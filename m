Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B803AC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0873D10ED9C;
	Tue,  7 Jul 2026 14:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZjsK0Iaj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B7A89B62
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:22:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D9806138D;
 Tue,  7 Jul 2026 14:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9FE1F000E9;
 Tue,  7 Jul 2026 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434158;
 bh=wgoQanoQqzfX/6FSR3qNQQlJk4tYi2+B6GQEHIEPto4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZjsK0Iaj2NFMaM+8pGtadGX8yoPjbkWj6KWaaj3OiewEyLGqCl85eO7NFJFP9LPY3
 nUQ/iNCE+ckavNLKp0yedVUVQecTWEbCrp047gwXFVIOrSpVUycM/I9BX0fXey6ovW
 1Q4/N0A9QvD4LmiPKr48Cqe8Vrnu7+CH23V/7vLm5+W+1JFwTbGXTkVUAf1voresnu
 mWGLtxo3+XhB1w/EqBnQgFkkK7ABc3T77g2hUeSeCAo64KC2Wn7qyLqJTisxcTTFtL
 Oj4Si3m3X/ebWOwfFpwVJXgK8vbezdbBsyQBvuATAdJrRvICmmQ4volsEyLT5vREM8
 /3kYSGYtIz7rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] drm/amdgpu: Implement struct
 vga_switcheroo_client_ops.pre_switch
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707135724.247562-6-tzimmermann@suse.de>
References: <20260707135724.247562-1-tzimmermann@suse.de>
 <20260707135724.247562-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:22:38 +0000
Message-Id: <20260707142238.8B9FE1F000E9@smtp.kernel.org>
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
- [High] An AB-BA lock inversion is introduced between `vgasr_mutex` and `d=
ev->clientlist_mutex`, leading to a potential deadlock.
--

--- Patch [5]: [PATCH 05/10] drm/amdgpu: Implement struct vga_switcheroo_cl=
ient_ops.pre_switch ---
commit 31dd42c0f56cf03f20324c5c0e3557fa630afd13
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/amdgpu: Implement struct vga_switcheroo_client_ops.pre_switch

This commit implements the pre_switch callback for vga_switcheroo_client_ops
in the amdgpu driver. It calls drm_client_dev_acquire_outputs() to push fbc=
on
updates from vga_switcheroo into DRM's fbdev emulation.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 211d30f03d25f..6c80c6f4b07ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1698,10 +1698,18 @@ static bool amdgpu_switcheroo_can_switch(struct p=
ci_dev *pdev)
>  	return atomic_read(&dev->open_count) =3D=3D 0;
>  }
> =20
> +static void amdgpu_switcheroo_pre_switch(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev =3D pci_get_drvdata(pdev);
> +
> +	drm_client_dev_acquire_outputs(dev);

[Severity: High]
Can this introduce an AB-BA lock inversion between vgasr_mutex and
dev->clientlist_mutex?

This callback is invoked by vga_switcheroo while vgasr_mutex is held, and
drm_client_dev_acquire_outputs() then acquires dev->clientlist_mutex.

Meanwhile, the hotplug path acquires clientlist_mutex first:

drm_client_dev_hotplug()
  mutex_lock(&dev->clientlist_mutex);

and then eventually takes console_lock and vgasr_mutex (via
vga_switcheroo_client_fb_set() called from register_framebuffer()) deeper in
the call stack.

If a hotplug event and a VGA switcheroo switch execute concurrently, could =
this
lead to a deadlock?

> +}
> +
>  static const struct vga_switcheroo_client_ops amdgpu_switcheroo_ops =3D {
>  	.set_gpu_state =3D amdgpu_switcheroo_set_state,
>  	.reprobe =3D NULL,
>  	.can_switch =3D amdgpu_switcheroo_can_switch,
> +	.pre_switch =3D amdgpu_switcheroo_pre_switch,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707135724.2475=
62-1-tzimmermann@suse.de?part=3D5
