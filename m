Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FD0F34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 802E010E4A7;
	Mon, 13 Apr 2026 14:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AUHlFM3R";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fiqQ4ZFV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FA810E49A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:04 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DCXPLQ298176
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2M46GkeAbIKNMo4RtIIN5JRHYxM3CJJlJxRZYNibdps=; b=AUHlFM3RovNhG89f
 n3TrDBgW8RSL8eqtxi17jkrXV7ROzbcRhgUQI3mLzPhKLvfnUwuTjMZdpHtIdvws
 oDzqr7Mx1ZKApu+dzIPi5Rj+EwcN8CE+aiAVy1zakwqWJuuGUUwoDG70/fTNMmJ+
 dwXaeuFXeKC8DhtYITReakBhOWNKT7rXRhmaKwrJcJup/MqDIa/7ubjSfy9mthzR
 w3ZwM9e2/IHRmZpUCLCYt+mkHJl4hyHxYXV7DH4SCN+sPzgvFR9UMMmiPDvgHzaz
 tuASG5jgFu5kwvo4PXThtnVJUz+18xBHYW+5eQcN7EWAMRGUy+ierckYUfiiBKiq
 MJM3Cw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh0kd0bxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:04 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-472728429d6so6355044b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089164; x=1776693964;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2M46GkeAbIKNMo4RtIIN5JRHYxM3CJJlJxRZYNibdps=;
 b=fiqQ4ZFVFZG26UOF/u7edo+z8HIHNBR2gTwd2oHK5eaYebvmB8dmbUSGgQjujD4lmS
 moG5kuGYM/0VYa1jB9YYnB38wpmfv4QURLu6cO28llN1Eqhc3WVIELeTxWReW3M4/eaQ
 10ldB/tlMc3ZcmRqx312k1Vi23wCymfzvjtAFGbZ8TLDdpRW3vDPdmIhS6u37hTCVmFt
 j1tGGFSE3o4CpoQe3Pvdh0ykyQ72RUtSXiJDyhvszKNlJ7/PnLL9xZjTrWXKwAsFILjz
 ZK+SWOr2w4W+q7VMcRtUFjAk5mn8p2Y5JjXlkQBGkuqWl9lNVPWkWYwG1MAKAsNz0Vhk
 1T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089164; x=1776693964;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2M46GkeAbIKNMo4RtIIN5JRHYxM3CJJlJxRZYNibdps=;
 b=OLDXy734iKbQuBrYFNPvTojBF/eIvQ53IRtFsm5Z8XRmd2pewqC/Lqu3BLo0oDXt6q
 Mtd4CkAD236t356V50JKH0CLb1b10j14Z9Mj4W3rqm5YkbahNcAxRMImVPgGBdUfACmJ
 +FXo0IShGtLZVLbKrqxxNJKQQrJpjoLJMXTr3i/mGDs+d2tP4JXzg4l9KkbrwMOWQP+n
 bvl1gKCMb5kJd4g4UqeCf+fOggcue2oVT91SYLi823V5/y7Bxjnzi7Ir+xy8r6RkAGD4
 BU+Yiq6zxol8H7iqNmtTKoGoi9boJdnnbn/+qGkIkwbfTIOVILQlJLNEpS6e/9u2Lezx
 Q8iw==
X-Gm-Message-State: AOJu0YxRrSeQlmZUVZl5bddKKqx04ktg6U37i7B6Y+4uSsthyqw9Enpw
 5y5sBTLYI6AjRn5n4EKJKB/lrGWLM6cuFnyERjrgFPtrMPvsopxEluYc5LCC7FaeVVCrFqiIMHJ
 UFdKqsYq6U+DgorhT1bAdUPzpK0U6CmizQuWZ8Urf/pUqr+kdHPfRpPKEb1+YCK6azdXoXRM=
X-Gm-Gg: AeBDietmUKsyGRQEkOKCs6OzN5FoDMTyQKOLTx2CUud7Q0dh4OA2D00uXHgwFVknhfd
 8bgm0SPVcbQ6iU/3I+zGB8tasxUo8/Le6QSj/rsNwZYAwCxe1dpsuHTaajrtlibaBJsaTJc18Ta
 Aw3w2UkPE8ABk0FTliGylmtvhK+ZyJlylR4K0iSvSkcQlwylSQuDVhU7Tmo3646IWfzmdgJqEvx
 +0kn2/OUfRfQ7rgFkTmODWVt0mEbli/EhJx5oXZTiKYFVdTHE9gCw5oELZkhtsZf6kh3xf8p5Bz
 PUZ5g9oIT7l//tWkQgVxTIDWjmxburq7EjoRfpizaSqVWT/mLp28ge3AJevuLBpOITr79s9IcnT
 qp6U+gmEzyP+exTB4fAxcC4Ota3VCKaRi/mUyvOGaRTcQMk6etypzvFnQKODKa4sVu9bQf8kSJ8
 m+Ds/g6CRZmUu6OP6NY4hisWnn5JjwfD0M34c=
X-Received: by 2002:a05:6808:ec7:b0:467:cd8:7f5e with SMTP id
 5614622812f47-4772a35f8ebmr7655821b6e.4.1776089163653; 
 Mon, 13 Apr 2026 07:06:03 -0700 (PDT)
X-Received: by 2002:a05:6808:ec7:b0:467:cd8:7f5e with SMTP id
 5614622812f47-4772a35f8ebmr7655803b6e.4.1776089163174; 
 Mon, 13 Apr 2026 07:06:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:06:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:36 +0300
Subject: [PATCH v3 13/21] drm/panel: jadard-jd9365da-h3: set prepare_prev_first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-13-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2OhwTmez/fN6vzgtCuASLky1gWVkSsam5T/8/+hvPxI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3PgoIvRLeRiGDxBhVYJ75H7QTnl71YAKsM74I
 b+hcuYNB7SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4KAAKCRCLPIo+Aiko
 1efWB/9yk/B1B2SCIZWMOvjs+HwMFFvQySMKbTEjbph8t99biLPGBfyJMwgu7HO49P/RTZDPczo
 4VamEYzP5ghhE2SKdUfG6LF4Zp3D2XmXbRglGcXbwIcto9hEfFOs/8k1r3/FC+ffkzfqKayWM7g
 gC5LupcqGmFL7qRKrzIlY/01Vs7wnCr8l6elkJ8EfR0ZWeayU+GLuPfug7SryhOe3VxQEnRe/Sx
 RMwe66hvk4Qb6gdBTdxDqYfxZNTNSIDoF6MnoDEJUX+lsdAXDS6wm0p5534yDy9hpa3QZElQwxj
 4P7oby/TZvXhzV49R/arrIMkaFdmpVmdIdz7wDMiwZw/MWcC
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfXxWaySqR0ThuZ
 EqbLZ3YdXLY9umdS0n/0bm9f12ZaT0TFd6AmbQz5nx17DrE993JoAAoBDMYGuSSDuEYQ2/z86Ne
 /DFwZGC81XASNxXn6oIKHZnCzBVr81Cvqi1IDgRvrkzuj9yC5JwaE+NGtLcOCQ/yIn13U7uxrM9
 vhuTjVeUMjwzHQ8uRg95QSGVPeq/l/9xVMxpdKhd4n98mNFbctGGdYHFwobutPaG17p3dSlX2j9
 W5BIMGrD3rPBdi7Nw0X0i7o/rqBXmt4FTUSNbseRwfY4ih9l6RBmnUzkPgW/w4qryz2N9+Bzq1x
 tj4R4uCJmkNb8cg5eExXp+uAnnyiEn92U4OFBqVrP1LpclNXq1goUDDT84VJ+wOffHUme7R6Q0S
 8FeE8NcTwzSee7D8TG/VHRYMe5b9wparzFpRLQcG/akixpLNv05DjLcLtzIfF1Q50OAkU0AJe2g
 eIx4WGnCWznGOHuJ97Q==
X-Proofpoint-GUID: 3dsO6YwQw0Gy1x3MWxh8VyYYSxl2cr3e
X-Authority-Analysis: v=2.4 cv=D7x37PRj c=1 sm=1 tr=0 ts=69dcf84c cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ic6V0yA_i5s2A4o5CdYA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: 3dsO6YwQw0Gy1x3MWxh8VyYYSxl2cr3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130138
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

Reviewed-by: Linus Walleij <linusw@kernel.org>
Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 796cc2368477..bc079b97cfb3 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -1666,6 +1666,8 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
+	jadard->panel.prepare_prev_first = true;
+
 	drm_panel_add(&jadard->panel);
 
 	mipi_dsi_set_drvdata(dsi, jadard);

-- 
2.47.3

