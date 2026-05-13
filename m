Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6542CD4F3E
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9D210F004;
	Wed, 13 May 2026 18:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L926dWnb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y6o5SSHI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8197610F00B
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:24:02 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DH6Ivf3430151
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sZrnMsT7jt/4L++ru9IvAvxyFjbRkLz2gfqjnGiw80s=; b=L926dWnbrlNFEaqp
 srzRYuP0cO0M8CQROQviJ240OwfSEfGfQkjbDWjadxTXeUGNt9JYCz2eOPBXiVMi
 reTJ/PRQJ9I7gmqRo3iKPD6xxNuzJSjsU5HEUsQFY6Vl9KFE4wO14tlNEUuyvvp9
 BV1Q8J/d+hIcdRBvj5Vwf6AwCWTcEQBgR3qPxVBpRg7PbOWMYZaSgsZJh7w+1yJP
 juhymAF7rJU1/fKM7YlysCzzyUCQMC1mZua8c9pmeUD6fi4mdDcceyHTwYp2x1yc
 x+g+3i7jbjZ3Lsljj7CqG7gPLkFr0h8+ay6DFmGE3wnZyULseJ2QoxdDEd920u5L
 ODmvYg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4qmchukm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:24:01 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-950c363a552so3902828241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696641; x=1779301441;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sZrnMsT7jt/4L++ru9IvAvxyFjbRkLz2gfqjnGiw80s=;
 b=Y6o5SSHI8d7qenPoTYOv1HPBiC3Vuz9QiOtnk3spFi2HH2yOrMT/vnaJlF4hHgMP7A
 alMPTt/L2+ruP1GMAoe8ybZ5z8QPkcHHiEsIu/OFhnBO7PPmNWFAP1oj4gR9TWePewgA
 3+AyeNW/Ge1S7vQA5I/1MDNINvtAshckr3cc9M6021In63v6zZYez9t9EuARHwbqQXFR
 sgXFP6rZOMKAALhbJ1FvMqDAXJ2Y2IxSLkRbh8RuU4oci3VoIi9alg1f31qr8WCUJq9p
 rcFpBp8Mo5sTkosotRZQSY4ibHvehva4X8Y53E6iYQ44/9y4IrQ2S/y/1XuaCeB5bZdn
 Lyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696641; x=1779301441;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sZrnMsT7jt/4L++ru9IvAvxyFjbRkLz2gfqjnGiw80s=;
 b=i7KYptQJT5GIuclvRdqumn5k5jRH7JoNlVvtScMxMAgZ0KAcGrD7yFp0TXUnTILk8O
 AaZfF2ZPiBq4ssVJ8UxnbYXWQGFVxUcqVFWpFtW4wwAguWLEdATzxtunuDMntU/BHNA3
 cv9YHk6kB73bxyVmw30fiJEWQEUT4IUTpYjy+g3xrpj+VZMOGD6TKRVBMtH4UY4fsde3
 F8GTQNz/3Ji6UnSiBK+Gmf6LI6U0wCCYJpmFROSbAHxuZ4XcoqmQitind92UEKd9kzr8
 DfphigJXJbtbqW5/fEXOqpEmJ3PDJXSQxnE4B1r0+QyMP/1Elf3HBgTktrTxl5ZUuXIi
 KzoQ==
X-Gm-Message-State: AOJu0YyH2k/XytuS9IzxuzygVcBzSQDPHd/ux54HAWK5b83CofOB+R/B
 26pmAaVlLv/eK6geQCy+W/mJLcqysmkQxzTbu4r/abZ1qPsSCzO2UFt48o56R8fFayYbnLT+weF
 We/HMuCj1UYKMRvhsCaWdXeXGxbBBPRDO5gwFNcVxp75eGHJu6ujBKpYoc6IGx30NZOFDqCo=
X-Gm-Gg: Acq92OG7K3HdHyXiEg8VOd/c6w4gLw8JDkrfCzOh89cb3uSc4+mNq5Wgd/ufReRwVMM
 fYFuNeI8Vn95Mk/ne8Hq+5jnlgjKMaheTPN34sJnHblGXs8EV6iMH8xcF6wMXD5wai6mXi+FSI0
 t91h6GAv2opgYmQjCTE0WBn6CZ8i/p1VYx5lbTAxi0E9LArUvgHW46tGOoXhNNAZ6PExZs8olHe
 48tlIo6+U9rf+Zzv2NVRoDRka73W6UxMIcN5679q/qiXjIZuyOz1ARrPk+AomDrtMxgXZeuZtFe
 hlTM9ijPMv5Lz/Ljx4nDju4GwJoeiH18oHjDVxn92g03WUUuyKESkBBnQIhpEKXeGeVbeC9pKOh
 UlF8FEtsacMD3TjHIz4i7U4ml16SdxIj9c+HOdW6XpgvPTp0wInADQV3FM+kQ6KwpldopP/uVo3
 snveKH3OUrnavvHVzQAkYUxYc38M/HXOhlv0A=
X-Received: by 2002:a05:6102:3754:b0:636:46ee:2f0b with SMTP id
 ada2fe7eead31-63771e93dd2mr2536254137.12.1778696640945; 
 Wed, 13 May 2026 11:24:00 -0700 (PDT)
X-Received: by 2002:a05:6102:3754:b0:636:46ee:2f0b with SMTP id
 ada2fe7eead31-63771e93dd2mr2536205137.12.1778696640430; 
 Wed, 13 May 2026 11:24:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a951d1f6sm4212851e87.23.2026.05.13.11.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:23:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 13 May 2026 21:23:24 +0300
Subject: [PATCH RESEND v3 4/6] drm/msm: dp: handle the IRQ_HPD events
 reported by USB-C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-hpd-irq-events-v3-4-086857017f16@oss.qualcomm.com>
References: <20260513-hpd-irq-events-v3-0-086857017f16@oss.qualcomm.com>
In-Reply-To: <20260513-hpd-irq-events-v3-0-086857017f16@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=891;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+/ILvBuGhqekKhSlkO02babbVbDbrJeHq8l4XOhAwlU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBMG0abAwQqrwNKrmGMKndnLCYyJA6PXn23RVR
 jIy1b2VxsmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagTBtAAKCRCLPIo+Aiko
 1dGPCACNGtpqzbvMTWs5X5vG8ECac3Hmh2yf8eM0hhFimdemipY/3p1uE7tZ1kfXqE9pDI1tP49
 wqoR6jikFqcgnRZ8SpkPDt3z2v8IjbTYJObqopxYBFmBaUt9lrvfMYHjf1IRxPBi0juVhtyKqEE
 I3psZD5FRUZi9u7VKDzuMV4vqUQitc9UgMQYvFPmPG/qomdvVXZJgCwlMUaSCY9/5RHsT3TNKC9
 JQNkKOHh+ORyA8ZutxDUNr1WX70N0HMl6YY7t91D4ZYk7vBzHYUOcRa5mm3GvAXPnywKP3vMquG
 6lyEjDNfEPjnhsGq8tO/gH5cybCBy0/PqZe1OxCjHZf+ALPU
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: TswqPJAsBbriC3mbyrniQxPPDVXdG0C0
X-Authority-Analysis: v=2.4 cv=Hu5G3UTS c=1 sm=1 tr=0 ts=6a04c1c1 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=3ML_fINe3tzxlWvVV4AA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MyBTYWx0ZWRfXygCdMqlADg8a
 U/JHEpJT8tEWAbotKBUu+pznRAnGh05135ELjuPID8XyULOMArHv7QXi5QUZdX9Q11DquAXA9r3
 zEU8biXkGDvyFm4pHWbjUUCoIvUg5gAihTWCmVHihvDY1J4ThcaQhdSn24SoYqF4uY45Hxd+cU3
 TSY6qsvEv+HKuEFk7JC6mHk9re8DHMQ/lWQXSOEkCQJQdGqpnbqMgkalwHGov6wx8WBOWaquakR
 kTk2Ky0C8H/GajH9oEMro6y8UprYhv+vV0ukrG1gRneBbtUlXXoI7kprpTOFDaa8g5naq3lyQo0
 9wO7YhIVCha3x59UypVh/XlqTg1dtRDEKQa6MtKMotVkQWgWMY2RaPbpII24UdCsFJzrNPOzoT0
 Zd9XllxbfvajlktvSmpTIWjd3NcN+0xUwhDErQibUKJvavb+ryBrTOTNBRrICX9jv5AdkR79diQ
 6ejtNjQ1QrmWbl6LBiQ==
X-Proofpoint-ORIG-GUID: TswqPJAsBbriC3mbyrniQxPPDVXdG0C0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130183
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

Let the MSM DisplayPort driver properly track and handle IRQ_HPD
delivered over the OOB events (e.g. from the USB-C AltMode handler).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 7a0623fdbd8e..8df579bb320a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1800,4 +1800,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
 	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
 		msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+
+	if (extra_status == DRM_CONNECTOR_DP_IRQ_HPD)
+		msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0, 0);
 }

-- 
2.47.3

