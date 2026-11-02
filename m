Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F060A2614
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SFeXF3GH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E702310EE38;
	Mon,  2 Nov 2026 13:46:10 +0000 (UTC)
Received: from mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410BB10E2E0
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:46:04 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=P2sBHzm3R20huYIeMHg9Un4m8wkGCVohUQK9dUiQf5I=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793627161; v=1; x=1794231961;
 b=SFeXF3GHfLHh35oMNnXKjZKqNWryp5H/0VJRgCIHIn2ydLUwzShxT1839nxXmpK2wzvtIoA6
 Y+l7AZU3bkv/Nu/raeqJ7LZ52lQdCUt368vPjrT3c1wYn+5hZWIxKXh/dquT3d3Ns4OMysUPmqj
 YI2XzDEHdtjcq14+ALsrluhE=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 4279429b9f88ac8f;
 Mon, 02 Nov 2026 13:46:00 +0000
X-Mizu-Trace-ID: 4279429b9f88ac8f
X-Migadu-Flow: FLOW_OUT
Message-ID: <4148e258-b406-4964-82b3-11ea624f974e@linux.dev>
Date: Mon, 2 Nov 2026 13:45:59 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] drm/tidss: oldi: Add power domain support
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Swamil Jain <s-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
 <20261029-beagley-ai-display-v4-11-dc7f2b532478@ideasonboard.com>
Content-Language: en-US
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20261029-beagley-ai-display-v4-11-dc7f2b532478@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tomi,

On 29/10/26 10:18, Tomi Valkeinen wrote:
> The OLDI TXes on AM62P and J722S have power domains of their own,
> described in the DT, unlike the earlier SoCs. The OLDI TX nodes are not
> real devices, so the driver core does not attach these power domains,
> and nothing in the core turns them on.
> 
> Add support to attach the PDs with dev_pm_domain_attach_by_node(), and
> manage the power state of the returned virtual devices with runtime PM
> functions.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_oldi.c | 88 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 5552c1c51074..df2326db3302 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -10,6 +10,8 @@
>  #include <linux/of_graph.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/media-bus-format.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
>  #include <drm/drm_atomic_helper.h>
> @@ -35,6 +37,12 @@ struct tidss_oldi {
>  
>  	struct clk *serial;
>  	struct regmap *io_ctrl;
> +
> +	/*
> +	 * The power domains of this OLDI TX and, in dual-link mode, of its
> +	 * companion. NULL for an OLDI TX without a power domain of its own.
> +	 */
> +	struct device *pd_devs[2];
>  };
>  
>  struct oldi_bus_format {
> @@ -238,6 +246,22 @@ static int tidss_oldi_atomic_check(struct drm_bridge *bridge,
>  	return 0;
>  }
>  
> +static void tidss_oldi_power_get(struct tidss_oldi *oldi)
> +{
> +	for (unsigned int i = 0; i < ARRAY_SIZE(oldi->pd_devs); i++) {
> +		if (oldi->pd_devs[i])
> +			WARN_ON(pm_runtime_get_sync(oldi->pd_devs[i]) < 0);
> +	}
> +}
> +
> +static void tidss_oldi_power_put(struct tidss_oldi *oldi)
> +{
> +	for (unsigned int i = 0; i < ARRAY_SIZE(oldi->pd_devs); i++) {
> +		if (oldi->pd_devs[i])
> +			pm_runtime_put(oldi->pd_devs[i]);
> +	}
> +}
> +
>  static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
>  					 struct drm_atomic_commit *state)
>  {
> @@ -251,6 +275,8 @@ static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
>  	if (oldi->link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK)
>  		return;
>  
> +	tidss_oldi_power_get(oldi);
> +
>  	connector = drm_atomic_get_new_connector_for_encoder(state,
>  							     bridge->encoder);
>  	if (WARN_ON(!connector))
> @@ -296,6 +322,8 @@ static void tidss_oldi_atomic_post_disable(struct drm_bridge *bridge,
>  
>  	/* Clear OLDI Config */
>  	tidss_disable_oldi(oldi->tidss, oldi->parent_vp);
> +
> +	tidss_oldi_power_put(oldi);
>  }
>  
>  #define MAX_INPUT_SEL_FORMATS	1
> @@ -468,6 +496,60 @@ static int get_parent_dss_vp(struct device_node *oldi_tx, u32 *parent_vp)
>  	return -ENODEV;
>  }
>  
> +static void tidss_oldi_detach_pd(void *data)
> +{
> +	struct device *pd_dev = data;
> +
> +	dev_pm_domain_detach(pd_dev, true);
> +}
> +
> +static struct device *tidss_oldi_create_pd_dev(struct tidss_device *tidss,
> +					       struct device_node *oldi_tx)
> +{
> +	struct device *dev;
> +	int ret;
> +
> +	dev = dev_pm_domain_attach_by_node(tidss->dev, oldi_tx, 0);
> +	if (IS_ERR_OR_NULL(dev))
> +		return dev;
> +
> +	ret = devm_add_action_or_reset(tidss->dev, tidss_oldi_detach_pd, dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return dev;
> +}
> +
> +static int tidss_oldi_create_pd_devs(struct tidss_device *tidss,
> +				     struct tidss_oldi *oldi,
> +				     struct device_node *oldi_tx)
> +{
> +	struct device_node *companion;
> +	struct device *pd_dev;
> +
> +	pd_dev = tidss_oldi_create_pd_dev(tidss, oldi_tx);
> +	if (IS_ERR(pd_dev))
> +		return PTR_ERR(pd_dev);
> +
> +	oldi->pd_devs[0] = pd_dev;
> +
> +	if (oldi->companion_instance < 0)
> +		return 0;
> +
> +	companion = of_parse_phandle(oldi_tx, "ti,companion-oldi", 0);
> +	if (!companion)
> +		return -EINVAL;
> +
> +	pd_dev = tidss_oldi_create_pd_dev(tidss, companion);
> +	of_node_put(companion);
> +	if (IS_ERR(pd_dev))
> +		return PTR_ERR(pd_dev);
> +
> +	oldi->pd_devs[1] = pd_dev;
> +
> +	return 0;
> +}
> +
>  void tidss_oldi_deinit(struct tidss_device *tidss)
>  {
>  	for (int i = 0; i < tidss->num_oldis; i++) {
> @@ -610,6 +692,12 @@ static int tidss_oldi_init_one(struct tidss_device *tidss,
>  		}
>  	}
>  
> +	ret = tidss_oldi_create_pd_devs(tidss, oldi, oldi_tx);
> +	if (ret)
> +		return dev_err_probe(tidss->dev, ret,
> +				     "OLDI%u: Failed to set up the power domains.\n",
> +				     oldi_instance);
> +

I agree with the what this patch is trying to do, but the
tidss_oldi_create_pd_devs() should be within the if() block above.

It seems like you are giving the pd_dev of the secondary OLDI TX to the
primary, but this path would be executed for secondary OLDI TX in clone
mode as well, whenever it gets supported.
Which is not ideal, because the primary OLDI TX in clone mode would
already be taking care of the secondary's pd_dev.

The conditional block above with,
`if (link_type != OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK)`, is exactly
for things that _can_ be setup per OLDI Tx, but shouldn't, like the
clock and the IO control.

-- 
Regards
Aradhya

