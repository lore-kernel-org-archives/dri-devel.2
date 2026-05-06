Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F422FF8855
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 13:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3B710EDA5;
	Wed,  6 May 2026 13:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X3oPmRrE";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF6310EDB5
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 13:18:22 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-44b052142e1so2752325f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778073501; x=1778678301; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gdn3v4LePnCbJLOvB6JNHelM7dSdIHqCyFsaYNEA7+I=;
 b=X3oPmRrEE32eMNrY8yyyzr+wvv2vBx3J4GMXvDpHCS9lLBKA2GJtvrhkyixcbUbQpd
 WWuB9NqsDAvgQS+XkEVMO+UrosZK0Tp5v0F/Tr3VVvID5o4MTAzz7ta7D0IrI6w5vfYf
 0WkDCSHfDHNdg1lelSpVJ7UmuGGf1G3hff33U/uZGSCc0MA5zpVSHCVZGXMx70KeNOOE
 O7Lwti9cEqnersxv8iBmL7cnIZJBww4YnnpSTckEDATfv9fhk557NqJMt03iv2IZrPKZ
 XJuwVMctegL81StRzuKvxwQ1KyObBt8BJaD6OKuY7pHY1Nk9kVblgWf5BDkKjS+k2PE7
 hbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778073501; x=1778678301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Gdn3v4LePnCbJLOvB6JNHelM7dSdIHqCyFsaYNEA7+I=;
 b=MW1hF4ZpL9FGge9SkgRTQOIoYIFHwd/NfO7XrlTu7dU10jmvBaCea5zle8+DfPbmNK
 G+4i9k+qJw7SqMtErvRDMNhtuA894F8TRlKNsL3xLXAnvuP53ut28p5FE6Tp4+U4/GDP
 gRuArPGts2RWIo8Wz36vD+K6HGOVnI2lK9RXUWYkOz3YJWBQT1jrB1G+hHLjQwYN5pOx
 Wx6EWApnaz7TfkTOWSP6ZQs3dmAuyxb9Tti6QU6gsi2Yaavms97zDZTDiwSfDFxoWyzr
 eLmVOGmQ7r5NihTfSfSH2O5Wm/xL6Zckcf0+lUsPjo2DD5KoEjyFue7x6eGocGaseyNT
 rczw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8t7kCh8HFdIko6goRInw7NanZCT6XnFqC0UMAuoM73isCEg0usvg1HA77pIeJycd/psFuDns5U60Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsbiYYIyqqnAW5nkTZ99tIR4HmjDTMl4C0JprDdsEEo0HwA2a3
 7tC72KgXwRIlsju013uB6J6XFD8RjvN+TqXhL639QA4Gzi8ppfA5VlTL
X-Gm-Gg: AeBDieuSFnrEfNxaSIKRNTz0wMA9i2oHuw+7y8La4rA+x2DXotcy73P3u+AFOec+bJg
 K3IBnM7W+6YNDpMttHFDbSO7rDHOql9DCI6xRw1RiIP35UUbgdAlh1wdZJkoIoL9NBv+nYYWzyn
 /Ggp9twyqXDsFV15E/9fGi9MgXUkS2NxzWOIB9qrECscgS5k+E7GW7y9CLZMPMftWr0Au8KsD+I
 6NZhcBzUs3bnItxIBAbdM4bFhWM5SVGei2FUFe3y0b/5gNtX0ms0f/eSXCf6hC9aYTcq3wDmz5R
 tcKshUQTWCpk4dVtRi3JWJR5EqGqyFthuycf5mhAOOj/JoMmv8+i7j0QoJoC+VV5ZpHi8FsoyFM
 mpax9d0UzgC6Us5+vZ7GkgSejZ9wfX5KaU1+GQc1Gdz3Dv7SxX79+zIS54Kc6raihXc8Y6nT9kY
 /OPBptnNq4k9Sbf9gcO7wCPZcZxhO/dNwh+syOYWDEN1vCtgOU0l9i898dp41OvyGirSCL
X-Received: by 2002:a05:6000:ccd:b0:451:fd07:ff24 with SMTP id
 ffacd0b85a97d-451fd07ff9bmr2374020f8f.2.1778073501232; 
 Wed, 06 May 2026 06:18:21 -0700 (PDT)
Received: from osama ([2a02:908:1b6:8980:89b3:e462:e9ca:df27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960fd6sm13258526f8f.31.2026.05.06.06.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 06:18:20 -0700 (PDT)
Date: Wed, 6 May 2026 15:18:18 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Edmund Dea <edmund.j.dea@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/kmb: reset DSI host singleton state on teardown
Message-ID: <afs_moGTJaQfqmUt@osama>
References: <20260420150658.165734-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420150658.165734-1-osama.abdelkader@gmail.com>
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

On Mon, Apr 20, 2026 at 05:06:57PM +0200, Osama Abdelkader wrote:
> Tear down and clear the global DSI host/device/bridge singleton state
> when unregistering the host so probe retries and remove/reprobe cycles
> start from a clean state.
> 
> Guard the clock-disable path in kmb_dsi_host_unregister() to avoid
> dereferencing error pointers from early probe failure paths.
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/kmb/kmb_dsi.c | 44 ++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
> index aeb2f9f98f23..500dc00ba6ae 100644
> --- a/drivers/gpu/drm/kmb/kmb_dsi.c
> +++ b/drivers/gpu/drm/kmb/kmb_dsi.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/of_graph.h>
>  #include <linux/mfd/syscon.h>
> @@ -182,8 +183,18 @@ static void kmb_dsi_clk_disable(struct kmb_dsi *kmb_dsi)
>  
>  void kmb_dsi_host_unregister(struct kmb_dsi *kmb_dsi)
>  {
> -	kmb_dsi_clk_disable(kmb_dsi);
> -	mipi_dsi_host_unregister(kmb_dsi->host);
> +	if (!IS_ERR_OR_NULL(kmb_dsi))
> +		kmb_dsi_clk_disable(kmb_dsi);
> +
> +	if (dsi_host) {
> +		mipi_dsi_host_unregister(dsi_host);
> +		kfree(dsi_host);
> +		dsi_host = NULL;
> +	}
> +
> +	kfree(dsi_device);
> +	dsi_device = NULL;
> +	adv_bridge = NULL;
>  }
>  
>  /*
> @@ -217,6 +228,8 @@ static const struct mipi_dsi_host_ops kmb_dsi_host_ops = {
>  int kmb_dsi_host_bridge_init(struct device *dev)
>  {
>  	struct device_node *encoder_node, *dsi_out;
> +	bool host_registered = false;
> +	int ret;
>  
>  	/* Create and register MIPI DSI host */
>  	if (!dsi_host) {
> @@ -230,25 +243,38 @@ int kmb_dsi_host_bridge_init(struct device *dev)
>  			dsi_device = kzalloc_obj(*dsi_device);
>  			if (!dsi_device) {
>  				kfree(dsi_host);
> +				dsi_host = NULL;
>  				return -ENOMEM;
>  			}
>  		}
>  
>  		dsi_host->dev = dev;
> -		mipi_dsi_host_register(dsi_host);
> +		ret = mipi_dsi_host_register(dsi_host);
> +		if (ret) {
> +			DRM_ERROR("failed to register dsi host\n");
> +			kfree(dsi_device);
> +			dsi_device = NULL;
> +			kfree(dsi_host);
> +			dsi_host = NULL;
> +			return ret;
> +		}
> +
> +		host_registered = true;
>  	}
>  
>  	/* Find ADV7535 node and initialize it */
>  	dsi_out = of_graph_get_endpoint_by_regs(dev->of_node, 0, 1);
>  	if (!dsi_out) {
>  		DRM_ERROR("Failed to get dsi_out node info from DT\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_unregister_host;
>  	}
>  	encoder_node = of_graph_get_remote_port_parent(dsi_out);
>  	if (!encoder_node) {
>  		of_node_put(dsi_out);
>  		DRM_ERROR("Failed to get bridge info from DT\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_unregister_host;
>  	}
>  	/* Locate drm bridge from the hdmi encoder DT node */
>  	adv_bridge = of_drm_find_bridge(encoder_node);
> @@ -256,10 +282,16 @@ int kmb_dsi_host_bridge_init(struct device *dev)
>  	of_node_put(encoder_node);
>  	if (!adv_bridge) {
>  		DRM_DEBUG("Wait for external bridge driver DT\n");
> -		return -EPROBE_DEFER;
> +		ret = -EPROBE_DEFER;
> +		goto err_unregister_host;
>  	}
>  
>  	return 0;
> +
> +err_unregister_host:
> +	if (host_registered)
> +		kmb_dsi_host_unregister(NULL);
> +	return ret;
>  }
>  
>  static u32 mipi_get_datatype_params(u32 data_type, u32 data_mode,
> -- 
> 2.43.0
> 
ping.
