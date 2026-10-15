Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB02CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE55E112380;
	Thu, 15 Oct 2026 14:38:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8847112384
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:38:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A7F0D43BBF;
 Thu, 15 Oct 2026 14:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052C21F000C4;
 Thu, 15 Oct 2026 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792075114;
 bh=ZPllHFkd2/41T9i7XIV50qq2n8bSLRO3ec7naV8MZSg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YkjWbEI3yJ5kawSgkClleLWVOI00vwHYbHg0TFw6M49By5ig/+aDRXjos9a7U4pOR
 WhScltQCno5viPoSiHWuZSbzTRUxwrLHkjTb9P/0WpHZDfzcXMhGboxeoBequwL+Er
 yeaw9bEPElYK8nrMJktjFLqdwk6w+FkXvGOMrYZUC2I281FWtWWUxFE2N7C6R8McRP
 VOOhdswDFuGr56JdoHCTUq5Ou4PjKEloHR9uwSzJElvunjwzLaUydX5lV87ULf4q29
 LG6nhscvtys12LaLykDj7MXf9z7dY2S/fKIPZPdoWjT+RxFstEF2E2Ww+pdHiTSSaF
 uxoHX8erElVKQ==
Message-ID: <sashiko-outbox-172968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/15] KVM: arm64: Introduce support to pin VMIDs
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20261015142552.4128028-11-ryan.roberts@arm.com>
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-11-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:38:30 +0000
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
- [Critical] kvm: arm64: integer underflow in max_pinned_vmids allows slab =
OOB write
--

commit 5166cc2f774d24bbef4a1dfb451334ee93c6273a
Author: Shameer Kolothum <skolothumtho@nvidia.com>
KVM: arm64: Introduce support to pin VMIDs

Introduce kvm_arm_pinned_vmid_get() and kvm_arm_pinned_vmid_put(), to pin
a VMID associated with a KVM instance. This will guarantee that VMID
remains the same after a rollover.

> diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
> index 7fe8ba1a2851c..322279f59e881 100644
> --- a/arch/arm64/kvm/vmid.c
> +++ b/arch/arm64/kvm/vmid.c
[ ... ]
> @@ -169,6 +175,49 @@ void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
>  	raw_spin_unlock_irqrestore(&cpu_vmid_lock, flags);
>  }
> =20
> +int kvm_arm_pinned_vmid_get(struct kvm *kvm)
> +{
> +	struct kvm_vmid *kvm_vmid;
> +	u64 vmid;
> +
> +	kvm_vmid =3D &kvm->arch.mmu.vmid;
> +
> +	guard(raw_spinlock_irqsave)(&cpu_vmid_lock);
> +	vmid =3D atomic64_read(&kvm_vmid->id);
> +
> +	if (refcount_inc_not_zero(&kvm_vmid->pinned))
> +		return (vmid & ~VMID_MASK);
> +
> +	if (nr_pinned_vmids >=3D max_pinned_vmids)
> +		return -EINVAL;

[Severity: Critical]
Does this capacity check protect against pinning exhaustion if max_pinned_v=
mids
underflows?

On ARM64 systems with 8-bit VMIDs (NUM_USER_VMIDS=3D256) and 255 or more CP=
Us,
the subtraction used to set max_pinned_vmids in kvm_arm_vmid_alloc_init() w=
ill
wrap around to a huge unsigned value.

This allows userspace to bypass this check and exhaust all VMIDs by pinning
them. Once fully exhausted, new_vmid()'s fallback find_next_zero_bit() retu=
rns
256, and then falls through to the set_vmid label:

arch/arm64/kvm/vmid.c:new_vmid() {
	...
set_vmid:
	__set_bit(vmid, vmid_map);
	...
}

Can this write past the end of the 256-bit bitmap and corrupt adjacent slab
memory?

[ ... ]
> @@ -186,10 +235,24 @@ int __init kvm_arm_vmid_alloc_init(void)
>  	if (!vmid_map)
>  		return -ENOMEM;
> =20
> +	pinned_vmid_map =3D bitmap_zalloc(NUM_USER_VMIDS, GFP_KERNEL);
> +	if (!pinned_vmid_map) {
> +		bitmap_free(vmid_map);
> +		return -ENOMEM;
> +	}
> +	nr_pinned_vmids =3D 0;
> +
> +	/*
> +	 * Ensure we have at least one empty slot available after rollover when
> +	 * the maximum number of VMIDs are pinned. VMID#0 is reserved.
> +	 */
> +	max_pinned_vmids =3D NUM_USER_VMIDS - num_possible_cpus() - 2;

[Severity: Critical]
Is it possible for this subtraction to underflow?

If a system has 8-bit VMIDs (NUM_USER_VMIDS =3D 256) and 255 or more CPUs,
this will result in a negative value that wraps around to ULONG_MAX.

While there is a WARN_ON(NUM_USER_VMIDS - 1 <=3D num_possible_cpus()) earli=
er
in kvm_arm_vmid_alloc_init(), it only emits a warning and does not prevent
the initialization from proceeding and setting this underflowed value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015142552.4128=
028-1-ryan.roberts@arm.com?part=3D10
