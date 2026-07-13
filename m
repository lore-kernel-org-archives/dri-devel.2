Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA199C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104A310E5EA;
	Mon, 13 Jul 2026 14:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="AvSbfpD6";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3632510E5FF
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:55:06 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-51bfbe05683so23733511cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783954505; x=1784559305; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IZhqR4JgKFkSLvdz8vThCe3gL1K7igiBUDMCwA8QSjs=;
 b=AvSbfpD6jIRj+KUZKP81+8XL2fltvzoIzPPoHWTNPRnx3RTDeKqLpGVHHvQSgl59z7
 gF4s4Hc6dyP6J0kaBMABJC1CkhNuoojiukKhS0TQiTotnQGDWUPXu+8tp6Sxo5/3M6h0
 Wptj8uTAR9VauxnIqBYvoEvfze4V/7AAJ/Wa7A0sXpne1ebIMaiTFJRL75J4dx2EJjzK
 ojBxeT/vRF9YhC7eEU9EWfOlw7ELhiyQwx0kihZO52BxyU1W8OaVRmKB2Qu9rBEAmYz/
 VjikekBolZhtJ9VB/FE0ZSGoduSto0qn9blOGX8/1aPKIcBO9TmTWzOv0HmHWCcnUVir
 gk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783954505; x=1784559305;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IZhqR4JgKFkSLvdz8vThCe3gL1K7igiBUDMCwA8QSjs=;
 b=rEe4Knsq6yZp4lh+lg/TBo7YiTk8KE/RuLvGuJhrVVf3DzARKmT5Yfhoas+vIO19S7
 Mox5naO3wkMLEhoKfsfKXHEoJmk7baKaJzMR6xeQoRAaEfrl4Tf6aYNSJqkDGYweFtlQ
 2EfnrR7HbroUnYxrI1B3L94Bc0BZDUFY0I2PIw3wvhd4mbhEC07cw+QyHzFhRnxt5tUY
 Gg2kjAp8N4n6siE8pWTEgehZaulnTKPtgjxhmwYBCUveGg9tNNUGQhb2vFIIKbOv7iBS
 YBDTlCgrxsJpwncaCJs9Q27xQExn5Ty0+lGC5ljqg8QC/le5RrEwBoaNx0BhZoV6k0SF
 CfBA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1Z/xtkZrMHcDqAG4bzfek6KwBKRbNEsnZXAmiaJ0a0MUkBnsBgewXn+URjvtf+cgLZdFBOB/YzEo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwK+NJA0JXBgNdWiCXDWcTgOe4JjNOtENaVnXA8sk67SN5LKlL5
 KySL5oRTYmWRhp6zuf/hjE1KHVSrE1E1w/uRo3jRkjrXYxTX9QG7bOrlqOTEsHRzeTs=
X-Gm-Gg: AfdE7ckXke3jMOEirWWTcAsWokqa0fdPH5RaUCOdiCn+OjVF0Hj1KogSdVd+iDLl3Sv
 3Sk/mbv1/7hS9cqIWIcv4FUNsYqMZYcZI7VG5tIEOhahmDVXVS7BCXIYjJati7npnicmKfTPwt6
 lC5eHUQKDYe+D6rfJcAyvfrV9r8Zr9NlgGuRxhuVYPETEmR9ijVE2DcK07/tvZAn2XNuozg7nQb
 YLKAlRtsZpeff2xhntb0BRWoK74iu6hOsFIihRlJ9/WNj8wKulntdu1zpDkom5rYz3XjZpFAUHg
 eAD46nR/AgObVuZEDo9QT0McU4rrspRi4TcwKBLaOd9BvQY1+TjtNP48yR5CZ2K43kDtEjZHqYL
 xStnZMsXcq7XaJKpFjomVuhrzSTz9VsI1tA3rJMIrJWiKnu75yVHhzUmc6irWY1Sv2JHgS0U=
X-Received: by 2002:a05:622a:1911:b0:51c:504:2ef7 with SMTP id
 d75a77b69052e-51cbf305510mr90471451cf.67.1783954504822; 
 Mon, 13 Jul 2026 07:55:04 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caab6d574sm84876451cf.3.2026.07.13.07.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 07:55:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wjI3j-0000000DQQj-2xH1;
 Mon, 13 Jul 2026 11:55:03 -0300
Date: Mon, 13 Jul 2026 11:55:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stanislav Kinsburskii <skinsburskii@gmail.com>, airlied@gmail.com,
 akhilesh@ee.iitb.ac.in, corbet@lwn.net, dakr@kernel.org,
 david@kernel.org, decui@microsoft.com, haiyangz@microsoft.com,
 kees@kernel.org, kys@microsoft.com, leon@kernel.org,
 liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com,
 maarten.lankhorst@linux.intel.com, mamin506@gmail.com,
 mhocko@suse.com, mripard@kernel.org, nouveau@lists.freedesktop.org,
 ogabbay@kernel.org, oleg@redhat.com, rppt@kernel.org,
 shuah@kernel.org, simona@ffwll.ch, skhan@linuxfoundation.org,
 surenb@google.com, tzimmermann@suse.de, vbabka@kernel.org,
 wei.liu@kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Message-ID: <20260713145503.GC3133966@ziepe.ca>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881034.900500.5214601525971121683.stgit@skinsburskii>
 <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>
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

On Fri, Jul 10, 2026 at 03:12:16PM -0700, Andrew Morton wrote:
> > +	mutex_lock(&region->mreg_mutex);
> > +
> > +	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
> > +		mutex_unlock(&region->mreg_mutex);
> > +		cond_resched();
> > +		goto again;
> > +	}
> > +
> 
> If the calling process has realtime scheduling policy and either a)
> we're uniprocessor or b) this process and the holder of
> interval_sub->invalidate_seq are both pinned to the same CPU then
> cond_resched() won't do anything, and this might be an infinite loop?

I think hmm and kvm have had this issue for a long time? I don't see
anything in the mmu notifier locking scheme that would alleviate it at
least

So.. In terms of this series I'd leave it, it is no worse than before?

Jason
