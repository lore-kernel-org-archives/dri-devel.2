Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D733C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2545710E712;
	Mon, 29 Jun 2026 07:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gurudas.dev header.i=@gurudas.dev header.b="Wn/fpinj";
	dkim-atps=neutral
X-Greylist: delayed 390 seconds by postgrey-1.36 at gabe;
 Mon, 29 Jun 2026 03:45:03 UTC
Received: from out-21.smtp.spacemail.com (out-21.smtp.spacemail.com
 [66.29.159.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0787510E002
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:45:03 +0000 (UTC)
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net
 [107.194.158.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.spacemail.com (Postfix) with ESMTPSA id 4gpX7F3RH8z8sbD;
 Mon, 29 Jun 2026 03:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
 s=spacemail; t=1782704315;
 bh=+xTdES5iivUlujAb8S85lcbvOQK1iknw8m7NM0ttyH8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Wn/fpinj+vbdRtvql+K6l/cdD/IQuxl+e8wa5bMUwtZjuwKBolSQ7MPAy/E7r34Vm
 JlNz056v097vPX0LzLgdqw2ChkZM2e+fJk8P/tSAAd2maOeMGg8lIAZF85c2zvHBDu
 VvjXDXzHnPpQjWCS+ByzEU1aJQsXP4SMkbdEEHVqG1BkAeoV2x9WC0P0K0Z+MjYOjS
 au8gLtLRrapdakIsP6VjyV1XxDwH+fWg+f5WXQGK+fiJCCeuiHfvVAww/GogX62e5/
 gE9EB44qcxIf7szuf9P8Mfi3D550P367GBwwZjyXTtADMoUywMT2GZh/cupjmsZoPi
 3qRa8ft7LLoJA==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 28 Jun 2026 20:38:18 -0700
Subject: [PATCH 4/7] block: rnull: use vertical import style
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-b4-rust-vertical-imports-v1-4-98bc71d4810b@gurudas.dev>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
To: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 driver-core@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-block@vger.kernel.org, netdev@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 drivers/block/rnull/configfs.rs | 20 ++++++++++++++++----
 drivers/block/rnull/rnull.rs    | 13 ++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 7c2eb5c0b722..07ce21a44081 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -2,14 +2,26 @@
 
 use super::{NullBlkDevice, THIS_MODULE};
 use kernel::{
-    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
-    configfs::{self, AttributeOperations},
+    block::mq::gen_disk::{
+        GenDisk,
+        GenDiskBuilder, //
+    },
+    configfs::{
+        self,
+        AttributeOperations, //
+    },
     configfs_attrs,
-    fmt::{self, Write as _},
+    fmt::{
+        self,
+        Write as _, //
+    },
     new_mutex,
     page::PAGE_SIZE,
     prelude::*,
-    str::{kstrtobool_bytes, CString},
+    str::{
+        kstrtobool_bytes,
+        CString, //
+    },
     sync::Mutex,
 };
 
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe8..d58d2c4c5f63 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -10,12 +10,19 @@
         self,
         mq::{
             self,
-            gen_disk::{self, GenDisk},
-            Operations, TagSet,
+            gen_disk::{
+                self,
+                GenDisk, //
+            },
+            Operations,
+            TagSet, //
         },
     },
     prelude::*,
-    sync::{aref::ARef, Arc},
+    sync::{
+        aref::ARef,
+        Arc, //
+    },
 };
 
 module! {

-- 
2.54.0

