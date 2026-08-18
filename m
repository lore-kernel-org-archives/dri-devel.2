Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE92C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF78A10EA87;
	Tue, 18 Aug 2026 09:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fpv2gwNE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KuxbE+A/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D79B110EA87
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:49:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I8BL3w310033
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vg4886UBjaM5jDA+5B8WNJXVBq5NN1PsHEk5H0Q8S4c=; b=Fpv2gwNEEZ6srAf6
 N1+1qnSzUtzTjVf+PlUOu6vpD0GudxkcNRBdLks8ILxEiRuXo9op+PFGj0qaqEv1
 7fEihUA5s93FV5O0vHMRleJ+f2Stgq2ZbsUrWby+iHWaOJf+m1GQzN0ABKE2O/+q
 lMF1rsC+HFfkg/Ez9AzzFhgWoqG2pTuHGs4W+KiQN4IuUNv4WnvpdPHfZ0OeRKgF
 C/6CDDvbxodRLayKc4rXqAyXK1BQU3eJ8M5UpSaGB+YrSWbap9Vypsy1wbTRKe8B
 eDwnS++P5YCDCjqpdPRFoq0tb0BPBUTxjCdWwGfXWiQZzVcrixbsr2gpX4ILh0O7
 TOsH6Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fba9jg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:49:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930b81c13b0so32656085a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787046542; x=1787651342;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vg4886UBjaM5jDA+5B8WNJXVBq5NN1PsHEk5H0Q8S4c=;
 b=KuxbE+A/zJ5+x0ZsWWLTxp5rdLsuBQ+P6azETEjPV1pc6HP4imXhRvs9APjijm9XDU
 2GZHJARlkunwiVLFpyXbRXoyQSiY4RUZ3ljXjrLBh+IucQDrhPDj+5UJItqzrpZMM95Y
 aWSa6wemADGOKM9IDUWTazDYnSnzV/4AuzveFOynZcYsnN0QBJtmJc02/i/y6AMsEDjJ
 QbLsYtwW9/EQa5CZvG0H4DtLsR8j3pQdgvBDG+GpEc9Q/FdoHsOozRICrhKDJZmX+AG/
 ZlxQDgp4mjXLC3nE62sqhmEf1D1wzLXwMjk4h/ol3PDQuASST2VlrdxxqdUQvWv9NjOL
 vMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787046542; x=1787651342;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vg4886UBjaM5jDA+5B8WNJXVBq5NN1PsHEk5H0Q8S4c=;
 b=eZ3ZJT0io4jV5CukuTiBq+mMCkIlvSQ0StyH9TJX2K8JD1X62uXsC7CsILz595SKWa
 Gittzz6t5WJJxJpUEhX0ilnGaLmcrLJAS/WuAYX41Qp6ecseBQ19z4tBXzrVeIRLH6Lb
 zBrzapZN7eJqhtmREoBgstKRWEtJL3i3HIV9CQ76J4QR1d1jEQjFUyE/GaHj+StrnR2l
 CT6tZ7np9aj5cAXXCR8KI1Int0rR0fZFa0l7w+UFU6GXhAgZihkLShoipc9inyG3MAwX
 tukp80o7VCRmegmqIjwPlBj0cjkVVIGUHZNjiPeCau4RTpbXPnL9FjDc1P1WAHK3+vmm
 O9pg==
X-Forwarded-Encrypted: i=1;
 AHgh+RraML4aSviSJ0kbrVJZQ1w+0+OS7cTaJZ2Jsnin7tDfM0AkEmO+mxgUaOVzRPK4R4Vyteu9s0xrCvo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPwKIm+zAziq0FsX7KO5l5XKDO/halHUD+MwzuSIK2LPJ6orkq
 a+HVK54UOWLVC8+ERlLCLsZAxqki7kZUab+FHAuRU2enHZk3sCvdHUSJakXJfZ+430KLSrZdftW
 I28nGXp+FzD2gIOSxAybY9DE7PLXL3r91Vg0OhMFBeSaL9CC+D3YvadJjSFD7qYDB7vjWCvk=
X-Gm-Gg: AR+sD123ZLhhjcj/wJZ/iIvgtYTYG6Qo+umUXuJoZSEiJJimqbMqonUGcDsWMXAjkG2
 CxptCf/UOLf7A+svQ5PBVnV1q70EidO6dPYUPsqHXj3UhFTIoTZUaYDAsKeYmkCKPfJy01/VqL7
 KV4fjDdJ/KwT1OMOvVdi2PssRPcZdv23tJ3/DQmBN5g9FqKNdVrLLCQwmjPwdNA13xSb2pVRZKk
 86R89+EzKThzNXVoPMgDi+/LHEE+lO6v5VjAF4JBUyXYu+hH6Vi4DHndrOfBPOUNkvHLtL1Vq2O
 jnp0kUxhY6WBVAcQioXZ+NV3Z+WVWJEK6lsk98yadUM7DbOcFS2t3vyvIsHGou6Ox/ZMU6pJx3y
 SyrIOBKZjDZjGVmD4AaiaY0sH
X-Received: by 2002:a05:620a:3712:b0:92e:5ef1:9072 with SMTP id
 af79cd13be357-936d235399fmr2328536185a.2.1787046542209; 
 Tue, 18 Aug 2026 02:49:02 -0700 (PDT)
X-Received: by 2002:a05:620a:3712:b0:92e:5ef1:9072 with SMTP id
 af79cd13be357-936d235399fmr2328534885a.2.1787046541792; 
 Tue, 18 Aug 2026 02:49:01 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c217fe69cf4sm160289566b.3.2026.08.18.02.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 02:49:00 -0700 (PDT)
Message-ID: <8728ddab-ec45-48a3-b2e0-93b85938d8b5@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:48:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dp: skip PUSH_IDLE when the link was never enabled
To: Jesse Casco <jesse.casco@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260808171325.133041-1-jesse.casco@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260808171325.133041-1-jesse.casco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3MSBTYWx0ZWRfX/sTyCCG6Xtpx
 g+RbpV1PGakIP75TWPvjRk95R3h+g/RVeXRoQ4H7+w1V0Bi2UZfdpMyH+HJ4G+YOyZrGKuK75T7
 WS438INqgrCXfVD1KFEUpFaN1+EpVYQ=
X-Authority-Analysis: v=2.4 cv=VsITxe2n c=1 sm=1 tr=0 ts=6a842a8f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NeJdD9iz2wSp6K8K9msA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Y1gkMNZhpaIiBcgAfCIDfXY5_f0-R8ca
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3MSBTYWx0ZWRfX/a6Op4Iim38b
 khxhiekQ59trX5tdUaDUT4FBu+HafDeg3zgA2hMnmDdd2TOBqBIUkDGy9lYNHB8lI8iLSiWg8GR
 XSfZKeks5hHdq7ws+/NzU6FDfaPSQdMFpwBV5JaMW9xu4ixN8ONfjFPNP7ODa8V9XrCRSSg9gwj
 2TVBA99/y0ZERxh1UWdPuBTVp/nz44uS3xrXAfoAmUR8LVPIZdSgcSSt4wMu1rcNka+Oyctnwlz
 owTc6RNe/HnWz5X2OBrYRPuvlVCUkpgxwBlg9hnjJTbff+KS1QEJ2T+FfbTlHrEl35ZdNB1iDXm
 J22RcpK4LqmysOxw9eoIoL34MeyM7gPQ+UXwY1h9M5yxqKP8nK1au5VgFQOPWmEe0bDBStBdhSB
 ZzXSrpsj+EsGxBKms4DQZqqgmMOtLdSoRR4cNclUo3ASoDMON0CGw8fR56+8/DxaFqv82yAkloK
 7oICcpHz0QBaFAPR2ug==
X-Proofpoint-GUID: Y1gkMNZhpaIiBcgAfCIDfXY5_f0-R8ca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180071
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

On 8/8/26 7:13 PM, Jesse Casco wrote:
> msm_dp_display_atomic_enable() returns early when link training fails,
> leaving ->power_on false and the main link down.
> msm_dp_display_atomic_disable() nevertheless writes DP_STATE_CTRL_PUSH_IDLE
> and waits for an idle-pattern completion that cannot arrive, so every failed
> enable is followed by "PUSH_IDLE pattern timedout".
> 
> Every other step of the teardown is already gated on that flag:
> msm_dp_display_disable(), called from .atomic_post_disable(), returns early
> on !power_on. The PUSH_IDLE write is the only one that is not, so the
> controller's runtime-PM reference is then dropped without the link having
> been taken down.
> 
> On glymur (Snapdragon X2 Elite) the consequence is not a warning. The SoC
> does not survive it: TrustZone force-stops the SOCCP and ADSP remote
> processors and the machine resets silently about 50 ms later, with no oops
> and no panic. On an ASUS Zenbook A16 (UX3607OA), whose eDP panel does not
> currently train, this reproduces without any compositor or GPU involvement:
> 
>   # eDP enable has already failed with "Failed link training (rc=-104)"
>   echo 1 > /sys/class/graphics/fb0/blank
> 
>   [535.645455] === marker ===
>   [535.694833] qcom_q6v5_pas d00000.remoteproc: fatal error received: \
>                  sys_m_smsm.c:512:TZ force stop
>   [535.694875] remoteproc remoteproc0: crash detected in soccp: type fatal error
>   [535.728857] qcom_q6v5_pas 6800000.remoteproc: fatal error received: \
>                  sys_m_smsm.c:783:err fatal notification received from TZ
>   <SoC reset>

FWIW the rproc crashes are only a symptom - if the system is going down due
to (among other causes) unclocked access, all remote processors will be
forced to go down and this is what Linux sees

[...]

> +	/*
> +	 * If .atomic_enable() bailed out - link training failure is the common
> +	 * case - the mainlink was never brought up and ->power_on stayed false.
> +	 * Driving the PUSH_IDLE pattern into a controller that was never
> +	 * enabled times out, and .atomic_post_disable() then drops the
> +	 * controller's runtime-PM reference without tearing the PHY back down,
> +	 * because msm_dp_display_disable() returns early on !power_on.  On
> +	 * glymur (Snapdragon X2 Elite) that combination is answered by a
> +	 * TrustZone-level SOCCP/ADSP force-stop and a silent SoC reset.
> +	 * There is nothing to push idle, so leave it alone.
> +	 */
> +	if (!dp->power_on)
> +		return;

Dmitry, should we even be reaching atomic_disable if lt fails before?

Konrad
