Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD525606D804
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a0YKVZJO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1434A10E8AA;
	Mon,  9 Nov 2026 13:10:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A617210E8AA;
 Mon,  9 Nov 2026 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794229823; x=1825765823;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MIxBSmzDBepqTU2DTXW7tfzJLCR9DCC+4Y6znsrqrMY=;
 b=a0YKVZJO2wz+OZaamVF98vntkPik2sQ8pw7wstL/FyW6MqkfzfDpD8QZ
 5FVsD+hcD9SVgWcsBTQCbhkBRRmN0wJFxntWCFNYXBDwdPnTUTeeVaI8x
 B/9OWJRmn+V7KKjEQ3HtpNC7Z1X07YKDLC/+QlhzLkA3QnFmxsCRo1mnV
 ePDwtdYVy6/nNdXD/tHi8Ho5qu3UbHI1iAbWTozi3eiz3a9OG3lNED1aA
 99WaWXiZJ/OiWvvOAEzakbdys8ZGgRfOtqbQx+UwbSzXfm2LckTF8pjgc
 xQf/fxHCcN/wKI/rBgZnxlVC4bVRYY9QrcFkswCU8TYpWm5CNbvlf60vN Q==;
X-CSE-ConnectionGUID: JLPBKmutRPGaSOamdI9AmQ==
X-CSE-MsgGUID: LD4RsFncTfWRSciViUMcEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="3052219"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="3052219"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:10:23 -0800
X-CSE-ConnectionGUID: lyKUtdNAR0SkpkMCqLgrRw==
X-CSE-MsgGUID: rDXvF2QkR0aXbw7i3v3x2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8002741"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.139])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:10:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] PCI: remove redundant resource assignments done after BAR
 resize
Date: Mon,  9 Nov 2026 15:10:07 +0200
Message-ID: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The BAR resize rework removed the resource assignment call that
followed the BAR resize in amdgpu. The xe and i915 drivers and the
PCI sysfs resize interface still make the same call.
 
The current BAR resize code should properly assign all resources and
handle fallback gracefully so a driver-side call to assign resource
right after BAR resize is just duplicate work (no-op). If that isn't
the case somewhere, the fix belongs either the BAR resize code or the
code that left the resource unassigned (e.g. a hotplug race or whatever
left an resource unassigned prior to resize).

If drm wants to take their patches out of these, it's fine with me
(either drm+pci or through pci tree only works for me).


Ilpo Järvinen (3):
  PCI/sysfs: Remove resource assignment after BAR resize
  drm/xe: Remove driver side resource assignment after BAR resize
  drm/i915: Remove driver side resource assignment after BAR resize

 drivers/gpu/drm/i915/gt/intel_region_lmem.c | 1 -
 drivers/gpu/drm/xe/xe_pci_rebar.c           | 2 --
 drivers/pci/pci-sysfs.c                     | 3 ---
 3 files changed, 6 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

