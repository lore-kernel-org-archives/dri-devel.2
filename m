Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37549C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A2E10F66D;
	Fri,  3 Jul 2026 07:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="xaJR77It";
	dkim-atps=neutral
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656B010E4A9
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:06:02 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-9670c11410cso722453241.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782993961; x=1783598761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cVZWX31i00/Q+AQyz7DVfvfVMzM7hxRZQOP4HWyMgo=;
 b=xaJR77ItDcPFTzTMHZbHzQ05nr+qGkrgM8H8TxYUJOW6EfqCHjnl2IhpmCXXZmBLY5
 IaYCZUt/eFX2CwjKo5Kn+4plt4zarDMmF7K45jpuWZRr8TXByVhxX7lPXzpLdi9LnHdV
 4XAEI8/TCpKVVW0kpZFQUcbinRwDLKTanywBRkWOJNnE3tto+nhaIt1fnM2ChegTgcqa
 I8XeQ/xQ+I3/8Af5qYUVacPxjw4q+HbGy7wiIeti49cRektuHG0jX20moj+Iy92gQcF3
 921XHpZHCksHMBD6vU56xqnilpKz4uMfFsjkGSOqhPaGQFxV282xQmNqKL3Mn8XN2Bs9
 2GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782993961; x=1783598761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9cVZWX31i00/Q+AQyz7DVfvfVMzM7hxRZQOP4HWyMgo=;
 b=aIQOsFvQ4Q/4IuVSSoGnojnXa/mYK+Vkilh08B/+bZcS3ZH41253ROsE8x/9DpWEiM
 13ytl+xMPloecDQ9XN6YWsKPhPTaxLkh2DiSC/qHn416iI6rjCfPTmezvBhJbk7GEMv2
 0GF3kLCiUjR5QlOR3rjVqKBK3QZendOf2JEttEThyaD+k9Uet0aACYlpUmLLssIp0O0w
 w22znUg465h+0WRQrvOVun22kOGFnwKUa7Jlcf0LifLEL+IuN8TccWHc+8FxJYHZ4/+r
 S0DE9RIfb0F3JtNQT2WhJs5BA6Vl6zZEDk0B1uN+v5DJ5Xnef8wwXmhIaJ5mM8Oecl2R
 vuAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4HibDZTON30qNeHAIFWc+Gdoq9QTW/YNABD09LeJbvtYHm3dkr/EfAU4ppZtuEUU2JpDtJyAaEiE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3THf5oVdqcWQ5786z9XA+dq7vLv59JtQS+nW8rbLzW14VGrFX
 yY3zMOjDq748N38Phx9QdvKO5vl9iMAyClMInVM/TZnTvewdSxHjmvM9tF/VrY1kQh4=
X-Gm-Gg: AfdE7ckS3bvIbAxFj0W+e5XmrVvMMsUfqt1/Y+nP2kja/JB873iVUs/1vqDP6dAWWup
 n77MdEtdz0nDgYDfe82Gh8y3PzH0QBNgF3lKUcK5QAh5S+GzoJk30eC9clBDycaaXDeZYi8iCk/
 ttDJjlKM0vVytn5P5OjDH0wOexi5HdaO7/AARTAEW6dnReUImZG0C7/KBE+KiRjp8flB2wNM5Bx
 nQrMwMTEcVSMN5K/eQ0Oc5/wZp0o1irp6cGm16nHd58Dl2aVsmkjCHsY3K1YIr9SFbMz9ZM4yWH
 B+IFBcO/Gw9ZqT6q6W2PczcCWB3JICdnHXeQ0Mr8gqk/uxRiEVgGDjngmvdFo0iMtzrFdXZW9MR
 I23NX5pQENt7y/d1vDUEMt6xK4mVc4FVtLKe1+OayXJA8G+9puJeuFL8jMTt0Ef0jV2GhoMoWGQ
 tNAxJJYaFj4+Z+8kA=
X-Received: by 2002:a05:6102:304c:b0:737:783d:1912 with SMTP id
 ada2fe7eead31-73dbe560d03mr2566154137.12.1782993960866; 
 Thu, 02 Jul 2026 05:06:00 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1caf43casm1182470137.11.2026.07.02.05.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:06:00 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH v2 5/5] drm/nova: use `zerocopy` in riscv.rs
Date: Thu,  2 Jul 2026 09:03:24 -0300
Message-Id: <20260702120324.40388-6-niyudi.honda@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702120324.40388-1-niyudi.honda@gmail.com>
References: <20260702120324.40388-1-niyudi.honda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

From: Pedro Yudi Honda <niyudi.honda@usp.br>

In riscv.rs, replave the following `transmute` traits with their
`zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`

Update call sites accordingly.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 drivers/gpu/nova-core/firmware/riscv.rs | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/riscv.rs b/drivers/gpu/nova-core/firmware/riscv.rs
index 2afa7f36404e..ba56bc7d4188 100644
--- a/drivers/gpu/nova-core/firmware/riscv.rs
+++ b/drivers/gpu/nova-core/firmware/riscv.rs
@@ -7,8 +7,7 @@
     device,
     dma::Coherent,
     firmware::Firmware,
-    prelude::*,
-    transmute::FromBytes, //
+    prelude::*, //
 };
 
 use crate::{
@@ -18,7 +17,7 @@
 
 /// Descriptor for microcode running on a RISC-V core.
 #[repr(C)]
-#[derive(Debug)]
+#[derive(Debug, FromBytes)]
 struct RmRiscvUCodeDesc {
     version: u32,
     bootloader_offset: u32,
@@ -36,9 +35,6 @@ struct RmRiscvUCodeDesc {
     monitor_code_size: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for RmRiscvUCodeDesc {}
-
 impl RmRiscvUCodeDesc {
     /// Interprets the header of `bin_fw` as a [`RmRiscvUCodeDesc`] and returns it.
     ///
@@ -50,7 +46,7 @@ fn new(bin_fw: &BinFirmware<'_>) -> Result<Self> {
         bin_fw
             .fw
             .get(offset..end)
-            .and_then(Self::from_bytes_copy)
+            .and_then(|b| Self::read_from_bytes(b).ok())
             .ok_or(EINVAL)
     }
 }
-- 
2.34.1

