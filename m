Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE99C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29FB890EB;
	Thu, 16 Jul 2026 20:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T+9NKQl8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02DB890EB
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06E6A60A5E;
 Thu, 16 Jul 2026 20:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BA91F000E9;
 Thu, 16 Jul 2026 20:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784234084;
 bh=jXzzTZnCOxmCWjsO8SZMSD2+Ph9skj6cUGVBBGdM9Vc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T+9NKQl8+ETGUk2iNL4vUa/dy6GxC31SwMXHX3X1ZLUI0hfk33ZJvmAxfUcTK1JfG
 zbwR6M9q2Q5jfpQBOmIwCidnCzkisxKDAWyuUxIYb6Jm0ov2dMGXDLHeSiuk77+72Q
 ikEkCf3Ql8T/pr5z5XgcJUzDfiNzYOnty+tELg9Z8+8bfieof4OdL0ORzHQFdr6Uk/
 QdwNTcnXCmqLzMQmxtNv8C1Ls7MY2U1sw/wP6pnURnnSVWt460OEAAguWKwE/Vg31c
 EP55+tcs4tsSDBLex7pI7I2lYXNqWE/5gMvNA+XdZNr+QPczZd3RMT3K7zCpgupgt7
 XDim4TQut7KJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/10] drm/msm: Remove invalid overflow check
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716201538.365824-11-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
 <20260716201538.365824-11-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 20:34:44 +0000
Message-Id: <20260716203444.84BA91F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Changing the allocation size variable `sz` from `uint64_t` to =
`size_t` and removing the `sz > SIZE_MAX` check introduces a critical integ=
er truncation vulnerability on 32-bit systems, leading to a massive heap bu=
ffer overflow.

Pre-existing issues:
- [High] Relocations allocated in `submit_lookup_cmds` are permanently leak=
ed if an error occurs before `submit->nr_cmds` is initialized later in the =
ioctl.
--

--- Patch [10]: [PATCH v5 10/10] drm/msm: Remove invalid overflow check ---
commit eb92124b933ee21b339fcbad2bb72fb24329057d
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Remove invalid overflow check

This commit removes the overflow check for the allocation size in
submit_create(), noting that struct_size() saturates at SIZE_MAX and
kzalloc() already handles it. It also changes the type of the sz
variable from uint64_t to size_t.

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 06b142d82e4d0..d914602fd443a 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -36,15 +36,11 @@ static struct msm_gem_submit *submit_create(struct dr=
m_device *dev,
>  {
>  	static atomic_t ident =3D ATOMIC_INIT(0);
>  	struct msm_gem_submit *submit;
> -	uint64_t sz;
> +	size_t sz;
>  	int ret;
> =20
>  	sz =3D struct_size(submit, bos, nr_bos) +
>  			((u64)nr_cmds * sizeof(submit->cmd[0]));
> -
> -	if (sz > SIZE_MAX)
> -		return ERR_PTR(-ENOMEM);
> -
>  	submit =3D kzalloc(sz, GFP_KERNEL | __GFP_NOWARN);

[Severity: Critical]
Does this change introduce an integer truncation on 32-bit systems?

Since sz is now a size_t, the 64-bit sum of struct_size() and the
nr_cmds multiplication can be silently truncated to 32 bits before being
passed to kzalloc().

For example, if a large nr_cmds like 0x8000000 is provided, the added size
could be 0x100000000, which truncates to 0 in a 32-bit size_t.

Could this cause kzalloc() to succeed with a smaller size than required,
resulting in an out-of-bounds write when setting submit->cmd[i] later?

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
msm_ioctl_gem_submit() leak the relocations?

Looking at submit_lookup_cmds(), memory is allocated for relocs:

    submit->cmd[i].relocs =3D kmalloc(sz, GFP_KERNEL | __GFP_NOWARN);

If an error occurs here or later in the ioctl, the code jumps to the error
path before submit->nr_cmds is initialized at the end of
msm_ioctl_gem_submit():

    submit->nr_cmds =3D args->nr_cmds;

Then __msm_gem_submit_destroy() will use the uninitialized submit->nr_cmds,
which is 0, for its cleanup loop:

    for (i =3D 0; i < submit->nr_cmds; i++)
        kfree(submit->cmd[i].relocs);

Could this result in permanently leaking all successfully allocated relocs
arrays if this error path is repeatedly triggered?

>  	if (!submit)
>  		return ERR_PTR(-ENOMEM);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716201538.3658=
24-1-robin.clark@oss.qualcomm.com?part=3D10
