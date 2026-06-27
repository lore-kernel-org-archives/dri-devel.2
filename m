Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71853C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 12:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E4A10E4CC;
	Sat, 27 Jun 2026 12:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SbEiHn3+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E446810E4CC
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 12:27:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3984C600AB
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 12:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45F41F000E9;
 Sat, 27 Jun 2026 12:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782563250;
 bh=z/6oDV2ysdNKE2w3qd+x2yOoWwdHtvBeztL88QPl6sg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SbEiHn3+HB/KJYJRZ1sPrwIvZcAUDTTxn6mR45aOd+R0cA4aNxciCl2ZOygfDSYP5
 +X/XWbHplUiGIvW9T5JAEGM03CCDKpRbQPuLDIHsX0RS3GzHm8kKiuQXTqII3gcHyw
 9j7xglNEXu6eGtA72G1B2s5LQxl9dvcsqFYPlCwGDrSsHG61izOdEzeGH8jzBrZnCZ
 BZSpKGRX3D3XoXDVyfk1UoGJqL+273FY3l9dac9ZS+1Lp3/55rl3w4icNeviUhSKxY
 pG4FRbSpz4HaiSo0SFjUZt/2HwxnE4DDFH8UBotNDueRisihCdYQR3BQF+B/FcvYXp
 RJfr+k2kYqyRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] drm/msm/mdss: keep mdp1-mem interconnect alive
 during suspend on SDM845
To: "Sam Day via B4 Relay" <devnull+me.samcday.com@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-rfc-sdm845-interconnect-collapse-workaround-v1-1-608a38de3715@samcday.com>
References: <20260627-rfc-sdm845-interconnect-collapse-workaround-v1-1-608a38de3715@samcday.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 12:27:30 +0000
Message-Id: <20260627122730.B45F41F000E9@smtp.kernel.org>
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
- [Low] Unnecessary device tree string matching on every iteration due to m=
issing short-circuit evaluation.

Pre-existing issues:
- [High] Silent failure on `-EPROBE_DEFER` for `mdp1-mem` prevents the SDM8=
45 workaround from applying.
--

commit 25610098a6bc164e41324a820ebd766373a58240
Author: Sam Day <me@samcday.com>

drm/msm/mdss: keep mdp1-mem interconnect alive during suspend on SDM845

If the peak vote for mdp1-mem is allowed to drop to zero, it seems to
cause the fabric to collapse that path entirely, which causes the device
to bus stall and fatally reset.

> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mds=
s.c
> index 9087c4b290dba..c635380b2ac3c 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
[ ... ]
> @@ -284,8 +284,12 @@ static int msm_mdss_disable(struct msm_mdss *msm_mds=
s)
> =20
>  	clk_bulk_disable_unprepare(msm_mdss->num_clocks, msm_mdss->clocks);
> =20
> -	for (i =3D 0; i < msm_mdss->num_mdp_paths; i++)
> -		icc_set_bw(msm_mdss->mdp_path[i], 0, 0);
> +	for (i =3D 0; i < msm_mdss->num_mdp_paths; i++) {
> +		if (of_device_is_compatible(msm_mdss->dev->of_node, "qcom,sdm845-mdss"=
) && i =3D=3D 1)

[Severity: Low]
Does this code perform unnecessary device tree string matching on every
iteration?

In C, the logical AND operator evaluates left-to-right. Thus,
of_device_is_compatible() is called on the first iteration (i =3D=3D 0),
despite i =3D=3D 1 being false. Swapping the conditions to
i =3D=3D 1 && of_device_is_compatible(...) would properly short-circuit
the expensive device tree string matching.

[Severity: High]
This isn't a bug introduced by this patch, but does the silent failure on
-EPROBE_DEFER for mdp1-mem prevent this SDM845 workaround from applying?

Looking at msm_mdss_parse_data_bus_icc_path():

drivers/gpu/drm/msm/msm_mdss.c:msm_mdss_parse_data_bus_icc_path() {
    ...
	path1 =3D devm_of_icc_get(dev, "mdp1-mem");
	if (!IS_ERR_OR_NULL(path1)) {
    ...
}

During device probe, if the interconnect provider for mdp1-mem is not yet
ready, devm_of_icc_get() returns ERR_PTR(-EPROBE_DEFER). The condition
!IS_ERR_OR_NULL(path1) handles this by silently skipping mdp1-mem rather
than returning -EPROBE_DEFER to defer the probe.

If this happens on SDM845, num_mdp_paths remains 1, meaning the newly added
workaround loop here in msm_mdss_disable() never reaches i =3D=3D 1.

Consequently, the vote for mdp1-mem drops to zero when the interconnect core
syncs state, which triggers the bus stall and fatal reset that this patch is
explicitly trying to fix.

> +			icc_set_bw(msm_mdss->mdp_path[i], 0, 1);
> +		else
> +			icc_set_bw(msm_mdss->mdp_path[i], 0, 0);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-rfc-sdm845=
-interconnect-collapse-workaround-v1-1-608a38de3715@samcday.com?part=3D1
