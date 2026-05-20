Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5675CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A3710E41D;
	Wed, 20 May 2026 09:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HlrnIGVf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79E610E41D
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:52:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB67A60120;
 Wed, 20 May 2026 09:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792091F000E9;
 Wed, 20 May 2026 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779270746;
 bh=SJETYFJkSCdwSSOgdJEmuUJWgEdHp6U1AWVfwQxLLkc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HlrnIGVf6XsyMNZ/pPtkBiKeJMERcmBZFAMvEwErzc7/2e9rwW2EZ/YTNAmeIpAs+
 +y3bziJlpZAlBql2M61qmmo3Q9pJyFFHSfAohmYGwr299Yo6WZP5lXQGoHS+W3on/b
 gkWpV2sNBl2v5PicyBPWBGU5WAUgXgV7BYYOzv6YhpE2PVoPVFvP92jJ2kPaHrQFL+
 Cmx7x86DbVP27txLoxmcqX9nngTEs+JwBbkPTxF4VotikOsesmld0FX9O+u+Ok00Dv
 wAz/3gOQ6hr8o8w3VsHKN3feg1NKZ0Zdm5xuzPz5m6J/m+LLbOAXEJX8KvjayaW/Us
 YFHdiIuz3AWKQ==
Date: Tue, 19 May 2026 23:52:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and throttling
Message-ID: <ag2EWbmlWhK2a3zz@slm.duckdns.org>
References: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
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

On Wed, May 20, 2026 at 02:07:20PM +0800, Qiliang Yuan wrote:
...
> This series introduces the "high" soft limit and associated task
> throttling mechanism to the dmem cgroup v2 controller.
> 
> The device memory (VRAM) management currently only supports hard limits
> (max), which leads to immediate allocation failures when reached. This
> can be disruptive for GPU-bound AI workloads. By introducing a soft
> limit, we allow cgroups to exceed their quota temporarily while
> applying backpressure via task throttling before the process returns
> to user space.
> 
> The mechanism is inspired by the memory cgroup's high limit:
> - When usage > high, the task is marked with TIF_NOTIFY_RESUME.
> - Upon returning to user space, it triggers a 100ms sleep.
> - This provides a smoother over-subscription model for GPU resources.

I'm not sure about complicating dmem control model without implementing
reclaim. What are we slowing them down for if the only recovery action is
killing them?

Thanks.

-- 
tejun
