Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47738C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924F810E5C3;
	Mon,  3 Aug 2026 14:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="T1OGMazb";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0887210E5C3
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:21:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8270B143D;
 Mon,  3 Aug 2026 07:21:36 -0700 (PDT)
Received: from e135116.arm.com (unknown [10.57.0.74])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 97D6E3F632;
 Mon,  3 Aug 2026 07:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785766900; bh=6l9n8cU0Nn9oPQJ68xsaS7I0q2OdVIL+2o7pPAJduMA=;
 h=From:To:Cc:Subject:Date:From;
 b=T1OGMazbV4uKFYSbaA7cfBEEpTgvgz+N7tizIqXJ/I6NRajiX9VRKo61fjt09rQzo
 chodwQyyfgcuaOwTz0woKdnmXCzdVfpIfG7bSyC/1DziIPvNF4z8ahk3zvEurMhXcf
 0rrjj6+cf0KwIf3vL0k5BAkyEshct0eezuoNYJOo=
From: Raveendra Talabattula <raveendra.talabattula@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Raveendra Talabattula <raveendra.talabattula@arm.com>, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, james.qian.wang@arm.com,
 asad.malik@arm.com, vincenzo.frascino@arm.com, nayden.kanchev@arm.com,
 charvi.mehta@arm.com
Subject: [PATCH v2 0/2] drm/komeda: Fix GLB_CORE_ID parsing and initialize
 encoder clone masks
Date: Mon,  3 Aug 2026 15:21:20 +0100
Message-ID: <20260803142122.4127851-1-raveendra.talabattula@arm.com>
X-Mailer: git-send-email 2.43.0
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

Komeda currently decodes GLB_CORE_ID with bit definitions that do not
match the hardware register layout, which leads to incorrect hardware
version reporting.

Patch 1 fixes the GLB_CORE_ID field definitions so the reported product
version matches the hardware specification.

DRM clone-mask validation can reject Komeda display + writeback
configurations because the encoder pair attached to one CRTC does not
advertise the required reciprocal possible_clones relationship.

Patch 2 sets the display/writeback clone masks when the writeback
connector is created, making the clone relationship explicit for the
encoder pair attached to that CRTC.

Changes in v2:
- Patch 1: add a short GLB_CORE_ID layout comment and drop the redundant
  product-id mask and shift-by-zero change noted in review.
- Patch 2: replace the global encoder mask initialization with per-CRTC
  display/writeback clone-mask setup.
- Patch 2: include each encoder's own bit in possible_clones.
- Update patch 2 subject and cover letter text to match the localized fix.

Cc: liviu.dudau@arm.com
Cc: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org
Cc: tzimmermann@suse.de
Cc: airlied@gmail.com
Cc: simona@ffwll.ch
Cc: james.qian.wang@arm.com
Cc: asad.malik@arm.com
Cc: vincenzo.frascino@arm.com
Cc: nayden.kanchev@arm.com
Cc: charvi.mehta@arm.com
Signed-off-by: Raveendra Talabattula <raveendra.talabattula@arm.com>

Raveendra Talabattula (1):
  drm/komeda: Fix bits parsing of GLB_CORE_ID

Vincenzo Frascino (1):
  drm/komeda: Set display/writeback clone masks

 .../drm/arm/display/include/malidp_product.h  | 10 +++++++---
 .../arm/display/komeda/komeda_wb_connector.c  | 33 +++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.43.0
