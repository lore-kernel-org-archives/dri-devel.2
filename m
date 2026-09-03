Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8719C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D69810F540;
	Thu,  3 Sep 2026 12:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Z3NNrYox";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E72A10F540
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788437300; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WzoqmzNw6gKNA2X+QB01ANc0mvhxUrftIFL7kJGY1A/6rzZA5mNKxoipPWNdGDYL24hnm7aHlLFDWDhPrVsxRpojSANT62aXhW671OQuuU2Smms2OTYCsa7M8pOxvsm/jkZjXcC6p08+8Ced+TGmY4W8jfEJrs9S9XjTmtQ7boY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788437300;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iwMAkCD0RcmKVfoSuKy9lBJqcRb9khWXwRY8bg45kSM=; 
 b=QygDsNjCQfRRDCqfSGIrZWwqBK/UXPxNJzvOZU2kO3b7p0sWVeOPb5fiz5e2FN32G8PjDH8kyDaKsyNMsBtNzojkCCUQuhhXw99rlkFL0xFKfq5/1hLyOrBnsbeVGUTARjdHzOow1GxDQR28GrjOakz1laHy0RjBV999u6dbzQ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788437300; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=iwMAkCD0RcmKVfoSuKy9lBJqcRb9khWXwRY8bg45kSM=;
 b=Z3NNrYoxPIZNwwt8pkBvBisQYQgiMUNE02r0MTecABe8CiIYpAQeIoDCzGuENcl2
 D+MjGqty10wR6hrtW+23PzPpyUHTzZjxnrzHyG635f3koxxi/fLjKg/CZJbLHln/i0j
 5DUcvqZXMST5+z8BuKxLycX3d8w6QZJA5U+b7mW3NbyAcOWfZbk3+rNlkHArlZXBBMI
 PKE976oE8CSvtVvnG4YqIt3gHoeCLtz2GKOqEvJWf3jwUaUP6Kt+5GOFoMv/1xHtfm4
 nT5mq8HqURTyE+PtNIdRJL3rE3VdjXEnm9kJW361jgCIqNiUpDWCAbqPI3FVRdMjLrs
 DH11X5UvlQ==
Received: by mx.zohomail.com with SMTPS id 1788437298187433.9861181594147;
 Thu, 3 Sep 2026 05:08:18 -0700 (PDT)
Message-ID: <edd7ae1b38ebc687d0b2bfb2509c40fb8a45e625.camel@icenowy.me>
Subject: Re: [PATCH v2 07/17] drm/spacemit: add Saturn DPU register model
From: Icenowy Zheng <uwu@icenowy.me>
To: codykang.hk@gmail.com, David Airlie <airlied@gmail.com>, Simona Vetter	
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan	
 <dlan@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Haylen Chu <heylenay@4d2.org>, Michael
 Turquette	 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney	 <bmasney@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yao Zi
 <me@ziyao.cc>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <u.kleine-koenig@baylibre.com>, Guodong Xu <docular.xu@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org
Date: Thu, 03 Sep 2026 20:08:10 +0800
In-Reply-To: <20260809-k3-display-v2-7-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-7-327d7910bf71@gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-08-09=E6=97=A5=E7=9A=84 21:14 +0800=EF=BC=8CCody Kang via B4=
 Relay=E5=86=99=E9=81=93=EF=BC=9A
> From: Cody Kang <codykang.hk@gmail.com>
>=20
> The Saturn display processing unit is programmed through a set of
> register blocks (composer, RDMA, timing generator, cmdlist engine,
> display MMU) laid out identically in both SoC instances. Add the
> block
> address map, the per-field word offset and mask tables consumed by
> the
> field accessors, the interrupt bit layout and the compositor and
> output-format ID encodings. The address map describes the whole
> IP block on purpose, including blocks the driver does not touch; the
> field tables carry the fields the driver programs, with each block's
> full word count kept as its NWORDS extent.
>=20
> Consumers arrive with the following patches; the driver only becomes
> buildable once the final patch adds the Kconfig and Makefile glue.
>=20
> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
>=20
> ---
> v2:
> - no change
> ---
> =C2=A0drivers/gpu/drm/spacemit/dpu/saturn_regs/dpu_int.h |=C2=A0 25 ++

Is the slightly different K1 Saturn DPU registers considered?

Thanks,
Icenowy

> =C2=A0.../gpu/drm/spacemit/dpu/saturn_regs/reg_map_hee.h |=C2=A0 64 +++++
> =C2=A0.../drm/spacemit/dpu/saturn_regs/saturn_fields.h=C2=A0=C2=A0 | 298
> +++++++++++++++++++++
> =C2=A0drivers/gpu/drm/spacemit/spacemit_dpu_ids.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 22 ++
> =C2=A04 files changed, 409 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/spacemit/dpu/saturn_regs/dpu_int.h
> b/drivers/gpu/drm/spacemit/dpu/saturn_regs/dpu_int.h
> new file mode 100644
> index 0000000000000..2c7fa00ba31e9
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/saturn_regs/dpu_int.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
> + *
> + */
> +
> +#ifndef DPU_INT_REG_H
> +#define DPU_INT_REG_H
> +
> +#include <linux/bits.h>
> +
> +#define DPU_INT_CMDLIST_CH_FRM_CFG_DONE_MASK	(0xff)
> +#define
> DPU_INT_CMDLIST_CH_FRM_CFG_DONE		(DPU_INT_CMDLIST_CH_FRM_CFG_DONE_MASK<<1=
1)
> +#define DPU_INT_FRM_TIMING_UNFLOW		BIT(8)
> +#define DPU_INT_CFG_RDY_CLR			BIT(5)
> +#define DPU_INT_FRM_TIMING_CFG_LINE		BIT(4)
> +#define DPU_INT_FRM_TIMING_CFG_EOF		(BIT(2) | BIT(3))
> +#define DPU_INT_FRM_TIMING_EOF			BIT(1)
> +#define DPU_INT_FRM_TIMING_VSYNC		BIT(0)
> +#define
> DPU_REST_INT_BITS			(DPU_INT_FRM_TIMING_CFG_EOF | \
> +					=09
> DPU_INT_FRM_TIMING_CFG_LINE | \
> +					=09
> DPU_INT_FRM_TIMING_EOF | \
> +					=09
> DPU_INT_CMDLIST_CH_FRM_CFG_DONE)
> +
> +#endif
> diff --git a/drivers/gpu/drm/spacemit/dpu/saturn_regs/reg_map_hee.h
> b/drivers/gpu/drm/spacemit/dpu/saturn_regs/reg_map_hee.h
> new file mode 100644
> index 0000000000000..9490021cdb918
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/saturn_regs/reg_map_hee.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
> + *
> + */
> +
> +#ifndef _SATURN_REG_MAP_hee_H_
> +#define _SATURN_REG_MAP_hee_H_
> +
> +#include "dpu_int.h"
> +
> +/* Base address, then bit definitions */
> +
> +#define DPU_TOP_BASE_ADDR 0x0
> +#define DPU_CTRL_BASE_ADDR 0x3c0 /* dpu_ctl_top start address */
> +#define CMDLIST_BASE_ADDR 0x500
> +#define DPU_INT_BASE_ADDR 0x700
> +
> +#define DPU_ONLINE_IRQ_MSK	(3 * 4)
> +#define DPU_ONLINE_IRQ_STS	(12 * 4)
> +
> +#define DMA_TOP_BASE_ADDR (RDMA0_BASE_ADDR + 0x280)
> +
> +#define RDMA0_BASE_ADDR (0x00001000)
> +#define RDMA1_BASE_ADDR (RDMA0_BASE_ADDR + 0x1000)
> +#define RDMA2_BASE_ADDR (RDMA0_BASE_ADDR + 0xa000)
> +#define RDMA3_BASE_ADDR (RDMA0_BASE_ADDR + 0xb000)
> +
> +#define MMU_BASE_ADDR (0x1100)
> +#define MMU_TOP_BASE_ADDR (MMU_BASE_ADDR + 0x100)
> +
> +#define TBU0_ADDR 0x1100
> +#define TBU1_ADDR 0x1180
> +#define TBU2_ADDR 0x2100
> +#define TBU3_ADDR 0x2180
> +#define TBU4_ADDR 0xb100
> +#define TBU5_ADDR 0xb180
> +#define TBU6_ADDR 0xc100
> +#define TBU7_ADDR 0xc180
> +
> +#define CMP0_BASE_ADDR 0x00018000
> +#define CMP1_BASE_ADDR (CMP0_BASE_ADDR + 0x18000)
> +#define CMP2_BASE_ADDR (CMP0_BASE_ADDR + 0x30000)
> +
> +#define PREPIPE_SCAL0_BASE_ADDR 0x14000
> +#define PREPIPE_SCAL1_BASE_ADDR 0x14400
> +#define PREPIPE_SCAL2_BASE_ADDR 0x14800
> +#define PREPIPE_SCAL3_BASE_ADDR 0x14c00
> +
> +#define POST_PIPE_ADDR (CMP1_BASE_ADDR + 0x300)
> +
> +#define EE_ADDR (CMP1_BASE_ADDR + 0xd00)
> +
> +#define DPU_SCENE_CTL_BASE_ADDR (0x300)
> +#define DPU_SCENE_CTL_SIZE 0x40
> +#define DPU_SCENE_CTL_ADDR(i) (DPU_SCENE_CTL_BASE_ADDR + (i) *
> DPU_SCENE_CTL_SIZE)
> +
> +#define TMG0_BASE_ADDR (0x00051000 + 0x200)
> +
> +#define CMDLIST_CH_Y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x188
> +#define CMDLIST_CH_START_CMPS_Y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x90
> +#define CMDLIST_CFG_READY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x34
> +
> +#endif
> diff --git a/drivers/gpu/drm/spacemit/dpu/saturn_regs/saturn_fields.h
> b/drivers/gpu/drm/spacemit/dpu/saturn_regs/saturn_fields.h
> new file mode 100644
> index 0000000000000..f745dfdaa83de
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/dpu/saturn_regs/saturn_fields.h
> @@ -0,0 +1,298 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
> + *
> + * Saturn DPU register field map: word offset and mask per field,
> consumed by
> + * the dpu_write()/dpu_read() accessors.
> + */
> +
> +#ifndef SATURN_FIELDS_H
> +#define SATURN_FIELDS_H
> +
> +#include <linux/bits.h>
> +
> +/* CMDLIST_REG: 128 x 32-bit registers */
> +#define CMDLIST_REG__NWORDS	128
> +#define
> CMDLIST_REG__cmdlist_reg_0__cmdlist_ch_start_addrl_WORD(i)	(0 + (i))
> +#define
> CMDLIST_REG__cmdlist_reg_0__cmdlist_ch_start_addrl_MASK	GENMASK(31,
> 4)
> +#define
> CMDLIST_REG__cmdlist_reg_16__cmdlist_ch_start_addrh_WORD(i)	(16 +
> (i))
> +#define
> CMDLIST_REG__cmdlist_reg_16__cmdlist_ch_start_addrh_MASK	GENMASK(5,
> 0)
> +#define
> CMDLIST_REG__cmdlist_reg_48__cmdlist_ch_y_first_WORD(i)	(48 + (i))
> +#define
> CMDLIST_REG__cmdlist_reg_48__cmdlist_ch_y_first_MASK	GENMASK(24, 12)
> +
> +/* CMPS_X_REG: 146 x 32-bit registers */
> +#define CMPS_X_REG__NWORDS	146
> +#define CMPS_X_REG__module_enable_WORD	0
> +#define CMPS_X_REG__module_enable_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__dst_w_WORD	1
> +#define CMPS_X_REG__dst_w_MASK	GENMASK(15, 0)
> +#define CMPS_X_REG__dst_h_WORD	1
> +#define CMPS_X_REG__dst_h_MASK	GENMASK(31, 16)
> +#define CMPS_X_REG__bg_color_r_WORD	2
> +#define CMPS_X_REG__bg_color_r_MASK	GENMASK(9, 0)
> +#define CMPS_X_REG__bg_color_g_WORD	3
> +#define CMPS_X_REG__bg_color_g_MASK	GENMASK(9, 0)
> +#define CMPS_X_REG__bg_color_b_WORD	4
> +#define CMPS_X_REG__bg_color_b_MASK	GENMASK(9, 0)
> +#define CMPS_X_REG__bg_color_a_WORD	5
> +#define CMPS_X_REG__bg_color_a_MASK	GENMASK(7, 0)
> +#define CMPS_X_REG__layer00_area_left_WORD	8
> +#define CMPS_X_REG__layer00_area_left_MASK	GENMASK(15, 0)
> +#define CMPS_X_REG__layer00_area_right_WORD	8
> +#define CMPS_X_REG__layer00_area_right_MASK	GENMASK(31, 16)
> +#define CMPS_X_REG__layer00_area_top_WORD	9
> +#define CMPS_X_REG__layer00_area_top_MASK	GENMASK(15, 0)
> +#define CMPS_X_REG__layer00_area_bottom_WORD	9
> +#define CMPS_X_REG__layer00_area_bottom_MASK	GENMASK(31, 16)
> +#define CMPS_X_REG__layer00_solid_color_r_WORD	10
> +#define CMPS_X_REG__layer00_solid_color_r_MASK	GENMASK(9, 0)
> +#define CMPS_X_REG__layer00_solid_color_g_WORD	11
> +#define CMPS_X_REG__layer00_solid_color_g_MASK	GENMASK(9, 0)
> +#define CMPS_X_REG__layer00_solid_color_b_WORD	12
> +#define CMPS_X_REG__layer00_solid_color_b_MASK	GENMASK(9, 0)
> +#define CMPS_X_REG__layer00_solid_color_a_WORD	13
> +#define CMPS_X_REG__layer00_solid_color_a_MASK	GENMASK(7, 0)
> +#define CMPS_X_REG__layer00_blend_mode_WORD	13
> +#define CMPS_X_REG__layer00_blend_mode_MASK	GENMASK(15, 14)
> +#define CMPS_X_REG__layer00_colorkey_en_WORD	13
> +#define CMPS_X_REG__layer00_colorkey_en_MASK	GENMASK(18, 18)
> +#define CMPS_X_REG__layer00_en_WORD	14
> +#define CMPS_X_REG__layer00_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer00_blend_sel_WORD	14
> +#define CMPS_X_REG__layer00_blend_sel_MASK	GENMASK(2, 1)
> +#define CMPS_X_REG__layer00_solid_en_WORD	14
> +#define CMPS_X_REG__layer00_solid_en_MASK	GENMASK(3, 3)
> +#define CMPS_X_REG__layer00_dma_id_WORD	14
> +#define CMPS_X_REG__layer00_dma_id_MASK	GENMASK(7, 4)
> +#define CMPS_X_REG__layer00_layer_alpha_WORD	14
> +#define CMPS_X_REG__layer00_layer_alpha_MASK	GENMASK(15, 8)
> +#define CMPS_X_REG__layer00_alpha_ratio_WORD	14
> +#define CMPS_X_REG__layer00_alpha_ratio_MASK	GENMASK(23, 16)
> +#define CMPS_X_REG__layer01_en_WORD	21
> +#define CMPS_X_REG__layer01_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer02_en_WORD	28
> +#define CMPS_X_REG__layer02_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer03_en_WORD	35
> +#define CMPS_X_REG__layer03_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer04_en_WORD	42
> +#define CMPS_X_REG__layer04_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer05_en_WORD	49
> +#define CMPS_X_REG__layer05_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer06_en_WORD	56
> +#define CMPS_X_REG__layer06_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer07_en_WORD	63
> +#define CMPS_X_REG__layer07_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer08_en_WORD	70
> +#define CMPS_X_REG__layer08_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer09_en_WORD	77
> +#define CMPS_X_REG__layer09_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer10_en_WORD	84
> +#define CMPS_X_REG__layer10_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer11_en_WORD	91
> +#define CMPS_X_REG__layer11_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer12_en_WORD	98
> +#define CMPS_X_REG__layer12_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer13_en_WORD	105
> +#define CMPS_X_REG__layer13_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer14_en_WORD	112
> +#define CMPS_X_REG__layer14_en_MASK	GENMASK(0, 0)
> +#define CMPS_X_REG__layer15_en_WORD	119
> +#define CMPS_X_REG__layer15_en_MASK	GENMASK(0, 0)
> +
> +/* DMA_TOP_REG: 25 x 32-bit registers */
> +#define DMA_TOP_REG__NWORDS	25
> +#define DMA_TOP_REG__image_rr_ratio_WORD	1
> +#define DMA_TOP_REG__image_rr_ratio_MASK	GENMASK(7, 0)
> +#define DMA_TOP_REG__pixel_num_th_WORD	1
> +#define DMA_TOP_REG__pixel_num_th_MASK	GENMASK(14, 9)
> +#define DMA_TOP_REG__rdma_timeout_limit_WORD	2
> +#define DMA_TOP_REG__rdma_timeout_limit_MASK	GENMASK(15, 0)
> +#define DMA_TOP_REG__wdma_timeout_limit_WORD	2
> +#define DMA_TOP_REG__wdma_timeout_limit_MASK	GENMASK(31, 16)
> +
> +/* DPU_CTL_REG: 15 x 32-bit registers */
> +#define DPU_CTL_REG__NWORDS	15
> +#define DPU_CTL_REG__nml_rch_en_WORD	0
> +#define DPU_CTL_REG__nml_rch_en_MASK	GENMASK(9, 0)
> +#define DPU_CTL_REG__nml_scl_en_WORD	0
> +#define DPU_CTL_REG__nml_scl_en_MASK	GENMASK(13, 10)
> +#define DPU_CTL_REG__nml_outctl_en_WORD	0
> +#define DPU_CTL_REG__nml_outctl_en_MASK	GENMASK(18, 18)
> +#define DPU_CTL_REG__nml_frm_timing_en_WORD	0
> +#define DPU_CTL_REG__nml_frm_timing_en_MASK	GENMASK(25, 23)
> +#define DPU_CTL_REG__both_cfg_rdy_WORD	2
> +#define DPU_CTL_REG__both_cfg_rdy_MASK	GENMASK(0, 0)
> +#define DPU_CTL_REG__video_mod_WORD	3
> +#define DPU_CTL_REG__video_mod_MASK	GENMASK(0, 0)
> +#define DPU_CTL_REG__dbg_mod_WORD	3
> +#define DPU_CTL_REG__dbg_mod_MASK	GENMASK(1, 1)
> +#define DPU_CTL_REG__timing_inter0_WORD	3
> +#define DPU_CTL_REG__timing_inter0_MASK	GENMASK(7, 2)
> +#define DPU_CTL_REG__timing_inter1_WORD	3
> +#define DPU_CTL_REG__timing_inter1_MASK	GENMASK(13, 8)
> +#define DPU_CTL_REG__sw_start_WORD	4
> +#define DPU_CTL_REG__sw_start_MASK	GENMASK(0, 0)
> +#define DPU_CTL_REG__nml_rch_vrt_reuse_WORD	7
> +#define DPU_CTL_REG__nml_rch_vrt_reuse_MASK	GENMASK(9, 0)
> +
> +/* DPU_CTL_TOP_REG: 53 x 32-bit registers */
> +#define DPU_CTL_TOP_REG__NWORDS	53
> +#define
> DPU_CTL_TOP_REG__dpu_ctl_top_reg_0__cmdlist_rch_en_WORD(i)	(0 + (i))
> +#define
> DPU_CTL_TOP_REG__dpu_ctl_top_reg_0__cmdlist_rch_en_MASK	GENMASK(0, 0)
> +#define
> DPU_CTL_TOP_REG__dpu_ctl_top_reg_10__cmdlist_cmps_other_en_WORD(i)
> 	(10 + (i))
> +#define
> DPU_CTL_TOP_REG__dpu_ctl_top_reg_10__cmdlist_cmps_other_en_MASK	GENM
> ASK(0, 0)
> +#define
> DPU_CTL_TOP_REG__dpu_ctl_top_reg_10__cmdlist_cmps_top_en_WORD(i)
> 	(10 + (i))
> +#define
> DPU_CTL_TOP_REG__dpu_ctl_top_reg_10__cmdlist_cmps_top_en_MASK	GENM
> ASK(1, 1)
> +
> +/* DPU_INTP_REG: 50 x 32-bit registers */
> +#define DPU_INTP_REG__NWORDS	50
> +
> +/* EE_REG: 51 x 32-bit registers */
> +#define EE_REG__NWORDS	51
> +#define EE_REG__m_benable_WORD	0
> +#define EE_REG__m_benable_MASK	GENMASK(0, 0)
> +
> +/* MMU_TBU_REG: 21 x 32-bit registers */
> +#define MMU_TBU_REG__NWORDS	21
> +#define MMU_TBU_REG__tbu_base_addr0_low_WORD	1
> +#define MMU_TBU_REG__tbu_base_addr0_low_MASK	GENMASK(31, 0)
> +#define MMU_TBU_REG__tbu_base_addr0_high_WORD	2
> +#define MMU_TBU_REG__tbu_base_addr0_high_MASK	GENMASK(11, 0)
> +#define MMU_TBU_REG__tbu_base_addr1_low_WORD	3
> +#define MMU_TBU_REG__tbu_base_addr1_low_MASK	GENMASK(31, 0)
> +#define MMU_TBU_REG__tbu_base_addr1_high_WORD	4
> +#define MMU_TBU_REG__tbu_base_addr1_high_MASK	GENMASK(11, 0)
> +#define MMU_TBU_REG__tbu_base_addr2_low_WORD	5
> +#define MMU_TBU_REG__tbu_base_addr2_low_MASK	GENMASK(31, 0)
> +#define MMU_TBU_REG__tbu_base_addr2_high_WORD	6
> +#define MMU_TBU_REG__tbu_base_addr2_high_MASK	GENMASK(11, 0)
> +#define MMU_TBU_REG__tbu_va0_WORD	7
> +#define MMU_TBU_REG__tbu_va0_MASK	GENMASK(31, 0)
> +#define MMU_TBU_REG__tbu_va1_WORD	8
> +#define MMU_TBU_REG__tbu_va1_MASK	GENMASK(31, 0)
> +#define MMU_TBU_REG__tbu_va2_WORD	9
> +#define MMU_TBU_REG__tbu_va2_MASK	GENMASK(31, 0)
> +#define MMU_TBU_REG__tbu_size0_WORD	10
> +#define MMU_TBU_REG__tbu_size0_MASK	GENMASK(15, 0)
> +#define MMU_TBU_REG__tbu_size1_WORD	11
> +#define MMU_TBU_REG__tbu_size1_MASK	GENMASK(15, 0)
> +#define MMU_TBU_REG__tbu_size2_WORD	12
> +#define MMU_TBU_REG__tbu_size2_MASK	GENMASK(15, 0)
> +#define MMU_TBU_REG__vsync_update_en_WORD	13
> +#define MMU_TBU_REG__vsync_update_en_MASK	GENMASK(1, 1)
> +
> +/* MMU_TOP_REG: 23 x 32-bit registers */
> +#define MMU_TOP_REG__NWORDS	23
> +#define MMU_TOP_REG__rdma_timelimit_WORD	0
> +#define MMU_TOP_REG__rdma_timelimit_MASK	GENMASK(31, 16)
> +#define MMU_TOP_REG__sram0_tlb_axi_port_sel_WORD	1
> +#define MMU_TOP_REG__sram0_tlb_axi_port_sel_MASK	GENMASK(1,
> 0)
> +#define MMU_TOP_REG__sram1_tlb_axi_port_sel_WORD	1
> +#define MMU_TOP_REG__sram1_tlb_axi_port_sel_MASK	GENMASK(3,
> 2)
> +#define MMU_TOP_REG__dmac0_rd_outs_num_WORD	2
> +#define MMU_TOP_REG__dmac0_rd_outs_num_MASK	GENMASK(7, 0)
> +#define MMU_TOP_REG__dmac1_rd_outs_num_WORD	3
> +#define MMU_TOP_REG__dmac1_rd_outs_num_MASK	GENMASK(7, 0)
> +
> +/* POSTPIPE_REG: 50 x 32-bit registers */
> +#define POSTPIPE_REG__NWORDS	50
> +#define POSTPIPE_REG__m_inwidth_WORD	13
> +#define POSTPIPE_REG__m_inwidth_MASK	GENMASK(15, 0)
> +#define POSTPIPE_REG__m_inheight_WORD	13
> +#define POSTPIPE_REG__m_inheight_MASK	GENMASK(31, 16)
> +
> +/* RDMA_PATH_X_REG: 60 x 32-bit registers */
> +#define RDMA_PATH_X_REG__NWORDS	60
> +#define RDMA_PATH_X_REG__layer_mode_WORD	0
> +#define RDMA_PATH_X_REG__layer_mode_MASK	GENMASK(1, 0)
> +#define RDMA_PATH_X_REG__layer_cmpsr_id_WORD	0
> +#define RDMA_PATH_X_REG__layer_cmpsr_id_MASK	GENMASK(15, 13)
> +#define RDMA_PATH_X_REG__is_two_layers_WORD	1
> +#define RDMA_PATH_X_REG__is_two_layers_MASK	GENMASK(0, 0)
> +#define RDMA_PATH_X_REG__is_offline_WORD	1
> +#define RDMA_PATH_X_REG__is_offline_MASK	GENMASK(1, 1)
> +#define RDMA_PATH_X_REG__base_addr0_low_ly0_WORD	9
> +#define RDMA_PATH_X_REG__base_addr0_low_ly0_MASK	GENMASK(31,
> 0)
> +#define RDMA_PATH_X_REG__base_addr0_high_ly0_WORD	10
> +#define RDMA_PATH_X_REG__base_addr0_high_ly0_MASK	GENMASK(1,
> 0)
> +#define RDMA_PATH_X_REG__base_addr1_low_ly0_WORD	11
> +#define RDMA_PATH_X_REG__base_addr1_low_ly0_MASK	GENMASK(31,
> 0)
> +#define RDMA_PATH_X_REG__base_addr1_high_ly0_WORD	12
> +#define RDMA_PATH_X_REG__base_addr1_high_ly0_MASK	GENMASK(1,
> 0)
> +#define RDMA_PATH_X_REG__base_addr2_low_ly0_WORD	13
> +#define RDMA_PATH_X_REG__base_addr2_low_ly0_MASK	GENMASK(31,
> 0)
> +#define RDMA_PATH_X_REG__base_addr2_high_ly0_WORD	14
> +#define RDMA_PATH_X_REG__base_addr2_high_ly0_MASK	GENMASK(1,
> 0)
> +#define RDMA_PATH_X_REG__rdma_stride0_layer0_WORD	15
> +#define RDMA_PATH_X_REG__rdma_stride0_layer0_MASK	GENMASK(15,
> 0)
> +#define RDMA_PATH_X_REG__rdma_stride1_layer0_WORD	15
> +#define RDMA_PATH_X_REG__rdma_stride1_layer0_MASK	GENMASK(31,
> 16)
> +#define RDMA_PATH_X_REG__img_width_ly0_WORD	16
> +#define RDMA_PATH_X_REG__img_width_ly0_MASK	GENMASK(15, 0)
> +#define RDMA_PATH_X_REG__img_height_ly0_WORD	16
> +#define RDMA_PATH_X_REG__img_height_ly0_MASK	GENMASK(31, 16)
> +#define RDMA_PATH_X_REG__bbox_start_x_ly0_WORD	17
> +#define RDMA_PATH_X_REG__bbox_start_x_ly0_MASK	GENMASK(15, 0)
> +#define RDMA_PATH_X_REG__bbox_start_y_ly0_WORD	17
> +#define RDMA_PATH_X_REG__bbox_start_y_ly0_MASK	GENMASK(31, 16)
> +#define RDMA_PATH_X_REG__bbox_end_x_ly0_WORD	18
> +#define RDMA_PATH_X_REG__bbox_end_x_ly0_MASK	GENMASK(15, 0)
> +#define RDMA_PATH_X_REG__bbox_end_y_ly0_WORD	18
> +#define RDMA_PATH_X_REG__bbox_end_y_ly0_MASK	GENMASK(31, 16)
> +#define RDMA_PATH_X_REG__pixel_format_WORD	29
> +#define RDMA_PATH_X_REG__pixel_format_MASK	GENMASK(5, 0)
> +#define RDMA_PATH_X_REG__uv_swap_WORD	29
> +#define RDMA_PATH_X_REG__uv_swap_MASK	GENMASK(6, 6)
> +#define RDMA_PATH_X_REG__rot_mode_ly0_WORD	29
> +#define RDMA_PATH_X_REG__rot_mode_ly0_MASK	GENMASK(10, 8)
> +
> +/* TMG_REG: 30 x 32-bit registers */
> +#define TMG_REG__NWORDS	30
> +#define TMG_REG__split_en_WORD	0
> +#define TMG_REG__split_en_MASK	GENMASK(0, 0)
> +#define TMG_REG__cmd_screen_WORD	0
> +#define TMG_REG__cmd_screen_MASK	GENMASK(1, 1)
> +#define TMG_REG__fm_timing_en_WORD	0
> +#define TMG_REG__fm_timing_en_MASK	GENMASK(2, 2)
> +#define TMG_REG__cmd_wait_en_WORD	0
> +#define TMG_REG__cmd_wait_en_MASK	GENMASK(3, 3)
> +#define TMG_REG__cmd_wait_te_WORD	0
> +#define TMG_REG__cmd_wait_te_MASK	GENMASK(4, 4)
> +#define TMG_REG__disp_ready_man_en_WORD	0
> +#define TMG_REG__disp_ready_man_en_MASK	GENMASK(5, 5)
> +#define TMG_REG__hsp_WORD	0
> +#define TMG_REG__hsp_MASK	GENMASK(7, 7)
> +#define TMG_REG__vsp_WORD	0
> +#define TMG_REG__vsp_MASK	GENMASK(8, 8)
> +#define TMG_REG__user_WORD	2
> +#define TMG_REG__user_MASK	GENMASK(15, 12)
> +#define TMG_REG__hfp_WORD	3
> +#define TMG_REG__hfp_MASK	GENMASK(27, 16)
> +#define TMG_REG__hsync_width_WORD	4
> +#define TMG_REG__hsync_width_MASK	GENMASK(9, 0)
> +#define TMG_REG__hbp_WORD	4
> +#define TMG_REG__hbp_MASK	GENMASK(27, 16)
> +#define TMG_REG__vfp_WORD	5
> +#define TMG_REG__vfp_MASK	GENMASK(15, 0)
> +#define TMG_REG__vsync_width_WORD	5
> +#define TMG_REG__vsync_width_MASK	GENMASK(25, 16)
> +#define TMG_REG__vbp_WORD	6
> +#define TMG_REG__vbp_MASK	GENMASK(11, 0)
> +#define TMG_REG__h_active_WORD	6
> +#define TMG_REG__h_active_MASK	GENMASK(29, 16)
> +#define TMG_REG__v_active_WORD	7
> +#define TMG_REG__v_active_MASK	GENMASK(13, 0)
> +#define TMG_REG__background_r_WORD	9
> +#define TMG_REG__background_r_MASK	GENMASK(11, 0)
> +#define TMG_REG__background_g_WORD	9
> +#define TMG_REG__background_g_MASK	GENMASK(27, 16)
> +#define TMG_REG__background_b_WORD	10
> +#define TMG_REG__background_b_MASK	GENMASK(11, 0)
> +#define TMG_REG__eof_1st_ln_dly_num_WORD	11
> +#define TMG_REG__eof_1st_ln_dly_num_MASK	GENMASK(15, 0)
> +#define TMG_REG__eof_2nd_ln_dly_num_WORD	11
> +#define TMG_REG__eof_2nd_ln_dly_num_MASK	GENMASK(31, 16)
> +#define TMG_REG__sof_pre_ln_num_WORD	14
> +#define TMG_REG__sof_pre_ln_num_MASK	GENMASK(16, 0)
> +
> +#endif /* SATURN_FIELDS_H */
> diff --git a/drivers/gpu/drm/spacemit/spacemit_dpu_ids.h
> b/drivers/gpu/drm/spacemit/spacemit_dpu_ids.h
> new file mode 100644
> index 0000000000000..41014dda927b9
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_dpu_ids.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
> + */
> +
> +#ifndef _SPACEMIT_DPU_IDS_H_
> +#define _SPACEMIT_DPU_IDS_H_
> +
> +/* Saturn online compositor instance ids (hardware IRQ-table
> indices). */
> +#define COMPOSER0	0
> +#define COMPOSER1	1
> +#define COMPOSER2	2
> +#define COMPOSER3	3
> +
> +/* DPU output-format field encoding (dpuctrl out-format register).
> */
> +#define OUTFMT_RGB121212	0
> +#define OUTFMT_RGB101010	1
> +#define OUTFMT_RGB888		2
> +#define OUTFMT_RGB666		12
> +#define OUTFMT_RGB565		13
> +
> +#endif /* _SPACEMIT_DPU_IDS_H_ */
