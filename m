Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480AACD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E25F10EDFC;
	Tue,  2 Jun 2026 09:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tg7X755a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3iMTrjE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FBA210EDFC
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:25:59 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65245oQq2692313
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a8oJhdM++qj84ExHpZEpnmVT1OSBcuhJ/dmbIOPi8AQ=; b=Tg7X755a+MFhnxIj
 ycrbD1uopXjdg1XWGUp0ARgDcMf3AGQ3DlgNZTI5jqISdvvfzHrYjiZNz3rRYavz
 E+MisLZkI4tzsG7Cey74sI+cPRs04maFEPx+90S6qvLKm5XWXtx7mDvDc09NPKQR
 eSQOsmD+GbPvWk9pzuB1uSXNRTao4u69wJ4Tquo+1zChc3dWCn4gU5OyiA7jqwSS
 z+1PEBPoTl0ZuQZ7EvXJwxdFPGjOsHscTSzAkfY3zJknDG7EBKNCs9RHT4CLWtFf
 bWSIW7LaiJWcr5IfX+ZKjC/K1nxQVET/kGMQajHsCiMr2Is+EjE/LXaVug/+PuNk
 mhAd9g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqumh8c3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:25:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36d98b54cf2so1884060a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780392358; x=1780997158;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a8oJhdM++qj84ExHpZEpnmVT1OSBcuhJ/dmbIOPi8AQ=;
 b=g3iMTrjE8/gOI4e0Vb+S625U/kiKe0IVRTkNts1Cm+cSwheE18FR3SyTLNFZXurLPU
 HX1UJ2zno5YEINJ+lHduRRHre/TnpFxwtRCXCUSBIzfs+HCa4E5Yt/iAPA6sLPgVYI/H
 OnXDiL0N60LgzirOAnUZrwH+TrCiOsmh1ZPc1m2rLA6NTaYNpHRJCtMSIiNc4djn8hFz
 ersP9WGmpgr2X0Y1gC6Bs98HbZsy2B6+MR4m5YZxARn2zb7G9fglf0RWlWMdhlnOW+z4
 C6xta0mvA7cYm2sJRZJgL9of0WdGmdq80B5VmOOh6hHMa+vlEia4BdeR8Ko6dzNYC2w/
 IOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780392358; x=1780997158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a8oJhdM++qj84ExHpZEpnmVT1OSBcuhJ/dmbIOPi8AQ=;
 b=fGsmU8KImGNA44q9ETqpE+ueYPCs3YzZLmEVUm6DxNQ/+GEL1Vm045LdP+WlASnDEX
 279p3x6YqnWgoOuBThNrFRDmm+HA477pneL59HrQa4tupMgIxwIrIhi9VbzW9qwHkBt/
 uKOIJ2g6qf7NcU4GjTEFQQSxRRhvqmn/Jwf43Cc4CxDJOOh7qnSa69j5F/hcWVdtRR54
 QZRHkSpMO2sbt1yy/DhiQlwFPsSGJohA4zOQ+8DkD/n/ry5FM5KYw1nu5PbT+yb09ig+
 ylRqBvNJOd6AwKfb0mjbo94iasjMSqz5zUKYZlCrk6UhAEDPwk4wDvkyr9vjnQlaPcF1
 36EQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eIkdR5mijnTY5/z7ZREi68YFcWPq/EGaMNZefqRZ1GXiozttVLOU7Nf3m5T045lT/Ra0X5K/gHZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZrhaw5/032P8/nolUTGNDbHVjBft48cp6TzPc5LkHlwG+/4ic
 OLBM/brWJxGzVBV8noGjP75RwkpLza7wQdEv9n80tOcTG1IrvclDrLk53q6I1gaar/dtn9Ygs4K
 eN/cZHcmfpFgecwbw+epMnnCLI8e+1MrOw6hEwv2FGAyqajgRyFoF3HQXtpiBbFm1vTIx3j8=
X-Gm-Gg: Acq92OGAr5rqhnXxPn364Zv3v1Z4lsW9WL/w0QQuCmsHiI2s+Rynu7zfdo/WUllnMOW
 7luQaLgE/qcfO5pFrdX8BBemDmULelXmeCp0wwhhgaR7Tij85NYa5vqKy4GFD0dnppKbw7IVFPu
 lMZLP2w8soC6L3oZxLRxCxaUtMn4eU6rkKmzM78lQQAB8XeY+gTr3XlJXuolyzt2c+DBRyxp0Tn
 ywP+jz+esi8jMNqWgUR0VzakvQQ7RFbL+Tg2P5VhLM5gEnXIFohokVNIHMAIlfYF2n+ACCx6U7E
 rDqJYERGLQw8FCGfb90XLQGUc/0M6gnurSUeB+aZkflk5zlGT7Lj8ZLtcNhZrXryyU78OPW985E
 ML8QBEaP4atpO3Hx5TfzoaeGI5GRop50kc9qIe2zvWJymPy2gkZwg
X-Received: by 2002:a17:90b:2889:b0:36d:bbe0:de7c with SMTP id
 98e67ed59e1d1-36dbbe0e324mr6879176a91.12.1780392357844; 
 Tue, 02 Jun 2026 02:25:57 -0700 (PDT)
X-Received: by 2002:a17:90b:2889:b0:36d:bbe0:de7c with SMTP id
 98e67ed59e1d1-36dbbe0e324mr6879145a91.12.1780392357348; 
 Tue, 02 Jun 2026 02:25:57 -0700 (PDT)
Received: from [10.64.68.243] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36dd91f1affsm2165015a91.11.2026.06.02.02.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 02:25:56 -0700 (PDT)
Message-ID: <7e5299fd-85f9-4f74-9e69-5192aca81f05@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 17:25:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] misc: fastrpc: Fail Audio PD init when reserved
 memory is missing
To: Jianping Li <jianping.li@oss.qualcomm.com>, srini@kernel.org,
 amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 abelvesa@kernel.org, jorge.ramirez@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com, stable@kernel.org
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
 <20260602071750.526-4-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260602071750.526-4-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NyBTYWx0ZWRfX6LZHmdBMXR2s
 LQwelZabAQm/icIVwpElFhMKSIPrrGSLb4RJku4TfjkD/yImyknrtQIckce2iuLk5HPz2Vd3YgW
 BSnX3X9c7V83DcbRomC30WitzIi1IjvMhjWautlg7JaPUcKiohNWUVzSp+wSfwOoaHGJ2QKJCH6
 0ICizz+YO5OnVglFaq4SeD6swez1lrHUx9k5WSFJq2uSAIHv+t9vZ/sJyOSnf29T8m+ARhwQx05
 snuuZ/AzglNZSRaJSBikNwcS+a1lZ/0NHjrgdOX6UpgOJn+dPdZjMEiyFwUjo0OC4px8GUXqJKT
 oj74bo6GcBE3iuq26D9wPPSCuuikMQ5uzXwAJa8BOXquJsW2g9nrbB5+tbVeRt6KgQWKFCeutjZ
 affrxSORV1UUem3d+SfwS27N/jFwnxyJ2ABKQaJjHCrHqY1Kfga0k1OP5odu92IwmcmhovmydKF
 JE7lLshsZUcfKSzeHEw==
X-Proofpoint-ORIG-GUID: fafucFq9r_nCFTpoZER6LcCYEfMJnluX
X-Proofpoint-GUID: fafucFq9r_nCFTpoZER6LcCYEfMJnluX
X-Authority-Analysis: v=2.4 cv=Rrv16imK c=1 sm=1 tr=0 ts=6a1ea1a6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NWGsHJKA5YHOe65YnXUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020087
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



On 6/2/2026 3:17 PM, Jianping Li wrote:
> Audio PD static process creation assumes that a reserved-memory
> region is defined in DT and exposed via cctx->remote_heap.
> 
> If reserved-memory is missing or incomplete, the driver may pass
> invalid address/size information to the DSP, leading to undefined
> behavior or crashes.
> 
> Add explicit validation for remote_heap presence and size before
> sending the memory to DSP, and fail early if the configuration is
> invalid.
> 
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>   drivers/misc/fastrpc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a8a58f889d07..f46a8f53970d 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1354,6 +1354,13 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   	} inbuf;
>   	u32 sc;
>   
> +	if (!fl->cctx->remote_heap ||
> +	    !fl->cctx->remote_heap->dma_addr ||
> +	    !fl->cctx->remote_heap->size) {
> +		err = -ENOMEM;
> +		dev_dbg(fl->sctx->dev, "remote heap memory region is not added\n");

should be an error instead of dbg info.

Thanks,
Jie

> +		return err;
> +	}
>   	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>   	if (!args)
>   		return -ENOMEM;

