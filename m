Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE636C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E5610E619;
	Fri,  3 Jul 2026 15:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QtzHmoly";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C49210E61A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:58:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id EFD24C49F5B;
 Fri,  3 Jul 2026 15:58:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1F9BC60300;
 Fri,  3 Jul 2026 15:58:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 59DA3104C952E; 
 Fri,  3 Jul 2026 17:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1783094286; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=/WKH+lT58py4xpaLk2fj4McpVKws6bBFfINblnSlJTI=;
 b=QtzHmolyfyGQYx62sAhllBtMGeXq+Sa9c8tAzrYvtgjZJChcCo3bitpCO+PxeAbXbLXSjy
 UnqX+fWfGi5jr2lB0gD8hjkuWCelk2f309LQYDxxMZYx/Z6dIeKvfszv9TN2tAvWZ6+AEB
 22KJB1YxFmzvYy9ElaMeJjnmQuFzOT3GFseMIHtof5hc+UHGQ4TN4EbdWLEGrGvNlSLm0w
 EHeFgVX2rZER9nHXWvzaV5jw1I6k121qaJaZiLLiElfJRSh96UrTKNCbpKX7pv+jF5iy29
 DoeZp01S3qd7tttKH/bC5XEZLv9Md3nHXtKo8v9JcxhPGsA6gF1V4IccxDeFRw==
Message-ID: <c1b622b2-3d47-4b93-8c1c-92eeb991bda8@bootlin.com>
Date: Fri, 3 Jul 2026 17:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/bridge: samsung-dsim: fix wording in comment
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260701-drm-fix-graph-wording-v1-0-295605c5777b@bootlin.com>
 <20260701-drm-fix-graph-wording-v1-2-295605c5777b@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260701-drm-fix-graph-wording-v1-2-295605c5777b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 7/1/26 19:19, Luca Ceresoli wrote:
> Fix a comment according to English grammar.
> 
> Link: https://lore.kernel.org/all/DI9ZFQUNMSBU.214AU8467OK76@bootlin.com/
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/bridge/samsung-dsim.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 5788066d479e..25ab475309e8 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1919,7 +1919,7 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
>   	/*
>   	 * of_graph_get_remote_node() produces a noisy error message if port
>   	 * node isn't found and the absence of the port is a legit case here,
> -	 * so at first we silently check whether graph presents in the
> +	 * so at first we silently check whether a graph is present in the
>   	 * device-tree node.
>   	 */
>   	if (!of_graph_is_present(np))
> 

