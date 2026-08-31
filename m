Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124A1C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3722710E3C0;
	Mon, 31 Aug 2026 14:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="I5tE7+9V";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAEA310E3C0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788188340; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LSQzgFS8WNjWIMjuLBuEk2ih1YG5oaoA+HzYfqfKD4APGNWpmguS+IrmJ9m2a+gRLNqees//TlxBQcLbmJhUfMBlEwmASR6A3Dka+fW26hee3+Z/PiZfVpNRON5WzdicZCRA6oNRgyW2jBM9rQ/55dxpM1VH9dagipXyGp9lcLI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788188340;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=V/n0rs421QS75IopvdLae0ZbpJtQFPcqIOlcj/fficI=; 
 b=YuFxxnmrC5VT59CNX0VglEPb8NUMl3yDRYIAkU8ECbnR7WsXoZC+fXS5MC454lrMwV5ULeLBHqJ6jhfqcyQ70GnyatsvhEOjRKufWTHD3lHAHGHua+yhwRAste4vO5QomF3s3/3jTerwrY/2MNy6ZKQYy9fuLcmXKxSuXodYxes=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788188340; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=V/n0rs421QS75IopvdLae0ZbpJtQFPcqIOlcj/fficI=;
 b=I5tE7+9VilVLgXVhGQhIZw9SBJJOeNfpri7jImqCUqernc0mGF2Mz5hl+UVlXbXY
 Wi0FBHO2If0QcxpdjdxJGoan1oZulXZz1RqPAC4qUhi7zbX8dmhMrQzzBl6tX6qHfV0
 1Bufcg7xkuAVJWRjgkEBwXvAEc6tzKm/CVy++FCk=
Received: by mx.zohomail.com with SMTPS id 1788188339156677.9545572505285;
 Mon, 31 Aug 2026 07:58:59 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Display priorities of panthor groups over
 debugfs
Date: Mon, 31 Aug 2026 16:16:12 +0200
Message-ID: <bh_Hv8FlSPWfzvdtnF4oNA@collabora.com>
In-Reply-To: <20260824101420.36380185@fedora-21.home>
References: <20260818-panthor-sched-group-prio-v1-1-1836857c53e9@collabora.com>
 <20260824101420.36380185@fedora-21.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Monday, 24 August 2026 10:14:20 Central European Summer Time Boris Brezillon wrote:
> Hello Nicolas,
> 
> On Tue, 18 Aug 2026 21:35:24 +0200
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> 
> > Analogous to what was added in Commit d41c79838c47 ("drm/panfrost:
> > Display list of device JM contexts over debugfs") for panfrost, add
> > similar debugfs information for panthor.
> > 
> > The group priority does not change over the lifetime of the group, so no
> > effort to synchronise with the scheduler lock is being made.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> > Some additional notes: I noticed panthor apparently uses
> > xa_for_each{_marked} by guarding it with xa_lock/xa_unlock. That appears
> > to be unnecessary, judging by the documentation of it and that nobody
> > else does this.
> > ---
> >  drivers/gpu/drm/panthor/panthor_drv.c   |  1 +
> >  drivers/gpu/drm/panthor/panthor_sched.c | 89 +++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/panthor/panthor_sched.h |  5 ++
> >  3 files changed, 95 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> > index 46a3080b0b20..8cdba0c1a14b 100644
> > --- a/drivers/gpu/drm/panthor/panthor_drv.c
> > +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> > @@ -1769,6 +1769,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
> >  {
> >  	panthor_mmu_debugfs_init(minor);
> >  	panthor_gem_debugfs_init(minor);
> > +	panthor_sched_debugfs_init(minor);
> >  }
> >  #endif
> >  
> > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> > index 5832dccfc093..44b61e946e2d 100644
> > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0 or MIT
> >  /* Copyright 2023 Collabora ltd. */
> >  
> > +#include <drm/drm_debugfs.h>
> >  #include <drm/drm_drv.h>
> >  #include <drm/drm_exec.h>
> >  #include <drm/drm_file.h>
> > @@ -4198,3 +4199,91 @@ int panthor_sched_init(struct panthor_device *ptdev)
> >  	ptdev->scheduler = sched;
> >  	return 0;
> >  }
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +static const char *
> > +panthor_sched_prio_str(enum panthor_csg_priority prio)
> > +{
> > +	switch (prio) {
> > +	case PANTHOR_CSG_PRIORITY_LOW:
> > +		return "LOW";
> > +	case PANTHOR_CSG_PRIORITY_MEDIUM:
> > +		return "MEDIUM";
> > +	case PANTHOR_CSG_PRIORITY_HIGH:
> > +		return "HIGH";
> > +	case PANTHOR_CSG_PRIORITY_RT:
> > +		return "REAL-TIME";
> > +	default:
> > +		return "UNKNOWN";
> > +	}
> > +}
> > +
> > +static int show_file_groups(struct panthor_file *pfile, struct seq_file *m)
> > +{
> > +	struct panthor_group *group;
> > +	unsigned long i;
> > +
> > +	if (IS_ERR_OR_NULL(pfile->groups))
> > +		return -ENOENT;
> > +
> > +	xa_for_each_marked(&pfile->groups->xa, i, group, GROUP_REGISTERED) {
> > +		seq_printf(m, " Group %lu: priority %s\n", i,
> > +			   panthor_sched_prio_str(group->priority));
> > +	}
> 
> Could this race with the GROUP_DESTROY ioctl and open the door for
> potential UAFs on the group object? Seems
> panthor_fdinfo_gather_group_samples() has this xa_for_each_marked()
> inside an xa_lock()-ed section to cover for this.

Hm, right, I was only considering the case where a group destruction
would happen when the drm handle is being closed anyway, which is
mutually excluded with the caller's file lock.

That being said, I'm not sure I'm in love with locking groups->xa
as a way to protect against this, but it's more fine-grained than
taking the scheduler mutex so I guess it's an improvement over that.

Looks like xa_for_each_marked only takes the RCU read lock in the
functions it calls, and I was hoping we could make a panthor-specific
variant that group_get()s the group before unlocking, but that would
be a write.

With the additional locking around the iteration, we can use
xas_for_each_marked though, but I don't think the rcu overhead for
the repeated unlocks is a problem.

This is debugfs so I shouldn't even worry.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int show_each_file(struct seq_file *m, void *arg)
> > +{
> > +	struct drm_info_node *node = (struct drm_info_node *)m->private;
> > +	struct drm_device *ddev = node->minor->dev;
> > +	int (*show)(struct panthor_file *, struct seq_file *) =
> > +		node->info_ent->data;
> > +	struct drm_file *file;
> > +	int ret = 0;
> > +
> > +	scoped_cond_guard(mutex_intr, return -EINTR, &ddev->filelist_mutex) {
> > +		list_for_each_entry(file, &ddev->filelist, lhead) {
> > +			struct task_struct *task;
> > +			struct panthor_file *pfile = file->driver_priv;
> > +			struct pid *pid;
> > +
> > +			/*
> > +			 * Although we have a valid reference on file->pid, that does
> > +			 * not guarantee that the task_struct who called get_pid() is
> > +			 * still alive (e.g. get_pid(current) => fork() => exit()).
> > +			 * Therefore, we need to protect this ->comm access using RCU.
> > +			 */
> > +			rcu_read_lock();
> > +			pid = rcu_dereference(file->pid);
> > +			task = pid_task(pid, PIDTYPE_TGID);
> > +			seq_printf(m, "client_id %8llu pid %8d command %s:\n",
> > +				file->client_id, pid_nr(pid),
> > +				task ? task->comm : "<unknown>");
> > +			rcu_read_unlock();
> 
> Don't we have this piece of information stored in
> panthor_group::task_info already? Unless you really want to reflect
> clients that have no groups, or have groups from a given client clearly
> outlined in the debugfs output, I'd flatten things out and have these
> client-related info printed along the group info in show_file_groups()
> (pass a drm_file instead of a panthor_file, so you can get the
> client_id from there).

I basically copied this over from panfrost's debugfs output. I do agree
that doing it in a flat listing without grouping them by file->pid is
simpler, since it saves us the trouble of the rcu fun here.

> 
> Regards,
> 
> Boris
> 
> > +
> > +			ret = show(pfile, m);
> > +			if (ret < 0)
> > +				break;
> > +
> > +			seq_puts(m, "\n");
> > +		}
> > +	}
> > +
> > +	return ret;
> 




