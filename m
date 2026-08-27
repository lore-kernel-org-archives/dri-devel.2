Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB31C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA6B10E3CC;
	Thu, 27 Aug 2026 09:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l7xQJQ0U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFFC10E33A
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:07:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2A67600D0;
 Thu, 27 Aug 2026 09:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEE21F000E9;
 Thu, 27 Aug 2026 09:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787821670;
 bh=NjMkLB/EgzKLAVIgpOI5dc2i2OLDi3iggVp8kStXUVk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l7xQJQ0UngUuP01oi4GxGXfffOAtntOYEdQvGjXbX48auZLAXm5aBUFGowfjxtD6G
 dZ7lg4PuXY3lT837yWrC/1ojTXh5wZighDjv1gPGDDmil/zaqVcErZtpZmSlyKM7dg
 m/dB8t5cK7W/Wo431SYrhRAOO7a39amhPssn3UUK5pHIvLSuQpS0vLEa3ujQ9+HNY2
 FIecTYX2WFElq/4Jh4icE67fdc+N0KkuOP5MXHGIMaUb6SSUV1TtX272erJaKxx5+/
 ojFnCu4yxHp2fLW+A45PtVKH9IWUdqxLYOlvA9Fujdzy91SsYpR5X95w4RWZLMuyMO
 HutjfD/FvnSCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] gpu: nova-core: mm: Add PRAMIN aperture
 self-tests
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-pramin-split-v3-10-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
 <20260827-pramin-split-v3-10-24b24d7afc52@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 09:07:49 +0000
Message-Id: <20260827090750.2BEE21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The misalignment selftest for `u64` will fail on 32-bit architec=
tures because `align_of::<u64>()` is 4, not 8.
- [Low] Compilation error when CONFIG_NOVA_CORE_SELFTESTS is enabled: calli=
ng `run_selftests` on an unpinned mutable reference.
--

commit 0fa1da2e573acbda3f74539dc8e29525a6f4dfba
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add PRAMIN aperture self-tests

This commit adds self-tests for the PRAMIN aperture mechanism to verify
correct operation during GPU probe. The tests validate various alignment
requirements and corner cases, and are gated behind the
CONFIG_NOVA_CORE_SELFTESTS configuration.

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -85,6 +85,9 @@ fn probe<'bound>(
>                  // (try_pin_init!() initializes fields in declaration or=
der), lives at a pinned
>                  // stable address, and is dropped after gpu (struct fiel=
d drop order).
>                  gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar=
) }),
> +                // Run optional GPU selftests.
> +                #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
> +                _: { gpu.run_selftests(pdev) },

[Severity: Low]
Will this cause a compilation error in the probe function when
CONFIG_NOVA_CORE_SELFTESTS is enabled?

The gpu field exposed within the try_pin_init closure is a standard mutable
reference, but the run_selftests method expects a pinned mutable reference.
Since these types do not automatically coerce, this looks like it will resu=
lt
in a build failure during probe execution.

[ ... ]
> diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/m=
m/pramin.rs
> --- a/drivers/gpu/nova-core/mm/pramin.rs
> +++ b/drivers/gpu/nova-core/mm/pramin.rs
[ ... ]
> +    /// Test that misaligned accesses are rejected.
> +    fn test_misaligned_access(
> +        dev: &device::Device<device::Bound>,
> +        pramin: &mut Pramin<'_>,
> +        base: VramAddress,
> +    ) -> Result {
> +        // u16 at odd offset (not 2-byte aligned).
> +        selftest_assert!(dev, pramin.window_at::<u16>(base + 0x21).is_er=
r());
> +
> +        // u32 at 2-byte-aligned (not 4-byte-aligned) offset.
> +        selftest_assert!(dev, pramin.window_at::<u32>(base + 2).is_err()=
);
> +
> +        // u64 at a 4-byte-aligned (not 8-byte-aligned) address.
> +        selftest_assert!(dev, pramin.window_at::<u64>(base + 0x44).is_er=
r());

[Severity: Medium]
Will this assertion in test_misaligned_access fail on 32-bit architectures?

On 32-bit systems, the memory alignment requirement for a u64 is typically 4
bytes rather than 8 bytes. Since the offset 0x44 is a multiple of 4, the
window_at call would succeed rather than returning an error, which seems
like it would cause a spurious selftest failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-pramin-spl=
it-v3-0-24b24d7afc52@nvidia.com?part=3D10
