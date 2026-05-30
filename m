Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02820CD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 17:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C8211292F;
	Sat, 30 May 2026 17:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="X7hKiXlH";
	dkim-atps=neutral
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch
 [109.224.244.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E9310E225
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1780161289; x=1780420489;
 bh=ggWnJbhWCZGehn3Jv1Jq/x6Xk3/GMeyz9N7uAmOorjE=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=X7hKiXlHGwvPk7opr2oB7UItClYfz/CcQG4KFBOE90CyLQkp5wTPPP6OVBP4W9kNA
 U1NFTYXByAxq8WTnBooyHdhuzv1KRGG1lteXxdCTJ9R/E4G4wFCc87h5xaVUCXjIQi
 pmYGl/14myKM9/OcQyrLFJ0SdwwqsZwiaT1U6ZH+H34jOO7+wXL0Bgv7iMzaHrUF5N
 XhezxIc4SvzuRLWQPOr/GHWHNSSKFuChhA8b+DJl4rSzTY5KXGXtLX78Mlnboa486d
 Iy9VpCGdYihhtLjSFyvOCdWOniu7KrxT9pMqgaE22ES7x/tSHlWE6YzTTO1nQsKyjI
 cjtSeSxbLDxTA==
Date: Sat, 30 May 2026 17:14:44 +0000
To: dri-devel@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: wayland-devel@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/atomic: introduce PAGE_FLIP_EVENT property
Message-ID: <20260530171422.4615-1-contact@emersion.fr>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: d3f062539c5133c08704b680d01f1a94ee201831
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Currently user-space can only request page-flip events for all CRTCs includ=
ed
in an atomic commit. This is cumbersome with multi-CRTC commits: when movin=
g a
plane from a different CRTC, or when disabling a plane, user-space has no w=
ay
to opt-out of the page-flip events.

Additionally, page-flip events are invalid for already-disable planes, so
user-space needs to add special cases [1]. Libraries cannot add planes to t=
he
commit without risking causing unexpected page-flip events for the
compositor [2]. Figuring out what CRTCs get implicitly included in a commit=
 is
non-trivial [3].

Introduce a new PAGE_FLIP_EVENT CRTC property so that user-space can select
explicitly which CRTCs will get page-flip events. The property is very
similar to IN_FENCE_FD/OUT_FENCE_PTR: it always reads as zero, and 1 can
be written to request an event.

A user-space implementation is available at [4].

[1]: https://github.com/ValveSoftware/gamescope/blob/67fcb3aebae0ae1eb2d1cf=
f60f29e6d9fe1d128f/src/Backends/DRMBackend.cpp#L2897
[2]: https://gitlab.freedesktop.org/emersion/libliftoff/-/merge_requests/85
[3]: https://lore.kernel.org/dri-devel/20250501112945.6448-1-contact@emersi=
on.fr/
[4]: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/5387

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Daniel Stone <daniel@fooishbar.org>
Cc: Michel D=C3=A4nzer <michel.daenzer@mailbox.org>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 17 +++++++++++++++--
 drivers/gpu/drm/drm_crtc.c        |  7 +++++++
 drivers/gpu/drm/drm_mode_config.c |  6 ++++++
 include/drm/drm_crtc.h            |  6 ++++++
 include/drm/drm_mode_config.h     |  4 ++++
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic=
_uapi.c
index 6441b55cc274..21f2b0df4f63 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -466,6 +466,14 @@ static int drm_atomic_crtc_set_property(struct drm_crt=
c *crtc,
 =09=09=09return -EFAULT;
=20
 =09=09set_out_fence_for_crtc(state->state, crtc, fence_ptr);
+=09} else if (property =3D=3D config->prop_page_flip_event) {
+=09=09if (val !=3D 1) {
+=09=09=09drm_dbg_atomic(crtc->dev,
+=09=09=09=09       "[CRTC:%d:%s] PAGE_FLIP_EVENT can only be set to 1",
+=09=09=09=09       crtc->base.id, crtc->name);
+=09=09=09return -EINVAL;
+=09=09}
+=09=09state->page_flip_event_requested =3D val;
 =09} else if (property =3D=3D crtc->scaling_filter_property) {
 =09=09state->scaling_filter =3D val;
 =09} else if (property =3D=3D crtc->sharpness_strength_property) {
@@ -507,6 +515,8 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
 =09=09*val =3D state->background_color;
 =09else if (property =3D=3D config->prop_out_fence_ptr)
 =09=09*val =3D 0;
+=09else if (property =3D=3D config->prop_page_flip_event)
+=09=09*val =3D 0;
 =09else if (property =3D=3D crtc->scaling_filter_property)
 =09=09*val =3D state->scaling_filter;
 =09else if (property =3D=3D crtc->sharpness_strength_property)
@@ -1385,6 +1395,7 @@ static int prepare_signaling(struct drm_device *dev,
 =09struct drm_connector *conn;
 =09struct drm_connector_state *conn_state;
 =09int i, c =3D 0, ret;
+=09bool page_flip_event_requested;
=20
 =09if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY)
 =09=09return 0;
@@ -1392,9 +1403,11 @@ static int prepare_signaling(struct drm_device *dev,
 =09for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
 =09=09s32 __user *fence_ptr;
=20
+=09=09page_flip_event_requested =3D arg->flags & DRM_MODE_PAGE_FLIP_EVENT =
||
+=09=09=09=09=09    crtc_state->page_flip_event_requested;
 =09=09fence_ptr =3D get_out_fence_for_crtc(crtc_state->state, crtc);
=20
-=09=09if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT || fence_ptr) {
+=09=09if (page_flip_event_requested || fence_ptr) {
 =09=09=09struct drm_pending_vblank_event *e;
=20
 =09=09=09e =3D create_vblank_event(crtc, arg->user_data);
@@ -1404,7 +1417,7 @@ static int prepare_signaling(struct drm_device *dev,
 =09=09=09crtc_state->event =3D e;
 =09=09}
=20
-=09=09if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
+=09=09if (page_flip_event_requested) {
 =09=09=09struct drm_pending_vblank_event *e =3D crtc_state->event;
=20
 =09=09=09if (!file_priv)
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 63ead8ba6756..5ad6681bd47c 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -248,6 +248,11 @@ struct dma_fence *drm_crtc_create_fence(struct drm_crt=
c *crtc)
  *=09The sharpness effect takes place post blending on the final composed =
output.
  *=09If the feature is disabled, the content remains same without any shar=
pening effect
  *=09and when this feature is applied, it enhances the clarity of the cont=
ent.
+ * PAGE_FLIP_EVENT:
+ *=09Atomic property for requesting a page-flip event on this CRTC.
+ *
+ *=09The value of this property is an integer value which always reads as
+ *=09zero and can be written with 1 to request the event.
  */
=20
 __printf(6, 0)
@@ -322,6 +327,8 @@ static int __drm_crtc_init_with_planes(struct drm_devic=
e *dev, struct drm_crtc *
 =09=09=09=09=09   config->prop_out_fence_ptr, 0);
 =09=09drm_object_attach_property(&crtc->base,
 =09=09=09=09=09   config->prop_vrr_enabled, 0);
+=09=09drm_object_attach_property(&crtc->base,
+=09=09=09=09=09   config->prop_page_flip_event, 0);
 =09}
=20
 =09return 0;
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_c=
onfig.c
index f432f485a914..688937d2e1ec 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -496,6 +496,12 @@ static int drm_mode_create_standard_properties(struct =
drm_device *dev)
 =09=09return -ENOMEM;
 =09dev->mode_config.prop_out_fence_ptr =3D prop;
=20
+=09prop =3D drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
+=09=09=09"PAGE_FLIP_EVENT", 0, 1);
+=09if (!prop)
+=09=09return -ENOMEM;
+=09dev->mode_config.prop_page_flip_event =3D prop;
+
 =09prop =3D drm_property_create_object(dev, DRM_MODE_PROP_ATOMIC,
 =09=09=09"CRTC_ID", DRM_MODE_OBJECT_CRTC);
 =09if (!prop)
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 152349f973e3..b0f9130d263a 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -311,6 +311,12 @@ struct drm_crtc_state {
 =09 */
 =09bool vrr_enabled;
=20
+=09/**
+=09 * @page_flip_event_requested: indicates whether a page-flip event has
+=09 * been requested on this CRTC.
+=09 */
+=09bool page_flip_event_requested;
+
 =09/**
 =09 * @self_refresh_active:
 =09 *
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index d8f5b7e9673e..13f39677c32f 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -670,6 +670,10 @@ struct drm_mode_config {
 =09 * value of type s32, and then cast that pointer to u64.
 =09 */
 =09struct drm_property *prop_out_fence_ptr;
+=09/**
+=09 * @page_flip_event_property: property to request page-flip events.
+=09 */
+=09struct drm_property *prop_page_flip_event;
 =09/**
 =09 * @prop_crtc_id: Default atomic plane property to specify the
 =09 * &drm_crtc.
--=20
2.54.0


