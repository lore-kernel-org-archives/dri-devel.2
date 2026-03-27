Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C39610F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9221810EEAD;
	Fri, 27 Mar 2026 19:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="KniBT4ti";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5AE10EE4C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:43:34 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48569636800so17395e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774640613; cv=none;
 d=google.com; s=arc-20240605;
 b=D5qFkRNjU/9oe1jxuR7dI5/4vE29YZTmjAjM7WgFXuveH5CSPrSei2JMg4una0bb5b
 GXzTkQpuhhGZPryLqvf97ltl7WPGjGTrO12jVpXTgzMZwv3GFb2AK8qcnRK5E9ty5+7A
 uq/p0Q8erY+g0J5C10V2KzgeDWuJdr1N8mMRcOaIUtcqK0JpVPLSLuDxnWOfsCrQC+ZZ
 zJK3gZELDcRYMTsF56DtnyDdtw4nEDoZP7TX85//Rj74LRvjpvXWPOGHqNumVpAwxhDA
 U60OJ+IRdm3XaKwUQQBuOMhUDP5sNXFkb9ij/UZh7aRx/vHKqztwFDpSGhUisakKqbCn
 kRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7tjhOfzQT3ZRSG3eV9w6+z7kzXwwNkzHiubxpA2Yl+8=;
 fh=sPkvoiVW1RBgQUxYl4/XdROFjqxLmkR3wF8LHkDYD0M=;
 b=KfWWk+F4snKGInOzFt9jCuY4xO21svckfanP49BWizsqd1eAlLaOYXgkzQIU5VcWOQ
 2EDGJN1/HYftZ14oFzJftA66+L4C2Z5IiTxZ8U6Xx0vlqD2O+vVl9dEUV3n0M0ot6Zfh
 VYm8t9CReMCInpsM2NXhRDqjRRpEKqOivxvZcOYS/d7r7EeaUy1/RGgZJpwtCy8pMDgy
 4STEQ5LwuIJA7ypsIzYNWImCWSc+gH66tpCJeJjFUeXqjTQsFEY3g/JZT5tcHUkM5AAT
 F+QzKRz/myIhPZZAmnGnowhhDUCLXRQXVCwh4/mQa4mxWTBa+Fa9xu12Ns/2FlESRS7o
 aIOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774640613; x=1775245413;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tjhOfzQT3ZRSG3eV9w6+z7kzXwwNkzHiubxpA2Yl+8=;
 b=KniBT4timD6glRwZZqKnkBc8s5zLhXmyTEOind5mzOSUG1v/H9kLvmG6Rq+/DZoJPb
 vuoAtx8KUkobkI79dVuuNfQrwBDYxeeD42I9RuCppR+m/qU4vzzTcWpe7mR4w6ve0LPn
 ftW/NyQ0XYlQ2BT9wz6nKrPt7df8dngJUiaKcPUhbs2tu8AwKHw8qK460UVp9pQ1qapW
 QLpwHIQ1HsYLoQidYliIv84lxvLHKM9cE25OSzX052lQv8gsW65Wg6dcKNRvHt/WtvLI
 Y7RyfGd2e1egB9bhxGU9eZe29YLcqrRx2FPabaYs49xVKf93E2pHvVWmpdb69T1luWZ6
 Npjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640613; x=1775245413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7tjhOfzQT3ZRSG3eV9w6+z7kzXwwNkzHiubxpA2Yl+8=;
 b=SDejmOiw2l2Rz0pRe55s/sdDwFc1oMDKHCE5lTNzfx7JRjaRvSolK0nCEa4+/5OByN
 ZPnoebTAgqPiUn2PokZK6odc8zITYP4HARcH3QBE+N/fbDiMzkA0FGr7jbQTWiH7VnHt
 kDHgguJgU5u4dEvLgGVS6czvBgRQXKPMiHugCGTHvoPuOJIolTB+bBrkdV6AR+qoWHqX
 fzMkEr4VG7iXot+lzsYqqh6Vrw8M7fAVJCns4MGiJ9mX38PdjplczWe3TWnperN1xgVb
 e0tUejCY7ylsSSbQlZMEvMsKeh9+7AQQWxi9iVkIER239kh0GhhU2oq/nj71i6c0E0ED
 p4/w==
X-Gm-Message-State: AOJu0YyOBVbDMwg6MOv07Hag2aTEmcxicpVCtT51cWINotaE34soUSn2
 gLrAw1vLGtZk2Vcj4D0UqHYA+QbbjcxAdm6C2Cljg46yotneQNbebEIVLd3sQYmWvMIB2uhnm1e
 s3+mRLbn86nnoPWYuTL4ovpvpNxP1mhXlX40+rvQF
X-Gm-Gg: ATEYQzzPVQCFfiNz7FcA9ZLoPRAtTiFd7owj0RrrydcJhKp1f5MfUyijNxabp7UXWwe
 KdkmY1QQjF+YZawDGdseRPbTQEkOtQN1w07czaoNGsZWsHyyf0D90XKSSDW4UwC4Ju7sJQM+2/X
 3P1U7qEfjaKtk9UvMKYVjQx9TK1Cm9g+usRx1A052OoUsUAbqMka4kTfP2Tf/uK5yqyFkQRigla
 0m63Jt/gmR41wRa1dIoTzQoYMWfH0q8u0pGnKt2Xhf06CgfmwmsjiBYzb+TCzC0YqzVbS4+vtL/
 mOzEktiBDdlv8wY9iEsWKJk25Bo2znntw2aDbjsUI4MOIx83QYrzLBZNAbTw42L8N1AI
X-Received: by 2002:a05:600c:898:b0:483:6a76:11a6 with SMTP id
 5b1f17b1804b1-4872fb4af58mr49025e9.5.1774640612616; Fri, 27 Mar 2026 12:43:32
 -0700 (PDT)
MIME-Version: 1.0
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-3-jiri@resnulli.us>
In-Reply-To: <20260325192352.437608-3-jiri@resnulli.us>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 27 Mar 2026 12:43:20 -0700
X-Gm-Features: AQROBzBYesqFRGc3W9I0GrvLQe43hwnK276StdxFy-fmLYpUjceKHOTqIZ5lfxQ
Message-ID: <CABdmKX2G-RavjPxmeTH4iiawNqN8ronj5dytYxKTYRJvtDXoFg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dma-buf: heaps: system: add system_cc_shared heap
 for explicitly shared memory
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

On Wed, Mar 25, 2026 at 12:23=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add a new "system_cc_shared" dma-buf heap to allow userspace to
> allocate shared (decrypted) memory for confidential computing (CoCo)
> VMs.
>
> On CoCo VMs, guest memory is private by default. The hardware uses an
> encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
> Intel TDX) to control whether a given memory access is private or
> shared. The kernel's direct map is set up as private,
> so pages returned by alloc_pages() are private in the direct map
> by default. To make this memory usable for devices that do not support
> DMA to private memory (no TDISP support), it has to be explicitly
> shared. A couple of things are needed to properly handle
> shared memory for the dma-buf use case:
>
> - set_memory_decrypted() on the direct map after allocation:
>   Besides clearing the encryption bit in the direct map PTEs, this
>   also notifies the hypervisor about the page state change. On free,
>   the inverse set_memory_encrypted() must be called before returning
>   pages to the allocator. If re-encryption fails, pages
>   are intentionally leaked to prevent shared memory from being
>   reused as private.
>
> - pgprot_decrypted() for userspace and kernel virtual mappings:
>   Any new mapping of the shared pages, be it to userspace via
>   mmap or to kernel vmalloc space via vmap, creates PTEs independent
>   of the direct map. These must also have the encryption bit cleared,
>   otherwise accesses through them would see encrypted (garbage) data.
>
> - DMA_ATTR_CC_SHARED for DMA mapping:
>   Since the pages are already shared, the DMA API needs to be
>   informed via DMA_ATTR_CC_SHARED so it can map them correctly
>   as unencrypted for device access.
>
> On non-CoCo VMs, the system_cc_shared heap is not registered
> to prevent misuse by userspace that does not understand
> the security implications of explicitly shared memory.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
