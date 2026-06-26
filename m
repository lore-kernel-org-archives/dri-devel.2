Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278A9CDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E72C10E23A;
	Fri, 26 Jun 2026 09:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="nQfFNWbV";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B377A10E23A
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:14:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAA951655
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:14:38 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 22D0C3F836
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782465283; bh=FvW/wYUykFkDvbA6mlDgK1yCPVtuwaEu2fiLJ/w9lyY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nQfFNWbVCcU0Vh1Yx0dLWQKyHd5KFtFwjQiKlzb0tC5Osi5GUEixTvgaTMiU1kWgR
 kTXpbpaVM8r//X6AJYcn9nqx+EC8bNDRjPI1qGzUNBm8wxifkN8oGeaHP0CQA4Dhbu
 jNR+Qpwl7ujrBhnwcvPwhAYtQQ5oAHwWBBcE5qzs=
Date: Fri, 26 Jun 2026 10:14:32 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] drm/panthor: Fix potential invalid pointer deref
 in group_process_tiler_oom()
Message-ID: <aj5C-NvrGHdkrLEZ@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-4-b67ed973fea6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625-panthor-misc-fixes-v1-4-b67ed973fea6@collabora.com>
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

On Thu, Jun 25, 2026 at 02:40:30PM +0200, Boris Brezillon wrote:
> If heaps is an ERR_PTR(), panthor_heap_pool_put() will deref an invalid
> pointer. Make sure we set it to NULL in that case.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=2
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index e97f29469d28..8fd4d97b062e 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1600,7 +1600,10 @@ static int group_process_tiler_oom(struct panthor_group *group, u32 cs_id)
>  	if (unlikely(csg_id < 0))
>  		return 0;
>  
> -	if (IS_ERR(heaps) || frag_end > vt_end || vt_end >= vt_start) {
> +	if (IS_ERR(heaps)) {
> +		ret = -EINVAL;
> +		heaps = NULL;
> +	} else if (frag_end > vt_end || vt_end >= vt_start) {
>  		ret = -EINVAL;
>  	} else {
>  		/* We do the allocation without holding the scheduler lock to avoid
> 
> -- 
> 2.54.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
