Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2D8C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB6F10E449;
	Mon,  7 Sep 2026 11:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UtvEV5kv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D662E10E449
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:44:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91FBE43B7C;
 Mon,  7 Sep 2026 11:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BAD1F00A3A;
 Mon,  7 Sep 2026 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788781463;
 bh=sM4lSu7cB41BQoJVxOJqyVmLHf6Zpp1jZjVwr5O9LjQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UtvEV5kvK/qjVTdoJZIfVpFKDLMLf7a1VEd3IWIuEHmsECjnHRcCK1SNcLe5njNpO
 dmfGkJphB3UQdkR5Qdb4xnzI3bAHNeOp1YJge8kI7dDoLddOZ7sfblk1oac2IERdHt
 yL5LI3rl0j2zJaWrmr9tlAbY4UhYGluhdmCmVVNVX5YjXYQy0vi6ykxweNziQlVIsM
 T7ZrGDWF2FhQIQfC8fjdcq1WnTqccIA34rU2Lq6EByRaKpmHU7FbRGiwoBvDm2Ot8M
 OkLIOwXRZ/HUsaQZR50H2oPEeL5pU+K78WqAyIV3rx1nt9b8yWrz6lYJKx+CLAfVCn
 XP+rDFgoYQq4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/13] drm/bridge: tc358762: Set DE_POL and DCLK_POL
 properly
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-tc358762-fixes-v4-12-e3fc3ab5cd83@ideasonboard.com>
References: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
 <20260907-tc358762-fixes-v4-12-e3fc3ab5cd83@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:44:22 +0000
Message-Id: <20260907114423.49BAD1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Sleeping function msleep() is called in an atomic context path (br=
idge enable callback).
--

commit 12b0c322f22c1997a91fce2069aabdcb2f3f31cf
Author: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

drm/bridge: tc358762: Set DE_POL and DCLK_POL properly

This commit updates the tc358762 bridge driver to dynamically set the
LCDCTRL_DCLK_POL and LCDCTRL_DE_POL polarities. Instead of hardcoding these
values, it now reads them from the output bus configuration flags to match
the panel's requirements.

> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/t=
c358762.c
> index ad3a2620ce476..25b719cd66fec 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -186,12 +186,15 @@ static void tc358762_enable(struct drm_bridge *brid=
ge,
>  {
>  	struct tc358762 *ctx =3D bridge_to_tc358762(bridge);
>  	struct drm_connector_state *conn_state;
> +	struct drm_bridge_state *bridge_state;

[Severity: High]
This isn't a bug introduced by this patch, but does this function sleep in
atomic context?

Looking at tc358762_enable() in drivers/gpu/drm/bridge/tc358762.c, there are
two instances where msleep() is called:

drivers/gpu/drm/bridge/tc358762.c:tc358762_enable() {
    ...
    tc358762_write(ctx, SYSCTRL,
                   FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4=
MA) |
                   FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA=
) |
                   FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3));

    msleep(100);
    ...
    tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);
    tc358762_write(ctx, DSI_STARTDSI, DSI_STARTDSI_STARTDSI);

    msleep(100);
    ...
}

This function is registered as the bridge's atomic enable callback. Accordi=
ng
to DRM subsystem guidelines, encoder and bridge atomic enable callbacks run=
 in
atomic context during non-blocking commits where sleeping is forbidden.

Can calling msleep() from this atomic context cause kernel warnings, system
instability, or potential deadlocks when the display pipeline is enabled?

>  	struct drm_crtc_state *crtc_state;
>  	struct drm_connector *connector;
>  	struct drm_display_mode *mode;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-tc358762-f=
ixes-v4-0-e3fc3ab5cd83@ideasonboard.com?part=3D12
