Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254DDC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD2610EA3F;
	Tue,  8 Sep 2026 07:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XlsQg8jT";
	dkim-atps=neutral
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1194510E4E4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 01:23:28 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-46aef6e48fbso2262394fac.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 18:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788830607; x=1789435407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=os1bxGgQvoOLa9ryjCYK+ThrfW/L4s5kmkzao71FISs=;
 b=XlsQg8jToh9lJVcs99p1ouPVJhfPxTNZKC+rmDyqHUf6l+LdlAU6Xzxm0u2ZTzZc9x
 iFYka4KdoiZFJi72y7ktK6a0wLQwiGpqS3rTKXJa2a+iPHJhSQWMRe7RJkFNVcAZFXhZ
 q2avvZ6LAwqJGcT/OWOkyGvq7fOvJ0/M0AZdCrSdqmM50IyGBa5bmNTmt/dx3AbZ9XMs
 mXiFldz5zyQni+yvMehE9NPTUW9r64ZuFNTmbmmQVWztkCYDJTzYeZbc8c5oUMBdOIT+
 1Mlu7ROnCWKMpHNHtlYVvu+YuYrIwwHckScJ43Ej/Vy4XkhVKJggEyrhypoG9vwpAKGl
 2SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788830607; x=1789435407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=os1bxGgQvoOLa9ryjCYK+ThrfW/L4s5kmkzao71FISs=;
 b=D9pFMV612GVjelZ5dBWdEdtrCjnkwMCvYKJHzi87XM/PWpsUda5o28fxjpDLme+6m2
 csck0ouZg66ZhOtmj/1/V9q3zw/DwyOajRBc9+zM9awHUMBNMfupZZ9m4PFCbEP73dwk
 SUYxjvhhfi7Wb0tIjy0Ky1N8L4me1h+hcVb6qdpxT2q5tx1Oq4rHAhEgnBfg+94Mngu4
 VKpg1TkyqW4KyCBuQN2+C6XGvJCvZ63uRDTgzNLhDVkd62dT2BHV8nu920+hcN/6rY4H
 aunhmGVyaU8dHsWSf6Q5Pe0bABxL2M87YOOXC6krnk6N96ucPItC3b1JdhaMNeSED7/N
 ZPfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrCSGFHEIE6yyyLpMKAvb+SVaQOk61de9yF944SXKmPwLcyaoHC3o8r7MKFaWhxmWSlEL9dpxRqGQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nEDUx385HoIHnluWWQfVQFC0RY0tQ6FRPvTpzUF0IAGdC/PmSH
 OwtKtI3SIf6jeCBumglzhoR+/3YjNeyTuWl8tRPvSzWPEGUtAnhTQNO+
X-Gm-Gg: AYBFou17g2e3uGPeNaxIlHSpvgoRd9HzVeB8PalHFbMgW98JWoNIWG+3HUCL/aCdw1+
 OlJXI7j8b107s9sMwN7HRmHgJPgktZroCz8y0REE40E9QH748EHM0pM3QQIg9eN4Dcoa4Pb9qJ0
 LSeOFGLFRf1yoM3JdEBgBDCD7hz+Fdh1ZqJS3fwfE8Sb9pavQPFi+vZ3N6wgwanjIMM4Um+SKAi
 QmBtH4jxVpWLjZqDDvEAIfq0YtxQmbF8iON0u0rLaQS+S4G66Em/glIiSSdIJVAjIqU3AwP8tJ7
 RtPL0Fio+I6eZBOwkSFYyhjb6AUSSddobR1vf8T5SsFPQN/WPIS+i7+kWYi8d+rhCJyiQcYiUeV
 Wnde1cuC7FbOICei6wHw8qiC/B/tFrHrVhJiiA7ixJ8OFeERhlZSUvY3Dn9bKDadOg9vqz5YTGw
 ABOROuj3CcCQ34pthdRKOLYGK9uHGvG7Z5dbbuUKDc0e5RWlnye1bNLaIeEsoC0eaFLcorAsrku
 k64TZ07CstPZAhwN3E=
X-Received: by 2002:a05:6871:c301:b0:457:494b:1548 with SMTP id
 586e51a60fabf-475516ed3a3mr34561336fac.5.1788830607148; 
 Mon, 07 Sep 2026 18:23:27 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475543f5ac5sm12322726fac.8.2026.09.07.18.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 18:23:26 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, dev@lankhorst.se, mripard@kernel.org,
 nat@pixelcluster.dev, tj@kernel.org, mkoutny@suse.com, osalvador@suse.de,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-team@meta.com
Subject: Re: [PATCH v5 4/7] mm/page_counter: use stock in
 page_counter_try_charge
Date: Mon,  7 Sep 2026 18:23:24 -0700
Message-ID: <20260908012325.1770706-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ap86vDv143VHvrzh@linux.dev>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

On Mon, 7 Sep 2026 16:21:33 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Mon, Aug 31, 2026 at 09:37:48AM -0700, Joshua Hahn wrote:
> > Transparently make page_counter_try_charge attempt to service the charge
> > from its stock. We preserve the same semantics as the existing stock
> > management in try_charge_memcg:
> > 
> > 1. Limit-check against the stock. If there is enough, then skip the
> >    hierarchy walk and charge to the stock.
> > 2. Greedily attempt to fulfill the charge request and refill the stock
> >    simultaneously to the hierarchy.
> > 3. If this fails, retry the stock and charge without trying to refill
> >    the stock, i.e. with the number of pages requested.
> > 4. If the greedy attempt succeeds, return excess pages to the stock.
> > 
> > page_counter_refill_stock() falls back to a hierarchical uncharge when
> > there is no stock, in NMI contexts, on lock contention, or for a refill
> > larger than the batch.
> > 
> > The greedy charge is also skipped in NMI where both stock helpers bail
> > out since the batch charge would be undone again.
> > 
> > No functional change intended, since no page_counter enables stock yet
> > and counter->batch is left at 0.
> > 
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >  include/linux/page_counter.h |   2 +
> >  mm/page_counter.c            | 135 +++++++++++++++++++++++++++++++----
> >  2 files changed, 125 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> > index c1fe331f34e7e..428ca8e7b2da5 100644
> > --- a/include/linux/page_counter.h
> > +++ b/include/linux/page_counter.h
> > @@ -82,6 +82,8 @@ static inline unsigned long page_counter_read(struct page_counter *counter)
> >  
> >  void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages);
> >  void page_counter_charge(struct page_counter *counter, unsigned long nr_pages);
> > +unsigned long page_counter_refill_stock(struct page_counter *counter,
> > +					unsigned long overage);
> >  bool page_counter_try_charge(struct page_counter *counter,
> >  			     unsigned long nr_pages, struct page_counter **fail,
> >  			     unsigned long *nr_charged);
> > diff --git a/mm/page_counter.c b/mm/page_counter.c
> > index 3f61eba695518..a76949abf04e7 100644
> > --- a/mm/page_counter.c
> > +++ b/mm/page_counter.c
> > @@ -113,25 +113,126 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
> >  	}
> >  }
> >  
> > +static bool page_counter_consume_stock(struct page_counter *counter,
> > +				       unsigned long nr_pages)
> > +{
> > +	struct page_counter_stock __percpu *stock = READ_ONCE(counter->stock);
> > +	struct page_counter_stock *pcp_stock;
> > +	unsigned long flags;
> > +	bool charged = false;
> > +
> > +	if (!stock || nr_pages > counter->batch)
> > +		return false;
> > +
> > +	/* raw_spin_trylock isn't enough to protect against nested NMI in UP */
> 
> I don't understand what this comment is trying to say. The nested NMI is
> confusing.

Hi Shakeel, thanks for your review on the series!

Yes, I'm sorry about that. There were a few layers of protection that
I wanted to make against nested NMI, ordering, publishing for stock, 
etc. I think I didn't make it clear what was happening, so I'll
address that in the next version.

> > +	if (in_nmi())
> > +		return false;
> 
> You are completely disabling stocks for memcg charges in nmi context. Why? I
> assume that is what the comment above trying to explain but it is failing.
> 
> IIUC you want to use spin_lock instead of local_trylock because you want to
> support draining from remote cpus and spin_lock on UP are simply disable irq and
> does not protect from NMI. Maybe you need spin_trylock similar to local_trylock.
> Not saying you to implement that but please explain stuff clearly.

Yes, that's exactly what it is. I think there was a lot of thinking
on my end on things to look out for that in the end it just kind of
became a jumbled mess, I'll definitely do a re-spin of what's happening
in the next version.

> > +
> > +	/* It's OK to migrate here, since stock is fungible within a counter. */
> > +	pcp_stock = raw_cpu_ptr(stock);
> 
> migrate between cpus? Why? What are you gaining by allowing that?

All I was trying to say here is that we don't need to drain an exact
CPU, all we need to do is to try and get any CPU. So if we migrate
and get a different CPU's ptr than we initially started with, it's no
big deal (that's what I tried to explain with saying that stock is
fungible). But I agree it's a little lacking in explanation here,
I'll rework it in the next version.

> > +	if (!raw_spin_trylock_irqsave(&pcp_stock->lock, flags))
> 
> Why do you need to disable irqs?
> 
> Anyways, you are changing the fast path of the charge drastically. Previously
> there was no atomic ops and not irq toggling but this patch is adding atomic op
> and irq toggle (not sure about why irq toggle is needed) on the fast path.
> 
> I understand that remote draining is the only reason you need to use spin locks
> here otherwise you will need to allocate work_struct in page_counter_stock. You
> are making these design decisions very silently and implicitly.

I agree, sorry for that : -(

> How about we decouple the decision of remote drain / spin lock from moving stock
> inside page counter? First move the stock to page counter without any spin lock
> or remote drain and later in the series you convert to spin lock plus remote
> draining with performance numbers.

That sounds like a good plan to me. I'll do exactly that and send a
new version.

Thank you for your time Shakeel, I hope you have a great rest of your
day! : -)
Joshua
