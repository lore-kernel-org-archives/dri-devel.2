Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118B7CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 11:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53AFA10E029;
	Tue,  6 Oct 2026 11:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LNqUMrpZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CD210E023
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 11:53:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C024B6022C;
 Tue,  6 Oct 2026 11:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB03D1F000FF;
 Tue,  6 Oct 2026 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791287635;
 bh=pm06+NkcSQVhTckq2o+B0jIj5R0QdwE0Dppd+dgufN8=;
 h=From:To:Cc:Subject:Date;
 b=LNqUMrpZgBVOLJSZ/W/MvA4gaS5eLGfbM29hyELkMy+C5gL5fIj5/sPuiqbsz8aih
 9qgYrjPfyC56shoPoNkk9g2LjskPA9VsvwCaA06BAMQ2Wq4tCxRRxFa/lmGSP79d40
 KZG2pz9bEKE9qjcnB8tiHaUiRsT3kFM0DoTrIqM16un8ROE/XYT9+QSkekALTXLSPb
 S+9ZPun9DMuNdGc2pbrEwyqXU4KKAIvkSd3QG89YJCnjpuIijhArElc5rKbsHpNZrV
 ZT5kfam8A7V2HNBUDeBv1gcrCX8MUtK+lO8bPjkP4hWPrtM1qM+goOMZAAaPEXtStX
 n8tb3ZBR1R83g==
From: Thorsten Blum <blum@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eliot Courtney <ecourtney@nvidia.com>,
 Gary Guo <gary@garyguo.net>
Cc: Thorsten Blum <blum@kernel.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: nova-core: gsp: use KVVec::zeroed() for payload buffers
Date: Tue,  6 Oct 2026 13:53:06 +0200
Message-ID: <20261006115311.92873-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=blum@kernel.org;
 h=from:subject; bh=VetweA1aMKnwvp/z6U6ngiU40fTiotUsT0isaYLH2nU=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlHHqpfm9o2s1SW41RCvNtzc4OZK9ed9M3b7zqP06r87
 tW1ByKndZSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEntsyMryLCCg+cU22NvP3
 /SN7Li282nR136Q5XhvuBvzeorBkyqMljAwX5jv53jeXUeh3NdnItW/miuMLok6XW/NaK82Os5E
 sf8UNAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
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

Use KVVec::zeroed() instead of KVVec::from_elem() to allocate and
zero-initialize the command and continuation payload buffers.

Also use KVVec::zeroed() in the test helper read_payload().

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/gpu/nova-core/gsp/cmdq/continuation.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq/continuation.rs b/drivers/gpu/nova-core/gsp/cmdq/continuation.rs
index 05e904f18097..9ef19f28de97 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/continuation.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/continuation.rs
@@ -106,9 +106,9 @@ pub(super) fn new(command: C) -> Result<Self> {
 
         if command.size() > MAX_CMD_SIZE {
             let mut command_payload =
-                KVVec::<u8>::from_elem(0u8, payload_len.min(Self::MAX_FIRST_PAYLOAD), GFP_KERNEL)?;
+                KVVec::zeroed(payload_len.min(Self::MAX_FIRST_PAYLOAD), GFP_KERNEL)?;
             let mut continuation_payload =
-                KVVec::<u8>::from_elem(0u8, payload_len - command_payload.len(), GFP_KERNEL)?;
+                KVVec::zeroed(payload_len - command_payload.len(), GFP_KERNEL)?;
             let mut sbuffer = SBufferIter::new_writer([
                 command_payload.as_mut_slice(),
                 continuation_payload.as_mut_slice(),
@@ -235,7 +235,7 @@ fn init_variable_payload(
 
     fn read_payload(cmd: impl CommandToGsp) -> Result<KVVec<u8>> {
         let len = cmd.variable_payload_len();
-        let mut buf = KVVec::from_elem(0u8, len, GFP_KERNEL)?;
+        let mut buf = KVVec::zeroed(len, GFP_KERNEL)?;
         let mut sbuf = SBufferIter::new_writer([buf.as_mut_slice(), &mut []]);
         cmd.init_variable_payload(&mut sbuf)?;
         drop(sbuf);
