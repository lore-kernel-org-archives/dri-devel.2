Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87AFC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1AE010EA35;
	Mon, 14 Sep 2026 08:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AVApbdzl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JD6EC8NB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 601CF10EA35
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:02:20 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5j4gT063677
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZlPx26cvgwY4RaZSyFHFEKKvtBm4/D1xS48mPtkzlJ8=; b=AVApbdzltLnnN0Wy
 u3jNUX1l3kfggAHIqezUC8yG4nSmm5tPshXvKDJQMrZy0ewsUzTV9rjA9MurKmVJ
 XMVyE1NDUcfrbqHhOUmBy9WYFMwEjkAjzHPoHhmVxNeQC/GuvKt4Xq/9rlwM7bNr
 VhMGL/ogibuYw4dj6fTv2cKZzzhGgxoGoQAqbXLko2e7+B7K7jDbMm1eWTFLTyFu
 JS+45hNXIJewwnlkPP0CPPK30DRYtpcgTevRaRyieMKZP3LS5hq9qorS2uOa0xiU
 /TN1zK+KnvFC9X9UWEs/Uvaxr2sj+x/Ex0t5+wbyo91paEKpSFQNWQtBghqlb9KR
 NdI2eQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dnphf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:02:19 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-791265014f7so53074137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789372938; x=1789977738;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZlPx26cvgwY4RaZSyFHFEKKvtBm4/D1xS48mPtkzlJ8=;
 b=JD6EC8NB+XYifl1VFiM/sNdwtNyYSv4IZscmD3DabD7zVJsiAZNDrZyhPDADa3nyPO
 tivVGsiKOp3ME+fx/FSbGsnhNQo4B5mRoXw3GD2RbLWkXi002/DbHRvce1LoCqi4QoZC
 xWuo8S/EMXFL+LuFKhPI1CLNzJwjE3LM54OcxIuEsoDqhbDHPnmgR1Y8DYO8r6EtT8vn
 DXvssR1m0cR1xnydexc9ixN9F2WggEOe75YmBABt1AaAoiuqu12nQzbiuOzzKh8162NR
 lt+OCeHEZk8FF8hUeV3tK5u4MreENCFm4oqtY4eqVedtG4fqhR+IjnSMFUGz88yqlqcy
 CsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789372938; x=1789977738;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZlPx26cvgwY4RaZSyFHFEKKvtBm4/D1xS48mPtkzlJ8=;
 b=qe/p5KntWkP84P/2LFzlesPls3g2XztzBfGKGtfBTeOFEvdcIUkUWWfSyRExwFqtcG
 hkmxcpkkxyouxl2zAuDPCHoCelD8So8vDXI5ifaMcuQoAdxJgzSYhh5wviOuJpnhAWJZ
 lLIefL92WRXk3Nx8MDZ2nLVdpYVsCehegihOvAChEnqhdTqSUmfz9osWLEaC1Mhyu36N
 yeQuLz6VR+Uw2+wLIaoBVk5q0dK1dXWwKHqabqciqCuLQBoWTvChT7FsCwcbvGjcf8nw
 9p0ocqdtWidzOEOfHB/RCKJJ/WGOjdsIBdzHYUzX3mW2mkyOYgJE3toUKhnFj4HE1bja
 g4Cg==
X-Forwarded-Encrypted: i=1;
 AKwUvByOuy3a9hqnlTN71c9uSfgUzPuPe4ufqfzcrzuafTmIUn17WZBwT8PtQfqudXItjcMHDnQtI5louPw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7NHThwS+oVFPfCcatjbE7i9QnmC5CjjUBL8XCTLAw6N6dc9TS
 nrST5bR79D2okhwdC4hGFE1DdA/WZzbFiGU6X3Sv5jsXamY2KGLXZjO8VchUT7SbQOHQJzspE+1
 WXnU5e2aV5OosAekBtyL/odfyiM6WErpQo0vR8poG7wL+EqyPfIG1l+2rFAEarCoryGrFXe8=
X-Gm-Gg: AYBFou2PvaRQ0yH704F4TavEZf0fYhoRR43AclWMznDwfhK7HfwnWNhDy7Y+S0JbeuG
 DQfotAP53MCd5lxUy94HO5pzQF815cMnEVa+YphImZxSgOU1S6pcul+0G6DvoBMpuyq0oN2WUBL
 SNyp7FHPKK3lpcp/MmHvdBseOmaDRvHtJsIDXsdcDWiiR855KDt+KXWFYY4aMCooGtZ29F5Qp2Q
 54+f5IjsuW1sCykBK8JasSd14tcAYg8Boq5D8D2F7+wQp7iP2LqmhQUku4YvwzBZWx82fOlyQ2j
 ivkXXK0560dWoPlJTHVDUyHlWt0ebSOzzxe/ACN2Li0gzNi/zxZ3S+dRXDxrtYUz7duw+vTd/Ca
 4wcfMpvu4hqXzbh4D29b3gg==
X-Received: by 2002:a05:6102:160b:b0:78f:c6f5:27c9 with SMTP id
 ada2fe7eead31-79b509df7c8mr192601137.0.1789372938395; 
 Mon, 14 Sep 2026 01:02:18 -0700 (PDT)
X-Received: by 2002:a05:6102:160b:b0:78f:c6f5:27c9 with SMTP id
 ada2fe7eead31-79b509df7c8mr192593137.0.1789372937939; 
 Mon, 14 Sep 2026 01:02:17 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29660b29a7sm387483066b.43.2026.09.14.01.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 01:02:17 -0700 (PDT)
Message-ID: <dae821cf-3869-4414-b590-d93197d6a322@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/mdp5: drop cursor pipe for msm8x76
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260914-mdp5-fix-cursor-v1-1-9fba3ace6cb9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260914-mdp5-fix-cursor-v1-1-9fba3ace6cb9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDExMyBTYWx0ZWRfX0TNr31ep5Nwb
 TFW5R9g7DZxtOmNPgpeCdLugXPQ8BhkB+SGuWb6jJMcWZt5OTc4Hq/d1Y5htcSIMzL+QP+v3myj
 0oE093f2n7zfDX0AzySAVNwMUX2Uu2YjcwgF6A/apIOHWBGiNBDhnv+so7qUO3TbdNfAwrA4X2h
 jOUpcyTud3MMqWLLBPlwAWg28vuI8n5f0yliuyzGtQ39P4bOwesnfYG5jC8qQEWYj/yc3mSJqW0
 QGdlR9v1nlrDsS9lQ9aVjvN2q4ZTPqUQfXRcazb6bkoAUil9CcQG2IcUGiSLMaExzTR3ZJ2NlOQ
 dWoNF7yd86Q4DKvWwJhp01ZjZua+eD8xcLomH1sfaZVufHw78EhOkm2xPQUJv/zeYS4BFguysJ7
 6CZNHsQmOHoRjvHmSJ4250p2C09LZOIzKH6e7EE5UjdxlPXFihjd1JY/UEgaxNtsGxyNQvhSrj9
 P1CmV0Wywgzvi6lYM+Q==
X-Proofpoint-ORIG-GUID: o7c4yHV8H-t9Ws6LWKOtm_rp8OTwctDg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDExMyBTYWx0ZWRfX5CnP1XY7fy4U
 AOscNnIm1/0mG9Ot/LHnNwXqsXLblws1Pz0Rho6k2KHWTxuSMBfnjrYPHW5Bqd9g3RoY3nbnyxk
 pFmDQA/l5vcB3o44Y+YPCsoobNOs5q4=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa7aa0b cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=UIDDT-_cQcoNCxQDPBkA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: o7c4yHV8H-t9Ws6LWKOtm_rp8OTwctDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140113
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

On 9/14/26 1:24 AM, Dmitry Baryshkov wrote:
> The MSM8976/56 family of platforms doe't have a separate cursor plane.
> Instead the cursor is a part of the LM block. Drop the erroneously added
> pipe configuration, letting LM to provide a legacy cursor instead.
> 
> Fixes: 1860f2a8b8b1 ("drm/msm/mdp5: Add configuration for msm8x76")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

The HPG agrees, the SWI disagrees.. possibly just a leftover register
though?

Konrad
