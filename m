Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D56C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A9310E19C;
	Mon, 14 Sep 2026 00:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WeyTfrQW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hGe1KOc6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F3810E19C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:45:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E06lpB3718216
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QODTxX750UA4HDn/zUk4Bheg
 1ca4Dh3QMwnpyqlFlbw=; b=WeyTfrQWQtxC7P+0lvyYoIAo37ADFwFqHxG8VhED
 3p5Vkma8T5Sas1eGuUM0PzPhyhMpNBrXUcKhwgt0E1Dzho7Mspo0XsJW7/SkzqDE
 NeqvMIY4oHX9vaLwxqSMSBaHFa6PVAM95/aYhak4r2HaMlppf2dwDqUMM4d0rKkX
 S0omk2f0Rq+jRIbq1Lf8yzgZMafTff8B7+e/CBHn+LOgYI3z5K+p8un4C2+7Ia6a
 cmQyhItAqar78egyuUSQVKx0V9aqqGYQAQ0uElefmuDzAO9xxBFOsaDbt5mdUDjW
 m0r5ngygOLIRnzTV19TJ9hTp+eoqw2YR1vQWgUchujrM+Q==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dmfey-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:45:45 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97e768af628so2369343241.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789346745; x=1789951545;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QODTxX750UA4HDn/zUk4Bheg1ca4Dh3QMwnpyqlFlbw=;
 b=hGe1KOc6TD22W3vzJ4cB6mMrbUJwGRMCiAUnv0w9LBfQJe90C+9XMUza9hY/SdJqI9
 BKkjim6ZFGurV4wSkukRTMoLuj1kKIpwfQSZDs4tiKRN/ldLlXq0447uPCg6iAONddkP
 oV178l2uEoTVT7DsPt1qK+QGLhjS0wti+lfly+OWwCEu1t5RArHZ9F+9+eR9/Wj2U4Pi
 m1uPuqv8HpRT8BjWKC8iixPhsCYbrfwq06wVqdyETqJYO4HyXY70QJvYoq/xbgVkfn/b
 k96Il5ou5Y1+q0sTm6rkGNjzvplwPK+P6xP3ouyegH0uOSbd0DYczj3YvbnIcEdmUuXK
 G5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789346745; x=1789951545;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QODTxX750UA4HDn/zUk4Bheg1ca4Dh3QMwnpyqlFlbw=;
 b=GNHbXQf+R4F1Irx390QB2JdqKIb9OAG6+6iBfwiOexhAJ6RLHjR2qKk+IjuL71tu09
 pexcfuq9qkq1vjhkz5wk8uUIC+wKErXUsX8S5/kyYVjewsJLudFLaN0OuqAwVPjxIgwd
 LhwtQGy25HqlUkf+oqzTZohlx65DoPSKBYKV2TJmfn6CDImGAKZo1WBxNywZs1W1hpq7
 mzPhwcilP71wLgwVCrGi8GUNqhUrbus4ItM5fuGvJ29MCHEjybOC+r1+ptrY0rOO2bzV
 d3MO3qV6ysHs763d77t5DViplZ5Zqx20pNV/+8i6xhNC5ZV6bUu7/eHyPYYv433yxwMa
 nZlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxouAfDpArl31cGOe9/u4CdXHo82B82S/1/oCZ7ZTXoSCsqfXaC0SVUDfTOlEJBsvH1QHSz4SnbgGc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nVtKP08CE3qo63i4rfTGkMFMt8LWpPoyx13rU+9eo7IBIYqelg
 bQaemqKlxfXSVTLXy4c2LYThPOIUC5CcdnmVHCojGSvMrrOYkgu5GX8EQMVWV18UKXbu+2rhC+v
 FSeWPfsEELuzLijSc2yXTUPLyNk0R6Ti+Ugn2NbRaSZSEsQPU2TDmP4IXNaVnmSwXKT9+vns=
X-Gm-Gg: AYBFou0oNELsDoGVGEfksVWZj9bBEaSu2/CuMHZLVESfdXtu1YCAsAydMj6aGP46LoL
 8XcSMWwcUgSDsGAZmc74QNRRp29vsiDl8mYmM91czcU29ZW2F7fC13FKW30NWyv7DL9XQgW0eWv
 /J9HGZTfPA1R9oKrn5+Lez3VXLTl9zt0d3ymtRRi7NGebWiajQDKmug9V1JS6LAltc4GLtAe5Fz
 LS1AM33Ilhjt3X8l00L80uY6abiC2/u+quejaDixtdzf0BUBh5xwg66a68OOB6qXcp/uLY9eWvd
 3KOiR3J3ymKwYvRtc+owFj2w6mASaucmN0oCYsHSr9eP25N49o+Ff0OEcV4I2kelfuzIjmoCqQM
 K7+SA3KjdqfQrgE3uY7Y2enxnzFIYgudXKPe2pUu8lMRaEkLN/57KCWiBddixvR+18B/RQyuZ0x
 XtPPwIkIbkHCYl
X-Received: by 2002:a05:6102:a4a:b0:77f:9278:af6e with SMTP id
 ada2fe7eead31-79b5b196caemr117948137.9.1789346745150; 
 Sun, 13 Sep 2026 17:45:45 -0700 (PDT)
X-Received: by 2002:a05:6102:a4a:b0:77f:9278:af6e with SMTP id
 ada2fe7eead31-79b5b196caemr117928137.9.1789346744772; 
 Sun, 13 Sep 2026 17:45:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a03a86f2sm2002489e87.4.2026.09.13.17.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:45:42 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:45:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 4/7] drm/msm/hdmi_bridge: Drop redundant
 initialization in msm_hdmi_bridge_init()
Message-ID: <vzr4mqf3opzusmbz42fwr4m5bbmpu7imrwzsuhhmxcz4klklme@anqfxjg2a55h>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-4-87bdb9f1987f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-4-87bdb9f1987f@oss.qualcomm.com>
X-Proofpoint-GUID: BVdw1XCb8brueakBeADd3u2zJJkDSG1J
X-Proofpoint-ORIG-GUID: BVdw1XCb8brueakBeADd3u2zJJkDSG1J
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa743b9 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=P84uMFOcKlMy4IiKK0cA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwNyBTYWx0ZWRfXz5nbU3wbLZJo
 zBJG5jvUOO7yTT3I1s1ut0dW5Qma/kIakM984LssnMViPhl5XCjJ7hvpitH2rPVXx/68vdampzu
 q7iZ5ErDmEgjDk/J7cgETWSEEZOlUbs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwNyBTYWx0ZWRfXzth05mnmm7cY
 b/oo8POTTgqf7phBEBByTErZmX9PiMbsf4Z91gOUebrN05Y4rCyHrE1xZxF9RJ14wWpM5QC3ZrF
 jsHONeC7XP+Bm581BWlM3O6+G9H+5jHYcRV3LZ1AW4PULc8MMykqR+8B2Ikyk+DRY8ICLsFuzej
 M6EaEvpAQtcPd/UvL2T5OrwQHplxI5Z6zDz8yrtk/GrP1TURUDCLRV2pOBSNbdABdBjHZIoLvKy
 AOOH8OR5r35zx/zgkmt0ofXyFTJwgt2oYUBk6LpJByPbJmPM3AkV/hUMH9hlDQJh/zDnqvRyYQN
 yxlZfdhyvg/WwVPa5BFgjOob17QV0j5JSbu1iOrUijVLI3XqwDPHwHUYDQBSf8aupRv0ybThM6N
 PraxinqQdles7fvtgVpK5Kr9U135kcoBpIe8YHZOHboY3zyCj2WERRsaifEHkoXPSVMK3co9yTX
 riXriRA2CKarRrIoBBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140007
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

On Fri, Sep 11, 2026 at 12:29:37PM +0200, Krzysztof Kozlowski wrote:
> Local 'struct drm_bridge *bridge' variable is assigned in ~13th line of
> the function, before any first use, thus explicit NULL initialization is
> not necessary.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
