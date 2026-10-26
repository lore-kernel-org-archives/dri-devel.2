Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525DB60A3803
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bd7cZQyA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EAOObh3M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B9810ED30;
	Mon, 26 Oct 2026 09:41:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17A410ED2F
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:41:31 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4avgW2727079
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jtOjUMLPVMIzOsKurX3BXE45pHwIm7WjBEObd/L5hnU=; b=Bd7cZQyA8FERtPMC
 Tw6IJiAeOXlQKyEVxMJWsUOC0cc9DZrz47pkfs3hxjFdRfxZbYrDZSHWLnmY3xg1
 0QGxG3mzS3vx2GzCN+szDYr3jJr7PBL72Xz6IZ0Z1PlrkBkz82X/MhyMI6LS9CgA
 iLphsZK0ZlS6qcvqEXyhHVhzaTbtlVVqOTRjWTrKOrgfSIkjbWV05NB/cD7qDUtk
 YlO+8Jg+VFLMPYKxqJcZUTWVBxPzzsLfFEngBMAg+xvALDITXRmPf1X7c8ueRHst
 CTDAzjXhQv5pNw483LxhKBUMUlGdRp62IHsteSeMTB4JtB6YFhc2DCpiWufG/AcA
 KFsndw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6nvhk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:41:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e629c7b16so35746985a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793007690; x=1793612490;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jtOjUMLPVMIzOsKurX3BXE45pHwIm7WjBEObd/L5hnU=;
 b=EAOObh3M9ZbqqvvAuUiSSL2ICf5EUQSZHmTu8L7rPoSNA/2Ck/jYOigozm/xdd+YcD
 pmJ9d4cwun3C3JuIxk7CALYjHaAwcy4fSTMnOqc6XYIwDmcN/EmqTPmhzuKlIE/Wz84F
 a481+mVN8RCjGjZnD2qNbMNcx6s+oYIBmWhuHMusUewpV8PfYmr9dKydogFzHGq7m1v+
 o1snBX1YXMyFz6OlReDFRacTC0d3BSAY4U4KSj8ErWHzHfKAcczUOXo34gE9h3jAIkrH
 h5cuhkxjBWCNg+xCqa0MolUYNQ3wWRTG2SRVwHKKYffgGgkGWlcNnNfyMHvT5+2lQQdr
 HwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007690; x=1793612490;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jtOjUMLPVMIzOsKurX3BXE45pHwIm7WjBEObd/L5hnU=;
 b=NrMbbVEwygFGPE3DeDz5NPuyd+3gnDbOGWZxnNObdi/3p9XyNKp6A7CwYVOPhxiAUD
 PW17sWKrMmYYI705F43abync75gijIPnsLTauyMozc/MpOGDGv7ZoAQdC8FXny6B02hD
 amvIzV8ijBBBpff7PNOQ+k8vp7rzGULJNqvVXbpigh0AmkdyTk/J1Tv80DADOafm8XR1
 KV1aucTMF4/5yZIsC7PAr/K9UlhRr5pREvUJ1qB3k8qqf1ETmoWxCokM1BFHqYIAOO4T
 +25u+KM8OOBNajrL0FaMMvjiYkr2MXD7rpg8t8jYk7/H2NFkRPZ3ittdOewP4fTj///s
 CqJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFvstPgiODPxCyMOAms3ASjF/HJRk7UdsM470lFBHt1TP+hXo4QN8iO+ks8AqMjPUn2/q0fieyX1c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL+221/a6/MkEJvgDk71AUxYErLnGsIi1+V79cH0xEyvGJEYjL9
 Jo9+OaVoohEWRbZNfgWjkoY2wmersVsz0l3eR7c2yIt8if6Z6EjurKZDi0tdru+6iklkh2FWIEb
 46Tu4zrFn1h68SKxYfxJs4rDJpFej0HKvQaiOZMKd9WjVTKnsvx26189wvXBHu2qtsxS+L78=
X-Gm-Gg: AYBFou0NMD9D9Qd6SPEvcDrbHvIUBrW15d2E4Jf2M7hT7fEuKz1cpYHzr8DHBk4vXu5
 M1UtYMSb2tQAw7TdQHHHTERHKlOfJtYWysCSfuNEGXmp462CsuVeqga8Yndl3dhTl6MmUu+S3uU
 yuzrALNSM/RxPi5o+sieNquOEiGdg6vEvqdgh1kmV/ahWtI09UU57r3oJ9uTqMbFi2V4FDpiqSs
 lppAsoIg0PqHRVFiyhk0xj/UjeYBp8MMA4u/Cx8XPqc7T7vBzktCrTSd57sKK59MseIWSro9awX
 QbiuW3KAnHuQvyufydjKqbZXjH/S3YPW32dmlaxUr7kb7Fn25w5IZ8MJ8xVL0uiZDEuc8hjNxnR
 1+YCXD4COCc/ewDAuPC+auw==
X-Received: by 2002:a05:620a:899:b0:939:eb09:4458 with SMTP id
 af79cd13be357-940ef8dcadamr954270285a.3.1793007690189; 
 Mon, 26 Oct 2026 02:41:30 -0700 (PDT)
X-Received: by 2002:a05:620a:899:b0:939:eb09:4458 with SMTP id
 af79cd13be357-940ef8dcadamr954268585a.3.1793007689733; 
 Mon, 26 Oct 2026 02:41:29 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm308885566b.51.2026.10.26.02.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:41:28 -0700 (PDT)
Message-ID: <9bfefd42-8562-4915-9d5b-8fdfd2cb6d8f@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:41:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] drm/msm/dpu: don't tear down a failed hw_init
 twice
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-9-66a30120a5ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-9-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4uAoXINFW5nbrRe_eA6HzEcySI1s6Kuh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfXyHuFWR7H1/O5
 KXRU3ao8qgGiMklSavV8rNsQ4MaB7Mk1xrASP/4lPEblAkgJGliYLQoZAHZy/nJZKWyw7qWKgiZ
 Cu5XnRVgc4OZWdFTg/eGbs6JKqGAOlk=
X-Proofpoint-GUID: 4uAoXINFW5nbrRe_eA6HzEcySI1s6Kuh
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adf204a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=6EvNe4Iz7nrDccDV2EAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfXxGVLPHvdoKMC
 GFv6R1a3sOL3Wc9saqfT6nWBE1P1B21aY/QstYWpgKC/x1WeHPdJYRlEiTwoSCuiooDBI9b2QuY
 es94oomXSMlh0BerOcVuQ4UOUKbvAd8j8NSeA3c6/RMOlLWuqtXlf/WBdBAqqOdiJjRr8HmiEIX
 z0yEZT92YSUVxrigHyzdYTrA4OjxfSktoSmzN1qtcVqC9nLjk9iXp4cBuCUFHYZbIaE5gdbLCmF
 4bGPJg8PgVgSAkEMDrRa0RFns2SZzQ3oxMZE8HDT7Eo5YAhKtVKizrWc8n34mrRJs8RnlLuwTkR
 i/QpinII2Zttgfgdl9PpIUtCxkGAccAjlTtqRPe/CFeAHdfw1LEypBLqLQInPP7cqeFJE90FoY0
 Qhiq2hlX9JC300ZzjLwi2kuDfgYxaFzx2zsr8W1pRzTW+S/7Bk3kHBczFifi70/j+G5tPeDQoPU
 oRqSLMuiILrlbEF/1QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260038
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 1:19 AM, Dmitry Baryshkov wrote:
> When dpu_kms_hw_init() fails it calls _dpu_kms_hw_destroy() itself, and
> the caller then runs the ->destroy() callback, which calls
> _dpu_kms_hw_destroy() a second time. Since the global state object is
> finalised there, the second call deletes its list entry again and frees
> its state twice.
> 
> Fold the hardware setup into dpu_kms_init(), undo the steps of
> dpu_kms_init() when it fails, and tell the caller not to run ->destroy()
> after a failed init.
> 
> Fixes: 49e27d3c9cd6 ("drm/msm/dpu: finalise global state object")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
