Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27968EDB7F2
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FBC710E3DB;
	Tue,  7 Apr 2026 10:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="s4ZMhbkD";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5AE10E3CC
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 10:49:54 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 3B6A64B3;
 Tue,  7 Apr 2026 12:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775558905;
 bh=Gg8HlXXefN/XgPC5kHOsD/buJpWmZx5GZjxQ1vLrL1I=;
 h=From:To:Cc:Subject:Date:From;
 b=s4ZMhbkDa/UWqpEr+hm5R06gsQHmOML62eODXCDYpSRUMkPFF7UwWirux+CqhbT0w
 5Hu539L/uts1xrRnK2yli2tI7at6qDPW+pKthCPrI7KjOTz/Z3J2XH/ZYJD0IfQ1dq
 OTql0fzI6dt8qb6wCXRKBa9cpUDaWCMeBUkL28m8=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v3] drm: uapi: Use SPDX in DRM core uAPI headers
Date: Tue,  7 Apr 2026 13:49:51 +0300
Message-ID: <20260407104951.1781047-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.52.0
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

The DRM core uAPI headers are licensed under the MIT license, and carry
copies of the license with slight variations. Replace them with SPDX
headers.

Following a discussion with Simona Vetter on this topic, add a
clarification in the drm-uapi.rst file that independent closed-source
userspace implementations of software using the DRM uAPI are accepted,
as allowed by the MIT license.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
---
Dave, could I get your ack on this ? Please also let me know if it
should go through drm-misc or if you prefer picking it up.
---
 Documentation/gpu/drm-uapi.rst |  4 ++++
 include/uapi/drm/drm.h         | 20 +-------------------
 include/uapi/drm/drm_fourcc.h  | 20 +-------------------
 include/uapi/drm/drm_mode.h    | 19 +------------------
 include/uapi/drm/drm_sarea.h   | 20 +-------------------
 5 files changed, 8 insertions(+), 75 deletions(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 579e87cb9ff7..32206ce62931 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -118,6 +118,10 @@ is already rather painful for the DRM subsystem, with multiple different uAPIs
 for the same thing co-existing. If we add a few more complete mistakes into the
 mix every year it would be entirely unmanageable.
 
+The DRM subsystem has however no concern with independent closed-source
+userspace implementations. To officialize that position, the DRM uAPI headers
+are covered by the MIT license.
+
 .. _drm_render_node:
 
 Render nodes
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 495462e44a17..bc7ef7684099 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Header for the Direct Rendering Manager
  *
@@ -11,25 +12,6 @@
  * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
  * Copyright 2000 VA Linux Systems, Inc., Sunnyvale, California.
  * All rights reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
  */
 
 #ifndef _DRM_H_
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index ac66fa93b5a3..2caf8249f892 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1,24 +1,6 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2011 Intel Corporation
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
  */
 
 #ifndef DRM_FOURCC_H
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index a4bdc4bd11bc..381a3e857d4e 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -1,27 +1,10 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright (c) 2007 Dave Airlie <airlied@linux.ie>
  * Copyright (c) 2007 Jakob Bornecrantz <wallbraker@gmail.com>
  * Copyright (c) 2008 Red Hat Inc.
  * Copyright (c) 2007-2008 Tungsten Graphics, Inc., Cedar Park, TX., USA
  * Copyright (c) 2007-2008 Intel Corporation
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
- * IN THE SOFTWARE.
  */
 
 #ifndef _DRM_MODE_H
diff --git a/include/uapi/drm/drm_sarea.h b/include/uapi/drm/drm_sarea.h
index a951ced60ebe..1e38d028332d 100644
--- a/include/uapi/drm/drm_sarea.h
+++ b/include/uapi/drm/drm_sarea.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /**
  * \file drm_sarea.h
  * \brief SAREA definitions
@@ -8,25 +9,6 @@
 /*
  * Copyright 2002 Tungsten Graphics, Inc., Cedar Park, Texas.
  * All Rights Reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * TUNGSTEN GRAPHICS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
  */
 
 #ifndef _DRM_SAREA_H_

base-commit: dc2d30e7db8321a6696d266838f7af7e9d1c7155
-- 
Regards,

Laurent Pinchart

