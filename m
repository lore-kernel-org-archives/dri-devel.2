Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB738606A33B
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emGqIgl6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BAB10E8CA;
	Tue, 24 Nov 2026 12:30:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE78D10E8CA
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:30:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CEE0D625E9;
 Tue, 24 Nov 2026 12:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102861F000D3;
 Tue, 24 Nov 2026 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523430;
 bh=hCaz85cDFZY8PRCRoBf6lstsxdUOIDLvnMndMBusOQ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=emGqIgl6jBZd3OPnc+B72Xls/N/I1ZRcUX53W23ZEvDwm3nmXTWN0eCvwcmL+HTge
 +Y+uuSYuzplq6ja7r+KaYGI6dNVrp13G3g8LFqD5+7LgFjeWGy6rS1M7Cm1eJxbdVW
 vGiaFJLzGV7VvgzBwSD5Fg+HbccBRaoaaJ4YCqUHlETQzwbFFGvU0u3vWi4LBsEm/1
 9OEtA8FqpehGgjXnE2jsbTPlyRmQbAMc8UE3qGxLA2QC7euAJz5ZJQgkEowk92n1VH
 8WZV8GHlqhQqQrhsLoDvkBQMMYDoxgJ8LGfx7SlyA76eIQNcfJwrE+RbXvqZud1DAE
 28g76d37T5QhA==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 01/10] rust: rcu: Add get_state_synchronize_rcu()
Date: Tue, 24 Nov 2026 13:29:43 +0100
Message-ID: <20261124122951.878199-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124122951.878199-2-phasta@kernel.org>
References: <20261124122951.878199-2-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some users don't want to perform a full call to synchronize_rcu() if it
is avoidable.

Add abstractions for get_state_synchronize_rcu() to obtain a grace
period identifier.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/sync/rcu.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index 0daa1ac87d81..7afc78b34759 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -86,3 +86,13 @@ pub fn synchronize_rcu() {
     // SAFETY: `synchronize_rcu()` is always safe to be called from process context.
     unsafe { bindings::synchronize_rcu() };
 }
+
+/// Obtain a cookie identifying a grace period.
+///
+/// Returns an identifier that can be used by other functions to check whether
+/// a specific grace period has passed already.
+#[inline]
+pub fn get_state_synchronize_rcu() -> usize {
+    // SAFETY: `get_state_synchronize_rcu()` is always safe to be called.
+    unsafe { bindings::get_state_synchronize_rcu() }
+}
-- 
2.56.0

