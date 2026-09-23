Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA8C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F95010E93D;
	Wed, 23 Sep 2026 16:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sim9s0JP";
	dkim-atps=neutral
Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com
 [74.125.229.164])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5284510E93D
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:13:08 +0000 (UTC)
Received: by mail-dl2-f36.google.com with SMTP id
 a92af1059eb24-14373bcc010so1283681c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790179987; x=1790784787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sUIXWjLbTey+d3P92W9cG28EMxJiRiFjR+QNnEvmF1I=;
 b=Sim9s0JP0QGBbDzDuaYtguK9ucojea/O2rmpP/XVq1lQOrRmgIik4LQY3zipfEynDH
 WzwaTwE0V9xOr2w0ecbp6bxbA0W2xflkgU/roitgQbO9KvFely2X7HuyO+Xua5fB2+Mj
 9LtaEMU6UnTw+wNgDhXluValX19TLf3SqnsFsD8LMgmN/6ZLzREklgYR1LsyL3DasMsW
 RrCrYqiwnmoR6oZkPcag0gfKRCVdy6PM9eX9UXMy+DJFMD8nfB/Cu9/ENWv1oYEA5Jom
 oVFngFtVWsTjJBX0ywS/qlUXvNb5zZ7mt/9arM2ZbetCWda5sWzI7w1gLP0XaZ/mkfGn
 QSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790179987; x=1790784787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sUIXWjLbTey+d3P92W9cG28EMxJiRiFjR+QNnEvmF1I=;
 b=h9ThJxN5uBrJbj018lJkO3WTU3mhWoeymueUk5cccx6+nTuof/s19fNbuaXagJyXNz
 op5wqiW+zs30O7fRLsvMl99DtCvHEARhQKxgs6ituUGTPv4OgjAnGCJoUuYiQw6tb06a
 t0EPKHZTM1uOvySSGJDQCTg6a3Q5Hs0iClFT+0Blms+0H2l9eDUfBDKRyeSGg+kDsq82
 PB4qv//pRR3Al5eYMoqFegc+cO2AxVwwxCwUxBBnZ6CgkoQPCS7VBIVHp1KYsg9yMWRY
 /scHwfGj1R9e69OSFykxhCcM8OCAnamYvEKIeFrZ1b8DnrcR7JJpaXpWtNnCYmOzGyFo
 HocA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbppQtsFXjrcYHxR41ntb4gC3eKGkJKMfFeSrHhKHDLGaRkwFmqkRqkjvN0IkCugoH4b0gWxKa7s0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++keNJgiSmCEinyEKaNQIFrLRJSt++PqoWSj9vtVWF+TcRoSDXMv
 5yacqrUx5nsE1sf07imOw1RgGojEG/iNNr0BhgbL5AoKEwbaeMZ6E8qL
X-Gm-Gg: AYBFou04/4/3hYhzWA6sFNNGq//eYZWx/p2RuJml9CMmI/ql+tlycjZ1/e7Ox/Gxo2H
 gVctojmVWMEg9g3NaBIv2sDFq7IzF4dQ9UD7S4PwIsR/B7kQCfykL2lvEo2Y6z35CScR5YFEjd+
 2OY3WUhtErnadYVk5L6mSlNJvyMojNlpzI8AM3J2xOAUuHo3bCh7ma2Z1U7Z/v284/CVI2naRpZ
 XaT1W+T9LC9tuAkYWz8RzUiy70odPdnzP0xj/lPVRD0QL2itMqg+eQTdQJWuimpfkIGvsUe2K+V
 ntLjoMr46RF4YOtzydkEIeYLbaKEnmM/GkiFCz4K0vuIsm+YV9a6AgmW1uZpZGD6/nPYJi5BkXu
 h4NKdIhOZH4sHLH9mXLYFRLZggH5VSVdpn8bmHU9q23Eh+X4rUdEWIjZPgEWIhXkpzewfv9fLCt
 IYxnutFuEbYh06sE8x98DjJTOF3RwKs/ZKCmSYUvkIl9/gY+N2QvOJLL8oZ+oZLcg0hvGDiwZzX
 g==
X-Received: by 2002:a05:701b:20de:20b0:145:152:b54c with SMTP id
 a92af1059eb24-1450152b7ecmr819023c88.23.1790179987346; 
 Wed, 23 Sep 2026 09:13:07 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14501794269sm992777c88.8.2026.09.23.09.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 09:13:06 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/amdgpu: fix ATOM parameter space index bounds check
Date: Wed, 23 Sep 2026 13:12:52 -0300
Message-ID: <20260923161252.1363895-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

atom_get_src_int() and atom_put_dst() use idx as a dword index into
the uint32_t *ps array (ctx->ps[idx]), but compare it against
ctx->ps_size which is in bytes. A malformed ATOM table operand with
idx between ps_size/4 and ps_size-1 passes the bounds check but
accesses up to 3 dwords (12 bytes) beyond the stack-allocated
parameter buffer.

For example with ps_size = 16 bytes (4 dwords), idx = 5 passes
the check (5 < 16) but ctx->ps[5] reads/writes the 6th dword at
byte offset 20, 4 bytes past the allocation.

Divide ps_size by 4 in both comparisons to match the dword indexing.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260923163157.1354872-1-qwe.aldo@gmail.com?part=1
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f..d0a45f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -232,7 +232,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 		(*ptr)++;
 		/* get_unaligned_le32 avoids unaligned accesses from atombios
 		 * tables, noticed on a DEC Alpha. */
-		if (idx < ctx->ps_size)
+		if (idx < ctx->ps_size / 4)
 			val = get_unaligned_le32((u32 *)&ctx->ps[idx]);
 		else
 			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
@@ -510,7 +510,7 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 		idx = U8(*ptr);
 		(*ptr)++;
 		DEBUG("PS[0x%02X]", idx);
-		if (idx >= ctx->ps_size) {
+		if (idx >= ctx->ps_size / 4) {
 			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
 			return;
 		}
-- 
2.43.0
