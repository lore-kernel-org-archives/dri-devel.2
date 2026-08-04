Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2129C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490CC10E154;
	Tue,  4 Aug 2026 10:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gaMz/1+R";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044E110E154
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785840378;
 bh=K0KMjt1g+TJkPmxR2QS7s88o3Bdg0dX7wUIIYi71tyA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gaMz/1+RU2k4sInaMUL1dyG1kXnKGmUl//dmBThUB+slX4EkTWtYnXetbyYaeNX+P
 QxHOZID7acWat/LQWe6xK3xiYUwjju+4wHkcpp/ARmRQuIpFuZsySfE+wwX+7mo/Bi
 2wGuYAhovgHWuDESSaAOJQGdTElBpp6fYf9BRHla6kTc+zArCY4GUWAbGpe+FqBUy8
 2/8MpTN5ysAwil2hi33KuXZvWWP1QEzUdWjFeOoTipwOE4hy9qHzbmSiCsPqbl5Zxy
 be+X6mfAik4/DsLi3B99nSAbH2jAZ3NbAMWax9L5TX/oPSESNvPngFLDv1dbHNTsZ7
 nnRDbRjq7oZoA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E917817E06DB;
 Tue, 04 Aug 2026 12:46:17 +0200 (CEST)
Date: Tue, 4 Aug 2026 12:46:13 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/panthor: Disable reset work before unplug
Message-ID: <20260804124613.7826291b@fedora-21.home>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-1-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
 <20260804-panthor-unplug-fixes-v1-1-abbbd2d41b13@collabora.com>
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

On Tue, 04 Aug 2026 12:09:40 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> Make sure we're not interrupted by resets while we're unplugging.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 0b25abebb803..e7f5744bc1e3 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -86,6 +86,9 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	 */
>  	drm_dev_unplug(&ptdev->base);
>  
> +	/* Make sure we're not interrupted by resets while we're unplugging. */
> +	disable_work_sync(&ptdev->reset.work);

As Sashiko pointed out, this introduces a deadlock, which I fixed in
patch 12 thinking it was something introduced before this patchset :-(.
I'll address that by pulling the from_reset_work argument into this
commit commits, and making the fake_failure bits its own commit.

> +
>  	/* We do the rest of the unplug with the unplug lock released,
>  	 * future callers will wait on ptdev->unplug.done anyway.
>  	 */
> 

