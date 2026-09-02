Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737DEC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9AA310F1BE;
	Wed,  2 Sep 2026 12:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="biubSlD8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3446510F1BE
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:51:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE89F404DC;
 Wed,  2 Sep 2026 12:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6F61F00A3D;
 Wed,  2 Sep 2026 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788353478;
 bh=b2LO6M5zgeaIJ73w3CknM7+xyqkEcj2DpUdzs3En5wA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=biubSlD8TpCNrGWJSl4jK82hN/b2hkoqe8ZKh1WEdCvfhl4Osiv/+rZ2G4YQEIBwF
 PumZqaWfD5dYakK9S2fuD99/NOv+xF+gGQzUJ0EJzdNFS8V/C4AMubaoJ1JY/ay2x7
 xjDLSx8TdKgVw0ZnW5q9PG27UDmDYUmRR7K628/94mDTKSkQh3XMV2hBn0qtWurGcR
 QE1z//qbCoXrSI7APmH0+MDhw5jfqs+2E8b/jLpDBFl8/axlPP/7+Y5PF41BfVgjkY
 KSsxNDrOeHitG5A8dIOYO/1b95wOFPLLeWuH+2P4TOw7LwQ9y3bxpmCPb2xqJpO24h
 9+M/TdppVveZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gud: fix out-of-bounds write in
 gud_plane_atomic_check()
To: "Sajal Gupta" <sajal2005gupta@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902123254.36987-1-sajal2005gupta@gmail.com>
References: <20260902123254.36987-1-sajal2005gupta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:51:18 +0000
Message-Id: <20260902125118.8D6F61F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [High] Use-After-Free due to unsafe access to `connector->state` in the f=
allback logic without proper locking or addition to the atomic state.
- [Medium] Iterator variable `connector_state` leaks from the `for_each_new=
_connector_in_state` loop when no CRTC-bound connector is found, causing th=
e wrong connector state to be used.
--

commit 0c2e0cfd22b820fc8dacf39a623bb3f5f21ff275
Author: Sajal Gupta <sajal2005gupta@gmail.com>

drm/gud: fix out-of-bounds write in gud_plane_atomic_check()

This commit fixes an out-of-bounds write in the plane property loop of
gud_plane_atomic_check(). It drops a redundant addition of the loop index
to num_properties, since num_properties is already the correct running
index.

Link: https://sashiko.dev/#/patchset/20260821071812.16500-1-sajal2005gupta%=
40gmail.com?part=3D1

> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pip=
e.c
> index 5ef887d8485a3..54adc401bc1ba 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c

[ ... ]

> @@ -562,8 +562,8 @@ int gud_plane_atomic_check(struct drm_plane *plane,
>  			goto out;
>  		}
> =20
> -		req->properties[num_properties + i].prop =3D cpu_to_le16(prop);
> -		req->properties[num_properties + i].val =3D cpu_to_le64(val);
> +		req->properties[num_properties].prop =3D cpu_to_le16(prop);
> +		req->properties[num_properties].val =3D cpu_to_le64(val);
>  		num_properties++;
>  	}

While reviewing this change, I noticed a couple of pre-existing issues earl=
ier
in gud_plane_atomic_check():

drivers/gpu/drm/gud/gud_pipe.c:gud_plane_atomic_check() {
    ...
    for_each_new_connector_in_state(state, connector, connector_state, i) {
        if (connector_state->crtc)
            break;
    }

    /*
     * DRM_IOCTL_MODE_OBJ_SETPROPERTY on the rotation property will not have
     * the connector included in the state.
     */
    if (!connector_state) {

[Severity: Medium]
This is a pre-existing issue, but I noticed the iterator variable
connector_state is not cleared if the loop completes without hitting the
break statement.

If userspace submits an atomic commit updating a plane property while
simultaneously modifying a disconnected connector, the loop evaluates the
disconnected connector and finishes without breaking. This leaves
connector_state retaining the disconnected state.

Since connector_state is no longer NULL, the fallback check is skipped.
Could this cause the hardware check command GUD_REQ_SET_STATE_CHECK to
receive the ID of a disconnected connector and misconfigure the display?

        struct drm_connector_list_iter conn_iter;

        drm_connector_list_iter_begin(plane->dev, &conn_iter);
        drm_for_each_connector_iter(connector, &conn_iter) {
            if (connector->state->crtc) {
                connector_state =3D connector->state;
                break;
            }
        }
        drm_connector_list_iter_end(&conn_iter);
    }

[Severity: High]
This is also a pre-existing issue, but does this fallback logic risk a
use-after-free by directly accessing connector->state?

When an atomic commit updates only a plane property, the fallback logic
iterates all system connectors and directly assigns connector_state to
connector->state. Because the connector is not added to the atomic state
via drm_atomic_get_connector_state(), its lock is not held by the current
thread.

If a concurrent userspace thread issues a property update on this connector,
could it swap and free the old state while gud_connector_fill_properties()
is simultaneously reading from it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902123254.3698=
7-1-sajal2005gupta@gmail.com?part=3D1
