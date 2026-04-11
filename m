Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66391F3ED50
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 17:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C398310E212;
	Sat, 11 Apr 2026 17:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EgHeNyWO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V6/V6G3W";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080F010E212
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:43:00 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4U0N63679672
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WwzWxiUt4/2M239gINQNxhn2
 wjnC3PgXMcvjNc/k60A=; b=EgHeNyWOGS5+3ScPqYQCa1WXPqANGIgA8FubBivE
 hT7fcl2chqdy028vbBEY59yzmZcBDsCTgbx1/ZzXS/S70dOaPWafwIQsSI572cAZ
 X5sEHmxSFkxQtuFCrzm+mjt0nhu37vFyLGN9hyzGM1LwALTxIcLXNuBscuXgaCg0
 minHU1csMwK6cY4OxC/yYHiuw4J1CJ5sJZ7WBqywP2TgP2+brD/zwdkvUFovHQZp
 MJ2Mh4VV9SLLxIBzGh02ZCwSE/n7pYb0lGkvib66O3UX/sM+eeXfb60gv8M1Gt/X
 Fxsf3wrG73FoaRhm6Kd1t+My4sCCcAxD8i2wwGHbY93TbA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dffb0h3pb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:42:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d8e4c29caso77911331cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 10:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775929378; x=1776534178;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WwzWxiUt4/2M239gINQNxhn2wjnC3PgXMcvjNc/k60A=;
 b=V6/V6G3WprI4vkMdyXp4vuzn9ZOB9rBMG6IgemzE6niD3gyd2zIHwiI5il83aePy4g
 lQmwXoZEyd6J5aaxMCDU+DTZRw5EaLNlbxAkYhhbaHf+1w/gIO5OL/0fMZGWjV+ABaXS
 z3T4UgebifYSq7pGwLNG84rxs1Np0SeapKO5UkUUBcgnjBJp9weWKtKd7Ti4J3bgUmxm
 MtpyICUbytkCpnQiZLU6UouVInGbD1CstSMXXUfSAx7wfgqbgrrjq9Z2lcF3at+gIHt1
 Le3S2HSDHoFI5hAkhlQ6inClL0Fon2GYnPiOJl+3rS5FlzqWufQNYSPBkwNI4o3izkDp
 YArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775929378; x=1776534178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwzWxiUt4/2M239gINQNxhn2wjnC3PgXMcvjNc/k60A=;
 b=bbaXdZNmMUgWmt4UHyJkTKAcJVeuytiX0zjV8uUgKfmZF0KBjVwZ4vsVgYzpbgJc0y
 QAiFMupeMyI7+nDUWa5PV+JKUISpp5eBStrw7Z9DTXqtqzsFIn7XSPZ+Q2qUK5WsvMEx
 LTIRjoblXoXnnGBDYEiX2bSpbl1q5yF9ujxAcTAxQqb0t93AqOo5SHF5Qj6eTK3LPpcY
 PYezWDs9CvxVrD/Li5mNFfyPqCnrSU0pgPtx1tik8NFEQDJrxFXiWmjTZ4bhXt+eqyIn
 oFj7kyqNc2SlnfqwNVfdV7oEXYAWEAvGU4YVRneT/0eWMXyuzkQl2qspnGXqIdMBicdW
 LOWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkSKX7k1wtHY5e5RsLU9uRYorgss1hIw2fjgZXBrBmzkg5iNZkzLV2ZjjuJ2SqQAfmOidRPXAU/9s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKJdpx3lpC9DFoWkPzTXEEjeS9FiJuV7bUXRXQoW+E85xCkBKM
 Y6sIKcDUnRrCsdBTFLmhc8G96IVznim8LQsxclCjIw9XeoHRJo29BOfevdprMyaeJonH3iGXnmu
 oJ4gEM+/GZMuBpDUjIk4DR4Wp/xWepTN3Ue0GVnjQm4n68kqvkOGanAuMDsQeCNqYJW0T8L4=
X-Gm-Gg: AeBDievix4C5GB/qdD9sv/p32iBmmYzib2AXVmpY1h1j5y3XzZLj4lV74sEsS/zy/TX
 jAr2IIDio25UT8tYzHAAxtFVjhUMww0elHO2R+wA+zQuZX6Cs+WD+p7SLaLR7SDDN0SmCTW0VpL
 4LBp8H7pUC09wUhAqk34o3t6FKkQEJz0knTXqFPURHLijGx/YYbE/BoJq1Z02cVTQMKCM/d/e3M
 zEk1Vh+u1DUCaTbfh0V/ZBf+NeyHu9hUo34ZyICkre28kli6qY1+rHTiUQIurHRRZsal0COvCM0
 B0WcolAoMfGfYmD4xfUEVaWfh+e7WcqPFFcvNBgYHdrjtPhgxd3hPIgajS3qDqEdnsmXQ4c46Fm
 Tn3nHNIQDXVfqHtVHacTaPoUO7GDiWGxfQ51EQWxXBTD8v6ZpGf30/GuK/hOMhNSojDfwxpaFh1
 Hh3Tvm48CItFO30CtzkX/Bv3Sgq+iuikXf8/I=
X-Received: by 2002:a05:622a:5e88:b0:50d:8074:f3e4 with SMTP id
 d75a77b69052e-50dd5baa698mr108826511cf.27.1775929378475; 
 Sat, 11 Apr 2026 10:42:58 -0700 (PDT)
X-Received: by 2002:a05:622a:5e88:b0:50d:8074:f3e4 with SMTP id
 d75a77b69052e-50dd5baa698mr108826201cf.27.1775929378027; 
 Sat, 11 Apr 2026 10:42:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeef6dafsm1550953e87.58.2026.04.11.10.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 10:42:57 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:42:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 12/39] drm/msm/dp: separate dp_display_prepare() into
 its own API
Message-ID: <zm4kinj4ycohlvd6tib5osut47xwxq6n7g7upig6d6m37jbesu@t77oetfzma34>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-12-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-12-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YfmNIQRf c=1 sm=1 tr=0 ts=69da8823 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=lDQkouuo_yPg0JcN4GoA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1NSBTYWx0ZWRfX5YDbxO0kaDPp
 XMfhSoxWvLni7fwdCiw3T6svBdHS00AvCBogjXIAQ7zEnAaexakHCuIU/yX2PQExWLQmoFpT9yv
 5z4jUHoQzxh9t1Tfw/oQc8efwUJdcFgLexq1N9zsodNTzUn7e9ydEU1hJbVOOVIsT6P6M4U8nOB
 wTHRLF3K0Eh9eS42tLavVVi+CUsre1uwr5fbVusJfY8e+gGYzJdGybHYCPDkud7rtwWM9HdfUOF
 L8d9gMj7hwPRkwZ9AD4My+d9QkpWO5D05SIgkMpWdCXB7efw+4RmxsjZXikYIhqjL/DyC231ddr
 Xy/QFS6IOYwyE5W14cWGP7jRzmSv2LylNiTn0pXgjH0O5nuQgmDf0orvY6a303a6i7fdBD787tL
 rCVKYQbPZrXmEg+UuXE8Q1dnjgiErOWwUcQzS4/MzN9csYOLmuKCkxB+idlImAmxa5TgQR+8+fp
 wJ2Xi6zMiPvAEHjGhDw==
X-Proofpoint-ORIG-GUID: pEE1EN_1ZwqpCoM6A-bwlK61cl8278_D
X-Proofpoint-GUID: pEE1EN_1ZwqpCoM6A-bwlK61cl8278_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110155
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

On Fri, Apr 10, 2026 at 05:33:47PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> For MST, the link setup should only be done once when multiple sinks are
> enabled, while stream setup may run multiple times for each sink. Split
> the link-related preparation out of msm_dp_display_atomic_enable() so it
> can be called separately before the per-stream enable path.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 16 +++++++++++-----
>  drivers/gpu/drm/msm/dp/dp_display.h |  5 +++--
>  drivers/gpu/drm/msm/dp/dp_drm.c     |  6 ++++--
>  3 files changed, 18 insertions(+), 9 deletions(-)
> 

In the hope that the atomic_prepare() function ends up being used as the
.atomic_prepare callback...

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
