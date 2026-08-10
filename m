Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27F1C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CAD10E982;
	Mon, 10 Aug 2026 18:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dGjCopdH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB22410E982;
 Mon, 10 Aug 2026 18:57:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C2F6600AD;
 Mon, 10 Aug 2026 18:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937911F000E9;
 Mon, 10 Aug 2026 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786388222;
 bh=DgHH11rbBugxycgVfllDqGnSiJw+pTYpQUpXBdKD4ec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dGjCopdH5Dh+u5udlFJdn6uvtThWYmJaM5Eb2jrmqTmlPXe5UlQ0CRphwRoBIJAm6
 F0kU/FDdk2naDL4p3srV/lxFnEfrV9izlK0/eVoMoRzHM6zEAlb9GpeWNPiLSHMibY
 7/DPwPPVatxqKpZv+TfYsfmRCGlQLyQIHN6gqgSCuosDQKnkX7zFjgBI0zLwi3MUEy
 whMrR+qxXWlWfsydnEdMuQYTG3VOiaRpdN8MxbYzSZLGHi/ErGFwHRXNVMMZH+h3LY
 9bzRCWjMFzLk9BevIJ+7lY7vmKa9eVcOTLJ3LnT1A3hINcRRz11t4KUr+PC1fbqo0Y
 U7y9rB8HQKU5A==
Date: Mon, 10 Aug 2026 11:57:00 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
 Stanislav Kinsburskii <skinsburskii@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Message-ID: <20260810185700.GD2496954@liuwe-devbox-debian-v2.local>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
 <20260723142242.5d3f87208d47819d873ae458@linux-foundation.org>
 <20260731211728.GA3243658@liuwe-devbox-debian-v2.local>
 <20260731143733.6f74ec9b9023f898c3c260e1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731143733.6f74ec9b9023f898c3c260e1@linux-foundation.org>
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

On Fri, Jul 31, 2026 at 02:37:33PM -0700, Andrew Morton wrote:
> On Fri, 31 Jul 2026 14:17:28 -0700 Wei Liu <wei.liu@kernel.org> wrote:
> 
> > On Thu, Jul 23, 2026 at 02:22:42PM -0700, Andrew Morton wrote:
> > > On Thu, 23 Jul 2026 10:36:32 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > > 
> > > > This series extends the HMM framework to support userfaultfd-backed memory
> > > > by allowing the mmap read lock to be dropped during hmm_range_fault().
> > > > 
> > > 
> > > Thanks, I've updated mm.git to this version.
> > 
> > Hi Andrew,
> > 
> > I see this series in linux-next now.
> > 
> > I'm curious to know if these patches are going to make 7.3.
> 
> Probably.  The series is incompletely reviewed at this time.  Perhaps
> you can assist with this?

Fair point. I'm not an MM expert but I will try.

Wei

> 
> > We have some work that's dependent on this so would like to plan
> > accordingly.
> > 
> > Thank you Stanislav for continue pushing this.
