Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27600C624DE
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DCEC10F3E8;
	Thu,  3 Sep 2026 07:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tIAjhwtk";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B865010E3E8
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 14:11:39 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso2511017a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788271899; x=1788876699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LHkkshZ3PVxOZzqbwKcqNzDLof8u7Tm/vxYAm4UhRQc=;
 b=tIAjhwtk7j6tTVNQK4YaM0Z5g27ZiNPd5uOlWxhfAktI2p7NnfIQxORtdU1aiAGy+W
 J/Syp2ckejpSwa3zbHq20I84C9ZpXwWVi0Z740U/BCqMO5Z86v156IGxUAPyXVyL+YUM
 AYIzzXaZI5h/jXg7FUzSUQTBkOaHunL8Z/twutcGl2pTRz8OmmKLLmPL2YDzN0iZqQ9a
 o6f/l7/g9Tiv4jguFOe1GfQd5ZUuxSaPkW0h+UO+3HjMokReUGOd2MsOIS8D/MrxmP80
 SyPZzSnRpbR36rTrASI6pw96SuC1/2NOqEXNPUVNrXtqkdWEUm7n78rhjXuwLTckxJK8
 561w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788271899; x=1788876699;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LHkkshZ3PVxOZzqbwKcqNzDLof8u7Tm/vxYAm4UhRQc=;
 b=FJHp1t+80m8dN6BgJIuUBgRd69x2vEmAuuLVKWLgymtz2pA5hXkoQYYsYvXHeSZ+wC
 VZqi7WrxbrGFPNjdJH/J/10vGKuu23Spuj3w8a2TBXLZfgO5gTMjM6FmhH42Ru8s8qsx
 ArjPL3jGK16BbZBKuM9XkYUF7OKzeOGlWp1TYHXt8zatRRvotIjNA1aHs5kCC1Vyhc0m
 HD5IylxeVB5eSAAwAo7wIZUas9V3+LL31Q2HQtn5NqPz0kkPNyPpEcvBViIBRhkmkDrZ
 6c8EH5cNaxjSUh3iwkXqLXXPmTlAlSQgiL+2kC5Xwuegqzd+DMXZTNaFYcnZY2oWEV3O
 trBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMRRkW6/UhvtkcigpD4s05I1OjHgFYY/zdjPHk0zdW79veWzCJyYvq7G3gjQ9Tp+m7l9bcnLpuTIA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mCZ7I8zCYKzFmcnG46Wyy7RbOMvMWcXYKVRo2zloaFxyH/Aa0E
 GPiHRCFl8T2VQ0rrpZ841ZmErQfOJfealkkrlbF8kzuq0ScxWxL9h9yd
X-Gm-Gg: AR+sD12H1/lNb12cI1iItkbeDuT8V1Lp6FXwgyfn1X6i4lqKdpDhIs+3PkVPQexYcG0
 f762/KU/RCw8gVFT2qkYGxe7AUiGn993YCQvAlDxx7LLZ921rcslIBTe4lp8pNpfh0+/EhG4mjL
 F5sUrn04BzfBFeiMbTRTWZ00H73VGbg/5nxaAw0zjribsuFfBAfxcj5nVv3Kru/kBs3UJlb3sJW
 Grq112C/FW+ijClJvRJufTO9adyVSagMRTdofm8iyzrOfnr/dutIgq72gQMVhTGO0ljAWcLbs23
 xL8aaMvrIoXbPBb3vw7nn4A6UwXMwS4hncEgikFfqEnsW6VaHmykicK+gF8slTrJDnVMTgS+sO7
 0Sdnd1L4nyhcp4V6SW368TjlkPY93h42QAgwwuA14wdo22rPV9Lf7Aei5TH1J/vl92D7CY5C4Uw
 kbAoR/ce74TJi+qWDcXw3hNRIwyp3em1lCthwFcqUxD/LE3ekxyiSG6I3GazkYEuwmSslThVY7o
 c9On9cX6a0//CY+l/g=
X-Received: by 2002:a05:6820:160e:b0:6b1:464d:4d1d with SMTP id
 006d021491bc7-6b1c65bfcd0mr34936183eaf.11.1788271898644; 
 Tue, 01 Sep 2026 07:11:38 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1ce359f82sm13402124eaf.14.2026.09.01.07.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:11:38 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, dev@lankhorst.se, mripard@kernel.org,
 nat@pixelcluster.dev, tj@kernel.org, osalvador@suse.de,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-team@meta.com
Subject: Re: [PATCH v5 7/7] mm/memcontrol: add stock to the memsw page_counter
Date: Tue,  1 Sep 2026 07:11:35 -0700
Message-ID: <20260901141136.1871423-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apaZdbM_l3kJIiyK@localhost.localdomain>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

On Tue, 1 Sep 2026 11:40:31 +0200 Michal Koutný <mkoutny@suse.com> wrote:

> Hello Joshua.
> 
> On Mon, Aug 31, 2026 at 09:37:51AM -0700, Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > Before this series, each memcg had one stock shared by all its
> > page_counters (memory + memsw). Now that the memcg stock was folded
> > into the page_counter level, give memsw its own page_counter_stock
> > so that it can benefit from caching charges as well.
> > 
> > Note that while the allocation is conditional on do_memsw_account(),
> > the freeing is not; the freer will only free non-NULL stocks. This
> > matters because do_memsw_account() could have changed in between the
> > allocation and the free.
> 
> (Just a passerby comment, I have no remarks to the overhaul.)

Hi Michal! Thanks for taking a look at the series.

> The change of do_memsw_account() is because of re-attaching the memory
> controller between v1 and v2 trees. That's not so common operation (but
> not ruled out), pre-condition for that is that there's only a single
> online memcg, namely the root memcg. So it needs treatment especially at
> memcg offlining (which is what drain_all_stock() (also) does).

Wow, that's good to know. To be completely honest I dont have much
experience with cgroup v1. I didn't realize it wasn't a "switch whenever
you want" type of operation. Good to know that there is some more
guarding there.

> I don't know how expensive page_counter_drain_stock_async() is going to
> be [1] but the v1 parts here could could be guarded with
> !cgroup_on_dfl(memcg->css.cgroup).

The function itself should be pretty quick. It just frees one CPU's
stock, but the rest is just scheduling a job item.

> Regards,
> Michal
> 
> [1] Now, I see in 5/7 that there's the counter->stock check which should
>     be quick bailout on v2 (maybe quicker than the cgroup_on_dfl()
>     I proposed above).

I'm not entirely sure, it's probably similar : -)
I think they should achieve the same goal, and hopefully it wasn't too
difficult to understand why we don't have the cgroup_on_dfl() there.

Hopefully the rest of the code looks good to you too. Thanks again for
taking a look Michal, I hope you have a great day!
Joshua
