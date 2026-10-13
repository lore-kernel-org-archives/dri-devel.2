Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5A4CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48278112157;
	Thu, 15 Oct 2026 07:56:49 +0000 (UTC)
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E158A10E893
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 19:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1791919056; x=1792178256;
 bh=Cq4MORSb8hI/u7CDSQaYgsFtEmVgfHYVoEOaPjQr8hY=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=bCKSEtmdy7JV23HbskB5D/jCL7jb3hnjGPD7l0nMn2HjCwseG1XgjmdfoFiTry7bi
 bxpyIeNK5IQIde34IK6EBPOtHGu5suhlR3spkGE1HIm17h1Fkvpppi0vt0m+fK6fzN
 aLjGhROOJ38I99cnQQoG7oTE7k1gpC9KdQZjepH3A1Y4StPcCygWzkpE1tb7XejJVA
 owYvL/eX4WokE6ob6VPzKvkMQftI3ViZpCYifgL9h/DcCId4CFXaa/wR4g5+LE/UhE
 jzCvt1mwr9s72TEBHrUVBQ9iUFHEIeBtDclRMRZ68BDzdWn9lQfFJ5KFCaLmiQOtEW
 livRPefl4DFOg==
Date: Tue, 13 Oct 2026 19:17:32 +0000
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
From: kerhunt <kerhunt@proton.me>
Cc: "david@redhat.com" <david@redhat.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: =?utf-8?Q?[REPORT]_udmabuf:_unaligned_offset_with_hugetlb_memfd_mis-sizes_buffer_=E2=80=94_data_placed_at_wrong_folio_offsets?=
Message-ID: <tx7v2Qaj_4HFdXLePQ7UNVmusSZDQ48wymOfejHx_hZ1OTEPORRFB1snkSp9jExhU4UrRXmiVmy0CdzTTot_iTVAf4Hw_NJ1pnd7THQ-9t4=@proton.me>
Feedback-ID: 227694322:user:proton
X-Pm-Message-ID: 0b48cf81c1e4bafcf9c11b04fb6e461daa0cf468
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

Hi dri-devel,

udmabuf_create() accepts hugetlb memfds (check_memfd_seals() in
drivers/dma-buf/udmabuf.c:256-272 explicitly allows
is_file_hugepages()), but the buffer fill logic mishandles
offsets that are not aligned to the huge page size, causing the
exported dma_buf to serve data displaced from what the caller
requested =E2=80=94 and in a partial-fill case, a mismatch between the
declared buffer size and the actually filled folio array.

=3D=3D AFFECTED =3D=3D

- Linux 6.12.112 (linux-6.12.y stable), commit 7aba70ab
- Linux mainline, HEAD 24a19b953e2a (torvalds/linux), as of this
  report

=3D=3D ROOT CAUSE =3D=3D

memfd_pin_folios() (mm/gup.c:3700-3809) pins the folios
overlapping the requested range and returns, per folio, the
offset of the range start *inside* that folio
(offset_in_folio(), gup.c:3777-3778). For a hugetlb memfd
(huge pages, e.g. 2MB), a range starting mid-folio returns a
large unaligned pgoff.

The udmabuf fill loop (udmabuf.c:288-340) then does:

    for each pinned folio:
        subpgoff =3D pgoff;                  /* starts unaligned */
        for (; subpgoff < folio_size(folio); subpgoff +=3D PAGE_SIZE) {
                ubuf->folios[upgcnt] =3D folio;
                ubuf->offsets[upgcnt] =3D subpgoff;
                ++upgcnt;
                if (++cur_pgcnt >=3D pgcnt) goto end;
        }
        pgoff =3D 0;    /* reset only from the SECOND folio on */

Two consequences:

1) The first (huge) folio fills only
   (folio_size - unaligned_pgoff) / PAGE_SIZE slots instead of
   folio_size / PAGE_SIZE =E2=80=94 so the accounting between
   cur_pgcnt (pages of the requested range) and upgcnt (slots
   filled) diverges from what the caller sized
   (pgcnt =3D list[i].size >> PAGE_SHIFT, udmabuf.c:364).

2) Subsequent folios restart their offsets at 0 (the pgoff
   reset at udmabuf.c:334), so the resulting buffer maps the
   folios with displaced data: the first folio serves bytes
   from the requested offset, but later folios serve from their
   own start =E2=80=94 the exported dma_buf does not contain the
   contiguous range the caller asked for.

Also, when cur_pgcnt reaches pgcnt early (goto end at
udmabuf.c:324-325), upgcnt can end lower than the pgcnt the
user requested in some unaligned configurations =E2=80=94 the declared
buffer size (exp_info.size =3D pagecount << PAGE_SHIFT,
udmabuf.c:281) then reflects the shortened fill.

There is no alignment check on the requested offsets/sizes
against the huge page size anywhere in udmabuf_create()
(udmabuf.c:342-382) or check_memfd_seals() =E2=80=94 is_file_hugepages()
is accepted with no hstate-size validation.

=3D=3D IMPACT =3D=3D

Data integrity: any consumer of the exported dma_buf (GPU
render paths, virtio buffers, cross-process sharing) reads
buffer contents displaced from the producer's layout =E2=80=94 silent
data corruption within the buffer the caller created.

Reachability: udmabuf_create is reachable from any process via
/dev/udmabuf (misc device) with a memfd that it creates itself
(memfd_create with MFD_HUGETLB) =E2=80=94 no special privileges.

Not a privilege escalation: the defect corrupts/reads the
caller's own buffer data, not kernel memory outside the pinned
folios.

=3D=3D PROPOSED REMEDIATION =3D=3D

Either:

(a) Reject unaligned ranges for hugetlb memfds in
    udmabuf_create(): if is_file_hugepages(memfd), require
    (offset % huge_page_size(memfd)) =3D=3D 0 for every list entry
    (or round handling per the QEMU/KVM usage expectations);

or (b) handle the first folio's unaligned pgoff consistently:
    count the first folio's contribution correctly so pgcnt and
    upgcnt stay in sync (the fill loop's cur_pgcnt accounting
    against the range pages does not currently match the
    folio-relative subpgoff walk).

Option (b) preserves the ability to share sub-folio ranges.

=3D=3D NOTES =3D=3D

- Found by static analysis of the 6.12.y stable tree,
  cross-verified against mainline. No dynamic PoC built; the
  reproduction is a memfd_create(MFD_HUGETLB) + UDMABUF_CREATE
  with an unaligned offset, then comparing the mmap'd buffer
  content against the memfd layout.
- Happy to test patches and send the formal fix.
- Please credit "kerhunt <kerhunt@proton.me>".

Best regards,
kerhunt
