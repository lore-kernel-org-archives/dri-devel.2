Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA00FC98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF57310E53D;
	Thu, 24 Sep 2026 10:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="dGHzXwEy";
	dkim-atps=neutral
X-Greylist: delayed 368 seconds by postgrey-1.36 at gabe;
 Thu, 24 Sep 2026 10:14:15 UTC
Received: from mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9087810E53D
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:14:15 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=TYkeGPF0hlaxiRuF9a4chMHeSplYcs9ovpi/ZQkxnyU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790244849; v=1; x=1790849649;
 b=dGHzXwEy4wecFSzkUcUlBMO6I0YAkoltRQsre4bHBL8bWXHiBXW70X6wIyfrpACODzZEfD2o
 0uZBLOelXz1lh6njez4gejaBD3pxTmtEG4Ny6iUfLW56fERb9lqxcEF20xG4Pz79TqUxCIKhGSW
 RFh9t+Al5MwNvyBSDABUDp1o=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id b00ef1a5dccb427d;
 Thu, 24 Sep 2026 10:08:05 +0000
X-Mizu-Trace-ID: b00ef1a5dccb427d
X-Migadu-Flow: FLOW_OUT
Message-ID: <50b4b64d-7948-418b-9f3e-9d841fc426a3@linux.dev>
Date: Thu, 24 Sep 2026 12:08:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Remove forgotten header
To: Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260625104903.1713213-2-phasta@kernel.org>
Content-Language: en-US
From: Marco Pagani <marco.pagani@linux.dev>
In-Reply-To: <20260625104903.1713213-2-phasta@kernel.org>
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



On 25/06/2026 12:49, Philipp Stanner wrote:
> sched_main.c still contains the spsc queue header, which is not needed
> anymore in that file.
> 
> Remove the surplus header import.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Marco Pagani <marco.pagani@linux.dev>

> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index d2ca01b31ee4..9446b08fff1c 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -77,7 +77,6 @@
>  #include <drm/drm_gem.h>
>  #include <drm/drm_syncobj.h>
>  #include <drm/gpu_scheduler.h>
> -#include <drm/spsc_queue.h>
>  
>  #include "sched_internal.h"
>  

