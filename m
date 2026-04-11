Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1C3F3ED4D
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C47810E1F0;
	Sat, 11 Apr 2026 12:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vs9pX17r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rdkjc1ZZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D3510E1E7
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:29 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B43E0I621067
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u/JqaEb+NMid83GHj5mNNQA+ojq3d6qm/84/uWVT8xw=; b=Vs9pX17rEvZCJU/5
 oR/lUvbWwG3vzUYIVLFj4RIdRazZfdYBaVQCmITh9XgDOzbRzUVvuZtrB8jtqYcy
 0CzUo0fACwCigiJSH5UqZ6nnHsWtWlAxNS8/97UN+cDidJ2ljJYwEHa3ZSYKKM+n
 1sztsrYOYEKK4en7P0t1ZMwsPyxL4j6bZXnl1dP4BIyhQRgwFSwZs1PrxAP22BUM
 +b9clcSAIU7kwKsoOrgok1WUFABxGlI0l8Jf9p/p7YxwntQT9DRbYCxRsjtgOY4U
 IblltI34k5Sk3XRnPSxYYY2cINCTVwaAj0SsUIdxA1xLtR4qurOAgiGKiZxZcNHv
 X9bOPQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfrncr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d8dac6233so56853051cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909488; x=1776514288;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u/JqaEb+NMid83GHj5mNNQA+ojq3d6qm/84/uWVT8xw=;
 b=Rdkjc1ZZ2r5oflWR2xW2V8asBDsmPmhjd3uzCouVNGDWs17i10Wnoy9IjR8WeFtEF6
 yaPPrIgSI8JwlBU7Cocpx45aZOzLivRuUUdS/bpLdxdtSyuzBv5sGglovjqm9L0bJufo
 ZMS7oGZml4FFN/IRjzRQRWICnrnBUbzPxf+3Ony2sa0+6o5VEkcOpknQqak5uLcG9+WG
 2dMRVVoM7UNANWUNU+EtF3pp2FXtouZK3lOLy16nEl1Pjv7ezYW6fJk4benNzugFLxKk
 lL7cK7tFkvYvUpfTKHCvC9n87xQ4SzwcPCMEuMTTNTv7pyrIyMqcxAcSyqFirnxCzAAv
 gP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909488; x=1776514288;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u/JqaEb+NMid83GHj5mNNQA+ojq3d6qm/84/uWVT8xw=;
 b=YWICvQBTWeD66Mp4S7ZXRES+RHbouMaYL+cZ6MMroYw9bVdVJKAQze+hQkRBWwe/CJ
 6mjGuraYP61e3NFJUwuFqysP+pJQU9p8Aq2XOUWI5vhvh1wMtf3kXo0/ZmVHZ6co09uK
 9XwBbv6gPmwq6H34QDPs+lF7ozax/MRwXVmE30wfBzb1+WYaMtk3rS0Tts6EJj6TR/mQ
 EFFKOZn8gOrZg7HU1r9LymoJulkyP3VBAXgfh8Z0Ock9IBxX5NIsy6sCa+ra7m3K9khQ
 JlTQ5f78NNjg2IPRZIhfBI4lyemnURtmLs+BI7uoVXuxmn0qTGx4OEnJ0TGYRXSzsOQm
 vQ8A==
X-Gm-Message-State: AOJu0YxatW1pa2kW5uC/2NR1nBHw6ViBbManVD0Nu1ZvyXM+OpRPCAkB
 dc71ApbD0V7fVroOMegyQMygpHRWhD/QJXNBxxwbPJUNFgJLdFAw0p30OgUd56wi0lsWA5wV0gB
 P2e5iqwm+DPopAfr3lZe3YQF7ctX9FKDz+Lb1pww6q+5UtHEFdILhUvB/vVwwC3B2SVQZ8wA=
X-Gm-Gg: AeBDievIJfPnmPMSt6xOFn3P8PzYZkcYP60FiTBYKe+dQ3iHd62a7eKoc1YkOlNJMqp
 dhcox5wpNAa/Bk6NNWxg4mFk0qnq0g69JrgbTMK8f1EPbgv3nzqK37m3NpuHhaJuqI5oNRkXU/9
 ffx7+dUjjVzQBMWvntRqMq49SnGbiELPICD4gAoD1hReIkLAAMRFE95KagFVcNrseeazldoDfhc
 9/UeRCdGFW1+uX2xwksl74UUbWjpEdgacZvNsB6DcBiJ5eD6wNm4nAnywC40RDmjkC2Z6QH4BWH
 Pgbcl7hoSJY3ll5exjhLESGQP+1IhE29hUJ4um4COcQNx6PhtqqyvGUOuf1YG74nrvszkltFlsY
 R8mJG0mT7wDqvjoKvBaorD2KHJsjShQxkeHeC2KqzSVghlB5tbRY4WjpyYsQQh6pqtU1v8K4ywu
 VcPqRoQj0TgzkRYjU4jDA2OIt9sIcZj3DRK+U=
X-Received: by 2002:a05:622a:a548:b0:50b:4ccf:135e with SMTP id
 d75a77b69052e-50dd5b7c79fmr77592551cf.31.1775909487810; 
 Sat, 11 Apr 2026 05:11:27 -0700 (PDT)
X-Received: by 2002:a05:622a:a548:b0:50b:4ccf:135e with SMTP id
 d75a77b69052e-50dd5b7c79fmr77592201cf.31.1775909487381; 
 Sat, 11 Apr 2026 05:11:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:38 +0300
Subject: [PATCH v2 18/21] drm/panel: add devm_drm_panel_add() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-18-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=rf4el4++6e9jBpjjECUwGqmrfgQoRtn7snVn69MvoWU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpHm6fYy9faeKzAMPgr6LGW7nVgHcX8hKrg+
 qopFVe49u6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RwAKCRCLPIo+Aiko
 1RooCACTizZflR7WKB6rcWXc9mVqam8f3y7ZEymyQjkmYT0Fq5EoVed/5U/A/eHZbscogqTiZHo
 31eHxncXOZIKlam+Rv8DV3lvfmC1W0NvHM+NKkJrxtKTV/MF8b0eO2A1uHFp1ys+EDjst6dPB6R
 Ny1kZAL7tOKNTUiHzdl2K954tffQj8KMkM02GaQSYuZ+RKoakeIaPDDg3cOh5gJxi4HdQos4Dtt
 SMUa0tZ7SBIcvkji9Xckd8bWlaMtm1YQE06k7qPvyWJGsK3i/0wBY+Z57Yz9bjKZfXh/hVdUGM0
 iY1IpWo+PdeQ+t27iZqaqWDgaDYRSZKqbP0s9N/dvJIgjK4K
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: UOqDHdmiUu2gnX1VoGBPrYB2UHgRvH0i
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69da3a70 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VYOP6asi5FRKG1UsDooA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: UOqDHdmiUu2gnX1VoGBPrYB2UHgRvH0i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfXwHHsxNvdaj2E
 /9FO9MqleH1p3GjiKzKVwNTypHvvEHUMilNMn8Bqb9piU0JwosxEAzIvek1MKQ6CIomtwb8yqks
 1g/3LsF3L09o5uHORwThmvxuciHcWATySsEImCmUnjmYDBgRKtqag51Y0hL6/OQ2OsyEGNFpaQT
 kQ2yyyAnSfDVBtK4R0ib46yOGB+vzE1VUNmhWch6hox/aCaGx4yZnaYVesgyIxcqRlCS3nE+JCJ
 J4PKeROR64jXOevwUc4farncuftRusctutslrbK2JhdkGhx2+MOr1herW9y7ASA1/r1UGNb93S1
 H4mQF/Yxo1TXOf/XI72ofNJdwKvQDvblWYuU+2o2+sCFE/WoGmSI5IMzexKf/IN2TCE7+Sa2y7j
 N/x1cy3mUkK2Nr2zxASLmnp0Wqa3/PgsZDReTl0+Pkze3guxc1iCQHadDaAn+adb26v/BQkwGzi
 /6UYRgDwu7bDhLL+eww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110102
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

Add devm_drm_panel_add(), devres-managed version of drm_panel_add().
It's not uncommon for the panel drivers to use devres functions for most
of the resources. Provide corresponding replacement for drm_panel_add().

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_panel.c | 23 +++++++++++++++++++++++
 include/drm/drm_panel.h     |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index d1e6598ea3bc..a6029b699b73 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -101,6 +101,29 @@ void drm_panel_remove(struct drm_panel *panel)
 }
 EXPORT_SYMBOL(drm_panel_remove);
 
+static void drm_panel_add_release(void *data)
+{
+	drm_panel_remove(data);
+}
+
+/**
+ * devm_drm_panel_add - add a panel to the global registry using devres
+ * @panel: panel to add
+ *
+ * Add a panel to the global registry so that it can be looked
+ * up by display drivers. The panel to be added must have been
+ * allocated by devm_drm_panel_alloc(). Unlike drm_panel_add() with this
+ * function there is no need to call drm_panel_remove(), it will be called
+ * automatically.
+ */
+int devm_drm_panel_add(struct device *dev, struct drm_panel *panel)
+{
+	drm_panel_add(panel);
+
+	return devm_add_action_or_reset(dev, drm_panel_add_release, panel);
+}
+EXPORT_SYMBOL(devm_drm_panel_add);
+
 /**
  * drm_panel_prepare - power on a panel
  * @panel: DRM panel
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 2407bfa60236..1fb9148dd095 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -329,6 +329,7 @@ void drm_panel_put(struct drm_panel *panel);
 
 void drm_panel_add(struct drm_panel *panel);
 void drm_panel_remove(struct drm_panel *panel);
+int devm_drm_panel_add(struct device *dev, struct drm_panel *panel);
 
 void drm_panel_prepare(struct drm_panel *panel);
 void drm_panel_unprepare(struct drm_panel *panel);

-- 
2.47.3

