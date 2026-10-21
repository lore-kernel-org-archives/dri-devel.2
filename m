Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF59606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFIkzoy/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66AE510FCED;
	Wed, 21 Oct 2026 10:06:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E5A10FCED
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:06:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 453C8601F0;
 Wed, 21 Oct 2026 10:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94721F000C9;
 Wed, 21 Oct 2026 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792577173;
 bh=hL3cU4j17+J60L1OX1Uci5aEkpKYjvCbizFZmZ7PQMw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JFIkzoy/3j8/hBDzJH7Ls4ni6KClwNK0NU47NwCiTiiyEfkVqNyn+hn3oeYmOhbGY
 pMcDHuS3lxDRrAZrEshI5AVW/YxxkFvu2BiiqwvyBKIct6i4xKYJO9+zAunARlctq9
 5seq8TXtIvZ54myBddu8RrOvi0bOXvc/ITd1W5864DG2sD7hlFDcrlIItpBwEkBYpZ
 m7BxW36u/XKuL+E0dDRpRnl4OURioTuEIpQ+QqNKmgzqNS9NAIno9QIyaWuYYRHGjo
 vKgiCoJuwvy9CpHf5REOvpUizyJ1eLF2Dvy7Ib+3wZlEV/+A3oXc2cmKn63e2WCWGS
 Ki0QSR2Gh3CIA==
Message-ID: <sashiko-outbox-180085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261021095512.1345191-3-phasta@kernel.org>
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 10:06:12 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bitops: set_bit_release() lacks release barrier and uses kcsan=
_wmb()
- [Medium] bitops: set_bit_release() undefined on archs without instrumente=
d-atomic.h
--

commit e20f77caba7042f428258dbb5808e1ad22ab5a60
Author: Philipp Stanner <phasta@kernel.org>

asm-generic/bitops: Add set_bit_release()

This commit adds set_bit_release() to
include/asm-generic/bitops/instrumented-atomic.h to provide a bit-setting
primitive with release ordering that pairs with test_bit_acquire().

> diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/a=
sm-generic/bitops/instrumented-atomic.h
> index c010d54275e4a..fb2d1472fd4d5 100644
> --- a/include/asm-generic/bitops/instrumented-atomic.h
> +++ b/include/asm-generic/bitops/instrumented-atomic.h
> @@ -72,6 +72,20 @@ static __always_inline bool test_and_set_bit(long nr, =
volatile unsigned long *ad
>  	return arch_test_and_set_bit(nr, addr);
>  }
> =20
> +/**
> + * set_bit_release - Set a bit with release ordering
> + * @nr: Bit to set
> + * @addr: Address to start counting from
> + *
> + * This is an atomic ordered operation (implied write memory barrier).
> + */
> +static __always_inline void set_bit_release(long nr, volatile unsigned l=
ong *addr)

[Severity: Medium]
Will defining set_bit_release() only in
include/asm-generic/bitops/instrumented-atomic.h break the build when gener=
ic
kernel code calls set_bit_release() on architectures that do not include th=
is
header?

Several architectures define their own atomic bitops directly in
arch/*/include/asm/bitops.h without including
include/asm-generic/bitops/instrumented-atomic.h or
include/asm-generic/bitops/atomic.h, including 32-bit arm, mips, alpha, m68=
k,
parisc, sparc, hexagon, openrisc, and sh:

arch/arm/include/asm/bitops.h:
    #define set_bit(nr,p)			ATOMIC_BITOP(set_bit,nr,p)
    #define clear_bit(nr,p)			ATOMIC_BITOP(clear_bit,nr,p)
    #define change_bit(nr,p)		ATOMIC_BITOP(change_bit,nr,p)

arch/mips/include/asm/bitops.h:
    static inline void set_bit(unsigned long nr, volatile unsigned long *ad=
dr)

Unlike clear_bit_unlock() (provided via include/asm-generic/bitops/lock.h a=
nd
architecture-specific definitions) or test_bit_acquire() (wired through
include/linux/bitops.h and include/asm-generic/bitops/non-atomic.h),
set_bit_release() has no definition or fallback on those architectures.

> +{
> +	kcsan_wmb();
> +	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
> +	arch_set_bit(nr, addr);
> +}

[Severity: Critical]
Does set_bit_release() in include/asm-generic/bitops/instrumented-atomic.h
actually provide release memory ordering when a caller publishes state to a
concurrent reader using test_bit_acquire()?

First, arch_set_bit() is a relaxed (unordered) atomic operation. In
include/asm-generic/bitops/atomic.h (used by arm64, loongarch, arc, csky,
s390, and others), arch_set_bit() calls raw_atomic_long_or(), which is
unordered and has no release barrier:

include/asm-generic/bitops/atomic.h:
    static __always_inline void
    arch_set_bit(unsigned int nr, volatile unsigned long *p)
    {
    	p +=3D BIT_WORD(nr);
    	raw_atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
    }

Architecture-specific implementations of arch_set_bit() in
arch/powerpc/include/asm/bitops.h and arch/riscv/include/asm/bitops.h are
likewise relaxed. By contrast, release-ordered bitops in
include/asm-generic/bitops/lock.h use a release-ordered atomic operation:

include/asm-generic/bitops/lock.h:
    static __always_inline void
    arch_clear_bit_unlock(unsigned int nr, volatile unsigned long *addr)
    {
    	addr +=3D BIT_WORD(nr);
    	raw_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)ad=
dr);
    }

Second, kcsan_wmb() in include/linux/kcsan-checks.h is only a sanitizer
annotation that compiles to a no-op when weak memory modeling is disabled a=
nd
never emits a hardware memory barrier:

include/linux/kcsan-checks.h:
    #define kcsan_wmb()	do { } while (0)
    #define kcsan_rmb()	do { } while (0)
    #define kcsan_release()	do { } while (0)

Third, both kcsan_wmb() and the function comment ("implied write memory
barrier") model a write memory barrier rather than a release operation. In
kernel/kcsan/core.c, wmb only orders prior writes, whereas release orders b=
oth
prior reads and prior writes:

kernel/kcsan/core.c:
    DEFINE_MEMORY_BARRIER(mb, true);
    DEFINE_MEMORY_BARRIER(wmb, sa->type & (KCSAN_ACCESS_WRITE | KCSAN_ACCES=
S_COMPOUND));
    DEFINE_MEMORY_BARRIER(rmb, !(sa->type & KCSAN_ACCESS_WRITE) || (sa->typ=
e & KCSAN_ACCESS_COMPOUND));
    DEFINE_MEMORY_BARRIER(release, true);

Because there is no hardware or compiler release barrier here, can the
compiler and processor on weakly-ordered architectures reorder prior memory
reads and writes after arch_set_bit(), causing data races when paired with
test_bit_acquire()? Should this follow clear_bit_unlock() in
include/asm-generic/bitops/instrumented-lock.h by using kcsan_release() and=
 a
release-ordered arch_set_bit_release() helper?

include/asm-generic/bitops/instrumented-lock.h:
    static inline void clear_bit_unlock(long nr, volatile unsigned long *ad=
dr)
    {
    	kcsan_release();
    	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
    	arch_clear_bit_unlock(nr, addr);
    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021095512.1345=
191-2-phasta@kernel.org?part=3D1
