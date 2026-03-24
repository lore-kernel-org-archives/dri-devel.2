Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7543E9A75C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3643310E137;
	Tue, 24 Mar 2026 10:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eyWb4tBj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrnQEWgE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5671E10E137
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:07:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O4ZLbx1909464
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sj8Gq3VQ0Zc3+20uFwp97cooX31vcz6gw5LJfk/5xvk=; b=eyWb4tBjsgLq/rc7
 6C+ZbNOr1eotnWI/zvVmTYUJlXNsKeJGR0oeewL/ijpWJrhb0QZ88RzyIeFsrHlf
 l47/CgZpvDcBBuYxHoEHYrGWd68mb9MrmJuss53XTKKVMkbJUfQJk1Y9JG4Glkov
 grNqECSHp3FfMOKorggpjKAsFxYYNQbv6+6GZTI2X/CqxMfgnx8J6pIoyItbUz+/
 jOeHY2ZFM6mmmnsmM5AUtxjjGkMBmh2RfedXMNgKzOHY9BiMIrzfZMy1mvBOHxon
 RM1Pr2LwyDERqsqv3ReS3y39A+WhDpXaokdcKIMg2xdcDNLLf/kFf6MlhbXrgAY8
 59C6sw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3awytwmx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:07:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b4bd8e77dso23895381cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774346844; x=1774951644;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sj8Gq3VQ0Zc3+20uFwp97cooX31vcz6gw5LJfk/5xvk=;
 b=ZrnQEWgEqKOUvyouErJ5T5cE5sd5Mipk2i5tNmhI9xqty+A3MuzIJY9V2+34OG7Xz8
 qbrVhYt/rs9GtRllqToxuHO75UguCgKXrjd4b+2I7Vn7NbWyuhv/Ibr1Vfx3joPreSy3
 2CznJg7uxxlP6zmh4ruyPX7EMMsevD+WFw+54q3PeZA+/5C/2Tkz/HtrDJ7C4qyioZbz
 24XUZNw5zF/b5sKd1yC8n0p6YYNEQXSOheT4Oz88rBrB9NJQSvhY2N2i42v8nMxnHX4A
 TW/TlrSn7gWQ6fPOJqlfVg8g6c+kVtKMYXCZ/gEmD79Xyc7GyO6A6WwzSuHM15Ep9cSl
 SFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774346844; x=1774951644;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sj8Gq3VQ0Zc3+20uFwp97cooX31vcz6gw5LJfk/5xvk=;
 b=gQd5N/pc8vs66zVMG7O0hEhnCxxzD2a4flmCapN0wVLPd/q8r6EuUhJdDwjxsfG0Ed
 oeqytLzcp9nmn2x7G0Nw5u5jgDuC+pxEDo+HpFtdP2fJBClIJxQTUquduiK5jO8IhjMt
 7rfVCmiyFSFHyOQhUL0OuKIz1qD9aS9JW0X8pp/GKjeQDotNeSagVNrdHsfMVw0drofQ
 u6X0wtipp7gQwmKg5nCsHgah3orZ9ATHG9FoaX+9y4enyi3Wb1WTkmuAtiSgHbCppcWL
 ecmURcvQGA/t3VbSeaEtEjHVVJkVCb8wK+EjQ1pAeN4RogFLYJAx+LnMFV/5R50HMYEt
 oKJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkHweaj35vEwDsnoSFenlCJ01bSb/hxrnE5Odi4GX0SmxOPwRFiWrSzW5w/RSh35np28cuAgO9a/g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwbA75cS/dOtIRNJAOzBg8JdVpwErJwaqGUfWBjVhwCDIlg6R9
 Va1TAuCvZMRME1lN2SVZEZENu/WnkXkTElQzoVVonFlqCN6c/Z1dNagVxuUozzouvVkFNlwZWRF
 SMVk+47X3n/GIGklcXkhsnxOHBWwxcbKNEBqQu6bT2hdT0f420jgpNttVDj2mAFoqSX9fwas=
X-Gm-Gg: ATEYQzyzSpi7PzZbrXXIVPbrG1TYUnxhXYZH+CDxwHTbWib72yZmxm508gvbjt+9S0n
 b4DcyWmo9L76wFbPf5GO5P7XwPU16dwOeQVMHQA4X8WF2f1oJqOzGzB5mCOr03vQ1jGoZ4XWJMP
 tLhm1HvAG10NA/N37S2FpysXKKuFoQEJUlVQSNoNKshK5j2x9GNyOV2xlvxF5ggWuSlBviKpPGy
 NOyVXYTLFV3vpj9QokvXWgMHGd49YYJk+JHKmbNlV4Qkreihn5SBJlIHnEHA4K3obElwk2aFcLV
 eOKghFPLB3On5rxyMGpGKKiJe4Bbv/t49qIaWa4dFfNgyToZWkNUwHFXAd/pzsRoe6i7gwju+Pe
 MvvWRhyON/HQ8eY6YTSGrEnKLNSWT9YUTJpgx1/N7dRAATqk9zuFaKMnJQz2YoItz1WGjOz0f/3
 lLG+0=
X-Received: by 2002:a05:622a:4647:b0:50b:6b21:2a80 with SMTP id
 d75a77b69052e-50b6b213658mr32330461cf.1.1774346843890; 
 Tue, 24 Mar 2026 03:07:23 -0700 (PDT)
X-Received: by 2002:a05:622a:4647:b0:50b:6b21:2a80 with SMTP id
 d75a77b69052e-50b6b213658mr32330271cf.1.1774346843436; 
 Tue, 24 Mar 2026 03:07:23 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668cf7e30f7sm4480697a12.8.2026.03.24.03.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 03:07:22 -0700 (PDT)
Message-ID: <e44e776c-df8f-4555-a487-9a7a6fe032dd@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:07:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] drm/msm/a6xx: Fix gpu init from secure world
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
 <20260324-a8xx-gpu-batch2-v1-10-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-10-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MSBTYWx0ZWRfX2bVfOs1Z1QSm
 qYNWajQpma3Skn9IJ4jVIJHZgT5XlCTlccQUQMedgw7ycazkD06TXp0QshBzPE0NVAbrI7ypLlb
 OvX4RUxHVWvnPTVXcddnBwAGuwRCdVJvX67eYcT/m4pLb70ZVYtMV/5MamLQoYE5CZB43e7SFeU
 CuJYbqW4FyCBB9is16N4ZT4gwulGGHD25qEnoNWfLCeQ/uDTl/V9+2pNPpKXDmoo+5qym0TsHOR
 o0MZ7BrzY+vJKBAhDQboEAHqRkK8yPUt2bZSdk6QzFqiWriEy+cHL6OuTIs4IVl4h+j6aqFxXSg
 VcvYEZGaVDJ+wHAtiz70gT0riOX/DC+nMNHIJyTxEpCmrXLJlY4s/pGpQ02rPipMOinr873HE/p
 M6D0dJk/hFcPgVmuAJOZXPmlumIdBshM5/EJmPcuiBKJsEYCETN++GAxLbax2e/DEPMyYnYBAKE
 zaSUdAhX+SZtlAugmVg==
X-Proofpoint-ORIG-GUID: BoMNLu7kV4i_q9QhW2W8pR-HcpJHGpNF
X-Authority-Analysis: v=2.4 cv=KuhAGGWN c=1 sm=1 tr=0 ts=69c2625c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=vwBs5ZOmTvMLfzL7RNEA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: BoMNLu7kV4i_q9QhW2W8pR-HcpJHGpNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
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
> A7XX_GEN2 and newer GPUs requires initialization of few configurations
> related to features/power from secure world. The SCM call to do this
> should be triggered after GDSC and clocks are enabled. So, keep this
> sequence to a6xx_gmu_resume instead of the probe.
> 
> Fixes: 14b27d5df3ea ("drm/msm/a7xx: Initialize a750 "software fuse"")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

This now makes this happen on *every GMU resume*, which sounds
undesirable (kgsl does this in gen7_gmu_first_boot)

Similarly, we call a8xx_gpu_get_slice_info() on *every resume*

Konrad
