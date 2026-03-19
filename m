Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AF41075290
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FAE10E891;
	Thu, 19 Mar 2026 10:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fEBErR4l";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PQtoYnOG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BFF10E948
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:04:48 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J73wLr1027092
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5GTauEHSGm4i3XT68NJbUfwxUwP+W5UkvCHabhr2+BI=; b=fEBErR4lthQNn4v9
 ZMxOQYhiV43EvXAT0j2MkfztgGZbH9A7ZALIhLAL0AFDs45FTMf05lrcsZQyG73t
 mP66d3btFxNNWre9lLNg1MWi5jSBddRRCj0KOABxhkoPs5ml3as6Yg4dNK7TX1zj
 +J+FTrj8kBN4uifBhZckyP+hw0K6g08JabNJ/tmsnfpcolL3RfEU4NEaUAcv45/o
 K1ReXowqAqcEjTeKUUjJ2Ny/G0Ff4lKdqkmriTXBW+hWS4dAFIck0JZjKNePBOnw
 T6RPYTjHG75k8O0QiJBhhKDt5qMwj/H2t7z7Ta7eGANE9VJRbcXljUP9wlfBeDPg
 zDrKOw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0032jug1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:04:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b2955cc1eso3656301cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773914687; x=1774519487;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5GTauEHSGm4i3XT68NJbUfwxUwP+W5UkvCHabhr2+BI=;
 b=PQtoYnOG8s/Hli9D+mVgOwNt039J6d9Zit84Ji1RaNLJXqyERZICMIR98voEATvL2u
 Ec3cQm06GWrbqIGjhVN+wZ3LpbwcN374CPIADWgnoeyIwUb/J5VBdLAQqwALjXJ4NB4y
 K99uDuWqr8my4aCq02MVLrsopvsMBs0/LzRNkkIDuomZ0loPM1AusjS0Ngz8KEFZsQw4
 hle7SM/VPzrBPdF7L/AMD9fDcSDtM9kfLThGTenTEVpQ/NzYI8NR2/3O8TNOo8TmYOt1
 jwKPns86iAaSSFo7sLCxR1kCGi1G/OxFqN2tOUuiRIcJ2oN0Ld6LOof5cTL8VYUZVKwL
 OuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773914687; x=1774519487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5GTauEHSGm4i3XT68NJbUfwxUwP+W5UkvCHabhr2+BI=;
 b=nC2YGyv8lPQiCw9KCDWtfXmAaxgYi3Jv/ihLfff3gi/ezatyQDM1ORhfDGnk2MoQry
 DyN2Ms4RMSnHsGu/GZHmrwwc46bV9rPrQNp9LETJN65Oq3cYpa8ZONHiDxOHScGYZbWT
 HknZplI+iG/0WV60EpfUwQRw8oLb68bWQcOaX2Vv9fd0NuCUISlIvrEh5NLd6PCi5Ou2
 uWMQshCXvsqJcbQIVWtVqDZTaePe+8iMXAAHWF7mEgnIoqjioatTO1OJZ4fKqE/ULs3j
 2HS+BN1BJGIinFBh+vWOt+D5vN/nvXlCKoWXLZX2DfuMC7kyrSud48XErMsuaLgySqLe
 hn3Q==
X-Gm-Message-State: AOJu0YzM7OMaXB7UNZyP0UYI5z6xNwkX1UBJHljKljXIw9OtFuhPb+Jd
 /zrVjYixjbF7rb5ha9Y93a2MpziPeYSkDcpq4O228zMhOfKINNAr5Gx13ZqKgTqTtOUOjgoWjFx
 5WBzZHtOZozNbF7rsxuvHJNXNGM7HQxy1cv+exC0ERvbrcTWFGIV2lL5kfHSH8UghzP8OFvo=
X-Gm-Gg: ATEYQzwFWSYPfE7QyyB4VaBI36Zj4u8zx/zJCD7HoAPslgjzTuBEGm2SgAelIxsl4KW
 XsnRdp2NozaKbNs56MDo3uKUeeLwlolB/pQ5We4sJY56bg9GwMuLRph+GhqQzxLMySC8bRMaySw
 6GujAWxAtkO9qJySs78Of1a+UKR32rZkBe3AlP+eYwl3ASRLTpfmM+M3Mdgfv0cCANnJfTa43O8
 SdjfAt/2ECB3HY0LsKRQbZJSRYFh/h86GfSEY4YvMLnZz5VzXL0kqEgGMCsvH469PpzOBiKC4FF
 Jr4menrIaiT84lpOWe6meEa7r60BEj7+r8zoT+r0udY+1y8ryX9th96Mc9z9yJLy5I79d1sYgW4
 j4pHUPLFv02K6n4fMSOQiYqzxMCICoK0XsZZOlkVvcnjOdvkxK2hnqU9d4wsqvqk27RGdbrCMsg
 Eim7A=
X-Received: by 2002:ac8:59c1:0:b0:509:38b0:c44b with SMTP id
 d75a77b69052e-50b14866da5mr64922031cf.5.1773914686633; 
 Thu, 19 Mar 2026 03:04:46 -0700 (PDT)
X-Received: by 2002:ac8:59c1:0:b0:509:38b0:c44b with SMTP id
 d75a77b69052e-50b14866da5mr64921631cf.5.1773914686102; 
 Thu, 19 Mar 2026 03:04:46 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f142a785sm426601566b.14.2026.03.19.03.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 03:04:45 -0700 (PDT)
Message-ID: <f0edd84c-bc83-479f-8168-1bcdddd8fa94@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 11:04:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/msm/dpu: fix video mode DSC INTF timing width
 for non 8 bit panels
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
 <20260318-dsi-rgb101010-support-v2-3-698b7612eaeb@pm.me>
 <c9d14a74-8e59-43bb-827b-577c8f675c8f@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c9d14a74-8e59-43bb-827b-577c8f675c8f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: G6X2admHlQc3kIoW05TZpGIiY5NJqmMB
X-Proofpoint-GUID: G6X2admHlQc3kIoW05TZpGIiY5NJqmMB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3OSBTYWx0ZWRfX9nlNiPumE88z
 +e1WlRvbwJUh2CaOxqzs3LM/hUC3V0jJu/qgaIulyG/qwzNMyRrAGaAVAXDadzknCqsTDu5Y99t
 2KPu8XfmSRHHpV8dr6Wj1sP4oYnPwDOuVrAx5kJMmPmgBCfYkyjIHlIIv9PzO8QzDP116qg1SDF
 LKwzDBXrir0/cZhkZJRP6NUN+N4/2Was7KPI8dbuPCm5M321vPgiaLpicdEggeCj3S1Ypl629Ua
 gV+4dhFN549XRIDWOp8O8/BPErvlw5C/2tg2diwGQIdfVUa9WXpOmASV23MkYNNePytHehbcI2H
 zXjyUYfqUDzvZnaj5IJuxh/1jG7hSGAlb2BM41CEx+y5gYF5PdOJmhV4O7JmVGM0wSY4QnrXTfq
 soIhGGewzI3hd2056dw5735vf2y0Rt0/5HNLS2/HKmDAdzsbNRUO5FDW9iW+GlnNouVuorbxFqg
 BqiwGPeYeEWnYVRSaRA==
X-Authority-Analysis: v=2.4 cv=WO9yn3sR c=1 sm=1 tr=0 ts=69bbca3f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=FH03U6bJQyAcg50I1OgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190079
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

On 3/19/26 9:34 AM, Neil Armstrong wrote:
> On 3/19/26 05:00, Alexander Koskovich wrote:
>> Using bits_per_component * 3 as the divisor for the compressed INTF
>> timing width produces constant FIFO errors for panels such as the BOE
>> BF068MWM-TD0 which is a 10 bit panel.
>>
>> The downstream driver calculates the compressed timing width by
>> dividing the total compressed bytes per line by 3 which does not depend
>> on bits_per_component. Switch the divisor to 24 to match downstream.
>>
>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>> index 0ba777bda253..9b046a0e77aa 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>> @@ -122,19 +122,21 @@ static void drm_mode_to_intf_timing_params(
>>       }
>>         /*
>> -     * for DSI, if compression is enabled, then divide the horizonal active
>> -     * timing parameters by compression ratio. bits of 3 components(R/G/B)
>> -     * is compressed into bits of 1 pixel.
>> +     * For DSI, if DSC is enabled, use a fixed divisor of 24 rather than
>> +     * bits_per_component * 3 when calculating the compressed timing width.
>> +     *
>> +     * This matches the downstream driver and is required for panels with
>> +     * bits_per_component != 8.
>>        */
>>       if (phys_enc->hw_intf->cap->type != INTF_DP && timing->compression_en) {
>>           struct drm_dsc_config *dsc =
>>                  dpu_encoder_get_dsc_config(phys_enc->parent);
>> +
>>           /*
>>            * TODO: replace drm_dsc_get_bpp_int with logic to handle
>>            * fractional part if there is fraction
>>            */
>> -        timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
>> -                (dsc->bits_per_component * 3);
>> +        timing->width = timing->width * drm_dsc_get_bpp_int(dsc) / 24;
> 
> 
> 
> @bits_per_component: Bits per component to code (8/10/12) <= how the DSC pixels are encoded in the stream
> @bits_per_pixel: Target bits per pixel with 4 fractional bits, bits_per_pixel << 4 <= the target display pixels
> 
> - bits_per_component is the transport width
> - bits_per_pixel is the display width
> - 3 is the DSC compression ratio
> 
> So for a RGB101010 DSC display bits_per_pixel should be 10 << 4
> 
> But here you say bits_per_component should be 8 ? can you share the downstream config of your panel ?
> 
> Are you sure about the bits_per_component & bits_per_pixel values you set in the dsc parameters ?

The computer tells me that if widebus=off, regardless of the compression
ratio and pixel depth before compression, 24 bits of compressed data are
transferred per pclk, and then you can transfer 1/2/4 slices per xfer

(As a note, the DSC compression ratio isn't fixed)

This also impacts the byte/pixel clock calculations (but dsi_host.c seems
to have taken care of that)

Maybe Dmitry knows something more..

Konrad
