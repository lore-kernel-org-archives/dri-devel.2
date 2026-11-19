Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C9606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=MIbIGg58
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441F5112086;
	Thu, 19 Nov 2026 08:12:59 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC75112086
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795075971;
 bh=ZQMB01aIN8qNya3qxG4hUX6cPbDHbcS4V5cVbvOVu1E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MIbIGg58jv9Q0GXJQ4L0ldxK2bdoC2tZ42YFmhF/UfmuU+uNUI2FqAGuQXfGfA1Iy
 Ybse6WJbktSHZcs2SR/LdKxAIF7LfeOrr3WKzGe1Lbva68mkYqWpB+hMOTAVYLP/Ge
 EvIKEt/nxZdVdKcaDwUvGuu26i6h0wOksN0A5/umH6d+B5pSwf2BO69kP54p8C/S4v
 Zh6Wv5/1C94dmAv98dmGQTE5L2kHvpDR25kCyYOTcRpIw/Th11e9VxkW40VMWEe60T
 aww5sgUC/kvUYiFiQSfElHbFYXUS611ZAHM77CLetC3BcVm6aT048frg6KjZjLC6oS
 N8neO27b5xV6A==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3FC7F17E02F2;
 Thu, 19 Nov 2026 09:12:51 +0100 (CET)
Date: Thu, 19 Nov 2026 09:12:46 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 10/10] drm/panthor: Skip devfreq when no OPP table is
 present
Message-ID: <20261119091246.58b806e9@fedora1.home>
In-Reply-To: <20261118175332.519657-11-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
 <20261118175332.519657-11-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 17:53:26 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> On Mali v15 AM systems, frequency scaling is handled outside panthor by
> the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.
> 
> Make panthor_devfreq_init() return early when dev_pm_opp_get_opp_table()
> returns -ENODEV, and guard the devfreq helper paths against a missing
> devfreq instance. Also make it so that frequency can be queried even if
> the devfreq instance is missing.
> 
> This keeps devfreq enabled for existing platforms while allowing v15 AM
> systems to probe without a local devfreq setup.
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
> v3:
> - Omit drm-maxfreq-panthor from fdinfo when the maximum frequency
>   is unknown, as on AM systems without an OPP table.
> v2:
> - Directly call functions instead of storing function pointers.
> - Picked up R-b from Liviu
> v1:
> - Only skip panthor_devfreq init when OPP lookup returns -ENODEV instead
>   of direct DT-property check.
> - Support frequency query without devfreq.
> 
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 29 +++++++++++++++++------
>  drivers/gpu/drm/panthor/panthor_drv.c     |  5 +++-
>  drivers/gpu/drm/panthor/panthor_hw.h      |  6 +++++
>  3 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 2249b41ca4afe..d1814b5197221 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -12,6 +12,7 @@
> 
>  #include "panthor_devfreq.h"
>  #include "panthor_device.h"
> +#include "panthor_hw.h"
> 
>  /**
>   * struct panthor_devfreq - Device frequency management
> @@ -164,6 +165,19 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	 */
>  	table = dev_pm_opp_get_opp_table(dev);
>  	if (IS_ERR_OR_NULL(table)) {
> +		/*
> +		 * On v15 GPUs, frequency scaling is handled outside of panthor
> +		 * by the AM_GOVERNOR block, so the GPU DT node may not provide
> +		 * an OPP table. In such cases, do not initialize devfreq for
> +		 * panthor.
> +		 */
> +		if (panthor_hw_is_gen5_am(ptdev->base.dev) &&

Could we have a property in panthor_hw or panthor_soc_data that
reflects whether devfreq is delegated or not, and move this commit
before the one introducing v15 support?

> +		    PTR_ERR(table) == -ENODEV) {
> +			drmm_kfree(&ptdev->base, pdevfreq);
> +			ptdev->devfreq = NULL;
> +			return 0;
> +		}
> +
