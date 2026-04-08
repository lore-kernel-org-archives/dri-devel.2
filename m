Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1F81073CBF
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 14:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB9A10E674;
	Wed,  8 Apr 2026 14:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="OGdZie0Q";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4772F10E673
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 14:09:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1B40267F;
 Wed,  8 Apr 2026 07:08:58 -0700 (PDT)
Received: from [10.57.32.88] (unknown [10.57.32.88])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C4C63F632;
 Wed,  8 Apr 2026 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775657344; bh=NGRGYkcFgbH8rvU4niZmKXkXJd9gpnZOfh8u8Kdq1S4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OGdZie0Q21/+zdVkkTdt3+D5YRb8As+itfAVUtJQl2l3w402KQ0nvo5OshB7J863B
 h8aX87OjYrcOwwCyUgaJUgoSGAlIuLFqdB/pbYtqys9e7gL6fuVrCle004AAIEBH8r
 LLjtaTycuh+1fKlOaAdOkBS4mypCRoRFWiyQLG5A=
Message-ID: <e7e565cd-6a48-407c-9e2e-450c3818c162@arm.com>
Date: Wed, 8 Apr 2026 15:09:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Fix kernel-doc in panthor_sched.c so it's
 visible
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yicong Hui <yiconghui@gmail.com>
References: <20260408091242.799074-1-steven.price@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260408091242.799074-1-steven.price@arm.com>
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

On 08/04/2026 10:12, Steven Price wrote:
> Various substructures defined in panthor_sched.c have kernel-doc which
> is silently ignored because it doesn't include the full path to the
> member. Fix these issues so that the kernel-doc text is actually output
> by including the name of the parent.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 72 ++++++++++++-------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 3bb1cb5a2656..b255354553df 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
[...]
> @@ -416,26 +416,26 @@ struct panthor_queue {
>  	 * queue is waiting on.
>  	 */
>  	struct {
> -		/** @gpu_va: GPU address of the synchronization object. */
> +		/** @syncwait.gpu_va: GPU address of the synchronization object. */
>  		u64 gpu_va;
>  
> -		/** @ref: Reference value to compare against. */
> +		/** @syncwait.ref: Reference value to compare against. */
>  		u64 ref;
>  
> -		/** @gt: True if this is a greater-than test. */
> +		/** @syncwait.gt: True if this is a greater-than test. */
>  		bool gt;
>  
> -		/** @sync64: True if this is a 64-bit sync object. */
> +		/** @synwait.sync64: True if this is a 64-bit sync object. */
>  		bool sync64;

Sashiko spotted[1]:
> This isn't a bug, but there is a typo here (synwait instead of syncwait).
> Will this cause the kernel-doc script to miss this member and generate a
> warning?

I'm not sure how it thinks it "isn't a bug" (in a patch about fixing the
comments), and indeed it will be missing from the output. I'll fix this
up and push to drm-misc-next.

Thanks,
Steve

[1]
https://sashiko.dev/#/patchset/20260408091242.799074-1-steven.price%40arm.com

