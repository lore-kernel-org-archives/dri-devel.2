Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EC3C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31A910E523;
	Mon, 24 Aug 2026 07:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Gu5KgeyA";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516CB10E523
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787557379;
 bh=yRmqeB3nRRvYemUlNul/PM8ZinWnakfSns0oc5NX2oM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Gu5KgeyAGYt4AmheSJnE1GUfgmYF5DqgmS6dqSHQ/s9fNh9o5GZRfjQA2It35cOvv
 80VSAZOtz30FPHJQZVGlYXKrcDhEeFzis7K2VcEHPCJBCFD5lRLUjhARXs0VApE8VV
 mPZJwdqQdJ+aNA7Omuz2gZ5tUUIPdXDGHkHz0hRhFBkia/G/RP3WjLZVdQwycA8rnv
 YC+R5YDiwij6DxsNncxeQMMjAkPkygUahyNtwTvvbz53sd4AVG2yFhgi1oXJnc4WmB
 IuHLDLdQ2vPbd34YzGBm81+BbrtZ8+icoH68KGGBfVLzBKDOx5iwdl68HOY4YLHk2c
 8AAUcN0FYCf7Q==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 96A7617E0887;
 Mon, 24 Aug 2026 09:42:58 +0200 (CEST)
Date: Mon, 24 Aug 2026 09:42:53 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/9] drm/panthor: Protect events processing with a
 separate spinlock
Message-ID: <20260824094253.3e468c28@fedora-21.home>
In-Reply-To: <85003800-2ba5-436e-8001-d6804ad2633d@arm.com>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
 <20260811-panthor-signal-from-irq-v6-6-12f2ab53d735@collabora.com>
 <85003800-2ba5-436e-8001-d6804ad2633d@arm.com>
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

On Mon, 17 Aug 2026 16:21:25 +0100
Steven Price <steven.price@arm.com> wrote:

> > +	/**
> > +	 * @events_lock: Lock taken when processing events.
> > +	 *
> > +	 * This also needs to be taken when csg_slots are updated, to make sure
> > +	 * the event processing logic doesn't touch groups that have left the CSG
> > +	 * slot.
> > +	 */
> > +	spinlock_t events_lock;
> > +
> >  	/**
> >  	 * @csg_slots: FW command stream group slots.
> > +	 *
> > +	 * Updates to these slots must happen with both panthor_scheduler::lock and
> > +	 * panthor_scheduler::events_lock held. As a result, reads can happen with
> > +	 * either of these locks held.  
> 
> Technically this isn't quite true - priority can be changed with only
> sched->lock. Perhaps the following would be slightly more accurate wording?
> 
>    * Updates to the group binding must happen with both
>    * panthor_scheduler::lock and panthor_scheduler::events_lock held.
>    * The group binding may therefore be read while holding either lock.
>    * Other slot fields are protected by panthor_scheduler::lock.


I'll go for your suggestion in v7.
