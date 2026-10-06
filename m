Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2865CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42A310E1CE;
	Tue,  6 Oct 2026 06:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FFTE6okV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE0710E0BB
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 06:55:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B96064182E;
 Tue,  6 Oct 2026 06:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26891F00893;
 Tue,  6 Oct 2026 06:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791269702;
 bh=kWfhtTsuBDzUJb00n8FTUxSmpeehi2Dw7Nxj3gMMr6Y=;
 h=From:To:Cc:Subject:Date;
 b=FFTE6okVVv2MKCisB77eJtQ8FbDuW2b1gka+r95Tks+CN10DiFUA0E02zOP+RE4Gz
 3dam7DUKthjxqVSVCd4YvvV+yMw94fQb1ORwjft1WTpSxbKODV98en2PbhiQFjiVK7
 DDTQw/rHk1XUNz60ofG1B83J/vvGz8dfRfr5MWWnYMbG8bX+2b6FJl2I+TrHTU9MUp
 ZypkBfEwY/YtRbdxX2XU+vIztzImtbh2Mv9rVxvSiK5Emvh+v8smGduqa4PW1gBEBZ
 rXB33n8hyTgK6wCv5fucEmpRqgFb4kHbN12CWdZ1rk89iRzTnhOINsdEqIlQbntwKg
 ix4jvTZWQ/ijw==
From: Thorsten Blum <blum@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Gary Guo <gary@garyguo.net>,
 Tim Kovalenko <tim.kovalenko@proton.me>
Cc: Thorsten Blum <blum@kernel.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: nova-core: fsp: use KVec::zeroed() in recv_msg()
Date: Tue,  6 Oct 2026 08:54:35 +0200
Message-ID: <20261006065437.58408-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=blum@kernel.org;
 h=from:subject; bh=Qn23wxiXez928e4XtpLbgNBHH4EiwBuPKrXVHQ82dos=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlHZuuea3j87Xqqu52FvOLURTP9b8cbvrm56qrM0trnT
 ru/aP/40lHKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATqX3CyPBO/NuLx1l58/Sm
 LFzCyxTIeuP+/39r1mZ6v3FfJbViJm8pw//09lff9+gk1dZWHtrnYK16capU61fV9unanCKpDsw
 T+XgA
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

Use KVec::zeroed() to create the message buffer in recv_msg() instead of
creating an empty vector and resizing it.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/gpu/nova-core/falcon/fsp.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 0437180b8829..4190f4f8e8c9 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -172,9 +172,7 @@ pub(crate) fn recv_msg(&mut self) -> Result<KVec<u8>> {
             return Err(EMSGSIZE);
         }
 
-        let mut buffer = KVec::<u8>::new();
-        buffer.resize(msg_size, 0, GFP_KERNEL)?;
-
+        let mut buffer = KVec::<u8>::zeroed(msg_size, GFP_KERNEL)?;
         self.read_emem(&mut buffer)?;
 
         // Reset message queue pointers after reading.
