Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAE6CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D766C10F141;
	Thu, 25 Jun 2026 07:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X079bB4u";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BA110E0F3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:23:56 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7ff05e5d009so13513647b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782329035; x=1782933835; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8tvwDj6aqG0ZCD9M1UH4HlCqt1P2RleXDyWTPKlWmro=;
 b=X079bB4ubyV8m7wpjHB+t+gze9E5merqOIhp0EBg9xppqNm8NT3SVm2+4AzIYNCeKI
 wLyDy2A850Pw9QFuZPApLcEjCUHQv+VykjHi9K2u62Umq+q2VYIZazrrvcCS1lih84sc
 CJsqHooMhJiMmFwHaTaeOrrS37FT/u1izNIlWS2rAECK11BztfW85vHyFo88JXhlvPaf
 s+lKoyMMQ7jJ/Tvru7p8dy93wY+6JvRAXg4bdvkA3tIRbYPdPvFUWjbPI2H0nKtyxeK2
 G+TGnWX7xao9iuB5ojdF4sB8g/RB+nJ38dXLHVuJgkgxsMRGFjxmfxtrdsDTAudN7uvt
 t/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782329035; x=1782933835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tvwDj6aqG0ZCD9M1UH4HlCqt1P2RleXDyWTPKlWmro=;
 b=HngqQlS2fYe3SltyqIzVxzj28vQpfvc/cndUByQvEJv42uEzuLXuTDRvQYs+AJrT6d
 tEU6WSLxGvIQ9ltEMtGIE9RH8Pa5Oya+4C18W9c1cx5GZWbmPs5q5IxTBKfU2/7VUJX/
 3q3XSXNlP4HDl6tLX5BRaQVJ1CH7PVWbAiqww3KZH/WyFh5ChRVvIjSUYZtE6c+p9wZW
 MVeU9PgIP2gxHPO8OUVo6FFYRdpOlpxCQv7ftHP33xV1t39eBAyTdKGPFjPOko5U5eq0
 oWSYbPGOdowHkxBsvj/iCkhUVOK5uqMN1+3aL3kQDwinIuNGVJmTY4qrF/svtg+O0smu
 VrbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RozvIrJcdrga/j8V71K9N9pyLqF4uZWDenN+80Mlye9+7xTQAaR7G/j5POhLOx4sRl2CWWPG/lxlp8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfK4ZhDLo058RuXDdEDuKhRlXI6AeQtVpyDNUvX1bAHNo7e5ED
 RvOG7sMX3NRal15VfO4MNlBlmgqNL1g5ySHx1R1q1U/dHErE8Uof7EnT
X-Gm-Gg: AfdE7ckgd5raSLIUKida4xK5nzPhvn4BoPhLGI3Vjrspq3sjYO6PCYT5HVh37fieO/H
 e9smaTuPpbZi3C36b5BUsHN4ZXCIKjVPyDwXTryjBOCAVI3/RuoAok1SKJKwJy69rFg1ZIvfV8t
 TM4WqZK45QftxPeV7wropk7gE8TBCH1O2CuSJJMIn5bTUWoav5jDruzgKmE5hR9S+Vz5xKmCPRA
 6fw+9b+nHEchVnFIujagFSrBsQxOqKstMC2+yitGfCCmQ75UvHnV1Sm7wJRS/77eK48vR9hJKCg
 LyjOavXV8uQZeCY/p1DzTRLVMfqQCfkLtrvdbHLn695oVZxI941KwVri3U9LTgkngPJEfK8wVag
 2726u9a9cwF+EgeiW0ArCDMLy3bMttC6UX2IsRq5MkV+SbnrSyv+n0bdRlnvsjLnYTylqDRLkMm
 R3CWRiUG5zRXwvt2rKRSOFD5eAOQ==
X-Received: by 2002:a05:690c:9b0a:b0:7e8:769:8094 with SMTP id
 00721157ae682-806c2667950mr87507277b3.23.1782329035177; 
 Wed, 24 Jun 2026 12:23:55 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025ffc2730sm61928587b3.34.2026.06.24.12.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 12:23:54 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: exclude mapped buffers from inline overlaps
Date: Wed, 24 Jun 2026 21:23:09 +0200
Message-ID: <20260624192309.4723-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

fastrpc_get_buff_overlaps() computes overlap offsets for every invoke
buffer, but only buffers without an fd are serialized into the inline DMA
payload. A mapped buffer can therefore advance max_end without reserving
inline payload space.

If a following inline buffer overlaps that mapped range, the serializer
uses the mapped range to derive a negative offset into the inline buffer
and then copies user data there. Ignore mapped buffers when building the
inline overlap state so inline payload pointers always refer to memory
that was actually reserved in the invoke buffer.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index ed0041076..1b70acc10 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -630,6 +630,15 @@ static int fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 	sort(ctx->olaps, ctx->nbufs, sizeof(*ctx->olaps), olaps_cmp, NULL);
 
 	for (i = 0; i < ctx->nbufs; ++i) {
+		int raix = ctx->olaps[i].raix;
+
+		if (ctx->args[raix].fd != 0 && ctx->args[raix].fd != -1) {
+			ctx->olaps[i].mstart = 0;
+			ctx->olaps[i].mend = 0;
+			ctx->olaps[i].offset = 0;
+			continue;
+		}
+
 		/* Falling inside previous range */
 		if (ctx->olaps[i].start < max_end) {
 			ctx->olaps[i].mstart = max_end;
-- 
2.54.0

