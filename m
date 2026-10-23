Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD7606A328
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NZDQmjEo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C7h2fGCK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A74112B22;
	Fri, 23 Oct 2026 13:41:04 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26879112B62
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:36 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAQHg1597889
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZeC773TKEYubASujmMTo4cYzyXvzJFRJKmRo+UPd0C4=; b=NZDQmjEo3XEu43PU
 qrUt2Yrt5RNEiHBrhrMODLvo7dCNn7vAd+G9DrNpFcK3+vA1y4YExqlfev88biMw
 79PH/yAhbyjzkThwN7o1j9kuIJTRhI7K6EgmIxIjQ0rz33bMhHn5SSkf7hE4QgF9
 SGU8BlGv05gCsCjyKIC6KPwhiWTld2YdDRiuS1YvFppdx2MjXwouWB/MvwUhLfPo
 SdBhQ2zFD4QBatW9pJBcfxdzCt4pG3JQl82VixJB6m3wW0jxV04pueNbdyBUrYjG
 GvGHl0357Xvcf3xrKjxOK0WkSX0WYqe581JBMznG33H9raDKY37gxnLM2VWK1e6E
 0Z8UQw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms3vnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f37c94ceeso396393085a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792762834; x=1793367634;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZeC773TKEYubASujmMTo4cYzyXvzJFRJKmRo+UPd0C4=;
 b=C7h2fGCKstOgqViMyYOk0yai32xkPTWQSuMPUzWsbhzhIr5i3kz4Bpz5ByZAHNR1V/
 86pShJ3nGtITZVtl9Ka565aAagJTmN+49syyddO8n5Kjg1koSC9JYCmTfto2hXxmHct9
 rm2zPSAdSO5xJKc1CaWiPmKlDZ2EGxdW/nWye7sdylepWPphii4MUK9CFd/eKz9C1Azp
 54d2jME+07hnDMdxmetliuhMrYN5hAlVkkg0Wff1pGYjP3YON42SoHlq8Gdrsb3gRqFe
 iDaZPDiRcMDZoDf/uOyEwKfHR3WdF6YS67RvueRQ9LsnR0aUG2dUUt2u55kwNsMbdNYg
 8GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792762834; x=1793367634;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZeC773TKEYubASujmMTo4cYzyXvzJFRJKmRo+UPd0C4=;
 b=eRLNsIbsaQ9jGbFujCLJqbQl9nSFlkGDnz9/1hdRNO4ArkZFwr/WfVv5kKGzelA29d
 raqzjKICc/Po5xUnfOIbliugz4Lw2qDigjkPFrdxEnirNkRjes9SuLXXdv6AYgEU+/tX
 oI+cn0WvpVzvBlSIUy81CJyNvY3VvEBjRFC0tToKcjTl0K75Hc7uSoKKYmX6Em0gHtI0
 dvRH9NgPHXi3vq5I4PIA5WoF0WsDkDec+NIIj7b5KbC2fmzWAzg9RqwM36OVQ+2OpXwT
 pghoE4KLrzdM+UOG0z1+vVgKOWdZW0QO5tJFD/DJgSeGHBeGov0LAnzSzRW1105+ctnj
 2GBw==
X-Gm-Message-State: AFq9FYK9sc+xz1QdzIin9yaJ7kPEbxVmOrf98CbSSh9DL7Rg87pGETSx
 LyDl62rzS2ThVnN+yzeIX+TWYTLBAwj3C8T2EuAVoFWt4zYFCsFxtFgQkHhHoxQbfRKivzYmeXo
 IrCf7i1PUDRXjsxnr0akwre0qMoGlbBA1LpG8dq8Rw/zD/TyMuxVhlO3dgp3phNysSHhOu1A=
X-Gm-Gg: AYBFou0ZLkYIWDJEXuJZh4tnOWvqW9Pxl7JkFSZR4h3A3v9rbrKgLErXUHAp1DRDylJ
 dF7z8S0//RvVE9qfzHDpGhlFdjRTBbyVS38Zw9sHlQfV9+ct45uZFDyqVWOlTKvgz6EVnCsXeXT
 Lux450GcVl0ib6Jhy1ZpQ0HH3rojQWEhUQQPpHN4bKT32MrY+SWKI4vxn2/c4hkWv79oVLUK3Vd
 HCiHq1qudeOlN86JuHdyjtWeJjhTcZe9d6+N6wUcMJL5f3bCw362qM+OtIcoXToNfVo1OB0viJj
 TO3nMnX8cFx2n0dx3sLid6zA7M+m0rAKB0H2cw2Il+Id3T3bVbIpHYgNGgeYhNNgZImsZE3W1iR
 KQXncMOCmRpqHxyEw61UUF4BFryQwK8b7IVQM9aLEvkRZgjSwMIc5uKDR5o/EgZDtdzXZ5CavXp
 sjA8W8hOhleYoF
X-Received: by 2002:a05:620a:4727:b0:93c:65e3:df81 with SMTP id
 af79cd13be357-93f626db2e2mr856691685a.13.1792762834358; 
 Fri, 23 Oct 2026 06:40:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4727:b0:93c:65e3:df81 with SMTP id
 af79cd13be357-93f626db2e2mr856686185a.13.1792762833809; 
 Fri, 23 Oct 2026 06:40:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac65ce14fcsm5309701fa.7.2026.10.23.06.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:40:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:39:49 +0300
Subject: [PATCH v7 9/9] usb: typec: ucsi: huawei-gaokun: pass down HPD_IRQ
 events
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-hpd-irq-events-v7-9-57a3aea3f09e@oss.qualcomm.com>
References: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
In-Reply-To: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Francesco Dolcini <francesco@dolcini.it>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bY5FhyMu3eZPaJc1ltLzH3W13KWzM9lAhGrC22j7pKg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq22OtA5kQaJAzu3uDsBpPRilZ5f2hkyP8+qPHe
 NeTG5AI00KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCattjrQAKCRCLPIo+Aiko
 1RI2CACg5pQDUEeajZzHEEghd4rfxKwDm4JgwgS9OSplIDBiAHrg2w/55A4G94IWULDp5wDxMxc
 jlgkqR47eCTeNzA2l6yZUkkMMvkCVWKhBM8U09/ys0hiHXYUW036cBiTAsb0Dj58VFU9dRl/R8+
 abZrn9cWVIKIHzllDpGW+CiM838Koz2EgVRrFKk76B1j/Rwx3fzwTPICryRsDzdbAzliuRvqaXV
 O8Vvtzbw/1Z+5I7/WE9Ic24Yk8xBHdCBSoATwKaz16mXwtSI8XwYvM0MQqwwSSiJ98d9mY7UwAo
 LfRTAJ62c1+UgsjyAEfClwnjIwik4AOmFfFZQCmJ4l6CZhuc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX75J9cOUQe37c
 lhxcywDd2yroOpIILpVUfnD+34RW9tayImIrKvxgBB766S3hlPUzwnRvgQEKlc8E3hdFac3DiN6
 50qcj2dpM7BEwywx/VYGv1wA9N3sFFAYkrgVnD8jGo01Vadzh4RbRgaTtIzqEa9+gRIqhNaKbxQ
 1Cvyb/vE5Zhthp7RD4tWsjnDDnOkRgYLUccNHWIENdXDJv7T3vqdN97xffJnGJs8+hT7iXiDmj0
 mO6AQG0MsHy9QzN2EC+WLGqchuQ0v7WEI+PA7rSeiXrMdUiD8K0PrexBueB9xu8Q84WbCkO8a4r
 6vdRqQ/R6r74Ph40i1/1CJ+hFcvggjTts3MUa+N2DdZRVR76URDitPDV+VKKkDoEkJxroPb8XWT
 8/3pM0wrf6nyZnyD/DBo7RpzJJpaENbsHmLiXU13dPAxop4OgXncINa5jSlYK5ZJznp3obdd6NP
 Ct6dc/6SoslAmd1WNxQ==
X-Proofpoint-GUID: SD0_ewF4e9cZKEZA7TKk-Y0RLS1O5ogz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX25ANObrPEupF
 qiQ69U2VqO+U8Maib0YXeYbvxwcgeIEE/fyYEPW4av8rtWAgXhUFYu/NQ5Uq/WESDDEfdwxbkC3
 YGMmQJsgvRCV4NK62vBtMrc0mjzxYBg=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb63d3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=HJ0TMOZLSqZlwYNULgAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: SD0_ewF4e9cZKEZA7TKk-Y0RLS1O5ogz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230053
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DisplayPort standard defines a special kind of HPD events called
IRQ_HPD. These events are used to notify DP Source about the events on
the Sink side.

Pass IRQ_HPD events from the EC to the HPD bridge, letting those
to be delivered to the DisplayPort driver.

Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
index 57b37fca150c..cb0312e2b8dc 100644
--- a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
+++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
@@ -316,10 +316,13 @@ static void gaokun_ucsi_handle_usb_mode(struct gaokun_ucsi_port *port)
 
 	/* UCSI callback .connector_status() have set orientation */
 	if (port->bridge && port->svid == USB_TYPEC_DP_SID)
-		drm_aux_hpd_bridge_notify(&port->bridge->dev,
-					  port->hpd_state ?
-					  connector_status_connected :
-					  connector_status_disconnected);
+		drm_aux_hpd_bridge_notify_extra(&port->bridge->dev,
+						port->hpd_state ?
+						connector_status_connected :
+						connector_status_disconnected,
+						port->hpd_irq ?
+						DRM_CONNECTOR_DP_IRQ_HPD :
+						DRM_CONNECTOR_NO_EXTRA_STATUS);
 
 	gaokun_ec_ucsi_pan_ack(uec->ec, port->idx);
 }

-- 
2.47.3

