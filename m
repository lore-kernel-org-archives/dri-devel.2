Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C645F483DB
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 23:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB8510E031;
	Mon, 23 Mar 2026 23:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="MAoLH91s";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3082810E031
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 23:26:00 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4852ef20fe8so17555e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774308359; cv=none;
 d=google.com; s=arc-20240605;
 b=FihuT5Us0cQYr8vE7iDoaDn/bEMfiJFL0etpE/rFTEbBIOwhl5jrZB/7TWaBa2EWnu
 Ul6b7IEkjrQIZCwAywdMk+5Ep6qGL5wyfpH8XZUA4F0q2aDbtcCjDybiT5Hp6Q85hZHF
 G8j+jNAD6OzGqEsVGUDKBSxWw/pnWetUfpcH/Od521xhGwB9JdS+d0Nva6Iahvu+puAC
 iqYfXQv1HDif3TDu8RBrNMqBDwl6TCcURLqRAR5KIuIwvezB4EEJgFSUiI0NraEKL9Ol
 Z7uheyke8TSQ4IozWMtX+/8uBQke2ImqGPIKJibp9AnfsZcy83BgZyfjXOO3naZohCqY
 S8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wsdu7cH+tJM9BcvV/aAG6iPqbhR4QDoeSOE9glJa45Q=;
 fh=sPkvoiVW1RBgQUxYl4/XdROFjqxLmkR3wF8LHkDYD0M=;
 b=DHs1tG5AVK4eO4IDZN2D9Wm6rcxyx69p3mHS3qk+StI5pat6r+14Lt1G8JKdrcAHZH
 3ZfzFG1MCANC9K6d93UTF6DlOybatrTfoZ+vWsheMXqL9dt5aYI6c/fD5OzxJ4srV5RE
 3cgWpO9cbLk1BXg33PBafCWnhY/3UkDegUZ3WBTgDGqLInf6Oppe90LZeN0AoTngdHq3
 sR2i1bEqJSPLzhqDW7UrUDLuECWfGOlPTXtyilazZkdbMPX3DxQpnC3rxh1cAKwG6nJd
 Gqu5zqfdOFuSKTbkoZrIVNMiC7LxXNbVAGsTVyjWCkk0JuZoKficArgwvET5PuFz5Mnx
 3aWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774308359; x=1774913159;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsdu7cH+tJM9BcvV/aAG6iPqbhR4QDoeSOE9glJa45Q=;
 b=MAoLH91sVyWhkXjRQwlDmt2lnl+gXXQznB0pAPCWYMHxRrcAMNViqJi03l0dvlh3Ff
 W8cgM9S8MgDj4JF5sexNbLNVHuyEtCdgiauuTQTr6vzz39AqpJAeY1QPt3ttlZCS7P+j
 J8LJ9LwKbed6ErrdkDkFasGq22/hCq45iXgVFEch5n0abQGz2pqz1zKCMw9IINObGQK2
 XnKDl/PGlBUuodN4v0xLjcayL4plxMZb+gHh+u4PSSyC14O7u7RtJ+KOILsMFH3pVs32
 hwqJWtWdSRY3/yVpsjTDhQys6yScfE6stknAI/XRW51qvYs+6YltWaXHGWQsN67Sl81O
 BLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774308359; x=1774913159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wsdu7cH+tJM9BcvV/aAG6iPqbhR4QDoeSOE9glJa45Q=;
 b=RoTrd89iVYtLDifn7r+5016SvFZYJV2+wYUzcgBHhkK9uPVe422T1xy3iHPsdsBK3L
 pVPtvm+9vuLzSMx3rUder8PVIv5ZMK1HGTH0ZrZQE3Kjq6RRSKtOd8z3vW/4aQSEUaCY
 /gcyomhSnWV0DmIbdMWS4mQ+wdWW03bEK+czRfcoyQ9078rATV7R1aRS/nBbxWkcXS5/
 L5QSejq1JY2nhguvyiCs0VQ5MPsADMbfcF+XRqouvu63scLsO8U5xDFpW/5BuqyKuplY
 jiSp9RuWBlo9n1wt4EdeyYqnNn/l4n02QMOI45VZdvspZFK6h9uhls/3uWhMLrDqJpNd
 XVGg==
X-Gm-Message-State: AOJu0Yz7bdEfMqLEHGz7v1Ksy0IK02yNYlX2q/58qsYo9vsHRBPnlGww
 ICUlKlyWrkNceyVjQqC4AVKg4yla80YWfV4Riw8V9QZXleOCRjkkltueisfJXu346ZZqfiKRo5e
 1XERnrg8X4OkvSOyaRY4Sy2a6z9pro1JQYG8tWdcE
X-Gm-Gg: ATEYQzxe7hilSWoKl3lq/Y/vJtUWpbe5bih4UJQt2ACJUxua1PNGlcP7TSqlnh3pfeU
 r9pvpF97TizUCL3nA3h/seVa5wahxORwK+X6hlZs939LSE8MDyPv2LaGTMV7im5LBZM5B0K7awD
 pd8K90bfBu+T+MezXrGyOb/HcrB1y4KCUwjBVRsAr+ch1uTq6pn2X51Fwgikfw6PuxXBFX94x8c
 G8E3hvT8COkdHNTI9Ho2OP3U3PuIDvOWaP86SbOntEKVIhp3A29b5v8LNsXYtX/Rt6+F1yf4Rrz
 efMcpCGrSyyAweSJacX5+9kK1eMV8uttNudKqA==
X-Received: by 2002:a05:600c:4e14:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-4870f497b4fmr377175e9.0.1774308357801; Mon, 23 Mar 2026
 16:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260316125857.617836-1-jiri@resnulli.us>
 <20260316125857.617836-3-jiri@resnulli.us>
In-Reply-To: <20260316125857.617836-3-jiri@resnulli.us>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 23 Mar 2026 16:25:46 -0700
X-Gm-Features: AQROBzDCFwWsy0-ozjsBb2bwEOaZ0_wnDJdRRApw7r8ld8wpTu_Wh01I0Gdm1Bs
Message-ID: <CABdmKX0Ux2HMTTuOnvZryBBRwCjH0zUe-EMvL9k1VxZtz+BWiA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dma-buf: heaps: system: add system_cc_decrypted
 heap for explicitly decrypted memory
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
 jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
 linux-coco@lists.linux.dev
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

On Mon, Mar 16, 2026 at 5:59=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add a new "system_cc_decrypted" dma-buf heap to allow userspace to
> allocate decrypted (shared) memory for confidential computing (CoCo)
> VMs.
>
> On CoCo VMs, guest memory is encrypted by default. The hardware uses an
> encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
> Intel TDX) to control whether a given memory access is encrypted or
> decrypted. The kernel's direct map is set up with encryption enabled,
> so pages returned by alloc_pages() are encrypted in the direct map
> by default. To make this memory usable for devices that do not support
> DMA to encrypted memory (no TDISP support), it has to be explicitly
> decrypted. A couple of things are needed to properly handle
> decrypted memory for the dma-buf use case:
>
> - set_memory_decrypted() on the direct map after allocation:
>   Besides clearing the encryption bit in the direct map PTEs, this
>   also notifies the hypervisor about the page state change. On free,
>   the inverse set_memory_encrypted() must be called before returning
>   pages to the allocator. If re-encryption fails, pages
>   are intentionally leaked to prevent decrypted memory from being
>   reused as private.
>
> - pgprot_decrypted() for userspace and kernel virtual mappings:
>   Any new mapping of the decrypted pages, be it to userspace via
>   mmap or to kernel vmalloc space via vmap, creates PTEs independent
>   of the direct map. These must also have the encryption bit cleared,
>   otherwise accesses through them would see encrypted (garbage) data.
>
> - DMA_ATTR_CC_DECRYPTED for DMA mapping:
>   Since the pages are already decrypted, the DMA API needs to be
>   informed via DMA_ATTR_CC_DECRYPTED so it can map them correctly
>   as unencrypted for device access.
>
> On non-CoCo VMs, the system_cc_decrypted heap is not registered
> to prevent misuse by userspace that does not understand
> the security implications of explicitly decrypted memory.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v2->v3:
> - removed couple of leftovers from headers
> v1->v2:
> - fixed build errors on s390 by including mem_encrypt.h
> - converted system heap flag implementation to a separate heap
> ---
>  drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
>  1 file changed, 98 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> index b3650d8fd651..a525e9aaaffa 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -10,17 +10,25 @@
>   *     Andrew F. Davis <afd@ti.com>
>   */
>
> +#include <linux/cc_platform.h>
>  #include <linux/dma-buf.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dma-heap.h>
>  #include <linux/err.h>
>  #include <linux/highmem.h>
> +#include <linux/mem_encrypt.h>
>  #include <linux/mm.h>
> +#include <linux/set_memory.h>
>  #include <linux/module.h>
> +#include <linux/pgtable.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>
> +struct system_heap_priv {
> +       bool decrypted;
> +};

Hi Jiri,

I wonder if it'd better to call this cc_decrypted (or I guess
cc_shared based on Robin's comment in the previous patch) like the DMA
attr? There's a separate effort for "restricted" heaps with TEE for
(encrypted) video playback, which doesn't involve VMs or RDMA. I think
the cc_ prefix might help avoid any confusion between the usecase here
and restricted heaps.



> +
>  struct system_heap_buffer {
>         struct dma_heap *heap;
>         struct list_head attachments;
> @@ -29,6 +37,7 @@ struct system_heap_buffer {
>         struct sg_table sg_table;
>         int vmap_cnt;
>         void *vaddr;
> +       bool decrypted;
>  };
>
>  struct dma_heap_attachment {
> @@ -36,6 +45,7 @@ struct dma_heap_attachment {
>         struct sg_table table;
>         struct list_head list;
>         bool mapped;
> +       bool decrypted;
>  };
>
>  #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO)
> @@ -52,6 +62,34 @@ static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_O=
RDER_GFP, LOW_ORDER_GFP};
>  static const unsigned int orders[] =3D {8, 4, 0};
>  #define NUM_ORDERS ARRAY_SIZE(orders)
>
> +static int system_heap_set_page_decrypted(struct page *page)
> +{
> +       unsigned long addr =3D (unsigned long)page_address(page);
> +       unsigned int nr_pages =3D 1 << compound_order(page);
> +       int ret;
> +
> +       ret =3D set_memory_decrypted(addr, nr_pages);
> +       if (ret)
> +               pr_warn_ratelimited("dma-buf system heap: failed to decry=
pt page at %p\n",
> +                                   page_address(page));
> +
> +       return ret;
> +}
> +
> +static int system_heap_set_page_encrypted(struct page *page)
> +{
> +       unsigned long addr =3D (unsigned long)page_address(page);
> +       unsigned int nr_pages =3D 1 << compound_order(page);
> +       int ret;
> +
> +       ret =3D set_memory_encrypted(addr, nr_pages);
> +       if (ret)
> +               pr_warn_ratelimited("dma-buf system heap: failed to re-en=
crypt page at %p, leaking memory\n",
> +                                   page_address(page));
> +
> +       return ret;
> +}
> +
>  static int dup_sg_table(struct sg_table *from, struct sg_table *to)
>  {
>         struct scatterlist *sg, *new_sg;
> @@ -90,6 +128,7 @@ static int system_heap_attach(struct dma_buf *dmabuf,
>         a->dev =3D attachment->dev;
>         INIT_LIST_HEAD(&a->list);
>         a->mapped =3D false;
> +       a->decrypted =3D buffer->decrypted;
>
>         attachment->priv =3D a;
>
> @@ -119,9 +158,11 @@ static struct sg_table *system_heap_map_dma_buf(stru=
ct dma_buf_attachment *attac
>  {
>         struct dma_heap_attachment *a =3D attachment->priv;
>         struct sg_table *table =3D &a->table;
> +       unsigned long attrs;
>         int ret;
>
> -       ret =3D dma_map_sgtable(attachment->dev, table, direction, 0);
> +       attrs =3D a->decrypted ? DMA_ATTR_CC_DECRYPTED : 0;
> +       ret =3D dma_map_sgtable(attachment->dev, table, direction, attrs)=
;
>         if (ret)
>                 return ERR_PTR(ret);
>
> @@ -188,8 +229,13 @@ static int system_heap_mmap(struct dma_buf *dmabuf, =
struct vm_area_struct *vma)
>         unsigned long addr =3D vma->vm_start;
>         unsigned long pgoff =3D vma->vm_pgoff;
>         struct scatterlist *sg;
> +       pgprot_t prot;
>         int i, ret;
>
> +       prot =3D vma->vm_page_prot;
> +       if (buffer->decrypted)
> +               prot =3D pgprot_decrypted(prot);
> +
>         for_each_sgtable_sg(table, sg, i) {
>                 unsigned long n =3D sg->length >> PAGE_SHIFT;
>
> @@ -206,8 +252,7 @@ static int system_heap_mmap(struct dma_buf *dmabuf, s=
truct vm_area_struct *vma)
>                 if (addr + size > vma->vm_end)
>                         size =3D vma->vm_end - addr;
>
> -               ret =3D remap_pfn_range(vma, addr, page_to_pfn(page),
> -                               size, vma->vm_page_prot);
> +               ret =3D remap_pfn_range(vma, addr, page_to_pfn(page), siz=
e, prot);
>                 if (ret)
>                         return ret;
>
> @@ -225,6 +270,7 @@ static void *system_heap_do_vmap(struct system_heap_b=
uffer *buffer)
>         struct page **pages =3D vmalloc(sizeof(struct page *) * npages);
>         struct page **tmp =3D pages;
>         struct sg_page_iter piter;
> +       pgprot_t prot;
>         void *vaddr;
>
>         if (!pages)
> @@ -235,7 +281,10 @@ static void *system_heap_do_vmap(struct system_heap_=
buffer *buffer)
>                 *tmp++ =3D sg_page_iter_page(&piter);
>         }
>
> -       vaddr =3D vmap(pages, npages, VM_MAP, PAGE_KERNEL);
> +       prot =3D PAGE_KERNEL;
> +       if (buffer->decrypted)
> +               prot =3D pgprot_decrypted(prot);
> +       vaddr =3D vmap(pages, npages, VM_MAP, prot);
>         vfree(pages);
>
>         if (!vaddr)
> @@ -296,6 +345,14 @@ static void system_heap_dma_buf_release(struct dma_b=
uf *dmabuf)
>         for_each_sgtable_sg(table, sg, i) {
>                 struct page *page =3D sg_page(sg);
>
> +               /*
> +                * Intentionally leak pages that cannot be re-encrypted
> +                * to prevent decrypted memory from being reused.
> +                */
> +               if (buffer->decrypted &&
> +                   system_heap_set_page_encrypted(page))
> +                       continue;
> +
>                 __free_pages(page, compound_order(page));
>         }
>         sg_free_table(table);
> @@ -347,6 +404,8 @@ static struct dma_buf *system_heap_allocate(struct dm=
a_heap *heap,
>         DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>         unsigned long size_remaining =3D len;
>         unsigned int max_order =3D orders[0];
> +       struct system_heap_priv *priv =3D dma_heap_get_drvdata(heap);
> +       bool decrypted =3D priv->decrypted;
>         struct dma_buf *dmabuf;
>         struct sg_table *table;
>         struct scatterlist *sg;
> @@ -362,6 +421,7 @@ static struct dma_buf *system_heap_allocate(struct dm=
a_heap *heap,
>         mutex_init(&buffer->lock);
>         buffer->heap =3D heap;
>         buffer->len =3D len;
> +       buffer->decrypted =3D decrypted;
>
>         INIT_LIST_HEAD(&pages);
>         i =3D 0;
> @@ -396,6 +456,14 @@ static struct dma_buf *system_heap_allocate(struct d=
ma_heap *heap,
>                 list_del(&page->lru);
>         }
>
> +       if (decrypted) {
> +               for_each_sgtable_sg(table, sg, i) {
> +                       ret =3D system_heap_set_page_decrypted(sg_page(sg=
));
> +                       if (ret)
> +                               goto free_pages;
> +               }
> +       }
> +
>         /* create the dmabuf */
>         exp_info.exp_name =3D dma_heap_get_name(heap);
>         exp_info.ops =3D &system_heap_buf_ops;
> @@ -413,6 +481,13 @@ static struct dma_buf *system_heap_allocate(struct d=
ma_heap *heap,
>         for_each_sgtable_sg(table, sg, i) {
>                 struct page *p =3D sg_page(sg);
>
> +               /*
> +                * Intentionally leak pages that cannot be re-encrypted
> +                * to prevent decrypted memory from being reused.
> +                */
> +               if (buffer->decrypted &&
> +                   system_heap_set_page_encrypted(p))
> +                       continue;
>                 __free_pages(p, compound_order(p));
>         }
>         sg_free_table(table);
> @@ -428,6 +503,14 @@ static const struct dma_heap_ops system_heap_ops =3D=
 {
>         .allocate =3D system_heap_allocate,
>  };
>
> +static struct system_heap_priv system_heap_priv =3D {
> +       .decrypted =3D false,
> +};
> +
> +static struct system_heap_priv system_heap_cc_decrypted_priv =3D {
> +       .decrypted =3D true,
> +};
> +
>  static int __init system_heap_create(void)
>  {
>         struct dma_heap_export_info exp_info;
> @@ -435,8 +518,18 @@ static int __init system_heap_create(void)
>
>         exp_info.name =3D "system";
>         exp_info.ops =3D &system_heap_ops;
> -       exp_info.priv =3D NULL;
> +       exp_info.priv =3D &system_heap_priv;
> +
> +       sys_heap =3D dma_heap_add(&exp_info);
> +       if (IS_ERR(sys_heap))
> +               return PTR_ERR(sys_heap);
> +
> +       if (IS_ENABLED(CONFIG_HIGHMEM) ||
> +           !cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +               return 0;
>
> +       exp_info.name =3D "system_cc_decrypted";
> +       exp_info.priv =3D &system_heap_cc_decrypted_priv;
>         sys_heap =3D dma_heap_add(&exp_info);
>         if (IS_ERR(sys_heap))
>                 return PTR_ERR(sys_heap);
> --
> 2.51.1
>
