Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24F1F531D9
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F4910E547;
	Mon, 13 Apr 2026 22:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="Whkcs+Cz";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F82410E54E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776119527; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=njAXZMpBVU2bPhiSAmt0y3yy5v0tvjvjrySCD2EgfWmPiyCYt73D3KWHTDgFVV17bj2Mg/ymB6x4oZmXBvfK4ecAbFlDDtQy5sBy97GZtmD2SyP79c0wXRhVz24fe0AsLvKSLmix0vRltDuz2EuH3RspEUzO04rHt0gT5ZxCtoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776119527;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KcHukzoU8dcgpz87NrenhC9DZ76DzADTeyvlOzIcL9c=; 
 b=dewnemAeopVeWQUkwgTfvTThoy5hvSsIiuJRBNfC9eAQPH5uB2Zsrj6cm/Mthu3a0lE0LEQVOzTUFhzK38lIJGisB25P21lH3n1EGmNmLrEvCaO9gn6FxwD7SU8pXGSmF4JIvYI2TN+b2zGdU3k5PXJHAwJoadca0uoC7vcDvMQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776119527; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=KcHukzoU8dcgpz87NrenhC9DZ76DzADTeyvlOzIcL9c=;
 b=Whkcs+CzqXAupsdgi4of014avOq2X4mRYUhBJcGNydz0CGestcpZhGuPjSClpLIe
 1Mms/BWhLHv72WJ5aIpueog800oIo6dtCE5qu7JVsmkMC8o24TOx46k//oKvBN0i5i4
 IF0F5ft1aR3u/OIgIZEbIHt0VRrTA5HzV6iNNj68=
Received: by mx.zohomail.com with SMTPS id 1776119525866948.4350674528085;
 Mon, 13 Apr 2026 15:32:05 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 13 Apr 2026 15:31:47 -0700
Subject: [PATCH v3 12/13] drm/tyr: add parser for firmware binary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-fw-boot-v3-v3-12-b422f3c03885@collabora.com>
References: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
In-Reply-To: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=18286;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=b9k99QVltbqyD/Fe9rFI5rWsmu3CuqkqbOW+iRrxeO4=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl3865yT3be3vPpQl9C4GTN0xfqosJjn99sLN64QO6Po
 5+h1XevjlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACaSdoXhf1XezU/ppzm3/7jn
 p3a6MmnrH6aE7e3vNCKjm0KMPQ22STL8L3p3387P8mpvnf+MBzteX+g5/WXOxZtrpKMsjj/PvnI
 xihsA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

From: Daniel Almeida <daniel.almeida@collabora.com>

Add a parser for the Mali CSF GPU firmware binary format. The firmware
consists of a header followed by entries describing how to load firmware
sections into the MCU's memory.

The parser extracts section metadata including virtual address ranges,
data byte offsets within the binary, and section flags controlling
permissions and cache modes. It validates the basic firmware structure
and alignment and ignores protected-mode sections for now.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/fw/parser.rs | 519 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 519 insertions(+)

diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/parser.rs
new file mode 100644
index 000000000000..638707430701
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw/parser.rs
@@ -0,0 +1,519 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Firmware binary parser for Mali CSF (Command Stream Frontend) GPU.
+//!
+//! This module implements a parser for the Mali GPU firmware binary format. The firmware
+//! file contains a header followed by a sequence of entries, each describing how to load
+//! firmware sections into the MCU (Microcontroller Unit) memory. The parser extracts section metadata including:
+//! - Virtual address ranges where sections should be mapped
+//! - Data ranges (byte offsets) within the firmware binary
+//! - Section flags (permissions, cache modes)
+
+use core::{
+    mem::size_of,
+    ops::Range, //
+};
+
+use kernel::{
+    bits::bit_u32,
+    prelude::*,
+    str::CString, //
+};
+
+use crate::{
+    fw::{
+        SectionFlag,
+        SectionFlags,
+        CSF_MCU_SHARED_REGION_START, //
+    },
+    vm::{
+        VmFlag,
+        VmMapFlags, //
+    }, //
+};
+
+/// A parsed firmware section ready for loading into MCU memory.
+///
+/// Represents a single firmware section extracted from the firmware binary, containing
+/// all information needed to map the section's data into the MCU's virtual address space.
+pub(super) struct ParsedSection {
+    /// Byte offset range within the firmware binary where this section's data resides.
+    pub(super) data_range: Range<u32>,
+    /// MCU virtual address range where this section should be mapped.
+    pub(super) va: Range<u32>,
+    /// Memory protection and caching flags for the mapping.
+    pub(super) vm_map_flags: VmMapFlags,
+}
+
+/// A bare-bones `std::io::Cursor<[u8]>` clone to keep track of the current position in the firmware binary.
+///
+/// Provides methods to sequentially read primitive types and byte arrays from the firmware
+/// binary while maintaining the current read position.
+struct Cursor<'a> {
+    data: &'a [u8],
+    pos: usize,
+}
+
+impl<'a> Cursor<'a> {
+    fn new(data: &'a [u8]) -> Self {
+        Self { data, pos: 0 }
+    }
+
+    fn len(&self) -> usize {
+        self.data.len()
+    }
+
+    fn pos(&self) -> usize {
+        self.pos
+    }
+
+    /// Returns a view into the cursor's data.
+    ///
+    /// This spawns a new cursor, leaving the current cursor unchanged.
+    fn view(&self, range: Range<usize>) -> Result<Cursor<'_>> {
+        if range.start < self.pos || range.end > self.data.len() {
+            pr_err!(
+                "Invalid cursor range {:?} for data of length {}",
+                range,
+                self.data.len()
+            );
+
+            Err(EINVAL)
+        } else {
+            Ok(Self {
+                data: &self.data[range],
+                pos: 0,
+            })
+        }
+    }
+
+    /// Reads a slice of bytes from the current position and advances the cursor.
+    ///
+    /// Returns an error if the read would exceed the data bounds.
+    fn read(&mut self, nbytes: usize) -> Result<&[u8]> {
+        let start = self.pos;
+        let end = start + nbytes;
+
+        if end > self.data.len() {
+            pr_err!(
+                "Invalid firmware file: read of size {} at position {} is out of bounds",
+                nbytes,
+                start,
+            );
+            return Err(EINVAL);
+        }
+
+        self.pos += nbytes;
+        Ok(&self.data[start..end])
+    }
+
+    /// Reads a little-endian `u8` from the current position and advances the cursor.
+    fn read_u8(&mut self) -> Result<u8> {
+        let bytes = self.read(size_of::<u8>())?;
+        Ok(bytes[0])
+    }
+
+    /// Reads a little-endian `u16` from the current position and advances the cursor.
+    fn read_u16(&mut self) -> Result<u16> {
+        let bytes = self.read(size_of::<u16>())?;
+        Ok(u16::from_le_bytes(bytes.try_into().unwrap()))
+    }
+
+    /// Reads a little-endian `u32` from the current position and advances the cursor.
+    fn read_u32(&mut self) -> Result<u32> {
+        let bytes = self.read(size_of::<u32>())?;
+        Ok(u32::from_le_bytes(bytes.try_into().unwrap()))
+    }
+
+    /// Advances the cursor position by the specified number of bytes.
+    ///
+    /// Returns an error if the advance would exceed the data bounds.
+    fn advance(&mut self, nbytes: usize) -> Result {
+        if self.pos + nbytes > self.data.len() {
+            pr_err!(
+                "Invalid firmware file: advance of size {} at position {} is out of bounds",
+                nbytes,
+                self.pos,
+            );
+            return Err(EINVAL);
+        }
+        self.pos += nbytes;
+        Ok(())
+    }
+}
+
+/// Parser for Mali CSF GPU firmware binaries.
+///
+/// Parses the firmware binary format, extracting section metadata including virtual
+/// address ranges, data offsets, and memory protection flags needed to load firmware
+/// into the MCU's memory.
+pub(super) struct FwParser<'a> {
+    cursor: Cursor<'a>,
+}
+
+impl<'a> FwParser<'a> {
+    /// Creates a new firmware parser for the given firmware binary data.
+    pub(super) fn new(data: &'a [u8]) -> Self {
+        Self {
+            cursor: Cursor::new(data),
+        }
+    }
+
+    /// Parses the firmware binary and returns a collection of parsed sections.
+    ///
+    /// This method validates the firmware header and iterates through all entries
+    /// in the binary, extracting section information needed for loading.
+    pub(super) fn parse(&mut self) -> Result<KVec<ParsedSection>> {
+        let fw_header = self.parse_fw_header()?;
+
+        let mut parsed_sections = KVec::new();
+        while (self.cursor.pos() as u32) < fw_header.size {
+            let entry_section = self.parse_entry()?;
+
+            if let Some(inner) = entry_section.inner {
+                parsed_sections.push(inner, GFP_KERNEL)?;
+            }
+        }
+
+        Ok(parsed_sections)
+    }
+
+    fn parse_fw_header(&mut self) -> Result<FirmwareHeader> {
+        let fw_header: FirmwareHeader = match FirmwareHeader::new(&mut self.cursor) {
+            Ok(fw_header) => fw_header,
+            Err(e) => {
+                pr_err!("Invalid firmware file: {}", e.to_errno());
+                return Err(e);
+            }
+        };
+
+        if fw_header.size > self.cursor.len() as u32 {
+            pr_err!("Firmware image is truncated");
+            return Err(EINVAL);
+        }
+        Ok(fw_header)
+    }
+
+    fn parse_entry(&mut self) -> Result<EntrySection> {
+        let entry_section = EntrySection {
+            entry_hdr: EntryHeader(self.cursor.read_u32()?),
+            inner: None,
+        };
+
+        if self.cursor.pos() % size_of::<u32>() != 0
+            || entry_section.entry_hdr.size() as usize % size_of::<u32>() != 0
+        {
+            pr_err!(
+                "Firmware entry isn't 32 bit aligned, offset={:#x} size={:#x}\n",
+                self.cursor.pos() - size_of::<u32>(),
+                entry_section.entry_hdr.size()
+            );
+            return Err(EINVAL);
+        }
+
+        let section_hdr_size = entry_section.entry_hdr.size() as usize - size_of::<EntryHeader>();
+
+        let entry_section = {
+            let mut entry_cursor = self
+                .cursor
+                .view(self.cursor.pos()..self.cursor.pos() + section_hdr_size)?;
+
+            match entry_section.entry_hdr.entry_type() {
+                Ok(EntryType::Iface) => Ok(EntrySection {
+                    entry_hdr: entry_section.entry_hdr,
+                    inner: Self::parse_section_entry(&mut entry_cursor)?,
+                }),
+                Ok(
+                    EntryType::Config
+                    | EntryType::FutfTest
+                    | EntryType::TraceBuffer
+                    | EntryType::TimelineMetadata
+                    | EntryType::BuildInfoMetadata,
+                ) => Ok(entry_section),
+
+                entry_type => {
+                    if entry_type.is_err() || !entry_section.entry_hdr.optional() {
+                        if !entry_section.entry_hdr.optional() {
+                            pr_err!(
+                                "Failed to handle firmware entry type: {}\n",
+                                entry_type
+                                    .map_or(entry_section.entry_hdr.entry_type_raw(), |e| e as u8)
+                            );
+                            Err(EINVAL)
+                        } else {
+                            Ok(entry_section)
+                        }
+                    } else {
+                        Ok(entry_section)
+                    }
+                }
+            }
+        };
+
+        if entry_section.is_ok() {
+            self.cursor.advance(section_hdr_size)?;
+        }
+
+        entry_section
+    }
+
+    fn parse_section_entry(entry_cursor: &mut Cursor<'_>) -> Result<Option<ParsedSection>> {
+        let section_hdr: SectionHeader = SectionHeader::new(entry_cursor)?;
+
+        if section_hdr.data.end < section_hdr.data.start {
+            pr_err!(
+                "Firmware corrupted, data.end < data.start (0x{:x} < 0x{:x})\n",
+                section_hdr.data.end,
+                section_hdr.data.start
+            );
+            return Err(EINVAL);
+        }
+
+        if section_hdr.va.end < section_hdr.va.start {
+            pr_err!(
+                "Firmware corrupted, section_hdr.va.end < section_hdr.va.start (0x{:x} < 0x{:x})\n",
+                section_hdr.va.end,
+                section_hdr.va.start
+            );
+            return Err(EINVAL);
+        }
+
+        if section_hdr.section_flags.contains(SectionFlag::Prot) {
+            pr_info!("Firmware protected mode entry not supported, ignoring");
+            return Ok(None);
+        }
+
+        if section_hdr.va.start == CSF_MCU_SHARED_REGION_START
+            && !section_hdr.section_flags.contains(SectionFlag::Shared)
+        {
+            pr_err!(
+                "Interface at 0x{:x} must be shared",
+                CSF_MCU_SHARED_REGION_START
+            );
+            return Err(EINVAL);
+        }
+
+        let name_len = entry_cursor.len() - entry_cursor.pos();
+        let name_bytes = entry_cursor.read(name_len)?;
+
+        let mut name = KVec::with_capacity(name_bytes.len() + 1, GFP_KERNEL)?;
+        name.extend_from_slice(name_bytes, GFP_KERNEL)?;
+        name.push(0, GFP_KERNEL)?;
+
+        let _name = CStr::from_bytes_with_nul(&name)
+            .ok()
+            .and_then(|name| CString::try_from(name).ok());
+
+        let cache_mode = section_hdr.section_flags.cache_mode();
+        let mut vm_map_flags = VmMapFlags::empty();
+
+        if !section_hdr.section_flags.contains(SectionFlag::Write) {
+            vm_map_flags |= VmFlag::Readonly;
+        }
+        if !section_hdr.section_flags.contains(SectionFlag::Exec) {
+            vm_map_flags |= VmFlag::Noexec;
+        }
+        if cache_mode != SectionFlag::CacheModeCached.into() {
+            vm_map_flags |= VmFlag::Uncached;
+        }
+
+        Ok(Some(ParsedSection {
+            data_range: section_hdr.data.clone(),
+            va: section_hdr.va,
+            vm_map_flags,
+        }))
+    }
+}
+
+/// Firmware binary header containing version and size information.
+///
+/// The header is located at the beginning of the firmware binary and contains
+/// a magic value for validation, version information, and the total size of
+/// all structured headers that follow.
+#[expect(dead_code)]
+struct FirmwareHeader {
+    /// Magic value to check binary validity.
+    magic: u32,
+
+    /// Minor firmware version.
+    minor: u8,
+
+    /// Major firmware version.
+    major: u8,
+
+    /// Padding. Must be set to zero.
+    _padding1: u16,
+
+    /// Firmware version hash.
+    version_hash: u32,
+
+    /// Padding. Must be set to zero.
+    _padding2: u32,
+
+    /// Total size of all the structured data headers at beginning of firmware binary.
+    size: u32,
+}
+
+impl FirmwareHeader {
+    const FW_BINARY_MAGIC: u32 = 0xc3f13a6e;
+    const FW_BINARY_MAJOR_MAX: u8 = 0;
+
+    /// Reads and validates a firmware header from the cursor.
+    ///
+    /// Verifies the magic value, version compatibility, and padding fields.
+    fn new(cursor: &mut Cursor<'_>) -> Result<Self> {
+        let magic = cursor.read_u32()?;
+        if magic != Self::FW_BINARY_MAGIC {
+            pr_err!("Invalid firmware magic");
+            return Err(EINVAL);
+        }
+
+        let minor = cursor.read_u8()?;
+        let major = cursor.read_u8()?;
+
+        if major > Self::FW_BINARY_MAJOR_MAX {
+            pr_err!(
+                "Unsupported firmware binary header version {}.{} (expected {}.x)\n",
+                major,
+                minor,
+                Self::FW_BINARY_MAJOR_MAX
+            );
+            return Err(EINVAL);
+        }
+
+        let padding1 = cursor.read_u16()?;
+        let version_hash = cursor.read_u32()?;
+        let padding2 = cursor.read_u32()?;
+        let size = cursor.read_u32()?;
+
+        if padding1 != 0 || padding2 != 0 {
+            pr_err!("Invalid firmware file: header padding is not zero");
+            return Err(EINVAL);
+        }
+
+        let fw_header = Self {
+            magic,
+            minor,
+            major,
+            _padding1: padding1,
+            version_hash,
+            _padding2: padding2,
+            size,
+        };
+
+        Ok(fw_header)
+    }
+}
+
+/// Firmware section header for loading binary sections into MCU memory.
+#[derive(Debug)]
+struct SectionHeader {
+    section_flags: SectionFlags,
+    /// MCU virtual range to map this binary section to.
+    va: Range<u32>,
+    /// References the data in the FW binary.
+    data: Range<u32>,
+}
+
+impl SectionHeader {
+    /// Reads and validates a section header from the cursor.
+    ///
+    /// Parses section flags, virtual address range, and data range from the firmware binary.
+    fn new(cursor: &mut Cursor<'_>) -> Result<Self> {
+        let section_flags = cursor.read_u32()?;
+        let section_flags = SectionFlags::try_from(section_flags)?;
+
+        let va_start = cursor.read_u32()?;
+        let va_end = cursor.read_u32()?;
+
+        let va = va_start..va_end;
+
+        if va.is_empty() {
+            pr_err!(
+                "Invalid firmware file: empty VA range at pos {}\n",
+                cursor.pos(),
+            );
+            return Err(EINVAL);
+        }
+
+        let data_start = cursor.read_u32()?;
+        let data_end = cursor.read_u32()?;
+        let data = data_start..data_end;
+
+        Ok(Self {
+            section_flags,
+            va,
+            data,
+        })
+    }
+}
+
+/// A firmware entry containing a header and optional parsed section data.
+///
+/// Represents a single entry in the firmware binary, which may contain loadable
+/// section data or metadata that doesn't require loading.
+struct EntrySection {
+    entry_hdr: EntryHeader,
+    inner: Option<ParsedSection>,
+}
+
+/// Header for a firmware entry, packed into a single u32.
+///
+/// The entry header encodes the entry type, size, and optional flag in a
+/// 32-bit value with the following layout:
+/// - Bits 0-7: Entry type
+/// - Bits 8-15: Size in bytes
+/// - Bit 31: Optional flag
+struct EntryHeader(u32);
+
+impl EntryHeader {
+    fn entry_type_raw(&self) -> u8 {
+        (self.0 & 0xff) as u8
+    }
+
+    fn entry_type(&self) -> Result<EntryType> {
+        let v = self.entry_type_raw();
+        EntryType::try_from(v)
+    }
+
+    fn optional(&self) -> bool {
+        self.0 & bit_u32(31) != 0
+    }
+
+    fn size(&self) -> u32 {
+        self.0 >> 8 & 0xff
+    }
+}
+
+#[derive(Clone, Copy, Debug)]
+#[repr(u8)]
+enum EntryType {
+    /// Host <-> FW interface.
+    Iface = 0,
+    /// FW config.
+    Config = 1,
+    /// Unit tests.
+    FutfTest = 2,
+    /// Trace buffer interface.
+    TraceBuffer = 3,
+    /// Timeline metadata interface.
+    TimelineMetadata = 4,
+    /// Metadata about how the FW binary was built.
+    BuildInfoMetadata = 6,
+}
+
+impl TryFrom<u8> for EntryType {
+    type Error = Error;
+
+    fn try_from(value: u8) -> Result<Self, Self::Error> {
+        match value {
+            0 => Ok(EntryType::Iface),
+            1 => Ok(EntryType::Config),
+            2 => Ok(EntryType::FutfTest),
+            3 => Ok(EntryType::TraceBuffer),
+            4 => Ok(EntryType::TimelineMetadata),
+            6 => Ok(EntryType::BuildInfoMetadata),
+            _ => Err(EINVAL),
+        }
+    }
+}

-- 
2.53.0

