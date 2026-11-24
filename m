Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247C606A68C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=IyM/USj8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6B710E675;
	Tue, 24 Nov 2026 09:22:14 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C383910F3AB
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:22:07 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 344A7BE1;
 Tue, 24 Nov 2026 10:19:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795511974;
 bh=BOfCuQdAIdr1WlDa1P9AUvRyvhXK6N294LNORjdQb0A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IyM/USj8MEwQIoE4mf/7EaUX/NDMFrLM+IC+v3xQ6TK3t3BjumxVZToae4d0s3ao+
 OtCQMz3/4E+pvJBx+IzkAto8tWTp0OBvlGWvo4+WUtia2TOsTxrT7LozpR18d61Xi4
 GPhz6gWPbr4LQzqvtAb2nAcqp4glz5vdUc2qbYeo=
Message-ID: <a86eaca8-ba7f-412b-9735-c50bb7f58a23@ideasonboard.com>
Date: Tue, 24 Nov 2026 11:22:02 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/42] drm/fb-dma-helper: Handle framebuffers without a
 GEM object
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-10-a67c2b45b8ec@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261120-drm-state-readout-v9-10-a67c2b45b8ec@kernel.org>
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

On 20/11/2026 14:55, Maxime Ripard wrote:
> The state readout documentation now states that a driver should
> return an error when the hardware was programmed with a
> configuration it cannot represent, so that the state initialization
> falls back to the regular path.
> 
> However, a readout can also succeed with objects that cannot be
> fully reconstructed. The framebuffer the firmware left in the
> hardware was allocated outside of the kernel memory allocator, so
> drivers won't have any GEM object to attach to its planes.
> 
> drm_fb_dma_get_scanout_buffer() dereferences the GEM object of the
> first plane to fill the scanout buffer description used by
> drm_panic, and would thus crash during a panic happening before
> userspace had a chance to replace the framebuffer read out from the
> hardware state.
> 
> Return -ENODEV for such framebuffers, like we already do for
> imported buffers that are not accessible from the CPU.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> 
> ---
> 
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>   drivers/gpu/drm/drm_fb_dma_helper.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
> index fd71969d2fb1..e24036e1f3ba 100644
> --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> @@ -175,10 +175,20 @@ int drm_fb_dma_get_scanout_buffer(struct drm_plane *plane,
>   	fb = plane->state->fb;
>   	/* Only support linear modifier */
>   	if (fb->modifier != DRM_FORMAT_MOD_LINEAR)
>   		return -ENODEV;
>   
> +	/*
> +	 * The framebuffer has no GEM object backing its first plane,
> +	 * like a framebuffer reconstructed from a hardware state
> +	 * readout: we cannot access its contents. Check the framebuffer
> +	 * directly, since drm_fb_dma_get_gem_obj() warns about a
> +	 * missing GEM object.
> +	 */
> +	if (!fb->obj[0])
> +		return -ENODEV;
> +
>   	dma_obj = drm_fb_dma_get_gem_obj(fb, 0);
>   
>   	/* Buffer should be accessible from the CPU */
>   	if (drm_gem_is_imported(&dma_obj->base))
>   		return -ENODEV;
> 

Are this and the next one needed? I'm not that familiar with the buffer 
management, but in my tidss changes I implemented (or hacked? I'm not 
sure if it's proper...) GEM object creation for the bootsplash fb (you 
can then e.g. see the FB dma address from debugfs). If it is okay-ish, I 
wonder if all drivers can just do something like that with SRO.

  Tomi

