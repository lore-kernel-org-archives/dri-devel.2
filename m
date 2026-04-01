Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697AED3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9DD710EF38;
	Wed,  1 Apr 2026 07:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d0QwnNKC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Op41kDpR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E3A10EF24
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:27:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6316GB1j639229
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1jG6fWLqrKrr2bIljqRcF9lJXBS1ljQA7abmmA6bs3U=; b=d0QwnNKC3tygGyZT
 Ny4G1ErORX4BFvbJPAlWX9OHCYvN8gJeXyeDaNQuyLV8Wpy7tRXCef28V3XZhy+q
 lBoHlaw0BrERHq6255lD6JUCU67adAwsMzaXkATK5fEelzHsoEaoR2ADMSMYTN1d
 ikEIIjN0y3vu+JTcLGTV3UQLCjfDVSq45s5SwyihlAf4zbs8tCjcibwnXpqZqmYV
 JhpUyYX4j62avROzBQl9/U9HnBmMYHETNbazesX0U64B+HFXxU/j4PnhbHnl+syF
 5erMMrNH+cOO0Wpmjd9GRStCi6qciGblhXcss8YtYaHe53t8howI7SkcDzt+kVps
 G528bQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8g2auxgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:27:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5093b92f327so205154111cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028439; x=1775633239;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1jG6fWLqrKrr2bIljqRcF9lJXBS1ljQA7abmmA6bs3U=;
 b=Op41kDpRoo186pnmdPFVQbkxMBLxvnNpZE5GUOIsafWrcbEy6/eSyabtPbEhxUrTmt
 sKTr7W2YDLGHNefmJZ6HWJ4OT0w18FniTtC36qfXAArIm7NW5/U6zZlIFOkPrEga/Gjo
 6zOU5z917ilLw4938bGNUe8sch2pdOtx10G80YoVAYp+cCqQZfa/EeI7n+zo92DUWjCm
 2CFb1fM8TUFJtVkbGMTHD7i9ONCkh4XV/DFZYZmsHWN+9+FfSzFMdgrUzhsaZxGd3H8F
 7XpNRpNpqjo/URIRq0+dadGaeKgsayKXFNse/Y68Z6Qh5mDR5YaJPPSbpn0iknRp09OH
 LlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028439; x=1775633239;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1jG6fWLqrKrr2bIljqRcF9lJXBS1ljQA7abmmA6bs3U=;
 b=HmkL1ZG2jGZXAQIAC8ajwyD9bsjlwNFNKto8EsLABAQNUMMT2PlZBToh+tJHw9TArQ
 KrPZWgAyvn90c5RKcQMcNVKdwPnP1dsrkYolZkyMDVFpQSMzKmSNVw0ci44B968cL15n
 rAO4n9P6i0jzFZ7SIYs7FRG4AygBFsBZ4aFjBlTIwxXHno+bRWe0cNGJ3kaiiMUblsVj
 htSNNfZEhVBIvjrxc6SMh8dYNSWgaAqPoNu1nZH20PAIODyGY0O78Hn7ERjAVkLV4bAr
 ui8j8iuF1n3Zn8NZx6q7QLrur29X9qIO9TEs0kOoo8YkpQGkf5VAK5JcFf0ibOC12AG+
 ouiA==
X-Gm-Message-State: AOJu0YxnCO+17LdpXj1JFhK1VlsttLJBQTLXb8unYyUPTlmkKzAUVufM
 ZuZT/rCAANNzufETzIVLr9W6mYQV/akL6qwiQMEIyTIZAx+PZS3Ru6LMZXwTxoBwfa42gZleRYT
 t6XUhPUduTh6MxGDuaTada8EQ/r2R5ATRaHcpNEY/2UFoJ+5r7sbwFfQ2ExJHLQSxeybzc1s=
X-Gm-Gg: ATEYQzyBBzmBmdVbuLQLcTW+ZySqJAni1XJB0IgnGp/YlJ4r5ncYBRltl658qtm3NuQ
 24W8ICGC6SzofSZfyeS+y+fBqHVB4sRZf6USrSejtY8XP4tFE+/xpPwEebo2wlFKJFhOI4LTXwp
 SvWzV+2A2yLZOImGlue9sTAeP8uPDdsbK27c1VyipMulpSDXmXKcZJ5zh4qppAnkSa5/7lKpT+o
 xfntkaVAF+rtGsM4MPYF76toXKgCEab0UJXEaInJjojwo7P9ys5FS5j89YoQuRL4uBeIAJ2qIRU
 JiNQ46wJQmeOVWaAoS9Re9ti8RWiZ2EV1jtODTQwRPRJhaMq7NNTdan5VYK5RbyC3rZCJTkG3go
 Vubh9OsH+41UTbokcWS1ZmpR7wSbGCXk0S1/N31a8nfITjRthY78BmROh6JzNRiilHchLLbTLfA
 MGj4WSFqr14uMHMnXqMGicshD3keTqx3LCxvI=
X-Received: by 2002:a05:622a:820e:b0:50b:9024:53bd with SMTP id
 d75a77b69052e-50d3bb640c5mr30436151cf.6.1775028439266; 
 Wed, 01 Apr 2026 00:27:19 -0700 (PDT)
X-Received: by 2002:a05:622a:820e:b0:50b:9024:53bd with SMTP id
 d75a77b69052e-50d3bb640c5mr30434601cf.6.1775028433711; 
 Wed, 01 Apr 2026 00:27:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:27:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:35 +0300
Subject: [PATCH 16/19] drm/panel: add devm_drm_panel_add() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-16-5e9119b5a014@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2041;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=r6Up/NY1fdRwk7oQTpx7zUWlF65EBySH6t0rkQuUn0Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMitpf3+wRDDqUwdCq6sQ06Hs9RSUDNOWDd7c
 a6RInGWpsSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIrQAKCRCLPIo+Aiko
 1RLPB/9SPmUJI4j3Vi8apJINepSPxkLJCUZaw8M/0qLcE1fosjoRv/KX5ipclM7dMkeAL8dmzbz
 Ft95y84cDkD4PkITNilAdMMUADeetqfXwVy+031S+n6HHFo9dJZLUtm23DQ+X5mp8AFQx0ATK5H
 pyEpkm4rDgF2gBtYsEQ41A12x4fE84g5EMLEtKwqwVvLPs+v1ym5aaL+WNrBKW/mCuY+IntCocD
 L23AervjUQeL3hkPenYtUSYg21EQ4QB5u5kGxRHzn2iYeI4/ecAlZcKbJLQZlCt2cCaHhicS+55
 BTrnI5eUqnPV5GdNCVxIL/OHrIPk+5MWvlzhGebH4QCFPiPR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfX2wdrblVF2w4b
 FMIlk1fRaNXdH0xpQ3D3jiPa187PyOlw/xkUVttos9zrWEafh/VHk+bzPuxBMJDZbQRGDN6eOyK
 QzkxaxxL0rhPCjxwWUm7gh1Ptrc/l7QohlrXHS3UfGi+6CaXfUO6R/IR0tdOar368WfpBZIvlN4
 uC9jVXlYLFEWPio5qO8zawqWryEkloDkuPcUTPoZfLt5pbN8wYnRO2Rm+1PMIvATvOw23yFAVLs
 Mr/9JJu+hnz/BhzuOTPqzvLCS/mXPyPJnyiIR613n8cVdQK3FS1yUcCBpSP+mUgjx8GD7cAFBAZ
 /J3xXdLDpaHo1kwISyNJcsy2Z5DIYesqvFlVuGG2wxAa8HUI0U9Ih/ChBM6b3OnF26CR8tJHxNy
 yMlzpI5xz1+bXFu5VMy3vd9379xm8p0imorod+/2pUEYz/j9L3wAp1Y483F2bBWfGoGrmt37IfL
 eWIHiMuMBnfjdoho94w==
X-Authority-Analysis: v=2.4 cv=G4ER0tk5 c=1 sm=1 tr=0 ts=69ccc8d8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=AWYnL6P3aIH6T79I5XMA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 4Qo37Wb8pbBn26YwkfniLm_2SFtfIMwv
X-Proofpoint-ORIG-GUID: 4Qo37Wb8pbBn26YwkfniLm_2SFtfIMwv
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

Add devm_drm_panel_add(), devres-managed version of drm_panel_add().
It's not uncommon for the panel drivers to use devres functions for most
of the resources. Provide corresponding replacement for drm_panel_add().

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

