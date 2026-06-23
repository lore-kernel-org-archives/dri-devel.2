Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADFCCDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84B010EA70;
	Tue, 23 Jun 2026 10:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cr3/0at9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30F310EA70;
 Tue, 23 Jun 2026 10:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782209717; x=1813745717;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G/k3h2BJE8WZumI5d6cXS3RO4xeI3jG46C8bYqPdoX4=;
 b=cr3/0at9GDN7exWq1xPu3m8RYLND6qoxhj+GqAblLS2H3p0w2Q7rrtBZ
 ygZtQx30qxUiZ9pfFrc3cBW8aPZutF0lQIcL7h+9jMP3/U5VVwCA9PkGt
 cOr4VgGBLpjCo8hjZPNRjSkndegxsrzb4LRtaolKR69tnm4MlKflYtKev
 sasBWLYngLFpdlfaB+vbduqXrawxFt55nwIPa8pXPIGbZ5Q553dX2KHne
 jgo9dopSOKFqv0437lBtLGmxzPXjRzlzdrR4QjdmeTGgdaizHLLYlIEV7
 5qPpwbMujg8N+IMs9txCl3FirqbB1BfvOeZyPC0wvSWbGIP0ViUhEh+jR g==;
X-CSE-ConnectionGUID: DWX9KaFLS6KelCWuvvhcgw==
X-CSE-MsgGUID: iPaH1Th+SS6LfwxBJKHK3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82053222"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82053222"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 03:15:17 -0700
X-CSE-ConnectionGUID: VvmRnpGlSoWwUSctelntNA==
X-CSE-MsgGUID: zBiRPfLIQeym9/bvLKew2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="273175572"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa002.fm.intel.com with ESMTP; 23 Jun 2026 03:15:12 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, dev@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, mallesh.koujalagi@intel.com,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 5/5] drm/xe/sysctrl: Reuse xe_sysctrl_create_command()
Date: Tue, 23 Jun 2026 15:39:59 +0530
Message-ID: <20260623101043.255897-6-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623101043.255897-1-raag.jadav@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
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

Now that we have a helper to create sysctrl command, reuse it for
threshold crossed events.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_sysctrl_event.c | 28 ++++++++-------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sysctrl_event.c b/drivers/gpu/drm/xe/xe_sysctrl_event.c
index b4d17329af6c..0547b7b39726 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_event.c
+++ b/drivers/gpu/drm/xe/xe_sysctrl_event.c
@@ -49,18 +49,6 @@ static void get_pending_event(struct xe_sysctrl *sc, struct xe_sysctrl_mailbox_c
 	} while (response->count);
 }
 
-static void event_request_prepare(struct xe_device *xe, struct xe_sysctrl_app_msg_hdr *header,
-				  struct xe_sysctrl_event_request *request)
-{
-	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
-
-	header->data = REG_FIELD_PREP(APP_HDR_GROUP_ID_MASK, XE_SYSCTRL_GROUP_GFSP) |
-		       REG_FIELD_PREP(APP_HDR_COMMAND_MASK, XE_SYSCTRL_CMD_GET_PENDING_EVENT);
-
-	request->vector = xe_device_has_msix(xe) ? XE_IRQ_DEFAULT_MSIX : 0;
-	request->fn = PCI_FUNC(pdev->devfn);
-}
-
 /**
  * xe_sysctrl_event() - Handler for System Controller events
  * @sc: System Controller instance
@@ -72,16 +60,16 @@ void xe_sysctrl_event(struct xe_sysctrl *sc)
 	struct xe_sysctrl_mailbox_command command = {};
 	struct xe_sysctrl_event_response response = {};
 	struct xe_sysctrl_event_request request = {};
-	struct xe_sysctrl_app_msg_hdr header = {};
+	struct xe_device *xe = sc_to_xe(sc);
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
 
-	xe_device_assert_mem_access(sc_to_xe(sc));
-	event_request_prepare(sc_to_xe(sc), &header, &request);
+	xe_device_assert_mem_access(xe);
 
-	command.header = header;
-	command.data_in = &request;
-	command.data_in_len = sizeof(request);
-	command.data_out = &response;
-	command.data_out_len = sizeof(response);
+	request.vector = xe_device_has_msix(xe) ? XE_IRQ_DEFAULT_MSIX : 0;
+	request.fn = PCI_FUNC(pdev->devfn);
+
+	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_GET_PENDING_EVENT,
+				  &request, sizeof(request), &response, sizeof(response));
 
 	guard(mutex)(&sc->event_lock);
 	get_pending_event(sc, &command);
-- 
2.43.0

