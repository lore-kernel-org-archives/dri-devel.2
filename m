Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6D606A31F
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=SIWnw434
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5702210E4F1;
	Sat, 28 Nov 2026 09:41:01 +0000 (UTC)
X-Greylist: delayed 379 seconds by postgrey-1.36 at gabe;
 Fri, 27 Nov 2026 12:48:32 UTC
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243DA112A97
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sU
 vRVtw8ImDh3X9R69Cm1MAr63hHzccbWqjyDbR8Clk=; b=SIWnw434uR+3Pz6Vxe
 C4IriJwH6VIZcoanpu8l5Vt/QNlIWsyiFHqNMxIjTtA82buj4NUfzD8Z3+ChwR5T
 4c9kGl9qYdNyqcSid+MXSBav6CUM87V7c5h+aOmJHpCHfmdeyheMLmwZviXmWrtN
 9H4K8v+oNxjvr2CmZxK/g3VM4=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wDnN5N+eglr4NvRDQ--.48926S2; 
 Fri, 27 Nov 2026 20:41:38 +0800 (CST)
From: Bilal Hashim <AeeSec@126.com>
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bilal Hashim <AeeSec@126.com>
Subject: [PATCH] drm/tyr: fw: fix integer overflow and inverted range check in
 Cursor
Date: Fri, 27 Nov 2026 20:41:07 +0800
Message-ID: <20261127124107.1782-1-AeeSec@126.com>
X-Mailer: git-send-email 2.47.0.windows.2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnN5N+eglr4NvRDQ--.48926S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw48GF1DZFW8ZrWDurWfKrg_yoW5JF43pF
 43G34vy3y7Ka1rur1jkF17JFyUZw17Za10yFW3Aw4kCr13KrykG3y5KF9a9ry7A3sxJw13
 tay29ay7KrWkZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziXAw3UUUUU=
X-CM-SenderInfo: 5dhh2vbf6rjloofrz/xtbBrQPbdmsJeoOxCAAA3h
X-Mailman-Approved-At: Sat, 28 Nov 2026 09:41:00 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In drivers/gpu/drm/tyr/fw/parser.rs, the firmware binary parser `Cursor`
has two bounds-checking bugs that can panic the kernel on malformed
firmware images:

1. `Cursor::view()` checks `range.start < self.pos || range.end >
   self.data.len()`, but does not check `range.start > range.end`. An
   inverted range passes the check and panics when indexing
   `&self.data[range]`.
2. `Cursor::read()` and `Cursor::advance()` compute `self.pos + nbytes`
   without overflow checking. On 32-bit systems (or with large `nbytes`),
   the addition can wrap around to a value less than `self.data.len()`,
   bypassing the bounds check and panicking in `&self.data[start..end]`
   or corrupting `self.pos`.

Use `checked_add()` in `read()` and `advance()`, and reject inverted
ranges (`range.start > range.end`) in `view()`.

Signed-off-by: Bilal Hashim <AeeSec@126.com>
---
--- a/drivers/gpu/drm/tyr/fw/parser.rs
+++ b/drivers/gpu/drm/tyr/fw/parser.rs
@@ -75,7 +75,7 @@ impl<'a> Cursor<'a> {
     ///
     /// This spawns a new cursor, leaving the current cursor unchanged.
     fn view(&self, range: Range<usize>) -> Result<Cursor<'_>> {
-        if range.start < self.pos || range.end > self.data.len() {
+        if range.start > range.end || range.start < self.pos || range.end > self.data.len() {
             dev_err!(
                 self.dev,
                 "Invalid cursor range {:?} for data of length {}",
@@ -98,9 +98,9 @@ impl<'a> Cursor<'a> {
     /// Returns an error if the read would exceed the data bounds.
     fn read(&mut self, nbytes: usize) -> Result<&[u8]> {
         let start = self.pos;
-        let end = start + nbytes;
+        let end = start.checked_add(nbytes);
 
-        if end > self.data.len() {
+        let Some(end) = end.filter(|&e| e <= self.data.len()) else {
             dev_err!(
                 self.dev,
                 "Invalid firmware file: read of size {} at position {} is out of bounds",
@@ -108,9 +108,9 @@ impl<'a> Cursor<'a> {
                 start,
             );
             return Err(EINVAL);
-        }
+        };
 
-        self.pos += nbytes;
+        self.pos = end;
         Ok(&self.data[start..end])
     }
 
@@ -144,7 +144,7 @@ impl<'a> Cursor<'a> {
     ///
     /// Returns an error if the advance would exceed the data bounds.
     fn advance(&mut self, nbytes: usize) -> Result {
-        if self.pos + nbytes > self.data.len() {
+        let Some(end) = self.pos.checked_add(nbytes).filter(|&e| e <= self.data.len()) else {
             dev_err!(
                 self.dev,
                 "Invalid firmware file: advance of size {} at position {} is out of bounds",
@@ -152,8 +152,8 @@ impl<'a> Cursor<'a> {
                 self.pos,
             );
             return Err(EINVAL);
-        }
-        self.pos += nbytes;
+        };
+        self.pos = end;
         Ok(())
     }
 }

