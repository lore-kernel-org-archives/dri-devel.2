Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49051CD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 12:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942D610E2D4;
	Fri,  1 May 2026 12:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="o8jc6gj8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7488110E023;
 Fri,  1 May 2026 12:51:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B4604096A;
 Fri,  1 May 2026 12:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAA7C2BCB4;
 Fri,  1 May 2026 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1777639904;
 bh=DOM6sWaD8PUqkldfrKOzv5eRuIlc3YsbPu+i88S/hTY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=o8jc6gj8TcHOoVj0RXYs1etvUnfykl4CYFtwin7s2cBslS2NYaa4QP9VVTTjgUVaF
 dw3Pv18etBP/aI4kCTc89CWnqLEcgPWVeblWq5nzm9iwJALFD6nL07J+5Ro0AClTtR
 WPyrFW31W9IoDK+T8csAcWeg0sANsoEWXypbFcy4=
Date: Fri, 1 May 2026 05:51:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Dave Chinner" <david@fromorbit.com>, Qi Zheng
 <zhengqi.arch@bytedance.com>, "Roman Gushchin" <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song
 <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Thomas =?ISO-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Carlos Santa <carlos.santa@intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>,
 "David Hildenbrand" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] mm, drm/ttm, drm/xe: Avoid reclaim/eviction
 loops under fragmentation
Message-Id: <20260501055143.b60c31287051a56295f10205@linux-foundation.org>
In-Reply-To: <afRH+KUNw9zap4sp@gsse-cloud1.jf.intel.com>
References: <20260430191809.2142544-1-matthew.brost@intel.com>
 <20260430160105.a3b74ec3bb316bbfbf8f9808@linux-foundation.org>
 <afRH+KUNw9zap4sp@gsse-cloud1.jf.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 30 Apr 2026 23:28:08 -0700 Matthew Brost <matthew.brost@intel.com> wrote:

> > AI review flagged a few possible issues:
> > 	https://sashiko.dev/#/patchset/20260430191809.2142544-1-matthew.brost@intel.com
> 
> Idk, who authors sashiko but what make it really nice if you could reply
> to it to talk things out.

It's a gemini 3 thing, based on prompts developed by Roman
Gushchin and Chris Mason and others.  Google is making this available
to kernel developers at a non-trivial expense.

And yes, it would be great if Sashiko were able to learn from our
replies and to fine-tune its checking based on the human corrections. 
I've asked for this a few times but didn't really understand the reply
;)
