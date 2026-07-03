Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B90C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459C410E62C;
	Fri,  3 Jul 2026 15:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rFltoTdZ";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F74D10E62C
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:59:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 219564E40C6E;
 Fri,  3 Jul 2026 15:59:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E9C2860300;
 Fri,  3 Jul 2026 15:59:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 49986104C94EF; 
 Fri,  3 Jul 2026 17:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1783094378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=UAkYp7gR6GAcUen6AlxpDy3Nj/vEGnp3F2Wlq67o3bQ=;
 b=rFltoTdZgqbm2HJwiltf2Qo4lOebH3TEUCPNI0qhVAfkF2o2kikVDblkVeFTka6wzSnEwI
 ni3WiyK9ENgA8ZCvJvXJuRAPNA+cLx6jrt9MNHrD0ftxgm2kfaMaCt84u6DzfrK4pWqeIO
 LK+mpqeT+zImhp/SilEKb2YkRpPCEN13UZfas0EDrzjystPweMJNLBJ8+RJMEcU4U+oGGh
 GDbwJsKvI2gxGUb01miTgK4jlYstf0f/S9waU/cm8LZpVGw6fGE/DinjmecDvINgvtYREV
 2UvMofpXIYfXZjw2SxDJ88PYYMvcQ7yrLIgh7WZTZ2dTOruowAzieXgCnVi5Pw==
Message-ID: <71806ff3-e8e8-487a-b90c-39b3239866ec@bootlin.com>
Date: Fri, 3 Jul 2026 17:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/bridge: rename
 drm_for_each_bridge_in_chain_scoped() to drm_for_each_bridge_in_chain()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Miguel Ojeda
 <ojeda@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 llvm@lists.linux.dev
References: <20260630-drm-bridge-alloc-getput-for_each_bridge-2-v2-1-e0a1094cd1eb@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260630-drm-bridge-alloc-getput-for_each_bridge-2-v2-1-e0a1094cd1eb@bootlin.com>
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



On 6/30/26 17:34, Luca Ceresoli wrote:
> drm_for_each_bridge_in_chain_scoped() was added in commit e46efc6a7d28
> ("drm/bridge: add drm_for_each_bridge_in_chain_scoped()") to provide a
> safer alternative to drm_for_each_bridge_in_chain().
> 
> Following commits converted all users to the _scoped variant.
> 
> Finally commit 2f08387a444c ("drm/bridge: remove
> drm_for_each_bridge_in_chain()") removed the old
> drm_for_each_bridge_in_chain() macro.
> 
> It's time to rename drm_for_each_bridge_in_chain_scoped() back to the
> original name.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> Changes in v2:
> - Rebased on drm-misc-next, fixed conflicts, renamed new occurrences
> - Link to v1: https://lore.kernel.org/r/20251223-drm-bridge-alloc-getput-for_each_bridge-2-v1-1-0362434ae0eb@bootlin.com
> ---
>   .clang-format                                  |  2 +-
>   drivers/gpu/drm/display/drm_bridge_connector.c |  4 ++--
>   drivers/gpu/drm/drm_atomic.c                   |  2 +-
>   drivers/gpu/drm/drm_bridge.c                   |  2 +-
>   drivers/gpu/drm/tests/drm_bridge_test.c        |  2 +-
>   include/drm/drm_bridge.h                       | 11 +++++------
>   6 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/.clang-format b/.clang-format
> index 6a3de86ab27a..5ef5743b77c9 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -167,7 +167,7 @@ ForEachMacros:
>     - 'drm_connector_for_each_possible_encoder'
>     - 'drm_exec_for_each_locked_object'
>     - 'drm_exec_for_each_locked_object_reverse'
> -  - 'drm_for_each_bridge_in_chain_scoped'
> +  - 'drm_for_each_bridge_in_chain'
>     - 'drm_for_each_connector_iter'
>     - 'drm_for_each_crtc'
>     - 'drm_for_each_crtc_reverse'
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 92f8a2d7aab4..8b54069fa53a 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -147,7 +147,7 @@ static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
>   		to_drm_bridge_connector(connector);
>   
>   	/* Notify all bridges in the pipeline of hotplug events. */
> -	drm_for_each_bridge_in_chain_scoped(bridge_connector->encoder, bridge) {
> +	drm_for_each_bridge_in_chain(bridge_connector->encoder, bridge) {
>   		if (bridge->funcs->hpd_notify)
>   			bridge->funcs->hpd_notify(bridge, connector, status);
>   	}
> @@ -854,7 +854,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>   	 * detection are available, we don't support hotplug detection at all.
>   	 */
>   	connector_type = DRM_MODE_CONNECTOR_Unknown;
> -	drm_for_each_bridge_in_chain_scoped(encoder, bridge) {
> +	drm_for_each_bridge_in_chain(encoder, bridge) {
>   		if (!bridge->interlace_allowed)
>   			connector->interlace_allowed = false;
>   		if (!bridge->ycbcr_420_allowed)
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 735ab7badc2e..e5c8ef06caed 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1554,7 +1554,7 @@ drm_atomic_add_encoder_bridges(struct drm_atomic_commit *state,
>   		       "Adding all bridges for [encoder:%d:%s] to %p\n",
>   		       encoder->base.id, encoder->name, state);
>   
> -	drm_for_each_bridge_in_chain_scoped(encoder, bridge) {
> +	drm_for_each_bridge_in_chain(encoder, bridge) {
>   		/* Skip bridges that don't implement the atomic state hooks. */
>   		if (!bridge->funcs->atomic_duplicate_state)
>   			continue;
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 6ead9b75ae3d..dfab82923c85 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1817,7 +1817,7 @@ static int encoder_bridges_show(struct seq_file *m, void *data)
>   	struct drm_printer p = drm_seq_file_printer(m);
>   	unsigned int idx = 0;
>   
> -	drm_for_each_bridge_in_chain_scoped(encoder, bridge)
> +	drm_for_each_bridge_in_chain(encoder, bridge)
>   		drm_bridge_debugfs_show_bridge(&p, bridge, idx++, false, true);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
> index 10a32620e962..430d9bc67a10 100644
> --- a/drivers/gpu/drm/tests/drm_bridge_test.c
> +++ b/drivers/gpu/drm/tests/drm_bridge_test.c
> @@ -1071,7 +1071,7 @@ static void drm_test_bridge_chain_verify_fmt(struct kunit *test,
>   	struct drm_bridge_state *bstate;
>   	unsigned int i = 0;
>   
> -	drm_for_each_bridge_in_chain_scoped(&priv->encoder, bridge) {
> +	drm_for_each_bridge_in_chain(&priv->encoder, bridge) {
>   		KUNIT_ASSERT_LT(test, i, num_expected);
>   
>   		bstate = drm_bridge_get_current_state(bridge);
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 18f3db367dc1..0fadc39dfc12 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1474,9 +1474,9 @@ static inline struct drm_bridge *__drm_for_each_bridge_in_chain_next(struct drm_
>   DEFINE_FREE(__drm_for_each_bridge_in_chain_cleanup, struct drm_bridge *,
>   	if (_T) { mutex_unlock(&_T->encoder->bridge_chain_mutex); drm_bridge_put(_T); })
>   
> -/* Internal to drm_for_each_bridge_in_chain_scoped() */
> +/* Internal to drm_for_each_bridge_in_chain() */
>   static inline struct drm_bridge *
> -__drm_for_each_bridge_in_chain_scoped_start(struct drm_encoder *encoder)
> +__drm_for_each_bridge_in_chain_start(struct drm_encoder *encoder)
>   {
>   	mutex_lock(&encoder->bridge_chain_mutex);
>   
> @@ -1489,8 +1489,7 @@ __drm_for_each_bridge_in_chain_scoped_start(struct drm_encoder *encoder)
>   }
>   
>   /**
> - * drm_for_each_bridge_in_chain_scoped - iterate over all bridges attached
> - *                                       to an encoder
> + * drm_for_each_bridge_in_chain - iterate over all bridges attached to an encoder
>    * @encoder: the encoder to iterate bridges on
>    * @bridge: a bridge pointer updated to point to the current bridge at each
>    *	    iteration
> @@ -1500,9 +1499,9 @@ __drm_for_each_bridge_in_chain_scoped_start(struct drm_encoder *encoder)
>    * Automatically gets/puts the bridge reference while iterating and locks
>    * the encoder chain mutex to prevent chain modifications while iterating.
>    */
> -#define drm_for_each_bridge_in_chain_scoped(encoder, bridge)				\
> +#define drm_for_each_bridge_in_chain(encoder, bridge)					\
>   	for (struct drm_bridge *bridge __free(__drm_for_each_bridge_in_chain_cleanup) =	\
> -		__drm_for_each_bridge_in_chain_scoped_start((encoder));			\
> +		__drm_for_each_bridge_in_chain_start((encoder));			\
>   	     bridge;									\
>   	     bridge = __drm_for_each_bridge_in_chain_next(bridge))			\
>   
> 
> ---
> base-commit: 377939b713ca89de92573e3f3662b805fecc95d5
> change-id: 20251223-drm-bridge-alloc-getput-for_each_bridge-2-2318aa93b69e
> 
> Best regards,
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

