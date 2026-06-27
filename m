Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33218C43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 09:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8017C10E485;
	Sat, 27 Jun 2026 09:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="iCXPKgPg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8185B10E47E
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 09:28:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9AB7B43D2C;
 Sat, 27 Jun 2026 09:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76D80C2BCFD;
 Sat, 27 Jun 2026 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1782552528; bh=5rcnLftEgCOp4lCy02ddo3ou6gJMaO0JvPUiLpW7d+w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iCXPKgPglGYTynSaDlFF4Tbm1FimKCzpNercjH+DlfCssyoro78bO25krZpG+lnop
 AYXphDrABeyN/wxs6GSNBFG9fdPuwrioNBd4AQDvpJEYwgkslUxJklPZ1zERxqf7eD
 z/pG40+4mFr0hmA2GC/IFxYF5seGhpwZQMbY5btk=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 67D93C43327;
 Sat, 27 Jun 2026 09:28:48 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Sat, 27 Jun 2026 17:28:48 +0800
Subject: [PATCH v7 10/10] rust: module: update MAINTAINERS to cover module.rs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-fix-fops-owner-v7-10-33cd3990edf0@linux.dev>
References: <20260627-fix-fops-owner-v7-0-33cd3990edf0@linux.dev>
In-Reply-To: <20260627-fix-fops-owner-v7-0-33cd3990edf0@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782552525; l=868;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=5rcnLftEgCOp4lCy02ddo3ou6gJMaO0JvPUiLpW7d+w=;
 b=GGNIoCoYKfEUBYQat5VFTOG6tmxmDNHqJv1L0W2i00rjBItd3TScnk0TLiteVX+ggLeT2cd/P
 +38gDUUtnNlAiDeHW685dFjc01zG0tBw7bcGavBN93GP3Z9NmybYFhA
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

Module types now live in `rust/kernel/module.rs` alongside
`rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
files are covered.

Assisted-by: opencode:glm-5.2
Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c4..74733de3e41ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17984,7 +17984,7 @@ F:	include/linux/module*.h
 F:	kernel/module/
 F:	lib/test_kmod.c
 F:	lib/tests/module/
-F:	rust/kernel/module_param.rs
+F:	rust/kernel/module*.rs
 F:	rust/macros/module.rs
 F:	scripts/module*
 F:	tools/testing/selftests/kmod/

-- 
2.43.0


