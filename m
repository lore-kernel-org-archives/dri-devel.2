Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EC5CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BC910F078;
	Mon, 12 Oct 2026 12:33:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D4A10EF66
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:33:47 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0PGF2088511
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Bs2Jgzs7Tv+fLgxyw08H5RN1
 Ifr7kpK1dx9qY8mqF68=; b=lDMJcHN/OPzq1UlDCuCQ65E5z1RzyVIhBJCOh8QD
 AcYZMy5DsN7x6i0KGs2sryjcj3yWICTOYdljhsJZCHp5YNeHtNSrT1tC+Gh1QzoV
 avhztiEp2vcnh/FO8yDSAhCIK+mEKcD4BL79euU3FtK9eiE2JKGYcPw0HG5IUeFZ
 4507/+Uu3ClC+MovwFh7WB7arRHwVkk4y9zKPx01QYnbP3irlWzExK2sF6RK8RCQ
 cOhBWh4JVbPaxFCquDxV7wld/w/BRw3IEJOSwP/JLhUj0ZUgy0b/03/DnOnyTx1M
 NS0NaNSPm9B3kSNnbafdBJtd2Hh02DPZE4z/OYgKnhj96Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu1we5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:33:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5ab5c136so317626285a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791808426; x=1792413226;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bs2Jgzs7Tv+fLgxyw08H5RN1Ifr7kpK1dx9qY8mqF68=;
 b=G2R/j+uTfvzg3jfXppeEVHGWo+zWky4s5SxcsT3WjCXKIb5J8PoQ7Apb2N9NNgV8s1
 qzEfeyk7FLrjvSktMzLuoIid4650IfkrXKD1VDvRYrglMmgpNrqgwNM5nxTd4mYMavtv
 TfvZzp2pe6Wd7oJI2DXSO0bDhWENRvH203eYzuQFukoeFcOCLak/tmJq/nFFEB1saY7I
 TQIs9/fSdu/AF/wcKZ1N1v4F9g8K2jQ458eQ0lmZbXiTKU3ozBh2OtJjmsG41FZMD0YA
 FecgLpY5NZ2AgafZVdP13K0dgA/D/h+zbDGPRZXvjuSw6Vx3gqYglPVC4/OJ3H2qSJjt
 D3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791808426; x=1792413226;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bs2Jgzs7Tv+fLgxyw08H5RN1Ifr7kpK1dx9qY8mqF68=;
 b=eJ5VjNQdijJZi0xaZCmbOnERxxqdNFXy4ar0oq7Ez7HDA0AAOeSUz1cEExwLlu8Osz
 nbTERzjbt2mpmMPDaury6TkBFDYbI1mtbLpubgeJzdpM9xhgezF31Y/WdjVql57g4UaJ
 9v9ROsSNODsm2lV9gkYfqIukO1Tl/Kncoy3gkr98J/xBXYIXy5A+LpvNoiURupZ6BXhf
 X7jFewvrjszN90u8NXkKQ3XCnvM7lX7X1d046yqUKy3UraQsamgshTC2GH2Uo9KqdWdd
 Q5f6wTHN9BN8A/zsgbkgWQJ47iY51Ij76kYlf0R6VyRJ7p9dWgUEXYmCR0TWRWyfZQi0
 6zjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7PBtMRh+R5POWvgDCEsR4vF1tOhNOdfab8yC7MohkzRpH05GZt+9znKBlZpCCvNEe79p0WU4cw20=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKehId2+GiYto4aoRJSvay2kI2NtVJI+UhVmdS3qaStj4WoVW2t
 9iKSCm+CMOP0F+vW63Ij4Yxm7q5YYJaKYKW85eFDC3+J+g9qP/mxaBES0JC7T9tWrdjVuD5l2Pb
 L2k+MiYfNAzctM0CcxwhAJmcp2qkJqyy253TKwbpvk5NFe6/E6snVWSTxO9CrHYPOsA4LUN4=
X-Gm-Gg: AYBFou2117Vjx+b2ASeFeZ5Mz5NNHE99+BgGtYCZ5dQCox+ygSA6TvYeMUUcR7JB9hU
 CsEK3IdVzbqGeI3lk7lFFo6pYvD5yaupUeLO+9O5mcLWyy22wQM2Gzhsjtmttrgx1ul/gdp2vIo
 WbcpAvLy+ZuSx7h+6zKF1dHyx1ovEEJ3juXtIefDvbzPytHd44g9f5nzHuE7QEIPOcNi+shQxv6
 cHtEQEQoAfd1fh9UKcr2Z8wIe73N5k8vt3/o80qCivylqR7O9du6pa1oqLHiqTaKLm22jIRiWRf
 03rf3PbtJUmEh6Ci5OR925oLRp75R2lUEBTXgU9I1xQy4wuwMojbiZCYH0WkSMo0L0+h4bKc/0V
 LjTBxa5v/oVs6OqixwwbQp5NS7B6I4XuRSztEt8q5dlsAxF4t4vTiJnv7Whit68EXPtH0aKunXs
 Fl477/UvrgvCqp
X-Received: by 2002:a05:620a:6493:b0:93e:c12c:f12e with SMTP id
 af79cd13be357-93ec12d0591mr1359662885a.73.1791808425734; 
 Mon, 12 Oct 2026 05:33:45 -0700 (PDT)
X-Received: by 2002:a05:620a:6493:b0:93e:c12c:f12e with SMTP id
 af79cd13be357-93ec12d0591mr1359651885a.73.1791808424602; 
 Mon, 12 Oct 2026 05:33:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddea81c7sm2819066e87.49.2026.10.12.05.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:33:43 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:33:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dragon@radxa.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/20] drm/atomic: Handle max bpc properties before
 connector state allocation
Message-ID: <mkkc7pbeh3aiyhhnbkis7owqvvpt55lyminlcnu5gun6s76vit@5pmsxkrdey4f>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-1-1835d4966da3@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-msm-dp-hdr10-v2-1-1835d4966da3@radxa.com>
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6accd3aa cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=ksxQWNrZAAAA:8
 a=uu4xuC75hOI6q6cYBXkA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX3hMOU3tRhunZ
 ZpC67hRsE6wx4w29Q2VzwTiRTZZzaJM1PQEwb7xhfREojDsPcoBxsOFwhSwqaua+eyf3/5FJgMU
 SL+LoSNpdnEay1tC86JKwusbZhOS2SgbT0nrphHaGzOVlNrcchVUZBWuvZZE6qr7Gv2OoyPUBxW
 WRIzunpgmry3ata3DxhYJNQ9kHNTgxEh6r9x6XCUJXyGuEECmZjKGzorj80U16TmbESS3WNtBti
 IASFVjFLfjvxqqkk2UXa8I8uBFRUg1PTwT0U3ZRrFFFDsLB3xWy9MfblTKYo8xu7ib6F4G+vrVH
 2vkshNESMXsvHFj/eyOQiFlFJpgW7B2SgwKL78qWn7SjHiMbyU5H81sypOs5JO6Y9VeNOXsW2H7
 AwaMpA1Fec/hm9JEHS0+73y6vjWFDIE/jr1eQDGB5VUWDzOp9auf/skpi1Z/1fjTQQN/NUgwN8m
 IOOiRrbt56OFWamcw5A==
X-Proofpoint-ORIG-GUID: u43MiGBgWj9M_2uGx-zuW_6x1f9Ujtw9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfXy/CjZVXky9P5
 MZf3Djklbz8R5L9lDeaFBVn++bxDPk3fSSXb4DG6ra8O3Gve7+Q3vcWhWmmz8kGF2qxdTvOpCJp
 AggsHgIYU+zk2B9KRVLbzH1eiIHk3AI=
X-Proofpoint-GUID: u43MiGBgWj9M_2uGx-zuW_6x1f9Ujtw9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120049
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

On Fri, Oct 09, 2026 at 11:15:53AM +0800, Xilin Wu wrote:
> Allow drivers to attach the max bpc property before allocating connector
> state, as needed by the upcoming non-HDMI bridge connector support.
> Only update the current state when one exists.
> 
> Initialize max_requested_bpc and max_bpc from the attached property default
> when creating connector state. Use drm_object_property_get_default_value()
> rather than the range maximum so that state creation and subsequent resets
> restore the value chosen when attaching the property.
> 
> Cover deferred allocation, existing state and restoration of a default
> that differs from the range maximum in the connector KUnit tests.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c  |  8 +++++
>  drivers/gpu/drm/drm_connector.c            |  6 ++--
>  drivers/gpu/drm/tests/drm_connector_test.c | 53 ++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 2 deletions(-)
> 

I'd very much prefer if instead non-HDMI bridge chains followed the HDMI
approach, making the state available.

-- 
With best wishes
Dmitry
