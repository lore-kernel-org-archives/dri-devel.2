Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE238E9A75E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4308D10E5F3;
	Tue, 24 Mar 2026 10:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UeQqaI2y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E9ZOoIYr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA6F10E64A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:13:50 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O9RU7g3934853
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pF5Yvft9OWQEMcww/FMusyd7xCYp7Y1/Nvsmv+Coe/0=; b=UeQqaI2y1Zd337qL
 QuVcHXzz9P0SMm00hLDKPksIxo9rRO+1lBcb1dyX90oaJlQaR5gLciok6t4kSP3M
 bK+ZOMCCG6Bv77b/Lp/ob/H2t4hVXVXcAHQnLyyHInOj4GmeeiyfqbsBnE8q+nZs
 UvrJypLjy4/xK3LghAqbQs6tdhEz6mrVuCe/TruaOpnWEsh/CVmLLPej1UOtgReD
 YI2mozRSFxRPGFE3X+2+U27gIV1Ss5hZPIDeoyU3cHAMJcTIXefg0NlSVpJa4CId
 eaSDz9d741EuyiqV8g05AkgCJMTEqlxilpWlhLia7zSh+egHFnj+WI95vQzVVn9c
 G21qSw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d37a0kwg4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:13:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c49436edeso43516156d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 03:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774347229; x=1774952029;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pF5Yvft9OWQEMcww/FMusyd7xCYp7Y1/Nvsmv+Coe/0=;
 b=E9ZOoIYr+NU20CndtxCR03DUueJ2Px4mVnZmAUo/CeYiS7HO/ya89YbkIiEHFvXiT4
 O++yShHNDdyO0dmJkWf0S4ki3XiVLyfw8L+x6pcQSULafuq6gXcgfI5dViZ2dFaiYId7
 XXIp/SIYfUYCAXqjs/NNArO5LftrLCj5UrZDuKu374aTIM+9OqKmzLoSbUIJnzi09Zkx
 c9HsGF6dcQtf8Cj6dkZnUGxW/vprKVSAqJEVlKP+tbQHeyKmHlkR/prAlGHOtUmG1xNO
 2UJLmaxeTX7lmKaaMFbDieMHmVSKUpS6PBO+AEf9hJWY/ZXQJWkZZKi21Nhhgp6GfbmO
 IdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774347229; x=1774952029;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pF5Yvft9OWQEMcww/FMusyd7xCYp7Y1/Nvsmv+Coe/0=;
 b=RtKGTRkK8rKL1e4CRbXZK9KDGODvcoZ1Xd9JabClGBjI3CNTgic/BNtXibz64WU1so
 iHBMpBARQO0BCjHoqfwyvviPipO5AUeFHRfS9oZoyZZav+5HEDkDy1KollyTc7Eu9bA/
 yfIpNnVjNYxPUE6Wt/VI91B97BoOGKVkwXqPVN9Axf1QVGRxxtd3842B9y54bDn+vBK3
 +I/5f8IoCtq012P3YfIYtXirDYM6PTpSejsh56RqYcIxPNVCzbps9lEdJ/hTBsYBtOZC
 U7DWQj7r1f5juEpwbVxFe0+u++2Tc7R7us40CcRxRat/HwlGyo62aiZEEkaiPPY6vtgv
 qASw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/792POSa+g1gIy5LkqIw6YFu07ywNhlnbWFhB1VpbKazqsLkJ3xnwsP+eh+lRFC71j0WWtLrEJGI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQOjPHZqIBoNFXtM0WONMPads75oKMq1jNXlZLqmV8FwrMjslG
 opA0mSZ1BqBrq4IT7vdzgPY3nO/rx1tNe01QSVNwf69X5UPJWx/Dd6/ovrwcY1BVS8kkdp9q08q
 J7szoItQXwKwgiyeKc2UVFB+CeAvk7QqTVy6z9xxmjU/+YyMqfyE+2uhNUpkOjYLcpMjw1vc=
X-Gm-Gg: ATEYQzyI5ajnZsWmWKfwRPiqu4u0GwrFlKJ4G3oJ7AyHvkMVH+ANTAheASm7WjfvzMA
 bzMqxk1kDtC3k7A/BOYU5x11aRtNLxGHOOyVF7ttlOFlEThZd9HwCxz3eSwlORFn68dODwiVhsj
 reuHzXC993ZMxZ5nTwaCT+dVc2ZfolhoGQtofh9ycC47NESufGrrCByysDEudGKl0XA3K9+n5g7
 E7M0l8EIykbPUcW6GXXb1+S7+8/bCPeGaBFW0v7JZNzo5m3+NW9tCRLgGS70GErYnPYb7BBXDe0
 0t6gJd2gvCctYtS4BnOkVlVM4yo83tnRBWS95pdcM1j+6LJbFfMe86l8MYt/EDn9ZUiPtrI+T4t
 fzp/6y6fh+h4zTchFZ8UtV/C+n+iyMiwxY1vko3EnMDKNcPszlFP5L9LCwWCkRuSXATJpZ8CtNz
 7/afM=
X-Received: by 2002:a05:6214:62d:b0:89a:4fd5:6998 with SMTP id
 6a1803df08f44-89c859d79f3mr191654306d6.1.1774347228580; 
 Tue, 24 Mar 2026 03:13:48 -0700 (PDT)
X-Received: by 2002:a05:6214:62d:b0:89a:4fd5:6998 with SMTP id
 6a1803df08f44-89c859d79f3mr191654006d6.1.1774347228179; 
 Tue, 24 Mar 2026 03:13:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983387084asm619569266b.53.2026.03.24.03.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 03:13:46 -0700 (PDT)
Message-ID: <54b03221-d21b-4582-b0b9-d2384480356b@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:13:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] drm/msm/a8xx: Implement IFPC support for A840
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-13-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-13-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GIIF0+NK c=1 sm=1 tr=0 ts=69c263dd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=4f25mLXvg3xlTH-B0vkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MSBTYWx0ZWRfXxoRulPLT+6vB
 yJ5M/wb35aF5HAVXDdf20qu8xReR9POIwSr+SGu9bkpYHuRMWrC3ZoANXcsYm+hbpqgTod7T3Oc
 LhGGjjHKj57b7P8W85LPv7vrJV9AHrb9YTxdv4XWnCHNQGKSe8+EKQSenkLxNbEslwP9MPGjxtv
 B95l3IjkMgGD4//UIfciVE0meXMZDLpZKimL/VLpvGIRvuEHl5EdmhBfOldXVU9nJLhrtH6skqG
 +f7QLMQpqMHpnv7xaeubikypP4uSYLepZUBLHerUEIJt6L3lpT8g6OOsK+LTuD7RqwkOXCr9Dxc
 OkVfljexdMV1yWpffAAasGFicE18MHyzFuI4VpQFjrw+Rm6/Wik51ZoLtMd1r6TVXM+93KPL4ca
 vjaUweJ5WW8rOUl4nDnkjBL1rym8suapEdq4G0mfrLFvbFxNRvd/CMYEnAAiXMicAuxcKfITxrN
 hMm7JD5JkXYlVZMRSTw==
X-Proofpoint-GUID: -7fDBhtVW4BrSQ6_ZQ59EJao8npCD8UC
X-Proofpoint-ORIG-GUID: -7fDBhtVW4BrSQ6_ZQ59EJao8npCD8UC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240081
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

On 3/23/26 9:12 PM, Akhil P Oommen wrote:
> Implement pwrup reglist support and add the necessary register
> configurations to enable IFPC support on A840
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +	for (u32 pipe_id = PIPE_BR; pipe_id <= PIPE_DDE_BV; pipe_id++) {
> +		for (i = 0; i < dyn_pwrup_reglist->count; i++) {
> +			if ((dyn_pwrup_reglist->regs[i].pipe & BIT(pipe_id)) == 0)

that's a nitty pet peeve, but I'd check for if (!(...)) instead

[...]

> +				continue;
> +			*dest++ = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe_id);
> +			*dest++ = dyn_pwrup_reglist->regs[i].offset;
> +			*dest++ = a8xx_read_pipe_slice(gpu,
> +						       pipe_id,
> +						       a8xx_get_first_slice(a6xx_gpu),

Only the first slice?

[...]

> +	/* Lo address */
> +	OUT_RING(ring, lower_32_bits(a6xx_gpu->pwrup_reglist_iova));
> +	/* Hi address */
> +	OUT_RING(ring, upper_32_bits(a6xx_gpu->pwrup_reglist_iova));
> +
> +	/* Enable dyn pwrup list with triplets (offset, value, pipe) */
> +	OUT_RING(ring, BIT(31));

I believe you need to patch OUT_PKT7() with the updated cmd count

Konrad
