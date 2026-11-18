Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F92606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=paWptVzZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB0E10FCE7;
	Wed, 18 Nov 2026 14:01:00 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC86D10FCE7
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=r927fCsu5OYlKQKCmEL8H5aMGocn+zYem10GOxKtVfQ=; t=1795010453; x=2110370453; 
 b=paWptVzZsVsmeTOHIHi7lw5PGkq/HreU+VQM1n/Cv/zeXXZu5Avae3VQGsEWOXs6wykn93j6cuh
 Kx0Zy3BmZ8hb0Ry8MS1IJa/vgxG3NYElBt5UGl4djBnM34ju43QhJHZIx2Gkf/Oy+O7dCKNfglg10
 uuxVoNwtG97EzNyaQIZMAvVry3VN1xktjbUTjjus4B/s3uhxnGb7e2WbnRGnjzqNJIh/c+uoGqjEA
 jIGBUIJoaezQwOclP2RhIpWe4C7n67lkhOJPeiDNw1W3UxwAzuL/AA0HH9xvtgo55l5x4+TeIPFi0
 7xVAgtdLKA4Payqx4Jy5ixadAN1yPFM8VXPg==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xTgDQ-0000000127X-2lH7; Wed, 18 Nov 2026 15:00:49 +0100
Message-ID: <bd7812ad-3eb6-49a1-bd22-b4252c09ac00@igalia.com>
Date: Wed, 18 Nov 2026 11:00:43 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vc4: dsi: Allocate the encoder per DRM device
To: Henry Zhang <henryzhang62@gmail.com>, mripard@kernel.org,
 dave.stevenson@raspberrypi.com
Cc: kernel-list@raspberrypi.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261117205902.1293962-1-henryzhang62@gmail.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20261117205902.1293962-1-henryzhang62@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Henry,

On 17/11/26 17:59, Henry Zhang wrote:
> The DSI encoder is embedded in struct vc4_dsi, which lives as long as
> the DSI platform device, but it is initialised with drmm_encoder_init()
> and so is only cleaned up when the DRM device is released. The DRM
> device can outlive the unbind of the vc4 components: unloading the DSI
> panel driver detaches from the DSI host, which deletes the DSI component
> and unbinds the whole vc4 DRM device, but a compositor that keeps the
> DRM device open keeps it alive.
> 
> If the panel driver is loaded again before that, the new DRM device
> binds the DSI component and calls drmm_encoder_init() on the encoder
> that is still on the old DRM device's encoder list. The old device's
> release later cleans it up from under the new one. On a Raspberry Pi 4
> with a 6.18-based kernel, closing the old DRM device then gave:
> 
>    WARNING: drivers/gpu/drm/drm_encoder.c:214 at drmm_encoder_alloc_release+0x30/0x40 [drm]
>    Call trace: drmm_encoder_alloc_release <- drm_dev_put <- drm_gem_dmabuf_release <- __fput
>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>    pc : drm_mode_config_cleanup+0x5c/0x2f0 [drm]
>    Call trace: drm_mode_config_cleanup <- drm_managed_release <- drm_dev_put

Could you reproduce this issue on top of drm-misc-next? The downstream
kernel differs from upstream in several ways. If you are able to
reproduce it, could you please provide the full call trace?

Best regards,
- Maíra

> 
> Allocate the encoder in bind with drmm_encoder_alloc(), so each DRM
> device has its own and releases only its own. The DSI bridge is still
> shared: while the old DRM device holds it, drm_bridge_attach() in the
> new bind fails with -EBUSY, so binding again before the old DRM device
> is released now fails cleanly instead of corrupting both devices.
> 
> The analysis, this change and this description were prepared with the
> help of an AI coding assistant (Claude Code).
> 
> Fixes: 6f0ca506c30e ("drm/vc4: dsi: Switch to DRM-managed encoder initialization")
> Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
> ---
> Testing:
> 
> - On this base (drm-misc-next 467ac0b56aeb): compile-tested only,
>    arm64 defconfig with DRM_VC4=m, W=1, no new warnings.
> 
> - A backport to a downstream Raspberry Pi 6.18.34 kernel, on a
>    Raspberry Pi 4 with an out-of-tree modular DSI panel driver: with the
>    compositor stopped and a process holding /dev/dri/card1 open, unload
>    the panel driver and load it again. The bind now fails cleanly:
> 
>      vc4-drm gpu: failed to bind fe700000.dsi (ops vc4_dsi_ops [vc4]): -16
>      vc4-drm gpu: adev bind failed: -16
> 
>    the panel probe fails with -16, and there is no warning or oops,
>    also when the holder then closes the old DRM device. Unloading and
>    loading the panel driver again after that brings back the display
>    and the compositor. Without the change, the same kernel gave the
>    warning and oops above. The backport differs from this patch in two
>    ways: that kernel still gets the panel bridge with
>    drmm_of_get_bridge(), which has a use-after-free of its own in this
>    sequence, so the test kernel used devm_drm_of_get_bridge() instead
>    (not needed here, where the panel bridge is refcounted); and a
>    downstream DSI restart worker that used the embedded encoder now
>    follows a pointer to the current one.
> 
> The -EBUSY is final: the panel probe is not retried when the old DRM
> device goes away, so the panel driver has to be loaded again. Would you
> prefer the DSI host to wait for the old DRM device to be released
> before adding its component again, or a bridge allocated per bind?
> 
> Not addressed: a connector probe that is already running when the
> panel is removed can still call into the panel driver.
> 
> This applies to drm-misc-next on its own. It also applies on top of my
> "drm/vc4: dsi: Serialize register writes through the DMA workaround",
> and it does not touch the code changed by my vc4 DSI series
> <20261028164539.3471833-1-henryzhang62@gmail.com>.
> 
> Tools: Claude Code (an AI coding assistant) analysed the crash logs and
> the vc4/DRM lifetimes, located the introducing commit, wrote the change
> and this description, built and checkpatch-checked it, and ran the
> backport test on the board, at my request.
> 
>   drivers/gpu/drm/vc4/vc4_dsi.c | 35 +++++++++++++++++++++++------------
>   1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index ec008f766..5bd8f579b 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -546,9 +546,18 @@ struct vc4_dsi_variant {
>   
>   };
>   
> +/*
> + * The encoder of one DRM device. The DRM device can outlive the unbind of
> + * this component, so a later bind must not reuse the encoder of an earlier
> + * one: allocate one per bind, managed by the DRM device.
> + */
> +struct vc4_dsi_encoder {
> +	struct vc4_encoder base;
> +	struct vc4_dsi *dsi;
> +};
> +
>   /* General DSI hardware state. */
>   struct vc4_dsi {
> -	struct vc4_encoder encoder;
>   	struct mipi_dsi_host dsi_host;
>   
>   	struct platform_device *pdev;
> @@ -601,7 +610,7 @@ struct vc4_dsi {
>   	container_of_const(host, struct vc4_dsi, dsi_host)
>   
>   #define to_vc4_dsi(_encoder)					\
> -	container_of_const(_encoder, struct vc4_dsi, encoder.base)
> +	(container_of_const(_encoder, struct vc4_dsi_encoder, base.base)->dsi)
>   
>   #define bridge_to_vc4_dsi(_bridge)				\
>   	container_of_const(_bridge, struct vc4_dsi, bridge)
> @@ -1626,7 +1635,8 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
>   	struct platform_device *pdev = to_platform_device(dev);
>   	struct drm_device *drm = dev_get_drvdata(master);
>   	struct vc4_dsi *dsi = dev_get_drvdata(dev);
> -	struct drm_encoder *encoder = &dsi->encoder.base;
> +	struct vc4_dsi_encoder *dsi_encoder;
> +	struct drm_encoder *encoder;
>   	int ret;
>   
>   	drm_bridge_get(&dsi->bridge);
> @@ -1637,9 +1647,6 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
>   
>   	dsi->variant = of_device_get_match_data(dev);
>   
> -	dsi->encoder.type = dsi->variant->port ?
> -		VC4_ENCODER_TYPE_DSI1 : VC4_ENCODER_TYPE_DSI0;
> -
>   	dsi->regs = vc4_ioremap_regs(pdev, 0);
>   	if (IS_ERR(dsi->regs))
>   		return PTR_ERR(dsi->regs);
> @@ -1758,12 +1765,16 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
>   	if (ret)
>   		return ret;
>   
> -	ret = drmm_encoder_init(drm, encoder,
> -				&vc4_dsi_encoder_funcs,
> -				DRM_MODE_ENCODER_DSI,
> -				NULL);
> -	if (ret)
> -		return ret;
> +	dsi_encoder = drmm_encoder_alloc(drm, struct vc4_dsi_encoder, base.base,
> +					 &vc4_dsi_encoder_funcs,
> +					 DRM_MODE_ENCODER_DSI, NULL);
> +	if (IS_ERR(dsi_encoder))
> +		return PTR_ERR(dsi_encoder);
> +
> +	dsi_encoder->dsi = dsi;
> +	dsi_encoder->base.type = dsi->variant->port ?
> +		VC4_ENCODER_TYPE_DSI1 : VC4_ENCODER_TYPE_DSI0;
> +	encoder = &dsi_encoder->base.base;
>   
>   	ret = devm_pm_runtime_enable(dev);
>   	if (ret)
> 
> base-commit: 467ac0b56aebc804360f276feffbc9032c265a6e

