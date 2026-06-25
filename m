Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CDFCDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833E110E50F;
	Thu, 25 Jun 2026 12:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I6zi1tn5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C525A10E50F;
 Thu, 25 Jun 2026 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782392384; x=1813928384;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=64n9msp9lwVstrlR6VZvtVSttvrMMUgiaBUBrWzuD0s=;
 b=I6zi1tn5xN5gYsmRGeoEb40KQCR1rP7IxhTbGPbbSB/SBTgNoAWZYOIg
 GDiMxWFpHrnahfOZS2uupugBU5JC4c3yhdk+FmGMgqWxeyqn4i3HJ6Dp0
 h+iyT1QfXvgRZSHqBfEbOaaatClLsURBQ80YoyDcgqSW3iQJqQfJiVIpL
 0Bb3ro7jtFY6QERSSXIbQ2R/jTd1+WfZQnmBbs66yKCwbtutmISGh6fGT
 LbIG3rzlBIJfZ9uhExN6VOt4GGaSyf2rZmK6pPwQvub/11xBi9K/QnEu9
 BOw6w8BX5IxmZtQ6AkkGMLYAeRHryFSsAObPE7nb9kJD2TQL74uVpvsR5 A==;
X-CSE-ConnectionGUID: 5IVL5c8OQ6WOJQkkGE89XQ==
X-CSE-MsgGUID: 9OhtXOysTBuwwnx+cRAEOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82287345"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="82287345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 05:59:43 -0700
X-CSE-ConnectionGUID: 8XL4TjupQzyXsGMVZP3kgw==
X-CSE-MsgGUID: MBqnCnu3R7q4Pe2seIFjDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280857006"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 05:59:40 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Raag Jadav <raag.jadav@intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andi Shyti <andi.shyti@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/xe/i2c: alerts and controller enabling
 modifications
Date: Thu, 25 Jun 2026 14:59:36 +0200
Message-ID: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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

Hi,

Changed since v1:
- Global header for the DesignWare I2C registers which meant a bit of
  patch refactoring.
- Selecting CONFIG_SMBUS in CONFIG_XE and handling smbus in xe_i2c.c instead of
  separate file.
- Storing the alert device to the client array and providing enum for the
  clients.
- Allowing other fields in the IC_ENABLE register to be updated except the
  Enable bit.
- Can't sleep in xe_i2c_disable() so using udelay().

v1: https://lore.kernel.org/lkml/20260622114759.3464047-1-heikki.krogerus@linux.intel.com/

This includes support for the SMBus alerts, and special handling for the
IC_ENABLE register.

Thanks,

Heikki Krogerus (3):
  i2c: designware: Global register definitions
  drm/xe/i2c: Handler for SMBus Alerts
  drm/xe/mcu_i2c: Take over control of the controller enabling

 MAINTAINERS                                |   1 +
 drivers/gpu/drm/xe/Kconfig                 |   1 +
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h      |   2 +
 drivers/gpu/drm/xe/xe_i2c.c                | 108 +++++++++++++++++++--
 drivers/gpu/drm/xe/xe_i2c.h                |   6 ++
 drivers/i2c/busses/i2c-designware-common.c |   1 +
 drivers/i2c/busses/i2c-designware-core.h   |  84 +---------------
 drivers/i2c/busses/i2c-designware-master.c |   1 +
 include/linux/designware_i2c.h             | 107 ++++++++++++++++++++
 9 files changed, 222 insertions(+), 89 deletions(-)
 create mode 100644 include/linux/designware_i2c.h

-- 
2.50.1

