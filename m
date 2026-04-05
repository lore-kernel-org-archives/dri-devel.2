Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6231E9D820
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 21:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F126E10E05E;
	Sun,  5 Apr 2026 21:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LaDYnW/r";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FFB10E180
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 15:47:14 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso46478405e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775404033; x=1776008833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lB+a99wJ5dswQkzQkoOsmekXtXL1XOz/X3cfxAbGqiM=;
 b=LaDYnW/rpoTNyZHDJt1Gqeua2qqwK2ekrpzVQvQMHYsMUKrYA9URoRRAYSs0jikty+
 17Y027gbwXfSU2d2RraTQkl8BAISxynu5itTB5vxZqS4uVeZi1eswaFj/44hBggqQ4fW
 6Ff1aanVe9+wSlidBLWixdbvs/Qg0mlv2hyi45ZTDjTS3U5HH7MvXnehYNEWljs4Awff
 7aOsxbAP8ZIek7OM0DGKR90GJDTKHfgVaDC7uijnzKi7fzj6Wzpm+nfSg2X+qXST9QDf
 CgQt4+pW+WsWPiLhntvqTPXhApN7ymVSyWxpzBArU9IVDYMvfAYNoPHwYTuNOa2XzFNx
 B2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775404033; x=1776008833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB+a99wJ5dswQkzQkoOsmekXtXL1XOz/X3cfxAbGqiM=;
 b=q5ZeEOUsQoQagq4aPSDlSWwNK93bKerUj0CF1J73E7gaNxkE0roudn+m6szxqwDlKv
 8dVMIS3osKX6B/6ycH3QNQIOXtCskZ0zmnHweN8u8qa3WP5cshionW+vojCxnc46oL8L
 afodrwUQSEHoiXEL9LotO7rZ0A+fqbZuY0HCP9guggcNUpoP7wXj9pUAIPbw0QhV7vc1
 Uy/pXOZmuAI6rUSu1OuemyIIwMzSgH5oE1EkrefxJo1REJ5ZDy42AAIs/6iNldRiDJZ0
 OhbindKEtUDz3SyHnDkTQYlksOcOWF+BVlDgHU9w2Jw5RqJm0gCU3FpqH5xGKS/eQNSf
 vMSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCTyFrdGpiIhTUfhiAR4Ne2uLaU2E/ya/cKFl3ITUGLBr59dzfrP6+0MQ56PjNevy1oclKw2Nm2v0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyze3RqF/B1UIh9tRLlUXhgGoFgsalVq4byQAoay6xs3PScHh1N
 O0Rh+4DKUi3iw52gKH89HeI1uSmvLGI2erukNfHhhS0UizmI3EsC8ufi
X-Gm-Gg: AeBDievbn6EI/x+gl72dtoom7B9MCLAaZAzU6o4LZ29c2HY3nPEVJDDiH6+Eo3FzZEH
 GdL3H/Ccg8SmPnTSKRiSjgJrxjmga34Wc9k8mYIysXt9MERLvE2s4IA/cfVW+KBXjfzRpbIsByW
 i+ZgoDjzcitxr/K9lIRZPFRt8K5d6WNOLuiwO3pb1Hg4Kwc2nxr2bvDQMIvkiGXfu9Zt14bSeHe
 eZWCHaCMic72jv55E76yjSC/reh7MQSIUVa5XqCvZV7KLrVkVQzH9jkaH4WiXlqZ8sfJvGH+49e
 1Mkk88HLYiNtiFfb5rspCqDNLrRhE/kNmJgu6HGRE1uEbYdosytE+p6VctQ/Uk8MgulXfR28oKN
 qC4jSrNqhz+p+Wlx68p83xVvcTxsq8qkPFbewAepvfvxijJhiUSJNAKf0Z6Ih7ExA4JJwysPpHb
 pdpRiJDSxxHOYcOgceh00GxNXF6ct9eieQmHwOtMI39mErvXnFWGLm+rjCiUGLyDhqnACnicDlt
 GIUZhRQFqws
X-Received: by 2002:a05:600c:3b23:b0:488:869c:edaf with SMTP id
 5b1f17b1804b1-488996df052mr128364685e9.8.1775404032826; 
 Sun, 05 Apr 2026 08:47:12 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f52easm34255338f8f.36.2026.04.05.08.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 08:47:12 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [PATCH v3] drm: use get_random_u64() where appropriate
Date: Sun,  5 Apr 2026 16:47:10 +0100
Message-ID: <20260405154710.4638-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Apr 2026 21:13:49 +0000
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

Use the typed random integer helpers instead of
get_random_bytes() when filling a single integer variable.
The helpers return the value directly, require no pointer
or size argument, and better express intent.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/gpu/drm/i915/i915_hdcp_gsc.c | 2 +-
 drivers/gpu/drm/xe/xe_gsc_submit.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_hdcp_gsc.c b/drivers/gpu/drm/i915/i915_hdcp_gsc.c
index 168b9ccbef3e..a0510f5ab25c 100644
--- a/drivers/gpu/drm/i915/i915_hdcp_gsc.c
+++ b/drivers/gpu/drm/i915/i915_hdcp_gsc.c
@@ -196,7 +196,7 @@ static ssize_t intel_hdcp_gsc_msg_send(struct intel_hdcp_gsc_context *gsc_contex
 
 	memset(header_in, 0, msg_size_in);
 	memset(header_out, 0, msg_size_out);
-	get_random_bytes(&host_session_id, sizeof(u64));
+	host_session_id = get_random_u64();
 	intel_gsc_uc_heci_cmd_emit_mtl_header(header_in, HECI_MEADDRESS_HDCP,
 					      msg_size_in, host_session_id);
 	memcpy(gsc_context->hdcp_cmd_in + sizeof(*header_in), msg_in, msg_in_len);
diff --git a/drivers/gpu/drm/xe/xe_gsc_submit.c b/drivers/gpu/drm/xe/xe_gsc_submit.c
index 08082b596501..195f99e6c3a8 100644
--- a/drivers/gpu/drm/xe/xe_gsc_submit.c
+++ b/drivers/gpu/drm/xe/xe_gsc_submit.c
@@ -49,7 +49,7 @@ u64 xe_gsc_create_host_session_id(void)
 {
 	u64 host_session_id;
 
-	get_random_bytes(&host_session_id, sizeof(u64));
+	host_session_id = get_random_u64();
 	host_session_id &= ~HOST_SESSION_CLIENT_MASK;
 	return host_session_id;
 }
-- 
2.53.0

