Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C76DC55173
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 19:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492D010E385;
	Sat,  1 Aug 2026 19:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=inria.fr header.i=@inria.fr header.b="QM0r4+rW";
	dkim-atps=neutral
X-Greylist: delayed 428 seconds by postgrey-1.36 at gabe;
 Sat, 01 Aug 2026 19:17:19 UTC
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BCF10E093;
 Sat,  1 Aug 2026 19:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eGNzqQoF4RSNQLvpJf4olM07e0yunhY4ZG6n3gv0Pbg=;
 b=QM0r4+rWXtHFIynievF2F36tTDpXJJvjv8QAnmZ7jiVtuoGatIQlIEBm
 p2YlTSKM4oY/5WVNY/Cgre9K7+yNZ2e70oeNLleKJTJsjqgx/PzylTWV8
 gix3DdaR2VdZn6ghmp6Uol1gVH823uhhEosB3mrPxXbJa/UsCydBPvMP8 g=;
X-CSE-ConnectionGUID: 0W+Bu0iYTbyt4Z338D48tA==
X-CSE-MsgGUID: eaIW/iH/Tm6zTtu7JyXogA==
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,198,1779141600"; d="scan'208";a="288769010"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 21:10:08 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Lyude Paul <lyude@redhat.com>
Cc: kernel-janitors@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/bios/init: drop unneeded semicolon
Date: Sat,  1 Aug 2026 21:09:54 +0200
Message-Id: <20260801191002.1383835-8-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
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

When a function-like macro expands to an expression, that expression
doesn't need a semicolon after it.  All uses have been verified to
have their own semicolons.

This was found using the following Coccinelle semantic patch:

@r@
identifier i : script:ocaml() { String.lowercase_ascii i = i };
expression e;
@@

*#define i(...) e;

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
index b54f044c4..3f888fb97 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -403,7 +403,7 @@ init_table_(struct nvbios_init *init, u16 offset, const char *name)
 #define init_io_condition_table(b) init_table_((b), 0x08, "io condition table")
 #define init_io_flag_condition_table(b) init_table_((b), 0x0a, "io flag condition table")
 #define init_function_table(b) init_table_((b), 0x0c, "function table")
-#define init_xlat_table(b) init_table_((b), 0x10, "xlat table");
+#define init_xlat_table(b) init_table_((b), 0x10, "xlat table")
 
 static u16
 init_script(struct nvkm_bios *bios, int index)

