Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8529D106ACE1
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB7610EA97;
	Thu, 12 Mar 2026 19:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="glxrrPU+";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109B510EA9D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 19:21:47 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8296dabef74so1353211b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 12:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773343306; x=1773948106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2E7o9mf9DFu5JCjWUjXsYbAic15IwHrJMx4QeoSfAR4=;
 b=glxrrPU+LxNTueWGWtCbhXTWwulo8tCm3fZYVmT8SHJFyovtGDopAJIwWbwLrU7AO3
 16C9mXLEo9s4Li3piVDb4busuD8M+5AD5E/7NjLK0ntOGJKiw1/paxotwL072K/pSk5p
 fEH+yDXbP07zy8FnpAosp4tzpla8jOjsFosigyJK8QgEKKIPsLAuFgOuwqh/85DcikYM
 crHsCKgUFILqPBSM5/lDdoGeOoCSz5m9a/ZDiMmKLuNNh5fEFAUPKSOgXZN7yRs5PFCr
 PRGoF2YqKLctKHASWZYbJYx58LSsnegPVip7752nVKT0IyPNaDlFG63b2/HHGOJMjQXI
 h44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773343306; x=1773948106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2E7o9mf9DFu5JCjWUjXsYbAic15IwHrJMx4QeoSfAR4=;
 b=PXRz3TgbhQP3v2DrAeYoDw67IVW6J0E7HavdeMc3AIANsAQ6kZV0+PPc5oMteO4MuT
 JXykFFhCtfjyz+3sVkN63pGZLVRU+NEfHdbSRMkbqAb2kDkTsSeltj+7fJJR1z98gRRP
 Tp7jZn6fe42CjYnzl51VSoru2i3qjLUXgfj54xxXe09Qr/wfV/DC3IZ21jOLEb8crLBV
 /cNJloTlDu9Em3PXndxDNTxKWpvJpUzRFWmUvd/BaNqfwhKm81TaGtv/vXI5n1ZaMH4I
 l9+ujFji9YimGkPir4ITxdgiJ50xADhvYC/KBdomroE/wA8Ohp1MzsStjfnO9s7fO/OR
 l6Hw==
X-Gm-Message-State: AOJu0YwTgn/Lq/u7rXdxaHQjOEB/DjE2nYX6i+VVfouYAJSFaOqHD8ku
 jSpuJwB+A/qH1SlW+9cE/rivGZkUD0gY+xU5B/hQp34OeLvIg6n3VXblMVnq2dOg
X-Gm-Gg: ATEYQzw5NHcNuoIfBGzpIQF6LGfAQ+UymD+SebpUdgcjeBSIPDUKJR4vfc4/In7R8Y9
 Y2UJlcaaNUNzPM8N5st9cFVkzHHqI79WmcJ987itM92gN9Ig5x21iwkJdOR6f6k2Iv0j6L4iFYo
 kT0LyDWq0Cfk7aT2hiPJxbOxaz93nWtUcxziQRMAgGuN5kOYkDiuQLjHRcc7+tTJL6sHgd065jy
 VozHqJ+7NE6MsCaOocR3WmXZYr2X4uPJwMLxxkSwyAOemM6S1rBFfmL+htu5tA6dMFIuX6Djvxn
 r9VxHELyNocbT1d0psCD6fiwxO3cI6MLMJ0gQMbFYx/crImSZqeH4BbRR4N6jUBRdfABXsQZxxV
 RodATx0HqO27w/4Oq8JgI9dMGH55d6xjzQJ7PGNYMCjDHyKSp7hkLS/It1Ib8f8Vmd9NnwGYq2S
 Wh1R4bT0jrsdJaFU/FGLnyR+dNVoRbRUziM/qo8QtWhtY83v3n2vVVQA==
X-Received: by 2002:a05:6a00:190c:b0:81b:8872:ae10 with SMTP id
 d2e1a72fcca58-82a1958bfeamr561146b3a.0.1773343305938; 
 Thu, 12 Mar 2026 12:21:45 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0725e05esm4549179b3a.18.2026.03.12.12.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 12:21:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/imagination: simplify pvr_fw_trace_seq_data
Date: Thu, 12 Mar 2026 12:21:28 -0700
Message-ID: <20260312192128.4133-1-rosenp@gmail.com>
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

A flexible array member allows one allocation instead of two. Which
means one less kfree to worry about.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_fw_trace.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index e154cb35f604..99d002b481a9 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -241,9 +241,6 @@ update_logtype(struct pvr_device *pvr_dev, u32 group_mask)
 }
 
 struct pvr_fw_trace_seq_data {
-	/** @buffer: Pointer to copy of trace data. */
-	u32 *buffer;
-
 	/** @start_offset: Starting offset in trace data, as reported by FW. */
 	u32 start_offset;
 
@@ -252,6 +249,9 @@ struct pvr_fw_trace_seq_data {
 
 	/** @assert_buf: Trace assert buffer, as reported by FW. */
 	struct rogue_fwif_file_info_buf assert_buf;
+
+	/** @buffer: Copy of trace data. */
+	u32 buffer[];
 };
 
 static u32 find_sfid(u32 id)
@@ -455,17 +455,10 @@ static int fw_trace_open(struct inode *inode, struct file *file)
 	struct pvr_fw_trace_seq_data *trace_seq_data;
 	int err;
 
-	trace_seq_data = kzalloc_obj(*trace_seq_data);
+	trace_seq_data = kzalloc_flex(*trace_seq_data, buffer, ROGUE_FW_TRACE_BUF_DEFAULT_SIZE_IN_DWORDS);
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
@@ -478,15 +471,12 @@ static int fw_trace_open(struct inode *inode, struct file *file)
 
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
 	kfree(trace_seq_data);
 
@@ -499,7 +489,6 @@ static int fw_trace_release(struct inode *inode, struct file *file)
 		((struct seq_file *)file->private_data)->private;
 
 	seq_release(inode, file);
-	kfree(trace_seq_data->buffer);
 	kfree(trace_seq_data);
 
 	return 0;
-- 
2.53.0

