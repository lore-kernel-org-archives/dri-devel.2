Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5C7CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBBA10E0EC;
	Sun, 10 May 2026 10:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="eo6iC6XZ";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2789E10E09C
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
 Message-ID:Date; bh=7nY8bbpnmeu2LuUe3UlRYz1YYTlxMg6MG2wDblyfVdk=;
 b=eo6iC6XZoS/6m/5V3TfBOQnc1CEVw29zSOqtekSAG7lfcV9/aJ3jzZfa90LWM7
 lJqpEMs/Btmx+tsK6eJXIqJjfvyWmrt+V2dX/yBhvJ9oeaIN7vKJ1aMYu3cH2FZe
 HIiOAQqyV19ubRXBwc7qg+lPQtw8psVmu8U2ZlxHtNW1c=
Received: from [127.0.1.1] (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wBnHxd88f5pRVN0AQ--.35430S2; 
 Sat, 09 May 2026 16:34:05 +0800 (CST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Jiaqi <shijiaqi_develop@163.com>
To: dri-devel@lists.freedesktop.org
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] drm/rockchip: Check return value of cdn_dp_grf_write()
 in error path
Message-ID: <177831564430.322716.2622130527771792842@163.com>
Date: Sat, 09 May 2026 16:34:04 +0800
In-Reply-To: <177831560568.322716.7926332149561323511@163.com>
References: <177831560568.322716.7926332149561323511@163.com>
X-CM-TRANSID: _____wBnHxd88f5pRVN0AQ--.35430S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1kCFyDKFWDCw1UJw1UZFb_yoW8Gry3pw
 4DJ34YvFZ29asrJayxKa48JrsYgayUZr4I9r97Cwn2v3W3Cr4ktr9IqF12qF4fXrs2yFyI
 yF4kJryrJrs0vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUfHbUUUUU=
X-Originating-IP: [42.63.126.112]
X-CM-SenderInfo: xvklyxpdtlsvxhyhz0rs6rljoofrz/xtbCzR21CWn+8X0oggAA3d
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

In cdn_dp_enable_phy(), when an error occurs after the GRF register has
been set to DPTX_HPD_SEL, the cleanup path at err_phy calls
cdn_dp_grf_write() to restore DPTX_HPD_DEL, but the return value is
ignored.

If this restore write fails (e.g., due to a bus timeout or GRF power
loss), the GRF register remains in the DPTX_HPD_SEL state. This leaves
the DP PHY control in an inconsistent state, which can cause subsequent
DP link initialization to fail or produce undefined behavior.

Fix by checking the return value of cdn_dp_grf_write() in the error
path and logging an error if it fails.

Signed-off-by: Jiaqi <shijiaqi_develop@163.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 8afabe2118a9..1234567890ab 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -425,8 +425,9 @@ err_power_on:
 		port->phy_enabled = false;

 err_phy:
-	cdn_dp_grf_write(dp, GRF_SOC_CON26,
-			 DPTX_HPD_SEL_MASK | DPTX_HPD_DEL);
+	ret = cdn_dp_grf_write(dp, GRF_SOC_CON26,
+			       DPTX_HPD_SEL_MASK | DPTX_HPD_DEL);
+	if (ret)
+		DRM_DEV_ERROR(dp->dev, "Failed to restore HPD_DEL: %d\n", ret);
 	return ret;
 }

--
2.40.0

