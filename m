Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834E606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=TmI2vofj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8A789864;
	Wed, 11 Nov 2026 14:57:09 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF48F89864
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:57:02 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 86CCF6AF;
 Wed, 11 Nov 2026 15:54:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794408878;
 bh=EinXmH3Lj3xhxGn+GXfi8CWJurPypEP8fTNioLOcrwQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TmI2vofj+dNTr9Dqf/lkQXjj50cDDJBeesqq2sZ4Bv7y2K4NoLzc8tJm2RkxTcwZc
 X7Vul+/nQf1gRsyjBWhjFYW8H+JaS0Fn+Mnxym4oRZjbVnorWpk67ar0hDAPiCQmhH
 CD69Mv4ex2CtrW5g6iPRiokxbnZQa5mPibyd+O6A=
Message-ID: <33f63eaf-42a0-4b3f-a21c-3752436d07b4@ideasonboard.com>
Date: Wed, 11 Nov 2026 16:56:57 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/omap: dss: fix handling deferrals
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
 hns@goldelico.com, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info>
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

On 11/11/2026 14:22, Andreas Kemnade wrote:
> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
> EPROBE_DEFER to ensure output gets initialized later when available.
> 
> On GTA04/OMAP3 no display was found, but it appeared after doing
> rmmod omapdrm ; modprobe omapdrm
> 
> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/gpu/drm/omapdrm/dss/output.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
> index 36d37deac8026..220ed7e003080 100644
> --- a/drivers/gpu/drm/omapdrm/dss/output.c
> +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> @@ -24,6 +24,11 @@ int omapdss_device_init_output(struct omap_dss_device *out,
>   
>   	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
>   	if (IS_ERR(bridge)) {
> +		if (PTR_ERR(bridge) == -EPROBE_DEFER) {
> +			ret = PTR_ERR(bridge);
> +			goto error;
> +		}
> +
Shouldn't we just return PTR_ERR(bridge) here? The error label will call 
omapdss_device_cleanup_output(), which cleans up things set up later in 
this function.

  Tomi

