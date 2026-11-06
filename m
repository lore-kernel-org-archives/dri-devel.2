Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1F606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9aqN9Lg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176E8112D64;
	Fri,  6 Nov 2026 13:29:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D401112D7B
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:29:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C6626020F
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2271F0089F;
 Fri,  6 Nov 2026 13:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971760;
 bh=vF/Pgp4XWN+OqPSC5hsmHVZq5C2S5qcoaagtQ9sS+5A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F9aqN9LguFak3TA2OkcJBYnSUKi02M+Mf1IuzXbhOsmBDG38x4NCKRBTWQZOIrVxP
 YNbR6638ZFXbDV1bUJAgl15rBn4n1/s0p1pHk/zNL35v9sv45zsW2hhZ93KWDig+qA
 QQ91+Up1JfKzoEKT1UQ6qWUQbiwIofebf68kAlGtXsiDqo+qRGHgagdn46kFvZ/qdA
 J2g9WYec/lsfnlaAcUgdh3IIkmwMIFi/YohEvPiDM7LNpZsjB+PYyj+9v3d7NrOSle
 NCA5c/Rc5zS1tND685UlYqdd8cbsZG37HEmLCoQ5dY8h80hAcMhNha2nAQcSdKAgdE
 GQOp+ZMPDapRQ==
Message-ID: <sashiko-outbox-201459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/39] drm/atomic: Fix private obj error handling
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-6-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-6-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:29:19 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/atomic: wrong Fixes commit in drm_atomic_private_obj_init()
  fix
--

commit a21244827cf8a5badb67ea5cb6c337990a26e370
Author: Maxime Ripard <mripard@kernel.org>

> drm/atomic: Fix private obj error handling
>
> drm_atomic_private_obj_init() initializes the modeset lock and adds the
> object to the privobj_list before calling atomic_create_state().
>
> However, if atomic_create_state() fails, the function returns the error
> directly without removing the object from the list or cleaning up the
> lock. This leaves a dangling entry in privobj_list and a leaked lock.
>
> Fix this by unwinding both operations in an error path.
>
> Fixes: b962a12050a3 ("drm/atomic: integrate modeset lock with private obj=
ects")
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

[Severity: Low]
In b962a12050a3 ("drm/atomic: integrate modeset lock with private objects"),
drm_atomic_private_obj_init() returned void, took a caller-allocated state
pointer, and had no error path.  The atomic_create_state() call and its
uncleaned error return were added by 47b5ac7daa46 ("drm/atomic: Add new
atomic_create_state callback to drm_private_obj").  Should the Fixes tag be:

  Fixes: 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback to=
 drm_private_obj")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D6
