Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9372BCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 22:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE3510E004;
	Mon, 12 Oct 2026 22:48:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E4C10E004
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 22:48:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16162601E4;
 Mon, 12 Oct 2026 22:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9FF1F0089B;
 Mon, 12 Oct 2026 22:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791845319;
 bh=l13zn7MCr9+2wGgyeqi2GdPwwl3fuDWzNMzcz39M1fU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IgRJuAGw6EigfdN81DSfGO4xWASp/wlBODWu7zMuADVpnrtz4EG0gvshlXlHP3DAt
 6JQZ6p4gadNfQfTZXzp0kcMSqUkTzBLUfWVihvFtWHq4X2bMii1glc4YFzpceeBLsD
 x/cVw9Jkx2Yn/l7i2BM0Kj9yJzKSlNxwhLG/7wFnO3O7mTr1d5RMeyH5rgXgh+RQj/
 Of4M7YmQHsbCWLA4LUM9JBUI1CS8w+eQG9yroGmMLArzN4uSgxTUhNlWVyiiwtChbe
 ygdyko8/tlDgtMACLngJfATvBY5AVIbVCNUL6QVF4GptFkGgpgJ//a9t1t1RCcrvns
 ImdOeaZgTJmkw==
Message-ID: <sashiko-outbox-168686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] drm/vc4: hdmi: Bump BCM2835 max pixel clock to
 165 MHz
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013-vc4-common-scramb-v2-2-a41d15e131ad@collabora.com>
References: <20261013-vc4-common-scramb-v2-0-a41d15e131ad@collabora.com>
 <20261013-vc4-common-scramb-v2-2-a41d15e131ad@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 22:48:39 +0000
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
- [High] drm/vc4: CEC register corruption via HSM clock divider overflow
--

commit ea5ddad9978e31ee47e604996aa2db29025b7ffb
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/vc4: hdmi: Bump BCM2835 max pixel clock to 165 MHz

This commit increases the maximum pixel clock for BCM2835 HDMI from 162 MHz
to 165 MHz. It allows users to use pixel clocks closer to the HSM clock,
which is now scaled to 101% of the pixel clock rate.

> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index 8e4623ccc4f8d..e61f1b694dbe2 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
[ ... ]
> @@ -3363,7 +3363,7 @@ static const struct vc4_hdmi_variant bcm2835_varian=
t =3D {
>  	.encoder_type		=3D VC4_ENCODER_TYPE_HDMI0,
>  	.debugfs_name		=3D "hdmi_regs",
>  	.card_name		=3D "vc4-hdmi",
> -	.max_pixel_clock	=3D 162000000,
> +	.max_pixel_clock	=3D HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ,

[Severity: High]
Does increasing the max pixel clock to 165 MHz cause an unmasked integer
overflow that corrupts the CEC register?

When modesetting at 165 MHz, the HSM clock is scaled to 166.65 MHz (101%).
This execution flows through vc4_hdmi_encoder_pre_crtc_configure() down to
vc4_hdmi_cec_update_clk_div():

drivers/gpu/drm/vc4/vc4_hdmi.c:vc4_hdmi_cec_update_clk_div():
    clk_cnt =3D cec_rate / CEC_CLOCK_FREQ;
    value |=3D clk_cnt << VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT;
    HDMI_WRITE(HDMI_CEC_CNTRL_1, value);

The CEC clock divider calculation (166.65 MHz / 40 kHz) yields 4166 (0x1046=
),
which exceeds the 12-bit VC4_HDMI_CEC_DIV_CLK_CNT limit (4095). Since the
value is unmasked, it spills directly into the adjacent
VC4_HDMI_CEC_ADDR_MASK field, silently breaking CEC functionality on 165 MHz
modesets.

>  	.registers		=3D vc4_hdmi_fields,
>  	.num_registers		=3D ARRAY_SIZE(vc4_hdmi_fields),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-vc4-common=
-scramb-v2-0-a41d15e131ad@collabora.com?part=3D2
