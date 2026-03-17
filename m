Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A96FED9F8
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD5F89083;
	Tue, 17 Mar 2026 17:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bmwffuC/";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE8410E550
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773768658;
 bh=U9CnMYSQ1Z+XBYqpSMqTX6JFNfnOGbn5Km7HbbDR/Bc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bmwffuC/py797z2nNDPkvTDf1oy0xdpwnQeYDQB/BHClI3v1LUX/QTxjWQAUDKmS4
 qu+bFArzvUNCfE62NDZWZ5sZCpR/st4JYDhjZxv2aG+dIV6YsKZQgj5oc8xDFJslCr
 QT3r4WzAcVE+awQUWAN8dRrhiWd9gM1w2GenSTlOCvOLTeC1QDPn8tMy/bOoUbOyjr
 jbxAhsEK3gD1+wkU94RjBHKyoPsvGxyYehGY4vHiQgnG6l3z+TDVHnNhl+CzZFqKJZ
 PG+ilvm/0pvDLKch0Ft+r4S4xXzeP8VNlo6P2StdOngmqGVRxpIklLWVh4V7quWZyV
 PdWYypB68WrRA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 227CA17E1005;
 Tue, 17 Mar 2026 18:30:58 +0100 (CET)
Date: Tue, 17 Mar 2026 18:30:54 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/shmem-helper: Fix Map huge page mapping in fault
 handler
Message-ID: <20260317183054.5d7030ec@fedora>
In-Reply-To: <20260316152152.1e20d35e@fedora>
References: <20260316002649.211819-1-pedrodemargomes@gmail.com>
 <20260316152152.1e20d35e@fedora>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 16 Mar 2026 15:21:52 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Sun, 15 Mar 2026 21:26:49 -0300
> Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:
> 
> > When running ./tools/testing/selftests/mm/split_huge_page_test multiple
> > times with /sys/kernel/mm/transparent_hugepage/shmem_enabled and
> > /sys/kernel/mm/transparent_hugepage/enabled set as always the following BUG
> > occurs:
> > 
> > [  232.728858] ------------[ cut here ]------------
> > [  232.729458] kernel BUG at mm/memory.c:2276!
> > [  232.729726] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> > [  232.730217] CPU: 19 UID: 60578 PID: 1497 Comm: llvmpipe-9 Not tainted 7.0.0-rc1mm-new+ #19 PREEMPT(lazy)
> > [  232.730855] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
> > [  232.731360] RIP: 0010:walk_to_pmd+0x29e/0x3c0
> > [  232.731569] Code: d8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 89 ea 48 89 de 4c 89 f7 e8 ae 85 ff ff 85 c0 0f 84 1f fe ff ff 31 db eb d0 <0f> 0b 48 89 ea 48 89 de 4c 89 f7 e8 92 8b ff ff 85 c0 75 e8 48 b8
> > [  232.732614] RSP: 0000:ffff8881aa6ff9a8 EFLAGS: 00010282
> > [  232.732991] RAX: 8000000142e002e7 RBX: ffff8881433cae10 RCX: dffffc0000000000
> > [  232.733362] RDX: 0000000000000000 RSI: 00007fb47840b000 RDI: 8000000142e002e7
> > [  232.733801] RBP: 00007fb47840b000 R08: 0000000000000000 R09: 1ffff110354dff46
> > [  232.734168] R10: fffffbfff0cb921d R11: 00000000910da5ce R12: 1ffffffff0c1fcdd
> > [  232.734459] R13: 1ffffffff0c23f36 R14: ffff888171628040 R15: 0000000000000000
> > [  232.734861] FS:  00007fb4907f86c0(0000) GS:ffff888791f2c000(0000) knlGS:0000000000000000
> > [  232.735265] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  232.735548] CR2: 00007fb47840be00 CR3: 000000015e6dc000 CR4: 00000000000006f0
> > [  232.736031] Call Trace:
> > [  232.736273]  <TASK>
> > [  232.736500]  get_locked_pte+0x1f/0xa0
> > [  232.736878]  insert_pfn+0x9f/0x350
> > [  232.737190]  ? __pfx_pat_pagerange_is_ram+0x10/0x10
> > [  232.737614]  ? __pfx_insert_pfn+0x10/0x10
> > [  232.737990]  ? __pfx_css_rstat_updated+0x10/0x10
> > [  232.738281]  ? __pfx_pfn_modify_allowed+0x10/0x10
> > [  232.738552]  ? lookup_memtype+0x62/0x180
> > [  232.738761]  vmf_insert_pfn_prot+0x14b/0x340
> > [  232.739012]  ? __pfx_vmf_insert_pfn_prot+0x10/0x10
> > [  232.739247]  ? __pfx___might_resched+0x10/0x10
> > [  232.739475]  drm_gem_shmem_fault.cold+0x18/0x39
> > [  232.739677]  ? rcu_read_unlock+0x20/0x70
> > [  232.739882]  __do_fault+0x251/0x7b0
> > [  232.740028]  do_fault+0x6e1/0xc00
> > [  232.740167]  ? __lock_acquire+0x590/0xc40
> > [  232.740335]  handle_pte_fault+0x439/0x760
> > [  232.740498]  ? mtree_range_walk+0x252/0xae0
> > [  232.740669]  ? __pfx_handle_pte_fault+0x10/0x10
> > [  232.740899]  __handle_mm_fault+0xa02/0xf30
> > [  232.741066]  ? __pfx___handle_mm_fault+0x10/0x10
> > [  232.741255]  ? find_vma+0xa1/0x120
> > [  232.741403]  handle_mm_fault+0x2bf/0x8f0
> > [  232.741564]  do_user_addr_fault+0x2d3/0xed0
> > [  232.741736]  ? trace_page_fault_user+0x1bf/0x240
> > [  232.741969]  exc_page_fault+0x87/0x120
> > [  232.742124]  asm_exc_page_fault+0x26/0x30
> > [  232.742288] RIP: 0033:0x7fb4d73ed546
> > [  232.742441] Code: 66 41 0f 6f fb 66 44 0f 6d dc 66 44 0f 6f c6 66 41 0f 6d f1 66 0f 6c fc 66 45 0f 6c c1 66 44 0f 6f c9 66 0f 6d ca 66 0f db f0 <66> 0f df 04 08 66 44 0f 6c ca 66 45 0f db c2 66 44 0f df 10 66 44
> > [  232.743193] RSP: 002b:00007fb4907f68a0 EFLAGS: 00010206
> > [  232.743565] RAX: 00007fb47840aa00 RBX: 00007fb4d73ec070 RCX: 0000000000001400
> > [  232.743871] RDX: 0000000000002800 RSI: 0000000000003c00 RDI: 0000000000000001
> > [  232.744150] RBP: 0000000000000004 R08: 0000000000001400 R09: 00007fb4d73ec060
> > [  232.744433] R10: 000055f0261a4288 R11: 00007fb4c013da40 R12: 0000000000000008
> > [  232.744712] R13: 0000000000000000 R14: 4332322132212110 R15: 0000000000000004
> > [  232.746616]  </TASK>
> > [  232.746711] Modules linked in: nft_nat nft_masq veth bridge stp llc snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore overlay rfkill nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr ppdev 9pnet_virtio 9pnet parport_pc i2c_piix4 netfs pcspkr parport i2c_smbus joydev sunrpc vfat fat loop dm_multipath nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport zram lz4hc_compress vmw_vmci lz4_compress vsock e1000 bochs serio_raw ata_generic pata_acpi scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse qemu_fw_cfg
> > [  232.749308] ---[ end trace 0000000000000000 ]---
> > [  232.749507] RIP: 0010:walk_to_pmd+0x29e/0x3c0
> > [  232.749692] Code: d8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 89 ea 48 89 de 4c 89 f7 e8 ae 85 ff ff 85 c0 0f 84 1f fe ff ff 31 db eb d0 <0f> 0b 48 89 ea 48 89 de 4c 89 f7 e8 92 8b ff ff 85 c0 75 e8 48 b8
> > [  232.750428] RSP: 0000:ffff8881aa6ff9a8 EFLAGS: 00010282
> > [  232.750645] RAX: 8000000142e002e7 RBX: ffff8881433cae10 RCX: dffffc0000000000
> > [  232.750954] RDX: 0000000000000000 RSI: 00007fb47840b000 RDI: 8000000142e002e7
> > [  232.751232] RBP: 00007fb47840b000 R08: 0000000000000000 R09: 1ffff110354dff46
> > [  232.751514] R10: fffffbfff0cb921d R11: 00000000910da5ce R12: 1ffffffff0c1fcdd
> > [  232.751837] R13: 1ffffffff0c23f36 R14: ffff888171628040 R15: 0000000000000000
> > [  232.752124] FS:  00007fb4907f86c0(0000) GS:ffff888791f2c000(0000) knlGS:0000000000000000
> > [  232.752441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  232.752674] CR2: 00007fb47840be00 CR3: 000000015e6dc000 CR4: 00000000000006f0
> > [  232.752983] Kernel panic - not syncing: Fatal exception
> > [  232.753510] Kernel Offset: disabled
> > [  232.754643] ---[ end Kernel panic - not syncing: Fatal exception ]---
> > 
> > This happens when two concurrent page faults occur within the same PMD range.
> > One fault installs a PMD mapping through vmf_insert_pfn_pmd(), while the other
> > attempts to install a PTE mapping via vmf_insert_pfn(). The bug is
> > triggered because a pmd_trans_huge is not expected when walking the page
> > table inside vmf_insert_pfn.
> > 
> > Avoid this race by adding a huge_fault callback to drm_gem_shmem_vm_ops so that
> > PMD-sized mappings are handled through the appropriate huge page fault path.
> > 
> > Fixes: 211b9a39f261 ("drm/shmem-helper: Map huge pages in fault handler")
> > Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> > ---
> > 
> > Changes in v3:
> >  - Pass a try_pmd boolean parameter to drm_gem_shmem_any_fault
> >  - Compile drm_gem_shmem_huge_fault only if CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> > is defined to avoid a build warning
> > 
> > Changes in v2: https://lore.kernel.org/dri-devel/20260313141719.3949700-1-pedrodemargomes@gmail.com/
> >  - Keep the #ifdef unindented
> >  - Create drm_gem_shmem_any_fault to handle faults of any order and use
> > drm_gem_shmem_[huge_]fault() as wrappers
> > 
> > v1: https://lore.kernel.org/all/20260312155027.1682606-1-pedrodemargomes@gmail.com/  
> 
> I've played a bit with the drm-misc-{next,fixes} versions (with the extra
> pfn_mkwrite fixes on top for the -next variant), and below is my preferred
> version (pfn insertion is all handled inside the try_insert_pfn() helper,
> with order == PMD_ORDER specialized there).

One last thing, the subject should probably be "drm/shmem-helper: Fix
huge page mapping in fault handler" (instead of "Fix Map huge page
..."). Pedro, do you think you'll be able to send a v4 before the end
of the week? I'd really like to have that fix in -rc5 or -rc6.

> 
> --->8---  
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 7b5a49935ae4..f549cc040c7a 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -550,27 +550,27 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
>  
> -static bool drm_gem_shmem_try_map_pmd(struct vm_fault *vmf, unsigned long addr,
> -                                     struct page *page)
> +static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order, unsigned long pfn)
>  {
> +       if (!order) {
> +               return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
>  #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> -       unsigned long pfn = page_to_pfn(page);
> -       unsigned long paddr = pfn << PAGE_SHIFT;
> -       bool aligned = (addr & ~PMD_MASK) == (paddr & ~PMD_MASK);
> +       } else if (order == PMD_ORDER) {
> +               unsigned long paddr = pfn << PAGE_SHIFT;
> +               bool aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
>  
> -       if (aligned &&
> -           pmd_none(*vmf->pmd) &&
> -           folio_test_pmd_mappable(page_folio(page))) {
> -               pfn &= PMD_MASK >> PAGE_SHIFT;
> -               if (vmf_insert_pfn_pmd(vmf, pfn, false) == VM_FAULT_NOPAGE)
> -                       return true;
> -       }
> +               if (aligned &&
> +                   folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
> +                       pfn &= PMD_MASK >> PAGE_SHIFT;
> +                       return vmf_insert_pfn_pmd(vmf, pfn, false);
> +               }
>  #endif
> +       }
>  
> -       return false;
> +       return VM_FAULT_FALLBACK;
>  }
>  
> -static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
> +static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned int order)
>  {
>         struct vm_area_struct *vma = vmf->vma;
>         struct drm_gem_object *obj = vma->vm_private_data;
> @@ -581,6 +581,9 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>         pgoff_t page_offset;
>         unsigned long pfn;
>  
> +       if (order && order != PMD_ORDER)
> +               return VM_FAULT_FALLBACK;
> +
>         /* Offset to faulty address in the VMA. */
>         page_offset = vmf->pgoff - vma->vm_pgoff;
>  
> @@ -593,13 +596,8 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>                 goto out;
>         }
>  
> -       if (drm_gem_shmem_try_map_pmd(vmf, vmf->address, pages[page_offset])) {
> -               ret = VM_FAULT_NOPAGE;
> -               goto out;
> -       }
> -
>         pfn = page_to_pfn(pages[page_offset]);
> -       ret = vmf_insert_pfn(vma, vmf->address, pfn);
> +       ret = try_insert_pfn(vmf, order, pfn);
>  
>   out:
>         dma_resv_unlock(shmem->base.resv);
> @@ -607,6 +605,11 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>         return ret;
>  }
>  
> +static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
> +{
> +       return drm_gem_shmem_any_fault(vmf, 0);
> +}
> +
>  static void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
>  {
>         struct drm_gem_object *obj = vma->vm_private_data;
> @@ -643,6 +646,9 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
>  
>  const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>         .fault = drm_gem_shmem_fault,
> +#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> +       .huge_fault = drm_gem_shmem_any_fault,
> +#endif
>         .open = drm_gem_shmem_vm_open,
>         .close = drm_gem_shmem_vm_close,
>  };

