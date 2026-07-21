Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8F1C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0D710E6AF;
	Tue, 21 Jul 2026 07:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kanardia.eu header.i=@kanardia.eu header.b="M+9kL0Wu";
	dkim-atps=neutral
Received: from th8-b.mail-neoserv.si (th8-b.mail-neoserv.si [152.89.234.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB51810E033
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:14:58 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=th8.neoserv.si; s=default;
 b=f+4kR4yo6jUf6v9SOHEGD9M8XEgZUV9p+czmITsw0Dp1mnM4ggfaih8T0PNiq8P8U9Pof/Kzgr
 M10NHliUFZoPrxIS7TmjZgNEFCQrrIXz4c/LuguRnW/Ul/kdFt0EuFxpvnAi28B5LoHWfT5hiN
 TYXShh7CzlX0QryVWm5v3Np0sr1F2IWUBKeHRRXk95JnBGwmxJ9l1xHtOsSsRtyBKYDkipeQr/
 C4B6xXp1Q92w9f6AmPkcUwqLk34ARwU7wfq5MVPdbeB62Sp8FRUw3QIXYo31XNIAF6+iwHhsDS
 u5ym1aqoFzvaombi3qL/WuV2MXufvkVBksUJjsIX3mf9aA==;
ARC-Authentication-Results: i=1; th8.neoserv.si; smtp.remote-ip=::1;
 iprev=fail smtp.remote-ip=::1;
 auth=pass (LOGIN) smtp.auth=rok@kanardia.eu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=th8.neoserv.si;
 s=default; 
 bh=spvjjBURpSwPzn4lfTMPK6DZ6i2zK4dFA8f/iJY34CY=;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:In-Reply-To:
 Subject:Cc:To:From:Date:MIME-Version:DKIM-Signature;
 b=RGEu9qt8QitTA5kNQ6slKMAoDYiRdg/CSbadec9lTLzX3sFU9InXjIeFaxwMBqmaj8jz2v4sD2
 31U4B0IHT7kJPmG5In+b1gNvlKD+qpeU6vFYphJYiau9FUo6FVjpK2erFObJwlihd2LnTmD+O9
 9UEIxznjfzhprhJTrRjrv/SZhY5xrmrCSb3F/NbtZfS1u7kaS4BxJ08Vpq37yU71EVm4kYL49u
 huDDM5FZLxve0Ou6FlkEN3Q0TC8NKw+dlQkVobOVQ67Pj++hOsbd8z9DfuYtIgfGkHG+UZ5Y2g
 5JcjjaIxT1wrnRyJTweWDaK2RJrzh/j9yJChbCooMQO2Dg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kanardia.eu
 ; s=default;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
 In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BnH57+/CTddrJAAK24HEO58bPH5pRHF9mJT4Kj+dOkg=; b=M+9kL0WulPClX4Wro+BgtYt4x0
 K4PPkknNYarSYAJ6/piJJ7z76VgnSlgMNNsNACXecVwLy+oLj2rJn1Ah96r27n+3GapERMr/yMLqh
 BZ0oJ/T+yA94tD28uXm9UOs+XkCwqRXhuO3vB+e7YGqZi54xLB62Zz6Q1mjUHuQ8Y3q0/0qyYdQcr
 P1xL3Mibla2XNWQiik2v1GUUk5QDaMc0OEwnOWthu18SpWt2SQWDwsycjW5bbiMjBMrEl4Vcd5ZYR
 dLDIjHHZKnOAR7+17zMEScsc1Ncfy16Fdd4uGqXntC+My8JlB9cuLLyuSz2RSNpHBHMcg28LB8ogJ
 QoCUIG7A==;
Received: from [::1] (port=44518 helo=th8.neoserv.si)
 by th8.neoserv.si with esmtpa (Exim 4.99.4)
 (envelope-from <rok@kanardia.eu>) id 1wm4go-000000004Bv-2pq4;
 Tue, 21 Jul 2026 09:14:54 +0200
MIME-Version: 1.0
Date: Tue, 21 Jul 2026 09:14:54 +0200
From: =?UTF-8?Q?Rok_Markovi=C4=8D?= <rok@kanardia.eu>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: rk356x: add LVDS node
In-Reply-To: <20260717121309.516801F00A3A@smtp.kernel.org>
References: <20260717120005.2087386-1-rok@kanardia.eu>
 <20260717120005.2087386-5-rok@kanardia.eu>
 <20260717121309.516801F00A3A@smtp.kernel.org>
User-Agent: Roundcube Webmail/1.6.17
Message-ID: <6391bf976ade8fa7df217d0880ccdb88@kanardia.eu>
X-Sender: rok@kanardia.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: th8.neoserv.si; iprev=fail smtp.remote-ip=::1;
 auth=pass (LOGIN) smtp.auth=rok@kanardia.eu
X-NEOSERV-MailScanner-Information: Please contact the ISP for more information
X-NEOSERV-MailScanner-ID: 1wm4go-000000004Bv-2pq4
X-NEOSERV-MailScanner: Found to be clean
X-NEOSERV-MailScanner-SpamCheck: 
X-NEOSERV-MailScanner-From: rok@kanardia.eu
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - th8.neoserv.si
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kanardia.eu
X-Get-Message-Sender-Via: th8.neoserv.si: authenticated_id: rok@kanardia.eu
X-Authenticated-Sender: th8.neoserv.si: rok@kanardia.eu
X-Mailman-Approved-At: Tue, 21 Jul 2026 07:21:13 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

17.7.2026 14:13, je sashiko-bot@kernel.org napisal
> Thank you for your contribution! Sashiko AI review found 2 potential 
> issue(s) to consider:
> - [High] Missing Hardware Clock Initialization for RK3568 LVDS
> - [Medium] Unbalanced Hardware Resource Teardown in Error Paths
> --
> 
> --- Patch [4]: [PATCH 4/4] arm64: dts: rockchip: rk356x: add LVDS node 
> ---
> commit bfe12cef9ca639b004d58e050ef9175743345f7b
> Author: Rok Markovic <rok@kanardia.eu>
> 
> arm64: dts: rockchip: rk356x: add LVDS node
> 
> This commit adds the LVDS transmitter node for the RK356x SoC, 
> assigning
> its clock, physical interface, and power domains. It is left disabled 
> by
> default, to be enabled by specific board files.
> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
>> index a5832895bd392..2b3beab5507b1 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
>> @@ -879,6 +879,31 @@ hdmi_out: port@1 {
>>  		};
>>  	};
>> 
>> +	lvds: lvds {
>> +		compatible = "rockchip,rk3568-lvds";
>> +		clocks = <&cru PCLK_DSITX_0>;
>> +		clock-names = "pclk_lvds";
> 
> [Severity: High]
> Does the driver actually use this clock?
> 
> Looking at rk3568_lvds_probe() in 
> drivers/gpu/drm/rockchip/rockchip_lvds.c,
> it seems to completely omit fetching the required pclk_lvds clock from 
> the
> device tree:
> 
> drivers/gpu/drm/rockchip/rockchip_lvds.c:rk3568_lvds_probe() {
>     ...
>     lvds->dphy = devm_phy_get(&pdev->dev, "dphy");
>     if (IS_ERR(lvds->dphy))
>         return PTR_ERR(lvds->dphy);
> 
>     return phy_init(lvds->dphy);
> }
> 
> Because lvds->pclk is left NULL, the clk_enable() call in
> rk3568_lvds_poweron() acts as a no-op:
> 
> drivers/gpu/drm/rockchip/rockchip_lvds.c:rk3568_lvds_poweron() {
>     ...
>     ret = clk_enable(lvds->pclk);
>     if (ret < 0) {
>     ...
> }
> 
> Will this cause hardware registers to be accessed without a running 
> clock,
> potentially leading to system hangs on device probe or modeset?
> 
>> +		phys = <&dsi_dphy0>;
>> +		phy-names = "dphy";
>> +		power-domains = <&power RK3568_PD_VO>;
>> +		rockchip,grf = <&grf>;
>> +		rockchip,output = "lvds";
>> +		status = "disabled";
>> +
>> +		ports {

Fixed. Removed unused clock.


> 
> [Severity: Medium]
> Will enabling this hardware expose an unbalanced resource teardown in 
> the
> driver's error paths?
> 
> If intermediate steps like phy_set_mode() fail in
> rk3568_lvds_encoder_enable(), the function returns early without 
> rolling
> back earlier successful calls:
> 
> drivers/gpu/drm/rockchip/rockchip_lvds.c:rk3568_lvds_encoder_enable() {
>     ...
>     ret = phy_set_mode(lvds->dphy, PHY_MODE_LVDS);
>     if (ret) {
>         DRM_DEV_ERROR(lvds->dev, "failed to set phy mode: %d\n", ret);
>         drm_panel_unprepare(lvds->panel);
>         return;
>     }
>     ...
> }
> 
> Because .enable() returns void, the DRM core assumes it succeeded and 
> will
> later call .disable(). The rk3568_lvds_encoder_disable() function
> unconditionally tears down all resources:
> 
> drivers/gpu/drm/rockchip/rockchip_lvds.c:rk3568_lvds_encoder_disable() 
> {
>     struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
> 
>     drm_panel_disable(lvds->panel);
>     phy_power_off(lvds->dphy);
>     rk3568_lvds_poweroff(lvds);
>     drm_panel_unprepare(lvds->panel);
> }
> 
> Could this cause refcount underflows for PHY, PM runtime, and clocks,
> resulting in kernel warnings if they were never successfully enabled?
> 
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			lvds_in: port@0 {
>> +				reg = <0>;
>> +			};
>> +
>> +			lvds_out: port@1 {
>> +				reg = <1>;
>> +			};
>> +		};
>> +	};
>> +


Fixed. Testing if lvds->enabled in disable.

Will post patchset v2.
