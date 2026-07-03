Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1703DC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BD410E61A;
	Fri,  3 Jul 2026 15:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="eS3wGwa9";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15B810E61A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:58:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DD2F5C49F5B;
 Fri,  3 Jul 2026 15:58:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0D2E160300;
 Fri,  3 Jul 2026 15:58:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9848F104C958F; 
 Fri,  3 Jul 2026 17:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1783094320; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ooyxgHg++j3jR3klxefyRfbJSQqXr4m9CeLrEFkWbz0=;
 b=eS3wGwa9zU3gDU/lXwM2qPcUvQLYXpYiBYDE+UPK6aKlAvF2s/oV2ehycII6xa0K4Olh79
 Nf9RuxQe7sYK7+DCrvN4IxksKCce0klj0Nm5XHaqwla1OFVBlkndqZuBJs8GokGhToNJmt
 IwHMpqNDfhJ/XYF0IlnJFhDFiuccjXto1u7zArETrIko7q1qU5FOLqhZs8uRCwkyRWIYnx
 HPb4irvDltt/pNoNpbeJdRHwH8+S4cQcEZoQRcnL2MfXZ9k5w+i5UfBQ6XUrlJwzroprgn
 PT5sq4VSHegQ+a5gaa2qXcYUmE1ZZ26Pq+6GTXbbLn6fhejPFz8CMYZC3aPllA==
Message-ID: <0a1f1719-9d04-4273-bc84-e9b0a7588610@bootlin.com>
Date: Fri, 3 Jul 2026 17:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/bridge: fix wording in comment
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
 <20260701-drm-fix-graph-wording-v1-3-295605c5777b@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260701-drm-fix-graph-wording-v1-3-295605c5777b@bootlin.com>
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
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/drm_bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 6ead9b75ae3d..38afa3bc2b7c 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1717,7 +1717,7 @@ struct drm_bridge *of_drm_get_bridge_by_endpoint(const struct device_node *np,
>   	/*
>   	 * of_graph_get_remote_node() produces a noisy error message if port
>   	 * node isn't found and the absence of the port is a legit case here,
> -	 * so at first we silently check whether graph is present in the
> +	 * so at first we silently check whether a graph is present in the
>   	 * device-tree node.
>   	 */
>   	if (!of_graph_is_present(np))
> 

