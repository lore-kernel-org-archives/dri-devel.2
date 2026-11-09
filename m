Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD175606D83B
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UFlDN21a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44ED510F283;
	Mon,  9 Nov 2026 13:10:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DBF10F280;
 Mon,  9 Nov 2026 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794229847; x=1825765847;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rVfe0EdQ0ADK9rlXStdj2gNQkQxng4CaytjOvju+JrI=;
 b=UFlDN21aMqFmRK3oaPS37hGXAPdt3k3xMCH5/cOUwShNsnG1pHonyGbW
 adhoD1/2mBn7IvLZNMPRvq0i0xc76ckJqZPX/HiLMKIZwVGUGtaD0sJ9Z
 DRtcKi0MrXudHLjLGBxUPB1gyMwi+X+1PLZhituz8cztmZWhzgFuj/24f
 NCLVnw1vp135H1f1+HHvSrt5wF5TX+vWvolefPfsSY6t+A6h9B8b0Xo5Y
 +ceafZGc4kpYt3XDDVIYyCwiTPbDBA3bvMXTx7dxP4ucHLcMQyxmT15FM
 +y83F2dy2LY6li6oIG+HvQIL4LLsSLHhY8xG3Bf1C+xBQwckdUdDhE4JT Q==;
X-CSE-ConnectionGUID: Bh23wO6dTZyeBp+ljD0Fvw==
X-CSE-MsgGUID: QosFYfeDQ2qdoeZRQJcoeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2843604"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2843604"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:10:47 -0800
X-CSE-ConnectionGUID: 4fBXfPgtRFGEsMcsVR789w==
X-CSE-MsgGUID: Z21x23CJTFGEmtrWRwK2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7683709"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.139])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:10:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] drm/xe: Remove driver side resource assignment after BAR
 resize
Date: Mon,  9 Nov 2026 15:10:09 +0200
Message-ID: <20261109131011.1815-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pci_resize_resource() assigns the resized BAR and the other BARs it
released, or restores the original configuration on failure. Calling
pci_assign_unassigned_bus_resources() after it is redundant. If that
call manages to assign more resources in some scenario, the problem
should be fixed inside pci_resize_resource() instead.

Remove the pci_assign_unassigned_bus_resources() call from
xe_pci_rebar_resize().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_pci_rebar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci_rebar.c b/drivers/gpu/drm/xe/xe_pci_rebar.c
index 7e2c7079b6ff..f47b3c039abd 100644
--- a/drivers/gpu/drm/xe/xe_pci_rebar.c
+++ b/drivers/gpu/drm/xe/xe_pci_rebar.c
@@ -100,7 +100,5 @@ void xe_pci_rebar_resize(struct xe_device *xe)
 	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd & ~PCI_COMMAND_MEMORY);
 
 	resize_bar(xe, LMEM_BAR, rebar_size);
-
-	pci_assign_unassigned_bus_resources(pdev->bus);
 	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
 }
-- 
2.47.3

