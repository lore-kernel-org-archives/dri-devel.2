Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1C606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6VZme/I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA4C10F90E;
	Tue, 17 Nov 2026 20:03:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 596DC10F90E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:02:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 698586182E;
 Tue, 17 Nov 2026 20:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39EB1F000C5;
 Tue, 17 Nov 2026 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794945775;
 bh=RW+pxihoVsKdHaEPBj/3kyddpihEiZsXihqMVm+HFyU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W6VZme/IPGSItEQUslnbPd05ccvBXHLAdMpwgd4h7g+5gIQ0mYENZM3L0RkpJ4voe
 8kF7CQG4dUTbX+oW8GE2mfKwRhN308AS3UfxvJgOofKtevoNOnntJbrfo9shBj2FGx
 EKmOHYElgrnuGakFupwSf1lap1P/+Ska/Xq8gd6Pi20SowJ9dUD73y7i7u6r0XBLqu
 q/NDYspVijhJ+ULhqYP+JTaBKW6stpmhjia3QRkO8U1ZGHJ9WJ/2bbvB3eJ2ijOP/X
 kcU3S6ztYHyYXaZAj2bEzitUqG0gQEF2t7mg8SiRGd+aAU5E7ANttfFaX14Hq7t6ye
 AOxMJij7vKFgg==
Message-ID: <sashiko-outbox-219548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/tyr: vm: expand sub-block unmaps to 2MB
 boundaries on remap
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261117-tyr-remap-2mb-v1-3-2a8efd4c8180@google.com>
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
 <20261117-tyr-remap-2mb-v1-3-2a8efd4c8180@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:02:54 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/tyr: page table desync and GpuVa leak on pt_map() error
  in sm_step_remap()
--

commit 890e6d1a0c182be186e5d6f90855d935bae30eda
Author: Sami Tolvanen <samitolvanen@google.com>

drm/tyr: vm: expand sub-block unmaps to 2MB boundaries on remap

This commit expands sub-block unmaps in sm_step_remap() to 2MB boundaries w=
hen
the surviving fragments are physically contiguous and remaps the surviving
head and tail fragments as 4KB pages.

> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index 1dd11b2b12532..bcc864b174284 100644
> --- a/drivers/gpu/drm/tyr/vm.rs
> +++ b/drivers/gpu/drm/tyr/vm.rs

[ ... ]

> @@ -749,10 +780,50 @@ fn sm_step_remap<'op>(
>              op.va_to_unmap().addr() + op.va_to_unmap().length()
>          };
> =20
> -        let unmap_length =3D unmap_end - unmap_start;
> +        // The surviving fragments inherit the protection of the mapping=
 being
> +        // split.
> +        let prot =3D op.va_to_unmap().data_ref().prot;
> +
> +        let block =3D Alignment::SZ_2M;
> +        let aligned_start =3D unmap_start.align_down(block);
> +        let aligned_end =3D unmap_end.align_up(block).ok_or(EINVAL)?;
> +
> +        // An end may only be expanded if the fragment the expansion swe=
eps and
> +        // rebuilds is fully mapped and physically contiguous, because t=
he
> +        // rebuild maps it linearly from a single recovered address. A g=
enuine
> +        // 2MB block is always contiguous, so this never misses one and =
the
> +        // partial-block unmap can never reach arm-lpae. A fragmented re=
gion is
> +        // never expanded, so its sub-range unmap stays correct.
> +        let head_paddr =3D match op.prev() {
> +            Some(prev) if aligned_start < unmap_start && prev.addr() <=
=3D aligned_start =3D> {
> +                contiguous_phys(context.pt, aligned_start..unmap_start)
> +            }
> +            _ =3D> None,
> +        };
> +        let tail_paddr =3D match op.next() {
> +            Some(next) if aligned_end > unmap_end && next.addr() + next.=
length() >=3D aligned_end =3D> {
> +                contiguous_phys(context.pt, unmap_end..aligned_end)
> +            }
> +            _ =3D> None,
> +        };
> +
> +        let region_start =3D if head_paddr.is_some() {
> +            aligned_start
> +        } else {
> +            unmap_start
> +        };
> +        let region_end =3D if tail_paddr.is_some() {
> +            aligned_end
> +        } else {
> +            unmap_end
> +        };
> +
> +        let prev_va =3D context.preallocated_gpuva()?;
> +        let next_va =3D context.preallocated_gpuva()?;
> =20
> -        if unmap_length > 0 {
> -            let region =3D unmap_start..(unmap_start + unmap_length);
> +        if region_end > region_start {
> +            let region =3D region_start..region_end;
> +            context.extend_lock(region.clone())?;
>              pt_unmap(context.dev, context.pt, region.clone()).inspect_er=
r(|e| {
>                  dev_err!(
>                      context.dev,
> @@ -764,14 +835,29 @@ fn sm_step_remap<'op>(
>              })?;
>          }
> =20
> -        let prev_va =3D context.preallocated_gpuva()?;
> -        let next_va =3D context.preallocated_gpuva()?;
> +        if let Some(head_paddr) =3D head_paddr {
> +            pt_map(
> +                context.dev,
> +                context.pt,
> +                aligned_start,
> +                head_paddr,
> +                unmap_start - aligned_start,
> +                prot,
> +            )?;
> +        }
> +        if let Some(tail_paddr) =3D tail_paddr {
> +            pt_map(
> +                context.dev,
> +                context.pt,
> +                unmap_end,
> +                tail_paddr,
> +                aligned_end - unmap_end,
> +                prot,
> +            )?;
> +        }
> =20
> -        let (op_remapped, remap_ret) =3D op.remap(
> -            [prev_va, next_va],
> -            pin_init::init_zeroed(),
> -            pin_init::init_zeroed(),
> -        );
> +        let (op_remapped, remap_ret) =3D
> +            op.remap([prev_va, next_va], GpuVaData { prot }, GpuVaData {=
 prot });

[Severity: Medium]
Can a pt_map() failure here leave context.pt out of sync with GpuVm and leak
the GpuVa?

pt_unmap() has already torn down the expanded 2MB range in context.pt before
pt_map() allocates L3 page tables for the surviving 4KB fragments.  If eith=
er
pt_map() fails with ENOMEM, sm_step_remap() returns without restoring the
unmapped range in context.pt or updating the GpuVm tree via op.remap().

When Vm::kill() or Vm::unmap_range() later calls sm_step_unmap() on the
unsplit GpuVa, pt_unmap() hits the already-unmapped PTEs, triggers a WARN_ON
in __arm_lpae_unmap(), and returns Err(EINVAL) before op.remove() can unlink
and free the GpuVa and its GEM BO references.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-tyr-remap-=
2mb-v1-0-2a8efd4c8180@google.com?part=3D3
