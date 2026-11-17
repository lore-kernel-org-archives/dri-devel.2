Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F6606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=pg1WbT/x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC70510EA42;
	Tue, 17 Nov 2026 07:24:47 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CCC110EABF
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:24:42 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97890177;
 Tue, 17 Nov 2026 08:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794900133;
 bh=PcgKyRP0jxJ8OZV/2VS9bPYPY9IAi5EKhkoitZj6qK4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pg1WbT/xN4cZqZhi8v/Ih+MJKk8zR39c8Xfbp3Bo55Qnar/ySLaHirn7D8pzINEsP
 LDy+TNIH89K2aXp0F6vtweE/Pdb2LXt3gqSjT6AKPY/SgiQoR0sW/ITGF9ClJJhJM1
 6/S38i4dHZ91V920MoB7QaKgzvrz7dfgOT2jnVv0=
Message-ID: <5f391511-45a2-41c8-9fc6-a1ddc33e7749@ideasonboard.com>
Date: Tue, 17 Nov 2026 09:24:36 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 32/39] drm/tidss: crtc: Add atomic_print_state
 implementation
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-32-cbe78624e1bc@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261106-drm-state-readout-v8-32-cbe78624e1bc@kernel.org>
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

On 06/11/2026 15:14, Maxime Ripard wrote:
> The tidss CRTC subclasses drm_crtc_state with bus_format and bus_flags
> fields that are set during atomic check and state readout. These fields
> are not visible in the standard atomic state dumps, making it harder to
> debug bus format negotiation issues.
> 
> Add an atomic_print_state hook to expose them in debugfs and kernel log
> state dumps.
> 
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/tidss/tidss_crtc.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
> index ae9c66831b6c..d2664bda53a9 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -404,4 +404,13 @@ static void tidss_crtc_destroy(struct drm_crtc *crtc)
>   }
>   
> +static void tidss_crtc_atomic_print_state(struct drm_printer *p,
> +					  const struct drm_crtc_state *state)
> +{
> +	const struct tidss_crtc_state *tstate = to_tidss_crtc_state(state);
> +
> +	drm_printf_indent(p, 1, "bus_format=0x%08x\n", tstate->bus_format);
> +	drm_printf_indent(p, 1, "bus_flags=0x%08x\n", tstate->bus_flags);
> +}
> +
>   static const struct drm_crtc_funcs tidss_crtc_funcs = {
>   	.destroy = tidss_crtc_destroy,
> @@ -411,4 +420,5 @@ static const struct drm_crtc_funcs tidss_crtc_funcs = {
>   	.atomic_duplicate_state = tidss_crtc_duplicate_state,
>   	.atomic_destroy_state = tidss_crtc_destroy_state,
> +	.atomic_print_state = tidss_crtc_atomic_print_state,
>   	.enable_vblank = tidss_crtc_enable_vblank,
>   	.disable_vblank = tidss_crtc_disable_vblank,
> 

Thanks, I'll pick this up to drm-misc-next.

  Tomi

