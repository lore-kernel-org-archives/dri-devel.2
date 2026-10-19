Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B921CCF2DE
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4996D10ECE2;
	Mon, 19 Oct 2026 13:13:25 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA44210ED1A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:05 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OtI43256627
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GjY7yAp2Z8nvcjzi2objk8Dg2AFP5I6RCbBdptwbxXw=; b=Xg/1YfD8EHqVjLCd
 cSTkcv5ymULTNWeLesqGwFCM3jFTtjmgbly01/uvxugyYBVOsWxKY25puQT98Q9J
 2c93BPO/NmMV5VAmxi9v9Q4OIY3fyJiHVt52FQRslRJolMqPWhwpN/0+qxKkbwdX
 9rXp+O+uCKD6+g/l8I/342rKjvR+y6iTKsB9TUyKzN7Shzutsn0NWXvAd+nl23tR
 SqwG39qcdMwa4ntlLHoALZLa/Aq8+fkYz6JWHyLodWBMPMfxfSgJJrqx3bZ31WZ+
 sjKo+qLiXOiPhIn1bFN1kbe4K+3hkfI/PVEN0YaRse3InRiXjC5kQLSnM0BSM7JC
 THInwA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f97mb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:13:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f322ef7d3so344149285a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415584; x=1793020384;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GjY7yAp2Z8nvcjzi2objk8Dg2AFP5I6RCbBdptwbxXw=;
 b=QhHpZqIQuZRIdVNq52PVCaGxh3OaQuTmVS3dRl+n3LXLEnu7ThugAO4mwsseNmuie5
 +aWsqJ3PZFbvXS1QLdaHgK9N47Hi5IuDwufl0LF8Cmb08XaYpLEkif8eZdqc10et/tPH
 qpMf1xEWzYG0Ryxt6nio6PVf/Zfk+xmI3C/p7WoZmNnqM+IPBpUa/eBAszXLEKOrAx9T
 wNA2rRob+YS8yyrjGvX6ZccMr1T1NtcDL94V6LrewdMTKEgQgJhjaxFasvcbEXLPLc8I
 CXqoaNv7VQ4L89eFV3eJ1tngOsD953DpiBNIUAIJ2hva47KHdYDsaJbvKA0yriPE6auL
 dBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415584; x=1793020384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GjY7yAp2Z8nvcjzi2objk8Dg2AFP5I6RCbBdptwbxXw=;
 b=Hjm4JOsTJc4Qt+/mayPIjdSDJluk9BEu8gZtGB4/+AIsC1XsW6sb2Tj7WOVORIu4cm
 bdaLG23gQYNBvCAjTnjrsG8Kf9CFSN8s+MfHypg9Xs3i6kYFBYpkqQwBvQlQxsx03wop
 aFXgVBnp/pYy6VANCT7NESJJPie1p9Sz6XLO+L3Xhn+5ekNepzs7Kv9cslvRlbPrSgU4
 WD0yqjR8q555a/XHhmlkRDuSlDoCRoyxkVlkuPPonqxrxxojF5n/agziFgs+NgENC8KO
 tNqn2S0Ck92rRBz82mjoUscsaQdHUgJMyyuS5aPEw8uQe3tqQiiWIjB3EFBaBhy2HbwS
 abvg==
X-Gm-Message-State: AFq9FYL282MEbG/0WJuFvWOQzkRGKecbowbzF22lBpyH6mEAyBNxq3rW
 J/yrdyVSxJw/Gh1pPnbZW7xNLj9nXv8G/rskfNEF9felk2RydTwRbISc/kQachjpgomrBdtMuqe
 kTNvDIWoCR9seaycSgjXTv1XgWHWJuzIjugAduqDo8cDnJ2immW2m0mPD9fg95xOv9/z798Q=
X-Gm-Gg: AYBFou3+n0oxW+jeEKpe/3XsgvZhGUMTyd7CQVZDLWX0vSvhoZZ+aEgFVUrrGmTVRav
 cAoLWNZzRy4y0MqHwQPvjrCtw3o3+3L0ZGSvxky62EyixTyd0FKF6v9wPNk82vj/1t7M3yGhrAL
 PEYjpfHnTd8Qvly3W/e8uQs8i+SuO8m6HFyZrnIf/p5FZEFx8Nj09//f0vk+pvmVas2GxRUdkKU
 u+Sw4iEPnQeT2PmneoSGP5a6R2AGJP1TCqgvsPKTHFS+TcNo2bHOB1H5FPAPdsL+nVbkawBilW7
 jd8gBHawLvL+pgReJLuxoXzF+kZli5IXBh5dMFWgYBO7GltnhaKgm1tP4rX42FUMhocAdvB6Mt9
 3637+FL8wDjyl8kDaVeY9rahew522hu8zs6tWwHRO5wR+D7jDvwD2gDTjdzffOvAW1VV/bbtPVC
 8pwRCB4h/NoJzB
X-Received: by 2002:a05:620a:4505:b0:939:6c9a:8f8d with SMTP id
 af79cd13be357-93f29ceec9bmr1248053185a.28.1792415584223; 
 Mon, 19 Oct 2026 06:13:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:939:6c9a:8f8d with SMTP id
 af79cd13be357-93f29ceec9bmr1248044185a.28.1792415583536; 
 Mon, 19 Oct 2026 06:13:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:13:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:35 +0300
Subject: [PATCH v7 9/9] drm: writeback: drop the drmm writeback cleanup action
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-9-d4288a26eb54@oss.qualcomm.com>
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
In-Reply-To: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Harrison <John.Harrison@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=cJTn82pjvFTmv+adSTGav2SLcNIy0UXB7XKTHYaKc7s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdGrWE90+VGNNBzkJup8rA7qU3hQoX7mvzRl
 8wMEIYTVG6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXRgAKCRCLPIo+Aiko
 1XcnB/4r2B/SnDa+KqzrY9qAJ+Lmba7KA8Op/9uFQB8E2ydzAXcTOqqgHiv4QFUYGKZ4B/Ra6Jj
 uDzpKki/dgdrqbghElst7BBOD9KgAcrauCvD0jhckc5uI7D9naEe7ld4JjvAXgtGkTQdD+XTqed
 Y5+ic4ZkIHQ/Ft9p92DnUsw9HyCq4LbEd+h16HozGCQOKLqF61cdBWLbIBbTrgZuNWXDtUIQU5Q
 DHLG2TdMuMa3kHgVXeFr//FpfmIS95T+IJnDUsyvTS4UgRQa8RnZVX/tlTEPn63rhGaIDhzCKBn
 BlvmeLAa8FjRjkTzflbzt6nAJQJNnv99VENO8gw8577fKCFc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: JHeRQ4jff-M1igZ1mOuNk5Lk2s-wtvRw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXzhFGZJSPYjR/
 VPINE00us7Og8klYDUqFn6F1dv8ZHKqvxT7RNv9s/DM885Yq2OPnTrpsls2R6Z20Pr3292fIgEk
 DGRvd/F5HjcYuyRhNnYFEkf2WXJ/YieXMyjoxHO13/5gYQDGZeBKDBvZn0VSJxQ5hpytuI7uoL7
 FZrxWqkHUe+AehFxf6LsRABK85GZ/HLZG/7Hbw0YahBeOZfRHE0iMkeKASaB6T6ZJuOaIFzKbSw
 copCgRS66lkK4oRrpvdcdKRWPsU6bV9YFw1D0To/evLc4huA0cND/Fq5z46aBTYFuFRhV6zQ5hJ
 1MDGiwDu0/nXp/5d92xZYX7Vygp9LOGZqrLoWkbnPwMTl/KQ6xKcr+Jg3D0sCg7ebeA4yqCAKZp
 gxy3+17gjYWc/Aqb1hEo+zWoFtnm0TTDKcjuYJsyrU2M0BW/0rwIDLUGGkd1RpJrJbjskwHgENB
 sON1oExS53DRnHLV5ew==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX8+vwd45l8E7K
 4CUDf6BTWI2z6LnrgwYwQD9pnUHWMBrrTbGOCaQCkFEzvRwdyw27HUBV4TgFMpqB2SL/xkguMi+
 qRqAvoICJiRzV/sxFA3EAqyAIPs0TQ8=
X-Proofpoint-GUID: JHeRQ4jff-M1igZ1mOuNk5Lk2s-wtvRw
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad61761 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=jfrLVL6Nzc9eZwqZ98kA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190052
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

drmm_connector_init() already registers drm_connector_cleanup() as a
managed action, and that now cleans up the writeback state too. The
extra action registered by drmm_writeback_connector_init() just does the
same work a little earlier, leaving drm_connector_cleanup() nothing to
do. Drop it.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 272012a70efe..0c5d2fbe7a7c 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -16,7 +16,6 @@
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_framebuffer.h>
-#include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_property.h>
 #include <drm/drm_writeback.h>
@@ -303,14 +302,6 @@ void drm_writeback_connector_cleanup(struct drm_connector *connector)
 	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
 }
 
-static void drm_writeback_connector_cleanup_action(struct drm_device *dev,
-						   void *data)
-{
-	struct drm_writeback_connector *wb_connector = data;
-
-	drm_writeback_connector_cleanup(&wb_connector->base);
-}
-
 /**
  * drmm_writeback_connector_init - Initialize a writeback connector
  *
@@ -321,7 +312,8 @@ static void drm_writeback_connector_cleanup_action(struct drm_device *dev,
  * @formats: Array of supported pixel formats for the writeback engine
  * @n_formats: Length of the formats array
  *
- * This function initialize a writeback connector and register its cleanup.
+ * This function initializes a writeback connector. Cleanup is automatically
+ * handled with a call to drm_connector_cleanup() in a DRM-managed action.
  *
  * This function creates the writeback-connector-specific properties if they
  * have not been already created, initializes the connector as
@@ -344,17 +336,8 @@ int drmm_writeback_connector_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	ret = __drm_writeback_connector_init(dev, wb_connector, enc, formats,
-					     n_formats);
-	if (ret)
-		return ret;
-
-	ret = drmm_add_action_or_reset(dev, drm_writeback_connector_cleanup_action,
-				       wb_connector);
-	if (ret)
-		return ret;
-
-	return 0;
+	return __drm_writeback_connector_init(dev, wb_connector, enc, formats,
+					      n_formats);
 }
 EXPORT_SYMBOL(drmm_writeback_connector_init);
 

-- 
2.47.3

