Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97449C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5BDF10E612;
	Sun, 28 Jun 2026 14:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UB8Xv3mM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F8710E612
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:40:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF68F6001D;
 Sun, 28 Jun 2026 14:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6178E1F000E9;
 Sun, 28 Jun 2026 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782657629;
 bh=A3FDkCIP9lto6RsA9VrQsjCk65L9gx//6ROS6a471Hw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UB8Xv3mM5Ig6lIdpYnAfP7/jJwVlkU0gY6zGQzHWT2EFgXQF9196TbWpOpaakaVG1
 o8X1yF2fwM1+Tl+rZI7SspQfwgxHz4hGAKxSyDrOySJMKIxvKlR5rkgITPQIPGJ1bX
 a+dMGbcgK+7t1uRs2iLUQSJDtSEWQ0JTMdhd7FRd9R8UzcCITeOFlXny6XZvJZEZyT
 l8fssioFPqbRJLezoGy8nwlgoZzcO1G6EqbGS0q9CoKhJQimKV9l/PXAuroA/EnRdF
 +eQvs6C0TGdWD4hTKcAqTQLxpzW3Kbtae5pCUprVeV3X5HAqel1RG/zhPsutF5LFg6
 7j5MG6pkfLolQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/nouveau: fix GEM refcount leak in validate_init
 error paths
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628142821.47290-1-vulab@iscas.ac.cn>
References: <20260628142821.47290-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 14:40:28 +0000
Message-Id: <20260628144029.6178E1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing ttm_bo_unreserve in the '!vma' error path causes a permane=
nt WW mutex lock leak.
- [High] Direct return on trycnt > 100000 bypasses all cleanup, leaking WW =
mutex locks, the WW acquire context, and GEM object references.
--

commit fc4adfd74f8e6257f658aeca598c47876610c9c5
Author: WenTao Liang <vulab@iscas.ac.cn>

drm/nouveau: fix GEM refcount leak in validate_init error paths

This commit adds drm_gem_object_put(gem) to error paths in validate_init()
to fix GEM object reference leaks when breaking out of the loop early.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouv=
eau/nouveau_gem.c
> index 20dba02d6175b..c654256f4081e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
[ ... ]
> @@ -523,6 +524,7 @@ validate_init(struct nouveau_channel *chan, struct dr=
m_file *file_priv,
>  			if (!vma) {
>  				NV_PRINTK(err, cli, "vma not found!\n");
>  				ret =3D -EINVAL;
> +				drm_gem_object_put(gem);
>  				break;
>  			}

[Severity: High]
This is a pre-existing issue, but does this break leave the buffer locked v=
ia
ttm_bo_reserve?

In validate_init(), if nouveau_vma_find() returns NULL for a successfully
reserved buffer, breaking here exits the loop before the buffer is added to
any list.

Because it is not on a list, validate_fini() will not unreserve it, which
appears to cause a permanent WW mutex lock leak for this GEM object.

[Severity: High]
This is also a pre-existing issue, but does the retry limit check at the top
of validate_init() bypass cleanup?

drivers/gpu/drm/nouveau/nouveau_gem.c:validate_init() {
    ...
retry:
	if (++trycnt > 100000) {
		NV_PRINTK(err, cli, "%s failed and gave up.\n", __func__);
		return -EINVAL;
	}
    ...

If the WW reservation loop hits a deadlock (-EDEADLK), reserves the buffer
via the slowpath, jumps to the retry label, and then exceeds the trycnt lim=
it,
this direct return bypasses the rest of the function.

Because it returns directly without calling validate_fini_no_ticket() or
cleaning up, does this leak the WW mutex locks, the WW acquire context, and
the GEM object references?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628142821.4729=
0-1-vulab@iscas.ac.cn?part=3D1
