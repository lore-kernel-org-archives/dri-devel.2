Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9892ECD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC9C10EF43;
	Thu, 11 Jun 2026 13:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aAWqa9jh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74B4910EF11
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 13:08:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D715443FB
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 13:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C4F1F00893;
 Thu, 11 Jun 2026 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781183323;
 bh=5d7f5PCxDirM6IGV8ArcS3q7p/yE05L+HDjpdr6HzhY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aAWqa9jhivNG1IdJx28NrUO2JzcoFjgb2Rtv5mFxD7W+sdvkn0VlwrKE4Lh90Fkce
 IhTvw+VBaUg/QcpqaWe70Jgv3fNpc1gVJjJzfVxlVvGlFfsKa40qPyXYX3hQhrIjGU
 wqQaY9H8q5teP2EBl4dMmRIHz4YBYgpWBLi1hskHrBk5IyNR/3cbR7oJMpF0kp41kl
 4rQS7VJV47f+XJTf57T3048GHnN16PKbwf2DYywZ6T0ST9QS9hTNu4VBnUyLGBf5gx
 jw+YuP6kMulOMveWzjgRrQUZSiClfYXzQvwWi7VmmS5SJMFN/OFazP141bmZX26T0i
 9lmBrz6MesWkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] amdgpu: lockdep: move temporary mutexes off stack
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611130240.3388318-1-arnd@kernel.org>
References: <20260611130240.3388318-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 13:08:42 +0000
Message-Id: <20260611130843.13C4F1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `reset_ctl.reset_lock` mutex is left uninitialized after the r=
emoval of its `mutex_init()` call, leading to a crash or lockdep splat when=
 `mutex_lock()` is subsequently called on it.
--

commit 6434ae76184d0a8413780553647c7fd53034416b
Author: Arnd Bergmann <arnd@arndb.de>

amdgpu: lockdep: move temporary mutexes off stack

This commit changes the dummy locks in amdgpu_lockdep_init() to use
static allocation instead of stack allocation to reduce the stack frame siz=
e.
It removes the explicit mutex_init() calls for these locks.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_lockdep.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -85,13 +85,13 @@ int amdgpu_lockdep_init(void)
>  {
>  	struct amdgpu_reset_domain *reset_domain =3D NULL;
>  	struct amdgpu_reset_control reset_ctl;

[ ... ]

> @@ -102,16 +102,6 @@ int amdgpu_lockdep_init(void)
>  	if (!reset_domain)
>  		return -ENOMEM;
> =20
> -	/* Initialize dummy locks */
> -	mutex_init(&userq_sch_mutex);
> -	mutex_init(&userq_mutex);
> -	mutex_init(&notifier_lock);
> -	mutex_init(&vram_lock);
> -	mutex_init(&reset_ctl.reset_lock);

[Severity: High]
With this initialization removed, does reset_ctl.reset_lock remain
uninitialized?

Since reset_ctl is still allocated on the stack earlier in the function,
calling mutex_lock(&reset_ctl.reset_lock) later in this routine will
operate on uninitialized memory. Could this trigger a crash or lockdep spla=
t?

> -	mutex_init(&srbm_mutex);
> -	mutex_init(&grbm_idx_mutex);
> -	spin_lock_init(&mmio_idx_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611130240.3388=
318-1-arnd@kernel.org?part=3D1
