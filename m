Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA91606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=de7PTetd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862531127D1;
	Thu, 19 Nov 2026 23:44:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84AB810E8C2;
 Thu, 19 Nov 2026 23:43:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49E214393F;
 Thu, 19 Nov 2026 23:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73221F000CA;
 Thu, 19 Nov 2026 23:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795131836;
 bh=t1eCgcy9b3WNHyq3M9rz9JT7lPvD4AfVY8O6VHdOGUc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=de7PTetdNXzA9qjyadz+Vh65j+r/uKwfjt0VWP3zCPkr+BEnQlaBZ4MntPdES+VuC
 VtdbHHXM5OCP8lRq4Mg5GUO6++0EiDuHfWvJk0PneluxNKHnJTYkCsuv1sX/wteqP+
 YMMAA3fqm49DBdbP4mLX7rbs6zAm41wun4wlLgeLsYB7HzUCy9fnIA9vDBzsM3vAej
 6xySeD9l9rJ25ibO/asoU5H9eOcharVtTXJalVwWpd3K2DA5/ULRJ+OlFKHncZ+fH3
 kszCYT5tFyHy0ys5sZvD+SVOWhW5yrNFNpNQnv8rpJbL0zxzkuWms1HUH8uC5/NhRc
 oLz7k17wyTJLA==
Message-ID: <sashiko-outbox-224212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/12] drm/gud: add connector luminance support
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261119-superm1-backlight-property-v12-10-89d5217d3618@amd.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
 <20261119-superm1-backlight-property-v12-10-89d5217d3618@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 23:43:55 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/gud: race on staged state in
  gud_connector_set_luminance()
--

commit 5745bfa73995dabc57cdf0005257260438071d7c
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/gud: add connector luminance support

This commit exposes GUD display brightness through the connector LUMINANCE
property when CONFIG_DRM_LUMINANCE is enabled, resending the current
display state and committing it from the .set_luminance callback on
luminance-only updates.

> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gu=
d_connector.c
> index ddbf3b3ebbca8..f00272f030c1c 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -13,6 +13,7 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_file.h>
> +#include <drm/drm_framebuffer.h>
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> @@ -314,17 +315,52 @@ static int gud_connector_atomic_check(struct drm_co=
nnector *connector,
>  	return 0;
>  }
> =20
> +/*
> + * The device receives brightness as part of its display state, there is=
 no
> + * dedicated request. Resend the current configuration with the new lumi=
nance
> + * and apply it, so that a luminance change doesn't need a modeset.
> + */
> +static void gud_connector_set_luminance(const struct drm_connector_state=
 *conn_state)
> +{
> +	struct drm_connector *connector =3D conn_state->connector;
> +	struct gud_device *gdrm =3D to_gud_device(connector->dev);
> +	struct drm_crtc_state *crtc_state =3D conn_state->crtc->state;
> +	struct drm_plane_state *plane_state =3D gdrm->plane.state;
> +	int idx, ret;
> +
> +	/*
> +	 * gud_plane_atomic_check() sent the committed luminance with
> +	 * GUD_REQ_SET_STATE_CHECK for these changes and gud_crtc_atomic_enable=
()
> +	 * applied it. A modeset that only changed the active state didn't.
> +	 */
> +	if (crtc_state->mode_changed || crtc_state->connectors_changed)
> +		return;
> +
> +	if (drm_WARN_ON_ONCE(connector->dev, !plane_state->fb))
> +		return;
> +
> +	ret =3D gud_state_check(gdrm, &crtc_state->mode, plane_state->fb->forma=
t,
> +			      plane_state->rotation, conn_state);
> +	if (!ret && drm_dev_enter(connector->dev, &idx)) {
> +		ret =3D gud_usb_set(gdrm, GUD_REQ_SET_STATE_COMMIT, 0, NULL, 0);
> +		drm_dev_exit(idx);
> +	}
> +	if (ret)
> +		gud_conn_err(connector, "Failed to set luminance", ret);
> +}

[Severity: Medium]
Can a nonblocking luminance commit race with gud_plane_atomic_check() and
clobber the display state staged on the device with GUD_REQ_SET_STATE_CHECK?

For commits where mode_changed or connectors_changed is set,
gud_plane_atomic_check() stages the new configuration on the device during
drm_atomic_check_only(), before drm_atomic_helper_swap_state() waits for an
in-flight nonblocking commit's hw_done completion, and
gud_crtc_atomic_enable() later applies it with a payload-less
GUD_REQ_SET_STATE_COMMIT.  Because commit_work runs
gud_connector_set_luminance() after modeset locks are dropped, it can
interleave with a subsequent modeset or property commit:

CPU0 (commit B: modeset/rotation)   kworker (commit A: nonblocking luminanc=
e)
drm_mode_atomic_ioctl()
  drm_atomic_check_only()
    gud_plane_atomic_check()
      gud_state_check()
        /* stages B on device */
  drm_atomic_helper_commit()
    drm_atomic_helper_swap_state()
      wait_for_completion(A->hw_done)
                                    commit_tail()
                                      ...
                                      gud_connector_set_luminance()
                                        gud_state_check()
                                          /* overwrites device with A */
                                        gud_usb_set(SET_STATE_COMMIT)
                                      drm_atomic_helper_commit_hw_done()
    ...
    gud_crtc_atomic_enable()
      gud_usb_set(SET_STATE_COMMIT)
        /* re-commits A; B is lost */
    gud_connector_set_luminance()
      if (mode_changed || ...)
        return;

Similarly, because gud_connector_set_luminance() drops gdrm->ctrl_lock
between gud_state_check() and gud_usb_set(GUD_REQ_SET_STATE_COMMIT), a
concurrent DRM_MODE_ATOMIC_TEST_ONLY ioctl can run gud_plane_atomic_check()
-> gud_state_check() between the two transfers and have its test-only state
committed to the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-superm1-ba=
cklight-property-v12-0-89d5217d3618@amd.com?part=3D10
