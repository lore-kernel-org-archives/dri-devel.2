Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E262C88E45
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E7510F40C;
	Thu, 10 Sep 2026 10:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHTJG87g";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331D810E579
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:31:16 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5b754cc3b6aso3594190e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788975074; x=1789579874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=COlbN8g71PZLS8Vw0yv0Jnd68gVBxKrHka7KfWabY50=;
 b=JHTJG87gmU171YL9kqJztJjADBnxL7Pa17ndamIATcTgSIvkOq/+BNwJUFw6mm0Ebv
 8H4EC1P6p37KBmRhNMpJX/nRAajwWjcz71bqTKqrkAJH3KAdrMLa6mKOr24lvyzD1XQ4
 wC2b7fKCzQYM/I4cfM+2BC+1+Qh8d3IoG1f3v5aIRKaoVFEKZzFLvylcp2pY77rtlPHz
 NThRnQJyb9zfHyrvCZ+p1lvVrYjGSE9LCsfUMxE+FSiiDUyzrnGx0WbnD73H1dJ1T4BK
 NJzZKnNkmzYjzjwlTmowyuj2G4DBnRTOCUp2iuveuQPJV3xy2Hc53xW3QRM9hMs674L+
 W85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788975074; x=1789579874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=COlbN8g71PZLS8Vw0yv0Jnd68gVBxKrHka7KfWabY50=;
 b=VjtyavjvuRRBng25x726Bz0hTTVhH4yQcxtisDuQePBV9jKjm5bwW7cerSAkxGER6s
 Dk3YU4F0JeYV6Ca1e1FYiSgDDe67sBJ8p2n5AA52eq+RO5LFF6zAciZOIyOKUpNfH86H
 oz1M8VCp4u9S8+t0PLuSErVKbRPDVvjvy7Va2KKbxuF3JOdrvpqx48tu0Mtmobg17gGO
 ozQRy4yJeDtej7DL4Q+kUbm0tuX5vyDPN7lLcZQ2nvMF5FiCUbePDcWbvVzn5zYesyUx
 XT0a8fOdxN5phpi9qvbgHgVitT1D/mvTsw0MSaIJndQgZoyqCEfCK/H7S92+/X2IA+qs
 7NrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQwSoch+SInkEGjnettEqQoyqAOiYp7IgqdsylqMGz/UUohVOIhs33nL2QAEeMZt3WTPkt/f3FXrg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nGNOSwuS+6UJ4DsAKWFJ+ll4uSFBFMHX/fAlyBFyXh0S5Em+ql
 qTtNgvkpabt8kCEIaivi5o5B1JUeWIKu8OHfg0U4JFgkATB0rMoxYhjW
X-Gm-Gg: AYBFou3n/1xOtE2/XHhK6uzHD5rwQOWl9w0RtA4M5FPy/cZJ2WMFOEpTh7MXqfmpWnZ
 XWj9dNI/lMzCNfuNf4EiczDm/AMky/pQOtX2HOrMZyGCaDoL68cll+sWpvARTMkSU1X0+yE/FeB
 3NNbSBXyF0DjW6hRmtIoRYTm2BNS7+Rnay7D/RkQvBvUk97Vpi1U7En5nfPyn57FA/3+E/H1+5Y
 kElO9cGFCUwzEbPnDTpIuD2tu2oyOESFZwoLpEqCBtGQI8r2Xij9MDuZhpiJp2+osYO9WEe3uRc
 bxScvOeQe95T4C690nXq/TQyAtgiYPDYBfxAJbFt/8JS8U5/BiNe4BX2ZzgnPEnK4aEKkCa2Gdp
 NZy0QI9xfUJFG33BI5XozH9V5e2l1eUzaizjmrI5MqHSmklVGteNbFvbWQeEdlp2PGcb40E6yb3
 3BiEkZ3lNaClne4EHnLSjkoBlcd9gBjotmeWDNs4HWMDR7oA9Nmce32d2eCbNJm36LP8cKo7Pnb
 ULfC8u4LmCve/0pLockEOa47hb9f2tKTg==
X-Received: by 2002:a05:6512:3e09:b0:5b6:4ad:77b5 with SMTP id
 2adb3069b0e04-5b616f4e76fmr5968551e87.29.1788975073832; 
 Wed, 09 Sep 2026 10:31:13 -0700 (PDT)
Received: from soda.int.kasm.eu (soda.int.kasm.eu.
 [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b752df233bsm2780995e87.25.2026.09.09.10.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 10:31:13 -0700 (PDT)
From: Klara Modin <klarasmodin@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Thorsten Leemhuis <linux@leemhuis.info>,
 Manuel Ebner <manuelebner@mailbox.org>, Gary Guo <gary@garyguo.net>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH v2] rust/drm/gem: initialize callbacks with
 ..pin_init::zeroed()
Date: Wed,  9 Sep 2026 19:31:03 +0200
Message-ID: <20260909173103.73656-1-klarasmodin@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

When the commit b67d2d039f64 ("drm/gem: Add callback for when handle
count goes to 0") added the handle_free callback, it did not update the
rust abstraction, which will cause a build failure when that is enabled.
Rather than just adding another None initializer, use
..pin_init::zeroed() to make all unlisted callbacks None, and remove the
existing zero-initializations.

Fixes: b67d2d039f64 ("drm/gem: Add callback for when handle count goes to 0")
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/all/aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info
Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
Closes: https://lore.kernel.org/all/4da62a4b-c4ef-492a-9a27-b56bd4784acf@suse.de
Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Klara Modin <klarasmodin@gmail.com>
---
v2:
- also remove initialization of vm_ops, which is also handled by
  ..pin_init::zeroed() (thanks Gary)
- fix the same issue in the shmem helper (thanks Thomas, also reported
  by Sashiko)
- v1: https://lore.kernel.org/lkml/20260908175427.47207-1-klarasmodin@gmail.com
---
 rust/kernel/drm/gem/mod.rs   | 13 +------------
 rust/kernel/drm/gem/shmem.rs |  5 +----
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 80d8f524f9d5..9d4280002765 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -266,18 +266,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
         free: Some(Self::free_callback),
         open: Some(open_callback::<T>),
         close: Some(close_callback::<T>),
-        print_info: None,
-        export: None,
-        pin: None,
-        unpin: None,
-        get_sg_table: None,
-        vmap: None,
-        vunmap: None,
-        mmap: None,
-        status: None,
-        vm_ops: core::ptr::null_mut(),
-        evict: None,
-        rss: None,
+        ..pin_init::zeroed()
     };
 
     /// Returns the `Device` that owns this GEM object.
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index a687d46d170d..24cb5343e0db 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -132,19 +132,16 @@ impl<T: DriverObject> Object<T> {
         open: Some(super::open_callback::<T>),
         close: Some(super::close_callback::<T>),
         print_info: Some(bindings::drm_gem_shmem_object_print_info),
-        export: None,
         pin: Some(bindings::drm_gem_shmem_object_pin),
         unpin: Some(bindings::drm_gem_shmem_object_unpin),
         get_sg_table: Some(bindings::drm_gem_shmem_object_get_sg_table),
         vmap: Some(bindings::drm_gem_shmem_object_vmap),
         vunmap: Some(bindings::drm_gem_shmem_object_vunmap),
         mmap: Some(bindings::drm_gem_shmem_object_mmap),
-        status: None,
-        rss: None,
         #[allow(unused_unsafe, reason = "Safe since Rust 1.82.0")]
         // SAFETY: `drm_gem_shmem_vm_ops` is a valid, static const on the C side.
         vm_ops: unsafe { &raw const bindings::drm_gem_shmem_vm_ops },
-        evict: None,
+        ..pin_init::zeroed()
     };
 
     /// Return a raw pointer to the embedded drm_gem_shmem_object.
-- 
2.55.0

