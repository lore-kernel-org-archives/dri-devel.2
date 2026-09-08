Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BE9C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9385810ED8E;
	Tue,  8 Sep 2026 20:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K7/dUd9G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A2310ED8E
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:45:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BAF24147B;
 Tue,  8 Sep 2026 20:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39021F00A3A;
 Tue,  8 Sep 2026 20:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900333;
 bh=LG3j4gE7ldemd+Dz5YDZ3pNh4yAUNQomOC0AFet+F64=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K7/dUd9GqMcbXdFhyJVTslN73aAhJW1HfNTyK3o5UzoC1efA49lqbS0mIredigrCa
 w5QEaE2CSjZDyJCreoXNzMyobDPMYOSnXzoN4CrtfFqY2Ivvu6qfb4VabSCZikn/Vt
 dDeZOEMFXO8x3qCG0Kf5gFwFzO/4n9UIunVjzxuc1wICpEWpLWCGSvjQri5hl4n8Kx
 axg9Wrsd2dzM07Y3N6sIiKd+nrgZsLkA5kue8OpehjSEHb9X68B8y8SvBmTrBmqWLQ
 TPItx1ytI0ONKmkY4G3sEgnsGJstMjuNTsue8ejlmJyRo4wPmsGF5O+jhwUxFurU81
 KJwTBcVzhwMUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/39] ALSA: pcm: use vm_insert_page() to map PCM status
 page
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 bpf@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 selinux@vger.kernel.org, linux-scsi@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-12-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-12-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:45:31 +0000
Message-Id: <20260908204531.D39021F00A3A@smtp.kernel.org>
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
- [High] Eager PTE insertion via `vm_insert_page()` during the `mmap` callb=
ack uses a stale `vm_page_prot`, inadvertently granting userspace write acc=
ess to the kernel-owned ALSA status page.
--

commit 31ad2114dee595c7dfa978aa004add8157e4aa43
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

ALSA: pcm: use vm_insert_page() to map PCM status page

This commit replaces the fault handler for the PCM status page mapping
with a direct vm_insert_page() call during the mmap callback. It also
ensures the VM_MAYWRITE flag is cleared so the status page remains
kernel-owned and read-only to userspace.

> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 62324282fcae9..37a157d558325 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
[ ... ]
> @@ -3760,39 +3760,26 @@ static __poll_t snd_pcm_poll(struct file *file, p=
oll_table *wait)
[ ... ]
> -static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, stru=
ct file *file,
> -			       struct vm_area_struct *area)
> +static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, stru=
ct file *file,
> +			       struct vm_area_struct *vma)
>  {
[ ... ]
> -	vm_flags_mod(area, VM_DONTEXPAND | VM_DONTDUMP,
> +
> +	vm_flags_mod(vma, VM_DONTEXPAND | VM_DONTDUMP,
>  		     VM_WRITE | VM_MAYWRITE);
> =20
> -	return 0;
> +	runtime =3D substream->runtime;
> +	page =3D virt_to_page(runtime->status);
> +	return vm_insert_page(vma, vma->vm_start, page);

[Severity: High]
Does this eager PTE insertion inadvertently grant userspace write access to
the kernel-owned ALSA status page?

When a user requests mmap with PROT_WRITE, the core MM's mmap_region()
initializes vma->vm_page_prot with hardware write permissions.

This driver callback clears VM_WRITE and VM_MAYWRITE from vma->vm_flags
using vm_flags_mod(). However, vm_flags_mod() modifies only the software
VMA flags and does not update vma->vm_page_prot.

The callback then eagerly populates the page table by calling
vm_insert_page(). This function reads the unmodified, still-writable
vma->vm_page_prot and installs a writable hardware PTE.

Only after the driver callback returns does the core MM invoke
vma_set_page_prot() via __mmap_complete() to recalculate the protection
based on the new flags. But by then, the PTE is already populated with the
stale writable protection, allowing kernel state corruption.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D12
