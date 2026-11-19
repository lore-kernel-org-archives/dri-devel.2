Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78D606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cjdKV5xa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC62710E249;
	Thu, 19 Nov 2026 18:02:56 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 533A71126C0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 18:02:51 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-381d542bc29so4703806eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795111370; x=1795716170;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0Pvdm5Aw2zCQXg3IWojN/p2DCIkq0Hpf5B2LHKgHVBE=;
 b=cjdKV5xaIVj49RRy8y7/iXINKkR3o4piN8JLWpZBwV3vtYR57UpaGO/OoZavajAmxq
 3ovNIJdjn3J8H57VPYT/0+WIz0n9zZWNgAIiEATZNM7yMqFUkKDBe5U7mwUo7Z99/nRI
 eIRTSKTLvBKR7gUunMNODyVtZhtQir9ZRVwL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795111370; x=1795716170;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Pvdm5Aw2zCQXg3IWojN/p2DCIkq0Hpf5B2LHKgHVBE=;
 b=xLqd4NVaL//3JhQvLTKujsM780GQ+ZbsU8ZYjJLaxYuPWIna7ByAJHtGrcryZEwfDm
 iiOyC7+mix74kFiza6MdLXji3/YH745fDCf52Wd7x7vcsI9qLNyzgJwyyAlW3V+06XAC
 qmXKNGgle5adBud/hLJALq4AEw5/izrRyUqbJzUHSh0oTnlSvG5VCDXgmZVzPLGKo4Sl
 N3huBzJdwWE6uNa0FAeXGGfQyA6Q2Vni2bQNnRoY/+pQcDnVT9LCN8sAS9wgaD/1M45U
 jiMrhcHx73KmbCSb5wUPPrKtZ5WfPOxwppTNP41MeihffbhAAso2uGEvwAeFmadU+gC6
 Q0fA==
X-Gm-Message-State: APuU4Z9K8VylpjpMQYF+OYraUslCBVFf1c4E9SXLx1Jygs9LDQIIqwvO
 vtIsmw5VFjH02OPCtAcp+Nk+ZWwOrtENTw8NIQ5Fpak4eAuhP8CP3xasPXfpIOYRlg==
X-Gm-Gg: AZFdTZfUbywddthD5V7PdqEcWzcO+Pi7Ht24ptlQWxcy0Y/o40a57i3bXNrZphmxz5p
 2A1dUFAQPL1Yu+KsZ3hMzQjA75ZsRaqpn2n5IxfkLNyyvZarwBlSoB3vEPrveA6CDVwWT3nGasW
 Mn00vhF3fsGsOglqXTHSithXwNZcWcr1XouKoy7hxPbSN7wdlZlSslXlRIIrry0TYvErbUFTEiv
 czUcxnDMU6NRxxv1nZEzpZm8jbSjG+HFrvtzZkgWAv6ek2R4AbGtzpiNiWrvv9+gVsG7wtJvT5W
 8ygKFYcH+ZZb7Q/MTXB61rd6b2Zyb7jIzmllFORykG3okl2QPxExkdbLSIZjkjCN+F6SMmac5NW
 QvvlGiCBJPB5i6ySOmfnv560M3O8/x2NATWtbd1Z3CPILvnQZCKEXpOAhofQ3a25qSsK6+aFeXn
 aAckkeMNhfkTL8seS8S58/CXqB5fr4oswSdlhLBMBFvWMxMft3RRFRyH7XWFCc3awlCNzeo2dCv
 8tZB8DNXeqF4+7DmMJV7t0hEvWWEfq3KGnulVFG++KHBMqg2FdzLaNbfI/2Luklin+WuLB+vWDa
 uf5KrGrWmVaUHLl2nbJkt0UFddqgJQUJeBHbNRqkBahYP4J1K0nd+N0ctWZJgK5vpWxa
X-Received: by 2002:a05:7301:4704:b0:383:729:cabe with SMTP id
 5a478bee46e88-3856f8519ecmr116848eec.19.1795111370528; 
 Thu, 19 Nov 2026 10:02:50 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:bdc0:a95f:45fc:7172])
 by smtp.gmail.com with UTF8SMTPSA id
 5a478bee46e88-38567ea2cc5sm497577eec.29.2026.11.19.10.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 10:02:49 -0800 (PST)
Date: Thu, 19 Nov 2026 10:02:47 -0800
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
Subject: Re: [PATCH] drm/bridge: analogix_dp: Fix runtime PM reference leak
 in set_bridge
Message-ID: <av85x_6VV1qcsUgh@google.com>
References: <CGME20261119093353eucas1p1de9688c7e1847ae8266690934b09f925@eucas1p1.samsung.com>
 <20261119093347.1159198-1-m.szyprowski@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119093347.1159198-1-m.szyprowski@samsung.com>
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

On Thu, Nov 19, 2026 at 10:33:46AM +0100, Marek Szyprowski wrote:
> analogix_dp_set_bridge() takes a runtime PM reference at the beginning,
> but returns directly without dropping it when
> analogix_dp_init_analog_func() fails. Jump to the common error path
> instead, which drops the reference.
> 
> Fixes: 3efe2ace7f5b ("drm/bridge: analogix_dp: move basic controller init into runtime PM")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 022acb962b7c..84951413012b 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -998,7 +998,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>  
>  	ret = analogix_dp_init_analog_func(dp);

This function never fails, in fact. So this patch is just an academic
exercise.

Personally, I'd prefer you just make analogix_dp_init_analog_func()
return void, to simplify things.

Brian

>  	if (ret)
> -		return ret;
> +		goto out_dp_init;
>  
>  	/*
>  	 * According to DP spec v1.3 chap 3.5.1.2 Link Training,
> -- 
> 2.43.0
> 
