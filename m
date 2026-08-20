Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336E1C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3756A10F1BB;
	Thu, 20 Aug 2026 22:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="Me5agFN+";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="XieaARD3";
	dkim-atps=neutral
X-Greylist: delayed 552 seconds by postgrey-1.36 at gabe;
 Thu, 20 Aug 2026 10:21:32 UTC
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F3E10EFC6;
 Thu, 20 Aug 2026 10:21:32 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 2869BEC011A;
 Thu, 20 Aug 2026 06:12:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 20 Aug 2026 06:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
 t=1787220740; x=1787307140; bh=sGNqTptE7s6gYdrLB8Z9LpMMoI+yyqIv
 9WSs2rN7GJ8=; b=Me5agFN+E8UF8H0Wp6vy/FgrkD/W2H5Kgfg81IO8JN3JNqFg
 sp9YaS1qz09HwTzWXY+w5MyW9bwHKhb0rjrM6rIYsjiWXSX1Slppyh0XnYoUdSio
 yH9otN71DwCgYZ7+NckQ2lw6NEutJkZQIlVvMTtWhNFbOnr9TGk2YFlocbSJmwci
 kwcWgaK00yj8wgO1d2q1PEy2Onl1JSfc2ETdEVS/rVymz9wNF7VWYCZUfyPyZPhr
 k8vftwI2KCkm7ZFCPeNyZg7kZp47wOQg84IO80D/PekszV7hX1hJvkD1R15i8OdX
 +vugVDDEfADOaq4moL1T37pINFREsyjcdvukBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1787220740; x=1787307140; bh=sGNqTptE7s6gYdrLB8Z9LpMMoI+y
 yqIv9WSs2rN7GJ8=; b=XieaARD342wcYHvjfXUJ0EC75HZFCzWAjP7lT2kW763J
 0xRj15oGd71EgVYSqHXTxRXQp0jy+afLbJKjmoO+JarTylrxVMdMalON9Yo7F9m8
 xYIA6LO9I4EEWfp4fbz6Y7d1dGeBkm53PjVBIctH7LwnN8wAZRXYWnUukrMvPULj
 TmMguAmAJSE8STJiKJv6Wv5x5SPSo6P+WNTx+wDq0EO38jP5+fJ8l+D6kxQ1r/W7
 Eh7JES6tnz6y0UW51tasqhlygGEXBgaX2pU3DnT7eF6QmrfmWr3Hsx2JVtYYDIFT
 rmg6ko8feWtpAygrAh+ey+nefHUkv8bmal359Varnw==
X-ME-Sender: <xms:A9OGalKiN3MqgffRbvzYQ0NGV0s7o64A3mLrm77PgIYltLiaGJscQg>
 <xme:A9OGajbN68jcWgUx0YNhZgfrEnVxh-dBdawnABnudO3FHCIo8_6tOVoxYy04Ns5l7
 p98eiENAUGzubIN4bFjUH7aiQexjX1KlsoFXN31ATrZFyz2WHk>
X-ME-Received: <xmr:A9OGav-_0FODOrJDz9FzmT546erxU0wvHnPF9PVFfh9itV3rHABHJgAFqD3j6GEDm5qsBXUIizJByQ>
X-ME-Proxy-Cause: dmFkZTGZPi6dpTYlHg6VIiYaWHMvOIezsDyxbHXjcalzNSEsRw8SzB0wyFhWhmZcQagGpE
 OlPNvgg4RMiUTnAebNy8Bpw976A2zZqzYqgOJ30OQloXKVKs9VrQcBADx9G5yD6PbcSMcy
 Qb3vxmzNDwb3mYrBCGbkhfbJv3Uel6h9lvZgqPDI9O9VGVzpP7/zJBrldxFNvmrM/4EGvM
 dtNgoFpV6ZLgsCP0XQjT/JVNu/0KxxjrVVuTOLuhZVpnuEbPoUmSvXXwVJPQtx7nKM3a0i
 KbGnzhOz6CgdcVt59ctG/y+o4XJDfbw6HDsE6QG/2npRTeB6IEOBTQRolBYc7zmfIkpENp
 FmtwyK+l7fsccfI+zWhXa/IUjMDTG92T/SPy0vZe63b1/L9ruYxPNKNNCl3kt/gKnxbK1N
 LB6vzSOHT1+R3rDmIDQGn0OudyEUl2IwvDVJ7QlVD1YlNzP5QTGE+qF/aNnU8Xf73AIMNQ
 KaJTBXl7oNaOugqf1OYExNef6XJGTJvxSRPwEEyM8cm4WPmKZ5R2K+529j50B63v48p7KJ
 oI2TSqnE5frJbIs6gLk8TNDGgl9gWv9xUti4wI1+qygBOHyw8ywppWbUCbYvWIabFZ+RmY
 jbqUm7xPG/WbkHVZKJfQi2fevtfeLjI6/1NtMZcquTBL2FtaA4WTGvTTqGBQ
X-ME-Proxy: <xmx:BNOGasZHJOxNtjUb6QP60v8EUhu2uZ4pVd7ZfZuBA8O7X_KJqLIJcg>
 <xmx:BNOGarNHK0payi0SADoD1knsXriPgmzJLh4RaJohWXDNSKhC40-dXQ>
 <xmx:BNOGagC5KRzxn_VNsOduUy50pe5uWMdwnZvWaTBB9e629n9cv9x7gg>
 <xmx:BNOGaqIg1HmnSJTlb4_p9f0KJe7GArjy9OnVOs6LamWCjmRTELioGg>
 <xmx:BNOGatd79R7eg2AEMjMnbNoj47tM_hPHdLPFBVNlg-PN43Aw8yqKSLG9>
Feedback-ID: i792e4853:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 06:12:18 -0400 (EDT)
From: =?UTF-8?q?Szymon=20Aceda=C5=84ski?= <accek@invisiblethingslab.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Szymon=20Aceda=C5=84ski?= <accek@invisiblethingslab.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV
Date: Thu, 20 Aug 2026 12:12:12 +0200
Message-ID: <20260820101212.1608543-1-accek@invisiblethingslab.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 22:53:16 +0000
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

Fixes display corruption on Xen PV dom0, where DMA buffers are not
guaranteed machine-contiguous, in which case bounce buffering kicks
in, breaking xe's memory coherency assumptions.

Apply the same workaround i915 carries in i915_sg_segment_size() since
commit 78a07fe777c4 ("drm/i915: stop abusing swiotlb_max_segment").

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8382
Link: https://lore.kernel.org/xen-devel/aYtznP_tT6xNPwf-@mail-itl/
Link: https://lore.kernel.org/all/20221020110308.1582518-1-hch@lst.de/ # i915 counterpart
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Szymon Acedański <accek@invisiblethingslab.com>
---
 drivers/gpu/drm/xe/xe_bo.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index e8081af..152bfcf 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -9,6 +9,8 @@
 #include <drm/drm_prime.h>
 #include <drm/ttm/ttm_tt.h>
 
+#include <xen/xen.h>
+
 #include "xe_bo_types.h"
 #include "xe_ggtt.h"
 #include "xe_macros.h"
@@ -575,6 +577,23 @@ static inline unsigned int xe_sg_segment_size(struct device *dev)
 	struct scatterlist __maybe_unused sg;
 	size_t max = BIT_ULL(sizeof(sg.length) * 8) - 1;
 
+	/*
+	 * For Xen PV guests pages aren't contiguous in DMA (machine) address
+	 * space.  The DMA API takes care of that both in dma_alloc_* (by
+	 * calling into the hypervisor to make the pages contiguous) and in
+	 * dma_map_* (by bounce buffering).  But xe (like i915, see commit
+	 * 78a07fe777c4) ignores the coherency aspects of the DMA API and thus
+	 * can't cope with bounce buffering actually happening, so add a hack
+	 * here to force small allocations and mappings when running in PV
+	 * mode on Xen.
+	 *
+	 * Note this will still break if bounce buffering is required for other
+	 * reasons, like confidential computing hypervisors or PCIe root ports
+	 * with addressing limitations.
+	 */
+	if (xen_pv_domain())
+		return PAGE_SIZE;
+
 	max = min_t(size_t, max, dma_max_mapping_size(dev));
 
 	/*

base-commit: b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6
-- 
2.53.0

