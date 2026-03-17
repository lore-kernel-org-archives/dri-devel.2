Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ADEFD8745
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BD010E60E;
	Tue, 17 Mar 2026 11:30:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="NsavaPYY";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4994E10E60B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 11:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6RYWarEzFu75TQfhyGtGIrajfUm5t79UfcymHu8wzk0=; b=NsavaPYY2EaF1ZEYrjdnqM0/D8
 sGyTUkaQNnUPZZ7mKVwOyCMn1h++U47Qfde/FrENxkEG1/kY33oLp0gIqkRfHZuLFmotzDWTdViCa
 nFIPQl+pE+kT8V16jFVOnwFKrbpfIpGKQLzTBEomtAdYWuh1bS78g0zhQkBlLpBu7bRPIRD4kFLXA
 +gHwndSKh6WxO50d9HWXkOXXjw7BJDRGIuHVAZAad3J829AWNdDPzjy0PlOmnVTIvuVN8fOVWj0cw
 twtdZ4sDc+4mT+wZEqXXOKCgwdV2k1tjFW9nqPn2raJu/l3xctBttIFEHmx1fbjc/KJlNOQThGvoO
 r9/VK+EQ==;
Received: from
 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl
 ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1w2Sd1-00000002bqs-0BeC; Tue, 17 Mar 2026 11:30:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id F3E9A303244; Tue, 17 Mar 2026 12:30:25 +0100 (CET)
Date: Tue, 17 Mar 2026 12:30:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, Alessandro Carminati <acarmina@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v6 0/5] kunit: Add support for suppressing warning
 backtraces
Message-ID: <20260317113025.GG2872@noisy.programming.kicks-ass.net>
References: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
 <69f4eb09-efbd-4bd1-81b8-963b78e1a3a3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69f4eb09-efbd-4bd1-81b8-963b78e1a3a3@kernel.org>
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

On Tue, Mar 17, 2026 at 12:20:26PM +0100, Vlastimil Babka (SUSE) wrote:
> > For this iteration, the `__report_bug()` centralized approach was
> > revisited after the discussion in the previous version [1].
> 
> Discussion with PeterZ, who is not CC'd here? (did it now for my reply).
> 
> > However, again this approach did not work because:
> > - Some warning output is generated directly in the macros before calling
> >   the centralized functions (e.g., `__warn_printk()` in `__WARN_printf()`)
> > - Functions in the warning path like `warn_slowpath_fmt()` are marked
> >   `__always_inline`, making it difficult to intercept early enough
> > - So, by the time `__report_bug()` is called, output has already been written
> >   to the console, making suppression ineffective
> > 
> > Current Proposal: Check Directly in the `WARN()` Macros.
> > This avoids the need for function symbol resolution or ELF section
> > modification.
> > Suppression is implemented directly in the `WARN*()` macros.
> 
> So does that bloat every warn/bug site (as Peter objected to) or not?
> And is it compatible with x86? I see you modify include/asm-generic/bug.h
> but x86 has its own version of e.g. __WARN_printf ?

Yeah, they done it all wrong again :-(

This should be pushed inside __report_bug() through __WARN_printf with a
new BUGFLAG thing.

So NAK from me on this -- again!
