Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B98CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E6FC10E1E0;
	Thu,  1 Oct 2026 07:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ddDKURof";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OBG+I8pi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1EC810E277
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:48:31 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xN9e1062181
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 07:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iUE/x4AAkeHFO216HIlMg4ngpja2zUSnzj99mniJ9e4=; b=ddDKURofQRcQ9hYy
 Hq2aYwXGPVLXz+PHbeakAa7UV5gYiFvF1GeSwOqA8BykI38LrnOhvd2BgvVNGh9R
 8IhFbBaieVVVYQ0aSNAGDSTQO7lwLm5GIK7uXpU4xpNkOVl/o/8Gs2mHybN2WLwb
 xVQkwFMjVIoGVXIFd7WwA7XqUmvFgVY/Ne3CLan3ojNQSQhU+GoDPq/Gogk4IrzY
 Rxcasv/xQYbkCrPZtxxjVjO3WyMufTTbhIAXi0QpbFxTOg3bkKx5ShEMhQP/imXm
 Sjw0GjE8+ZRSqEm5NKvj3G0NJ6GOYnKT3CbFpy2h/X//7Nuo0bP37MUcfnHfNNkQ
 ewj3eg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvtjqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:48:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917a04d1cb2so3690836d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 00:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790840910; x=1791445710;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iUE/x4AAkeHFO216HIlMg4ngpja2zUSnzj99mniJ9e4=;
 b=OBG+I8piIKI64y0yo5YGu4kIEN8luUVtqEHIZVp9JMkb7+Jo9IUngwCoo0gDzkgle/
 kK6a4ocf/sSpZEVrKbGpyQTMMbgtiBly2gMk0S8xqKxWiBIkb+2DKz7cesaZJNVfvD4J
 Tob55nBSH91oFfd2jovUoxS+PFLXrbyUQ2vk1Ey3lWVeHcr1dSGXRhLXks4rZdKziu0k
 dJ+e5/nU7I8FPuS6Smkr9XQeCvHoy19jIiBQ5G3SFDWE0HU4cAQbP9uIs6SUlBz42+gk
 UY2HdDyDIc5qZy+lVel/r0Z69lG0ksBGzY5bCs9qHFlP+yhviiNBAIBP1/a+lnwP6N5i
 mtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790840910; x=1791445710;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iUE/x4AAkeHFO216HIlMg4ngpja2zUSnzj99mniJ9e4=;
 b=mrLKLnFSavZdhKaqAyyR/6a76MO0HZ9SYVp8OLOB6oLkHpnPqcS1bJ6Ax5oCMMp0B4
 DgQhgt3qZ5HHhRmlxXpPPpggDW1KXmDC8NIVxynf8rxgcm3FZ2tWURFo/DRiIpp5Ijyr
 NHu5HqWo2S4B2tiwMzimpYS0MGYL8bcq42yutsDVj2FncIY8lCQ3u8MMGtCc/CLZoz+L
 8Zv2FlFrGpbKCl0kCSAGv3N5XXBPpEIIE6L5sAvEO7dFCleMXmfPP21ajdNwl0yGKxgG
 vUKlqF9Y45uRbqJL1YrDUiJtRuY4GOOsfOCGSkHxNvf+VTx3owPMdINgz4uhqXtKcZiZ
 O4Cg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmhL2ZNgUz0H8p/N8Tq/ih9pyKlPZZJbzPzYY8CI8CpsvmtMfD/NxPv1I/pl6xnqwpHJHXUcXll9U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k5ilonv2MFG+asrNHfd5/T25D8iQXRFgrAXucB0F54r2VOtZRo
 iPN8EXhc9CFTGDIMIVNfert0NHO3msU0TPA3+z3SWSNMCLjJqQrZZgW0xmw9nc2iymK2G7nH5m0
 h871TyrvS2xnXvTJnmTGsXIBXYzbk/L+iTkzkSw8ubqXe2V8srJzyerv7EfRNS/YmN0xo6Oc=
X-Gm-Gg: AYBFou1A6MAsZh2c2/OK6nSKDHIAoeUN/WFbQvt2QmPAlVfsrgEHw5n+uP4DCSsKq1D
 vT5P5hNI9Nhuyf39e2M5wKtMnvF1v3QncZ/L+KYqgKjCQ1KtV1FV1MzWjIeO4kfkCDPiDe77z+6
 R+81SZYsB1kJ0yTX/66plhjrVd7sJhEQAzNfBTxVpHROQ5Lle5Y4PXGblpfl6RVuQAq2Fj9qqv6
 BZxwb70PvJqs1sQeqslZ/Uzax1Fbpyotd4dack0zZMe9Xd7zurJCRLav2EDyE2pu3SbSOOIjFuq
 M+W7ZdxYNs+JUWJdML80V3E4o9qYPYTMs1W4LnkR2QzHNFfZVNV2n2rcpOj67+udfceQiVMXr29
 7F9TJ1ITajhMD2kgWcjFxnQ==
X-Received: by 2002:a05:620a:3726:b0:939:94c4:b799 with SMTP id
 af79cd13be357-93ca9776d92mr691545885a.5.1790840910263; 
 Thu, 01 Oct 2026 00:48:30 -0700 (PDT)
X-Received: by 2002:a05:620a:3726:b0:939:94c4:b799 with SMTP id
 af79cd13be357-93ca9776d92mr691541785a.5.1790840909631; 
 Thu, 01 Oct 2026 00:48:29 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ae4c7efdbbsm597303a12.5.2026.10.01.00.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 00:48:28 -0700 (PDT)
Message-ID: <557b1ce4-fdcb-42fa-baab-429c53830129@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 09:48:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a5xx: don't read the GPMU registers on GPUs
 without a GPMU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260920-a5xx-no-gpmu-v1-1-714200254f76@oss.qualcomm.com>
 <1eca3b55-fce3-4a39-9e0d-2c6d1fcd6a86@oss.qualcomm.com>
 <5ibc3ap35a75ovwrhyeq2qrc55qo6zx43tsp2s5obyukzlivhw@n5tgfcsslxrv>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5ibc3ap35a75ovwrhyeq2qrc55qo6zx43tsp2s5obyukzlivhw@n5tgfcsslxrv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RYFsm3Kw4FoidykTOgfZ8p1HaNElA5wr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMCBTYWx0ZWRfX54Heg4vtsTxJ
 5W5XskLnM7HT3VpyNGpu3Eii1h0jSPgoy9CyuSL/41ncXUrKZ6S7ypSjihvLEBR669QyLMFHPpJ
 24NGZ5KarvdGJddNJ7N6xlm1JBFND1Nxnyb49Ebs5FQ+S5opRFioHtc+cYXN+jQ4+aeD3bfw4zA
 dliB5BiHjrhsdRhto6u9LnEqK1PjuASi0CCmyv6saUzRvdXojs9JKOnrgnqkJVdHTn6U/aHfDD3
 5z+v2tbuRocyuRgrCpJCAgn/uOtiQe8x48q4X/F3bCa6091gI6y0rmbmVs7qUM4x+0yI/Fatr3W
 aVm1A81DY83uF5IfAc/REeiyxCQGLT8Ffy7qlaZd2pSytyQ+cznA8rAbJWnrpXOgFAMzTvboU2E
 pSh2VnVAQ/+p4BinFA6ZlsoBkQVkASKnY4fCmsCTWTGFH8CQOfMDJR2q7re8SVC0PgBnoFVNV1o
 +/GU1Zo+eqqo1RmmU/A==
X-Proofpoint-GUID: RYFsm3Kw4FoidykTOgfZ8p1HaNElA5wr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMCBTYWx0ZWRfX3LT6HDVI3IkW
 IfXea7P23kN34A1vFI3ta8DjMxXr9MqPvisPqCgCs6XrU34YwM+2BLtRBKmT+pgHcjCsK4VaEKM
 HjbP0rUVABkqouvZRyymz9nvepDmUAQ=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abe104f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4YALIuPG6eELS2f6wpoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010030
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

On 10/1/26 3:53 AM, Dmitry Baryshkov wrote:
> On Mon, Sep 21, 2026 at 09:40:35AM +0200, Konrad Dybcio wrote:
>> On 9/20/26 1:08 PM, Dmitry Baryshkov wrote:
>>> Only a530/a540 have a GPMU.  On the other a5xx parts, reading the
>>> 0xa800-0xac60 GPMU aperture during a crashdump resets the board -- on
>>> sda660 (a512) a GPU hang thus reboots the SoC instead of recovering.
>>>
>>> Split the GPMU block into its own array and collect it only when a GPMU
>>> is present.

[...]

>> I'm not sure if there are holes in these ranges in the hw, but msm-3.18
>> (8998 kernel) simply has:
>>
>> 0xA800-0xA8FF
>> and
>> 0xAC60-0xAC60
>>
>> (both ranges inclusive)
> 
> Yes. However these tables list registers to dump. We don't need all GPMU
> registers (and even if we do, it should be a separate patch).

Fine.

GPT points out that crashdec doesn't recognize the registers-gpmu section
name, rename it to registers-gmu or fix up crashdec

any which way:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
