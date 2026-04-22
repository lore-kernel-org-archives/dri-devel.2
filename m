Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6138FA1FEC
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3576310EF31;
	Wed, 22 Apr 2026 19:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TxJCv37V";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gfjTg8dA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1B410EF38
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:40:41 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MFfqmN3528444
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wJrgZsTxfg/73T8w1EsYI+eF
 Oa20AX0qzFXqb6f1ewE=; b=TxJCv37VuTV8qp29LD55vb85wUJNsUxfV8EI2fhQ
 tRKGNuiQwAW72Bw/E/kdM99bP6w9bMfaQPV96u85SaB0F8Ud2vjPnmVazU9BZnzu
 5vCVC1vcrf1EKroBlujG7rkrNvXdo9pB3xbN5/QEdia9uPJrXIGqTq/rr6qzmfej
 7SIjD7iqcedQ4p0tvIY4QHS0aCfrEKrVVTh1hF0bC1m3mzqJCeDsPnZzWs9+Youg
 /zd29JsA8ii8rQVQ2AUq9z7OOacJbK1dgqcR6zxm73fyFAzq3YC4aNGO+fad8F7F
 6XLarjVMIrF/1rNI2tDzsXlcwYAbwwIy4xafxa0I9z+v/Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16wrvtw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:40:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e592e833aso46030421cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776886840; x=1777491640;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wJrgZsTxfg/73T8w1EsYI+eFOa20AX0qzFXqb6f1ewE=;
 b=gfjTg8dArWjX3eZfZBD8/A9evFc2G78SWG4LvZRyAntciEJpNUvVmpH5GcBm4DClq3
 yQxyLS45FxAkGk4LP4h9nTtFshP0DfGIz/qYVJHj15kZzsgZ99ue68wQfutvD4/2/k4Q
 ZzvtAlwLBmo/t1oXz2TQYg/IVMnVneiF3oKboU7ZUamD9Vn1lRYmOtZ35Ay9UFlNpujW
 fQ+PcZnN8CRnaC4P8jVVBfQrNoilOru22PPzw5nUJ9eLS58lXyvTgr0C+fswvH6kAvHe
 FD2HMRADpsR9YPtnYegxf17NlWZQFnf+oAozHw1bsL3Hf+5bY3rAG2lU5+holKPqqTOR
 NRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776886840; x=1777491640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJrgZsTxfg/73T8w1EsYI+eFOa20AX0qzFXqb6f1ewE=;
 b=my/Nxuw/yjrmNc1/hUv8sCm0dm7IZSI8y48x/CjibKw+s+B+NNHO3jV7OcUBBYwJwJ
 CTkLG9BfwdSs5dEPKOsaY1hkUIDnghKcO3Lfqg6sUr4dqu22UZTD/Xk116Ibn0QpDDLM
 4jTS6QYNxLPdgGr1aXeLDCm5ByBun4l7+/sQlmuafwOywqE4AP5Z/QX6e5YVN6n1zJM0
 nFJlThLFHljWl0UnJ6qfxQxbvIrWT9oNF4HJCGBYotLbkR1ibvoVG2rPKGU52oh+6sq3
 87OE6q3oc1XFFL4F+0etxE50vckflgS/2AQANqDc+sig6Pa1qu8OZM2Qx2SipKvaehyV
 YoiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yL04bfFhZ0zPSn0/VqKfPf7dW9tqusLKpA/Xq5qYAcnvbNnjKqLEsbn6S4VeFwJm0vUQbzAtLQNA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj15VSwWvNfnJFzJg0m9tgF8BGW8E3vAXF7tjOg2VFnjmSxiz6
 dAKHDuMMYunnwGOAHt7t80bG/KeKVQSVPke+rcQyDO2Kz2U60v/hi8kn3cvu44GWqJChnmf/GXt
 RC3Mr/MBJBwoGeJs5QUQCfE41nuuKXaZamZs+UsdDfhT1pD0o/24dlkAH4/upmRqIGotXLp8=
X-Gm-Gg: AeBDietBAptEFG0z+3nSrJXVK9FOsBRH+c/zPYy5OY4m2HXR+92CKX/iQmoHPZIlivz
 piK4arKoAmso6cdD/4EA+aNUcIEE5fRhfN2DOg8IqVJlztIvSZBdpTAMhHsbgmLUKwCDvsijKO/
 phwWrgVb+/UtdFUo4A6jW6ESCkWNn60fkAaQlgHtwZw3fu5XOmneeMDkjo0OXXf80KZy8UuXbLe
 +3m2b+LgoE/1j6PIAhhR3/FrRyQGZSgUdGzE6zn8g6NS/gU29I3zRZbVJNYH4sLi1VWhjK4tQsJ
 qSUtUl6Z2ksaX0jHOLgUbRaR7cX+e8O/xVqDLF0mKdKH5tZE+AcMU/5dP4yrX7HY2gKliZBsPvq
 ldxtLt76WsX4P6LiILnBfia2AQIWEIdxot74/Q14YrfpqtNy716BPdcF0bMiP8xAvWW/pM7uHXl
 C97RBplheOGKPWCYag04o/6l0pEsfQpcbnr92BNQC+E+Uj1w==
X-Received: by 2002:a05:622a:6a94:b0:50e:5d24:db6f with SMTP id
 d75a77b69052e-50e5d24ed34mr145194171cf.43.1776886839984; 
 Wed, 22 Apr 2026 12:40:39 -0700 (PDT)
X-Received: by 2002:a05:622a:6a94:b0:50e:5d24:db6f with SMTP id
 d75a77b69052e-50e5d24ed34mr145193741cf.43.1776886839428; 
 Wed, 22 Apr 2026 12:40:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e7dfesm4608874e87.71.2026.04.22.12.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:40:38 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:40:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Marek Vasut <marex@denx.de>, Linus Walleij <linusw@kernel.org>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: ti-sn65dsi83: two fixes + add test pattern
Message-ID: <7igh3ptyadpztgxgl2pjbikeossz2trr3rowdjv3lbf6gatyb6@5bm3hon5b6mi>
References: <20260416-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v3-0-143886aebc6b@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v3-0-143886aebc6b@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE5MCBTYWx0ZWRfX7qfwS/5FGLvt
 nVyer5Z0vWm0ZSWKI0hlr2lHyiPmRtqJwHtIjzKsBQve5h/LSGFbAlxgCumFI38CuNGwY2oQR+N
 71WL+T+cYQpq+6jGB6siTDbWQTdkrnHqX/GAkDQHI0lw+6Vdn7Pjgp++Q+dAfGt8L6yOF66qSL7
 YgDyAu4t8hIzp7gUTvlPVBAaMrnAubpV+uvDb1fB3WMtitzzkO/8YHRsRMAu41lV9N1Q/rnE9lP
 ZgU0JuT8tDLlZkjICClao1bUN4bPYem/ii5ouH+Nbi953gr8FOGz+YjiW3pv0DKQ6Nv6SexQANA
 fZUXKx0uVCaZ7UZ4aG7dQK7OBS5b7acSgP27LUdz3Qhi9/jeKuDMHhPg9/eqjbGFaeeQW1pSApo
 RuyqbIH4d31+IUkjvLPLGXckkfQwe+evL/68wRfxz9nZyGAdqtRLT+yi+Y5mHhqfuKN4r3DrgCI
 YVs2Oa8swjaZoqBuR0g==
X-Authority-Analysis: v=2.4 cv=dL+WXuZb c=1 sm=1 tr=0 ts=69e92438 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=bC-a23v3AAAA:8
 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=Wje8BORFgm0jWopP8VUA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 9jLcR2s6pDR3DDG84ohdSfmnIyecG6m1
X-Proofpoint-ORIG-GUID: 9jLcR2s6pDR3DDG84ohdSfmnIyecG6m1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220190
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

On Thu, Apr 16, 2026 at 03:59:54PM +0200, Luca Ceresoli wrote:
> This series used to have two bug fixes, now applied to drm-misc-fixes, and
> a patch adding support for enabling the test pattern output from userspace,
> which is now at v3.

We really need a generic interface for TPGs...

> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Changes in v3:
> - Fix incorrect halving in single-link mode
> - Link to v2: https://patch.msgid.link/20260309-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v2-0-e6aaa7e1d181@bootlin.com
> 
> Changes in v2:
> - Removed patches now on drm-misc-fixes
> - Fixes potential inconsistend values in the test_pattern patch
> - Link to v1: https://lore.kernel.org/r/20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com
> 
> ---
> Luca Ceresoli (1):
>       drm/bridge: ti-sn65dsi83: add test pattern generation support
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> ---
> base-commit: 126c50bc2fb6ddfe5b7718de67bbd7592a1062bb
> change-id: 20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-f5ff67e1900c
> 
> Best regards,
> --  
> Luca Ceresoli <luca.ceresoli@bootlin.com>
> 

-- 
With best wishes
Dmitry
