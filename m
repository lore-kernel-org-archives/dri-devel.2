Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC10FA1FD6
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB6F10EA84;
	Wed, 22 Apr 2026 16:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vbi3je/l";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qp73nyyg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99AE410EA84
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:40:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MG4kv61587773
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BocpQQQnoL1JLtuDV8x1jEBZoyxugL2chYUL6mfG0KE=; b=Vbi3je/lMJ+yD720
 YHy4+8hsMyaaHbR3DEC3rhpVYuW4l57SI0Sj1d2xOi6peH6WnVjBVjOaIq7nXW0K
 YEAjEOSozg5TvG1i0SvnjrhZtlKHvR0SiU71MNeEEp5Gcw9HbUkhARV4v0abUxMn
 w0KXXGq1x6bWVwMktLRbhccOh1DamTnsx9upAuqHPi+yTnlro2OghSLhywaJrIZC
 G9tALMguuBNQbXBi4JzpYHWPdIOH18PLhvFUDhv6/mWy5QFeDMdjSL4ZC0moQi3e
 5KDqrsJQBJK8L/JKtxko+jruhr3yLSkF8XC49ITcXAZXirItRZQ/eOiqb61OPY0N
 lAhSzw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hq044v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:40:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8eb6880430dso102692085a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776876010; x=1777480810;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BocpQQQnoL1JLtuDV8x1jEBZoyxugL2chYUL6mfG0KE=;
 b=Qp73nyygVgsbIkalTPL9/nqKrWETMj1NRESaqR1aid0QDLYSQ/hPdz/S6ySK+pR4ck
 uICmrF5S1wuTFwxJiTMB4Hd6T5ZTVNjPHVcsTMkym1d2AxM5MhRkfTOTmtly4PTn2f0h
 Y0l/UEvFCBz75RsNd+U2A7ATgJj+gnFYfThdgYlrvxzTu2PcleJ4lDlp0HGHFcJh4s5T
 KGkoilorF5upjU0obTlgKPe2Ro/k9AHLDz3vdgJOUcPpbsBNZ92bT0rqTOt9E5lTKsMO
 flQ8WWquqX6jnucWixyNS+kVU2FhpqrJWdrPoBFQMqlLtn/255LA3v3BHajnywCz7jZ9
 g/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776876010; x=1777480810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BocpQQQnoL1JLtuDV8x1jEBZoyxugL2chYUL6mfG0KE=;
 b=YPEFiWtCaKXzREK+NL+l1JLQbR6owKVUKi0FuSVFGC1+B9Mo1NBx+OIFaivYErXsla
 jH5HfStTuXawOihRIBPmXXVfp84hlrw71ohu7Zh+xoWaK/WCozNS2ssXAGjMokpUx5lH
 xJ/begml8H7RkX+R84U03ANn8OLhicHV36RtaPo9S41/3HJOKUUh88RRpi9WoRvtLm3M
 wmq0gIwc6X+zb2WfcgmRydJ3RocV74Vg6rrbqSJ3XUt+I7RcrsirQacsnieQ3iSCAJ2d
 Bt+3Zz0U3Xsxz7iZxEs5zxawgOJHv0YHHoXiiDSq//VkXlSVaQfo+u3HF/k02yCpTM2s
 WOfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e73F/p0fhff0w7jHw3AlguIF4tc8rr6KU7ei+xgViCS/lGwnGYLqttt2eS3qh1fj040b7SukOsck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywp73DnppLYUDBMioS9ZG6YIz0Mo51Y+89cN8gWbYbbzijEuayn
 qxwGw1jmEaF4VaYfrVqxuWFebKnn96/iT3s5lgDQMcUKor0qCMMR/fzkfTsqrZjLb+PseVGf5t7
 76ZEbPtnX4cRg6IVFcwBovhtEXxkfLPUG5rm496IUQQa6V+GfHS9EUu4hJ0r5uKINpx0P2ss=
X-Gm-Gg: AeBDietNcJd9OtrpGS38PPwQRfgvk1KDQewYzssp4CDD2doqwz3VfRT+69xZerhn/HT
 RzXV4A/NbWGVTc/8i4kpmDED66mZwJMlaJVNmuyXW/zUqdVB8W2XyAV3ZiD+oQmxqmiHQ3dedM4
 dvpdrJJI1tC+AqFuvjVNc6eaZF+n5h6Uvfgo71GFeDZd77TMd8JfrhypbioWm2FW3CekUUnSCWD
 wXSD+xPGlEF10ho2Fpo1YqXQLp/p7udC0p2q6VPUJT/KeR1HmKT3RoUl29/leCz9eiSuxlxJJ45
 m4MTJRx6NHJjdxgRZQe1dtYxVIIZTu64iOkhCjgEyMBvbdKjPoZUb7JJ8UaBqcKLFxBFWgJy1Ey
 tQU9GcRozEXpF2OUAa432/RGePJR0CPpZAIU62Bex/HUf6ESMmUVVo2hlGPljVFvg7romUOGDGQ
 zx9ll6sUwpLnQoBA==
X-Received: by 2002:a05:622a:38e:b0:50d:714d:e966 with SMTP id
 d75a77b69052e-50e3669e233mr234484141cf.0.1776876009793; 
 Wed, 22 Apr 2026 09:40:09 -0700 (PDT)
X-Received: by 2002:a05:622a:38e:b0:50d:714d:e966 with SMTP id
 d75a77b69052e-50e3669e233mr234483721cf.0.1776876009338; 
 Wed, 22 Apr 2026 09:40:09 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba454d1bd19sm557433666b.37.2026.04.22.09.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 09:40:08 -0700 (PDT)
Message-ID: <d31f9669-c2b8-4943-ba5a-d38b5230da8d@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 18:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: add flag for sending all DSC slices
 in one packet
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v2-1-0a1b316f8250@pm.me>
 <9vOWCBGQu4kqkzUaF1cAimiRnCHzd7NAjB98ZcmVygN9kNr7G2H-UzhkQfyiDlaj7G6wxWqKlGvAprsMtVE-P2erdkutRN7LuO1GQBOSzH8=@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9vOWCBGQu4kqkzUaF1cAimiRnCHzd7NAjB98ZcmVygN9kNr7G2H-UzhkQfyiDlaj7G6wxWqKlGvAprsMtVE-P2erdkutRN7LuO1GQBOSzH8=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE2MSBTYWx0ZWRfX7DGGGgx6KfoI
 hWsBvVkoGB7mpI5tvyKcJXDIS3SWSbmblq/QaP9TTffDi/PiBz2B9bTSahIlYTesFPmw7SIt3hT
 /V6dbHd2HSNzqGGIrfTY5Ut0LaMzeYyM4T/+EYHWrSZALIAoR0qGCEb8NOQPul/0Roa/z9TuTZo
 vZyuwmSvT0C5G2+j1LUOO4CeThLqKo1v8M5LeynNoGhh485eJgRgPHxSPi6m2TcaclAKdwYp4PH
 9qJWS3PABdHCBR5JKRe2iqwNOMPvakJBEGmW8hapG+amWvKxHXhkO74JBDKTguwQyHOwEIHv6I6
 VZcMjlx/yMHjhIQNHww605yUHSUXKZlt6503jX4ye0DA4CQhWALOv3oj5xnCk7V3099fSHoMMNM
 JJ/TJ+sX39Uj+w07w2hVlbKgZs3+1xPO95fLEcWQsmIeXEzg5pLiiC5HSWoSN4BYWYsiBPn4fhe
 9rAglaQnevn/dSPpUHg==
X-Proofpoint-ORIG-GUID: 4skJndaiGzxa_Fk6x-Seru70DxZhPiEd
X-Proofpoint-GUID: 4skJndaiGzxa_Fk6x-Seru70DxZhPiEd
X-Authority-Analysis: v=2.4 cv=TJt1jVla c=1 sm=1 tr=0 ts=69e8f9ea cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=nFR1E6h3X-GUGZrjxzwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220161
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

On 4/22/26 5:15 PM, Alexander Koskovich wrote:
> On Wednesday, March 18th, 2026 at 5:58 AM, Alexander Koskovich <akoskovich@pm.me> wrote:
> 
>> The MIPI DSI v1.3 spec defines two modes for transporting compressed
>> pixel data: one slice per packet or multiple slice widths in a single
>> packet (Section 8.8.24 Figure 40).
>>
>> Add a MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag that panel drivers can
>> set to indicate that all DSC slices for a line should be packed into a
>> single packet. When unset should default to 1 slice per packet.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>> ---
>>  include/drm/drm_mipi_dsi.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
>> index 3aba7b380c8d..d3ad8c5d3ebe 100644
>> --- a/include/drm/drm_mipi_dsi.h
>> +++ b/include/drm/drm_mipi_dsi.h
>> @@ -138,6 +138,8 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node);
>>  #define MIPI_DSI_MODE_LPM		BIT(11)
>>  /* transmit data ending at the same time for all lanes within one hsync */
>>  #define MIPI_DSI_HS_PKT_END_ALIGNED	BIT(12)
>> +/* pack all DSC slices for a line into a single packet */
>> +#define MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT	BIT(13)
>>
>>  enum mipi_dsi_pixel_format {
>>  	MIPI_DSI_FMT_RGB888,
>>
>> --
>> 2.53.0
>>
> 
> If there are no objections, could this be merged?

Certainly not in the merge window - patches will usually be picked up after
-rc1 drops.

Konrad
