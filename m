Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8077C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E463A10F523;
	Fri, 11 Sep 2026 07:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s0Af+rxv";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CB110E763
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 16:00:18 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747eb79f6so12213735ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789056018; x=1789660818; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bXD/U7hlVPQRpHS1AI7lVEOW2y8sGkOWMG9ZHqUS/sc=;
 b=s0Af+rxvUmpH5czSptgISIYRw141PqEq94tSdWanp9YDD0IssetZawsRLxjb38B2Kf
 c3YfU6+WlMnWEo6QPUI6BFLtIs3f1pmHwh+DMuidP2LTmJWtcvxHjQrqxlcjQBgXqqlQ
 9HLIUwmCgw7MRVchG0cSJNLwOxsYkD6E6BOwvhFuJXQTg5cpYoj+25rRyZ5TymMBdcnv
 FKV02BchAE4sdvi9TRX+u9KImYb4JWxOg0bjMEUUCYORtCMyj0a5vD7aFDwDTNhIzNoj
 IPxiDUdJOJ7+qfj3gIDALiCrcyywGXxyV3QGXO7S4zpxciJsPT0ynYy21YfA1O6pTrsk
 YOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789056018; x=1789660818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bXD/U7hlVPQRpHS1AI7lVEOW2y8sGkOWMG9ZHqUS/sc=;
 b=F6jyoF8pwGIU3SmCRIhs1sF9nHwu65hIlHqImFZo9fH/QukDycsXChl09FxS+13mVJ
 3NkcRIqqVLXkKzqLZv+ugT/D0us5l6yUE+4zqahQnkMG+QZlHPHAHwS5j+FM0BWGfesf
 3ixYrsGeTtn4HWQLmBEiKFDgvh6iG3e0y7sFblzx0uP3YqErcw4SGr3NKyssj+PeHiiO
 QwpOhkEkMTyFcWZoWsgAjDeph59siZCcP4VezfOfn0J+ABMndHKGgSp+dTdq+A8lowOU
 KDQk33wKlzRMFWbcZS1bGkhNYhLHyzU0xjfs/iS3szWHj3emXXpUYoI3sK6PpDScl+Sw
 LaXA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQaUvHIo8cy6LCUoVjb8wmFMaOzuBmb1gnrel2qphqHGFvKUHIs6WUlwdT58oz4ttO21VIeGzDDbY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mJ6y9Nnfe6zWi9ZcU04BrGT1rr3k/r0PVSuLR1w0u3DofPI/mr
 qIliuHEOhoXsebwsYdAD8H2Qbz6YSVbfgEh1YgFeUdrgG1VyPcYlUkq0
X-Gm-Gg: AYBFou3hlRTFULlESwzg6mYacPC5VDTnxmEoJDk2sRbA9ekttKWzUH6QUKywkX+PzEZ
 Uv5i2YiCCqpceEKOrZ5ifgRR6lo0mxHl4+Gg2TRrYG5znNu1sI+4dEFJgbComxr8axhnHsXiYxH
 cCsKwKiMvavjYaRzdVGcwkL9IRGCo4SxO7wfAFRDdl8BrF4VCOXvyeFonOFXxd3BgVA5LFandDW
 I/q8NQEntpBSiPHC7WYrnnwKl6rLheHPFOSyz/wkhAUYMXstuyfd/+nCkhp1AMx2Dm1WaHJkEja
 D+S4rJ5XY9BzdRBEMLflbMua0Bw51ddaBuHiCVPDhFjiLatTIowAfc7e50mvFGoquelgfiyMOdQ
 Ge6xVi7Htff27DlrfC61Nrr4NUel5phR7DWFzsrv3yzxfUIZ1+deJfC3ofRZCo29d6zwy3+djNi
 UqeCzqi+3JW/ldnC7ZDsXr3TP7vAskk9ECjtRUHhSf4wr3WlkFUoW39mScCDcdaPaJMBPZmKw=
X-Received: by 2002:a17:902:ea0b:b0:2d6:3c22:99bf with SMTP id
 d9443c01a7336-2dd2a1ef505mr1333475ad.9.1789056017830; 
 Thu, 10 Sep 2026 09:00:17 -0700 (PDT)
Received: from G15-5520 ([103.206.144.4]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3397d6d1becsm15350364eec.22.2026.09.10.09.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 09:00:17 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org (open list:INTEL DRM DISPLAY FOR XE AND I915
 DRIVERS), 
 intel-xe@lists.freedesktop.org (open list:INTEL DRM DISPLAY FOR XE AND I915
 DRIVERS), dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] drm/i915/fb: replace kmalloc_array with kmalloc_objs
Date: Thu, 10 Sep 2026 15:58:45 +0000
Message-ID: <20260910155846.79513-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

Replace the remaining kmalloc_array instance with kmalloc_objs.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index 1c0859d5f829..c3e4c3f6d8cf 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -596,7 +596,7 @@ u64 *intel_fb_plane_get_modifiers(struct intel_display *display,
 			count++;
 	}
 
-	list = kmalloc_array(count, sizeof(*list), GFP_KERNEL);
+	list = kmalloc_objs(*list, count);
 	if (drm_WARN_ON(display->drm, !list))
 		return NULL;
 
-- 
2.53.0

