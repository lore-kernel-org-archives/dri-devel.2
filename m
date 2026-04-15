Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4132FA0C2B
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 05:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4870D10E00F;
	Wed, 15 Apr 2026 05:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JjXt5Zug";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096C310E00F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:00:26 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8a151012558so75696746d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 22:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776229225; x=1776834025; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BD0Jh7NHgh3Rj0E+5aYakpmd9tAV1Auw6G8xYy/O08k=;
 b=JjXt5ZugWcpRa41mEWBVsME6mAAjoVt01r7FhvrpSpLeOlOJrz8w6ZGgsuV8VZpfqS
 95ChKv+ebVi1d18w3BTIuzL6tlZr5ZeWMGnjVtPcP4RjftoSQe5VC8IOCZwHi/Tz8MgS
 4f2cETeGx6TWuBu0WZ1ywH2wPlRXHvexXHI/47YPD3IDlG7/Vb1K/bHffxP773BB9TK/
 8vILwqGp23yQvpx1oAQbDwtzWoBCGAQBTLVhwu0q7jJuWRXE3iXDtNKYhueOUMC0Ei+2
 7XIxOe6wqv3KxTF345T5/OOC2I9Y5xyqAW2ISq3vghrSKTIKFs07dhrZHY4vWFLkAQob
 h7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776229225; x=1776834025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BD0Jh7NHgh3Rj0E+5aYakpmd9tAV1Auw6G8xYy/O08k=;
 b=eczigwyJx7etregxIYtDeCxmTFESk/wyh+qM4VEA3AIppS2PFJRbR9qLC86ZWadRoV
 3RuN/UEm2J3inLs72pWRyhpreo4KHOhjjXk8aL97UPzsOec+4eg8e7EAS7l9PaadbGhN
 lh2dSOHJWEcrfOhjVCoJfXIxxLKeqsgVWlioNgRkbzDnvL4OhjGlMsQsE8T7JWjhvzDI
 t/c9o08X7S9tHZ6Vk4EFwzUAJgPYrwkJbwBompetKZIW6Cc4TB1oIRo4YLt2m/i0hu5I
 papd+po1c2J8QSCNVizf2vEMKCB7vOLuLhN4KaDfUioP5wXWLFKy027QfcuovNz3LWZo
 aK2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8T1STJLlzrWLdD0ChtllR88Vcy9C70O/btiG00VYrriHBomwpmS5iaaylRAFelk6/NIP6+sf586YA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygJF56MB64UGRbnK5fQuXd0oC13BZixizGbaOEuxpjyEde6oTB
 dHAdAJdQkIwDZM7Fu9s5xMaz38hbr0/nAaoAszDn3P+mjQMlteHvvVSg
X-Gm-Gg: AeBDievkA5rsmaVqV45bbU7Jf30pq3VGf9SBzqMFeKIQgqoCke/awEeQX6Ifkz2FvjQ
 gV2yphs7JGPUw/iPOyTeX7Oah4C3QWIqvhWOCyYhHlvVyXeQ+zmLvn8hK+zQ6ZuM/a1lOQhL7CB
 XwsS2JQCVb3Loj/O07lghfaTZiFVbH0IOSWOex3qhNhgT3dFth0QMJhXPRD/arDQiiZeJcec/+X
 BwpBy9KWLgaXWj46kdlbph/RLz7bPkSiEoWIRJuNxPfmukQUuvbVtH0+tQwW+CsQw4jw/Ami+U1
 Q03IBSS1vSSAbF3q1qe5i9aeFg8mWgov3aFr7A9VFLYiwhkLB2o8cgldwHgecxV/VqcGJOMLZai
 WAqIZm6JNrqw1sk717GccOfrn90Zx5PqKEviYKP0RKhdMEvF8QVwWlqph8gdOHXRTb6i/wJKT9B
 gfop8nCBjMDr9/54/zuxOVuyJb77d9vrk+NzlJPW5ehsojnphZKwyBKviAAx0UoGaqeGMznjgyG
 jNnwP2Gdl6f2+kHOHoGfKp2cb7d14FgnAJk76qeAQqvwEFAhA==
X-Received: by 2002:ad4:5f8e:0:b0:8ae:61bb:95e3 with SMTP id
 6a1803df08f44-8ae61bb9793mr70305236d6.36.1776229224733; 
 Tue, 14 Apr 2026 22:00:24 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm3890086d6.8.2026.04.14.22.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 22:00:24 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: mwen@igalia.com,
	mcanal@igalia.com
Cc: itoral@igalia.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v4] drm/v3d: Reject empty multisync extension to prevent
 infinite loop
Date: Wed, 15 Apr 2026 05:00:00 +0000
Message-Id: <20260415050000.3816128-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

v3d_get_extensions() walks a userspace-provided singly-linked list of
ioctl extensions without any bound on the chain length. A local user
can craft a self-referential extension (ext->next == &ext) with zero
in_sync_count and out_sync_count, which bypasses the existing duplicate-
extension guard:

    if (se->in_sync_count || se->out_sync_count)
            return -EINVAL;

The guard never fires because v3d_get_multisync_post_deps() returns
immediately when count is zero, leaving both fields at zero on every
iteration. The result is an infinite loop in kernel context, blocking
the calling thread and pegging a CPU core indefinitely.

Fix this by rejecting a multisync extension where both in_sync_count
and out_sync_count are zero in v3d_get_multisync_submit_deps(). An
empty multisync carries no synchronization information and serves no
useful purpose, so returning -EINVAL for such an extension is the
correct defense against this attack vector.

Fixes: 9032d5f633ed ("drm/v3d: Detach job submissions IOCTLs to a new specific file")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
V3 -> V4: fix indentation
V2 -> V3: drop depth counter; instead reject empty multisync
          (in_sync_count == 0 && out_sync_count == 0) in
          v3d_get_multisync_submit_deps()
V1 -> V2: change cap from 16 to V3D_MAX_EXTENSIONS (7), add #define

v3: https://lore.kernel.org/dri-devel/177614548527.3603641.5360701002746181082@gmail.com/
v2: https://lore.kernel.org/dri-devel/20260413055230.3349114-1-ashutoshdesai993@gmail.com/
v1: https://lore.kernel.org/dri-devel/20260410013907.2404175-1-ashutoshdesai993@gmail.com/

 drivers/gpu/drm/v3d/v3d_submit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 18f2bf1fe89f..fc74351efad5 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -393,6 +393,11 @@ v3d_get_multisync_submit_deps(struct drm_file *file_priv,
 	if (multisync.pad)
 		return -EINVAL;
 
+	if (!multisync.in_sync_count && !multisync.out_sync_count) {
+		drm_dbg(&v3d->drm, "Empty multisync extension\n");
+		return -EINVAL;
+	}
+
 	ret = v3d_get_multisync_post_deps(file_priv, se, multisync.out_sync_count,
 					  multisync.out_syncs);
 	if (ret)
-- 
2.34.1

