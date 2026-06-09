Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33551CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9571A10E354;
	Tue,  9 Jun 2026 15:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="AmWoTRd/";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C7810E354
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:07:10 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45fe59255beso2951945f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1781017629; x=1781622429; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3+lYmg1zjeWVIf3w85zVmJHhuwAn6RrT9xbEHdQoysw=;
 b=AmWoTRd/pcXd0DGDmfo67DRwFtgJ8Vn61B09FZbvFJM6SI1Xwu+etmRDhEb/KM1QRi
 NTn68glJL1CZIevLAMd8JU/Cy6m8w1Xx+8ycEKEkMTe3nFOmUyfDINmdEaU5U78sk+Qc
 vvm4KIlmuVvRnmiA0hIN4fd2GQfwXi6TEgb4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017629; x=1781622429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+lYmg1zjeWVIf3w85zVmJHhuwAn6RrT9xbEHdQoysw=;
 b=HyCQVEmpdEuOT1rT8IdgiHHFMD3Rke/gTT3AFT8TWNl4cAlDvrWf58ko4WSHyJNPIF
 +c3OGVWSRf6ppn0URfoz7eRmamFrcI98zbNK3sx+DfYIH6d3V0o0XvO6/yui78FMH89+
 w+Jzh87FV3RQK3T1xl7W8W1xFhyUZEzt0H+RSJ6FYrt4c6eEm+1gckKnLXLfBNjuWfFj
 tebFQ/sJCFCqk72WNH9xUelNYcHzL3FpQtc1mr35KbythIJevd50i8hu/YzojlAwW5ZN
 DYHbCHmm6lg/C5yj5f0B+8if7A3erL2T37IM1rXZOM0YFmf3P86c3bqNtqrRxHyiGlzC
 Lj9w==
X-Gm-Message-State: AOJu0YzrmpKmgdc/0cDOg7Bg7hQoxjOXArGslR5cPpNL9vMmFADYkJWK
 jYotDnEdrzvMucddpkr+hEREeZOJJ3jbiXTvv6MLEZ8kV5QwJBluadyBDCEYq+MSD6E=
X-Gm-Gg: Acq92OF2mwluZ1jb8grWWLqTUUDqpLYUnpCq2kcTOzhysW4hAudaGmw+9tY7TraYVkU
 0MnGXP7JetOjxc+TCgAXM/AE8ojNUKDYXvQo6Je+TYs/oqaoXjgae2Bt6em9vqHY7cIdu0LuIL9
 zKPZ9jycR5M5VtVn9YQLM2mbzjYUZGwZnfy/3E5jzJ5ONB7AXYUn8T8fqikW/wiVNTOteqt+cpA
 WlMZtvwhZx63z/r0u3l552XklIGp4fYmR8BgsA50PVCaynZNOr6ahOiCVngniYcKeXfb/+rib/7
 t3ezJmc+rvMgH9mRJfJFuD3/8aajBy6NKI+qFGzyrHo8yExDavhmbuRQizTQvBJeZkP/9Zo/6h8
 E21Tj5tjXPZ9P/oPpY+Q4tU6lwksyxjoqWYPkiG8Jk3uqkzp9tl/zAJJP9bykBZnp89nHtKNk88
 +0pFJEupDA3VPpQ4nrrxHXeYjjPckFRdJ4xdQtnblYZqjKWw==
X-Received: by 2002:a05:6000:46c7:b0:460:e0f:8d19 with SMTP id
 ffacd0b85a97d-460302e3193mr21015324f8f.9.1781017628989; 
 Tue, 09 Jun 2026 08:07:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46059346676sm1710506f8f.26.2026.06.09.08.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:07:08 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:07:06 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 Simona Vetter <simona@ffwll.ch>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: turning on sashiko.dev for dri-devel
Message-ID: <aigsGomurnOVWLVO@phenom.ffwll.local>
References: <CAPM=9tyvm1jAX5udJ8OU+39XzwZRATjjhHAWDn7kJug+NZKBuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tyvm1jAX5udJ8OU+39XzwZRATjjhHAWDn7kJug+NZKBuA@mail.gmail.com>
X-Operating-System: Linux phenom 6.19.10+deb14-amd64 
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

On Thu, May 28, 2026 at 10:14:41AM +1000, Dave Airlie wrote:
> Hey,
> 
> Just want to give a heads-up that I intend to ask Roman to enable
> sashiko.dev AI patch review to be enabled for dri-devel in a week.
> Will request it replies to the list at for a trial period I think it
> balances time wasted best, but also allows people won't don't want to
> see the AI reviews to just bin it on their end in their mail filters.
> 
> I also encourage the development of drm subsystem rules either via
> documentation updates or review prompts,
> https://github.com/masoncl/review-prompts

Bit late my take, ignoring all the big picture questions (which are maybe
more suitable for the hallway track at next xdc - I do have strong
opinions on all this), the one reasons I think this is worth it is better
docs.

> There has been some recent discussion
> https://lwn.net/Articles/1073583/ about merging the review prompts to
> the kernel or providing them as documentation.

Like Jon Corbet also pointed out, whether it's because people feel more
comfy giving clear instructions to machines, or whether the faster cycle
possible with an llm getting everything wrong until you're extremely clear
with everything, very often code agents docs seem to be much better. So if
we can land those in the main docs and if this bot helps people (for as
long as the vc splurge may last) to improve the docs we have so it spits
out more useful replies, then I think it's worth to enable it.

For me though this does not remove the need for review, which is
fundamentally about ensuring that at least 2 human contributors have the
illusion (we all know that we're often not that good for real
understanding, this stuff is hard) of understanding a patch set, why we
need it, and how it goes about solving that problem.

And at the meta level above that, the point of having that review is to
encourage collaboration across teams and companies, and improve our
community knowledge of how to and how not to write gpu drivers.

Anyway, firehose is on, let's see what happens.
-Sima
-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
