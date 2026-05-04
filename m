Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CD9CD3426
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 09:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC4A10E5EA;
	Mon,  4 May 2026 09:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="B0a50oH8";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4470F10E5EA
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 09:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777887257;
 bh=2MtHJqOE09wNQuT2vYsaJzmrMMPEm631CqKprZrY760=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=B0a50oH84hTTfJ/wPH05tRGqpvzIPFEF6xPbkMA2R+aVTb3bYfP5LkENbO1vWJWUW
 9ozuBMolslK7SZQvw6QrJsVhdI06NTJUmpoRHD0AvC1lDACi7GY621olSsth+nrjVD
 LKBo2n1sajzyXLDtr8aXfYDGdKYxWFuPOiVOLIZ4DpoYEdjXh25SbozOyr9GuL+xGL
 ysBaPyRVZhSx/8eSl+vNXzbSGejopzdcfQK0RYLf2RZlitGLXwk9PBI+40USgtvVM4
 hMwPpN0aH/3WlZfi1pKzuB37XjazHVhgLYVBpmRKbSz7cQ9zecABkTTsjks+RPXHBa
 2n5ml4Pr4xJEA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BBE5317E061E;
 Mon,  4 May 2026 11:34:16 +0200 (CEST)
Date: Mon, 4 May 2026 11:34:13 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] drm/panthor: Prepare the scheduler logic for FW
 events in IRQ context
Message-ID: <20260504113206.747a183c@fedora>
In-Reply-To: <323eb2e0-9ed5-4be6-8ec9-b6c0b52262f5@arm.com>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-6-4b92ae4142d2@collabora.com>
 <323eb2e0-9ed5-4be6-8ec9-b6c0b52262f5@arm.com>
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

On Fri, 1 May 2026 14:47:59 +0100
Steven Price <steven.price@arm.com> wrote:

> On 29/04/2026 10:38, Boris Brezillon wrote:
> > Add a specific spinlock for events processing, and force processing
> > of events in the panthor_sched_report_fw_events() path rather than
> > deferring it to a work item. We also fast-track fence signalling by
> > making the job completion logic IRQ-safe.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
> 
> I think there's some locking problems here. With some AI help I found
> the following path:
> 
>  * panthor_job_irq_handler()
>   * panthor_sched_report_fw_events()
>    * [takes events_lock]
>    * sched_process_csg_irq_locked()
>     * csg_slot_process_progress_timer_event_locked()
>      * lockdep_assert_held(&sched->lock);

Oops, this one should check that events_lock is held instead. I'll fix
that.

