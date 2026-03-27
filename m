Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C52210ED64A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F0F10EDAA;
	Fri, 27 Mar 2026 11:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cnCTSFZ8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHZwTnRL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F1A10EDA8
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:35:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6w3eD1860213
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 30ZC0GJstGxIxDb7g+6xkWIqpNTdQrufacREKq2etWY=; b=cnCTSFZ8JJcxYv3d
 JGcPi40ja7iPN672yEyDTRr8Gr1FN4QxhFrGT6Irr4tnsDsrOm4hIlnpYiwOuQs5
 Pw7UdLw2PZAkow+2ddHo3/0hITA/zBRLvehrp6x7HCVKXPdPvhIeOPUwYagFbXZK
 KHrMpm0dJR9QzSYkN3KIHbS8y3xA0Q52Dou5aBubyf9qiXx42Jutf329qp7cvg5J
 Ly6l73zdPNAOqQdeC23+6rCITDOpCa4aUoIUeehjYRTKB2wiGI+6Pc48sS9FYNJe
 kDKNr9uhywsz1imwy9Ik86H4T0t6WhQwIfFFcFFtQjSQf2EMBtdf2cazgO5SbLi4
 uwi1SQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv2u4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:35:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89cd0f68ed4so6494866d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774611340; x=1775216140;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=30ZC0GJstGxIxDb7g+6xkWIqpNTdQrufacREKq2etWY=;
 b=XHZwTnRLGS7ewXjyO83XfuNoLFBXaWo26U0WQmG+XSsQMOEp69T06U5BOnumdlJWAG
 RWz15DHz4acgWQOlpqPiBAnRNpQ6qi8KrbOj08GMnk+ECpMYElfYsc4uJrLQynIGbjOz
 enh06ZQrHmcS4uepzb+RWldmAjN98AV1J7lpL+zmazOk4mEA2jDMk+Vq+zm6DHvjbIHI
 Rpnd+NR1UVZk02hMZ+7rIeGQTpVpLpYEjxso+m1yZ96zDnpCrpU9/jPmIn2B1GVthrWb
 fWax4GPoCT5vscMybyBMuYkjImgs5fOvsvdCc9YtKIwmqkTdyze2HhbpE0XnPYLM9tjf
 MGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774611340; x=1775216140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30ZC0GJstGxIxDb7g+6xkWIqpNTdQrufacREKq2etWY=;
 b=pqMUodLOjcOERrC6LRXdeOPXFLx8uFXss7OcMlUork8fHLbXWS5FE6jmiQ2drnLTYz
 ptR/03zQ4S+CkmR7GfQRmzuwQt3PP9zij5V83l9piRnxowUfpMS3tigH+U9ncy4CN/dv
 zmhp3JUR5sPWGD47qIS2dNwxTQUJLIxpkg91LO0GxZCzCRw9jcUI5n9bOlQIFfcFRYJe
 LbhrCBjUV84rNJijYtJqpWWTi9FRMNnD1tkBwrxO3ISt/S1IRWRVpaQ3AT1WJhSHKT4k
 Nm2keUbkeCPrkC/jRpm6QNiQAhl2QNmfR5X4ZUdi/CoGSiG5pPFuIBdc/7R1RI2dgewn
 GVvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgwzR9aUSdAFq2e9aXB+yB/YZPYBE+zqvRT3zD4poN7aIY/kl8JQ5AuT+Y7KXoyOTbbTUOcWhXT/Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjiuNzD3ZSi/6yushgyw/I+mrNlZPm0FeLWudDHCfTm0ZpLY4t
 c+P8WjAgF8sTgHuijOxhnyymV14beBCkX9/mLvTEuJA7UB1LfPooNy/FtskE73Zz5D19tIE2IOP
 7GChongNc3ln3WH9i5Hgf3e7bHUccoXU62LC8AswX2pHi2+y9FVPmI5qrH219u+okyepIC3U=
X-Gm-Gg: ATEYQzzcLDu9wG6/a95EGx40oq24WdeA4k/gbaS99fO+9nKxF3oqxuV1+OBcVFEjwAt
 MvZTXVCTm3hHvAmp1PJzQQz3/joweFQki86QHv0E685QN9uyomcLpSK/vUCyiJazhFaROmvTuEG
 42XdiZm/YOeW0zYED0GsDh/1Dz2gstD+DuaNkAufAWa4/CT1P54C4iRnbU8HSUgjcWxdG3FFVTu
 dHsm6CWx6ZeA9Yz0Q3UDTonFAQ98wKSODbs4PSNz+PyjL8qTwYsxUWdK86C86DrGk4VDLj1nLMF
 Is6UIdXqwEpfPbINOU8/7DskKrt6QtHtJSJNCRs6hrG74QkikVvPacMy6UpC3ixY8HJAV+/lQ/v
 RN7HWKYi6iojKD7ABYeBoUK4c6a4NejjvbHd6DKA4d96r0+uuiUoCW3h+MWKRa/Be0nAcUtint4
 T8yRI=
X-Received: by 2002:a05:622a:5c0e:b0:509:e68:22cb with SMTP id
 d75a77b69052e-50ba394ce8cmr19051751cf.5.1774611340619; 
 Fri, 27 Mar 2026 04:35:40 -0700 (PDT)
X-Received: by 2002:a05:622a:5c0e:b0:509:e68:22cb with SMTP id
 d75a77b69052e-50ba394ce8cmr19051501cf.5.1774611340184; 
 Fri, 27 Mar 2026 04:35:40 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66ad6751cc4sm2337139a12.18.2026.03.27.04.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 04:35:38 -0700 (PDT)
Message-ID: <8114a15d-510d-498d-af79-a75493a8fc71@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 12:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] drm/msm/adreno: Coredump on GPU/GMU init failures
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
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-8-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-8-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c66b8d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wHiI9OMDwfVBJI4OM5sA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: Wx0csdX_W6LDpxndO893ePen1JaMUPr1
X-Proofpoint-GUID: Wx0csdX_W6LDpxndO893ePen1JaMUPr1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA4MCBTYWx0ZWRfX7d33yfXNDWns
 70/jnf4mI4I5seUEdSjqz4yNJav7EGsPjUKPpzURAQxPZC+V584O+3cXcjg00wRsZCYXXQP59hc
 4e9AfNu9QWQqG1nyoVEKRgh/SQpdrg2lTMfbixSzftqC3d5d07TxCa64w7TaI/XwIddyfixGryc
 W3K9dfS+SKnRuPN/P6pzqNFekUt/DjAmsnxtcQege2U4kJgAJv1JhAj+mgA+JsmCjNIxdZ1HDU3
 g5U9V1+ZbExWDfg5dnbukieyDnlvBENCBF8ZcIDp7yqmKCzN5e49ARGCVRBDQHe0wgN13Pgpbfl
 xow70LyjztybjqyP99LyyB7Hd/y9WanOTuce1rR/u5kVcJKC7HdlOO1H5gKQ+lfIqWbNXS7GWdp
 kGFTLD8/P/GNbxWtg2x1/VRPMLaRll5M8uUB58Q1gG/xXEij8P3OTj5gc/XT6rA4DyIAzoqIzqh
 vb5Ve41VPRqnIVFhliQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270080
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

On 3/27/26 1:13 AM, Akhil P Oommen wrote:
> Capture coredump on GPU or GMU errors during initialization to help in
> debugging the issues. To be consistent with the locks while calling
> msm_gpu_crashstate_capture(), call pm_runtime_get(gpu) always with
> msm_gpu->lock.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]


> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -391,10 +391,13 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>  		return 0;
>  	case MSM_PARAM_TIMESTAMP:
>  		if (adreno_gpu->funcs->get_timestamp) {
> +			mutex_lock(&gpu->lock);
>  			pm_runtime_get_sync(&gpu->pdev->dev);
> +
>  			*value = adreno_gpu->funcs->get_timestamp(gpu);
> -			pm_runtime_put_autosuspend(&gpu->pdev->dev);
>  
> +			pm_runtime_put_autosuspend(&gpu->pdev->dev);
> +			mutex_unlock(&gpu->lock);

This is something to take care of in a separate patch, but get_sync may
fail and then the read could crash the device (GMU may be off too)

put_autosuspend could theroetically fail too, but perhaps -edontcarethatmuch

Konrad
