Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98A1CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0DB10E991;
	Wed, 10 Jun 2026 13:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gcGj8kGG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF5F10E991
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 13:57:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 45C7741B31;
 Wed, 10 Jun 2026 13:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C47E1F00893;
 Wed, 10 Jun 2026 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781099878;
 bh=HGRHyYwNvn4lA0Xw14jdK/t3SL3DhcwG0SMCUKKzHYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
 b=gcGj8kGGaoZW0cb2H7hR5PvR5zrMsZrgY06XxR6FyMDiGvcyIjwMKNOys8POK025/
 EwdRSa7s3QfAdYcLr75FPXiGhd+H04eAHJLY1yilq/IvDeG8SZ7qJhyMVtQUxoRbco
 sPvcne0sAdQbM3ou7YPnWkFTudKQiQR2GzSiakD6mr0AWf8mGb5lxAtq4onNGk4ApW
 HVw6f/qZIoCtxziHzyq6fLcmzBlLtPIl2qUOvJGtSu3BbcxKPAtfG83qq+Zvn9+DHe
 W8qtOR8PLWtd44f9yCqMxSGUC5lLySofLntmHBDsRliqsYLiaimseFgxQoq+BxgmXk
 ucemmg/GJKfqQ==
From: Gary Guo <gary@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 2/2] gpu: nova-core: use `c"literal"` instead of `c_str!()`
Date: Wed, 10 Jun 2026 14:57:15 +0100
Message-ID: <20260610135716.1013688-2-gary@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610135716.1013688-1-gary@kernel.org>
References: <20260610135716.1013688-1-gary@kernel.org>
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
Reply-To: Gary Guo <gary@garyguo.net>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Gary Guo <gary@garyguo.net>

No functional changes intended.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/nova_core.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 9f0199f7b38c..735b8e17c6b6 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -54,7 +54,7 @@ struct NovaCoreModule {
 
 impl InPlaceModule for NovaCoreModule {
     fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
-        let dir = debugfs::Dir::new(kernel::c_str!("nova-core"));
+        let dir = debugfs::Dir::new(c"nova-core");
 
         // SAFETY: We are the only driver code running during init, so there
         // cannot be any concurrent access to `DEBUGFS_ROOT`.
-- 
2.54.0

