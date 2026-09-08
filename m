Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CE5C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C8A10EEFD;
	Wed,  9 Sep 2026 06:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B0UyyjoT";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9540610E144
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 17:55:02 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5b4adcce4b1so4212539e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788890100; x=1789494900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S3mHm6ZqbhRQ6tXzMkeFKmTWTzRDfTiWOZtRcgd3yZs=;
 b=B0UyyjoTWiug5OSX31wuiBxNfCmTYICWIg6NwqjSpCNiz19t+BfUay/6lOD7w+ktPz
 kKxD86ayi6J9jXkV7bB5+2RpOEssyw7Bc2/lryJjla2PabIKVtsSw2yUh0Y02VOqVfwW
 myDNyrRspLFphYm4F8luUc8iz4v7lFwamgIti52Tjx5iYXc/j1SjbKF4GZPdL3fftZhb
 PthPmFysH9loXeYRKOe6QYA1/8m3cQya/64yoN93wrnPb7MDModacAj2cUiQjuKnGTh+
 ewHSG5eSN1yT0415o39/Gurzh4RAyihNkZwRRNRima+q0FZcu+lmCdrY1oCjCRZhWNbK
 hhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788890100; x=1789494900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S3mHm6ZqbhRQ6tXzMkeFKmTWTzRDfTiWOZtRcgd3yZs=;
 b=S4QLC1pYx3V8jvJFW8b5lZiTEqbG+IlyHR1EVKPnL945s+wJvYaOH60id03lIs+YNz
 Qb4Y4I2cFanVpjGil+AIk/yo809zFz4VDXWAzL0N8v2BYuvxXWt8GWl3mmITTWa//AD2
 PwY1d7ug3DBIk7gPpPi8OeX0jZgfh5znyK19XdhqYOPl/3xS0c0SCEhXh1i0+fhDJWuF
 EJMrd4jzWt3etFhE9kuOWaFUdSTOXW/3cr2ZhBL9hu8CJVQPi9kTaxY0wAmbTmNH+D+J
 kKsx/mC7gxAvIGLC4lo0nc8b6rQYdDiU6NllMFMo7UfwlZ6GGgWVDiWuVsWngetvqNTS
 WCzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBypbM1on4UF+cRMD09aypCYuJYCSsCsY3qhpxq6sKJwGmDpddTzssY1zRxHdWbRp/2PXMCSQb6MnOw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k2VFFXlBCuH9kdwWR60RSjUXXWRpDnKEiLf/xza27RMKo533wC
 uCQFC6dkq2DapxYsVKZ5AClNG0lK1v9pg+vvjwEZfne04/tW7wDNNaO4
X-Gm-Gg: AYBFou3yeTC2it5RiKdEN0ZZKlbR2dvteW7Zpt7AW0fguYo09JcBg/bkHw3lI5APgGV
 vFcKDUjMlAjdeBq+fEsYUpSHg8DsPAf+ZXLbrBT0IGBXNC7S9dTx08fzDm7OJYbUp8VJzWWUbul
 84uUvP7DwovO0B/Ll5fkd1n1DmnesiW5SJnQ7fv5uVRYxZAz+tNMBG6q4rHHhON5YSWIeFszD8a
 ymDwm29jSbHrSoMEaCRmMTF8EYGdxX0PtSdto+KLAC1XEJF+vKo+OKjGXWAh6CNO+eYdJ1lmWeK
 Gwjcm87WK3f16OAlIohGeT/AFsNtM1xk6whL2tDz7yz4+URHfyGB20QwGWgC/5o6hgC49JLDkm4
 JHq20Gf3xB7N8qcaAUlpjqBxeoVMACpGofj2M+XUXjRW2vvuVcDVCH9Fn1YXNx+WxTYw6Dv5kRc
 UioOC0UHfi0Epb34TEBL45rhrKraY2+7APjt0Ygke+Zanpixqg2jhPYYz5EV6YUnpwtAFIr/6KO
 hKckyzzkORs
X-Received: by 2002:a05:6512:8393:b0:5b6:1836:8082 with SMTP id
 2adb3069b0e04-5b6183683cbmr7614121e87.28.1788890099983; 
 Tue, 08 Sep 2026 10:54:59 -0700 (PDT)
Received: from soda.int.kasm.eu (soda.int.kasm.eu.
 [2001:678:a5c:1202:7b92:9ac1:b9ef:5287])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166fcdf9sm3172156e87.46.2026.09.08.10.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:54:59 -0700 (PDT)
From: Klara Modin <klarasmodin@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Thorsten Leemhuis <linux@leemhuis.info>,
 Manuel Ebner <manuelebner@mailbox.org>, Gary Guo <gary@garyguo.net>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH] rust/drm/gem: initialize callbacks with ..pin_init::zeroed()
Date: Tue,  8 Sep 2026 19:54:27 +0200
Message-ID: <20260908175427.47207-1-klarasmodin@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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
existing None-initializations.

Fixes: b67d2d039f64 ("drm/gem: Add callback for when handle count goes to 0")
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/all/aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info
Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Klara Modin <klarasmodin@gmail.com>
---
 rust/kernel/drm/gem/mod.rs | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 80d8f524f9d5..af8274134a71 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -266,18 +266,8 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
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
         vm_ops: core::ptr::null_mut(),
-        evict: None,
-        rss: None,
+        ..pin_init::zeroed()
     };
 
     /// Returns the `Device` that owns this GEM object.
-- 
2.55.0

