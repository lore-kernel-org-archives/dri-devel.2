Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCE2C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1379810EA82;
	Tue,  8 Sep 2026 07:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PPCy7M0k";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372FF10EA85
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:25:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 752E8601DB;
 Tue,  8 Sep 2026 07:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645FF1F00A3A;
 Tue,  8 Sep 2026 07:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788852347;
 bh=1lgD2/r9LjhQmUOUH0YH3LrX/i+KeQI0zSLtZTqIS20=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PPCy7M0kEV/l5uMwCDewbk5ofC7S+199WVCjwjePE5xMFlpWt3DCukjEiId8ZnQsE
 hYLsJvy1uQRjvRscFQaEb98lAhL7ibXwHBhi8U8Nd+AXji1lUjIwGSm0VPJz0zkJIF
 ZVAFhNq0PaJXc81j6Pbvfzdt0D55iJgWG0yxOWQYgw6j/LqZiTN8s5m5ZsHJj1oaZB
 2EwMukTw18IZmoBOSZLDRY943Df1e3JaKfeS8ylG0ASdBfOzOk7BMk2CRgkDN2DSw0
 OP0jclFfkglLXBVLkyeC33RtCD1+A/pVKYgb3N6ht4YH7w8/AmdUQ6cQ02koaV334p
 4nPHZ/o7qV2iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-2-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-2-dcf8956878ca@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:25:45 +0000
Message-Id: <20260908072546.645FF1F00A3A@smtp.kernel.org>
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
- [High] Aborting `atomic_pre_enable()` on power-on failure guarantees an i=
mprecise abort (system crash) in `atomic_post_disable()` due to uncondition=
al accesses to unpowered PHY and HDMI controller registers.

Pre-existing issues:
- [High] Unclocked MMIO access in `msm_hdmi_set_timings()` before the HDMI =
PM runtime is resumed.
--

commit 9912da31672d32069f2e4d118d3714a533a0157a
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()

This commit adds error handling for msm_hdmi_power_on() during the=20
.atomic_pre_enable() phase to prevent register accesses if the power=20
domain fails to come up.

Cc: <stable@vger.kernel.org>

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm=
/hdmi/hdmi_bridge.c
> index 157f19bd90b4e..db85400e574e4 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c

[ ... ]

> @@ -287,13 +294,18 @@ static void msm_hdmi_bridge_atomic_pre_enable(struc=
t drm_bridge *bridge,
> =20
>  	msm_hdmi_set_timings(hdmi, &crtc_state->adjusted_mode);

[Severity: High]
This is a pre-existing issue, but does calling msm_hdmi_set_timings() here
risk unclocked MMIO access?

This register access occurs before the power domain is reliably enabled by
msm_hdmi_power_on() later in this function. If the connector is forced on
while disconnected (so HPD is disabled and no background PM reference is
held), the AHB/APB clocks for the HDMI block are off.

Writing to these registers without an active clock can immediately stall the
bus and cause an imprecise external abort (kernel panic).

> -	mutex_lock(&hdmi->state_mutex);
> -	if (!hdmi->power_on) {
> -		msm_hdmi_phy_resource_enable(phy);
> -		msm_hdmi_power_on(bridge);
> -		hdmi->power_on =3D true;
> +	scoped_guard(mutex, &hdmi->state_mutex) {
> +		if (!hdmi->power_on) {
> +			if (msm_hdmi_phy_resource_enable(phy))
> +				return;
> +
> +			if (msm_hdmi_power_on(bridge)) {
> +				msm_hdmi_phy_resource_disable(phy);
> +				return;

[Severity: High]
Does aborting here guarantee a crash later during teardown?

When this error path disables PHY resources and returns early, it leaves
hdmi->power_on =3D false. However, because atomic_pre_enable() returns void,
the DRM core is unaware of the failure and continues the modeset sequence.

Eventually, the DRM core will call msm_hdmi_bridge_atomic_post_disable(),
which unconditionally writes to unpowered registers:

msm_hdmi_bridge_atomic_post_disable() {
    ...
    msm_hdmi_set_mode(hdmi, hdmi->hpd_enabled);
    msm_hdmi_phy_powerdown(phy);
}

Since the PHY clocks were explicitly disabled by this error path, accessing
these registers without an active clock will cause an imprecise external
abort on MSM hardware.

> +			}
> +			hdmi->power_on =3D true;
> +		}
>  	}
> -	mutex_unlock(&hdmi->state_mutex);
> =20
>  	if (connector->display_info.is_hdmi)
>  		msm_hdmi_audio_update(hdmi);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-drm-msm-hd=
mi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com?part=3D2
