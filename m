Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC8CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7740E10F26C;
	Thu, 18 Jun 2026 11:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="aJg/Ih3P";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D4F10F26C;
 Thu, 18 Jun 2026 11:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gg
 0v4mNICq66S4WjgqT9Dzd0uw6VSyp4kHXR3khbLzk=; b=aJg/Ih3Pa18N/nWZAx
 0s0iTZ8+bJH/bXNherApom2TT970bn8Mc/2T5lUn6Puhq7whiEWqvwEx20gc3tH3
 YyBF7i5aEVIOH7yTb98JbgSPaIHW0V/zNmeQZsegbeX66vXYqkTG+hml+sWmlr5U
 Hk4LrbgMy0kUlVj+kcLVVqaHo=
Received: from ubuntu.. (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wD3t77P0DNqfkKHEA--.18129S4; 
 Thu, 18 Jun 2026 19:04:53 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, hansg@kernel.org, matthew.d.roper@intel.com,
 vivek.kasireddy@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, Ma Ke <make_ruc2021@163.com>,
 stable@vger.kernel.org
Subject: [PATCH v2] drm/i915/dsi: fix i2c adapter reference leak in
 i2c_adapter_lookup()
Date: Thu, 18 Jun 2026 19:04:46 +0800
Message-ID: <20260618110446.518501-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3t77P0DNqfkKHEA--.18129S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4Dtr1xJw15Gw13Jw13Arb_yoW8Gry7pr
 ZrWF4UCrWYqF9aqay7AF1UuFW7uayIy34rKFZ7Cw13u3Wkuw18JryFyrW0gFyDWa9rXa1D
 tFnrJ3yUKFyjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pES_MPUUUUU=
X-Originating-IP: [202.112.113.208]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9RXQ22oz0NWmMQAA3g
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
Changes in v2:
- Changed email to trigger CI, no code change.
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

