Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E75606A32D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=euDtoINk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3DF10F42A;
	Tue,  3 Nov 2026 08:21:47 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5748110E5E0
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 09:44:17 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso1900711f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 01:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793612655; x=1794217455;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NoeO4H254v62ZOJJIm68Fw+JHpyHTDMSfunZ/oF8L/k=;
 b=euDtoINkWc9csCsn61zPHkQHI1bMw+TI5AK/E2GSz/7UZzRkuQ/pNYsnNLjCPibk19
 6qKdXNdfawPSxFw7YZGoebfx4ZiEm1cAgc0xvuNdIUbCjB/24J1Jee8H7vHWqPVA0BLo
 KaymsIJRSKln+2NEDw3586E4opV2VDOxtibjPcbX/PFuI6F0ETe+MDyMR4eL5MSmLtnW
 i1No7kUAMpjJam0fjwkoXDgTgQGWSD1PFCYrLZhbzinAYQ4FRnijjG760TuW9PO0MebQ
 xece8ZBpqBh9XSrGMGT2AwUL1EMU1qIfmeQARibDKd7tLAnr84Y2IdPdjBLtK1zvx0XL
 Cc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793612655; x=1794217455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NoeO4H254v62ZOJJIm68Fw+JHpyHTDMSfunZ/oF8L/k=;
 b=G5MnPIJtJEwgrMVkm/yAVCMRtE//3SYGt4ElHBxOlnRyTLp1JKSLt3vy+gCTeOKS+U
 eEuxa2hdxCFDIA1DDrNAMxgSKhoAAUxeQkwZslXYmfHgDGCWEgkMHHRydD0jLH2cKb3H
 8XJkw7xWbMCUlfu66Gt8ny0Aex7dYMKUnNywPwoTw6TciFiGU9l1Yi0CW9M1ThJMVYp4
 ALVfGgRHLgwLTUc+3+tItEHrhCgsoY6+cj6wjPG7k7QKFN7HzYx+ReRyrw1eavQlvFb/
 jbopA1X8nbI8882a+mMN/O4uoyEYHgHrWWgNRNQOhM501jXUHVRIfdLt00AeIJg1U/KW
 v6hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxssGP1qBr75c41XS+boRe5C7uxzDvJSlERD1o9lGaaufFEvdGiu0YUK8ECibSl7D1MHnbHWO1Ncys=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/85Ef/CWFfSgpsnMQV+8BuCMe80uO8et3acE7OFVXan+czmxRP
 jAYoWOAIsWfNViQccr0Y9fuzRV1V+sCXrtXR42W+uXdm1faciNRibHCI4EAuA0sM4E0=
X-Gm-Gg: AYBFou0czP6gNSEkPuhIAAM8RM6CAPZuc1mEqG6CETnR9IUgKVwTC5fHEFC4pYY3yvr
 YN902fruXHguOrENL649nwgpSxnNcTyJjxXS1yp+AgzlHlsB6kYIMBvMw8D2H4e80YX4fVNO/lN
 y7BIiaBvyi/gZ61tnos8MozG8e34yaJs+WOUg5ed8ZZvhhYttKYEw1lREgleFoUg4Gmbi3mZ2ZQ
 Op9INrhPNKaj3lnDbdLHXRzL272VI5ge3unMKT6uu5p4g8MwIPa77Iq82hkV6csKwzt4LqcHH40
 xgPeuVA5g2horYHsRjnVVgO3Xq2FFgdzwDq07hIlrrmY1EWnM378zxYMycBE1i6I+fhsAByqcsp
 D2B6V/zJPx/ZoSX7X0x8HPJsyKWTruL338kyt8dFxJfeLTmKEEJRN3WIrjWkpZAzVWp8D8s8Kfu
 zQm9wpUCLtLy1RKg+8SAdrfA9wkM3Bv0pQ1kCkJH8qdYH4/kVQTsJDGda9rsD8pm15m233HpwAs
 nCE4of9dlPMMjenmIwRRUJtp3aAY3F8KLMM3dyH+xlMtGCufZwFuwVJD1FC5MHKoryeG11h/Xsg
 UmvJSEmxiGx134aSCkAoAaSIO4ErXmPhY43sJkBGGiexBQzM6KbLg2U1j+t/4A2CUFA=
X-Received: by 2002:a05:6000:26c8:b0:48d:f14a:9183 with SMTP id
 ffacd0b85a97d-48e6e303b1dmr21700466f8f.15.1793612655038; 
 Mon, 02 Nov 2026 01:44:15 -0800 (PST)
Received: from localhost (137.36.26.109.rev.sfr.net. [109.26.36.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b725b8sm19130989f8f.20.2026.11.02.01.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:44:14 -0800 (PST)
From: Phong LE <ple@baylibre.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Phong LE <ple@baylibre.com>, Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/etnaviv: add the Allwinner T527 VIP9000 hardware
 database entry
Date: Mon,  2 Nov 2026 10:42:52 +0100
Message-ID: <20261102094343.2086424-1-ple@baylibre.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 08:21:46 +0000
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a hardware database entry for the VIP9000 NPU found in the
Allwinner T527, as used on the Orange Pi 4A.

It's coming from allwinner BSP driver in gc_feature_database.h with
vip9000nano-si+ IDs.

Signed-off-by: Phong LE <ple@baylibre.com>
---
v2:
  - Fix minor_features6..11 masks: translate flags by name matching
    against Linux UAPI definitions (common.xml.h) rather than raw
    positional struct packing from the vendor gc_feature_database.h.

 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 32d710baf17f..54e353d61be2 100644
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
+		.minor_features6 = 0xfc8ee200,
+		.minor_features7 = 0x03fffa6f,
+		.minor_features8 = 0x00fe0ef0,
+		.minor_features9 = 0x0088003c,
+		.minor_features10 = 0x10c0c8c0,
+		.minor_features11 = 0x00000010,
+	},
 };
 
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
-- 
2.43.0

