Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB5CC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8CC10E81B;
	Mon, 28 Sep 2026 08:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jBuhpJQu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Geecc+Hd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 985C810E805
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:29:13 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S7xjtK1871698
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6xndBd5gqizhYMvRqH0U4waQTYqgueSPfdyK8EMU99k=; b=jBuhpJQuH44rdrAq
 wvTI1RPbP/mnbkm35Ej7ZxBm6iMOc6gwmtEOdX9PWzdc3/Z/8R8LnQRfUSBiRO/p
 BPLmwXqNFqyRDlPG4+bQQJkPY0asEWsZ/Q/PZGIEEovI3Y4XpRCz0Yy3K+ldCrsh
 L++SiejYXDtKXYZNUAjNCBB4Q6iUoNfSzqOokC8WRub7Kk65U3Q00P+2TKEkp+GM
 37z1nGO3wBFt5Cvlm2fO2eaA4UpIIr+xBrOWIPpiRl5WX10fGenUrSreobh1/vL0
 NSLHkH6dO9mUdHFB7l0u1GvDyysJp8ibSJSzokOczQurYyUmwixaqoN1eAb0AdOf
 WXTSSA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubgmun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:29:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c6049cd16so7710585a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790584152; x=1791188952;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6xndBd5gqizhYMvRqH0U4waQTYqgueSPfdyK8EMU99k=;
 b=Geecc+HdQh+TCRgpUC9zCuniiND0/JqrEPCmAhUXXYoV6leHfVtxK/p1Vj35YV76n0
 1kVJh/iAAsW9+4pK8qhJPsIQ6ehZjmV9NfRJd+qdGLVp0urYeLaXLEZWM3GMr8QlIj++
 VKtJuYCbfb+o/5Uz47MjobDC/Ts9lrio14G9BmUl6DyNdG6EB4u0TxZrpe7NLgd1fRKF
 jk6HGG5BRuEdZE+FVLDG9pXILMc+1F2YpXsggGlRO3hClqqeNAGrGBKMV70EmSEsZ/vy
 Ol+LJpckeE9Ur+tpSarJkS6ffys4+JQVyCXHuVyU6oBsjKi6hLSGD1vvrQfb81NJtjot
 g5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790584152; x=1791188952;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xndBd5gqizhYMvRqH0U4waQTYqgueSPfdyK8EMU99k=;
 b=D87wMZgTLFflLNAdMjlix5+Y37Y5EiOHgQ7AJlBiLeEPBG37tc4+VfDEjrATIyTejP
 2AmQlfrSBY57SBDB6T7vqk0NmZMc/pgXFhMBi+SjmsXro5U21CK27ltIxlIGTSfLUINU
 mdVWv3xDNuaxfgntgt0IipxL7mKF6yvZSi5NUfGrVETZlgVR4jsci0o56tdsOs0nxvGK
 iEsQOEXOknUjhCdDvU11PJ3JTLBKAOdZdFhp50pLUJkd4R7ZGLRLj9y2ar514gq/zUQw
 stfOUZOv4b79C5ItEhaI/qd6k2+Ewm5EfF0RPodyO50bl7ppSv4bic/+l9dlQhr1B+Gl
 EeMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4Ti0wYkdIpnYgvFOwDC9m730n2rm3gJjp5HG+qsnAxMOVJA6T9y93VAupOcgDegWp8Jihb86fgd0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mXrbKp6+tD6D3CkyBDVLw6hhrhsKoO0M3CF5fOSjUHgDjF4Qxs
 TfEvqFAgmZETR+lnrdObKIugXVplYn1B+V9sytx8to6g6RCoTHcbtAHvLwSKiAKw5dP1SFewAMV
 swkzH8miOTMMlXZtJacJbZSDF1k2yUbXm5nEjFjtdJKcMYXPakDT3rKUsTVSXFtc4/9UyQcw=
X-Gm-Gg: AYBFou1McP0HLEppof5AMqbXkmznhrAm0NLnZ5uURAWbg8sCielzTMLm0PtIm3idyFI
 EDXDHdKhb2qbe1bYu+gInr2TmwBUQfBv9M26JtXA71zJES4kavkf1lT9igzclKFJks+z0tos1E8
 eRWX8Lx/LN/Lw/mWcS/lQV64SeV9DcQ6O6EaZNXu97ol22WR4+nbF7uztDI2wIDbaap2f6eVuMK
 9cyEmws56r/GbDkLLSYEjvJKMQZG92hit9QbALk+77YnUko5XYcM4aUmsI78sv6olz6uWizWK6j
 xO2ogvjKqlyB93O0vPxdO8oGV1832jZj1eV4FsAjBugoAhAivH2YRg3XRuJZuZp9pYvF9ie0liG
 gXWMJ38oV1I/BTH8VDXqOSw==
X-Received: by 2002:a05:620a:404c:b0:93b:ee2a:b67c with SMTP id
 af79cd13be357-93c43d78ef4mr1813619885a.4.1790584152219; 
 Mon, 28 Sep 2026 01:29:12 -0700 (PDT)
X-Received: by 2002:a05:620a:404c:b0:93b:ee2a:b67c with SMTP id
 af79cd13be357-93c43d78ef4mr1813617885a.4.1790584151740; 
 Mon, 28 Sep 2026 01:29:11 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dd69d4f65sm128311666b.22.2026.09.28.01.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 01:29:10 -0700 (PDT)
Message-ID: <89c68705-bac5-40d2-b53b-bfc818900487@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 10:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a3xx: fix VBIF halt mask for A306/A306A
To: me@samcday.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexandre MINETTE <contact@alex-min.fr>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260926-a306-vbif-mask-v1-1-2bae5e81c05a@samcday.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-a306-vbif-mask-v1-1-2bae5e81c05a@samcday.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iC4kOLuHTsQIHzA62MblEf2Tqi5ciAIR
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba2559 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Oh2cFVv5AAAA:8 a=lKQ-AihTAAAA:8 a=EUspDBNiAAAA:8 a=ZpghvvjZZmtfGsAZhOkA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=7KeoIwV6GZqOttXkcoxL:22
 a=K6G5NyU7usMl-irPePdK:22
X-Proofpoint-ORIG-GUID: iC4kOLuHTsQIHzA62MblEf2Tqi5ciAIR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzMyBTYWx0ZWRfX4XrWKUIoOlMo
 f1g14fRrO3C64nJN3RvG4B0AhG/yxb9DOKlmcpjr4C3LXrMd9/kLtTmMbiIsRvPbq4cTgDO9Iom
 n3B+FpiAYQ+d3wsuVdv3pPLj9zPQckk844Jkqfi3iHDGren6QmXVOu+FY8Gse5jLUqnXegTg7FJ
 In3gnQZDBuyHAm0Tp9hv3fTVHASR5npQL1tjnE4de6IjTDUrvwWDOH+teI3DAMC/AfrpahalN3x
 E+s9G54FxMt6KXjTWhh7P0z+4TKFWF6rbdSqd8Av2irlm+T9FoitmF7hEDUpSrn+BiVzNoO5Ak7
 mzmOAjyk2/0warcDkZlq1bBCZP6xkp5MzlDDuiDpAqo/HoBOiUDI0aR/AU0oyn/xLzPKppdS/0g
 7mgqXwoH8qYn2eW2wvw7hhfsR8axpl9En09R4Zr/of7Y/r1+skKrpkBmQRACc5Vt/p4h9+5/KWh
 ajstsHr0nbrXgouKjJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzMyBTYWx0ZWRfX7UdTLCr2PisX
 ldaLw85cscdALo1IB6n+uw8BykJDgE4LNfHKt86HYxM69gmAATNnBF1JXz8lV2UQMxUBfWZZy83
 zFjnnRGbMcZIwVYLT3IVX1RlpvJ1zR4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280033
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

On 9/26/26 8:17 AM, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> A306 and A306A implement only three VBIF XIN halt request bits.
> Consequently, waiting for the full 6-bit A3xx mask times out and
> prevents runtime suspend.
> 
> This issue was reproduced on a DragonBoard 410c: the request reads back
> as 0x7 and the acknowledgment as 0x00070007 - the poll eventually
> returns -ETIMEDOUT, and a3xx_pm_suspend fails with -EBUSY.
> 
> The downstream kgsl driver corroborates this (see link). Since the
> single-character difference between A3XX_VBIF_XIN_HALT_CTRL0_MASK and
> A30X_VBIF_XIN_HALT_CTRL0_MASK could be confusing to read, the narrowed
> GENMASK is instead defined inline in a3xx_vbif_halt().
> 
> Fixes: be0e82b8e0c9 ("drm/msm/a3xx: Drain VBIF before GPU suspend")
> Link: https://android.googlesource.com/kernel/msm/+/c90c7feeca2f5839ad6824f816c0bd207602a2f4/drivers/gpu/msm/adreno_a3xx.c#637
> Assisted-by: LLM
> Signed-off-by: Sam Day <me@samcday.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
