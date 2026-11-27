Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6A606A326
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQMPExpF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6779D1129EB;
	Fri, 27 Nov 2026 10:34:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F1510E9DD
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92A4443A2D;
 Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10E01F00897;
 Fri, 27 Nov 2026 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795775657;
 bh=12R8+MxmoCMK3Pvk1lqEg5lov8oGmq9pon4JJH+fMUM=;
 h=From:To:Cc:Subject:Date;
 b=PQMPExpFdlMdxmUO2KahNRNrA+Kixwz2/YhcsQut2hC3NR78H8DXxKij/GC5ktnSm
 MHuVRqFEPvJDZjgKZnzomlFp0Qu9twn8LVj3Pz9jNNQBdnmGDkhAfbBT2niz456lqb
 9IpIcqBAb9hP8d5KB5cs58ZAQ5cird5Bd9J6MTRCiSCyoSfu1AbACzi4OYZhci+BNf
 VsLpTBpDnGyB3hSXfve+iXTnycEiuOdCT8o/1gNtXyGFrFzKrXKz12u5okV3/pXZtc
 A8Jt3SfYNUwWKZUto4GoebTdisCTlZXSBtw6oxLpe4g5+s7W8CTKYnwpB8aIbK1TKv
 gL3zn+ywg5kzw==
From: Thorsten Blum <blum@kernel.org>
To: Junjie Cao <junjie.cao@linux.dev>, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, Pengyu Luo <mitltlatltl@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>, Junjie Cao <caojunjie650@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2] backlight: aw99706: Clamp negative brightness values
Date: Fri, 27 Nov 2026 11:33:42 +0100
Message-ID: <20261127103341.663905-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=blum@kernel.org;
 h=from:subject; bh=rU3L8+ljDsDEvOv0FEVg6DJCO+bDkPX4OtCb3WNCsdA=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNmcMa2yW3Re+UsqXr+275Hjg6b5ixYaiZ/eUbXIMHMNl
 /yr4wnnOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi8v8Z/ievXCh6+N+fvNSl
 HVEPDOync/A1qrr94j/ome/m3Fhw+jsjw/Ov712yrig3nDyXkaxny9bhPuPOsj2nHIQljjy1m7n
 rLwcA
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

device_property_read_u32() reads both the "default-brightness" and the
"max-brightness" properties directly into signed int fields. Therefore,
values larger than INT_MAX are interpreted as negative and pass the
upper-bound checks.

Read both properties into a temporary u32 and clamp the values before
assigning them to the signed backlight properties.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Also clamp the default brightness (Junjie)
- Clamp both values before assigning them to bl_props (Junjie)
- Update patch subject and description
- v1: https://lore.kernel.org/r/20261127021423.656745-2-blum@kernel.org/

 drivers/video/backlight/aw99706.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index 43f82c83f91a..1ea5d0d2146d 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -265,18 +265,13 @@ static void aw99706_dt_parse(struct aw99706_device *aw,
 		aw->init_tbl[i].val = val << __ffs(prop->mask);
 	}
 
-	bl_props->brightness = AW99706_MAX_BRT_LVL >> 1;
-	bl_props->max_brightness = AW99706_MAX_BRT_LVL;
-	device_property_read_u32(aw->dev, "default-brightness",
-				 &bl_props->brightness);
-	device_property_read_u32(aw->dev, "max-brightness",
-				 &bl_props->max_brightness);
-
-	if (bl_props->max_brightness > AW99706_MAX_BRT_LVL)
-		bl_props->max_brightness = AW99706_MAX_BRT_LVL;
-
-	if (bl_props->brightness > bl_props->max_brightness)
-		bl_props->brightness = bl_props->max_brightness;
+	dt_val = AW99706_MAX_BRT_LVL;
+	device_property_read_u32(aw->dev, "max-brightness", &dt_val);
+	bl_props->max_brightness = min(dt_val, AW99706_MAX_BRT_LVL);
+
+	dt_val = AW99706_MAX_BRT_LVL >> 1;
+	device_property_read_u32(aw->dev, "default-brightness", &dt_val);
+	bl_props->brightness = min_t(u32, dt_val, bl_props->max_brightness);
 }
 
 static int aw99706_hw_init(struct aw99706_device *aw)
