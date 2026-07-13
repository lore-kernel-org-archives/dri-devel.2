Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF43C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488F710EB46;
	Mon, 13 Jul 2026 22:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=0sec.ai header.i=@0sec.ai header.b="IHeJZAEU";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C88C10E32A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 17:30:35 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493ece78b0cso25501245e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0sec.ai; s=google; t=1783963833; x=1784568633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h1VuKaNm+FCqQ0Qgm5d1hgzA1jRjKkQpwwjQu1kdhRU=;
 b=IHeJZAEUGW8ru7/6JPG/qP2SkyWpo6zKdy4iHFMq6waZcj7L6xaL8aypVa7nWAKM6A
 I5MNgoKsaMP70tbJuyN3MoV1D83k9PhipP1+Y7/NWW/ItGLvhSPoV/6NazfoW4nBdGhV
 tmD1wAirzTP8fuz6fNWldBU2HQkXzkr6pNUWyRBCUFV/C/zZB2KE+n+AnStBI47A0Wpq
 VmHKpkKNKyg5AGMzMNspvqYJVNJ4R+ySdg4hUrf5EDJUfXdk+o76k1902kxD4oaP1vIN
 hS2DB7wtlh3MznzIId+MJNRxtc8trL8uWz45UCCCbWTxKg7paCoAc9R9i1lIqqkGTJAK
 isZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783963833; x=1784568633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h1VuKaNm+FCqQ0Qgm5d1hgzA1jRjKkQpwwjQu1kdhRU=;
 b=LULVj2YbUPTaJC26B2otkLKVrMhg9Lk3n7cOJ9hUzMRLNj+liTDbhtQI1O4gQ8VD1S
 oqhMTwVZ8QREzzhrPdXAmgH4Zj911BditfuwCLkQ2dJdNtPttENnqt2bMUMW+z2IymRg
 2rbG2oAojDdX/LA/XE/7rJdAmaUQUQao4pdth4WHPzkXr15qpF4AIhBqh7Le+o2mf9sD
 e3MIzzllaM61POAaZe6lUM4eH+01moC+r1FWmChSNHNa0G3twWcxNU16mxex7muyZoN+
 dkC0eM2hqlDMSCiL3P9+cm78MmDQw8hlckCKJMw0QYYNq4nh2GWwqEJxoKYt2xWkp0v5
 /NLw==
X-Gm-Message-State: AOJu0Yzh7Sg/8k1gXJVXaESGM7B7hK4GKqNXiL0uo4K3a2n85sFiV2yT
 5dm3LhtvYZ8YjJM709vE0OiVzzAE66/VkyWH3t1fUgku8+xdemGLYpk7HToHkLHP5VpH
X-Gm-Gg: AfdE7cnDLO5DVYnkB7doNmUYf53TSbpgOk78svIe0RDQ4FXiUZla1GjsP0tDdZBG36+
 Qbdpvwpkver1PIn0jLYkU4GO138/HEr7X3mmUSLJMirWj++u37hfnzxm3/vBrXyZCKjbfNidkfF
 PW9TJZr2aoj7x/Fr/i8PtGsLDsQXZHoTVD+Sn4sDVndH5h3f14IyR9MwkkKL61NtwFoAxTWq0Pp
 un1Gel5gdkW97Wygqd6gQPXmR8VNLdnHM/UPU+tjejHfECJwxYRiN9wKCelOQI0V+l8YBx3pI21
 qt2swN8CCC0TXmu+YWv9eudvDw6w0nRaVpYvWX4L4gYKFGgfjXg3aRyJ9B59kkbT4zs+QqDZZro
 0ChifawMFEM/y7w80+IbShypfG8LhXWJ7Ngn4tCOr4xhz8XDsZIsdC7m5e4CPbE3O2SOTJl1KNo
 FrDdIgZfDYnQ2eCM7gyDnjHwjaJTwM4WANBl6oLZTSJd409xrsbBf8QWDjDxNN9R2HRQAio9Wem
 fZMQA1+vOSFb5pseweS/EzWwVdwu7Uhdv3HP/GhMWhRWw==
X-Received: by 2002:a05:600c:6303:b0:493:cfe8:5b36 with SMTP id
 5b1f17b1804b1-495158c6a1bmr3362305e9.8.1783963833325; 
 Mon, 13 Jul 2026 10:30:33 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f3a60404sm260075855e9.1.2026.07.13.10.30.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jul 2026 10:30:32 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Doruk Tan Ozturk <doruk@0sec.ai>, stable@vger.kernel.org
Subject: [PATCH 1/2] accel/amdxdna: reject user command submission without a
 command BO
Date: Mon, 13 Jul 2026 19:30:28 +0200
Message-ID: <20260713173030.87541-2-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713173030.87541-1-doruk@0sec.ai>
References: <20260713173030.87541-1-doruk@0sec.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

amdxdna_drm_submit_execbuf() passes the user-supplied command BO handle
straight into amdxdna_cmd_submit() with drv_cmd == NULL. When the handle
is AMDXDNA_INVALID_BO_HANDLE (0), the block that fetches job->cmd_bo is
skipped, leaving it NULL, and no check rejects it on the user path (the
!job->cmd_bo guard lives inside the != INVALID branch).

The job is then armed and pushed to the DRM scheduler.
aie2_sched_job_run() takes the drv_cmd == NULL path and calls
amdxdna_cmd_set_state(job->cmd_bo) -> amdxdna_gem_vmap(NULL) ->
to_gobj(NULL)->dev, a NULL pointer dereference in the drm_sched worker.
A process with access to the accel node on a system with a probed AMD NPU
can trigger a kernel oops with a single AMDXDNA_EXEC_CMD ioctl
(cmd_handles = 0).

Only internal driver commands (SYNC_DEBUG_BO / ATTACH_DEBUG_BO)
legitimately pass AMDXDNA_INVALID_BO_HANDLE, and they always set drv_cmd.
Reject the invalid handle for user submissions (drv_cmd == NULL) at the
submit choke point so every user path is covered.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 8f8df9d04ec5..a5c8c2c4de6d 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -603,6 +603,16 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 			ret = -EINVAL;
 			goto free_job;
 		}
+	} else if (!drv_cmd) {
+		/*
+		 * Only internal driver commands (drv_cmd != NULL) may omit a
+		 * command BO. A user command submission with the invalid handle
+		 * would leave job->cmd_bo NULL and later fault when the scheduler
+		 * dereferences it in amdxdna_cmd_set_state().
+		 */
+		XDNA_DBG(xdna, "Command BO handle required for user submission");
+		ret = -EINVAL;
+		goto free_job;
 	}
 
 	ret = amdxdna_arg_bos_lookup(client, job, arg_bo_hdls, arg_bo_cnt);
-- 
2.43.0

