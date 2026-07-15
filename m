Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8E6C44513
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52C110F1F4;
	Thu, 16 Jul 2026 08:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aMG0c0HX";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4361310E07F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:42:52 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so5152210a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784126572; x=1784731372; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YFdvFy4JZmcJMIT1d11E7kO8Wgq6KQpSjvMclrKV/Fk=;
 b=aMG0c0HXaHDF3+UpuSbMgTebk/ETEZDMSeJLciYua9HHa7eVxqHHfW03HyZ3o55cLn
 Ru/AqnHsjhcUSQ/A3kUgsqKglh7Fus4l7t0j9giwuJhu/8z+XqKBGcckcvRv2ASVmlZp
 MT9yRcVAf3jcMsOGyFcdGKx9Rf4QC4+vKwTFHR3RQ6D+K5PTMGFAx3OeW5+e3QIpVe3S
 YcM2dw21IpiG1e+2sGiRS/VYKMtdRA4hz5eB3g1iMQlfceEWT1PJQJKRBiT5a4vnUI44
 0VLIkLy2K1IyD4O5XAeSXujq1cQCt78ko16MbJSQYGXNXFDjatOVyjB+E4rMFC0kgKBO
 JiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784126572; x=1784731372;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YFdvFy4JZmcJMIT1d11E7kO8Wgq6KQpSjvMclrKV/Fk=;
 b=BFI715mt7WUnxWLa4Cszdiqkfn5gCthrB3tu/f6OU/aooqnBl/z66JAHAeHtqKpDDq
 OfxQwT1jP3/aA1k8nC9L9F+aJg7vfzNegZdF43avq/9y++VIJtv50ccU5dl3KzF/gdgw
 UX85YAHVdtHBwaTDuOtZO9h3tb3PWJ0QzwxB2Dxzd8GcCKvEoMw7VEiEhJuYDhNYNOwa
 c7CjTMpxsC+rLU7XX3vYDay8pst6IlFdOMINO0AF97zRW1Fu+LeW+2F6kfVPEiQ34x7w
 /bQfp+xZYbCJJFV0/RQW0kfiTNQI7el9vuLs17+eO/TAc2cT99Uc/IKqanQdbkUv/CUH
 krwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3kdhPwYOu7LgaPa7z819FVYtZIk/5c4d7ihoe7bwWdPWVOlnv3ejwa/1u5KKqMhKyqGBXsPDmqIE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8dIQMCKpS4tMIa7pu7LfL4uzRY2SxRwL4zZg6EMHH0vKifE2n
 g9RZFz6/HfNNHWpcLTHI5Yjh0bsqCmLCdWuflYwV8bgLy/NQm0A18LPd
X-Gm-Gg: AfdE7cmQl6IAiNMnQrWFWB7Dadd3gL3tq92TqKGbg3QKlFrRc7JA/hdbKx956rL2aWX
 4daNP0Sh1J4O5Ll3u1BlSShRiGQRsTitUCp87TRVkzCR0bNT0hu5RxVYDb5qVInWFrjmnhJHUrD
 vr10yX+RixPiF3KY2+W7ebeNIloO/pTyTVYf97ouxgb8/iTQnOs6CBXQffz999C9D2vmLuwTU/E
 491SAxQKZDeqyw+u8pSX6ELQqh1ReToPRtwhUQ4XhdoICOSFzMe6Hg8jHO9KWJnqjnYDXrYv/Tx
 xKrx+VJOt6Yedh9ur6Bcz+weTioYX+qxJou3n7azhQdk1qef+WePq8bEBzokuNImqi8K2iVNq+e
 oqZDdz+i8TX/zIbClVA5DIUUHvhB3I2RQZgpFe+i3aiKcg21ss5/5+4pCOiJnok2CdZOBiQLGvp
 A2tSHc7vfPIRiWx2KTp/Bo2wOF0grc1twVJdTUvYkYAhVd6RFiO45jTac=
X-Received: by 2002:a17:90b:2890:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-38e29ff97b1mr2563808a91.9.1784126571549; 
 Wed, 15 Jul 2026 07:42:51 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b6da2sm3320825a91.4.2026.07.15.07.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:42:51 -0700 (PDT)
Date: Wed, 15 Jul 2026 07:42:48 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, jgg@ziepe.ca, kees@kernel.org,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com,
 ljs@kernel.org, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/4] mm/hmm: Clarify notifier retry state and scope
 HMM timeouts
Message-ID: <alecaJ1FUso39D9k@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
 <4300f09b-8f93-4605-b072-7c09a82cb16e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4300f09b-8f93-4605-b072-7c09a82cb16e@kernel.org>
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

On Wed, Jul 15, 2026 at 02:41:43PM +0200, David Hildenbrand (Arm) wrote:
> On 7/15/26 00:21, Stanislav Kinsburskii wrote:
> > This small fixup series applies on top of:
> > 
> >   [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for userfaultfd-backed mappings
> > 
> > The first patch updates the HMM documentation example to make the
> > mmu_interval_read_retry() state explicit: callers should use the notifier and
> > notifier_seq stored in the same hmm_range that was passed to
> > hmm_range_fault_unlocked_timeout().
> > 
> > The remaining patches adjust nouveau, amdxdna, and drm_gpusvm users so the
> > timeout passed to hmm_range_fault_unlocked_timeout() is treated as a relative
> > HMM retry budget. These callers no longer keep an absolute deadline around
> > their outer driver retry loops or pass a computed remaining time into HMM.
> > 
> > This keeps the timeout scoped to HMM's internal mmu-notifier retry handling. If
> > HMM succeeds and the driver later observes an invalidation through
> > mmu_interval_read_retry(), the driver retries the operation with a fresh HMM
> > retry budget.
> > 
> > Changes in v2:
> >   - Kept the nouveau outer absolute timeout around the
> >     mmu_interval_read_retry() loop. hmm_range_fault_unlocked_timeout() only
> >     bounds HMM’s internal retries, while nouveau faults are handled from a GPU
> >     fault worker, so userspace fatal signals cannot break an endless stream of
> >     invalidations there.
> >   - Updated nouveau to use time_after_eq() before calling HMM, so the remaining
> >     timeout passed to hmm_range_fault_unlocked_timeout() is always positive and
> >     never 0, which would mean retry indefinitely.
> >   - Updated the nouveau fixup commit message to explain the worker-thread
> >     timeout issue and the time_after_eq() boundary behavior.
> >   - Fixed the amdxdna fixup commit message. It now describes
> >     aie2_populate_range() correctly instead of carrying stale nouveau prose,
> >     and notes that command submission still keeps its broader timeout while HMM
> >     gets a fresh relative retry budget.
> > 
> > 
> > ---
> > 
> > Stanislav Kinsburskii (4):
> >       fixup! mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
> >       fixup! drm/nouveau: use hmm_range_fault_unlocked_timeout() for SVM faults
> >       fixup! accel/amdxdna: use hmm_range_fault_unlocked_timeout() for range population
> >       fixup! drm/gpusvm: use hmm_range_fault_unlocked_timeout() for range faults
> 
> Why a fixup series instead of properly resending the full thing?
> 

The goal was to get a Sashiko review, and v8 has already been applied to
both `mm-new` and `linux-next`.

You can find more details here:

  https://sashiko.dev/#/message/alaWmUEeIBeSkmO0%40skinsburskii

Thanks, Stanislav

> -- 
> Cheers,
> 
> David
