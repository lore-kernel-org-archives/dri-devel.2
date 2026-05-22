Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D450ACD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3956910E1B3;
	Fri, 22 May 2026 11:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMOqR9z+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SDqriXpV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D1F10E1E6
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:28:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MB7mO3776868
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xnhOOcTcjq/QyrWBsiSMk8cqc2b43JhyotHaDX3ndwQ=; b=TMOqR9z+ARc4Ae56
 xEn7nmwPJVlu84c/WAL55uvLoaQ9H1QgojrjzVF/OaiEgPW3TYHkRXEFsUA7sS6s
 gzmfgjY4SABCJqD7w1RTmuLESjVzUnR4EI5ddSp/fUjDwCe5bI3PhMHXCBcFB5t4
 JBRg5cuYH1vec+Ls+pX06rxxfamlR8CkQAGQTYJzPfDaygrWcG32q6CsxGnFJNKb
 KhVUOWJuPl6ImAPEinRnZkcrUYGnR0K/E0Hd1m/ILcAl0V+6a6/D55sFghwewR3w
 0fg9bnJ31ZSa8crKsePVvPumXhdvFmzF1tpsgHqAUimBhoNw9BwW24fBiIPx8HOp
 MrHNLQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea94h38hx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:28:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-910a755d717so104936185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779449326; x=1780054126;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xnhOOcTcjq/QyrWBsiSMk8cqc2b43JhyotHaDX3ndwQ=;
 b=SDqriXpVx3k6uIiCmwSLkeJkgZNBXfzZxZ/EonJdt3XBNzHhhO3CpxJ3B3mu8Bbpm7
 uearen97Re/x13gWjAGMx+wtFblNWfxR5Fl/pHXgxMmtnZYv/Rr/aW0J6TVUE3HBND4R
 J/9mevjR+i5OwifQMJ3Skzu9EFOU68ftdmTifPeZQVWgb23hVikUqQ1PKjvNm6zvHsh4
 lOqpYX+QhQPqEObGMx+SqTmUy9fNRksgcU7Nx5obp5Z7YpwyIXFu4d+y0nyjc2X0zkpZ
 61KCNiu3zN0nuBj6Eg99fa7sVfsej6qC7TRUDRgdh4aQSEeuS9kRRSSS8ChVI9+bZFav
 eTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779449326; x=1780054126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xnhOOcTcjq/QyrWBsiSMk8cqc2b43JhyotHaDX3ndwQ=;
 b=HtqE1srmMqLqK1i4R90vBnqFs8F/qMP8FK/6l8LlByr5p3iW4DGLZWomb3ItAXk2NX
 ZoxFzkCExIKKtoL82HkAv2bdnZN8xb1znHWbF03+3F9h9bg3UgFgrJ4mRoxa+YB8V9Oy
 TO7uhEIpduRGiHaTCiiA0Tz3TMwFipfbnAvKUGZKgC3zEWXY69vcg5GcECDXHc1EiXwc
 laqErR1hSfdtKMuneH2KFmEqRYT2KGtQRWrs+Xb05pxBnaeV5Kxpzcw3Dx4SH37j0QLt
 RC4zeEHP5v5CTEwhNVyzoUWxvR17pMwhZ0FOnAlTnjsv0iiUQDMJ4Mwnl1DfY+NKaUCn
 SDZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uAd0skDrVR0uJtDyNjklsfPMBz5cz0cLsJOWDZVSQlvMoVx/ZaE4VWQOytfp5twNFVq5/hsh7ecM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/Xa41HmYwbSKHx+ILnndLd4+tlTAtkoNljmimqrEhVFkI1Jge
 hXYK/ToYBgN/ACvWjW4QdyeEvB3ToK1KnwUZ8eAuMuPCNbBdIVNbn+CMpwBfJ+1RRjvYqZu0XdM
 QZiluk/8VjN0btdGE56ITRHVV7hXDlxRv6tJPsE72xXcNlYwnwVO6FNiBXSeT5TVVPo5IrRY=
X-Gm-Gg: Acq92OFcYlQreqHGUKtKRsAQrjs/Aqlw/DKSF8l4mLrY75B42suBU/lusBEKKYE2hZg
 UvG8NNCYDHiTWd0OzCUAw8541weCu5d2pVJqRjoRWfWAu+69v6c1wFObW3gVenR/Mgt646NkTEH
 vokFfozo/8E/2ek7ryb+khgkSYITZe9vFPSKJhpe6UvFnd9mikwljec8q7boWzi12nWlHA2otPl
 /kyGtCTr4T0lzSVAn2C6+93bZnmVjtysMgqUzX9/o6J+xbaoiIUptAqBRMeNMWI0slqAFHvnnAW
 q/f5srrpyz4La1g9De0TedeaCVThWpKHBA3AtTeAr4x8x7td37zGBasdxKVhOgAaEEHrDPqJlw1
 oOugTCktH4ZvTFf5wUvqETtS4FiwmIgLFdHcjO/3of7Z+Ow==
X-Received: by 2002:a05:620a:2682:b0:913:b4b9:5ec8 with SMTP id
 af79cd13be357-914b49a070dmr333131985a.6.1779449325912; 
 Fri, 22 May 2026 04:28:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:913:b4b9:5ec8 with SMTP id
 af79cd13be357-914b49a070dmr333130085a.6.1779449325479; 
 Fri, 22 May 2026 04:28:45 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc62d70a5sm45211066b.48.2026.05.22.04.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:28:44 -0700 (PDT)
Message-ID: <86b69fee-b588-45f0-b682-744b9959e86e@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] drm/msm/dp: Fix the ISR_* enum values
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-2-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-2-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TvEdNYuyabIbd5_W7gLbTp5K6K0rUidM
X-Authority-Analysis: v=2.4 cv=QblWeMbv c=1 sm=1 tr=0 ts=6a103dee cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hxhQaWjiUK3sto3hAJ4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: TvEdNYuyabIbd5_W7gLbTp5K6K0rUidM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNCBTYWx0ZWRfX/fWBb0bURWHq
 lkAOlZ4x7JRoc5MeF3uqvfPjBkTI2wKtkLMR1r5Ju7R5+3C5yemDnRaOjmBLReLo84aEfwadxfR
 +/8IgWqwhb3WXLnyvAHMza3IBmM1fxkuEEDPXfsmK1mUY0ZCkx9FRLdHGtltWacehWvrs8Eer+n
 mTodx8yOl1XnDmXtPyldnIu++HKgUnp8ynTwWgIbPKfpIlItxbKaGqmXZoFr0BdpXYQRvhkKbtc
 L7N0VHCRN1NsCuxcI5mN0R82phdUfiFhKcB5xrVVu4AsojLwcrAlEQF71jKJeEs2iQj6uDAna6G
 SP2qYFC+WQUYlQNlaU367/g0wGz+1xpmMjJ+mQMBbeClBdTaN/rUzwkNBdUlAzKnZC/vRj+W0vc
 Y+/Yi6tjoU7+UDboDvCztTrZvSqD9U5RZFIBbg8aC45xBS382F6Mcnv+GyNQRP1QSMH5S778UVu
 CY23AuAFb3IzsXR7Lkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220114
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

On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jesszhan0024@gmail.com>
> 
> The ISR_HPD_* enum should represent values that can be read from the
> REG_DP_DP_HPD_INT_STATUS register. Swap ISR_HPD_IO_GLITCH_COUNT and
> ISR_HPD_REPLUG_COUNT to map them correctly to register values.
> 
> While we are at it, correct the spelling for ISR_HPD_REPLUG_COUNT.
> 
> Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
