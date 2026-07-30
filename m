Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33B2C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97E210F176;
	Fri, 31 Jul 2026 06:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ULcVlqnY";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E383A10E0E7
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:00:19 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c15e592da74so286721766b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785430818; x=1786035618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8afrmJvJNjiQFgHKILdFDrH8vU7XVuTipqlZKwZMuTE=;
 b=ULcVlqnY1ZfVdyAHx3AlZim9liTHxYfV1mMmbaFhHG5jSiHNImrUEAXY8IAFzMr6/g
 9829vzJgZp4/T5EtB/wKDSwQ1xt6dv1R5JrvrIbd+6F6l6K/jr7Q8f4g9kxNPsB93S36
 lmOSrCSSIv2GOxtw6V1sLsHzw93UXLIlK3oyiJj6jyb5afk7jKNq82CMkuMm2TQNgR30
 tDswyG8FBVVeiebrSsJl+2kzpNN7ggjfFcBP7rpI82Auv59ziO+sSVrMhhgtlaX+oTv9
 z7Suc8srqPTPfZY05LpEfYYlibiDihGAy7OcrMzXzcLLRxenRmJjmk5baa2O2VVX3ucn
 eulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785430818; x=1786035618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8afrmJvJNjiQFgHKILdFDrH8vU7XVuTipqlZKwZMuTE=;
 b=jCSQ/9tDh/yb78Dwk5eL0YzMQYAS6NxnJ9jnMcMOVhrzzfYkhHXmWpLi6eSlgcbaZu
 D93u7PAgshMXFqedIpDOlbF/T5xTgPp+HeWtHDmYOy7EAokeVgqmoD+gg7pXcUsuV/n/
 qkymERpezjmkeC1j6tK7V00oX3GsU2tkSbktlWx/kmyYq+2EVtVkEkRsmubgv+UPxhjV
 tnA9+hxKGTVvAjsMnhIvAu2SUqo+teWAbST4pOCyngLBpABkjOK0R3uyUYzOXuC6S9QK
 d7ubc7jHqMbHblG6ltXTCYDLYTWV+h7M117iB9U0BTDIk35F+Y04ecdA+2usqPvo0hFu
 hrQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RowC4d0GKBzngyszxiN0KBcg9EOJwtZm5J/CFL4jIc8mTAosSYZkjpxareNVdcxp1ASaaIGXfELWTU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOsyzSHlfz2MVCD50WKGbCO5kfSixBiEdIqfI4GTkVxRtIzMAB
 8LiVOIPFlJr4SOpGfyo/1rWuH3jYRvJQ1982kb9MEIVqirUngiau/taU
X-Gm-Gg: AR+sD10JY5eKo+JYkJ7Pu2ipLyBguC7+3DCyiuHmJAKkY2m4FgMCZnG2BrvWPBCr77P
 Iu0GkKF0adZuPvIThSLjozCSYcUlQe4stn5WuUP69sPJ8g1lHG1e9uy0W9kUHLGvecqUe8sM2oN
 dGUz9rwy8unmFL/E3TUAF43fcgHRJEABZjMaV4/xaOXuq3mzNwYDSOD6RZXCMUOzVIOv2Ui29ac
 AfgSWgAPLnWUg7mDowDNna7c8rXJMxJUpNQdJhSQrpjEzez/QbF5H9ijShszpdNXlb/1STVeiih
 yDSeW69x1nZ3HoRGJ8Qu3xrqQc3RcwszAbP9LwRNR0aJ4TEyke+eL5h0heUK3lx/HY7AU9X/sBq
 bcub5wz1IzHfJlGtJG2HWPSiojGf0QeI+K8MSXF+I0KTQbGPk9hAurObP/UXiH0hR5MrXx66eH/
 rpQ5QBbOz0Rxp4f3KGtxDn0WAPQMx2Uf8fSGilFRv7CMm4tjN1fQ7usAjINadHfYay3zWFt+Lf4
 bUuHzgx6kgEX+Aot8OjmiGkFGqj/EHJFHdjoavJk9++HF1LvYe6
X-Received: by 2002:a17:907:3e84:b0:c16:66dc:3abe with SMTP id
 a640c23a62f3a-c1fa54e8f31mr174712266b.28.1785430817965; 
 Thu, 30 Jul 2026 10:00:17 -0700 (PDT)
Received: from misharu.home
 (2a02-a463-a071-0-ee66-8497-94b5-6e78.fixed6.kpn.net.
 [2a02:a463:a071:0:ee66:8497:94b5:6e78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851d4b7sm93725366b.4.2026.07.30.10.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 10:00:17 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Mario Limonciello <superm1@kernel.org>, Tao Zhou <tao.zhou1@amd.com>,
 Kees Cook <kees@kernel.org>, Candice Li <candice.li@amd.com>,
 Jammy Zhou <Jammy.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] drm/amdgpu: bound ATOM bytecode cursor within the VBIOS image
Date: Thu, 30 Jul 2026 19:00:11 +0200
Message-ID: <20260730170011.28915-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:54:16 +0000
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

The ATOM interpreter executes bytecode straight out of the VBIOS
image and multiple cursor-mutation paths are not bounded against the
image size:

 - the main opcode fetch loop follows jump/skip targets anywhere
   (jump targets are u16 offsets that can point past a small image),
 - atom_op_switch scans for ATOM_CASE_END with no limit; a table that
   omits the marker walks off the allocated BIOS copy,
 - atom_op_processds advances the cursor by an unchecked u16 taken
   from the table itself,
 - the command-table base offset from the master table is used
   unchecked before its header fields are read.

On a malformed/malicious VBIOS image, these reads could run past the
kmalloc'd BIOS buffer and the out-of-bounds bytes get interpreted as
further opcodes/operands.

atom_context::bios_size and the corresponding amdgpu_atom_parse()
parameter already exist in this tree; this uses that existing
infrastructure to bound the four sites above. atom_index_iio() is
already bounds-checked separately and is not touched here.

Assisted-by: gkh_clanker:t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f280e2..56c8a17edea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1032,8 +1032,12 @@ static void atom_op_switch(atom_exec_context *ctx, int *ptr, int arg)
 	uint32_t src, val, target;
 	SDEBUG("   switch: ");
 	src = atom_get_src(ctx, attr, ptr);
-	while (U16(*ptr) != ATOM_CASE_END)
+	while ((uint32_t)*ptr + 2 <= ctx->ctx->bios_size &&
+	       U16(*ptr) != ATOM_CASE_END)
 		if (U8(*ptr) == ATOM_CASE_MAGIC) {
+			/* magic byte + immediate (up to 4) + 2-byte target */
+			if ((uint32_t)*ptr + 7 > ctx->ctx->bios_size)
+				break;
 			(*ptr)++;
 			SDEBUG("   case: ");
 			val =
@@ -1087,7 +1091,14 @@ static void atom_op_debug(atom_exec_context *ctx, int *ptr, int arg)
 
 static void atom_op_processds(atom_exec_context *ctx, int *ptr, int arg)
 {
-	uint16_t val = U16(*ptr);
+	u16 val;
+
+	/* the skip count is bytecode-supplied; validate before reading it */
+	if ((uint32_t)*ptr + 2 > ctx->ctx->bios_size) {
+		ctx->abort = true;
+		return;
+	}
+	val = U16(*ptr);
 	(*ptr) += val + 2;
 	SDEBUG("PROCESSDS output: 0x%02X\n", val);
 }
@@ -1237,6 +1248,13 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	if (!base)
 		return -EINVAL;
 
+	/* the table offset itself comes from the VBIOS master table */
+	if ((uint32_t)base + ATOM_CT_CODE_PTR >= ctx->bios_size) {
+		DRM_ERROR("atombios command table %d offset 0x%x outside VBIOS image\n",
+			  index, base);
+		return -EINVAL;
+	}
+
 	if (ctx->execute_depth >= ATOM_EXECUTE_MAX_DEPTH) {
 		DRM_ERROR("atombios command table nesting exceeded limit (%u)\n",
 			  ATOM_EXECUTE_MAX_DEPTH);
@@ -1273,6 +1291,13 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 
 	debug_depth++;
 	while (1) {
+		/* jump/skip targets are bytecode-supplied; stay inside the image */
+		if ((uint32_t)ptr >= ctx->bios_size) {
+			DRM_ERROR("atombios cursor 0x%x outside VBIOS image (table %04X)\n",
+				  ptr, base);
+			ret = -EINVAL;
+			goto free;
+		}
 		op = CU8(ptr++);
 		if (op < ATOM_OP_NAMES_CNT)
 			SDEBUG("%s @ 0x%04X\n", atom_op_names[op], ptr - 1);
-- 
2.43.0

