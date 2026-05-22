Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C6ECD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A4F10E1D6;
	Fri, 22 May 2026 09:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="puFzssaY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZhfqKmcO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F4010E1D6
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:39:54 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M8oKkW1658210
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fZi6CGqyMwgYn7xlaB2Q8iqRILRAoRP37K/MNg/r1nQ=; b=puFzssaYuhrJx5xm
 QRJW2mO5np/Mon+Kw4DMB0vk73EnKszD2lceFKUYO10QUYo47PWn9o9iaA5a7e6d
 J4b3kTOHqaLep58dwF3o8rrLv/wycaPQMKEVOn39rVceq7L8UgeKDk1WOJcGw3cW
 PM4La5GiF0Pyx49F5rJZun+F4ll++r5FyjlCDLp6pdBqzD7ge6Ud3KFKbGR8Ncg8
 Ywh1jepAbN+/ZagiGRTmDgG4XfbIDuh59yjs107XBOzvQ4UAb3Xm4z1L52B+lQBl
 irBU5tgSNV2Tjdr/ujokIyQ6xyyV+cl4ublaLO74e2vUCDjjd+n8bT7TtXxV3WxG
 g/eDYw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea0dkn5ch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:39:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8acb4b340f4so18412626d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779442793; x=1780047593;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fZi6CGqyMwgYn7xlaB2Q8iqRILRAoRP37K/MNg/r1nQ=;
 b=ZhfqKmcOFnEszl0lGcOU+N7tj48KKoFKUb1xknk8SpMnaOOesFaMLE+z/M0bL70mQ3
 FzWDS5VZ6GnFKYW3emqxVHRrtreUaZJw6dRpqEcSBD+zxLDRthlLhMK6NlHrvEnU61M8
 sC5azZFeF9h6Xj5c2PxeIhI+MQpVDkpuw4vdo5ys9IhxTWDnLTY4nvUhp7UauOH3B0lA
 cx4Qi8DrJDX5nf6hlBHCZ88W/2BU2HaaK+UFMldAEiRRyoNHVkvLIzYUYlgsb7BS0NoZ
 i9YcX0Xt1xYD47bVvHKCvPx/jtlZet44Z/0bqu3wK6Jo8Hthm6fnDHGA0PNkdUl1/n+z
 KLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779442793; x=1780047593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZi6CGqyMwgYn7xlaB2Q8iqRILRAoRP37K/MNg/r1nQ=;
 b=gcdjrV7Vr2LTy/UsxCDyZvtTpayeSNFTVFfW0dgkOtpown4k7UOveKOCX/FvkTx2nM
 RH0h52aNvR76DPNOOS3e7AhcCSq7oTbpiCNH55ygDmHcnsLUNV2cRFSet966NOSH/Otx
 w/ZE3PuzULJpVfI4oG9Tu3OY9QT1egtSlY2b1DVpDzvQdFBUKzRN84bd7OOWBPYJS/P9
 N86YeckfPTXuDaAhyKgPsS7s1NYAb/42sSHkGgw2+5PyA4IE9WV46TgWNLEva/pIDiOB
 G1/yY9v9CkdoPyacliv9uk9YSWyepfJ/DY4fhJuTCrHTijrAUTIR8r9Xu3EHfHvqGghj
 ya2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Q4d6oTtraWSdGqOnR760BsZbfQN4dn+VnojWHQkA/tps0qIUEncQzQILUKOXMLVXCmTXIzcQLwn0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxo/y2rrYuHDFYtISacu9drjH/6eIkeNGp4R34KcED8o4yGeN68
 ZqkVGZW34EyZJgaq2PvTRdsToU1mUy5zzZYfIYXZYRtE63djir8bRpcDX9gAxER0Ur1Guv5j2OT
 3Q/fwZ7tCPYkzbJIuja8Wrd+lYPj+aQFZi5uiNC6ufqrC9d2Unh4E+oHOH7GHQbxReY6X85g=
X-Gm-Gg: Acq92OF4yy26J4/bkKvfNukD6VCdiME7a/ihA6sybT+uWmmPxCnDnrcpjXZmj8MDl9c
 gzKhHy15+65FSZOglFwErR/C+tXkpiJj9NT7MuEoekP6phkh6VFQiByIwyw8vYqsQ3SnyRDdfeV
 tgDNlY6nv6w/xGDzHaH2AQIGfSpzjo7UMqqNXURBLHDbYbXuCfAtQ9sn9ufcHJA6aTIT8XYFlx4
 yx3lq1SNNGzgd1qUgMhc143VJQdGJF625ZkZLq2+24H2xBC/nlLAeH37elK8U8j0srCcOxhsu2P
 pKFnynU/opK7ChT5B7qKYfpcJU54ZPcTofq9hPOND4CgloSYjJn+W+kN83LU6DB9/tiEPrdCC0m
 881P2B7pROvufTwpqxUm7WY2gGJYEQR/Cp1l9c3VgHfS+ew==
X-Received: by 2002:a05:622a:4a07:b0:513:43ce:eaa3 with SMTP id
 d75a77b69052e-516d43cfdbemr29963161cf.6.1779442793258; 
 Fri, 22 May 2026 02:39:53 -0700 (PDT)
X-Received: by 2002:a05:622a:4a07:b0:513:43ce:eaa3 with SMTP id
 d75a77b69052e-516d43cfdbemr29962971cf.6.1779442792837; 
 Fri, 22 May 2026 02:39:52 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc66dfb2esm35573166b.59.2026.05.22.02.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 02:39:51 -0700 (PDT)
Message-ID: <191d66ef-7d36-41e0-b29f-1ddd47812b75@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:39:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 0/7] Add support for Adreno 810 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss
 <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260515-adreno-810-v6-0-fbe04c7203e1@pm.me>
 <3dc009dc-8f36-4735-b849-d952fb626cf4@oss.qualcomm.com>
 <3vzdlxnee4w6mur5qiyk2rhewlugswxarhevv7l4zo47qnnqah@45oxl7rjqawv>
 <01b424f6-6617-442a-a77f-9b7a8472c447@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <01b424f6-6617-442a-a77f-9b7a8472c447@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NCBTYWx0ZWRfX8bZgSIP8W7Vq
 26Cq7z4+W80QW+71IqaVmZ+97psELRS4H77gXypjMJ+YtmxaqxQpDFu9vObN59zOCLWnjYwh2Fc
 mIY2ssEQFC6TRrldWQWEARFUpGDOBuVqLE0FWTfd564zedGPQscrccHyV5puWSO2Oi6GhZOrA7k
 o3YXcZvurelRnjegmXzHLLCMcRgFEtM/FoJYwV41iVXPbtnp918QflAKVbQDNmjDoODMIU8Sb19
 /fp1hftGLG9uQgkWy+Fig/C+10x8hYo75YYu+Jo+rurEZZ0fm+m0fEemtF8btnnUoSc/XJPwMS2
 REuFLH8Ne1RSOVEkk1YHiZmgX35gg1MqXPTqP5Yx1OfQEezzv4H/Ce027Y9gMxuprv36cXzSjxW
 PQAYcsxld6dgMk7hb0I40BDWatJqKebS8BSLhYgSVTbQ5cKdxu9frNUC8wsg0hKxlzYgq5R3SsU
 O5Jcmqg9xiRBx0sweaw==
X-Authority-Analysis: v=2.4 cv=aueCzyZV c=1 sm=1 tr=0 ts=6a10246a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=ceajz_fLbYyYHEW_QOYA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: abtNoQkGLQD_p9SzkEJXGvOmX3sbj15k
X-Proofpoint-ORIG-GUID: abtNoQkGLQD_p9SzkEJXGvOmX3sbj15k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220094
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

On 5/20/26 9:38 PM, Akhil P Oommen wrote:
> On 5/17/2026 11:54 PM, Dmitry Baryshkov wrote:
>> On Sat, May 16, 2026 at 03:52:08AM +0530, Akhil P Oommen wrote:
>>> On 5/15/2026 10:38 AM, Alexander Koskovich wrote:
>>>> Adreno 810 is present in the Milos SoC and is the first GPU to be released in
>>>> the A8x family.
>>>>
>>>> This series is marked as RFC because it depends on a few other in review
>>>> series, GPU GX GDSC handling [1], QFPROM efuse for Milos [2], and devicetree
>>>> support for Glymur [3] (for a8xx RSCC offset fix and X2-185 bindings change).
>>>>
>>>> Also depends on the GXCLKCTL block for Milos [4], but this is no longer in
>>>> review and has been applied.
>>>>
>>>> [1]: https://lore.kernel.org/linux-arm-msm/20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com
>>>> [2]: https://lore.kernel.org/linux-arm-msm/20260331-milos-qfprom-v1-0-36017cc642db@pm.me
>>>> [3]: https://lore.kernel.org/linux-arm-msm/20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com
>>>> [4]: https://lore.kernel.org/linux-arm-msm/20260417-milos-gxclkctl-v3-0-08f5988c43a2@fairphone.com
>>>>
>>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>>
>>> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>
>>> For the rest of the patches that doesn't have my R-b tag in this series.
>>
>> Unfortunately patchwork doesn't capture tags from the responses to the
>> cover letter. I'd kindly ask to spam the list with individual r-b's.
>>
>>
> 
> There will be another rev to remove the RFC tag which will hopefully
> have my R-b tag. ;)

Do we have a resolution on whether the proposed fuse values
are OK for this platform?

Konrad
