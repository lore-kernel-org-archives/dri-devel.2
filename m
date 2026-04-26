Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47573FF885D
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 09:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A515310E531;
	Sun, 26 Apr 2026 09:47:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KmY8dY6W";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0509C10E531
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 09:47:44 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-35f9ab079bdso6126983a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 02:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777196864; x=1777801664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZHhSckLmj3+7rbDwz/6bR3hAFf764LgnIQFCwbFne0A=;
 b=KmY8dY6WMYjBbk4RK4MvLSaFxNJxE1KVq3QYp3l0ChV9J5AHSYU4MLeYc2Uwn1m9R3
 LwGvudZBvZ4Bpbd0ob6aZgZY92XLeHjxdnCvQE64bUFlunqhL+qaRWtChb/ae3oOgXKM
 tX+aF7/NIYE/fkyEvSiJcY5nNFBFiJSZ6Do4WC/KfdrCILaIbT2WfOoq5ffjot8hKu2e
 fS1v5D67Xj0mUqm/n/1QBgXu4TjYW+QR/Puvj42W7y/abAQwueFwaQfVQ+85yIVIj4xw
 p3/4wF5DSdy7Dr5l0Bk7AFxhNEh+mX8oV0Yovqrs22f7V4YCe3AeX3v7Lpw8lYPYqsNF
 Mr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777196864; x=1777801664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZHhSckLmj3+7rbDwz/6bR3hAFf764LgnIQFCwbFne0A=;
 b=FmZxm72h6GC8JQ8bPkfmD6QD19lJx1z6B5v1yn6Z3/9qVROj3p9ZGJPjNgCwGzXqtF
 wWWIUPrp/B7GdFivhPFlX+7GWEnA+2rnvYz45kMDsEJcF/m9J1t8RFp5z/fUZ8hOR+0B
 tFgnrv7LCW8ajc/Izrb9gmYQ2uDLPzT93oa7DgrUBm+U5w7HdYdRpvHZxR6nH9/BHGTU
 ZT7u5jPSM/NoT8foZjWihmWr7Zcan+Q+oGlPE43YNJiBfjDcQkgOpvITvnkkJntczKw8
 DPLaIOV5dq+S4aFNreKtbMNPXGmdR58tubiCC7e48L2JmhD84+eyFQxX4Gsre7jxk+2t
 PzOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9b79dhzxsfSGuPPSZTDNgUclHupJAIReh3DX06hlsPTEe/Xoq1GIZsml3IqmFqBCJ5ttIyJIlWbks=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy40/W8B2wD0rv0OUN7qnMKFO7lFeqyZh81Te7Kq99C5zs7ANkC
 pGQo7oTValrkFXu8YbRqNq6bg7mml9gVH8udpPBuaeCpvX+5gbCesdzd
X-Gm-Gg: AeBDies9XGyUYOoZKrh4zzdqXzCsl9WXWWjY82MLdeZQFtY8h9rnt8hNoZOUR09W9KK
 54tgBmAPUdpqHsNOQn4DV65xshoGgSlwriGcd364RbTKU2f3CqO0Pm9Ie+95xFbxi2VxSJRUoUn
 LAbATxcDachFSxRbQTvle+3BhPD54PX7rt0i90DDcgQrA3I18Kb8der3hKt0H+9ip+FRHpiHZex
 yXU9FwEpZrdlNifEntyaC6IfVzjb6n6CVXY044FLOFfgf/Jk7yljsVkXckIfGuCGYqlSUIE1AO4
 XO+3ZU3xzOdTKDicd2L3p3SN7MlP4jk71DD1QNcVFAyuZK73Jz1sB6IeE61zTrG7i0D7R6unZrb
 pwP19YH3XQBKQ5yTKxXwGJsrfyz5+TWbYwJCdnSRCDB+j0tHzCpwa0fOklmNak/TSYReGb1ufFW
 AzbQO2JXfxUxP4MUiaRKog3gylylKj+bAgMPCYDcu0qCnBrSSzm9MphPYGZSJ8s03f4u4lE3EtN
 Y44IBykLrp/95Y=
X-Received: by 2002:a17:90b:37cb:b0:35f:d56d:1c45 with SMTP id
 98e67ed59e1d1-3614041bc7cmr35362717a91.12.1777196864370; 
 Sun, 26 Apr 2026 02:47:44 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com
 ([106.51.164.157]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614371a7c8sm28450073a91.5.2026.04.26.02.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 02:47:44 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: dakr@kernel.org, aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, daniel.almeida@collabora.com, lina+kernel@asahilina.net,
 lyude@redhat.com, j@jananu.net, mkchauras@gmail.com,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/1] rust/drm: import ARef from sync crate
Date: Sun, 26 Apr 2026 15:17:25 +0530
Message-ID: <20260426094725.2188668-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426094725.2188668-1-mkchauras@gmail.com>
References: <20260426094725.2188668-1-mkchauras@gmail.com>
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

ARef is defined in sync and is getting used from types causing the
build to fail.

Fix this by using ARef from sync module.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/kernel/drm/gem/shmem.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index d025fb035195..e1b648920d2f 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -19,10 +19,8 @@
     },
     error::to_result,
     prelude::*,
-    types::{
-        ARef,
-        Opaque, //
-    }, //
+    sync::aref::ARef,
+    types::Opaque, //
 };
 use core::{
     ops::{
-- 
2.53.0

