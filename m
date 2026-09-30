Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FACCA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCFE610E240;
	Wed, 30 Sep 2026 16:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pFJUR1c/";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 27D7D10E240
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:07:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36087168F
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:07:50 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 5D9BE3F85F
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790784473; bh=AzoXOLzGjyaVfPtVwerDXKD7G1qpD1+GSMFpiLIuzMQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pFJUR1c/iEMy0uE2pCwuFBlaAOPUsVfiwntc3bTSpadCn96bPTkZFqS5J0DlE7fOk
 kJy8hwNvm8ARuLaJzVxONicqZU0dVECsYoamfp2Ovge9I457MMT8KJ/knRjT/EMAfN
 RiIjCOmtFgXqsNHrBnleRANPkHV662Sg6CQgyPGA=
Date: Wed, 30 Sep 2026 17:07:43 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: validate userspace queue count against
 initialized firmware slot count
Message-ID: <ar0zz1IS8f4eUpXg@e142607>
References: <20260804160048.174148-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804160048.174148-1-osama.abdelkader@gmail.com>
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

On Tue, Aug 04, 2026 at 06:00:47PM +0200, Osama Abdelkader wrote:
> In panthor_drv.c:panthor_ioctl_group_create(),
> the queue count is validated against the hardcoded maximum:
> 
> 	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
> 		return -EINVAL;
> 
> However, if the firmware reports fewer slots than MAX_CS_PER_CSG,
> panthor_fw_init_ifaces() will only initialize that smaller number of
> stream interfaces.
> 
> If unprivileged userspace requests more queues than the firmware reported
> (but no more than MAX_CS_PER_CSG), cs_slot_prog_locked() fetches an
> uninitialized stream interface and may crash when dereferencing
> cs_iface->input->ringbuf_base.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260803141149.68182-1-osama.abdelkader@gmail.com?part=1
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Sorry for the delay caused by holidays and other things, this patch has now been merged.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5832dccfc093..64749750e6ee 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3673,6 +3673,9 @@ int panthor_group_create(struct panthor_file *pfile,
>  	    hweight64(group_args->tiler_core_mask) < group_args->max_tiler_cores)
>  		return -EINVAL;
>  
> +	if (group_args->queues.count > sched->cs_slot_count)
> +		return -EINVAL;
> +
>  	group = kzalloc_obj(*group);
>  	if (!group)
>  		return -ENOMEM;
> -- 
> 2.43.0
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
