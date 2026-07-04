Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED708C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A70010E4FE;
	Sat,  4 Jul 2026 18:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fg8xaPGo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41EF10E2DD
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:46:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A569843B0E;
 Sat,  4 Jul 2026 18:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466FA1F000E9;
 Sat,  4 Jul 2026 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783190775;
 bh=5HXqkSW29JaZVgyrTFhzMaXxBlqTxurfjzN1jA6Xyik=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fg8xaPGoOyIH03RpV+tWgNl2+qHi70k9qwuwnRCcDkPGmgAfk6+zloUm7FDBkKQ2r
 yv2IdsWOiO1N5MOpCXRxjMXp5jYQHHvtTq/MAWaafDDhxefbUuohITj6WSDilZk1mk
 Iz9J+7Rgo/F4FhstjYD6L3jAaL7yc5YQkcTpKymBJDpnalaaL5vdtqZoJgg6V5760j
 utHCYdlkFPYDK20ZLyY7QELf7C11LCqi6FbvYmHKjRE1KPH8Xa+PksPwkb3TrsfJEI
 8FPJtnGECqJlwO1rM9pE0R9jBtsrJzEDsxbmi8CjsBnXtxQyTmkq+GwbnFHpWP/l2Y
 nHYMtmVd5LwoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] drm/tve200: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260705-drm-simple-kms-removal-v1-8-b4e1ca053623@oss.qualcomm.com>
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-8-b4e1ca053623@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:46:14 +0000
Message-Id: <20260704184615.466FA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Vblank event is leaked on CRTC disable and may be delivered premat=
urely on CRTC enable.
- [Medium] Calling `drm_connector_attach_encoder()` on an uninitialized con=
nector.

Pre-existing issues:
- [High] Calling `usleep_range()` from a CRTC `atomic_enable` callback.
- [High] Direct, lockless access to global state pointers `plane->state` an=
d `crtc->state` in atomic commit callbacks.
--

Note: The format of this review has been altered to a free-form summary due
to mailing list quoting restrictions.

Commit: 2c5e6508a64461d7a207075c4328681142076aef
Author: Ze Huang <ze.huang@oss.qualcomm.com>
Subject: drm/tve200: replace struct drm_simple_display_pipe with regular at=
omic helpers
Summary: This commit converts the TVE200 driver to use explicit plane, CRTC,
and encoder objects instead of the simple display pipe helpers, while keepi=
ng
generic plane-state validation and GEM framebuffer preparation.

[Severity: High]
In drivers/gpu/drm/tve200/tve200_display.c,
tve200_plane_helper_atomic_update() checks if the CRTC is NULL and returns
early. Does this cause the pending vblank event to be leaked during a CRTC
disable, since the plane is also disabled (making crtc NULL) and the event
is never consumed?

Additionally, since commit_planes() executes before commit_modeset_enables(=
),
is the event processed and delivered prematurely on CRTC enable? Could the
event consumption be moved to CRTC callbacks like atomic_enable,
atomic_disable, or atomic_flush instead of handling it in the plane callbac=
k?

[Severity: Medium]
In drivers/gpu/drm/tve200/tve200_drv.c, tve200_modeset_init() gets the
connector using drm_panel_bridge_connector() and immediately passes it to
drm_connector_attach_encoder(). Since drm_bridge_attach() has not run yet,
is this modifying an uninitialized DRM object structure?

Would it be better to rely on panel_bridge_attach(), which already
automatically handles attaching the connector to the encoder, making this
manual call redundant?

[Severity: High]
This isn't a bug introduced by this patch, but in
drivers/gpu/drm/tve200/tve200_display.c, tve200_crtc_helper_atomic_enable()
contains a hardware polling loop that calls usleep_range(30000, 50000).
Since CRTC atomic enable callbacks run in atomic context during non-blocking
commits where sleeping is strictly forbidden, can this cause kernel warnings
or deadlocks? Should this be replaced with non-sleeping delay functions like
udelay or ndelay?

[Severity: High]
This is a pre-existing issue, but it appears to be expanded here. In
drivers/gpu/drm/tve200/tve200_display.c, tve200_plane_helper_atomic_update()
and tve200_crtc_helper_atomic_enable() directly access the global state
pointers plane->state and priv->plane.state.

In non-blocking commits, these global pointers can be swapped if userspace
submits a concurrent commit. Does this create a TOCTOU race where a
concurrent commit setting the framebuffer to NULL could lead to a NULL
pointer dereference when accessing fb->format->format? Should this code use
the proper drm_atomic_get_new_plane_state() (or equivalent) accessors on the
passed state object instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-drm-simple=
-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com?part=3D8
