Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2927CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B3C10FDB3;
	Wed,  3 Jun 2026 13:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZDKKye9W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NhvykxbL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 665DD10FDB3
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 13:03:58 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6537ExOd1956521
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 13:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SUKm9YYEQI6OdE6YQifIsyofez6s+wjK8CMcZYA45ok=; b=ZDKKye9WrI8DRLhg
 fdksZrITISiWBbAzREOMa+Duk0ZclMr8+fFtNyEs7T8odq7LV1bXzLQQfSzJugEp
 3KW2O05N8JVNlP94XQRj+OYkks9vN6LD/r4Zx/Y2yUx1CdumUzzaiJv2GX+iGaiF
 /4erKwdmMFsfYlPG9LiLb4yIgydUoOT6/ZlxNpRy1lGXTw+Yjb28KyAc/xHgvYD4
 fWCU+g3D+QIzoX6txLG+gmL8/kYgqIO4wVWC7ebzRkdNEAyzkLGzBMxzeMZbA0+t
 gnQbN4f95S+mLDEqlqmt1TvbLf6DH0NSXwhExd9z1PaG2x9+pN9KvsJUYSCMvU4a
 IP5cPA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejfqc1c58-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 13:03:57 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e6f5350426so39047a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780491837; x=1781096637;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SUKm9YYEQI6OdE6YQifIsyofez6s+wjK8CMcZYA45ok=;
 b=NhvykxbLrCx8Be3byCujZjomaRmEb3FX0GnHZUTmzP9f17IquFEi2dKZ0dBZOHK0F3
 4yPeGFmiQ4UqHog1UUGcCsnR+/PIfWArANNemwKdOBRbT0SdYgNIo5Y+7us2il5aiGlc
 kUQzJWukS9gaqON0aL1P4SVL3JotdNTS2uy3mOjLwL0oVw1R3bEkJSfegC/4R3Hf2Trl
 Pn5oS6HYLjrxjrIYrvWQpjPwNplQkjA6bBdPWsMAKMMa7b7sEtMTi6L+NloVnmDTOjxs
 Wl0I46KMN2yVQSyCDhpayT65m7jbk7cK5o57NveQsG9bI3gAVD8CpvM+ELhJxaPZfpr8
 QTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780491837; x=1781096637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SUKm9YYEQI6OdE6YQifIsyofez6s+wjK8CMcZYA45ok=;
 b=MtlcH2OaHFmCPgnZ/Fj2lyIb/BYsvrOB/1PQZYFM8lSzReH3BkB3r0KO5A61/B67Ks
 2uahkhqM4msV0fJZlQbePfdbd1/zH63lQPhSbuN7dWqARpMx9beR+Z9y86SVbN8bacfW
 FLKjIIffkQDac5Mkmm6alf17d9s4CdyfNnvIr7UYOmpj780hiBJUqRXFxljXux+4rs17
 0S3eWn3Q0AJk0Qo4NRv4jnUmHHJ/sfYu6x7rjqZCfo4iqS7h11zc1ZRt06mKaJCPOpJK
 DdrAJnB9EMEl9N9xgDDbkNG7kJjVhdcdxmJ9hVCFgPBsSIIWxCAvsK49DrECpS9VrpkI
 xB0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9houC3D3fJIxFGukzjdYL97iy6etYsQTGE+3lWl+dRfF7vP2WIhlHFl+5Hh2xtN+q4JpeE1xadHMk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrxoXCVodk3Qt6Hb6TjJA5hPLxoVsvCP8fqJuELQuL07Da2aX6
 iSYDRkgqOswYpJik/biNV+wGEQ4nmrlEakkSPcNh6SaZG0qRyBT70njYAb0xlcdeIrVa9VlH963
 O61jSFsBBph7w41SQO4DMDymO9W37J7DzCgkSsdt5FXx1THxMZGUHvi8RfX3eYZLFXtEsxlo=
X-Gm-Gg: Acq92OFNFkQ07cwQCdNAjsU3SoQWUqohrsJPoHTijhMzDBDaiAhV8GbspDFjbwQaWAB
 cG1BK70VO6xrijIOxcE166pmCA7YTUW3oAICA01+/B6UBvObP9Srs3c1XfWi26/ZsJGJRih/9/l
 XukhIMUFoz7Rl3Nr8wI0VxKWTbQZhE2AyT8m2vK20LsbtUMyTSHMZlEdGndy7Gm9itJmi7YDs4G
 yKpBPB64GeTQi5Fa+ea8IddUrVR70gXPLvtR11zZ5tXa9quHyrCmaF10DfvlZQDDAIVcgHU0+lG
 oGf4oFVksGujqQS7duT5604469bBeFw3xPHCVzx2PNnHxnkspAX9ahBKDR5FkhcesZF7KbgKsSm
 VehycPt09gPsYpYtGyEc8ZFQudy5UuLeGD2M76Q9WzElDQ8l82HlpglZYniUqzVndH6hh0v3rse
 TKqzGoCLS1H7Y=
X-Received: by 2002:a05:6830:81c7:b0:7d7:ea6e:322b with SMTP id
 46e09a7af769-7e6e5fd80afmr1348557a34.0.1780491836469; 
 Wed, 03 Jun 2026 06:03:56 -0700 (PDT)
X-Received: by 2002:a05:6830:81c7:b0:7d7:ea6e:322b with SMTP id
 46e09a7af769-7e6e5fd80afmr1348417a34.0.1780491834475; 
 Wed, 03 Jun 2026 06:03:54 -0700 (PDT)
Received: from [10.100.11.76] (public.toolboxoffice.it. [213.215.163.27])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf051770994sm152620766b.13.2026.06.03.06.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 06:03:53 -0700 (PDT)
Message-ID: <bf72e433-bb1a-4fa0-b8d0-32611b4e2d29@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 15:03:49 +0200
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
 <191d66ef-7d36-41e0-b29f-1ddd47812b75@oss.qualcomm.com>
 <9a999b51-8131-4032-82c3-72d7eccbd222@oss.qualcomm.com>
 <25812e14-d691-4e15-8fd9-82cacc203eee@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <25812e14-d691-4e15-8fd9-82cacc203eee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hZk7qJp8i6HUrWKoSmNRKSsDhCu6FAja
X-Proofpoint-ORIG-GUID: hZk7qJp8i6HUrWKoSmNRKSsDhCu6FAja
X-Authority-Analysis: v=2.4 cv=e602j6p/ c=1 sm=1 tr=0 ts=6a20263d cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=aBIYUfOEhgoR9egqXYNcqA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=Zrx8uGjwauVpT-NhnRYA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyNSBTYWx0ZWRfX0DHkU2julMm/
 kBgYcCGe9GGl5sCo2eT2uoOGeGWubPY4e7nor6FsjYYKhbhsiLFhDpDOZrEKhoEHoQxaTkgMxLG
 RPvWILPyLwvWylLqZnBeYH5jl72hjf+/ofUdjtOcfCxtiq5Tvg9XpI5z8UMsw3kuR8G0UeiDPxW
 QDYBcRqYsikfonPtkEv4GezUw/MPAN+zgmT8yArOgl8cZQmLuiRrphymye1IJ/s3vISIv9iGz6z
 wfotER18Lctr/X0A+1yc5d7mFTGGeBAUWydPCQOu8e2onbmucMLWN2SyBQKYNEko2awQNK/ZGrG
 WYy1FLaLFPW8sUInkh0yei2Ax64xLqTaGXmieFOArNpGAv+Ja80DCL+FJWpi/Fr2zlxpN9cDwj4
 hHCnkNkmBtYij7TisXBlwizFBVpOw9ppEtJbksYrMpUgBfqbKAAz87ZT1NNcwRE2E6E0Smo7+RE
 rcYtC83LZhF3RI70VPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030125
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



On 27-May-26 22:07, Akhil P Oommen wrote:
> On 5/22/2026 3:11 PM, Konrad Dybcio wrote:
>> On 5/22/26 11:39 AM, Konrad Dybcio wrote:
>>> On 5/20/26 9:38 PM, Akhil P Oommen wrote:
>>>> On 5/17/2026 11:54 PM, Dmitry Baryshkov wrote:
>>>>> On Sat, May 16, 2026 at 03:52:08AM +0530, Akhil P Oommen wrote:
>>>>>> On 5/15/2026 10:38 AM, Alexander Koskovich wrote:
>>>>>>> Adreno 810 is present in the Milos SoC and is the first GPU to be released in
>>>>>>> the A8x family.
>>>>>>>
>>>>>>> This series is marked as RFC because it depends on a few other in review
>>>>>>> series, GPU GX GDSC handling [1], QFPROM efuse for Milos [2], and devicetree
>>>>>>> support for Glymur [3] (for a8xx RSCC offset fix and X2-185 bindings change).
>>>>>>>
>>>>>>> Also depends on the GXCLKCTL block for Milos [4], but this is no longer in
>>>>>>> review and has been applied.
>>>>>>>
>>>>>>> [1]: https://lore.kernel.org/linux-arm-msm/20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com
>>>>>>> [2]: https://lore.kernel.org/linux-arm-msm/20260331-milos-qfprom-v1-0-36017cc642db@pm.me
>>>>>>> [3]: https://lore.kernel.org/linux-arm-msm/20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com
>>>>>>> [4]: https://lore.kernel.org/linux-arm-msm/20260417-milos-gxclkctl-v3-0-08f5988c43a2@fairphone.com
>>>>>>>
>>>>>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>>>>>
>>>>>> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>>
>>>>>> For the rest of the patches that doesn't have my R-b tag in this series.
>>>>>
>>>>> Unfortunately patchwork doesn't capture tags from the responses to the
>>>>> cover letter. I'd kindly ask to spam the list with individual r-b's.
>>>>>
>>>>>
>>>>
>>>> There will be another rev to remove the RFC tag which will hopefully
>>>> have my R-b tag. ;)
>>>
>>> Do we have a resolution on whether the proposed fuse values
>>> are OK for this platform?
>>
>> Ref:
>>
>> https://lore.kernel.org/all/oka0Q911ixJLZzAbfWBx54dOmxbQAre36QqHUX4iDZoH3TE5jD-IqTAHspti6B8kfpLQ-OTnuWjFdXtsqJM-CUC8G9R3x_9vFI--LnpppiA=@pm.me/
>>
>> Konrad
> 
> Yeah. this looks fine to me.

Nice, thanks!

Seems like Rob pulled in the series - thank you Alexander
for your contribution!

Konrad
