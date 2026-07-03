Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F90C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C8D10E646;
	Fri,  3 Jul 2026 16:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="Adc/QN9m";
	dkim-atps=neutral
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9457010E646
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
 References; bh=Njtjf1i80jiwsx4tH+XPD/0oObtiwzZtrIXREWvC9jI=; b=Adc/QN9mgdZ21I
 nXX5EgwMx04HUhu48Let/InbZuHlpFMdMw8uviTAwmJacGu61FpkDWV++00yYfSpjXWFFmQM4MlSO
 V8EWNCGst5/HoaOxYPBT8X2v+Kf9Qeq3goULW87cuwLU1WGLaw0gCCTH+AQSEQt5G7CMqKPegR5YI
 r+fQVnzgF2r7Yf758HujVN0nyweawvg+oora2EfPoFqrEv4RcY1Bucz636tM5Nrty/M+JhZXwTWBy
 dAzeNVsqNlqnTD/DD+tiWvjezRcHBknNfXsvUQCKbDgNTU6XU0j6gIdVrbkxaF6HyPfulESBsL3na
 QEWw/ItH5iTDctsTAIoA==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1wfgg0-00BZLx-Dv; Fri, 03 Jul 2026 17:23:40 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
 (envelope-from <ben@rainbowdash>) id 1wfgg0-0000000BwuK-0Ww1;
 Fri, 03 Jul 2026 17:23:40 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
 Alessio Belle <Alessio.Belle@imgtec.com>
Subject: [PATCH v2] drm/imagination: make pvr_fw_trace_init_mask_ops static
Date: Fri,  3 Jul 2026 17:23:38 +0100
Message-Id: <20260703162338.2848039-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
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

The pvr_fw_trace_init_mask_ops is not used outside pvr_fw_trace.c
so make it static to avoid the following sparse warning:

drivers/gpu/drm/imagination/pvr_fw_trace.c:74:31: warning: symbol 'pvr_fw_trace_init_mask_ops' was not declared. Should it be static?

Fixes: c6978643ea1c ("drm/imagination: Validate fw trace group_mask")?
Revied-by: Alessio Belle <Alessio.Belle@imgtec.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v2:
  - added fixes tag
---
 drivers/gpu/drm/imagination/pvr_fw_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index 6bb5baa6c41b..805d9f9bc1dd 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -71,7 +71,7 @@ pvr_fw_trace_init_mask_set(const char *val, const struct kernel_param *kp)
 	return 0;
 }
 
-const struct kernel_param_ops pvr_fw_trace_init_mask_ops = {
+static const struct kernel_param_ops pvr_fw_trace_init_mask_ops = {
 	.set = pvr_fw_trace_init_mask_set,
 	.get = param_get_hexint,
 };
-- 
2.37.2.352.g3c44437643

