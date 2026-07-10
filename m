Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F35C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 18:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 247EE10E207;
	Fri, 10 Jul 2026 18:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="HaxJvCJf";
	dkim-atps=neutral
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E47E10E219
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 18:03:15 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-51bfbe05683so7212481cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783706594; x=1784311394; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pchhQjIZYIsHA+IyTP+kMOXOCiYK49mahPv3eolm7bw=;
 b=HaxJvCJfdQjx6HXwsmRuDWFXUXK3N5YVfskFy1aXMr02tVrW3Q+abEdEr0Ro8rG9Ua
 eGu3wUoho5qi9Y1FhZ07RXmSiirCgtrqkoDjh0utvrD72mkhLFqLd1cQNgV/NBtowtJq
 7YgnXLFVJCwrsGQugpBU0Yphr8YJIkisAxmt+nm2n/v83DromwhCKwAQZGZXy4Wg0qQ5
 UeRDuN/LDcRMhItQoxFcXaUI6crFDZAQZLXVTivK39wwc4qxL+ixt4RizBn1HyvzUQxj
 de7GYYiRKREUEBGk/JRplC2dYTmp9dH0brZhwKTj344TkV20PVMP1g6iqfzBO83s4PTy
 XuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783706594; x=1784311394;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pchhQjIZYIsHA+IyTP+kMOXOCiYK49mahPv3eolm7bw=;
 b=ZViq2EL1IVA7k4z1V/ddelQMTxutYEgmDIfqiZsJQKSfKX4fyF4SLB3oaOFSZQ81YX
 CmzzmrI5pLboqt+OLL8uCPVaJq2HBGg82vcTu+duoHUPNEJCKlz+9YbfekqUiox5xq0G
 ZxfZ/SWhtnTR+IzzVVoksJTjzzlIgbZcPjMcRUbBuOL7azFgrEFNgt8A4wbU526wheCG
 qGbZxfcJe6xFjQnCYvNoNFUlIve5PttHrWPJ3whlkRq7dmFoHhUi2munwf2BGN432+1V
 D/naVanmuMnmxL+tnd6zxAXakI5F0G64lLBGtr1py2cCLVDcziYdaemvkKByY/c2N/mx
 1DqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNwvqkt0P/455kJ+iXXVT58tLPh2MbdTbZFDkNcw1qhk/Dvw51HzD4AaaRg3lvR6VOv6QqnsHO6NQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxBK+Eo2qtYnTkdvMEe5Ql1fhfdoC8n5RGpu3AYwyKs0+Yt4an
 eB8cUmKijGsrSrbbYc/dc9B4wN/STRM+JW3mjjEQxGuTPSytztN99FvmR1QfFdRVGbI=
X-Gm-Gg: AfdE7clj+pjrpPQgtq0rDyro8u+b2JkPmA4ZgnKIfOxYun7aNX+JYZLJqDaMhhO8o7i
 Da/Ed/OH9xXWNk7aHeHb0kgTk4JjsgvwCrnE483Q3qQ/6/Ceu8CFlo+o9kUlz4HKlr+on+hWQy4
 WM7VI8EoTPA/53FrqqhnGKQloBwWAcU4bjNlNRkXhxinK2SFsWydxCbJMOAQ1Az2vFdFRIpHeiF
 uhx21TqRg7S8PsFzfjgX8IBXUDcycfmvTiir6OY/vduuBJqc1Tz52L9eh8Kc6SSMRaqTfny8C28
 17iPsvU1dSltZ6A5pZSePZ9ltawrQ8zKs1aifLwZ3pINJGWfpSk/Gnn2u5Vk0dxxLcKTLuxMlAU
 lVgFnHB/iUtEHIbsnCD2pj0b658UjLs+vBlhh624jVyFJd5axA8rVCZQ75WcQ
X-Received: by 2002:ac8:7e8c:0:b0:51c:7b13:62fa with SMTP id
 d75a77b69052e-51c8b438c0dmr129494461cf.80.1783706594020; 
 Fri, 10 Jul 2026 11:03:14 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd7c1fd2bsm47060696d6.27.2026.07.10.11.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 11:03:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wiFZA-00000007fhc-13JV;
 Fri, 10 Jul 2026 15:03:12 -0300
Date: Fri, 10 Jul 2026 15:03:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
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
Message-ID: <20260710180312.GD1803712@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
 <20260710164743.GX118978@ziepe.ca> <alElv0EKjLQXMNK8@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alElv0EKjLQXMNK8@skinsburskii>
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

On Fri, Jul 10, 2026 at 10:02:55AM -0700, Stanislav Kinsburskii wrote:
> The main customer for this new feature I have in mind is the MSHV driver
> which backs VMs memory with HMM, requires userfaultfd support for
> post-copy live migration and fast restore and it doesn't timeout.
> 
> I agree, that this current timeout value used by the other callers might
> not be enough to repopulate the mappings with userfaultfd, but there
> drivers would get -EFAULT for uderfaultfd-backed mappings without this
> change anyway, so getting -EBUSY with the change instead doesn't look
> like a significant change to the behaviour from my POV.

It sounds like it won't be reliable either then.

> > So, maybe the deadline should be resetting after every handled fault?
> > ie the timeout really is only about the mmu notifier and we don't
> > count the time spent handling faults or walking?
>
> The timeout was inherited from existing HMM users rather than introduced
> as a new HMM policy. Some GPU drivers use HMM_RANGE_DEFAULT_TIMEOUT as a
> budget for the whole range population operation, including HMM retries
> and subsequent driver mapping work.

Yes, because we always had a timeout around the notifier because that
scheme can sort of live lock. The timeout was to protect that only, ie
limit the number of notifier retries.

Expanding the timeout to be outside what is bounded by the notifier
retry is not right, and heavy stuff like mapping should be done after
the hmm side succeeds and the notifiers concluded so they can rely on
normal locking instead.

This is why I'm suggesting to reset the deadline as hmm makes forward
progress, we really only want to bound the notifier retry loop not
anything else.

Jason
