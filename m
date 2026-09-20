Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7890C982DA
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2943C10E2EA;
	Sun, 20 Sep 2026 15:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tc3H3Mhj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j1jrlsxE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5718110E291
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:03:10 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68KBoiD92288785
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 riY9eG3dz9cv+aMf8SNtiXHDGuMJEVW0ccQBcCjvHek=; b=Tc3H3MhjFhnblgJD
 SPNW+KTDOflRPaWcL2vLPAG7WqseeqmVAEBRj58+94rfWA1icLbM5/eDLWwI3vcX
 9swNh5fsoZC+3zlx5WDw7cIxzYqz8qoqpwAT6n0+1g1Ko3n0m+oYsJqEFnQTlUjY
 /Pd837l494hM/8LQecJxSwFZcVZWwz6Yg8YPdH6EWctRA+GQmpOM6TKm1iXSjokv
 lCvKpwfqTZfD3PtBhFWsNS6ANlRWxvrZZWwNB24DNR2SlEiVkKc9+HcbZs2XLznb
 ltoNsbnsIFVRysLBL9+qxrMR9s2vqkH6HbxOzxQYUA0x5QJof8KLgJ3x9crfOigq
 sXGFEQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsfrnujp2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:03:09 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-79cdabf7d89so2451250137.2
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789916589; x=1790521389;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=riY9eG3dz9cv+aMf8SNtiXHDGuMJEVW0ccQBcCjvHek=;
 b=j1jrlsxEO7Z2wbnNJA7US/qfTdr/9pwoGYBMeW2ryn90K+nn5R1w7Hi7d1PrK8W8hg
 9NmCaY3ubzCo74N0FKgEMGowpFPyOJbyNwY7ZWasMpwpLyP7Be+NnFngEtQJZEIwX7if
 Uh2aZCm0pbQuTiIp6JwbMHW5HZy3azGYala38pdxPkq39Jm2O3/Cm6psg7QMDNKhzzOj
 E8UahYMd8eLLRTqDn0mdiKRZPSjF3N5ZpOsMt2iE7L7GVh5Vr9ZkVQiC3yYpl3PEX8mo
 G2buAsDNeLGhjYwdGvOKBF8g5dhqqIMjU9lI7UomvHXCTCUPL4peQ177PXB4AdvP1NTz
 +h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789916589; x=1790521389;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=riY9eG3dz9cv+aMf8SNtiXHDGuMJEVW0ccQBcCjvHek=;
 b=Tqh3cWck66LYKlfN0NHBpTjk1BqbB3g0W2wZA5Li5MsdfeJhuaiunuBBZ0+8h9YFka
 DSrpRm2E3VJQXduAneZAEh8hvRvgPgAtHv84AHKlmgv4ABk9JiFaeaID0RUrmetvgO5d
 ypUeSCF33JHp98PFKsXMc2IeS2h6JabhTdxKC4p87EM1ABfDWUYs6xzBQTruS3pMZgVa
 TO5+o4KvxNu0mbKsn9BCqMx3B54zSyUV3GjdXIgkGMLtsk34LQJCcWq3/a/Z87JxOUE+
 TLL+SX1r1w43kTt48pRrhmBy0qNdfIrLxqDq8UZGFMtc3qasjXITl7jFMWx53CXt6Hgm
 v6vQ==
X-Gm-Message-State: AFuF++lefRDO/hNKhQeRXQ230jWDCd1aRgwlH2Ep80Te7rPT+VKNazeW
 00pm7cgu9AUEi2kORDwZfYCDCCcSx7oApfnmoGAHE6muMDKLMsdovRyOvHSuho9xQJ5eTwdDal8
 3ApnbLoRSmsvXOWHAF/aRGdrospvCcxGnByhUK5uK5Mh6sDwZFmvEN/9GI8vwiLeD91NYGDc=
X-Gm-Gg: AYBFou0G0pYhBKR37108RHlNaQsviINtpSj1IxXNa9MGxt4jyIAS4dxiWX8PUNkufYP
 F806/TzWI5X26mYKN0DQGMltHYl3onxrwPvnorNgwc+BD9msetxTcvNWxn3sX/dwRTQiYwa7hKb
 yrPOZ3SATl/qP4kRNTXFi/rYzOmX1LgrrROjNhEqqNsfd/VlQ0Weu9qF6VO1w2r51FBjtyBHgXy
 qjqpqIjyAVVgH+tajVYM+715Nd+ZINBg+GEdJAjjhFqU2ZbZoXiJcsbBn7WcsqSfbRhOg5l4GG/
 OlSqHvUJvUYjo3P6ptlzzaS380zS3w6kaQfQFLDg4O2begCAnhrrHZNUMsl582LLpsS+NcMJlNv
 5dGlD2Rpdj58RpyzLSpUTQKWGHgwwKZmejGH350Rby/nRI3XRZpR7FkiSM4bPFxlZpalXaQ6/jK
 XZRYIwRQD9QBTZ
X-Received: by 2002:a05:6102:5714:b0:7a1:f7d2:e823 with SMTP id
 ada2fe7eead31-7a55daa4aefmr3065673137.28.1789916534213; 
 Sun, 20 Sep 2026 08:02:14 -0700 (PDT)
X-Received: by 2002:a05:6102:5714:b0:7a1:f7d2:e823 with SMTP id
 ada2fe7eead31-7a55daa4aefmr3061758137.28.1789916509473; 
 Sun, 20 Sep 2026 08:01:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a6163d7119sm4090061fa.30.2026.09.20.08.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 08:01:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 20 Sep 2026 18:01:32 +0300
Subject: [PATCH v5 7/8] soc: qcom: pmic-glink-altmode: pass down HPD_IRQ events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-hpd-irq-events-v5-7-ff1de0090c72@oss.qualcomm.com>
References: <20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com>
In-Reply-To: <20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com>
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Y5prep+uK+TtAox//5HU+Am3tOMfG+jy1KYlpaBl7WM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9b6rx73FSI8L3M2/xHQ/9vYsClqvtqFDunnUQJ/PTexr
 Vv7aI1qJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmElTKwbD89sa9B+8KP2p6
 9qOlQ9erc85v7vgP/5qXta3VXDshTN3/Up7LDJtlL8+XKNV/nFwR31K7W5/D58kd6e+bZ24U8Jb
 /G8gmHewiJqL8jL2WrcxMS/Ti58O9Fx9eOvZPplTDuPleqNjUa5/TZJQEZBavPv7u8rZFan835h
 /JcWlYGCxxZsPZZd7B0s+tc1h1k7K3GWgw2Jy0vdfuc1v1WU2GiVlsj8TeLyc+1zUcza34H/tRP
 WV1X0m30rY5/Km1j/JT8r9yXFfKeHJNsP/illuvGRza3lV79FUZpr5cIl+oXZAv5rmqW7SdcWPD
 RKdOZ8X4PTNsYi4yZ3DdC+JJfxHRKpHnwxL5cnLz+sm7AA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=W9mtxhWk c=1 sm=1 tr=0 ts=6aaff5ad cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=Wdvqb4HS36tEXOME5F0A:9
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIxOSBTYWx0ZWRfX+dtG1nm7DZxg
 YZBOPtSzrO9MRRbX6hKKNBZnweT6hEdf6CQZWRTop0KWElGWAE6TOuW+2cQ+sB/JFuNqIGy36eo
 25xwR1OiWbDDPO9OsTtE7j20R9S08qs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIxOSBTYWx0ZWRfX2hPG+rb7yXQh
 otIYnLstSs5w/+uclZyxngBOrTsWoq1lCcb+ILYcUg4CHXnKLypAvDjeuG66kmkNklN/aaUn2Gc
 CkRk4p2oDq9+A7IL6c5Wc7R6xjeYFdUHitpDcRW8aPBsN1mpLhbCIPczugIT4Ty5xMdk2TgaO1G
 NX69afyrVi8gLYjQgUFkB0yGnBH0qrZHJwNxxilNpVCoggx24I7go00MgTb9yYyerK4aekDWi+0
 l1pAnjNf1n+rvwATr5intzcDUO1dhrqxbOppT7VzDecfZV0m7BhmBYCy9Tthxujs/8tQwri3Ot3
 eGhiN24jrq1yq7D6EMQ77iQyYtt7ZJKHTPFKyRW4MP8jCX7gER67QWYt4hkPvLYXyjSuLv1H0Cb
 Pnq4AzloZfiWxLG4K3AECVwjWDGin4rdiIVL+YJ525D7W6bSF1Zdf1Pk8VM1rXjRmECvhhFO0JH
 fw8CEK2xuTPoBdXV0Lw==
X-Proofpoint-ORIG-GUID: LglXC6xkzqkr34sncQsfzRuixFcGlToR
X-Proofpoint-GUID: LglXC6xkzqkr34sncQsfzRuixFcGlToR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
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

The DisplayPort standard defines a special kind of HPD events called
IRQ_HPD. These events are used to notify DP Source about the events on
the Sink side.

Pass IRQ_HPD events from the firmware to the HPD bridge, letting those
to be delivered to the DisplayPort driver.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Acked-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 465e5d2316a0..e903d4910e9c 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -374,7 +374,11 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
 		else
 			conn_status = connector_status_disconnected;
 
-		drm_aux_hpd_bridge_notify(&alt_port->bridge->dev, conn_status);
+		drm_aux_hpd_bridge_notify_extra(&alt_port->bridge->dev,
+						conn_status,
+						alt_port->hpd_irq ?
+						DRM_CONNECTOR_DP_IRQ_HPD :
+						DRM_CONNECTOR_NO_EXTRA_STATUS);
 	} else if (alt_port->mux_ctrl == MUX_CTRL_STATE_TUNNELING) {
 		if (alt_port->svid == USB_TYPEC_TBT_SID)
 			pmic_glink_altmode_enable_tbt(altmode, alt_port);

-- 
2.47.3

