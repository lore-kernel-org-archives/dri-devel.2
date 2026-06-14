Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C5ACD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 14:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 325DD10E0A0;
	Sun, 14 Jun 2026 14:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="aa7BqSPW";
	dkim-atps=neutral
X-Greylist: delayed 413 seconds by postgrey-1.36 at gabe;
 Sun, 14 Jun 2026 14:30:36 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28C410E0A0;
 Sun, 14 Jun 2026 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kA
 dOHfVqDF74w3XFEUTLT8kIauibT8ourgUuTIUthpI=; b=aa7BqSPWBx+ZsHbuj9
 6Wu9SQatN3VxQpQ3q5QN/229UPfEDZrGX+fHr+RseAJaL93yhtdIDNnGquBwFSJK
 y5+Xq0JGTx650zr8OwMFOucCbJRzmF3zkIvmtn68ZNcaVZoiMbm+sJoRclLfrw2S
 gT2Pshk+6puKmMsEDbwAumDaM=
Received: from ubuntu.. (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDH1uI8uS5q3zRWDg--.41766S4; 
 Sun, 14 Jun 2026 22:22:56 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, hansg@kernel.org, vivek.kasireddy@intel.com,
 matthew.d.roper@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, Ma Ke <make_ruc2021@163.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/i915/dsi: fix i2c adapter reference leak in
 i2c_adapter_lookup()
Date: Sun, 14 Jun 2026 22:22:49 +0800
Message-ID: <20260614142250.2001136-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDH1uI8uS5q3zRWDg--.41766S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4Dtr1xJw15Gw13Jw13Arb_yoW8JFW8pr
 W7WFWUCrWYqF92q3y7AF1UuFW7uayIy3s3KFZ7Cw13uF1kuw18Jr9YyrW2gFyDWa9rXa1D
 trnrJ3yUKFyjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMc_-DUUUUU=
X-Originating-IP: [202.112.113.208]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC1ACkr2ouuUArbQAA3k
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

i2c_adapter_lookup() acquires a reference on the i2c adapter through
i2c_acpi_find_adapter_by_handle() but not releases it.  Each
invocation of this ACPI resource callback leaks one device reference,
potentially leading to resource exhaustion over repeated driver
load/unload cycles.

Calling path: i2c_acpi_find_adapter_by_handle() -> bus_find_device()
-> get_device.

Found by code review.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Cc: stable@vger.kernel.org
Fixes: 8cbf89db2941 ("drm/i915/dsi: Parse the I2C element from the VBT MIPI sequence block (v3)")
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index fe12041e913c..2097c5d17cb7 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -460,8 +460,10 @@ static int i2c_adapter_lookup(struct acpi_resource *ares, void *data)
 		return 1;
 
 	adapter = i2c_acpi_find_adapter_by_handle(adapter_handle);
-	if (adapter)
+	if (adapter) {
 		intel_dsi->i2c_bus_num = adapter->nr;
+		put_device(&adapter->dev);
+	}
 
 	return 1;
 }
-- 
2.43.0

