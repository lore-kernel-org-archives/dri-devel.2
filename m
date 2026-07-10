Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5EFC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D369E10E14C;
	Fri, 10 Jul 2026 07:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bWqJlWnx";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6149810E14C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:59:21 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gxPP21FFwz8v1b;
 Fri, 10 Jul 2026 09:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783670358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=onM4s65g1/+YaVMTyhiYHj+x13XGWY4LnTNzdWSettQ=;
 b=bWqJlWnxjHUmdQhVHeOaNCrieNLhiJeJd8SptZ3FxJ73WReMUC6at6IyRfls8bsitSJrWj
 EnWgiUOp+wuFf4iPYt8VjvSzw1Zw78pgnQCiXiKF7h0sU2euC1XeyFLnhE956PM7xuJXSA
 B0DBvCn2n8kPiZD3vR/P45PjJjibtRTgWNmTe9bTLd6jnSxd2WtDpUn3q/qD7KHg2wiZ55
 BKQL/UhZGYRuL63s5SLscsndsP3a4s+/Q8jWFxn77r6S9+q0RO80bBAtv3R1UJxEni/nmn
 FtILmiXd6582ryaDReV+B3LIz+Deustf9DKOrgsMGp97czqwoUlPleTy5mdcJA==
Message-ID: <67f97b1b-0ea0-4b23-bee8-1a5b5a3e7ea1@mailbox.org>
Date: Fri, 10 Jul 2026 09:59:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] drm/atomic: Clear plane pipeline for legacy clients
To: Robert Mader <robert.mader@collabora.com>, dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>, Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Jonas_=C3=85dahl?=
 <jadahl@redhat.com>, Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>,
 Victoria Brekenfeld <victoria@system76.com>, Xaver Hugl
 <xaver.hugl@kde.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20260709115855.53725-1-robert.mader@collabora.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260709115855.53725-1-robert.mader@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ae872851820d238e1ff
X-MBO-RS-META: dxddxprihhpddykbn78878skk6mfrxpc
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

On 7/9/26 13:58, Robert Mader wrote:
> Clients that do not enable DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE and try to
> apply a new plane state currently have no way to unset/reset an existing
> non-bypass color pipeline, resulting in unexpected behavior.
> 
> As we can be sure that such clients do not expect plane pipelines to be
> set, let's reset the later for them, ensuring clean bypass-only pipeline
> states.
> 
> This is a less comprehensive but more backward compatible approach compared
> to a DRM_MODE_ATOMIC_RESET flag (link) that is currently being discussed.
> Considering the simplicity and clearly defined behavior of this case,
> this change could serve as an additional stop-gap solution to smoothen the
> transition to the new APIs, resulting in less breakage on systems with
> existing clients.
> 
> Link: https://lore.kernel.org/all/CAFZQkGzw2MZGivy=oyYgZE3_dmxu-z-NbDgzh9uyqSsj=MG=2w@mail.gmail.com/
> 
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> 
> ---
> 
> If an approach like this was previously rejected or clearly goes against
> API rules (or is unacceptable for other reason), please excuse me (and
> just let me know).
> 
> The main motivation for the patch came up during testing the Weston
> implementation (link) for the fixed-matrix color-ops. The test there checks
> both the color pipeline and legacy property ways of offloading YCbCr
> buffers and the current reset-less situation results in the legacy one
> failing once the color pipeline test ran before.
> 
> Link: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133
> ---
>  drivers/gpu/drm/drm_atomic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 735ab7badc2e..581fde90dbd8 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -656,6 +656,9 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
>  	state->planes[index].new_state = plane_state;
>  	plane_state->state = state;
>  
> +	if (!state->plane_color_pipeline)
> +		plane_state->color_pipeline = NULL;
> +
>  	drm_dbg_atomic(plane->dev, "Added [PLANE:%d:%s] %p state to %p\n",
>  		       plane->base.id, plane->name, plane_state, state);
>  

Is drm_atomic_get_plane_state always called for all planes which might have a color pipeline enabled?

If yes, this looks reasonable.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
