Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2725DC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC5A10E8B0;
	Tue, 22 Sep 2026 08:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pkk8hJkz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5845B10E8B0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:03:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 627286053E;
 Tue, 22 Sep 2026 08:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1991F000FF;
 Tue, 22 Sep 2026 08:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790064230;
 bh=iz5ZvXuN69BjPyv2G6HIms6qrpA+v8co7aU/JAxPMNE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Pkk8hJkz+KwRWDTWURSLDurufWOnqDbYDUTIZvYXp9jfWOkdjCM/lvETnNtDoI+LS
 weuk7KILNbiDpsCFZUmltc1Xv7VITIdVF1H2oDuxtlrKssjRaAsgmNRV2hAr5C4SeQ
 bZ/80zCO8tXpnUnlLHyelefCFy8yEvMbmP9VMlwSO1DLccj29DgxZ7QexRl8x2wU7k
 fTdqHnUv9AVXxk5dnorcXIFA8Peq7IgJWCVjlGznMMm05cuXM6uyfS9EWxIwApJwpK
 DXsQ17/1MOkMBuP4zJ74q36cN6eF1s7VZkd7lMrYU+rofAevR3gfQLNsSR3/mGgEhl
 sgglkuVP99KSA==
Date: Tue, 22 Sep 2026 09:03:40 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: linuszeng@tencent.com
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <nat@pixelcluster.dev>,
 Tejun Heo <tj@kernel.org>, 
 Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Oscar Salvador <osalvador@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>,
 Jingxiang Zeng <jingxiangzeng.cas@gmail.com>, 
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/6] mm: memcontrol: implement the memsw limit on cgroup v2
Message-ID: <arI2So8-IHlUjuv0@gremlin>
References: <20260918-descriptive-name-v1-0-dfcfdd91b456@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-descriptive-name-v1-0-dfcfdd91b456@tencent.com>
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

Hi,

For one of several possible reasons this mail has triggered an AI
detector script.

Note that, while we are fine with AI assistance, it is kernel
policy that you must disclose this with an Assisted-by tag like:

Assisted-by: LLM

See https://docs.kernel.org/process/coding-assistants.html

It is also kernel policy that you must fully understand and take
responsibility for every patch that you send.

See https://docs.kernel.org/process/generated-content.html most
notably:

        If tools permit you to generate a contribution automatically, expect
        additional scrutiny in proportion to how much of it was generated.

        As with the output of any tooling, the result may be incorrect or
        inappropriate. You are expected to understand and to be able to
        defend everything you submit. If you are unable to do so, then do
        not submit the resulting changes.

        If you do so anyway, maintainers are entitled to reject your series
        without detailed review.

In general, if you are a newcomer to mm, we expect you to do smaller work
before moving on to larger changes, so you build understanding of both the
technical aspects of mm and how we do things.

--
Cheers, Lorenzo
