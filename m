Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB4606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qrt+KPt6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91ABC10EE46;
	Mon, 23 Nov 2026 14:17:29 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F7610E402
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:40:36 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3869b68caecso3889527eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 01:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795426836; x=1796031636; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9jX0RW6LaoLCUoJWieDzex2x/0egSw3B2iYNY4JlEL4=;
 b=Qrt+KPt6CiSelvOsuYniUe4AaMafY8kQmlnXF4GfDZphczevrletUwsTzCxbA/KdU3
 59e5rQMf0ET0kpykpaVm3EuYQv6sTIvPAuJlRVEm0JSOWKkrJ3an0BOtNA1Eb9ZWJU/i
 lFBJ6QS6q/znTi0y3pfJOQUqu7N7Ll8c3tuImAvi2Lvvu0lHBId9aHEUkKVScaY+vtNk
 Al3ZhLG2x4VftjJOAnZ+mahNcI7B9PXVTFNX0M9uf8lFFuaoPEZwjqonFq785EDT9bMR
 xmAFVcFFDq9EgA8JyyspaMUNUZv+br7/Ksu8n+cPQHsGXjXWjslvbvdrjAiq4xfy6Hms
 hkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795426836; x=1796031636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9jX0RW6LaoLCUoJWieDzex2x/0egSw3B2iYNY4JlEL4=;
 b=KEdW35dYh09sXznMoRnjS8XtUyGYTXf6OQF9ZXT8r4xo+bdbsTJBlJ3xGrPLV53IFK
 bBsQJGKCPR2AyXMNu4ZslEiipsWOFHuKCObHh/yMwKEQoXc5O8SINlkjArTKxdI7mbY3
 rS922egZYDObGHIN73lwIxJDIEF6I98xFcZ9C1ztMtPaKyO75yhha4j3QGpL7/h5J6gO
 tC3UG3g99F4GengozxLsaACEtY/bmUcPOPLzX2J6jV0L/VzeSPpXE1TeMfCDLRVGbDvu
 QGAgMMQpzxNejw2PK0CUghKkG1FIxQYUWbPNhfc8wiXD1wIFXnv2Xgbfw/eDXgMa6Kz4
 m+Gg==
X-Gm-Message-State: APuU4Z+CTEkqS+ygcyGqMheXypjLrACauRD3NYvSGEgGcKMAsZ7+ri6M
 x0rJ+V6ng4kxY6g5lp4wPV8CeBaBg2HX/MzzigHqHPHXaHKLgmcrfxT+ubwf/BjB
X-Gm-Gg: AZFdTZeYU9o4uJSpkOhNljibrtQqHlGzdr+k68PeXywYdMhJ3Dzo/icnVhAOOzKe802
 HTqggUxFWMMzDR4x3j4Tx6ctypbC4A8s5OakafIQk1N9Pi3NTrNXF2LSxbBoUXIskBOuksta1/M
 zPhAO2tQggqyZtaqOQ76dc2IvoOkRkPvzHuGN77Nj/5YzjM6T3lves+nUA6vgSP+BimqL75VL8u
 5sORP4sj7cIqTjL1eLAnBTrk7D/K43/n2Qs0Gvsjr7eEK7kLSSieJON5ryAzonI2y5XJAR/D1ty
 9vQ1cYVTrM1lKT6OGDIFqcznGJh59rLiw4fJVC0eATfpGLJHN9y4zMnWscekV5MmBXpR8vNZYpF
 V27DIiAJDfxrTaLRzaJK50za1q3gm+ciZ2HJ9C+4qjNVJbNPV9Xn76vljoQUWhEiGi4l77mCvjv
 NgLLUGVyLO9ThmG+LeHmH14uJGb4AzZp6rtPNovv1+iOjD64s6HjoXGspRjyl5Zug9NHGZc8VSa
 ddFalFQ1VKFsk5mZ2rqunEqo1f8MQNwsX+iPcdxNv0sjrgSXYS0QQf3mPEJ2sAQb+5R5PewPo7j
 138v7M4nGNhsuZ0cTrdf
X-Received: by 2002:a05:693c:808b:b0:386:3535:1dd with SMTP id
 5a478bee46e88-3863535052amr9738885eec.12.1795426835930; 
 Mon, 23 Nov 2026 01:40:35 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386aa203267sm10875210eec.0.2026.11.23.01.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 01:40:35 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Honglei Huang <honghuan@amd.com>, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] drm/pagemap_util: Drop the kernel-doc for a member that does
 not exist
Date: Mon, 23 Nov 2026 09:40:32 +0000
Message-ID: <20261123094032.3993177-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kernel-doc reports, with or without -Wall:

  Warning: include/drm/drm_pagemap_util.h:45 Excess struct member 'peer'
  description in 'drm_pagemap_owner_list' (did you mean one of: 'peers')

The struct holds one list member, @peers, documented on the member itself.
The @peer line was added with the struct and refers to no member, so drop
it.

After:

  $ scripts/kernel-doc -Wall -none include/drm/drm_pagemap_util.h
  (no output)

The warning is not cosmetic in a -Werror build: kernel-doc exits with
status 3 on the file before this change, so a headercheck run with
CONFIG_WERROR=y fails on it.

The other DRM pagemap and gpusvm headers are clean with -Wall as well.

The change and this changelog were written with Hermes Agent
(deepseek-v4.1-flash); I reviewed the change and ran kernel-doc -Wall on
the file before and after.  No build was run, as only a comment changes.

Fixes: e44f47a9bf51 ("drm/pagemap_util: Add a utility to assign an owner to a set of interconnected gpus")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 include/drm/drm_pagemap_util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/drm_pagemap_util.h b/include/drm/drm_pagemap_util.h
index 19169b42b891..34fa879505d2 100644
--- a/include/drm/drm_pagemap_util.h
+++ b/include/drm/drm_pagemap_util.h
@@ -32,7 +32,6 @@ struct drm_pagemap_peer {
 
 /**
  * struct drm_pagemap_owner_list - Keeping track of peers and owners
- * @peer: List of peers.
  *
  * The owner list defines the scope where we identify peers having fast interconnects
  * and a common owner. Typically a driver has a single global owner list to

base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.53.0

