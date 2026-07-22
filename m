Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402C3C4452B
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BF110EBF6;
	Wed, 22 Jul 2026 01:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LHJTl/OC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B93A10EBF6
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:04:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9339F42D51;
 Wed, 22 Jul 2026 01:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474EA1F000E9;
 Wed, 22 Jul 2026 01:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784682251;
 bh=DO654lot1HE1y8tftbhqQA5Tq1r6w5adHV92yAVrht8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LHJTl/OCg0OISiprBMWMPrPwWzfRnpwR/g6iSFnTvS45B+RzrlI6I4vfWoL6acdk6
 9CEWIAvi0k5ADE45lZXmbzXIs59MlXlKY2w2G2P/AFHUzv/cpJWVG1rO3Oq2SkC5HD
 0MecTDeHQ1ZydpoYbiK7oCXOT5+UomTJNLcBTvl8P1wSrUP4W5eJjREXIEYu0Gzblp
 WYmmL4q78YkhnI6skGPzvJxlLUSZ5WmZuWg8EaA3UOGBuHPRsQoQJV5mv24K0v7UMr
 pl5HHZtl1mv8LW8cQGpMVFCbcnZA9rw5pTBEJ9PqiURgtUHiWgLMdW+4iSoa9XFZ+e
 sRNowKUxiq/pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/7] drm/tyr: add parser for firmware binary
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260721-fw-boot-b4-v8-6-b28f744581c9@collabora.com>
References: <20260721-fw-boot-b4-v8-0-b28f744581c9@collabora.com>
 <20260721-fw-boot-b4-v8-6-b28f744581c9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:04:10 +0000
Message-Id: <20260722010411.474EA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The parser incorrectly rejects firmware sections where `va_start =
=3D=3D va_end`, which breaks compatibility with valid firmware binaries.
- [High] Firmware entries can silently extend beyond the header region, cau=
sing the parser to incorrectly read payload data as headers.
- [Medium] The parser fails to validate that virtual address ranges are pag=
e-aligned.
- [Medium] Casting the firmware binary length to `u32` can cause silent int=
eger truncation on 64-bit architectures, leading to incorrect size validati=
on.
- [Low] The catch-all match arm for unknown entry types contains unreachabl=
e dead code and overly convoluted boolean logic.
--

--- Patch [6]: [PATCH v8 6/7] drm/tyr: add parser for firmware binary ---
commit a6abcd1e77314e56a03e26729fd17f0e939b696a
Author: Daniel Almeida <daniel.almeida@collabora.com>

drm/tyr: add parser for firmware binary

This commit adds a parser for the Mali CSF GPU firmware binary format. The
firmware consists of a header followed by entries describing how to load
firmware sections into the MCU's memory.

> diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/pa=
rser.rs
> new file mode 100644
> index 0000000000000..f71cdcf760bd4
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/fw/parser.rs

[ ... ]

> +    fn parse_fw_header(&mut self) -> Result<FirmwareHeader> {

[ ... ]

> +        let fw_header: FirmwareHeader =3D match FirmwareHeader::new(&mut=
 self.cursor) {
> +            Ok(fw_header) =3D> fw_header,
> +            Err(e) =3D> {
> +                dev_err!(self.cursor.dev, "Invalid firmware file: {}\n",=
 e.to_errno());
> +                return Err(e);
> +            }
> +        };
> +
> +        if fw_header.size > self.cursor.len() as u32 {

[Severity: Medium]
Could casting the firmware slice length down to 32 bits cause issues on
64-bit architectures?=20

If a firmware file happens to be larger than 4GB, the truncated length might
falsely trigger the truncated image error. Would it be safer to cast
fw_header.size to usize instead?

> +            dev_err!(self.cursor.dev, "Firmware image is truncated\n");
> +            return Err(EINVAL);
> +        }
> +        Ok(fw_header)
> +    }
> +
> +    fn parse_entry(&mut self) -> Result<EntrySection> {

[ ... ]

> +        let entry_section =3D {
> +            let mut entry_cursor =3D self
> +                .cursor
> +                .view(self.cursor.pos()..self.cursor.pos() + section_hdr=
_size)?;

[Severity: High]
Can an entry size silently extend beyond the header region here?
   =20
The FwParser::parse() method iterates until cursor.pos() < fw_header.size,
but cursor.view() checks its bounds against self.data.len() (the full
binary file size).
   =20
If an entry size extends past fw_header.size, will the parser read past
the header region into the payload data, interpreting raw payload bytes
as structured headers?

> +
> +            match entry_section.entry_hdr.entry_type() {
> +                Ok(EntryType::Iface) =3D> Ok(EntrySection {
> +                    entry_hdr: entry_section.entry_hdr,
> +                    inner: Self::parse_section_entry(&mut entry_cursor, =
firmware_size)?,
> +                }),
> +                Ok(
> +                    EntryType::Config
> +                    | EntryType::FutfTest
> +                    | EntryType::TraceBuffer
> +                    | EntryType::TimelineMetadata
> +                    | EntryType::BuildInfoMetadata,
> +                ) =3D> Ok(entry_section),
> +
> +                entry_type =3D> {
> +                    if entry_type.is_err() || !entry_section.entry_hdr.o=
ptional() {
> +                        if !entry_section.entry_hdr.optional() {

[Severity: Low]
Since EntryType is an exhaustive enum, does this catch-all arm only match
the Err variants from TryFrom?=20
   =20
If entry_type.is_err() is always true here, it looks like the else block
returning Ok(entry_section) is unreachable dead code. Can this logic be
simplified to just check the optional flag?

> +                            dev_err!(
> +                                self.cursor.dev,
> +                                "Failed to handle firmware entry type: {=
}\n",
> +                                entry_type
> +                                    .map_or(entry_section.entry_hdr.entr=
y_type_raw(), |e| e as u8)
> +                            );
> +                            Err(EINVAL)
> +                        } else {
> +                            Ok(entry_section)
> +                        }
> +                    } else {
> +                        Ok(entry_section)
> +                    }
> +                }
> +            }
> +        };

[ ... ]

> +    fn parse_section_entry(
> +        entry_cursor: &mut Cursor<'_>,
> +        firmware_size: usize,
> +    ) -> Result<Option<ParsedSection>> {

[ ... ]

> +        if section_hdr.va.start =3D=3D CSF_MCU_SHARED_REGION_START
> +            && !section_hdr.section_flags.shared()
> +        {
> +            dev_err!(
> +                entry_cursor.dev,
> +                "Interface at 0x{:x} must be shared\n",
> +                CSF_MCU_SHARED_REGION_START
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let mut vm_map_flags =3D VmMapFlags::empty();

[Severity: Medium]
Does the virtual address range need to be validated for page alignment
before setting up the VM mapping flags?=20
   =20
Passing unaligned virtual addresses to the GPU VM subsystem might cause
mapping errors or corrupted page tables.

> +
> +        if !section_hdr.section_flags.write() {
> +            vm_map_flags |=3D VmFlag::Readonly;
> +        }

[ ... ]

> +impl SectionHeader {
> +    fn new(cursor: &mut Cursor<'_>) -> Result<Self> {
> +        let section_flags =3D SectionFlags::try_from_fw(cursor.read_u32(=
)?)?;
> +
> +        let va_start =3D cursor.read_u32()?;
> +        let va_end =3D cursor.read_u32()?;
> +
> +        let va =3D va_start..va_end;
> +
> +        if va.is_empty() {

[Severity: High]
Does this check incorrectly reject valid firmware sections?

The Rust Range::is_empty() function returns true when start >=3D end, which
means sections with va_start =3D=3D va_end are rejected with EINVAL.

If a firmware section contains payload data but has no VM mapping footprint
(where va_start =3D=3D va_end is intentional), will this cause the parser to
falsely reject it?

> +            dev_err!(
> +                cursor.dev,
> +                "Invalid firmware file: empty VA range at pos {}\n",
> +                cursor.pos(),
> +            );
> +            return Err(EINVAL);
> +        }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-fw-boot-b4=
-v8-0-b28f744581c9@collabora.com?part=3D6
