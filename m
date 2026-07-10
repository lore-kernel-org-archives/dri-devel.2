Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39578C44508
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC6310E7C4;
	Mon, 13 Jul 2026 07:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I2qDyMK0";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1AA10E200
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 17:03:00 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8478fe07f0fso1239140b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783702980; x=1784307780; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eJt4dduVMLAOIcmpuYMBgvu3eT4RLvOgifRZbg/Z4kQ=;
 b=I2qDyMK07/a63AHzdyr5V5NWsIck/Va9/GjWFWTPvQoA32YN8m2jMv8jCED70SFemL
 CL6vPCTGJpzd7gn8wOnb7o/ICv92O8MI89LorrdI27T7Io4MZDYy6B0MzFjb6lcg/LgY
 8uSA6zECxTd/SWcnpjFTiucpQ3cZDkkk/mPSNWRzIFQQBSfqqi8Nq32UtpAiFSo1ERDO
 KbWIdnRyfMBO0FxvEMoCMgqJdcoeT7216nXV5rLat3JgEW/kmIF45M09cXvItsF32Hgu
 ah/YATBWC/tESgXS20sub0e3xEw5OLTG+7uk4AZRLbl6dt27j6gChT4vGcVNnO0NQHEX
 1BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783702980; x=1784307780;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eJt4dduVMLAOIcmpuYMBgvu3eT4RLvOgifRZbg/Z4kQ=;
 b=YpuziKTi0sPEgTyKBc40+jrFoznIj5JPnUckKG0AJsCfL8b7U0TBTX7N1YnwfseIrR
 rfXS3Dr0d2sz2YrAfvR7oGSRieNRRooMROJlQKRJsFWbf+5UKG3Ax8/qIaL5CqQe0ks+
 g4Gqj7ZtH+sALAnfeuZ1FESj9o5k7/BZohdrdAP8D2SQ56jPZgr0qaiYmlQkYxGdT5VI
 7WeVuqkggSMBMfF+7nOAnlnnmMi38NiXnp55EjQ4jyssRq3EUCLG0GPJvT+PBhHMoEAa
 2wxkpzkDUkNDReJo0cqzzHr65Q50jXouIb28G0Z8h7HD9Fr4fzM3RNBoVZm/NCTn0ieN
 JM4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJza3Z4AApUPZu5RV3Z94cO4ifEmbdpWTFNI60HyZ2SPM+SYZR9oWYjDOnsxOTAUUUoNGGNX83KFA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkMjFKdfsHARQzoII77bPitnb+H9491E7cTsAIckYSSQEXCI1m
 +2TZuxuUmCEZhthdbv09yQpOYcJusLE0NR24e+XdMom7QRTEqiXuM+Er
X-Gm-Gg: AfdE7ck4TpoYsLaikS5/peQRNIyA851wGJ8tiIvIc8JCVtcEukG9NwnSJPpGOQDBSHo
 8/f91Oxz8yUFumageaAExR2Wh3ZvtgqOuIp4IqyfJCLupAdHgiwY27MuXZWFsBMxhP+12/Fh+HA
 Mbm9H4WXP4plIT5Gl57s6AdSrbPhAvnWPQxzMhvIUlZJMetDBxPd72CufmPPToVttBfyYvl0TAP
 iuKXFixoU7KepKCvGfpWmcRx3Gp+t2rdOHGDyZzpijmHDtW8ZZTF8ocryKGa80wPb0Xm/O9ioye
 lMuv0W8mkKgtwgmO13VqXj3q1f1u6/Xqr5MJXe7iicjdHZhImxiQKgrkUL+R9CISdx/LhUy6DDv
 /S3ZZsnIdgwKJc0OFd8s4kb+sQRlXsjs0OfZEtBkcOuS4EegIzqyHnIUiNLgVY1/OOQRgjNqWrd
 mNASu/D+TZ3cabTHI3iMMjCZY2YjAMxU84SNXwx+7RoQAyBdQOrLqv+d8=
X-Received: by 2002:a05:6a00:1f13:b0:848:6ba2:4139 with SMTP id
 d2e1a72fcca58-8486ba24522mr4844235b3a.36.1783702979579; 
 Fri, 10 Jul 2026 10:02:59 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8484519580csm4394040b3a.32.2026.07.10.10.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 10:02:58 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:02:55 -0700
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
Message-ID: <alElv0EKjLQXMNK8@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
 <20260710164743.GX118978@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710164743.GX118978@ziepe.ca>
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

On Fri, Jul 10, 2026 at 01:47:43PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 10, 2026 at 01:27:49PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:
> > 
> > > +int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
> > > +				     unsigned long timeout)
> > > +{
> > > +	struct mm_struct *mm = range->notifier->mm;
> > > +	unsigned long deadline = 0;
> > > +	int locked, ret;
> > > +
> > > +	if (timeout)
> > > +		deadline = jiffies + timeout;
> > > +
> > > +	do {
> > > +		if (fatal_signal_pending(current))
> > > +			return -EINTR;
> > > +
> > > +		if (timeout && time_after(jiffies, deadline))
> > > +			return -EBUSY;
> > 
> > I really dislike there is a timeout here, HMM is supposed to be more
> > deterministic. GUP doesn't have a timeout, what is this about?
> 
> It looks like you've moved the timeout processing related to the mmnu
> notifier sequence from the callers into this helper. I'm fine with
> that, but maybe add some comments that this timeout is helping
> implement the mmu notifiers, and we do expect that the HMM part will
> not timeout.
> 
> Though it is a little hard to see how your stated purpose of enabling
> userfaultfd is going to work, aren't you pretty much guarenteed to hit
> a timeout if the userfaultfd process is adversly scheduled? That's
> going to end up broken.
> 

The main customer for this new feature I have in mind is the MSHV driver
which backs VMs memory with HMM, requires userfaultfd support for
post-copy live migration and fast restore and it doesn't timeout.

I agree, that this current timeout value used by the other callers might
not be enough to repopulate the mappings with userfaultfd, but there
drivers would get -EFAULT for uderfaultfd-backed mappings without this
change anyway, so getting -EBUSY with the change instead doesn't look
like a significant change to the behaviour from my POV.

> So, maybe the deadline should be resetting after every handled fault?
> ie the timeout really is only about the mmu notifier and we don't
> count the time spent handling faults or walking?
> 

The timeout was inherited from existing HMM users rather than introduced
as a new HMM policy. Some GPU drivers use HMM_RANGE_DEFAULT_TIMEOUT as a
budget for the whole range population operation, including HMM retries
and subsequent driver mapping work.

Moving retry handling into the unlocked helper would otherwise hide
repeated -EBUSY returns from those callers and silently turn their
bounded operation into an unbounded one. So the timeout argument is
there to preserve existing caller semantics during conversion.

I'd say it's up to the caller to provide big enough timeout for
userfaultfd to succeed.

Thanks,
Stanislav

> Jason
