Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4889606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YSf4C42p;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wq9wA9GB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421DE10F883;
	Wed, 11 Nov 2026 00:43:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AEC510E0C9
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAN8js6570205
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EkeKOmV556G5oy0quwFksL6YgLAm3oPpd3qf7nvMs1w=; b=YSf4C42pqvHJUUxF
 W8UP3vMr9r32Ke0eoBq8Qg8NajOpybQ/nbQ4HeuzdAFfZS40kX2rZzIfVoIMLUVu
 QZHbmiHM7h+3d5asQzLo/08LTK4SXzq9Tmn4Z/n8LudSocdolhBeKveLx0uJW1B3
 stxmVMMMfpDOJ31H33LTXG0wmh13bgXSEKZX3fw1xSP3Ry7OXxJwFXbrClCeSq/0
 Rv2EfUrEP5TESLxX59LjDgeNRZXzpmY2KcPyrmst2eGBVfpQ2qg4Bei1G7KYS316
 kg1w0v8lGVS0FcPI42in3XtUMavGjuFymrTk17td7pLtEFVufKzm2uL+/ygDQfI5
 Whw1pw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvcpeg8xp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91ea4a2210fso30592796d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357804; x=1794962604;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EkeKOmV556G5oy0quwFksL6YgLAm3oPpd3qf7nvMs1w=;
 b=Wq9wA9GB3qqMOZRQJTfFPDOmDuiFE4Q2N8rRdUfIFKTHoLr2/9u+GP2pc5O3GrM9N1
 NDiyZ3qg8TddMgAEqbdPePmgK37oy9ZjJDQ4d6J8INEIDbcCp6DMPWS90Zk1D0xBgAfq
 l63xl5a/K9ie6qDtY73E8p9DTEAKaKaMcfZLn4Yfy/Ng4uFGKjll9g/uDgGqbdLKCppj
 QNS/M+fSLKKdQfbZIDpjbzIp7yWjO+H2a66a+y0lFPfSh1Q5hlP6teJyJzwWiBC8/Ylp
 HTfJwRTS1QMTHtZGZKv5gZaHuXO0qMlg1c4LxaNjvjykQD4q7v1/SD+/rFJ69HvGgCBP
 tCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357804; x=1794962604;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EkeKOmV556G5oy0quwFksL6YgLAm3oPpd3qf7nvMs1w=;
 b=XDxDw7mwo98Ndy24ljIkAkUB9GQC6AhYFYtxVEg+51Yyw3SkWYQ7Huo9obZrB1Iu9B
 YvREltI+vPK3ffuozMzEQnswHs0Gi+U8872DvAPPdqrDx+l9LRJgUE67bQiJfNLX7ruO
 VT3femic7nyW5ibdrVuk4uLqajCgNp/P2gOJdSjmS1j1y2caz4i9CoBd+j2qfdtEm2ki
 GnR9GxKgegPtqw/QXdyC6487Q4DykLHLO7+vGdngx5b2mv/1tuzxk7qADpF1ctagyj8z
 jw29KI+4eS2XD1AAzZSgaewdgNzBnO4iS13/OugP2iRBlsVK2DJoihK7dI6c9tz7+i3Y
 c5yw==
X-Gm-Message-State: APuU4Z/Ehhobf120DJeDojsYtEfpYcVWk+fKO6Ll5dZyQmWGrYkqfQGV
 kBAS4gqbio/kN230Rqo1cOvDFMrVdBkj57amyP0jdeGSJNCPqWzLyaqlfz325a/U4SbauPS0EgL
 1LbefF+UZtyH8JFDbXBZPQxE/y+7TAU2qw9/fWKqebNiQYqbv+qJMXSC0HzqfhWGAM4Mp2wo=
X-Gm-Gg: AYBFou0H0exepRu5SvI33/W356zKb4p/TqWp3eJBZ4Twvskll0w2NKXTxExQ1fqtvOd
 49Ps1AgHGkZdZx3xxVyJy4Nf7Ux5nHLcHCPmgfGqWgu+ZCPCV6gqAg999v+bjSsfjX8du/kKSL4
 T3GK/S5Yo5RTcZEcy1/BW2F6Dnk6orC3kFPLSlmYq7mUfbqfl8sUUs130TNGJ2kd1tsGrAKxP/S
 MmrV5nA3GoEgZMVUOo4nfPl5zDG/svOZZdMyOL/q7GSibah185oC8lCFBe768AY4py9kJYRNnY/
 8DKb0qeODRYU01xSSptKvTFFaHPMieilqkTith9F62qcsyakF1bBPz6MrrKE4bmr0bHaRXejdNn
 Vd+1DmfpQvToxw5mpE9WANYFXq4GdSSNtSsUsT5HdopnSHUIEXzdEeTROe/qeBjdw78+geACep8
 oOFgEZD0sakfLzUrIFxJakuHZHCKohyPQC82pwCXmsKHVVPDKyUO5JOvCjHhlqXw==
X-Received: by 2002:a05:6214:2249:b0:91e:bcec:dd6 with SMTP id
 6a1803df08f44-91f040e8cfemr18262186d6.34.1794357803339; 
 Tue, 10 Nov 2026 16:43:23 -0800 (PST)
X-Received: by 2002:a05:6214:2249:b0:91e:bcec:dd6 with SMTP id
 6a1803df08f44-91f040e8cfemr18261716d6.34.1794357802708; 
 Tue, 10 Nov 2026 16:43:22 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:21 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:36 +0200
Subject: [PATCH v8 07/10] drm: writeback: don't destroy the shared
 writeback properties
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-7-62948ed87d13@oss.qualcomm.com>
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
In-Reply-To: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3828;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZMmknsfr9fO2ooOGlXI2wiwkvAWhuDIhtJaDkPBlfcg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oQcX4TkBGw0MKdj9tR1CR0bhdMfpjNQjJM5
 EEMcRML3a6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6EAAKCRCLPIo+Aiko
 1cWCCACXQKaJYDW8pw84y5h0sLJnOub3GG15pTXhZIXisZVjqa147f+1H/z9+d++hwJ3NfPd4GL
 NyJm880aY0LY2YCE4t93ZuOtYOFwxAdvz5n+wxq+8fcvhIrbbF516WhHYtcVxFxuo4rXOGEKVSP
 wXr1mc4/+WbjqS4yieCKoO4REKOpzoUv/kLzkDkB/jC+E/JYlj3WLahjFT5Gp2pJuus3359xL1F
 puhRVaSD14LwKp0i3k7L3mQw6hG8+XHnZT4GkAjYOLLTfUAA+ZJvWYGRW5UyuHFjJnt7poQOtPT
 4ssFdYgIIuT1JOumLBcfCPGpxRKVSHgnyH4868wCjA95Mnn9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfXz+OJSneqzpYY
 2HEYPMj+OHU1oACz5oWUgoq/DfbLJtu4I3YmKb+roVJLb9UIE1Obp7LRVDiubqVTqKQnaGtVlR9
 V0I8f9KmT9bdhBbPqQS9xvTYQCVAv2m1goB5pMjPhdPoFbnHEd/xQGFS7UJjgZHtm6g5a//49d2
 pBMWeyHldZFhnHWF3n2AS8eh8hHHGm1b6H6geAP2ag2Ax8Lgnz2so6LQKo83YWMw3Gr3fxphMg0
 FejAak001JYlgjxNPvgy0qGsC/sSbssdMHsjS2IfkkcJDexCqxeYN3ysiQfKyVRBuPwGJn89Xoa
 z/HNtryu7p9o3oUCKDtfYFD69W5rRFLGKp3MufdoPYh9qSzfTef4GFud+DEerdSTMbLSaqu5A26
 T/NJjHtFM9pbFNG0v0L3FWlcHSKzGj34gbGH+ObErifyD2Q9pGkwGPL6rQhUHtULKbBn1DybSqh
 6tbNXqkm3uz0W+98Ezw==
X-Proofpoint-ORIG-GUID: 1MMGFCHivNOKlHKi1z-A4MdM1C4eKGqU
X-Proofpoint-GUID: 1MMGFCHivNOKlHKi1z-A4MdM1C4eKGqU
X-Authority-Analysis: v=2.4 cv=RfAFmFtv c=1 sm=1 tr=0 ts=6af3ba2c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Brd4iQZBKng0vAjXyHYA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfXxgcA2OVQWtQ4
 8v+7A2xKJ3IXib7gQNr2Tf/8hFAr3WcsjH3/QbJq6gC+Zrf4TqS1SbZMXcpsHd+L7DKLwJjpkj6
 ciH7Vol1qUeWLL+dywRFvOMvPbllRkM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110001
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

The writeback properties are created once per device and attached to
every writeback connector. Nevertheless, a failing
__drm_writeback_connector_init() destroys all three of them. If an
earlier writeback connector has already been registered (komeda and
rcar-du create one per CRTC), it is left holding stale property
pointers. The drmm cleanup action likewise destroys them as soon as the
first connector goes away.

Leave the properties alone. They are on the device's property list, so
drm_mode_config_cleanup() destroys them together with all other
properties.

Fixes: 2f3f4a73631b ("drm: writeback: Add missing cleanup in case of initialization failure")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 89c36f1414ce..2f6a7b50336c 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -148,22 +148,6 @@ static int create_writeback_properties(struct drm_device *dev)
 	return 0;
 }
 
-static void delete_writeback_properties(struct drm_device *dev)
-{
-	if (dev->mode_config.writeback_pixel_formats_property) {
-		drm_property_destroy(dev, dev->mode_config.writeback_pixel_formats_property);
-		dev->mode_config.writeback_pixel_formats_property = NULL;
-	}
-	if (dev->mode_config.writeback_out_fence_ptr_property) {
-		drm_property_destroy(dev, dev->mode_config.writeback_out_fence_ptr_property);
-		dev->mode_config.writeback_out_fence_ptr_property = NULL;
-	}
-	if (dev->mode_config.writeback_fb_id_property) {
-		drm_property_destroy(dev, dev->mode_config.writeback_fb_id_property);
-		dev->mode_config.writeback_fb_id_property = NULL;
-	}
-}
-
 /**
  * __drm_writeback_connector_init - Initialize a writeback connector
  *
@@ -198,20 +182,18 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 	int ret = create_writeback_properties(dev);
 
 	if (ret != 0)
-		goto failed_properties;
+		return ret;
 
 	connector->interlace_allowed = 0;
 
 	ret = drm_connector_attach_encoder(connector, enc);
 	if (ret)
-		goto failed_properties;
+		return ret;
 
 	blob = drm_property_create_blob(dev, n_formats * sizeof(*formats),
 					formats);
-	if (IS_ERR(blob)) {
-		ret = PTR_ERR(blob);
-		goto failed_properties;
-	}
+	if (IS_ERR(blob))
+		return PTR_ERR(blob);
 
 	INIT_LIST_HEAD(&wb_connector->job_queue);
 	spin_lock_init(&wb_connector->job_lock);
@@ -234,9 +216,6 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 	wb_connector->pixel_formats_blob_ptr = blob;
 
 	return 0;
-failed_properties:
-	delete_writeback_properties(dev);
-	return ret;
 }
 
 /**
@@ -295,8 +274,8 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
  * @dev: DRM device
  * @data: Pointer to the writeback connector to clean up
  *
- * This will decrement the reference counter of blobs and destroy properties. It
- * will also clean the remaining jobs in this writeback connector. Caution: This helper will not
+ * This will decrement the reference counter of blobs. It will also clean the
+ * remaining jobs in this writeback connector. Caution: This helper will not
  * clean up the attached encoder and the drm_connector.
  */
 static void drm_writeback_connector_cleanup(struct drm_device *dev,
@@ -306,7 +285,6 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
 	struct drm_writeback_job *pos, *n;
 	struct drm_writeback_connector *wb_connector = data;
 
-	delete_writeback_properties(dev);
 	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
 
 	spin_lock_irqsave(&wb_connector->job_lock, flags);

-- 
2.47.3

