Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9135CCD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B6D10E654;
	Mon, 22 Jun 2026 11:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XDF7cQmS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5058410E654;
 Mon, 22 Jun 2026 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782128883; x=1813664883;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4n5igli6yz4uB+fY9MiJXFo+GB2XsYsCw0nY/93G7uA=;
 b=XDF7cQmS4vcEeAr4o6j996jOoFMNwVe22GLpvAEHeA3jY9F4KcOkUDtn
 d3b943mPZLfqSpUk5RZi/1bF6mcYYnzvWd1XWzhvuvwmaeJKyDohfTeXX
 2D5Dg3xl9o2Ns5ack18oWObLxH8G4B7mljjpDHlCAMSN9Li2U9eNLschH
 LOjvE+55h4TvQi2FqXVxkFtAgL6gcRrTMdW/7E9sLlUNHwdmVPNxoiXvE
 4nyWQGh5ghwp/SrlI5Ny9AYckQDJmaR/ig15sHo8n+dT9GMlA+1fpByBV
 4qKUiKHIYmLfo+TbaTw+GrQnvMurba25efYS2FtLvqL12GsnFAVHTSchA w==;
X-CSE-ConnectionGUID: zI68iZZ9RK+0JMh9vipa/g==
X-CSE-MsgGUID: oRKROiPhR9CjVhSNNBpvpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93510044"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="93510044"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 04:48:02 -0700
X-CSE-ConnectionGUID: 2woNzUGPTo+97tHSje9IyA==
X-CSE-MsgGUID: kdi2Zk9cQdSyS95PQVr/Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="272909368"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa002.fm.intel.com with ESMTP; 22 Jun 2026 04:48:00 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Raag Jadav <raag.jadav@intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] drm/xe/i2c: alerts and controller enabling
 modifications
Date: Mon, 22 Jun 2026 13:47:57 +0200
Message-ID: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
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

This includes support for the SMBus alerts, and special handling for the
IC_ENABLE register.

Thanks,

Heikki Krogerus (2):
  drm/xe/i2c: Handler for SMBus Alerts
  drm/xe/mcu_i2c: Take over control of the controller enabling

 drivers/gpu/drm/xe/Makefile       |  1 +
 drivers/gpu/drm/xe/xe_i2c.c       | 86 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_i2c.h       | 16 ++++++
 drivers/gpu/drm/xe/xe_i2c_smbus.c | 59 +++++++++++++++++++++
 4 files changed, 154 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_i2c_smbus.c

-- 
2.50.1

