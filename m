Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86B4CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E69410F3CA;
	Mon,  8 Jun 2026 13:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XO/eh56Q";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C6210F3CA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780925478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iewDQSsA13YrnQ4UInBbfMz/SjkA5BPlaeZcu83emSo=;
 b=XO/eh56QoZAqv1MOnVoOmHnAgGGL5loCMhTBWpcFna7Xjm43JICpSaAEuY14F5w/yClj1S
 AtpiCVz0NkGhGegR2xp4Mo2sjLM71+2SadJ49KBp1P1xU1+ycInC+923Dcg9nf6nymAPq+
 AABjF9W565eKfwxqwp498Vaz6a+C/2Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-gBNa3036My-UENq3XoA89Q-1; Mon, 08 Jun 2026 09:31:14 -0400
X-MC-Unique: gBNa3036My-UENq3XoA89Q-1
X-Mimecast-MFC-AGG-ID: gBNa3036My-UENq3XoA89Q_1780925473
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91598ab3a1aso650562485a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925473; x=1781530273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iewDQSsA13YrnQ4UInBbfMz/SjkA5BPlaeZcu83emSo=;
 b=NNOYIS2CQf4i57wsO6rUDF8MX1FsI5TzU9lPvT95VbK9tPoGj4xnTviyra8X4zIasH
 xkckqmrJLbHQfz4PFpkV1I/W1ha5RuwsMD6RSz1V3uBxFemn3JpeUML+oJZAZEJtgRfN
 d/temb7wNekFA2b2tvJ8kVEKy9Su4Ii4xE6O0PRdhIzkwOuHV9qmJDO1i60iSKccVmVF
 p7CXm3V3sc1d+Ib7lL9+xDb69uFs2CJYZnRQRgv7lAj2ifqPlyJX2N40+UFpn6sCPJYd
 l7ge+4BPBNxedktqsCuwusTKfvA8zyHlmA+ao8dleeWq1wIk6iycAd8kwzczM8kDswQ3
 jfsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JsKPiZgP0eHGIjbTZOnphMW95LAETEatIDjlYh3DNLQbBNnOKvdX0xltqP3O1xIM2VDf0cyCjJUA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHD07KqzzsuYBhoX+ZVof70YtP1SHxufA9HrgjkT6/kScLfk7n
 VvGXOFa31FOPFxH5uvDE1xFfyMnPHmdub51k0cJe0IfN0+UKlxysZYfpfUZ2seafGSTxIaJDlUP
 xuMNPYcNj82L8Eg5MHnxpH5luiXhCZUYF0tKTMA0M3xUwNku43iIop7LIZDRGH5pAVSQZ2Q==
X-Gm-Gg: Acq92OHH6sYnNEpfrFW3YqQwkY0JgbjhMEk0NIVXSYaxAJtfXnw7nsiLsHt38QfqHFM
 5aHwXw13ibsPwiTYYlyNgJCl2yT7d6p2V83s/MVDkzJLgh8eivytXhHCE0uxXleWVYDE00nxQm1
 ANe9iybF/kPTEkR6c/tcgpuY4mEdsljvZV4fUtfMYJOVZmPbVoOadIbfqUgEy6tM6alnir59f9L
 +6Jtd4Eso8t6JCjAhVexmZavBbMFE3HZdJx9Eoas99xdfn7Llc64uew0RjYQhWLVV2iqZ3MitGH
 V2gX2bdYFYF6cybTCgr8a1xtGlGH3L1GNOv2i3+ZXZ9sc904MiOOTdY+FmdDBPd6P1lqLcGwPS+
 JbCwxW4Dt/PT/VXrKgQJggOLHUHCGdbO6O2AASdiPb1H3Qp0MSTdEWAxa4FM6EWoCHsFbqmu/9U
 s+
X-Received: by 2002:a05:620a:4546:b0:915:cf88:1e3b with SMTP id
 af79cd13be357-915cf882096mr770203485a.47.1780925453637; 
 Mon, 08 Jun 2026 06:30:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4546:b0:915:cf88:1e3b with SMTP id
 af79cd13be357-915cf882096mr769780685a.47.1780925431588; 
 Mon, 08 Jun 2026 06:30:31 -0700 (PDT)
Received: from localhost (pool-100-17-17-231.bstnma.fios.verizon.net.
 [100.17.17.231]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a238f8esm1762107885a.15.2026.06.08.06.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:30:30 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:30:29 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, 
 Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
Message-ID: <aia9FfWlmRivZCQe@x1nano>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
 <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
MIME-Version: 1.0
In-Reply-To: <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pp--lmFJEt9s72clOko0fEELozMH-Fl7_D9_cit1wpw_1780925473
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Sat, Jun 06, 2026 at 06:31:53PM +0200, Natalie Vock wrote:
> On 6/6/26 00:44, Eric Chanudet wrote:
> > Accept only one "region value" pair entry for the dmem.max, dmem.min,
> > dmem.low files.>
> > This changes the UAPI that otherwise accepted multiple lines for setting
> > multiple entries in one write. No existing user is known to rely on
> > writing multiple regions in a single write.
> 
> Ugh, shoot.
> 
> For dmem.low specifically, there already are some userspace thingies
> floating around that may write more than one region/value pairs.
> 
> These thingies all depend on that one patchset for dmemcg protection that I
> should really get around to merging[1]. Since the userspace utilities depend
> on not-yet-merged patches, they sort of have to expect stuff changing under
> their belts, so I wouldn't really consider those users a blocker by
> necessity.
> 
> As I see it, we could go down one of two paths:
> 1. We go ahead with the patch as proposed, and I make sure that the users I
> know of adapt. Could be a bit icky wrt. "do not break userspace" rules, but
> since the already use non-merged UAPIs in one place, you can argue that
> these users kind of have to expect breakage.
> 2. We use the old handling allowing multiple lines for dmem.min and dmem.low
> only. This preserves compatibility but uglifies the code by quite a bit.
> 
> All things considered, I think I personally would prefer going with 1. and
> taking the patch as proposed and just having one codepath handling every
> limit file. Just highlighting this so we don't do it on accident.
> 
> [1] https://patchwork.freedesktop.org/series/163183/
> 
> Some more review comments inline.
> 
> > 
> > Processing multiple regions in dmemcg_limit_write() could quietly change
> > first limits before failing on a later one and returning an error to the
> > writer, with no indication some changes occurred.
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > ---
> > Follow up from discussions on a previous thread[1].
> > If Albert's series[2] lands, I can cleanup and prepare some kunits for
> > these as well.
> > [1] https://lore.kernel.org/all/158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se/
> > [2] https://lore.kernel.org/all/20260519-kunit_cgroups-v4-1-f6c2f498fae4@redhat.com/
> > ---
> >   kernel/cgroup/dmem.c | 70 +++++++++++++++++++---------------------------------
> >   1 file changed, 26 insertions(+), 44 deletions(-)
> > 
> > diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> > index 6430c7ce1e0372f59f1313163fb7630ce49ac1ef..113ee88e276296bccb4def546adf5cc175d7f0be 100644
> > --- a/kernel/cgroup/dmem.c
> > +++ b/kernel/cgroup/dmem.c
> > @@ -734,57 +734,39 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
> >   				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
> >   {
> >   	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
> > -	int err = 0;
> > -
> > -	while (buf && !err) {
> > -		struct dmem_cgroup_pool_state *pool = NULL;
> > -		char *options, *region_name;
> > -		struct dmem_cgroup_region *region;
> > -		u64 new_limit;
> > -
> > -		options = buf;
> > -		buf = strchr(buf, '\n');
> > -		if (buf)
> > -			*buf++ = '\0';
> > -
> > -		options = strstrip(options);
> > -
> > -		/* eat empty lines */
> > -		if (!options[0])
> > -			continue;
> > -
> > -		region_name = strsep(&options, " \t");
> > -		if (!region_name[0])
> > -			continue;
> > -
> > -		if (!options || !*options)
> > -			return -EINVAL;
> > +	struct dmem_cgroup_pool_state *pool;
> > +	struct dmem_cgroup_region *region;
> > +	char *region_name;
> > +	u64 new_limit;
> > +	int err;
> > -		rcu_read_lock();
> > -		region = dmemcg_get_region_by_name(region_name);
> > -		rcu_read_unlock();
> > +	buf = strstrip(buf);
> > +	region_name = strsep(&buf, " \t");
> > +	if (!region_name[0] || !buf)
> 
> If buf is NULL, isn't strsep(&buf, ...) also NULL? region_name[0] would
> therefore be a NULL pointer deref. Flipping the order of the logical or
> should be enough to prevent this.
> 

I can do a v2 with that today.

I added it if there are no delimiter found (e.g, if only the region name
is passed and strstrip() ate any trailing space). Although, buf can't be
NULL in the write callback iirc, it's either pre-allocated or
kmalloc'ed.

> > +		return -EINVAL;
> > -		if (!region)
> > -			return -EINVAL;
> > +	rcu_read_lock();
> > +	region = dmemcg_get_region_by_name(region_name);
> > +	rcu_read_unlock();
> > +	if (!region)
> > +		return -EINVAL;
> > -		err = dmemcg_parse_limit(options, &new_limit);
> > -		if (err < 0)
> > -			goto out_put;
> > +	buf = strstrip(buf);
> 
> Do we start allowing extra spaces between region and limit as well? Would
> also be fine by me, it doesn't break anything, just highlighting that it's a
> change in behavior. Should perhaps be documented in the commit message, too.
> 
> Also, you should be able to use skip_spaces() here for an equivalent result.
> I'm not strongly opinionated on either way, but using skip_spaces()
> indicates more clearly that this can only remove spaces at the start.

Same I can add to v2, I failed to notice it wasn't allowed in the
original logic.

Thank you for the review.
Best,

> 
> Best,
> Natalie
> 
> > +	err = dmemcg_parse_limit(buf, &new_limit);
> > +	if (err < 0)
> > +		goto out_put;
> > -		pool = get_cg_pool_unlocked(dmemcs, region);
> > -		if (IS_ERR(pool)) {
> > -			err = PTR_ERR(pool);
> > -			goto out_put;
> > -		}
> > +	pool = get_cg_pool_unlocked(dmemcs, region);
> > +	if (IS_ERR(pool)) {
> > +		err = PTR_ERR(pool);
> > +		goto out_put;
> > +	}
> > -		/* And commit */
> > -		apply(pool, new_limit);
> > -		dmemcg_pool_put(pool);
> > +	apply(pool, new_limit);
> > +	dmemcg_pool_put(pool);
> >   out_put:
> > -		kref_put(&region->ref, dmemcg_free_region);
> > -	}
> > -
> > +	kref_put(&region->ref, dmemcg_free_region);
> >   	return err ?: nbytes;
> >   }
> > 
> > ---
> > base-commit: 640c57d6ca1346a1c2363a3f473b405af979e046
> > change-id: 20260605-cgroup-dmem-write-single-region-9bf05b6d995d
> > 
> > Best regards,
> 

-- 
Eric Chanudet

