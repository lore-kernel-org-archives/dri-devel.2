Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34261C5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA8510EF62;
	Thu, 20 Aug 2026 08:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HJOgebtM";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D588B10ED94
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:17:34 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so1288230a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787131054; x=1787735854; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HgKYKxxGawS+Y3KPMd3fgnzXO0x1m/t52oc7d3V1CPs=;
 b=HJOgebtMfKLpxeGYBTGfMLCv1/HTpg+0PbBUkw7ylLazj+/ujJXJ4mhYfM6pbj4r42
 xJqjah6zcXAoAFXm+VM3giPHwOKKwBdRWSP+cSTq5DaH9b+H0z6SG4CCzK9blFfzZvs9
 Awi0usFutcSoMp6WaLR+NI2FVGg+URQi1SWU9ggXr4RSPG/CoC3SBHB+BUS5nflUzXf0
 H1OUMMhJEBnVPVU3C0tYoivu6DCKeZfM42UXdE9XdNYMRq/c1bLqLmYSrAMVtBcjo3GA
 6pteEsDKWAX6lUs2rwj9uT7LcCZWBPMJwqUPODuBFKvg7Z/N0jqV6tjes9V2zzicbNNp
 QCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787131054; x=1787735854;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HgKYKxxGawS+Y3KPMd3fgnzXO0x1m/t52oc7d3V1CPs=;
 b=Qc9Z1CUiZjeWqG0Lr9r1e4gD+txTRi5w9HnsZFRPVOx26WZDw3TRDT8eftdTmHT6yZ
 EdestK1SJ9KmfwvcENOvq+SC89oalLhvaMnWi10b1owwCuoFngL9G+0SDEtK5mzieMqr
 bUsNTho5xohpJA69pYbtd0EFObMj6OGJI5Yq/szKAbE46BoqEQaTipI0Zl0MG9tzMIo7
 aAGGJBOlq1dd0kvR8vqgKwnOrl16IcBYbAXTyl0C5jceCHbyoAxlruUcUb8gAXzOD3rM
 wVxpKwYIdB2kIM2hXHeOmkRuLN7Cm8i8WjspXs8RKVwR66HDOHdRg2QIcblCLaFAxzHi
 UNyg==
X-Gm-Message-State: AFuF++nu5tMYFjAdS0WAWpVGXs7iA6qILFJ19zZb6fxmrPL4O1x3B6CK
 oDmlwdYCO641KG5qmtySvlXT8FnDtI0G86zENdy+If5friPED08ltCmC
X-Gm-Gg: AR+sD11vTMuuSUe2GJ/Ldph9uCSXpR1+Lo9V2BmwlDpNX9Gd6DeghNjYhyAd883CJL/
 2iLX3lLlcx+uan29CXBOLO2eS7mQ6iqmGMgvBTHYg7kS8wB430SdkzDfJ67ACADHHCbLKuamyTf
 S+9swGtK1z0+3qlmmFaBfJxd2TMseU50DqtsJsOsU7tKvrYcoPVtncs10irCaYDeiNmMpclCxKV
 BAg5M+KbqHRNaRtrkDekSlKX9IATMoes3JHEJ4kOf8O7HVGhEM25P/Zs6xefvnHndyZzyvazu5r
 R+HIYnu3IPuxPyynkByjryKTPKMUq/0dxE0yrKFmUWOqgK6dwxYPl21eGva/ywfhL2ROr/ILhr7
 HYDIlcaOfnF8RS7sB8QHhY3h/MtgE4BtpTjA1Iy7KsPh/hQGbWDmV8lu52linv0lmHR94kvoi7D
 g5DLY185msMQpEtSmWn3J08ysb/bp9EiCgPKxdmU0gt+ikxQuHiilCoc3O3jFPGbJgZsfKgg==
X-Received: by 2002:a17:90b:4e8f:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39580a50d67mr6579598a91.2.1787131054307; 
 Wed, 19 Aug 2026 02:17:34 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.101.42])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb30541sm1875737a91.13.2026.08.19.02.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:17:33 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 19 Aug 2026 17:17:01 +0800
Subject: [PATCH v2] drm/nouveau/nv04: check cursor buffer object size
 before upload
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-nouveau-nv04-cursor-oob-v2-1-63eb8d0c847f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIx0hWoC/4WNSw6CMBRFt0I69pl+DBpH7sMw6OcBz0hrWtpoS
 Pcu4AIcnuTccxeWMBImdm0WFrFQouBXkIeG2VH7AYHcykxy2fKLUOBDLqgz+MJPYHNMIUIIBrS
 TpuVcOFSOretXxJ7ee/ne/Thl80A7b7nNGCnNIX726yI27/9LESBA9QqNOjsplLsNk6bn0YaJd
 bXWL7GoJb3QAAAA
X-Change-ID: 20260813-nouveau-nv04-cursor-oob-ad2b6001de3d
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787131049; l=2269;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=yKd0NOqvnUZEXHXx+SmVyZErpDxsdELkJs/BqkIVgrQ=;
 b=3C4upJJdGASxXPTYB5K57J6xhcml4PoXkh2TeciUednabbD7qnhs5S1jUJs0UdydjzTeemBIR
 b9h0HYcOlVFCXGw7fZOCKq5rljXg9qF9dLGLhCHUbCGf4C2W8UCaqMt
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
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

nv04_crtc_cursor_set() validates only the 64x64 cursor geometry, not the
size of the backing GEM object, before nv11_cursor_upload() /
nv04_cursor_upload() read up to 64 * 64 * 4 = 16384 bytes from it via
nouveau_bo_rd32() at hardware-fixed offsets.

nv04 uses a legacy cursor_set callback with a NULL cursor plane, so
drm_mode_cursor_common() passes the raw handle to the driver without
building a drm_framebuffer; the framebuffer path's size check never runs.

A client with DRM master can thus supply an undersized GEM object and
trigger an out-of-bounds read, as nouveau_bo_map() only kmaps
PFN_UP(size) pages.

Reject undersized buffers before mapping, as gma500's
gma_crtc_cursor_set() does. The bound is computed with array3_size() so
the width * height * 4 product saturates to SIZE_MAX instead of
overflowing. The check precedes nouveau_bo_map(), so the error path only
drops the GEM reference via the existing 'out:' label.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Suggested-by: Lyude Paul <lyude@redhat.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Changes in v2:
- Compute the size bound with array3_size() so the width * height * 4 product cannot overflow (Lyude Paul).
- Link to v1: https://patch.msgid.link/20260813-nouveau-nv04-cursor-oob-v1-1-3f3eb37d213d@gmail.com
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index 500fd77b87d1..07251cf83df9 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -1000,6 +1000,11 @@ nv04_crtc_cursor_set(struct drm_crtc *crtc, struct drm_file *file_priv,
 		return -ENOENT;
 	cursor = nouveau_gem_object(gem);
 
+	if (gem->size < array3_size(width, height, 4)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = nouveau_bo_map(cursor);
 	if (ret)
 		goto out;

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260813-nouveau-nv04-cursor-oob-ad2b6001de3d

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

