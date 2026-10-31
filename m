Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD5606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ox1WBMOb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9AD310E30F;
	Sat, 31 Oct 2026 17:55:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B171B10E10C;
 Sat, 31 Oct 2026 17:55:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B29B60C08;
 Sat, 31 Oct 2026 17:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAA31F000C1;
 Sat, 31 Oct 2026 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793469314;
 bh=72ZTUiaW/xPPsRS42rEDWovInGzCFnt3oGUuR1Drm1M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ox1WBMObL68M3BwPM8m2xr22nkF7CLpMd6VBGg1hvceTysfpfrwh5tWvfEtzsuNOs
 VHNvBySj1dcWb6724boLXPAWlJJCX1YBkvQFaRe1JbgzatWdXLry4umlCAyx72cR6V
 t0WFTXBwzYe6We/17xVFyma4BNd86zsrlp4u23MHZfEUHr7O28pV+Iwzj/td+NsZwP
 xy+UpE9SlQ3VAJ01yU9PpccMlWFLEDFjTnnV3JRuCQoclzx9VpLFIEI0a6TUtW+ZM0
 0L7+LODnI+Vv20CqAk7tpBeojKTRoLJjMuV7EWSoL3x0YYhTkY9L8nNqJmMSQk2Iz7
 zMkuBYFY0bmWQ==
Message-ID: <sashiko-outbox-192081@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/i915/display: Add quirk for interlane align bit
 on CH7511
To: bitey <s.mavlenkov@mail.ru>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261031174518.10004-1-s.mavlenkov@mail.ru>
References: <20260608082500.45902-1-pjakobsson@suse.de>
 <20261031174518.10004-1-s.mavlenkov@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:55:13 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/i915/display: intel_init_dpcd_quirks() never clears quirks.m=
ask
- [Low] drm/i915/display: misleading QUIRK_IGNORE_INTERLANE_ALIGN_BIT name =
and logic
--

commit f2b8ff46914625ae07bb1d14ecb3a249c916384a
Author: bitey <s.mavlenkov@mail.ru>

drm/i915/display: Add quirk for interlane align bit on CH7511

This commit adds a DPCD quirk matching the Chrontel CH7511 bridge on any
platform and forces the per-lane and interlane alignment link status bits
in intel_dp_needs_link_retrain() to prevent an endless retraining loop.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/driv=
ers/gpu/drm/i915/display/intel_dp_link_training.c
> index ac1aff6edf052..5888f57422be2 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c

[ ... ]

> @@ -2521,6 +2522,22 @@ intel_dp_needs_link_retrain(struct intel_dp *intel=
_dp)
>  	if (link_recovery_autoretrain_pending(link_training))
>  		return true;
> =20
> +	/*
> +	 * The CH7511 bridge incorrectly clears all link status bits
> +	 * (INTERLANE_ALIGN_DONE, per-lane CR/CEQ/SYMLOCK) when disabling
> +	 * the training pattern. Force them to indicate successful training.
> +	 */
> +	if (intel_has_dpcd_quirk(intel_dp, QUIRK_IGNORE_INTERLANE_ALIGN_BIT)) {
> +		u8 lane_eq =3D DP_LANE_CR_DONE | DP_LANE_CHANNEL_EQ_DONE |
> +			     DP_LANE_SYMBOL_LOCKED;
> +		int i;
> +
> +		for (i =3D 0; i < (intel_dp->lane_count + 1) / 2; i++)
> +			link_status[i] |=3D lane_eq | (lane_eq << 4);
> +		link_status[DP_LANE_ALIGN_STATUS_UPDATED - DP_LANE0_1_STATUS] |=3D
> +			DP_INTERLANE_ALIGN_DONE;
> +	}

[Severity: Low]
This isn't a bug, but since v4 forces all of the 8b/10b link status bits
(DP_LANE_CR_DONE, DP_LANE_CHANNEL_EQ_DONE, DP_LANE_SYMBOL_LOCKED, and
DP_INTERLANE_ALIGN_DONE) rather than just the interlane align bit, are
QUIRK_IGNORE_INTERLANE_ALIGN_BIT, quirk_ignore_interlane_align_bit(), the l=
og
message, and the commit subject now misleadingly named?

Also, instead of synthesizing every bit checked by drm_dp_channel_eq_ok() i=
nto
link_status right before calling intel_dp_link_ok(), would it be clearer to
return false early in intel_dp_needs_link_retrain() or check the quirk insi=
de
intel_dp_link_ok()?

> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/dr=
m/i915/display/intel_quirks.c
> index 7d7db774d8c7b..359bca48c6f66 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -94,6 +94,14 @@ static void quirk_disable_edp_panel_replay(struct inte=
l_dp *intel_dp)
>  	drm_info(display->drm, "Applying disable Panel Replay quirk\n");
>  }
> =20
> +static void quirk_ignore_interlane_align_bit(struct intel_dp *intel_dp)
> +{
> +	struct intel_display *display =3D to_intel_display(intel_dp);
> +
> +	intel_set_dpcd_quirk(intel_dp, QUIRK_IGNORE_INTERLANE_ALIGN_BIT);
> +	drm_info(display->drm, "Applying ignore interlane align bit quirk\n");
> +}
> +
>  static void quirk_disable_psr2(struct intel_display *display)
>  {
>  	intel_set_quirk(display, QUIRK_DISABLE_PSR2);
> @@ -289,6 +297,15 @@ static const struct intel_dpcd_quirk intel_dpcd_quir=
ks[] =3D {
>  		.sink_oui =3D SINK_OUI(0x00, 0x22, 0xb9),
>  		.hook =3D quirk_disable_edp_panel_replay,
>  	},
> +	/* Chrontel CH7511 DP-to-LVDS bridge */
> +	{
> +		.device =3D DEVICE_ID_ANY,
> +		.subsystem_vendor =3D PCI_ANY_ID,
> +		.subsystem_device =3D PCI_ANY_ID,
> +		.sink_oui =3D SINK_OUI(0x2b, 0x02, 0xf0),
> +		.sink_device_id =3D SINK_DEVICE_ID('C', 'H', '7', '5', '1', '1'),
> +		.hook =3D quirk_ignore_interlane_align_bit,
> +	},
>  };

[Severity: Medium]
Unlike existing entries in intel_dpcd_quirks[] which match internal eDP pan=
els
on specific laptop PCI subsystem IDs, this entry uses DEVICE_ID_ANY and
PCI_ANY_ID and matches external hotpluggable CH7511 DP-to-HDMI/LVDS adapter=
s.

On non-eDP connectors, intel_dp_detect() -> intel_dp_detect_dpcd() ->
intel_dp_get_dpcd() runs on every connector detection:

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_get_dpcd() {
	...
	if (!intel_dp_is_edp(intel_dp)) {
		u8 dprx;

		drm_dp_read_desc(&intel_dp->aux, &intel_dp->desc,
				 drm_dp_is_branch(intel_dp->dpcd));

		intel_init_dpcd_quirks(intel_dp, &intel_dp->desc.ident);
	...
}

And intel_init_dpcd_quirks() never clears intel_dp->quirks.mask before
scanning intel_dpcd_quirks[]:

drivers/gpu/drm/i915/display/intel_quirks.c:intel_init_dpcd_quirks() {
	struct intel_display *display =3D to_intel_display(intel_dp);
	struct pci_dev *d =3D to_pci_dev(display->drm->dev);
	int i;

	for (i =3D 0; i < ARRAY_SIZE(intel_dpcd_quirks); i++) {
		...
			q->hook(intel_dp);
	}
}

If a user unplugs a CH7511 adapter from an external DisplayPort connector a=
nd
plugs in a normal DisplayPort monitor, won't QUIRK_IGNORE_INTERLANE_ALIGN_B=
IT
remain permanently set in intel_dp->quirks.mask for that port (especially if
drm_dp_read_desc() fails on the new sink without clearing intel_dp->desc),
disabling 8b/10b link failure detection and retraining for any monitor
connected afterwards?

Also, while a CH7511 adapter remains connected to a non-eDP port, won't eve=
ry
connector probe re-run quirk_ignore_interlane_align_bit() and print "Applyi=
ng
ignore interlane align bit quirk" via drm_info()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031174518.1000=
4-1-s.mavlenkov@mail.ru?part=3D1
