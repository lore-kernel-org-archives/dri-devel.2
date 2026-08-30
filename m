Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B44C624C9
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F2010E6B4;
	Mon, 31 Aug 2026 07:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYVx4L/4";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E282910E1BD
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 13:07:26 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d6f624c323so25131155ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788095246; x=1788700046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ff+tAYyxP+Ja85LcjLz6eITSmOy44S8AX6xrfczNf6Y=;
 b=AYVx4L/4VkU8xMgOCNTd82CjIEWXkAtr/q6YVu+3t0JmJbCC2Z1hQnj+NDLWku2GTs
 ioBhFGyG58WcywQNcZCNRZiMgtQ9e6adidcOc/J/CHrFj5Md1eyfCb92caMrUEmvhRcb
 U8GuFR0267ML4fHy+xcZjrMycEiQsIYrabDvhc8BfAxB1tdmKldikvOElIpwZmBCmU1B
 13ey+PPTCfnsaw02WTdBBQbJjV5D3Xsu3pff+j0yU86gUykUJuqK0+Jq0SMBioYBaOCa
 lNOvqlux9+fll0Lb2OHWLBtt+e5fjnNhktgYT95ia4FHRJ1S524IvsSHcR0AhKUDgYsM
 z2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788095246; x=1788700046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ff+tAYyxP+Ja85LcjLz6eITSmOy44S8AX6xrfczNf6Y=;
 b=D18LubOrYPJQxpziYHJIEDrOgQrgwxfRbikaxfLN0Z0PVPU4+whubBJxFT2cAZ4dFx
 MhquISgAXi+9J5T/HCSFg3JTPxu3xTSpAfuGaEjc7AmAXGrB9hgreiL8RN3U+ei0/7w6
 7nS+NrKkbBH98cgfJnHBUrA27mkwBlyCgARPGTcEYbUaZJY5rv+e6DGa1122e+Her2hD
 YmbI4gK7UcETwTtVdbhln8Vg+F4Aj5BIsJQcPlZQxdx7IRA9EKg4wJ2IO/ycFaeFijgj
 w4Skcn9y4WmoxforvvvAeHolLLtK252NP05GF6TwmAiAOaLr9s0m+vqMdyZsTpnmm6Qt
 aqKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy77zTpsJMYiIl1rlWSe+U57itKZmVXbWiMbu3X24ZBCi3lSwJdHaay+TcKeYoTfleBGVH+zZk1py4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++njAtRWhWoFSjPNM++10n8cKHnm2Eg33gQbnpTlW+Ch9dE4Bk02
 Ne5iVnujCXtlk6dG60W84b+H0pRfwiUAKGZ+dWuYJs6CSg/bbo38TH0E
X-Gm-Gg: AYBFou1HevQRR0WBinTMtS98GI+8YMEIMQtI9MyfLVRBXO2tyJUWA2mMRVYu0MziFnt
 2z7X7B4hVWNEHVVbmcCPbkKuz9TljbjyyPomhkh45GJ09M03COC7JdPe7Q1AhQ2gz9PyCQZfFR7
 Ema6hrs6XQ96dPFqv3sH6LabRryf2GnM2iPqczNfcylObgdzVPeatr45PSxxBHDGcEye+lt0txG
 Tp9rm/Kq1SKbvC77ky6KkXmmTZGukxX/3k9jiBSQ9yHeby8zeTbtf8F3U2AkavpnqKiACzj40KL
 HnxtLNaUmdvfJBA/GqtczPvsguOehcww2i9np+UslAtyCjFPEyTFjH+aHroDUoBjFqckAGvsIQV
 038/yGThkutA54+MbGogJJtqIk9CGSNIxlbylSpqxQfw9BHtTLHFWD8wwG7tEPOMmEyC/g5+Dah
 kA1WkZx+Quw8piwgOf422QXktRAQdYzyTBMyfHhv5hi6DpqllHwAJr4CVAsFsP+DAjcpK9GbkdG
 S37HMQLmXrCgWgEZg6RuBW2rZBxY07Bsfp3W+psdPk=
X-Received: by 2002:a17:903:320d:b0:2cc:6018:f030 with SMTP id
 d9443c01a7336-2d74df16112mr345982995ad.14.1788095246201; 
 Sun, 30 Aug 2026 06:07:26 -0700 (PDT)
Received: from hnkz-ubuntu-vm1.mshome.net (flh4-125-195-69-140.tky.mesh.ad.jp.
 [125.195.69.140]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7598d26e4sm22386025ad.84.2026.08.30.06.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 06:07:25 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: mripard@kernel.org,
	dave.stevenson@raspberrypi.com
Cc: mcanal@igalia.com, kernel-list@raspberrypi.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, eric@anholt.net, bbrezillon@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kazuki Hanai <hnkz.64@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/vc4: Hold a GEM reference while purging userspace BOs
Date: Sun, 30 Aug 2026 22:07:00 +0900
Message-ID: <20260830130700.680041-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

vc4_bo_userspace_cache_purge() removes a BO from the purgeable list and
then drops the list lock before taking the BO madvise lock. A concurrent
final GEM put can therefore release the BO while the purge path still
holds only a raw pointer.

Acquire a non-zero GEM reference while the purgeable list lock still
protects the lookup. If final release has already started, drop the list
lock so the release path can remove the entry and retry. Put the temporary
reference after dropping the madvise lock to avoid recursing into final
release while that lock is held.

Fixes: b9f19259b84d ("drm/vc4: Add the DRM_IOCTL_VC4_GEM_MADVISE ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 49ea2ed0996b4..5289e69f3345f 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -319,6 +319,19 @@ static void vc4_bo_userspace_cache_purge(struct drm_device *dev)
 		struct drm_gem_object *obj = &bo->base.base;
 		size_t purged_size = 0;
 
+		/*
+		 * The last GEM reference can be dropped concurrently. Its free
+		 * callback removes the BO from this list before releasing it, so
+		 * the list lock makes an unless-zero get safe. Never carry only a
+		 * raw list pointer across the lock drop below.
+		 */
+		if (!kref_get_unless_zero(&obj->refcount)) {
+			mutex_unlock(&vc4->purgeable.lock);
+			cond_resched();
+			mutex_lock(&vc4->purgeable.lock);
+			continue;
+		}
+
 		vc4_bo_remove_from_purgeable_pool_locked(bo);
 
 		/* Release the purgeable lock while we're purging the BO so
@@ -345,6 +358,7 @@ static void vc4_bo_userspace_cache_purge(struct drm_device *dev)
 			vc4_bo_purge(obj);
 		}
 		mutex_unlock(&bo->madv_lock);
+		drm_gem_object_put(obj);
 		mutex_lock(&vc4->purgeable.lock);
 
 		if (purged_size) {
