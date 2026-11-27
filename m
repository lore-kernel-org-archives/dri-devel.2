Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2ED606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=efZ3tR0E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E037112CD8;
	Fri, 27 Nov 2026 18:02:15 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F7B112CD0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 18:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795802509; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DvIUp2PfjhQSJwYEKqs2qf4Lyjm/tI0OJK3Ck9x/Kk86AHUMIrI0vW5j3iU4HGSAcjs4iIouMT5AyonvpAfpXcng166tfKMmldEW8g2FGZvRgLDGkSUYaVYsbembZ1KrdS1yU8VuZe5aDAaoRD7qOeuAxvmkTDOWaABkNMlbnfU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795802509;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=X9yNAdzryjQKZhPZtoVlIkMprxCbQ4QtZxwb0ASsv/Q=; 
 b=VosvB8uJ0TdcxCWVlnPPLti3/x7pftFVNIaTcL4NAJkAr+WxBAaQACZz92E+F/yDpYTBXsgp1ZAvY1H0u8AhceDuX4Yq7qJWW1Ii1VGD0l52d3g7To99gGJedeoHrqYkAzkBOPIDQ1WKcsH/6z/kewkj2x0uiL4yBE7MjWqAQwg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=efZ3tR0EuGaeB5FMn2lIXygaOD4Fy+f8alKj4fyBzmiowMpOBkoBFMIQ+4jHfhYcWJ4PXNY0wJn9FvePGrsfzB3w9rwHZH2QtOE667hV9MhLg73/GmmxuHJ8meO3CZtWym9H59OUJVQBTdWBl2eXrIOSTFHD/lp2XPIbM4qpRHw=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=X9yNAdzryjQKZhPZtoVlIkMprxCbQ4QtZxwb0ASsv/Q=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795802508180997.6136186105167;
 Fri, 27 Nov 2026 10:01:48 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 15:01:38 -0300
Subject: [PATCH RESEND 2/3] drm/tyr: reject firmware sections that overlap
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-tyr-fw-parser-v1-2-8aab2a711f9b@collabora.com>
References: <20261127-tyr-fw-parser-v1-0-8aab2a711f9b@collabora.com>
In-Reply-To: <20261127-tyr-fw-parser-v1-0-8aab2a711f9b@collabora.com>
To: dakr@kernel.org, simona@ffwll.ch, airlied@gmail.com, aliceryhl@google.com
Cc: Sami Tolvanen <samitolvanen@google.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Firmware::new() maps each loadable section at the VA range given in its
section header. When two ranges overlap, GPUVM unmaps or splits the part
of the earlier mapping that the later one covers. The MCU then sees the
later section's pages there, and nothing reports the overlap.

Reject an image whose loadable sections overlap in FwParser::parse(),
and add a test for it.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/fw/parser.rs | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/parser.rs
index de5881f1bf47..133b63c5cff1 100644
--- a/drivers/gpu/drm/tyr/fw/parser.rs
+++ b/drivers/gpu/drm/tyr/fw/parser.rs
@@ -188,6 +188,18 @@ pub(super) fn parse(&mut self) -> Result<KVec<ParsedSection>> {
             let entry_section = self.parse_entry(header_end)?;
 
             if let Some(inner) = entry_section.inner {
+                if parsed_sections.iter().any(|other: &ParsedSection| {
+                    inner.va.start < other.va.end && other.va.start < inner.va.end
+                }) {
+                    dev_err!(
+                        self.cursor.dev,
+                        "Firmware virtual address range {:#x}..{:#x} overlaps another section",
+                        inner.va.start,
+                        inner.va.end
+                    );
+                    return Err(EINVAL);
+                }
+
                 parsed_sections.push(inner, GFP_KERNEL)?;
             }
         }
@@ -883,4 +895,29 @@ fn shared_region_not_shared() {
         image.entries[1].flags = SectionFlags::READ_MASK;
         assert_eq!(image.parse().err(), Some(EINVAL));
     }
+
+    /// Loadable sections with overlapping VA ranges are rejected.
+    #[test]
+    fn overlapping_sections() {
+        let mut image = Image::new();
+        // The second section is the page at `second`.
+        let second = image.entries[1].va.start;
+
+        // The first section ends where the second one starts.
+        image.entries[0].va = second - 0x1000..second;
+        assert!(image.parse().is_ok());
+
+        // The first section starts where the second one ends.
+        image.entries[0].va = second + 0x1000..second + 0x2000;
+        assert!(image.parse().is_ok());
+
+        // The first section covers the page below the second one and the second one.
+        image.entries[0].va = second - 0x1000..second + 0x1000;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+
+        // The second section covers three pages, and the first one is the page in the middle.
+        image.entries[0].va = second + 0x1000..second + 0x2000;
+        image.entries[1].va = second..second + 0x3000;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
 }

-- 
2.56.0

