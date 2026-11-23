Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF4606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=W6pxzYb0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EB710E7D7;
	Mon, 23 Nov 2026 13:56:54 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC7610E7D4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:56:47 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5830E177;
 Mon, 23 Nov 2026 14:54:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795442054;
 bh=lSv+S7dvrshwj/tW2HBSMnkfiXxF4p953ex8rK58vVU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W6pxzYb0wQcX9D9ZYB5CMV7cZUDlB6PElnfx+xRjCKfYTTw8W8XLPVeW5BRaRkYTC
 SrfSJuqzRzaZd+Im7TwC9RpuCJRjst/d3y4Z9GkNKGqjsc7WCSH2Y4ywvL35vta0l3
 M9BuLbEnMCf4QkJK+/JbnwXDmuf2aIhwUfabeYU8=
Message-ID: <7dd150ca-4fcf-434c-bed2-2aac3a290d48@ideasonboard.com>
Date: Mon, 23 Nov 2026 15:56:41 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/42] drm/atomic: Add
 drm_atomic_get_connector_for_encoder_locked()
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
 <20261120-drm-state-readout-v9-1-a67c2b45b8ec@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261120-drm-state-readout-v9-1-a67c2b45b8ec@kernel.org>
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
> drm_atomic_get_connector_for_encoder() takes the connection mutex
> through the acquire context it is given, looks up the connector routed
> to an encoder, and releases the mutex before returning.
> 
> However, callers that need to look at the state of the connector they
> just found have to take the connection mutex again afterwards, which
> leaves a window where a concurrent commit can re-route the connector.
> And if the caller already held the connection mutex through the same
> acquire context, drm_atomic_get_connector_for_encoder() releases it
> from under it.
> 
> Split the lookup into drm_atomic_get_connector_for_encoder_locked(),
> which expects the caller to hold the connection mutex, and make
> drm_atomic_get_connector_for_encoder() a wrapper around it that takes
> and releases the mutex.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_atomic.c | 57 ++++++++++++++++++++++++++++++++++----------
>   include/drm/drm_atomic.h     |  2 ++
>   2 files changed, 46 insertions(+), 13 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

