Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62679C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A6010EEC1;
	Tue,  1 Sep 2026 19:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lx8t8qhE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D8BC10EEC1
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:39:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9750D4070D;
 Tue,  1 Sep 2026 19:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547E11F000E9;
 Tue,  1 Sep 2026 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788291578;
 bh=1+MC1ATcjO070ZxcXgp3NndVpEI/RYdj51SSePCEXGA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lx8t8qhE5phsGooKimcICcAaJEKjr5TDTSFo7+LRBUiNv3fWEyDDMaGgKknu2CseH
 sKm1rKz3kCEC/7kk35HZx05k6xLpDR67kG1DKk2rIcSR0rDL6g3y19L8tjLvmjCUnW
 wKzHaXajM5ZMFPzZmlN+m8nHRzyXNI3EfVZbK9/oc5KDxXzcK6GMKqBmraJWOb7iPk
 VH5bZ8UylsKy/umsegsIAt8sLLfuMK1F0cly6xlgXruOh7fwqO18+N0xhEAvHuuH0F
 RFPlz0p1l6Rfb+o5NuxChJggW4IdlJD9mUPsivR3NsenkzKTk1BT7kYFPfEmBOlkJm
 qAxKaj0jHyszw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 24/74] drm/display: hdmi-state-helper: Set HDMI
 scrambling requirement
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-24-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-24-bc12954a0688@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 19:39:38 +0000
Message-Id: <20260901193938.547E11F000E9@smtp.kernel.org>
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
- [High] Missing validation of sink SCDC scrambling capabilities during the=
 atomic check phase when scrambling is required.
--

commit caf66f1de17a42fc5664100ac7127160f89c2866
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi-state-helper: Set HDMI scrambling requirement

This commit sets the HDMI scrambling requirement in the HDMI state helper
when the computed TMDS character rate exceeds the HDMI 1.3 maximum limit.
Centralizing this clock-based requirement prevents drivers from needing
to open-code the threshold check.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 1e269b203b987..7cdb7ca3dc12f 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -596,6 +596,9 @@ hdmi_compute_clock(const struct drm_connector *connec=
tor,
> =20
>  	conn_state->hdmi.tmds_char_rate =3D clock;
> =20
> +	/* TODO: also check drm_display_info.hdmi.scdc.scrambling.low_rates */
> +	conn_state->hdmi.scrambler_needed =3D (clock > HDMI_1_3_TMDS_CHAR_RATE_=
MAX_HZ);

[Severity: High]
Does this allow an unsupported configuration to pass the atomic check phase?

When a high TMDS clock is requested, this unconditionally sets
conn_state->hdmi.scrambler_needed to true without validating sink SCDC
capabilities. The configuration can pass hdmi_compute_clock() and
atomic_check because info->max_tmds_clock is permitted to exceed 340MHz
regardless of SCDC support.

Later during the hardware programming phase, it will fail:

drivers/gpu/drm/display/drm_hdmi_helper.c:drm_connector_hdmi_enable_scrambl=
ing() {
	...
	if (!drm_scdc_sink_supports_scrambling(connector)) {
		drm_dbg_kms(dev, "Sink doesn't support scrambling.\n");
		return -EINVAL;
	}
	...
}

Failing during atomic_enable violates KMS atomic guarantees. This sequence
can be triggered remotely if an untrusted or malformed EDID advertises a hi=
gh
TMDS clock via HF-VSDB but clears the SCDC supported bit.

Should this validate drm_scdc_sink_supports_scrambling(connector) during the
atomic check phase and return an error if scrambling is required but SCDC is
unsupported by the sink?

> +
>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dw-hdmi-qp=
-scramb-v11-0-bc12954a0688@collabora.com?part=3D24
