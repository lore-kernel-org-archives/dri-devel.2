Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F87CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CDA010E28D;
	Tue, 13 Oct 2026 10:21:09 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C54210E28D
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791886860;
 bh=1UOaZeGoU29X/7aFtnHvZ6owYgab7lpd599FnEZx3a0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LI/DR5OTLijeW4so6+0RPKZE1eUbHi6kDQmwIgsUETtrnQekB8bi1BLQMRzGXvcYP
 YCDhLyZeBUnVF2ab0gDyBjB6LdKo1aSnUYk8YI87TZw2JezQD7UOrYGPXq2MvWtb7L
 1XCKyhGveIg5hMkS0+9+QYsfdrIQWPZJZmzF1ahVLEdNA5Y3ticahPQ73GS4ijPDDz
 VveChrGLeXBkNws29i+t5y+O5khOaJCTJyrIogEdQLRivR9VWb4kEV13jBt592eegV
 GGJDoUr08zZRf8zMGRj6D46sDslpJ2vWEuZSDcxzIs1KcSCd2R3+XioOKRuwCYDe6C
 UYUp22lFQoM2A==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2222A17E0243;
 Tue, 13 Oct 2026 12:21:00 +0200 (CEST)
Date: Tue, 13 Oct 2026 12:20:55 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Erik Faye-Lund <erik.faye-lund@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Karunika Choo
 <karunika.choo@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] odrm/panthor: fix immortalis condition
Message-ID: <20261013122055.6ae24c80@fedora-21.home>
In-Reply-To: <20261013093150.4186117-1-erik.faye-lund@arm.com>
References: <20261013093150.4186117-1-erik.faye-lund@arm.com>
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

On Tue, 13 Oct 2026 11:31:50 +0200
Erik Faye-Lund <erik.faye-lund@arm.com> wrote:

s/odrm/drm/ in the subject :D.

> Exactly 10 cores is also valid for an Immortalis configuration,
> according to the public documentation:
> 
> https://support.arm.com/compute-ip/immortalis-g715
> 
> So let's report this G715 with 10 cores as Immortalis as well, as long
> as it supports the ray-intersection feature. This matches what we do for
> more recent GPUs as well.
> 
> Fixes: 3b1dc21d6d80 ("drm/panthor: Add support for Mali-Gx15 family of GPUs")

With the SoB added and the typo fixed, this is

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 7e315708ca7c..ea1e222ef121 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -136,7 +136,7 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  	case GPU_PROD_ID_MAKE(10, 7):
>  		return "Mali-G610";
>  	case GPU_PROD_ID_MAKE(11, 2):
> -		if (shader_core_count > 10 && ray_intersection)
> +		if (shader_core_count >= 10 && ray_intersection)
>  			return "Mali-G715-Immortalis";
>  		else if (shader_core_count >= 7)
>  			return "Mali-G715";

