Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C7DCD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 14:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449E510E626;
	Fri, 15 May 2026 14:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="nGgYLcvu";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0448E10E626
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 14:02:15 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-90ea08cc5ceso562688985a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1778853734; x=1779458534;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uJOdi/TzljxZPI9yl1I4A/VL65oRSiUkNPLik5t/1gE=;
 b=nGgYLcvuy9S+ZMrZwqw91g86z+VKWIn7BrmBzIfPCTqTY6F/DJ6CiVGvlCKYw5eSO+
 Oky0WwVuZxO1VU6U7MhILcuSBJV/IQloe6nGX1hm0X3YSWfgJzK90BsB8b+Y9eGDH+Qy
 0vzUHr3d/+lcYfTHb4AJ6ihoJTkZygwzQQyrVp+RxRVPO7lyGKkPHtcwWj8V1gTS7hit
 TV4jwXMv2/Fa/Ps0ipfxB/l6ST3J0iAyB3UQcSYoNodZv2H7MmNu839LqNgOC+c8IPg4
 ci6IC/Mbs7v4wya+eOLm1MS+UHDWRboBhHG2k1Q1iXfYfaHg7MSjcdBoWI7dVKKsws11
 DEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853734; x=1779458534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJOdi/TzljxZPI9yl1I4A/VL65oRSiUkNPLik5t/1gE=;
 b=Hl8tcIdO846rDjExpTjFhcbxx4uudJduQC4dZL0pknCaocJEqwymmdscbvXAm2wf91
 GxcCLXIwtLFRzuYZI+i49UjiojeQoSF3gMZLaGmyUiv4YehNu5Viwd/0CYUaR/mZpN5l
 i62kAETZP+SDeGx6KRmDpBWLiyzMsgtfyQdxGxsjmuvHUR2jkI8FyiPT/OKbmm3mUTUz
 KiuSPS+G0aSJpEXiX6vmVaAp8/tQMvbNcqEYhz43CYilultlwCYpDdq3MUH6Exn2IFTE
 72zh6aPGr2Vn9E73BGGGBzoIL5OlciStFzniGpUZT9F5RsPSOxHkxtMXalk0f+KncGOC
 LUfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nr8J0i+vd6n0jk1jFDDJT1ffSi+GoyIxpQpAu+T94doxGUDCU2SJZfBmLUwaxzX/6lM/y9y2smuE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKmq+3S6ARR+DDDY0kLqZlA3WYaHNrCK4nrdzrSZnWcVn7Hh5Z
 XqVFcCdVFQ5O4+WkcYP35UC13mbFCQ0kTDAyEU1BWOMX1otbuy6KHJ9uviH90QbcrUOBDqHrpXT
 naypqWVI=
X-Gm-Gg: Acq92OF8nK7rEf1g3o32kX/CX/NKIvhsbvtQNCurFIuoMSu0jS2rP71SiNNll3eGrv2
 RQGQul6RprrwUT9qsx1A2SLtuRhn5vRQu+gyuxuJ7WuCPQC1gNsItanpKIp4qcCCZL6hTRMAcPT
 McveWZWjZYp77vXy5eYFowQhE0EfiArfAezA6CM4eHE/3R/ZyT/w0DGgiRavDZ8ROQ07ms3ZH0v
 lOVOVi7msXsNMdqQ/0HYwmMSYLUKKHtd5KQXixYRKNeKL0bWDiFS/iJIc+RoHc13laIbwYJzhRL
 OCJELTRAaYTnRiqLfmDp60x27rEnoGxYxDFt+OJa04JRmGvr6BRANrySg+a0TcBSfx+l5JPe/uw
 yyJ7qBZcklDvqEyaSsqFvfSfj9Scrma2g9f7cERYDnF7nrjjXAES77uD7HGtqNE3qkIlyZMLWqO
 q9gXwFp1Z8UiZvMCyl4lbDERREPJMj
X-Received: by 2002:a05:620a:454b:b0:8f0:7516:daaf with SMTP id
 af79cd13be357-911d087bf3cmr649143485a.48.1778853733580; 
 Fri, 15 May 2026 07:02:13 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bc83b85asm549789885a.25.2026.05.15.07.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:02:13 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/3] drm/xe: Use trace_call__##name() at guarded tracepoint
 call site
Date: Fri, 15 May 2026 10:01:41 -0400
Message-ID: <20260515140141.2239437-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
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

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/gpu/drm/xe/xe_guc_ct.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index a11cff7a20be..8a10a1ede983 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -1032,8 +1032,9 @@ static int h2g_write(struct xe_guc_ct *ct, const u32 *action, u32 len,
 	 * the fast H2G submission path when tracing is not active.
 	 */
 	if (trace_xe_guc_ctb_h2g_enabled())
-		trace_xe_guc_ctb_h2g(xe, gt->info.id, *(action - 1), full_len,
-				     desc_read(xe, h2g, head), h2g->info.tail);
+		trace_call__xe_guc_ctb_h2g(xe, gt->info.id, *(action - 1),
+					   full_len, desc_read(xe, h2g, head),
+					   h2g->info.tail);
 
 	return 0;
 
-- 
2.54.0

