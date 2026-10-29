Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDC9606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LkQ/cbBb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C93B10E156;
	Thu, 29 Oct 2026 21:56:16 +0000 (UTC)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F6910E156
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:56:10 +0000 (UTC)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3acdcfa2bd3so52648a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793310970; x=1793915770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d9XEeTWk87x2ImskMZFYpbUHdMyJkVEwO7nVEscXoGQ=;
 b=mG9CXAetDjDgZ4oGLmDgJVTCJ5qpojMNdG3dtWkY/MlJVpW5OVmolvb0dU6OsFaZcP
 V3YlVuBFl9oBmR3zIwuZNf4Id8U+W2J6BEEX4Y6U2IwNkoG2tkrVrFtX6SXnIkLAvC1L
 sOXjhn1qr/UqIcNXvagL8xsG+Tnqug/43CLJim6tmz+8EG5Ulh7B0tqppFDRx2yKL86t
 mkydlHK9UYmvrWoe5+J3//sTYIhOoaQNVptpnh8RsHTbEWA/s6CZ4MRqIwZSpYyDngqG
 9c4O1gsihqB1Zxn0IscYVo47510MUuH0jnhM98M1KDQM1vfouN7VMZcPEuiEUEAiG6UW
 v0zA==
X-Gm-Message-State: AFq9FYLF6w03+9mw/L+Kq9D5WLjnaJCvxDyMJgM94fItxF0zv5yVooHw
 XaLBEirLdZJlCQpQzR+2e5vTyEa7n8U+cb/M6rOzw8h5ix+olKndU330VJBt6NiPNi6Js52HnWm
 yZwDU5uKqp3LetYmY76xHdx8rMAK3M/FyKC+H3U1qOVuv5EtuvKPdqJLJSXZ017iPFURdIHp/4I
 0BbvLLQSCuAuyW9WxgjEpMIZe6iigZKTmQm37xYUeV1KBmG4tuEo2X7bDxPNygQkpqFcI/zbk8M
 DB0PV1h1Q7XtwZ+djXj
X-Gm-Gg: AYBFou36Vc8kkJI1pO7dXFNyAUxJY1Ce6oYCgOHJlqaJfCCP3QqJ11msKs/byAP24yo
 rM6YTQyAcLpdTsflU1/uTudeE8aEWN0J+LbeRbYT82OB1B/Gj/aRMWSUjKOlEGr8AHvT21wt3Tk
 Lg6bhG+T3/Vtr0+cKK345a2BVhPJJAqqBcZ4UyZVWnc8cb5z3Gbgr2Eh8kEMnxqrOr+HxtFyleT
 1s2DBvH2aPPWiem5xgCcAqPVw1Ad7btQYXHlQ2vg9Z2WlvX+OdSKVuhcbsKVGjOEQAQkN1UvCkh
 b9MYCWGC3QQHIULpryWR6B89XO2FLr64eqWVNJ06JWbmUhRgx5vbLPQ7v9dnbhPA64R9RwmLpWY
 nQ9Yg0eZHpwGprnggqC8L6YE7jk9kZMuKUmb8V8MZ+2jK26+hbKhnxOxeYAIowE4MY+kJiDBegq
 mCGw8IvnOty2keNXeQbwrQGfHFoYo6idT3
X-Received: by 2002:a17:90b:3b51:b0:3ac:450b:164c with SMTP id
 98e67ed59e1d1-3ae89831c86mr236557a91.47.1793310970068; 
 Thu, 29 Oct 2026 14:56:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae85f87a56sm221637a91.1.2026.10.29.14.56.09
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 14:56:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-18eb2616974so146226c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793310968; x=1793915768;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d9XEeTWk87x2ImskMZFYpbUHdMyJkVEwO7nVEscXoGQ=;
 b=LkQ/cbBbQuzOf4GA/n2Anjhy7rw9A4vmTitwvu6fLFOVgzzwgBHXsxBCTZduLoJHcU
 S/paTJoaey8ehgp76ThFlzqxEgh+ueSImcJ5oEFMVT6yN1B/7RsOmW/O5pxg2hjH3wLu
 h+tD7EwZ742bmoH1PMKNgMvhtzSQ9oj0WlbZQ=
X-Received: by 2002:a05:7022:1117:b0:195:49ee:94c7 with SMTP id
 a92af1059eb24-1ac5a0b579emr441361c88.8.1793310968055; 
 Thu, 29 Oct 2026 14:56:08 -0700 (PDT)
X-Received: by 2002:a05:7022:1117:b0:195:49ee:94c7 with SMTP id
 a92af1059eb24-1ac5a0b579emr441301c88.8.1793310966865; 
 Thu, 29 Oct 2026 14:56:06 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1b38ac58sm1297719c88.23.2026.10.29.14.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 14:56:06 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, Zack Rusin <zack.rusin@broadcom.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: log missing primary planes only once
Date: Thu, 29 Oct 2026 17:55:40 -0400
Message-ID: <20261029215540.3008997-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stop filling kernel logs due to something that's not even a bug. Some
igt tests, e.g. kms_flip trigger this message ~17000 times which makes
all the other diagnostics almost impossible to find.

Just inform the user about this condition once and let it through
afterward.

Fixes: a60ccade88f9 ("drm/vmwgfx: Fix crtc's atomic check conditional")
Cc: stable@vger.kernel.org
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 85228eb9c3e6..da2d3b62f75f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -155,9 +155,8 @@ int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 	 * some actual rendering so give a clue as why it's blank.
 	 */
 	if (new_state->enable && !has_primary)
-		drm_dbg_driver(&vmw->drm,
-			       "CRTC without a primary plane will be blank.\n");
-
+		drm_info_once(&vmw->drm,
+			      "CRTC without a primary plane will be blank.\n");
 
 	if (new_state->connector_mask != connector_mask &&
 	    new_state->connector_mask != 0) {
-- 
2.53.0

