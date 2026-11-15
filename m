Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82909606A32D
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=HHvz2HKt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF56910E030;
	Sun, 15 Nov 2026 11:48:21 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49DD10E030
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 11:48:13 +0000 (UTC)
Received: from [192.168.17.1] (unknown [124.79.98.159])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04f1;
 Sun, 15 Nov 2026 19:48:08 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [RFC PATCH v2 0/2] drm/bridge: cdns-mhdp8546: order teardown against
 producers
Date: Sun, 15 Nov 2026 19:48:06 +0800
Message-ID: <179474328603.103840.4363768155390012601@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-HM-Tid: 0aa1df09431b03a1kunmbac61c98bf7b4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSU8aVkhLGh1MGkIdT01DT1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
 ++
DKIM-Signature: a=rsa-sha256;
 b=HHvz2HKtonMn5+t3pSPdVz57/+1YCwuxLYJ6zHb7hZ8V/i6/VbuMnXDwAgt9X2aoe9miBU6vo5ECgKjusMNOngSjfXrH7I9e0ZSOdJnxgk5n7Li9deoQvUk+P1465uYmXPiE+AgKpIsenGGZ1dgCr4LUd/uonxaVBkqLuMSxefs=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=0Cn4oWoP2n7fe+cmCgJKQDfY5yx76B+/Bp4WeuLCUlc=;
 h=date:mime-version:subject:message-id:from;
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The bridge teardown cancelled work after the controller resources were
released, and the atomic hooks were not excluded from re-queuing it.
This RFC uses the current bridge unplug critical section for the whole
resource-facing hooks and work callbacks, keeps a reference for the
asynchronous firmware callback, and drains the IRQ and all work items
before the controller and PHY are stopped.

Patch 1 extends the HPD helpers so unplug also covers their mutexes and
clears the registered callback while the mutexes still exist.  Patch 2
applies the driver-side lifetime repair.


Hongyan Xu (2):
  drm/bridge: protect complete HPD helpers during unplug
  drm/bridge: cdns-mhdp8546: exclude producers before teardown

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 333 ++++++++++++++----
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |   2 +-
 .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   |  76 +++-
 drivers/gpu/drm/drm_bridge.c                  |  41 +++
 4 files changed, 365 insertions(+), 87 deletions(-)

-- 
2.50.1.windows.1

Discovery: found by the author's in-house static analysis tool.
