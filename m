Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD5606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AJ28w226;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LE48KX2z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1306B10ED16;
	Wed, 11 Nov 2026 07:17:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF2F010E999
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:16:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KHsg1368993
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YEaA1DBqarKKF3iwyyd4vyG/r+VkRfbWN3BmJSY+Swo=; b=AJ28w226MFP5hSwG
 ryter7C+4olREoV/fXQItH4QRipQ6BroKfgt0EKlAZq8fRpE5UmZykQMOMtL4sUN
 ARhPHcEFAZbaKpIVIX829uS7iq/QsQXFoEQX1g6dugu3r5ZfoqnadsM2CvUa0feq
 onzIAzcj0aWBx+CgKRe7N+2AkBSP5dpyEk2qwCRm2HfeZxqlk/MawAoNmjHCo9W/
 JK00ETbgKOJgYLSS1iO2p+lteqjsgnfvkGtn4nP9eJRtrV4hGDeMoUyD1NH0/gud
 +sjb2P9upntHaFbB2GUqGf/cAadxpw13XyocA7A2P6/g9Os/P0LZZvJSjkO0m9Q1
 zsGoLg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvcpehhc4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:16:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ed05b3eaecso24765075ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 23:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794381417; x=1794986217;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YEaA1DBqarKKF3iwyyd4vyG/r+VkRfbWN3BmJSY+Swo=;
 b=LE48KX2zAL5nYm3QQR4OreBLmzPgUP19DmZujZAAH90IBnBNW77TgWltl4jp5+OPCK
 dX4mIcdt+jUw8hehidYpFGHBlC7yzHfpC280rs5JGmCWANs2gvLAMGDxZ7J3HCTc7642
 aPkZYWC0xHqgqhCTXY/aTm7DHLYl5j8qBYYkJKkwuYnDwo8jUFpvLAnVagJQBL0iLyc5
 T9f+8ixvJXxrnzb/6eQGzZcyRwwTDPUsZkpHEl4ScjJ9Yeppo5vRZtuUZPe9nkIUDlKy
 GRYFoy0r3MES8GHexP8RikT9nQGp2UlE6U/sDqdkLZp/GmqEJg63m1b3pzFORHmyYdBB
 Xsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794381417; x=1794986217;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YEaA1DBqarKKF3iwyyd4vyG/r+VkRfbWN3BmJSY+Swo=;
 b=QGEOq85AYjSUiKdv+V9KHrsmWtoHM5XD0jBVRd17osG8OrsTYqO+bXCrjdxptK2ZSC
 dt3kZEHeEysKTzBdzKqzHOxXc6OnhioUDoeRzOGcd8GEyKzBP3I38Cp/tze9ULbQHjSf
 MIijuN4Khw6eI75q4r9cbB6FcGoAP4n+ykXs8MR/tXvW5CNbBVZWSm6mTpNmaCfDDOfc
 pIM2eqnu+guEsQBCa3rkT2utCzLr6no22smHpsD0XJ2NCynKPVA37Sn5cgxRI0UxjjYv
 IbCIJRmclvIzW0mT6zgGcolEPMiEgS+//JNntinVTtlaICgyLb++2tfUdlgRCZz/LSmt
 gG/w==
X-Forwarded-Encrypted: i=1;
 AL+hErGYMKc612o7GxS1fzh1FeuQPNZuNS9UXj9lBu4lnOc9e+T/RkJcQB+9Er6itM/T60pzMc4SVm2UTWQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8EqGgGSL4wucK/3h8fXVid6QOAwQygb3TLVm0A52AFA5ct3zph
 zTe9g5QkfJVgS+cGWGwEf93K4yKtyQKrsv7YRhDMr+cbxQGshYykpzguw4OchMpbF1p4vVSeRpZ
 fH2ZO8WL5kY6fTsbkT3zSB1Oukv0yAmF6onE1fNJx+dUJrBLYi2uuMcZxmKZ1W5G8sWIR4no=
X-Gm-Gg: AYBFou236q2LT3Hfswh9dIJHeh/efKszYSsJZMJWPpIvj5gTfgZ3yfu5JCn2kjZrY/C
 8jtN0W2LlbrdRyYPPuFV1bDEuqLHnkP/TUYdD8MEekWzjTvLur8Ce8D9FLV+L5Jpe3RUnNZhjfv
 ollPEQs7hYshy+iiLXCUK9yShDKcFjmV5WO3b4u1nW6CxbDmSxPGv4O9BX65VJaOCYFMAEULi5r
 W+bok4zPZikDYz5U/WaxYTnhkTp1YZ4LYVy+BO+40+B49kDDxKmNI9yANRYgUH6DdCmVyb5BbiE
 HMhwP7tTbwpKsOfiHqihLnDXooUM4Z59J+7wsufx+wIXPo06dcPDbTZqs7XAYb2SK8tvjsrAgEZ
 TtyYTpbPtNGMyqPw1YUdAZiEej8bdLmzW6HL3qqcjdlQg6bh9/aHlnPhCcwkj0795gsMUhHKJ1h
 kfQuML0pY=
X-Received: by 2002:a17:903:3c27:b0:2e6:7c6:8d40 with SMTP id
 d9443c01a7336-2edd7a03c19mr16642275ad.27.1794381416975; 
 Tue, 10 Nov 2026 23:16:56 -0800 (PST)
X-Received: by 2002:a17:903:3c27:b0:2e6:7c6:8d40 with SMTP id
 d9443c01a7336-2edd7a03c19mr16641935ad.27.1794381416369; 
 Tue, 10 Nov 2026 23:16:56 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d7bf46sm18117315ad.31.2026.11.10.23.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 23:16:55 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <177ad2ea-6cf4-40b1-af3c-0d85ad96cc08@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:46:43 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/23] drm/msm/dcp: Add HFI DSI and panel commands
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-10-7cf014efdee1@oss.qualcomm.com>
 <ebhoujzyf4fn5v3gfmgrskjw646d2e7l5b3yr4pyq2wh4vrclq@5a6vx4zx55w3>
Content-Language: en-US
In-Reply-To: <ebhoujzyf4fn5v3gfmgrskjw646d2e7l5b3yr4pyq2wh4vrclq@5a6vx4zx55w3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX+A9DfHzjdZXp
 AJ1zjsw6R9Btq+0RoP6w9jCxj1jao/qtwI560Inhd/rI9RHMPrz3t3IhRiNxxA6QYGMWXbuG58I
 L+p9SL3VTMHC/N1aasHhZ3MG5USmXKLCK4VwQHwgxDHOBk7beQ1bgw0pHZLl7uuR7jGnVutDlr9
 orb266U3gK2GHStf/0g1gm5wYyvP93Jib7OTZwK67bxex1RjYixEkXlApCI1UsPM1UWbFIWO2Yk
 oNVdkvu6bn4N+m5q+KCQ7FCIZSqmppn4TLSN+9zUWE+aMmFsr/54Q7AZG55hhIfhy5sDDFkN8cz
 8kCv5+WBWFbdVpTCXHvrMPweNwgckM1SkTMI3zVebKjTH9bpNvBPipQQk7QXmEf3hnm9RuwSbxO
 9LGN1xdqJmzhM66JboUn6vcIGL4XK0mUVR4wo8plk1t5yuEm/IAT3waPBlLfy2/BNyemvkCAATk
 4hh9bVUlY4gBk3GTSrQ==
X-Proofpoint-ORIG-GUID: gabZ7Pslop0NVnmaBAsI6geqwnhsiFcM
X-Proofpoint-GUID: gabZ7Pslop0NVnmaBAsI6geqwnhsiFcM
X-Authority-Analysis: v=2.4 cv=RfAFmFtv c=1 sm=1 tr=0 ts=6af4166a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=CbyQB27IJ3HHEvoKa4cA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfXyW5M8LD91M8b
 giiyYkuhmrp2prmb7iL7+jW8Ikd9uEXOh4/1zT4Id072XjRwbfP+KxO7xARhtKleKPI6jIErjUG
 AIkKunJssklogt6z0Jjuz318g2grSyI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110028
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 27-10-2026 16:36, Dmitry Baryshkov wrote:
> On Mon, Oct 26, 2026 at 11:51:20AM +0530, Jayant Shekhar wrote:
>> Translate DSI host and panel operations into HFI commands. Firmware
>> owns the DSI hardware, so mode validation, display power, panel setup,
>> and DCS transfers must cross the HFI interface instead of accessing
>> controller registers from Linux.
>>
>> Implement DSI mode validation, display session and power management,
>> panel initialization, and DCS transfer helpers while keeping them
>> separate from generic display commands.
>>
>> Assisted-by: LLM
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/Makefile                |   2 +
>>   drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h     |  81 ++++
>>   drivers/gpu/drm/msm/dcp/dcp_hfi.h           |  25 ++
>>   drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c       | 252 ++++++++++++
>>   drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c | 592 ++++++++++++++++++++++++++++
> Please stop calling it a panel. There can be any bridge after the DSI
> device. From the Linux point of view, drm_panel is a subclass of
> drm_bridge.
>
>>   5 files changed, 952 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
>> index bdc5e3b8efa7..77c268aabca6 100644
>> --- a/drivers/gpu/drm/msm/Makefile
>> +++ b/drivers/gpu/drm/msm/Makefile
>> @@ -74,6 +74,8 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
>>   msm-display-$(CONFIG_DRM_MSM_DCP) += \
>>   	dcp/dcp_hfi_core.o \
>>   	dcp/dcp_hfi_crtc.o \
>> +	dcp/dcp_hfi_dsi.o \
>> +	dcp/dcp_hfi_dsi_panel.o \
>>   	dcp/dcp_hfi_encoder.o \
>>   	dcp/dcp_hfi_kms.o \
>>   	dcp/dcp_hfi_plane.o \
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
>> new file mode 100644
>> index 000000000000..a8898e469b44
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
>> @@ -0,0 +1,81 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * DCP DSI panel configuration shared by the HFI panel implementation and
> What if there is a DSI2DPI or DSI2LVDS bridge and then DPI or LVDS
> panel?
>
>> + * the DRM DSI bridge.
>> + */
>> +
>> +#ifndef __DCP_DSI_PANEL_H__
>> +#define __DCP_DSI_PANEL_H__
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/sizes.h>
>> +#include <linux/types.h>
>> +
>> +#define DCP_DSI_MAX_PHY_TIMINGS	32
>> +
>> +/**
>> + * struct dcp_dsi_hfi_panel_config - Complete HFI PANEL_INIT configuration.
>> + *
>> + * This contains the bridge-owned panel configuration plus the
>> + * mode-dependent values assembled before the HFI PANEL_INIT command.
>> + */
>> +struct dcp_dsi_hfi_panel_config {
>> +	u32 display_type;
>> +	u32 num_ctrls;
>> +	u32 ctrl_indices[4];
>> +	u32 num_phys;
>> +	u32 phy_indices[4];
>> +	u32 vsync_source;
>> +	u32 te_dcs_command;
>> +	u32 dma_trigger;
>> +	u32 stream_trigger;
>> +	u32 wr_mem_start;
>> +	u32 wr_mem_continue;
>> +	u32 dma_sched_line;
>> +	u32 dma_sched_window;
>> +	u32 phy_type;
>> +	bool cphy_mode;
>> +	bool lp11_init;
>> +	bool ulps_supported;
>> +	bool bllp_eof_power_mode;
>> +	bool bllp_power_mode;
>> +	u32 lane_map;
>> +	u32 color_order;
>> +	u32 esd_mode;
>> +	u32 jitter_numer;
>> +	u32 jitter_denom;
>> +	dma_addr_t dcs_tx_dva;
>> +	dma_addr_t dcs_tx_iova;
>> +	u32 dcs_tx_buf_size;
>> +	u32 phy_timings[DCP_DSI_MAX_PHY_TIMINGS];
>> +	u32 num_phy_timings;
>> +	bool dsc_enabled;
>> +	u32 dsc_version_major;
>> +	u32 dsc_version_minor;
>> +	u32 dsc_scr_version;
>> +	u32 dsc_slice_height;
>> +	u32 dsc_slice_width;
>> +	u32 dsc_slices_per_pkt;
>> +	u32 dsc_bits_per_component;
>> +	u32 dsc_pps_delay_ms;
>> +	u32 dsc_bits_per_pixel;
>> +	u32 dsc_chroma_format;
>> +	u32 dsc_color_space;
>> +	u32 dsc_block_prediction_enable;
> Why do you need to copy those? Can't you use struct drm_dsc directly?
> Having it as a non-NULL pointer would have saved you from having
> the dsc_enabled flag.
>

Will remove in v3.


>> +	/* Optional DSC rate-control override panel configuration. */
>> +	bool dsc_rc_override;
>> +	u8 dsc_rc_min_qp[15];
>> +	u8 dsc_rc_max_qp[15];
>> +	u8 dsc_rc_bpg_offsets[15];
>> +	u32 topology_mixer_count;
>> +	u32 topology_enc_count;
>> +	u32 topology_intf_count;
>> +};
>> +
>> +/* DCS buffers use IOVAs directly in the firmware command descriptor. */
>> +#define DCP_DSI_DCS_TX_BUF_SIZE	SZ_4K
>> +#define DCP_DSI_DCS_RX_BUF_SIZE	SZ_4K
>> +
>> +#endif /* __DCP_DSI_PANEL_H__ */
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi.h b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
>> index 6d3eadb5e811..88d73de69383 100644
>> --- a/drivers/gpu/drm/msm/dcp/dcp_hfi.h
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
>> @@ -242,6 +242,31 @@ int dcp_hfi_send_resource_register(struct dcp_hfi *hfi);
>>   int dcp_hfi_set_display_property(struct dcp_hfi *hfi, u32 session_id,
>>   				 u32 prop_id, u32 value);
>>   
>> +struct dcp_dsi_hfi_panel_config;
>> +int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
>> +		       const struct drm_display_mode *mode,
>> +		       const struct mipi_dsi_device *dsi,
>> +		       const struct dcp_dsi_hfi_panel_config *cfg);
>> +int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx,
>> +			   u32 display_id, u32 *session_id);
>> +int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id);
>> +int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
>> +				  const struct drm_display_mode *mode,
>> +				  u64 clk_rate_hz);
>> +int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
>> +			     const struct drm_display_mode *mode,
>> +			     u64 clk_rate_hz);
>> +int dcp_hfi_display_power_register(struct dcp_hfi *hfi, u32 session_id);
>> +int dcp_hfi_display_power_control_ack(struct dcp_hfi *hfi, u32 session_id,
>> +				      u32 packet_id);
>> +int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id);
>> +int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id);
>> +int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id);
>> +ssize_t dcp_hfi_dcs_transfer(struct dcp_hfi *hfi, u32 session_id,
>> +			     const struct mipi_dsi_msg *msg,
>> +			     void *tx_buf, dma_addr_t tx_iova,
>> +			     void *rx_buf, dma_addr_t rx_iova,
>> +			     u32 post_wait_ms, u32 ctrl_idx);
>>   #endif /* __DCP_HFI_H__ */
>>   void dcp_hfi_set_power_control_cb(struct dcp_hfi *hfi, void *priv,
>>   				  void (*cb)(void *priv, u32 display_id,
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
>> new file mode 100644
>> index 000000000000..fbeec03cf90d
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
>> @@ -0,0 +1,252 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * HFI commands for the DSI display-session lifecycle.
>> + * Panel initialization and DCS transfers are implemented in dcp_hfi_dsi_panel.c.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <drm/drm_modes.h>
>> +
>> +#include "dcp_hfi.h"
>> +#include "dcp_hfi_priv.h"
>> +#include "hfi/hfi_commands_display.h"
>> +#include "hfi/hfi_defs_common.h"
>> +#include "hfi/hfi_defs_display.h"
>> +#include "hfi/hfi_packet.h"
>> +#include "hfi/hfi_packer.h"
>> +#include "hfi/hfi_properties_display.h"
>> +
>> +static void dcp_hfi_fill_mode_info(struct hfi_display_mode_info *info,
>> +				   const struct drm_display_mode *mode)
>> +{
>> +	memset(info, 0, sizeof(*info));
>> +	info->size            = sizeof(*info);
>> +	info->h_active        = mode->hdisplay;
>> +	info->h_back_porch    = mode->htotal - mode->hsync_end;
>> +	info->h_sync_width    = mode->hsync_end - mode->hsync_start;
>> +	info->h_front_porch   = mode->hsync_start - mode->hdisplay;
>> +	info->h_skew          = mode->hskew;
>> +	info->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_PHSYNC);
>> +	info->v_active        = mode->vdisplay;
>> +	info->v_back_porch    = mode->vtotal - mode->vsync_end;
>> +	info->v_sync_width    = mode->vsync_end - mode->vsync_start;
>> +	info->v_front_porch   = mode->vsync_start - mode->vdisplay;
>> +	info->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_PVSYNC);
>> +	info->refresh_rate    = drm_mode_vrefresh(mode);
>> +	info->clk_rate_hz_lo = lower_32_bits((u64)mode->clock * 1000);
>> +	info->clk_rate_hz_hi = upper_32_bits((u64)mode->clock * 1000);
>> +}
>> +
>> +static void dcp_hfi_dump_mode_info(struct dcp_hfi *hfi, const char *cmd,
>> +				   u32 session_id,
>> +				   const struct hfi_display_mode_info *info)
>> +{
>> +	dev_dbg(hfi->dev,
>> +		"HFI %s s=%u h=%u/%u/%u/%u v=%u/%u/%u/%u p=%u/%u r=%u clk=%llu sz=%u\n",
>> +		cmd, session_id,
>> +		info->h_active, info->h_back_porch, info->h_sync_width,
>> +		info->h_front_porch,
>> +		info->v_active, info->v_back_porch, info->v_sync_width,
>> +		info->v_front_porch,
>> +		info->h_sync_polarity, info->v_sync_polarity,
>> +		info->refresh_rate,
>> +		(u64)info->clk_rate_hz_lo | ((u64)info->clk_rate_hz_hi << 32),
>> +		info->size);
>> +}
>> +
>> +int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
>> +				  const struct drm_display_mode *mode, u64 clk_rate_hz)
>> +{
>> +	struct hfi_display_mode_info info;
>> +	int ret;
>> +
>> +	dcp_hfi_fill_mode_info(&info, mode);
>> +	info.clk_rate_hz_lo = lower_32_bits(clk_rate_hz);
>> +	info.clk_rate_hz_hi = upper_32_bits(clk_rate_hz);
>> +	dcp_hfi_dump_mode_info(hfi, "HFI MODE_VALIDATE", session_id, &info);
>> +
>> +	ret = dcp_hfi_send_sync(hfi,
>> +				HFI_COMMAND_DISPLAY_MODE_VALIDATE,
>> +				HFI_CMD_BUFF_DISPLAY, session_id,
>> +				HFI_PAYLOAD_U32_ARRAY,
>> +				&info, sizeof(info),
>> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
>> +				HFI_TX_FLAGS_NON_DISCARDABLE,
>> +				NULL, 0,
>> +				DCP_HFI_TIMEOUT_MODE_MS);
>> +
>> +	return ret;
>> +}
>> +
>> +int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
>> +			     const struct drm_display_mode *mode, u64 clk_rate_hz)
>> +{
>> +	struct hfi_display_mode_info info;
>> +	int ret;
>> +
>> +	dcp_hfi_fill_mode_info(&info, mode);
>> +	info.clk_rate_hz_lo = lower_32_bits(clk_rate_hz);
>> +	info.clk_rate_hz_hi = upper_32_bits(clk_rate_hz);
>> +	dcp_hfi_dump_mode_info(hfi, "HFI SET_MODE", session_id, &info);
>> +
>> +	ret = dcp_hfi_send_sync(hfi,
>> +				HFI_COMMAND_DISPLAY_SET_MODE,
>> +				HFI_CMD_BUFF_DISPLAY, session_id,
>> +				HFI_PAYLOAD_U32_ARRAY,
>> +				&info, sizeof(info),
>> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
>> +				HFI_TX_FLAGS_NON_DISCARDABLE,
>> +				NULL, 0,
>> +				DCP_HFI_TIMEOUT_MODE_MS);
>> +
>> +	return ret;
>> +}
>> +
>> +int dcp_hfi_display_power_register(struct dcp_hfi *hfi, u32 session_id)
>> +{
>> +	return dcp_hfi_send_sync(hfi,
>> +				 HFI_COMMAND_DISPLAY_POWER_REGISTER,
>> +				 HFI_CMD_BUFF_DISPLAY, session_id,
>> +				 HFI_PAYLOAD_NONE, NULL, 0,
>> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
>> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
>> +				 NULL, 0,
>> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
>> +}
>> +
>> +int dcp_hfi_display_power_control_ack(struct dcp_hfi *hfi, u32 session_id,
>> +				      u32 packet_id)
>> +{
>> +	struct dcp_hfi_buf *buf;
>> +	struct hfi_cmd_buff_hdl hdl;
>> +	struct hfi_header_info hdr_info;
>> +	struct hfi_packet_info pkt_info;
>> +	int ret;
>> +
>> +	buf = dcp_hfi_buf_alloc(hfi);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	hdl.cmd_buffer = buf->data;
>> +	hdl.size       = DCP_HFI_BUF_SIZE;
>> +
>> +	hdr_info.num_packets   = 0;
>> +	hdr_info.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
>> +	hdr_info.object_id     = session_id;
>> +	hdr_info.header_id     = dcp_hfi_next_packet_id(hfi);
>> +
>> +	ret = hfi_create_header(&hdl, &hdr_info);
>> +	if (ret)
>> +		goto err_free_buf;
>> +
>> +	pkt_info.cmd          = HFI_COMMAND_DISPLAY_POWER_CONTROL;
>> +	pkt_info.id           = session_id & 0xFFFF;
>> +	pkt_info.flags        = HFI_RX_FLAGS_SUCCESS;
>> +	pkt_info.packet_id    = packet_id;
>> +	pkt_info.payload_type = HFI_PAYLOAD_NONE;
>> +	pkt_info.payload_size = 0;
>> +	pkt_info.payload_ptr  = NULL;
>> +
>> +	ret = hfi_create_packet_header(&hdl, &pkt_info);
>> +	if (ret)
>> +		goto err_free_buf;
>> +
>> +	return dcp_hfi_send_cmd_async(hfi, buf, hfi_get_header_size(&hdl), NULL);
>> +
>> +err_free_buf:
>> +	dcp_hfi_buf_free(hfi, buf);
>> +	return ret;
>> +}
>> +
>> +int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx, u32 display_id,
>> +			   u32 *session_id)
>> +{
>> +	int ret;
>> +
>> +	ret = dcp_hfi_send_sync(hfi,
>> +				HFI_COMMAND_DISPLAY_ENABLE,
>> +				HFI_CMD_BUFF_DISPLAY, display_id,
>> +				HFI_PAYLOAD_NONE, NULL, 0,
>> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
>> +				HFI_TX_FLAGS_NON_DISCARDABLE,
>> +				NULL, 0,
>> +				DCP_HFI_TIMEOUT_DISPLAY_MS);
>> +	if (ret) {
>> +		dev_err(hfi->dev,
>> +			"HFI DISPLAY_ENABLE intf=%u display_id=%u failed: %d\n",
>> +			intf_idx, display_id, ret);
>> +		return ret;
>> +	}
>> +
>> +	*session_id = display_id;
>> +
>> +	return 0;
>> +}
>> +
>> +int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id)
>> +{
>> +	return dcp_hfi_send_sync(hfi,
>> +				 HFI_COMMAND_DISPLAY_POST_ENABLE,
>> +				 HFI_CMD_BUFF_DISPLAY, session_id,
>> +				 HFI_PAYLOAD_NONE, NULL, 0,
>> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
>> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
>> +				 NULL, 0,
>> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
>> +}
>> +
>> +int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id)
>> +{
>> +	return dcp_hfi_send_sync(hfi,
>> +				 HFI_COMMAND_DISPLAY_DISABLE,
>> +				 HFI_CMD_BUFF_DISPLAY, session_id,
>> +				 HFI_PAYLOAD_NONE, NULL, 0,
>> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
>> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
>> +				 NULL, 0,
>> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
>> +}
>> +
>> +int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id)
>> +{
>> +	return dcp_hfi_send_sync(hfi,
>> +				 HFI_COMMAND_DISPLAY_POST_DISABLE,
>> +				 HFI_CMD_BUFF_DISPLAY, session_id,
>> +				 HFI_PAYLOAD_NONE, NULL, 0,
>> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
>> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
>> +				 NULL, 0,
>> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
>> +}
>> +
>> +int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id)
>> +{
>> +	int ret;
>> +
>> +	ret = dcp_hfi_display_disable(hfi, session_id);
>> +	if (ret) {
>> +		dev_warn(hfi->dev, "HFI DISPLAY_DISABLE failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = dcp_hfi_display_post_disable(hfi, session_id);
>> +	if (ret) {
>> +		dev_warn(hfi->dev, "HFI DISPLAY_POST_DISABLE failed: %d\n", ret);
>> +		return ret;
>> +	}
> Why are there two types of calls, pre and post? Should they go to the
> corresponding separate DRM callbacks?
>

This display close function would be removed, its redundant.


>> +
>> +	ret = dcp_hfi_send_sync(hfi,
>> +				HFI_COMMAND_DISPLAY_CLOSE,
>> +				HFI_CMD_BUFF_DISPLAY, session_id,
>> +				HFI_PAYLOAD_NONE, NULL, 0,
>> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
>> +				HFI_TX_FLAGS_NON_DISCARDABLE,
>> +				NULL, 0,
>> +				DCP_HFI_TIMEOUT_DISPLAY_MS);
>> +	if (ret)
>> +		dev_warn(hfi->dev, "HFI DISPLAY_CLOSE failed: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
>> new file mode 100644
>> index 000000000000..b27fa8fa3160
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
>> @@ -0,0 +1,592 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * HFI commands for panel initialization and DCS transfers.
>> + * Firmware owns the DSI controller and PHY.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/math64.h>
>> +#include <drm/drm_modes.h>
>> +#include <drm/drm_mipi_dsi.h>
>> +
>> +#include "dcp_dsi_panel.h"
>> +#include "dcp_hfi.h"
>> +#include "dcp_hfi_priv.h"
>> +#include "hfi/hfi_commands_display.h"
>> +#include "hfi/hfi_commands_panel.h"
>> +#include "hfi/hfi_defs_common.h"
>> +#include "hfi/hfi_defs_panel.h"
>> +#include "hfi/hfi_packet.h"
>> +#include "hfi/hfi_packer.h"
>> +#include "hfi/hfi_properties_panel.h"
>> +
>> +#define DCP_DSI_CTRL_CMD_READ              BIT(0)
>> +#define DCP_DSI_CTRL_CMD_FETCH_MEMORY      BIT(5)
>> +#define DCP_DSI_CTRL_CMD_LAST_COMMAND      BIT(6)
>> +
>> +static u32 dcp_bpp_to_hfi(u32 bpp)
>> +{
>> +	switch (bpp) {
>> +	case 16: return HFI_PANEL_BPP_16;
>> +	case 18: return HFI_PANEL_BPP_18;
>> +	case 30: return HFI_PANEL_BPP_30;
>> +	case 24:
>> +	default: return HFI_PANEL_BPP_24;
>> +	}
>> +}
>> +
>> +static u32 dcp_dsi_traffic_mode(const struct mipi_dsi_device *dsi)
>> +{
>> +	if (!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO))
>> +		return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE;
>> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
>> +		return HFI_PANEL_TRAFFIC_BURST_MODE;
>> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
>> +		return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_PULSE_MODE;
>> +	return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE;
>> +}
>> +
>> +static u32 dcp_lanes_to_hfi(u32 num_lanes)
>> +{
>> +	u32 mask = 0;
>> +
>> +	if (num_lanes >= 1)
>> +		mask |= HFI_PANEL_LANE_0;
> There is always at least one lane. Set the mask to HFI_PANEL_LANE_0.
>
>> +	if (num_lanes >= 2)
>> +		mask |= HFI_PANEL_LANE_1;
>> +	if (num_lanes >= 3)
>> +		mask |= HFI_PANEL_LANE_2;
>> +	if (num_lanes >= 4)
>> +		mask |= HFI_PANEL_LANE_3;
>> +
>> +	return mask ?: HFI_PANEL_LANE_0;
>> +}
>> +
>> +static bool dcp_hfi_panel_wait(struct dcp_hfi *hfi,
>> +			       struct dcp_hfi_completion *comp)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (wait_for_completion_timeout(&comp->done,
>> +					msecs_to_jiffies(DCP_HFI_TIMEOUT_DISPLAY_MS)))
>> +		return false;
>> +
>> +	/* Serialize removal with response dispatch before the stack object dies. */
>> +	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
>> +	dcp_hfi_pending_find(hfi, comp->packet_id);
>> +	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
>> +	return true;
>> +}
>> +
>> +int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
>> +		       const struct drm_display_mode *mode,
>> +		       const struct mipi_dsi_device *dsi,
>> +		       const struct dcp_dsi_hfi_panel_config *cfg)
>> +{
>> +	u32 num_lanes;
>> +	u32 bpp;
>> +	bool is_cmd_mode;
>> +	u32 display_type;
>> +	u32 vsync_source;
>> +	u32 traffic_mode;
>> +	u32 phy_type;
>> +
>> +	struct dcp_hfi_buf *buf1, *buf2;
>> +	struct hfi_cmd_buff_hdl hdl1, hdl2;
>> +	struct hfi_header_info hdr_info1, hdr_info2;
>> +	struct hfi_packet_info pkt_info;
>> +	struct dcp_hfi_completion comp1, comp2, comp3;
>> +	u32 payload[128];
>> +	u32 *p;
>> +	u32 packet_id, packet_id2, packet_id3;
>> +	u64 clk_hz;
>> +	int ret;
>> +	bool timeout1, timeout2, timeout3;
>> +	u32 link_bpp_x16;
> Reverse christmas tree, apply universally to all your code.
>
>> +
>> +	if (!hfi || !mode || !dsi || !dsi->lanes || !cfg)
>> +		return -EINVAL;
> And which of those can actually be passed as NULL?
>
>> +	if (cfg->num_ctrls > ARRAY_SIZE(cfg->ctrl_indices) ||
>> +	    cfg->num_phys > ARRAY_SIZE(cfg->phy_indices))
>> +		return -EINVAL;
>> +
>> +	display_type = cfg->display_type;
>> +	vsync_source = cfg->vsync_source;
>> +	phy_type = cfg->phy_type;
>> +	num_lanes = dsi->lanes;
>> +	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
>> +	if (bpp < 0)
>> +		return -EINVAL;
>> +	is_cmd_mode = !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
>> +	traffic_mode = dcp_dsi_traffic_mode(dsi);
>> +	link_bpp_x16 = bpp << 4;
>> +
>> +	buf1 = dcp_hfi_buf_alloc(hfi);
>> +	if (!buf1) {
>> +		dev_err(hfi->dev, "HFI PANEL_INIT: TX buffer exhausted\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	hdl1.cmd_buffer = buf1->data;
>> +	hdl1.size       = DCP_HFI_BUF_SIZE;
>> +
>> +	hdr_info1.num_packets   = 0;
>> +	hdr_info1.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
>> +	hdr_info1.object_id     = intf_idx;
>> +	hdr_info1.header_id     = dcp_hfi_next_packet_id(hfi);
>> +
>> +	ret = hfi_create_header(&hdl1, &hdr_info1);
>> +	if (ret) {
>> +		dev_err(hfi->dev, "PANEL_INIT: hfi_create_header (A) failed: %d\n",
>> +			ret);
>> +		goto err_free_buf1;
>> +	}
>> +
>> +	{
> Jayant, you really like to ignore comments. Please stop doing that. And
> also please stop having unconditional nested blocks. If you need one,
> extract it to a function.
>

Sorry about that, probably missed at one place, had addressed all the 
other places.

All other comments including this to be addressed in v3.


>> +		u32 num_props = 0;
>> +
>> +		p = payload + 1;
>> +		num_props++;
>> +		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TIMING_MODE_COUNT, 1);
>> +
>> +		/* DCS TX buffer is described by both DVA and IOVA properties. */
>> +		if (cfg->dcs_tx_iova && cfg->dcs_tx_dva &&
>> +		    !(cfg->dcs_tx_iova & 0x3ff) && !(cfg->dcs_tx_dva & 0x3ff)) {
>> +			num_props++;
>> +			p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_DVA,
>> +				       lower_32_bits(cfg->dcs_tx_dva),
>> +				       upper_32_bits(cfg->dcs_tx_dva),
>> +				       cfg->dcs_tx_buf_size, 0, 0);
>> +			num_props++;
>> +			p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_IOVA,
>> +				       lower_32_bits(cfg->dcs_tx_iova),
>> +				       upper_32_bits(cfg->dcs_tx_iova),
>> +				       cfg->dcs_tx_buf_size, 0, 0);
>> +		}
>> +		payload[0] = num_props;
>> +	}
>> +
