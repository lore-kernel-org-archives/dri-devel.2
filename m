Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8B7F43832
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4561510E6FB;
	Wed, 15 Apr 2026 15:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="lpvcecJc";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id CCB5610E6FB
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:20:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A60B4700;
 Wed, 15 Apr 2026 08:19:54 -0700 (PDT)
Received: from [10.57.61.136] (unknown [10.57.61.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130953F7B4;
 Wed, 15 Apr 2026 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776266400; bh=xTkccFs5JYvIyE6A5G0cvYCtRvR+YhQ4J6Agd8gOAR8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lpvcecJckuixuMubMyxvU+et7EfxOFrgW/hHo/D0QOpuDH8S47moqxGZ2CXT9VDnV
 voPRhoY/i55RY+FaM9rjlbEcQ8pahvPvKpeqdFtDPcPDsphBMY77iFPzegzTbfJMb0
 i7+rEG/KaKUE7n75ncCW4AjTUy8eeWaVeRKhIMV4=
Message-ID: <8485f901-f989-4b40-a832-16f040a7400e@arm.com>
Date: Wed, 15 Apr 2026 16:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] drm/panthor: Delete spurious whitespace from uAPI
 header
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-4-adrian.larumbe@collabora.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20260415112900.681834-4-adrian.larumbe@collabora.com>
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

On 15/04/2026 12:28, Adrián Larumbe wrote:
> There's no extra blank line after the last member of any other uAPI
> structures, so delete it.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  include/uapi/drm/panthor_drm.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index dc2704fc2829..42c901ebdb7a 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -677,7 +677,6 @@ struct drm_panthor_vm_bind_op {
>  	 * This array shall not be empty for sync-only operations.
>  	 */
>  	struct drm_panthor_obj_array syncs;
> -
>  };
>  
>  /**

