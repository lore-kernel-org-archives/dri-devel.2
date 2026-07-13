Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12663C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5151C10EB47;
	Mon, 13 Jul 2026 22:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qqXPbpsa";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E202910E610
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 16:56:15 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-388b404ea89so105079a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783961775; x=1784566575; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+wyTThpzWI663yfCX7yR0ohXV0bj+fwjL2+oCBrswHw=;
 b=qqXPbpsad4Ff23vhjTjQfJGs1mkZz7MjIXIIzbvfDvPMlV0LrpK99LsJAdACNYPiK5
 DECzYPgs8sMitz1nTAvb3sv5a0Ax5pVGUAsiR1hBrbYdpqfyDpK9g7f5zdyERlnQcCTJ
 /1SrK9kHugrRIDkQkszneIw+MTHZKubiyohMmqvYqU7S79SptXzmj2/SsjG8Dgsqh6ot
 cZ4a7pPggVPAQiMTm+29frYM/hgBbulNPg6fNETQiYRconjplhyuk1Hq4ARS4VE3YOsu
 vi3pFq6PGzoF5XdKwiex7oVMF+BUA7KvGlTuw4T5xDXtI8Pp3t9liGhh9QRowJBCePRw
 ITEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783961775; x=1784566575;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+wyTThpzWI663yfCX7yR0ohXV0bj+fwjL2+oCBrswHw=;
 b=g0D0At6u/tXlj3iggxLtDDqqL1FD4QKW0NusuvYcQM8LpyxZGjuXLq1NZBkKBvmOsf
 OxszadhchPQ0z7lP6SmcaYbp0BfRpFkNO0b0kP11qNdNZP+G55NyUFXEuswEFrmoytTY
 s+twmCJZcgalGD/0/BwNoF0KdgCGQwCgDquLt6DzZi76D7DQILsTkn6DRiofXhJI9E9G
 DLpqhZtoqGXgFiYabHSzCjo66qYgX/DUd8Bb2umkr6waqK5/aDuKZ37FxajUWz6WL1Lw
 C7eAp8V/FdFgaFopktcTyB9PvaWvP0v1leg8o1++Nexkl5WNIGwz+WjwKgcDNFHKpTPm
 uGZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqL4ixgXAotobPZ9RiYGKRY60WwHlVbXpPtOBnZFoIhK5menPMFP1BHxSnSmxt4+CGHo7go1Wkp8/E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/8oPIKvBt4fTt+xP6r7TIcB0d6yXUxubzIb/TVJIyEa8IVD7e
 2HzlMfKgexj9gVFhtZXfjXQCHr1MGG4wWIHWYJbgqb8/YmMGWO1dBSyQ
X-Gm-Gg: AfdE7cliqeVeYCUVgwiCLre4UbPt+9NVOoglnEkya1AO4PhSe18wKV5L3MHFZEBf3P5
 TSvYZNe68RIW8iWQWRRqL83MWVf3P+K3yLZYSDHd1k0nj3QrR4GQla8N2OTNr6xBFGnxwId86Gu
 4fZe00WPiwtAfneYyzP+yP5JQcim1UGREG4DrFLg0MwRlsoEOZU5cHLfiJpG9nDFNpbYfwmxyxr
 F2MidNreB+rZR8AGR2/H5gQyPCKCIbzWU5nIt8f1Oyfz7Rr/GR8W4TMRdzA3JJ5/Ozc0Objb/PR
 5/vFRAsmtadJir6InDbel08W2rtfSNmjMrSHZkYSSSSaCbaQK+1ZGJyEHDun2L0cWH52UFZnAYR
 GqYiySCHk/rGtJAH+W2MQMz20o+n+DFqBNQDC/VL9HRMHMt8WBidthH90TPFMDda7yFAKfoW62w
 xIBmKSu+2lYe16+2wmtQrdKvq+d6LxwJn0H8eKrobSahOJVQqK2+ML6Es=
X-Received: by 2002:a17:90b:57cb:b0:36b:769c:c037 with SMTP id
 98e67ed59e1d1-38dc81978ecmr7351194a91.5.1783961775319; 
 Mon, 13 Jul 2026 09:56:15 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e1745a596sm180718a91.15.2026.07.13.09.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:56:14 -0700 (PDT)
Date: Mon, 13 Jul 2026 09:56:12 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
 dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org,
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
Subject: Re: [PATCH v8 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Message-ID: <alUYrESVcHR_p-S_@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881034.900500.5214601525971121683.stgit@skinsburskii>
 <20260710151216.0397a6f9ac5c7b4ccd274cc1@linux-foundation.org>
 <alG1JwgUK44dCiN4@skinsburskii>
 <20260710224606.69235ab5c49b5987fd33e924@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710224606.69235ab5c49b5987fd33e924@linux-foundation.org>
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

On Fri, Jul 10, 2026 at 10:46:06PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 20:14:47 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > > > +	mutex_lock(&region->mreg_mutex);
> > > > +
> > > > +	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
> > > > +		mutex_unlock(&region->mreg_mutex);
> > > > +		cond_resched();
> > > > +		goto again;
> > > > +	}
> > > > +
> > > 
> > > If the calling process has realtime scheduling policy and either a)
> > > we're uniprocessor or b) this process and the holder of
> > > interval_sub->invalidate_seq are both pinned to the same CPU then
> > > cond_resched() won't do anything, and this might be an infinite loop?
> > 
> > Yes, looks like it might.
> > What can be done to prevent this?
> 
> Well the best way is remove the polling loop and use a proper sleep/wakeup
> mechanism - mutex_lock()/prepare_to_wait()/etc.
> 
> If the polling loop is to be retained then maybe msleep(1) or
> usleep_range()?

Well, running MSHV - or, I suppose, any other VM - on a uniprocessor host
would not be very efficient.

I’m not sure whether this corner case needs to be handled explicitly.
But even if it does, supporting or explicitly forbidding it would be a
separate change. As Jason noted, this is not a regression introduced by
this series.

Thanks,
Stanislav
