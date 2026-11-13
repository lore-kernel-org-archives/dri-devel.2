Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AEC606A88A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPxuuUc5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2431310E1AA;
	Fri, 13 Nov 2026 21:28:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F9E10E1AA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 21:27:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EC1641A85;
 Fri, 13 Nov 2026 21:27:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794605274;
 b=AP/KzZDfZ8bCMo4cm/5Tl0XIRRXx4HchidV5jwysu2+ofqJSFzxLhYjpvbeeSJbYDBGj
 5miUorO4pld2vTZQQ4xY1F/3GnRPRWkUET31+LdTfidvNGVdiBqrkHZgChrQWVskzBlhd
 eD2YWJwk9vQ0dbGrr2esMDd4XjdGOIE0tfLEKabmbGPkE2JkM7jkq5a352nGTcaOLeEz6
 1CfbxD8DmcXiMEotMmOJ/q2cqt7klmB4+WZQrY0Z2okO7HyEtacf1zQjTOGH1wyIKrRnp
 GzriWM12ggJhZfHPe8DJMDJ+JLxohbDJ4k4CtIcZRKUz2M4A9viGeOl5+CNpcImlAcA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794605274;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=k2xYll9QcnSCQUYhZz7UgDQuNChadFhDR/is56uKZSQ=;
 b=eQmA4zd8RP1ajMgEOIKpvlA9TGpjrWCmuqkiKcSeJuN8ukxiihdzpI1OMGvHWfBCP/uZ
 1NuyvwHsNC2jE4qlTV3Np9B/xB7pIFvZndrhODFNh+pqTBNv4yuzCMup/yfUpxxe29zHf
 vzmwEWur6N/R6mAnaqe/T0RPlJo3364NDybaNQC+q3yjkzI//vrpsJeBwX3eRLCZxXXNz
 EvOBUbY8P+TZJRYePwO2yDoUZfg2mzKll4ORkLhPQRXQVKVmWiCpEodDhO4rSyPN6bfEF
 Mc+Yr5q0LMbU1gaOMfJ5EW3FewnNgXCjBoCUzlYCdElzEO6NG6xPs0SmFlgCMem/AQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 06B481F000C4;
 Fri, 13 Nov 2026 21:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794605274;
 bh=k2xYll9QcnSCQUYhZz7UgDQuNChadFhDR/is56uKZSQ=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=LPxuuUc5oehLgqWVojLImACb58EnQ3Za3nnD7SzN5+tdwnxLH+0C9UWUSCvKKlRCR
 K9Bzxa7xpd49KK2hVXqGwWHjj0dylsyN6hmNAYIkYh0M6Bdieqn3MGFJWV5rfHiPIi
 NaPKQZ2awad3Gqz9p+0RpHrEMGe/uCLYd4AA2H4YDVAZcRX5MeUntv2dYqDy/W18mV
 xkaP6Kh1XQ/TDuvHW4haCJeLX59Ar4C0UXnS2Irlf4AOK/K5/64USair5i9RHjD7jG
 SFZZQsBoK59NjHYUjHxuQcj78JDwU06ZuH5VrCoL9+kk/IulujvC9GxzSvLU59s+tH
 0P38D1g3l1ABQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8C95149B06;
 Fri, 13 Nov 2026 21:27:53 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 21:27:54 +0000
Subject: [PATCH v2] drm/debugfs: Accept "reset" with a trailing newline in
 edid_override
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-drm-debugfs-edid-reset-v2-1-07939ebe7a8b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CQAxFr0Jmbc20Iior72FYwLRAjYCZAaIh3
 F3AuHT5kv/fm0wQrxJMGk3Gy6hBu3YB2kXG1XlbCSgvbMhSgogW2DfAUgxVGUBYGbwE6cEebZy
 TdcmJ0Sznp5dSX5v4ln05DMVdXL/a1kWtoe/8eyuPuO5+EfoXGREQYsd44fPBMdG1anJ97F3Xm
 Gye5w8kD9nrzgAAAA==
X-Change-ID: 20261110-drm-debugfs-edid-reset-0504a20c67d1
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605273; l=2090;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=NYL/q8RW4OVHSqWl5Xmdo7H2RuHmd47GPaMUXnBj3ww=;
 b=GBnVq8NpjUHncNStUoHXfUdva311z6rUwCSQZaIRbwplqMYBmr7bkrz/OHXO8V0ciQtVA1ORm
 R+wmP0AUgD3CMWYf1zSh/XSbO+eEhj211EZT7oZqLXal3aycABZMEW1
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

Writing "reset" to edid_override only removes the override when exactly
those five bytes are written, so "echo reset > edid_override" fails with
-EINVAL and leaves the override in place.

Compare with sysfs_streq() on a NUL-terminated copy, and reject writes
larger than the largest possible EDID (256 blocks) before copying,
so that the size of the copy is bounded.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Tested on an Orange Pi 5 (RK3588S) with this patch on a 7.3 based
kernel: "echo reset" and "printf reset" both remove an override, an EDID
override round trip still works, and garbage or oversized writes fail
with -EINVAL.

Developed with Claude (Anthropic), which wrote the code and the commit
message. I reviewed and tested it.
---
Changes in v2:
- Use memdup_user_nul() and sysfs_streq() (Jani Nikula)
- Reject writes larger than 256 EDID blocks before copying
- Shorter commit message
- Link to v1: https://patch.msgid.link/20261112-drm-debugfs-edid-reset-v1-1-4cd19d83cd22@gmail.com
---
 drivers/gpu/drm/drm_debugfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index a72f9723d3a9..7c39c8ed3984 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -565,11 +565,15 @@ static ssize_t edid_write(struct file *file, const char __user *ubuf,
 	char *buf;
 	int ret;
 
-	buf = memdup_user(ubuf, len);
+	/* An EDID has at most 256 blocks */
+	if (len > 256 * EDID_LENGTH)
+		return -EINVAL;
+
+	buf = memdup_user_nul(ubuf, len);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	if (len == 5 && !strncmp(buf, "reset", 5))
+	if (sysfs_streq(buf, "reset"))
 		ret = drm_edid_override_reset(connector);
 	else
 		ret = drm_edid_override_set(connector, buf, len);

---
base-commit: cb0a63f0c96e8ecb90199eeb99cc2a7fcfa703d4
change-id: 20261110-drm-debugfs-edid-reset-0504a20c67d1

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


