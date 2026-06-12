Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E396CD98D2
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E39010F62B;
	Fri, 12 Jun 2026 18:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j1kCkMsT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SaZcG+PB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F10910F626
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:27 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGV6CJ047201
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jRi4QyMfJKJttBAEFdi1P15sbORxIAP33IpeK1RT27w=; b=j1kCkMsTOh3LWhON
 0QAKPzpA3acIfOXO/MvUweopgToy0P2xRi9aznHifE0+rqx+rgwxVa+amb51jiNS
 diq2pHZ3HdNXpLnuH/Y8YbB//wDxYLxd6pY0VEa6WNOA99OPxvS8iSEH3xtDC9up
 PoX4jX9sE5Vt6RQAkyTnGFs7JCsBrS37IDLHQPt/dsnc083oBVyOpRJUeGdP8ZKp
 Qq4EL7EYdFL6G6928vhzHGg7B3DIG3td+WYA9nEVqEAACrJxoWyf56n/pKwxPLti
 7K+ENyiNIW9Ed/7pTcKcHCxJHJz7oQI4oBDmb0ax0667GojX8TOl4NPEYVMSq05v
 eL/I9A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2u440n8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915767b341eso118571285a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289026; x=1781893826;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jRi4QyMfJKJttBAEFdi1P15sbORxIAP33IpeK1RT27w=;
 b=SaZcG+PBQ8JYYh84GImx18eozv22Tp5F819RrWUoC9w3wduMjufw0bglinp660lFom
 nSc2aZN5sINmfv4WAPRZ0JcofCxmLiSOGDjfXOzrq0xb/Il43Usz+SWzjnFZ68pHHjzg
 9dNbSCLrQqY1tJJizDrDEqJxGVR8s2Z+2ef0F/+M6I4fu3bihIO7q61EdMgPJL0iFAIu
 PYzGjFrlMdQ7NbSJB2oRZ43oVzdCxogUXdEAnLSqzPyDQKwkihOgyXnaW++CRyxfJ/oc
 2t9Y077nzrdex53saG2P1/9X6uc4evG8XrNI7ToeRmb1q7rqkYtTypv/MdIvnENa905q
 WWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289026; x=1781893826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jRi4QyMfJKJttBAEFdi1P15sbORxIAP33IpeK1RT27w=;
 b=RCicYUFnO+s1u+9aFcuiV96Z4QBVCV2DUaEn44ZsasSh0qmlmepqAZZNRnqG0YVwBB
 16UU3JbNV0GX/MulClOt7/WKc35hHv48ImjUnQjjC6YI6gf+UFwFc5JeQpjjI/+b4wMi
 mJbW9pbVhLxQxQPcw9k92iu+QiybCfVe6m+WhuwdULZpFWL+kLI0XIaJAECj+fkvgp+s
 R8J4WR5HPM1wCEBsLliPdrRtiR1XbKKz63QnYw03Z4qrDLCaUa0Ig7x9buGO7se1ixAy
 AcF7MsrVmOOniGlRiL54hjqfs3Tkg2hz9uyl4UYNMMug5nntMA33KxjP/SSFxUNd05o0
 PHrA==
X-Gm-Message-State: AOJu0YzRVyMlPLuHUviNDQnTlCIglrh6aNDtkZ5uND7F3RDaL7lA2+gC
 fvd9s9VsW+2gkFjkpb3ynSiPGL84M64OYvt1UgiMgJ5FOWdjx+dMbTOxHFcXWn1eLaicg4Uwi97
 mEC4SU6UerdgqOAK/vSXZZ3e9KLrOw0b5ZX7jSl2eEbLV/InqwQOJ6F8PQgKdcx7tVIUXwP4=
X-Gm-Gg: Acq92OFGWrurZlFjM7Q+NhLSJbt9UB0YKM+mkbFOu/uaoHL1tBhHLrC+fb4X/jd+hlE
 iOttCrLiAGGezDEBXOdyQs2Nwbm/W5DrCfNyNuJ7U7K4gAyVDOpyDccNvN6JjJ4BDXwOEBNk0kl
 AHdDQY88IQchjdtEGJ5nTiJHuYdrVWy9ayf4jKMb+lQR+hgiLzN72E3TtKOrtl/Q7yjF7RTHWKi
 iWJzRiDTWSFomfrmYmnTgYmZskPdp5nW9MS6pD6b/yMPbah7sjpCV4N0V1aknZWqShJ1UXItuk2
 a02N0hCXa9sT1+WJlin14wtREJz04Il+bBlLUzn7v8LoX8aJwGWm85zU5SRyjYUtBTtk515lzHo
 ouOVrkoyDZvxcJzn0QaZagLgP3OBkT0tnbi5vwzT5IVgmVcsg8e57AiAohN9VQXQQZoXJQo9OPY
 DhjIgziRZqEPHLmhMdOHDByZftI8cc9yLmmUA=
X-Received: by 2002:a05:620a:2714:b0:8ef:ca26:dcf8 with SMTP id
 af79cd13be357-9161b954533mr612528085a.0.1781289025609; 
 Fri, 12 Jun 2026 11:30:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2714:b0:8ef:ca26:dcf8 with SMTP id
 af79cd13be357-9161b954533mr612513885a.0.1781289024928; 
 Fri, 12 Jun 2026 11:30:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:13 +0300
Subject: [PATCH v6 3/9] drm/amd/display: use
 drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-3-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
In-Reply-To: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3286;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MbaRBOLwFT+ETgHAVWF3UBcaA1Q1ln0hWBI7tVGYbZw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA2TF8iWOsdGp/XNhFFMMbJIh1AWUGAs9E8q
 XZNuCdRYNKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNgAKCRCLPIo+Aiko
 1edSB/0VjeuYOMaO2KkI6CX4me4o/IauFy8eyB2qW0cOD6x73XUrx6wzyhhmPiEQs9KITW95Aux
 vOlO1OGm4WTd10dda61ZQYwFQCxUQCr7hUhOhpYfjLILW8d5w6LcrB4e/y4VO+m9yt89EgCxZ84
 m8nTMxnSfypw3OwMZya9EzwpgnFKQI/emxXRCB8fJh3mYb69roMD5FzqMiPiMJoG4uQMv9uPEea
 UQC3upMrVgAG8LSU+oom9Leb8S4NQuNZEWgRfKGNF0fMB+9rQvKjr7Ga6EL6VshD355ZdKH8cNv
 KCLIdEljpwWS5Cc5UowFwL+muSXLb74Lh/zEqFv53Rdxr5ax
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: BlXbd1q42EohK3IPPMn5YWa1NH8PICTR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX9XMN0pu4Bt1H
 Hznq8jqErHqbhdgRZ3kkTAelgOL1hnqE8Hx2KSLuRn7cgjuRBkdpvctS7ZWTFaYIeBDAiEGVd23
 +2hPomnH/MmNp0mkCdd9dEcW+5bDDmI=
X-Proofpoint-ORIG-GUID: BlXbd1q42EohK3IPPMn5YWa1NH8PICTR
X-Authority-Analysis: v=2.4 cv=N94Z0W9B c=1 sm=1 tr=0 ts=6a2c5042 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=P-IC7800AAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=M-qvw7r3wQx8XY5Jx90A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX8BjAp6D3O/UL
 ni4chMmmjNXWQZiw3CKAMEo1Qo0hTUlmouj3SHKfz0rsfqmyPyZJCu5Yl56PzbBmfOu7qp/F6Iu
 /nRlUwkZ4dZb2O+/oTp3UsFaqI/AJVTSVUFdojiTUJWgKVSmn1ckiGyEtId8mzqydJAX8uzpcpi
 rzvZeq2/kHz0gfpNAdJ/r58TLcQ0G39ylnlr1iROx60ucS9BTmBHcdJoKwoE/GUiKZDc4dVdb/1
 tUD+21UGHeQkxORYAmIjEa0ddr0IEkbjlOHC1IQpkEyTAyUqtyibgHEXbleDKPCgv6eQ5F/nJZx
 hWSHB797pvG3NsG7P5Wa+mQoUu2OdGk8N9UbO9kwbu0n37BTJkpSRtimTzwGr/FYhJA8djjeddG
 A7+Ex6GN9ieDT2I3vs/lcdUfgZrAV5YJ5+uPUfsFOg/2dQ18bdZDBboGwhaSnSrwQq+/zDJ5ny8
 8yM1Z4q4MtOQ9+BMO6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120173
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

The driver uses drm_writeback_connector_init() instead of its drmm
counterpart, but it doesn't perform the job queue cleanup (neither
manually nor by calling drm_writeback_connector_cleanup()). On the
contrary, the drmm_writeback_connector_init() function ensures the
proper cleanup of the job queue.

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 436562e32e63..066ba6b6ef76 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10996,7 +10996,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 		return;
 	}
 
-	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
+	acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		kfree(wb_info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 110f0173eee6..fdc3da40452f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -169,7 +169,6 @@ static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs =
 
 static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = amdgpu_dm_connector_funcs_reset,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -188,17 +187,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 	struct dc *dc = dm->dc;
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
 	int res = 0;
+	struct drm_encoder *encoder;
+
+	encoder = drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &amdgpu_dm_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
 
 	wbcon->link = link;
 
 	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
 
-	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
+	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
 					    &amdgpu_dm_wb_connector_funcs,
-					    &amdgpu_dm_wb_encoder_helper_funcs,
+					    encoder,
 					    amdgpu_dm_wb_formats,
-					    ARRAY_SIZE(amdgpu_dm_wb_formats),
-					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
+					    ARRAY_SIZE(amdgpu_dm_wb_formats));
 
 	if (res)
 		return res;

-- 
2.47.3

