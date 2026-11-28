Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC4606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=nyZX6+Nq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBE410E50D;
	Sat, 28 Nov 2026 09:41:01 +0000 (UTC)
X-Greylist: delayed 47862 seconds by postgrey-1.36 at gabe;
 Sat, 28 Nov 2026 02:02:08 UTC
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD6B10E6F1
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 02:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qO
 sfYdl2fZw6R1RRVzY5eBqAX2mNgq4GFjIvwLEGdYc=; b=nyZX6+Nq57XxLLhtg/
 rwOUf/jRKY9HAs+0N1cHpHL1jVGW16iMzBXvUuzkAmgiAPinGI4cNpgOgt1/LLgS
 bdVRtCfAGwM+9+5jwxpEFgX2gfrP12VOG5kZo5TZVzB6PPf5JzMt5rdOASWL9+32
 OMmzVO/NR6dTsOaEfzp8+ygZE=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wD3F+oBNgprou_QDw--.19088S2; 
 Sat, 28 Nov 2026 10:01:40 +0800 (CST)
From: Bilal Hashim <AeeSec@126.com>
To: Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bilal Hashim <AeeSec@126.com>
Subject: [PATCH v2] drm/tyr: fw: harden Cursor bounds checks
Date: Sat, 28 Nov 2026 10:01:08 +0800
Message-ID: <20261128020108.834-1-AeeSec@126.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20261127171532.2097157-1-aliceryhl@google.com>
References: <20261127171532.2097157-1-aliceryhl@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3F+oBNgprou_QDw--.19088S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryUWw1xWr48Xw1kAryUtrb_yoW8KFyUpr
 43G34vy3yUK3yF9r1UKF1xJF1UZw13Xa10gF43Aws5Cw13Kr1DGryUKFySkF9rZr93Jw1a
 ya9YvayxK3ykZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_kucrUUUUU=
X-CM-SenderInfo: 5dhh2vbf6rjloofrz/xtbBrQTrhmsKNgRmQwAA3y
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

In drivers/gpu/drm/tyr/fw/parser.rs, `Cursor` currently relies on its
callers to uphold non-inverted ranges and non-overflowing sizes:

1. `Cursor::view()` checks `range.start < self.pos || range.end >
   self.data.len()`, without checking `range.start > range.end`.
2. `Cursor::read()` and `Cursor::advance()` compute `self.pos + nbytes`
   without `checked_add()`.

Although current private callers in `parser.rs` already uphold these
preconditions, make `Cursor`'s bounds checks self-contained as defensive
hardening by rejecting inverted ranges in `view()` and using
`checked_add()` in `read()` and `advance()`.

Signed-off-by: Bilal Hashim <AeeSec@126.com>
---
Changes in v2:
- Reword commit message to describe this as defensive hardening rather
  than a reachable kernel panic (per Alice Ryhl).
- Format `advance()` with `rustfmt`.
---
--- a/drivers/gpu/drm/tyr/fw/parser.rs
+++ b/drivers/gpu/drm/tyr/fw/parser.rs
@@ -75,7 +75,7 @@
     ///
     /// This spawns a new cursor, leaving the current cursor unchanged.
     fn view(&self, range: Range<usize>) -> Result<Cursor<'_>> {
-        if range.start < self.pos || range.end > self.data.len() {
+        if range.start > range.end || range.start < self.pos || range.end > self.data.len() {
             dev_err!(
                 self.dev,
                 "Invalid cursor range {:?} for data of length {}",
@@ -98,9 +98,9 @@
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
@@ -108,9 +108,9 @@
                 start,
             );
             return Err(EINVAL);
-        }
+        };
 
-        self.pos += nbytes;
+        self.pos = end;
         Ok(&self.data[start..end])
     }
 
@@ -144,7 +144,11 @@
     ///
     /// Returns an error if the advance would exceed the data bounds.
     fn advance(&mut self, nbytes: usize) -> Result {
-        if self.pos + nbytes > self.data.len() {
+        let Some(end) = self
+            .pos
+            .checked_add(nbytes)
+            .filter(|&e| e <= self.data.len())
+        else {
             dev_err!(
                 self.dev,
                 "Invalid firmware file: advance of size {} at position {} is out of bounds",
@@ -152,8 +156,8 @@
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

