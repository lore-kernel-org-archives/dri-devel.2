Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E1EC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8607510E56C;
	Fri, 14 Aug 2026 14:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ONNh+Lys";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4213410E55D
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:25:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 141BA41246;
 Fri, 14 Aug 2026 14:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06CC1F000E9;
 Fri, 14 Aug 2026 14:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786717512;
 bh=jxJjQpGONHk3GkAjg4IFA+GKzLQJ8fsZz0zd7hopP/I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ONNh+Lys2uxQ7rJjt5vdSJ3QdCN0iPKmVTPRoWiaXLKMuOfwsCdeOfqQ6NXlHqfEC
 3Vh2MAdpBfsIPe/iXP3yeo81qvj2XD5Wm9rVVaHYM6ORN0o0JqjW/vVR9tnytOci1h
 XfvC484UHfiQ3zDyY0fKixRtd1S/8Cgu1RODSotveYVIKnmc44fJ9jZGuljDZTrCk/
 Ksgc4KhcHxRIvgLp5Wh6IAz+xHESyLU6VhB+XM5sx8R5/ZunIo6JRmXJgxflZ117cp
 Eryl+iEqjb/O2pml2awdh8rC5kIf7vzn0NbHy73LLQSFVvCIzGjF5tDQ/wvG2gzME5
 zXakWboT4Q2qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] drm/bridge: panel: add a panel_bridge to every panel
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-bridge-every-panel-v1-5-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-5-19cd5277cc8d@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:25:11 +0000
Message-Id: <20260814142511.C06CC1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incorrect error check `WARN_ON(!panel->bridge)` masks bridge all=
ocation failures, leading to invalid state.

Pre-existing issues:
- [High] Architectural Use-After-Free on panel memory when the panel unbind=
s.
--

--- Patch [5]: [PATCH 05/11] drm/bridge: panel: add a panel_bridge to every=
 panel ---
commit fe7eeb215d441faca3cc4f0f4f95d9a96a4fb587
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: panel: add a panel_bridge to every panel

Adding a panel does currently not add a panel_bridge wrapping it. Usually
the panel_bridge creation happens later, when some other driver (e.g. the
previous bridge or the encoder) calls *_of_get_bridge() and the following
element in the pipeline is a panel.

[ ... ]

Switch to the new approach: always create a panel_bridge with a drm_panel,
thus matching the lifetime of the drm_panel and the panel_bridge wrapping
it. This makes lifetime much more straightforward to understand and to
further develop on.

[Severity: High]
This is a pre-existing issue, but does the underlying bridge allocation
architecture have a use-after-free risk when panels unbind?

Looking at drm_panel_bridge_add_typed() in drivers/gpu/drm/bridge/panel.c:

struct drm_bridge *drm_panel_bridge_add_typed(...)
{
        ...
        panel_bridge =3D devm_drm_bridge_alloc(panel->dev, struct panel_bri=
dge,
                                             bridge,
                                             &panel_bridge_bridge_funcs);
        ...
}

Since devres automatically frees the bridge memory when the panel unbinds
(e.g., via rmmod), this completely ignores the bridge->refcount kref. For
child-parent topologies like DSI panels where fw_devlink cannot enforce
unbind ordering, couldn't the DSI host remain bound and retain a dangling
pointer to the freed bridge in its chain?

[ ... ]

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f8f6082e637fd..95fc95d1b4b7a 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -453,6 +453,9 @@ void *__devm_drm_panel_alloc(struct device *dev, size=
_t size, size_t offset,
> =20
>  	drm_panel_init(panel, dev, funcs, connector_type);
> =20
> +	panel->bridge =3D devm_drm_panel_bridge_add(dev, panel);
> +	WARN_ON(!panel->bridge);

[Severity: Medium]
Will this check actually catch failures? devm_drm_panel_bridge_add()
returns an ERR_PTR on failure, rather than NULL.

If the allocation fails due to memory pressure or an invalid connector
type, the warning will be silently bypassed since an ERR_PTR evaluates to
true.

The panel driver will then complete allocation successfully but with an
error pointer in panel->bridge, which can cause display controllers to
defer probing indefinitely without any error logs.

Should this use IS_ERR() instead of checking for NULL?

> +
>  	return container;
>  }
>  EXPORT_SYMBOL(__devm_drm_panel_alloc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-bridge=
-every-panel-v1-0-19cd5277cc8d@bootlin.com?part=3D5
