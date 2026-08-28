Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEF3C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7EA110F3D0;
	Fri, 28 Aug 2026 14:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g+HQadwh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A3410F3D0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:16:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E94B9601FD;
 Fri, 28 Aug 2026 14:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211751F000E9;
 Fri, 28 Aug 2026 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787926562;
 bh=gpSQdtmPiduaeeqYTWQNMk4lHtkx6iHZpTrlb/zsQeU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g+HQadwhzYonTCNZPPr/RlcKSnUTcWmMJ2sEDB64u6Aol13blVuSDPPgE413j9m+D
 KuAits7gjHyWyrgI0ymaJKAC7643P5uJSnNtDPLmruFaN6G+9MBNUVZsXKFdNnqGoa
 mYc7tKATfGNIL7ZLsadPhV4q55l/nB+GmAvFI5PR9bHmQgFt+vrb/PDXYMhAHPg52d
 e76UdZM+6TmQDzDiQywaAaqzdIDSPjRsAo/NvcZA5cEO5/jmp+qlrAEDCrjIvY0uJs
 ESancyiUBoAd6h6cMmPFTwywBn/uBkmDcyp48q1MhMTStFsrgtNbLZXpQ7G5TaxxpO
 HCN6n1KGbmxeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC/DO NOT MERGE 08/12] drm/msm/hdmi: Add support for PM
 OPP table
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, vkoul@kernel.org,
 robh@kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-8-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-8-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:16:01 +0000
Message-Id: <20260828141602.211751F000E9@smtp.kernel.org>
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
- [High] Unconditional call to `devm_pm_opp_set_clkname()` causes probe fai=
lure on platforms without the optional "extp" clock.
- [Medium] Memory and reference leak of `hdmi->next_bridge` on error paths =
in probe due to bypassed cleanup.
--

commit 44f5c22fff51888fa0578000b738b8abea1a33b0
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

drm/msm/hdmi: Add support for PM OPP table

This commit adds PM OPP table support to allow scaling domain rails=20
using the pixel clock ("extp"). This enables proper votes depending=20
on the requested HDMI pixel rate.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/h=
dmi.c
> index 4740060846335..c46f30063f142 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
[ ... ]
> @@ -368,6 +368,14 @@ static int msm_hdmi_dev_probe(struct platform_device=
 *pdev)
>  		goto err_put_bridge;
>  	}
> =20
> +	ret =3D devm_pm_opp_set_clkname(dev, "extp");
> +	if (ret)
> +		return ret;

[Severity: High]
Does this code cause a probe failure on platforms without the "extp" clock?

Earlier in msm_hdmi_dev_probe(), the "extp" clock is fetched using=20
devm_clk_get_optional():

        hdmi->extp_clk =3D devm_clk_get_optional(dev, "extp");

If the platform does not provide this clock, devm_pm_opp_set_clkname()=20
will return an error (such as -ENOENT). Returning that error here will
unconditionally abort the probe, preventing display output on hardware
where this clock is legitimately absent.

[Severity: Medium]
Also, does this code leak the hdmi->next_bridge reference by returning=20
directly?

If devm_pm_opp_set_clkname() fails, returning the error directly skips the=
=20
goto err_put_bridge; label. This bypasses the cleanup of hdmi->next_bridge,
which was acquired earlier in msm_hdmi_dev_probe() via
of_drm_get_bridge_by_endpoint().

> +
> +	ret =3D devm_pm_opp_of_add_table(dev);
> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "invalid OPP table in device tree\n");

[Severity: Medium]
Similarly, does this direct return also leak the hdmi->next_bridge reference
if devm_pm_opp_of_add_table() fails?=20

Using the goto err_put_bridge; path instead of returning directly would=20
ensure the bridge reference is correctly dropped.

> +
>  	if (!hdmi->hpd_gpiod)
>  		DBG("failed to get HPD gpio");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-drm-msm-hd=
mi-eliza-v1-0-67843277de17@oss.qualcomm.com?part=3D8
