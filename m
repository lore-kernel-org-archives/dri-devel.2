Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41410CDB481
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9084410EF60;
	Wed, 24 Jun 2026 14:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="COYy78yl";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6FADC10EF60
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 14:49:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B1CD2A2A;
 Wed, 24 Jun 2026 07:49:36 -0700 (PDT)
Received: from [10.57.80.146] (unknown [10.57.80.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E85843F62B;
 Wed, 24 Jun 2026 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782312581; bh=knsI1NsAyTH8YWLtllLGoBV1MAk+4DNnbC9Of3da/AU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=COYy78ylW27WlChz0/hFb4ehJ6MeZRpTxAwdKfO5wCSg7XaT83+yJj1Q3hcZFBtEK
 6gaw5edQopR9Z2FbKCECJPJYvlix36aQ/OsZS7EcJaa571a50L3ZjYfPju0obbLVI5
 J/hDP0tMBzPWzz2PxbbUVXkhDpUXvN4e/Zhx2ViU=
Message-ID: <2d8d5b9c-6d2d-4229-b381-c9d73c6caf5c@arm.com>
Date: Wed, 24 Jun 2026 15:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/panthor: Fix comment to reflect actual struct
 field name
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
 <20260619-vm_bind_checks-v2-2-b51abab35f71@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260619-vm_bind_checks-v2-2-b51abab35f71@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 19/06/2026 13:41, Adrián Larumbe wrote:
> The mismatch would pop up when building the kernel with W=1.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index a8de4fe6b231..d8c6d8a9e26e 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -306,7 +306,7 @@ struct panthor_vm {
>  		/** @kernel_auto_va.start: Start of the automatic VA-range for kernel BOs. */
>  		u64 start;
>  
> -		/** @kernel_auto_va.size: Size of the automatic VA-range for kernel BOs. */
> +		/** @kernel_auto_va.end: End of the automatic VA-range for kernel BOs. */
>  		u64 end;
>  	} kernel_auto_va;
>  
> 

