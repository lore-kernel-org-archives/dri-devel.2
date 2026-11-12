Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D622606A880
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=nSe0RQaY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C725F10E509;
	Thu, 12 Nov 2026 10:25:32 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837B310FFDD
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:25:26 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A05A6802;
 Thu, 12 Nov 2026 11:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794478981;
 bh=m3PNmU33zF/fXWsagM6zSSS6S9ylBnP9yC97sAMjp38=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nSe0RQaYko4amJJHwPtkHqMlysca2D7eh/uECdmwT5xquIyKIFb/cXKXslR3LRy+c
 LKLOY0eXC9ktGawwh4Qwu7SEuBsmrvW2zO/SVmFqyovGRVLIIDoK0g9CZFd8rpjag2
 49jESfeI5+hIjh7eo8E7Qb3GGJ+DZscPGsO7RI6A=
Message-ID: <e93d1911-a6d9-4256-a2cb-cd2d6112a4c0@ideasonboard.com>
Date: Thu, 12 Nov 2026 12:25:20 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/omap: dss: fix handling deferrals
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
 hns@goldelico.com, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/11/2026 23:14, Andreas Kemnade wrote:
> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
> EPROBE_DEFER to ensure output gets initialized later when available.
> 
> On GTA04/OMAP3 no display was found, but it appeared after doing
> rmmod omapdrm ; modprobe omapdrm
> 
> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
> - do not use the error goto
> - Link to v1: https://patch.msgid.link/20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info
> ---
>   drivers/gpu/drm/omapdrm/dss/output.c | 3 +++
>   1 file changed, 3 insertions(+)

Thanks, I'll push to drm-misc-next.

  Tomi

> diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
> index 36d37deac8026..b5cef5093a883 100644
> --- a/drivers/gpu/drm/omapdrm/dss/output.c
> +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> @@ -24,6 +24,9 @@ int omapdss_device_init_output(struct omap_dss_device *out,
>   
>   	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
>   	if (IS_ERR(bridge)) {
> +		if (PTR_ERR(bridge) == -EPROBE_DEFER)
> +			return PTR_ERR(bridge);
> +
>   		dev_dbg(out->dev, "failed to find video sink\n");
>   		return 0;
>   	}
> 
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261111-gta04-drm-regression-fix-f7ef51c66ed3
> 
> Best regards,
> --
> Andreas Kemnade <andreas@kemnade.info>
> 

