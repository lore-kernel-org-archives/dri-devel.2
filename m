Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32040C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A133F10EA8B;
	Wed, 19 Aug 2026 06:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UgFQq5Zr";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AAEF10E4F1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:09:28 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cc11a30a259so3791624a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787069368; x=1787674168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jtbdktcDMHK2UUilb3s7er2LASWhJy/LqRbzLHdr7EI=;
 b=UgFQq5ZraO7jsnAABQq5K17MIZ9vvF/4rIKzfeC+XAUg567RiGg+hSlJIbl3YgS0FQ
 cZ89w/LW4QdOos8cjIf3TyMD0LPJEr7crvbynPWeP/1gbeWSdD3ZohnL3vw2mXcfsRxI
 CngesAVnze0Gx5Qr4BiMXpslQ7QP9Gni2R7j7b2ZYzDEWjgMBq3VO+JVgBPay9LmGIGv
 VC//VHSTfds2sIcoxwNZhf2EqFj4PnZebC6iU3SVDQrxRtk6MkHl+8HlSXqB3GMFVyQe
 +VIHBzVD7lekLSrNYQUmoRacxLD5cjCYtQlT/3zWEew5Ng1/CWwR+h0CocDlUs/Z7uhB
 xnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787069368; x=1787674168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jtbdktcDMHK2UUilb3s7er2LASWhJy/LqRbzLHdr7EI=;
 b=pGHoK+0FBUFy5TPYQflFA+GsPidHeA8E1q0r0JkqoHX28/tKCS5GDrhIadHuBeoEq3
 O4hJBNwyhBLH+ENDXDunBmJqxdLplClIM+GWl8DkuQMHHq5Bf3G5gBL1knHeLYOvRLQp
 awgMV3jiNSgl/A1kkf+/G7YMVZihwM49ShGSMcLyXJGew4rsx5yidsB7k1M3DCisILQj
 imbqww0h1DlinQ1baH4vULQydzhx9jM8DRjzEbEG/lSKtTX6Ra5oSPhdy/kY8VQae6FX
 4YvmTmj775Owy5uhlLo+OezYhb6BJ6RvIcvHR1bR1UebWI6fqr3XIrR+knaQuD7RiRFn
 Vtrg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+sl0N3nIM7xfsHBeVWP40q/1TY8gvYu5471rxV3qV/UCkJ+aoRxxPYwi+FIllzv+YlVjkLTbF+Zg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw86aQvNpFJCbK12VBZwZh98jVG7MimP5ya7qazMKKIAwO8YCBX
 G9tKiNMktk0S0gBLi9oaCc3kawKuUsi3iHgLt3lTilOo0ZPmWZG9YyVG
X-Gm-Gg: AR+sD10gai004lFLu16IguNkE8c9S9PQIlsw1MkSXvO5xAsebXYU9hFxGauy04Y1xx3
 ay5nl4CQEA6q+kDANnNQhd1AUfha7GrbEbcMxiyJ3z06XT1xj+8Awkyku9wL4kIKbOxKcL2sh/r
 hmRM99OPau58mK7PTL8qwqrhSSZJv7oXjLfYZ0cqFbSfhmyNSa/kFzoejLe2eqnPdwSMxtm7Yis
 uemg4JQblYUs9IWJcZKyA8PeFkb40LIT5EAQRYWZH/a4BsNjaKEyrIBmOugrM/49G2j313HDb9x
 NFcToV8yaRng/kqfUihgqR/5I/ZTE0sVorl3qvFIyBLz1NEqeoZbe8MV0VpCR7B8RJepyYnCg9k
 yVN+Ivxag8wgk4WxmVz8idANDKcx1+cXI8+Za3vv+3KQbapjIhrtDDe2H0s2dLUCLxgApo09asG
 Gs1iM3Zdp0v6RmmQw+o9e2LU31vGnRzbJIatIb1MnjNoi5JikUr5Fyx5VNockL8q9O3rTO29jTv
 l0NlwMtcQsqBYEygztNsVBDkPSGU/IQLpXrf+IryDMNc6j3sDrFE5jv/DCI5eozuWJC
X-Received: by 2002:a05:6a20:938c:b0:3bf:7081:9356 with SMTP id
 adf61e73a8af0-3cc71d5627amr41562410637.17.1787069368457; 
 Tue, 18 Aug 2026 09:09:28 -0700 (PDT)
Received: from LAPTOP-M4N25KQ5.tail73068d.ts.net
 (1-160-197-194.dynamic-ip.hinet.net. [1.160.197.194])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1469e2e5esm1007767a12.5.2026.08.18.09.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 09:09:28 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v1 2/2] drm/ttm: make ttm_swap_ops static
Date: Wed, 19 Aug 2026 00:09:14 +0800
Message-ID: <20260818160914.108313-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818160914.108313-1-seanwascoding@gmail.com>
References: <20260818160914.108313-1-seanwascoding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

ttm_swap_ops is not used outside ttm_bo.c and is not exported via
EXPORT_SYMBOL(), so give it static linkage to keep it file-local
and avoid polluting the global symbol namespace.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 943297b49dc5..1b9477381a1d 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1449,7 +1449,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 	return ret;
 }
 
-const struct ttm_lru_walk_ops ttm_swap_ops = {
+static const struct ttm_lru_walk_ops ttm_swap_ops = {
 	.process_bo = ttm_bo_swapout_cb,
 };
 
-- 
2.43.0

