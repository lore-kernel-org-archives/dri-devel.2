Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB26BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501DC10E7F2;
	Mon, 13 Jul 2026 07:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXrVxN4+";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC7D310E21A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 18:07:27 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2ccdb73f0e1so10771145ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783706847; x=1784311647; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vK1yycrFvPnOHneU0oNi6DrjeWKqgXkTtqXMvxDGhZQ=;
 b=gXrVxN4+oTBuV1U2WSIlNpT7Zmr5cQd+1x06uFvK7F6MOSiANa9A3moCoVe/AV/fSZ
 Dp6PDfA/d9tXr0YftDi1TiDU950UDdM7sZs39vybFSPdgIGy201DUm9QZHRuUtt4lGLj
 A8/JmMULFLSbFHFIMxrjK13hT4YQtcO/hIhkr30NCfevWZTP84E65jB4n+5bTeU3ZpnE
 ghQno1pq1crBoASeNK81dAN0fmKYM5Pptw8WTFwlqLcoCfYm47OiIqHMWw3SAuWX0WXg
 RNE9w0CPXy/i/m00eovUtsZ92WIiyWU9yqEjCjrkOPYcw81YIOvBlnbWTm6DwA2w8Yje
 kHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783706847; x=1784311647;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vK1yycrFvPnOHneU0oNi6DrjeWKqgXkTtqXMvxDGhZQ=;
 b=nJ8R1lhpSvTgvS/Dj1+B+fyCpf3qzAQSC+/dt6vW74iaRhG3oMScYfWQfWAnulRHuH
 t8MNdgWW5WkyOVsEzfxu/ePOzSUiKwzz6jGHN1Cj5t4ZvvRQUqtQweF+LE/U7ZalmruX
 KF6cEUjzydyO+gzIWqzL91e0nPJKd255TdSHbGIW/FS7vO+faAF00zSh0/sL6DXu/AEN
 ADuLQcrbj1K2CMfRhzPvSpJ4MPeq2AHpwEm29d2IzgNNRfmVGiRBR7ANYJX3K/kxWuJM
 gjaYDjLF2GL/oozrSCvxBgtWsocGxBx+TLn+lkWCT9pxTzTL29c36rBbV+0cr7KNs8Wy
 TZyw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rruw4J17BtM+AyeSaW4dDXZEVKnTESYrUBlauylJ7MDj7fOVhVbGlSgAulQcdpiFes+kf/CD5NNxsM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyegidO0c8138n4IhehimhRq1uue5unDrk+eDJ94u4oPnjVvDLY
 YCqmbl7J13vWGmGh5D32fHashUvwABOHt7l1rwT99hge4e/EUfPDe6Tt
X-Gm-Gg: AfdE7cmBo1faQF497UiUuYdDEJR0h9kjdbvz1qtrtCP5NDcnM+YBjG64t39ZiCbenMb
 QWiyxEqQ9aSU8CHWhabwM0UhFSkPi/eKwhL5NFK00upN8hRPxQVWyGpU9qcHTTuoie71DSAiOzI
 EFh60T/GeTuYp4ESU4hxK/Wc1bg65O3aUMC11qPrqBQX/WHCeVtzuXpkUgUux5SAokegb4ha/rf
 uOhNusRs0phc1VIlT4HOk9SDf+cw2gws7p021i7U1zZpWo06UK7odH7Pv+Sumva1Pf39fbYFwxd
 7BrDK8rYH45BgeuMgcb+PlIyF6Y+6kbBM2wV/azTnd25ZUGCe0zd8DecWdYbblyC8TQDy1yFYdw
 mLLaOrivHwdZZDx6utHCZSCPWQLv0O5D1KIoYKeZsH6+BY3FFiaFg/jpxFY+u0D66cfMfJfEI9F
 npjPqzfcrwJyNq6GNmB+IHDfhu5Fehgz6I6KVmudngW2VqYDmGUhOKWKE=
X-Received: by 2002:a17:903:2a88:b0:2c9:d8c6:1db8 with SMTP id
 d9443c01a7336-2ce9f284e45mr2337085ad.28.1783706847144; 
 Fri, 10 Jul 2026 11:07:27 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf74cbsm63356135ad.18.2026.07.10.11.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:07:26 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:07:23 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org,
 decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
 kys@microsoft.com, leon@kernel.org, liam@infradead.org,
 lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
Message-ID: <alE028DsCGeUwNh6@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
 <20260710164743.GX118978@ziepe.ca> <alElv0EKjLQXMNK8@skinsburskii>
 <20260710180312.GD1803712@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710180312.GD1803712@ziepe.ca>
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

On Fri, Jul 10, 2026 at 03:03:12PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 10, 2026 at 10:02:55AM -0700, Stanislav Kinsburskii wrote:
> > The main customer for this new feature I have in mind is the MSHV driver
> > which backs VMs memory with HMM, requires userfaultfd support for
> > post-copy live migration and fast restore and it doesn't timeout.
> > 
> > I agree, that this current timeout value used by the other callers might
> > not be enough to repopulate the mappings with userfaultfd, but there
> > drivers would get -EFAULT for uderfaultfd-backed mappings without this
> > change anyway, so getting -EBUSY with the change instead doesn't look
> > like a significant change to the behaviour from my POV.
> 
> It sounds like it won't be reliable either then.
> 
> > > So, maybe the deadline should be resetting after every handled fault?
> > > ie the timeout really is only about the mmu notifier and we don't
> > > count the time spent handling faults or walking?
> >
> > The timeout was inherited from existing HMM users rather than introduced
> > as a new HMM policy. Some GPU drivers use HMM_RANGE_DEFAULT_TIMEOUT as a
> > budget for the whole range population operation, including HMM retries
> > and subsequent driver mapping work.
> 
> Yes, because we always had a timeout around the notifier because that
> scheme can sort of live lock. The timeout was to protect that only, ie
> limit the number of notifier retries.
> 
> Expanding the timeout to be outside what is bounded by the notifier
> retry is not right, and heavy stuff like mapping should be done after
> the hmm side succeeds and the notifiers concluded so they can rely on
> normal locking instead.
> 
> This is why I'm suggesting to reset the deadline as hmm makes forward
> progress, we really only want to bound the notifier retry loop not
> anything else.
> 

Sure, I'll modify accordingly.

Thanks,
Stanislav

> Jason
