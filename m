Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230D606A33A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LP//exdM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D1610E8D5;
	Tue, 24 Nov 2026 21:17:22 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D16210E8D5
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 21:17:16 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb5b33e2ffso133355e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:17:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795555035; cv=none;
 d=google.com; s=arc-20260327;
 b=pE3jn3J8wSMgsPmHbWn+gi3AMSrZKX5cLjR+D3GB5fSaRy7ozSPm0i8WWHo63BwjtW
 5Grid6FvcFibHjnr2B/y/SXYrGymgwWqgiSgXPNeqx4nxePvwJYZ4KzjNHmDfrQ1/H5I
 Tc9Gzm6Py0e0cHQQDB0oK3ODpRvXyc4srocrHDNJKfxfYfm1L9VzUsPPiNXqoJA3hQ+J
 bUTSNxA+IAvDO18+mV2utfRqH1xWOg0vlZKVH3zKkGZ6fEIDtQtCO/oOeBA7ORmxVk/E
 BoVsNtBJDta2GCPi1mZec37fp0uKLyPcMfbOm0XaNqlxefHMVnlso3VSsldix7+SoVbt
 PHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D7CWradJPGVaYwp8zWE8ibM5vKB/LP8o1hdDmpVawtw=;
 fh=uKePbQfZQlLTx9ZW9MgJRAPaKEBz00kQTgmH+EzzlEI=;
 b=k/iFDyoj6+jgaNgGRE+Ml7nTR9cKXc4MayPHYXb9Miy2r7HoMn5iRaM4cH2IW67W6o
 PoduzNPEb0EhK1JNyKyKllePl3sJ+5HuDb18ccSbLNDRatvossvEq5kXPufYiItw0HsZ
 FwPvAJ0IzdCVBD8qarxalQhD8yxRzjyOEKKFlKxcuxiNaEgHtQ9VjUktZd+OWs5Ypq9v
 N7iIw2tsguHzNJK3L23YNdYU3TUjIJKq6eQbHiIwGk4+Kq6Y9vryTFBQ+IvjBsiWjbW3
 hLwCKAygE3n8bkYthEAur5NFsx2xnACQM6dcbOKWluFZqiloovkSVR7oC/nMHoPsYj1A
 9KKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795555035; x=1796159835;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D7CWradJPGVaYwp8zWE8ibM5vKB/LP8o1hdDmpVawtw=;
 b=LP//exdMWaFNF47LeSHb8RwIQBNr1zHQLB8x+lWPJaMghO3oV01aSK2pLofQtD9cUN
 wqQRzFtDDxKBxpmJoDzJpBxvpA4WMlUgCvzKLReFxiiP4tZLDzQR/53yQEcNUvWSpjSh
 zGzHhZq/MbgnY5mcjmvyH0N2f9WKbr8cby1BOPSn0rmOxMWsaLnrJUiUwOYH9Ya5dh4f
 kkqWF4cyd4olahdJL3P7KctS3sfRfCTHW+lDObER+DA5IYVH8hiPk593wm6x6xOQFBj+
 kPnazs3vyAffxk06eh9PK5vHXX+m2G1bROhdMgZvqJF0BNEu9mhLmS36uyGR2IIdXzXE
 V4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795555035; x=1796159835;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D7CWradJPGVaYwp8zWE8ibM5vKB/LP8o1hdDmpVawtw=;
 b=Wts3sbNszmfhJte0sFIun+sVT49ctNCWGiaTpuHI2NuDEmsNS4+IppoTQwkwgcm3jF
 JkIb7NGeHqAkSK5PFUarKRpXXC5kzJMRrEeLLEzvVV8GtDxCPQmOW4RqFBxH+f1gYxEm
 5oGOLvI/7zMmRhqM6qpxOKAf71TjK/AKT1kDnjYRm1b0sFy28z/rpg1wsu6/mTeXoY0S
 CATFlo6U4KQHIVI3Z038YWY6YvCIV+eEFo7gxOMpdDa9wtHZ5nCFMRpvXdIB2PTjScJk
 osXg8ZJAa6O5gmcYa7YpvVMAoQ3gOlBw+ilMncb00LJrE0U2cHqhSJHLq5HQr7xjgYpc
 6TDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHFGQoFqnZPNq/pHB8xcTSIroVhjWdabW68HuKPw+MHJRWhIw6V0zQ15i775yqorrVWAmtPCjh5X0k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8NvZJdb6LDEKja6UY7ZqdZdi4EdPGIy0RBJRYT5p45El5D+pcV
 nLkKCtfopUidXWHUceaKyuO+Cpwf93zThYrMSV3JVjfxRpGpUeZ+kPH8L/ldpMyTGl/cw2sPCCj
 bRtIggC+Du6y46uCMIWmnqFhU4D4ctRe59KWqogDJ
X-Gm-Gg: AZFdTZeusZzQaD4Epv3lCQMI/3PcaNyRIVFt03s+XnveE2VBCjjJUYpSFkW5ZFd3Kmh
 VUDOIGj+cdGZU1jS5DKN/xVzLnJhkSlu8+YrxhrnkDoqxxwOYNoBWtPa9BABlJpjjVHRIxzx1vU
 dVeezxv19bqUTjKO6BVnLibUPIVbrQg0G9i0/R62hnjoK0Lym7P50wjTQMV6zZJ3Yy1X3m9wMw9
 wJfLUaUy4JIriYJGYAPUAw9QWNLULDm84pinI+medzblJl7c8psPaxE7ql44+chnrZS0fzA35ov
 PNHAn2YMKbewrXs3VEfGo0zDX42yseMgUWq86nZKlZmIAPw6NHOcH/SVFeimP39YLhunxptyrsK
 /FbltNtufdBz3s2xUV3+Ye3+/R0fsUseJb8rWaGNj9GEClqnrlYYD3gv+AHk486020CQzj94KoQ
 vd7NUhgq8WryLYdavmU0gaaD7skCkB9VoNMqc1MXReg+U=
X-Received: by 2002:a05:600c:41c7:b0:4bb:7ae0:3158 with SMTP id
 5b1f17b1804b1-4bb91683f09mr1702525e9.8.1795555034613; Tue, 24 Nov 2026
 13:17:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-feat-udmabuf-huge-pfnmap-v2-0-3254f801fc36@linux.dev>
 <20261123-feat-udmabuf-huge-pfnmap-v2-2-3254f801fc36@linux.dev>
In-Reply-To: <20261123-feat-udmabuf-huge-pfnmap-v2-2-3254f801fc36@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 24 Nov 2026 13:17:02 -0800
X-Gm-Features: Aa3M54oDsXG-xXA0liYSlMAI56IBmdX9Wf6SVnF95VXy1mB4cBPNV8817l0bAvI
Message-ID: <CABdmKX2156cpvWHEg7hVNGqqhgg-+v1Vj4G_bAK01kk6huq=4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] udmabuf: map huge page backed ranges with PMDs
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Shuah Khan <shuah@kernel.org>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Philip Yang <Philip.Yang@amd.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Natalie Vock <nat@pixelcluster.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 6:45=E2=80=AFPM Qiliang Yuan <qiliang.yuan@linux.de=
v> wrote:
>
> QEMU and crosvm hand guest memory to the host renderer and display as
> udmabufs for virtio-gpu blob resources. The guest memory is a memfd that
> is often backed by 2 MiB huge pages, and the host process mmap()s the
> dma-buf to access it with the CPU.
>
> udmabuf maps every page with its own PTE: the first fault inserts a PFN
> for each 4 KiB page of the whole VMA. Mapping and touching 4 GiB this way
> takes over 200 ms and a million PTEs, although the memory behind it is
> 2048 huge pages.
>
> Add a ->huge_fault() handler that maps a PMD-sized range with one PMD
> when it is backed by an aligned run of contiguous PFNs, and falls back to
> PTEs otherwise. Have the pre-mapping on the first fault skip the ranges
> the handler will map, so that their PTEs don't take the place of the
> PMDs. Once THP is disabled for the VMA, the ranges already mapped with a
> PMD keep it, so pre-map only the PMD-sized range of the fault then.
>
> Mapping a udmabuf over a memfd filled with data and reading a byte of
> each 4 KiB page through the mapping, base and patched kernels alternating
> over 3 rounds of 5 runs (7 for shmem 4K), median of the per-round medians
> and range in parentheses:
>
>   backing    size        before (ms)         after (ms)   change
>   hugetlb    256M   13.3 (13.3-13.7)      1.7 (1.7-1.8)     -87%
>   hugetlb      1G   53.6 (53.0-53.7)      6.5 (4.2-6.6)     -88%
>   hugetlb      4G      211 (211-212)   23.6 (17.6-25.2)     -89%
>   hugetlb      8G      423 (422-424)   45.8 (45.8-47.2)     -89%
>   shmem THP    1G   52.8 (52.5-53.1)      6.3 (5.8-6.8)     -88%
>   shmem THP    4G      210 (207-214)   20.7 (19.5-21.1)     -90%
>   shmem 4K     1G   52.0 (51.6-52.7)   51.8 (51.5-52.9)       0%
>   shmem 4K     4G      209 (209-211)      208 (208-209)       0%
>
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>

This commit message should explicitly say this patch depends on
Lorenzo's series in addition to mentioning it in the cover letter (for
merging / backporting). The mm/core hashes may change, so just by the
series title or patch subjects for now.

> ---
>  drivers/dma-buf/udmabuf.c | 85 +++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 81 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 018937435356e..9f53d33fbdd9a 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -44,12 +44,63 @@ struct udmabuf {
>         struct miscdevice *device;
>  };
>
> +/*
> + * Return whether the PMD-sized range of @vma at @addr is backed by one =
aligned
> + * run of contiguous PFNs, which can then be mapped with a single PMD.
> + */
> +static bool udmabuf_pmd_mappable(struct vm_area_struct *vma, unsigned lo=
ng addr,
> +                                unsigned long *pfn)
> +{
> +       struct udmabuf *ubuf =3D vma->vm_private_data;
> +       const pgoff_t nr =3D PMD_SIZE >> PAGE_SHIFT;
> +       unsigned long first;
> +       pgoff_t pgoff, i;
> +
> +       if (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP))
> +               return false;
> +
> +       if (!IS_ALIGNED(addr, PMD_SIZE) || addr < vma->vm_start ||
> +           vma->vm_end - addr < PMD_SIZE)
> +               return false;
> +
> +       pgoff =3D vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +       if (pgoff >=3D ubuf->pagecount || ubuf->pagecount - pgoff < nr)
> +               return false;
> +
> +       first =3D page_to_pfn(ubuf->pages[pgoff]);
> +       if (!IS_ALIGNED(first, nr))
> +               return false;
> +
> +       for (i =3D 1; i < nr; i++) {
> +               if (page_to_pfn(ubuf->pages[pgoff + i]) !=3D first + i)
> +                       return false;
> +       }
> +
> +       *pfn =3D first;
> +       return true;
> +}
> +
> +#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
> +static vm_fault_t udmabuf_vm_huge_fault(struct vm_fault *vmf,
> +                                       unsigned int order)
> +{
> +       unsigned long pfn;
> +
> +       if (order !=3D PMD_ORDER ||
> +           !udmabuf_pmd_mappable(vmf->vma, vmf->address & PMD_MASK, &pfn=
))
> +               return VM_FAULT_FALLBACK;
> +
> +       return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE=
);
> +}
> +#endif
> +
>  static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>         struct udmabuf *ubuf =3D vma->vm_private_data;
>         pgoff_t pgoff =3D vmf->pgoff;
> -       unsigned long addr, pfn;
> +       unsigned long addr, end, pfn;
> +       bool pmd_ok;
>         vm_fault_t ret;
>
>         if (pgoff >=3D ubuf->pagecount)
> @@ -61,14 +112,37 @@ static vm_fault_t udmabuf_vm_fault(struct vm_fault *=
vmf)
>         if (ret & VM_FAULT_ERROR)
>                 return ret;
>
> -       /* pre fault */
> -       pgoff =3D vma->vm_pgoff;
> +       /*
> +        * Pre-fault the rest of the VMA, except for the ranges that
> +        * udmabuf_vm_huge_fault() maps with a PMD once they are accessed=
.
> +        */
> +       pmd_ok =3D thp_vma_allowable_order(vma, vma->vm_flags, TVA_PAGEFA=
ULT,
> +                                        PMD_ORDER);
>         addr =3D vma->vm_start;
> +       end =3D vma->vm_end;
>
> -       for (; addr < vma->vm_end; pgoff++, addr +=3D PAGE_SIZE) {
> +       /*
> +        * Ranges mapped with a PMD before THP was disabled for the VMA k=
eep
> +        * their PMD, so pre-fault only the PMD-sized range of the fault.
> +        */
> +       if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) && !pmd_ok) {
> +               addr =3D max(addr, vmf->address & PMD_MASK);
> +               end =3D min(end, (vmf->address & PMD_MASK) + PMD_SIZE);
> +       }

This fixes the v1 problem, but it means that a task with THP disabled
takes a fault per PMD size instead of the whole VMA. Including buffers
that are entirely backed by 4k pages. That partially undoes the
f0bbcc258e81 ("udmabuf: pre-fault when first page fault") behavior.
That's probably fine (would be good to see results for shmem 4K under
PR_SET_THP_DISABLE), but I think the commit message should mention
this also applies to 4k buffers.

Also probably worth mentioning / commenting that
/sys/kernel/mm/transparent_hugepage/enabled =3D never (we use that)
doesn't get you here because the THP tuneables are bypassed for
VM_PFNMAP VMAs with huge_fault().

If we stick with this behavior when THP is disabled, can we just do it
unconditionally (using pmd_addr_end(vmf->address, vma->vm_end))? That
would eliminate pmd_ok, the thp_vma_allowable_order() call, the skip
branch below, and keep udmabuf_vm_fault() within the faulting PMD's
page table and avoid repeated full-VMA scans (e.g. post
MADV_DONTNEED), which seems like it might be worth the extra faults.
Worth checking the shmem 4k numbers to see if the extra per-PMD faults
are negligible though.

> +       pgoff =3D vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +
> +       for (; addr < end; pgoff++, addr +=3D PAGE_SIZE) {
>                 if (addr =3D=3D vmf->address)
>                         continue;
>
> +               if (pmd_ok && IS_ALIGNED(addr, PMD_SIZE) &&
> +                   (vmf->address & PMD_MASK) !=3D addr &&
> +                   udmabuf_pmd_mappable(vma, addr, &pfn)) {
> +                       pgoff +=3D (PMD_SIZE >> PAGE_SHIFT) - 1;
> +                       addr +=3D PMD_SIZE - PAGE_SIZE;
> +                       continue;
> +               }
> +
>                 if (WARN_ON(pgoff >=3D ubuf->pagecount))
>                         break;
>
> @@ -89,6 +163,9 @@ static vm_fault_t udmabuf_vm_fault(struct vm_fault *vm=
f)
>
>  static const struct vm_operations_struct udmabuf_vm_ops =3D {
>         .fault =3D udmabuf_vm_fault,
> +#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
> +       .huge_fault =3D udmabuf_vm_huge_fault,
> +#endif
>  };
>
>  static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
>
> --
> 2.43.0
>
