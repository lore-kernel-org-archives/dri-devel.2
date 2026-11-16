Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485E606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzJxLpqr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E9C10F1CE;
	Mon, 16 Nov 2026 13:30:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0E410F1A0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:30:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7D2160DD0;
 Mon, 16 Nov 2026 13:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F4D1F000C4;
 Mon, 16 Nov 2026 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794835822;
 bh=NY7N2tubvcvARtBhqdjLt3ZsbtHPX+yB6//X0ZMhmUc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HzJxLpqrze+Pbdpovk0B8ZZG7PltiXkwuecIehVqVhUb/xEzMjq5vGXGUH/cpIEIn
 EUCaRzMbGC98cIdlYXOIAUi4tHPOSs4STpfeB/RI4bxk42pcdHnb+415twOMvLkcc2
 Kz+E6hnha2/Qj3UZrbP97MPJElG0xNI2DDiV/jnx2/XWtDK4CvJQQ8s7gqgJPFOUKw
 DBABeAEmSOkwlys6DI1fMcTTw8S6No1TlJn2iqkvQfBZBiZ7GxG1/Nw04EmT8SXF45
 qjvtm1mQCxQUm+zkW/Vpb9Lh3FiORuMDvkXmicX5bpNl0YlCkI4zjYcUiHsPuQBaCh
 Dxbn2kodsIqYw==
Message-ID: <sashiko-outbox-217079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/11] phy: qcom: edp: Add Nord-specific QSERDES COM
 register header
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261116-nord-drv-dt-v3-10-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
 <20261116-nord-drv-dt-v3-10-e3d3bf0e2c49@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:30:21 +0000
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
- [Low] phy: qcom: edp: duplicate QSERDES v6 COM register definitions in
  v8-nord header
--

commit 6ae0c395ca0665ea9d8f96120d2aff620150f574
Author: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

phy: qcom: edp: Add Nord-specific QSERDES COM register header

This commit adds a header defining the QSERDES COM register offsets for
the Nord DisplayPort QMP PHY.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8-nord.h b=
/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8-nord.h
> new file mode 100644
> index 0000000000000..f38b48dae39e3
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8-nord.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserv=
ed.
> + */
> +
> +#ifndef QCOM_PHY_QMP_QSERDES_DP_COM_V8_NORD_H_
> +#define QCOM_PHY_QMP_QSERDES_DP_COM_V8_NORD_H_
> +
> +/* Nord DP QMP PHY - QSERDES COM registers (relocated from v8 base offse=
ts) */
> +#define NORD_DP_QSERDES_COM_HSCLK_SEL_1			0x03c
> +#define NORD_DP_QSERDES_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x058
> +#define NORD_DP_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x05c
> +#define NORD_DP_QSERDES_COM_SSC_STEP_SIZE1_MODE0	0x060
> +#define NORD_DP_QSERDES_COM_SSC_STEP_SIZE2_MODE0	0x064
> +#define NORD_DP_QSERDES_COM_CP_CTRL_MODE0		0x070
> +#define NORD_DP_QSERDES_COM_PLL_RCTRL_MODE0		0x074
> +#define NORD_DP_QSERDES_COM_PLL_CCTRL_MODE0		0x078
> +#define NORD_DP_QSERDES_COM_CORECLK_DIV_MODE0		0x07c
> +#define NORD_DP_QSERDES_COM_LOCK_CMP1_MODE0		0x080
> +#define NORD_DP_QSERDES_COM_LOCK_CMP2_MODE0		0x084
> +#define NORD_DP_QSERDES_COM_DEC_START_MODE0		0x088
> +#define NORD_DP_QSERDES_COM_DIV_FRAC_START1_MODE0	0x090
> +#define NORD_DP_QSERDES_COM_DIV_FRAC_START2_MODE0	0x094
> +#define NORD_DP_QSERDES_COM_DIV_FRAC_START3_MODE0	0x098
> +#define NORD_DP_QSERDES_COM_INTEGLOOP_GAIN0_MODE0	0x0a0
> +#define NORD_DP_QSERDES_COM_INTEGLOOP_GAIN1_MODE0	0x0a4
> +#define NORD_DP_QSERDES_COM_VCO_TUNE1_MODE0		0x0a8
> +#define NORD_DP_QSERDES_COM_VCO_TUNE2_MODE0		0x0ac
> +#define NORD_DP_QSERDES_COM_BG_TIMER			0x0bc
> +#define NORD_DP_QSERDES_COM_SSC_EN_CENTER		0x0c0
> +#define NORD_DP_QSERDES_COM_SSC_ADJ_PER1		0x0c4
> +#define NORD_DP_QSERDES_COM_SSC_PER1			0x0cc
> +#define NORD_DP_QSERDES_COM_SSC_PER2			0x0d0
> +#define NORD_DP_QSERDES_COM_BIAS_EN_CLKBUFLR_EN	0x0dc
> +#define NORD_DP_QSERDES_COM_CLK_ENABLE1			0x0e0
> +#define NORD_DP_QSERDES_COM_SYS_CLK_CTRL		0x0e4
> +#define NORD_DP_QSERDES_COM_SYSCLK_BUF_ENABLE		0x0e8
> +#define NORD_DP_QSERDES_COM_PLL_IVCO			0x0f4
> +#define NORD_DP_QSERDES_COM_SYSCLK_EN_SEL		0x110
> +#define NORD_DP_QSERDES_COM_RESETSM_CNTRL		0x118
> +#define NORD_DP_QSERDES_COM_LOCK_CMP_EN			0x120
> +#define NORD_DP_QSERDES_COM_VCO_TUNE_CTRL		0x13c
> +#define NORD_DP_QSERDES_COM_VCO_TUNE_MAP		0x140
> +#define NORD_DP_QSERDES_COM_CLK_SELECT			0x164
> +#define NORD_DP_QSERDES_COM_CORE_CLK_EN			0x170
> +#define NORD_DP_QSERDES_COM_CMN_CONFIG_1		0x174
> +#define NORD_DP_QSERDES_COM_SVS_MODE_CLK_SEL		0x17c
> +#define NORD_DP_QSERDES_COM_CMN_STATUS			0x1d0
> +#define NORD_DP_QSERDES_COM_C_READY_STATUS		0x1f8

[Severity: Low]
Can Nord reuse the existing QSERDES_V6_COM_* definitions from
drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h instead of introducing
this SoC-specific header?

All 40 NORD_DP_QSERDES_COM_* register offsets defined here are identical to
the existing QSERDES_V6_COM_* definitions.  Moreover,
drivers/phy/qualcomm/phy-qcom-edp.c already includes
phy-qcom-qmp-qserdes-com-v6.h and provides v6 COM helpers (such as
qcom_edp_phy_power_on_v6(), qcom_edp_phy_com_resetsm_cntrl_v6(), and
qcom_edp_com_bias_en_clkbuflr_v6()), and nord_usb3dpphy_cfg in
drivers/phy/qualcomm/phy-qcom-qmp-combo.c already uses qmp_v6_dp_serdes_tbl
with the QSERDES_V6_COM_* definitions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-nord-drv-d=
t-v3-0-e3d3bf0e2c49@oss.qualcomm.com?part=3D10
