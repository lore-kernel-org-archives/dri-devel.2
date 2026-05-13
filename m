Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298F4CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 21:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791D710F06F;
	Wed, 13 May 2026 21:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V3ZTMjoa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fCXNyKvI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B65E10F06F
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 21:10:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGB4Vw2524633
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 21:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EP3xjrgY2XMSo+tnYkujYFohkhHAzdynEqCAcazAHkk=; b=V3ZTMjoaZ1BdtS+p
 M4LwfZsI/ayfy4CicDWmR9bbK1xGJksY4o9heQnzoxxRlRjF/DPCWgtb7tdCZmHj
 wSAaVMLrFYmgKqc92ECa6P2gyokl7KtPbKSNHLWV1LBQf8UipU2KH9Qh8EvzTk2K
 IXxRnMrNhNAjQkE3cBYvWA8BMRy8S0PVNrTA+3Hap0V1tqq8IIJ1POwdw1ZpRVGe
 aAiulVO6ru3Lo0zgcJgBk2blQ52jb06umsRDB9rFq7cdqI6BrgHlmUiiNz2B795O
 GXBErlTmAeL8cS25ZkILYVSQ9YQ3BbQ+Bb8Y2yByzvioM3zS2beL9a2oLzKXTL2S
 XS7HLA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjh6d9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 21:10:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-354c44bf176so8595342a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778706647; x=1779311447;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EP3xjrgY2XMSo+tnYkujYFohkhHAzdynEqCAcazAHkk=;
 b=fCXNyKvIhT2I+4Y+A9pK/UmDSaJ9/mCNTsfgaABkdRGHp8c7PRxWkl+7uiJ+xrSrlJ
 /kEl6gPykdi+fY+R0HKafBBhzrE6AI0W+GLhAOnA64FdD6/OvROyYF7rTzPstZlcbjrS
 bs5b3Rg27HhC2FCElJGpEmC3IeUwBsggXWoph6HhzQhqgBfccAAguvnZ2JsCKn8M6xb1
 PhYGxeqKL1fbH73Jv+p/txaBSAysVaHfwHb3CI4RyhpaaWPPDoGAO8FauriAoi/Qi3C3
 AgOp66L4Fs6nRO1+dV5JtLl/YVK/sqbMbw3BkWXm5MT4wTdMmKR5+qR06Fv0ZAMvIsE/
 DJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778706647; x=1779311447;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EP3xjrgY2XMSo+tnYkujYFohkhHAzdynEqCAcazAHkk=;
 b=GelP9M4TyF/jX+VmfM/Iu1Gn2CAvk02z/uLT9EkBHuRk2hCNvg5Qx0US6j3bRvaakr
 Ubh3it4QIGCXJgvy9pOZlPDOQiDIp92gli3j/O7eyssyN2d9TcvTI2uaNLpusp/zlrcT
 n/lo2j0dBlaEKKrO2OUfbikuF0ejSU6HpXxTLRXpUjlu7cPLdZfTteA8zWYllqWsU1DF
 mydyDPLOkCIPvQe7+KFIZ8uhvybJ+YirHRF/FhHU0yJ+J9nnpBYDJx7dqN5n6MwaXgjo
 ZIncWd8NjgF2MZyvEnax+c3KDaxSRvzKF08zH02+DMtT72/TQl0DjUvLvoNam5VWyiNx
 m3Pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8x+WMq8hr777Z45AToWZjvPclw4bkqXwf9lKs4ZL4Ip5aKhV9DxK65a6Tqtpg1kluQcbKbvvvmhe8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8L2Ho5/7MOButF6hA0t1NFaR607be0hE0wOh7OLMeTz6f9D0u
 whF72j8fQE9CeBkXDJXXZzbADz927XFgd5pfn2WRDsT8kAr4ixIpyD7j1K84equmUUfPcIMSqj0
 Tpt6v+6Jhu8+jmm/K7sNZZXweLAnCKueQAmo1MpDmLqvzlDoSccyhR4aDU2PTTe2QO1ibQ8Y=
X-Gm-Gg: Acq92OHawz74Sx38TkRwHIqe9EEA0Zrw9ANh+8O+sUXC6cmTFmemSxdHRtkXEQpuhAd
 LogWEJkTLS8UuPCqBEQtBVDpTNC5A2I4gK77eqr8XOranwmCkqCOdb5KLwJOWUh6W4YrLAFHxIQ
 /lyY8H2YTWr+dQngAYtQQEe8NtWia6EA2zlMjXpAcUTVP/d2FeJ/ngIXlA7p7DItISqkGmWY2Iw
 oShpG7LSisSQFdKVoBYYYJHd/gnklW4iyHOnS9Lz2NvxzycY4ADdfwT8kscXKquGIeUFVYdhYgA
 tGrRKEYMKuivwn/Q7Ef0VWDM4Rw8pyqYLKtGMYdLeXDYpysO6SruBzcAsJx3w+lrgfWHV7J9xk/
 9J+HrVIevXAkox5ZKpHFjo2+zfPhhxq91ba+XgaiOeo0r
X-Received: by 2002:a17:90b:3a46:b0:368:ac5f:d313 with SMTP id
 98e67ed59e1d1-368f3e7b6e1mr5521377a91.20.1778706647266; 
 Wed, 13 May 2026 14:10:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3a46:b0:368:ac5f:d313 with SMTP id
 98e67ed59e1d1-368f3e7b6e1mr5521348a91.20.1778706646758; 
 Wed, 13 May 2026 14:10:46 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.229.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3692f4a3c8fsm187754a91.16.2026.05.13.14.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 14:10:46 -0700 (PDT)
Message-ID: <1dc269c5-fe74-427b-94d6-85b5aada318d@oss.qualcomm.com>
Date: Thu, 14 May 2026 02:40:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 2/5] drm/msm: Centralize the standalone drm device
 check for GPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
 <20260513-gmu-sync-state-fix-v1-2-6e33e6aa9b4f@oss.qualcomm.com>
 <roeaegvmg2nvzt6j5yhmsv6p5vzhvsglzkmtvbnw7yq7u6bqqm@lo27u5mwsrwv>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <roeaegvmg2nvzt6j5yhmsv6p5vzhvsglzkmtvbnw7yq7u6bqqm@lo27u5mwsrwv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nSckj6OkOi0n69cCRfRFaHLhOKNuQT-f
X-Proofpoint-ORIG-GUID: nSckj6OkOi0n69cCRfRFaHLhOKNuQT-f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIxMCBTYWx0ZWRfX6+DmJOPGwTv1
 DxZ2Tqkbc0ztm5IxmNfQYPdxbvXkz6IugiYbpStmtd4GiezxNBtSeN5UkJnINa7sIrSlcg/u/v+
 hTHvrp3V1PpUhnggAvlS1V+mdkYSQ6ZEVDPlka3UCDm1m2WejXYCXYafz2rVHUci44SyKxd4VuY
 3+BfPRLKjhSS6b3FB5gMnnRY73RwOhalfYXBxBB/bR1TVQZZrn4JRJEPD5514WpllsTcyvRUa0e
 CLSEiiFREADX+v2gnTg7qGKjM9Y/CStoaGWboEK6ViKbHW2Fh5Owtk4wsg9HEXm1HA7UQS1MJ2B
 Kwxu1Vgn44cDK2yOcKzAyH3BaBwAZd5Afq/j1fcCryeX/Ez6gNjuzR9LjjEc2fTvu3zACXVCifv
 5+9nvNN36qmdSCVCbkeJxetbmWMGYx84bRUQ8+Cc50oG3AFBxrZAX4z5Eu7mmDjdjsRa5qh4afT
 EugYZigM+Hg3yx7H/0A==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04e8d8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nm1BsBjGsf7C+PoY3QnOXg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ZzDrR4TfVffB5w7mJ1MA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130210
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

On 5/13/2026 11:11 AM, Dmitry Baryshkov wrote:
> On Wed, May 13, 2026 at 02:22:57AM +0530, Akhil P Oommen wrote:
>> Replace msm_gpu_no_components() with msm_gpu_use_separate_drm_dev() and
>> move the platform-specific check for "amd,imageon" into the helper so the
>> policy is centralized and reused by both the core driver and adreno probe
>> path. No functional change intended.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/adreno_device.c |  3 +--
>>  drivers/gpu/drm/msm/msm_drv.c              | 11 +++++++----
>>  drivers/gpu/drm/msm/msm_drv.h              |  2 +-
>>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> For the next iteration please swap this and the next patches (yes,
> introducing some code duplication). It's generally not recommended to
> have fixes which depend on a non-fix patches.

Ack.

-Akhil.

> 
> 

