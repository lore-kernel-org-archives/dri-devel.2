Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9942CD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2BE1129AD;
	Thu,  4 Jun 2026 20:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HUSWvnjj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F681129AD
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:14:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CBE4160139;
 Thu,  4 Jun 2026 20:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411F81F00893;
 Thu,  4 Jun 2026 20:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604055;
 bh=UDKImhxSIS/fNprfWQIRF9/bFD0CG+MEzEYu4ZjZLR0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HUSWvnjjP2E25THnS10KhqGscgSWfXPY9OTuEU2lXvu8sGjibTgS2hJh1c7sVR233
 ZsSMfrGf5wan4J4lQaBQPFxwxHEfkZB+SyslGH0qiD3tupaMJGOF+xfVCXrdCa2nop
 bfZ4DrP5VtkcSumcTB7mPODx29giM+ghh+FTkROTaLEuAE6mh6otpO2xPVgZt2DqVC
 XWOJbv6sA3Uf/sptnzfc7WprUW0qPW12ITimONL3qIMyuoyGZsERZkyT7yyp4AoXjJ
 JSPLPuTZtHSv89xBRY2E+XCGkG/WIy0HPLdmYvkNEYRY8uN7duiAc2vqNKEQ6Rg+2N
 1E1gmpx/gdZhQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:16 +0200
Subject: [PATCH v17 04/10] rust: page: update formatting of `use`
 statements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-4-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Boqun Feng <boqun@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, driver-core@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=4RyZCw8fL1vZdiYtCKnYPrhKo0dFDXqsJU7kpadSv3Q=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvpNRczTi1MEzbEqRlUSeyXZWfTU4TEqBFL8
 dQ624Rhe9eJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb6QAKCRD6UCkIqsW9
 0GdUD/4yqmBAhNqMpqX2A7JxCA0GG24Vbr11LAL40KqFhbTCAdt3gGkUa/a9Rz9aqi3vkCbe/ST
 FnkQd+bp2YQxM1v4HvkNdYl6bMHsOvU18ZPZoCGKvZQdn0lKxUF293/3c9nt0kC71fWAfWL4wUP
 uy/AgLXJiQ/bVHs8H1//ZL7q//UZyzTjudKIDdn/EdREN8oXJP4QpPMHfnIzWC61sddwm6SZq1X
 7VkKcUzxtOBs75BHWPMXfiC3Xg8KePSbkgSlhLUO70BrcXgRRSLmRRKacG6XS26Yz0me2pRnu7b
 cbjUrbadHMO3LNeUwdHuQjW+WEvIrm1sTyrM0G+4DxAuLLKNhoeiHC192iqOdYproBsGzIdxZ/W
 CcTR5LugyvvJIpEIvAXhvq2C8XTPF3dR/lAhBfHr4vph7dFDwfsiucAQpcXJSOtQ7coI+ZX7Rct
 JvnjdjshEue1W9UTO9m5UWjnXARSegihnwosgjfAX5rft8kqmQ8bOKDDpcHvHZ3qVnJWK/be+Oe
 aq7VqUaKnUOsvjxnxfFEc0jDhigeUxIZUPxZrJeTV1ak7jdJAjZNBIC+vvQ72+hBMXRMIclDCVe
 vviPbhfux8KOliVlfgAoDzFODyHymtIfsJkBJBNpxpvX3P3KI581baQQA6LqlsWWHywfzYv01nt
 XV4VKoWPUlCeb/g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
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

Update formatting in preparation for next patch

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/page.rs | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index adecb200c654..3bdcee0e16a8 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -3,17 +3,23 @@
 //! Kernel page allocation and management.
 
 use crate::{
-    alloc::{AllocError, Flags},
+    alloc::{
+        AllocError,
+        Flags, //
+    },
     bindings,
     error::code::*,
     error::Result,
-    uaccess::UserSliceReader,
+    uaccess::UserSliceReader, //
 };
 use core::{
     marker::PhantomData,
     mem::ManuallyDrop,
     ops::Deref,
-    ptr::{self, NonNull},
+    ptr::{
+        self,
+        NonNull, //
+    }, //
 };
 
 /// A bitwise shift for the page size.

-- 
2.51.2


