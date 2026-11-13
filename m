Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546A606AE13
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cY3VOVAp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E68911268F;
	Fri, 13 Nov 2026 16:08:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332E010EC69
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:08:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C4D446648;
 Fri, 13 Nov 2026 16:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACA41F000C4;
 Fri, 13 Nov 2026 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794586105;
 bh=6ryxFwwcER6FOSNecYjXVfS7v18vVPAs/JONPuhnvVk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cY3VOVApbt5h+WMzqSbbXgiBmMKV3s6IB/7euA0QKP1t1Tkd+okMlurxoIgyCpY+9
 0qvL3C4SiyrUxnMU9QDGu7kvdSVl/Hl9N6dsmJ2fRUuhQekdbXgGbymXrr08QdsCqH
 8GsHADX8RWvGYBuKRDK0KAiSh/niGus+zdQMIKtrgCMFloQnhgDisYXr/Z1/PytHTP
 LrbnECVBzAJyeqpgMJJLo1kHqIDYa3lOp2di9/hF1Hc8+WQQBDNL0EeLBuxsVbvyD1
 CHuVFPJbi33SjYdxV70Ng7il/y/iEqSKq0XtntT1gf4BuwCW+prw1aNLQjOxktMjYy
 9OaWLq//tH55Q==
Message-ID: <sashiko-outbox-213161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/msm/mdss: reset all block resets described in DT
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>,
 dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113155606.1677313-3-xiaqinghuan@mail.ustc.edu.cn>
References: <20261113155606.1677313-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261113155606.1677313-3-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:08:24 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/msm/mdss: inaccurate INT2 reset description in
  msm_mdss_reset() commit
--

commit 8dd3e2454eeeb0b73b84226f92cb892017ce9f66
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

drm/msm/mdss: reset all block resets described in DT

This commit switches msm_mdss_reset() to devm_reset_control_array_get() so
that all resets listed in the MDSS device node are asserted and deasserted
together.

> msm_mdss_reset() acquires only the first reset listed in the MDSS
> device node.  Platforms can describe more than one MDSS block reset: the
> SM8750 display clock controller also provides a reset for the MDSS core
> INT2 interrupt controller, which is left out of reset when the
> bootloader hands over with the display block still running.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mds=
s.c
> index 259d362475c81..e10185ef21677 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -325,7 +325,8 @@ static int msm_mdss_reset(struct device *dev)
>  {
>  	struct reset_control *reset;
> =20
> -	reset =3D reset_control_get_optional_exclusive(dev, NULL);
> +	reset =3D devm_reset_control_array_get(dev,
> +					     RESET_CONTROL_OPTIONAL_EXCLUSIVE);
>  	if (!reset) {
>  		/* Optional reset not specified */
>  		return 0;
> @@ -342,8 +343,6 @@ static int msm_mdss_reset(struct device *dev)
>  	msleep(20);
>  	reset_control_deassert(reset);
> =20
> -	reset_control_put(reset);
> -
>  	return 0;
>  }

[Severity: Low]
As reported by Dmitry Baryshkov on v3 [1], is the commit message accurate in
describing DISP_CC_MDSS_CORE_INT2_BCR on SM8750 as a reset for an INT2
interrupt controller?

In drivers/clk/qcom/dispcc-sm8750.c, DISP_CC_MDSS_CORE_INT2_BCR (0xa000) is
the block reset for the second internal MDSS core domain paired with
mdss_int2_gdsc (0xb000) and the disp_cc_mdss_mdp1_clk,
disp_cc_mdss_mdp_lut1_clk, disp_cc_mdss_vsync1_clk, and
disp_cc_mdss_ahb1_clk branch clocks, as updated in commit "arm64: dts: qcom:
sm8750: describe the second MDSS block reset".

In addition, switching from reset_control_get_optional_exclusive() and
reset_control_put() to devm_reset_control_array_get() keeps the exclusive
reset controls acquired for the lifetime of the msm_mdss device rather than
releasing them after the boot reset pulse.

[1] https://lore.kernel.org/r/awb7bslhrhemsgvu7ubaejvurk6fecotgvqlwtvsoe2be=
nqdgq@tvh2sfjbuzyu

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155606.1677=
313-1-xiaqinghuan@mail.ustc.edu.cn?part=3D2
