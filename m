Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79366CD3430
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 15:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DD610E738;
	Mon,  4 May 2026 15:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aqpdwaok";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB3210E76F
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 15:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777906856;
 bh=xWfpnUZfLeM39wUROZg2x6WISFfY57/hGwZjThDIqQU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aqpdwaok+7uZsXLXhTblfDb4NS2nvQrMnkx0YttSRFAVmHQIDS3u+yYCSXgtp3RtH
 2bxV73kSvk6vQ8OyEKh7Qlrk5nPEpgSJq9lEPNJoAxQuvJH1WIqK0q1Sydb6F28G2q
 UteirA/NBr+WGYbGWAm4eiWfwu5tRi0VkJ1ebOGqGse9MGw2calw+LFIBciaDnC9zU
 G9iAcH//L07TM5WX8boSZ3hioY56BBJU6I9CYTFNYk/Ss1dUGDsK8zb3nnFQf04+k8
 y8zeywlb6EuGpt5bKhU5JKct5DRpnXTSJMzyMK39CMlkQgxRYcts1mgLd3AUOpq1TA
 v+iFvWhroQHzw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0B81E17E131B;
 Mon,  4 May 2026 17:00:56 +0200 (CEST)
Date: Mon, 4 May 2026 17:00:51 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] drm/panthor: Automate CSG IRQ processing at group
 unbind time
Message-ID: <20260504170051.64759934@fedora>
In-Reply-To: <e5c9763b-87c1-405d-9fda-f3f324d6bdfe@arm.com>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-7-4b92ae4142d2@collabora.com>
 <e5c9763b-87c1-405d-9fda-f3f324d6bdfe@arm.com>
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

On Fri, 1 May 2026 14:53:22 +0100
Steven Price <steven.price@arm.com> wrote:

> > @@ -2970,8 +2963,6 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
> >  
> >  			if (flush_caches_failed)
> >  				csg_slot->group->state = PANTHOR_CS_GROUP_TERMINATED;
> > -			else
> > -				csg_slot_sync_update_locked(ptdev, csg_id);  
> 
> The justification for this change doesn't seem to be included in the
> commit message and looks suspicious.

Hm, right. I somehow confused csg_slot_sync_update_locked() and
sched_process_csg_irq_locked().

> Although AFAICT the events_lock
> wouldn't be held here so it could trigger a lockdep assert before this
> change...

Yeah, the guard(spinlock_irqsave)(&sched->events_lock); should have
been added to patch 4.
