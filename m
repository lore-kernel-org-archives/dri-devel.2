Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92016606D814
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+3g/JLl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9438310F13C;
	Mon,  9 Nov 2026 09:31:49 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2280B10E82C
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 07:41:06 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso285936f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 23:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794210064; x=1794814864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7/Tf8BQkHl6UVzxzkfSyq7osHN9OzzgsIStTSdb69F8=;
 b=H+3g/JLlqpgiKafL0/6mlvOQKkvvfKo2i28QGNb8DWSxq20OECYdZ/pCHJKXeL6HuW
 8sp16x5q2JEsu6t/FFPNr0X9wUJeIkgCyB7JDD/VES8RIhVSbhfpbWxeV1LZ8XxTbAAJ
 +5CpLGIHRQ612YvncLOCdrLO1s1/QeSSivy/h/Z1n8F0LkGF58xZlCTlVzHZY2hlJPjg
 9ZJdoka43wkVfi8qnsdiVie05kFqLlikn3iIxYLc56J2ROhAp0X4MAGGwT2docxcnMWX
 b5TWuS/sUJ2BC76HwefMQ3I08N8J4Ckpact714w04qqNxoY5Lm2YPTw9GVyfKSJ8Dmc0
 X1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794210064; x=1794814864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/Tf8BQkHl6UVzxzkfSyq7osHN9OzzgsIStTSdb69F8=;
 b=PZ0/d1P/QxKLelNCtPElR1sJZMlALSHVh8Sy5pmdJJNnRAVdtZhHVHcuA+FSi/Mhty
 GX3Lsb88pfYg2RDN4W9BkZ3qUiPVG73r04w/wqZjzpfp3itQZVN7lLbNI4wDp/XcCJsw
 LoPGV4+PkcLz+EOWpveIRBmXMJfRHZMldLUuNckEUrud/bGEWmkgi0vV0zDHuNkyc0Pj
 VtYTIpx8oF05kqcCdOZtEHAvf6sQao/g6wmnYS+ECPB8J80S090PAHWmZtEf0BiyZu2F
 S1yx1dfHMsvmD2cFeikj20dIWB+VbiQ4QeZhmBP6pCsISGOU1JA+XcktAupodHkhYoyJ
 Kraw==
X-Gm-Message-State: APuU4Z+7T9whPPdF3CFVDNsiBPf8AGovp9pRcXxpO5dNoW81n9kWTa5y
 BWLnl/3uTTSVrKzsjdCyRcy6prjgulOW/Uiv0SnlDsudtvewSv3jlmqk
X-Gm-Gg: AYBFou0L1bsHRKk0cW7grz2orE4KRR0JXwneYfKmvfQehx5kr+E64+cJ400nZU7EkiI
 7ssNh8ZW6g6Q44tyWHoVo8YJnDstBsh8fxGtEjPEGpImwtJBieE1BcglRUQrUmLoxlvqADz3Ue4
 86t506XRYondCl0DniPMs0osF9FYgy+4lLXoRbvtkLVZuv7wiU1SRHoU6QPKjpQma5sP/xq8knQ
 KravVx6YMvs3B/e/ytwXoz80zBCQPpZ/7kIy6bUz8bBNsazHAwtltEJTJz6stNclYvsS51roHG4
 GJJMdaI1egof1/MjqlawW+WYiSEjN30ZSyibqolAaq9jxqaQa/JOEGGKGPCmsM0mtLZClMUvE/W
 wv5gBQRem4iul0ZFDc3T0GdWOZ7eCITolZtkgdutsFj9+MyJWKgRzkLh4iogV8mlj6GK90ewJcx
 y9GEyftL6TjnJrkraQ8sLTbhf253rLSMmBPxh7I6M+jLRL2YKT4Kl4s6bat+oMCeruwkIcVIWPN
 AQ7Pf0VpHAtbQtk9Vhe599BFO/fHnfUUH2igkAQVbMwKAlARQ+YlVDt/LTuA5KO0dW4anrkIiwH
 cTt8ZVEx8+L/wX16Afw/apzlDBcYfgb/Sa4aYjYO9mGiGx72/7sberWwKKSWnL+Y9HyCDCqoESf
 j60ZNgbdy
X-Received: by 2002:a05:6000:22c1:b0:48c:7387:6b88 with SMTP id
 ffacd0b85a97d-4958b5374bamr7080666f8f.37.1794210064251; 
 Sun, 08 Nov 2026 23:41:04 -0800 (PST)
Received: from nest.tail012287.ts.net ([176.40.105.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597652ca7sm8898526f8f.39.2026.11.08.23.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 23:41:03 -0800 (PST)
From: Yazdan Ghalavand <yazdanghalavand@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] drm/nouveau/bios/vmap: only read max2 if the header contains
 it
Date: Mon,  9 Nov 2026 10:41:02 +0300
Message-ID: <20261109074102.11997-1-yazdanghalavand@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvbios_vmap_parse() reads the id of the third "max voltage" entry
(max2) from offset 0xc of a version 0x20 voltage map table whenever
the table's *entry* length is at least 0xc. The entry length says
nothing about the size of the header, though. On a GeForce 710M
(GF117) the header is only 0xa bytes long while the entries are 0x26
bytes, so "max2" is actually read from byte 2 of the first voltage map
entry:

  header:  20 0a 26 12 01 c8 00 ff ff ff
  entry 0: 01 10 50 f8 0c 00 ...
                 ^^ read as max2 = 0x50

There is no vmap entry 0x50 (the table has 0x12 entries), so
nvkm_volt_map() falls back to interpreting the id as a voltage in
10 mV units, and nvkm_cstate_find_best() caps every cstate at 800 mV.
That is below the boot voltage (850 mV) and below what every cstate of
the board needs (900-950 mV), so no cstate is ever valid and setting
any pstate fails with -EINVAL.

Check the header length instead of the entry length before reading
max2.

Fermi reclocking is disabled upstream, so on this board the bug is
only visible with reclocking force-enabled, but the parser runs for
every GPU with a version 0x20 vmap table, including those where
reclocking is enabled.

Tested on the GeForce 710M with Fermi reclocking force-enabled locally:
without this patch, writing pstate 0f fails with -EINVAL; with it, the
pstate is accepted and the core clock goes to 774 MHz.

Fixes: 4a4555a7f1dd ("drm/nouveau/volt: Parse the max voltage map entries")
Signed-off-by: Yazdan Ghalavand <yazdanghalavand@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/vmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/vmap.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/vmap.c
index c228ca1..07b3b47 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/vmap.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/vmap.c
@@ -68,7 +68,7 @@ nvbios_vmap_parse(struct nvkm_bios *bios, u8 *ver, u8 *hdr, u8 *cnt, u8 *len,
 	case 0x20:
 		info->max0 = nvbios_rd08(bios, vmap + 0x7);
 		info->max1 = nvbios_rd08(bios, vmap + 0x8);
-		if (*len >= 0xc)
+		if (*hdr > 0xc)
 			info->max2 = nvbios_rd08(bios, vmap + 0xc);
 		else
 			info->max2 = 0xff;
-- 
2.56.0

