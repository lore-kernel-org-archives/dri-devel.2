Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F37606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=TWbaZIYf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DA910F340;
	Tue, 24 Nov 2026 08:44:51 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2124510F360
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:40:22 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 334F5C4B;
 Tue, 24 Nov 2026 09:37:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795509467;
 bh=2K8xPBj9iPM8TNkB1PVwAYmvsBxCh/QK1VVS76t/A94=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TWbaZIYfIBczsL5s26/kLSuXsLUwhRmHtOi+GTr002laFFgzCp3Kn2e2viv2ChHvJ
 RhJALgOzhEZ4LcTqIpj9SFT3cfsxdpYhcOroiVLr3l1c2Smx15Z/KDu9LG4rkrkG8K
 xSJ1CT/+ppZjjdH4jHVjoi/fiA3Majok1RoLtA8c=
Message-ID: <f8667b5b-7adb-46f4-938f-adede2f2ef7c@ideasonboard.com>
Date: Tue, 24 Nov 2026 10:40:16 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/42] drm/colorop: Export
 drm_atomic_helper_colorop_create_state()
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-5-a67c2b45b8ec@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261120-drm-state-readout-v9-5-a67c2b45b8ec@kernel.org>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 20/11/2026 14:54, Maxime Ripard wrote:
> drm_atomic_helper_colorop_create_state() is only called by
> drm_mode_config_create_state(), which lives in the same module, so it
> never needed to be exported.
> 
> The atomic state readout helpers we'll introduce call it
> from drm_kms_helper to allocate the colorop states. Without the
> export, building the kernel with CONFIG_DRM_KMS_HELPER=m fails at
> modpost with an undefined symbol.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_colorop.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index 95da03d6c65c..319557d1436f 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
> @@ -646,10 +646,11 @@ drm_atomic_helper_colorop_create_state(struct drm_colorop *colorop)
>   
>   	__drm_colorop_state_init(state, colorop);
>   
>   	return state;
>   }
> +EXPORT_SYMBOL(drm_atomic_helper_colorop_create_state);
>   
>   /**
>    * __drm_colorop_reset - reset state on colorop
>    * @colorop: drm colorop
>    * @colorop_state: colorop state to assign
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

