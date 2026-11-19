Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484FC606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GdY0aA6j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6131610E2B8;
	Thu, 19 Nov 2026 18:14:32 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9A710E2B8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 18:14:25 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-380c28f9e35so1146174eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795112065; x=1795716865;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y8PbeBxo18F1K4bUgnNFg9TAXNOHPLNg4Za/ShEs8I4=;
 b=GdY0aA6jmTqfjXqYf2eVKDP9wrK33p3oQSXOmaD9NfJceoYqsz1bx0EGXJeBxs899m
 XM/TE3Cz2CKKog/lnbljfPRVAlgNJMi+KCM60Lmnw4pjp//wgLywwngCcQColV3pevcg
 N7i5RdroeEq3eKQ40mxJRJ8dDAZzow2Vxhd4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795112065; x=1795716865;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y8PbeBxo18F1K4bUgnNFg9TAXNOHPLNg4Za/ShEs8I4=;
 b=fiOA8T5u1Zve5x6x0GY7l1b1iE+hIYy3JU9a6PlefV6gc4MYZGZOPQj5zsx7lma+lg
 zEjzPIq9cBQdXjzjQ4Re6Wq5vac6gYe8DxlGiWZM5rO2Ws3LJpGFAAwBr1Fib112KZuC
 Dy9P55E9H2UB7mRgPE0MEfrll795bWHVLSgC9zz/15Z1Y7lY82OGwwnYvdt7vzj4q35o
 Xx+1yfwaNF9MxG4JsnwywKm9ilEA7w7uXcHw3P2qsmyUCwLbvCGJZg512cmcrIu8DcXQ
 owZmkFQDGx9b7QC0AzGgR7ymq820o/5gEmnh1DnAKHx2rPLBjc9dAmxGA5z2BeSUGlEa
 wywQ==
X-Gm-Message-State: APuU4Z+KHYVZPmiNJGiTPqGLYUvuxGCnnDGW3MAauQBH6/jk7Te1lrdm
 Y0jjj4CUA3ab9GxZWhBbGBKH+G9XCxfXmVPPQ19jWdL8l/hyYrLSEjx6BE/DGv3THg==
X-Gm-Gg: AZFdTZeCpIvZfJRzPWwHcbvYsBAuonuAzbCsv6Lg05QC8DTMFuOvtZawn+spDjADj0n
 9UUzX7NDCbuszqQ928CBOpBVBVPbaAxmgtLlkSrXBHYXjZPdZmc18QRkjLs787oXBXAN5+1G58C
 VnUVNPB3lWjt09FPjXREvKv0Zarf8cqDmvqKbxYet9Ns6qk10uNELOVVC1GjUYa6ytkP5HYuYJq
 1ENiJZpFN9T+/opoKKuRj+AAS0jm1hc1UZ5heyCmbTDI+Z8dT8EDH7vbe+ock2DdTEA8Twqs0X/
 h4QDYXzq6qeKGVOmCphrUHIttoqUHzMg5Q210ndtVMmzgYB0J2ZvwvO8IVN23H0CMjZxvcZOTcD
 Wqfb3sRzQiZXCihJbccjUr5Et5LXByt9xXjP/iYZ4aibm4kkq3q/xuqtorx4mqg0am5bi6PXRu0
 d0AEUtpcYtIGMyi6DmbsmuAUoTXCoHApx3Hq8SuQ+Vqa58pzX8mdudbde7khkQY9rbSyB4fdtYZ
 FfhpZXVueA4nKsdm7+sK/wMygzE8TneleX6kud+/jXea+QcVWzG61wvDz/q4qTcrS7Dznggp6Un
 d/v9YNQijXO6GFcZxRdfrFwQ+4eMcDC/HO8aLSx7uMAmiarMutI+8qXHghsDqjwzQSEPSKONyEf
 dsuHA7JV7fAShQA==
X-Received: by 2002:a05:693c:68dc:b0:384:244b:12ed with SMTP id
 5a478bee46e88-384b11ec95amr1738509eec.3.1795112064301; 
 Thu, 19 Nov 2026 10:14:24 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:bdc0:a95f:45fc:7172])
 by smtp.gmail.com with UTF8SMTPSA id
 5a478bee46e88-385667decc2sm473306eec.9.2026.11.19.10.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 10:14:23 -0800 (PST)
Date: Thu, 19 Nov 2026 10:14:20 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Hold runtime PM reference in
 bridge detect
Message-ID: <av88fNztBjS79X8L@google.com>
References: <CGME20261119103751eucas1p16485be9bf23e31909f3b2df7c1c9d43f@eucas1p1.samsung.com>
 <20261119103742.1161858-1-m.szyprowski@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119103742.1161858-1-m.szyprowski@samsung.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 11:37:41AM +0100, Marek Szyprowski wrote:
> analogix_dp_bridge_detect() calls analogix_dp_detect_hpd() without
> holding a runtime PM reference on the DP device. If there is no HPD
> GPIO, analogix_dp_get_plug_in_status() reads ANALOGIX_DP_SYS_CTL_3 and,
> with "force-hpd", analogix_dp_force_hpd() also writes to it. When the
> display is disabled the controller is runtime suspended, so these are
> accesses to an unclocked (and possibly unpowered) IP block.

If there *is* an HPD GPIO and no 'force-hpd' ... is this patch wasteful?
How much?

(Honest question. I don't remember all the details here, but you're
suggesting this can be poked by userspace any time, so it seems like it
might be relevant.)

Brian

> The connector created by drm_bridge_connector is polled because the
> bridge provides DRM_BRIDGE_OP_DETECT without DRM_BRIDGE_OP_HPD, and
> userspace may also query the connector state at any time, so this path
> is regularly executed with the device suspended. It affects only setups
> without a next bridge or panel (e.g. a DP connector), as otherwise
> detect returns early.
> 
> Take a runtime PM reference around the HPD check, the same way as
> analogix_dpaux_transfer() and analogix_dpaux_wait_hpd_asserted() do,
> and report the connector status as unknown if the device cannot be
> resumed.
> 
> Fixes: 2b77a2918c5d ("drm: bridge: analogix/dp: move hpd detect to connector detect function")
> Closes: https://sashiko.dev/#/bug/linux-ea09d64b-12cd-4301-bd54-12c515b01bde
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Changelog:
> v2:
> - removed pm_runtime_mark_last_busy(), as it is not included in
>   pm_runtime_put_autosuspend()
> 
> v1: https://lore.kernel.org/all/20261119092857.1158971-1-m.szyprowski@samsung.com/
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 84951413012b..664ee46c8e53 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -905,9 +905,14 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
>  	if (dp->plat_data->next_bridge)
>  		return connector_status_connected;
>  
> +	if (pm_runtime_resume_and_get(dp->dev) < 0)
> +		return connector_status_unknown;
> +
>  	if (!analogix_dp_detect_hpd(dp))
>  		status = connector_status_connected;
>  
> +	pm_runtime_put_autosuspend(dp->dev);
> +
>  	return status;
>  }
>  
> -- 
> 2.43.0
> 
