Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571A2FD5F99
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEBE10E59B;
	Wed,  8 Apr 2026 08:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rhrnQbnd";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id ADDE510E59B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:57:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ED8C2D95;
 Wed,  8 Apr 2026 01:57:07 -0700 (PDT)
Received: from [10.57.32.88] (unknown [10.57.32.88])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 245223F632;
 Wed,  8 Apr 2026 01:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775638633; bh=hL/IlzsmXrkiy8j5LwUDBfc6pyyS+d3tDsLfxhpS7Eg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rhrnQbndtQJL7Muf4HTSG1hDXbVjF0xvd/FcwxSfbAp5ZWZVDf3jbv0WqCGttB5sU
 uErzWzF/0c6bpIoXzFtWvrq3ed29SX3q5G6WPmWtYM+IURDAtaf5HcppP3WxXwaCDu
 Wz0oGA0g10PQSMNXpRLXgHcMsZr+FXclRLQ7PVO8=
Message-ID: <57e63f1e-f678-4b31-a9ca-800a631c9a94@arm.com>
Date: Wed, 8 Apr 2026 09:57:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Fix kernel-doc warning in panthor_sched.c
To: Yicong Hui <yiconghui@gmail.com>, boris.brezillon@collabora.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com
References: <20260405192309.389039-1-yiconghui@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260405192309.389039-1-yiconghui@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 05/04/2026 20:23, Yicong Hui wrote:
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

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks, I actually have a patch I've been meaning to send for this.
There's a few more kerneldoc issues in this file (documentation doesn't
get output but there's no warning) - I'll push this to drm-misc-next and
send a patch for the remaining issues.

Thanks,
Steve

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

