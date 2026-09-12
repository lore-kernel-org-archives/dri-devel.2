Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76310C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804FE10E9FF;
	Sun, 13 Sep 2026 20:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qp/2vgTV";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5722110E374
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:18:48 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5b568dae0e8so1672683e87.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789197526; x=1789802326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=57Wx5MSpf2ecnCSxZA6V8UzQ9jEpIiGdt0LOaHjR6Qk=;
 b=qp/2vgTV8ZFo0lS+p0rpA9r66Pu6tOsCIiolQRBcnlrjnPaVS5ugQFGpzhLdlYpacD
 Gn3spU6K7xk1RQQGzxkj3dfg1xChXn5aTKFijJP8rkeyJPzYeu02I4jX8v/V4r9q7sgk
 CxP6B71F7l7FL81CVowLwmwPnVssxzf8gUMzTN+BO1yWX0Z4zkHotBII1J4P+EkTQQTf
 CDtcoeEug7yWTfRx3q1yWvPV/5EMwu8lTdLonCh0xzzTRVhd3gPncVdAnpWrezxxmWih
 KpuZoLr4OK57fv11Tj9i2wfNELszy6DFwTWiDh6ybyh9W4pfrYVQHhUcEjDCZfHmduSI
 RCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789197526; x=1789802326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=57Wx5MSpf2ecnCSxZA6V8UzQ9jEpIiGdt0LOaHjR6Qk=;
 b=pxBkG1s05imBjTg/CfCZfNDMp4XnUG6hyrePo+4Ui7ieccUhxkWt3vTIG0+CqNbMxi
 o1AEAyvldODGMZsNXi7rP77zbQPbrKDl1xydhLA5MwfGphzh1DIc6fZZMqrb4P4+Ewu9
 GCzrk2P3NzdCeMyurK9n5tg4d6PeHK2O/7WaZ4KK2862tAg1xjWaSFsePi3MQtNmHWYx
 ulzV/PrP+X8Nj/TsRa+yTrlYlqHHZ7RPoa3ewhygRiRTZ6ufQnd3rcla0G5vWNc+26JA
 lJQUv1DVT1lJbDX051APq4QRPMmp4MV4xw1mABUj4rh63cw2TRD25L0Gahgc2nKf5b4j
 dHPw==
X-Forwarded-Encrypted: i=1;
 AKwUvByfqRwMIR1PGDcQh5wh/HABe9Gn+fNcEubWjYJKBemBYlhiStZZMFkMau9Ux6kp/mBFk3KeA2Q1YYU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n5CCa+bxlFitlsz8sP/3vC+GnoHSaP8qEEvC5BHNflC2GRV84I
 2eCqz4cz4xiwVwcC5o2p+VSg6rWpZ9eENxELiSgRqyragyYVLbbvfeyF
X-Gm-Gg: AYBFou3DLzi1IiwStmk5Koe02ec4tPiOxWwSfS1hexiCTbn1EPRkIM90ly8wmAIUGqg
 QZQonrPHtZjJwAxks5zogKft0eCJj/Rog8W+Pl8R3h/CY2uTFA/fETvTPWDzUZQp9AkT9RmUOR6
 G+a9tQWkFc5czkCqWITLec7zXgT/dhYgX4fhm+JtcstUB6wqtm0TcAzMUsjB9Knik8ADbdejuIC
 5egNqxfmey+hInOeDrxbaNNt0GE5bSBMurUyJRpsXxonfkhzbSf7GitIgdxpaL+xKIbYyAnUeBC
 DXyCHPz8sMDEhr+RpFwYQsogfFs/mda46vF7AK/MI+4XBxjHcgCI8/ZAEcdqqqf1deHhkHPBs/A
 1ooCrpoCjr2KUfZi8Xde39LdtY1tuaaizHKeC6rMHPOso0I3/YCNeBxuNyqeHRim5g1LGvtNQXU
 MmplYRJ86UmEqjE6i1VvSGu4HHnH1qak/K5dDQBznEe/lPzpsREZbPKX8dGxpOfNHI5BGp1RlTE
 pR7OA==
X-Received: by 2002:a05:6512:2246:b0:5ae:b7ca:33ec with SMTP id
 2adb3069b0e04-5b8a02de7eamr1453366e87.9.1789197526260; 
 Sat, 12 Sep 2026 00:18:46 -0700 (PDT)
Received: from localhost ([95.190.112.239]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a04571b0sm1096277e87.13.2026.09.12.00.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 00:18:45 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v3 1/3] gpu: nova-core: build the debugfs guard before
 registering the driver
Date: Sat, 12 Sep 2026 14:18:40 +0700
Message-ID: <20260912071842.622696-2-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912071842.622696-1-vladazaharova2018@gmail.com>
References: <20260912071842.622696-1-vladazaharova2018@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

init() creates the debugfs root, hands it to a static, and leaves it to
DebugfsRootGuard to clear that static once the module goes away.

try_pin_init! builds fields in the order they are written, and an
initializer that fails drops only what it has already built. The guard
is written after the Registration, so a registration that fails leaves
it unbuilt and its drop never runs. Statics are not dropped either, and
the module is unloaded right after, so the "nova-core" directory outlives
everything that could remove it.

The next load then finds the name taken: debugfs_create_dir() returns
-EEXIST, which Entry keeps as it would any other pointer, and every
debugfs file of the driver silently fails to appear until the machine is
rebooted.

Build the guard first. Drops still run in declaration order, so the
driver is still unregistered before the guard clears the static.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 drivers/gpu/nova-core/nova_core.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 1133c6ce5c55..11fe1d2858a9 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -47,7 +47,8 @@ fn drop(&mut self) {
 #[pin_data]
 struct NovaCoreModule {
     // Fields are dropped in declaration order, so `_driver` is dropped first,
-    // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
+    // then `_debugfs_guard` clears `DEBUGFS_ROOT`. They are initialized the
+    // other way round, see `init()`.
     #[pin]
     _driver: Registration<pci::Adapter<driver::NovaCoreDriver>>,
     _debugfs_guard: DebugfsRootGuard,
@@ -61,9 +62,14 @@ fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
         // cannot be any concurrent access to `DEBUGFS_ROOT`.
         unsafe { DEBUGFS_ROOT = Some(dir) };
 
+        // Fields are initialized in the order written here, and an initializer that fails drops
+        // what it has already built, so the guard goes first: should registration fail, its drop
+        // still takes `DEBUGFS_ROOT` down with it. Nothing would otherwise, as statics are never
+        // dropped and the module is unloaded right away, leaving a directory behind that the
+        // next load cannot create again.
         try_pin_init!(Self {
-            _driver <- Registration::new(MODULE_NAME, module),
             _debugfs_guard: DebugfsRootGuard,
+            _driver <- Registration::new(MODULE_NAME, module),
         })
     }
 }
-- 
2.55.0

