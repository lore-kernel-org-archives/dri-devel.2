Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFE2E9D832
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 06:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C5610E2CF;
	Tue,  7 Apr 2026 06:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="X09XSYyr";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A532810E2CF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 06:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775545116;
 bh=9MaSF+5azQx7DkeVosUs/4h0gZfTjLNeJee7ptu0yiA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=X09XSYyrI11ElWJORcEeSwotgsUSEgY/KpIxmyiEUVXvMeIw+UJGadURlxo4ngI5y
 W1d88yhXixuxz9zVW3EIJ7JV7FNOS4AjFf5TloeZ/ys+4AodHE1gmjhairHMP6YYKN
 Gn/KwY7nOeAu7A7FrJAPhZqr9+wvEkULqIJ3TIauv3UJh7oZi/HZ4YTR27rrEYz9jF
 7UKsQ1m/n+nDllvLUHKSMgo/zNBakoX6N27Cb3XqXVV+mXbmaNk0STZCe8x+oWxGE4
 oA4lOGY0e4RkDMMuwrYHjn2WC/j+oE+8eBHR3dtP/Qgp4m2mTo3kq8aWRkzBbl5wfO
 6wa9wZhZP3QUA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0BFC017E04F2;
 Tue,  7 Apr 2026 08:58:36 +0200 (CEST)
Date: Tue, 7 Apr 2026 08:58:32 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Yicong Hui <yiconghui@gmail.com>
Cc: steven.price@arm.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 me@brighamcampbell.com
Subject: Re: [PATCH] drm/panthor: Fix kernel-doc warning in panthor_sched.c
Message-ID: <20260407085832.51a4d169@fedora>
In-Reply-To: <20260405192309.389039-1-yiconghui@gmail.com>
References: <20260405192309.389039-1-yiconghui@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Sun,  5 Apr 2026 20:23:09 +0100
Yicong Hui <yiconghui@gmail.com> wrote:

> Fix the following W=1 kerneldoc warnings by adding the missing parameter
> descriptions for @ptdev and @events in panthor_sched_report_fw_events()
> and @ptdev in panthor_sched_report_mmu_fault()
> 
> Warning: drivers/gpu/drm/panthor/panthor_sched.c:1898 function parameter 'ptdev' not described in 'panthor_sched_report_fw_events'
> Warning: drivers/gpu/drm/panthor/panthor_sched.c:1898 function parameter 'events' not described in 'panthor_sched_report_fw_events'
> Warning: drivers/gpu/drm/panthor/panthor_sched.c:2783 function parameter 'ptdev' not described in 'panthor_sched_report_mmu_fault'
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Signed-off-by: Yicong Hui <yiconghui@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index a70f1db0764e..2d6dc5db4148 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1894,6 +1894,8 @@ static void process_fw_events_work(struct work_struct *work)
>  
>  /**
>   * panthor_sched_report_fw_events() - Report FW events to the scheduler.
> + * @ptdev: Device.
> + * @events: Bitmask of pending FW events to report.
>   */
>  void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
>  {
> @@ -2779,6 +2781,7 @@ static void panthor_group_start(struct panthor_group *group)
>  
>  /**
>   * panthor_sched_report_mmu_fault() - Report MMU faults to the scheduler.
> + * @ptdev: Device.
>   */
>  void panthor_sched_report_mmu_fault(struct panthor_device *ptdev)
>  {

