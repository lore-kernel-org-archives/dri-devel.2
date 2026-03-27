Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C60C10F285F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF0210EEC0;
	Fri, 27 Mar 2026 17:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="nXaQenAA";
	dkim-atps=neutral
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA02B10EEAA
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1774631916; x=1774891116;
 bh=RtNwqriTK8rT1ph4Z/+R9cbx7IZCZMzJo4A2+TPSFyw=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=nXaQenAA+eoNuuhq3jCUmSOOF6ww4VoMuOdPZiROUN4pHPWD1fCZBtGBaFOuPIN9e
 3oKQe1Q2R2yRCkDpIvZ9960HfJq5jFbNZOMQPqw4kgPexqSv9PM9imMYLx8pMHBQbL
 fQqFEeQHeiP9NZe8afllsbX3jaVsYLKb5EVkf6TkFAPkKBXgqsskqSpmsgSfzNLGL8
 1y41duLvqgOL2mCfBJiFCdKOINRYxFMq1y3dnzBM7nz3C3rznBoRPWCsrAacmgYPx8
 JpQ3xTGMFtyfTyHYvWTjlgZE68O64015SGbPRdx5hBMIMkiHXCl+/z5vE5zQy8Cjq7
 MYJgo+6UM29MA==
Date: Fri, 27 Mar 2026 17:18:29 +0000
To: dri-devel@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: Simona Vetter <simona@ffwll.ch>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/doc: document DRM_IOCTL_SYNCOBJ_EVENTFD
Message-ID: <20260327171812.128290-1-contact@emersion.fr>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: c23a396d621dafc49e5bfb1888983677f0541894
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

struct drm_syncobj_eventfd was documented, but
DRM_IOCTL_SYNCOBJ_EVENTFD was not. This prevents references to this
define from being properly linkified in docs.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Daniel Stone <daniel@fooishbar.org>
Cc: Michel D=C3=A4nzer <michel.daenzer@mailbox.org>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
---
 include/uapi/drm/drm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 27cc159c1d27..495462e44a17 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -1323,6 +1323,13 @@ extern "C" {
  */
 #define DRM_IOCTL_MODE_GETFB2=09=09DRM_IOWR(0xCE, struct drm_mode_fb_cmd2)
=20
+/**
+ * DRM_IOCTL_SYNCOBJ_EVENTFD - Register an eventfd to be signalled by a sy=
ncobj.
+ *
+ * This can be used to integrate a syncobj in an event loop.
+ *
+ * The IOCTL argument is a struct drm_syncobj_eventfd.
+ */
 #define DRM_IOCTL_SYNCOBJ_EVENTFD=09DRM_IOWR(0xCF, struct drm_syncobj_even=
tfd)
=20
 /**
--=20
2.53.0


