Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5C3CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FCE10F5BC;
	Fri, 12 Jun 2026 17:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I+zMYdUf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0506D10EAEC
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 17:17:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 34154601E1;
 Fri, 12 Jun 2026 17:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F327CC2BCB8;
 Fri, 12 Jun 2026 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781284656;
 bh=lonMWUk3tdHkzE//oyRyvMIpUZlUAdavhA4XYi3iZ5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=I+zMYdUfbcqk41yn78YQ7piKTwj5LbiK+zglOuN+Gw21xFv2qu0zIF9q3kHuCojuQ
 b4K1ZvcSl0fKYxuDnFs4qzVxuZJ3RGeHJY/eLQrwclOkYKOPXzTRWXJBKAc5eaWNlT
 wha2eXWLN4LvTWy01vjyO7VXTaDSHenIlBEnuSek5rKNbeeHdP3v31bTFNDB8jwHHw
 kIFomodhOwniVA6X0fBh+/rEl7IUj4EYgnSP6kkA8pCIeQnQmJBBsQqoH5nsfKiMfv
 YW62Bel5SSkZY/woRWbrna6BFfqp4rLqWheSOhWLBIhzB1bc05nh6v8CzH4P7K1UI1
 uml3xqB05qIfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D6C7FCD98CE;
 Fri, 12 Jun 2026 17:17:35 +0000 (UTC)
From: Alberto Ruiz via B4 Relay <devnull+aruiz.redhat.com@kernel.org>
Date: Fri, 12 Jun 2026 18:17:16 +0100
Subject: [PATCH 1/4] drm/solomon: add ssd130x_run_cmd_seq() for batch
 command execution
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-ssd-batchcmd-v1-1-c61e5f7c24bc@redhat.com>
References: <20260612-ssd-batchcmd-v1-0-c61e5f7c24bc@redhat.com>
In-Reply-To: <20260612-ssd-batchcmd-v1-0-c61e5f7c24bc@redhat.com>
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Alberto Ruiz <aruiz@redhat.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781284654; l=2024;
 i=aruiz@redhat.com; s=20260612; h=from:subject:message-id;
 bh=7aY1PLlc9EJ6kLHma9AUr2Hy4BkrCZ+OPY9RYqNraa8=;
 b=lu5PX75vL6lQbkOsRQQAYv7YUE1Tn1Fv/pH2+a55vb6vriNela8AXX4bkuWcnPNH6hDqA6LPX
 CJagk3r8LwEArDW0Hm5Ro+cruvB2clp02mOo6F3mEZNHvRxpdB38+bq
X-Developer-Key: i=aruiz@redhat.com; a=ed25519;
 pk=d1doFQwve1B/jU9nG5oPl1W5d+t+iFrjkkwk/hD97Ow=
X-Endpoint-Received: by B4 Relay for aruiz@redhat.com/20260612 with auth_id=818
X-Original-From: Alberto Ruiz <aruiz@redhat.com>
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
Reply-To: aruiz@redhat.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Alberto Ruiz <aruiz@redhat.com>

Introduce ssd130x_run_cmd_seq() that interprets a flat byte array of
length-prefixed command entries terminated by a zero byte, removing the
need for per-command error checking at each call site.

Signed-off-by: Alberto Ruiz <aruiz@redhat.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index c77455b1834d..46e2c277a9bf 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -276,6 +276,49 @@ static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
 	return ret;
 }
 
+/*
+ * Write a command byte sequence from a buffer.
+ *
+ * Like ssd130x_write_cmd() but takes a pre-built byte array instead of
+ * variadic arguments, handy when the command is already in an array or
+ * when the caller wants to use sizeof() for the length.
+ */
+static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
+			      size_t len)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < len; i++) {
+		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Run a packed command sequence.  The format is a flat byte array where each
+ * entry starts with a length byte followed by that many command bytes.  A
+ * zero length byte terminates the sequence.
+ *
+ * Example: { 2, 0x81, 0x80, 1, 0xAF, 0 }
+ *   sends command {0x81, 0x80}, then command {0xAF}, then stops.
+ */
+static int ssd130x_run_cmd_seq(struct ssd130x_device *ssd130x, const u8 *seq)
+{
+	while (*seq) {
+		u8 len = *seq++;
+		int ret = ssd130x_write_cmds(ssd130x, seq, len);
+
+		if (ret)
+			return ret;
+		seq += len;
+	}
+
+	return 0;
+}
 /* Set address range for horizontal/vertical addressing modes */
 static int ssd130x_set_col_range(struct ssd130x_device *ssd130x,
 				 u8 col_start, u8 cols)

-- 
2.53.0


