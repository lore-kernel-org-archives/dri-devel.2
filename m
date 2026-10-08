Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D07FCA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCF010E6B8;
	Thu,  8 Oct 2026 10:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQBrfsrf";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DADF10E6B8
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 10:09:43 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48af27fe287so2084770f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791454181; x=1792058981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uEuJYz+pVbgCSCGaEVPneImA96kKSzfy+n11GiKnq8c=;
 b=cQBrfsrf6GjpABbpNos0cUxIVFfc6+ivoHeJ16hhs+ehAG8vQtpBmdzsWVwjMfv+kb
 gYBpwJ6/+WddHU43ngFRGjqcQJj+eTI9l+2WbP+PWMlaP5eq06GvpEVXDxGFg3ACiAM3
 7t87jFtNzMm6L28Tcduh+OUwjVDWXwuKJIGqGuYpEg1XkZ1GNFiwweRKXdZaqzzLyk/w
 p074ajFaQxz6O9B5hT7EyH2yO64dAdqK6Sx4fvgk+wtdfZ5I22vmgS8lnaGxOJoIzHxG
 RjG4tr2sf5KnFGki+LbIXFJqdVPmDBrnBzhm7Gkosbf3UYcGBlso32B17tDWsFN1M4N8
 ZpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791454181; x=1792058981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uEuJYz+pVbgCSCGaEVPneImA96kKSzfy+n11GiKnq8c=;
 b=IA0/RO7F7DZKyRLpoY0vlXAW6R/+og4Wy4Nh4hoEi1qeYt1wab6h3jne/svy3j6URt
 x82kpYXy2lYJuinBhAdwI53wv4BFbMrasLMmC72e8jJ7rmZCt/iNmfprHMLi6CuUmJVs
 vcWHitpOqRIeoKA2IL1uGih88gRPpBjGnJECIst7X2JQqKcrmKbu0yDQ51n+RUVA1p+O
 /x36753n8lTtubA/wbWDIiEeZ7S7hUwwtJd7DZao1ru1Xn8RR0B1HubHuvg1P79Dis3n
 nTsqqPRL2pkr02xU2tGUmP/1gamwKKXVh5o5TW8XFkBIp92Ms5bAOKJXWwa7+U/FNivH
 BPmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWud3CJHe/FbWURM3gky89sos+B6yiIXEblTYsiPynppGDGzt5q0xblhdnmy/szmHvjAGlEm/o5zE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kbRJMxGbTLjpZQqNcz50HbOED+sefYxSAfmzkYsPJ4HMxwr+UJ
 sJxwZTWA8uiQg7XnFJMJov+iDyDKL1kkNpG87zL6XWsM5klKabGu45Tx
X-Gm-Gg: AYBFou2DhkLpUUcLwiokx4eQwrzY/8aZtMuYQXBQ/WF2MWqoKwWeBQS3QobCnBHSbac
 hZPeLv4INtquMSnB6kKOOkJkR7+x6wzPPMqrWF1KMt//OjFwneI0BqnrU3SeDfYC4g4lynrm5W2
 1EIXmDi0FNjGguYtvvxYZ3/mq7ZWAaB69H2u1VbdWDfDeADvO6A0FaNXFMYppHe/1Su8S7kQGDG
 uWwpNyQNAirMepfAXZGKTJrMpw3L7FGmI8iHkEoby3qLZcIUVBImwXCyabg6e1bMAmByo5bonL9
 U7M9RGumfpM4pq1kjztJQvvyTBphTen1gANwm3chS4RaIEGNJs4HllW5B2k4EwmqYaLvUDsHonU
 8b3xSVDG/IHj3jNt6ec7P6X5fO4TrgyuqHbPWxXctGsbctGHCtYZI6MTznpcB5FOzr0GIy4YglZ
 GbO0oWE7asSuk10YTuzjaGE3BaMaI/QjHVh7xY8bLp5wH+yf+4v5wco46OSKuMaqNZVMSwfmzJ6
 YX207jIx8t4BaUJfwMuyngxrVwYeXCg
X-Received: by 2002:a05:600c:524f:b0:49f:d6f0:6f24 with SMTP id
 5b1f17b1804b1-4a1800d3d38mr84852165e9.2.1791454181336; 
 Thu, 08 Oct 2026 03:09:41 -0700 (PDT)
Received: from osama ([2a02:908:182:d1a0:b456:28a3:bd59:abb6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843e3356sm52932505e9.14.2026.10.08.03.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 03:09:38 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
 Akash Goel <akash.goel@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/panthor: Fix TOCTOU race between GROUP_REGISTERED
 check and erase
Date: Thu,  8 Oct 2026 12:09:35 +0200
Message-ID: <20261008100935.3059587-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

panthor_group_destroy() checks the GROUP_REGISTERED mark and then calls
xa_erase() without holding the xarray lock across both. If the handle is
destroyed by another thread in between, and a concurrent GROUP_CREATE
reuses the freed ID, the first destroy erases and releases the new,
still-initializing group, leading to a use-after-free in
panthor_group_create().

Do the mark check and erase atomically under xa_lock().

Fixes: eec7e23d848d ("drm/panthor: Prevent potential UAF in group creation")
Assisted-by: Claude:claude-opus-5.5
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- added Assisted-by tag, no code changes.
---
 drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 0493858e55d7..a343c5180e01 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3770,12 +3770,18 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_scheduler *sched = ptdev->scheduler;
-	struct panthor_group *group;
+	struct panthor_group *group = NULL;
 
-	if (!xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
-		return -EINVAL;
+	/*
+	 * Check the mark and erase the entry atomically, so a concurrent
+	 * destroy + create can't make us erase a group that's still being
+	 * initialized and happens to reuse the same handle.
+	 */
+	xa_lock(&gpool->xa);
+	if (xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
+		group = __xa_erase(&gpool->xa, group_handle);
+	xa_unlock(&gpool->xa);
 
-	group = xa_erase(&gpool->xa, group_handle);
 	if (!group)
 		return -EINVAL;
 
-- 
2.53.0

