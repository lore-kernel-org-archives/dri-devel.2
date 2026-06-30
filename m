Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E148CC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E67610EC76;
	Tue, 30 Jun 2026 12:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDALlAFD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d0HFXhwL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E904D10EC76
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:42:33 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9mm6c1541441
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vqgiAyPpNCB0A0IntH53l4iOkxkfpMU8dkDpi4Z9XyI=; b=FDALlAFDR7huBxwd
 WpIQ6SpAtlJNosB/BjBaKCGSCxBr9UYGDgxAea5BPhA/iJxfpFmvJ7NPOpawWx90
 pSel/yL0Hy9QAJ85bUk+hw0x7kvr04y2alpgbaiqNd3LoZygWGn3rcAfEMyWuuQS
 AaPFT6C5b+WfoAzB2ITk9au9cNNvVTfsSpFdP+zhh9thg3RcFEqDJlKYgwufpqxO
 +44/GUDjNzNBntgDtsGCCSZe53+bCRnzDu2qDe+sLpFixkaqrd1yKCNbNQyysm/V
 Rtn5XnXLAFjqIECmh2rqZt1brTWzVH5CiDI1CUZi9idMKEpcEz8dvnZfx8DK6af4
 7fbMVQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44wp2fqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:42:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8ee253caso5231381cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782823352; x=1783428152;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vqgiAyPpNCB0A0IntH53l4iOkxkfpMU8dkDpi4Z9XyI=;
 b=d0HFXhwLYjHZGarxIeyj3x4vVUtRm/nYcVqn33c1MlRrElJ3UjVrYxyLSucSNB8gXt
 fraDplrh8Ja2K0FZjZTMxWyCm4pRqjJHf53M2V0OIKebSSw+H9ugLqo/Cr/vCeHCrA34
 H9TLNZtWTCNO2LOqB+VNMfVM1zp5GzJdDgwU/Rd8X0rCum8p3pS3mUWgpbDh6HoOvmKa
 YJxhudELeadP2h1bwfvus5zscPHvgIZyA0JdKDNVjr84wjafRQ5h3trBoNOLvnR6p4QF
 5GrQ8vssWo6jNJWUucI3NSqF2TfugAHNBn+d5nxJ9xxQlMQ9Wi5ISBvFJI2jwLwm8pwO
 qoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823352; x=1783428152;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vqgiAyPpNCB0A0IntH53l4iOkxkfpMU8dkDpi4Z9XyI=;
 b=gDMLEnd/8dty2LOrGCHZ/g+lQUMhI1RbiecdlXdFL+cURrd/6Lhn+Dpli8REHGap2d
 B25OOIDPZ2b0A4opLiYqQk19oWIrZG6VFRBZyfVXsSUxYUuWLOi1hpODt9WxNVtb2WKO
 KGGOOx3I+E0TqLPwHGWglgNrrmzbTgBiHqOlKDUXCFF+BgVaD86frdhzilvu7iKO0PDn
 uALt9c4vS/hNu+F0qGOU1vmhaqHnqDLMlxdm07iQujGg8o67iVRBWxK8D3PVs4vwlfNt
 QlWR9jAXqXVqsLjAYhTo9xWrccIaZ/vZQXJS35sSLsaMnaK0tzuiSLQRnegdV/jpNPZu
 5kzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qqQq5mvBrPw+S9hr2GfUhJAgcD+6fp2QCysfCH/O2YdVJ4fmMhOUVT1UVdmmbc64zaghWidp8eVY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxk5A3UypLT0jw1TirDT3I68MyMppPialtM/hNJDLILwSXEOXwm
 rBbx2Ny++I6vFQqWFKNs6CEUOaZcroAtD4KCP31yC9zNUHdY+GTdtBiPnQHxJsTlmLSo8uaUtjj
 NACTgvDp+xS2Dx5ulIvUdMlA8Mm0t4QY6pAqzWVmaaqErAk2PP2/NGAbsI03FWZldAPRXYxY=
X-Gm-Gg: AfdE7cnBDCZ5jQWWwgaqGUjiWU1fv4D0a20IePr1olTdyPSFctscyTTLS1WbjhZwBwR
 +FxVclc4xj3aIUFIZ1wjpdIQTvSJ6i5UBpABx4+vJV0yyjH4eOQULetPKhbowRwpixxw3F8/6jo
 Dn8thW8tu7/5WWYjMmPZKPWLLpNec2FkB7+jJmDtjNXuxDWiaz8Lw53/X/xJv5FjeePW6og/DuH
 BeP0q6egZU/pLUEeFfFMGg41Po6zCF/fApj1jy0OP9Ke9sNdwL1Ar/GKJ/3MlZVi3WoDmaJe1Sv
 l6xMIxRsjZnlIcbqs3DrRXJfuMElsE42rLOxPgT9UlQlaKkN8DMW1hXs8/u4v+rubTNPDBtZxXv
 Fymn3oXQn/kNCZ3XBn2mXOuBhNx0Wy2ssU3k=
X-Received: by 2002:ac8:7fc9:0:b0:51c:215:3e81 with SMTP id
 d75a77b69052e-51c10754ef1mr27550211cf.4.1782823352475; 
 Tue, 30 Jun 2026 05:42:32 -0700 (PDT)
X-Received: by 2002:ac8:7fc9:0:b0:51c:215:3e81 with SMTP id
 d75a77b69052e-51c10754ef1mr27549891cf.4.1782823351774; 
 Tue, 30 Jun 2026 05:42:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1288f4c19esm118502566b.51.2026.06.30.05.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:42:30 -0700 (PDT)
Message-ID: <c251430d-2184-4ecc-8d05-9cb47533e5ec@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/14] media: qcom: Pass proper PAS ID to
 set_remote_state API
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-11-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-11-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UCi04kpS-bnwpmnvzzey6zbmX4L8wypj
X-Authority-Analysis: v=2.4 cv=AtDeGu9P c=1 sm=1 tr=0 ts=6a43b9b9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XI7qjyBPQyksM17I1wMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: UCi04kpS-bnwpmnvzzey6zbmX4L8wypj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX+FET3OkdyOx/
 HJX/XcPm08MuqEfrITqIEUysUYnLLfCuLYiW0jX84gA4CjGLf+ExJym5qvuSRUSkKLzbW5dsYJn
 gE7egzBitcwoCfU38A8GglpbwibJDpjGgYm2c/gFcdGwPz0B+9s/tQCG/dSZf3OHFvvonB94C+o
 QhklyMyTBAJd3CaRezRiwrbdyLEzH0gY7S2ykILEZkkWfKo+FRcAViaGAW17/Jx47w2ET143T5W
 PC0dKnrDl7SKdqJ/x0noprwEyP+zghSS0A18BPnveq7KSqcfmVG0UtHo9wbPdLqlJPNBPEhoyQq
 zR21bDHQPrnXfQVdaeMfYQhRyK4kMoCBBZo8N4JkDvpd0F+DqtFMn2fVQ3TzL/6pqfb/xX2mZlV
 R17rYM1heNzDopiBA7935bVybOWn0NgcX3ExPpLWQGFPAQ2c14BDS6SKtWjwnfygOdGn67I4V+q
 ernizHos1v7dkqIv9HA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX12VUfNn3HSQ2
 +5yocd+L9XtI4bMRlGpwOgCKOTITIumTpIF9n0WqjrHJU6u/LIy8UUWP+7LYDTH0zT54u665B9h
 T1zb2cJhOM5Mkq+T2UOWBgxj0TiK5Jk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
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

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> As per testing the SCM backend just ignores it while OP-TEE makes
> use of it to for proper book keeping purpose.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_firmware.c | 2 +-
>  drivers/media/platform/qcom/venus/firmware.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index ea9654dd679e..d2e7ba4f37e3 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -110,5 +110,5 @@ int iris_fw_unload(struct iris_core *core)
>  
>  int iris_set_hw_state(struct iris_core *core, bool resume)
>  {
> -	return qcom_pas_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, IRIS_PAS_ID);
>  }
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 3a38ff985822..3c0727ea137d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -59,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	int ret;
>  
>  	if (core->use_tz) {
> -		ret = qcom_pas_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);

This should not be in the middle of a mildly related series..
The PAS IDs should be centralized into a single header. And the
name of the driver shouldn't be part of the define. I would guesstimate
that on the secure side it's probably called VPU or VIDEO

Konrad
