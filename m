Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A07606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ArmHmbIL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CZTYMkOI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266D610F885;
	Wed, 11 Nov 2026 00:43:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D36110F873
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:24 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB0FJ78725912
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hhveaKbmmmrP1w+Sni0lZMyjK8nAFckdknPCkhp9J44=; b=ArmHmbILUuUtsadw
 nWEPIL8Tw+H7j2TWvIODSCkbPxgChOY6fbgLnLnu7KZLOOlVekdLrRmRShwJZYJP
 oYD9EqTVQWRbEIstWQVeqzaFjyr6EcFV+YqS7NLi8+Q7sSmB0mxL1Uf9tzEzxDIf
 NxO03sD3Cy3DUtQMyY7/xcOtu9AjuSaMECeE5xIHYa0e3oLyO1PZR06kDMcGFoOH
 OGIcwPWjg6gGnWfYslAy1dbuOaYHrTuB1ozETvFwaVCrYCpVleVcTaxvDzv55lpl
 ZozBtmSKCmOo+z50kPNvTNqODU5AiFnF2D1WFVhPPtJcvk7kaUwEHMsfEQx08FYV
 JGB08g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnm82n1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91e98bada22so51362876d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357802; x=1794962602;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hhveaKbmmmrP1w+Sni0lZMyjK8nAFckdknPCkhp9J44=;
 b=CZTYMkOIeKk9WURcsaIJqh30lnX72EGHrfE5QDLFOnKKxDl5hw1i2mPOY31HLTi/7I
 FVBMpWhKN5Gez6jjfcIP9YTyI5dh8U4/ACz64HHucBvMNsXgL6s445S4z2MX5X6XhtT2
 /wAVutu/BtZTRY54HaU+CPUhCzRVZfljiIlz4mya8rztJjopS8OAaGAZ7Kfcw6LJT1/2
 P49NFlVqmYV0ytrLFmcJOFon7V9oYZKq5bWXLlEbeHaR4Y1FZ7IF8UIutVVBRTvks7sf
 Zbiie/f3xCBhFsnPJNMLF9R9SKZH5csT9sZnfxoNhr9kHJAn/zyXuQfJMIeNJ5us9JQS
 1wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357802; x=1794962602;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hhveaKbmmmrP1w+Sni0lZMyjK8nAFckdknPCkhp9J44=;
 b=M+lNBdag/J/cqC0wNk3GcjQ5eOwJ22IQhTOzsEvatUnWTNO3S6+KUd1b7gLafxB7Od
 SUY3CqkoJsoSCmU0hkil+Nc6bvyJkIcl0Dbjzz5vtyDI6CjMHjmwhp/dRDmbzJ0Azzrb
 dLHQYH4ujBkqlNkt8ug/kvOVpllRinp9m7yRth1H5/AP2dAhySm358FnsjHoWOE+0zbw
 WyG/ceM6VjAteqMymOuVFItV/Vdi9QkozEPHdUK39bi34k8jonOBiQtFj6Zttvdn+29i
 8YO+8gyDff7zsXG8E/lKc0UZS33vPv5fe/CIOftIEzXrGyygb8GNdJ6CNk+9+1VXcS1Y
 QAmQ==
X-Gm-Message-State: APuU4Z/i5mbiscFsSH6O7n1SjVLI7b24SxZDTyuWp668XZmW6biskBPw
 xIYVJdVYI8YiFxOu8rAQpFnEiqUu3vYJ+q0doXzCOqrP1LXWwtIQXQGDJsWLz7s/onpbqjLtuOt
 tWtyTX828CMktcThyWxC04fIvwBhpH5Eq8UAB4FKkYTojbYgSLzM3ANXXQk60znpjJHyf0f8=
X-Gm-Gg: AYBFou1RwnhhNifK2IC6K3+lSCT90Ml24y7V5OyqWEUizbCjIjmSxef1sN7Y417yBMy
 af3mGY0MM8HSE231cQ5i66JtJy0kh3m1PSLbQ8d+mejsgjjf+ZKXFyjxNjfQMy1Ig9qEi8ZHdoz
 JZkK5Pu00nDylPzqxnI3oPyubAw4gjpqFMSHLOblW2tDePxpE9QYktIAin1Y9oy+9q7SMF6et2A
 0hGTG/g+LZJXofkZgxc0DUUaCcOoE/T2udvMwEDD9aQTq+g5bZKwuFKSV3t1Q3NtlD59SYcahXU
 /TnHEkq/8zDvTOQRUFiQkKC2vbfTSdaHuXuRGeH3Xb63T2MnoJlPz1fEF5wgE2YKXowW1YTQ1gi
 Z3bhUu+qByxIqb58dnSATgwqcxHkA4hYguzEfk2nyOVWemak3mDSFKnG08NIQ7hKmfxKNK7Ozaj
 8zvtbP2qKe5bQtLqWm8XmEmk29jhhPgUM6RcyqK2cKi6IWaU1P8KQV91CoftEJ/w==
X-Received: by 2002:a05:6214:d86:b0:91e:a629:ff92 with SMTP id
 6a1803df08f44-91f04196dd4mr18149536d6.42.1794357802291; 
 Tue, 10 Nov 2026 16:43:22 -0800 (PST)
X-Received: by 2002:a05:6214:d86:b0:91e:a629:ff92 with SMTP id
 6a1803df08f44-91f04196dd4mr18148396d6.42.1794357801033; 
 Tue, 10 Nov 2026 16:43:21 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:16 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:35 +0200
Subject: [PATCH v8 06/10] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-6-62948ed87d13@oss.qualcomm.com>
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
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8350;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=wvKxj/weq4r4ZxPKaEMkccXc+Kqhd05QUrApI4aY/UE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oO56imQXCPnVcLCoJc7EVpFUdmAkmiwiJjs
 DKzNFrZ25OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6DgAKCRCLPIo+Aiko
 1XvNCACpqHYibAHqx9CrcrvKX7v7KToL77nGbW0BpE/3brMkQw5Au+kpj7nq7PT/fw73Q0PRsAV
 oKhCfkmuvYa9IsYzA2dJ6CTKy6yNNJ+YgU1U86C3BOi1dyWIiSuY2nXqIGxVjBTV7sBPh7FRAyl
 Re0sqtsmSv7k35XyQNMgd82L+rUC7BRfUAuJnt5K5FcMuV0jDcS1Tvqhjw3Lpd53sH6nDG8+obn
 RV/SOXsFd0beBgLVxDEbw0IYIJcbTj44dIHpm6k6z8tLQcDuEKPFrBQpqrmWoKFkJvnPFfYSb+6
 PnzfQHJLHFOk0VYLr17RNNmZAt1Z1MIjebJ7J5s5dqRYA+kV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: qNXhf2Na5HaNWyU--w9xKWmdpzRTUILm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX8cO2HWWfYm/m
 gybbzRygC63DiGvmgUSS8Bpni1iu/b5UpsTDe0fwMgtZpx9VQl2OcHegwPq4VAgig0oaIyvxz/H
 unHE3RFT9fqm7b2oMRvJwAKz2sDuumo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX2BSj54rOE1ZR
 kXzGXWYsmwtljDgOK4bFgmKwqIAcrlV0xFJdYiSvE5bb0RRu0FR7tgoeZ2p3seVeSlzmTC7TOcv
 z0Rd8FD9k7CKOa51VGVHVgZnb9CZSnDqEXICA9MiHCTyMu4OLCwjdNaMkHHTNJokoW3zq66LuXF
 oJ3NfJ06iMH0LQ4suunCQfiCsKVgwvaa9YaJkvRf+BcTOpMLIMURl/oBPlDw6OCGcYpIXTMPqqE
 /oR1Pc+inKIkp/Txe+eWyxohKgufaMbecceuG2YY1bDpuV7xaXdnEAKBekJstA0coYHYXjqlaw4
 txeMOYLdDcgycuTvspSxCvQ6F8cQzNCtAlwR6cG9VfVyDbOMdHQR9s0STNr53wozWZHzV92fKN9
 UrCqyHOr4Ymb2gEqxrS8QTHXo6rKQhs6c7aNxCGfGDSB4ziX4Sq4PUojVCoCp0Yug68VODQR94A
 SqsZpbOHeDFY3ixaz4g==
X-Proofpoint-GUID: qNXhf2Na5HaNWyU--w9xKWmdpzRTUILm
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af3ba2b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=s8YR1HE3AAAA:8
 a=EUspDBNiAAAA:8 a=KeTiLIfg1DN4_MrrFvcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110001
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

Rename drm_writeback_connector_init_with_encoder() to
drm_writeback_connector_init() and adapt its interface to follow
drmm_writeback_connector_init(). Drop references to the "custom encoder"
from the documentation since it's now the only way to specify the
encoder to the writeback connector.

Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c    | 10 +++++-----
 .../drm/arm/display/komeda/komeda_wb_connector.c    |  8 ++++----
 drivers/gpu/drm/arm/malidp_mw.c                     |  8 ++++----
 drivers/gpu/drm/drm_writeback.c                     | 21 +++++++++------------
 drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 10 +++++-----
 drivers/gpu/drm/vc4/vc4_txp.c                       |  8 ++++----
 include/drm/drm_writeback.h                         | 10 +++++-----
 7 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index e0ef23f692d4..dde02b2b018b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -262,11 +262,11 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 
 	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
 
-	res = drm_writeback_connector_init_with_encoder(&dm->adev->ddev, &wbcon->base,
-							&wbcon->encoder,
-							&amdgpu_dm_wb_connector_funcs,
-							amdgpu_dm_wb_formats,
-							ARRAY_SIZE(amdgpu_dm_wb_formats));
+	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
+					   &amdgpu_dm_wb_connector_funcs,
+					   &wbcon->encoder,
+					   amdgpu_dm_wb_formats,
+					   ARRAY_SIZE(amdgpu_dm_wb_formats));
 	if (res) {
 		drm_encoder_cleanup(&wbcon->encoder);
 		return res;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 7b795e1c5705..ea4589b00ee0 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -186,10 +186,10 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return err;
 	}
 
-	err = drm_writeback_connector_init_with_encoder(&kms->base, wb_conn,
-							wb_encoder,
-							&komeda_wb_connector_funcs,
-							formats, n_formats);
+	err = drm_writeback_connector_init(&kms->base, wb_conn,
+					   &komeda_wb_connector_funcs,
+					   wb_encoder,
+					   formats, n_formats);
 	komeda_put_fourcc_list(formats);
 	if (err) {
 		drm_encoder_cleanup(wb_encoder);
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 889d0d1db85d..3669d10540bf 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -239,10 +239,10 @@ int malidp_mw_connector_init(struct drm_device *drm)
 		return ret;
 	}
 
-	ret = drm_writeback_connector_init_with_encoder(drm, &malidp->mw_connector,
-							&malidp->mw_encoder,
-							&malidp_mw_connector_funcs,
-							formats, n_formats);
+	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
+					   &malidp_mw_connector_funcs,
+					   &malidp->mw_encoder,
+					   formats, n_formats);
 	kfree(formats);
 	if (ret) {
 		drm_encoder_cleanup(&malidp->mw_encoder);
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 683da368e339..89c36f1414ce 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -165,8 +165,7 @@ static void delete_writeback_properties(struct drm_device *dev)
 }
 
 /**
- * __drm_writeback_connector_init - Initialize a writeback connector with
- * a custom encoder
+ * __drm_writeback_connector_init - Initialize a writeback connector
  *
  * @dev: DRM device
  * @wb_connector: Writeback connector to initialize
@@ -241,8 +240,7 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 }
 
 /**
- * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
- * a custom encoder
+ * drm_writeback_connector_init - Initialize a writeback connector
  *
  * @dev: DRM device
  * @wb_connector: Writeback connector to initialize
@@ -269,11 +267,11 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
  *
  * Returns: 0 on success, or a negative error code
  */
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-					      struct drm_writeback_connector *wb_connector,
-					      struct drm_encoder *enc,
-					      const struct drm_connector_funcs *con_funcs,
-					      const u32 *formats, int n_formats)
+int drm_writeback_connector_init(struct drm_device *dev,
+				 struct drm_writeback_connector *wb_connector,
+				 const struct drm_connector_funcs *con_funcs,
+				 struct drm_encoder *enc,
+				 const u32 *formats, int n_formats)
 {
 	struct drm_connector *connector = &wb_connector->base;
 	int ret;
@@ -290,7 +288,7 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
+EXPORT_SYMBOL(drm_writeback_connector_init);
 
 /**
  * drm_writeback_connector_cleanup - Cleanup the writeback connector
@@ -320,8 +318,7 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
 }
 
 /**
- * drmm_writeback_connector_init - Initialize a writeback connector with
- * a custom encoder
+ * drmm_writeback_connector_init - Initialize a writeback connector
  *
  * @dev: DRM device
  * @wb_connector: Writeback connector to initialize
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index a1271fec9874..a88408124758 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -217,11 +217,11 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 	drm_connector_helper_add(&wb_conn->base,
 				 &rcar_du_wb_conn_helper_funcs);
 
-	ret = drm_writeback_connector_init_with_encoder(&rcdu->ddev, wb_conn,
-							encoder,
-							&rcar_du_wb_conn_funcs,
-							writeback_formats,
-							ARRAY_SIZE(writeback_formats));
+	ret = drm_writeback_connector_init(&rcdu->ddev, wb_conn,
+					   &rcar_du_wb_conn_funcs,
+					   encoder,
+					   writeback_formats,
+					   ARRAY_SIZE(writeback_formats));
 	if (ret)
 		drm_encoder_cleanup(encoder);
 
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 642953cba25f..6ffc54d23d48 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -601,10 +601,10 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_connector_helper_add(&txp->connector.base,
 				 &vc4_txp_connector_helper_funcs);
-	ret = drm_writeback_connector_init_with_encoder(drm, &txp->connector,
-							encoder,
-							&vc4_txp_connector_funcs,
-							drm_fmts, ARRAY_SIZE(drm_fmts));
+	ret = drm_writeback_connector_init(drm, &txp->connector,
+					   &vc4_txp_connector_funcs,
+					   encoder,
+					   drm_fmts, ARRAY_SIZE(drm_fmts));
 	if (ret)
 		return ret;
 
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 879ca103320c..958466a05e60 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -137,11 +137,11 @@ drm_connector_to_writeback(struct drm_connector *connector)
 	return container_of(connector, struct drm_writeback_connector, base);
 }
 
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-				struct drm_writeback_connector *wb_connector,
-				struct drm_encoder *enc,
-				const struct drm_connector_funcs *con_funcs, const u32 *formats,
-				int n_formats);
+int drm_writeback_connector_init(struct drm_device *dev,
+				 struct drm_writeback_connector *wb_connector,
+				 const struct drm_connector_funcs *con_funcs,
+				 struct drm_encoder *enc,
+				 const u32 *formats, int n_formats);
 
 int drmm_writeback_connector_init(struct drm_device *dev,
 				  struct drm_writeback_connector *wb_connector,

-- 
2.47.3

