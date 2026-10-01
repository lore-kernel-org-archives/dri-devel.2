Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E4BCA5FF6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0444410EADE;
	Sun,  4 Oct 2026 17:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BFDVPMkY";
	dkim-atps=neutral
Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com
 [74.125.229.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B53F10E05C
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 16:33:39 +0000 (UTC)
Received: by mail-dl2-f43.google.com with SMTP id
 a92af1059eb24-142dd04edb5so29428c88.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790872418; x=1791477218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1RPYD0N0OhgGTStrwI9XEfjRHAB9yKnlVpEfCkGkP/E=;
 b=BFDVPMkYjFLe0nG/EKZgoz5/LBDt+Bsy/IBPVTAuR63hlKKy1J2zREE5q0kYnC7Gno
 F3OW2yTlWphKXNUjMo1WqvnKM1+CGKaJqPpoEEvINzLASr0E5SoW3o36IX0ONDzxv33R
 1erGt0+KrTKRRO3pxaIFv2fdVbY7dgXXaCo4j65VDoTkSd3CoxQ5burrvi6e2Lhh7eTg
 Hd7yaxKy/n3lsPK0KY8Y3uF5/WiuZyGLcnRW6aDpGkoQpt0ulZtzQeWnVLWhrEfDL1nV
 xRpAshjh2tfFtYSPllzxxmJV+WaUQJRIIxDde6umBpqIbgrzqxKk5fYPyq/tnobe3cnP
 /yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790872418; x=1791477218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1RPYD0N0OhgGTStrwI9XEfjRHAB9yKnlVpEfCkGkP/E=;
 b=hgb+9mQLukY8HI4SZJzhh8yJbhVtF4HCijZwPT87f51NI9QXkAFyWrWaPkwPPiskG1
 QJU3rKLpPCYJZtNOVy8VQNvp8yhRm/p4rsPkddzkwnzzBQ3LdEXPE5Op37HfAy/32IKk
 3WUOJ7NehHLG9EOwXYx0kfoNMvhyg6TR2fFtGQXb6snXldGHdD+Ngt8DB0OW3BdiRtKz
 B4D0ICmJMmPXqgmupDG78J9uNQ77F0bDyau7tTXQMjRV6kftT6x8+HXWOVNo7RN2KfQN
 lChDWecPZoOlZ2etSVOmkdnrT5rzL1myCZ/AY8fEQeUu4fONnkvA2Z2FRx6Gp8JIoDId
 Rh7A==
X-Forwarded-Encrypted: i=1;
 AKwUvByKxI2LxJMdpEvJ25iD8i9iT/Z3efgAH8ZqIB5yzCafA0dvICKtqdFPwt4ManKy6bZ0ZKSuX3RP3Qc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n1lX8WQ5A4ackL7OEGc2dHaBT4uP95u5pGSdxjXeoWyuBj5n2r
 VL83pfo2QNJLGFZlmaUNZaHmVqp9ZjrP+IYsDq4u2FhBd6qMPbdc6Uyn
X-Gm-Gg: AYBFou1KGsDcIw+RSoWQExkWjWdkQ+DkpsAPUytl660QR9pz/eS0OFfiH0NcfNvnuFG
 MyP2T+htcLIs40eX1gvWQ4OAX1boeyTKDGlGVphy/U0PRm+8N9MYBoA+Hf6lK+stT8gTZN5y9TA
 DqW7HkRUpyZCT84y+7TSZcPYZH7DtkWWZyyB/6yMalsQbfs0qHyCPJHqGERNOh3iD98OzXtghMP
 JiNXDuAwLszgV3RAX0stxwBpu5/8KfJUUXNf7lJ8OFGZfSIfLWnRtul4nSBtInGCQn69YhYcxxS
 GXEHWRQUYh4Cz0iwc4/jyVWbp6fxeFDBiQoFT40rG1jQE8/60Vx+KSShAGLjTs0spmyN1dCjH0y
 Lggyk22B9+7NrkKLgB/y7ETXSSf7X75gc4YnXCLEYCCnyRHSukE0wAYSK747XKmTf8guy8vwIB4
 lHhiA45A6CHo7cORo9C8CZffR0VT09wTfIkX3Y7U7UpWVvzfYwF07JdRqC6WNOQx5kyTQ9X2wKg
 wVBL2cCvzfVeVzOc3LEO+jibOUzLkAosa2Dn2M3vDOuUefdyUA3dByv+SFmLDG3qKImKr1wXQ==
X-Received: by 2002:a05:701b:280d:b0:149:cfa4:9b3b with SMTP id
 a92af1059eb24-14d2fbcad2fmr5218644c88.3.1790872418302; 
 Thu, 01 Oct 2026 09:33:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:a4cd:e25d:fdef:4a3b])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f265d307fsm385750c88.3.2026.10.01.09.33.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 09:33:37 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] drm/xe: use resource_size() in xe_pagemap_create()
Date: Thu,  1 Oct 2026 22:03:22 +0530
Message-ID: <20261001163328.51556-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

The open coded res->end - res->start + 1 is what resource_size() does.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index b228a737c..e6ab5a5b3 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -1848,7 +1848,7 @@ static struct xe_pagemap *xe_pagemap_create(struct xe_device *xe, struct xe_vram
 out_no_pages:
 	drm_pagemap_release_owner(&xpagemap->peer);
 out_no_owner:
-	devm_release_mem_region(dev, res->start, res->end - res->start + 1);
+	devm_release_mem_region(dev, res->start, resource_size(res));
 out_err:
 	drm_pagemap_put(dpagemap);
 	return ERR_PTR(err);
-- 
2.46.0

