Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0182CCA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3D510E5CE;
	Wed, 30 Sep 2026 13:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ccUBWyDL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A66010E5CE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790774992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WYoWKwmmFmUn/iLrFWt5ayLZVBeiXg5SrFLIxovOK5Y=;
 b=ccUBWyDL6R5aQnPik+kHg3SVQcTnciFKhTKT/OSjUIb1GbJv6dT49YwYNdCxIj/1ZrE77o
 DWDNpk+EXA3NSgUw4kC2MOn1mfP8H35iPoyMRHoBnrkB2JI2sBxvClsKlDeM9f63NNw81I
 ODxOJ+VaHA+LCtHUp1mfnxXooCcLh74=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-tmxe5FfJPfW9HIRmfIBnVQ-1; Wed, 30 Sep 2026 09:29:51 -0400
X-MC-Unique: tmxe5FfJPfW9HIRmfIBnVQ-1
X-Mimecast-MFC-AGG-ID: tmxe5FfJPfW9HIRmfIBnVQ_1790774990
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a0101292baso16147285e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790774990; x=1791379790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WYoWKwmmFmUn/iLrFWt5ayLZVBeiXg5SrFLIxovOK5Y=;
 b=hNlfzPQp7NEwVE0wu6nitzbtzzq2JJ+3G9dOsltDmo1qdivUf/oeSHDZRqMOAySjsj
 NS8D2GA34hEPnJnJZv3pYGLjUJrGwXg2qGQHn+ZI5M8c4u3O+KtBOq2q46dJX/JYfCbs
 oJEmyC2ihxPgDywD3qerh9ZhAe89hdZWUlZd0BPbZzxusmck/E8loTQ4XP/U2/3H58ZE
 7EpaL7Zzv0Bf2RMGV1yrkSkJhpHZkileMQp1UrRVHEcVSKAEO4upAjtcwYd3gnVA3qes
 z2Zaxe9XBDQuztQBZpHtYaMwlEQTE3GHh/fmacfz/WK+B2c83GBZ120pUwdn3WOrgH6w
 LK0w==
X-Gm-Message-State: AFuF++lCj4rpuTilKLbwQljCHeSgQtGMUDni3QfF3VUUBEabu+q6GFjx
 TGBh85LyDeiPUnXn6i5PKJcxM64QtKJd1okto/nm0VtMDBTG9s1F7P0JVRqCtOhd6pkItS7D9kI
 09oDaC9qxf7114iKLhFnAdN2YONGfoKc9vXCtteOFWBfj/3mtb/jwbyALvGX9A7TwAaBozqqEZm
 0B2nVmcL9KpstGbc+ac+b3LeiLyACv48Zp/Cy8h8Hh4nDJVR/Cy40YQD4=
X-Gm-Gg: AYBFou2fxfEkDhkCXJCpWVg3qlc/B6F6GmiybhLvpzcWdkkf8my1jxo6SjFPmdTFxvy
 +M7qNU433lFqzY7651USeIdMxO9Bk/WXHcvZCnoMh9SuhUVzUw1L8/v9d1/6SBsQq5UgXzfrZ9p
 taiFe5uLwq7qJVfbVHJ17bvA6vVzff9lKSaFV7jL+RYhnneZ9yEwdN01/A2inBs+qVo9n91gZM2
 0kATAZ/E8SJb8ApceDWOaod/6MIVgD1j1jkz7e5dROpNkDItt/WIM8UHp8tMX6paokaLDQinvzl
 3URwX9rxVtqiij/FE5d6yZVQyFyEgyUtWA7HysRbYaNETiN756P28zkXWrWGIcd9HA4J9v3Vkxc
 +ZoHZ89sLhNl711M16zR3H83FDZvyTl07/HGqlrvvFD96Fh1vodH73HPVPtNJYiL2Z/i3MAaiGW
 K6cFv3L1mO9JE=
X-Received: by 2002:a05:600c:a10d:b0:4a0:1c10:1372 with SMTP id
 5b1f17b1804b1-4a01c102ebamr14249195e9.27.1790774989897; 
 Wed, 30 Sep 2026 06:29:49 -0700 (PDT)
X-Received: by 2002:a05:600c:a10d:b0:4a0:1c10:1372 with SMTP id
 5b1f17b1804b1-4a01c102ebamr14248695e9.27.1790774989381; 
 Wed, 30 Sep 2026 06:29:49 -0700 (PDT)
Received: from dbassey-thinkpadp16vgen1.tpbc.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174e165fsm63564975e9.6.2026.09.30.06.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:29:41 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Cc: kraxel@redhat.com, airlied@redhat.com, dmitry.osipenko@collabora.com,
 slp@redhat.com, mhrica@redhat.com, gurchetansingh@chromium.org,
 mripard@kernel.org, tzimmermann@suse.de, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH] drm/virtio: add ARGB8888 support for primary planes
Date: Wed, 30 Sep 2026 15:27:07 +0200
Message-ID: <20260930132707.500748-1-dbassey@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VhG88rIkfpA4Gvya5mDqfGVPPT5XMXAJgoffqTOEvlE_1790774990
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

Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for
virtio-gpu primary planes. Without this, glmark2-drm fails at
startup because it selects ARGB visual configs by default, which
don't match the XRGB-only plane capabilities. This causes
drmModeSetCrtc to fail with EINVAL.

The virtio_gpu_translate_format() function already handles
ARGB8888 translation to VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM,
so this just exposes the existing capability to userspace.

Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index b422eba42a5f..5f0bc1b1931b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -37,6 +37,7 @@
 
 static const uint32_t virtio_gpu_formats[] = {
 	DRM_FORMAT_HOST_XRGB8888,
+	DRM_FORMAT_HOST_ARGB8888,
 };
 
 static const uint32_t virtio_gpu_cursor_formats[] = {
-- 
2.55.0

