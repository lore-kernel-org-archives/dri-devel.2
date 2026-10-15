Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5557CCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B938A112311;
	Thu, 15 Oct 2026 11:25:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E44112327
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:25:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF7C143C83;
 Thu, 15 Oct 2026 11:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9207F1F000C4;
 Thu, 15 Oct 2026 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792063519;
 bh=Cuj0erEhvhKBpe4TYEcQbqkKDN3J/7Y5BkvZDDosCPg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JvGYv8YQVMNXcOJ9K2iC4z04OvA2fF7cS2eJkv7A65oomJUoJ/T2G+C+e1disc56P
 iWARMBC4d2plf0Uhf2tptXzU8n1dee8HeMm3P9JNihPt3/kJJTZ2P4hmnzYpBqMXZI
 PbIqY4PowLYecuqllFUs0MVOTmg20UuzFLGoeoQ+rFXAmQBcKliXuoIcbzPgaece2w
 Vtp4lNx1ih3YLdy/54qsOVxHa3w6+6UYGVprw1rFvtccTopZLG31un1faTp1zFQJEt
 nbNU7QT9O8uXFcL0nu38DSo4tfmDjICA5KBD5qkZeQ5itnEER/mxlRF/tvh3rZckbF
 aDqW8bUKsRtNA==
Message-ID: <sashiko-outbox-172742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/13] drm/bridge: tc358762: Improve DPI enable handling
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-tc358762-fixes-v5-6-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
 <20261015-tc358762-fixes-v5-6-7cd721a6451b@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 11:25:19 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/bridge: tc358762: Error state leak in post_disable breaks next=
 enable
--

commit d2e59cf65b7853d5bbc77858afb718b43405bd7b
Author: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

drm/bridge: tc358762: Improve DPI enable handling

This commit clears the DPIENABLE bit at the start of display enablement to
avoid temporary wrong timings, and sets it later with the rest of the LCDCT=
RL
configuration. It also explicitly disables DPIENABLE when disabling the bri=
dge.

> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/t=
c358762.c
> index 91bc79d36a744..19f328b6e7980 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c

[ ... ]

> @@ -185,6 +191,9 @@ static void tc358762_post_disable(struct drm_bridge *=
bridge,
> =20
>  	ctx->pre_enabled =3D false;
> =20
> +	/* Turn off the DPI output */
> +	tc358762_write(ctx, LCDCTRL, 0);
> +

[Severity: High]
Can this leak an error state that breaks the next enable cycle?

If this newly added tc358762_write() fails during the post_disable phase
(for example, due to a transient DSI timeout or host teardown state), it
will set ctx->error to a negative error code.

Unlike the initialization path which calls tc358762_clear_error(),
tc358762_post_disable() does not clear ctx->error.

When the display is later re-enabled, all subsequent hardware configuration
writes in tc358762_init() will be silently skipped because tc358762_write()
checks this cached error state:

tc358762_write() {
        if (ctx->error)
                return;
        ...
}

Will this leave the hardware uninitialized and the display persistently
broken until the module is reloaded?

>  	if (ctx->reset_gpio)
>  		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-tc358762-f=
ixes-v5-0-7cd721a6451b@ideasonboard.com?part=3D6
