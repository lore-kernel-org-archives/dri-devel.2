Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B76BC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FFAD10EA84;
	Mon,  6 Jul 2026 19:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GJ6k21O3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A788D10EA82;
 Mon,  6 Jul 2026 19:25:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DAA41600C3;
 Mon,  6 Jul 2026 19:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D231F000E9;
 Mon,  6 Jul 2026 19:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783365911;
 bh=u6Ou0jbsdMUOvdHXYTkqyWBUsmGQD9nbdqqr1UFdWDg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GJ6k21O3aLYCNuYZdTOtBHnjVXv/pe0UdV/Lc9MyMQv3HtYcIoQhUXqfWzMizCkvP
 lWU0cLU78OXeUOjZjAU3cpK52hRZ4JRIqFth+2DjhHQQBYtmyrlpAQ+6Dtwyg3ZcDP
 nu7itkPJ3bzH2PYkoKq6HptUbsDvF942k1fF+XOcKUqE+EBsDqWak0ae86rXQqzFuv
 wUtNBUbJCpVZ3sXJzSAAx5mhKvdf/oz7LXclw152Vq+gcV/tCrMuNZ4k/t9riXn9LR
 GnbTfrwT3jPjdVbgmq5HK8a/+xpXOVTjrbBQXdLnyZDxNaliTrbxG0jRYTBf5yyGvN
 e1KkYjuXt4l0A==
Date: Mon, 6 Jul 2026 09:25:10 -1000
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
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] cgroup/dmem: Add reclaim callback for lowering
 max below current usage
Message-ID: <akwBFlw8MwhrwsRu@slm.duckdns.org>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
 <20260703130541.2686-4-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703130541.2686-4-thomas.hellstrom@linux.intel.com>
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

On Fri, Jul 03, 2026 at 03:05:38PM +0200, Thomas Hellström wrote:
> Also honor O_NONBLOCK so that if that flag is set during the
> max value write, no reclaim is initiated. The idea is to avoid
> charging the reclaim cost to the writer of the max value.

Is this really necessary? I'm not necessarily against it but this is trivial
to work around from userspace and feels like a gratuitous addition. What's
the use case?

Thanks.

-- 
tejun
