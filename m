Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E6CCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8C810E2D1;
	Tue, 23 Jun 2026 19:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="EZd5R1+S";
	dkim-atps=neutral
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com
 [209.85.160.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3C410E2D1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:33:22 +0000 (UTC)
Received: by mail-oa1-f97.google.com with SMTP id
 586e51a60fabf-43cce8288c7so166554fac.3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782243202; x=1782848002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cCKG9LoZ8KLcemxYdcqINnAkBf0hjfWSdjJ68Q/B0s=;
 b=aLmCtI1id1FFhWlqSNVz9SEuM+YXqnPMzM/iA29Ptp8Qc1gGKfU/JHAavJBNkfLLaZ
 RWq88u1ua3PvPuUEHuFHmNAiiJQv6ZgNiJnb7FHFQ02X4W5v5YXQVjqmWClwhYDXTsFw
 YQ267G5ockxVY6hpUGCP1JlOv4+T2bgzgKfSbHLUjdGUjcoeNo4CwWvXLRNlzWLgIiRf
 gqvZfB/gwawRXlIGhl2ETmtPvNrTzhx+dt3c1omqgiZ/vqxxNt655rSFjjCxLwMD/0LE
 M9k7Qhsidh7otVAHoNNfwWkzPGjfsuuYh8txCRNrXB44QpE+u67BwqHUU2KTKqlrKBRt
 DJwQ==
X-Gm-Message-State: AOJu0YwFEMFFruCOxXJ452ShrfRAKf2e9YI/O5ZQTPxfsygyHPPpkfJ7
 UGRzqbYJAS6lXPOmICnvBJ0NKyFa+6ihgPGrWvEKHQawA5nhrPSZJ7L7p0+7oFlVTjMiEc+R5TQ
 BTzEF57doRxtb97LRLyb/SPNkbpzQwVM/pSoFM3DcfWJ+IQBqK5S29ZrTJyMZ//58RZjUdCQMiE
 jpJHgUgR4jfDRmO/9M6UP09rjZaRIcHv5Djqe3SeOtnHLumV8IvcyM4CLAWYVVYrYY7tY6AgLYa
 Xe+sE6MVaiqvVd1kT7D
X-Gm-Gg: AfdE7cnHhnHzQEakgg+Z1TmyWzkkoqfwLy+FHNIJKuukGyy5bLtKZ2aAOIHusfxiQcD
 8v4kXxiDxXCMkI2ZYDh9uMAytrwUvY4dmSbLn30fFhrxDYdu2KeickYWBAzZJOItbGyhfSQnXCo
 yEKWwNwWWzPhNnCunmFNx47Xr123EobCQTjiNByclTi15b0EU74u+ce6G8/VG8Ty8eYAbiiMH++
 wXqPRPqALis68x7xlAI8txne9nA5PVGkkxaRPOD2ilurySS+xau/01kcqlLRKeKIzLkbE9bNYSI
 1DuWIV3/rBD5oDM1Yz0hM2jJunXkPj/3/uSmRy5c8qV95bTO/aKzk1yFtryAPmhoTVXEhw1ZtAA
 sVPhFNwm3Iod7+7uZTomw2JpUyCmuxDyi0tEUAaAx/JSi1G6s7a4eDP87MawFsFwgDTpIjLJpCu
 +Oa0otbywQ4/7G0y/D1gnAmUBp5xt65p/UeO0yDztO9DVXNg==
X-Received: by 2002:a05:6870:3c8a:b0:447:3081:a4c5 with SMTP id
 586e51a60fabf-447dcdd5400mr169605fac.10.1782243201745; 
 Tue, 23 Jun 2026 12:33:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-4472edca751sm1120112fac.7.2026.06.23.12.33.20
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jun 2026 12:33:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92229624a71so20954085a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1782243200; x=1782848000;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/cCKG9LoZ8KLcemxYdcqINnAkBf0hjfWSdjJ68Q/B0s=;
 b=EZd5R1+SK5qLo0uyXeNo8pP8bCDiurxQ61byz+VRukNpOHeKDnjcEYovvV19L1oHnl
 EmhPQK2meYDrWXSuxM0O0sdpx+jcrz+cALInBik+qYWwnBHnoIfpxd3r2UZBbXjOU3Yg
 dT8xskxymX9DObOj92GKukq2jcLofZtYgYa8w=
X-Received: by 2002:a05:620a:458b:b0:915:f163:a8 with SMTP id
 af79cd13be357-9278124afc7mr83972285a.53.1782243199833; 
 Tue, 23 Jun 2026 12:33:19 -0700 (PDT)
X-Received: by 2002:a05:620a:458b:b0:915:f163:a8 with SMTP id
 af79cd13be357-9278124afc7mr83963685a.53.1782243199149; 
 Tue, 23 Jun 2026 12:33:19 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fd390e76sm357643885a.3.2026.06.23.12.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 12:33:18 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH] drm/vmwgfx: Validate vmw_surface_metadata::array_size
Date: Tue, 23 Jun 2026 14:33:14 -0500
Message-ID: <20260623193314.506257-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

This field comes from userspace and should be validated against specific
limits depending on which Shader Model (SM) is available.

Fixes: 504901dbb0b5 ("drm/vmwgfx: Refactor surface_define to use vmw_surface_metadata")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index b2d3927b5567..bd0563741e89 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -78,7 +78,7 @@ static int vmw_gb_surface_unbind(struct vmw_resource *res,
 static int vmw_gb_surface_destroy(struct vmw_resource *res);
 static int
 vmw_gb_surface_define_internal(struct drm_device *dev,
-			       struct drm_vmw_gb_surface_create_ext_req *req,
+			       const  struct drm_vmw_gb_surface_create_ext_req *req,
 			       struct drm_vmw_gb_surface_create_rep *rep,
 			       struct drm_file *file_priv);
 static int
@@ -1503,7 +1503,7 @@ int vmw_gb_surface_reference_ext_ioctl(struct drm_device *dev, void *data,
  */
 static int
 vmw_gb_surface_define_internal(struct drm_device *dev,
-			       struct drm_vmw_gb_surface_create_ext_req *req,
+			       const  struct drm_vmw_gb_surface_create_ext_req *req,
 			       struct drm_vmw_gb_surface_create_rep *rep,
 			       struct drm_file *file_priv)
 {
@@ -1521,9 +1521,21 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 				req->base.svga3d_flags);
 
 	/* array_size must be null for non-GL3 host. */
-	if (req->base.array_size > 0 && !has_sm4_context(dev_priv)) {
-		VMW_DEBUG_USER("SM4 surface not supported.\n");
-		return -EINVAL;
+	if (req->base.array_size > 0) {
+		if (has_sm5_context(dev_priv)) {
+			if (req->base.array_size > SVGA3D_SM5_MAX_SURFACE_ARRAYSIZE) {
+				VMW_DEBUG_USER("Invalid Surface Array Size.\n");
+				return -EINVAL;
+			}
+		} else if (has_sm4_context(dev_priv)) {
+			if (req->base.array_size > SVGA3D_SM4_MAX_SURFACE_ARRAYSIZE) {
+				VMW_DEBUG_USER("Invalid Surface Array Size.\n");
+				return -EINVAL;
+			}
+		} else {
+			VMW_DEBUG_USER("SM4+ surface not supported.\n");
+			return -EINVAL;
+		}
 	}
 
 	if (!has_sm4_1_context(dev_priv)) {
-- 
2.54.0

