Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C3FC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0423410EE94;
	Wed,  9 Sep 2026 04:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jK4rrw5N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD8210EE94
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:09:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D43441163;
 Wed,  9 Sep 2026 04:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB6F1F00A3D;
 Wed,  9 Sep 2026 04:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788926988;
 bh=ItxQ42bOElBvYb0jpSHxdZKsVH8n54DIv1divndYuXE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jK4rrw5NNgfHnfZvBlv5UI3J7tQI+cMY2HnJ0ektr4u/C0kuo2/5ZqVCMMdBNJ34L
 YnKiRjuB2zg/5Vuh2sitMa4FPgidKV4hEPYnaiWASr3Z0TeO+0UVyKXEQxcomGfpc5
 SrWQxyXEWQ3+J+xOw395/suqu70T8Eff4knabGtmP3AGceeoFz2bpCOkjgHWRVJu/b
 Hp8ZhshDTMxkJM1T4l4xdoS7NNaYLcnoG8caDjN0hwP1zReNG+zm8BbQTLatf3HIPm
 jp0lkL+B5Op0ZP86cCRdUi49YchumFJcwlT/Q/Y6Q4vKU7nrOfYF+F5rV3UJe+9pZD
 Bbn+mtZvGo0FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/16] gpu: nova-core: mm: Add buddy allocator and TLB
 to GpuMm
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-mmrebase-v1-2-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-2-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:09:47 +0000
Message-Id: <20260909040948.0FB6F1F00A3D@smtp.kernel.org>
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
- [High] Tlb::flush unconditionally uses TlbAckMode::None, which fails to w=
ait for global TLB invalidation and creates a use-after-free risk during un=
maps.
--

commit d4de9556e03b0600a4f0e5f45fee95f566102c9d
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add buddy allocator and TLB to GpuMm

Extend GpuMm with the buddy allocator for VRAM allocation and the TLB
manager for translation buffer operations. This completes the centralized
ownership model for memory management components.

> diff --git a/drivers/gpu/nova-core/mm/tlb.rs b/drivers/gpu/nova-core/mm/t=
lb.rs
> new file mode 100644
> index 0000000000000..cc862e8159a19
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm/tlb.rs

[ ... ]

> +    /// Flush the GPU TLB for a specific page directory base.
> +    ///
> +    /// This invalidates all TLB entries associated with the given PDB a=
ddress.
> +    /// Must be called after modifying page table entries to ensure the =
GPU sees
> +    /// the updated mappings.
> +    pub(super) fn flush(&self, pdb_addr: VramAddress) -> Result {
> +        let _guard =3D self.lock.lock();
> +
> +        // Write PDB address.
> +        self.bar.write_reg(regs::NV_TLB_FLUSH_PDB_LO::from_pdb_addr(
> +            pdb_addr.into_raw(),
> +        ));
> +        self.bar.write_reg(regs::NV_TLB_FLUSH_PDB_HI::from_pdb_addr(
> +            pdb_addr.into_raw(),
> +        ));
> +
> +        // Trigger flush.
> +        self.bar.write_reg(
> +            regs::NV_TLB_FLUSH_CTRL::zeroed()
> +                .with_all_va(true)
> +                .with_ack(TlbAckMode::None)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does hardcoding the fire-and-forget acknowledgment mode here create a
use-after-free risk?

Since TLB flushes are used during unmap operations, a fire-and-forget mode
fails to wait for global TLB invalidation. The GPU might retain and use sta=
le
TLB entries to access freed physical memory before the invalidation fully
propagates.

The documentation for TlbAckMode::Globally notes that it is strictly
required during unmap or permission tightening to prevent this exact issue.
Should Tlb::flush accept the acknowledgment mode as a parameter, or use
TlbAckMode::Globally by default?

> +                .with_trigger(true),
> +        );
> +
> +        // Poll for completion.
> +        read_poll_timeout(
> +            || Ok(self.bar.read(regs::NV_TLB_FLUSH_CTRL)),
> +            |ctrl: &regs::NV_TLB_FLUSH_CTRL| !ctrl.trigger(),
> +            Delta::ZERO,
> +            Delta::from_secs(2),
> +        )?;
> +
> +        Ok(())
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D2
