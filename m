Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58764C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA16F10ED3E;
	Wed,  5 Aug 2026 07:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O2RpFSjG";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7C510EA87
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 14:58:05 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso5789045a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 07:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785855485; cv=none;
 d=google.com; s=arc-20260327;
 b=AfNQ9n84DX7RSeTjDtbA1JnbLjIYdVFQv4N2IZOgitT34fGL/Xy5XAx//z9Wze1VUz
 dFya2lvu16P9vKmlKJLj9ae3Lq16fk6FnvwxiCXyQB6JJoLVtp8EbbhgMT9cxBG012pV
 mvvy8aWBHnTWdzQMLjA7+t0GQF1FKAIDdea3B+qg6cqRVd0RBh6Z6j684EWl0KfS3C8k
 m4ZVWS9h0TvkOaE5vxxSw65yI0t7NA+w4zE6kvBVXy13zSNPOmmeEPF9ibjJteiFpGjn
 CYqICYfNyy9kMGzFvHPcDfMm5eL0qXAV1XvKYPmBdLHr8lhfbCfAC4FpbBGwTjIcF1G3
 BmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZXmm83TGVs8V0++ogZvMrKHltLz+j+PoXOcZxjRNY7o=;
 fh=MS+OqKK6dm3nYaouVu/qHU48Eb/c+QnwJFy3R6preLA=;
 b=Jx//KTayT7a2wPDlpUT6tW/wkYsGd/WG42eEsEUvnrubuQLqA12iKExGNxxh2Fc7iB
 lM0LY3xLqmYh9Ej55qeoZHDvq0KeINDNarvuVke1oWRuhhgjcNI6GgPwtY7KpcDEQbVJ
 6VKGSW8/b9pzCFQ4rSPfDNimn/6CaA4raU3VwWP3z4adZvM0vj56UBrNyvJQCQi2i3Z0
 8Q54abMBj1QeZ6dzrL+yRH0XDvhReV6d4wxjcL+RQ3b7YmPjdliwbR47+ID441V7kFQx
 EdOsmDLp5YBZO36DIYoDt+5WSlMoztH/AKgWzpJvjmHS9ihvu/yBu5N74x3DgU5bjDd9
 A+iA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785855485; x=1786460285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZXmm83TGVs8V0++ogZvMrKHltLz+j+PoXOcZxjRNY7o=;
 b=O2RpFSjGpwtalKSmLASEgwC8l8khzeXYVPrFFIuIQRYvvLR2dv72ztipfe34K2rL0i
 jS9kereRunrKxVX+W3p6kdXc54Uu1dF0e0ntNFQvSrMT9cB3q9U5mguIU6xKGDhB6Erf
 Q0dI5MWP0GkrUETBL2qxdJBkFrofVBXwTbpi73dlrWYoXdRryZ/v112586mOcDcM7UTH
 IXX2DyLx7u+AmgS71BYrsCVZ0G9n6GJ/N5MKera4FpC+AMvpXSOh52SBmsbZ8P/yV2i3
 BkdAYC0aPTvKN7nI4MDHpVVg76kAXOV1VFF5sfmwKRifhd2PgZ64YTfRbXTCYeLx5EUh
 cYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785855485; x=1786460285;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZXmm83TGVs8V0++ogZvMrKHltLz+j+PoXOcZxjRNY7o=;
 b=suzjJ/hZ7aeJHJ0GY+t3/f/1xdDqztoIafZCl6GQXsFCqTypcfLE6GxWyc/ee7xGwR
 PcCpO/WzENhEGFl7P0PxLqLxbYxEI3iuegMGb0zdfgvdwMv1455gdbS46baLaLLzT6S8
 t2dD4L4l7U2k+IWPE2JU6+LFoP/nfcTNt49zzS9AzgMLXI9bSTvDSSOrRryp2677qYgk
 GgFZkwKKzjVc9vaI7eewhJlTPEjuRRI/Bh82Jq/HUOsj/VZQxnCfkIWIBTUoeEEWAdNX
 3ew7yg+Sgsgf8xIFcwp+0t5T1BrOfX0UKHwjuWjpdc729eSb0Y/8SKlruGbIWWoVmKG2
 UnGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxECr0Lvjx0sxwL89HUGN8De5zYsHqw7V/wCMxXmkuo0drKCGaDs+AsydO6MA99UpkPidi5lQy0fg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsOfJvrAsmHDgHYm7awwTh7P10hkQ/r/UfFIQmQrZ+5YKehrH2
 S52l1AcRlM5gM+1IxILMLaaQa78tsaDLci2A/6dCIdC7uWfkOTVJrh3xpwmWpktuecXIB8tFQqB
 QUtbHWxX6uj6pXGZCaF8I9xqquITjVMA=
X-Gm-Gg: AR+sD11rj8F0ecG2wIaxv9qwZnzxHPZxTSv34EqG/pVp+9SveWPFENXx47yzmTOCnQp
 J2W61mn1mQ6YaO9fLMRlbTMzn54GfFKzara2mOv2DWFd2SX9PjUJ2GM0FllbwC8ATmqWDX7/N23
 RE+CCuI9fwGgfVggOz6BlDjkc2nazWv8sYVp9Rivm4WNI+y8wp+gRLvU692DB+vWC7Aano7jRgc
 zKS2txTPBNy8InCHykZZWBpYx+6WZgxfv/N4vUKaIPw9TxVcRxpjT0JWZRhKngQtYCo8tNSKITn
 MDqcfib3Fct155mtNw1tTs8v6xJk8IQ7xodMqLnHJTvYqJ6o1xrn+XAdXrmCRAffpRmdjmBnG2Z
 h5q0PzZLyQb4CCh3BzuO3ZMU=
X-Received: by 2002:a17:90b:1c86:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38fbc4249efmr13503882a91.10.1785855484729; Tue, 04 Aug 2026
 07:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260804140403.16337-1-kfastov@gmail.com>
 <20260804162924.0268f80a@fedora-21.home>
In-Reply-To: <20260804162924.0268f80a@fedora-21.home>
From: Konstantin Fastov <kfastov@gmail.com>
Date: Tue, 4 Aug 2026 17:57:52 +0300
X-Gm-Features: AUfX_mxmYF7mTsV_kCbKDVkg1SSi2DOX7EMuysDet_SV7d52zqlljQHcxRDaOHk
Message-ID: <CABWhNekebS6dt=Ft+74iG4YpCq-5ZcV1EvvERNxT612VUOC9Ww@mail.gmail.com>
Subject: Re: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:24:24 +0000
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

Hello Boris,

=D0=B2=D1=82, 4 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 17:29, Bori=
s Brezillon <boris.brezillon@collabora.com>:
>
> Hello Konstantin,
>
> On Tue,  4 Aug 2026 17:04:03 +0300
> Konstantin Fastov <kfastov@gmail.com> wrote:
>
> > Since the introduction of dirty tracking, drm_gem_shmem_vm_ops has a
> > .pfn_mkwrite handler.  Its presence makes vma_wants_writenotify() true,
> > so vma_set_page_prot() removes the write bit from vm_page_prot of
> > shared mappings, and the vmf_insert_pfn() call in the fault handler now
> > installs read-only PTEs even when serving a write fault.
> >
> > For regular CPU accesses this is transparent: the retried access faults
> > again on the present read-only PTE, goes through wp_pfn_shared() into
> > .pfn_mkwrite() and the PTE is upgraded to writable.  But consumers that
> > resolve faults through fixup_user_fault() + follow_pfnmap_start()
> > perform no such retry.  In particular KVM's hva_to_pfn_remapped(),
> > after "successfully" handling a write fault, finds a present read-only
> > PTE, treats it as KVM_PFN_ERR_RO_FAULT and fails the vcpu run with
> > EFAULT.  Observed as AsahiLinux/linux#560: muvm/libkrun microVMs
> > mapping virtio-gpu blob resources die with EFAULT on first GPU access.
> > The traced failing sequence:
> >
> >   follow_pfnmap_start()        -> -EINVAL   (no PTE yet)
> >   fixup_user_fault(WRITE)
> >     drm_gem_shmem_fault()
> >       vmf_insert_pfn()         -> NOPAGE    (read-only PTE installed)
> >   fixup_user_fault()           -> 0         (fault "handled")
> >   follow_pfnmap_start()        -> 0, !writable
> >   hva_to_pfn()                 -> KVM_PFN_ERR_RO_FAULT
> >
> > Fix it the same way commit cb2a2a5b37ad ("drm/shmem_helper: Make sure
> > PMD entries get the writeable upgrade") did for the PMD path: when the
> > fault is a write fault, install a writable entry directly and record
> > the write for dirty tracking, instead of relying on a refault that not
> > every fault-resolution path performs.
> >
> > To do that at PTE level, add vmf_insert_pfn_mkwrite(), the VM_PFNMAP
> > counterpart of vmf_insert_mixed_mkwrite(): insert_pfn() already
> > implements the mkwrite semantics, there was just no wrapper exposing it
> > for pfn inserts with the default pgprot.
>
> The same issue is being discussed here [1].
>
> Regards,
>
> Boris
>
> [1]https://lore.kernel.org/dri-devel/20260804120529.1730187-1-pbonzini@re=
dhat.com/

Thanks, I missed that series, I searched dri-devel but not the kvm list.
Paolo's patches 1-2 are indeed the same fix (down to the same function
name), so please consider my patch superseded by his series.

I have a fast reproducer on Apple Silicon (Asahi, muvm microVM, dies in
under a second on stock 7.1.5) and an automated test rig, so I'll run
Paolo's full series on that hardware and follow up with Tested-by in his
thread.

Thanks,
Konstantin
