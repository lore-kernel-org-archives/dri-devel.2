Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3273CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5E8112389;
	Thu, 15 Oct 2026 14:44:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B060D112389
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:43:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D9A34150E;
 Thu, 15 Oct 2026 14:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4B91F000C6;
 Thu, 15 Oct 2026 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792075436;
 bh=bCgCeShaQBxK36aaYtu1vNQnmk+/QwKKcoQ12igVn6c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ti4tLAbKEi3c9h+C09FYpavN1JYeUZpPzg5l+0XWfKEVJgktQbuA2CWWFZtBRSfDP
 /aT84B7TQ/nBIUhsUUYMv+i0tS2HxJ4L610Xz/aOyJL0h/z/0CCTne16TrfJBX6z6C
 ltk9pigL4zVD6rK0J5YmDGsuAkdpNBqTikdCyDCMfX9smNtruGDqFx5b109AAd1jh0
 XxTP0Srr0JQ6mhbqVbw6HcorYy8Z9NsasATCbDIrP2BRZ9QS857B0uV/txqhVygFeI
 hrGErcicjdyAhC1NL6jTHdE0dZkHRMYB0po6LCmxJJ57h9tEuKs1uscALYAMbaB/5q
 wJVVj526CPj1g==
Message-ID: <sashiko-outbox-172975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/15] KVM: arm64: Export stage-2 MMU config
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20261015142552.4128028-12-ryan.roberts@arm.com>
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-12-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:43:55 +0000
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
- [Low] cleanup: mixing goto-based cleanup and guard() in kvm_arch_get_gues=
t_mmu()
--

commit 857dcf037db9acd0dfd4486a2d4b54b73644b090
Author: Jean-Philippe Brucker <jpb@kernel.org>

KVM: arm64: Export stage-2 MMU config

This commit provides an API to drivers that want to share the stage 2
configuration of a VM with their device. It introduces the
kvm_arch_get_guest_mmu and kvm_arch_put_guest_mmu functions to expose the
stage 2 MMU config of an EL1 VM.

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 9ba86450fe4af..56490226f973b 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
[ ... ]
> +struct kvm_arch_guest_mmu *kvm_arch_get_guest_mmu(struct kvm *kvm)
> +{
> +	int ret;
> +	struct kvm_arch_guest_mmu *mmu;
> +
> +	guard(mutex)(&kvm->arch.config_lock);
> +
> +	if (is_protected_kvm_enabled())
> +		return ERR_PTR(-EOPNOTSUPP);
[ ... ]
> +	ret =3D kvm_arm_pinned_vmid_get(kvm);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	ret =3D -ENOMEM;
> +	mmu =3D kzalloc_obj(*mmu, GFP_KERNEL_ACCOUNT);
> +	if (!mmu)
> +		goto err_unpin_vmid;
> +
> +	mmu->vtcr =3D kvm->arch.mmu.vtcr;
> +	mmu->vttbr =3D kvm_get_vttbr(&kvm->arch.mmu);
> +	mmu->hcr =3D kvm_mmu_get_hcr(kvm, 0);
> +
> +	return mmu;
> +
> +err_unpin_vmid:
> +	kvm_arm_pinned_vmid_put(kvm);
> +	return ERR_PTR(ret);
> +}

[Severity: Low]
Is it intentional to mix goto-based cleanup and guard macros in this functi=
on?

The function uses guard(mutex)(&kvm->arch.config_lock) for scope-based
locking, but also relies on the goto err_unpin_vmid label to clean up the
VMID when kzalloc_obj fails.=20

According to the cleanup helpers guidelines, mixing goto-based error handli=
ng
with scope-based cleanup helpers in the same function creates confusing
ownership semantics and increases the risk of double-free or resource leak
bugs during future code edits.

Would it be better to convert this entirely to scope-based cleanup, or
alternatively, use manual unlocks without the guard macro?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015142552.4128=
028-1-ryan.roberts@arm.com?part=3D11
