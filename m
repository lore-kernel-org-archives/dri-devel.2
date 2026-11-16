Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF5606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kl0tcgKx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED5A10E167;
	Mon, 16 Nov 2026 01:53:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59EF410E008;
 Mon, 16 Nov 2026 01:53:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CB966127B;
 Mon, 16 Nov 2026 01:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E256E1F000C5;
 Mon, 16 Nov 2026 01:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794793988;
 bh=Si78R8jHIv4VFU2XhNXb4GmWVwjU+50D1Od8gb4lvU0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kl0tcgKxoNp6B3xeICBWh0iLWzv0pvFUtqU+7t7e98MDUUYTP0005Ks928EEiHbAG
 S82cEH2sN6A9fSOxp+eSjdetQR2Dw77I5/VRVIZ1+FIBsbVpvnCqiIFFq9VaiEGW7U
 R7VGk1R3riZiqea09YcY6qVSqatQCVmCTMOFU/q1ACw0KqPoLVf2xPzFVVFBzdGeMA
 zP+VQOt0lXfxAwvvJtBI6rq6KHs/tbLvLKlGr07KcJvOpELBOtovwQ5xlhDFUXz8Vc
 3/ohLviL3iqTo131eVY5bPc/mKsUf2XU4FHDcmG2BVCJOmh3rKDeZxEVPGEYT6pV/u
 qMNW+mQBInv9Q==
Message-ID: <sashiko-outbox-216018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/i915/display: Let the drivers free the KMS objects
To: "Baoli Zhang" <baoli.zhang@linux.intel.com>, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116011504.3910139-3-baoli.zhang@linux.intel.com>
References: <20261116011504.3910139-1-baoli.zhang@linux.intel.com>
 <20261116011504.3910139-3-baoli.zhang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:53:07 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/i915/display: double intel_encoder_remove_all() on Xe
  probe error
- [Medium] drm/i915/display: UAF of struct intel_display in
  intel_crtc_destroy()
--

commit 4777f76b60cbdafe718dcc54b80e3edb4d081b1c
Author: Baoli Zhang <baoli.zhang@linux.intel.com>

drm/i915/display: Let the drivers free the KMS objects

This commit moves drm_mode_config_cleanup() out of
intel_mode_config_cleanup() into a new
intel_display_driver_mode_config_cleanup() helper and calls it from the
i915 and xe driver teardown paths after
intel_display_driver_remove_noirq().

> diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/driver=
s/gpu/drm/i915/display/intel_display_driver.c
> index d513cfc881069..62a4d95d78b53 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_driver.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
> @@ -160,6 +160,18 @@ static void intel_mode_config_cleanup(struct intel_d=
isplay *display)
>  {
>  	intel_atomic_global_obj_cleanup(display);
>  	intel_encoder_remove_all(display);
> +}
> +
> +/*
> + * Free the KMS objects, including the encoders torn down by
> + * intel_display_driver_remove_noirq(). Userspace can keep referring to =
them
> + * until the last reference to the DRM device is gone.
> + */
> +void intel_display_driver_mode_config_cleanup(struct intel_display *disp=
lay)
> +{
> +	if (!HAS_DISPLAY(display))
> +		return;
> +
>  	drm_mode_config_cleanup(display->drm);
>  }

[Severity: Medium]
Can this cause intel_encoder_remove_all() to run twice on the same
encoders if intel_display_driver_probe_nogem() fails during
xe_display_init_early()?

When intel_display_driver_probe_nogem() fails after intel_setup_outputs()
(for example, if intel_dp_tunnel_mgr_init() fails), its err_mode_config
path calls intel_mode_config_cleanup(), which now runs
intel_encoder_remove_all() without destroying the encoders via
drm_mode_config_cleanup().  xe_display_init_early() then jumps to
err_noirq and calls intel_display_driver_remove_noirq() ->
intel_mode_config_cleanup() a second time while those encoders are still
on mode_config.encoder_list.

Running encoder->remove() twice dereferences a NULL dig_port->tc pointer
in intel_tc_port_cleanup() (which frees and clears dig_port->tc on the
first call) and double frees intel_dp->aux.name in intel_dp_aux_fini().

> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i9=
15_driver.c
> index aeb7b24c81c8b..d29b37ab2833e 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -906,6 +906,7 @@ int i915_driver_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
>  	intel_display_driver_remove(display);
>  	intel_irq_uninstall(i915);
>  	intel_display_driver_remove_noirq(display);
> +	intel_display_driver_mode_config_cleanup(display);
>  	goto out_cleanup_modeset;
>  out_cleanup_irq:
>  	intel_irq_uninstall(i915);

[Severity: Medium]
Does the out_cleanup_irq error path in i915_driver_probe() leave CRTCs
referencing a freed struct intel_display when
intel_display_driver_probe_nogem() fails?

If intel_display_driver_probe_nogem() fails after intel_crtc_init() has
linked a CRTC onto display->pipe_list, its err_mode_config path calls
intel_mode_config_cleanup(), which no longer calls
drm_mode_config_cleanup().  i915_driver_probe() then jumps to
out_cleanup_irq, bypassing intel_display_driver_mode_config_cleanup(),
and frees display in i915_driver_late_release() ->
intel_display_device_remove().  When drmm later runs
drm_mode_config_cleanup() -> intel_crtc_destroy(),
list_del(&crtc->pipe_head) writes to display->pipe_list inside the
already-freed struct intel_display.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116011504.3910=
139-1-baoli.zhang@linux.intel.com?part=3D2
