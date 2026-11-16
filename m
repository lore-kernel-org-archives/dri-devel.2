Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E2606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Obxe2VTI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84DF10E83E;
	Mon, 16 Nov 2026 01:38:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E374110E83E;
 Mon, 16 Nov 2026 01:38:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 11F8D61338;
 Mon, 16 Nov 2026 01:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EAD1F000C4;
 Mon, 16 Nov 2026 01:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794793090;
 bh=i8pdDuD1q//PqkBTTkIxwE9XTpFUBsiwJhCsmmvTu20=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Obxe2VTIaJBDlooCDRutVABKT1vIXfFRy/fn47Z9/VxSEvrcb7MWi6jJvmawc1QFE
 FIAd1iGzdhV3EulH6FMLcI1BHLAtx/+E8K1QlsApwL5JgLn8J9zJyNEb3ILZJPkShd
 v5FWiFiqDLpLtqbCi0J4/JLSxDOcjTE7tLg3FIZTUxa4E+UxeP03fcQYpoIywV520E
 QQZZXSxGpjkLYMhnWKkevvkSgbR15AXMvfDNFRMdRPu0jDOpiO01zn+ifAKOIxm7h9
 Tv6LTrCw+Y8asiBzso73XNM54XdARNn0gLOx9D2djRVXSX1fHboNb+CYD4WiRMm+7B
 JfQMe4rCMgwDg==
Message-ID: <sashiko-outbox-216002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/i915/display: Tear down encoder hardware state
 in a separate hook
To: "Baoli Zhang" <baoli.zhang@linux.intel.com>, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116011504.3910139-2-baoli.zhang@linux.intel.com>
References: <20261116011504.3910139-1-baoli.zhang@linux.intel.com>
 <20261116011504.3910139-2-baoli.zhang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:38:10 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/i915/ddi: uninitialized dedicated_external check in
  intel_ddi_init() [1]
--

commit 29c999b99f6cbc9e2b633d5c497aefc1594c72cf
Author: Baoli Zhang <baoli.zhang@linux.intel.com>

drm/i915/display: Tear down encoder hardware state in a separate hook

This commit introduces an intel_encoder ->remove() callback to separate
hardware and userspace-visible encoder teardown on driver remove from
memory deallocation in ->destroy().

> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i=
915/display/intel_ddi.c
> index a0aff087fafa8..01fbb5ab038fd 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c

[ ... ]

> @@ -5353,6 +5358,7 @@ void intel_ddi_init(struct intel_display *display,
>  	encoder->initial_fastset_check =3D intel_ddi_initial_fastset_check;
>  	encoder->suspend =3D intel_ddi_encoder_suspend;
>  	encoder->shutdown =3D intel_ddi_encoder_shutdown;
> +	encoder->remove =3D intel_ddi_encoder_remove;
>  	encoder->get_power_domains =3D intel_ddi_get_power_domains;
> =20
>  	encoder->type =3D INTEL_OUTPUT_DDI;

[Severity: High]
This problem wasn't introduced by this patch, but doesn't intel_ddi_init()
call intel_encoder_is_tc() before dig_port->dedicated_external is
initialized [1]?

intel_encoder_is_tc() returns false when dig_port->dedicated_external is
set, yet intel_ddi_init() only populates dedicated_external from VBT after
querying intel_encoder_is_tc() to select encoder->get_config and check
need_aux_ch():

drivers/gpu/drm/i915/display/intel_ddi.c:intel_ddi_init() {
	...
	if (HAS_LT_PHY(display)) {
		...
		if (intel_encoder_is_tc(encoder))
			encoder->get_config =3D mtl_ddi_tc_phy_get_config;
		else
			encoder->get_config =3D mtl_ddi_non_tc_phy_get_config;
	} else if (DISPLAY_VER(display) >=3D 14) {
		...
		if (intel_encoder_is_tc(encoder))
			encoder->get_config =3D mtl_ddi_tc_phy_get_config;
		else
			encoder->get_config =3D mtl_ddi_non_tc_phy_get_config;
	}
	...
	if (intel_bios_encoder_is_dedicated_external(devdata))
		dig_port->dedicated_external =3D true;
	...
}

On DISPLAY_VER() >=3D 14 or HAS_LT_PHY() platforms where the VBT marks a
Type-C PHY port as a dedicated external port, encoder->get_config is
assigned mtl_ddi_tc_phy_get_config() instead of
mtl_ddi_non_tc_phy_get_config(). Once dedicated_external is set to true,
subsequent intel_encoder_is_tc() calls return false, so atomic DPLL
computation uses the non-TC path (ICL_PORT_DPLL_DEFAULT) while hardware
state readout via mtl_ddi_tc_phy_get_config() populates
ICL_PORT_DPLL_MG_PHY, causing DPLL state verification mismatches and
failing fastset checks.

[1] https://sashiko.dev/#/bug/linux-4f65a789-b335-4420-aca7-1aaf9a2f9779

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116011504.3910=
139-1-baoli.zhang@linux.intel.com?part=3D1
