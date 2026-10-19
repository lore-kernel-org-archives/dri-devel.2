Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E16ECCF2E5
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 315A010ED12;
	Mon, 19 Oct 2026 13:13:00 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3FBD10ECFB
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:48 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JCsO9v2483323
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S7nJSSePe19a+M+g6PxMBInmxs8mUq4HTiTkNQcAnA0=; b=DyAgfWMKSzCiuNiL
 jxBH1qF2fgWAoPvlIHVI2vV+Vwwm/HyIEudioyHkcvJcuRZwTBwQbRb7UsYLHVN0
 3G/O5bym3ff+iN0CVhhlmybGoTxsrTuxJDnE9SCmfZhHOkHfXPTdGXwOznRSTaGo
 eIlv9qbe1EYPb5KSGFRaC6ZpZ+klf2NJKsRE99LmJFSJFuGQjjZWL7n34zSWKhG0
 OlQy8R37oxSW7ofDrE9S9urdhc6LIyw8ND6xY5jBFGy52RWYkHZMuB1XSk7aUezX
 kD2wu3QyLhX4uss495l7K9Om4J7FlgiLph1bBXYetwGlK23oizc6Zmc/tC3IRj4I
 aV8oQQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfg2ud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5338c59f90dso56873201cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415567; x=1793020367;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S7nJSSePe19a+M+g6PxMBInmxs8mUq4HTiTkNQcAnA0=;
 b=jgBabCJ9OUvnIdt55iLJAorHMxHwqjq6yyjvQ0JPFgx1LoD8RH5t7Tcb4MtSLvjQ9G
 fH6oWFAGD0FpBJNd0tF6gPP3nvObtRL31w4GRj0HU2kgPxYd17AcwwnO01wkrYxoSYqt
 jvuqu8TNVZwHKWrwDO/Ujmw+b49vDEjzHNgfMtDcTeOzAMeYflonJXgpeZVMO7JKVTHq
 hI8eJZZsST3bYvfj64RKorFYkb4B35cWKgfGh2nMSa1ZhVkUYbTdq3Y5HCmfKw29PkEk
 BBMMNhhDGh8QKiYx5HbyfIhaMQCH56h1+2HSIan6u19J2avtRhYfULCMs17CKtCkOXMI
 lTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415567; x=1793020367;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S7nJSSePe19a+M+g6PxMBInmxs8mUq4HTiTkNQcAnA0=;
 b=u9WdbTiqYmtR8R2Mk4sdmPkgLISsTaTGvQK4bGo+Q2JLIbYEQpdUrKBOzsNSdfUwYh
 nFGvnDuDFRSXDTZxVIR16gflsXbjrOG6Y/MUdELTnBM86arotq/nbkdRFQNIxAu3I/9Q
 4tncQV+WGXE3q1J5E/QKWnqrMbRnlcKi3fK8zjw2UhLrsWK+SLPlz4FrUwoe2TlBss/8
 k8AOE6wKRB+X6s3Zoh/OEUw0TVwSrDOnt+ARY7RERz2Rl257iKVajBXWHSVNifdHzcUj
 tzt7dBk0rgVfl5FpqNlO+cGFR7Uuwf0EuWb3lBpRx0fojOHZ0tyvNY2Fwdgj3cg3ECQo
 Kutw==
X-Gm-Message-State: AFq9FYIf9B8DFrXni77owv3QuXXbSmpHM6j+nAlMwZFBxqKLC7RGCCY0
 kTYI5d5IqhWMWLXKLedBQR9j8Bmfay/UYAErDBojwTPSOBqsDVzjRK7eHumTqvW2WsDY/Wx8Eoi
 J/R4h2WB9l7XI/h6EZpj6go8ZUmg7Jw9zOjVXhaVW9F3B3XB9Oghgq8M4jYwQKYlQvI8LBfs=
X-Gm-Gg: AYBFou3xr1AV9nwtH4RqNH5hTxf0jZaWTaKJHGJ5e523u4Xz5PGyZrNqgL8GHcbJZTQ
 MJ4fDVbITLAvSIGzE4Ghy/ieixf9YJ3sxvEvHWFXfDLMFnon8tIjnz2HHCEzWWwKtAKlQ9FKiDE
 CV4t5V1OHxjEXU2WPg8wJtDMrLBUIyTT7kXuRxzPWb5DjSXinojwjuNKtgL+INLsKrwF42e3SXu
 PUZX3OtT2qViR/obSCENVa4E5lNBm3PKR/dn/uUICDlOmXsFdKpSSfT2JIsgEa5gvDNnG/p5c/S
 11l58BypcHW8tnwbjvnBqWKUxRhiNXMoVDYRvTXJ+/az6yjIBfnibOYXQG+9YMWrTh03rywb19c
 7bmEl5NWjkF0ZQI9wC4XWw8pYp1cSuMFl5Bijo4CqE88BcM3j3OVpl6IimTmNfDIzt/e07BCBtE
 72tIT4CEHDDigJ
X-Received: by 2002:a05:620a:a2da:20b0:93f:2571:c317 with SMTP id
 af79cd13be357-93f2571dc9dmr860033585a.28.1792415567104; 
 Mon, 19 Oct 2026 06:12:47 -0700 (PDT)
X-Received: by 2002:a05:620a:a2da:20b0:93f:2571:c317 with SMTP id
 af79cd13be357-93f2571dc9dmr860029985a.28.1792415566587; 
 Mon, 19 Oct 2026 06:12:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:12:28 +0300
Subject: [PATCH v7 2/9] drm/komeda: embed the writeback encoder in
 komeda_wb_connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-wb-drop-encoder-v7-2-d4288a26eb54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NrouW+lVauNgON0jHseun6cAAxKf6ZXGanxiaBIsFlw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdD1DCtkA+u6NCRZ4TR9cfpMtSBKJoh68S5B
 5WR8CKWtDSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXQwAKCRCLPIo+Aiko
 1fXhB/9ueb/k6E6h5LRWhJ/DwQxRqBdV5htWru57d+0lMYqSjcmijqPs+FZP0q9YXQds03fXB4b
 TfDAdzNVIeBJbUVpEHobAVDjg70zFwtbRgm2XVOUZBwT99umeLuU4Svk18tl90BRqdKmtPnm2y/
 z1HXgJitz8eANW4yE63Z/VCTngNgXcn/HFqj3U7LheWzUKeNZFeYxb4PWsJnM3qCqgLf/IIksTb
 /5SbNXJBEoLb2X4RWfvbSiImpfOkiznb6pfitjNpsQf2QLIzFCkvzWmEKX1d3t8QcrcuyOyWaf1
 CB4Bamk7lyQeGc6kpH/F6WedLX4owP8WHJEzNtDXMS8pPI17
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: Zv9JJDAyWMhnJ8VgonuGZx_8a9qrbNOk
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad6174f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=eOsO5XS9GAZRO-ePzeIA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXzFb8kV8hYRYs
 +GnYIbm9XRV62jkZyxEDn0YZPVXiDTJ6LiF8MI3JyZCyDHyv/wY+vEd7AnCuK3Gb2o5wTqLnUIG
 mZNqKeIeo5oye6dhEsZgQvVtZVwah9CwBURXvmqqG4yzd2jSzl5aRTVEO/5nk5Iim3pGP4ejZ/K
 RjIa6u4iXJoJHEXx6D/B7SlR5VFJvQ/mYHcpYesofgupyuInUu9Q84JKRG/8Ggpye52lg2NdoaF
 PVazrQEYQakaT7wP8AyvBiDjVI7hz18UwOylGBRvgQ/mn3IvB4lgVxlOq0MDaxikZpvEowYfSH5
 vDvxgpplHd+YIClbeGgEOtA92aIyWc/yqPo6KVSCTOED3KoZQqEKFDiEWmHCVcIUd5Y3nt1XQZm
 IAIrKUmfstDWuD6T2Xy6L2uJTGHH5bNIE7gSnOjYIjuJR7+relNe+PF3Z9zAsH1P80f1UnbI+HI
 1dVyvxMgcgBZ3VfEQZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX0HCYF4VMJwIO
 x8+d296bimiMxt81bgqlkezdhZcsHBGX1QEiF9/+oTHJHxfEplN6Bn+6EYW8bHXtvD/gn0fndmj
 5WpOB9pqNN4uli6rBACmerMGpvhWA6I=
X-Proofpoint-ORIG-GUID: Zv9JJDAyWMhnJ8VgonuGZx_8a9qrbNOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

drm_writeback_connector_init() hides the encoder inside struct
drm_writeback_connector, which is the only reason that structure carries
an encoder at all. Every other writeback user already owns its encoder.

Embed the encoder in the driver's own structure and register the
connector with drm_writeback_connector_init_with_encoder(), so that the
encoder can be dropped from drm_writeback_connector.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |  3 +++
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 28 ++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
index 83e61c4080c2..4d41681a834b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -56,6 +56,9 @@ struct komeda_wb_connector {
 	/** @base: &drm_writeback_connector */
 	struct drm_writeback_connector base;
 
+	/** @encoder: writeback encoder */
+	struct drm_encoder encoder;
+
 	/** @wb_layer: represents associated writeback pipeline of komeda */
 	struct komeda_layer *wb_layer;
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 4872253a2449..77aecf4d3f09 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -127,6 +127,10 @@ static void komeda_wb_connector_destroy(struct drm_connector *connector)
 	kfree(to_kconn(to_wb_conn(connector)));
 }
 
+static const struct drm_encoder_funcs komeda_wb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_connector_funcs komeda_wb_connector_funcs = {
 	.reset			= drm_atomic_helper_connector_reset,
 	.detect			= komeda_wb_connector_detect,
@@ -170,18 +174,28 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return -ENOMEM;
 	}
 
-	err = drm_writeback_connector_init(&kms->base, wb_conn,
-					   &komeda_wb_connector_funcs,
-					   &komeda_wb_encoder_helper_funcs,
-					   formats, n_formats,
-					   BIT(drm_crtc_index(&kcrtc->base)));
-	komeda_put_fourcc_list(formats);
+	wb_encoder = &kwb_conn->encoder;
+	drm_encoder_helper_add(wb_encoder, &komeda_wb_encoder_helper_funcs);
+	wb_encoder->possible_crtcs = crtc_mask;
+
+	err = drm_encoder_init(&kms->base, wb_encoder, &komeda_wb_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (err) {
+		komeda_put_fourcc_list(formats);
 		kfree(kwb_conn);
 		return err;
 	}
 
-	wb_encoder = &wb_conn->encoder;
+	err = drm_writeback_connector_init_with_encoder(&kms->base, wb_conn,
+							wb_encoder,
+							&komeda_wb_connector_funcs,
+							formats, n_formats);
+	komeda_put_fourcc_list(formats);
+	if (err) {
+		drm_encoder_cleanup(wb_encoder);
+		kfree(kwb_conn);
+		return err;
+	}
 
 	/*
 	 * The writeback connector is associated with a single CRTC. Make its

-- 
2.47.3

