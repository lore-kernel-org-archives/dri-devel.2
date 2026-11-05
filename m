Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0EE606A332
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=A090ybic
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE29112284;
	Thu,  5 Nov 2026 09:04:53 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D2F11228A;
 Thu,  5 Nov 2026 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=gz5sekZhkEN5i4KTVnJFPB0GpaceA8nVJ3ASWXSb3No=; b=A090ybicYHuJUXKX52u0Jbpa0M
 BlrGtwZwjal56BippSBYVqX582lCQV8utP4PlFbrD2s8OGq1EFIx4p8OW8BGDFupZBJqvzMayjg9k
 EtmgVO66mS2nusbHe+EafDJYftNi3sSBMwU7ajar8/ks1ufBzNiRCZgVxLCZN0PjsjquEjudf8SXI
 lme1YI+aaY9pB7ahZFF2hF4AvJUVkHF+HFP2rg5l56A5+wNJGX3m/aW2BM3jUMnzJcchB17U1mCFH
 76wtQWSwQKZQ05B+IH5amI5jI5Vy+1WftK2ZKjz+eu+Du8gakXhjbhihIqtx7taFTky18BrRbtjUA
 4CF9vMww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xOtOg-00000006W57-0YHQ; Thu, 05 Nov 2026 09:04:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id BBD9A30057E; Thu, 05 Nov 2026 10:04:37 +0100 (CET)
Date: Thu, 5 Nov 2026 10:04:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Vineet Gupta <vineet.gupta@linux.dev>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Brian Gerst <brgerst@gmail.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/4] Fix the x86 defconfig build with GCC 17
Message-ID: <20261105090437.GT2668804@noisy.programming.kicks-ass.net>
References: <20261104160722.1637541-1-vineet.gupta@linux.dev>
 <20261104162747.GAautdA2q2lw2gsth2@fat_crate.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104162747.GAautdA2q2lw2gsth2@fat_crate.local>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 08:27:47AM -0800, Borislav Petkov wrote:
> On Wed, Nov 04, 2026 at 08:07:17AM -0800, Vineet Gupta wrote:
> > Fix build warnings and failures (CONFIG_WERROR=y) with a GCC 17 build.
> > GCC 17 adds -Wconstant-logical-operand which is strict about operands
> > of && or || that fold to a constant other than 0 or 1.
> 
> Just from looking at it, my initial reaction would be to disable that option.
> 
> Because, frankly, I don't see the point.

Yes, this. This seems like a really pointless warning to me too.
