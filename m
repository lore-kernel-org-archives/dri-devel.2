Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E585CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4ED410E291;
	Thu,  7 May 2026 14:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Juv1r3JB";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5946410E291
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:00:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7109C2641;
 Thu,  7 May 2026 07:00:29 -0700 (PDT)
Received: from [10.57.67.110] (unknown [10.57.67.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54EE63F763;
 Thu,  7 May 2026 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778162434; bh=0Md9K0ehnCxUNP9VxL+ZkWs040mqlqf71Wfx81eKDys=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Juv1r3JB0WACL5+W+WXJUyxQzkaKrBC/y3z9oO8Tv9WdOkWkSlGjIUCMlQjvtmgT9
 QC0suT5OUGIz203EStDQP9EUkGcWI9bd2Zz3sAXzWG3cZ+WnIURK6oH7jNPL66cEH8
 JI+xyamwZpMIinL09k+g/jMrFd8vi7w/eq6wKmsg=
Message-ID: <b6d671eb-cdc4-4d0b-8719-d6d2242c596b@arm.com>
Date: Thu, 7 May 2026 15:00:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Fix dma_resv_wait_timeout() return handling in
 rocket/panfrost ioctls
To: Gyeyoung Baek <gye976@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?=
 <adrian.larumbe@collabora.com>
Cc: Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1776581974.git.gye976@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <cover.1776581974.git.gye976@gmail.com>
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

On 19/04/2026 08:17, Gyeyoung Baek wrote:
> dma_resv_wait_timeout() returns a positive 'long' (remaining jiffies)
> on success, which is truncated to 'int`.
> So userspace interpret that as an error.
> 
> Each patch explicitly sets `ret` to 0 on the
> success path.
> 
> Gyeyoung Baek (2):
>   accel/rocket: Fix prep_bo ioctl leaking positive return from
>     dma_resv_wait_timeout()
>   drm/panfrost: Fix wait_bo ioctl leaking positive return from
>     dma_resv_wait_timeout()
> 
>  drivers/accel/rocket/rocket_gem.c       | 2 ++
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
>  2 files changed, 4 insertions(+)
> 

Both patches pushed to drm-misc-fixes.

Thanks,
Steve

