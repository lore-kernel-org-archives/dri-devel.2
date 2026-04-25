Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A417FF8850
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0596F10E525;
	Sun, 26 Apr 2026 06:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DmLKY5Py";
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 818BA10E180
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 18:17:42 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id BB44820B7167; Sat, 25 Apr 2026 11:17:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB44820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777141062;
 bh=sh39rjXCVsjh69pBUlReRVKxFnTSW80T1LCRSsVGCpk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DmLKY5PywiKZ56ifa/A3vP5fRErajPZezlwTuJfPij/+ws3BnFPT2CW1kRGiEHxfe
 2Gb3yZDo/EljSMA2RhOBHeNPVvD+MLbQMsWCLHVamglpQGTHQngBGf1CuyhRz5PmJE
 F6buL9MpiAXEl/u57gvRZN4SLya5TH6eS35PR9kU=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Himadri Pandya <himadrispandya@gmail.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Deepak Rawat <drawat.floss@gmail.com>,
 dri-devel@lists.freedesktop.org,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, stable@kernel.vger.org
Subject: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Date: Sat, 25 Apr 2026 11:17:19 -0700
Message-ID: <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:47:14 +0000
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

VMBUS ring buffers must be page aligned. So, use VMBUS_RING_SIZE() to
ensure they are always aligned and large enough to hold all of the
relevant data.

Cc: stable@kernel.vger.org
Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 051ecc526832..753d97bff76f 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -10,7 +10,7 @@
 
 #include "hyperv_drm.h"
 
-#define VMBUS_RING_BUFSIZE (256 * 1024)
+#define VMBUS_RING_BUFSIZE VMBUS_RING_SIZE(256 * 1024)
 #define VMBUS_VSP_TIMEOUT (10 * HZ)
 
 #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
-- 
2.54.0

