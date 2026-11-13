Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FD606A331
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=x0E1WDdV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D7510E444;
	Fri, 13 Nov 2026 11:47:35 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7BA10E444
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 11:47:30 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jQwV70xgdzKr56;
 Fri, 13 Nov 2026 12:47:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794570447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hw6iuwPNz9xqHLB6VPecRpVOyJoujoDzeolzbUQLp+8=;
 b=x0E1WDdVP4c9oqpyfQAwOc/vjGHZ2uDFSX5kPvZydwf1eOVyH3B0NUpQonNZLTDwQttkFS
 pKnceJtSKU2t4esGm59G7LYVP1XOSKwOoiuFrpXzA9CxW1bBjGJa5esXD1mpwGEuWbMkuu
 9ku6OJtwufgLAaXb/7LnLEUhfyH8V83kudYCEk5dt46NF7YHXMhF90YQIuHG6zztsAtZkw
 zS/HlowPvka107q5puvkiuMD/LpDCWcP8TgHBFq5N7VxzB2bI6oaSLqCuoUD49kOfWBo2t
 pYMtEgj/F5dGglax32wYH5Z9vp7yGCb9pUtTUngdTFD1mL1jFm8Bq39b4msGGg==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, Petri Karhula <petri.karhula@novatron.fi>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] backlight: cgbc_bl: Fix kernel-doc
Date: Fri, 13 Nov 2026 12:45:52 +0100
Message-ID: <20261113114552.895592-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 76b2e7b13eb03885d2a
X-MBO-RS-META: d8ac538mishf1rhdaakw5ozqknkm43q5
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This comment describes a struct as a kernel-doc. Format as such, fixing:
  $ ./scripts/kernel-doc --none drivers/video/backlight/cgbc_bl.c
  Warning: drivers/video/backlight/cgbc_bl.c:29 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
   * CGBC backlight driver data

Fixes: b516456e9f91 ("backlight: Add Congatec Board Controller (CGBC) backlight support")
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
[v2]
 added 'cgbc_bl: ' to title (Thomas Richard)

[v1]
 https://lore.kernel.org/all/20261112192744.850142-1-manuelebnerli@mailbox.org/

---
 drivers/video/backlight/cgbc_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/cgbc_bl.c b/drivers/video/backlight/cgbc_bl.c
index 3be140284e..63408fe40f 100644
--- a/drivers/video/backlight/cgbc_bl.c
+++ b/drivers/video/backlight/cgbc_bl.c
@@ -27,7 +27,7 @@
 #define CGBC_BL_MAX_BRIGHTNESS     100
 
 /**
- * CGBC backlight driver data
+ * struct cgbc_bl_data - CGBC backlight driver data
  * @dev: Pointer to the platform device
  * @cgbc: Pointer to the parent CGBC device data
  * @current_brightness: Current brightness level (0-100)
-- 
2.56.0

