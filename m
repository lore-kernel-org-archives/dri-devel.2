Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D88C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551DD10F275;
	Fri, 28 Aug 2026 06:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WVMILWJc";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Fri, 28 Aug 2026 06:57:09 UTC
Received: from mail-m16023653192.xmail.ntesmail.com
 (mail-m16023653192.xmail.ntesmail.com [160.236.53.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA0010F275
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:57:09 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4bab2d582;
 Fri, 28 Aug 2026 14:52:02 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v8 0/5] Add eDP lane mapping support
Date: Fri, 28 Aug 2026 14:51:48 +0800
Message-Id: <20260828065153.590802-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa04723c63e03a8kunm9cc188d518831f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ0hNHlYeQhgfHkkYHh
 4ZQkhWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSEpKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=WVMILWJcBzV6eYWE+qJSZLa1Tskj+ReLam0Ikoo9j1KGwt7fsyffBUVJltHgeDr6uavrZT+73hAj8CeSZIVFerWoWgNE6m31ub0cmaIk8z54+D86aTe4RGlkS7ZVl7m9gF0h4RwYoNwCvXBegjWO5UWBDYXfQEUR+MKcpuBuSxc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=xUWryYLszvMhpY9lSrgXJtpEJ4lE5ULsbA6OqmZWLbc=;
 h=date:mime-version:subject:message-id:from;
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

This series adds configurable eDP physical lane mapping support via
device tree data-lanes property.

Lane mapping is mainly used for below scenarios:
1. Correct PCB lane swap and differential line routing crossover
   without hardware changes;
2. Adapt mismatched lane pin definitions between SoC and eDP panel;
3. Support multiple panel hardware variants on the same board
   by configuring data-lanes in device tree only.

The series includes driver implementation and device tree binding
updates to support custom lane mapping configuration from endpoint
node, and keeps default linear lane order if no configuration is given.

Patch 1: Add endpoint data-lanes property to analogix-dp binding
Patch 2: Add DRM DP helper API to validate DP lane counts
Patch 3: Restore mandatory for samsung,link-rate and samsung,lane-count
         properties
Patch 4: Add validation for samsung,lane-count property as preparation
Patch 5: Implement lane mapping in analogix_dp driver

Damon Ding (5):
  dt-bindings: display: bridge: analogix-dp: Add data-lanes support for
    endpoint
  drm/dp: Add helper to validate DP lane counts
  drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties
  drm/bridge: analogix_dp: Add validation for samsung,lane-count
    property
  drm/bridge: analogix_dp: Add support for optional data-lanes mapping

 .../bindings/display/bridge/analogix,dp.yaml  | 19 +++--
 .../rockchip/rockchip,analogix-dp.yaml        |   1 +
 .../drm/bridge/analogix/analogix_dp_core.c    | 84 ++++++++++++++++++-
 .../drm/bridge/analogix/analogix_dp_core.h    |  4 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 15 ++--
 .../gpu/drm/bridge/analogix/analogix_dp_reg.h |  4 +
 include/drm/display/drm_dp_helper.h           |   6 ++
 7 files changed, 115 insertions(+), 18 deletions(-)

---

Changes in v2:
- Add lane mapping application scenarios in commit message.
- Remove redundant deprecated property 'data-lanes' for eDP node.
- Update port@1 $ref to /schemas/graph.yaml#/$defs/port-base.

Changes in v3:
- Squash [PATCH v2 2/3] into [PATCH v2 1/3].
- Add unevaluatedProperties: false to both the port@1 and endpoint
  nodes.

Changes in v4:
- Add validation for samsung,lane-count property as preparation.

Changes in v5:
- Add DRM DP helper API to validate DP lane counts.
- Apply DRM DP helper API to check the validity of samsung,lane-count
  property.
- Add Acked-by and Reviewed-by tags.

Changes in v6:
- Add a separate commit to restore mandatory samsung DP DT properties.
- Add Reviewed-by tag.

Changes in v7:
- Add Reviewed-by tag.

Changes in v8:
- Expand the commit message of [PATCH v7 3/5] with the detailed link
  training failure analysis, and add 'Cc: stable'.
- Fix reg parameter of of_graph_get_endpoint_by_regs() from -1 to 0
  in [PATCH v7 5/5].
- Rename 'tmp' to 'lane_idx' and add comment to explain the lane map
  fill loop in [PATCH v7 5/5].
- Add Reviewed-by tags.

-- 
2.34.1

