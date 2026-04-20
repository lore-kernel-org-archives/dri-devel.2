Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95D1F3ED73
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63FD10E00F;
	Mon, 20 Apr 2026 05:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ou7t1Dz1";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F261410E00F
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 05:19:29 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8c9f6b78ca4so336219485a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 22:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776662369; x=1777267169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XVBsgs/Wk3x8UxkibJW5Haz8zZ0ewkla2R+/4mLmWr8=;
 b=ou7t1Dz1ehjjiMiycNHHybAlXYERurqGn4L/qy9jb3pI98LRqmZLrbgAXtNW5ocuvl
 jZ/jIctXgmyIXun2ktXl0PpsrWWznF5OOApdpo9PHyvIClyBhl5dAX2jfjDQGvWtvY8j
 3oStjZDRql4VFA7RkN+SwPlHYUtNcMcX1oUsXHomdQPR/X+lopPPGC66ITMZgBzCmtiv
 +dkcBfG/eaFt+vZPa45K4IUu3DCZJviKQ8y6UchuFiPY6J/Dutf0qhQ69xqZ3i/DPBbO
 a3w6hmHeU4IZPCXlh01lYaoOcIGp/35G/+jzteHEyakhtycwaUkk6jCAZ+CvVb2KWuf5
 grww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776662369; x=1777267169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVBsgs/Wk3x8UxkibJW5Haz8zZ0ewkla2R+/4mLmWr8=;
 b=BmwMnwycFqDd6LopggWTok0V7u4EksPem4HNag00320htA7hOJhzp4e6kM6LNaE3H9
 1oH+dshSbaa2qzaEurYdp/43rBFw4Za/Kq5grvj0M3vBnEvF8uSDnG8EEMs2Ky19a3d8
 iiLxY0NbOc1PsL35QXPO2DZEnYP/mED6aXcz8u6HiWqCsvVROvv4YhO0y27qzWkQmBFn
 OTvotTqE+9ByFetVU5eQi3dno5RQymEWHqZtlhPF07btgS749RXYq+zDIXGAqkDEfNuX
 MRQZrB6ioJGrzXnTTQ6DRWrr9yK0UszdhelC8Q3p1QJ3GpVTv2r9xc3/HpE2qBRA+XGW
 pCYg==
X-Gm-Message-State: AOJu0Yyds5TU7fj5qvcPL558XStYdeH3XyfcGQ7waPaAfs/W/ed+UoAd
 42rNjbFu4k5O2wnR+04/2exiqxNNPQN2pUVB7VMjsX818N5q1oYWqlKq
X-Gm-Gg: AeBDieulmUq5iC6mby9u0UGEnQS7Tr6Fx3pSuW6SktUA8TUV8MXbx8EJFM0oOoTDJ06
 SPOY6P0qpOtsKVDjBOweXSJTE/mMJOzVkmfYd3RnMVDyR9iOH7wcVFOQjL9QgMRFrEJEZXR94bL
 j6HQRP2KbhONdjbn/7eP8vwOglDOM0VEx+ODm7KB0OsqCV+npikGso0JUS3Ly3Rt98mO8OCZJYk
 aXJUOfPwgmqDBRdeLFIAFc4e2yILR4W7WNz7GsAX4IbtWjjksH6QhcyN/ANqLIgkJp02/HxVOR2
 O1AvVtT0SKRqkKbImAbHj7j6RzNrFeM1lWjoIwENA5tEdF2GmXch6Ss54KvRM7sbgE0Jnif9ToA
 N7u7KGaSTq/pvrWAZ2Rr5uybQDQDlEUbFDVURxYajyB5iIPnY4Bc1aG/ZNC8KQrWQgXWNlq2vj9
 aIK2NTmLbgU+vSRU5G7KNc2mTKFTYRcx1VNJ900H/E2II/ilnw2gxFy96O87A=
X-Received: by 2002:a05:620a:2913:b0:8cd:94f9:1bb1 with SMTP id
 af79cd13be357-8e79010e10emr1688870285a.27.1776662368751; 
 Sun, 19 Apr 2026 22:19:28 -0700 (PDT)
Received: from localhost.localdomain ([165.85.38.136])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d99c3c17sm726161485a.45.2026.04.19.22.19.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Apr 2026 22:19:28 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Antonino Daplas <adaplas@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>,
 Taegyu Kim <tmk5904@psu.edu>, Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] fbdev: savage: fix probe-path EDID cleanup leaks
Date: Mon, 20 Apr 2026 01:19:26 -0400
Message-ID: <20260420051926.28276-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
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

When CONFIG_FB_SAVAGE_I2C is enabled, savagefb_probe() can build both an
EDID-derived monspecs.modedb and a modelist from it before later
failing.

The normal success path frees monspecs.modedb after the initial mode
selection, but the probe error path only deletes the I2C busses and
misses the EDID-derived allocations.

Free both the modelist and monspecs.modedb on the failed: unwind path.

Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index ac41f8f37589f..c2f79357c8da0 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2322,6 +2322,8 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
  failed:
 #ifdef CONFIG_FB_SAVAGE_I2C
 	savagefb_delete_i2c_busses(info);
+	fb_destroy_modelist(&info->modelist);
+	fb_destroy_modedb(info->monspecs.modedb);
 #endif
 	fb_alloc_cmap(&info->cmap, 0, 0);
 	savage_unmap_video(info);
-- 
2.50.1 (Apple Git-155)

