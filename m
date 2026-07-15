Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB6DC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C78C10F1D1;
	Thu, 16 Jul 2026 08:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AOsZ5yKF";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4779110E1D9
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 16:39:41 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so1543142a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784133581; x=1784738381; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=or7RxpRNzsjVzPQB5YJNcUrM8L7o9Zk9H3H5s18AhOk=;
 b=AOsZ5yKF82h5tlQ2oh/nI/EEvPfcV22mTpTxhjPjDM2AWzNLnqsFtfvg6OhNv5Ln6k
 NDrsiyL8bHZsG/fQn4jy/q4vkJ9sFaiaSKiwRRMAF2na1XZ2+wyGTKb8kd9cyxnFEn2C
 S93GvudLw2RngbCJs2ikVpnN01gBbEwBZNkLLVjP9zcdpj9mJGFo3yv2Qt2bibH1v4Hr
 YRDo0E5Dk+0w+8rR9wd2sd2EZNL82e9rWBRYUkBytew5LczYrh5mk8To8Y6aquxuKFAx
 JmA5wK8+4Ri7bd0whxJoHqbLYRefQ1qeERQ0Gm8JtZnrHh+x0EdFx3tZiTmxJt5k9j52
 J8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784133581; x=1784738381;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=or7RxpRNzsjVzPQB5YJNcUrM8L7o9Zk9H3H5s18AhOk=;
 b=MWTQiemuk6s4dwxj7S9JSbZd7mv8BUX4K8H+m9ifox6PF5mSjsEff0+Lbchdhx6Vne
 vAacBPEHw7UWRcvY/inJKwgmNJnKwl6Eft/mcRGy1qZZ3aCDMNkbRTy13Ra1TgzDlgIB
 vffPKpjuRwI5RXD4yI6zH91uAsWfAQVny24GL4ECvZTqqjtkSP+BlbkBCPeEnKX87P3b
 WQ26cnpksKM8VCBOMRr1rZy5vZfhqq//kvwxNSAJnk/9xpI/ANLjJkhr/2i6M36+4fDi
 LqITqccrHkmget28t1BQRygJ9+olTfOIlsuYaDjQkIrwjAhrL9GG5kPz24HEeP/gYqv4
 4FEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrLvWCv7ScofVMxfPwxJAYxbKpMbvORORnyVylWO9DDia67BxL5+7IIG9VEY52X6qLRcf0LZiFgUc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6RK/vPqNpkgpyv49DgTaAmZfUT/X+spSm4vQZHz/BGrNEZIOb
 1RnHXKR34mZ1EdtDaoOR5ew7K3903bEcoUaGbjjz7WGYuLVjIjW2lvOn
X-Gm-Gg: AfdE7cmEN+/rJSCVZ125AJ/2XUzjGvOIZFF/b07dZdMYR7rcwsER+HwUHLNtH8NSqD9
 Ofum4yDSn8rkeHRhxvhmFB4xgVAgz6qY9rvdLgHvSJAJfUwUJkAkImE3ikKIV6kKYQmiNyti/u0
 9qDXwNDHgfx7CdA6p17sJip6hKNJ1CLavOMDft5lchaI14WkhQmq41tUKVNJZs2d7ddUBBTkpEh
 b+X/da4O2SGRxp3tUk+CRvTo+ea38JP0cBlnfumMDRgwcxKCR+0pTYgAl5wBRujOAxHdq+Xnshn
 HLgTpu9h1jsrabCaeh/bNpk0TbaRvJRDQDcImVpm+cUDsew2IUqj7W8N4D9zE+3tZsCL+PlSMyQ
 uc03LiNuOS/BkhX6fmpWeGErG5OA/82tMiav2qCSYOxyQGwjzT9RYFBUPIhCxDX4PWlTh3GMhuw
 xHlwfqAeQrj9YqjMJeVYzPkhuVY9H3Gec/1zgfLzcg+AaA68Mklzn0XPg66piTB9kgww==
X-Received: by 2002:a05:6a21:7785:b0:3c3:682d:9fbb with SMTP id
 adf61e73a8af0-3c384b91e5amr105261637.21.1784133580580; 
 Wed, 15 Jul 2026 09:39:40 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb258fd10d2sm486006a12.16.2026.07.15.09.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 09:39:39 -0700 (PDT)
Date: Wed, 15 Jul 2026 09:39:37 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, airlied@gmail.com,
 akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org, corbet@lwn.net,
 dakr@kernel.org, jgg@ziepe.ca, kees@kernel.org, leon@kernel.org,
 liam@infradead.org, lizhi.hou@amd.com, lyude@redhat.com,
 maarten.lankhorst@linux.intel.com, mamin506@gmail.com,
 mhocko@suse.com, mripard@kernel.org, nouveau@lists.freedesktop.org,
 ogabbay@kernel.org, oleg@redhat.com, rppt@kernel.org,
 shuah@kernel.org, simona@ffwll.ch, skhan@linuxfoundation.org,
 surenb@google.com, tzimmermann@suse.de, vbabka@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/4] mm/hmm: Clarify notifier retry state and scope
 HMM timeouts
Message-ID: <ale3ydkx1xt6ruuP@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
 <4300f09b-8f93-4605-b072-7c09a82cb16e@kernel.org>
 <alecaJ1FUso39D9k@skinsburskii> <alet21wLwM6P_Km2@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alet21wLwM6P_Km2@lucifer>
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

On Wed, Jul 15, 2026 at 05:02:59PM +0100, Lorenzo Stoakes (ARM) wrote:
> To avoid confusion: obviously please don't merge this series Andrew.
> 
> On Wed, Jul 15, 2026 at 07:42:48AM -0700, Stanislav Kinsburskii wrote:
> > On Wed, Jul 15, 2026 at 02:41:43PM +0200, David Hildenbrand (Arm) wrote:
> > > On 7/15/26 00:21, Stanislav Kinsburskii wrote:
> > > > This small fixup series applies on top of:
> > > >
> > > >   [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for userfaultfd-backed mappings
> > > >
> > > > The first patch updates the HMM documentation example to make the
> > > > mmu_interval_read_retry() state explicit: callers should use the notifier and
> > > > notifier_seq stored in the same hmm_range that was passed to
> > > > hmm_range_fault_unlocked_timeout().
> > > >
> > > > The remaining patches adjust nouveau, amdxdna, and drm_gpusvm users so the
> > > > timeout passed to hmm_range_fault_unlocked_timeout() is treated as a relative
> > > > HMM retry budget. These callers no longer keep an absolute deadline around
> > > > their outer driver retry loops or pass a computed remaining time into HMM.
> > > >
> > > > This keeps the timeout scoped to HMM's internal mmu-notifier retry handling. If
> > > > HMM succeeds and the driver later observes an invalidation through
> > > > mmu_interval_read_retry(), the driver retries the operation with a fresh HMM
> > > > retry budget.
> > > >
> > > > Changes in v2:
> > > >   - Kept the nouveau outer absolute timeout around the
> > > >     mmu_interval_read_retry() loop. hmm_range_fault_unlocked_timeout() only
> > > >     bounds HMM’s internal retries, while nouveau faults are handled from a GPU
> > > >     fault worker, so userspace fatal signals cannot break an endless stream of
> > > >     invalidations there.
> > > >   - Updated nouveau to use time_after_eq() before calling HMM, so the remaining
> > > >     timeout passed to hmm_range_fault_unlocked_timeout() is always positive and
> > > >     never 0, which would mean retry indefinitely.
> > > >   - Updated the nouveau fixup commit message to explain the worker-thread
> > > >     timeout issue and the time_after_eq() boundary behavior.
> > > >   - Fixed the amdxdna fixup commit message. It now describes
> > > >     aie2_populate_range() correctly instead of carrying stale nouveau prose,
> > > >     and notes that command submission still keeps its broader timeout while HMM
> > > >     gets a fresh relative retry budget.
> > > >
> > > >
> > > > ---
> > > >
> > > > Stanislav Kinsburskii (4):
> > > >       fixup! mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
> > > >       fixup! drm/nouveau: use hmm_range_fault_unlocked_timeout() for SVM faults
> > > >       fixup! accel/amdxdna: use hmm_range_fault_unlocked_timeout() for range population
> > > >       fixup! drm/gpusvm: use hmm_range_fault_unlocked_timeout() for range faults
> > >
> > > Why a fixup series instead of properly resending the full thing?
> > >
> >
> > The goal was to get a Sashiko review, and v8 has already been applied to
> > both `mm-new` and `linux-next`.
> 
> Please don't do this, this is completely impossible to track for review :)
> 
> mm review is currently very difficult based on volumes, it'll become impossible
> to manage if people sound fragments of series.
> 
> Please just resend the whole thing at this point.
> 

Well, I followed the guidance provided by Andrew, and I believe he
applied all of the changes, including these, to the `mm` tree.

Do you still want me to send v9 under these circumstances?

Thanks, Stanislav

> >
> > You can find more details here:
> >
> >   https://sashiko.dev/#/message/alaWmUEeIBeSkmO0%40skinsburskii
> >
> > Thanks, Stanislav
> >
> > > --
> > > Cheers,
> > >
> > > David
> 
> Thanks, Lorenzo
