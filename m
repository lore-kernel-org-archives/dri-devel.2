Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B332606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJHfTTi6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1AC10F038;
	Mon, 26 Oct 2026 16:41:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529A910F026
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:41:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D35443DF6;
 Mon, 26 Oct 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793032874;
 b=b/CKrsVAT/b1SZUNT+uEcm0MmCl1ye7CGj0SaK3ijJgJ/QbaARPolCFp8VeqFSLubntr
 GNcVFR49GOAqAt2uThuC6PvhGZzeeVpOOK2lmhv6plQ37ZYBoFNyzNLLnLacXC8pgygIT
 52NG3B/QXMt+gZLC0paOsLfT/CYrUP9WWVMBHFM6VkmqkJSdUYvRvOTCXZABQr2dszsVQ
 NPSzHFUsPm5ytcPNelPcvmWvRKYjedNs7Dpt1qjruGhPCbUf/FfAeGfSIG7dQISVob4r9
 xsSrY0k3wbAKBWL3GfBCVEPKOYOXzBI0BzfWXxWutFUA7GcQ5/EY+5pxnKr/UJchdFw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032874;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=jPxyRVxUkD8Td+9QwNyvaWaSg+CRoePkY9b5UHxne8c=;
 b=OLC+6eQHJhxt3ho/9+L73HRcDlnjLW1ZsWduLMnzC/cu6vGgwYIpbijQR7J8tDyVYRqf
 SfZ8zio2poYBsTTXxBx96XTqKRr7MEmVOPmbZPdTdt6yOtiElGDD0PIK7d5n+C/aIm+y7
 2UdSIo8ckaHMMWh3WuXjIA2Hb7Mdjq/XCRiv9jY0vxJwd7IlrspMKmNKoBx8KvfUxP2UB
 gSrk5qOwOdzXfaHDW4s7to87lsqDSMnPovfgw4Eggy6MTdeiGnQEtTVHXCsmirT2W7zXc
 Tv+1CEathWD6uoR0M9byRmxfIjlHjA40fyBO6uJInNfc9Gex/2Pt8zZ7nDBvOK5iJjQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id DBA9C1F031E0;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793032874;
 bh=jPxyRVxUkD8Td+9QwNyvaWaSg+CRoePkY9b5UHxne8c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=RJHfTTi6vfr1qmU4HBARtkQuo3mprmtwNAaMcWxQ4NWoHQ3Y5vM5XDkHX1yoB/yjA
 h01mlA0PRxWXiQmWAjA8lb5nYvbj5yd33wkudow1WRqJ+77DlNvzC2gGp60TE6dbV9
 Hrc2XGMpYpOYHSUMI+kR1FXgWMN3p3rd7NTD7hlWEDxo3XAfnWklU5q9IkwAI02eOv
 KsmGk2Xw3+uLa7pKEtPa3XOp3+awGqcxFbNbm/yb5y/eAfyAyUT81SRqrEois8Xg5I
 Id3D33MLPmKbUl+nVq5n+k1rofRU+YI+8y2FFvpj21uigauvPBuvIbUPQrt2G780rW
 bDcBX87tIwpig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 61E5E44DCD;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Tue, 27 Oct 2026 00:40:56 +0800
Subject: [PATCH v5 03/11] rust: sync: arc: relax `ForeignOwnable` for `Arc<T>`
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-tyr-ioctls-v5-3-59dfe98cb003@kylinos.cn>
References: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
In-Reply-To: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
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
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793032870; l=1389;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=E65clxOu/qjNbqNDrRBBfaWHB/W/gvw7JStoVkgnAT4=;
 b=OuJ11WJeh+RTO5A+UnE6Z62IEeZ7bfDvHeR9vBre58ENq5srwGFZMjbo6AfdON1Wem0+woS/l
 dyWuNRlyKyCDl78DBCx6ah0cAAnlHREJsX69X5O9L/9F0RA4djDQzzc
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


