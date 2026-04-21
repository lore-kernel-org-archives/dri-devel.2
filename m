Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3EBF94CA7
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC87E10E1A4;
	Tue, 21 Apr 2026 20:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="N+fXdLgZ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809D310ED91
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 20:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776803909; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AVEISuzOkBmF5InESuJzBYA7sp+mdStgApOzWWkQIFjEb2QGMok0zhb9xYKa1JrrGZRUwAjnIPHCCAoWaK/Sk6zpnb13A24FAIkO6B8aBFs2sekIcpXYdPDGqI6IfdohsvVARmudOFDT8pSWQhhjT6jY0EwXIE/bPiZJpCf/pU4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776803909;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HSh/B2iUj0iq/8dGADJDwgRxvcXnfJwJ0DwKuc/4DVA=; 
 b=QJefDIkZEoBGXFV7QnX65lpg+Am9Ut9jOoASz/guT7wma5gxiZaXH+LSoqCLA+io86DnkP3OnVFW0RBjAufvIhhTBr4/2B3CvkFajy+iE6kfah+SCF/41v2RXTqwgm9N2MVpleZAw9H/xvPl1XGYKsY3aL+xfXJu0ukp4mFYwoo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776803908; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=HSh/B2iUj0iq/8dGADJDwgRxvcXnfJwJ0DwKuc/4DVA=;
 b=N+fXdLgZWvNOtow91JjzhnuE74T59mdwR/JiTC+zaJlQfxxchNSJDbAjYsV9nYU/
 LXxJQIbI414tl9JHY4Nby1d9W3WIt9HhQaudTZUJ4tVTjdg3hfPSXy1Dm6nMgaN6Zqi
 uOQ1J8n/CA0pD2gL0F+rAV/1wHdDtq1swoe2rOKw=
Received: by mx.zohomail.com with SMTPS id 1776803907231125.60155997936374;
 Tue, 21 Apr 2026 13:38:27 -0700 (PDT)
Date: Tue, 21 Apr 2026 21:38:20 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/panfrost: Fix wait_bo ioctl leaking positive
 return from dma_resv_wait_timeout()
Message-ID: <aefgJ5eR3MXTO5Qf@sobremesa>
References: <cover.1776581974.git.gye976@gmail.com>
 <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
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

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 19.04.2026 16:17, Gyeyoung Baek wrote:
> dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
> on success, 0 on timeout, and -errno on failure.
>
> panfrost_ioctl_wait_bo() returns this 'long' result from an int-typed
> ioctl handler, so positive values reach userspace as bogus errors.
> Explicitly set ret to 0 on the success path.
>
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 3d0bdba2a..784e36d72 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -390,6 +390,8 @@ panfrost_ioctl_wait_bo(struct drm_device *dev, void *data,
>  				    true, timeout);
>  	if (!ret)
>  		ret = timeout ? -ETIMEDOUT : -EBUSY;
> +	else if (ret > 0)
> +		ret = 0;
>
>  	drm_gem_object_put(gem_obj);
>
> --
> 2.43.0
