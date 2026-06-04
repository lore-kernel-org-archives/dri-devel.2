Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F77CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DAB112992;
	Thu,  4 Jun 2026 20:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NMaDa3T3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E6D112992
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:13:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9FFEA432F2;
 Thu,  4 Jun 2026 20:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EDF1F00893;
 Thu,  4 Jun 2026 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604014;
 bh=NPcZxJix8R8ASgeYRVdWoUpgDuVO0mdlMhZYBbXxkJg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NMaDa3T3vyLRFmymA/V52rXGwDjbP7qMQN4Wc6U9T7dNibSv9rS4yWTPxKF0xFzfN
 dFZOd0Y8wfML/F5N2JdyfxqQMOrT524BxyBbUKRKu4/typQSBoh7ZOcQC5MdBLbD5r
 C9zJAYfKCjEVkzTKSipsvwoebejBXmrm2+xD/6QwEn4TFfc2wN8StX1Sz9WdD8podp
 spMPdFZLO9/8wFf7L+vHYI9bVVvTww+5hLMn9V3TZzZQohZXAxPSqm0SM6NfrnEkOK
 pX49PkQ8gXFAS4hFTKiK9du8Dtl/oCH7bqwbLMSjbXowqz9mGLhnspH9Kps2IJKiI9
 ZKCEb3I8LC1ew==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:20 +0200
Subject: [PATCH v17 08/10] rust: aref: update formatting of use statements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=751; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=l5c0q5tDqBvfUKptiUH9ujhgGaCW4zeIf26teZmhjjI=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvtLrwkUygT4paQMSlPzGAJcExHlfQf51liz
 OCOSDABPJiJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb7QAKCRD6UCkIqsW9
 0J6WD/0Z8lBgQ1MuPW0rDHqnrcon/KFXZUwq3cjDwyiCbtTXQiqqqEQxzoFn4yoVsgCmwPqmeOm
 Cx8DTKkFZa72O2fudXulQnzc7oh1qvTtZL2jIN9XCKwsrlO7B397BRIbW6DZDciF5UEjT2f2RKq
 5zYNXCH8IfEgUZMKL78lTl39Rcp6XKKbUoW5PEVlEm73+SKiXHxwzFfJDkH9jcjGprTlztQ0T/4
 DBj4iiOWhCKUfv8pxas1yPG0xsvkuhy2jH2bpT51pe1X9kWG7qV62tbl60SpN/1r4D6NS08pgtE
 /jtE3A+Q+2Ai7gLh+sEwFFLBptTVRkjy+rFiBivZDSkpYmEh4Z3a+FqILoLdN/dcb0zMcUra4a4
 vdzb2MagQbOIERyflkW4Apz1YcbHDkL/895OLyzPFZKeEu6BACgcnvSr7JOca+rn3dccghtl9vs
 5lbeD662E/jwmvKHa9r6/35yJ0BcM4EZcPeAFvpbHFJjgNA2CYXmZLjWWEuw3bS7+DPTVPSN1s9
 kZ8uc2TYKagptlINpzFfIOqH2ojTx4awhCIuHNDv2K7rqJve7fI+WZewsteU15iOq9AfRec34+u
 Tdpn/pMgwdni2r7UW1vly0W0TNj1enYARL7mXpTRJR0J0On5QpNOeJfBJypkxp5AS6MB1G61dMu
 wuM844VmxxYXIDA==
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

Update formatting if use statements in preparation for next commit.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 7491382bcf29..818c84fa923a 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -17,7 +17,12 @@
 //! [`Arc`]: crate::sync::Arc
 //! [`Arc<T>`]: crate::sync::Arc
 
-use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonNull};
+use core::{
+    marker::PhantomData,
+    mem::ManuallyDrop,
+    ops::Deref,
+    ptr::NonNull, //
+};
 
 /// Types that are internally reference counted.
 ///

-- 
2.51.2


