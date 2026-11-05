Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F9606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQfRaZZy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 718C4112C6A;
	Fri,  6 Nov 2026 09:19:00 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF7810E284
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 00:18:21 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-53644b28706so18142791cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 16:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793837900; x=1794442700; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2RfzmInKLxcVdPe2pyLqd5yFU8xZtV1axjF/Ql8v5bI=;
 b=uQfRaZZyCdhyoqh++IpUNk5aXGSLi+K1mplgtS/noRXaMbXfxJ/dzftb/TNUsZZB5J
 rj8dOHKGWOv6YupXj7FckHet4q5RxdPzP7mK9sqJqS4QlI7E1KUe7lwMJiE8iKj6/xfZ
 PyjDgOryairw99GfiZgzh10HX3SqRLZZs2jgIJbH1enIIetbvNW9GV63kcjRz2/nEvCK
 1NQoz/g/N5PzUSRfN+U+ZfCfpNdGIp+DwbVOPQ+k6rU3n/c6g9cGRGs7YuWwrg0/Us2n
 in4GuydVPQ19QlHFD2A4FJzfDFaiUy8BAH5NCpZyRi2r115Z1ZvszcrtH48xowhKpdsb
 /t/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793837900; x=1794442700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2RfzmInKLxcVdPe2pyLqd5yFU8xZtV1axjF/Ql8v5bI=;
 b=JDMTl3WUF/QzN++RSQDrWNH8T+TgsawP6SAfypnNN9bsZAkpmZ5X7qCWfLolgZVFGo
 ZM6hhyMGyNG3gkDayDHep6ATXIaQ/uM+QONGUeT5r0F0INM9Xx2Bj2Ke79+SApLdp11F
 FQ1xNphtzIi1Qto7JTNZC1PWTp6cQ2lJEpo5ftG0VE6XRa6xrk237A6Ht2YvUUELOXDs
 a33QJqoIMEp6tnNMiZkOPwg881GJboIXRpZ5iYDLUrQWqmqU4dv+x4mWv+c0xTM+A1e+
 ADYdzUftYt+LCScOjWVeioOWfuy0vvi8QIHux9J7pp3QCoHQSRJy1fmqGBx7i9BzPJuU
 epJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWrJlck/iC1+r+Y77vFygpSETUevuPNm6og4mxO1kYkMsjNPODthvtWDPG6miX0xVDz1iEKTEj/Po=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/S3w1QRoLbgsGzJ9ypiWuJHIyEmOZwzbgNnRq5Nbkv9owYvgCM
 LOeVHEHird1Y5li/utc2JjyC6st6Y6FPhqLAoAa1xeU3I2TxdKDAK14r
X-Gm-Gg: AYBFou2/OUhUp1R84B4DEvIjjxYWW+07Fhc/8qDEjywv3NBE1fN3tizSHnj+guw14Vy
 xwkQQfzMn4H3an8gPTs2Jp13uhqoHHisLD2BVQmqCfjRe5pBllIHhhvolyztK3zOCgOnQAwjKR3
 iz+kUP+o+iX5QKncrG/kOZ9b1o055S42yFFsHVInKnV7dvLgDoKcRrFXYTAgrOgJrDL0YOh+eLv
 DsfwwFNtULihwsqudaTNmQTe4zk09cuN/8tWNz1yeGvevy7rlyTc1H6MvzE7Cr8PRueHiFlPNC2
 rBALKZ9jeOzjSos47F8QzGBJEiigR39aNV+TCUcXrUFOPFUrXTneRzi+8YEpNyObQ/ZN2rET5Uk
 28X/lvo+xrCWmiekRVCfpkLp4+nTa/xxPRIRqUon7nlrZfgY3qYtTyI23gLYL6qyXNEU3Kvg+CL
 qWHY4V1MOsDxaW4LYm7+AgByuDMg0F2McVAgkFN8iVu57V08mQHfdgWP5I0MtQMJn7B0f3mdc4d
 drGyAkkWVuex1bQqDjqIw23+wtoauUs8tpQPpkyDTbsYfx4hl7KUb9rK3qQaBCC88ACkz7ATqLH
 0vRGB9YW86y1hOTavg==
X-Received: by 2002:a05:622a:393:b0:535:bb7a:884b with SMTP id
 d75a77b69052e-542b62a4c8bmr301056311cf.27.1793837899712; 
 Wed, 04 Nov 2026 16:18:19 -0800 (PST)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91e7e76be8dsm32655966d6.41.2026.11.04.16.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 16:18:19 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Simon Ser <contact@emersion.fr>, Alex Hung <alex.hung@amd.com>,
 Daniel Stone <daniels@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] drm/colorop: Release the object ID in drm_colorop_cleanup()
Date: Wed,  4 Nov 2026 19:18:15 -0500
Message-ID: <20261105001815.4000596-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The drm_plane_colorop_*_init() functions add the colorop to the mode
object IDR, but drm_colorop_cleanup() does not remove it, unlike
drm_plane_cleanup(). When a driver frees a colorop after a failed
pipeline setup, its ID still points to the freed object.

vkms ignores the setup error and registers the device anyway, so the
stale ID can be looked up from userspace. With one allocation in
drm_plane_colorop_curve_1d_init() failed through failslab, querying
the IDs with DRM_IOCTL_MODE_OBJ_GETPROPERTIES gives:

  BUG: KASAN: slab-use-after-free in __drm_mode_object_find+0x2e8/0x320
  Read of size 4 at addr ffff88800b681020 by task getprops/79
  Call Trace:
   __drm_mode_object_find
   drm_mode_obj_get_properties_ioctl
   drm_ioctl_kernel

Call drm_mode_object_unregister() in drm_colorop_cleanup().

Fixes: 9cf87f864d83 ("drm/colorop: Add destroy functions for color pipeline")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
 drivers/gpu/drm/drm_colorop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 95da03d6c65c..edfb4d72d166 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -183,6 +183,8 @@ void drm_colorop_cleanup(struct drm_colorop *colorop)
 
 	if (colorop->state)
 		drm_colorop_atomic_destroy_state(colorop, colorop->state);
+
+	drm_mode_object_unregister(dev, &colorop->base);
 }
 EXPORT_SYMBOL(drm_colorop_cleanup);
 

base-commit: 3944ca3e6b7d25e545e8ef6498f69941e8e0c8ae
-- 
2.43.0

