Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F92CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 22:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61C710E894;
	Mon,  4 May 2026 22:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFkwYgbS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RUedlJIA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD15810E894
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 22:41:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644LkRt21430674
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 22:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nwoJXM6+1xp+hLX5E50uMhXY
 2w5IXLa3r/hbeB0B2t4=; b=JFkwYgbSJdNmoSVpJMPbX0CCS6SptV6GgHo2/0n/
 jFC8/oeZYqCZujRkQBp0VHC3vM5uMc+PqKjt2zNudlMnItK+BWv9V0IYZRTBdN8r
 LbJ0AffuVMmBGxhqKPlKlJaFz+mdsDNf0s8BLyQaXGjAs1A8jm8TglOhlLSSl7Cq
 /2vWaAIYopRi8ti7AAwz5crGYzZNXWtGAEAZ1NEI/yTYaMq0ysLhbzsdTiuTVO7F
 9FpcGaXW2HCHfcb+/VoCy7f9AqHVOHYhbnQoQMEv98voFT5uLpJ0RDVcJF1rtR8z
 pY601zgpX+WZreXoyJ8aqaW8kiZKyuoqQfCIVvXpbLdxDA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvn6swwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 22:41:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso161031341cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777934486; x=1778539286;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nwoJXM6+1xp+hLX5E50uMhXY2w5IXLa3r/hbeB0B2t4=;
 b=RUedlJIAw/ctkxxyXq0GEUEUnpqyoeSA+PqTwCUygzoABV0vu3WHV5IhgaYM7SmtwO
 qNDmH++eElQx72XjDFJHcc2pfKw4GBQtuZkEqhM9iKTbrEmBhHqklene5KmTdL7fdD3e
 Tef0wyw38ZsgyczYw8QPzsCVj0Jwe8lJqsN/RECz1qVzkRHFtSKMtrzi8PM2muHdBSPR
 TfzBDHlYHj5AskF9ZuSm3+GubZwsRkBIm1f8TAI+D0vMgIIbQQ58Bvt1/ejLlb0m+bqT
 Ygzwhr+kvgWqu2hVrnUVxmVguy3batd4pJcdkHvNENQqBC6REsz+iu52FQlOjrwUPMfe
 ul0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777934486; x=1778539286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwoJXM6+1xp+hLX5E50uMhXY2w5IXLa3r/hbeB0B2t4=;
 b=GhOjia4+VsnfmGMQkfI39BdSh6nDGOGsqKGVDejhrV2IUE+jjbA6y/mow9ZvO+XhID
 dArVbWNuBMis3phYuyCvEyv/Lr3QE6AdnBeanWbJf7C1j9MSHnDwmfQoP/z855KQNdYQ
 W9MX7peb51Kefcxn3Woqdj1itl1jbRQvi11qbScgLjl5FmohnnV/pPrcTFyC1PHENbry
 QsYwvJKwICn/hbjLA4hQuZD4vaactuKm2r9jjJ9OXvxvS3/NMB2Sd+dFVzTgaaalXCal
 hAjOFMVFiuKvvOoQOMvIbmv7QO2u7i3P/9Gk1OD6I7nnipJIR/l+uxqwK6lT6GIHo9/5
 2ZVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9B6W4vR4v3Lry3NMuCsc3cYvj/uQUPVu/E+DPL4ZOENM+TcOd+S/RcGcyieLHwLrtCbABCDhxKZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywxn+dOMUSpspGiWZ4UA2oqQbcmOGjMTSMQ/omyI0KCDHfL5trJ
 jlPL+0UQ5juFZPxNsKvLLN4Ncd8TRt6Whb5HATZgSmwZ4A2tx43oWoAkumOenl5t7edfcdlyKqB
 sJ6HcCelUVScvDbnWy0nv2JA1CTVQbgTmd3Fveb4UgcYBu0OYd5/7v5+J1ZNt2O0iYKFK+Qg=
X-Gm-Gg: AeBDiet6b23RMmcQwU6x5fkW5DUueluAh95r8R6D43hOU7pLH2eFBCAoRc/okWpDX7Y
 YERGkQdlW2EKZxWHXIPdLyEuFX6cSt0QUGY3/4uHTpfOklcLm2EuPO1mmXMs7NtfIKWbE/PEl7B
 nj45hnV52w/8oZm0lzI6lYAOUA0XUpqwkbITvaZdyASlkdxz4LYYiJwvRZs103+mPYu9iyz/45G
 47I9B4ENxMxhrunENhJFPgaTApe4klWNRRjojfnx2mH53ViS44TzPLv8+TogZ2sQy47rgfzwYqZ
 JiBBQwUVPO/FPGfdRibSYvdY0TNe3LbqpEWqG+ih/Wew2QHH5GVV/bNM7GONmGvza+uWLB9RWq/
 OW5qngnH+K29em3Dvw63co/S6tSmz7ERKO6i8EhNxGkYhRQFa59XfGZhhTeRMqgaqJtpxqD+JFX
 ITCIId5VUqvwA4Ndsh0cluZv/kiYX6nelEqFUSoj6xSDoLEg==
X-Received: by 2002:a05:622a:1aa8:b0:50d:5a11:1b5 with SMTP id
 d75a77b69052e-513069d6e28mr11412051cf.17.1777934486313; 
 Mon, 04 May 2026 15:41:26 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa8:b0:50d:5a11:1b5 with SMTP id
 d75a77b69052e-513069d6e28mr11411561cf.17.1777934485864; 
 Mon, 04 May 2026 15:41:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39361300c88sm34342041fa.25.2026.05.04.15.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 15:41:23 -0700 (PDT)
Date: Tue, 5 May 2026 01:41:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: defconfig: Enable Novatek NT37705 panel
Message-ID: <7sujwhy2sbnxhyuo3xajlohsbkyvugciq5but4eyjsfohzojg5@wflekkz65bwy>
References: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
 <20260501-fp6-panel-v1-3-e09cb05651cc@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-fp6-panel-v1-3-e09cb05651cc@fairphone.com>
X-Proofpoint-ORIG-GUID: _dIJt5sWI7XUEuTC0Bls5VNoXRtJ6s40
X-Authority-Analysis: v=2.4 cv=Z+vc2nRA c=1 sm=1 tr=0 ts=69f92096 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=7jsc-R8H8AlhYXVgh4oA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: _dIJt5sWI7XUEuTC0Bls5VNoXRtJ6s40
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDIxMSBTYWx0ZWRfXxymppUk+hCQz
 +ZLjym+T/GTLFjWSbM326tosqx/uu62+MsIVMfhHeDppkl2KrgKlqUgrwgdmSGr1tlxtmR8ypHC
 2/fixfKFmOrCZef1x8qB7r43xdfvftZ+5uqOT6h2r7iCDiRG9/zRNE8OfxCQU3T0EHMUCPohHoF
 gNKM9cf5ti0GyzQLgEfasFw9TuaVciCxlDXyt+HNW31twN3gEPGX0oDK9BTExEdz+ek2ONshYxY
 Jb/lCSWO09GNvp2dakqULiCiHWKkDhJq/XcFcx8KyURgZIomvzeVVpDnOgZWmjAG10A+oOTZXOx
 ONgyU/9NWzIenu55S/j8RlR8c/aGad3FUwOD6xl37/6h6uPKjcrSqAqFC0uqwQI6yB2P1CrFIqL
 WKJTyuubAO96cMvySHOg4rcU1x5/M26ebb+xGdFNKlFCKF6NlENF41FH2TGm6V4uLFrSl+5r/SS
 s2zwxIdJElnkGHBTb1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040211
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

On Fri, May 01, 2026 at 03:52:47PM +0200, Luca Weiss wrote:
> Enable the NT37705 panel driver which is used on Fairphone (Gen. 6).
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
