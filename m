Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E82F10A88D2
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A41410EA93;
	Thu, 26 Mar 2026 15:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Hqjjub+w";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B1F10EA93
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:25:57 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-4853466655dso10410975e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774538756; x=1775143556;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=eGI812ogRgf7xjY2uKTJWNIiKDkrlv+vQMBI465KlG4=;
 b=Hqjjub+wPGtj5nMJKmt/5+aoYatMW0CakArRUwE/uHF90TsXTjFABOeZzIsXTKNFHR
 DriGPbneCLhxNbqKMMQ5N47A6zRsqfwKALzZT0AbuzJlAT6OQ7T+aL+MJH6vMLiuOqFr
 lHC2eFbhicfERQvybm6yKnBKv55owJHc9mncuFTCy8FNi6cTsWHvR1Caez7uQVbSg4eY
 7eG71zGeaiEf5zAK+6rxAswu1b6jUuBPGIqN5j1+Qjn2H0vBnRnOTo02t2b2OdrQLt5+
 fWV8XAmRYCftvXRqZ6ytTu/Xjbtw+0nusUn8jgmSaP3EcTlsQSTsvWVbmhPjR+bTUvYa
 jPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774538756; x=1775143556;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eGI812ogRgf7xjY2uKTJWNIiKDkrlv+vQMBI465KlG4=;
 b=oIzTgJWldShwNSZYUmW17RcJy1ATA/EpHzKMo+mDMp2UB7iPftmxjnExXjLxewc59Z
 PWX0js5f0LQROAj6GTJjQG567GH5R9W9VXOzWYV2+pOTXh9HZ9EvfX8kDbUe+URhksNe
 o/SKvKmD9cZemSZY+yMi09WJ+hlydjTqxExjvbX3/OzjU6SipqVVNKxSBDMSbhCPJ8ZF
 FhJ7XcYzXbCiKVSj6Z0jPwNhVX5ntDuAu7lzvM/b6BNaJelRWh3v5xkKOjQRFWOQ5ggw
 VD7mBgJgsOzNfLGIAnwa9fbZAt3oZNCW352EJv4k7ACF9y/0BahmZJ0ceYs1P6SucfFT
 XY5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDcV27ppE0nr1y0pVRbVx/dKuYFFCfyfH5hi7n00RjVRIi7cJICF9bitj0g/9Qm9MiBya0MNS5Okk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNGreNG9WG5r7YylEqstwlZlAjxbbEt8M5c8vC6y53PpXojPhe
 6kgteVCsD8i26jszONcOP/GyZ6UmFlfHIcp0o6npOVmvQXVFFjZZd+a03+5J12hbAM2NnuDQJYH
 mNnRCcEnrLydHV2/N5g==
X-Received: from wmsk8-n2.prod.google.com
 ([2002:a05:600d:8488:20b0:483:6cc0:9daf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c5:b0:487:467:4276 with SMTP id
 5b1f17b1804b1-487160ab146mr116334945e9.30.1774538756267; 
 Thu, 26 Mar 2026 08:25:56 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:25:36 +0000
In-Reply-To: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
Mime-Version: 1.0
References: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=8ETadglAjaG7AHLMZ/ghtdaqP5Ysza0qOceDqwHbL0k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpxVABHNAGQa6Y/giqeifOnyYAZavwDyC4n21IH
 nfASus7yRCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCacVQAQAKCRAEWL7uWMY5
 Rk+fD/9ZmJclSHvBZCxLoRTkDpgIuciOQJ6vLTB0kGsN4F6NHU9YJJiv8T3av5opWjHbwO1TD/V
 xVJqjqsQTA6XtxkhuyuG1bkDprPCbbS4Ov7R/so49fqtdvD7J7wosm6jxKJNQ4R/84hjwNepgt3
 JS6mbNFawhn5yXNeoqpGUuApD+v40ieMCWkF5Nxt2WcpxqMjQalOsuiqexuegOjVsAAbKm4Qp6q
 ykaMkMgHXDUCZzY2QRyMN8tdPnADOvGM4T9Ib1aVLmeS8TM8rImO8pqFaIPuiJEvZ0+ElREcsSy
 FpbH4K3SNFdMLIrSJ1y6U7RNHoYAV/ERPey7PLEs4RghjXkMPdInBne5GjZzPbqEpBQtTtPjLTq
 /DIu4rdTN0zq87aYfg/34Q0bGeiBBQfnWPKLfibPcS/NFOn6Ifm7yu6z03tAlcfVWGvRl6KlM+C
 dWdFa5Nj/vjUC+IlBvFNDaZlBKuAb07aUEI9HuqKJyUXEFpkWmD8Y6jqFJpGNBbKFopISUBYG7S
 KrpW5B7+U3ZwQ8IvZ8VFzCIXQsRFRXuPxvv5/a6kCEXUuSoGDZnqm9wTan50A7dFPIsuMlvPbgX
 lBAvl/qOTFKRn6QtxsE8ytT7p4U48aqaubSM8IHt9ZdOTh00fda6S15IQtMUWis8KLxen4WDyCG
 1g8UORg/BkD6tJA==
X-Mailer: b4 0.14.3
Message-ID: <20260326-drm-rust-next-fix-aref-v1-1-7f6f58d2828a@google.com>
Subject: [PATCH drm-rust-next 1/2] rust: workqueue: use new sync::aref path
 for imports
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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

ARef and AlwaysRefCounted are being moved to sync::aref, and the
re-exports under types are planned to be removed. Thus, update imports
to the new path.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/workqueue.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 4ee4ff567197..019feafd3459 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -189,10 +189,12 @@
     alloc::{AllocError, Flags},
     container_of,
     prelude::*,
-    sync::Arc,
-    sync::LockClassKey,
+    sync::{
+        aref::{ARef, AlwaysRefCounted},
+        Arc, LockClassKey,
+    },
     time::Jiffies,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    types::Opaque,
 };
 use core::{marker::PhantomData, ptr::NonNull};
 

-- 
2.53.0.1018.g2bb0e51243-goog

