Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C20DFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899EC10E308;
	Tue, 28 Apr 2026 11:34:21 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by gabe.freedesktop.org (Postfix) with ESMTP id B9D5410E6D1;
 Tue, 28 Apr 2026 11:34:19 +0000 (UTC)
Received: from gate.crashing.org (localhost [127.0.0.1])
 by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63SBY0U31059939;
 Tue, 28 Apr 2026 06:34:00 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.18.1/8.18.1/Submit) id 63SBY0B51059937;
 Tue, 28 Apr 2026 06:34:00 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 28 Apr 2026 06:34:00 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Yury Norov <ynorov@nvidia.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Laight <david.laight.linux@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/9] uaccess: Convert INLINE_COPY_{TO/FROM}_USER
 to kconfig and reduce ifdefery
Message-ID: <afCbKJg_Cq7yNO9j@gate>
References: <cover.1777306795.git.chleroy@kernel.org>
 <9fe875d2f55af59c12708336c571a46038528678.1777306795.git.chleroy@kernel.org>
 <ae-tVFVfx72oCC_i@yury>
 <f54c3c2b-33da-42a0-80b7-0f6615d930ce@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f54c3c2b-33da-42a0-80b7-0f6615d930ce@citrix.com>
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

On Mon, Apr 27, 2026 at 09:39:33PM +0100, Andrew Cooper wrote:
> On 27/04/2026 7:39 pm, Yury Norov wrote:
> > On Mon, Apr 27, 2026 at 07:13:43PM +0200, Christophe Leroy (CS GROUP) wrote:
> >> Among the 21 architectures supported by the kernel, 16 define both
> >> INLINE_COPY_TO_USER and INLINE_COPY_FROM_USER while the 5 other ones
> >> don't define any of the two.
> >>
> >> To simplify and reduce risk of mistakes, convert them to a single
> >> kconfig item named CONFIG_ARCH_WANTS_NOINLINE_COPY which will be
> > We've got a special word for it: outline. Can you name it
> > CONFIG_OUTLINE_USERCOPY, or similar?
> 
> You can't swap the "in" for "out" like this.  "out of line" is the
> opposite of "inline" in this context, while "outline" means something
> different and unrelated.

Yeah.  Technically much more correct for it is inline vs. functional.
Not that that term won't be misunderstood as well :-)


Segher
