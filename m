Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C3DFF8864
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DFA8825E;
	Mon, 27 Apr 2026 08:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="aQBo2uqy";
	dkim-atps=neutral
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01BF910E222
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1777277371; x=1777536571;
 bh=rgyZSowpv6J4bzf/vCMeteZ7S5Yz8QJusKYSp680fQ0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=aQBo2uqy2PDIrT3bspYpEYCKRwt1qqhtNmr9NmkMfcxUM6awp1QeV0fBCwn3CF2bb
 +xbwhHTYU7Jtf5bsBN0SuiRhyEW9TeCovKt5W6qKBJjdAB/uNCQD8uYbl0L2Us/SSb
 5XSjDyBdSdfjrOzoxMZJbX53BBWPCFiOzJM0RTQsmlcDZMDYE4pCP5t6ZOfg3o3mYj
 +9bEG2Y1oumerFXLQxvNnLDVzUQp4uw727ksroYd2X/tTYd3o6bsWqm+bRfIgo15QB
 4+i9yGaW+4lemPpxUeFL1/uqrCIkoRlbANU2aJnewd5sH0WMoTazaQIG6KUX8J87n3
 Xs5niiCpKAjNg==
X-Pm-Submission-Id: 4g3x6w3vHDz1DFFY
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com,
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com,
 alvin.sun@linux.dev
Subject: Re: [PATCH v4 12/20] drm/tyr: add parser for firmware binary
Date: Mon, 27 Apr 2026 11:09:25 +0300
Message-ID: <20260427080926.73950-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260424-b4-fw-boot-v4-v4-12-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <20260424-b4-fw-boot-v4-v4-12-a5d91050789d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 24 Apr 2026 16:39:06 -0700=0D
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:=0D
=0D
> From: Daniel Almeida <daniel.almeida@collabora.com>=0D
> =0D
> Add a parser for the Mali CSF GPU firmware binary format. The firmware=0D
> consists of a header followed by entries describing how to load firmware=
=0D
> sections into the MCU's memory.=0D
> =0D
> The parser extracts section metadata including virtual address ranges,=0D
> data byte offsets within the binary, and section flags controlling=0D
> permissions and cache modes. It validates the basic firmware structure=0D
> and alignment and ignores protected-mode sections for now.=0D
> =0D
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>=0D
> Co-developed-by: Beata Michalska <beata.michalska@arm.com>=0D
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>=0D
> Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>=0D
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>=0D
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>=0D
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>=0D
> ---=0D
>  drivers/gpu/drm/tyr/fw/parser.rs | 519 +++++++++++++++++++++++++++++++++=
++++++=0D
>  1 file changed, 519 insertions(+)=0D
> =0D
> diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/pa=
rser.rs=0D
> new file mode 100644=0D
> index 000000000000..638707430701=0D
> --- /dev/null=0D
> +++ b/drivers/gpu/drm/tyr/fw/parser.rs=0D
> @@ -0,0 +1,519 @@=0D
> +// SPDX-License-Identifier: GPL-2.0 or MIT=0D
> +=0D
> +//! Firmware binary parser for Mali CSF (Command Stream Frontend) GPU.=0D
> +//!=0D
> +//! This module implements a parser for the Mali GPU firmware binary for=
mat. The firmware=0D
> +//! file contains a header followed by a sequence of entries, each descr=
ibing how to load=0D
> +//! firmware sections into the MCU (Microcontroller Unit) memory. The pa=
rser extracts section metadata including:=0D
> +//! - Virtual address ranges where sections should be mapped=0D
> +//! - Data ranges (byte offsets) within the firmware binary=0D
> +//! - Section flags (permissions, cache modes)=0D
> +=0D
> +use core::{=0D
> +    mem::size_of,=0D
> +    ops::Range, //=0D
> +};=0D
> +=0D
> +use kernel::{=0D
> +    bits::bit_u32,=0D
> +    prelude::*,=0D
> +    str::CString, //=0D
> +};=0D
> +=0D
> +use crate::{=0D
> +    fw::{=0D
> +        SectionFlag,=0D
> +        SectionFlags,=0D
> +        CSF_MCU_SHARED_REGION_START, //=0D
> +    },=0D
> +    vm::{=0D
> +        VmFlag,=0D
> +        VmMapFlags, //=0D
> +    }, //=0D
> +};=0D
> +=0D
> +/// A parsed firmware section ready for loading into MCU memory.=0D
> +///=0D
> +/// Represents a single firmware section extracted from the firmware bin=
ary, containing=0D
> +/// all information needed to map the section's data into the MCU's virt=
ual address space.=0D
> +pub(super) struct ParsedSection {=0D
> +    /// Byte offset range within the firmware binary where this section'=
s data resides.=0D
> +    pub(super) data_range: Range<u32>,=0D
> +    /// MCU virtual address range where this section should be mapped.=0D
> +    pub(super) va: Range<u32>,=0D
> +    /// Memory protection and caching flags for the mapping.=0D
> +    pub(super) vm_map_flags: VmMapFlags,=0D
> +}=0D
> +=0D
> +/// A bare-bones `std::io::Cursor<[u8]>` clone to keep track of the curr=
ent position in the firmware binary.=0D
> +///=0D
> +/// Provides methods to sequentially read primitive types and byte array=
s from the firmware=0D
> +/// binary while maintaining the current read position.=0D
> +struct Cursor<'a> {=0D
> +    data: &'a [u8],=0D
> +    pos: usize,=0D
> +}=0D
> +=0D
> +impl<'a> Cursor<'a> {=0D
> +    fn new(data: &'a [u8]) -> Self {=0D
> +        Self { data, pos: 0 }=0D
> +    }=0D
> +=0D
> +    fn len(&self) -> usize {=0D
> +        self.data.len()=0D
> +    }=0D
> +=0D
> +    fn pos(&self) -> usize {=0D
> +        self.pos=0D
> +    }=0D
> +=0D
> +    /// Returns a view into the cursor's data.=0D
> +    ///=0D
> +    /// This spawns a new cursor, leaving the current cursor unchanged.=
=0D
> +    fn view(&self, range: Range<usize>) -> Result<Cursor<'_>> {=0D
> +        if range.start < self.pos || range.end > self.data.len() {=0D
> +            pr_err!(=0D
> +                "Invalid cursor range {:?} for data of length {}",=0D
> +                range,=0D
> +                self.data.len()=0D
> +            );=0D
> +=0D
> +            Err(EINVAL)=0D
> +        } else {=0D
> +            Ok(Self {=0D
> +                data: &self.data[range],=0D
> +                pos: 0,=0D
> +            })=0D
> +        }=0D
> +    }=0D
> +=0D
> +    /// Reads a slice of bytes from the current position and advances th=
e cursor.=0D
> +    ///=0D
> +    /// Returns an error if the read would exceed the data bounds.=0D
> +    fn read(&mut self, nbytes: usize) -> Result<&[u8]> {=0D
> +        let start =3D self.pos;=0D
> +        let end =3D start + nbytes;=0D
> +=0D
> +        if end > self.data.len() {=0D
> +            pr_err!(=0D
> +                "Invalid firmware file: read of size {} at position {} i=
s out of bounds",=0D
> +                nbytes,=0D
> +                start,=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        self.pos +=3D nbytes;=0D
> +        Ok(&self.data[start..end])=0D
> +    }=0D
> +=0D
> +    /// Reads a little-endian `u8` from the current position and advance=
s the cursor.=0D
> +    fn read_u8(&mut self) -> Result<u8> {=0D
> +        let bytes =3D self.read(size_of::<u8>())?;=0D
> +        Ok(bytes[0])=0D
> +    }=0D
> +=0D
> +    /// Reads a little-endian `u16` from the current position and advanc=
es the cursor.=0D
> +    fn read_u16(&mut self) -> Result<u16> {=0D
> +        let bytes =3D self.read(size_of::<u16>())?;=0D
> +        Ok(u16::from_le_bytes(bytes.try_into().unwrap()))=0D
> +    }=0D
> +=0D
> +    /// Reads a little-endian `u32` from the current position and advanc=
es the cursor.=0D
> +    fn read_u32(&mut self) -> Result<u32> {=0D
> +        let bytes =3D self.read(size_of::<u32>())?;=0D
> +        Ok(u32::from_le_bytes(bytes.try_into().unwrap()))=0D
> +    }=0D
> +=0D
> +    /// Advances the cursor position by the specified number of bytes.=0D
> +    ///=0D
> +    /// Returns an error if the advance would exceed the data bounds.=0D
> +    fn advance(&mut self, nbytes: usize) -> Result {=0D
> +        if self.pos + nbytes > self.data.len() {=0D
> +            pr_err!(=0D
> +                "Invalid firmware file: advance of size {} at position {=
} is out of bounds",=0D
> +                nbytes,=0D
> +                self.pos,=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +        self.pos +=3D nbytes;=0D
> +        Ok(())=0D
> +    }=0D
> +}=0D
> +=0D
> +/// Parser for Mali CSF GPU firmware binaries.=0D
> +///=0D
> +/// Parses the firmware binary format, extracting section metadata inclu=
ding virtual=0D
> +/// address ranges, data offsets, and memory protection flags needed to =
load firmware=0D
> +/// into the MCU's memory.=0D
> +pub(super) struct FwParser<'a> {=0D
> +    cursor: Cursor<'a>,=0D
> +}=0D
> +=0D
> +impl<'a> FwParser<'a> {=0D
> +    /// Creates a new firmware parser for the given firmware binary data=
.=0D
> +    pub(super) fn new(data: &'a [u8]) -> Self {=0D
> +        Self {=0D
> +            cursor: Cursor::new(data),=0D
> +        }=0D
> +    }=0D
> +=0D
> +    /// Parses the firmware binary and returns a collection of parsed se=
ctions.=0D
> +    ///=0D
> +    /// This method validates the firmware header and iterates through a=
ll entries=0D
> +    /// in the binary, extracting section information needed for loading=
.=0D
> +    pub(super) fn parse(&mut self) -> Result<KVec<ParsedSection>> {=0D
> +        let fw_header =3D self.parse_fw_header()?;=0D
> +=0D
> +        let mut parsed_sections =3D KVec::new();=0D
> +        while (self.cursor.pos() as u32) < fw_header.size {=0D
> +            let entry_section =3D self.parse_entry()?;=0D
> +=0D
> +            if let Some(inner) =3D entry_section.inner {=0D
> +                parsed_sections.push(inner, GFP_KERNEL)?;=0D
> +            }=0D
> +        }=0D
> +=0D
> +        Ok(parsed_sections)=0D
> +    }=0D
> +=0D
> +    fn parse_fw_header(&mut self) -> Result<FirmwareHeader> {=0D
> +        let fw_header: FirmwareHeader =3D match FirmwareHeader::new(&mut=
 self.cursor) {=0D
> +            Ok(fw_header) =3D> fw_header,=0D
> +            Err(e) =3D> {=0D
> +                pr_err!("Invalid firmware file: {}", e.to_errno());=0D
> +                return Err(e);=0D
> +            }=0D
> +        };=0D
> +=0D
> +        if fw_header.size > self.cursor.len() as u32 {=0D
> +            pr_err!("Firmware image is truncated");=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +        Ok(fw_header)=0D
> +    }=0D
> +=0D
> +    fn parse_entry(&mut self) -> Result<EntrySection> {=0D
> +        let entry_section =3D EntrySection {=0D
> +            entry_hdr: EntryHeader(self.cursor.read_u32()?),=0D
> +            inner: None,=0D
> +        };=0D
> +=0D
> +        if self.cursor.pos() % size_of::<u32>() !=3D 0=0D
> +            || entry_section.entry_hdr.size() as usize % size_of::<u32>(=
) !=3D 0=0D
> +        {=0D
> +            pr_err!(=0D
> +                "Firmware entry isn't 32 bit aligned, offset=3D{:#x} siz=
e=3D{:#x}\n",=0D
> +                self.cursor.pos() - size_of::<u32>(),=0D
> +                entry_section.entry_hdr.size()=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        let section_hdr_size =3D entry_section.entry_hdr.size() as usize=
 - size_of::<EntryHeader>();=0D
> +=0D
> +        let entry_section =3D {=0D
> +            let mut entry_cursor =3D self=0D
> +                .cursor=0D
> +                .view(self.cursor.pos()..self.cursor.pos() + section_hdr=
_size)?;=0D
> +=0D
> +            match entry_section.entry_hdr.entry_type() {=0D
> +                Ok(EntryType::Iface) =3D> Ok(EntrySection {=0D
> +                    entry_hdr: entry_section.entry_hdr,=0D
> +                    inner: Self::parse_section_entry(&mut entry_cursor)?=
,=0D
> +                }),=0D
> +                Ok(=0D
> +                    EntryType::Config=0D
> +                    | EntryType::FutfTest=0D
> +                    | EntryType::TraceBuffer=0D
> +                    | EntryType::TimelineMetadata=0D
> +                    | EntryType::BuildInfoMetadata,=0D
> +                ) =3D> Ok(entry_section),=0D
> +=0D
> +                entry_type =3D> {=0D
> +                    if entry_type.is_err() || !entry_section.entry_hdr.o=
ptional() {=0D
> +                        if !entry_section.entry_hdr.optional() {=0D
> +                            pr_err!(=0D
> +                                "Failed to handle firmware entry type: {=
}\n",=0D
> +                                entry_type=0D
> +                                    .map_or(entry_section.entry_hdr.entr=
y_type_raw(), |e| e as u8)=0D
> +                            );=0D
> +                            Err(EINVAL)=0D
> +                        } else {=0D
> +                            Ok(entry_section)=0D
> +                        }=0D
> +                    } else {=0D
> +                        Ok(entry_section)=0D
> +                    }=0D
> +                }=0D
> +            }=0D
> +        };=0D
> +=0D
> +        if entry_section.is_ok() {=0D
> +            self.cursor.advance(section_hdr_size)?;=0D
> +        }=0D
> +=0D
> +        entry_section=0D
> +    }=0D
> +=0D
> +    fn parse_section_entry(entry_cursor: &mut Cursor<'_>) -> Result<Opti=
on<ParsedSection>> {=0D
> +        let section_hdr: SectionHeader =3D SectionHeader::new(entry_curs=
or)?;=0D
> +=0D
> +        if section_hdr.data.end < section_hdr.data.start {=0D
> +            pr_err!(=0D
> +                "Firmware corrupted, data.end < data.start (0x{:x} < 0x{=
:x})\n",=0D
> +                section_hdr.data.end,=0D
> +                section_hdr.data.start=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        if section_hdr.va.end < section_hdr.va.start {=0D
> +            pr_err!(=0D
> +                "Firmware corrupted, section_hdr.va.end < section_hdr.va=
.start (0x{:x} < 0x{:x})\n",=0D
> +                section_hdr.va.end,=0D
> +                section_hdr.va.start=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        if section_hdr.section_flags.contains(SectionFlag::Prot) {=0D
> +            pr_info!("Firmware protected mode entry not supported, ignor=
ing");=0D
> +            return Ok(None);=0D
> +        }=0D
> +=0D
> +        if section_hdr.va.start =3D=3D CSF_MCU_SHARED_REGION_START=0D
> +            && !section_hdr.section_flags.contains(SectionFlag::Shared)=
=0D
> +        {=0D
> +            pr_err!(=0D
> +                "Interface at 0x{:x} must be shared",=0D
> +                CSF_MCU_SHARED_REGION_START=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        let name_len =3D entry_cursor.len() - entry_cursor.pos();=0D
> +        let name_bytes =3D entry_cursor.read(name_len)?;=0D
> +=0D
> +        let mut name =3D KVec::with_capacity(name_bytes.len() + 1, GFP_K=
ERNEL)?;=0D
> +        name.extend_from_slice(name_bytes, GFP_KERNEL)?;=0D
> +        name.push(0, GFP_KERNEL)?;=0D
> +=0D
> +        let _name =3D CStr::from_bytes_with_nul(&name)=0D
> +            .ok()=0D
> +            .and_then(|name| CString::try_from(name).ok());=0D
> +=0D
> +        let cache_mode =3D section_hdr.section_flags.cache_mode();=0D
> +        let mut vm_map_flags =3D VmMapFlags::empty();=0D
> +=0D
> +        if !section_hdr.section_flags.contains(SectionFlag::Write) {=0D
> +            vm_map_flags |=3D VmFlag::Readonly;=0D
> +        }=0D
> +        if !section_hdr.section_flags.contains(SectionFlag::Exec) {=0D
> +            vm_map_flags |=3D VmFlag::Noexec;=0D
> +        }=0D
> +        if cache_mode !=3D SectionFlag::CacheModeCached.into() {=0D
> +            vm_map_flags |=3D VmFlag::Uncached;=0D
> +        }=0D
> +=0D
> +        Ok(Some(ParsedSection {=0D
> +            data_range: section_hdr.data.clone(),=0D
> +            va: section_hdr.va,=0D
> +            vm_map_flags,=0D
> +        }))=0D
> +    }=0D
> +}=0D
> +=0D
> +/// Firmware binary header containing version and size information.=0D
> +///=0D
> +/// The header is located at the beginning of the firmware binary and co=
ntains=0D
> +/// a magic value for validation, version information, and the total siz=
e of=0D
> +/// all structured headers that follow.=0D
> +#[expect(dead_code)]=0D
> +struct FirmwareHeader {=0D
> +    /// Magic value to check binary validity.=0D
> +    magic: u32,=0D
> +=0D
> +    /// Minor firmware version.=0D
> +    minor: u8,=0D
> +=0D
> +    /// Major firmware version.=0D
> +    major: u8,=0D
> +=0D
> +    /// Padding. Must be set to zero.=0D
> +    _padding1: u16,=0D
> +=0D
> +    /// Firmware version hash.=0D
> +    version_hash: u32,=0D
> +=0D
> +    /// Padding. Must be set to zero.=0D
> +    _padding2: u32,=0D
> +=0D
> +    /// Total size of all the structured data headers at beginning of fi=
rmware binary.=0D
> +    size: u32,=0D
> +}=0D
> +=0D
> +impl FirmwareHeader {=0D
> +    const FW_BINARY_MAGIC: u32 =3D 0xc3f13a6e;=0D
> +    const FW_BINARY_MAJOR_MAX: u8 =3D 0;=0D
> +=0D
> +    /// Reads and validates a firmware header from the cursor.=0D
> +    ///=0D
> +    /// Verifies the magic value, version compatibility, and padding fie=
lds.=0D
> +    fn new(cursor: &mut Cursor<'_>) -> Result<Self> {=0D
> +        let magic =3D cursor.read_u32()?;=0D
> +        if magic !=3D Self::FW_BINARY_MAGIC {=0D
> +            pr_err!("Invalid firmware magic");=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        let minor =3D cursor.read_u8()?;=0D
> +        let major =3D cursor.read_u8()?;=0D
> +=0D
> +        if major > Self::FW_BINARY_MAJOR_MAX {=0D
> +            pr_err!(=0D
> +                "Unsupported firmware binary header version {}.{} (expec=
ted {}.x)\n",=0D
> +                major,=0D
> +                minor,=0D
> +                Self::FW_BINARY_MAJOR_MAX=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        let padding1 =3D cursor.read_u16()?;=0D
> +        let version_hash =3D cursor.read_u32()?;=0D
> +        let padding2 =3D cursor.read_u32()?;=0D
> +        let size =3D cursor.read_u32()?;=0D
> +=0D
> +        if padding1 !=3D 0 || padding2 !=3D 0 {=0D
> +            pr_err!("Invalid firmware file: header padding is not zero")=
;=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        let fw_header =3D Self {=0D
> +            magic,=0D
> +            minor,=0D
> +            major,=0D
> +            _padding1: padding1,=0D
> +            version_hash,=0D
> +            _padding2: padding2,=0D
=0D
nit: I would write it like this:=0D
=0D
	_padding1: 0,=0D
	version_hash,=0D
	_padding2: 0,=0D
=0D
to be more explicit.=0D
=0D
> +            size,=0D
> +        };=0D
> +=0D
> +        Ok(fw_header)=0D
> +    }=0D
> +}=0D
> +=0D
> +/// Firmware section header for loading binary sections into MCU memory.=
=0D
> +#[derive(Debug)]=0D
> +struct SectionHeader {=0D
> +    section_flags: SectionFlags,=0D
> +    /// MCU virtual range to map this binary section to.=0D
> +    va: Range<u32>,=0D
> +    /// References the data in the FW binary.=0D
> +    data: Range<u32>,=0D
> +}=0D
> +=0D
> +impl SectionHeader {=0D
> +    /// Reads and validates a section header from the cursor.=0D
> +    ///=0D
> +    /// Parses section flags, virtual address range, and data range from=
 the firmware binary.=0D
> +    fn new(cursor: &mut Cursor<'_>) -> Result<Self> {=0D
> +        let section_flags =3D cursor.read_u32()?;=0D
> +        let section_flags =3D SectionFlags::try_from(section_flags)?;=0D
> +=0D
> +        let va_start =3D cursor.read_u32()?;=0D
> +        let va_end =3D cursor.read_u32()?;=0D
> +=0D
> +        let va =3D va_start..va_end;=0D
> +=0D
> +        if va.is_empty() {=0D
> +            pr_err!(=0D
> +                "Invalid firmware file: empty VA range at pos {}\n",=0D
> +                cursor.pos(),=0D
> +            );=0D
> +            return Err(EINVAL);=0D
> +        }=0D
> +=0D
> +        let data_start =3D cursor.read_u32()?;=0D
> +        let data_end =3D cursor.read_u32()?;=0D
> +        let data =3D data_start..data_end;=0D
> +=0D
> +        Ok(Self {=0D
> +            section_flags,=0D
> +            va,=0D
> +            data,=0D
> +        })=0D
> +    }=0D
> +}=0D
> +=0D
> +/// A firmware entry containing a header and optional parsed section dat=
a.=0D
> +///=0D
> +/// Represents a single entry in the firmware binary, which may contain =
loadable=0D
> +/// section data or metadata that doesn't require loading.=0D
> +struct EntrySection {=0D
> +    entry_hdr: EntryHeader,=0D
> +    inner: Option<ParsedSection>,=0D
> +}=0D
> +=0D
> +/// Header for a firmware entry, packed into a single u32.=0D
> +///=0D
> +/// The entry header encodes the entry type, size, and optional flag in =
a=0D
> +/// 32-bit value with the following layout:=0D
> +/// - Bits 0-7: Entry type=0D
> +/// - Bits 8-15: Size in bytes=0D
> +/// - Bit 31: Optional flag=0D
> +struct EntryHeader(u32);=0D
> +=0D
> +impl EntryHeader {=0D
> +    fn entry_type_raw(&self) -> u8 {=0D
> +        (self.0 & 0xff) as u8=0D
> +    }=0D
> +=0D
> +    fn entry_type(&self) -> Result<EntryType> {=0D
> +        let v =3D self.entry_type_raw();=0D
> +        EntryType::try_from(v)=0D
> +    }=0D
> +=0D
> +    fn optional(&self) -> bool {=0D
> +        self.0 & bit_u32(31) !=3D 0=0D
> +    }=0D
> +=0D
> +    fn size(&self) -> u32 {=0D
> +        self.0 >> 8 & 0xff=0D
> +    }=0D
> +}=0D
> +=0D
> +#[derive(Clone, Copy, Debug)]=0D
> +#[repr(u8)]=0D
> +enum EntryType {=0D
> +    /// Host <-> FW interface.=0D
> +    Iface =3D 0,=0D
> +    /// FW config.=0D
> +    Config =3D 1,=0D
> +    /// Unit tests.=0D
> +    FutfTest =3D 2,=0D
> +    /// Trace buffer interface.=0D
> +    TraceBuffer =3D 3,=0D
> +    /// Timeline metadata interface.=0D
> +    TimelineMetadata =3D 4,=0D
> +    /// Metadata about how the FW binary was built.=0D
> +    BuildInfoMetadata =3D 6,=0D
> +}=0D
> +=0D
> +impl TryFrom<u8> for EntryType {=0D
> +    type Error =3D Error;=0D
> +=0D
> +    fn try_from(value: u8) -> Result<Self, Self::Error> {=0D
> +        match value {=0D
> +            0 =3D> Ok(EntryType::Iface),=0D
> +            1 =3D> Ok(EntryType::Config),=0D
> +            2 =3D> Ok(EntryType::FutfTest),=0D
> +            3 =3D> Ok(EntryType::TraceBuffer),=0D
> +            4 =3D> Ok(EntryType::TimelineMetadata),=0D
> +            6 =3D> Ok(EntryType::BuildInfoMetadata),=0D
> +            _ =3D> Err(EINVAL),=0D
> +        }=0D
> +    }=0D
> +}=0D
> =0D
> -- =0D
> 2.53.0=0D
> =0D
