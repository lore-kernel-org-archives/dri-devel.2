Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037E6FCD0D2
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E62210E73C;
	Wed, 18 Mar 2026 08:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UGOIR7jD";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B20010E1B9
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 19:11:12 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-829a9d08644so3535305b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773774672; x=1774379472; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ey5xOspEF8t8qpOzkawTxCYiw1oiTsiTR8cXxAAxS3s=;
 b=UGOIR7jDJDlhnXhmmyaTHa6VgrnP0zU6tgwOTuoVmHr2j4pINFADD8u7e98dKd+2dD
 nZwxwoPPad1vlUNJT+3ERo414G0zaEOE8pNYWgW+BecbB1N2mVc8xkFFXcU1ViqFZbxy
 bsloIy3v5Vl3GRJEGz1wxugqYzzfqSGeTscfBe1p6UV6dCWwKsxk/u3/7HEtfBWNXnQH
 7hd+JyAHAaWeNI4m+REyDQu4aeX9SFUVguJdNpxl90rJ8Fapcs2bGDOCbOTD3hFYjHJD
 ICxhk7uQY3LP1FeP4eUIaJf+UZHOydRCkZYOuXojpg1Bfvkcsz7e8sfkxYnfpu4BgbDe
 K+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774672; x=1774379472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ey5xOspEF8t8qpOzkawTxCYiw1oiTsiTR8cXxAAxS3s=;
 b=NNhXYtSxP1y+uE4qHecjXgl7qpU/5XDoTzvwd+js0oPcSFZiQYIFqrG0zfOCk1M8V7
 3EJAO0yQtLyZRgTOXMErgxVkry3rEKK9HMtLHflbh0KmvpwRrXJISNDL09pmZDD8tA35
 7Kte9CD1nIDvyPmfa/cvPHyItRbrTwQlF9+1kThznENDN8BrY64bfiAlTXNE0ca77e68
 ympfjaLTgXxCmx7cFiR/I57X+sJbFnTGpGNLRyefRYixYai/JiofqkmEQ2OxwVChTSJB
 z3bMACuCPfSo4kWhmx1vIy7PgDZebsoMUGt3fFJEQxSHAsc2+21V9g3cTmQsWPPc0Rnl
 4GLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvlAU/n8Wroh2pigCQbZ26KLWSsqDyLEBSNAX6byFptnLGSKKBx6jufZ/zUViQ8vr6rMF4l0bV034=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+b0bcwRbpRGsUJBdqHVF61PL5pLnJMmrz1joVXvQZYIwyVJtg
 tD12hfpIFDNPlvViAZ+13htgnDVWXkeZAm+3oXlGlrrJ2zQi0eApHpyucZC/Ew==
X-Gm-Gg: ATEYQzx+2eI+614h58cze97iPRb+om8d/jJRSG59NuCj3CR+pG5JYEQgvrk6YxFIg46
 ++z+hzNx++09isc9ECn67WfwJfDcx8v0/wkR66xpohtwdNx3e31ozKqQEl2p5s9ZfPuYgJqDIiN
 VDG+BXSEs34tdg3UB7y/SARYmIwX/xFszqDDR4FOVHo6bo6/Qp585w/GBfH2AFA155qUi9owKwb
 Hns/kGb/bRxPNuS+hbbY91JVgmo/QKfxLg67DKNs7S7Z3045kQsG/9X7GNXx58nnLUL2kzwNFu1
 XZk/4tYB5vzQFDDsIUOvm3EjAOGR5lnNVRZopZ965Gcor9iXk3KbDBm1B0/PlcpI0MynsF6xt8q
 K4bBCTBFPOVt+n/wSkNllHoSE9EL+yeGFagiBPK+v+R7fCfQCeVQqQcSp1F0tYn6JDBfFyD9mqU
 IvMw9edoEIGw7gOTQddkHZxIul9j1Qx7YZjii1xBnJoGfV5D/vk4aFsarzQo5JGWWWKrqLDnBV8
 /HTmp3Y5fwDpnt/aiD2/1QcBcX1Nw07jSJxujljOMaEqULxOpaBHKJgAfc3Up4n6aKRHw==
X-Received: by 2002:a05:6a00:1ca3:b0:81f:4ce8:d64b with SMTP id
 d2e1a72fcca58-82a6ae4f234mr356985b3a.44.1773774672367; 
 Tue, 17 Mar 2026 12:11:12 -0700 (PDT)
Received: from 2045D.localdomain (76.sub-72-110-123.myvzw.com. [72.110.123.76])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bf0cf5fsm224612b3a.61.2026.03.17.12.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:11:11 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: gregkh@linuxfoundation.org, dakr@kernel.org, rafael@kernel.org,
 vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc: pierre-louis.bossart@linux.dev, rander.wang@intel.com,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 akaieurus@gmail.com, me@ziyao.cc, Gui-Dong Han <hanguidong02@gmail.com>,
 yangshiguang <yangshiguang@xiaomi.com>
Subject: [PATCH 3/4] soundwire: debugfs: initialize firmware_file to empty
 string
Date: Wed, 18 Mar 2026 03:10:29 +0800
Message-ID: <20260317191029.43515-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317185920.43387-1-hanguidong02@gmail.com>
References: <20260317185920.43387-1-hanguidong02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

Passing NULL to debugfs_create_str() causes a NULL pointer dereference
upon reading, and creating debugfs nodes with NULL string pointers is no
longer permitted. Change the initialization of firmware_file to an
allocated empty string. Existing driver code using this field handles
empty strings correctly.

Fixes: fe46d2a4301d ("soundwire: debugfs: add interface to read/write commands")
Reported-by: yangshiguang <yangshiguang@xiaomi.com>
Closes: https://lore.kernel.org/lkml/17647e4c.d461.19b46144a4e.Coremail.yangshiguang1011@163.com/
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 drivers/soundwire/debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index ccc9670ef77c..d4abe8bfca76 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -358,8 +358,9 @@ void sdw_slave_debugfs_init(struct sdw_slave *slave)
 	debugfs_create_file("go", 0200, d, slave, &cmd_go_fops);
 
 	debugfs_create_file("read_buffer", 0400, d, slave, &read_buffer_fops);
-	firmware_file = NULL;
-	debugfs_create_str("firmware_file", 0200, d, &firmware_file);
+	firmware_file = devm_kstrdup(&slave->dev, "", GFP_KERNEL);
+	if (firmware_file)
+		debugfs_create_str("firmware_file", 0200, d, &firmware_file);
 
 	slave->debugfs = d;
 }
-- 
2.43.0

