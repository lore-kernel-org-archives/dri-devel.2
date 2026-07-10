Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0648FC44508
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EF410E7D2;
	Mon, 13 Jul 2026 07:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FruZGHly";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3081410E200
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 17:06:48 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so1591600b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783703207; x=1784308007; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SpFBfA7wdgGokfuzCR83lopKSZdMUZgccIdXLTCA/gs=;
 b=FruZGHlyGf+g917yTIvFBQy8Ek0ygQ1hXaRCtahQey0VwSnAUTt3NXNZLWuVvSwUcZ
 DcZNKRbfhKlyukQqCWiEcaVerhEoE1Yoqrh9ADwN5gfBbJxpIQ+EPG8klp3Zyr2MuGq2
 0wTxbATmr8JG3bhHG0zZGdHguFxmU1DbqNmVbsFUmD7u4oe5tocqfehIbRtO8ljR3768
 FA0F0Ygb9letLubrdE7SVnRFDrOIjUN7QMI+zhqD+RuLr8EAsXE+3khZyeBkbwiityA4
 YrCq+pX8H6tQNq4K1A+fAYcP74uEdvnMiHURSjuJseSN7p+6hneFkgFg0wbIfWMCfpFD
 Hn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783703208; x=1784308008;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SpFBfA7wdgGokfuzCR83lopKSZdMUZgccIdXLTCA/gs=;
 b=L5s4xTQJIm7m363vbevIG/1mVM+xzerZmm10N+8j9c+ouocegQUzHhY8iZvEezKDfS
 BXjpvBACxqsZ6uz2FoxivEfLdxB3/z8DvXzPVvp8tozXshmoqvd0EfeUpr8Qqr8xbLxM
 wTHLwgsOv/OMDg6xtkkvkRqHoxsy5A7puuIkSfHI+ptQcmVPN/ExMwaBgnh76//c/3o6
 sHXhyClti7akk2CtPSwsphgwbyTe2vZ8AL58QmLAkauV47ohu53FE/xDFZHj/JVcWKhL
 Zrpnda6sdMeSMKf4Qqi647D5UcgKYfSat6unDReJZjTmWZAJNrfbKZ6c2sztkRGn5jjJ
 fuMA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9r8xfPT3bQMJxQb64hxnBKw7RyZz4uwKrB0j0ixyKcyw5G3tSnZO6WOuAy5ZOn9o5SdR2jkBxiCk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzorzLVRsgRYcGJPMdeH0ceD7hoWbEY7VK49TOBzAEjeRCjpE2E
 9EZRyh3r9EJ9ddIaN/BM3otjKI2O3kPNbKaXn5c34iCrvS76XNK8QEZy
X-Gm-Gg: AfdE7cm2F+UXtkro+jN9Y+D6jwA92IfjHOKgaQkl4k8DBSOHzsWJiW8QoJyE6kG1iz8
 2NOiVMDxD8uAMbszmfI2qNz+7E1GTSBYIp+Xs264EnE+mcb5q7GmfLLm6QaBIWtaD3TCLSjKT0y
 uObFcvg4lZj8He3pAkyXa6Y3jtPif5rUsX3dZUDwBDmbrlpP/ZsEAGShryp2gCnkE6h+vPHpANJ
 nJp50CKEbzSg3dAR1vgva2EWvwr3uqr8ATiT7UvCwDKm44DhdfVFN1EQGtsaHfrkRC207mxHUhj
 9EFmlyTevpHTp3eMabF0EylFh56p+5+4mmLLJn3eKVnbXAw3xzCgxyFg2CMvrUiPwQ1aT7hubWX
 XczBO7PnSmoWWuLZYAnlqh0q4F8oPCSFXrtQtwatVag8Zpsk3glPIwsj90mFuaHRdsEEoWai01N
 wSSVPP78DXN/95s2Q7Yq4ehT6vrT4P9js2H4vgaff1gwJ8kFKW779dZP4=
X-Received: by 2002:a05:6a20:d494:b0:3c0:9acb:400 with SMTP id
 adf61e73a8af0-3c0f13a6583mr4025578637.37.1783703207546; 
 Fri, 10 Jul 2026 10:06:47 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3a2e42bsm5458929a12.30.2026.07.10.10.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 10:06:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:06:44 -0700
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
Message-ID: <alEmpEv-Q_bQFzNu@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710163835.GR118978@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710163835.GR118978@ziepe.ca>
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

On Fri, Jul 10, 2026 at 01:38:35PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:
> > hmm_range_fault() requires the caller to hold the mmap read lock for the
> > duration of the call. This is incompatible with mappings whose fault
> > handler may release the mmap lock, notably userfaultfd-managed regions,
> > where handle_mm_fault() can return VM_FAULT_RETRY or VM_FAULT_COMPLETED
> > after dropping the lock. Drivers that need to populate device page tables
> > for such mappings have no way to do so today.
> 
> sashiko could not apply v7 for some reason but the remarks on v6
> seemed meaningful, did you see them were they delt with?
> 

Yes, I dealt with them.

> https://sashiko.dev/#/patchset/178336023903.504354.7500950448226027718.stgit%40skinsburskii
> 
> > diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
> > index 7d61b7a8b65b..70885f153d03 100644
> > --- a/Documentation/mm/hmm.rst
> > +++ b/Documentation/mm/hmm.rst
> > @@ -208,6 +208,69 @@ invalidate() callback. That lock must be held before calling
> >  mmu_interval_read_retry() to avoid any race with a concurrent CPU page table
> >  update.
> >  
> > +Dropping the mmap lock during page faults
> > +=========================================
> > +
> > +Some VMAs have fault handlers that need to release the mmap lock while
> > +servicing a fault (for example, regions managed by ``userfaultfd``).
> > +``hmm_range_fault()`` cannot be used on such mappings because it must hold the
> > +mmap lock for the duration of the call. Drivers that need to support them
> > +should call::
> 
> Given the majority of callers use this API it should probably be the
> focus of the documentation and example, regulate the existing API to a
> 'BTW if you really need the mmap lock, and you really shouldn't, this
> exists too'
> 

Sure, I'll update the doc to reflect it this way.

> > @@ -32,6 +32,7 @@
> >  
> >  struct hmm_vma_walk {
> >  	struct hmm_range	*range;
> > +	int			*locked;
> 
> Let's use bool if you have to respin this
> 

Sure.

> > @@ -651,37 +663,33 @@ static int hmm_do_fault(struct mm_struct *mm,
> >  		fault_flags |= FAULT_FLAG_WRITE;
> >  	}
> >  
> > -	for (; addr < end; addr += PAGE_SIZE)
> > -		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
> > -		    VM_FAULT_ERROR)
> > -			return -EFAULT;
> > +	for (; addr < end; addr += PAGE_SIZE) {
> > +		vm_fault_t ret;
> > +
> > +		ret = handle_mm_fault(vma, addr, fault_flags, NULL);
> > +
> > +		if (ret & (VM_FAULT_COMPLETED | VM_FAULT_RETRY)) {
> > +			*hmm_vma_walk->locked = 0;
> > +			return HMM_FAULT_UNLOCKED;
> > +		}
> > +
> > +		if (ret & VM_FAULT_ERROR) {
> > +			int err = vm_fault_to_errno(ret, 0);
> > +
> > +			if (err)
> > +				return err;
> > +			BUG();
> 
> Linux will be upset if he sees this.  
> 
> if (WARN_ON(!err))
>    err = -EINVAL
> 

It will. I copied it from GUP.
I'll change it the way you propose it.

> > +/**
> > + * hmm_range_fault - try to fault some address in a virtual address range
> > + * @range:	argument structure
> > + *
> > + * Returns 0 on success or one of the following error codes:
> > + *
> > + * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vma
> > + *		(e.g., device file vma).
> > + * -ENOMEM:	Out of memory.
> > + * -EPERM:	Invalid permission (e.g., asking for write and range is read
> > + *		only).
> > + * -EBUSY:	The range has been invalidated and the caller needs to wait for
> > + *		the invalidation to finish.
> > + * -EFAULT:     A page was requested to be valid and could not be made valid
> > + *              ie it has no backing VMA or it is illegal to access
> > + *
> > + * This is similar to get_user_pages(), except that it can read the page tables
> > + * without mutating them (ie causing faults).
> > + *
> > + * The mmap lock must be held by the caller and will remain held on return.
> > + * For a variant that allows the mmap lock to be dropped during faults (e.g.,
> > + * for userfaultfd support), see hmm_range_fault_unlocked_timeout().
> > + */
> 
> Add a comment discourging anyone from using this function and prefer
> hmm_range_fault_unlocked_timeout()
> 

Will do.

Thanks,
Stanislav

> Other than the concern about the timeout and minor nits this looks
> fine
> 
> Jason
