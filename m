Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726F3C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D466110E697;
	Tue, 14 Jul 2026 03:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KoK0pQTn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9776910E697
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:28:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0449B601DE;
 Tue, 14 Jul 2026 03:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448D61F000E9;
 Tue, 14 Jul 2026 03:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783999696;
 bh=0HL2eS8ApuX1T9gHcmE3hxAgA0PdADqHlfvuIT3EsQQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KoK0pQTnvxVfpPDq2mRvnKMpQ+EZnNNmIqK9E1L/Ji+6/T+n0ZnWJFPPYZ0ZES3h4
 SsSogLZeO1ZKZhdihFyX9HxFsjQ3vsfZN9BYmrDh/AJgxYEb0cJnPzousYE2pjPFh+
 cQPqvNTZEElg5K4Zxz84gkhNcq0maQTJxOOK9VJ+tY/Vz8upaIuxTVehpOEHQ7DzGD
 wT7Xdcq8W6JqZlAN1800oVtBeCrHEEpH0jkOHtYxFZy5e7UeFTdBrb+MTheoc4enH8
 9dzew30+FOtTZJu5frIvfmYfGKgp9AxJMIIOanwiPUP1qE2AQo86N91kfro9zvhE3C
 hO08+TG4BcdVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/7] drm/tyr: add parser for firmware binary
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260713-fw-boot-b4-v7-6-afd8dc1494dd@collabora.com>
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
 <20260713-fw-boot-b4-v7-6-afd8dc1494dd@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 03:28:15 +0000
Message-Id: <20260714032816.448D61F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Integer underflow when parsing a firmware entry with size 0, leadi=
ng to a kernel panic.
- [High] Missing validation of firmware data offsets against the binary siz=
e.
- [Low] Unnecessary memory allocations and string parsing for the section n=
ame which is immediately discarded.
- [Low] Redundant and unreachable virtual address range validation check.
--

--- Patch [6]: [PATCH v7 6/7] drm/tyr: add parser for firmware binary ---
commit e96b99b53f7521bb5685e37e8217c78b4047a1ee
Author: Daniel Almeida <daniel.almeida@collabora.com>

drm/tyr: add parser for firmware binary
   =20
Add a parser for the Mali CSF GPU firmware binary format. The firmware
consists of a header followed by entries describing how to load firmware
sections into the MCU's memory.

> diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/pa=
rser.rs
> new file mode 100644
> index 0000000000000..198a754b294f4
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw/parser.rs

[ ... ]

> +    fn parse_entry(&mut self) -> Result<EntrySection> {
> +        let entry_section =3D EntrySection {
> +            entry_hdr: EntryHeader(self.cursor.read_u32()?),
> +            inner: None,
> +        };
> +
> +        if self.cursor.pos() % size_of::<u32>() !=3D 0
> +            || entry_section.entry_hdr.size() as usize % size_of::<u32>(=
) !=3D 0
> +        {
> +            pr_err!(
> +                "Firmware entry isn't 32 bit aligned, offset=3D{:#x} siz=
e=3D{:#x}\n",
> +                self.cursor.pos() - size_of::<u32>(),
> +                entry_section.entry_hdr.size()
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let section_hdr_size =3D entry_section.entry_hdr.size() as usize=
 - size_of::<EntryHeader>();

[Severity: High]
If a firmware entry has a size of 0, will this subtraction underflow?

If entry_hdr.size() is 0, the alignment check earlier in FwParser::parse_en=
try()
passes since 0 % 4 =3D=3D 0. This subtraction would then wrap around to a v=
ery
large value.

When this underflowed value is added to self.cursor.pos(), it can wrap
around to a value smaller than the current position, creating a range where
range.start > range.end. When Cursor::view() receives this range, the slice
operation &self.data[range] will unconditionally panic, leading to a kernel
crash.

Should there be a check to ensure entry_hdr.size() is at least
size_of::<EntryHeader>()?

> +
> +        let entry_section =3D {
> +            let mut entry_cursor =3D self
> +                .cursor
> +                .view(self.cursor.pos()..self.cursor.pos() + section_hdr=
_size)?;

[ ... ]

> +    fn parse_section_entry(entry_cursor: &mut Cursor<'_>) -> Result<Opti=
on<ParsedSection>> {
> +        let section_hdr: SectionHeader =3D SectionHeader::new(entry_curs=
or)?;
> +
> +        if section_hdr.data.end < section_hdr.data.start {
> +            pr_err!(
> +                "Firmware corrupted, data.end < data.start (0x{:x} < 0x{=
:x})\n",
> +                section_hdr.data.end,
> +                section_hdr.data.start
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        if section_hdr.va.end < section_hdr.va.start {

[Severity: Low]
Is this validation check reachable?

SectionHeader::new() already validates that the virtual address range is not
empty by calling va.is_empty(). Since Range::is_empty() returns true if
start >=3D end, the condition section_hdr.va.end < section_hdr.va.start her=
e in
FwParser::parse_section_entry() appears to be dead code.

> +            pr_err!(
> +                "Firmware corrupted, section_hdr.va.end < section_hdr.va=
.start (0x{:x} < 0x{:x})\n",
> +                section_hdr.va.end,
> +                section_hdr.va.start
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        if section_hdr.section_flags.contains(SectionFlag::Prot) {

[ ... ]

> +        let name_len =3D entry_cursor.len() - entry_cursor.pos();
> +        let name_bytes =3D entry_cursor.read(name_len)?;
> +
> +        let mut name =3D KVec::with_capacity(name_bytes.len() + 1, GFP_K=
ERNEL)?;
> +        name.extend_from_slice(name_bytes, GFP_KERNEL)?;
> +        name.push(0, GFP_KERNEL)?;
> +
> +        let _name =3D CStr::from_bytes_with_nul(&name)
> +            .ok()
> +            .and_then(|name| CString::try_from(name).ok());

[Severity: Low]
Are these string allocations and validations used anywhere?

The parsed section name is bound to _name, which is intentionally unused and
immediately dropped. The allocated memory for the KVec and CString is freed
without being attached to the ParsedSection or used further.

Could this parsing be removed to save CPU cycles and avoid unnecessary memo=
ry
allocations during firmware loading?

> +
> +        let cache_mode =3D section_hdr.section_flags.cache_mode();

[ ... ]

> +impl SectionHeader {
> +    /// Reads and validates a section header from the cursor.
> +    ///
> +    /// Parses section flags, virtual address range, and data range from=
 the firmware binary.
> +    fn new(cursor: &mut Cursor<'_>) -> Result<Self> {
> +        let section_flags =3D cursor.read_u32()?;
> +        let section_flags =3D SectionFlags::try_from(section_flags)?;
> +
> +        let va_start =3D cursor.read_u32()?;
> +        let va_end =3D cursor.read_u32()?;
> +
> +        let va =3D va_start..va_end;
> +
> +        if va.is_empty() {
> +            pr_err!(
> +                "Invalid firmware file: empty VA range at pos {}\n",
> +                cursor.pos(),
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let data_start =3D cursor.read_u32()?;
> +        let data_end =3D cursor.read_u32()?;
> +        let data =3D data_start..data_end;

[Severity: High]
Does this code validate that the data offsets are within the firmware binar=
y?

The data_start and data_end offsets are read directly from the firmware
without being checked against the total size of the firmware binary.

When FwParser::parse_section_entry() returns the ParsedSection with this
data_range, downstream code that uses it to slice the firmware could
encounter an out-of-bounds access. In Rust, this would trigger an
unconditional panic and crash the kernel if the firmware is corrupted or
maliciously crafted.

> +
> +        Ok(Self {
> +            section_flags,
> +            va,
> +            data,
> +        })
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-fw-boot-b4=
-v7-0-afd8dc1494dd@collabora.com?part=3D6
