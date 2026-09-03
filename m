Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2950EC624DE
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 21:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2CF10F7A2;
	Thu,  3 Sep 2026 21:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="D4cmCSW2";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982C110F7A4
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788470369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oisNWoIp7gQlNLE50911kRCMJdf5POJVWw1vlhgc66I=;
 b=D4cmCSW2WK1sxsWlUUTQqrYVdr4UIQG+NAynLxh42bdPizqXzFkgWnwvWoHoWEo3awnE86
 FaNL5mvh5xCQ5ZwA/7VtB9Hn5i4cm4FIcQRT7cO/39yDYHC6TSv61OEivB2kg1dhiZPApE
 kfh/RyHRWAYzv6ccZ8Kc3xZtB7fD3dw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-qxb0LdXEOjGu7NNr3YTmzg-1; Thu,
 03 Sep 2026 17:19:25 -0400
X-MC-Unique: qxb0LdXEOjGu7NNr3YTmzg-1
X-Mimecast-MFC-AGG-ID: qxb0LdXEOjGu7NNr3YTmzg_1788470364
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9DB1187E5CE; Thu,  3 Sep 2026 21:19:23 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.64.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB0291955F70; Thu,  3 Sep 2026 21:19:21 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@lists.freedesktop.org
Cc: Christian Hergert <christian@sourceandstack.com>,
 "Dmitry Osipenko" <dmitry.osipenko@collabora.com>,
 "David Airlie" <airlied@redhat.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, "Simona Vetter" <simona@ffwll.ch>,
 "Gerd Hoffmann" <kraxel@redhat.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 2/2] drm/virtio: Recalculate ignore_damage_clips on every
 update
Date: Thu,  3 Sep 2026 17:15:52 -0400
Message-ID: <20260903211914.1109100-3-lyude@redhat.com>
In-Reply-To: <20260903211914.1109100-1-lyude@redhat.com>
References: <20260903211914.1109100-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: VqaiLdFvXgFOr7WDXrHy_2fbxp3svK0aIurEJQZq84M_1788470364
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: Christian Hergert <christian@sourceandstack.com>

Plane state duplication preserves ignore_damage_clips. Once fbdev sets
it for a dumb buffer, later updates using rendered resources continue to
ignore damage because the flag is never cleared.

Assign ignore_damage_clips on every atomic check so rendered resources
can use supplied damage after an earlier dumb-buffer update.

Signed-off-by: Christian Hergert <christian@sourceandstack.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index d9579a4b4714c..95ec688690d3a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -119,8 +119,8 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 	 * so preserve userspace's accumulated per-buffer damage for those.
 	 */
 	bo = gem_to_virtio_gpu_obj(new_plane_state->fb->obj[0]);
-	if (old_plane_state->fb != new_plane_state->fb && bo->dumb)
-		new_plane_state->ignore_damage_clips = true;
+	new_plane_state->ignore_damage_clips =
+		old_plane_state->fb != new_plane_state->fb && bo->dumb;
 
 	crtc_state = drm_atomic_get_crtc_state(state,
 					       new_plane_state->crtc);
-- 
2.55.0

