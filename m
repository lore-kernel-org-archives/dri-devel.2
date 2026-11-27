Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FBF606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=crdBkrSy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04875112CD3;
	Fri, 27 Nov 2026 18:02:02 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA94112CC7
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 18:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795802507; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cy/lfqUj8n+pkVMAHu0twOg+fk/TgBdmDxHfKFOKz+qZXZOe8wxuFSl5j43Muo3sqETTHqrkDKvssOfq5ov6aFclxBsxD6aTjfpmhFjo6Cv5yaPYnblBlYBRw0H9tbsQLUKFXcmwANL/REVp2d7RQ1LQNksDjcQyAEyTdXS9O1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795802507;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=O5n3RY0LIssaQxNS1HOM3Xrt87DdGm2tM0uOFOF8AnE=; 
 b=NnHry3+i3VvWC31bCZLdbr+GvcBryQac4xbEUuhwNPLb+ZFmEkjnSsyr1zdwGwf1WJoURnyAi0DLxRrul/v4c4wvbSueu5vwMG5v0p8hm4A/s/JhVXIO1TfPLbMGg9aWvvOFL7fhzM6dL4Rx2sCNK3HhvBYejo2r+cdxTPdhXq8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=crdBkrSyHF8dv0TIFvRAYuqE78gJ2zUQcFtZwnqZ71RbmbYwSg6F8ZhgiK7DDIjhZqvXBGIUg0K3NDd1LUahIXgsd82THvLtn1Z9U/EIOvHzlWlafbtvSz/Q34/57LxJIUgpxXBo2agwhevm3GA3EvkR40wQ47Evq4+TeZOjaqg=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=O5n3RY0LIssaQxNS1HOM3Xrt87DdGm2tM0uOFOF8AnE=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795802505646560.0662479829062;
 Fri, 27 Nov 2026 10:01:45 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 15:01:37 -0300
Subject: [PATCH RESEND 1/3] drm/tyr: add KUnit tests for the firmware
 parser
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-tyr-fw-parser-v1-1-8aab2a711f9b@collabora.com>
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

The firmware parser checks the header and the entries of the firmware
file before Tyr maps the sections into the MCU VM. The files in
linux-firmware pass all of these checks and no test feeds the parser a
malformed file, so nothing exercises its error paths.

The parser does not touch the hardware, which lets KUnit run it on
images built in memory. Add the tyr_fw_parser suite. It builds an image
from named fields, checks that a well-formed image parses into its
sections, and checks that malformed images are rejected.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/fw/parser.rs | 298 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 298 insertions(+)

diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/parser.rs
index c4d0ad1d7899..de5881f1bf47 100644
--- a/drivers/gpu/drm/tyr/fw/parser.rs
+++ b/drivers/gpu/drm/tyr/fw/parser.rs
@@ -586,3 +586,301 @@ fn try_from(value: u8) -> Result<Self, Self::Error> {
         }
     }
 }
+
+#[kunit_tests(tyr_fw_parser)]
+mod tests {
+    use super::*;
+
+    use kernel::faux;
+
+    /// Appends little-endian values to a firmware image.
+    struct Writer(KVec<u8>);
+
+    impl Writer {
+        fn write_u8(&mut self, value: u8) -> Result {
+            self.0.push(value, GFP_KERNEL)?;
+            Ok(())
+        }
+
+        fn write_u16(&mut self, value: u16) -> Result {
+            self.0.extend_from_slice(&value.to_le_bytes(), GFP_KERNEL)?;
+            Ok(())
+        }
+
+        fn write_u32(&mut self, value: u32) -> Result {
+            self.0.extend_from_slice(&value.to_le_bytes(), GFP_KERNEL)?;
+            Ok(())
+        }
+    }
+
+    /// A firmware image with two entries.
+    ///
+    /// It has a field for each value that a test changes. [`Image::to_bytes()`] writes the other
+    /// values as zero.
+    struct Image {
+        magic: u32,
+        major: u8,
+        /// The padding after the version hash.
+        padding: u32,
+        /// Size of the firmware header and the entries, in bytes.
+        header_size: u32,
+        entries: [Entry; 2],
+        /// Size of the section data after the entries, in bytes.
+        data_size: u32,
+    }
+
+    /// An entry of an [`Image`].
+    struct Entry {
+        entry_type: u8,
+        /// Size of the entry, in bytes.
+        size: u8,
+        flags: u32,
+        va: Range<u32>,
+        data: Range<u32>,
+    }
+
+    impl Image {
+        /// Returns a well-formed image of 72 bytes.
+        ///
+        /// The first section has 4 bytes of data. The second section is at the start of the shared
+        /// region.
+        fn new() -> Self {
+            Self {
+                magic: FirmwareHeader::FW_BINARY_MAGIC,
+                major: 0,
+                padding: 0,
+                // A firmware header of 20 bytes and two entries of 24 bytes.
+                header_size: 68,
+                entries: [
+                    Entry {
+                        // An interface entry.
+                        entry_type: 0,
+                        // An entry header of 4 bytes and a section header of 20 bytes.
+                        size: 24,
+                        flags: SectionFlags::READ_MASK,
+                        va: 0x0..0x1000,
+                        data: 68..72,
+                    },
+                    Entry {
+                        entry_type: 0,
+                        size: 24,
+                        flags: SectionFlags::READ_MASK | SectionFlags::SHARED_MASK,
+                        va: CSF_MCU_SHARED_REGION_START..CSF_MCU_SHARED_REGION_START + 0x1000,
+                        data: 72..72,
+                    },
+                ],
+                data_size: 4,
+            }
+        }
+
+        /// Writes the headers in the order in which the parser reads them, followed by the data.
+        fn to_bytes(&self) -> Result<KVec<u8>> {
+            let minor = 0;
+            let padding1 = 0;
+            let version_hash = 0;
+
+            let mut w = Writer(KVec::new());
+
+            w.write_u32(self.magic)?;
+            w.write_u8(minor)?;
+            w.write_u8(self.major)?;
+            w.write_u16(padding1)?;
+            w.write_u32(version_hash)?;
+            w.write_u32(self.padding)?;
+            w.write_u32(self.header_size)?;
+
+            for entry in &self.entries {
+                // The entry header has the type in bits 7:0 and the size in bits 15:8.
+                w.write_u32(u32::from(entry.entry_type) | (u32::from(entry.size) << 8))?;
+
+                w.write_u32(entry.flags)?;
+                w.write_u32(entry.va.start)?;
+                w.write_u32(entry.va.end)?;
+                w.write_u32(entry.data.start)?;
+                w.write_u32(entry.data.end)?;
+            }
+
+            for _ in 0..self.data_size {
+                w.write_u8(0)?;
+            }
+
+            Ok(w.0)
+        }
+
+        /// Writes the image and parses it.
+        fn parse(&self) -> Result<KVec<ParsedSection>> {
+            parse_bytes(&self.to_bytes()?)
+        }
+    }
+
+    /// Parses a firmware image.
+    fn parse_bytes(image: &[u8]) -> Result<KVec<ParsedSection>> {
+        let reg = faux::Registration::new(c"tyr-fw-parser-kunit", None)?;
+
+        FwParser::new(reg.as_ref().as_ref(), image).parse()
+    }
+
+    /// The well-formed image parses into one section for each entry.
+    #[test]
+    fn well_formed_image() -> Result {
+        let image = Image::new();
+        let sections = image.parse()?;
+
+        assert_eq!(sections.len(), image.entries.len());
+        for (section, entry) in sections.iter().zip(&image.entries) {
+            assert_eq!(section.va, entry.va);
+            assert_eq!(section.data_range, entry.data);
+        }
+
+        Ok(())
+    }
+
+    /// A file that ends inside the firmware header is rejected.
+    #[test]
+    fn truncated_firmware_header() -> Result {
+        let image = Image::new().to_bytes()?;
+
+        // The first 16 of the 20 bytes of the firmware header.
+        assert_eq!(parse_bytes(&image[..16]).err(), Some(EINVAL));
+
+        Ok(())
+    }
+
+    /// A file with the wrong magic is rejected.
+    #[test]
+    fn wrong_magic() {
+        let mut image = Image::new();
+        image.magic = 0;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// A major version other than 0 is rejected.
+    #[test]
+    fn unsupported_major_version() {
+        let mut image = Image::new();
+        image.major = 1;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// Padding after the version hash that is not zero is rejected.
+    #[test]
+    fn nonzero_padding() {
+        let mut image = Image::new();
+        image.padding = 1;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// Headers that are larger than the file are rejected.
+    #[test]
+    fn headers_larger_than_file() {
+        let mut image = Image::new();
+        // The file is 72 bytes long.
+        image.header_size = 76;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// An image with no loadable section is rejected.
+    #[test]
+    fn no_loadable_section() {
+        let mut image = Image::new();
+        // The headers end with the firmware header.
+        image.header_size = 20;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// Headers that end inside an entry header are rejected.
+    #[test]
+    fn truncated_entry_header() {
+        let mut image = Image::new();
+        // The entries end at byte 68. A third entry header would end at byte 72.
+        image.header_size = 70;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// An entry that is smaller than its own header is rejected.
+    #[test]
+    fn entry_smaller_than_its_header() {
+        let mut image = Image::new();
+        image.entries[0].size = 0;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// An entry with a size that is not a multiple of 4 is rejected.
+    #[test]
+    fn unaligned_entry_size() {
+        let mut image = Image::new();
+        // The second entry is 25 bytes long, and the headers end where it ends.
+        image.entries[1].size = 25;
+        image.header_size = 69;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// An entry that ends past the headers is rejected.
+    #[test]
+    fn entry_larger_than_headers() {
+        let mut image = Image::new();
+        // The first entry starts at byte 20. It now ends at byte 72, 4 bytes past the headers.
+        image.entries[0].size = 52;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// An entry of an unknown type that is not optional is rejected.
+    #[test]
+    fn unknown_entry_type() {
+        let mut image = Image::new();
+        image.entries[0].entry_type = 0xff;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// Section flags that the driver does not know are rejected.
+    #[test]
+    fn unknown_section_flags() {
+        let mut image = Image::new();
+        // Bit 6 is not a section flag.
+        image.entries[0].flags = 1 << 6;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// A VA range that ends before it starts is rejected.
+    #[test]
+    fn section_va_end_before_start() {
+        let mut image = Image::new();
+        // The VA range ends at 0x1000.
+        image.entries[0].va.start = 0x2000;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// Section data that ends before it starts is rejected.
+    #[test]
+    fn section_data_end_before_start() {
+        let mut image = Image::new();
+        // The data starts at byte 68.
+        image.entries[0].data.end = 64;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// Section data that ends past the file is rejected.
+    #[test]
+    fn section_data_past_end_of_file() {
+        let mut image = Image::new();
+        // The file is 72 bytes long.
+        image.entries[0].data.end = 76;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// A VA range that is not page aligned is rejected.
+    #[test]
+    fn section_va_not_page_aligned() {
+        let mut image = Image::new();
+        image.entries[0].va.start = 0x800;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+
+    /// A section at the start of the shared region that is not shared is rejected.
+    #[test]
+    fn shared_region_not_shared() {
+        let mut image = Image::new();
+        image.entries[1].flags = SectionFlags::READ_MASK;
+        assert_eq!(image.parse().err(), Some(EINVAL));
+    }
+}

-- 
2.56.0

