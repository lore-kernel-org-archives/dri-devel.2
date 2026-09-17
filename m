Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5386C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C55F10E6F1;
	Thu, 17 Sep 2026 11:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="T7BQox8K";
	dkim-atps=neutral
X-Greylist: delayed 603 seconds by postgrey-1.36 at gabe;
 Thu, 17 Sep 2026 11:15:25 UTC
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D5E610E6D7
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:15:25 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20260917110519e985c19a43000207ea
 for <dri-devel@lists.freedesktop.org>;
 Thu, 17 Sep 2026 13:05:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=GXdhflyGWUbl9NTwcQhvsBNxzZkrZQmTOjB/BvxV0xM=;
 b=T7BQox8KW3PoO/xkGmhlbpXZ5uf1MOPc5BNZ8KwkRrJzXu/oEN3D59u/JJMK92icZ6bR8y
 yjiAzH4v2TYOAmhnWkqpAAdAF+W1RCXkWEgRSLXceBfrpGyQjaNVHzSVUt7R3fqmhK9xA9r6
 IG53XaQnATykqiGZVgfcHE5bjBMqEfiFnDAxp7jf1L1TjxefpLRLSYpeWqMBPqrTQvhhYvVb
 sRm0rgXdUmY566vFnJSqpE64rKIhH4Yj/iHChnrRBPk3OuoOPYm29cKe3552/OAVgSKkIGc4
 P/1uM378ptL7mwc7SzPgr5t1xSAQiMNBWsdkEbhAZsV+Z7Br82JqWDsw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/panel: simple: Add Truly TFT320240-229-E panel
Date: Thu, 17 Sep 2026 13:05:13 +0200
Message-ID: <20260917110517.1053556-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Add Truly TFT320240-229-E panel support into panel-simple driver along with
the required DT bindings documentation.

Alexander Sverdlin (1):
  dt-bindings: display: simple: Add Truly TFT320240-229-E panel

Frank Bodammer (1):
  drm/panel: simple: Add support for Truly TFT320240-229-E panel

 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 drivers/gpu/drm/panel/panel-simple.c          | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.55.0

