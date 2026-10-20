Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB060A261B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YD9ZRw1e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2033D10F3AD;
	Tue, 20 Oct 2026 08:25:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA2B10F39F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:25:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B65AC60DA4;
 Tue, 20 Oct 2026 08:25:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792484747;
 b=hTIJtvSRH2k49nX6d+50Tro4sahNt4ZbWf/U/WUggzaqM6eD/WrJbIqTsr9vKGA5gB86
 JMnRj8E4zDXskzRIBAOVR4xCZwv6m9g8PtGEkkXRwxU8kmfwmNr2NSKjctk3K0dk+bSfb
 oneP7KxJACLm0g2tujFga0BY8sdiX/WlNSyAASor+bJh8nORDjrWH0H1RKCFIb33y8lV9
 JBwLS6blfUWhhq7Zqn3u1+wPrsmsB6f1/pWZeX8thokE3l3gK6UBFANVhdwCT4+tmwJlH
 3luiq/l+dwRnv63qjV0P5QRgIffiSqoTHU5R69iuK32Hxu9F8eCos9JDYup6XYTrA7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792484747;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=jPxyRVxUkD8Td+9QwNyvaWaSg+CRoePkY9b5UHxne8c=;
 b=dKatv3KDTnujupP71/V0C99ssfgpTxF3JbVdauQpPBOCNMxRkSp3Pbt3qBjeQm6yvvGT
 lHA3j7u3ANXBzZR4KX9t/jPpTBV+1ag/fZMDTclTVoTlUQbIyLKn9ue4BzPMhJ2/LReja
 olOBfiToR31xqTE5AEaDWKlPLfyT5vcpynDqJLZyo5hg7EevYW7FxAd8l7+Xn0Ei6Qn1Z
 PQS25D7kLu7OtYWuEXT+dECQHOITTR0GsexOx+ogm2GwefJWLK4IZ/w/nIkHPSB09gUlr
 sza3PUaBUO98XoeZ/sN4a7mqDEFg7DY7RQlKpKUpj/Uml9tkVWn6r7Zz2LTPkUuF0HA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4562E1F000C7;
 Tue, 20 Oct 2026 08:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792484747;
 bh=jPxyRVxUkD8Td+9QwNyvaWaSg+CRoePkY9b5UHxne8c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=YD9ZRw1edhudz76MTNsrjlEf4hfWQ7z+8WgT/xIwtiZ1qTEz8z5rMMEmhE7vVzxcy
 rQcNJd8kE9JVl+3MUoQJHpZXi8W7RkRL43FRMc+QRp35wvYeQuQfrqQe9EwMc37AJn
 Mb2wmSa49WKkaY5OY01Cw5Y0F0QI+URCdsQLbIrADAkrKb5agEVOpjD+87zqtUIN/F
 6yieJWhW8QwcVg6IG3CCP2oDVugkrQXKr/wBX7lf5pjfopRhRv+WYPgJXCN7Nm3RY/
 wJrChpQCxPs+mgXTuTrU0Kg3ZljzjCGlyk+fJT1VSX/zzKTU8BL6Xl4fyye/NMU2Ri
 pQ8AeWx1pYJlA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id AF794430D7;
 Tue, 20 Oct 2026 08:25:45 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Tue, 20 Oct 2026 16:25:20 +0800
Subject: [PATCH v4 03/11] rust: sync: arc: relax `ForeignOwnable` for `Arc<T>`
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-tyr-ioctls-v4-3-704de77da223@kylinos.cn>
References: <20261020-tyr-ioctls-v4-0-704de77da223@kylinos.cn>
In-Reply-To: <20261020-tyr-ioctls-v4-0-704de77da223@kylinos.cn>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org, 
 driver-core@lists.linux.dev, Ke Sun <sunke@kylinos.cn>, 
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792484721; l=1389;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=E65clxOu/qjNbqNDrRBBfaWHB/W/gvw7JStoVkgnAT4=;
 b=9OwCtSZSA8ESXlncgmFEdWkXp304HK2DH1QRwr3SpIWHFMg8uWBiTUZC5Hf5v+z/VV9+TF7dw
 4om5xcnMwqkBO3IoqCJ1E6WR15C8MP4tWxyhVdQb1+sbDG3gpEGztpT
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sunke@kylinos.cn
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Sun <alvin.sun@linux.dev>

Drop the `'static` bound so that refcounted values borrowing from a
driver registration scope can be foreign-owned by the XArray
abstraction.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/sync/arc.rs | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 8ae0fe6f19ec0..9b582a815f888 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -363,11 +363,17 @@ pub fn into_unique_or_drop(this: Self) -> Option<Pin<UniqueArc<T>>> {
 
 // SAFETY: The pointer returned by `into_foreign` was originally allocated as an
 // `KBox<ArcInner<T>>`, so that type is what determines the alignment.
-unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
+unsafe impl<T> ForeignOwnable for Arc<T> {
     const FOREIGN_ALIGN: usize = <KBox<ArcInner<T>> as ForeignOwnable>::FOREIGN_ALIGN;
 
-    type Borrowed<'a> = ArcBorrow<'a, T>;
-    type BorrowedMut<'a> = Self::Borrowed<'a>;
+    type Borrowed<'a>
+        = ArcBorrow<'a, T>
+    where
+        T: 'a;
+    type BorrowedMut<'a>
+        = Self::Borrowed<'a>
+    where
+        T: 'a;
 
     fn into_foreign(self) -> *mut c_void {
         ManuallyDrop::new(self).ptr.as_ptr().cast()

-- 
2.43.0


