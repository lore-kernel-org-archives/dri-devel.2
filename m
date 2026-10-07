Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2267ACA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823F510FCCA;
	Thu,  8 Oct 2026 07:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LCoC+8Vo";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7770A10E693
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 21:18:49 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so23001025e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791407928; x=1792012728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gCOgnzxgPsldEawW4qaR+rRqfBySYiXshFn8/j+fwrI=;
 b=LCoC+8Vov2TAfTOd6XgH84Zg25Jr0NamhmeUEHqKu65RNU9HZJSJebxYTrsrVq3waT
 nkHCpOl/LU3vPTmq7BS/qw5spZS7q0bWyvxxktH8M0hhlTB4/6eZjW1L6Smv4yVsKepi
 sm2fesucW6uyoR7DvN194dRrtsFITMP6A44yyf/nTVCYpHrIINGiXlKyYxVfwYrC6vJB
 aicmfmFmfgpcqPQrtpRObzCBsWZsuj9OKWwf4z/mOMQB7KDHmi5HaAmBcgEMEE4QCgma
 YM2q8g6xjRMSE/xb9k7PEbgouR+/mcEzBLwT8d2/hFC1dEjQRYvgxn9h7lf0APzPNZuy
 bazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791407928; x=1792012728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gCOgnzxgPsldEawW4qaR+rRqfBySYiXshFn8/j+fwrI=;
 b=zcPS4+6IfwM1XYhh+3RzWv+FAdn0e/DubQw+KKlBouKjNkQg/3xYAutGYD/7yWn2oV
 nZ+77MzFNYszx27WJjdS0xpZZNCy/NUQ5GDzED8RJ43rnVmqNo0TXoJGK7Mzy96TkQQV
 HDhYCHQviOQDH/170I5kqgINryB9D3dhXhj7ZXfrDMrYO+z53ZDOm/opdMYSfHnpjVix
 cS2HDXdz/Zsa34jESpZkO0cdiccU9COntGi36O2sibUx3W36NGrSJQDeDpayodxKdgGG
 lksmiqLRbx5jPquo1nPG0awPnG2yPgqf0KyD3wkiXt+MDyj7MozzivimzvzzigjRAcV4
 Qh8A==
X-Forwarded-Encrypted: i=1;
 AKwUvByj19ftWG6c8fvhGm4t3s4nna+q1yKYEMSUW+YWDVlr1DJ3ek/6AqrizxSc+SyspEXlUOf+6/8Q2QM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mYRu23JRZduh4Hq416UkHYb+rhqNZ130/7fr1e1nw85ZnG8TJ4
 nNde80pU5+5cxEIkt1TUfzcd5hpHYrkbYzy8P6v/u5hkm9uAYHngelVg
X-Gm-Gg: AYBFou1dxlowcvKmfaDjUOhB62LPrWSvvJOBV76gsrMh47MyQYU/gz8Rn8M8vppRp3/
 K2KLbRlZpkA2mYaehDa+R+7fz7+n12qscBbK5zqBdha72JFgqprFq3wGkOBSG+7U52JT9zlV8r7
 +fWV7/axQnSZIUldz8ER/xJE9chUSWxj0m8M+5pyg3iDXkS9zaCf3RzIrsc2FpPaOc9HxkRSVHN
 1yUgpAX/m9L0P/bVn4MMinfcnjwIMoJAg+DM2YVQXYs0BcPiUK24zGmx/PpX4A65tbFOCbT8vNr
 bedF5+JieVT6Qry5u53nuTzV/eJwXHxeeq0Ccu1AYf5DGhbTLe2n25P7xFuYF/7wn/TTzvxb/DM
 Y19xutsezC/+sZmsyajNzRaO+cLzHiox/MVEEEAStHegiYFPTdAYDdQ+FZObD/G5L1RhUuZzGuS
 SfpfqpQhNFTZj1HLp/yD67DG+72l7x7GhjBZJdQA4mE0WDuWuyY/KRwA0YsOWTUq/CeZyjf3m62
 WsNPpTBbDW5Ws9QWP7UF5MYZLFjpdy/o9u5huaKQt5gon58RBc=
X-Received: by 2002:a05:600c:4e45:b0:4a1:6c3d:cdcc with SMTP id
 5b1f17b1804b1-4a18043b382mr55914275e9.15.1791407927690; 
 Wed, 07 Oct 2026 14:18:47 -0700 (PDT)
Received: from sp1der-OptiPlex-7080.epfl.ch (dhcp-122-dist-b-107.epfl.ch.
 [128.178.122.107]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f446d51sm57964705e9.0.2026.10.07.14.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:18:47 -0700 (PDT)
From: spidermana <xuyiwen14@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: spidermana <xuyiwen14@gmail.com>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] rust: drm: ioctl: wrap `Device::from_raw` in an `unsafe` block
Date: Wed,  7 Oct 2026 23:17:40 +0200
Message-ID: <20261007211751.2428111-1-xuyiwen14@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:42:48 +0000
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

`declare_drm_ioctls!` generates an `unsafe extern "C" fn` per ioctl. Inside
it, four unsafe operations are performed, while the call to `Device::from_raw()` relies on the enclosing
`unsafe fn` body instead.

Both forms are legal, but the kernel builds all Rust code with `-Dunsafe_op_in_unsafe_fn`, which asks for the explicit block.
The lint does not fire here because the macro is defined in the `kernel` crate and expanded in the
driver crates, and rustc suppresses lints for code coming from another crate's macro.

The patch is to wrap the call in an unsafe block, keeping the existing SAFETY comment. No functional change.

Signed-off-by: spidermana <xuyiwen14@gmail.com>
---
 rust/kernel/drm/ioctl.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 64af9eacc306..5a2e2f4f0e91 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -152,7 +152,7 @@ macro_rules! declare_drm_ioctls {
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
                             let dev: &$crate::drm::device::Device<_, $crate::drm::Ioctl> =
-                                $crate::drm::device::Device::from_raw(raw_dev);
+                                unsafe { $crate::drm::device::Device::from_raw(raw_dev) };

                             // Type-inference anchor: the closure is never called but ties `dev`'s
                             // type to `$func`'s first parameter, which the compiler cannot infer
--
2.43.0
