Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3D6D3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03D410EE3F;
	Wed,  1 Apr 2026 07:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IEYcjqyU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cihQxL0o";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB3C10EE3F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:26:59 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63167G28639472
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OrsSeXDgflueFJTKbryvDrNrj0ECLTEOv9jGD5jIVFo=; b=IEYcjqyUP0UQxGwA
 Z6eTHdZQCkC0M4R+Nr3UYGtd/RwFFgVoRKq3KW8ZmwE5LqanPkuMMk6ezagYt7k1
 UUDce9ahN3n9SC4q4Tm/Y2gtbAv3VIc0HKM5eNFmGLCUTr8Iswi6Tc59VBI6iQGp
 GLZuKqh5/fwdkq8myJXyj19G1oVoRn1NnPCHXCDJlxEixTWZeB/NZImrkEpm1+xH
 ke6kWVWhPPn2HquEasM90JbfqauQMVEF12TAMOAdn94uDeQFtn6qtIrsKWCKNdeT
 dC5HTsV3aCF9KhvXD+XFT/i5YNVHKZOPBfyNuZHQxn6ApiGBfyPZc/aM2fziGG7h
 GLExnA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8g2auxe0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:26:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b34223670so95437671cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028418; x=1775633218;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OrsSeXDgflueFJTKbryvDrNrj0ECLTEOv9jGD5jIVFo=;
 b=cihQxL0o7Huj3ELGaQBIlVv5WM0jiTkmsvRqnFVHOqTRrQDw8gRD2MmGhgx7BT++QP
 sfzU0Nj7ytdY0ZgvxL21Ntycb3aITBVkEYjRyhs6KLx9FQyJsShIOErStvmX/F/t6lmO
 dFotoDk+t42ssL1ey5OdM1sFHUvvLyxj7WPPXEGPXcXhXhl6wBvD+pJDDPS1fSPkcQe6
 g0SpVZhVNxzsJWpfJ3EnZ/vKBpQbolY2lq+6o9YO23PrG5FJ6LaY569or8aF+PsgUe8C
 ItF3pbltydmUcG5pmXSHXNnZgLp+QWUZpPDlSc6TeT1gG5I3pKjpBf1slyVFOW3eFxtU
 ZIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028418; x=1775633218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OrsSeXDgflueFJTKbryvDrNrj0ECLTEOv9jGD5jIVFo=;
 b=IRC5gYFkTgCJ0hC5Dfw0hPXZZ7KUrxymTRED9rzpdfpJRsQqDk7x09/dJ6CIteZRYG
 kaSgFsmowTXxZBHQ7SihpPag55uaikgiqeacQwXyP3og0ZescuVQx13vtiLMsPLm2GTX
 uam2RwNkjN13V8OWd6/eh8wS6TS/UPxVYTpbeLuC9aTMsQCUEuJeduQyCieoubTfM9fL
 FiL2W4AHoampwCQtGA6nQwMWbutv1DP4GpPd8DJ0oTubAIrLxvC1JMoFj65Up1GOjl7Y
 eCzCDTT9fy996sCLgnqIbRDtCvD2YOQMvlZuYRgBsWwCHOIoc8giOjhkLzm7Bob+uAp8
 fDZQ==
X-Gm-Message-State: AOJu0YyU23RbjLO4t2IVbn7HkLWtj9uRCh3Fb1iAGvSG8Q5cxA1hU6zr
 XyzRkXPSfq2JMtVHXwZf9+FovmJCalwUy3mozGMLoFo4tLM5n6TQuPSGiOZahu0Uvg1O2hTvlqm
 VYDT+v9OJM+c6DxJ1U9DhlRi3YgSH5jJjSv3W3LEJNHdunsHvko80owiwaHjG51sRmKdpm8PeIQ
 oIfRw=
X-Gm-Gg: ATEYQzxcv4Bli3pBNeJhqE0fGPjPbYgD7L7947K59PPBynqaaVnbDbhaOOggbjIzd7i
 lJyYzUHafsxlkqKgdlgmoRiuS6vssbba6YciRUgadM6UwcCGtrT1ISk2bIwjj1Xlw55iPYgW/Zw
 +/bHgME2mRGLLnV+1o07rB+qAmm4Qfx4fOMKxmTp30DRulNPUCX3N8qxFZUyfJPbpGcUSCXTEcr
 X392RmPh8Up3bDUQucUnpdjwj/WU9MQg5o+b6gVvrI0nlqqMMclgzLqjekF5/yc9aW5LT0M0Ohn
 Fx+x1ATnMYEG27o5SL+fqOZRKYwrPMmXSfS5+FBRuwyb9GyHQHTpREbJCmi26T/f3vtQ9TaKr9i
 EmnGjU1PTS9nAywgrqRw79K039XXt2W5aF2Yt0/JPP3iVScNZx7y/LX5K+E5EicnG7yZEJ0Ytu+
 a6TIvqg2AWSfrbMlKvaJIKKMny/HOi8g8Q5Ec=
X-Received: by 2002:a05:622a:5448:b0:506:6caf:3cab with SMTP id
 d75a77b69052e-50d3bc0a9e8mr37476891cf.26.1775028417632; 
 Wed, 01 Apr 2026 00:26:57 -0700 (PDT)
X-Received: by 2002:a05:622a:5448:b0:506:6caf:3cab with SMTP id
 d75a77b69052e-50d3bc0a9e8mr37476651cf.26.1775028417263; 
 Wed, 01 Apr 2026 00:26:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:26:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:27 +0300
Subject: [PATCH 08/19] drm/panel: himax-hx8394: set prepare_prev_first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-8-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=929;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ICRBrnQij3AHdlL1aBsp8l8GKgsmUylWuvxjYCl0Jww=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMisLWXFY6GGXVfAmBGZzwLhMyy/wiVS8/GGS
 nXgHm7+YeiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIrAAKCRCLPIo+Aiko
 1fa5B/4rA2razUl1EdKZVnBd1wxc26tJ4GQzJOG182PKBt6opAY/YjmYxnMi0rVWhK8EhFW3ZGa
 z/8BC/+RpXTsXxC7wQ5nM1kzZtzCkDX7xt8ySloFRcZ8iijpwg+K+QrNzk8oYDFuq80xgG/I3wL
 TICqFlNA8yC4I8cO4Fi8NK+pAKSGxYkdN3ctiBIWLYuPqaZXEF3bFAnvkQT7BLBVxPrSuZ8m8dN
 BHAkPNJJp0rLagT4+4dHo6nDuP0sm5m2FGnu0uqaT0IpeRXnJsY00MQSZBtddkeFK3Yi5P9TbdP
 dmCkbF5OeIMrwcMX/zeVXQuGThvrp7TPXiZwuCjPAQqErfNH
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfX1B906NRhJnVO
 wZTgeK2IrdryzjKQO6cUje6yB6BIIk4AED7m9Wk1gibYKWbN05Q25R5HHOLU+WRjStn/e3CUP9O
 FE80G2HdYQwLA7bRZj7Ry0aEBQAgDoebQztbsrD7mov+8LAvvnweLTuC8dn26uHVnECdkxfoX7B
 IpNVoSPV6DJz4Le+3AQZdx/M847d9nP/5Pw0aSOp6DJGGMvMiPWzKuuvGbQcShcgGbGvKsdFYPq
 rawXT7sZbKIbv65CAS8sURZaKaARF1GEatAeiCRm1MmVozBk/ft1sSrYsp6JFappIYblYvoa0ig
 S5BTh927R4ciRBCz7jNE/NJGbH6QAgBR2iFRaiWl9mA/DZfb8s+Q3EeHe+aZbt0uAvC5Xbms81n
 J8fk6RsGdCVwXwLxDp2UFbwseB6i7u73zwBFMg0qc764C9SNFvRRcSZqnS96Zst2mBB6bE7tELv
 Ba+twcRV+5iOu5bN/sQ==
X-Authority-Analysis: v=2.4 cv=G4ER0tk5 c=1 sm=1 tr=0 ts=69ccc8c2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=cd2vOsepvhAVWqutC0UA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ASMEHtdBdjODwMT_0G8GeZ4s-28gFAbX
X-Proofpoint-ORIG-GUID: ASMEHtdBdjODwMT_0G8GeZ4s-28gFAbX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010064
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

Sending DSI commands from the prepare() callback requires DSI link to be
up at that point. For DSI hosts is guaranteed only if the panel driver
sets the .prepare_prev_first flag. Set it to let these panels work with
the DSI hosts which don't power on the link in their .mode_set callback.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index c4d3e09a228d..d64f3521eb15 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -792,6 +792,8 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
+	ctx->panel.prepare_prev_first = true;
+
 	drm_panel_add(&ctx->panel);
 
 	ret = mipi_dsi_attach(dsi);

-- 
2.47.3

