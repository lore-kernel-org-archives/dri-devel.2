Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A4BCC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3945C10E415;
	Tue, 13 Oct 2026 17:04:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93D810E415
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:04:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 738A0402F5;
 Tue, 13 Oct 2026 17:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B671F000FF;
 Tue, 13 Oct 2026 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791911087;
 bh=trYYkzD1fUs2CPyc6avA9Aj89H9HqMjaP7lJEkleLw0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MHhpxNma2+XUsPMVZHnq8rTIQWBMavytXojW7y5vd4gUuugEqYGxdRuV8qU3XwwYP
 AZIcUXMjujc/YsJgY2YU2XxNRApLORzKbQf/yHrrteWGOgGShuuyE6iQIMpclWNS3w
 iBu8BkqypB5Qp8HrYKusRxuaM9ENB7F1tMjDaVI9D9tXByX9d20zvGote51RlW3ZIi
 puL/us9LlgbOPGp9XUjcvtSCKVw6sfSHlid6LvnpsM8NjjNsDZn5IcPWGiXUKAclZ6
 WZeLj0Pe2LX9+pKUcFKBE9SkSrg/kSXHF+dOQAhq42r5Jv3UV3/GL4QA4TIm7aopsI
 8Ju3bft2ogs+g==
Message-ID: <sashiko-outbox-170187@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/39] infiniband: update hfi1 to use
 remap_vmalloc_range()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-11-1aa3c9b139f9@kernel.org>
References: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-0-1aa3c9b139f9@kernel.org>
 <20261013-b4-mmap-prepare-vma-flag-sanify-v6-11-1aa3c9b139f9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:04:45 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: VM_WARN_ON_ONCE triggered by vm_flags_reset() in mmap hook
--

commit a356d47e4beede9d3e032c777130976d06dd5dd8
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

    infiniband: update hfi1 to use remap_vmalloc_range()
   =20
    In cases which map chip memory from vmalloc()'d ranges, the hfi1 infini=
band
    drivers currently installs a fault handler, and then smuggles the kernel
    virtual address of this range in vma->vm_pgoff.

> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/h=
w/hfi1/file_ops.c
> index dc548e6802e24..b02d1f1dbb27b 100644
> --- a/drivers/infiniband/hw/hfi1/file_ops.c
> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
[ ... ]
> @@ -422,7 +418,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_=
area_struct *vma)
>  			ret =3D -EPERM;
>  			goto done;
>  		}
> -		vm_flags_clear(vma, VM_MAYWRITE);
> +		vm_flags_mod(vma, VM_DONTEXPAND, VM_MAYWRITE);
>  		/*
>  		 * Mmap multiple separate allocations into a single vma.  From
>  		 * here, dma_mmap_coherent() calls dma_direct_mmap(), which
[ ... ]
> @@ -559,12 +546,10 @@ static int hfi1_file_mmap(struct file *fp, struct v=
m_area_struct *vma)
>  	}
> =20
>  	vm_flags_reset(vma, flags);
> -	mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr, memvirt, memdma,=20
> +	mmap_cdbg(ctxt, subctxt, type, mapio, is_vmalloc, memaddr, memvirt, mem=
dma,
>  		  memlen, vma);
> -	if (vmf) {
> -		vma->vm_pgoff =3D PFN_DOWN(memaddr);
> -		vma->vm_ops =3D &vm_ops;
> -		ret =3D 0;
> +	if (is_vmalloc) {
> +		ret =3D remap_vmalloc_range(vma, memvirt, 0);

[Severity: Medium]
Will this trigger a lockdep warning due to the VMA not being write-locked?

In hfi1_file_mmap(), modifying the VMA flags using vm_flags_reset() (and
the newly introduced vm_flags_mod() earlier in this function) enforces=20
write-lock assertions via vma_assert_write_locked().=20

Because the VMA is not yet inserted into the tree and is not write-locked=20
during the mmap callback, its vm_lock_seq is uninitialized (UINT_MAX) and=20
will not match the mm lock sequence. This triggers a VM_WARN_ON_ONCE_VMA.

Should vm_flags_init() be used instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-mmap-pr=
epare-vma-flag-sanify-v6-0-1aa3c9b139f9@kernel.org?part=3D11
