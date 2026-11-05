Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84A60707A8
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=B8xpVXrr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3050B11290F;
	Thu,  5 Nov 2026 15:55:33 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A252111290E;
 Thu,  5 Nov 2026 15:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793894117; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CR2pennS5hSbWsFNmP77+NJWpOZsPJC0Uaj/YPAW2kmnuMLpFxNpTTH6KmvOyxKYUGxAkMEdf8zScqXRVRhdrnfaoBQuJL2NQ7TsWZO874UDtW+Ro2YqBs7tz2rsJaYL+OuYZ4syfJeyy0ReXS7oIrMt/JQYFr/rLs5NnJ3kjk4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793894117;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tVNwYKMhk2/WnrIZ19upJetFcNs7CUL1Pr30OK/rV9s=; 
 b=AJg3rcecPL1vPnfYJ0PawUJipTuMxvcOJLJH7RoshWzWPz+mLoREmsbs43PAWxVKj1IHiVwcj3pgH6RCv/P9EFXKeKp04LHbpa3atUkgPDSZH1XyImOIZo71CVOUQpx9iyPwcD7TbXJoEsI7gIAC3tgloDNTX6gfU24cZnih2eE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=B8xpVXrrrydEK2W4qItNLZsmWHehtPHQN+tJwM9U4qG2heDbFs7i7woYk2Yet8XdDGgIoM7KWsGZUxBdl8sg9rk9Khy8v87trvQ8+8fDQMZsMrGITRsnAItDXAeD4jHvIryGuOKTE95+/Imq54Hd77b0G0vlcSklkUqn7KY3bzM=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=tVNwYKMhk2/WnrIZ19upJetFcNs7CUL1Pr30OK/rV9s=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894116497649.6985151835922;
 Thu, 5 Nov 2026 07:55:16 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:17 +0100
Subject: [PATCH v2 26/27] drm/debugfs: Expose HDMI VRR in vrr_range debugfs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-26-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
In-Reply-To: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IGT requires the vrr_range debugfs file for running the tests, for
better or worse.

Since Commit 014da1db5e64 ("drm/edid: parse HDMI 2.1 gaming (ALLM/VRR)
capabilities from HF-VSDB") parses the HDMI VRR minimum and maximum
numbers into separate members and not the display_info.monitor_range
member, this debugfs entry needs to use those members when the display
is HDMI and does HDMI VRR.

Add this special casing, and also protect accesses to connector->status
and connector->display_info interruptibly with the mode_config mutex.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_debugfs.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index a72f9723d3a9..476f44642ac3 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -586,12 +586,26 @@ static ssize_t edid_write(struct file *file, const char __user *ubuf,
 static int vrr_range_show(struct seq_file *m, void *data)
 {
 	struct drm_connector *connector = m->private;
+	u16 min_vfreq, max_vfreq;
+
+	scoped_cond_guard(mutex_intr, return -EINTR,
+			  &connector->dev->mode_config.mutex) {
+		struct drm_display_info *info = &connector->display_info;
+
+		if (connector->status != connector_status_connected)
+			return -ENODEV;
+
+		if (info->is_hdmi && info->hdmi.vrr_cap.supported) {
+			min_vfreq = info->hdmi.vrr_cap.vrr_min;
+			max_vfreq = info->hdmi.vrr_cap.vrr_max;
+		} else {
+			min_vfreq = info->monitor_range.min_vfreq;
+			max_vfreq = info->monitor_range.max_vfreq;
+		}
+	}
 
-	if (connector->status != connector_status_connected)
-		return -ENODEV;
-
-	seq_printf(m, "Min: %u\n", connector->display_info.monitor_range.min_vfreq);
-	seq_printf(m, "Max: %u\n", connector->display_info.monitor_range.max_vfreq);
+	seq_printf(m, "Min: %u\n", min_vfreq);
+	seq_printf(m, "Max: %u\n", max_vfreq);
 
 	return 0;
 }

-- 
2.56.0

