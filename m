Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D021CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2782F10E095;
	Mon, 18 May 2026 19:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="RtiCmlzy";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90FD10E095
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:22:09 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488940ccfa6so1185e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779132128; cv=none;
 d=google.com; s=arc-20240605;
 b=UkoigM4KoiQ3t8u5lIwN5r5dX3N8jpehrHmYuZ95LsQJ4DlEnKfQLLa9GiPS7iJ4YG
 Iwi7//04mCpJWLBlsf9WQnor4pwURtAF5Ipm21cWfETxRkEF5RHjk3Rgwhm4o0jb9XTA
 jR48STCgdC1wSDe/wTjWv8I6yAqX8Vn3eCQHnVJ1S2MEtWAxEGF15x0X2+lM6H7ZMV9j
 TdDN2w8fRpapDj+dIBlYDkX+mZzE0vgiHBJ5rn22sIXZ1GmRxVG7D8P7cxMKYzp36Oxu
 TykMzzxmHvN6PeKibF5egnPIVE0Zy0x8CC8OsxWO5vu9cVS/VWChVPB2zxKejkZL8MBb
 d8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tamJOUr/gFpbNHYCsIZYX+iIMAFW5aR8+J/DZkkw+Z4=;
 fh=cUM8qJrg83zRN3L5NZkQBBL3o32gFspWKz8U15uBxtE=;
 b=EF7mSKpl/nFqDRJ2/eGgUaOTnr+ZrusTDQgjjBxSPIM6HkkNtVwCNd4diuFdO2I5zR
 AcJZHetX+ifdG14u39QbiTy8SPRmcvzzg59x3rw4t2/Qwu5fOFrY1xqVf+bo4H6sX4rP
 oDwNtBij8aDdm2+A6r+LG/X0lYsV/RiPFcG2pejRGWw6o329ITGSCBNePNrH+RllwXiH
 VPXsMxeNJv4lvpVjEh0fbuwVWd+5BuoSyeS7wrijmsjF43jBcCNtoPJfiEvwD3UdiR2b
 Mr3VGqHspVmdX/6HWpinStCbB7heoCdLBKUA/5fnF6dorUhyNZKkPifdREsy9QkYRVWz
 UGwQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779132128; x=1779736928;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tamJOUr/gFpbNHYCsIZYX+iIMAFW5aR8+J/DZkkw+Z4=;
 b=RtiCmlzyKzdLZscG/qip//VWwCqLj04ZS+xmqmWG2EghH/Y1e5Ji1uz5JFOH8UWsBR
 mHJmjXJR8co3x/6x2IQON/js/+T2rjyo35L8ZXtunREeQYCjru32esZ1+BV/Ei+NqjKl
 /xI/pbJHDCEdS4EamGg0HLf9ECkFEcqrRSzO7enrniwk0dc2rumUg2+5F1USKX7gElLx
 uL+Kmeu52LbIdFzUdc6PQ4H920geMEY875uhZgfxTn6t2iDIMw8NBBk0GAuvIx67f7iO
 qc9tjIvb+amDiG+Hvlt3zDqa6D5klqf7e887S6BIOHTfIzvj3cs4SxGV+Xvszj0vPxlv
 DdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779132128; x=1779736928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tamJOUr/gFpbNHYCsIZYX+iIMAFW5aR8+J/DZkkw+Z4=;
 b=OnZAUYYV3BBt2V4f6PPvFSCOxtaTbZoYmvBjHeCIjC6jxZU7ZNhdNSu5ijbY86UErJ
 K87IQw0k2D4jtg51q7518ER+RT0OO/NzcSJy84R9v1JkYewuBoYTAjGo7PmWf6WBF0mL
 QYPVWPEOs1sHxQoe12kCfib88AcCmh/LLOTwxj0fqltFvZVgxyi6xbOqYFDjgAr2+xIk
 tAxeTDqBaRvs3EbArX2sb1A4aSt+UFkAT/Gf+Jr+lEDIPBz4KEOTL18rIMuZs2aLIyWT
 YIMj7qooaQAtoj8EIfQGuLXK2ZYXYQza48nZXhxozKnKsRd70R6wkNgYsIdxhSM+1xEO
 NnDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ80ju7Wro2ktrUOELximQxaFUOlx8+hqHvvn5PvLivNfyIk7N44gfIF9sCWQ05u111zrKrHf4C9gXU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywh1mJx3VRshWsEoGrrEzDHw8uO4xzBWF6gzlJswvXJWY9bzZoQ
 ic2Y+2TWPv/XCsgQkMytGH4oPy9G4PovN96kNaiAjBtj/KVQX2aX8hMFwtHpeOuhn7iD/gdOGWg
 f5TFjlyh/qluzylNHbR6yRrIcES1hV2TCbaET3XUW
X-Gm-Gg: Acq92OFZyBMHzeGiumTLXdDnhIuLCY02+HHi0VHr3PI8tNeuGVksh1mAr1mnzlYwaYF
 ADOG5BRa7l+wLK+NKfLiGauMsYb9T2A71d326uYcc7jJDTeD5Sg/QxydYxO4+WZG+zfpDAh5EmI
 MzrAWERemhXU/udjEQZsc+S4tZkxYNiK/krl4bMtcFyRyj7cdKwyk4sw0Mmt3Rc3ye2JVIiW2d1
 0Y+Swnl7YtSnK+WmPcJ2mINu9OnwcIWfG64bxvkBNp950UG7nO0n0a7zRZv9slFRCHvZnXCU6E9
 lmLmXxy42hmMBgpsyQitM5oAWwkvrytaQsW2pr2dJ0yBObQ1
X-Received: by 2002:a05:600c:6299:b0:483:6a76:11a6 with SMTP id
 5b1f17b1804b1-48ffd84253emr3382295e9.5.1779132127442; Mon, 18 May 2026
 12:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <afXGeq1AvqFY76MY@stanley.mountain>
 <agsrBPXYXA2vZgj1@willie-the-truck>
In-Reply-To: <agsrBPXYXA2vZgj1@willie-the-truck>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 12:21:55 -0700
X-Gm-Features: AVHnY4IaFTCEtAbkOTHrQii7e8-AzKA2Ul7h3BwOA0peBU4GDfj3y7WV26rf3CU
Message-ID: <CABdmKX0hPe7itx4orMAx2Q6EQa+A4uL6yFa4in7q3vHRBQRn1w@mail.gmail.com>
Subject: Re: [bug report] dma-buf: heaps: Rework heap allocation hooks to
 return struct dma_buf instead of fd
To: Will Deacon <will@kernel.org>
Cc: Dan Carpenter <error27@gmail.com>, jstultz@google.com, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, May 18, 2026 at 8:06=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Sat, May 02, 2026 at 12:40:10PM +0300, Dan Carpenter wrote:
> > I'm not sure exactly who to report this bug too.  Probably the mm
> > devs?
>
> [Adding John and TJ, in case they are interested / able to help]
>
> Will
>
> (original report follows)
>
> >       drivers/dma-buf/heaps/system_heap.c:499 system_heap_allocate()
> >       warn: passing positive error code 's32min-(-1),1' to 'ERR_PTR'
> >
> > drivers/dma-buf/heaps/system_heap.c
> >     459         if (cc_shared) {
> >     460                 for_each_sgtable_sg(table, sg, i) {
> >     461                         ret =3D system_heap_set_page_decrypted(=
sg_page(sg));
> >     462                         if (ret)
> >     463                                 goto free_pages;
> >
> > It kind of looks like system_heap_set_page_decrypted() can return 1.
> >
> >     464                 }
> >     465         }
> >     466
> >     467         /* create the dmabuf */
> >     468         exp_info.exp_name =3D dma_heap_get_name(heap);
> >     469         exp_info.ops =3D &system_heap_buf_ops;
> >     470         exp_info.size =3D buffer->len;
> >     471         exp_info.flags =3D fd_flags;
> >     472         exp_info.priv =3D buffer;
> >     473         dmabuf =3D dma_buf_export(&exp_info);
> >     474         if (IS_ERR(dmabuf)) {
> >     475                 ret =3D PTR_ERR(dmabuf);
> >     476                 goto free_pages;
> >     477         }
> >     478         return dmabuf;
> >     479
> >     480 free_pages:
> >     481         for_each_sgtable_sg(table, sg, i) {
> >     482                 struct page *p =3D sg_page(sg);
> >     483
> >     484                 /*
> >     485                  * Intentionally leak pages that cannot be re-e=
ncrypted
> >     486                  * to prevent shared memory from being reused.
> >     487                  */
> >     488                 if (buffer->cc_shared &&
> >     489                     system_heap_set_page_encrypted(p))
> >     490                         continue;
> >     491                 __free_pages(p, compound_order(p));
> >     492         }
> >     493         sg_free_table(table);
> >     494 free_buffer:
> >     495         list_for_each_entry_safe(page, tmp_page, &pages, lru)
> >     496                 __free_pages(page, compound_order(page));
> >     497         kfree(buffer);
> >     498
> > --> 499         return ERR_PTR(ret);
> >     500 }
> >
> > The problem is that add_to_pagemap() returns PM_END_OF_BUFFER (1)
> > which is used by pagemap_read() and nowhere else.  The call tree
> > is:
> >
> > system_heap_allocate()
> > system_heap_set_page_decrypted()
> > set_memory_decrypted()
> > realm_set_memory_decrypted()
> > __set_memory_enc_dec()
> > __change_memory_common()
> > update_range_prot()
> > walk_kernel_page_table_range_lockless()
> > walk_pgd_range()
> > pagemap_pte_hole()

This doesn't look right to me. update_range_prot is in arm64 arch
code. It uses the arm64 pageattr_ops which does not provide a pte_hole
op. So walk_pgd_range should never call ops->pt_hole.

> > add_to_pagemap()
> >
> > This code seems sort of old and I guess no one has reported the bug
> > so maybe it's a false positive, but it feels like it's asking for
> > problems to return the PM_END_OF_BUFFER.  There aren't any comments
> > on any of those functions above explaining what return values are
> > expected.
> >
> > This email is a free service from the Smatch-CI project [smatch.sf.net]=
.
> >
> > regards,
> > dan carpenter
