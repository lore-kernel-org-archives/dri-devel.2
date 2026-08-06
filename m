Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9250DC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC84B10F06B;
	Thu,  6 Aug 2026 00:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K9CoGpuc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E7510F06B
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:58:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF6B960A64;
 Thu,  6 Aug 2026 00:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230A61F00A3A;
 Thu,  6 Aug 2026 00:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785977891;
 bh=mFEpnPMj9EIoExCVxyq+2h87FI1SbRMLY5sfqEC8B98=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K9CoGpucUblTXTb/Vx3dr2o4XkW+uup6EtzoxZYj2BKSKDGv1Zi8hp7+RQzASAgtD
 NarKW5gec6x42yZmr5xWU3xbDz2ud6n6z6rE4wzimlwUyaRySMI9CAZMBhY8eHy/98
 5tr/SOxiJsEZmAE1hjqsey+HsuJvMe5g0pd38JkkOAv8ozfr3rsThK7lM8asCfwRMU
 2X1o+Gs/Xp/aa+NB6p/Ib9RIhXbFhgRP8qXpTTHUAPGHbGXv9+lOrg+dwqvkNDzbty
 S4dY6D1XzmaTSps6PMCZYiim61Ub0FaBAOucY/s5PC56FwZkSfFoPM9/Py8KaxaF7P
 QAkE18l1MPlAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/21] drm/bridge: synopsys: dw-dp: Document missing
 reset line deassert
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-4-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v10-4-d84a26c303d6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 00:58:10 +0000
Message-Id: <20260806005811.230A61F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing reinit_completion in dw_dp_aux_transfer causes AUX transfe=
r corruption after timeouts.
- [High] Sleeping delay functions are used in atomic commit paths, violatin=
g DRM subsystem guidelines.
--

--- Patch [4]: [PATCH v10 04/21] drm/bridge: synopsys: dw-dp: Document miss=
ing reset line deassert ---
commit c7f9030ef61e21ab471dde4c6e59c410a28a4503
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Document missing reset line deassert

This commit documents an issue where the SoC will hang if the reset line
is automatically deasserted during probe using
devm_reset_control_get_exclusive_deasserted(). It leaves the existing
devm_reset_control_get() call in place to avoid the hang.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index dd951fd447227..fd7663013faaa 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -2095,6 +2095,10 @@ struct dw_dp *dw_dp_probe(struct platform_device *=
pdev, const struct dw_dp_plat_
>  		return ERR_CAST(dp->hdcp_clk);
>  	}
> =20
> +	/*
> +	 * This reset line is deasserted by default; asserting it hangs the SoC=
 if the
> +	 * related power-domain is still active.
> +	 */
>  	dp->rstc =3D devm_reset_control_get(dev, NULL);
>  	if (IS_ERR(dp->rstc)) {
>  		dev_err_probe(dev, PTR_ERR(dp->rstc), "failed to get reset control\n");

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the DP driver
I noticed a potential atomic context violation in dw_dp_link_train_fast():

    ret =3D dw_dp_link_train_set_pattern(dp, DP_TRAINING_PATTERN_1);
    if (ret)
        goto out;

    usleep_range(500, 1000);

Can this sleep function be reached from atomic commit paths?

Looking at dw_dp_bridge_atomic_enable(), it appears this function
is called during the modeset. The DRM subsystem guide indicates that
atomic enable callbacks run in an atomic context where sleeping
is forbidden, which could lead to scheduling while atomic panics.

Would it be better to replace usleep_range() with a non-sleeping
delay like udelay() or ndelay() in this path?

[Severity: High]
This is another pre-existing issue, but I noticed a potential problem with
how wait_for_completion_timeout() is used in dw_dp_aux_transfer():

    value |=3D FIELD_PREP(AUX_CMD_TYPE, msg->request);
    value |=3D FIELD_PREP(AUX_ADDR, msg->address);
    regmap_write(dp->regmap, DW_DP_AUX_CMD, value);

    status =3D wait_for_completion_timeout(&dp->complete, timeout);

Could this lead to stale data being read?=20

If a previous AUX transfer times out and the hardware completes the
interrupt shortly after, the completion's internal counter would increment.
A subsequent call to dw_dp_aux_transfer() might return immediately from
wait_for_completion_timeout() without waiting for the new transaction,
causing the driver to read garbage data from the AUX status registers.

Should there be a call to reinit_completion(&dp->complete) before
writing to DW_DP_AUX_CMD?

[Severity: High]
This is a pre-existing issue as well, but I noticed another potential
atomic context violation in dw_dp_reset():

    disable_irq(dp->irq);
    regmap_update_bits(dp->regmap, DW_DP_SOFT_RESET_CTRL, CONTROLLER_RESET,
               FIELD_PREP(CONTROLLER_RESET, 1));
    usleep_range(10, 20);
    regmap_update_bits(dp->regmap, DW_DP_SOFT_RESET_CTRL, CONTROLLER_RESET,
               FIELD_PREP(CONTROLLER_RESET, 0));

    dw_dp_init_hw(dp);
    regmap_read_poll_timeout(dp->regmap, DW_DP_HPD_STATUS, val,
                 FIELD_GET(HPD_HOT_PLUG, val), 200, 200000);

Does dw_dp_bridge_atomic_disable() eventually call this reset function?

Since dw_dp_bridge_atomic_disable() is an atomic commit callback,
using usleep_range() and regmap_read_poll_timeout() (which sleeps)
here might cause system panics during a hot path.=20

Might we need to switch to non-sleeping equivalents or move this
initialization out of the atomic commit path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v10-0-d84a26c303d6@collabora.com?part=3D4
