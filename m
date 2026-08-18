Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656E5C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B70710E05C;
	Tue, 18 Aug 2026 19:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MBEN1CJ4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2755810E05C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 19:46:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 38F67601DE;
 Tue, 18 Aug 2026 19:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49141F000E9;
 Tue, 18 Aug 2026 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787082382;
 bh=kWnIDZUhk+F4eY24U48DIJpdRq618xRexTfBviRyPy8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MBEN1CJ4BlsL2SsxNnM+XHv5/rXz6/T34ZeJ9Qi7b06MJsNAL8nL0MqxVxWc0RZ9u
 IaipHElneHpt9BeiS21PHwzeEuOyPL6JELKLz9dSarSuhOei63zKpsK32NlFl9MiVP
 MJRGqjFpqlV0RZbJo9PIIpESUqKlDRjZUeu+XkxpGiTRCDmwdqyKVZU6ZOx5qC9yHr
 FvNlng4DIGaZb1BeZTah3h7HuobDiprvWNugt6y7jUjA9mY/O7CpteWUr+8HOjzLCB
 KzWrS4XfYx/NJgBjxhXo1FNXs7ulXPgsi4NoJXqCkgs1zSiVrZedRF/lBtYw8/m4XF
 KHZqh2P6gUfOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: Display priorities of panthor groups over
 debugfs
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818-panthor-sched-group-prio-v1-1-1836857c53e9@collabora.com>
References: <20260818-panthor-sched-group-prio-v1-1-1836857c53e9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 19:46:22 +0000
Message-Id: <20260818194622.C49141F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `rcu_read_lock()` or `xa_lock()` around `xa_for_each_marke=
d()` iteration leads to a use-after-free on `group`.
--

--- Patch [1]: [PATCH] drm/panthor: Display priorities of panthor groups ov=
er debugfs ---
commit 55662349e547cf65d238c177ee7f9c17e8fd597c
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/panthor: Display priorities of panthor groups over debugfs

This commit adds debugfs information for panthor groups, showing
the priority of each group. The implementation uses xa_for_each_marked
to iterate through registered groups.

> Some additional notes: I noticed panthor apparently uses
> xa_for_each{_marked} by guarding it with xa_lock/xa_unlock. That appears
> to be unnecessary, judging by the documentation of it and that nobody
> else does this.

Is this assumption accurate? While xa_for_each_marked() protects the
XArray's internal state without external locks, the returned object pointers
require either an rcu_read_lock() or xa_lock() around the entire loop to
prevent them from being freed while they are being accessed inside the loop.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 5832dccfc0932..44b61e946e2d4 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
[ ... ]
> @@ -4198,3 +4199,91 @@ int panthor_sched_init(struct panthor_device *ptde=
v)
[ ... ]
> +static int show_file_groups(struct panthor_file *pfile, struct seq_file =
*m)
> +{
> +	struct panthor_group *group;
> +	unsigned long i;
> +
> +	if (IS_ERR_OR_NULL(pfile->groups))
> +		return -ENOENT;
> +
> +	xa_for_each_marked(&pfile->groups->xa, i, group, GROUP_REGISTERED) {
> +		seq_printf(m, " Group %lu: priority %s\n", i,
> +			   panthor_sched_prio_str(group->priority));
> +	}

[Severity: High]
Does this code risk a use-after-free on the group pointer?

Because xa_for_each_marked() only takes the RCU read lock internally
during the lookup, the returned group pointer has no lifetime protection
once the macro yields it to the loop body.

If a user reads the sched_groups debugfs file concurrently with a group
being destroyed via the DRM_IOCTL_PANTHOR_GROUP_DESTROY ioctl, the group
could be removed and freed before its priority is accessed here.

Should this iteration be protected by an rcu_read_lock() or xa_lock() to
ensure the group pointer remains valid during the loop?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-panthor-sc=
hed-group-prio-v1-1-1836857c53e9@collabora.com?part=3D1
