Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E762F103E199
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C800210E85C;
	Wed, 18 Mar 2026 15:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IujoxCao";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TgnpfUEB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA57910E85B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:11:11 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62ID5uOB2612576
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zTaSBeSUZqyP55RQNCJYe+Q9
 ap51sInV9JJjR2VFl/U=; b=IujoxCaojfpzwcOlEHi9EUm/xn78BswNB8OuNPX1
 PEK999Ee36iFlB/md/RZMkeLexHLhfgmHuRQRwQey9N5UPdM6tw5kBRmrg17lf7x
 Nif/oe0g5Ro/0JEox9phN9nhtu1FnQBOJCse/PJ4bda8PZDKjYr5nTVAh3vfhnp+
 oL6oRDCNkLmnNprEq/TiWiMJXQnk6ja6rRItK1FEkDM8zbESLdaGXo8o4NK6a/3R
 fUt6fOSFhg6GM5Lp7luqpr6wzxWPBVkkWuquCnCe5ct6wyX4sdD0gbzdpAisFjHh
 jDT7eTjUUUXgKqsLra8EA9Qe+BuSatCBzQxg/bjoAFIi3g==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyqcdswgw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:11:10 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-5ffa9d879e7so59630327137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773846670; x=1774451470;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zTaSBeSUZqyP55RQNCJYe+Q9ap51sInV9JJjR2VFl/U=;
 b=TgnpfUEBiUZBersDMTvyuz38xK1umDSR9ibgJK/MUW4iBkneKxEx1QE0lm/YwzmjBs
 wGwZ3HAHPrIV8sj8BC58E3daWHNOqS9tipVF9ZOzjXgrEIL5JAviz/8shHD5Nm99M9sF
 vGW3njAJrMghid7ijIGn1m5dQevcDPghu8eBWZXQ91QoTh5HLnOM6i7HsvaBB59wxg88
 z9husf9MLIw5sXcWGxK0j6KYNlNSoauMspTqDV0wJidvTpJi2eV3rDNVQ+Rk9lraC/FC
 300enLqE5ZLcOow2MYNU1tqt1TlJpoJWAWWBYuAV6PpzYxjxnMaTKqkh3JXh5De7MPqC
 ucdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773846670; x=1774451470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTaSBeSUZqyP55RQNCJYe+Q9ap51sInV9JJjR2VFl/U=;
 b=f2eFLCtfiF7lOy3bJPqvjjW9c8Nh2JlXL6+Sj7LDg+w2Xm8Hk8rVcNCy+3TvRMGsMk
 8ISmeFtzXpzAI0TK+lwdUdml98yjo/YHuQrbioMVu21GK5uOpd17N1cs4N3JI9+9Qsll
 SOLGwJ+jh5CGyjRSpjZf2fyPItZFrFT03mtxw1K6gmCLfd65cZt/nPzk+mG+LdzIOvcK
 YKKwocHvIJ4RVJzzl/N1dqKZadrqcWfl/0PhqpOvhUdF9TtsRtxT4NteY9Pz8C39L3U5
 R55sHUb8e3/u5O3t5Mv0/B/+UVIPuz2yexg5NhKfFxax3yi7fQlJy4fNwwNO4cc9I+9h
 zGsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWRb8WfQBZU/HufeYrF1kg3XoyuNe+BMsWwXO995RgTPSmv0kk8kBAbVMH+w5L9tQ+a9QgkocFivs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUHuEcVRK/W6a5FhMw5j27Dl7aCDVLAk0JekRwCguIBoxo/1dz
 ZAPiPzLEouIHeNhgcJR0O8fLw0mNLJqvO+ZQmLbY/4GYcMwdZzRTlVZaZr3ME+pK3mqsDGJYxdk
 uzwwhEpziSkojURuuYct6qUeq6uPhZzVOprhIymNdNiDvMIP81AcR9m1VWL+wLP3/H9tQcdw=
X-Gm-Gg: ATEYQzx09oYZPVKEwubv80PunG2t/wSKrG52qqZbMvgWsn4bVDKLr0hM+4QyZY3oF1t
 fUt7VfXmIXG/uoxNG216LE2v5x85uvPPGpOPgjETOv55s/c6yHcmHBK32rydsMun0NAEqS3Pdqf
 oWQk+lB4rxpcS9L4Widp9D0zHN/QVrYqNJn5fz5BcqoKyu3+qE7En42g5d3NxQIJ1WX35ikjPFi
 BUk/k1kdA/nJmHCR7TkCEkJaM+yPCKEL+XYNdq92X+2gF4voBCPE6v9NFExOZGFVSSn+H04vrBO
 FKGCWFf3aNS9De+LDOXWsXmgXE0uShLLSsYF6s6gkUzts0KqFBIKv9GehSDJbXXidbn3NMWjRkB
 c2Gc50JsJOVWSeRmC8+XsNs8dqr5H9YuqIcG3qXhUNtvhrYU3T8DTQ7P1EZt1jL1nd1226eh91M
 o/AkkDuaR34RJ9xf2+tU+8Mrv3NUcRDfwQHuY=
X-Received: by 2002:a05:6102:84d1:b0:602:9228:34a3 with SMTP id
 ada2fe7eead31-602922838d1mr307304137.0.1773846670239; 
 Wed, 18 Mar 2026 08:11:10 -0700 (PDT)
X-Received: by 2002:a05:6102:84d1:b0:602:9228:34a3 with SMTP id
 ada2fe7eead31-602922838d1mr307287137.0.1773846669635; 
 Wed, 18 Mar 2026 08:11:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a279c6e6e3sm590250e87.48.2026.03.18.08.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:11:08 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:11:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/3] drm/mipi-dsi: add RGB101010 pixel format
Message-ID: <5yunhfspibjyktb2qnjeoo4d67tbmwrbq44lopfjrtbqkw4gec@un7uckbss6ol>
References: <20260318-dsi-rgb101010-support-v1-0-6021eb79e796@pm.me>
 <20260318-dsi-rgb101010-support-v1-1-6021eb79e796@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dsi-rgb101010-support-v1-1-6021eb79e796@pm.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyOSBTYWx0ZWRfX+dTzAWlprj7n
 tUtL+Ss5VZrY6nlSQr/TDyOZ2z/Wy11u90VAXXfTKwgUdLfYvWkfxm0DvjW9lXfc1hXZOy18b52
 f6FgSTFaMe4To2s4qEZTTVsMvagiXLFr0ud9xpVqCTnLPbD4R7TeQuXYAUXHtJhvfMbBjOq7xif
 oymF2QNiovFp3Yk8Kwn+CytoOj14Emkp4A4ZtTG6rqheNWDw6ULTYpDtB3Kq0nyjgUlR8oG1G2i
 6pjXxBRt/QR+59l7kddmhvhdQemkxOfPvq/8bekWQLAnWyiEr1+8uftM/y87i8P0S8dK6R4ZnxN
 ydLU63k+/sR4EJ3oEFnGmpQPtKiIHY3mBpBUUxNgmvdAtO1MKR4FwO6Oq1Uph/vWDdGjp+ig/jp
 JeO/24dmrWn5wExdhB+7LSHi3u7YOVbKbiIusb9JZR0izEfFSTVq2TCnZrvC1sINOCDhWCswamU
 edIQcR+pxodUsPgXB4w==
X-Proofpoint-ORIG-GUID: VSvD4iqU6D-on8D3LS5AEhbYHpTJuInt
X-Authority-Analysis: v=2.4 cv=H87WAuYi c=1 sm=1 tr=0 ts=69bac08e cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=FuJAHOuw8bFYrA2LdQkA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: VSvD4iqU6D-on8D3LS5AEhbYHpTJuInt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180129
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

On Wed, Mar 18, 2026 at 09:41:00AM +0000, Alexander Koskovich wrote:
> Add MIPI_DSI_FMT_RGB101010 for 30 bit (10,10,10 RGB) pixel format,
> corresponding to the packed 30 bit pixel stream defined in MIPI DSI
> v1.3 Section 8.8.17.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  include/drm/drm_mipi_dsi.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
