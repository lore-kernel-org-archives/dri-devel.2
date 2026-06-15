Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E337BCD98E1
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96BC10E5EA;
	Mon, 15 Jun 2026 18:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i+44SHLS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA3510E5E0;
 Mon, 15 Jun 2026 18:57:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 38306600AB;
 Mon, 15 Jun 2026 18:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B149D1F000E9;
 Mon, 15 Jun 2026 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781549826;
 bh=ZkxUGDLSZMr0Dq+DdzIPtXTXVSaYiY2WHl9OHQk/HmE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=i+44SHLSEjFboHQKldJvgVHf3fFqesutTGQKBKUoBaYf1PDwTRUkh2KCBbfiv/zxK
 AHpovUOYmMej8NestBeihJK5CrLS5z7Hbvwf2Of7QJjOK4OxZokXnmRA73OfXZFZAn
 zdKEoHoe6a87h8z8m5TuXlcVyhmvLeMTAqSWmn5NjhSpJnBXUR32tU15ovJ5Bj/OXc
 8g1oze2ON0nj84ddT6EiR8PjTYFECnDbTWQA60ql8B4kdR38mVdBh5ej7Kfj+/6GO8
 iVlzkdwBGzWKAGCJ4MeDNp2MKoqtAIWvXoY3pt6YTKAE3kd6Qlra7H+r4/Tu+eEHVg
 yjEBRjBz88cPQ==
Date: Mon, 15 Jun 2026 08:57:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup
 controller
Message-ID: <ajBLAsNoKesXmFcs@slm.duckdns.org>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
 <ajBJU-Jp2QVy14qt@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBJU-Jp2QVy14qt@slm.duckdns.org>
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

On Mon, Jun 15, 2026 at 08:49:55AM -1000, Tejun Heo wrote:
> The canonical behavior for cgroup2 would be not failing the write at all
> even when the usage can't be brought down below the new max. Updating the
> target configuration and tracking the current usage are separate operations.
> The former should just set max and trigger reclaim and a writer should not
> assume that a successful write indicates that the usage is below the written
> max value.

Sent too early. One of the reasons is that cgroup is hierarchical and there
can be multiple delegation layers and if you tie application of configuration
to immediate enforcement, some hierarchical control actions become racy and
awkward.

Here's an example: Imagine a system agent trying to lower usage in a subtree
which contains multiple delegated containers. If max can be set below what
reclaim can achieve immediately, it can just set the max and if the usage is
still too high, can go around and e.g. kill some of the containers. If max
write fails, it'd have to kill and then try again and inbetween someone else
might push up the usage.

Thanks.

-- 
tejun
