Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BEAC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6344A10ED90;
	Tue,  7 Jul 2026 14:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cjj8mYKC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC5110ED8D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:17:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E15DE43A89;
 Tue,  7 Jul 2026 14:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A0F1F00A3E;
 Tue,  7 Jul 2026 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783433842;
 bh=XooZ1j2/PeTN4Cppq3/g7WsrrzUn7Kzdk0MrCi3sqmU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cjj8mYKCw8By17/CWrCS7a4PIwML7hzpVPtOaVsdDYj9F1PE0bXJzVjNe6vXrtCy1
 4JRGSzfwc3S5ta7XLmON+je0hynhSs0RN/1VSfuVU/bVzgR5K3xbrVZPXeZIGiQh1T
 0Sc3xlz0wIA3zATAqbHMKvXyCcyL9gYRRXTp6qIgvpdeV6l6a0bK0wysHJ20P71GJU
 mSZnuhw1fc/i8jWCrM6YA8n1AG45iifBJKoWk0ZXylCcR/Xr5JvzZ2rzc6kzR1goP1
 FQRWv1PsRtTgAbA60jWETAENhwJUw/OoWT6oQL/6QTJk9r+OpovrvEJ8E/E2auLPf3
 gHsBblqRMSuWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] drm/i915: Implement
 vga_switcheroo_client_ops.pre_switch
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707135724.247562-7-tzimmermann@suse.de>
References: <20260707135724.247562-1-tzimmermann@suse.de>
 <20260707135724.247562-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:17:22 +0000
Message-Id: <20260707141722.A6A0F1F00A3E@smtp.kernel.org>
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
- [High] AB-BA deadlock between `vgasr_mutex` and `dev->clientlist_mutex` d=
uring VGA switcheroo and DRM client hotplug/registration.
--

--- Patch [6]: [PATCH 06/10] drm/i915: Implement vga_switcheroo_client_ops.=
pre_switch ---
commit ca43d8e034e1ee27918b22e1b7a19b8f6a5b4a67
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/i915: Implement vga_switcheroo_client_ops.pre_switch

This commit implements the pre_switch callback for vga_switcheroo in the
i915 driver. It calls drm_client_dev_acquire_outputs() to push fbcon
updates from vga_switcheroo into DRM's fbdev emulation.

> diff --git a/drivers/gpu/drm/i915/i915_switcheroo.c b/drivers/gpu/drm/i91=
5/i915_switcheroo.c
> index 7e0791024282e..6b306ece0556a 100644
> --- a/drivers/gpu/drm/i915/i915_switcheroo.c
> +++ b/drivers/gpu/drm/i915/i915_switcheroo.c
[ ... ]
> @@ -58,10 +59,19 @@ static bool i915_switcheroo_can_switch(struct pci_dev=
 *pdev)
>  		atomic_read(&i915->drm.open_count) =3D=3D 0;
>  }
> =20
> +static void i915_switcheroo_pre_switch(struct pci_dev *pdev)
> +{
> +	struct drm_i915_private *i915 =3D pdev_to_i915(pdev);
> +
> +	if (i915 && intel_display_device_present(i915->display))
> +		drm_client_dev_acquire_outputs(&i915->drm);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this code introduce an AB-BA deadlock between vgasr_mutex and
dev->clientlist_mutex?

A GPU switch triggered via userspace will acquire vgasr_mutex and eventually
call this pre_switch callback:

vga_switcheroo_debugfs_write()  [acquires vgasr_mutex]
  vga_switchto_stage2()
    i915_switcheroo_pre_switch()
      drm_client_dev_acquire_outputs()  [acquires dev->clientlist_mutex]

However, a DRM client hotplug event can acquire these locks in the reverse
order:

drm_client_dev_hotplug()  [acquires dev->clientlist_mutex]
  drm_fbdev_client_hotplug()
    register_framebuffer()
      fbcon_fb_registered()
        do_fb_registered()
          vga_switcheroo_client_fb_set()  [acquires vgasr_mutex]

Could this lead to a system hang when a GPU switch races with a display
hotplug event?

> +}
> +
>  static const struct vga_switcheroo_client_ops i915_switcheroo_ops =3D {
>  	.set_gpu_state =3D i915_switcheroo_set_state,
>  	.reprobe =3D NULL,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707135724.2475=
62-1-tzimmermann@suse.de?part=3D6
