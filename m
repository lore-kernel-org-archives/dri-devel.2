Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806F4C982DA
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A3110E182;
	Sun, 20 Sep 2026 15:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bEPQODQd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmVH69VT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B0E10E182
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:01:36 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68KBoJ7X2762089
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=cFBw/9MveNooP76MRdC5+S
 4XLI9vlDs3jbwQiSM5tkM=; b=bEPQODQdVajwiKS7seZzZCY40NdK/hsGB8CCKY
 tfxlNyICqlYzvW+IeKuuNl2mqUw3jYhqMKW2Y9pZaE2SL6DYJT4KXDPpkDjLXdSp
 fH9j4kaj0/VBkpeQMa3CPinKZludEQs463RZuqlLCtLhBp2VXssCTk31aOamy08p
 g1Qdy7WcUkuVQ87mRpeJwrXCA1lpVf9IKgHBiInqtdgaBdeUODG+A1MJafHybP+q
 lAfvq/c8pzf3BelrfId9PquV4ApQCXfsbhrtODTE5fH+3+m4n4jwZTVV0Pv/Jv+R
 KOHbORGCx9al2dTYZOcqkL4Md9XW+4CMRjI/5662ZtldxXwA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshd63b27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:01:35 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7847917c402so2157016137.2
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789916495; x=1790521295;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cFBw/9MveNooP76MRdC5+S4XLI9vlDs3jbwQiSM5tkM=;
 b=ZmVH69VTU+fnB8mM0EqBsLklx8UTw9/Lc2E9oYQp1LR5+68ayE+GKSzRK39OY1GaiT
 qHqkQA95GWym7uc5O6jJ/Y8V+dw/lTUf0pEugwVSPW9O3GQYnePT/jdPzF7zE255DSmV
 3zU90uXUlP3LDptIQvxvxQ5kIQE5vkdFqa9mH6qLa2zEs6593TVyypk0wJwWrdUIpDwg
 cEyyBhNMBwt8RDCoEj+NCbDZiVb3zAjxgVr/wTPGuqEehNqCo8vTZfJYcEo00gXO+uz/
 efQidBl6JoQixSA47XxGq6z4fbH0fZH73x8Hb9boJuVsVVOfWG07DAacL2a7C9v7KuMQ
 sRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789916495; x=1790521295;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cFBw/9MveNooP76MRdC5+S4XLI9vlDs3jbwQiSM5tkM=;
 b=fg/RodYOtUNjnj2p0RYLSzfIymB2fWwOuV2X6bvGKGCCEvhT+2lSmAh2WGcDulHlnb
 7jkrjalq/CgXwLDQLvd+eMEsFeCUF4vuTDLO0qpxQNlnlGWI8gtly2F/gew/+dofUber
 JO2n85gDPrgnmZfmwgv1F4DVN5Hf3F5hTToV6aBusZfAR1m1El7jzD3/gVsOoC4gpu3Y
 4wClawHZWPdGfIIFBYvF/bHIbr8uHNzrSRJfvBlbULEUTDIRPwpj1ZBg66QTmBfoMa5v
 AB27yue1416Tt2McbskbVu+TeHWZknlOgl3GWy+h3X1GmDUQ6nlC6W86QJqFS1nlmU1k
 vAEQ==
X-Gm-Message-State: AFuF++msN6bm8MLLem4bLytBhn4LvrhSqNtuoC3qmUxXWLjTkyPTSrZH
 WlDljw6sWzswybrGJVjF/9WM9GdtG8ymDEVagAAIHIU/eNRXsK0v3qwkEHBDfU8nqpk7U38f/SE
 9bkZUdMCKuIYZeqK32up1kqXnvNoKg6aaNV/yLthMWx4CK+ZISq9Qpt4NVEvJun7yqo89uAc=
X-Gm-Gg: AYBFou1btNLM9u+SsU0i0+tsLgc+Crwlq7M7GYqe/UGfwY8MNZxeSRFeG0anSIQ3tb7
 TLryd6OntHUk/vZMhk2hK3I2RBKxVZUYRNsdYsRTR0NS6m4OHIQELDxWhUn8hTdJya3yBI94Pcp
 alp2z4RozJEU8g0LtUIQpD8IjmzTfHpsLd587Jzf6NS3ZmOZYiBycMJI9XHgD97xO+YtptG7LfS
 fBu1SAvbLxui7qhM/q8y7i8M2cycUb2WDtJRKQV0a8xsi3e4IwNr0NM9dFhrSeh8EQrO7uuwY2P
 IPPqRKbEoFaSyUJnPDBb+2UVp3j5LfQSrwd4v5J/QlI2qlKfDMF7Lbmn+dkYDvsbPG9Jef+f/Uv
 OmqPWUSeZmcim1d3M5xjY1xQWWzMaUo/SRA/vCbLyJkaFSP0C/UVKXFRH6/oEs/8bAoP2JW5SQP
 CbbQ45Kqzj4dI+
X-Received: by 2002:a05:6102:41aa:b0:7a7:19aa:8a83 with SMTP id
 ada2fe7eead31-7a719aa90ccmr1489170137.30.1789916493909; 
 Sun, 20 Sep 2026 08:01:33 -0700 (PDT)
X-Received: by 2002:a05:6102:41aa:b0:7a7:19aa:8a83 with SMTP id
 ada2fe7eead31-7a719aa90ccmr1488929137.30.1789916492529; 
 Sun, 20 Sep 2026 08:01:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a6163d7119sm4090061fa.30.2026.09.20.08.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 08:01:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 0/8] drm: handle IRQ_HPD events correctly
Date: Sun, 20 Sep 2026 18:01:25 +0300
Message-Id: <20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEX1r2oC/3XOwW7CMAwG4FdBORPkOGkKO+09EIcmddYgaCEpE
 Qj13ZcwTUMrXCz90u/PvrNIwVNkH4s7C5R89EOfQ7VcMNs1/Rdx3+bMEFCDEop3p5b7cOaUqB8
 jpxqNhVo3lRMsL50COX99gNvdT44Xsyc7FqU0Oh/HIdweF5MovV9c/8eT4MBFY4QT1hk0+DnEu
 DpfmoMdjsdVHqzcSPikIMwUzIoCdI6wpg1t3ijyWREzRRZFtWicgtbZd7+oP0XDeqaorEgwGo2
 UlVrXL5Rpmr4BRq0de5cBAAA=
X-Change-ID: 20260414-hpd-irq-events-e72bc076a5f1
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Francesco Dolcini <francesco@dolcini.it>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5586;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=T1aSMkDvUg9F4iAHgfR3ruSI6UlGC1w9a/0Vrd6WDtY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqr/VHrDBA6z2QkqCb4MlukXsy8f/Bwm2WbvbLS
 PGY3/CGZ3+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaq/1RwAKCRCLPIo+Aiko
 1bS6CACQo4YyOra9XHAUD9XHzteIJFP/nsaDjZ+koYADIdi0trNeItVnSKMahos3SM31s4f1c/q
 ceNCJ52X48MeITEomzforKgCxg0XK1ezaqRv6uG1aVV77k/9sF4E5Natyst5gWP5cOJTIFC/1Jp
 nHPhYixemqLOxMTjpoE5GtQe7ywIdmSpK/Xs/DV6vJHJEzuZ7mpIxx8qEsaAcsMgOJBF/5TWfC/
 kknru+qOu3skUf6igt4HV4diKuE7eR/iwW68hXcGO8SUV6XHphEWDwPdF+VX9tBvfOu+/pMxn1j
 TWEE2AtnruYKINyRc1QKY8wT/gDFZgCK8OkhhuEcReyWAO5m
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIxOSBTYWx0ZWRfX1CSGXQPQt8sh
 h0RKCDn0EqeKsjm2WcrJGr2QDkkdXP17rVeNHIH5l+NkAINjFm58zuGwzdVo712RIh6FuyJLuGh
 ihmVTGsrgqKR5f8HBLeWX/HreZ8h+PrrXHGjuVqDzlxvH3yXpjGM7mac/ipEAyQqJCW6lWE0Z/5
 qu2FGB3NNpo9/c50q29lC7xyYk570MMG5BXhqiRZyvmBK9x4obfWTRyl1ssS5AoZQvCSVI3HN9C
 Jh5A+DGd82YyCdsecbkT8DIWI4iEi/nLwoWsPbueCrqRCSGW6HT9RMbyOEZAPu8QPxqaeHtURsX
 0e6yjtWL0Tfrgk0y0uXfiuaudOanMTgc48D6h4sSB6a0PH+WSaN2xgyaTy4oLk4ZkzewQRUQUTu
 /pULnQK67ylV+6D1V5TD0VoBHg30rgM7ufAus9f8grdh+21jFdRTWOBV+mjloLyAkJMWKmARDnJ
 aLpgB6SF/tXyvUFmIYA==
X-Authority-Analysis: v=2.4 cv=RMQmjIi+ c=1 sm=1 tr=0 ts=6aaff54f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=ag1SF4gXAAAA:8 a=KKAkSRfTAAAA:8 a=P1BnusSwAAAA:8 a=P-IC7800AAAA:8
 a=GFqr32JmAAAA:8 a=IpJZQVW2AAAA:8 a=mK_AVkanAAAA:8 a=tVI0ZWmoAAAA:8
 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=eKQTCwoLd85be8zhlTQA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=cvBusfyB2V15izCimMoJ:22 a=D0XLA9XvdZm18NrgonBM:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=f02Ha7HRcztGgdyUxOxW:22 a=IawgGOuG5U0WyFbmm1f5:22 a=3gWm3jAn84ENXaBijsEo:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: j4qMp5wCIFMcbQAFel9z1l40fQUbno-x
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIxOSBTYWx0ZWRfX0jVdpdokdI9P
 K5A8PpJy9K5gIcS0zJrNF8wQ5PhZaqIEum/X7E0v8sqCOxd1O2nmomHPHf2VWVyMWb8A7WaprEM
 VPR9igYNPldlrce6qvUjrdfiGvUIUhA=
X-Proofpoint-GUID: j4qMp5wCIFMcbQAFel9z1l40fQUbno-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200219
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

Both DisplayPort and HDMI standards define a way for the Sink / display
to notify the Source / host about some kinds of events. In case of HDMI
it's as simple as singnalling changes to the EDID. In case of
DisplayPort it's more complicated and requires actual checking of the
DPCD registers.

Currently USB-C drivers don't have a way to deliver the IRQ_HPD
notifications, leading to missing MST notifications. Provide necessary
plumbing to let IRQ_HPD events be passed to the DisplayPort drivers.

Note: the Yoga C630 UCSI driver and Acer Aspire1 EC driver are not yet
enabled to send the IRQ_HPD events. Both of them would need some more
reverse engineering to find out how the event is being reported by the
EC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v5:
- Renamed drm_connector_status_extra to drm_connector_dp_event (Maxime)
- Link to v4: https://patch.msgid.link/20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com

Changes in v4:
- Renamed drm_connector_oob_hotplug_event() to
  drm_connector_dp_oob_status() (Maxime)
- Reworked commit messages, explaining what it is about (Bjorn)
- Rearranged commits, making them a bit more logical.
- Link to v3: https://patch.msgid.link/20260421-hpd-irq-events-v3-0-44d2bf40dfc2@oss.qualcomm.com

Changes in v3:
- Fixed build error if aux bridges are disabled (Intel GFX CI)
- Link to v2: https://patch.msgid.link/20260420-hpd-irq-events-v2-0-402ffe27e9e9@oss.qualcomm.com

Changes in v2:
- Change irq_hpd arg to be an enum, possibly desribing other uses (Toni)
- Account for that, chaning the API accordingly (with_irq -> extra,
  etc.)
- Wire up AUX bridge notifications
- Link to v1: https://patch.msgid.link/20260416-hpd-irq-events-v1-0-1ab1f1cfb2b2@oss.qualcomm.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
To: Francesco Dolcini <francesco@dolcini.it>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org

---
Dmitry Baryshkov (8):
      drm/connector: report out-of-band IRQ_HPD events
      drm/connector: pass down IRQ_HPD to the drivers
      drm/bridge: aux-hpd: let drivers pass IRQ_HPD events
      drm/bridge: pass extra events to the HPD callback
      drm/bridge: pass down IRQ_HPD to the drivers
      drm/msm: dp: handle the IRQ_HPD events reported by USB-C
      soc: qcom: pmic-glink-altmode: pass down HPD_IRQ events
      usb: typec: ucsi: huawei-gaokun: pass down HPD_IRQ events

 drivers/gpu/drm/bridge/aux-hpd-bridge.c        | 11 +++++----
 drivers/gpu/drm/bridge/chrontel-ch7033.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt8912b.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
 drivers/gpu/drm/bridge/ti-tfp410.c             |  3 ++-
 drivers/gpu/drm/display/drm_bridge_connector.c | 22 ++++++++++--------
 drivers/gpu/drm/drm_bridge.c                   | 20 ++++++++++-------
 drivers/gpu/drm/drm_connector.c                | 22 ++++++++++--------
 drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c            | 10 +++++----
 drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
 drivers/soc/qcom/pmic_glink_altmode.c          |  6 ++++-
 drivers/usb/typec/altmodes/displayport.c       | 23 ++++++++++++-------
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c    | 11 +++++----
 include/drm/bridge/aux-bridge.h                | 13 +++++++++--
 include/drm/drm_bridge.h                       | 31 +++++++++++++++++++++-----
 include/drm/drm_connector.h                    | 24 +++++++++++++++++---
 19 files changed, 152 insertions(+), 65 deletions(-)
---
base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
change-id: 20260414-hpd-irq-events-e72bc076a5f1

Best regards,
--  
With best wishes
Dmitry

