Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CFBC5DF9D
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899F510E69E;
	Mon, 24 Aug 2026 08:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HFD4utzX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92CC10E6AF
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787559266;
 bh=dNn7+3rsBa8HQJx84xgDlGmD5XExMp7xGbx5W66x/R4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HFD4utzXAJbPoPxOd8Wm9m6XnLD1TQ5PaGe3ddKFJflpwkMIwzKSTNyMVN1ccMRrn
 xhSsh19ZYmZxMtkZTpEQhi6SHXzz403WWFWkjIJWWOXREphpn+Y5jgHoiHYNnMjbVE
 BVIh0y4CpJGLer3A5Pb5Saf3zhVk8292lzhGeAImMKIpD2FwggaHSc3tmC2URerUr6
 Iq9Po45xXk7GMvMlzZfAwjlO4QXrJpztQbQgfq3XOpr2rWcS43cyDyqMtgXAppMNrh
 UMJHWUYrR2av9h1TOVkhTlTrFqPXWCc0QqvtPEXoQ7yDzeJSoaypXx+YAtLQoH+QY0
 +LCA19VAT8O3Q==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E2B7617E084E;
 Mon, 24 Aug 2026 10:14:25 +0200 (CEST)
Date: Mon, 24 Aug 2026 10:14:20 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Display priorities of panthor groups over
 debugfs
Message-ID: <20260824101420.36380185@fedora-21.home>
In-Reply-To: <20260818-panthor-sched-group-prio-v1-1-1836857c53e9@collabora.com>
References: <20260818-panthor-sched-group-prio-v1-1-1836857c53e9@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
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

Hello Nicolas,

On Tue, 18 Aug 2026 21:35:24 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> Analogous to what was added in Commit d41c79838c47 ("drm/panfrost:
> Display list of device JM contexts over debugfs") for panfrost, add
> similar debugfs information for panthor.
> 
> The group priority does not change over the lifetime of the group, so no
> effort to synchronise with the scheduler lock is being made.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> Some additional notes: I noticed panthor apparently uses
> xa_for_each{_marked} by guarding it with xa_lock/xa_unlock. That appears
> to be unnecessary, judging by the documentation of it and that nobody
> else does this.
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c   |  1 +
>  drivers/gpu/drm/panthor/panthor_sched.c | 89 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_sched.h |  5 ++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 46a3080b0b20..8cdba0c1a14b 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1769,6 +1769,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
>  {
>  	panthor_mmu_debugfs_init(minor);
>  	panthor_gem_debugfs_init(minor);
> +	panthor_sched_debugfs_init(minor);
>  }
>  #endif
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5832dccfc093..44b61e946e2d 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0 or MIT
>  /* Copyright 2023 Collabora ltd. */
>  
> +#include <drm/drm_debugfs.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_exec.h>
>  #include <drm/drm_file.h>
> @@ -4198,3 +4199,91 @@ int panthor_sched_init(struct panthor_device *ptdev)
>  	ptdev->scheduler = sched;
>  	return 0;
>  }
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +static const char *
> +panthor_sched_prio_str(enum panthor_csg_priority prio)
> +{
> +	switch (prio) {
> +	case PANTHOR_CSG_PRIORITY_LOW:
> +		return "LOW";
> +	case PANTHOR_CSG_PRIORITY_MEDIUM:
> +		return "MEDIUM";
> +	case PANTHOR_CSG_PRIORITY_HIGH:
> +		return "HIGH";
> +	case PANTHOR_CSG_PRIORITY_RT:
> +		return "REAL-TIME";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}
> +
> +static int show_file_groups(struct panthor_file *pfile, struct seq_file *m)
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

Could this race with the GROUP_DESTROY ioctl and open the door for
potential UAFs on the group object? Seems
panthor_fdinfo_gather_group_samples() has this xa_for_each_marked()
inside an xa_lock()-ed section to cover for this.

> +
> +	return 0;
> +}
> +
> +static int show_each_file(struct seq_file *m, void *arg)
> +{
> +	struct drm_info_node *node = (struct drm_info_node *)m->private;
> +	struct drm_device *ddev = node->minor->dev;
> +	int (*show)(struct panthor_file *, struct seq_file *) =
> +		node->info_ent->data;
> +	struct drm_file *file;
> +	int ret = 0;
> +
> +	scoped_cond_guard(mutex_intr, return -EINTR, &ddev->filelist_mutex) {
> +		list_for_each_entry(file, &ddev->filelist, lhead) {
> +			struct task_struct *task;
> +			struct panthor_file *pfile = file->driver_priv;
> +			struct pid *pid;
> +
> +			/*
> +			 * Although we have a valid reference on file->pid, that does
> +			 * not guarantee that the task_struct who called get_pid() is
> +			 * still alive (e.g. get_pid(current) => fork() => exit()).
> +			 * Therefore, we need to protect this ->comm access using RCU.
> +			 */
> +			rcu_read_lock();
> +			pid = rcu_dereference(file->pid);
> +			task = pid_task(pid, PIDTYPE_TGID);
> +			seq_printf(m, "client_id %8llu pid %8d command %s:\n",
> +				file->client_id, pid_nr(pid),
> +				task ? task->comm : "<unknown>");
> +			rcu_read_unlock();

Don't we have this piece of information stored in
panthor_group::task_info already? Unless you really want to reflect
clients that have no groups, or have groups from a given client clearly
outlined in the debugfs output, I'd flatten things out and have these
client-related info printed along the group info in show_file_groups()
(pass a drm_file instead of a panthor_file, so you can get the
client_id from there).

Regards,

Boris

> +
> +			ret = show(pfile, m);
> +			if (ret < 0)
> +				break;
> +
> +			seq_puts(m, "\n");
> +		}
> +	}
> +
> +	return ret;
