Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B124AC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F6D10F3E3;
	Fri, 28 Aug 2026 14:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oj39tixe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226A010F3E3
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:22:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47B8A601FD;
 Fri, 28 Aug 2026 14:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AD01F000E9;
 Fri, 28 Aug 2026 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787926952;
 bh=USIBPZIIitxiDbYgG5g1JltFJ3mijD2CH92KveFVOAA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Oj39tixeZdYZ3eLCW62ianppzXL/2NVm3BNkjFOES2g9dJkkH5SsxB/6kJqEhEEKd
 8zASF8Y0xtahPOkCVxHZklFa5CNoFkIaaXV8mia95EPOBoljXFmtI+E7zlar1jDfip
 GXfkmp4Jxwwxy414GBiNZYyMM2VPMd7JKXuq+loAZUgAfrTqTyTE8by/tsJqzW4glG
 Xj4kcsQ/+WIfaE8Vg+oI1TmYo+tazuOY3AxE3KHDg7H/scGtcH4mJNjlHZ0hLg0iQ2
 txBjJd0f1yrzSJxTKnX3G/NDzZRa9OuzJdPo/1A9mYdIEuPEEFDbDU1nKkOQ9In0dQ
 lzxrgRT/vTxdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC/DO NOT MERGE 07/12] drm/msm/hdmi: Split PHY init
 from power up
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com, vkoul@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-7-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-7-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:22:31 +0000
Message-Id: <20260828142231.81AD01F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The HDMI pixel clock is disabled before the 20ms vblank delay, bre=
aking the intended shutdown sequence and risking hardware hangs.
- [Medium] Unconditional clock disable and PHY deinitialization can cause u=
nbalanced clock teardown or CCF warnings.

Pre-existing issues:
- [High] Hardware registers are accessed after dropping the runtime PM refe=
rence.
- [High] Missing return value checks for hardware initialization functions,=
 such as `pm_runtime_resume_and_get()` and `msm_hdmi_phy_resource_enable()`.
--

commit 821f230494b55344c7aaf6bb73ba3e416ff8cb25
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: drm/msm/hdmi: Split PHY init from power up

This commit reworks and splits the msm_hdmi_power_on() sequence into
smaller steps. It separates out runtime PM enablement, introduces a new
msm_hdmi_phy_init() step, and splits clock preparation and reparenting into
msm_hdmi_clk_prepare() which runs after PHY initialization.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm=
/hdmi/hdmi_bridge.c
> index 9d027f96ae243..ead6ba3b8192a 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> @@ -15,12 +15,18 @@
> =20
>  static void msm_hdmi_power_on(struct drm_bridge *bridge)
>  {
> -	struct drm_device *dev =3D bridge->dev;
>  	struct hdmi_bridge *hdmi_bridge =3D to_hdmi_bridge(bridge);
>  	struct hdmi *hdmi =3D hdmi_bridge->hdmi;
> -	int ret;
> =20
>  	pm_runtime_resume_and_get(&hdmi->pdev->dev);

[Severity: High]
This is a pre-existing issue, but is it safe to ignore the return value of
pm_runtime_resume_and_get() here?

If it fails, the power domain is not enabled and the PM usage count is not
incremented. Proceeding to access hardware registers will cause an SError
or panic, and the subsequent pm_runtime_put() in the disable path will
underflow the usage count.

> +}

[ ... ]

> @@ -341,6 +359,8 @@ static void msm_hdmi_bridge_atomic_post_disable(struc=
t drm_bridge *bridge,
>  	msm_hdmi_set_mode(hdmi, hdmi->hpd_enabled);
> =20
>  	msm_hdmi_phy_powerdown(phy);
> +	msm_hdmi_clk_unprepare(bridge);
> +	msm_hdmi_phy_deinit(phy);
> =20
>  	if (hdmi->power_on) {

[Severity: Medium]
Can this unconditional clock disable and PHY deinitialization cause
unbalanced clock teardown or Common Clock Framework warnings?

If atomic_post_disable() is called to sanitize the hardware during initial
modeset (where hdmi->power_on is false), msm_hdmi_clk_unprepare() will be
called without a matching prior enable. This bypasses the state tracking
guard and triggers a WARN in the CCF.

[Severity: High]
Does this code disable the HDMI pixel clock before the 20ms vblank delay
inside power_off()?

Because msm_hdmi_clk_unprepare() is called before power_off(), the
pipeline is frozen mid-frame before the delay executes. Powering down a
frozen display controller mid-frame frequently causes system-wide bus hangs
(AXI bus stalls) on ARM SoCs.

>  		power_off(bridge);

[Severity: High]
This is a pre-existing issue, but can the code following power_off() access
hardware registers after the runtime PM reference has been dropped?

The power_off() function drops the runtime PM reference via
pm_runtime_put(). Immediately after, msm_hdmi_bridge_atomic_post_disable()
calls msm_hdmi_audio_update() if the display info is HDMI.

This accesses MMIO registers via hdmi_read() and hdmi_write(). It risks an
asynchronous SError (kernel panic) if the power domain is turned off in the
background before the accesses complete.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-drm-msm-hd=
mi-eliza-v1-0-67843277de17@oss.qualcomm.com?part=3D7
