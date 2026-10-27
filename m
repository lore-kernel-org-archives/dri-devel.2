Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE1606A326
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FNGxog26;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F2C3gU9Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F2510F3E6;
	Tue, 27 Oct 2026 11:06:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD63510F3DE
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:06:42 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAe3VR2524812
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YAs9yE3ryxQ6Hl63Kw+ENBo0
 qX1XTY4t+VA6gDiBjWc=; b=FNGxog26mwWdehEENsBbB7Oh3lx2xg6xTtvNckj7
 t5xNvF21EAv5y/mrOzf7MPaotkf7OeBeTKZ7KktncNEk8HEJagbOUpflq8Hj8urx
 JjzUSufgbUzhqPQ3vr6WE6zY8ip16rYLar0Y31lJNxCRVPHPC9QzHXrXutahGEJj
 0GU2fEzQP4567PSLaDIv2KA2IAdK8GqifFDnLMJD+XhJKP6X7GVQJ/LJUNZgQBat
 djrJDkQoYiRc9mSFqpOEbU0OLW0IPP1HnOlRIh2HqEf2NTe0MnALNuQyl94Q940S
 pyxFVhqhcvjRQCEwaQA3KiGqE66UKxQtQ53WPegLParnSw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw20rhn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:06:41 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-990ca9607c3so2594498241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793099201; x=1793704001;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YAs9yE3ryxQ6Hl63Kw+ENBo0qX1XTY4t+VA6gDiBjWc=;
 b=F2C3gU9YtfSewo1xW9b/2s87IuqrwrmTwI0/9qN9dr/PR087oGznkfjUjwFZXi4E9U
 zKIi6DHLfLhCB9mKFOfRXg4CafGXIWEmlhcisvhn1eQS+MPIxU9QzfEz/l8SQeB24fgV
 Ngb2lH4zxHn2E3Tw6xlOboBhUXr5pw9uqOcdHw9KP/jfZi3K6Ibw2Xfp62gSKlGr5aEV
 IBRFWYj649gXGadotP6JseJZPBibEWh7xvHzGJtO7iZKGrDAkV0Wuu05rSlmlL+K4lLI
 cr9yZSllULQwtQF8bkKCzdp1A7vBxM2RfgpsY1nw2OUfseV5apbx21bH0+n/l/0jKGdc
 klAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099201; x=1793704001;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YAs9yE3ryxQ6Hl63Kw+ENBo0qX1XTY4t+VA6gDiBjWc=;
 b=lllYTCsyl15F1COYapxxJceOoFKbUx12VumN2Os1UOPkvoTbbqnQUODY6K3U12M7ol
 JePuIS4ttTPlEsbeK5Fasfv6Nql01+uuPUXBkliF14qVlZiTxp7BoZ4Ir3koVJ9zApS3
 Gez+rKqaTkbKjBTcXS9vRdGB7BlwyCzAPeAN/8GygqHizIGlzm+hpKg6iVWRdWL4aAHR
 bK/mgAwPkJWueWKECPBvVbam0UQJwJZ6chR/fMpxHE0YB5LXMZMJAyBjpTHtDs9GRFX4
 qKLW44yYwZ0WClP19HizIOw10djb7u6aQkjUB/MuFxP3lIMR91t835ImyFY9ANwR/kL5
 Zd4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6aHJjhAikDO2MgtskwP0PLXYmHPAsrItk/yI124aBm5tEMHTgGF866vq+6UFcPGJt9jMbnZXx8JM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLGNr1rS0lTtQf0FSjD4hBC272gUwfIthrRHwbGhB9PKCzfMYrr
 Y+md6pVOe+qdau9+ilZ6OSV769zj5GVKUku/R9YN3dQ7DQfgLhkbD59rcnGeiQMzMW7BRK7sgoo
 oVAqND1k479v6m+0db7Db2Rqg86KDkr1/qdj52LYewVdlkvlOxOnOMbKWIMTN/VcoYxyMel8=
X-Gm-Gg: AYBFou1SSg8cn+3n2DPp7M/gcJelkWoouRBwuBsuLdHnOg1QdiSuxa0zVxMfuyGGFjW
 RC64UqLCHSfcVl1Wb4gwPkN5tJpgqwzFVpVftuSG3+iy6M8Nb6ELK7RIGGMCYWjYu92C1F7Q4Fv
 iQYIHxOrwTCtuV8Josqg2jOFFS7h/XOC6zKmR+utb0b3XJ67YZU6arlU+FHf8ewnclQ+jZh61id
 Ki/0/UY1L0Cc/bgl31OFflNWxPGaCkai4l8v8LOzSWTD+v6Tnx/bfk7l5+qybx80ZMkrAuY70K1
 jtB0zfDAVWG1t9JjklTu+KdJRmQJTYKKlYa9Oft3GEf/CAnLmdvZJeem64yFrlgAVCa1zyF/paH
 MA4j/+IMbtvZgveJ8AaG/NY2Li8ZBHvS7ej14per6sTplena5jgKfmA/AL1DPBci71pQesepqln
 y176+Z+ye2MF9i
X-Received: by 2002:a05:6102:50a4:b0:7b3:32fe:77b6 with SMTP id
 ada2fe7eead31-7ce5ca0ccd2mr3572992137.3.1793099200661; 
 Tue, 27 Oct 2026 04:06:40 -0700 (PDT)
X-Received: by 2002:a05:6102:50a4:b0:7b3:32fe:77b6 with SMTP id
 ada2fe7eead31-7ce5ca0ccd2mr3572974137.3.1793099200096; 
 Tue, 27 Oct 2026 04:06:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a4csm25383871fa.25.2026.10.27.04.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:06:39 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:06:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 10/23] drm/msm/dcp: Add HFI DSI and panel commands
Message-ID: <ebhoujzyf4fn5v3gfmgrskjw646d2e7l5b3yr4pyq2wh4vrclq@5a6vx4zx55w3>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-10-7cf014efdee1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-10-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfXyRUB96A0ufzZ
 9rWC55H9lrjIhgx1ZnobqouFLT4VsnKDHxLVzyCqNF+0VE3WpyILq/RT9bYyyoGM/davcOPDRg2
 8HHuw/AR7JjmZ3Iw81Y2AWgtTkC/SowXDpN/pItqE5hK1DLpq5HuU6QqYOQwqSqbd6S19PL6Ubj
 nBgK7JIW+pEVm7NUVq7+KR1SW+XJbBDQFTAJOi49dpkjrlLd8Sk9ZTiSt/fDIthTK4HLXQ5wz1H
 FOHjkDIAjkM1eBESjVehB9sdLGOfcA1/4ate+6qBGo8wDbzukWHBfI9EG5+GInY3NKOUSeWieOT
 HleK8kpReQOpAnICvnlMnzd9sW4N2FBa//RTFC44MAMGFweKS/57UZAm68F7q7nfVbL57ZlmlgN
 yAKCHDzDEJhLPnlVvwzMjz0+quuScALdqaIXYCNvx52LCv3GqHIeZaqGQybVc5eZwxTwm1mzcrC
 jgg65JMtbqi0jqJTl1Q==
X-Proofpoint-GUID: W0BfYfkSKmYes4Wry0-IIWIDi917x_5i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfX2AwZ7MwMqRXD
 BPYUK95AUOvAkXTImYD+Gsf4sB6U6atb7jP0tJPtkJNyl+76oHotCse49Jyy9s439nlPoj+U+ec
 7iJSgmTuMIz41SPBImDiJjBuxBSyOsU=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae085c1 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=XOpGMaQh1TDZy5n8wDsA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: W0BfYfkSKmYes4Wry0-IIWIDi917x_5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270044
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:51:20AM +0530, Jayant Shekhar wrote:
> Translate DSI host and panel operations into HFI commands. Firmware
> owns the DSI hardware, so mode validation, display power, panel setup,
> and DCS transfers must cross the HFI interface instead of accessing
> controller registers from Linux.
> 
> Implement DSI mode validation, display session and power management,
> panel initialization, and DCS transfer helpers while keeping them
> separate from generic display commands.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile                |   2 +
>  drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h     |  81 ++++
>  drivers/gpu/drm/msm/dcp/dcp_hfi.h           |  25 ++
>  drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c       | 252 ++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c | 592 ++++++++++++++++++++++++++++

Please stop calling it a panel. There can be any bridge after the DSI
device. From the Linux point of view, drm_panel is a subclass of
drm_bridge.

>  5 files changed, 952 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index bdc5e3b8efa7..77c268aabca6 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -74,6 +74,8 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
>  msm-display-$(CONFIG_DRM_MSM_DCP) += \
>  	dcp/dcp_hfi_core.o \
>  	dcp/dcp_hfi_crtc.o \
> +	dcp/dcp_hfi_dsi.o \
> +	dcp/dcp_hfi_dsi_panel.o \
>  	dcp/dcp_hfi_encoder.o \
>  	dcp/dcp_hfi_kms.o \
>  	dcp/dcp_hfi_plane.o \
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
> new file mode 100644
> index 000000000000..a8898e469b44
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP DSI panel configuration shared by the HFI panel implementation and

What if there is a DSI2DPI or DSI2LVDS bridge and then DPI or LVDS
panel?

> + * the DRM DSI bridge.
> + */
> +
> +#ifndef __DCP_DSI_PANEL_H__
> +#define __DCP_DSI_PANEL_H__
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/sizes.h>
> +#include <linux/types.h>
> +
> +#define DCP_DSI_MAX_PHY_TIMINGS	32
> +
> +/**
> + * struct dcp_dsi_hfi_panel_config - Complete HFI PANEL_INIT configuration.
> + *
> + * This contains the bridge-owned panel configuration plus the
> + * mode-dependent values assembled before the HFI PANEL_INIT command.
> + */
> +struct dcp_dsi_hfi_panel_config {
> +	u32 display_type;
> +	u32 num_ctrls;
> +	u32 ctrl_indices[4];
> +	u32 num_phys;
> +	u32 phy_indices[4];
> +	u32 vsync_source;
> +	u32 te_dcs_command;
> +	u32 dma_trigger;
> +	u32 stream_trigger;
> +	u32 wr_mem_start;
> +	u32 wr_mem_continue;
> +	u32 dma_sched_line;
> +	u32 dma_sched_window;
> +	u32 phy_type;
> +	bool cphy_mode;
> +	bool lp11_init;
> +	bool ulps_supported;
> +	bool bllp_eof_power_mode;
> +	bool bllp_power_mode;
> +	u32 lane_map;
> +	u32 color_order;
> +	u32 esd_mode;
> +	u32 jitter_numer;
> +	u32 jitter_denom;
> +	dma_addr_t dcs_tx_dva;
> +	dma_addr_t dcs_tx_iova;
> +	u32 dcs_tx_buf_size;
> +	u32 phy_timings[DCP_DSI_MAX_PHY_TIMINGS];
> +	u32 num_phy_timings;
> +	bool dsc_enabled;
> +	u32 dsc_version_major;
> +	u32 dsc_version_minor;
> +	u32 dsc_scr_version;
> +	u32 dsc_slice_height;
> +	u32 dsc_slice_width;
> +	u32 dsc_slices_per_pkt;
> +	u32 dsc_bits_per_component;
> +	u32 dsc_pps_delay_ms;
> +	u32 dsc_bits_per_pixel;
> +	u32 dsc_chroma_format;
> +	u32 dsc_color_space;
> +	u32 dsc_block_prediction_enable;

Why do you need to copy those? Can't you use struct drm_dsc directly?
Having it as a non-NULL pointer would have saved you from having
the dsc_enabled flag.

> +	/* Optional DSC rate-control override panel configuration. */
> +	bool dsc_rc_override;
> +	u8 dsc_rc_min_qp[15];
> +	u8 dsc_rc_max_qp[15];
> +	u8 dsc_rc_bpg_offsets[15];
> +	u32 topology_mixer_count;
> +	u32 topology_enc_count;
> +	u32 topology_intf_count;
> +};
> +
> +/* DCS buffers use IOVAs directly in the firmware command descriptor. */
> +#define DCP_DSI_DCS_TX_BUF_SIZE	SZ_4K
> +#define DCP_DSI_DCS_RX_BUF_SIZE	SZ_4K
> +
> +#endif /* __DCP_DSI_PANEL_H__ */
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi.h b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
> index 6d3eadb5e811..88d73de69383 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_hfi.h
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
> @@ -242,6 +242,31 @@ int dcp_hfi_send_resource_register(struct dcp_hfi *hfi);
>  int dcp_hfi_set_display_property(struct dcp_hfi *hfi, u32 session_id,
>  				 u32 prop_id, u32 value);
>  
> +struct dcp_dsi_hfi_panel_config;
> +int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
> +		       const struct drm_display_mode *mode,
> +		       const struct mipi_dsi_device *dsi,
> +		       const struct dcp_dsi_hfi_panel_config *cfg);
> +int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx,
> +			   u32 display_id, u32 *session_id);
> +int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id);
> +int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
> +				  const struct drm_display_mode *mode,
> +				  u64 clk_rate_hz);
> +int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
> +			     const struct drm_display_mode *mode,
> +			     u64 clk_rate_hz);
> +int dcp_hfi_display_power_register(struct dcp_hfi *hfi, u32 session_id);
> +int dcp_hfi_display_power_control_ack(struct dcp_hfi *hfi, u32 session_id,
> +				      u32 packet_id);
> +int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id);
> +int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id);
> +int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id);
> +ssize_t dcp_hfi_dcs_transfer(struct dcp_hfi *hfi, u32 session_id,
> +			     const struct mipi_dsi_msg *msg,
> +			     void *tx_buf, dma_addr_t tx_iova,
> +			     void *rx_buf, dma_addr_t rx_iova,
> +			     u32 post_wait_ms, u32 ctrl_idx);
>  #endif /* __DCP_HFI_H__ */
>  void dcp_hfi_set_power_control_cb(struct dcp_hfi *hfi, void *priv,
>  				  void (*cb)(void *priv, u32 display_id,
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
> new file mode 100644
> index 000000000000..fbeec03cf90d
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * HFI commands for the DSI display-session lifecycle.
> + * Panel initialization and DCS transfers are implemented in dcp_hfi_dsi_panel.c.
> + */
> +
> +#include <linux/device.h>
> +#include <drm/drm_modes.h>
> +
> +#include "dcp_hfi.h"
> +#include "dcp_hfi_priv.h"
> +#include "hfi/hfi_commands_display.h"
> +#include "hfi/hfi_defs_common.h"
> +#include "hfi/hfi_defs_display.h"
> +#include "hfi/hfi_packet.h"
> +#include "hfi/hfi_packer.h"
> +#include "hfi/hfi_properties_display.h"
> +
> +static void dcp_hfi_fill_mode_info(struct hfi_display_mode_info *info,
> +				   const struct drm_display_mode *mode)
> +{
> +	memset(info, 0, sizeof(*info));
> +	info->size            = sizeof(*info);
> +	info->h_active        = mode->hdisplay;
> +	info->h_back_porch    = mode->htotal - mode->hsync_end;
> +	info->h_sync_width    = mode->hsync_end - mode->hsync_start;
> +	info->h_front_porch   = mode->hsync_start - mode->hdisplay;
> +	info->h_skew          = mode->hskew;
> +	info->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_PHSYNC);
> +	info->v_active        = mode->vdisplay;
> +	info->v_back_porch    = mode->vtotal - mode->vsync_end;
> +	info->v_sync_width    = mode->vsync_end - mode->vsync_start;
> +	info->v_front_porch   = mode->vsync_start - mode->vdisplay;
> +	info->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_PVSYNC);
> +	info->refresh_rate    = drm_mode_vrefresh(mode);
> +	info->clk_rate_hz_lo = lower_32_bits((u64)mode->clock * 1000);
> +	info->clk_rate_hz_hi = upper_32_bits((u64)mode->clock * 1000);
> +}
> +
> +static void dcp_hfi_dump_mode_info(struct dcp_hfi *hfi, const char *cmd,
> +				   u32 session_id,
> +				   const struct hfi_display_mode_info *info)
> +{
> +	dev_dbg(hfi->dev,
> +		"HFI %s s=%u h=%u/%u/%u/%u v=%u/%u/%u/%u p=%u/%u r=%u clk=%llu sz=%u\n",
> +		cmd, session_id,
> +		info->h_active, info->h_back_porch, info->h_sync_width,
> +		info->h_front_porch,
> +		info->v_active, info->v_back_porch, info->v_sync_width,
> +		info->v_front_porch,
> +		info->h_sync_polarity, info->v_sync_polarity,
> +		info->refresh_rate,
> +		(u64)info->clk_rate_hz_lo | ((u64)info->clk_rate_hz_hi << 32),
> +		info->size);
> +}
> +
> +int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
> +				  const struct drm_display_mode *mode, u64 clk_rate_hz)
> +{
> +	struct hfi_display_mode_info info;
> +	int ret;
> +
> +	dcp_hfi_fill_mode_info(&info, mode);
> +	info.clk_rate_hz_lo = lower_32_bits(clk_rate_hz);
> +	info.clk_rate_hz_hi = upper_32_bits(clk_rate_hz);
> +	dcp_hfi_dump_mode_info(hfi, "HFI MODE_VALIDATE", session_id, &info);
> +
> +	ret = dcp_hfi_send_sync(hfi,
> +				HFI_COMMAND_DISPLAY_MODE_VALIDATE,
> +				HFI_CMD_BUFF_DISPLAY, session_id,
> +				HFI_PAYLOAD_U32_ARRAY,
> +				&info, sizeof(info),
> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				HFI_TX_FLAGS_NON_DISCARDABLE,
> +				NULL, 0,
> +				DCP_HFI_TIMEOUT_MODE_MS);
> +
> +	return ret;
> +}
> +
> +int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
> +			     const struct drm_display_mode *mode, u64 clk_rate_hz)
> +{
> +	struct hfi_display_mode_info info;
> +	int ret;
> +
> +	dcp_hfi_fill_mode_info(&info, mode);
> +	info.clk_rate_hz_lo = lower_32_bits(clk_rate_hz);
> +	info.clk_rate_hz_hi = upper_32_bits(clk_rate_hz);
> +	dcp_hfi_dump_mode_info(hfi, "HFI SET_MODE", session_id, &info);
> +
> +	ret = dcp_hfi_send_sync(hfi,
> +				HFI_COMMAND_DISPLAY_SET_MODE,
> +				HFI_CMD_BUFF_DISPLAY, session_id,
> +				HFI_PAYLOAD_U32_ARRAY,
> +				&info, sizeof(info),
> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				HFI_TX_FLAGS_NON_DISCARDABLE,
> +				NULL, 0,
> +				DCP_HFI_TIMEOUT_MODE_MS);
> +
> +	return ret;
> +}
> +
> +int dcp_hfi_display_power_register(struct dcp_hfi *hfi, u32 session_id)
> +{
> +	return dcp_hfi_send_sync(hfi,
> +				 HFI_COMMAND_DISPLAY_POWER_REGISTER,
> +				 HFI_CMD_BUFF_DISPLAY, session_id,
> +				 HFI_PAYLOAD_NONE, NULL, 0,
> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
> +				 NULL, 0,
> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
> +}
> +
> +int dcp_hfi_display_power_control_ack(struct dcp_hfi *hfi, u32 session_id,
> +				      u32 packet_id)
> +{
> +	struct dcp_hfi_buf *buf;
> +	struct hfi_cmd_buff_hdl hdl;
> +	struct hfi_header_info hdr_info;
> +	struct hfi_packet_info pkt_info;
> +	int ret;
> +
> +	buf = dcp_hfi_buf_alloc(hfi);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	hdl.cmd_buffer = buf->data;
> +	hdl.size       = DCP_HFI_BUF_SIZE;
> +
> +	hdr_info.num_packets   = 0;
> +	hdr_info.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
> +	hdr_info.object_id     = session_id;
> +	hdr_info.header_id     = dcp_hfi_next_packet_id(hfi);
> +
> +	ret = hfi_create_header(&hdl, &hdr_info);
> +	if (ret)
> +		goto err_free_buf;
> +
> +	pkt_info.cmd          = HFI_COMMAND_DISPLAY_POWER_CONTROL;
> +	pkt_info.id           = session_id & 0xFFFF;
> +	pkt_info.flags        = HFI_RX_FLAGS_SUCCESS;
> +	pkt_info.packet_id    = packet_id;
> +	pkt_info.payload_type = HFI_PAYLOAD_NONE;
> +	pkt_info.payload_size = 0;
> +	pkt_info.payload_ptr  = NULL;
> +
> +	ret = hfi_create_packet_header(&hdl, &pkt_info);
> +	if (ret)
> +		goto err_free_buf;
> +
> +	return dcp_hfi_send_cmd_async(hfi, buf, hfi_get_header_size(&hdl), NULL);
> +
> +err_free_buf:
> +	dcp_hfi_buf_free(hfi, buf);
> +	return ret;
> +}
> +
> +int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx, u32 display_id,
> +			   u32 *session_id)
> +{
> +	int ret;
> +
> +	ret = dcp_hfi_send_sync(hfi,
> +				HFI_COMMAND_DISPLAY_ENABLE,
> +				HFI_CMD_BUFF_DISPLAY, display_id,
> +				HFI_PAYLOAD_NONE, NULL, 0,
> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				HFI_TX_FLAGS_NON_DISCARDABLE,
> +				NULL, 0,
> +				DCP_HFI_TIMEOUT_DISPLAY_MS);
> +	if (ret) {
> +		dev_err(hfi->dev,
> +			"HFI DISPLAY_ENABLE intf=%u display_id=%u failed: %d\n",
> +			intf_idx, display_id, ret);
> +		return ret;
> +	}
> +
> +	*session_id = display_id;
> +
> +	return 0;
> +}
> +
> +int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id)
> +{
> +	return dcp_hfi_send_sync(hfi,
> +				 HFI_COMMAND_DISPLAY_POST_ENABLE,
> +				 HFI_CMD_BUFF_DISPLAY, session_id,
> +				 HFI_PAYLOAD_NONE, NULL, 0,
> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
> +				 NULL, 0,
> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
> +}
> +
> +int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id)
> +{
> +	return dcp_hfi_send_sync(hfi,
> +				 HFI_COMMAND_DISPLAY_DISABLE,
> +				 HFI_CMD_BUFF_DISPLAY, session_id,
> +				 HFI_PAYLOAD_NONE, NULL, 0,
> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
> +				 NULL, 0,
> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
> +}
> +
> +int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id)
> +{
> +	return dcp_hfi_send_sync(hfi,
> +				 HFI_COMMAND_DISPLAY_POST_DISABLE,
> +				 HFI_CMD_BUFF_DISPLAY, session_id,
> +				 HFI_PAYLOAD_NONE, NULL, 0,
> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
> +				 NULL, 0,
> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
> +}
> +
> +int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id)
> +{
> +	int ret;
> +
> +	ret = dcp_hfi_display_disable(hfi, session_id);
> +	if (ret) {
> +		dev_warn(hfi->dev, "HFI DISPLAY_DISABLE failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = dcp_hfi_display_post_disable(hfi, session_id);
> +	if (ret) {
> +		dev_warn(hfi->dev, "HFI DISPLAY_POST_DISABLE failed: %d\n", ret);
> +		return ret;
> +	}

Why are there two types of calls, pre and post? Should they go to the
corresponding separate DRM callbacks?

> +
> +	ret = dcp_hfi_send_sync(hfi,
> +				HFI_COMMAND_DISPLAY_CLOSE,
> +				HFI_CMD_BUFF_DISPLAY, session_id,
> +				HFI_PAYLOAD_NONE, NULL, 0,
> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				HFI_TX_FLAGS_NON_DISCARDABLE,
> +				NULL, 0,
> +				DCP_HFI_TIMEOUT_DISPLAY_MS);
> +	if (ret)
> +		dev_warn(hfi->dev, "HFI DISPLAY_CLOSE failed: %d\n", ret);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
> new file mode 100644
> index 000000000000..b27fa8fa3160
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
> @@ -0,0 +1,592 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * HFI commands for panel initialization and DCS transfers.
> + * Firmware owns the DSI controller and PHY.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/math64.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_mipi_dsi.h>
> +
> +#include "dcp_dsi_panel.h"
> +#include "dcp_hfi.h"
> +#include "dcp_hfi_priv.h"
> +#include "hfi/hfi_commands_display.h"
> +#include "hfi/hfi_commands_panel.h"
> +#include "hfi/hfi_defs_common.h"
> +#include "hfi/hfi_defs_panel.h"
> +#include "hfi/hfi_packet.h"
> +#include "hfi/hfi_packer.h"
> +#include "hfi/hfi_properties_panel.h"
> +
> +#define DCP_DSI_CTRL_CMD_READ              BIT(0)
> +#define DCP_DSI_CTRL_CMD_FETCH_MEMORY      BIT(5)
> +#define DCP_DSI_CTRL_CMD_LAST_COMMAND      BIT(6)
> +
> +static u32 dcp_bpp_to_hfi(u32 bpp)
> +{
> +	switch (bpp) {
> +	case 16: return HFI_PANEL_BPP_16;
> +	case 18: return HFI_PANEL_BPP_18;
> +	case 30: return HFI_PANEL_BPP_30;
> +	case 24:
> +	default: return HFI_PANEL_BPP_24;
> +	}
> +}
> +
> +static u32 dcp_dsi_traffic_mode(const struct mipi_dsi_device *dsi)
> +{
> +	if (!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO))
> +		return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE;
> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> +		return HFI_PANEL_TRAFFIC_BURST_MODE;
> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> +		return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_PULSE_MODE;
> +	return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE;
> +}
> +
> +static u32 dcp_lanes_to_hfi(u32 num_lanes)
> +{
> +	u32 mask = 0;
> +
> +	if (num_lanes >= 1)
> +		mask |= HFI_PANEL_LANE_0;

There is always at least one lane. Set the mask to HFI_PANEL_LANE_0.

> +	if (num_lanes >= 2)
> +		mask |= HFI_PANEL_LANE_1;
> +	if (num_lanes >= 3)
> +		mask |= HFI_PANEL_LANE_2;
> +	if (num_lanes >= 4)
> +		mask |= HFI_PANEL_LANE_3;
> +
> +	return mask ?: HFI_PANEL_LANE_0;
> +}
> +
> +static bool dcp_hfi_panel_wait(struct dcp_hfi *hfi,
> +			       struct dcp_hfi_completion *comp)
> +{
> +	unsigned long flags;
> +
> +	if (wait_for_completion_timeout(&comp->done,
> +					msecs_to_jiffies(DCP_HFI_TIMEOUT_DISPLAY_MS)))
> +		return false;
> +
> +	/* Serialize removal with response dispatch before the stack object dies. */
> +	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
> +	dcp_hfi_pending_find(hfi, comp->packet_id);
> +	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
> +	return true;
> +}
> +
> +int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
> +		       const struct drm_display_mode *mode,
> +		       const struct mipi_dsi_device *dsi,
> +		       const struct dcp_dsi_hfi_panel_config *cfg)
> +{
> +	u32 num_lanes;
> +	u32 bpp;
> +	bool is_cmd_mode;
> +	u32 display_type;
> +	u32 vsync_source;
> +	u32 traffic_mode;
> +	u32 phy_type;
> +
> +	struct dcp_hfi_buf *buf1, *buf2;
> +	struct hfi_cmd_buff_hdl hdl1, hdl2;
> +	struct hfi_header_info hdr_info1, hdr_info2;
> +	struct hfi_packet_info pkt_info;
> +	struct dcp_hfi_completion comp1, comp2, comp3;
> +	u32 payload[128];
> +	u32 *p;
> +	u32 packet_id, packet_id2, packet_id3;
> +	u64 clk_hz;
> +	int ret;
> +	bool timeout1, timeout2, timeout3;
> +	u32 link_bpp_x16;

Reverse christmas tree, apply universally to all your code.

> +
> +	if (!hfi || !mode || !dsi || !dsi->lanes || !cfg)
> +		return -EINVAL;

And which of those can actually be passed as NULL?

> +	if (cfg->num_ctrls > ARRAY_SIZE(cfg->ctrl_indices) ||
> +	    cfg->num_phys > ARRAY_SIZE(cfg->phy_indices))
> +		return -EINVAL;
> +
> +	display_type = cfg->display_type;
> +	vsync_source = cfg->vsync_source;
> +	phy_type = cfg->phy_type;
> +	num_lanes = dsi->lanes;
> +	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
> +	if (bpp < 0)
> +		return -EINVAL;
> +	is_cmd_mode = !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
> +	traffic_mode = dcp_dsi_traffic_mode(dsi);
> +	link_bpp_x16 = bpp << 4;
> +
> +	buf1 = dcp_hfi_buf_alloc(hfi);
> +	if (!buf1) {
> +		dev_err(hfi->dev, "HFI PANEL_INIT: TX buffer exhausted\n");
> +		return -ENOMEM;
> +	}
> +
> +	hdl1.cmd_buffer = buf1->data;
> +	hdl1.size       = DCP_HFI_BUF_SIZE;
> +
> +	hdr_info1.num_packets   = 0;
> +	hdr_info1.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
> +	hdr_info1.object_id     = intf_idx;
> +	hdr_info1.header_id     = dcp_hfi_next_packet_id(hfi);
> +
> +	ret = hfi_create_header(&hdl1, &hdr_info1);
> +	if (ret) {
> +		dev_err(hfi->dev, "PANEL_INIT: hfi_create_header (A) failed: %d\n",
> +			ret);
> +		goto err_free_buf1;
> +	}
> +
> +	{

Jayant, you really like to ignore comments. Please stop doing that. And
also please stop having unconditional nested blocks. If you need one,
extract it to a function.

> +		u32 num_props = 0;
> +
> +		p = payload + 1;
> +		num_props++;
> +		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TIMING_MODE_COUNT, 1);
> +
> +		/* DCS TX buffer is described by both DVA and IOVA properties. */
> +		if (cfg->dcs_tx_iova && cfg->dcs_tx_dva &&
> +		    !(cfg->dcs_tx_iova & 0x3ff) && !(cfg->dcs_tx_dva & 0x3ff)) {
> +			num_props++;
> +			p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_DVA,
> +				       lower_32_bits(cfg->dcs_tx_dva),
> +				       upper_32_bits(cfg->dcs_tx_dva),
> +				       cfg->dcs_tx_buf_size, 0, 0);
> +			num_props++;
> +			p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_IOVA,
> +				       lower_32_bits(cfg->dcs_tx_iova),
> +				       upper_32_bits(cfg->dcs_tx_iova),
> +				       cfg->dcs_tx_buf_size, 0, 0);
> +		}
> +		payload[0] = num_props;
> +	}
> +

-- 
With best wishes
Dmitry
