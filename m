Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7492B109E549
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 05:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21CD10E8E8;
	Thu, 26 Mar 2026 05:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TwloJN/E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ymu6dc2+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C5410E8DF
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 05:06:16 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PKhe4t142445
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 05:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kX/Q4tA/GGa5kkY3FZPPynvH5D47EXWFc+DBBlWPBDw=; b=TwloJN/EuipuqjgI
 ewx4ZWUoLxUzztkbX8sN4O8oWa/BefS83UksG56Ds8pzxKKR+CA2XsMKKwqOqSmh
 eiuDd3ojea2YJNNvzA1qhC3yC2Kj7G6xd4nLJk5DxcQhrSWb7HGiFeiyq1EKQ5qT
 wsZ1Xib8AuBQsGchz+JAQ3b5grWLJwMg8b/3RYd+2zRv4DV86uMTvfAyIDDL+Gvt
 aljeE66UU8CVMreOnssvgqueIsK8ZzD4A4gbebKZQVnv3IPWNDxJl/ubN+fgjlbO
 B0hl+kBG/o/rnEmvOimIr6LTNj6OAYbwoT/gs1qWH5AbU0014PcQWUyTQyoXV69I
 u7GWRw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q091a6n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 05:06:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35c1107da15so899280a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 22:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774501576; x=1775106376;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kX/Q4tA/GGa5kkY3FZPPynvH5D47EXWFc+DBBlWPBDw=;
 b=Ymu6dc2+Iq0xSO1GSm4VDqf/7cvA2chRD05XIOxdRY45Ky9Om6hI5A/p2MWovsjTla
 34N6jTaGzTfs6vhvKIMEy18Sp0Pg8T4qoedNnlMBuWFTstXLWqPiVG0gJ33LOfvWcPvt
 3KzA/tVuMI2AMmzg0Oc4OKuAbSEBqFBcMwyv2Rpw5d4rUKiSg/YEnCDexVRxFjQi69dO
 ZBUe7SACe6xDQnOIj6gp4Ei4NKwEeh0kRCzkwwLpAAsxN8nM/Vx1Tyg4VdQ82tgWPTm7
 YTVDytOfgH7iG+LjUpVE6q9ge3zY9oz/hUeasu9nKrBNhFohzXlq/3q6+n4A6Ls3kObV
 d8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774501576; x=1775106376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kX/Q4tA/GGa5kkY3FZPPynvH5D47EXWFc+DBBlWPBDw=;
 b=NtJpUV0QwAE9RT7XBPGRuRxBsxlj2ERSCl6cik1ZtMn2LHHNzVXz0AAqPPO3a56DEm
 jl78pEJIwms33lGOTTAAL2ie6TPUVUV9zj0YumBb1shtEBYZxrNXA77lbXQ5oiJJ4s43
 ImSSZ/kbv5za+OBxqPiHEuVU68K0QSp85Zkh4oIJDS1IQCJuOmT/iV3IcYpkAJa1o1xl
 tSO6egIByDMkWn0cTGNZ2Ukm+ynMgKeTxafpyzfpOxH4Qod+EleooymB081vVKrmCNXb
 2AoPJ4QtrlUuCPjVfqSWVqw72vooYKJ9O2KHsCvUbDTRyvTxy/lp4PRW9qqv/nnrFBNA
 hpiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDX+B/B6FL28LFFdmKBapWyNfFFiYnulLk6nYSylxDGMrm9gLLaSF7siyVn7Wkv/vEya+h//RJ7Kc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGvsQxyCOnehEfrYOQzu/ashUcrOzJLGkkcvB1mWBJoey5w4Qf
 pd/eIljGvO0LjYNdcLNpI+6rR0C4fw54t4zPkXcq5+qDn2+3y+tdBif/npVOq7Mp28ZkV7aPIyo
 S4qWXv1Nu3vDuQCbvoYCW3oHtg/2EjsU4MPhG6EnrkhidAdCQWlTyzJQ39qRGMEU7izyMmVc=
X-Gm-Gg: ATEYQzyrKr9gI0SaMzhudZXLLZPPDSbkRSfcvBPl6eOBEUpiAXeDtkNrSSaLAgJcRIJ
 PBHxYRNguYcH4JrmMhKY8COJnawYeJHVoeIKldkLKVo1N57DDadkvu9WeagSJ+KZMyg/3e+Ybe7
 LXR4CKgrJlhRBfE63FJhFm4hxSyhog/ynQaRGXiRBnnRJKTv98JNPu0TGYqRbFLQBWgeODIDYwH
 a/bVqCkUHvcnMXO9RwxfB6/17VV0YXRvNjT09zuf2La0rb3jrO6v9vCjOri4A41+apdyY0+v+ym
 AV7ZWXmrfCsl6+v8hzdCpWhBGt4DkpahUpvqi9SiC08dWY9SPqQhF6wZXgWQ21mla/rySo8/5p7
 4YpaWKJKFKUOdJOvgNcjDVJ5H6QW5CmuC7BsOc8pfAXXXemN6OkRLUg==
X-Received: by 2002:a17:90b:4a03:b0:35b:9cd5:232e with SMTP id
 98e67ed59e1d1-35c0dd95865mr5470197a91.29.1774501575454; 
 Wed, 25 Mar 2026 22:06:15 -0700 (PDT)
X-Received: by 2002:a17:90b:4a03:b0:35b:9cd5:232e with SMTP id
 98e67ed59e1d1-35c0dd95865mr5470167a91.29.1774501574933; 
 Wed, 25 Mar 2026 22:06:14 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.231]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22d09429sm198541a91.17.2026.03.25.22.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 22:06:14 -0700 (PDT)
Message-ID: <56860faf-3f74-daeb-3d19-a35243172317@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 10:36:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 3/9] media: iris: retrieve UBWC platform configuration
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Wangao Wang <wangao.wang@oss.qualcomm.com>
References: <20260125-iris-ubwc-v4-0-1ff30644ac81@oss.qualcomm.com>
 <20260125-iris-ubwc-v4-3-1ff30644ac81@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20260125-iris-ubwc-v4-3-1ff30644ac81@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fufRpV4f c=1 sm=1 tr=0 ts=69c4bec8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=n9i7a1ABM4vdrNuulSdbnA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=74htzXLwVZE36vefv0kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: K0TlUckCftirqDR6_F7ArWG1Oo8xH09w
X-Proofpoint-ORIG-GUID: K0TlUckCftirqDR6_F7ArWG1Oo8xH09w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAzNyBTYWx0ZWRfXyT2nV2TKdbjS
 XlBayb87dz4sqnxUDH4f+s4h7inhI14P/8itZ6i+ZG82SedTAzlp1n0nWkCvOIBnoGuZbHheZrZ
 RZ7WRQVqGoExvAYtLCBFjOlnjaxZN1LG32iOY5Zf2O+DcoaNILudTBe7uMZpE2ZBFk7Eq47qyyE
 g+d2dJ04DWk8R12JL6ZcBCv6mz5OsXOMrFgao2zJkRA9N8Kti6FAGrD+dBS34cYrM8WfPU/wVNB
 Y+xvt/HpnNAZ17s3nUcXHxshFhH2iarQhDI15EO1j/GHYlLSNvk/PX8KrdZT0os3PBoDt4d8Z7Z
 GCCt9iVHbT/g7OxfbbIrq34ZyKqftTZWdGIkyzwyitSJqzb2jDKnClsicKLi6PLEDURYj7eaWZE
 1PSspplQiaXZz2ov7rw0nf157OcKindJjVQLLiBhNLd5MvkZEKOJEpvrxVXC4o6t2De+Y1PSO3l
 lXBC8PT+QyuwfrrakIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260037
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



On 1/25/2026 5:00 PM, Dmitry Baryshkov wrote:
> Specifying UBWC data in each driver doesn't scale and is prone to
> errors. Request UBWC data from the central database in preparation to
> using it through the rest of the driver.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Kconfig      | 1 +
>  drivers/media/platform/qcom/iris/iris_core.h  | 4 ++++
>  drivers/media/platform/qcom/iris/iris_probe.c | 5 +++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
> index 3c803a05305a..39b06de6c3e6 100644
> --- a/drivers/media/platform/qcom/iris/Kconfig
> +++ b/drivers/media/platform/qcom/iris/Kconfig
> @@ -5,6 +5,7 @@ config VIDEO_QCOM_IRIS
>          select V4L2_MEM2MEM_DEV
>          select QCOM_MDT_LOADER if ARCH_QCOM
>          select QCOM_SCM
> +        select QCOM_UBWC_CONFIG
>          select VIDEOBUF2_DMA_CONTIG
>          help
>            This is a V4L2 driver for Qualcomm iris video accelerator
> diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
> index fb194c967ad4..d10a03aa5685 100644
> --- a/drivers/media/platform/qcom/iris/iris_core.h
> +++ b/drivers/media/platform/qcom/iris/iris_core.h
> @@ -30,6 +30,8 @@ enum domain_type {
>  	DECODER	= BIT(1),
>  };
>  
> +struct qcom_ubwc_cfg_data;
> +
>  /**
>   * struct iris_core - holds core parameters valid for all instances
>   *
> @@ -52,6 +54,7 @@ enum domain_type {
>   * @resets: table of iris reset clocks
>   * @controller_resets: table of controller reset clocks
>   * @iris_platform_data: a structure for platform data
> + * @ubwc_cfg: UBWC configuration for the platform
>   * @state: current state of core
>   * @iface_q_table_daddr: device address for interface queue table memory
>   * @sfr_daddr: device address for SFR (Sub System Failure Reason) register memory
> @@ -95,6 +98,7 @@ struct iris_core {
>  	struct reset_control_bulk_data		*resets;
>  	struct reset_control_bulk_data		*controller_resets;
>  	const struct iris_platform_data		*iris_platform_data;
> +	const struct qcom_ubwc_cfg_data		*ubwc_cfg;
>  	enum iris_core_state			state;
>  	dma_addr_t				iface_q_table_daddr;
>  	dma_addr_t				sfr_daddr;
> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
> index ddaacda523ec..492f85f518eb 100644
> --- a/drivers/media/platform/qcom/iris/iris_probe.c
> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
> @@ -10,6 +10,7 @@
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> +#include <linux/soc/qcom/ubwc.h>
>  
>  #include "iris_core.h"
>  #include "iris_ctrls.h"
> @@ -244,6 +245,10 @@ static int iris_probe(struct platform_device *pdev)
>  
>  	core->iris_platform_data = of_device_get_match_data(core->dev);
>  
> +	core->ubwc_cfg = qcom_ubwc_config_get_data();
> +	if (IS_ERR(core->ubwc_cfg))
> +		return PTR_ERR(core->ubwc_cfg);

Afterthought: This change assumes that the presence of a UBWC config
implies Iris UBWC support. However, some platforms (e.g. qcm2290) do have
UBWC data defined at the SoC level but do not support UBWC in the video
firmware, which could potentially surface during SYS_INIT if UBWC is
advertised unconditionally, so this might be worth double‑checking.

Thanks,
Dikshita

> +
>  	ret = devm_request_threaded_irq(core->dev, core->irq, iris_hfi_isr,
>  					iris_hfi_isr_handler, IRQF_TRIGGER_HIGH, "iris", core);
>  	if (ret)
> 
