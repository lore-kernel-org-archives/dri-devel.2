Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65170F3D5FC
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 10:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB3210E431;
	Sun, 29 Mar 2026 10:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9S8b4Pq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HAcOMpYH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CF210E431
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 10:05:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62T4ktkk3152749
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 10:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JaiqO1qH1s6Lg7602BQN0CxF
 8FKSe/qUocsXjuCSObg=; b=l9S8b4PqvOFQrX/E7BnEIuqqHeaY7rle1VyRjVzz
 0wTVMOj05Gy/uwdx6o3CEzM8DWeisasE/GRkfUGySj4dHUM7D0/a0tqMQFjwfR5p
 KRcJNK3NXlcgKlCmKs8WEjcfw9JwtJfK1hvhoiW4b9M61LGclJj4mvWZUUwY0i2e
 an1jpXEqh8h1PQWT68rDuiBNgocdiEukL2aYskBrORCO3N0Jw4s4/EIGadbw/g7m
 MNPcxFGRV1SEW7DYKOpCyyy3ZWxoxRTb6hy5l6VmdkpDy47FFkLPf4erPENYnAA3
 jXgY68BBbHlQ6yRdcvov/hBNPX1Jqd/OZ9l6lTtaxg5SqQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d64bm2vyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 10:05:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5091327215dso38613841cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774778729; x=1775383529;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JaiqO1qH1s6Lg7602BQN0CxF8FKSe/qUocsXjuCSObg=;
 b=HAcOMpYHye/am9V3w/3Nie15LJHbN8z8VCOg5x89yBtXna9LJyNnhUuhlg5ynzs9fS
 84HOP7mMDHFAl4aeakVa0QwYPC0DsSJFsLdOYT7WgV9xGqXx1LjVvAOJZDB+0l/eU5WW
 GAYJHppJtRP9Xv/GxVfaYlvAjCS01vexm6HIwy1rtsX/76Px5E8BV9p2fd5zDXuYpAcc
 9tu8hkZuF+Fm74orz8NI0LJxksvs6V4ZwKy5ILQhYU3f/wG6/+U+bS7o+QpFYn7Ay44w
 hRxADPzVjqbMHubRnSolGelGYnV3Mde9wrxgcqRTt8sOpiZKaWQEYtO07hyAKGzM9fzx
 uN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774778729; x=1775383529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JaiqO1qH1s6Lg7602BQN0CxF8FKSe/qUocsXjuCSObg=;
 b=LB5rCyVFtiw7ZKzoq+RBxfF/zWD6P845jFmoyJxOD0Z61DW/9A0KKmLwPFZHY0qAV7
 caO8n7lqgAdsRKBaJu7z7kl7qK0FQywI1X+2vAU8080IlEqkUt4uV7YV4c0MAIPBlw7h
 Ox+hb3qdbo/J/rJNdTCMDAUor2xJIyRtsjVSbIOys6SJyH/8gIqtvH25GLxvFqJlkUhN
 vyhuocoNZJoMXskg4iIvl0XCnY7z/Kk8JM2lNuQz9Ix0bdiNHqr96+VqJu0vWVY3yGRo
 SJkFTQhfWqvEVkT9TajLYuKBtaB4h4VyRmG+BOT0C9+r7HK/N71R0VcX4ygHORvFJHWC
 FPuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9l7PCF43IrWPdyXiSYylhdFoO/YQnKFS9GIPNjtY2g4AffqRmK6Bgc6u/sWdJXRNOxJpe3SXO4Uo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYbGIE2U6bVMazYvkBa20ZwL10b2+H2fyHH1TGOHr7dDdgp1Fk
 Ti+I67M9gMm/3mjJIoMXBC7jtLtuaGNJZ6rMgWq7j5MNPvOKx4GsTFAOvvogxmhbT+nHY5kBwtM
 SJXIGaCWqdDe+xrV8UNlzXgHMiTRJSZ0wuwTMG6Y1qFQoHlWpjRRuKlKvqOIZrwPi5dUdVko=
X-Gm-Gg: ATEYQzwWVg5+DsymaEk1OhQsySdMmjrhUV/52jMUj5V/24txY1zx3DHHVfTbB0/hLtp
 iqyN8g5Nq7rl0Br1ZUxEJkf+t/1jqtOil7JYGDxHhm+tmqhXSCz/e2W1OCN3F6H8vkLsxPxD78U
 c5I1mg8nDYp3zwsu5b4Vvf7LRIxM4zeiSHjrtFK0XpeDOY/JJ21KX4Zp4jdxNAnAE4f4G8PL4Y4
 eP1RQl39a0THUt0yasgbYNZwkqIDSrbH0UhrAITZjVdGf/NrSNxX6aYA3UcNrVHBQioNlK3q1Oq
 Y3OIGZmQ5Lhxnqy5eqD6V4Z9Y3lxMW+vLgbxM0OW1vecwIya3iAmSlnjBmvxo6uFDewq3GB41ly
 M7BNuIhRETsObmAb0LCpY245SC1ZEdVpNkizEyxOGWhnq48rQGqmuJstm8/u7FiceZDr8PUjaTV
 tqiqVLKKS2iH34ApCmyip1mwyTVlF+CGOJcog=
X-Received: by 2002:a05:622a:8:b0:509:2f5f:a178 with SMTP id
 d75a77b69052e-50ba3836481mr121712661cf.21.1774778729069; 
 Sun, 29 Mar 2026 03:05:29 -0700 (PDT)
X-Received: by 2002:a05:622a:8:b0:509:2f5f:a178 with SMTP id
 d75a77b69052e-50ba3836481mr121712401cf.21.1774778728557; 
 Sun, 29 Mar 2026 03:05:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c8373096esm8697771fa.15.2026.03.29.03.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 03:05:27 -0700 (PDT)
Date: Sun, 29 Mar 2026 13:05:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci@protonmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] drm/panel: Add driver for Novatek NT35532
Message-ID: <3qsp7fawh3wtvpvb7zvupfjpio4dhg7po56gudrttb2jcatqz2@gqhdobwalhlg>
References: <20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com>
 <20260327-rimob-new-features-v4-2-06edff9c4509@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-rimob-new-features-v4-2-06edff9c4509@protonmail.com>
X-Proofpoint-ORIG-GUID: 4Mp2onXQES6s8kFPT_ckoeDRaw79Fmxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA3NyBTYWx0ZWRfX1AOOGPWtih5G
 2xHSYdQxiHmsNoVNGxCTd2pYGa1kN6Y4q7uyWUVn0XL9NjnmX+9fvGXnRTby266Q2x7eb24CTIB
 KMP0zkgLoLVVUqye2fnF5qSdaM4JOB0Uf86BzCbrwNe1YHeYorxy9TYQ8EEUNOSWo+Ryk4q/vnp
 iOagfJE+jSYOJ25ikD8Lsmj4VrawBD4u7GKAnZwKG7J7PoY1uu3wuOAdH/1NOWoBmQwD/bwuYYT
 NvrKjY4ISszZrfHBPmMhR52JBo04WsPNS192czlJeHmigi6DmEv9jAP7MxxIe2uUNgRG4QeSt6Y
 WLMiGBuFppRmI1N5MmEaYXK9HL47lPOl9fCSgQ/+Ot62eJ3Y2kpqvKH69+BaUVVBCWhOTV9xva1
 1hEy3jQ/J8MkkUAOjccHXfDqhjroM3tTOrvvXbvKWbWugR7VqC5Mkg9Dbz+rr4oogS21tIR8IsH
 I0mM/OIb1kPYwQuyZDA==
X-Authority-Analysis: v=2.4 cv=eJAeTXp1 c=1 sm=1 tr=0 ts=69c8f969 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=sfOm8-O8AAAA:8
 a=EUspDBNiAAAA:8 a=f_kZLxWr8KFBRA8n9fgA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: 4Mp2onXQES6s8kFPT_ckoeDRaw79Fmxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603290077
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

On Fri, Mar 27, 2026 at 03:30:48PM +0100, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> Add support for Novatek NT35532-based 1080p video mode DSI panel.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---
>  MAINTAINERS                                   |   1 +
>  drivers/gpu/drm/panel/Kconfig                 |  10 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-novatek-nt35532.c | 796 ++++++++++++++++++++++++++
>  4 files changed, 808 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
