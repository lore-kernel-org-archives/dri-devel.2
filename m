Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD5606A33A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=eoFt80c7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D0C10FC1D;
	Wed, 18 Nov 2026 13:52:10 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4DB10FCB1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=teG95imnd3SA/vWcomCAbPlJTD54rWgayeqF+AKsa2o=; t=1795009924; x=2110369924; 
 b=eoFt80c7viDVX4UkBkIzjUp6T3y8JmcjG0KQvGFa4VG3dlYzen4VnJczOKpi/5DV9gck8OyovM6
 vdjn0JLGVFfO/djoU1s7MWZ1eTOUgDKrwfr+QQEI8zKwplcNFVY5k/wW0Ayx5DHFXZop6QHVrf5Uh
 CCEdkJxO/utqk6FpXwDAcj2I06hPZ+tPPhZ+n6l8m19gzx2k9KA2cbyWi+pkNWRcPuA7DfShuhuul
 5lGlUE5O5o/NEa0Zc9cQtU/E8nu1goN63RZMBO/qra0BGn/3m6M0dkHxsr+Vj6dFPloP75c8cG5Sf
 16rbJ1MJSllmg37z4Ss22df/llox/sP+BvpQ==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xTg4t-000000011nz-2iLW; Wed, 18 Nov 2026 14:51:59 +0100
Message-ID: <7fc8d992-a0f7-455e-a87f-da1c03a8ede8@igalia.com>
Date: Wed, 18 Nov 2026 10:51:54 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] drm: Use designated initializers for of_device_id
 arrays
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Lanzano <lanzano.alex@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org,
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
References: <cover.1795002467.git.ukleinek@kernel.org>
 <c157d2e858e783956f47862ef45986d71c72a56d.1795002467.git.ukleinek@kernel.org>
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
In-Reply-To: <c157d2e858e783956f47862ef45986d71c72a56d.1795002467.git.ukleinek@kernel.org>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 18/11/26 09:08, Uwe Kleine-König wrote:
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct of_device_id replacing .data by an anonymous union.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com> # vc4

Best regards,
- Maíra

> ---
>   drivers/gpu/drm/panel/panel-dsi-cm.c          |  4 ++--
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |  4 ++--
>   drivers/gpu/drm/tiny/sharp-memory.c           | 20 +++++++++----------
>   drivers/gpu/drm/vc4/vc4_dsi.c                 |  6 +++---
>   4 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel/panel-dsi-cm.c
> index ae6e9ffc46cb..99ccf3badde7 100644
> --- a/drivers/gpu/drm/panel/panel-dsi-cm.c
> +++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
> @@ -628,8 +628,8 @@ static const struct dsic_panel_data droid4_data = {
>   
>   static const struct of_device_id dsicm_of_match[] = {
>   	{ .compatible = "tpo,taal", .data = &taal_data },
> -	{ .compatible = "nokia,himalaya", &himalaya_data },
> -	{ .compatible = "motorola,droid4-panel", &droid4_data },
> +	{ .compatible = "nokia,himalaya", .data = &himalaya_data },
> +	{ .compatible = "motorola,droid4-panel", .data = &droid4_data },
>   	{},
>   };
>   
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index acc560dc5ea5..bdbe1fe9c879 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2924,8 +2924,8 @@ static const struct of_device_id ili9881c_of_match[] = {
>   	{ .compatible = "wanchanglong,w552946aba", .data = &w552946aba_desc },
>   	{ .compatible = "waveshare,7.0-dsi-touch-a", .data = &waveshare_7inch_a_desc },
>   	{ .compatible = "ampire,am8001280g", .data = &am8001280g_desc },
> -	{ .compatible = "raspberrypi,dsi-5inch", &rpi_5inch_desc },
> -	{ .compatible = "raspberrypi,dsi-7inch", &rpi_7inch_desc },
> +	{ .compatible = "raspberrypi,dsi-5inch", .data = &rpi_5inch_desc },
> +	{ .compatible = "raspberrypi,dsi-7inch", .data = &rpi_7inch_desc },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, ili9881c_of_match);
> diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
> index 861dd81a8e5b..e3367e433a2e 100644
> --- a/drivers/gpu/drm/tiny/sharp-memory.c
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> @@ -435,16 +435,16 @@ static const struct spi_device_id sharp_memory_ids[] = {
>   MODULE_DEVICE_TABLE(spi, sharp_memory_ids);
>   
>   static const struct of_device_id sharp_memory_of_match[] = {
> -	{.compatible = "sharp,ls010b7dh04", &sharp_memory_ls010b7dh04_mode},
> -	{.compatible = "sharp,ls011b7dh03", &sharp_memory_ls011b7dh03_mode},
> -	{.compatible = "sharp,ls012b7dd01", &sharp_memory_ls012b7dd01_mode},
> -	{.compatible = "sharp,ls013b7dh03", &sharp_memory_ls013b7dh03_mode},
> -	{.compatible = "sharp,ls013b7dh05", &sharp_memory_ls013b7dh05_mode},
> -	{.compatible = "sharp,ls018b7dh02", &sharp_memory_ls018b7dh02_mode},
> -	{.compatible = "sharp,ls027b7dh01", &sharp_memory_ls027b7dh01_mode},
> -	{.compatible = "sharp,ls027b7dh01a", &sharp_memory_ls027b7dh01_mode},
> -	{.compatible = "sharp,ls032b7dd02", &sharp_memory_ls032b7dd02_mode},
> -	{.compatible = "sharp,ls044q7dh01", &sharp_memory_ls044q7dh01_mode},
> +	{ .compatible = "sharp,ls010b7dh04", .data = &sharp_memory_ls010b7dh04_mode },
> +	{ .compatible = "sharp,ls011b7dh03", .data = &sharp_memory_ls011b7dh03_mode },
> +	{ .compatible = "sharp,ls012b7dd01", .data = &sharp_memory_ls012b7dd01_mode },
> +	{ .compatible = "sharp,ls013b7dh03", .data = &sharp_memory_ls013b7dh03_mode },
> +	{ .compatible = "sharp,ls013b7dh05", .data = &sharp_memory_ls013b7dh05_mode },
> +	{ .compatible = "sharp,ls018b7dh02", .data = &sharp_memory_ls018b7dh02_mode },
> +	{ .compatible = "sharp,ls027b7dh01", .data = &sharp_memory_ls027b7dh01_mode },
> +	{ .compatible = "sharp,ls027b7dh01a", .data = &sharp_memory_ls027b7dh01_mode },
> +	{ .compatible = "sharp,ls032b7dd02", .data = &sharp_memory_ls032b7dd02_mode },
> +	{ .compatible = "sharp,ls044q7dh01", .data = &sharp_memory_ls044q7dh01_mode },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, sharp_memory_of_match);
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index ec008f766dd5..3e231f875725 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -1450,9 +1450,9 @@ static const struct vc4_dsi_variant bcm2835_dsi1_variant = {
>   };
>   
>   static const struct of_device_id vc4_dsi_dt_match[] = {
> -	{ .compatible = "brcm,bcm2711-dsi1", &bcm2711_dsi1_variant },
> -	{ .compatible = "brcm,bcm2835-dsi0", &bcm2835_dsi0_variant },
> -	{ .compatible = "brcm,bcm2835-dsi1", &bcm2835_dsi1_variant },
> +	{ .compatible = "brcm,bcm2711-dsi1", .data = &bcm2711_dsi1_variant },
> +	{ .compatible = "brcm,bcm2835-dsi0", .data = &bcm2835_dsi0_variant },
> +	{ .compatible = "brcm,bcm2835-dsi1", .data = &bcm2835_dsi1_variant },
>   	{}
>   };
>   

