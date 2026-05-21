Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F46FCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B225010E4A5;
	Thu, 21 May 2026 09:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="WO2Ax2Bn";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7709910E0D4
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1779356756;
 bh=4isyDSU2yKa1nmv4Pvr9FM416ghQXAnaNHpmgxxin50=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WO2Ax2BnzpAIfdf9+avS8EvsulN1b3fhEzPLipJmppmnT95ZDOg4H96OfW4MBtbBs
 yk5Pr9Q1HF+nvyQSqDZOagUZEqEbVI/Z3mXH1Fvd2TTfY5F5V8K59eu9ENhDjUsS3g
 ZuhyuRNVSOfqmzrVUyd7eaFrJn8xKoTl1VlVh9ARPjYMhJn5q1yn+riNXMJPxS8UlY
 SoKNjXivMxxFNz73HjZVT3nkUWR/x4xzut1Si9Edv3yD8PKy34vc5dR7yET19w1dKV
 57Uojx9JgT8Pj6tfUlFoUwmTLfkkG21yk2D+765J4RwL+TCGNNpDhBSZjsBUWzwfM5
 toF1Dk77lk4Tg==
Message-ID: <63878874-39d2-43d5-9fc3-68addf9ebbdd@lankhorst.se>
Date: Thu, 21 May 2026 11:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and throttling
To: Qiliang Yuan <realwujing@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello Qiliang,

Den 2026-05-20 kl. 08:07, skrev Qiliang Yuan:
> Introduce the "high" soft limit for the dmem cgroup v2 controller.
> When a cgroup's device memory usage exceeds its high limit, tasks
> belonging to that cgroup are throttled by being forced into a sleep
> before returning to user space, instead of being failed outright
> as with the "max" limit.
> 
> Key changes:
> - Add high counter configuration to dmem_cgroup_pool.
> - Add over-high check in the try_charge path and set TIF_NOTIFY_RESUME.
> - Inject the dmem throttling handler into resume_user_mode_work.
> - Implement the handler to perform a 100ms interruptible sleep for
>   over-limit tasks.
> 
> This mechanism provides smoother over-subscription support for device
> memory resources.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
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
> 
> Qiliang Yuan (1):
> 
> cgroup/dmem: implement dmem.high soft limit and throttling
> ---
> To: Maarten Lankhorst <dev@lankhorst.se>
> To: Maxime Ripard <mripard@kernel.org>
> To: Natalie Vock <natalie.vock@gmx.de>
> To: Tejun Heo <tj@kernel.org>
> To: Johannes Weiner <hannes@cmpxchg.org>
> To: Michal Koutný <mkoutny@suse.com>
> Cc: cgroups@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---

I think the concept of allowing userspace to throttle on high
is interesting.

It's the approach I'm more worried about. I believe that it's
better if we punish exceeding their high limit by preferentially
evicting those.

It would make eviction run in 3 passes on the affected cgroup tree:
- Round 1: Clients above their 'high' limit
- Round 2: Clients above their 'low/min' limits
- Round 3: Clients at or below their 'low' limit

And the same client's cgroup, below 'min' limit as well.

I'm open for other ideas as well. Perhaps a flag that would allow
allocation or binding to an address space to fail if it would need
to evict, or a notification sent to the affected client that they
went over high.

Have you tried any other approaches before this one?

Kind regards,
~Maarten Lankhorst
