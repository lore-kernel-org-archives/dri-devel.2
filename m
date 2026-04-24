Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1937FE5214
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5151A10E3D3;
	Fri, 24 Apr 2026 12:05:25 +0000 (UTC)
X-Greylist: delayed 613 seconds by postgrey-1.36 at gabe;
 Fri, 24 Apr 2026 12:05:22 UTC
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by gabe.freedesktop.org (Postfix) with ESMTP id E79B310E3CB
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:05:22 +0000 (UTC)
Received: from gate.crashing.org (localhost [127.0.0.1])
 by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63OBs8ib185599;
 Fri, 24 Apr 2026 06:54:08 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.18.1/8.18.1/Submit) id 63OBs5hd185566;
 Fri, 24 Apr 2026 06:54:05 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 24 Apr 2026 06:54:05 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, tamird@kernel.org, arnd@arndb.de,
 nsc@kernel.org, simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
 Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <aetZ3VX_Y9sop-SO@gate>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424054742.45832-6-mkchauras@gmail.com>
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

Hi!

On Fri, Apr 24, 2026 at 11:17:40AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> The core crate currently depends on these two functions for i64/u64/
> i128/u128/core::time::Duration formatting, but we shouldn’t use that in
> the kernel so let’s panic if they are ever called.
> 
> This doesn’t yet fix drm_panic_qr.rs, which also uses __udivdi3 when
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y, but at least makes the rest of the kernel
> build on PPC32.

GCC uses calls to functions like even __addsi3 whenever the (sub-)target
does not implement some RTL, doesn't have a define_insn and the like for
it.  When you write a new port you only *have* to implement a very few
things, the rest is done in libgcc (you might still have to write some
of that for your target, no free lunch etc.)

32-bit PowerPC has no instructions for 64-bit divisions, nor
instructions that help implementing it in software.  It still very often
helps to hand-write machine code for it, it very easily can usually be
more than twice as fast for example (for example if the divisor is less
than half a word big, the common case -- it can be made tens of times
faster then).

There can be many reasons why a GCC backend decides to call a libgcc
routine.  For __udivdi3 on -m32 rs6000 you'll be good AFAICS :-)
(but poisoning functions like you do is a terrible idea in general!)


Segher
