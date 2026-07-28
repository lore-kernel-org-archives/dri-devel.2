Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF781C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A97B10E594;
	Tue, 28 Jul 2026 13:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ygf+M6nL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WKTBUoZf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF3E10E56F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:56:20 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SDObOi2411674
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xxoz+34qkVkkaCkqzIrALQ4y
 3r0ocs3NKveRxhoBSyE=; b=Ygf+M6nL+AJp8XYQ56WaTUW3Yl4G1I2VY1kFYxRk
 o5N0UBEX14C0m0FKWeMl0z98zYjkwcqhPZRGbUXxJt/rn+gZKXXDrEz0LqWbqZOI
 +b5gqC6xgr3Pp0VHwZT6RVjnbyXkm03iv4UkBDLJWagAZGxVaJq4Lh8tl3CfQOq1
 A0zPaJjeXIvV8hdAbjEI7owe1PryE44GWW46Xkaoxp2LS+Ix7WbfXe2OjUS/meob
 k2e8V45GwgNZ3cNdL04d3qHsoFAHC7Bf8CSQINke8qDHUe6bjsDfKajQ1Et3mTIK
 k3eMx1WRFUrH7n+Ilft6lzT+DsSayLomc6hWd0qILZTakA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fppttsyjb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:56:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso50819801cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785246978; x=1785851778;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xxoz+34qkVkkaCkqzIrALQ4y3r0ocs3NKveRxhoBSyE=;
 b=WKTBUoZfebw0iE5v1AXx9Z0Qe9FPUghBrgXt9faCmHWaSLtmuRHy9pyJKSzWWoL4mF
 ylNmwBM2WKIxb5WPutnn8uFDp5KygL9xTB0UVic7zgXnoqKCHlrtkjyN3xy3ATP6tk4L
 T62Q70sJ+Dkbgj6khFOiG830uExUyaBuj0XJdNac/0pAcxRiobMBaQHxdksiOX5B85V+
 6FV/CRpwfUflomxP9g/NHxZBcaXDvtFNE6eoeKcSWxZrfQRyTGIgjmxUcSVfREQZc3dL
 UDdTPJpae7gFnfQQyGrRC9eUmHfF4/2EZi6UAvmp4LeC8C4eMxHz4h6iAw/ofPxhiVaa
 s6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785246978; x=1785851778;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xxoz+34qkVkkaCkqzIrALQ4y3r0ocs3NKveRxhoBSyE=;
 b=Y/mvVkcfgZcUsoAp6cxHSeCi+xeZGGACX5SCxYhF/Y+4ptpL6V39HrsVy5YLwzGUrs
 v8fYc7rQ1SwXQw6Tsg+5p//0rzNoCKmte/Kzh6GMmn1AGy1wGx2Qz4vK5xKatNP75Riz
 AnRqqYxonuHxub+EVraAvCy7EbX0RLIMY95WQz+DBImtMBO89IKQk/oZa7FjD+6lhY+4
 +AKqaxPLA6FBcjbK4ovDovu8nrOupbWEn/18K2tVOGyWub0VxLyJQnbbZT1cXFAO+eQ4
 wGpMfZYyQOHyw/Ubn3Lo5ovi8Mo2GcG/Zy7WUDreTCIJrRypDhCkGNjX7qbMrEnlnCQ2
 RP8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQL49TS2zMXFEOeYo8qQN8dT2Qfo+D82wet/M9heDceyYBJOpItxlHVrvYSYspgcZ1hWePpVdpyvE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzskyL21UBT4snLJJpOfK8cBx0FMSJrI7twNNinV7zZj5SdC4SY
 FoKxtQoyhTsoRxjnQg96ZYPzfvJEDNzpYPP/7K9dd/Qk1DQA4FJxbBARlheobk4m899mfYuDCAR
 JrOW+OJMPYj/goAGyddBRL+spLXqV7eUjCvjpkKFVyI9ZoyiMZfkY/FR/CJQcWrVCtMnNdno=
X-Gm-Gg: AR+sD13pREAGEkwuMcyOq06F6EzgTXGyqkGNGEh9S+JTdarl4Ua9SGTZA+09j79L3uP
 V6QcFB3/Mjm131gZ3/QC8zRJYuZ6L3oyncDC7EYfm+wsU6s+CdYPKvEKWpyPj6+xa/o8PoYpeX/
 2qXUbB55Ev+LKgSt+Xq+eP5ExaRLm3kFH0QzjhppbRgoVhhNFBKX1MIMwpYe/yiMZ14mGChvcOi
 wfsAiYjKFBThLQE1r+5h9PJS6c9TeyNZhqDBOfCjXw5OEsHaCBW2nHBMUVCOD9dckFZhkz/nULC
 ZPhZTM4DSpX68ifkAejWJCXYAbV3bn1Z0xzDWT/C9DglgeYOljG0mP70ERCZJJLRutFEs3XWH7v
 4MyzdbdNFxESQYSAOr5WJwoKgIHjmXvc7OY2vxcfbmzfMfl3hG4Uj/K+JKg/VDhNhRd9+Iq5jp5
 JCADnIjsSYXkxSGw==
X-Received: by 2002:a05:622a:1918:b0:51c:94f:8ce with SMTP id
 d75a77b69052e-529d6feaef4mr22346261cf.34.1785246978026; 
 Tue, 28 Jul 2026 06:56:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1918:b0:51c:94f:8ce with SMTP id
 d75a77b69052e-529d6feaef4mr22345991cf.34.1785246977639; 
 Tue, 28 Jul 2026 06:56:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f22237558sm18744421fa.19.2026.07.28.06.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:56:16 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:56:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 Sravanthi Kollukuduru <skolluku@codeaurora.org>,
 Rajesh Yadav <ryadav@codeaurora.org>,
 Chandan Uddaraju <chandanu@codeaurora.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Vara Reddy <quic_varar@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
 Guenter Roeck <groeck@chromium.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tanmay Shah <tanmay@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] drm/msm/dp: Drop dev_pm_opp_set_rate(0)
Message-ID: <atbh2v2p5bq7dvr25y2l7nal25hd4j7n7ikzxckrmfcfqudpmp@h7v3f5vv4bln>
References: <20260728-topic-dpu_power-v1-0-e7783b859a70@oss.qualcomm.com>
 <20260728-topic-dpu_power-v1-2-e7783b859a70@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-topic-dpu_power-v1-2-e7783b859a70@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyNCBTYWx0ZWRfX+bvm5YfL/Ozu
 M+tfIUHaO4J1T7356+P3CPvtRX/6PyTLCWEZ4axWMBCBJ2PSAxHaPqYr8NgOh47YApltXe3Nn0K
 1YPAFxu3r6DYJwQINK8AjluoukCXF9o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyNCBTYWx0ZWRfXxSXKPH88ajET
 B9U1BKT3AgHErHj3L+ivSIWQA/jOnRqhxOh2mCszFzNmSeZFEfNxJ4HAFEY3y8l9R5A7T8H4SKR
 ayDBP5LUR4tIzV0pmf+VSbVTtUkarbE13j9j2yrQmXNkOckz4jfKmNe9U7t41MDGeqiR3zxsWe9
 v/E0Yq++lX57LjlTs3t7JWRXzEBG4WFOzGl3wFiIORrZTcJBAVkEKQDei/CTjkYAEUWzkFxyKKB
 zKmNOR+ifZBn1YgxPuxkgE56uRwZuvOIL/4uisHBRQhGDdOPirQdbFuX3WH+WdRmpwCUwJqEYhK
 Fbh/UOpBOCRCLh9QexjLxSjOlrRQ7EFJvuIer8EPsjyeSidCpJ/LPe/zgUiBGldq2y6IsThaTNo
 9WJ5yVeDoiCefxqA1O6YpwteJQeSyrNIX7fqBPYZJ+hpGH/yl+JCeqy5j3UazaFo+Tf740CaknW
 TyfRi9S3M8mXB+b2H3w==
X-Authority-Analysis: v=2.4 cv=aa1RWxot c=1 sm=1 tr=0 ts=6a68b504 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ze_z4zfmBB5lhDDjiZgA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: khdn3GkGUlD2ZU7bxmQGYV-mYZv1slCW
X-Proofpoint-ORIG-GUID: khdn3GkGUlD2ZU7bxmQGYV-mYZv1slCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280124
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

On Tue, Jul 28, 2026 at 03:20:46PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> dev_pm_opp_set_rate(0) removes the vote specified in required-opps but
> does not actually park the clock, making it run without the necessary
> power backing. Drop the explicit calls to it.
> 
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
