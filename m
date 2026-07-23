Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F58BC44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEFBE10EF52;
	Thu, 23 Jul 2026 01:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gjchJLWl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5728B10EF52
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:50:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F50143E1F;
 Thu, 23 Jul 2026 01:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B341F000E9;
 Thu, 23 Jul 2026 01:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771440;
 bh=1uqZ2fxy2CSbWgYVrfB6flCO9ZokFBE1VaME2LGwv+M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gjchJLWljXFo/LL2PHurDMTCZwiznsCAAa09IjL5s0Ngm5M9zE+un2WEi1kkaOxhR
 aBXswkor0T6DafpAYdsTMRiHlyHwEji7DHt/6p55FGO34ZoY82kuu03goPZPhdrP2B
 +clqYo5dEqG91Md2rtXsyZyb8mJ4Jku6Mezcn8IYftS0aFc7+H69WbClijcrtMOF7p
 GCfkPX48+/eU7ImLho5Z0EGD5LLjcqxqdsCOS9fsWBCY0xcClBvuWeGrgQICiBhiFU
 WUK7r/rIxfG4elJhGoxf5x1BzZWuM8sj5rzK6VhJEj7QrspxCNkGdst6XYPlJe3ocG
 w1GR0bF4QPjKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 18/61] drm/display: hdmi-state-helper: Set HDMI
 scrambling requirement
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-18-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-18-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:50:39 +0000
Message-Id: <20260723015039.E1B341F000E9@smtp.kernel.org>
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
- [High] The HDMI atomic check framework fails to validate sink scrambling =
capabilities, allowing unsupported high-clock modes to pass atomic check an=
d fail later during the commit phase.
--

--- Patch [18]: [PATCH v9 18/61] drm/display: hdmi-state-helper: Set HDMI s=
crambling requirement ---
commit 7fcaa4103f10e7da80a91d4e2de65346b900fcb1
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi-state-helper: Set HDMI scrambling requirement
   =20
This patch sets drm_connector_hdmi_state.scrambler_needed when the computed
TMDS character rate exceeds the HDMI 1.3 maximum TMDS character rate.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index ad59318a3e85f..d112c15555178 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -594,6 +594,9 @@ hdmi_compute_clock(const struct drm_connector *connec=
tor,
> =20
>  	conn_state->hdmi.tmds_char_rate =3D clock;
> =20
> +	/* TODO: also check drm_display_info.hdmi.scdc.scrambling.low_rates */
> +	conn_state->hdmi.scrambler_needed =3D (clock > HDMI_1_3_TMDS_CHAR_RATE_=
MAX_HZ);

[Severity: High]
Could this introduce a regression where unsupported high-clock modes pass t=
he
atomic check phase, only to fail later during atomic_commit?

If userspace requests a mode with a TMDS clock > 340 MHz on a legacy sink
that does not support scrambling, the hdmi_clock_valid() check bypasses the
maximum clock limit if info->max_tmds_clock =3D=3D 0.

By setting scrambler_needed to true here without verifying if the sink
supports scrambling (e.g., via drm_scdc_sink_supports_scrambling()), the
validation successfully passes drm_atomic_helper_connector_hdmi_check().

However, later during atomic_commit, the attempt to enable scrambling fails:

drivers/gpu/drm/display/drm_hdmi_helper.c:drm_connector_hdmi_enable_scrambl=
ing() {
	if (!drm_scdc_sink_supports_scrambling(connector)) {
		drm_dbg_kms(dev, "Sink doesn't support scrambling.\n");
		return -EINVAL;
	}
    ...
}

Failing during the non-blocking KMS atomic_commit phase violates the atomic=
 KMS
model and can leave the display hardware misconfigured. Should we validate =
sink
scrambling capabilities here in the atomic check phase instead?

> +
>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D18
