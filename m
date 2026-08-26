Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FDAC61DC6
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DA910E2AC;
	Wed, 26 Aug 2026 13:38:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c1yHT5im";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E75710E2AC
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:38:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A0DB43212;
 Wed, 26 Aug 2026 13:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83F51F000E9;
 Wed, 26 Aug 2026 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787751512;
 bh=RaHE5HaCRIguS7TaSCz+N1AryZuIXrOhVtHCsu+LEco=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c1yHT5imfjXnV6LSY8v5h2aC+CxWilOvpverE1wDm4Ok/IKBAEgk3jApzsVhbuVYl
 LcP0pxIFMQIMeTk2Ng6UjEbEjxJVxJ96cZy7GTe439aDRnKXw6ZJUZ9HUEr33Gn+2E
 i2/nR0d3SRzXbU6vSv89pxQsrbsy1nBs7N18hhQ0J/9CPfzLmmoEZ/myW/MfTD6pWd
 wNumvxzKsnnmMAUGipcbui1RwptvRx4t+vFpmxBjGVLwZXav4fsoTPH2Xo995g96c2
 ZMYRasaXJPpluWuOj9mcp3cCvvg9fly5sSPEX+cJ7XFgRZTmCRAR4Wcj+Qz0fVoSb8
 sBZgvULsV6ebg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/bridge: tc358767: check regmap_write() return
 values
To: =?utf-8?b?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC0?=
 =?utf-8?b?0LjQvdC+0LLQuNGH?= <r.zhambakiev@prosoftsystems.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826132251.113084-1-r.zhambakiev@prosoftsystems.ru>
References: <20260826132251.113084-1-r.zhambakiev@prosoftsystems.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 13:38:31 +0000
Message-Id: <20260826133831.C83F51F000E9@smtp.kernel.org>
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
- [Medium] Meaningful code and commit message mismatch regarding error clea=
nup
--

commit eec31d58dcee33de416927375afdb370e4851289
Author: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

drm/bridge: tc358767: check regmap_write() return values

This commit propagates error values from regmap_write() in
tc_set_edp_video_mode() and tc_main_link_enable(). The commit message
asserts that the callers of both functions already handle failures by
disabling the main link via tc_main_link_disable().

> Propagate the errors instead. The callers of both functions already
> handle failures by disabling the main link via tc_main_link_disable().

[Severity: Medium]
Is this description accurate for both functions?

While the caller of tc_set_edp_video_mode() handles failures by calling
tc_main_link_disable(), it looks like the caller of tc_main_link_enable()
does not.

If tc_main_link_enable() fails, its caller tc_edp_bridge_atomic_enable()
only logs the error and returns:

drivers/gpu/drm/bridge/tc358767.c:tc_edp_bridge_atomic_enable() {
	...
	ret =3D tc_main_link_enable(tc);
	if (ret < 0) {
		dev_err(tc->dev, "main link enable error: %d\n", ret);
		return;
	}
	...
}

Will this mismatch leave the hardware in a partially initialized state
upon I2C failure if tc_main_link_enable() returns early?

> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/t=
c358767.c
> index e3a57f8228dae..a98a48534bf60 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
[ ... ]
> @@ -1144,9 +1146,14 @@ static int tc_main_link_enable(struct tc_data *tc)
>  	/* Reset/Enable Main Links */
>  	dp_phy_ctrl |=3D DP_PHY_RST | PHY_M1_RST | PHY_M0_RST;
>  	ret =3D regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
> +	if (ret)
> +		return ret;
> +

[Severity: Medium]
Does returning an error here rely on the caller performing cleanup that it
currently lacks?

>  	usleep_range(100, 200);
>  	dp_phy_ctrl &=3D ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
>  	ret =3D regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
> +	if (ret)
> +		return ret;
> =20
>  	ret =3D tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 500, 100000);
>  	if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826132251.1130=
84-1-r.zhambakiev@prosoftsystems.ru?part=3D1
