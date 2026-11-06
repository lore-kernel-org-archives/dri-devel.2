Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB672606EE9C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pg9iyBc5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dag591+b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D9A0112D9D;
	Fri,  6 Nov 2026 13:45:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F9D112D99
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:42 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6APCuI2076103
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 13:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X74gM1bp+SoEVAkxrQgSjNlyuK9X9pX12qrSj0XV6aI=; b=pg9iyBc5WIMupZ9y
 VA7bc0RKC7mqvAH3ZqmJ3zDwPKrjMEp2I4Tuu81EODHGyzwHeqErGAOvVCOouQGZ
 9XSZXh+/7siDPbkBxrKh+BOOJQnfAfK5yQDAy/0sSNY/9C7SK2Yh3fD8zuKfvrXw
 4DWMJftjR9pVcWOlakPaucfIJ88rVc5DeHn4aQA6/TvcEcDyg3AhEapV4ibpmCPn
 p985hIy0ESjDZwgpDHE7KZqp8X3ZL9tOgaRm8yXhcZ+3xHWfV34SdEVfQqWQEuvg
 JUBJQiS1qORcUkQxEhKxiwE4ooLjIIm7DJKRwid3FKvxL5km1R2fvc9GtnjUK/sV
 zGnb9A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pcaycj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 13:44:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so152753385a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793972681; x=1794577481;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X74gM1bp+SoEVAkxrQgSjNlyuK9X9pX12qrSj0XV6aI=;
 b=dag591+bm/QlaGszX1RExU40NkwQIAE9gr6haeFQ1xfJViWsXBnzbv99b4joGXNs0S
 OPtk3aSScgwbL5k66PFeU9jq4KSHilbnXLqgbnjSQkwljYHaLL2vBur4VT4TWmNCMmia
 ZSPQJXFWVgFXDn7oewPSkCgJoYFoOLENh1BCewp4PyCOGQftTtdkZs+Tl00HLaJFRhyr
 FjWFBKL1i2ruVSUzJtWbBA3wvrpEYjadEqCB3mNU/Oa+oOg4awdOdnjNSMVrOya8Zj5F
 1cjn/sCGn4l+bH+L9mU1IY1lRqewf/s6Wm0b1ZyE/cVIUQMnvIKzl+lHFxD2duFP0k//
 uoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972681; x=1794577481;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X74gM1bp+SoEVAkxrQgSjNlyuK9X9pX12qrSj0XV6aI=;
 b=Cj0a2mGfOnuiSEC8agvRMp7w0sH5wBYhUjOJeuOHV3SF1AhPkqIDJJt4LPkiDNKZLw
 Is6GhkC/aDo/RriaATG9QRBm1UWj6UF2dL+s3CJ5HQjoYfnwahFzWubs0sVQGsB6ypL8
 Jk1Ym8PvKw79TJ1G3AWy1PUaz1mBbxJnNp09HtafJzFT9ushBcsIIRh2yudoVwX91xqQ
 F217jt1LKCTcXaKOCF12ZkHpQI0qp34DYcAk78FCLCXMx1YKhD3nD3JKOlzMccGcYXJu
 RMYCIEsoxU2WStaC7+pT1OQ8So3RNEC3bDD2KR/QF8Nnm467w3hq0fIlSjJfGPqCJBhF
 1fhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAXpDZ3Bibqo1OIEw1q0vkUNF9DvMe8d1i2BTBwPt7fPB+KSD1Q6/I3FpeRqxGLpxd4MpJmC+IBug=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/j+JQ+Zs69uhm5PRX9zgmoMnptmpi7epduh5HqZWbS2bfZ1Foy
 b+YicDRxMSwTW3miD0VaUD47BoY1yxvrpSimTj4iktgndnNpA9mTwR4/9ikZnwgm9Mw7HCFi5Rj
 TmpoF7HSPldGbcXs7tw7elzh/UiZ73p9vj4Ouzzvea1D5/2F9cwxJr3RoWmpZQXW4GKnt4B0=
X-Gm-Gg: AYBFou0xYhPGW1nf5QLsnLRcLWIqJeOTe53SDmT2qeNO8tzDcS3COvpFOZCExiaXopW
 SED8NqA5XNsfhFEQB2IRNceB+Qv2Rj1AssGFma+kgYjIU0XxX7iowWcHx1el7dw38FGjXJuE4S6
 49x7KIOBL7XGf0GlJEYhsMsqKIDE5felptuTQlZzmHzLxeTJ3CAH56hfSKCIJzhGfnfnvWm3Y4R
 w+qbAqkKQOfrNtYf6rrBcM3Gtbi1nxAU+uJzKJEZwr7uuvT2Ew/cXabwLlF/mHOxIKtBqSXof4W
 eD9x8O4phHxbA/ntLNWsJfttLJJADUehbG3L8AxzH19dq81tQQrDizzmyf/j8QvNQ3ciVCc19UI
 s0K84Jm7gRaHGpB6/rsKvoKmSMxx4/5RD3ncJK+tS35DpoFIHJyqs/x/j2unxZe51Q1FW95nffh
 wx45iT+HneBw5ueEfphNZX5il1A1NmeDiu1sm0PAfUmOUaIHpTkdBKSewaOorKlQ==
X-Received: by 2002:a05:620a:4515:b0:93c:6534:d04d with SMTP id
 af79cd13be357-945f34ffe72mr328908685a.35.1793972680836; 
 Fri, 06 Nov 2026 05:44:40 -0800 (PST)
X-Received: by 2002:a05:620a:4515:b0:93c:6534:d04d with SMTP id
 af79cd13be357-945f34ffe72mr328904385a.35.1793972680295; 
 Fri, 06 Nov 2026 05:44:40 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c003055a5csm382747e87.13.2026.11.06.05.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:44:37 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 15:44:09 +0200
Subject: [PATCH v2 3/8] drm/msm: move the UBWC plane size calculation out
 of DPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ubwc-format-docs-v2-3-82949f88f030@oss.qualcomm.com>
References: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
In-Reply-To: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8736;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5IhPgv4vcHizwDpAPh96mpXfWHFvDsJ77WdWDQntwOM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq7dmzmMoPIpfABi0aq2VOyhe9NZJKm/HiCBayP
 Y2rEaMdZNeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCau3ZswAKCRCLPIo+Aiko
 1curCACp4z5hzQ0f80ZRvD5UJrxNjVpnGhmVPetmQvA4Xhxx7kS3v/SnC0cvBTsMhEYjAv52pBp
 u0dEc6JYMy7CinD6/FPJflLdLsPuKUSxlBADmPp5H7h68CqRzyNW4irwzI/LlZgqJ3gfj6qDLgx
 aK7ANvDatSNgXgWGQb2MEac066R3E1t4UrIfbCiMWf0thd8jp6EB3br4PnNbEzFpXpyVUZggZST
 Wx42CkJ8diDF7qpVitmF6IzpYB32/n03vcq/6LEaAsUlg0mfTbYM8c+XdxYs+4u2L9eSgDzl5O3
 4x8itu/M/ZqgqIyhOp7+nh8EPaj+byVggz5fYk84Ejg0bzoV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Ku4v90hz8D-gbQeUbWvo9PZYbN1wCJwd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX6nY+VckKwblX
 wW/kqvy4xwW5GSvCRIKaC7vcxkyjtM6w1HLCpqXOXSztQZiB8DaeNyZGtFTCTV3Uif32iH8SOeu
 YlLKfCj1JMrb07+kfolphmDG1AbalFYTW51o88bjLY3TFPs3ICHgabXzQoHwUd0tN7Bx6BEz4EB
 UYWFQnXnZPyVT1cLA4zxPCR9g4C6gwbZiVXnFfGeNLkRhkALXOCfthxSVYrn6jC7mj0xUI9LIrm
 qCGyLmlOzJd90Q3C20tnWlrV+aH51KUJnHIvgJEXI+y6v0ZXsK6u5EnTGoU9flQ4xC7XSVuE8pm
 Qfw/2Xyi0OHdcRT2ZsViGpszazJuAuOMCDyfFKq/tWW5JLwxBCg0Z9Xpa6/ewyG6EMMIIO4U8Rc
 tNLhXC1wF8NZJbMEmjYPYuCpRDcdQFaY1NAPK2vFIShJufbbld9u4LUGerhfajGioUsFMvAYlhK
 aak0WbGuWXSDHJyNd1A==
X-Proofpoint-GUID: Ku4v90hz8D-gbQeUbWvo9PZYbN1wCJwd
X-Authority-Analysis: v=2.4 cv=TI3Q2Fla c=1 sm=1 tr=0 ts=6aedd9ca cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=iK4Z-rw_lK1HlppuerAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfXzhL2MU3+U5W/
 enWdfctC2UJf0qLaOhFwUwZiqH/eW+Bel5vGesx9cimuhzukOI4JZUaq0alymfZ4gFJbLPk+ND5
 +1id2TdKgVLqUDsHas/sUdRUE4996U0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060054
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

The layout of a UBWC framebuffer is only known to the DPU, which computes
it from the framebuffer at atomic check time.  msm_framebuffer_init()
cannot check such a framebuffer against its layout, so it applies the
linear size check instead, which neither matches what the DPU fetches
nor what userspace allocates.

Move the calculation next to mdp_get_format() and make it take the
format and the image size instead of the framebuffer, so that it can be
used before the framebuffer is created.  No functional change.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c |  84 ++---------------------
 drivers/gpu/drm/msm/disp/mdp_format.c       | 100 ++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h               |   3 +
 3 files changed, 107 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index a8e9a69834af..06903325e7e7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -10,8 +10,6 @@
 #include "dpu_kms.h"
 #include "dpu_formats.h"
 
-#define DPU_UBWC_PLANE_SIZE_ALIGNMENT	4096
-
 /*
  * struct dpu_media_color_map - maps drm format to media format
  * @format: DRM base pixel format
@@ -58,87 +56,13 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 		struct drm_framebuffer *fb,
 		struct dpu_hw_fmt_layout *layout)
 {
-	bool meta = MSM_FORMAT_IS_UBWC(fmt);
-
-	if (MSM_FORMAT_IS_YUV(fmt)) {
-		unsigned int stride, y_sclines, uv_sclines;
-		unsigned int y_tile_width, y_tile_height;
-		unsigned int y_meta_stride, y_meta_scanlines;
-		unsigned int uv_meta_stride, uv_meta_scanlines;
-
-		if (MSM_FORMAT_IS_DX(fmt)) {
-			if (fmt->flags & MSM_FORMAT_FLAG_UNPACK_TIGHT) {
-				/* can't use round_up() here because 192 is NPoT */
-				stride = roundup(fb->width, 192);
-				stride = round_up(stride * 4 / 3, 256);
-				y_tile_width = 48;
-			} else {
-				stride = round_up(fb->width * 2, 256);
-				y_tile_width = 32;
-			}
-
-			y_sclines = round_up(fb->height, 16);
-			uv_sclines = round_up((fb->height+1)>>1, 16);
-			y_tile_height = 4;
-		} else {
-			stride = round_up(fb->width, 128);
-			y_tile_width = 32;
-
-			y_sclines = round_up(fb->height, 32);
-			uv_sclines = round_up((fb->height+1)>>1, 32);
-			y_tile_height = 8;
-		}
-
-		layout->plane_pitch[0] = stride;
-		layout->plane_size[0] = round_up(layout->plane_pitch[0] *
-			y_sclines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
-
-		layout->plane_pitch[1] = stride;
-		layout->plane_size[1] = round_up(layout->plane_pitch[1] *
-			uv_sclines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
-
-		if (!meta)
-			return 0;
-
-		y_meta_stride = DIV_ROUND_UP(fb->width, y_tile_width);
-		layout->plane_pitch[2] = round_up(y_meta_stride, 64);
+	mdp_format_ubwc_plane_sizes(fmt, fb->width, fb->height,
+				    layout->plane_pitch, layout->plane_size);
 
-		y_meta_scanlines = DIV_ROUND_UP(fb->height, y_tile_height);
-		y_meta_scanlines = round_up(y_meta_scanlines, 16);
-		layout->plane_size[2] = round_up(layout->plane_pitch[2] *
-			y_meta_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
-
-		uv_meta_stride = DIV_ROUND_UP((fb->width+1)>>1, y_tile_width / 2);
-		layout->plane_pitch[3] = round_up(uv_meta_stride, 64);
-
-		uv_meta_scanlines = DIV_ROUND_UP((fb->height+1)>>1, y_tile_height);
-		uv_meta_scanlines = round_up(uv_meta_scanlines, 16);
-		layout->plane_size[3] = round_up(layout->plane_pitch[3] *
-			uv_meta_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
-	} else {
-		unsigned int rgb_scanlines, rgb_meta_scanlines, rgb_meta_stride;
-
-		layout->plane_pitch[0] = round_up(fb->width * fmt->bpp, 256);
-		rgb_scanlines = round_up(fb->height, 16);
-		layout->plane_size[0] = round_up(layout->plane_pitch[0] *
-			rgb_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
-
-		if (!meta)
-			return 0;
-
-		/* RGB metadata is fetched through SRC2, SRC1 stays unused */
+	/* RGB metadata is fetched through SRC2, SRC1 stays unused */
+	if (!MSM_FORMAT_IS_YUV(fmt) && MSM_FORMAT_IS_UBWC(fmt))
 		layout->num_planes += 1;
 
-		rgb_meta_stride = DIV_ROUND_UP(fb->width, 16);
-		layout->plane_pitch[2] = round_up(rgb_meta_stride, 64);
-
-		rgb_meta_scanlines = DIV_ROUND_UP(fb->height, 4);
-		rgb_meta_scanlines = round_up(rgb_meta_scanlines, 16);
-
-		layout->plane_size[2] = round_up(layout->plane_pitch[2] *
-			rgb_meta_scanlines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index 2712a73e5783..3dc835c9b937 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -655,6 +655,106 @@ const struct msm_format *mdp_get_format(struct msm_kms *kms, uint32_t format,
 	return NULL;
 }
 
+#define MSM_UBWC_PLANE_SIZE_ALIGNMENT	4096
+
+/**
+ * mdp_format_ubwc_plane_sizes - compute the layout of a UBWC or tiled buffer
+ * @fmt: format, which must use MDP_FETCH_UBWC
+ * @width: image width
+ * @height: image height
+ * @pitch: per-plane pitches
+ * @size: per-plane sizes
+ *
+ * Plane indices follow the hardware: 0 is the Y or RGB data, 1 the CbCr data,
+ * 2 the Y or RGB metadata and 3 the CbCr metadata.  Planes not used by the
+ * format are set to zero.
+ */
+void mdp_format_ubwc_plane_sizes(const struct msm_format *fmt,
+				 unsigned int width, unsigned int height,
+				 u32 pitch[4], u32 size[4])
+{
+	bool meta = MSM_FORMAT_IS_UBWC(fmt);
+
+	memset(pitch, 0, 4 * sizeof(*pitch));
+	memset(size, 0, 4 * sizeof(*size));
+
+	if (MSM_FORMAT_IS_YUV(fmt)) {
+		unsigned int stride, y_sclines, uv_sclines;
+		unsigned int y_tile_width, y_tile_height;
+		unsigned int y_meta_stride, y_meta_scanlines;
+		unsigned int uv_meta_stride, uv_meta_scanlines;
+
+		if (MSM_FORMAT_IS_DX(fmt)) {
+			if (fmt->flags & MSM_FORMAT_FLAG_UNPACK_TIGHT) {
+				/* can't use round_up() here because 192 is NPoT */
+				stride = roundup(width, 192);
+				stride = round_up(stride * 4 / 3, 256);
+				y_tile_width = 48;
+			} else {
+				stride = round_up(width * 2, 256);
+				y_tile_width = 32;
+			}
+
+			y_sclines = round_up(height, 16);
+			uv_sclines = round_up((height + 1) >> 1, 16);
+			y_tile_height = 4;
+		} else {
+			stride = round_up(width, 128);
+			y_tile_width = 32;
+
+			y_sclines = round_up(height, 32);
+			uv_sclines = round_up((height + 1) >> 1, 32);
+			y_tile_height = 8;
+		}
+
+		pitch[0] = stride;
+		size[0] = round_up(pitch[0] * y_sclines,
+				   MSM_UBWC_PLANE_SIZE_ALIGNMENT);
+
+		pitch[1] = stride;
+		size[1] = round_up(pitch[1] * uv_sclines,
+				   MSM_UBWC_PLANE_SIZE_ALIGNMENT);
+
+		if (!meta)
+			return;
+
+		y_meta_stride = DIV_ROUND_UP(width, y_tile_width);
+		pitch[2] = round_up(y_meta_stride, 64);
+
+		y_meta_scanlines = DIV_ROUND_UP(height, y_tile_height);
+		y_meta_scanlines = round_up(y_meta_scanlines, 16);
+		size[2] = round_up(pitch[2] * y_meta_scanlines,
+				   MSM_UBWC_PLANE_SIZE_ALIGNMENT);
+
+		uv_meta_stride = DIV_ROUND_UP((width + 1) >> 1, y_tile_width / 2);
+		pitch[3] = round_up(uv_meta_stride, 64);
+
+		uv_meta_scanlines = DIV_ROUND_UP((height + 1) >> 1, y_tile_height);
+		uv_meta_scanlines = round_up(uv_meta_scanlines, 16);
+		size[3] = round_up(pitch[3] * uv_meta_scanlines,
+				   MSM_UBWC_PLANE_SIZE_ALIGNMENT);
+	} else {
+		unsigned int rgb_scanlines, rgb_meta_scanlines, rgb_meta_stride;
+
+		pitch[0] = round_up(width * fmt->bpp, 256);
+		rgb_scanlines = round_up(height, 16);
+		size[0] = round_up(pitch[0] * rgb_scanlines,
+				   MSM_UBWC_PLANE_SIZE_ALIGNMENT);
+
+		if (!meta)
+			return;
+
+		rgb_meta_stride = DIV_ROUND_UP(width, 16);
+		pitch[2] = round_up(rgb_meta_stride, 64);
+
+		rgb_meta_scanlines = DIV_ROUND_UP(height, 4);
+		rgb_meta_scanlines = round_up(rgb_meta_scanlines, 16);
+
+		size[2] = round_up(pitch[2] * rgb_meta_scanlines,
+				   MSM_UBWC_PLANE_SIZE_ALIGNMENT);
+	}
+}
+
 struct csc_cfg *mdp_get_default_csc_cfg(enum csc_type type)
 {
 	if (WARN_ON(type >= CSC_MAX))
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 2840e8a5052d..02fde07eb6f6 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -204,6 +204,9 @@ struct msm_drm_private {
 };
 
 const struct msm_format *mdp_get_format(struct msm_kms *kms, uint32_t format, uint64_t modifier);
+void mdp_format_ubwc_plane_sizes(const struct msm_format *fmt,
+				 unsigned int width, unsigned int height,
+				 u32 pitch[4], u32 size[4]);
 
 struct msm_pending_timer;
 

-- 
2.47.3

