Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB3606BE83
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=kQP8xFig
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D519112855;
	Thu,  5 Nov 2026 15:54:40 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05FA4112854;
 Thu,  5 Nov 2026 15:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793894067; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MFsFdQgnegm1B3xQ8huk7GZLc4TUC3KxCXfA9bIAiy9iBmjsxQJwnPFVYr1gkl1xMv0LywG3IAdwU6OY+GoEg6GIkmpM1y3yitE7mq4mDbyqpMkwvHhbK/VsppZIXQ4z7F5kHg8dmojkmPeWWyJPFpwMSgalzX8ecjE5U+WdUzw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793894067;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VSQNShoB0NRUJv6LH1J7WdPfdRWQNf3+ZOl8d69TG6Q=; 
 b=enbBslQS4Hcyt8BocoexXCoAWDT6h1/pMBjf6NJAVKB2rKsJRS1BV4dj1uiAxYpMvPkTGtdMBmYSAlOVNLS4rEyueGPYpVSc59aY52CbBp/hLR7BU/XuYKYdEoybbqY8ofzaFAnY7Q5XtzCl5cU3yosdqIDWSTx2c5Co53nhqw8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=kQP8xFig6aOPYeuyosbN72pQeWl5WEcYA53Fe34V8KiBDKpXwHHJGEzoTSxEkVM4mjSiw7mH/WKENojMGdmYDUkvL/KbrcYnK8eip/sK+bxCA5Jja7o5ZHi+x1296zjdGKVkhzmyL2gWjERVRK03I1oV9yhI+YOSr/wYmCTgOxo=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=VSQNShoB0NRUJv6LH1J7WdPfdRWQNf3+ZOl8d69TG6Q=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894066538358.0060003364383;
 Thu, 5 Nov 2026 07:54:26 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:09 +0100
Subject: [PATCH v2 18/27] video/hdmi: Add support for QMS in VTEM EMP packing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-18-55f4215be2c2@collabora.com>
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

Add the necessary struct members and packing code to allow the
hdmi_emp_infoframe_vtem_pack function to write VTEM packets with HDMI
Quick Media Switching (QMS) data.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/video/hdmi.c | 6 ++++--
 include/linux/hdmi.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index ed9abc7ad228..c164f69a646a 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -1994,7 +1994,7 @@ ssize_t hdmi_emp_infoframe_vtem_pack(struct hdmi_emp_infoframe_vtem *vtem,
 	ptr[1] = BIT(7) | BIT(6);
 	ptr[2] = 0;
 
-	ptr[3] = BIT(7) | BIT(2);
+	ptr[3] = BIT(7) | BIT(2) | (vtem->qms_en ? BIT(1) : 0);
 
 	ptr[4] = 0;
 	ptr[5] = 1;
@@ -2005,10 +2005,12 @@ ssize_t hdmi_emp_infoframe_vtem_pack(struct hdmi_emp_infoframe_vtem *vtem,
 
 	/* This is where the VTEM part starts */
 	ptr[10] = (vtem->fva_factor_m1 << 4) |
+		  (vtem->qms_en ? BIT(2) : 0) |
 		  (vtem->m_const ? BIT(1) : 0) |
 		  (vtem->game_vrr_en ? BIT(0) : 0);
 	ptr[11] = vtem->base_vfront;
-	ptr[12] = vtem->base_refresh_rate >> 8 & 0x3;
+	ptr[12] = (vtem->next_tfr << 3) |
+		  (vtem->base_refresh_rate >> 8 & 0x3);
 	ptr[13] = vtem->base_refresh_rate & 0xFF;
 
 	return 14;
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 71e2b36896af..8eaa127f0cb5 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -243,10 +243,12 @@ struct hdmi_emp_infoframe_vtem {
 	unsigned char length;
 
 	bool game_vrr_en;
+	bool qms_en;
 	bool m_const;
 	unsigned char fva_factor_m1;
 	unsigned char base_vfront;
 	u16 base_refresh_rate;
+	u8 next_tfr;
 };
 
 void hdmi_avi_infoframe_init(struct hdmi_avi_infoframe *frame);

-- 
2.56.0

