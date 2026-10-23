Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FEF606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KmLmmive;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f+wXs+5L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E022010E56C;
	Fri, 23 Oct 2026 07:00:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3184410E052
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:00:44 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1Etor2389426
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TSBqvXX7rnpjqt8rxFBv9WYb5CVV2ARyX91j3W4WjFs=; b=KmLmmiveV0bumqez
 d+39v60GZ0o3u6v8RIUZmkjA8wkDduHbSvlM5WzuzWYQ4H1wLyy29DqdB6LBUBZj
 Y3D5V9S/QvwMZ/+826aOuW2tgoMWQ9Rt/Ajpv3xka5wE86Y/dZ5HZmMJ6tHA5Wrg
 k+LV9c0bupHxatk8gpYgCKPgNcLDmPnFThFJ/lsKwk0B0NJERWS60/L6HN92hT7J
 uMx8bEmSHnIgjHRbLoYWodIGczznj4719hrBpOYlRA/IxwaelVAzxRvS8ib/TTHj
 TFTWDL5mlY8XbrnArxAcX4hB9V2fGaTVTA42RScVnuu2j8ZO7KoSnmds9y4vzdUA
 QzXc+Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmpabvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:00:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd60a365440so386827a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792738843; x=1793343643;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TSBqvXX7rnpjqt8rxFBv9WYb5CVV2ARyX91j3W4WjFs=;
 b=f+wXs+5LDx5LsYl3J8M3z6aMChEWBwGNpFJ2JXHwF+wUDmSfuhDKFg6v2qVYHe7Lq+
 92CA0a7MHQ9uHXptuU29Ei5dbGGf+JhedeIMHsRDxMk4AwimV6JyNRT8tI2Via5ERHUe
 vgnnsZfCnT2DJCw11DVIOpfZTanq8lk0vjFaNN/2bXkBx8RNwtoLm1YWtuuZEi2yYRhO
 K1/ObHkJrL5y2UAp2+iZAwExUM7Db/qaJazUxvvHrqmLTDVXwZX4wiW29jn7sg9Toht4
 4ELQ5cpNICV56861W2KIiq0FypG2DcQ+YWwekvrpqQ1GBlr3VQh8q/dq6ZoExH4rY7vj
 Zugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792738843; x=1793343643;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TSBqvXX7rnpjqt8rxFBv9WYb5CVV2ARyX91j3W4WjFs=;
 b=O82UATN3gr0E78e03iX4H49dx7JDeDfsdQRWg8L2mtZeGIBYoymBxFct14Dd2rSo+/
 r+Lm92G5S88rLKuiuvC/1k1gWisNV9efrNjIDJE8lgP6rgNyC80T0tqcORgu+QVC/Hke
 sF7nKgsGwFGjA6drIlPUjqLeEk63GUtm66Vy5F2FhBiym4NwjhgRUGWAG5irmE/oOHtO
 5bA3V5F7YQovpewq+QZvn8RZogBvhrSqsUn3C7wv89d7K7zBD2HhQPEIZ1Kn3jJ90i1u
 92VnUO7duJ+GvLi0RAj2ArsPYJKdxNqpZSOopxMIVj1f6TfiNIw12UQfEVupQO2eWKXT
 gqBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3+FcnXCD8qW7azFxnNDgw9SYTBHMJONpM39M2GzGGGQYTJwFgslInIGjhyQ0Ssv3UcnLr+vxKykE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL1GTAC0vlMsQcRjrbSiaZ1CBBR/SL51RrC7jv+V23Hqm7JCPZK
 SB3OziIhKAeEsqcEF7yYIsmcVRu8UbTUg+BroBB9J/q1P6Un2h+o5Z6ynm/5mX7uQUPbXF3kena
 EhJSLZRZeOrcenTvqblUUMxD6Oqx/WdcslJo9j5eLEQCoOuV62iz5tRwosFFTURP1pRmTgao=
X-Gm-Gg: AYBFou3UwlXAeNJTOrltsO1rkzWe+j6kcQaOL1TeGzOVFTga7uixOK09HOhfhQVwBJ7
 Uz8yEAR2VRrlU6pLV8cHvymNADlVEydAJHezybPsmJBhN0Rw3MIbboubm1ZRFwGR6WvzurqfyEn
 qLVdwzR9GPqfPkhLox9ez5tubeeB6q9CI79nYATd2leIIzk6q1ZB4zwyoQ0N0r7dVj9OPKwiyF4
 wS05ZlcD3ozpFtldHsgIog3T5A00xiRl0zK/SFumsBR5lYPuiVpcIEsC/Lx3MzfvirGJiI9radv
 KVVxiNEguTC6Q/W0o34qt9+5Oww7SuR3B3yFfg/5hAUHbJyawUW9zbAZ7smlTpMQAeOOtfB7D7v
 ROpkYMenQ4htDZuzArLZdmhU95RneKpI+QQ==
X-Received: by 2002:a17:902:e742:b0:2dd:c100:7cc8 with SMTP id
 d9443c01a7336-2ea7d08faaamr14182395ad.68.1792738842487; 
 Fri, 23 Oct 2026 00:00:42 -0700 (PDT)
X-Received: by 2002:a17:902:e742:b0:2dd:c100:7cc8 with SMTP id
 d9443c01a7336-2ea7d08faaamr14182005ad.68.1792738841827; 
 Fri, 23 Oct 2026 00:00:41 -0700 (PDT)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea7b3da4e2sm6307665ad.57.2026.10.23.00.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 00:00:41 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <c7117cf1-5ffd-4071-a2f9-5db9ec28f7e7@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:30:29 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] drm/msm/dcp: Add HFI transport over VirtIO
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-3-48aad0fe4f72@oss.qualcomm.com>
 <i2wnkjvzds5wqpvf6svghcwmg4l3muddf7ksieeadran2xd7jd@pvs7cavr3x5g>
Content-Language: en-US
In-Reply-To: <i2wnkjvzds5wqpvf6svghcwmg4l3muddf7ksieeadran2xd7jd@pvs7cavr3x5g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyNyBTYWx0ZWRfX7aZ73uu8vZX1
 0G2PWgDj4u6GlGHKvm64ETZCttYKtqbjZv5BFE6rs35b62WiSUoEj7WGtSI1FFl0CpVR+pKTSv+
 FN5OvLaQ2sXKniYC6rG0sLCt2WTLczw=
X-Proofpoint-GUID: dN_50hKP20g2cgzxG6AMSX11nzXFN6gK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyNyBTYWx0ZWRfXy4E61tm3ujxC
 EKTfYF22Wc1QQFvB+llrsJ5EgRoGz6GjF5sM540E3Gtcw3gVge3ojRiXAjXH33KT85aOfNhpjxL
 J4kS+kjAyG5vznoHckP3iht1Z4IbPZwavzxvngg+WDOixdlvV+y5Jr5eWnuFgaqHXt1wB03fmAO
 /ow5xCpWVeGdiYVTvhyKdxNe0UMMXiKjbI6HipfHZQVvYFkBLWmSZUBy9jbcX+QUhn9gZ3nsAXv
 oumiM5Og7BGUwUBUxiTGY2u9pLcycvVVi80OgLchu0x74+Vr7m5wiLBNlhe1icGG8dOrnMCfNDo
 xvuNtQOLxxit23lbqA8w9eWx4CpHGGq90jWbK8zyn9baFaZBG/et2QeBgOTqVDVrGOADzEv/h6G
 xwW1DylD6u/Jkfuw7tUlq7Pxton5o4rg/nUdNtIMEi+pignT6QKVFbY2ftvy6b/iYz50BEcgVmK
 zO1iIxIMVrrU9vxXLqw==
X-Proofpoint-ORIG-GUID: dN_50hKP20g2cgzxG6AMSX11nzXFN6gK
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6adb061b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=AwTlwv5SfzYnvGzAyigA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230027
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 15-10-2026 18:06, Dmitry Baryshkov wrote:
> On Thu, Oct 15, 2026 at 01:08:23PM +0530, Jayant Shekhar wrote:
>> DCP firmware owns the display hardware, so the MSM DRM driver needs a
>> transport for HFI commands, responses, and asynchronous display events.
>>
>> Add the VirtIO command and response queues used to communicate with DCP.
>> Allocate command, response, and capability buffers through the DMA API
>> using the firmware-visible IOVA window. Track synchronous commands and
>> asynchronous responses, dispatch HFI callbacks, and synchronize queue
>> teardown with in-flight transactions.
>>
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> Assisted-by: LLM
> You haven't read Documentation/process/. Sad.


Will move the assisted by above signed off.


>
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
>> new file mode 100644
>> index 000000000000..bf6c34af43a0
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __DCP_DRV_H__
>> +#define __DCP_DRV_H__
>> +
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/notifier.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/virtio.h>
> Are all these headers required for this header?
>

Unused headers to be removed in v2.


>> +
>> +#include "dcp_hfi.h"
>> +
>> +struct dcp_dpu_kms;
>> +
>> +struct dcp_drv {
>> +	struct virtio_device	*vdev;
>> +	struct platform_device	*dcp_subsystem_dev;
>> +	struct device_dma_parameters dcp_subsystem_dma_parms;
>> +	struct device_node	*dcp_subsystem_node;
>> +	struct dcp_hfi		*hfi;
>> +	struct dcp_dpu_kms	*kms;
>> +	struct dcp_caps		 caps;
>> +	struct notifier_block	 panic_notifier;
>> +};
>> +
>> +#endif /* __DCP_DRV_H__ */
>
>
>> +
>> +#define DCP_MAX_DISPLAYS	4
>> +
>> +#define DCP_FEAT_DSC		BIT(0)
>> +#define DCP_FEAT_HDR		BIT(1)
>> +#define DCP_FEAT_SRC_SPLIT	BIT(3)
>> +#define DCP_FEAT_CURSOR		BIT(4)
> What kind of features are those?


Will be removed


>
>> +
>> +#define DCP_MAX_SSPP_COUNT	16
>> +#define DCP_MAX_VIG_PIPES	DCP_MAX_SSPP_COUNT
>> +#define DCP_MAX_DMA_PIPES	DCP_MAX_SSPP_COUNT
>> +
>> +#define DCP_MAX_BLOCKS			8
>> +
>> +/* Pipe indices encode the rectangle ID in bits 31:24. */
>> +#define DCP_REC_ID(x)		(((x) & 0xff000000) >> 24)
>> +
>> +/* Capabilities parsed from DEVICE_INIT responses. */
>> +struct dcp_caps {
>> +	u32 dcp_hw_rev;
>> +	u32 hw_rev;
>> +	u32 fw_rev;
>> +
>> +	u32 num_vig_pipes;
>> +	u32 vig_pipe_ids[DCP_MAX_SSPP_COUNT];
>> +	u32 virt_vig_count;
>> +	u32 vig_r1_indices[DCP_MAX_SSPP_COUNT];
>> +
>> +	u32 num_dma_pipes;
>> +	u32 dma_pipe_ids[DCP_MAX_SSPP_COUNT];
>> +	u32 virt_dma_count;
>> +	u32 dma_r1_indices[DCP_MAX_SSPP_COUNT];
>> +
>> +	u32 num_crtcs;
> CRTCs? Or mixers?


Mixers


>
>> +
>> +	u32 dsi_count;
>> +	u32 dsi_indices[DCP_MAX_BLOCKS];
>> +	u32 max_dsi_resolution;
> If these are parsed, why is it still u32 rather than two resolutions?


to be addressed in v2


>
>> +
>> +	u32 dp_count;
>> +	u32 dp_indices[DCP_MAX_BLOCKS];
> Unused, drop
>
>> +
>> +	u32 active_pipes_mask[DCP_MAX_DISPLAYS];
> Unused. Drop all unused fields.
>
>> +
>> +	u32 max_width;
>> +	u32 max_height;
> max width/height of... what?
>
>> +	u32 max_planes;
>> +	u32 features;
>> +	bool valid;
> How can it be invalid?
>
>> +
>> +	bool dyn_clk_support;
> ??
>

All above to be addressed in v2.


>> +};
>> +
>> +struct dcp_hfi_buf {
>> +	void *data;
>> +	dma_addr_t dma_addr;
>> +	size_t size;
>> +	struct scatterlist sg;
>> +	struct dcp_hfi_completion *comp;
>> +	struct list_head node;
>> +};
>> +
>> +struct dcp_hfi_completion {
>> +	struct completion done;
>> +	int status;
>> +	void *resp_data;
>> +	size_t resp_len;
>> +	u32 packet_id;
>> +};
>> +
>> +#define DCP_HFI_RESOURCE_VOTE_BUF_SIZE	256
>> +
>> +/* Wire-format resource vote entry. */
>> +struct dcp_resource_vote_pair {
>> +	u32 key;
>> +	u64 value;
>> +};
>> +
>> +struct dcp_resource_vote_wire {
>> +	__le32 key;
>> +	__le64 value;
>> +} __packed;
>> +
>> +struct dcp_hfi {
>> +	struct device *dev;
>> +	struct dcp_drv *drv;
>> +
>> +	struct device *dma_dev;
>> +
>> +	struct virtqueue *cmd_vq;
>> +	struct virtqueue *resp_vq;
>> +
>> +	struct dcp_hfi_buf *cmd_pool;
>> +	struct list_head cmd_free_list;
>> +	/* Protects cmd_free_list and command buffer ownership. */
>> +	spinlock_t cmd_lock;
>> +
>> +	struct dcp_hfi_buf *resp_pool;
>> +	/* Protects response queue draining and power callback publication. */
>> +	spinlock_t resp_drain_lock;
>> +	struct list_head resp_repost_list;
>> +	struct delayed_work resp_repost_work;
>> +	struct xarray pending_xa;
>> +	/* Protects pending_xa. */
>> +	spinlock_t pending_lock;
>> +	atomic_t packet_id;
>> +	atomic_t shutdown_in_progress;
> This all demands at least some description or kernel docs.
>
>> +
>> +	struct work_struct resource_vote_work;
>> +	/* Protects resource_vote_buf, resource_vote_len, and callback state. */
>> +	spinlock_t resource_vote_lock;
>> +	u8 resource_vote_buf[DCP_HFI_RESOURCE_VOTE_BUF_SIZE];
>> +	u32 resource_vote_len;
>> +	u32 resource_vote_generation;
>> +	void (*resource_vote_cb)(struct dcp_drv *drv,
>> +				 const struct dcp_resource_vote_pair *pairs,
>> +				 u32 count);
>> +
>> +	/* Protects caps_cache pointer and its lifetime. */
>> +	spinlock_t caps_lock;
>> +	/* Serializes capability transactions and cache detach/free. */
>> +	struct mutex caps_cache_lock;
>> +	struct dcp_hfi_caps_cache *caps_cache;
> What's the point of keeping it as a pointer? Just embed it here and drop
> the locks. Read the caps while the devices is not visible so that there
> are no concurrent users.
>
>> +
>> +	void (*hotplug_cb)(struct dcp_drv *drv, u32 intf_idx, bool connected);
> Why do we need these callbacks? Can you call the functions directly?
>

Will be removed in v2.


>> +	void (*error_cb)(struct dcp_drv *drv, u32 display_id, u32 error_code);
>> +
>> +	void *power_control_priv;
>> +	void (*power_control_cb)(void *priv, u32 display_id,
>> +				 u32 power_mask, bool enable, u32 packet_id);
>> +};
>> +
>> +int dcp_hfi_init(struct dcp_drv *drv, struct virtio_device *vdev,
>> +		 struct virtqueue *cmd_vq, struct virtqueue *resp_vq,
>> +		 struct device *dma_dev);
>> +void dcp_hfi_set_power_control_cb(struct dcp_hfi *hfi, void *priv,
>> +				  void (*cb)(void *priv, u32 display_id,
>> +					     u32 power_mask, bool enable,
>> +					     u32 packet_id));
>> +void dcp_hfi_clear_power_control_cb(struct dcp_hfi *hfi, void *priv);
>> +void dcp_hfi_stop(struct dcp_hfi *hfi);
>> +void dcp_hfi_quiesce_queues(struct dcp_hfi *hfi);
>> +void dcp_hfi_deinit(struct dcp_hfi *hfi);
>> +
>> +void dcp_hfi_resp_callback(struct virtqueue *vq);
>> +void dcp_hfi_cmd_callback(struct virtqueue *vq);
>> +
>> +int dcp_hfi_send_sync(struct dcp_hfi *hfi, u32 cmd,
>> +		      enum hfi_cmd_buff_type cmd_type, u32 object_id,
>> +		      enum hfi_packet_payload_type payload_type, void *payload,
>> +		      u32 payload_size, u32 tx_flags, void *resp_data,
>> +		      size_t resp_len, unsigned int timeout_ms);
>> +
>> +int dcp_hfi_send_no_wait(struct dcp_hfi *hfi, u32 cmd,
>> +			 enum hfi_cmd_buff_type cmd_type, u32 object_id,
>> +			 enum hfi_packet_payload_type payload_type, void *payload,
>> +			 u32 payload_size);
>> +
>> +int dcp_hfi_send_no_wait_flags(struct dcp_hfi *hfi, u32 cmd,
>> +			       enum hfi_cmd_buff_type cmd_type, u32 object_id,
>> +			       enum hfi_packet_payload_type payload_type,
>> +			       void *payload, u32 payload_size, u32 tx_flags);
>> +int dcp_hfi_send_no_wait_atomic_flags(struct dcp_hfi *hfi, u32 cmd,
>> +				      enum hfi_cmd_buff_type cmd_type, u32 object_id,
>> +				       enum hfi_packet_payload_type payload_type,
>> +				       void *payload, u32 payload_size, u32 tx_flags);
> You haven't really followed the internal review feedback. You have been
> asked to review the indentation. You didnt.
>

This indentation was not caught by b4 prep --check

Anyways, will address across files.


>> +#endif /* __DCP_HFI_H__ */
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
>> new file mode 100644
>> index 000000000000..bf27cbf9b8a4
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
>> @@ -0,0 +1,1198 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * DCP HFI core transport.
>> + */
>> +
>> +#include <linux/completion.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/unaligned.h>
>> +#include <linux/slab.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/virtio.h>
>> +#include <linux/workqueue.h>
>> +#include <uapi/linux/virtio_mmio.h>
>> +
>> +#include "dcp_hfi.h"
>> +#include "dcp_hfi_priv.h"
>> +#include "dcp_drv.h"
>> +#include "hfi/hfi_packet.h"
>> +#include "hfi/hfi_packer.h"
>> +#include "hfi/hfi_unpacker.h"
>> +#include "hfi/hfi_commands_device.h"
>> +#include "hfi/hfi_commands_display.h"
>> +#include "hfi/hfi_commands_display_events.h"
>> +#include "hfi/hfi_defs_common.h"
>> +#include "hfi/hfi_defs_display.h"
>> +
>> +static void dcp_hfi_resource_vote_work(struct work_struct *work);
>> +static int dcp_hfi_prepost_resp_bufs(struct dcp_hfi *hfi);
>> +
>> +u32 dcp_hfi_next_packet_id(struct dcp_hfi *hfi)
>> +{
>> +	u32 id;
>> +
>> +	id = (u32)atomic_inc_return(&hfi->packet_id);
>> +	if (id == 0)
>> +		id = (u32)atomic_inc_return(&hfi->packet_id);
> What if something looks at your counter inbetween? Two atomic operations
> aren't atomic.
>
>> +	return id;
>> +}
>> +
>> +#define DCP_HFI_BUF_ALLOC_RETRIES	3	/* Bound command-path stalls. */
>> +#define DCP_HFI_BUF_ALLOC_SLEEP_US_MIN	30000
>> +#define DCP_HFI_BUF_ALLOC_SLEEP_US_MAX	40000
>> +
>> +static struct dcp_hfi_buf *_dcp_hfi_buf_alloc(struct dcp_hfi *hfi,
>> +					      struct list_head *free_list,
>> +					       spinlock_t *lock,
>> +					       const char *pool_name)
>> +{
>> +	struct dcp_hfi_buf *buf = NULL;
>> +	unsigned long flags;
>> +	int retry;
>> +
>> +	if (atomic_read(&hfi->shutdown_in_progress)) {
> This is called drm_dev_get().
>
>> +	


There is no drm_dev_get() call in this path. HFI command paths allocate 
buffers directly and use shutdown_in_progress to reject new work during 
teardown.
dcp_hfi_stop() sets shutdown_in_progress while holding cmd_lock. 
dcp_hfi_send_cmd_async() performs the final shutdown check under the 
same lock before adding the buffer to the VirtIO queue. Therefore, if 
allocation races with teardown, the buffer is returned and cannot be 
submitted after shutdown begins.


>> 	dev_dbg(hfi->dev,
>> +			"HFI shutdown in progress — refusing %s buffer allocation\n",
>> +			pool_name);
>> +		return NULL;
>> +	}
>> +
>> +	for (retry = 0; retry <= DCP_HFI_BUF_ALLOC_RETRIES; retry++) {
>> +		if (atomic_read(&hfi->shutdown_in_progress))
>> +			return NULL;
>> +
>> +		spin_lock_irqsave(lock, flags);
>> +		if (!list_empty(free_list)) {
>> +			buf = list_first_entry(free_list,
>> +					       struct dcp_hfi_buf, node);
>> +			list_del(&buf->node);
>> +		}
>> +		spin_unlock_irqrestore(lock, flags);
>> +
>> +		if (buf)
>> +			return buf;
>> +
>> +		if (retry < DCP_HFI_BUF_ALLOC_RETRIES)
>> +			usleep_range(DCP_HFI_BUF_ALLOC_SLEEP_US_MIN,
>> +				     DCP_HFI_BUF_ALLOC_SLEEP_US_MAX);
>> +	}
>> +
>> +	dev_warn_ratelimited(hfi->dev,
>> +			     "HFI %s TX pool exhausted after %d retries — command dropped\n",
>> +			     pool_name, DCP_HFI_BUF_ALLOC_RETRIES);
>> +	return NULL;
>> +}
>> +
>> +static void _dcp_hfi_buf_free(struct dcp_hfi *hfi, struct dcp_hfi_buf *buf,
>> +			      struct list_head *free_list, spinlock_t *lock)
>> +{
>> +	unsigned long flags;
>> +
>> +	buf->comp = NULL;
>> +	spin_lock_irqsave(lock, flags);
>> +	list_add_tail(&buf->node, free_list);
>> +	spin_unlock_irqrestore(lock, flags);
> Just call _dcp_hfi_buf_free_locked() under the lock.
>
>> +}
>> +
>> +static void _dcp_hfi_buf_free_locked(struct dcp_hfi_buf *buf,
>> +				     struct list_head *free_list)
>> +{
>> +	buf->comp = NULL;
>> +	list_add_tail(&buf->node, free_list);
>> +}
>> +
> [..]
>
>> +
>> +	case HFI_COMMAND_DISPLAY_EVENT_HPD_STATUS: {
>> +		u32 intf_idx = pkt_info->id & 0xFFFF;
>> +		bool connected = false;
>> +
>> +		if (pkt_info->payload_ptr &&
>> +		    pkt_info->payload_size >=
>> +		    sizeof(struct hfi_display_hpd_status)) {
>> +			struct hfi_display_hpd_status *hpd =
>> +				pkt_info->payload_ptr;
>> +			connected = (hpd->dp_state ==
>> +				     HFI_DP_STATE_CONNECTED);
>> +		}
>> +		if (hfi->hotplug_cb)
>> +			hfi->hotplug_cb(hfi->drv, intf_idx, connected);
>> +		return true;
>> +	}
>> +
>> +	case HFI_COMMAND_DISPLAY_EVENT_PANEL_DEAD:
>> +		dev_err(hfi->dev,
>> +			"DCP: panel dead display %u\n",
>> +			pkt_info->id & 0xFFFF);
>> +		if (hfi->error_cb)
>> +			hfi->error_cb(hfi->drv, pkt_info->id & 0xFFFF, 0);
>> +		return true;
>> +
>> +	case HFI_COMMAND_DISPLAY_EVENT_HW_RECOVERY:
>> +		dev_err(hfi->dev,
>> +			"DCP: HW recovery display %u\n",
>> +			pkt_info->id & 0xFFFF);
>> +		if (hfi->error_cb)
>> +			hfi->error_cb(hfi->drv, pkt_info->id & 0xFFFF, 1);
> Yep... Drop the callbacks. I think it was also a part of the review.
>
>> +		return true;
>> +
> Can you split the patches? It really becomes troublesome to review.


Above comments to be addressed in v2.


