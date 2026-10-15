Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915C8CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8FF10E8C2;
	Thu, 15 Oct 2026 13:18:52 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DFD10E8C2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:18:41 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jO3k2114165
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=C4WmfmwxCEynC+hdqwgbo9dV
 lRmDSGZVVWS2jGB2Vio=; b=KaYcm2i6gojYlKIk5CP0E1h2msLVtFNjk27+20uH
 4m/mgrtuxer8NeaAZ3iWnrgDhOr5uVcK3u3+PNrPPwKlAj4ZP8a+/573PVRbDzi5
 ObGTY7uEtfO6L9OARjzL9C248mBRjESVpk4s5P1I09zavKy3dU9YKWqg9rLtzpta
 tr1YipGkH4AOeAQrVHf/lk/neDIKh6mrWBj4XM/zg/6KPNJrfy10sioeV8HEdoQt
 OFNkj7hA9ZoCqA0Bq/I6YKLpLbG8PArwhHxSbMZhTMQALcrFbTmgLOVSH0vbOsO5
 7ZxAgX24MdL8aGm1kuY65xw36bauPt3MgiQz6qYKrRkVPQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmyb7bx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:18:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91792488228so116791976d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792070319; x=1792675119;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C4WmfmwxCEynC+hdqwgbo9dVlRmDSGZVVWS2jGB2Vio=;
 b=WYkVAVBPG+icNvYu9djfv36/PmeT9jSkFpP1rqCd+xzxTk8vkFK/RJG3ISegTzY69r
 W6ZBaUeyqLkCPcxx9noJ92RjQlq6FD0Ehqr3F8O1TfR1xjbtBNfXRu3KyKlHS//4fYC3
 yIHH5k2Zv43sPf1VFenCxd4sZw0qypaDzYJZ/TdEDUvdABPYe+mP6rGOKnTn4ApDrYsI
 6Tlskon5X/8nO0iKpiHppfu2jxrXQsrGAGWc6X/H9q1rL0hauGW/OCcuFDrMkBLxZ2tp
 AKf+IHzmtgichsd3j0O76eIkb/UHlps7qcNnalyhdzB3V0/1OoUygQeScOzXBAXx7RJB
 Hulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792070319; x=1792675119;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C4WmfmwxCEynC+hdqwgbo9dVlRmDSGZVVWS2jGB2Vio=;
 b=mjOtsjmK5s4A1+JPcWjyr9dD6eQ8OacKikultz3QrU1HpI9NwVAOmPR11WVk6DCvTJ
 WixbmNIUajqOWy19xbdJdk+gKdVdVxUTWRaIj88ARPbt0RTtDvat6nmAyaOhw1mClEUu
 72LQZmUhqLFD+pMZd5133tIt6/IGBUnCp3D2RbUI2XRRFek9ibwyA7Luo7NX9b4y+6vl
 o8oSt0JIaMgxfsOBSYlOUA/XrmnDXkcFOG2tFsWe8HOC69A/jXxkMAaPONMgJB1FBb5k
 RUqolVApoKanIwdCDHQfF49tOd0sDV388bsT39brV9H+n7ucx5CDGAzumV/N0M/BM5ZI
 EyzA==
X-Forwarded-Encrypted: i=1;
 AKwUvByuXg2rZ9QvgvaDHms4wdK9mjF0SaDopQv/wIjwF2j1QYN565iPQI9APZpw7NBKXkYP4Wi6K2XfUgk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLuMRPA5R7BmGtrRl6sQvKP6OJyXKItPksmoyytySmHVNI2Zj3N
 SQjkorTnP6lN8/loFP61Bijg05Q/SwjhEfScmckVaZNbP1S13OCLSBEBl+pFDAUDpp+0IMV+I13
 Fx8LoW3ZymH5gmeTmbF8he6s/7BUfxwXyJoyG4fzWL1I21ffoLSOzHSsrirsTk+xwIwiElvo=
X-Gm-Gg: AYBFou0TBo2M5rH6av4IyiGoMmEJEBxN2lLptIQ33n3QO1mELbB9Doxg2bq+SZtEfon
 Je1R08E1OEz0I2iHfn0+LI1MGL1VAkKvrky6HjMkEBbuP+n00HIFhYYALXfjsgUmFFe2Tw7anyf
 6siwcDXjNaMncY3ef9ymOMRSKh5VSkvnK+YFCdmF4z8jdkCPpukHE5vwZd125eYET+Leaj18+qR
 5uTlLJAVo4XzbAMMHBuOiyH7icGU9a7fI7/xU7LDimWLKbFN2IFQnCGeSvlXtIH7ePMtNUZPs26
 J2yyZ2zrT4ts+2zK/gPicrldurgI8M5VVVbdxOEJf/3CYphgh8HuTXWVhqGxRmBHEGRwgJjnBKB
 OXv9Ud8gPp6b8/Qq+BoWD4EmI/ovp00Tx60v1Dxv8TfQ9cBar3nLAWXkQp/JFb1mS05AgERURhs
 y93WPRc1ayPlMg
X-Received: by 2002:a05:620a:19a5:b0:93e:5016:e3a6 with SMTP id
 af79cd13be357-93ebd1eca74mr2926784485a.26.1792070318733; 
 Thu, 15 Oct 2026 06:18:38 -0700 (PDT)
X-Received: by 2002:a05:620a:19a5:b0:93e:5016:e3a6 with SMTP id
 af79cd13be357-93ebd1eca74mr2926777185a.26.1792070317568; 
 Thu, 15 Oct 2026 06:18:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafdf53b14sm6578801fa.41.2026.10.15.06.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 06:18:31 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:18:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 06/13] drm/msm/dcp: Add planes, CRTCs, and HFI event
 routing
Message-ID: <x2ppnksfdan6yehawencv53qttcxznr367iuaw3ltwttkoffkx@ccrzx7alvdpm>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-6-48aad0fe4f72@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-6-48aad0fe4f72@oss.qualcomm.com>
X-Proofpoint-GUID: N1b5GMPWNPm4jdeD_cw7u4CUUvslcw0G
X-Proofpoint-ORIG-GUID: N1b5GMPWNPm4jdeD_cw7u4CUUvslcw0G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfX0Jv9OcstKwer
 lkvSmZ/HsQHdpZYcRyrHAua5o+ohkP+pJWqcpZX6HHWbqiyR798IJ1v6oNpskg8C70ZJhff5bNU
 IBINgvDm9x6v1r9E5dnpNp1CN07/Zlc=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad0d2b0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Wmgxo4Guaa5p6PH-UfAA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfX+lU2NNwCuW/i
 aXyhgOPOQe03ok41WHBOjgXXwz5SOtCPzkpeOkcwR6xgGn9os4WnAmfvQCExTa0bEzbM8LVHP98
 NenZfHSCJM5UNH0KX6q8C81l2IwCxBTc16BvMVShLUYJoQB5YJRibWdX/tnvd1gA0d+wl64TwXR
 v6X7lBBLRCUp0fIUv77maik7ol5DvIoUIphP7C+HtSeA2Ug97Non9zSPRhvGBaZF5NJRwYWa7Jy
 Tg1VY7AGJfyfrFeDWImRblXRzsgOPDcTnY9umhZssCuyTDo09m+pcxZbwBoXfcAwTYjFKIQl62p
 cFcekbdvTJGVndJFkMWS3bZwbMfGe1qtra2E6vGFADRSMgCUcJUidOMZHs/2a10S43zruKD0y7B
 g+NOLltj9u5lR9SOkwRewySwArmUQWC52ZONlwKdCEgM61YyCBe1pBdmpyCntzEsOq/mXI1hOMd
 NOJYrNm1t9y1eiYKsWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150052
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

On Thu, Oct 15, 2026 at 01:08:26PM +0530, Jayant Shekhar wrote:
> The firmware-owned DCP pipeline still needs normal DRM atomic objects and
> event handling so it can participate in the MSM DRM device.
> 
> Add DCP plane and CRTC objects, validate framebuffer and plane state,
> allocate firmware display pipes, calculate bandwidth and clock votes, and
> translate visible planes and CRTC state into HFI commands. Route VSYNC and
> frame-scan completion events back to DRM and retain CRTC-local display
> session state.
> 
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> Assisted-by: LLM
> ---
>  drivers/gpu/drm/msm/Makefile           |    3 +
>  drivers/gpu/drm/msm/dcp/dcp_crtc.c     |  733 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_crtc.h     |  104 ++++
>  drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c  |   27 +
>  drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h  |   49 ++
>  drivers/gpu/drm/msm/dcp/dcp_hfi.h      |    2 +
>  drivers/gpu/drm/msm/dcp/dcp_hfi_core.c |   21 +
>  drivers/gpu/drm/msm/dcp/dcp_plane.c    | 1073 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_plane.h    |   60 ++
>  9 files changed, 2072 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 039c2e697258..b7c1a2e9a19e 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -70,6 +70,8 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
>  	disp/mdp5/mdp5_smp.o \
>  
>  msm-display-$(CONFIG_DRM_MSM_DCP) += \
> +	dcp/dcp_crtc.o \
> +	dcp/dcp_dpu_kms.o \
>  	dcp/dcp_hfi_core.o \
>  	dcp/dcp_hfi_crtc.o \
>  	dcp/dcp_hfi_dsi.o \
> @@ -78,6 +80,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
>  	dcp/dcp_hfi_kms.o \
>  	dcp/dcp_hfi_plane.o \
>  	dcp/dcp_ipcc.o \
> +	dcp/dcp_plane.o \
>  	dcp/hfi/hfi_packer.o \
>  	dcp/hfi/hfi_unpacker.o \
>  	dcp/hfi/hfi_utils.o
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> new file mode 100644
> index 000000000000..ede81881d495
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> @@ -0,0 +1,733 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * DCP CRTC implementation.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/wait.h>
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_rect.h>
> +#include <drm/drm_vblank.h>
> +
> +#include <drm/drm_managed.h>
> +
> +#include "msm_drv.h"
> +
> +#include "dcp_crtc.h"
> +#include "dcp_drv.h"
> +#include "dcp_hfi.h"
> +#include "dcp_dpu_kms.h"
> +#include "dcp_plane.h"
> +
> +#include "hfi/hfi_defs_display.h"
> +#include "hfi/hfi_properties_display.h"
> +
> +#define DCP_FRAME_DONE_TIMEOUT_MS	500
> +
> +static struct dcp_dpu_kms *dcp_crtc_get_kms(struct drm_crtc *crtc)
> +{
> +	struct msm_drm_private *priv = crtc->dev->dev_private;
> +
> +	return to_dcp_dpu_kms(priv->kms);
> +}
> +
> +static struct drm_crtc_state *
> +dcp_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
> +{
> +	struct dcp_crtc_state *cstate;
> +
> +	if (WARN_ON(!crtc->state))
> +		return NULL;
> +
> +	cstate = kzalloc_obj(*cstate, GFP_KERNEL);
> +	if (!cstate)
> +		return NULL;
> +
> +	__drm_atomic_helper_crtc_duplicate_state(crtc, &cstate->base);
> +
> +	cstate->topology_mixer_count =
> +		to_dcp_crtc_state(crtc->state)->topology_mixer_count;
> +	cstate->topology_bits_per_component =
> +		to_dcp_crtc_state(crtc->state)->topology_bits_per_component;
> +	memcpy(cstate->mixer_roi, to_dcp_crtc_state(crtc->state)->mixer_roi,
> +	       sizeof(cstate->mixer_roi));
> +	cstate->update_roi = to_dcp_crtc_state(crtc->state)->update_roi;
> +	return &cstate->base;
> +}
> +
> +static void dcp_crtc_atomic_destroy_state(struct drm_crtc *crtc,
> +					  struct drm_crtc_state *state)
> +{
> +	struct dcp_crtc_state *cstate = to_dcp_crtc_state(state);
> +
> +	__drm_atomic_helper_crtc_destroy_state(state);
> +	kfree(cstate);
> +}
> +
> +static struct drm_crtc_state *
> +dcp_crtc_atomic_create_state(struct drm_crtc *crtc)
> +{
> +	struct dcp_crtc_state *cstate;
> +
> +	cstate = kzalloc_obj(*cstate, GFP_KERNEL);
> +	if (!cstate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_crtc_state_init(&cstate->base, crtc);
> +	cstate->topology_mixer_count = 1;
> +	cstate->topology_bits_per_component = 8;
> +	return &cstate->base;
> +}
> +
> +static void dcp_crtc_aggregate_bw(struct drm_crtc_state *crtc_state,
> +				  bool enable)
> +{
> +	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc_state);
> +	struct drm_plane *plane;
> +	const struct drm_plane_state *pstate;
> +
> +	cstate->dram_ib  = 0;
> +	cstate->dram_ab  = 0;
> +	cstate->llcc_ib  = 0;
> +	cstate->llcc_ab  = 0;
> +	cstate->core_clk = 0;
> +
> +	if (!enable)
> +		return;
> +
> +	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
> +		const struct dcp_plane_state *dcp_pstate = to_dcp_plane_state(pstate);

Check if it's enabled.

> +
> +		cstate->dram_ib  = max(cstate->dram_ib, dcp_pstate->fetch_bw);
> +		cstate->dram_ab += dcp_pstate->fetch_bw;
> +		cstate->llcc_ib  = max(cstate->llcc_ib, dcp_pstate->fetch_bw);
> +		cstate->llcc_ab += dcp_pstate->fetch_bw;
> +		cstate->core_clk = max(cstate->core_clk, dcp_pstate->clk);
> +	}
> +}
> +
> +static enum drm_mode_status
> +dcp_crtc_mode_valid(struct drm_crtc *crtc,
> +		    const struct drm_display_mode *mode)
> +{
> +	struct dcp_dpu_kms *kms = dcp_crtc_get_kms(crtc);
> +	u32 max_width, max_height;
> +
> +	if (!kms)
> +		return MODE_ERROR;
> +
> +	dcp_mode_limits(mode, kms->caps->max_width, kms->caps->max_height,
> +			&max_width, &max_height);
> +
> +	return drm_mode_validate_size(mode, max_width, max_height);
> +}
> +
> +static void dcp_crtc_atomic_begin(struct drm_crtc *crtc,
> +				  struct drm_atomic_commit *state)
> +{
> +	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
> +	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
> +	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
> +	u32 mixer_count;
> +	u32 session_id;
> +	u32 i;
> +	int ret;
> +
> +	if (!crtc->state->active)
> +		return;
> +	if (!dcp_kms->commit_pm_active) {
> +		cstate->hfi_error = -EIO;
> +		return;
> +	}
> +
> +	if (!dcp_crtc_get_session(crtc, &session_id)) {
> +		cstate->hfi_error = -ENODEV;
> +		return;
> +	}
> +
> +	if (cstate->core_clk > 0 || cstate->dram_ib > 0) {
> +		ret = dcp_hfi_crtc_set_bw(dcp_kms->hfi, session_id,
> +					  cstate->dram_ib,  cstate->dram_ab,
> +				      cstate->llcc_ib,  cstate->llcc_ab,
> +				      cstate->core_clk);
> +		if (ret) {
> +			cstate->hfi_error = ret;
> +			return;
> +		}
> +	}
> +
> +	mixer_count = cstate->topology_mixer_count;
> +	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
> +		cstate->hfi_error = -EINVAL;
> +		return;
> +	}
> +	for (i = 0; i < mixer_count; i++) {
> +		struct dcp_mixer_roi *roi = &cstate->mixer_roi[i];
> +
> +		if (!roi->w || !roi->h) {
> +			DRM_ERROR("CRTC%u: invalid zero-sized LM%u ROI\n",

No deprecated macros in the new driver, thank you.

> +				  dcp_crtc->display_id, i);
> +			cstate->hfi_error = -EINVAL;
> +			return;
> +		}
> +
> +		ret = dcp_hfi_crtc_set_resource(dcp_kms->hfi, session_id,
> +						i, roi->w, roi->h, roi->x, roi->y);
> +		if (ret) {
> +			cstate->hfi_error = ret;
> +			return;
> +		}
> +	}
> +
> +	ret = dcp_hfi_crtc_set_dest_roi(dcp_kms->hfi, session_id,
> +					cstate->update_roi.x, cstate->update_roi.y,
> +					cstate->update_roi.w, cstate->update_roi.h);
> +	if (ret) {
> +		cstate->hfi_error = ret;
> +		return;
> +	}
> +}
> +
> +static void dcp_crtc_atomic_flush(struct drm_crtc *crtc,
> +				  struct drm_atomic_commit *state)
> +{
> +	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
> +	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
> +	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
> +	unsigned long flags;
> +	u32 session_id;
> +	int ret;
> +
> +	if (!crtc->state->enable)
> +		return;
> +	drm_dbg_driver(crtc->dev, "DCP_FLUSH CRTC%u mask=0x%x err=%d\n",
> +		       dcp_crtc->display_id, crtc->state->plane_mask,
> +		      cstate->hfi_error);
> +
> +	if (!dcp_crtc_get_session(crtc, &session_id)) {
> +		dev_dbg(crtc->dev->dev,
> +			"CRTC%u: atomic flush without HFI session\n",
> +			dcp_crtc->display_id);
> +		goto flush_done;
> +	}
> +
> +	if (cstate->hfi_error)
> +		goto flush_done;
> +
> +	ret = dcp_hfi_crtc_set_scan_sequence_id(dcp_kms->hfi, session_id,
> +						++dcp_crtc->commit_seq_id);
> +	if (ret)
> +		goto flush_error;
> +
> +	ret = dcp_hfi_crtc_set_autorefresh(dcp_kms->hfi,
> +					   session_id, true, 1);
> +	if (ret)
> +		goto flush_error;
> +
> +	goto flush_done;
> +
> +flush_error:
> +	cstate->hfi_error = ret;
> +
> +flush_done:
> +	spin_lock_irqsave(&crtc->dev->event_lock, flags);
> +	dcp_crtc->event = crtc->state->event;
> +	crtc->state->event = NULL;
> +	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> +}
> +
> +void dcp_crtc_set_session(struct drm_crtc *crtc, u32 session_id)
> +{
> +	struct dcp_crtc *dcp_crtc;
> +	unsigned long flags;
> +
> +	if (!crtc)
> +		return;
> +
> +	dcp_crtc = to_dcp_crtc(crtc);
> +	spin_lock_irqsave(&dcp_crtc->spin_lock, flags);
> +	dcp_crtc->session_id = session_id;
> +	dcp_crtc->session_valid = true;
> +	spin_unlock_irqrestore(&dcp_crtc->spin_lock, flags);
> +}
> +
> +void dcp_crtc_clear_session(struct drm_crtc *crtc)
> +{
> +	struct dcp_crtc *dcp_crtc;
> +	unsigned long flags;
> +
> +	if (!crtc)
> +		return;
> +
> +	dcp_crtc = to_dcp_crtc(crtc);
> +	spin_lock_irqsave(&dcp_crtc->spin_lock, flags);
> +	dcp_crtc->session_valid = false;
> +	dcp_crtc->session_id = 0;
> +	spin_unlock_irqrestore(&dcp_crtc->spin_lock, flags);
> +}
> +
> +bool dcp_crtc_get_session(struct drm_crtc *crtc, u32 *session_id)
> +{
> +	struct dcp_crtc *dcp_crtc;
> +	unsigned long flags;
> +	bool valid;
> +
> +	if (!crtc)
> +		return false;
> +
> +	dcp_crtc = to_dcp_crtc(crtc);
> +	spin_lock_irqsave(&dcp_crtc->spin_lock, flags);
> +	valid = dcp_crtc->session_valid;
> +	if (valid && session_id)
> +		*session_id = dcp_crtc->session_id;
> +	spin_unlock_irqrestore(&dcp_crtc->spin_lock, flags);
> +
> +	return valid;
> +}
> +
> +void dcp_crtc_set_topology_state(struct drm_crtc_state *state,
> +				 u32 mixer_count,
> +				 u32 bits_per_component)
> +{
> +	struct dcp_crtc_state *cstate = to_dcp_crtc_state(state);
> +
> +	cstate->topology_mixer_count = mixer_count;
> +	cstate->topology_bits_per_component = bits_per_component;
> +}
> +
> +void dcp_crtc_commit_kickoff(struct drm_crtc *crtc)
> +{
> +	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
> +	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
> +	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
> +	u32 session_id;
> +	int ret;
> +
> +	if (cstate->hfi_error) {
> +		dev_err(crtc->dev->dev,
> +			"DCP_TRIGGER CRTC%u suppressed after HFI error %d\n",
> +			dcp_crtc->display_id, cstate->hfi_error);
> +		return;
> +	}
> +
> +	if (!dcp_crtc_get_session(crtc, &session_id)) {
> +		dev_warn(crtc->dev->dev,
> +			 "CRTC%u: no active session, skipping FRAME_TRIGGER\n",
> +			dcp_crtc->display_id);
> +		return;
> +	}
> +
> +	dcp_crtc->pending_seq_id = dcp_crtc->commit_seq_id;
> +	atomic_inc(&dcp_crtc->pending_kickoff_cnt);
> +
> +	ret = dcp_hfi_display_commit(dcp_kms->hfi, session_id);
> +	if (ret) {
> +		dev_err(crtc->dev->dev,
> +			"HFI commit failed for CRTC%u (session=%u): %d\n",
> +			dcp_crtc->display_id, session_id, ret);
> +		atomic_dec(&dcp_crtc->pending_kickoff_cnt);
> +		wake_up(&dcp_crtc->frame_done_wq);
> +	}
> +}
> +
> +void dcp_crtc_wait_for_commit_done(struct drm_crtc *crtc)
> +{
> +	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
> +	unsigned long timeout = msecs_to_jiffies(DCP_FRAME_DONE_TIMEOUT_MS);
> +
> +	if (!atomic_read(&dcp_crtc->pending_kickoff_cnt))
> +		return;
> +
> +	if (!wait_event_timeout(dcp_crtc->frame_done_wq,
> +				atomic_read(&dcp_crtc->pending_kickoff_cnt) == 0,
> +				 timeout)) {
> +		dev_err(crtc->dev->dev,
> +			"frame done timeout for CRTC%u\n",
> +			dcp_crtc->display_id);
> +		atomic_set(&dcp_crtc->pending_kickoff_cnt, 0);
> +	}
> +}
> +
> +void dcp_crtc_complete_commit(struct drm_crtc *crtc)
> +{
> +	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
> +	unsigned long flags;
> +
> +	if (!crtc->state->active)
> +		dcp_crtc_aggregate_bw(crtc->state, false);
> +
> +	spin_lock_irqsave(&crtc->dev->event_lock, flags);
> +	if (dcp_crtc->event) {
> +		drm_crtc_send_vblank_event(crtc, dcp_crtc->event);
> +		dcp_crtc->event = NULL;
> +	}
> +	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> +}
> +
> +int dcp_crtc_vblank(struct drm_crtc *crtc, bool enable)
> +{
> +	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
> +	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
> +	u32 session_id;
> +	int ret;
> +
> +	if (!dcp_kms->hfi || !dcp_crtc_get_session(crtc, &session_id))
> +		return -ENODEV;
> +
> +	if (enable)
> +		ret = dcp_hfi_display_event_register_async(dcp_kms->hfi,
> +							   session_id, HFI_EVENT_VSYNC);
> +	else
> +		ret = dcp_hfi_display_event_deregister_async(dcp_kms->hfi,
> +							     session_id, HFI_EVENT_VSYNC);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(dcp_crtc->vblank_enabled, enable);
> +	return 0;
> +}
> +
> +void dcp_crtc_vblank_callback(struct drm_crtc *crtc)
> +{
> +	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
> +
> +	if (!READ_ONCE(dcp_crtc->vblank_enabled))
> +		return;
> +
> +	if (ktime_compare(dcp_crtc->vblank_cb_time, ktime_set(0, 0)) == 0)
> +		dcp_crtc->vblank_cb_time = ktime_get();
> +	else
> +		dcp_crtc->vblank_cb_count++;
> +	drm_crtc_handle_vblank(crtc);
> +}
> +
> +void dcp_crtc_frame_done_callback(struct drm_crtc *crtc)
> +{
> +	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
> +
> +	atomic_add_unless(&dcp_crtc->pending_kickoff_cnt, -1, 0);
> +	wake_up(&dcp_crtc->frame_done_wq);
> +}
> +
> +static struct drm_crtc *dcp_crtc_find_by_session_id(struct dcp_drv *drv,
> +						    u32 session_id)
> +{
> +	struct dcp_dpu_kms *dcp_kms;
> +	struct drm_crtc *crtc;
> +	u32 active_session_id;
> +
> +	if (!drv || !drv->kms)
> +		return NULL;
> +
> +	dcp_kms = drv->kms;
> +	if (!dcp_kms)
> +		return NULL;
> +	if (session_id >= DCP_MAX_DISPLAYS)
> +		return NULL;
> +
> +	crtc = dcp_dpu_kms_get_crtc(dcp_kms, session_id);
> +	if (!crtc || !dcp_crtc_get_session(crtc, &active_session_id) ||
> +	    active_session_id != session_id)
> +		return NULL;
> +
> +	return crtc;
> +}
> +
> +static struct drm_device *dcp_crtc_get_drm_dev(struct dcp_drv *drv)
> +{
> +	struct dcp_dpu_kms *dcp_kms;
> +
> +	if (!drv || !drv->kms)
> +		return NULL;
> +
> +	dcp_kms = drv->kms;
> +	if (!dcp_kms)
> +		return NULL;
> +
> +	return dcp_kms->dev;
> +}
> +
> +void dcp_crtc_hfi_vblank_cb(struct dcp_drv *drv, u32 session_id)
> +{
> +	struct drm_crtc *crtc = dcp_crtc_find_by_session_id(drv, session_id);
> +
> +	if (crtc)
> +		dcp_crtc_vblank_callback(crtc);
> +	else if (dcp_crtc_get_drm_dev(drv))
> +		drm_err_ratelimited(dcp_crtc_get_drm_dev(drv),
> +				    "unknown CRTC for HFI VSYNC session %u\n",
> +				     session_id);
> +}
> +
> +void dcp_crtc_hfi_frame_done_cb(struct dcp_drv *drv, u32 session_id, u32 sequence_id)
> +{
> +	struct drm_crtc *crtc = dcp_crtc_find_by_session_id(drv, session_id);
> +
> +	if (crtc) {
> +		struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
> +
> +		if (sequence_id != dcp_crtc->pending_seq_id) {
> +			dev_warn(crtc->dev->dev,
> +				 "CRTC%u: ignoring stale FRAME_SCAN_COMPLETE seq=%u expected=%u\n",
> +				 dcp_crtc->display_id, sequence_id,
> +				 dcp_crtc->pending_seq_id);
> +			return;
> +		}
> +		dcp_crtc_frame_done_callback(crtc);
> +	} else if (dcp_crtc_get_drm_dev(drv))
> +		drm_err_ratelimited(dcp_crtc_get_drm_dev(drv),
> +				    "unknown CRTC for HFI frame-done session %u seq=%u\n",
> +				     session_id, sequence_id);
> +}
> +
> +static int dcp_crtc_setup_mixer_rois(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *crtc_state,
> +				     struct dcp_crtc_state *cstate)
> +{
> +	const struct drm_plane_state *pstate;
> +	struct drm_plane *plane;
> +	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
> +	u32 mixer_count = cstate->topology_mixer_count;
> +	u32 mixer_width = mode->hdisplay / mixer_count;
> +	u32 i;
> +
> +	if (!mixer_width)
> +		return -EINVAL;
> +
> +	cstate->update_roi.x = 0;
> +	cstate->update_roi.y = 0;
> +	cstate->update_roi.w = mode->hdisplay;
> +	cstate->update_roi.h = mode->vdisplay;
> +	for (i = 0; i < mixer_count; i++) {
> +		cstate->mixer_roi[i].x = (mode->hdisplay * i) / mixer_count;
> +		cstate->mixer_roi[i].y = 0;
> +		cstate->mixer_roi[i].w = (mode->hdisplay * (i + 1)) / mixer_count -
> +			cstate->mixer_roi[i].x;
> +		cstate->mixer_roi[i].h = mode->vdisplay;
> +		dev_dbg(crtc->dev->dev,
> +			"DCP_CHECK CRTC%u LM%u roi=(%u,%u %ux%u)\n",
> +				to_dcp_crtc(crtc)->display_id, i,
> +				cstate->mixer_roi[i].x, cstate->mixer_roi[i].y,
> +				cstate->mixer_roi[i].w, cstate->mixer_roi[i].h);
> +	}
> +
> +	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
> +		bool fullscreen;
> +		bool assigned = false;
> +		u32 mixer_idx;
> +
> +		if (!pstate || !pstate->visible || !pstate->fb)
> +			continue;
> +
> +		for (mixer_idx = 0; mixer_idx < mixer_count; mixer_idx++) {
> +			struct dcp_mixer_roi *mixer = &cstate->mixer_roi[mixer_idx];
> +
> +			if (pstate->crtc_x >= mixer->x &&
> +			    pstate->crtc_x + pstate->crtc_w <= mixer->x + mixer->w) {
> +				assigned = true;
> +				break;
> +			}
> +		}
> +
> +		/* Any plane may cover the complete split display. Plane type is
> +		 * not a resource-selection mechanism in the universal-plane API.
> +		 */
> +		fullscreen = pstate->crtc_x == 0 && pstate->crtc_y == 0 &&
> +			pstate->crtc_w == mode->hdisplay &&
> +			pstate->crtc_h == mode->vdisplay;
> +
> +		if (!assigned && !fullscreen && mixer_count > 1) {
> +			/*
> +			 * Split-pipe/source-split and multirect allocation are
> +			 * deferred until the atomic pipe resource manager is added.
> +			 * Reject planes needing multiple mixer rectangles for now.
> +			 */
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
> +				 struct drm_atomic_commit *state)
> +{
> +	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
> +	struct drm_crtc_state *crtc_state =
> +		drm_atomic_get_new_crtc_state(state, crtc);
> +	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc_state);
> +	struct drm_plane *plane;
> +	const struct drm_plane_state *pstate;
> +	u32 max_width, max_height;
> +	u32 mixer_count;
> +	int num_planes = 0;
> +	int ret;
> +
> +	drm_dbg_atomic(crtc->dev, "CRTC%u: atomic_check enable=%d active=%d mode=%s\n",
> +		       crtc->base.id, crtc_state->enable, crtc_state->active,
> +		 crtc_state->mode.name[0] ? crtc_state->mode.name : "none");
> +
> +	if (!crtc_state->enable || !crtc_state->active)
> +		return 0;
> +
> +	mixer_count = cstate->topology_mixer_count;
> +	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
> +		drm_err(crtc->dev,
> +			"CRTC%u: invalid mixer count %u (limit 1..%u)\n",
> +				crtc->base.id, mixer_count, DCP_MAX_MIXERS);
> +		return -EINVAL;
> +	}
> +
> +	ret = dcp_crtc_setup_mixer_rois(crtc, crtc_state, cstate);
> +	if (ret)
> +		return ret;
> +
> +	dcp_mode_limits(&crtc_state->adjusted_mode,
> +			dcp_kms->caps->max_width, dcp_kms->caps->max_height,
> +			&max_width, &max_height);
> +
> +	if (crtc_state->adjusted_mode.hdisplay > max_width ||
> +	    crtc_state->adjusted_mode.vdisplay > max_height) {
> +		drm_err(crtc->dev, "CRTC%u: mode %dx%d exceeds DCP caps %dx%d\n",
> +			crtc->base.id,
> +				 crtc_state->adjusted_mode.hdisplay,
> +				 crtc_state->adjusted_mode.vdisplay,
> +				 dcp_kms->caps->max_width,
> +				 dcp_kms->caps->max_height);
> +		return -E2BIG;
> +	}
> +
> +	/* Limit visible planes to the firmware blend-stage count. */
> +	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
> +		if (!pstate || !pstate->visible)
> +			continue;
> +		num_planes++;
> +	}
> +
> +	if (num_planes > DCP_MAX_BLEND_STAGES) {
> +		drm_err(crtc->dev, "CRTC%u: %d planes exceeds max blend stages %d\n",
> +			crtc->base.id, num_planes,
> +				 DCP_MAX_BLEND_STAGES);
> +		return -EINVAL;
> +	}
> +
> +	dcp_crtc_aggregate_bw(crtc_state, true);
> +
> +	return 0;
> +}
> +
> +static u32 dcp_crtc_get_vblank_counter(struct drm_crtc *crtc)
> +{
> +	return drm_crtc_vblank_count(crtc);
> +}
> +
> +static void dcp_crtc_atomic_enable(struct drm_crtc *crtc,
> +				   struct drm_atomic_commit *state)
> +{
> +	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
> +	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
> +	u32 session_id;
> +	int ret;
> +
> +	if (!dcp_crtc_get_session(crtc, &session_id))
> +		return;
> +
> +	ret = dcp_hfi_crtc_set_power_mode(dcp_kms->hfi, session_id,
> +					  HFI_MODE_DPMS_ON);
> +	if (ret) {
> +		dev_err(crtc->dev->dev, "CRTC%u: DPMS ON failed: %d\n",
> +			to_dcp_crtc(crtc)->display_id, ret);
> +		cstate->hfi_error = ret;
> +	}
> +
> +	drm_crtc_vblank_on(crtc);
> +}
> +
> +static void dcp_crtc_atomic_disable(struct drm_crtc *crtc,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
> +	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
> +	u32 session_id;
> +	int ret;
> +
> +	if (dcp_crtc_get_session(crtc, &session_id)) {
> +		ret = dcp_hfi_crtc_set_bw(dcp_kms->hfi, session_id, 0, 0, 0, 0, 0);
> +		if (ret) {
> +			dev_err(crtc->dev->dev,
> +				"CRTC%u: clearing bandwidth vote failed: %d\n",
> +				to_dcp_crtc(crtc)->display_id, ret);
> +			cstate->hfi_error = ret;
> +		}
> +
> +		ret = dcp_hfi_crtc_set_power_mode(dcp_kms->hfi, session_id,
> +						  HFI_MODE_DPMS_OFF);
> +		if (ret) {
> +			dev_err(crtc->dev->dev, "CRTC%u: DPMS OFF failed: %d\n",
> +				to_dcp_crtc(crtc)->display_id, ret);
> +			cstate->hfi_error = ret;
> +		}
> +	}
> +
> +	drm_crtc_vblank_off(crtc);
> +}
> +
> +static const struct drm_crtc_funcs dcp_crtc_funcs = {
> +	.set_config             = drm_atomic_helper_set_config,
> +	.page_flip              = drm_atomic_helper_page_flip,
> +	.atomic_create_state    = dcp_crtc_atomic_create_state,
> +	.atomic_duplicate_state = dcp_crtc_atomic_duplicate_state,
> +	.atomic_destroy_state   = dcp_crtc_atomic_destroy_state,
> +	.enable_vblank          = msm_crtc_enable_vblank,
> +	.disable_vblank         = msm_crtc_disable_vblank,
> +	.get_vblank_counter     = dcp_crtc_get_vblank_counter,
> +};
> +
> +static const struct drm_crtc_helper_funcs dcp_crtc_helper_funcs = {
> +	.atomic_check         = dcp_crtc_atomic_check,
> +	.atomic_enable        = dcp_crtc_atomic_enable,
> +	.atomic_disable       = dcp_crtc_atomic_disable,
> +	.atomic_begin         = dcp_crtc_atomic_begin,
> +	.atomic_flush         = dcp_crtc_atomic_flush,
> +	.mode_valid           = dcp_crtc_mode_valid,
> +};
> +
> +struct drm_crtc *dcp_crtc_init(struct dcp_dpu_kms *kms,
> +			       struct drm_plane *primary_plane,
> +			       u32 display_id)
> +{
> +	struct drm_device *dev = kms->dev;
> +	struct dcp_crtc *dcp_crtc;
> +	int ret;
> +
> +	dcp_crtc = drmm_kzalloc(dev, sizeof(*dcp_crtc), GFP_KERNEL);
> +	if (!dcp_crtc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dcp_crtc->display_id = display_id;
> +
> +	spin_lock_init(&dcp_crtc->spin_lock);
> +	init_waitqueue_head(&dcp_crtc->frame_done_wq);
> +	atomic_set(&dcp_crtc->pending_kickoff_cnt, 0);
> +
> +	ret = drmm_crtc_init_with_planes(dev, &dcp_crtc->base,
> +					 primary_plane, NULL,
> +					  &dcp_crtc_funcs,
> +					  NULL);
> +	if (ret) {
> +		dev_err(dev->dev, "CRTC%u init failed: %d\n", display_id, ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	drm_crtc_helper_add(&dcp_crtc->base, &dcp_crtc_helper_funcs);
> +
> +	dev_dbg(dev->dev, "CRTC%u initialized\n", display_id);
> +	return &dcp_crtc->base;
> +}
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.h b/drivers/gpu/drm/msm/dcp/dcp_crtc.h
> new file mode 100644
> index 000000000000..d22c891750f4
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP CRTC implementation.
> + */
> +
> +#ifndef __DCP_CRTC_H__
> +#define __DCP_CRTC_H__
> +
> +#include <linux/completion.h>
> +#include <linux/spinlock.h>
> +
> +#include <drm/drm_crtc.h>
> +
> +struct dcp_dpu_kms;
> +struct drm_plane;
> +
> +#define DCP_MAX_MIXERS 6
> +#define DCP_MAX_BLEND_STAGES 12
> +
> +static inline void dcp_mode_limits(const struct drm_display_mode *mode,
> +				   u32 cap_width, u32 cap_height,
> +				   u32 *max_width, u32 *max_height)
> +{
> +	*max_width = cap_width;
> +	*max_height = cap_height;
> +
> +	if (mode->hdisplay < mode->vdisplay && cap_width > cap_height) {
> +		*max_width = cap_height;
> +		*max_height = cap_width;
> +	}
> +}
> +
> +struct dcp_mixer_roi {
> +	u32 x;
> +	u32 y;
> +	u32 w;
> +	u32 h;
> +};
> +
> +struct dcp_crtc {
> +	struct drm_crtc base;
> +	u32 display_id;
> +	u32 session_id;
> +	bool session_valid;
> +
> +	struct drm_pending_vblank_event *event;
> +	wait_queue_head_t frame_done_wq;
> +	atomic_t          pending_kickoff_cnt;
> +	/* Protects CRTC-local vblank and commit state. */
> +	spinlock_t        spin_lock;
> +	u32     vblank_cb_count;
> +	bool    vblank_enabled;
> +	ktime_t vblank_cb_time;
> +	bool    enabled;
> +	u32 commit_seq_id;
> +	u32 pending_seq_id;
> +};
> +
> +struct dcp_crtc_state {
> +	struct drm_crtc_state base;
> +
> +	u32 topology_mixer_count;
> +	u32 topology_bits_per_component;
> +	struct dcp_mixer_roi mixer_roi[DCP_MAX_MIXERS];
> +
> +	struct dcp_mixer_roi update_roi;
> +	int hfi_error;
> +	u64 bw_ctl;
> +
> +	u64 dram_ib;
> +	u64 dram_ab;
> +	u64 llcc_ib;
> +	u64 llcc_ab;
> +	u64 core_clk;
> +};
> +
> +#define to_dcp_crtc(x)       container_of(x, struct dcp_crtc, base)
> +#define to_dcp_crtc_state(x) container_of(x, struct dcp_crtc_state, base)
> +
> +struct drm_crtc *dcp_crtc_init(struct dcp_dpu_kms *kms,
> +			       struct drm_plane *primary_plane,
> +			       u32 display_id);
> +
> +void dcp_crtc_commit_kickoff(struct drm_crtc *crtc);
> +void dcp_crtc_wait_for_commit_done(struct drm_crtc *crtc);
> +void dcp_crtc_complete_commit(struct drm_crtc *crtc);
> +int dcp_crtc_vblank(struct drm_crtc *crtc, bool enable);
> +void dcp_crtc_vblank_callback(struct drm_crtc *crtc);
> +void dcp_crtc_frame_done_callback(struct drm_crtc *crtc);
> +
> +struct dcp_drv;
> +void dcp_crtc_hfi_vblank_cb(struct dcp_drv *drv, u32 session_id);
> +void dcp_crtc_hfi_frame_done_cb(struct dcp_drv *drv, u32 session_id, u32 sequence_id);
> +
> +void dcp_crtc_set_session(struct drm_crtc *crtc, u32 session_id);
> +void dcp_crtc_clear_session(struct drm_crtc *crtc);
> +bool dcp_crtc_get_session(struct drm_crtc *crtc, u32 *session_id);
> +void dcp_crtc_set_topology_state(struct drm_crtc_state *state,
> +				 u32 mixer_count,
> +				      u32 bits_per_component);
> +
> +#endif /* __DCP_CRTC_H__ */
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
> new file mode 100644
> index 000000000000..573376785be2
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * DCP KMS driver.
> + */
> +
> +#include <drm/drm_crtc.h>
> +
> +#include "dcp_dpu_kms.h"
> +
> +struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dpu_kms,
> +				      u32 display_id)

Can we just use CRTC ids instead of display_id? Under which path do we
need to query the CRTC? Is it not accessible from the state pointers?

> +{
> +	struct drm_crtc *crtc;
> +	u32 idx = 0;
> +
> +	if (!dpu_kms || !dpu_kms->dev)
> +		return NULL;
> +
> +	drm_for_each_crtc(crtc, dpu_kms->dev) {
> +		if (idx++ == display_id)
> +			return crtc;
> +	}
> +
> +	return NULL;
> +}
> +
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
> new file mode 100644
> index 000000000000..4601571a994f
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * DCP KMS state.
> + */
> +
> +#ifndef __DCP_DPU_KMS_H__
> +#define __DCP_DPU_KMS_H__
> +
> +#include <linux/spinlock.h>
> +
> +#include "msm_drv.h"
> +#include "msm_kms.h"
> +
> +struct dcp_hfi;
> +struct dcp_caps;
> +struct dcp_dsi_bridge;
> +struct dcp_drv;
> +struct drm_crtc;
> +
> +#define DCP_DPU_AUTOSUSPEND_DELAY_MS	5000
> +#define DCP_DPU_MAX_CRTCS	4
> +#define DCP_DPU_MAX_PLANES	12
> +
> +struct dcp_dpu_kms {
> +	struct msm_kms		 base;
> +	struct drm_device	*dev;
> +	struct device		*pm_dev;
> +	struct dcp_drv		*drv;
> +	struct dcp_hfi		*hfi;
> +	struct dcp_caps		*caps;
> +	struct device_node	*dpus_np;
> +	struct device		*iommu_dev;
> +	bool			 rpm_enabled;
> +	bool			 commit_pm_active;
> +	struct dcp_dsi_bridge	*dsi_bridge[2];
> +};
> +
> +#define to_dcp_dpu_kms(x) container_of(x, struct dcp_dpu_kms, base)
> +struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dpu_kms,
> +				      u32 display_id);
> +int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dpu_kms,
> +				     struct drm_crtc *crtc);
> +
> +int dcp_dpu_drm_obj_init(struct dcp_dpu_kms *dpu_kms);
> +extern const struct msm_kms_funcs dcp_dpu_kms_funcs;
> +int dcp_kms_init(struct drm_device *ddev);
> +
> +#endif /* __DCP_DPU_KMS_H__ */
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi.h b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
> index 664d44f0e48b..25e822ce096a 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_hfi.h
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
> @@ -169,6 +169,8 @@ struct dcp_hfi {
>  	struct mutex caps_cache_lock;
>  	struct dcp_hfi_caps_cache *caps_cache;
>  
> +	void (*vblank_cb)(struct dcp_drv *drv, u32 display_id);
> +	void (*frame_done_cb)(struct dcp_drv *drv, u32 display_id, u32 sequence_id);
>  	void (*hotplug_cb)(struct dcp_drv *drv, u32 intf_idx, bool connected);
>  	void (*error_cb)(struct dcp_drv *drv, u32 display_id, u32 error_code);
>  
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
> index bf27cbf9b8a4..fea14a2d5095 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
> @@ -20,6 +20,7 @@
>  #include "dcp_hfi.h"
>  #include "dcp_hfi_priv.h"
>  #include "dcp_drv.h"
> +#include "dcp_crtc.h"
>  #include "hfi/hfi_packet.h"
>  #include "hfi/hfi_packer.h"
>  #include "hfi/hfi_unpacker.h"
> @@ -264,18 +265,35 @@ static void dcp_hfi_store_caps_payload(struct dcp_hfi *hfi,
>  	dev_dbg(hfi->dev, "%s: stored %u bytes\n", name, n);
>  }
>  
> +static void dcp_hfi_dispatch_frame_done(struct dcp_hfi *hfi,
> +					const struct hfi_packet_info *pkt_info)
> +{
> +	const struct hfi_display_frame_event_data *frame = NULL;
> +	u32 sequence_id = 0;
> +
> +	if (pkt_info->payload_ptr &&
> +	    pkt_info->payload_size >= sizeof(*frame)) {
> +		frame = pkt_info->payload_ptr;
> +		sequence_id = frame->bufferflip_index;
> +	}
> +	dcp_crtc_hfi_frame_done_cb(hfi->drv, pkt_info->id & 0xFFFF,
> +				   sequence_id);
> +}
> +
>  /* Route asynchronous events and capability packets before flag handling. */
>  static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
>  				   const struct hfi_packet_info *pkt_info)
>  {
>  	switch (pkt_info->cmd) {
>  	case HFI_COMMAND_DISPLAY_EVENT_VSYNC:
> +		dcp_crtc_hfi_vblank_cb(hfi->drv, pkt_info->id & 0xFFFF);
>  		return true;
>  
>  	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_START:
>  		return true;
>  
>  	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE:
> +		dcp_hfi_dispatch_frame_done(hfi, pkt_info);
>  		return true;
>  
>  	case HFI_COMMAND_DISPLAY_EVENT_HPD_STATUS: {
> @@ -1019,6 +1037,9 @@ int dcp_hfi_init(struct dcp_drv *drv,
>  	struct dcp_hfi *hfi;
>  	int i, ret;
>  
> +	if (!dma_dev)
> +		return -ENODEV;
> +
>  	hfi = devm_kzalloc(&vdev->dev, sizeof(*hfi), GFP_KERNEL);
>  	if (!hfi)
>  		return -ENOMEM;
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_plane.c b/drivers/gpu/drm/msm/dcp/dcp_plane.c
> new file mode 100644
> index 000000000000..e804fb8cfa1b
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_plane.c
> @@ -0,0 +1,1073 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP plane state validation and HFI property packet construction.
> + */
> +
> +#include <linux/math64.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
> +#include <drm/drm_damage_helper.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_rect.h>
> +
> +#include "msm_drv.h"
> +
> +#include "dcp_crtc.h"
> +#include "dcp_hfi.h"
> +#include "dcp_dpu_kms.h"
> +#include "dcp_plane.h"
> +
> +#define DCP_ZPOS_MAX			255
> +#define DCP_MAX_IMG_WIDTH		0x3FFF
> +#define DCP_MAX_IMG_HEIGHT		0x3FFF
> +#define DCP_SSPP_MAX_PITCH_SIZE	0xFF00
> +#define DCP_MAX_UPSCALE_RATIO	20
> +#define DCP_MAX_DOWNSCALE_RATIO	4
> +
> +static const u32 dcp_plane_formats[] = {
> +	DRM_FORMAT_ARGB8888, DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_RGBX8888, DRM_FORMAT_BGRX8888,
> +	DRM_FORMAT_RGB888,   DRM_FORMAT_BGR888,
> +	DRM_FORMAT_RGB565,   DRM_FORMAT_BGR565,
> +	DRM_FORMAT_ARGB1555, DRM_FORMAT_ABGR1555,
> +	DRM_FORMAT_RGBA5551, DRM_FORMAT_BGRA5551,
> +	DRM_FORMAT_XRGB1555, DRM_FORMAT_XBGR1555,
> +	DRM_FORMAT_RGBX5551, DRM_FORMAT_BGRX5551,
> +	DRM_FORMAT_ARGB4444, DRM_FORMAT_ABGR4444,
> +	DRM_FORMAT_RGBA4444, DRM_FORMAT_BGRA4444,
> +	DRM_FORMAT_XRGB4444, DRM_FORMAT_XBGR4444,
> +	DRM_FORMAT_RGBX4444, DRM_FORMAT_BGRX4444,
> +	DRM_FORMAT_ARGB2101010, DRM_FORMAT_XRGB2101010,
> +	DRM_FORMAT_ABGR2101010, DRM_FORMAT_XBGR2101010,
> +	DRM_FORMAT_NV12, DRM_FORMAT_NV21,
> +	DRM_FORMAT_P010, DRM_FORMAT_YUV420, DRM_FORMAT_YVU420,
> +};
> +
> +static const u64 dcp_format_modifiers[] = {
> +	DRM_FORMAT_MOD_QCOM_COMPRESSED,
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID,
> +};
> +
> +static struct dcp_dpu_kms *_dcp_plane_get_kms(struct drm_plane *plane)
> +{
> +	struct msm_drm_private *priv = plane->dev->dev_private;
> +
> +	return to_dcp_dpu_kms(priv->kms);
> +}
> +
> +static bool dcp_plane_hfi_pipe_valid(struct dcp_dpu_kms *dcp_kms, u32 pipe_id)
> +{
> +	const struct dcp_caps *caps;
> +	u32 i;
> +
> +	if (!dcp_kms || !dcp_kms->caps)
> +		return false;
> +
> +	caps = dcp_kms->caps;
> +	for (i = 0; i < caps->num_vig_pipes; i++)
> +		if (caps->vig_pipe_ids[i] == pipe_id)
> +			return true;
> +
> +	for (i = 0; i < caps->num_dma_pipes; i++)
> +		if (caps->dma_pipe_ids[i] == pipe_id)
> +			return true;
> +
> +	return false;
> +}
> +
> +static bool dcp_plane_pipe_is_vig(const struct dcp_caps *caps, u32 pipe_id)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < caps->num_vig_pipes; i++)
> +		if (caps->vig_pipe_ids[i] == pipe_id)
> +			return true;
> +
> +	return false;
> +}
> +
> +static bool dcp_plane_pipe_busy(struct drm_atomic_commit *state,
> +				struct drm_plane *self, u32 pipe_id)
> +{
> +	struct drm_plane *plane;
> +	struct drm_plane_state *plane_state;
> +	struct drm_plane *iter_plane;
> +	struct drm_plane_state *new_plane_state;
> +	int i;
> +
> +	drm_for_each_plane(plane, state->dev) {
> +		if (plane == self)
> +			continue;
> +
> +		plane_state = plane->state;
> +		for_each_new_plane_in_state(state, iter_plane, new_plane_state, i) {
> +			if (iter_plane == plane) {
> +				plane_state = new_plane_state;
> +				break;
> +			}
> +		}
> +
> +		if (plane_state && plane_state->crtc && plane_state->visible &&
> +		    to_dcp_plane_state(plane_state)->hfi_pipe_id == pipe_id)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static u32 dcp_plane_assign_pipe(struct dcp_dpu_kms *dcp_kms,
> +				 struct drm_atomic_commit *state,
> +				 struct drm_plane *plane,
> +				 struct dcp_plane_state *pstate,
> +				 bool yuv, bool scaling)
> +{
> +	const struct dcp_caps *caps = dcp_kms->caps;
> +	u32 i, pipe_id;
> +
> +	/* YUV scanout requires a VIG pipe with the CSC path. */
> +	if (dcp_plane_hfi_pipe_valid(dcp_kms, pstate->hfi_pipe_id) &&
> +	    (!yuv || dcp_plane_pipe_is_vig(caps, pstate->hfi_pipe_id)) &&
> +	    (!scaling || dcp_plane_pipe_is_vig(caps, pstate->hfi_pipe_id)) &&
> +	    !dcp_plane_pipe_busy(state, plane, pstate->hfi_pipe_id))
> +		return pstate->hfi_pipe_id;
> +
> +	/*
> +	 * R1/virtual pipes are intentionally not allocated as independent
> +	 * planes yet. They require transactional physical-pipe/R1 ownership
> +	 * and multirect programming, which will be added with the resource
> +	 * manager.
> +	 */
> +	for (i = 0; i < caps->num_vig_pipes; i++) {
> +		pipe_id = caps->vig_pipe_ids[i];
> +		if (!dcp_plane_pipe_busy(state, plane, pipe_id))
> +			return pipe_id;
> +	}
> +
> +	if (yuv || scaling)
> +		return U32_MAX;
> +
> +	for (i = 0; i < caps->num_dma_pipes; i++) {
> +		pipe_id = caps->dma_pipe_ids[i];
> +		if (!dcp_plane_pipe_busy(state, plane, pipe_id))
> +			return pipe_id;
> +	}
> +
> +	return U32_MAX;
> +}
> +
> +static const struct {
> +	u32 fourcc;
> +	u64 modifier;
> +	u32 hfi_fmt;
> +} dcp_fmt_table[] = {
> +	{ DRM_FORMAT_ABGR8888,    DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_RGBA8888 },
> +	{ DRM_FORMAT_XBGR8888,    DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_RGBX8888 },
> +	{ DRM_FORMAT_ABGR2101010, DRM_FORMAT_MOD_QCOM_COMPRESSED,
> +		HFI_COLOR_FORMAT_UBWC_RGBA10_10_10_2 },
> +	{ DRM_FORMAT_XBGR2101010, DRM_FORMAT_MOD_QCOM_COMPRESSED,
> +		HFI_COLOR_FORMAT_UBWC_RGBX10_10_10_2 },
> +	{ DRM_FORMAT_BGR565,      DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_RGB565 },
> +	{ DRM_FORMAT_NV12,        DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_NV12 },
> +	{ DRM_FORMAT_P010,        DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_P010 },
> +
> +	{ DRM_FORMAT_RGB565,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGR565 },
> +	{ DRM_FORMAT_BGR565,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGB565 },
> +	{ DRM_FORMAT_RGB888,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGR888 },
> +	{ DRM_FORMAT_BGR888,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGB888 },
> +	{ DRM_FORMAT_ARGB8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA8888 },
> +	{ DRM_FORMAT_ABGR8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA8888 },
> +	{ DRM_FORMAT_RGBA8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR8888 },
> +	{ DRM_FORMAT_BGRA8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB8888 },
> +	{ DRM_FORMAT_XRGB8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX8888 },
> +	{ DRM_FORMAT_XBGR8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX8888 },
> +	{ DRM_FORMAT_RGBX8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR8888 },
> +	{ DRM_FORMAT_BGRX8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB8888 },
> +	{ DRM_FORMAT_ARGB2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA10_10_10_2 },
> +	{ DRM_FORMAT_ABGR2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA10_10_10_2 },
> +	{ DRM_FORMAT_RGBA1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR2_10_10_10 },
> +	{ DRM_FORMAT_BGRA1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB2_10_10_10 },
> +	{ DRM_FORMAT_XRGB2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX10_10_10_2 },
> +	{ DRM_FORMAT_XBGR2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX10_10_10_2 },
> +	{ DRM_FORMAT_RGBX1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR2_10_10_10 },
> +	{ DRM_FORMAT_BGRX1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB2_10_10_10 },
> +	{ DRM_FORMAT_ARGB1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA5551 },
> +	{ DRM_FORMAT_ABGR1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA5551 },
> +	{ DRM_FORMAT_RGBA5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR1555 },
> +	{ DRM_FORMAT_BGRA5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB1555 },
> +	{ DRM_FORMAT_XRGB1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX5551 },
> +	{ DRM_FORMAT_XBGR1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX5551 },
> +	{ DRM_FORMAT_RGBX5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR1555 },
> +	{ DRM_FORMAT_BGRX5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB1555 },
> +	{ DRM_FORMAT_ARGB4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA4444 },
> +	{ DRM_FORMAT_ABGR4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA4444 },
> +	{ DRM_FORMAT_RGBA4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR4444 },
> +	{ DRM_FORMAT_BGRA4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB4444 },
> +	{ DRM_FORMAT_XRGB4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX4444 },
> +	{ DRM_FORMAT_XBGR4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX4444 },
> +	{ DRM_FORMAT_RGBX4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR4444 },
> +	{ DRM_FORMAT_BGRX4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB4444 },
> +	{ DRM_FORMAT_YUV420,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_YU12 },
> +	{ DRM_FORMAT_YVU420,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_YV12 },
> +	{ DRM_FORMAT_NV12,         DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_NV12 },
> +	{ DRM_FORMAT_NV21,         DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_NV21 },
> +	{ DRM_FORMAT_P010,         DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_P010 },
> +};
> +
> +static u32 dcp_drm_to_hfi_format(u32 fourcc, u64 modifier)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dcp_fmt_table); i++) {
> +		if (dcp_fmt_table[i].fourcc == fourcc &&
> +		    dcp_fmt_table[i].modifier == modifier)
> +			return dcp_fmt_table[i].hfi_fmt;
> +	}
> +
> +	return U32_MAX;
> +}
> +
> +static u32 dcp_drm_to_hfi_rotation(u32 drm_rotation)
> +{
> +	u32 hfi_rot = 0;
> +
> +	if (drm_rotation & DRM_MODE_ROTATE_0)
> +		hfi_rot |= HFI_DISPLAY_ROTATION_0;
> +	if (drm_rotation & DRM_MODE_ROTATE_90)
> +		hfi_rot |= HFI_DISPLAY_ROTATION_90;
> +	if (drm_rotation & DRM_MODE_ROTATE_180)
> +		hfi_rot |= HFI_DISPLAY_ROTATION_180;
> +	if (drm_rotation & DRM_MODE_ROTATE_270)
> +		hfi_rot |= HFI_DISPLAY_ROTATION_270;
> +	if (drm_rotation & DRM_MODE_REFLECT_X)
> +		hfi_rot |= HFI_DISPLAY_REFLECT_X;
> +	if (drm_rotation & DRM_MODE_REFLECT_Y)
> +		hfi_rot |= HFI_DISPLAY_REFLECT_Y;
> +
> +	if (!hfi_rot)
> +		hfi_rot = HFI_DISPLAY_ROTATION_0;
> +
> +	return hfi_rot;
> +}
> +
> +static u32 dcp_drm_to_hfi_blend_op(u32 drm_blend_mode)
> +{
> +	switch (drm_blend_mode) {
> +	case DRM_MODE_BLEND_PIXEL_NONE:	return HFI_BLEND_OP_OPAQUE;
> +	case DRM_MODE_BLEND_PREMULTI:	return HFI_BLEND_OP_PREMULTIPLIED;
> +	case DRM_MODE_BLEND_COVERAGE:	return HFI_BLEND_OP_COVERAGE;
> +	default:			return HFI_BLEND_OP_NOT_DEFINED;
> +	}
> +}
> +
> +static u16 dcp_compute_bg_alpha(u32 pixel_blend_mode, u16 fg_alpha)
> +{
> +	switch (pixel_blend_mode) {
> +	case DRM_MODE_BLEND_PIXEL_NONE:
> +		return DRM_BLEND_ALPHA_OPAQUE - fg_alpha;
> +	case DRM_MODE_BLEND_PREMULTI:
> +	case DRM_MODE_BLEND_COVERAGE:
> +		return (fg_alpha != DRM_BLEND_ALPHA_OPAQUE) ? fg_alpha : 0;
> +	default:
> +		return DRM_BLEND_ALPHA_OPAQUE;
> +	}
> +}
> +
> +static u32 dcp_hfi_scale_alpha(const struct drm_plane_state *state, u32 alpha)
> +{
> +	if (!state || !state->crtc)
> +		return alpha << 8;
> +
> +	if (to_dcp_crtc_state(state->crtc->state)->topology_bits_per_component >= 10)
> +		return alpha;
> +
> +	return alpha << 8;
> +}
> +
> +static u64 dcp_plane_calc_bw(u32 bpp,
> +			     const struct drm_display_mode *mode,
> +			       const struct drm_rect *src,
> +			       const struct drm_rect *dst)
> +{
> +	int src_w = drm_rect_width(src) >> 16;
> +	int src_h = drm_rect_height(src) >> 16;
> +	int dst_h = drm_rect_height(dst);
> +	int fps   = drm_mode_vrefresh(mode);
> +	int vbp   = mode->vtotal - mode->vsync_end;
> +	int vpw   = mode->vsync_end - mode->vsync_start;
> +	int vfp   = mode->vsync_start - mode->vdisplay;
> +	u32 hw_latency = 25;
> +	u64 scale_factor = (src_h > dst_h) ? mult_frac(src_h, 1, dst_h) : 1;
> +	u64 plane_bw, prefill_bw;
> +
> +	plane_bw = (u64)src_w * mode->vtotal * fps * bpp * scale_factor;
> +	prefill_bw = plane_bw * hw_latency;
> +
> +	if ((vbp + vpw) > hw_latency)
> +		do_div(prefill_bw, (vbp + vpw));
> +	else if ((vbp + vpw + vfp) < hw_latency)
> +		do_div(prefill_bw, (vbp + vpw + vfp));
> +	else
> +		do_div(prefill_bw, hw_latency);
> +
> +	/* HFI DRAM/LLCC votes are expressed in Kbps. */
> +	return div_u64(max(plane_bw, prefill_bw), 1000);
> +}
> +
> +static u64 dcp_plane_calc_clk(const struct drm_display_mode *mode,
> +			      const struct drm_rect *src,
> +				const struct drm_rect *dst)
> +{
> +	int src_h = drm_rect_height(src) >> 16;
> +	int dst_w = drm_rect_width(dst);
> +	int dst_h = drm_rect_height(dst);
> +	int fps   = drm_mode_vrefresh(mode);
> +	u64 clk   = (u64)dst_w * mode->vtotal * fps;
> +
> +	if (src_h > dst_h) {
> +		clk *= src_h;
> +		do_div(clk, dst_h);
> +	}
> +	return clk;
> +}
> +
> +void dcp_plane_calc_perf(const struct drm_plane_state *state,
> +			 const struct drm_display_mode *mode,
> +			 struct dcp_plane_perf *perf)
> +{
> +	struct drm_rect src, dst;
> +	u32 bpp;
> +
> +	memset(perf, 0, sizeof(*perf));
> +
> +	if (!state || !state->visible || !state->fb || !mode || !mode->clock ||
> +	    !drm_mode_vrefresh(mode))
> +		return;
> +
> +	src = drm_plane_state_src(state);
> +	dst = drm_plane_state_dest(state);
> +	bpp = drm_format_info_bpp(state->fb->format, 0);
> +
> +	perf->fetch_bw = dcp_plane_calc_bw(bpp, mode, &src, &dst);
> +	perf->clk = dcp_plane_calc_clk(mode, &src, &dst);
> +}
> +
> +static inline u32 *prop_u32(u32 *p, u32 prop_id, u32 lid, u32 val)
> +{
> +	*p++ = HFI_PACK_KEY(prop_id, 0, 2);
> +	*p++ = lid;
> +	*p++ = val;
> +	return p;
> +}
> +
> +static inline u32 *prop_roi(u32 *p, u32 prop_id, u32 lid,
> +			    u32 x, u32 y, u32 w, u32 h)
> +{
> +	*p++ = HFI_PACK_KEY(prop_id, 0, 5);
> +	*p++ = lid;
> +	*p++ = x; *p++ = y; *p++ = w; *p++ = h;
> +	return p;
> +}
> +
> +static inline u32 *prop_attach(u32 *p, u32 lid)
> +{
> +	*p++ = HFI_PACK_KEY(HFI_PROPERTY_DISPLAY_ATTACH_LAYER, 0, 1);
> +	*p++ = lid;
> +	return p;
> +}
> +
> +static inline u32 *prop_src_addr(u32 *p, u32 lid,
> +				 const dma_addr_t *iova, u32 hfi_fmt)
> +{
> +	int i;
> +
> +	*p++ = HFI_PACK_KEY(HFI_PROPERTY_LAYER_SRC_ADDR, 0, 13);

Magic 13, which encodes a particular value for HFI_MAX_PLANES. I've
asked you previously to write a macro which takes variable number of
args and programs all of them, preventing a need to specify number of
args.

> +	*p++ = lid;
> +	for (i = 0; i < HFI_MAX_PLANES; i++)
> +		*p++ = lower_32_bits(iova[i]);
> +	for (i = 0; i < HFI_MAX_PLANES; i++)
> +		*p++ = upper_32_bits(iova[i]);

Who has invented this? Splitting addresses into two distinct arrays.

> +	*p++ = 0;       /* size */
> +	*p++ = 0;       /* version */
> +	*p++ = 0;       /* flags */
> +	*p++ = hfi_fmt; /* format */
> +	return p;
> +}
> +
> +static inline u32 *prop_stride(u32 *p, u32 lid, const u32 *pitches)
> +{
> +	int i;
> +
> +	*p++ = HFI_PACK_KEY(HFI_PROPERTY_LAYER_STRIDE, 0, 5);
> +	*p++ = lid;
> +	for (i = 0; i < 4; i++)
> +		*p++ = pitches[i];
> +	return p;
> +}
> +
> +static inline u32 *prop_cache_attr(u32 *p, u32 lid, u32 state, u32 op)
> +{
> +	*p++ = HFI_PACK_KEY(HFI_PROPERTY_LAYER_CACHE_ATTR, 0, 3);
> +	*p++ = lid;
> +	*p++ = state;
> +	*p++ = op;
> +	return p;
> +}
> +
> +static int dcp_plane_build_one_hfi_props_packet(struct dcp_plane_state *pstate,
> +						const struct drm_plane_state *state,
> +					      u32 session_id, u32 packet_id,
> +					      u8 *packet)
> +{
> +	struct drm_framebuffer *fb = state->fb;
> +	struct hfi_cmd_buff_hdl hdl;
> +	struct hfi_header_info hdr_info;
> +	struct hfi_packet_info pkt_info;
> +	u32 payload[128]; /* 128 dwords = 512 bytes, enough for all properties */

"640 KiB ought to be enough"

> +	u32 *p = payload;
> +	u32 *num_props_ptr;
> +	u32 num_props = 0;
> +	u32 hfi_format;
> +	u32 hfi_rotation;
> +	u32 hfi_blend_op;
> +	u32 pitches[4] = { 0 };
> +	dma_addr_t fb_iova[HFI_MAX_PLANES] = { 0 };
> +	u32 src_x, src_y, src_w, src_h;
> +	u32 dst_x, dst_y, dst_w, dst_h;
> +	u32 hfi_alpha, hfi_bg_alpha;
> +	u32 lid = pstate->hfi_pipe_id;
> +	int i, ret;
> +	u32 payload_words;
> +
> +	hfi_format = pstate->hfi_format;
> +
> +	hfi_rotation = dcp_drm_to_hfi_rotation(state->rotation);
> +	hfi_blend_op = dcp_drm_to_hfi_blend_op(state->pixel_blend_mode);
> +
> +	src_x = state->src_x >> 16;
> +	src_y = state->src_y >> 16;
> +	src_w = state->src_w >> 16;
> +	src_h = state->src_h >> 16;
> +	dst_x = state->crtc_x;
> +	dst_y = state->crtc_y;
> +	dst_w = state->crtc_w;
> +	dst_h = state->crtc_h;
> +
> +	hfi_alpha = dcp_hfi_scale_alpha(state, state->alpha);
> +	hfi_bg_alpha = dcp_hfi_scale_alpha(state,
> +					   dcp_compute_bg_alpha(state->pixel_blend_mode,
> +								state->alpha));
> +
> +	for (i = 0; i < 4 && i < fb->format->num_planes; i++)
> +		pitches[i] = fb->pitches[i];
> +
> +	for (i = 0; i < HFI_MAX_PLANES && i < fb->format->num_planes; i++)
> +		fb_iova[i] = msm_framebuffer_iova(fb, i);
> +
> +	num_props_ptr = p++;
> +
> +	p = prop_roi(p, HFI_PROPERTY_LAYER_SRC_ROI, lid,
> +		     src_x, src_y, src_w, src_h);
> +	num_props++;
> +
> +	p = prop_roi(p, HFI_PROPERTY_LAYER_DEST_ROI, lid,
> +		     dst_x, dst_y, dst_w, dst_h);
> +	num_props++;
> +
> +	p = prop_attach(p, lid);
> +	num_props++;
> +
> +	p = prop_src_addr(p, lid, fb_iova, hfi_format);
> +	num_props++;
> +
> +	p = prop_stride(p, lid, pitches);
> +	num_props++;
> +
> +	p = prop_u32(p, HFI_PROPERTY_LAYER_SRC_FORMAT, lid, hfi_format);
> +	num_props++;
> +
> +	p = prop_u32(p, HFI_PROPERTY_LAYER_ROTATION, lid, hfi_rotation);
> +	num_props++;
> +
> +	p = prop_cache_attr(p, lid,
> +			    HFI_CACHE_STATE_DISABLE,
> +			    HFI_CACHE_OP_TYPE_NONE);
> +	num_props++;
> +
> +	p = prop_u32(p, HFI_PROPERTY_LAYER_ZPOS, lid,
> +		     state->normalized_zpos);
> +	num_props++;
> +
> +	p = prop_u32(p, HFI_PROPERTY_LAYER_ALPHA, lid, hfi_alpha);
> +	num_props++;
> +
> +	p = prop_u32(p, HFI_PROPERTY_LAYER_BG_ALPHA, lid, hfi_bg_alpha);
> +	num_props++;
> +
> +	p = prop_u32(p, HFI_PROPERTY_LAYER_BLEND_TYPE, lid, hfi_blend_op);
> +	num_props++;
> +
> +	p = prop_u32(p, HFI_PROPERTY_LAYER_SRC_IMG_SIZE_W, lid,
> +		     pstate->src_img_w);
> +	num_props++;
> +
> +	p = prop_u32(p, HFI_PROPERTY_LAYER_SRC_IMG_SIZE_H, lid,
> +		     pstate->src_img_h);
> +	num_props++;
> +
> +	*num_props_ptr = num_props;
> +
> +	payload_words = p - payload;
> +
> +	hdl.cmd_buffer = packet;
> +	hdl.size       = DCP_PLANE_PROP_PKT_MAX_SIZE;
> +
> +	hdr_info.num_packets   = 0;
> +	hdr_info.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
> +	hdr_info.object_id     = session_id;
> +	hdr_info.header_id     = packet_id;
> +
> +	ret = hfi_create_header(&hdl, &hdr_info);
> +	if (ret)
> +		return ret;
> +
> +	pkt_info.cmd          = HFI_COMMAND_DISPLAY_SET_PROPERTY;
> +	pkt_info.id           = session_id & 0xFFFF;
> +	pkt_info.flags        = HFI_TX_FLAGS_NON_DISCARDABLE;
> +	pkt_info.packet_id    = packet_id;
> +	pkt_info.payload_type = HFI_PAYLOAD_U32_ARRAY;
> +	pkt_info.payload_size = payload_words * sizeof(u32);
> +	pkt_info.payload_ptr  = payload;
> +
> +	ret = hfi_create_full_packet(&hdl, &pkt_info);
> +	if (ret) {
> +		pstate->prop_pkt_size = 0;
> +		return ret;
> +	}
> +
> +	pstate->prop_pkt_size = hfi_get_header_size(&hdl);
> +
> +	dev_dbg(state->plane->dev->dev,
> +		"DCP_COMMIT p=%u pipe=%u src=%ux%u+%ux%u dst=%ux%u+%ux%u fmt=0x%x mod=0x%llx alpha=%u bg_alpha=%u props=%u words=%u size=%zu\n",
> +		 state->plane->base.id, lid, src_x, src_y, src_w, src_h,
> +		 dst_x, dst_y, dst_w, dst_h, hfi_format, fb->modifier,
> +		 hfi_alpha, hfi_bg_alpha, num_props, payload_words,
> +		 pstate->prop_pkt_size);
> +	return 0;
> +}
> +
> +static int dcp_plane_build_hfi_props_packet(struct dcp_plane_state *pstate,
> +					    const struct drm_plane_state *state,
> +					      u32 session_id, u32 packet_id)
> +{
> +	int ret;
> +
> +	pstate->prop_pkt_size = 0;
> +
> +	ret = dcp_plane_build_one_hfi_props_packet(pstate, state, session_id,
> +						   packet_id, pstate->prop_pkt);
> +	return ret;
> +}
> +
> +static int dcp_plane_prepare_fb(struct drm_plane *plane,
> +				struct drm_plane_state *new_state)
> +{
> +	int ret;
> +
> +	dev_dbg(plane->dev->dev,
> +		"plane%u: prepare_fb fb=%u\n",
> +		 plane->base.id,
> +		 new_state->fb ? new_state->fb->base.id : 0);
> +
> +	if (!new_state->fb)
> +		return 0;
> +
> +	ret = drm_gem_plane_helper_prepare_fb(plane, new_state);
> +	if (ret)
> +		return ret;
> +
> +	ret = msm_framebuffer_prepare(new_state->fb, false);
> +	if (ret) {
> +		DRM_ERROR("plane%u: framebuffer prepare failed: %d\n",
> +			  plane->base.id, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void dcp_plane_cleanup_fb(struct drm_plane *plane,
> +				 struct drm_plane_state *old_state)
> +{
> +	dev_dbg(plane->dev->dev,
> +		"plane%u: cleanup_fb fb=%u\n",
> +		 plane->base.id,
> +		 old_state->fb ? old_state->fb->base.id : 0);
> +
> +	if (!old_state->fb)
> +		return;
> +
> +	msm_framebuffer_cleanup(old_state->fb, false);
> +}
> +
> +static int dcp_plane_atomic_check(struct drm_plane *plane,
> +				  struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_state =
> +		drm_atomic_get_new_plane_state(state, plane);
> +	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
> +	struct dcp_dpu_kms *dcp_kms = _dcp_plane_get_kms(plane);
> +	struct drm_crtc_state *crtc_state = NULL;
> +	struct drm_rect src;
> +	struct drm_rect fb_rect = { 0 };
> +	u32 max_width, max_height;
> +	int min_scale = DRM_PLANE_NO_SCALING;
> +	int max_scale = DRM_PLANE_NO_SCALING;
> +	bool scaling;
> +	int ret, i;
> +	struct dcp_plane_perf perf;
> +
> +	dev_dbg(plane->dev->dev,
> +		"DCP_CHECK plane%u pipe=%u src=(%u,%u %ux%u) dst=(%d,%d %ux%u)\n",
> +			plane->base.id, pstate->hfi_pipe_id,
> +			new_state->src_x >> 16, new_state->src_y >> 16,
> +			new_state->src_w >> 16, new_state->src_h >> 16,
> +			new_state->crtc_x, new_state->crtc_y,
> +			new_state->crtc_w, new_state->crtc_h);
> +
> +	pstate->valid = false;
> +	pstate->prop_pkt_size = 0;
> +	pstate->fetch_bw = 0;
> +	pstate->clk = 0;
> +
> +	if (!new_state->crtc)
> +		return 0;
> +
> +	crtc_state = drm_atomic_get_new_crtc_state(state, new_state->crtc);
> +	if (IS_ERR(crtc_state)) {
> +		ret = PTR_ERR(crtc_state);
> +		dev_err(plane->dev->dev, "plane%u: failed to get CRTC state: %d\n",
> +			plane->base.id, ret);
> +		return ret;
> +	}
> +
> +	if (!new_state->fb)
> +		return 0;
> +
> +	scaling = new_state->src_w != ((u32)new_state->crtc_w << 16) ||
> +			  new_state->src_h != ((u32)new_state->crtc_h << 16);
> +
> +	pstate->hfi_pipe_id = dcp_plane_assign_pipe(dcp_kms, state, plane,
> +						    pstate, new_state->fb->format->is_yuv,
> +						scaling);
> +	if (pstate->hfi_pipe_id == U32_MAX) {
> +		dev_err(plane->dev->dev, "plane%u: no compatible HFI pipe available\n",
> +			plane->base.id);
> +		return -ENOSPC;
> +	}
> +
> +	if (dcp_plane_pipe_is_vig(dcp_kms->caps, pstate->hfi_pipe_id)) {
> +		min_scale = FRAC_16_16(1, DCP_MAX_UPSCALE_RATIO);
> +		max_scale = DCP_MAX_DOWNSCALE_RATIO << 16;
> +	}
> +
> +	ret = drm_atomic_helper_check_plane_state(new_state, crtc_state,
> +						  min_scale, max_scale,
> +						  true, true);
> +	if (ret) {
> +		dev_err(plane->dev->dev, "plane%u: plane state check failed: %d\n",
> +			plane->base.id, ret);
> +		return ret;
> +	}
> +
> +	if (!new_state->visible)
> +		return 0;
> +	if (new_state->crtc_x < 0 || new_state->crtc_y < 0 ||
> +	    new_state->crtc_w <= 0 || new_state->crtc_h <= 0 ||
> +	    (u64)new_state->crtc_x + new_state->crtc_w >
> +			crtc_state->adjusted_mode.hdisplay ||
> +	    (u64)new_state->crtc_y + new_state->crtc_h >
> +			crtc_state->adjusted_mode.vdisplay) {
> +		dev_err(plane->dev->dev,
> +			"plane%u: destination out of bounds: (%d,%d %ux%u), mode %ux%u\n",
> +			plane->base.id, new_state->crtc_x, new_state->crtc_y,
> +			new_state->crtc_w, new_state->crtc_h,
> +			crtc_state->adjusted_mode.hdisplay,
> +			crtc_state->adjusted_mode.vdisplay);
> +		return -EINVAL;
> +	}
> +
> +	if (new_state->normalized_zpos >= DCP_MAX_BLEND_STAGES) {
> +		dev_err(plane->dev->dev,
> +			"plane%u: zpos %u exceeds blend stages %u\n",
> +			plane->base.id, new_state->normalized_zpos,
> +			DCP_MAX_BLEND_STAGES);
> +		return -EINVAL;
> +	}
> +
> +	dcp_plane_calc_perf(new_state, &crtc_state->adjusted_mode, &perf);
> +	pstate->fetch_bw = perf.fetch_bw;
> +	pstate->clk = perf.clk;
> +
> +	pstate->hfi_format = dcp_drm_to_hfi_format(new_state->fb->format->format,
> +						   new_state->fb->modifier);
> +	if (pstate->hfi_format == U32_MAX) {
> +		drm_dbg_atomic(plane->dev, "plane%u: unsupported format 0x%x mod 0x%llx\n",
> +			       plane->base.id,
> +				 new_state->fb->format->format,
> +				 new_state->fb->modifier);
> +		dev_err(plane->dev->dev,
> +			"plane%u: unsupported format 0x%x modifier 0x%llx\n",
> +			plane->base.id, new_state->fb->format->format,
> +			new_state->fb->modifier);
> +		return -EINVAL;
> +	}
> +
> +	fb_rect.x2 = new_state->fb->width;
> +	fb_rect.y2 = new_state->fb->height;
> +
> +	if (drm_rect_width(&fb_rect) > DCP_MAX_IMG_WIDTH ||
> +	    drm_rect_height(&fb_rect) > DCP_MAX_IMG_HEIGHT) {
> +		dev_err(plane->dev->dev,
> +			"plane%u: framebuffer too large: %ux%u (limit %ux%u)\n",
> +			plane->base.id, new_state->fb->width, new_state->fb->height,
> +			DCP_MAX_IMG_WIDTH, DCP_MAX_IMG_HEIGHT);
> +		return -E2BIG;
> +	}
> +
> +	dcp_mode_limits(&crtc_state->adjusted_mode,
> +			dcp_kms->caps->max_width, dcp_kms->caps->max_height,
> +			&max_width, &max_height);
> +
> +	if (new_state->fb->width > max_width ||
> +	    new_state->fb->height > max_height) {
> +		dev_err(plane->dev->dev,
> +			"plane%u: framebuffer %ux%u exceeds caps %ux%u\n",
> +			plane->base.id, new_state->fb->width, new_state->fb->height,
> +			dcp_kms->caps->max_width, dcp_kms->caps->max_height);
> +		return -E2BIG;
> +	}
> +
> +	for (i = 0; i < new_state->fb->format->num_planes; i++) {
> +		if (new_state->fb->pitches[i] > DCP_SSPP_MAX_PITCH_SIZE) {
> +			dev_err(plane->dev->dev,
> +				"plane%u: pitch[%d]=%u exceeds limit %u\n",
> +				plane->base.id, i, new_state->fb->pitches[i],
> +				DCP_SSPP_MAX_PITCH_SIZE);
> +			return -E2BIG;
> +		}
> +	}
> +
> +	src = drm_plane_state_src(new_state);
> +
> +	pstate->src_img_w = new_state->fb->width;
> +	pstate->src_img_h = new_state->fb->height;
> +
> +	if (new_state->fb->format->is_yuv) {
> +		u32 src_x = src.x1 >> 16;
> +		u32 src_y = src.y1 >> 16;
> +		u32 src_w = drm_rect_width(&src) >> 16;
> +		u32 src_h = drm_rect_height(&src) >> 16;
> +
> +		if (src_w < 2 || src_h < 2) {
> +			dev_err(plane->dev->dev,
> +				"plane%u: YUV source too small: %ux%u\n",
> +				plane->base.id, src_w, src_h);
> +			return -EINVAL;
> +		}
> +
> +		if (src_x & 0x1 || src_y & 0x1 || src_w & 0x1 || src_h & 0x1) {
> +			dev_err(plane->dev->dev,
> +				"plane%u: unaligned YUV source: (%u,%u %ux%u)\n",
> +				plane->base.id, src_x, src_y, src_w, src_h);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void dcp_plane_set_hfi_error(const struct drm_plane_state *state, int ret)
> +{
> +	struct dcp_crtc_state *cstate;
> +
> +	if (!state || !state->crtc || !state->crtc->state)
> +		return;
> +
> +	cstate = to_dcp_crtc_state(state->crtc->state);
> +	if (!cstate->hfi_error)
> +		cstate->hfi_error = ret;
> +}
> +
> +static int dcp_plane_submit_update(struct drm_plane *plane,
> +				   struct drm_plane_state *new_state)
> +{
> +	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
> +	struct dcp_dpu_kms *dcp_kms = _dcp_plane_get_kms(plane);
> +	u32 session_id;
> +	int ret;
> +
> +	if (!dcp_kms->hfi)
> +		return 0;
> +
> +	if (!dcp_crtc_get_session(new_state->crtc, &session_id)) {
> +		dev_dbg(plane->dev->dev,
> +			"plane%u: update before HFI session open, deferring\n",
> +			plane->base.id);
> +		return 0;
> +	}
> +
> +	pstate->prop_pkt_id =
> +		(u32)atomic_inc_return(&dcp_kms->hfi->packet_id);
> +
> +	ret = dcp_plane_build_hfi_props_packet(pstate, new_state, session_id,
> +					       pstate->prop_pkt_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = dcp_hfi_submit_prop_pkt(dcp_kms->hfi, pstate->prop_pkt,
> +				      pstate->prop_pkt_size);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(plane->dev->dev,
> +		"plane%u: submitted HFI update pipe=%u bytes=%zu\n",
> +		plane->base.id, pstate->hfi_pipe_id, pstate->prop_pkt_size);
> +
> +	return 0;
> +}
> +
> +static int dcp_plane_submit_disable(struct drm_plane *plane,
> +				    struct drm_plane_state *old_state)
> +{
> +	struct dcp_plane_state *pstate = to_dcp_plane_state(old_state);
> +	struct dcp_dpu_kms *dcp_kms = _dcp_plane_get_kms(plane);
> +	u32 session_id;
> +
> +	if (!old_state->crtc || !dcp_kms->hfi)
> +		return 0;
> +
> +	if (!dcp_crtc_get_session(old_state->crtc, &session_id)) {
> +		dev_dbg(plane->dev->dev,
> +			"plane%u: disable after HFI session close, skipping detach\n",
> +			plane->base.id);
> +		return 0;
> +	}
> +
> +	return dcp_hfi_plane_disable(dcp_kms->hfi, session_id,
> +				     pstate->hfi_pipe_id);
> +}
> +
> +static void dcp_plane_atomic_update(struct drm_plane *plane,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_state =
> +		drm_atomic_get_new_plane_state(state, plane);
> +	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
> +	int ret;
> +
> +	dev_dbg(plane->dev->dev,
> +		"plane%u: atomic_update visible=%d fb=%u pipe_id=%u\n",
> +		 plane->base.id, new_state->visible,
> +		 new_state->fb ? new_state->fb->base.id : 0,
> +		 pstate->hfi_pipe_id);
> +
> +	pstate->valid = false;
> +	pstate->prop_pkt_size = 0;
> +
> +	if (!new_state->visible || !new_state->fb)
> +		return;
> +
> +	ret = dcp_plane_submit_update(plane, new_state);
> +	if (ret) {
> +		dev_err(plane->dev->dev,
> +			"plane%u: HFI update failed: %d\n", plane->base.id, ret);
> +		dcp_plane_set_hfi_error(new_state, ret);
> +		return;
> +	}
> +
> +	pstate->valid = true;
> +}
> +
> +static void dcp_plane_atomic_disable(struct drm_plane *plane,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *old_state =
> +		drm_atomic_get_old_plane_state(state, plane);
> +	struct dcp_plane_state *pstate = to_dcp_plane_state(old_state);
> +	int ret;
> +
> +	dev_dbg(plane->dev->dev,
> +		"plane%u: atomic_disable pipe_id=%u\n",
> +		 plane->base.id, pstate->hfi_pipe_id);
> +
> +	ret = dcp_plane_submit_disable(plane, old_state);
> +	if (ret) {
> +		dev_err(plane->dev->dev,
> +			"plane%u: HFI detach failed: %d\n", plane->base.id, ret);
> +		dcp_plane_set_hfi_error(old_state, ret);
> +	}
> +
> +	pstate->valid = false;
> +	pstate->prop_pkt_size = 0;
> +	pstate->prop_pkt_id = 0;
> +}
> +
> +static struct drm_plane_state *
> +dcp_plane_atomic_duplicate_state(struct drm_plane *plane)
> +{
> +	struct dcp_plane_state *pstate, *old_pstate;
> +
> +	if (WARN_ON(!plane->state))
> +		return NULL;
> +
> +	old_pstate = to_dcp_plane_state(plane->state);
> +	pstate = kzalloc_obj(*pstate, GFP_KERNEL);
> +	if (!pstate)
> +		return NULL;
> +
> +	__drm_atomic_helper_plane_duplicate_state(plane, &pstate->base);
> +	pstate->hfi_pipe_id     = old_pstate->hfi_pipe_id;
> +	pstate->src_img_w       = old_pstate->src_img_w;
> +	pstate->src_img_h       = old_pstate->src_img_h;
> +	pstate->fetch_bw       = old_pstate->fetch_bw;
> +	pstate->clk            = old_pstate->clk;
> +	pstate->valid           = false;
> +	pstate->prop_pkt_size   = 0;
> +	pstate->prop_pkt_id     = old_pstate->prop_pkt_id;
> +
> +	return &pstate->base;
> +}
> +
> +static void dcp_plane_atomic_destroy_state(struct drm_plane *plane,
> +					   struct drm_plane_state *state)
> +{
> +	__drm_atomic_helper_plane_destroy_state(state);
> +	kfree(to_dcp_plane_state(state));
> +}
> +
> +static void dcp_plane_reset(struct drm_plane *plane)
> +{
> +	struct dcp_plane_state *pstate;
> +	u32 hfi_pipe_id = to_dcp_plane(plane)->hfi_pipe_id;
> +
> +	if (plane->state) {
> +		dcp_plane_atomic_destroy_state(plane, plane->state);
> +		plane->state = NULL;
> +	}
> +
> +	pstate = kzalloc(sizeof(*pstate), GFP_KERNEL);
> +	if (!pstate)
> +		return;
> +
> +	__drm_atomic_helper_plane_reset(plane, &pstate->base);
> +	pstate->hfi_pipe_id = hfi_pipe_id;
> +}
> +
> +static void dcp_plane_atomic_print_state(struct drm_printer *p,
> +					 const struct drm_plane_state *state)
> +{
> +	const struct dcp_plane_state *pstate = to_dcp_plane_state(state);
> +
> +	drm_printf(p, "\tvalid=%d\n", pstate->valid);
> +	drm_printf(p, "\tprop_pkt_size=%zu\n", pstate->prop_pkt_size);
> +	drm_printf(p, "\thfi_pipe_id=%u\n", pstate->hfi_pipe_id);
> +
> +	if (pstate->valid) {
> +		u32 hfi_rot = dcp_drm_to_hfi_rotation(state->rotation);
> +
> +		drm_printf(p, "\thfi_format=0x%x\n", pstate->hfi_format);
> +		drm_printf(p, "\thfi_rotation=0x%x\n", hfi_rot);
> +	}
> +}
> +
> +static bool dcp_plane_format_mod_supported(struct drm_plane *plane,
> +					   u32 format, uint64_t modifier)
> +{
> +	if (modifier == DRM_FORMAT_MOD_LINEAR)
> +		return true;
> +
> +	if (modifier == DRM_FORMAT_MOD_QCOM_COMPRESSED)
> +		return dcp_drm_to_hfi_format(format, modifier) != U32_MAX;
> +
> +	return false;
> +}
> +
> +static const struct drm_plane_helper_funcs dcp_plane_helper_funcs = {
> +	.prepare_fb     = dcp_plane_prepare_fb,
> +	.cleanup_fb     = dcp_plane_cleanup_fb,
> +	.atomic_check   = dcp_plane_atomic_check,
> +	.atomic_update  = dcp_plane_atomic_update,
> +	.atomic_disable = dcp_plane_atomic_disable,
> +};
> +
> +static const struct drm_plane_funcs dcp_plane_funcs = {
> +	.update_plane           = drm_atomic_helper_update_plane,
> +	.disable_plane          = drm_atomic_helper_disable_plane,
> +	.reset                  = dcp_plane_reset,
> +	.atomic_duplicate_state = dcp_plane_atomic_duplicate_state,
> +	.atomic_destroy_state   = dcp_plane_atomic_destroy_state,
> +	.format_mod_supported   = dcp_plane_format_mod_supported,
> +	.atomic_print_state     = dcp_plane_atomic_print_state,
> +};
> +
> +struct drm_plane *dcp_plane_init(struct drm_device *dev,
> +				 u32 hfi_pipe_id,
> +				   enum drm_plane_type type,
> +				   unsigned long possible_crtcs)
> +{
> +	struct dcp_plane *dcp_plane;
> +	struct drm_plane *plane;
> +	int ret;
> +
> +	dcp_plane = drmm_universal_plane_alloc(dev, struct dcp_plane, base,
> +					       possible_crtcs,
> +					   &dcp_plane_funcs,
> +					   dcp_plane_formats,
> +					   ARRAY_SIZE(dcp_plane_formats),
> +					   dcp_format_modifiers,
> +					   type, NULL);
> +	if (IS_ERR(dcp_plane))
> +		return ERR_CAST(dcp_plane);
> +
> +	plane = &dcp_plane->base;
> +	drm_plane_helper_add(plane, &dcp_plane_helper_funcs);
> +
> +	ret = drm_plane_create_zpos_property(plane, 0, 0, DCP_ZPOS_MAX);
> +	if (ret)
> +		drm_dbg_driver(plane->dev, "plane%u: zpos property failed\n", hfi_pipe_id);
> +
> +	drm_plane_create_alpha_property(plane);
> +
> +	drm_plane_create_blend_mode_property(plane,
> +					     BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> +		BIT(DRM_MODE_BLEND_PREMULTI) |
> +		BIT(DRM_MODE_BLEND_COVERAGE));
> +
> +	drm_plane_create_rotation_property(plane,
> +					   DRM_MODE_ROTATE_0,
> +		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
> +		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270 |
> +		DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y);
> +
> +	drm_plane_enable_fb_damage_clips(plane);
> +
> +	dcp_plane->hfi_pipe_id = hfi_pipe_id;
> +	if (plane->state)
> +		to_dcp_plane_state(plane->state)->hfi_pipe_id = hfi_pipe_id;
> +
> +	dev_dbg(dev->dev, "plane initialized (type=%d, hfi_pipe_id=%u)\n",
> +		type, hfi_pipe_id);
> +	return plane;
> +}
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_plane.h b/drivers/gpu/drm/msm/dcp/dcp_plane.h
> new file mode 100644
> index 000000000000..685e78c547da
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_plane.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP plane state and HFI property packet definitions.
> + */
> +
> +#ifndef __DCP_PLANE_H__
> +#define __DCP_PLANE_H__
> +
> +#include <drm/drm_plane.h>
> +
> +struct dcp_dpu_kms;
> +struct drm_display_mode;
> +
> +struct dcp_plane_perf {
> +	u64 fetch_bw;
> +	u64 clk;
> +};
> +
> +#define DCP_PLANE_PROP_PKT_MAX_SIZE	512
> +
> +struct dcp_plane {
> +	struct drm_plane base;
> +	u32 hfi_pipe_id;
> +};
> +
> +#define to_dcp_plane(x) container_of(x, struct dcp_plane, base)
> +
> +struct dcp_plane_state {
> +	struct drm_plane_state base;
> +
> +	u64 fetch_bw;
> +	u64 clk;
> +
> +	u8     prop_pkt[DCP_PLANE_PROP_PKT_MAX_SIZE];
> +	size_t prop_pkt_size;
> +	u32 prop_pkt_id;
> +
> +	bool valid;

How can it be invalid?

> +
> +	u32 src_img_w;
> +	u32 src_img_h;
> +
> +	u32 hfi_pipe_id;
> +	u32 hfi_format;
> +};
> +
> +#define to_dcp_plane_state(x) \
> +	container_of(x, struct dcp_plane_state, base)
> +
> +void dcp_plane_calc_perf(const struct drm_plane_state *state,
> +			 const struct drm_display_mode *mode,
> +			 struct dcp_plane_perf *perf);
> +struct drm_plane *dcp_plane_init(struct drm_device *dev,
> +				 u32 hfi_pipe_id,
> +				   enum drm_plane_type type,
> +				   unsigned long possible_crtcs);
> +
> +#endif /* __DCP_PLANE_H__ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
