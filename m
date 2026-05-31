Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73E1CD6E57
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 17:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4B6C10E6D8;
	Sun, 31 May 2026 17:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VIJE5abn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E0C10E6D8
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 17:09:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0308D6008A;
 Sun, 31 May 2026 17:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897FF1F00893;
 Sun, 31 May 2026 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780247346;
 bh=SVEJL4GEwkXkrp6OsZZkCybl5z2/KKltadlzYqj29wI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=VIJE5abn5CItq56HmUAdW+Knc3RYlzlx17YNtux49HXAuFoZ5mrgTdG42OZxZ20XW
 zfe/XXcBnZAMbDuWNIh2CNnXDOB9QtCMdDlORVJtZiOa2f7KFhI5ZsQ+QVbwgrokbi
 BzQdroh8CHBXMyQ3RM0lCTErePv+oXad+PA4DrKKE12M79hS8nnabqO++Ml7MRi/jk
 876Tt8TcYO/m5XbWAShgoX2dVkCpKp5ZTSaTG+RyLOn4z/pw5g4lqnxYSW32tuKZuN
 +mnja4ml2mMwSkQo9K2R6ai1tO83yq9cgZQdfdMLSgaVA/zzJIh7+CVm7vpe3MfznR
 Eklpd0LVEZ1Rw==
From: Tejun Heo <tj@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Natalie Vock <natalie.vock@gmx.de>
Cc: Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6] cgroup/dmem: implement dmem.high soft limit via
 prioritized eviction
In-Reply-To: <20260531-feature-dmem-high-v6-1-20563ecd6dc7@gmail.com>
References: <20260531-feature-dmem-high-v6-1-20563ecd6dc7@gmail.com>
Message-ID: <20260531070612.GA03193@kernel.org>
Date: Sun, 31 May 2026 07:06:12 -1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hello,

I don't think we want to define dmem.high (or dmem.max) in terms of a
specific reclaim mechanic. These interface files should express a
generic resource-distribution concept that stays valid regardless of
how the underlying reclaim works. As written, dmem.high comes down to
"evicted first in the high-priority eviction pass". It isn't consulted
on charge and dmem has no proactive reclaim, so the file does nothing
until a dmem.max hit elsewhere triggers eviction. That's an
implementation detail, not something I'd want to commit to in the
cgroup interface.

It also reads as a way to work around dmem's reclaim behavior rather
than a soft limit in its own right. A dmem.max hit doesn't just fail
today: the charge returns -EAGAIN and TTM already falls back to evicting
buffers and retrying before the allocation fails. So the question isn't
"max fails immediately, add reclaim via high" but which buffers reclaim
should target and when, which is a property of the max reclaim behavior.

If we work around that with a high knob whose meaning is the current
eviction order, we bake an implementation detail into the ABI and make
it harder to give dmem.high a proper soft-limit semantics later.

I'm not against a dmem soft limit. I'd rather improve the max reclaim
behavior so it makes sense in general, and then define high as a concept
on top of that, rather than the other way around.

The whole max-vs-high distinction and what a soft limit should mean has
had a lot of thought put into it on the memcg side, so adding the memcg
folks for their input.

Thanks.

--
tejun
