Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF9FF34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C18010E497;
	Mon, 13 Apr 2026 14:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gjweD+Mv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e0no5UN1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA3A10E49B
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:22 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DCWxwh297386
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u/JqaEb+NMid83GHj5mNNQA+ojq3d6qm/84/uWVT8xw=; b=gjweD+MvZb4xDCac
 gVLHxNRsljPEDeeOlOG7Tu5Hv448YRH19hYYrdNm3/mQ9Lo6LvzDz9y8i6CmrdTO
 UeaF79i+hIA6WpZxen+QcE7xtA51GLZ7/6GlXb75CKbWKpyM1WkBXAJl2qbJC0iK
 TBbyEfS9RNTpsfC/84I6KXO5mWtHaZr7GCxkETrtRn3RJ/TgQHMPQ9NNEtYv6aYQ
 4BMZU25EOM8Br3NZ20CLlyn4grizBEnCJZ2H4vxeWDiyUrD5Lpb9jQ4eptbE8gIU
 XDJcO7a0GsS2ai4jUpV6e/j2vNSLbf3zFthttWRtk/sjIMENguj2CI4EQCQTg1t2
 SDL1cw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh0kd0c03-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:22 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-467f7743d64so5346512b6e.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089181; x=1776693981;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u/JqaEb+NMid83GHj5mNNQA+ojq3d6qm/84/uWVT8xw=;
 b=e0no5UN1yC69hbkWtwKI7311wOXH2da9F2MMY4u+UReJabvXdFLLmxLb9+5G3Xxq3N
 Cwz9gncyx2TE7WW387rOq98lYg/FKm8yJSrkB+15KeXCYLlT2kkcMTy5mqQjoo9okUrg
 NWDe08UnjInespU5YDubAb6PjY1/Q7SitMJYRIOl8HeSn5cJ0n1AgiQGS0BuwKGIKQGs
 DCIg+aWouI2H85T0UHOlaHJ27LlsCAXAPFDcVXoNWPhp8Lmmj1CRkgYymVzGaLsoVkw9
 VWHcne94b1EAJI5SEjgXk3D28W5KoD9Fg0nasLds9UuyFI++vLPDEFRAS3cgAmyroaBF
 999A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089181; x=1776693981;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u/JqaEb+NMid83GHj5mNNQA+ojq3d6qm/84/uWVT8xw=;
 b=mw+FNBAyG9LBGAIRg08Ly311TE7TK3O8QNuZ/3AFtsP5xkGdc9lq8UXF9krz0/BUvs
 IOrqIfQdqNd6+Zq98SnTgkaRrNjiUUSNuHA97sUqUXbW2/PkDw0gDeEgRAjdxYdxvPyq
 qU7z4eAgIC9dPKt/Z+T7mRUbiOKHqatG2RVdvpLpuFhIXfcWS9/yuLVXKqF2ShZNS570
 GuVGf5qEQ1u6pDbgy00x/hYDKsj9Sj48Zlfa2QkBtdMgyM0FZCsf/Evtk69EedFoqUQF
 KdrCX4VCZpXno1XbyCapTU30jGamlp3Qph3Ot1nJL53qX7iVyiNsFGc8pyUY8VnyYGeK
 RbQA==
X-Gm-Message-State: AOJu0YwOQzNzpLnRSLiBoCTrpvN2xN5EP6l1szxmj/7yi8PYKe1MpxG0
 WYWAdHhJVl8EmRHKLPcbleLDI3qSizXEYswGQEbblMOln2ry90D4txy9WnwOnH8f8MUcnl0qKQD
 /QvIKXEfTuSQ2OOAnuU27f0hnKvFUwCzuGULYEcdAZJXuX2B8tgY94ddfZmEGcrUZFXHmj9o=
X-Gm-Gg: AeBDievnj1VDFcSD81zUXkfw5Qxj8SFq6LuKLAHk7GBF/CumR/Bb6SlVQ2wp2WPOIWJ
 U18F23tOmBfxTBcEHNb1bHlSrslBQ90dPuceJ7l0MwwefU50smMJpsbD4sIGomOxisB/WGb4hqH
 ts7gduwPLbUDMfhbivPV2vEj5N8vAF9+1xb60p8NNTx2sN0K4H19m9hjIDlrBpw1FtXXQcUDpxW
 4iPP1aRU1WTOaqzDOuvBivIWy8H93/66ytHG11KkP+VYj/xeIV5vtfadoZtg/oOJx+Ug8j19dtt
 /xH39bifzSnzzcx/phUjbwWpxSp1Z8FeWezOLaW+m1w9ZecSiqP6RKmQMKqSCv/UGpzAgulPl/p
 OzTuJknphp3i+lddfAJfE8uJsIfOXajEv1bSVP/cm3p9OOmhAu4b3JtqOxWz5wSFvQMB8pzwf/l
 ku9y/2LhHBD484TxVi2KHImLHOtAPgEDzDvS0=
X-Received: by 2002:a05:6808:6713:b0:467:4939:9666 with SMTP id
 5614622812f47-4789f9ff5f1mr6710721b6e.47.1776089181429; 
 Mon, 13 Apr 2026 07:06:21 -0700 (PDT)
X-Received: by 2002:a05:6808:6713:b0:467:4939:9666 with SMTP id
 5614622812f47-4789f9ff5f1mr6710663b6e.47.1776089180901; 
 Mon, 13 Apr 2026 07:06:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:06:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:41 +0300
Subject: [PATCH v3 18/21] drm/panel: add devm_drm_panel_add() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-18-3aeb53022c32@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=rf4el4++6e9jBpjjECUwGqmrfgQoRtn7snVn69MvoWU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3Pgp36dO9d8sfKpSoa2iQ31yyNO8Ctp8WrrhH
 LXL4NK7WQyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4KQAKCRCLPIo+Aiko
 1V0QCACnAkb/uJNfOqLJvZOMdoZDHqS3A+CKkd7WrYSl+1DpW8RrS7lFtt+GehaxZYzcW56jM5u
 BvUELCsVb4Q/AI4RdseuaZRFDN7hhZ1ZVNKsU3J4xEPBKdazX3fFFnhMjzxVfpCHYTIDFBCNoIQ
 NhFP52aq9E74NdJTipo6BVBjUGlir4QDFO6emDGGO5Kvq7ObR99dqNLfbjVApJYGhXQeDVyjhkg
 VvuYhVzBihGipeqVaknv8TNMagcu8VOCGp77OGd54TYCr3X1Pan8faJzNbk7jbNA6jvaDsQRmeE
 b0hFftgYc5yx5LWiG6lWS3gf3iQtgc8QcFSPUxb35yrLyVzJ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfXz4B6tyywEV42
 YzlZtSEwboPN3iO0H/Vjnmo+RE+DBWTFp80PuqK0+LLsTYSk85yW+D06GjduX/dKFcx+kUWfXXe
 g56G6YjkKBvHvnm+qPB4LqPFusMc7O6aMng5aJL4sjqRbKhBY+q3inVjvxuxjdwhC+RVHNbSmGL
 psCTrI/F8kYZDsszgEiXV7IcybO1MVjjfZ1YQzzKZa7DlLEzd/XaupJRQdory9mwJ5G3VlXbV5M
 N00ejJogqpvrhBW44MPpm+ecNJCwJomE1mDFfiooctq/CxH00COXlqRY9UPYYc6rTR+wa+j4gcX
 vGDZjsRVhE0Bn2huTJhHqsR6OuBAJ+KWmALUyozbPsHl1MAVKrSvW2AJNo+nkOxYh9mkF8ZzOdd
 k77r/Mc7PEQACaOlR1vOSSV1SPOJsvvfX7rl91HAovZjqW5Dzn39nqw4tqERjV7bWhGkCeiwK8L
 LVGskLy+57FDXtB+THw==
X-Proofpoint-GUID: uacQuIApEPzoxi7GzmdafcqddPtYw4J_
X-Authority-Analysis: v=2.4 cv=D7x37PRj c=1 sm=1 tr=0 ts=69dcf85e cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VYOP6asi5FRKG1UsDooA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: uacQuIApEPzoxi7GzmdafcqddPtYw4J_
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

