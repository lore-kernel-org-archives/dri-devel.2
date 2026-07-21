Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5A0C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F4610EBA6;
	Tue, 21 Jul 2026 22:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="P/qIBgto";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id F250610E1EF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:52:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44994152B;
 Tue, 21 Jul 2026 06:52:54 -0700 (PDT)
Received: from e135116.manchester.arm.com (e135116.arm.com [10.33.50.66])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79A693F58B;
 Tue, 21 Jul 2026 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784641978; bh=mTscvaW54QrDZ9ks6EmcmLglz/tbxTvVPzp7nwW54d8=;
 h=From:To:Cc:Subject:Date:From;
 b=P/qIBgto/kHEnsY+PbULtiwnbNVkBrlAMaz6B2vASNvZOZkCkw/ixBwdmNpm2l5gp
 rujGKlQibVziPJeQdOVWXRhMqWaA/Zin+yphKq47moS5vebaGlaXSbkBiF9aAQfWBr
 FPaMbV6Y2r46Yz0OgjRP5/ZsnbE4FPC663XygngM=
From: Raveendra Talabattula <raveendra.talabattula@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Raveendra Talabattula <raveendra.talabattula@arm.com>, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, james.qian.wang@arm.com,
 vincenzo.frascino@arm.com, nayden.kanchev@arm.com, charvi.mehta@arm.com
Subject: [PATCH 0/2] drm/komeda: Fix GLB_CORE_ID parsing and initialize
 encoder clone masks
Date: Tue, 21 Jul 2026 14:52:25 +0100
Message-ID: <20260721135227.439413-1-raveendra.talabattula@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

Komeda also leaves encoder->possible_clones unset, so it remains zero
for all encoders. As a result, DRM clone-mask validation can reject
writeback configurations because no encoder is advertised as
clone-compatible.

Patch 2 initializes encoder->possible_clones after encoder
registration, making the clone-mask setup explicit for registered
encoders.

Cc: liviu.dudau@arm.com
Cc: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org
Cc: tzimmermann@suse.de
Cc: airlied@gmail.com
Cc: simona@ffwll.ch
Cc: james.qian.wang@arm.com
Cc: vincenzo.frascino@arm.com
Cc: nayden.kanchev@arm.com
Cc: charvi.mehta@arm.com
Signed-off-by: Raveendra Talabattula <raveendra.talabattula@arm.com>

Raveendra Talabattula (2):
  drm/komeda: Fix bits parsing of GLB_CORE_ID
  drm/komeda: Initialize encoder possible_clones

 .../drm/arm/display/include/malidp_product.h  | 12 +++++++----
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 20 +++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.43.0

