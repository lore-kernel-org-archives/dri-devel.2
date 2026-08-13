Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A93C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D49C10E103;
	Fri, 14 Aug 2026 07:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D9AKsJlH";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029C510E35F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:36:03 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1849504a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 03:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786617363; x=1787222163; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z3AY/Bs9FDrd8H3tGAAndoQ/dkrF/oypF8YiYah5nNY=;
 b=D9AKsJlHQ5dz8KkNku+b6H/PijCsD8Jrb7UT8j6iRAn4NCW4PU/DAno2i3+TAWkK+d
 tpCrqHbINYABElVSeQVUTosGyoyEld3ENrF/BGMXNfJwSOk4wR3gAxlMr0gOd0xjUPVB
 OLqmLQFi+is7K2TAKr7k7ZbV/TtfSxhrazjS36P875JmvYyWQ0xoeC5RW5Wk/R8DAGr3
 QeT0W9Cv8BZMPlumQowejfr3FFsh5yKBLOCFFZvBUM/R2n8F24+sCnSW9icx/MrE2hHM
 TlLlV9eKqYFd9cMZOU52j074IKaOl5bTK+4dnfUoSTZ/rpIZEwYc1fnqURK7s7G9Euaf
 FiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617363; x=1787222163;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z3AY/Bs9FDrd8H3tGAAndoQ/dkrF/oypF8YiYah5nNY=;
 b=iCVX7HBWKtUmd83X/6/9rtlNzDi2OWx8fauCp0Hbj0U6B/1ocQerhZ+gv6kac5g3ls
 aZY0E6RxwE9p+pQsyPgnh8txi5DZaSkx6XBkn8n1+o9pi/aJHvZmXYkAX6iohZa6rfxU
 v7ajl3aTYnzfdpk6qXXLATutSljHeYt4vyk3Qtf4ql6gv4D+NypppwFcVNi3O4yjBEOr
 j3QG6jv8GkD5TQBquz+DDS+/qr8iGSODhJ4/XBQXxJEjqr6tVDZfwu6Zi66FpLgYD54c
 x+GeP4N3tRUZ5qtKCZVwryEB/AGeZrh3fSkth7tS8YXn3nEsgu3MRQ1hYBx39XOQlNhT
 2GSA==
X-Gm-Message-State: AOJu0YwbHtQP2YJgtI5Nnt8x8X98/2qy74UaBBHHWBLJzYQDwQDkH6jh
 D/YU5YwutzZlg3QAxPMc7hd8/0rzuib9XTCXuFk/ttds6RcqIbPCCX9Z
X-Gm-Gg: AR+sD13uOy1Bj3JFLr6uevGsZZG/CF6QZ1YOBjqb5/Ajk2A4VWFGTQEu7Y/LkDjrcK4
 b6/IEytQkUmZy20A6gU4+twVK0YxAdjPyrbCxOxvMfF3oBeyvy/dgXcbfY8CjUGOGzRTM7eC4A8
 0+Jm4g8oJBd4ATDb0VpWOF//VoD+k2aOCZ8xW5nps5/cuBfWwFSTEiVwCTtpLgqV94jZxffvEvn
 L4sTbSJEQu3wahW87l1hlUqjlL55y5UicsKrq/BF+BecplkJyMLRqmEWLH2B25bG3ecGFhewLRw
 J2ysbjXn7e8WPJ/vomg9ylvtqajqgUKHsda0rCs9zavRQAxpZZ6cbpgq7gG+dDajpVkgYyYfwOY
 mF/Ri3/RIGfssWd5P8gxPXrmXa3CXsyQgBDKyEl/6fL0ob1D4NxULASnFL5M48NiQqAsU0ipfzc
 ay2kx9ZX64y1Ni7+fedIaZd6cpRVxDVkXwNkCab+0TzTqBKcosdRZf/7lwYNI=
X-Received: by 2002:a17:90b:278e:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-3931e0242f8mr6100351a91.6.1786617363370; 
 Thu, 13 Aug 2026 03:36:03 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f41ce3fsm2381426a91.10.2026.08.13.03.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:36:02 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Thu, 13 Aug 2026 18:35:47 +0800
Subject: [PATCH] drm/nouveau/nv04: check cursor buffer object size before
 upload
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nouveau-nv04-cursor-oob-v1-1-3f3eb37d213d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAKefWoC/yXMTQoCMQxA4asMWRtIOzKIVxEX/YkaF400tgwMc
 3erLr/FexsYV2GD87RB5S4mWgbcYYL0COXOKHkYPPmFTm7Goq1zaFg6HTG1alpRNWLIPi5ELvO
 cYdSvyjdZf+fL9W9r8cnp/d3Bvn8AMrGehnsAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786617357; l=1859;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=meyb6Y2dzI5h7FZCiO0Odzp0AHqH1igJ4/zqrayN1Nc=;
 b=RNFf4wcl5LftIPZXfs3V3e6M/RvnsKRYFDr2Klg/361+meLcH5wFsHmX27P4vcahMHwYigsCm
 x9MU0ukgwrABPcno3tUpRryRAvmlcH+Rkiw0czCAWwMQsBzK44PWa6V
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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
gma_crtc_cursor_set() does. The check precedes nouveau_bo_map(), so the
error path only drops the GEM reference via the existing 'out:' label.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index 500fd77b87d1..0393025baa64 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -1000,6 +1000,11 @@ nv04_crtc_cursor_set(struct drm_crtc *crtc, struct drm_file *file_priv,
 		return -ENOENT;
 	cursor = nouveau_gem_object(gem);
 
+	if (gem->size < width * height * 4) {
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

