Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB22FCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1EC210F642;
	Fri, 22 May 2026 16:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UNZ9koOS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1765F10F642
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:17:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 774D040931;
 Fri, 22 May 2026 16:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361211F000E9;
 Fri, 22 May 2026 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779466669;
 bh=SD6FHiszBLtwk4oPX8InQw0Ejv5/nftEPeupI+z1+zo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UNZ9koOScsHmXoJtud8jjPvCqZmXGk5F7XJiqVRW9I+QcBHUKyhlpphGq7RHWpkOe
 kZUq3p36C57+V82JKNS+wUwZebdHmM1weNsJMQMFZez9LBu/Y8SqT/0WbX3PH4v8Le
 RLn7mKe36FV+Os1VLtkUhR8eapTyd9JkGwFPPUeneAoSLgBuB13wvyBK97RvrOU7fb
 bS/77qZBuHGcaKozTHF6jI7PiVYx+agJQisgb9xcwt8IQqr5A9zBmhBxMirdkGBJb8
 5nGKoKccqtHdizfDCnIx+KT5wOuMT3qNJW5q9WHpawssisrMMuEG+f+S8Q5uuDNSJO
 4nvyL5krx8a8w==
Date: Fri, 22 May 2026 06:17:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Eric Chanudet <echanude@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Maxime Ripard <mripard@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, Dave Airlie <airlied@gmail.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
Message-ID: <ahCBrNfiLrh10Vtq@slm.duckdns.org>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
 <ahBxB5a9sX9DEWvl@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahBxB5a9sX9DEWvl@localhost.localdomain>
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

Hello,

On Fri, May 22, 2026 at 05:26:16PM +0200, Michal Koutný wrote:
> Hello Eric.
> 
> On Tue, May 19, 2026 at 11:59:02AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
> > Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
> > configure whether allocations in a dmem region should also be charged to
> > the memory controller.
> 
> This kinda makes sense as it is not unlike io.cost.* device
> configurators.
> 
> Just for my better understanding -- will there be a space for userspace
> to switch this? (No charged dmem allocations happen before responsible
> userspace runs, so that the attribute remains unlocked.)
> 
> (I'm rather indifferent about the actual double charging/non-charging
> matter.)

I wonder whether this would make more sense as a mount flag? What's the use
case for e.g. having different config for different devices? Wouldn't that
be really confusing?

Thanks.

-- 
tejun
