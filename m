Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B9ECD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 14:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A7F10EDC6;
	Wed,  6 May 2026 14:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="J0+CPLXT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC57610EDBC
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nRaOz1lcNpsbT5rGgL5au+0YmvtZKsbg6EsSvRJK3wo=; b=J0+CPLXTtNQdpaIr6HVLL0e8Xl
 ERcF86Asw953dAX+lVYLW1no599f6dj17G6vx9xuNZy/XTr0AazOstdZ66BHYXBKoOiTrZsL5NBJB
 JKhxDu1tl/uZ1zzifPOyL+mRbBp6aHbi1syE5IrdaXrYSuFBxTodHrIZ0JjPWzh1/yEt/a4R/tp+D
 nNkNKzlwDHAcls/hefSAy7HJ3YENkstDkGe6Ch/fhAuKvDfol9x5V1I3oM753Ojypz3KX5gFhzb52
 2dh7b9pu63gswb1OlPLJnVe//JdR0494s4hqRICH5sGbmdcSChgE9t4wrnwGYm1toQwKBkWs9XHUz
 XfaqdaKw==;
Received: from 179-125-92-238-dinamico.pombonet.net.br ([179.125.92.238]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKd59-006vns-Jr; Wed, 06 May 2026 16:18:35 +0200
Date: Wed, 6 May 2026 11:18:26 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH 0/2] cgroup/dmem: introduce a peak file
Message-ID: <aftNsqrv2sGPOPHX@quatroqueijos.cascardo.eti.br>
References: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
 <aftB-cc5EhDXxCGA@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aftB-cc5EhDXxCGA@localhost.localdomain>
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

On Wed, May 06, 2026 at 03:53:59PM +0200, Michal Koutný wrote:
> Hello Thadeu.
> 
> On Wed, May 06, 2026 at 08:58:23AM -0300, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > Just like we have memory.peak, introduce a dmem.peak, which uses the
> > page_counter support for that.
> > 
> > It can be written to in order to reset the peak, but different from
> > memory.peak, which expects any write, dmem.peak expects the region name to
> > be written to it. That region peak is the one that is reset.
> > 
> > That requires ofp_peak to carry a pointer to the pool that was reset.
> 
> (It'd be nicer to have generic data in that generic structure, at least
> some void *priv. But see below.)
> 

I used void *, at first, but as the only current use is for the pool and as
mixing different uses may lead to misuse, I thought it would be safer to
use the type directly. This has been pointed out before for other members
of cgroup_file_ctx. See [1].

> > Writing a different region name will reset the different region and make
> > the original region peak get back to its non-reset value.
> 
> I'm slightly confused by this fds x pool matricity when there's only
> a single slot in cgroup_file_ctx::cgroup_of_peak.
> 
> The intended use case is that users should maintain one fd per pool and
> not mix it up?
> This stanza would better fit to cgroup-v2.rst proper than the commit
> message. Or make it simpler and start with non-resettable peak file
> (like memory.peak had started too) and see how it fares. WDYT?
> 

That is also due to the limitation that each file descriptor has a single
linked list under cgroup_file_ctx::cgroup_of_peak. To allow for all the
pools to be reset at once, we would need one list per file descriptor.

But, on the other hand, as you pointed out, this leads to the flexibility
of being able to reset only one pool, while leaving the others as is.
Whereas, if one needs to reset all pools, they can use one file descriptor
per region.

I started with a non-resettable peak file, but as memory.peak can be reset,
I added that feature too. If we want to merge a non-resettable support
ealier and need to take longer to discuss how to work on the resettable
support given the above, I can resubmit. But I guess we can see if we can
reach an agreement sonner rather than later.

Thanks.
Cascardo.

> 
> Thanks,
> Michal

[1] https://lore.kernel.org/all/CAHk-=wgiYkECT=hZRKj8ZwfBPw2Uz=gpOGBGd4ny0KYhSsjC0w@mail.gmail.com/
