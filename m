Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E43CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA54010E136;
	Mon,  5 Oct 2026 19:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GDlKQn+G";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E5210E20A
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 19:41:30 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33c11ef641aso3527232eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791229289; x=1791834089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uv7afzpq7+dnopZxaVqr0Kj31R9b5sq4pmvrJx8z7b8=;
 b=GDlKQn+G2u723g5xut9B4u8m8OeeL5rFsy5KUonHd/pW8G8wjRv0MNsY0tnx7TI8I9
 xDIsKbR9KQf2E70f2nk7Rv9H7dBJqho4QJXqHjCUyGiCkzEgRnCPRwVfBh07qAlWQ2K6
 Mobv0WhQsP6wr+lMUjaZeHmvNwOIhpD1F5O3F38SaF/JUDOtiT0R3PSuXoEZsPmhMy9F
 J4M1Tuo8ioryJngRd5MiOTvSsGgIt0+cZ7NPNBXY498SVK1500e7Eaa9wZjfWUC3gntI
 NJcAKxyKMXoV6czGm0pt+WD7JJrg7EyFZftNY432lC7JVyT/TJgRsPO5W00O0LpH065/
 CScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229289; x=1791834089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uv7afzpq7+dnopZxaVqr0Kj31R9b5sq4pmvrJx8z7b8=;
 b=Gtd8Un3h3UQdLjcIJAuGf/WwVLErZjngNuF+TSEuDGNGtMsI6b09k3m2JWJ6M9mU3j
 w6k9jvGvU0LPd6vOaCIh83SBMz/yarrmQTA/lX6eBLkOOkaabNSWM764WugJBJJpBu7C
 cCrwpPtenA+dxHED3riEa3U8VT9teWFwMbspVa1EH1OUsBS43BpfGrgl8m9t6xp6F0tg
 DsKgRY/D/BfYumpSdkBYfTfDseBNcvBW98XDKXu7dcgYgvatOBQ02k6SFV4Zn0gbhlvi
 NHxREErIh8Dvzb94f0+miJcyXU+MYOv2vzENERTsFJSVlo7vzM9luUU3QujoyvL+bdZR
 uDwQ==
X-Gm-Message-State: AFq9FYLWP5o9C2bD3CwJmfzvmcI9xSRX2Zp9ucLkn5oDnh53EymU2aNv
 d2zS5GVbSxIqaSD0xm5uPt51hoFLqdPi3jCeE+i+Bbopm0gsRvuCwwxMlejy186mpM0=
X-Gm-Gg: AYBFou2QklTNIs5d0UPIcQjDPCU3cJrlTcCHN+98ee5JJWHi+vEgLHa71010HBtR3y3
 +Z2kSV/vhByAq1V1AozxmcBCWEUjr/Autl99Xhl6slWZ5Kcbv8tZgWp4v+DUb9xjdxIKXO8f/cy
 SlnDgG0BhTsJqSae9S0NikNjAQd5iCiFZKt7hx+/Hdh1b0ch24VMegQRjSD6bLMkaAX2tnOtdSK
 fhvMeFlAnuOUE+Ium70kJ1Gy7HpAcm4+JQh6OPOnrZaG13xIf1Dxbjz2YBFI4RWPcaRV4sgTSEq
 OeMVwanV/P4IA32q8W6qsxMwWvxavUOoprfOSzJoqQXCij8DZ2TXZKgm+m6Ob/+qfCQKaVqyjrM
 SVHmoK6dUcwgaef1cKOZ83Ke0uMKO8bvWWOtq+aKnJM9GG1x9/YXuXCcnlLPHqORH9Ab8yUy6jr
 IDP6cXUSq6PCV3U9oYnmfh/VvZTv+/AlxWwxmR/DTqEwN6rLj+e2oeqAiYQIRMaVpMLPwTWk4To
 l3koEiU+n+RMlQFSv5qeUMtxf8tPRGual4VQx9HjH3qnjeYYEX1yH1m97Tbs6weu0hyFeysiA2T
 1GsnPycokJpfFZdc9nexbVgXUcH9bRYwWdAkzUHrxIBLTMkW
X-Received: by 2002:a05:693c:65c4:b0:350:2a5c:56c with SMTP id
 5a478bee46e88-3502a5c09d7mr14871911eec.20.1791229289353; 
 Mon, 05 Oct 2026 12:41:29 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35146b3b5aesm848241eec.29.2026.10.05.12.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 12:41:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 imagination@lists.freedesktop.org (open list:IMGTEC POWERVR DRM DRIVER),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/imagination: simplify pvr_fw_trace_seq_data
Date: Mon,  5 Oct 2026 12:41:27 -0700
Message-ID: <20261005194127.151181-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The trace buffer copy always has ROGUE_FW_TRACE_BUF_DEFAULT_SIZE_IN_DWORDS
entries, so embed it in struct pvr_fw_trace_seq_data as a fixed-size
array instead of allocating it separately. This removes one allocation
and its error handling, and lets FORTIFY_SOURCE and UBSAN_BOUNDS see the
real size of the buffer.

At about 48KB, the struct needs an order-4 page allocation, which can
fail under memory fragmentation. Allocate it with kvzalloc_obj() so it
falls back to vmalloc in that case, and free it with kvfree().

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use kvzalloc_obj()
 drivers/gpu/drm/imagination/pvr_fw_trace.c | 25 ++++++----------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index 6fe478f64f02..27bbc62114b1 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -240,9 +240,6 @@ update_logtype(struct pvr_device *pvr_dev, u32 group_mask)
 }
 
 struct pvr_fw_trace_seq_data {
-	/** @buffer: Pointer to copy of trace data. */
-	u32 *buffer;
-
 	/** @start_offset: Starting offset in trace data, as reported by FW. */
 	u32 start_offset;
 
@@ -251,6 +248,9 @@ struct pvr_fw_trace_seq_data {
 
 	/** @assert_buf: Trace assert buffer, as reported by FW. */
 	struct rogue_fwif_file_info_buf assert_buf;
+
+	/** @buffer: Copy of trace data. */
+	u32 buffer[ROGUE_FW_TRACE_BUF_DEFAULT_SIZE_IN_DWORDS];
 };
 
 static u32 find_sfid(u32 id)
@@ -454,17 +454,10 @@ static int fw_trace_open(struct inode *inode, struct file *file)
 	struct pvr_fw_trace_seq_data *trace_seq_data;
 	int err;
 
-	trace_seq_data = kzalloc_obj(*trace_seq_data);
+	trace_seq_data = kvzalloc_obj(*trace_seq_data);
 	if (!trace_seq_data)
 		return -ENOMEM;
 
-	trace_seq_data->buffer = kcalloc(ROGUE_FW_TRACE_BUF_DEFAULT_SIZE_IN_DWORDS,
-					 sizeof(*trace_seq_data->buffer), GFP_KERNEL);
-	if (!trace_seq_data->buffer) {
-		err = -ENOMEM;
-		goto err_free_data;
-	}
-
 	/*
 	 * Take a local copy of the trace buffer, as firmware may still be
 	 * writing to it. This will exist as long as this file is open.
@@ -477,17 +470,14 @@ static int fw_trace_open(struct inode *inode, struct file *file)
 
 	err = seq_open(file, &pvr_fw_trace_seq_ops);
 	if (err)
-		goto err_free_buffer;
+		goto err_free_data;
 
 	((struct seq_file *)file->private_data)->private = trace_seq_data;
 
 	return 0;
 
-err_free_buffer:
-	kfree(trace_seq_data->buffer);
-
 err_free_data:
-	kfree(trace_seq_data);
+	kvfree(trace_seq_data);
 
 	return err;
 }
@@ -498,8 +488,7 @@ static int fw_trace_release(struct inode *inode, struct file *file)
 		((struct seq_file *)file->private_data)->private;
 
 	seq_release(inode, file);
-	kfree(trace_seq_data->buffer);
-	kfree(trace_seq_data);
+	kvfree(trace_seq_data);
 
 	return 0;
 }
-- 
2.56.0

