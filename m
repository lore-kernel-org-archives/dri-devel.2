Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51387C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8028F10EA7E;
	Tue,  8 Sep 2026 07:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OYD5uTiL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1D010EA7D
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:22:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FDDA601DB;
 Tue,  8 Sep 2026 07:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C5B1F00A3A;
 Tue,  8 Sep 2026 07:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788852169;
 bh=iZ3HFLDmzP191HKMjkSGl5UNPb9KoynZv0pdk3OBJno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OYD5uTiLtUBFu5OUJt+cK+dlbL2wVLqtaNEYa3dG3KZRnaQFHIkqBoci3TYf6Z4Jc
 1LWF/Q8QOZx6URIeWVgpkSWMppzX/q6XyO7souv2e+PGwV8ChWkMcrN15ZKmSez1BW
 vdvdv1WlF3MKDNTm2RXkuk29pWoZSk2QEfcv+qvFxpOB5useq1/9tRmBw0A4jqJfv4
 Ve9ZdcqepeUCbM3x3HijTmGPOU3o18x1MX0m6Y7Q5fA5xLS0zZOS5ZbIrQoNZhlCbg
 QF7eLvZd7BBicU2A3CBbkJ0KpCBmNxx3SWQeDgIefeNU6NKsc9nIsD0hsGM6wDauHs
 wWOiHRrx4PSdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] dt-bindings: display/msm: hdmi: Correct name of
 disallowed supplies
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-7-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-7-dcf8956878ca@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:22:49 +0000
Message-Id: <20260908072249.83C5B1F00A3A@smtp.kernel.org>
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
- [High] Unclocked register access in `msm_hdmi_bridge_atomic_post_disable`=
 if `atomic_pre_enable` fails, leading to a system crash.
--

commit cf37fcc44eb6e3ec93e18234643d645b17ce8c49
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

dt-bindings: display/msm: hdmi: Correct name of disallowed supplies

There are no properties in DTS or Linux drivers called
"core-vcc-supplies" or "hdmi-mux-supplies", so the binding probably
wanted "-supply" properties instead.

> diff --git a/Documentation/devicetree/bindings/display/msm/hdmi.yaml b/Do=
cumentation/devicetree/bindings/display/msm/hdmi.yaml
> index dfec6c3480f3f..02d27ccad0247 100644
> --- a/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> @@ -113,7 +113,7 @@ allOf:
>              - const: core
>              - const: master_iface
>              - const: slave_iface
> -        core-vcc-supplies: false
> +        core-vcc-supply: false

[Severity: High]
Can this series cause an unclocked register access regression if
atomic_pre_enable fails?

When a userspace DRM atomic commit triggers atomic_pre_enable, if
msm_hdmi_power_on() fails (e.g., clk_prepare_enable failure), the error path
introduced earlier in this patch series disables PHY resources and returns
early:

drivers/gpu/drm/msm/hdmi/hdmi_bridge.c:msm_hdmi_bridge_atomic_pre_enable() {
			if (msm_hdmi_power_on(bridge)) {
				msm_hdmi_phy_resource_disable(phy);
				return;
			}
}

This leaves hdmi->power_on as false. Since DRM core continues because
atomic_pre_enable returns void, later when the pipeline is disabled,
msm_hdmi_bridge_atomic_post_disable() is called unconditionally:

drivers/gpu/drm/msm/hdmi/hdmi_bridge.c:msm_hdmi_bridge_atomic_post_disable(=
) {
	msm_hdmi_set_mode(hdmi, hdmi->hpd_enabled);

	msm_hdmi_phy_powerdown(phy);

	if (hdmi->power_on) {
}

These functions execute register writes without being guarded by
hdmi->power_on. Since PHY resources were dropped on error, it writes to
unclocked and unpowered hardware, which can cause a bus error or synchronous
external abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-drm-msm-hd=
mi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com?part=3D7
