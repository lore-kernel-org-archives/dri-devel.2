Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F36E937E0
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 01:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1827D10E2E3;
	Mon, 13 Apr 2026 01:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ndRG22yi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cGYQ+JMC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C39710E2E3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 01:05:45 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CMKRJI117582
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 01:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ExKPMn+q8c44eiqyy6tUy8A/
 JrhkyrK6RMgRaSkJYqA=; b=ndRG22yi2SpEqaMKrYVS0e9dd7MVHDZKwt0U+hrJ
 YoOXT+JvRHjKRltLijAWDHp8F92gPK4hERu/+kTY3YrRQN+5ufX0V4z8tRQ6FYPb
 bAK5UYRh92M9Y1tjo1e8CkmTJ7QvP/3pEE/goiUxN0QGJq+VsMH5vXImV8T2q9Rt
 JAY02TeKkYYA/mjDviDZ2aMtNHfrUHhiMDNV/C0Sh2D4h94V4CC8tCExCY25m1Um
 3fP6RTHKEN/LhLu4GlUiJoSODiA88IrIw9KtuSWFVnNu7kforvgm6FNIAupwH9u0
 stCrjczgEmz8Zi7WnrM+QDY3vOqyQy8JDhmfJEH/krNMHQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewku77s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 01:05:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b44f7b7bbso93864761cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 18:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776042344; x=1776647144;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ExKPMn+q8c44eiqyy6tUy8A/JrhkyrK6RMgRaSkJYqA=;
 b=cGYQ+JMCo7oHEG9UQA1JsLN3m1U6VkreZYeKMyyHF/9AAfHBmZIZaLvGVtJuhpCskp
 m1MJsPkwjtgAmOj1/Do2RtXZhI2zqzkJZGDSBmhybkEBkBOh5beUi6PTlp78Fj8hAdOU
 VZi70W1OSoKKWhGAnmiRKEKSC3wthQdPpPgEcU0ViVly0uQbvWOIb4xzViTgHV3WoOiq
 KPS7yWh29BUQ3orZbYceJVmJPePH0Wp1yuH5Fj0MsJthMmrRy7jL6LwmigF3txmTKDQb
 tOEkUoZMHDDBhmtgCLwDoSghsZA5Fi97C0GWiHb0jpJ7emfbGU1J7a7GCAvck48zjtkW
 6CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776042344; x=1776647144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExKPMn+q8c44eiqyy6tUy8A/JrhkyrK6RMgRaSkJYqA=;
 b=lcGDPM4wPIAEZ2HVfh/LPIWrm91QeFB84RNLQGYX0IYiuV5h1cHxXx3Hzr0uXjYQ82
 gDjvIMfvs9Q56NnkrtTtd7LFjceLx5iNEjzLlrXGpyKBI8s4WPJEdVh+8C/sJa0wt6yC
 ZKHaNgsSsl0QTgHqgcBd7/+s8RfIcsorj28GkxSullJfZCVIUVBdVWXmXPXWioqrLzay
 biH3+mFULQdqaX2vzEEw2Kx0aoUxZbcsYOA5o/M/X94d1BSl47a95udx+YGOFKb50bMV
 AP5xTRaA7y6lyqFonir0P26UvpAgwIk5GAJNfBj5ykS+aa5qHnYQjeJGAI3BOKvGK/I3
 W9yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT6aPO9qV3SK5hBLGHVZibpTRnaaA1IkJtlgQvNfIUYfDVDM8gKdjHNgzOmHbOa9HJHiB17mmLrR8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRLEh4tNRvlCArPoF8T5vJKa9owjFzj78/X9sgiPQYg+NNN63R
 SCW94YEeEQCLgDNl9DQGW4SPdMeRV/hMpnk9f3d9PuYucyHVNhaovjewpHGfjdUCHzj9m2ZYfH8
 hDvErn8SH5nTPErmL4D8hlcw5Tas565qZmwkMvcFIuz2Onlex2M/ybs8QbML781mRU2BV9Ys=
X-Gm-Gg: AeBDieuTL2sX6aTjsoNJOtoR+IF8aSqNDjMJfpjo2PpPMw02LRL64pqgYh6uNYAwKht
 TTntMxcPoNN31X8EELXl5EMN/B8wPQgxrtSBCDMXpCxrGMMcZ1qVEXVq/A5WLxcS03M2Or0LYYk
 GKQ21z8Jdg/4T5KZgzrmC2ZJIwPGXS/y5lS5sMu/ONzfYns1G50zAeUhMHae1glDhMzOXBDo4GS
 rVmcRHZ7eUq5n8L3i2V7GyY3zNzUbWUhupdHhcMbi14zYpsAo5t5hgtI1gG1h76Wekj7IMiz/Qi
 RZxTbUE0hUFnWeSPFlS5XmxPg86f/LSbDNpSOl4c14zjHPx5aIt96+1m6G+S5tRLXgD08UAdqOc
 szYcCbboAI3fwPBbfiU8CZWmC3enhn39Mqpaww2Wwd6cXXX+pZvy3AYOg8FPNnx3hMexc7bCVBm
 48RHrdvntPNRNYguwp6gZyZWdDqqJBiYGnjSI=
X-Received: by 2002:a05:622a:aa10:20b0:50d:85e4:baa3 with SMTP id
 d75a77b69052e-50dd5b7c794mr141156811cf.35.1776042343620; 
 Sun, 12 Apr 2026 18:05:43 -0700 (PDT)
X-Received: by 2002:a05:622a:aa10:20b0:50d:85e4:baa3 with SMTP id
 d75a77b69052e-50dd5b7c794mr141156581cf.35.1776042343166; 
 Sun, 12 Apr 2026 18:05:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eef00327sm2226085e87.73.2026.04.12.18.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 18:05:42 -0700 (PDT)
Date: Mon, 13 Apr 2026 04:05:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alicja Michalska <alicja.michalska@9elements.com>,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] drm: Introduce drm_panel_prepare_for_mode callback
Message-ID: <uckcm7zviwss3jdjrapzd2fpivpdkrdbpcgju2hmrayulfzeaf@2tnli5evjtuh>
References: <20260412113851.355944-1-val@packett.cool>
 <20260412113851.355944-2-val@packett.cool>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412113851.355944-2-val@packett.cool>
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69dc4168 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=TM553TlBOhhBRnBKVesA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDAwOCBTYWx0ZWRfX0eAsZaCsOkCo
 aDMFSfMmMMzBsjbvULf+1jMrji2ScGtTQ06gJd4HCShem8zmDoU6QH955ibWIM46mau8bCnu2xp
 AAOnJyHp/TEXN5fEr5nHbTbL1I1SK2Sgv49QeYzIBVcvAzz3xtEcBElJSCd0r1O9Egp8LIAtVYY
 vku21Jn+6DTTOWVbSyASTxVCt5TGlzONY8TyIt4rLhFXyrXFWAeMsCRbiqkW/oOAItZ8PecxSDu
 Ty1W+u7+VkpPZtGJjOvJ0YbeBXErlUugfEb39AEBjO68ZATBS887t466NdXshAfOYPjlAOZoT8u
 uI62imH7hYvp58F6aoOjG+XTjb8tyzW+vHmlNVKXpp3mFd0QAbuh0gQ4XOGCFJY52E4Hp5JqDQ1
 uSKTpVKoDcQmD++D/rhW/RZ3dQlOhMGfjRo9L38gmvwlR1mUtl/fDXgVRSWQVr1x7ACUjkIsE5d
 bbCqFdp/7s2F7G79RDg==
X-Proofpoint-ORIG-GUID: YD-TCZVJhd3zYBth5i8H_t0GDhRcE5KY
X-Proofpoint-GUID: YD-TCZVJhd3zYBth5i8H_t0GDhRcE5KY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_06,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130008
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

On Sun, Apr 12, 2026 at 08:00:44AM -0300, Val Packett wrote:
> Modern OLED panels often need to vary their prepare commands based on the
> mode being set (resolution and refresh rate). Introduce a new variant of
> the drm_panel_prepare callback that passes the chosen mode as an argument
> to allow for this.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  drivers/gpu/drm/bridge/panel.c |  8 ++++++--
>  drivers/gpu/drm/drm_panel.c    | 15 +++++++++++++--
>  include/drm/drm_panel.h        | 12 ++++++++++++
>  3 files changed, 31 insertions(+), 4 deletions(-)
> 

A (somewhat) better approach would be to let add .atomic_foo callbacks,
which would receive drm_atomic_state instance. See  the discussion
around [1].

[1] https://lore.kernel.org/dri-devel/nfc6ih43gjpi5u67fpkkxgwwygv53grdldq7tfp5iiukrkiy2u@53fsrtezzkyt/

-- 
With best wishes
Dmitry
