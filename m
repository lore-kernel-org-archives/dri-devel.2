Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F310CA9EC5
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9352E10E8EB;
	Sat, 10 Oct 2026 11:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="mGkw0dUh";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634A110E042
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:31:27 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so3398645e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791621086; x=1792225886;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=27dNsyUa7fhD1O/J2+BjSAdyJgmahNgxjJzz5yMN3P4=;
 b=mGkw0dUhFn0P4K8UHOer/j+OkO5fMepG947zJ/fmU1lh7Ryf+Y8TGV0ixI47nrdRkG
 1y+9UNbBdxR/Wvwd3baATUCY6IL09wx+jpHpXWL43pDsw2vMa1+2t6qhx2fB6LWmnnKj
 HdkslbWifPYFKZ3tzm8Mflf2gEC+8KRMeNFlhbb3rfmevqVKx432yKwRWraW66khVTH7
 jpldr2A4mpF/yk8SYx3wqnMf8fRV7y05ZbNo7Oyg8wiZNKu6mXW0WyiVqof4HIAatcgp
 OCMoSxIKrc2FlMkxsrEasU2nHjz1r+hdLlyUCas5IfhE/5lHBiMvcKISPEQfVd4JeGaA
 sNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791621086; x=1792225886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=27dNsyUa7fhD1O/J2+BjSAdyJgmahNgxjJzz5yMN3P4=;
 b=BiwcGM5gAHBg4UOKI/FjRpln1K7UEGstv0t2U7hx78hZJtK79Q8Ev8MyGWeS2JJJLa
 nMZc4eCUgBa6a+ltA5jqvIwqKjsw+lxlVBQXOhJiz5PBaolYoNEBjhxZGSgBKLf4CzXj
 on63UB8rb/rqXLpIWCGtNFHhlFpaXeVKT0Mszy7Ch5kEOuqMnpCY+XrVzAcVSJdZopcT
 THZdR/czMu2ZomhVksrT+uS2BF8fHkxAX6yrYM5Q2W7ylYKc+Dlg4IrXnY/x3meu1WU7
 4DqesvoDFdqi8/VsqrXQ9bSYV1ym1rAeeh+lqnhauXBfKZEfZdfch7nItYyjwvQmtwqj
 /lXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByeKw4sCs1X3+x9od/0NvdUJwS9sRCmtdiUTiuJpiewR3cVRiZSnlxyNkTlEjUGSd91gxkLBkirm44=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLOKSDmFLqjIFk2hQSdPIcO8Um4Jq7zLiiupiB+QN8vNbs6pWBL
 O9S18jjH2Q8aE2Phc5S08vYgSstzFU5Dbgtnk427lIu4cu5vOslLy6tacG6f+tjkyfA=
X-Gm-Gg: AYBFou2zKU03MEYciv3aWkgFhCj/6kE9LLjBDwWJFoRUxkdkcGQSNFEPrF22jR2KcDi
 EC6/85ngfPJeSo78oboLb1KkkFq7VPbMk02c2kUse/wUg7J5aspOmGzJjpiauvTM8LrQAoLcnaa
 5gw2KODHOxnv5C6zphyOsXg3zKL7Px+TtYC22tMuB1Z6n48Ha2YxcHpul4BXZP31mbi9GiygRtA
 15SwtIZ7yLcEBiBFSoyjl3PjPPYh1DC4Vf4YDCQ16GiLefofj+Mz7efhk1Qtx2rrGmII7weqgb9
 96EetKcUyEZMD/830E6yleg8GDi6qEUXsvzCE4lBxSbx6yr+UK9j8oQiuEG/IshLMjQLb+FHIMz
 AlZV1d66OMMzWlbx6nnPTZi/DVB3oYMVdTnv+0ShewALfwjEcDWyG8t4ZjgANmZbuIJ+oqwv+YT
 rmQTY36jH66/LAkXR0NKudeXKfLcNxY3BZdAT0GCuLb0nmI88lHfgOb39YpbyW/x8Mmpiryid8M
 uZ7MXa1lgHgXtqVQLhRYLPa6MY=
X-Received: by 2002:a05:600c:3d96:b0:4a1:746e:5898 with SMTP id
 5b1f17b1804b1-4a18e4835e7mr80062645e9.13.1791621085688; 
 Sat, 10 Oct 2026 01:31:25 -0700 (PDT)
Received: from localhost (137.36.26.109.rev.sfr.net. [109.26.36.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e4a3b4asm198380275e9.5.2026.10.10.01.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 01:31:25 -0700 (PDT)
From: Phong LE <ple@baylibre.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/etnaviv: add the Allwinner T527 VIP9000 hardware database
 entry
Date: Sat, 10 Oct 2026 10:30:36 +0200
Message-ID: <20261010083036.765881-1-ple@baylibre.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Oct 2026 11:45:03 +0000
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

Add an identity entry for the VIP9000 NPU found in the Allwinner T527,
as used on the Orange Pi 4A. Match model 0x9000, revision 0x9003,
product 0x05090009, customer 0x10000016 and ECO 0x06000000.

Provide the core counts, limits and feature masks for this variant
instead of relying on the register-based fallback. It has six NN cores
and one shader core.

Include SECURITY_AHB in minor_features10. The corresponding
vip9000nano-si+ entry in the Orange Pi BSP feature database advertises
both SECURITY and SECURITY_AHB. This lets the existing capability check
select ETNA_SEC_KERNEL without a model-specific security override.

Validated on an Orange Pi 4A with a 6.18.38-based kernel and patched
Mesa/Teflon. Full quantized MobileNet inference completes with identical
NN intermediate and final outputs to the vendor BSP. Two additional
runs without per-operation instrumentation complete without a hang.
The Mesa fixes are separate from this hardware database addition.

Signed-off-by: Phong LE <ple@baylibre.com>
---
This entry combines the locally tested T527 HWDB addition and the
SECURITY_AHB correction.

Prepared against torvalds/linux 6812ce4e4379ffc99c52401ec28f0d7ffbc36206 (etnaviv_hwdb.c).
Hardware testing used the local 6.18.38-based tree, not this upstream
revision.

Vendor reference: Orange Pi T527 BSP,
bsp/drivers/npu/aw_nna_galcore/hal/inc/gc_feature_database.h,
entry vip9000nano-si+, customer 0x10000016. The SECURITY and SECURITY_AHB
fields are both set to 1.

Test details: 5,043,689 NN output elements and all 1,001 final output
values match the captured BSP reference. This tests one model/input;
it does not validate every reported capability or the graphics paths.

 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 32d710baf17f..4df463ef6e60 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -292,6 +292,38 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.minor_features10 = 0x108048c0,
 		.minor_features11 = 0x00000010,
 	},
+	{
+		.model = 0x9000,
+		.revision = 0x9003,
+		.product_id = 0x5090009,
+		.customer_id = 0x10000016,
+		.eco_id = 0x6000000,
+		.stream_count = 8,
+		.register_max = 64,
+		.thread_count = 256,
+		.shader_core_count = 1,
+		.nn_core_count = 6,
+		.vertex_cache_size = 16,
+		.vertex_output_buffer_size = 1024,
+		.pixel_pipes = 1,
+		.instruction_count = 512,
+		.num_constants = 320,
+		.buffer_size = 0,
+		.varyings_count = 16,
+		.features = 0xe0287cac,
+		.minor_features0 = 0xc1799eff,
+		.minor_features1 = 0xfefbfadb,
+		.minor_features2 = 0xeb9d6fbf,
+		.minor_features3 = 0xedfffced,
+		.minor_features4 = 0xd30dafc7,
+		.minor_features5 = 0x7b5ac333,
+		.minor_features6 = 0xf239c400,
+		.minor_features7 = 0xffffe9bf,
+		.minor_features8 = 0x2003dfce,
+		.minor_features9 = 0x01081841,
+		.minor_features10 = 0x01004048,
+		.minor_features11 = 0x00010000,
+	},
 };
 
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.43.0

