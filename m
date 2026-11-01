Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F33606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SOBq+xfr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB7F10E409;
	Sun,  1 Nov 2026 14:14:10 +0000 (UTC)
Received: from mta1.migadu.com (out-226.mta1.migadu.com [95.215.58.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0333710E409
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 14:14:02 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=cYMHJdYJyH2hnxqe0M9Ky2nfXrZcnOvPqcgoIDJjcvI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793542441; v=1; x=1794147241;
 b=SOBq+xfraJJp8nTTBpTv50QeDYHVixvYawFSkryoSeO9lxAoWZZsWP45cXImuCjYTZSCDQE4
 FoqyVqo2Y0Q7Oa3xEfp7ix9qetMW+9Og3dDrTLCbZpjUwVenP+Zo1pwm4zK0p7z3u6ut/85Pf0x
 0S/bBBs7WuU/RI9kY8PMan0A=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id a05e464f0524c77c;
 Sun, 01 Nov 2026 14:14:00 +0000
X-Mizu-Trace-ID: a05e464f0524c77c
X-Migadu-Flow: FLOW_OUT
Message-ID: <c12f6a9f-983d-4704-a90b-3453ce984a2c@linux.dev>
Date: Sun, 1 Nov 2026 14:14:00 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] drm/tidss: oldi: Fix cleanup on a failed init
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
 <20261029-beagley-ai-display-v4-9-dc7f2b532478@ideasonboard.com>
Content-Language: en-US
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20261029-beagley-ai-display-v4-9-dc7f2b532478@ideasonboard.com>
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
> tidss_oldi_init() registers a bridge for each OLDI TX in turn. If a later
> OLDI TX fails, the bridges registered for the earlier ones are not
> removed.
> 
> Fix this by calling tidss_oldi_deinit() in the error path.
> 
> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_oldi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 506507e83112..7344d86e1f13 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -638,5 +638,6 @@ int tidss_oldi_init(struct tidss_device *tidss)
>  err_put_node:
>  	of_node_put(child);
>  	of_node_put(oldi_parent);
> +	tidss_oldi_deinit(tidss);
>  	return ret;
>  }
> 

Since tidss_probe() (in tidss_drv.c) calls tidss_oldi_init(), it also
calls tidss_oldi_deinit() in its error exit path.

I think this patch is not required.
-- 
Regards
Aradhya

