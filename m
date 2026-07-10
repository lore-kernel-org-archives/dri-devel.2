Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC68C44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B0A10EB08;
	Fri, 10 Jul 2026 16:47:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="PqMi8Yx5";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8C010EF62
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:47:46 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-92e5d6f35c1so93387585a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783702065; x=1784306865; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ldYpDeT5zs3T98XMfsT8ni9uE73SXe2oYxwTATvCf1s=;
 b=PqMi8Yx5YWe6HeOiDa2LLyY8lAd3khqR+MZgLO4P38qIN2ymRKKHEK7QZcmoAjrhAj
 2qR2jZFyJp4NPm3TOexw8N7iJaECOXRS8eoOL6qpHMo+adpbUFhwFRPDlp9pFolF8Z24
 QoCbjSrdT525sUoyor/Bq1bRRb+P044aBDPbkF+Yqlk8/0z1fwgdLb9oNKbUEHLq170P
 6JAqplJx7qzNFzk7HvyUUlX2v5J8in63ACULFXhSHIVlatOur2WxdP7iOoNAjYP/tPtK
 LV/iJsjU789K2cnnX8p5jP8PlPenRi9JlVOaXfyLt2wJ75USWsXMQRBUAYYUpFhRgnO0
 7r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783702065; x=1784306865;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ldYpDeT5zs3T98XMfsT8ni9uE73SXe2oYxwTATvCf1s=;
 b=PJIVgCypD01QnNloKy5k5X4mJwanXO0JO4XL+EnO8HCdP3Jv5UF5g+jEN2L/v68wtr
 H9+Et94fJS1+Sk5BK2cwvThzdu3mzXwOIp9VO08TTw6izrODdRzqT07jHsXtu4u33kVP
 uF5YjnXj6/Y5cV8FnmFcOi4MtFkazTb9utjClamVkmOn32SHKLHUkwizDK6DU5gIJSPH
 f/L+wNljhjXbJwJwdTB5uHTbjxYQZJX3JM0aeRtOHO8JB/KevwnvyJfm5sZpizpZ16r0
 bIv5kXJwvEjuyMIprrET/qnqvRCoqwSx1k8MIhPZ6jgLjYf4WWkgirFGqYRzg2pbFQSG
 KAfg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1V2m0l+ieIaw2J93WyZ6ENTkWgLIXhVlqIySykcVLoEbam+ivXn8/HP/Lea4bmYvPWWbXb17wz7Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwafQBTWcjJO8qXxvIgunQ/h76qHgzKInevIvFgwXy9uY9ObiW3
 /XjpCMYsqB/5FKCxgcVjao3LARK76T8iWsWWe/SOcBKqqn+GXmZqIV5wSW0Vcc8GhUo=
X-Gm-Gg: AfdE7cnK28CPEBTPwitlG5CREFwYjW/hqjpZFbYk7EuGVSKScx8g/E5OydPSI+JmVzA
 owUOzkMs4n0JccIxcEHIixOSWE/SA8jV4prDSaL0TvxSQBrXI8zLmppzEl9yKxLhN6GyH//2h+7
 6jL1EzYqhPEWF8oFJmIqSB5/jrhvEoEoPRte/t8Bb4u51cOdPT976Il33B2QRovOuh6b8ituEQG
 /HumcB8y4qLBzXQqw/y8OMydTb/0Ygr1eBY9x+1peKv/gyHYh18MS1XvvN5XsaxE2s8zWaCYBqG
 aY8Q53IE2MZIPJlKqpZ7DnoVqyFIt7r34leBmDn9a6Sh7vslNtuffSn9kc+vQilz31kdpwHHb89
 U/vDWQrTXIH87wnVzETELmYGl713Zwz7lUzRKfa3ZLVQbBBR/J80H3rx3BS+s
X-Received: by 2002:a05:620a:4044:b0:92a:3ceb:9cf1 with SMTP id
 af79cd13be357-92ecf68b839mr1385461685a.37.1783702065110; 
 Fri, 10 Jul 2026 09:47:45 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd5bbac2asm45778726d6.21.2026.07.10.09.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:47:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wiEO7-00000007ZDn-3hnt;
 Fri, 10 Jul 2026 13:47:43 -0300
Date: Fri, 10 Jul 2026 13:47:43 -0300
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
Message-ID: <20260710164743.GX118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710162749.GP118978@ziepe.ca>
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

On Fri, Jul 10, 2026 at 01:27:49PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:
> 
> > +int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
> > +				     unsigned long timeout)
> > +{
> > +	struct mm_struct *mm = range->notifier->mm;
> > +	unsigned long deadline = 0;
> > +	int locked, ret;
> > +
> > +	if (timeout)
> > +		deadline = jiffies + timeout;
> > +
> > +	do {
> > +		if (fatal_signal_pending(current))
> > +			return -EINTR;
> > +
> > +		if (timeout && time_after(jiffies, deadline))
> > +			return -EBUSY;
> 
> I really dislike there is a timeout here, HMM is supposed to be more
> deterministic. GUP doesn't have a timeout, what is this about?

It looks like you've moved the timeout processing related to the mmnu
notifier sequence from the callers into this helper. I'm fine with
that, but maybe add some comments that this timeout is helping
implement the mmu notifiers, and we do expect that the HMM part will
not timeout.

Though it is a little hard to see how your stated purpose of enabling
userfaultfd is going to work, aren't you pretty much guarenteed to hit
a timeout if the userfaultfd process is adversly scheduled? That's
going to end up broken.

So, maybe the deadline should be resetting after every handled fault?
ie the timeout really is only about the mmu notifier and we don't
count the time spent handling faults or walking?

Jason
