Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5804CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457B610EDD4;
	Tue, 13 Oct 2026 17:48:32 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D5610EDD4
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7A07B4E4120F
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4F46160362
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:19 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
 id 9B39711D7159B; Tue, 13 Oct 2026 19:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791913698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=i7DvJv6aN3h7IEYKi4oVl5rzMxjd2FsU0tIV7NHPlLE=;
 b=bV+Du7b45aNamHcuINT5E47/CPenbSnA8ZGAwMFsy0CzGlWGCFBIemrI25Z7yX9oPsTLXb
 WNQzyn9qWkIhmdREmZLJ4cxgTMuVC5BFAgCKhkRnCThuJl40vLk1PIXlR67mmevd8tEogt
 8dU6LTGboP7lRhHj0RjArgcV0+vs/8Sno/iUYlQQcSRRWux3cCisOUAIHsjS3HoZvUHDG8
 lbageR07sMnSNYFJRyQV3VADIEKbeqpLl9AIHQ/Xw/bnVh9gx8lh0ZH5Fv///fgiCYj6QO
 4q9BUUPB/EoNJvXoCt/zRnKtlqxEA1bkPKVS1EBd/q2s0kOZnAq8SZoclrQIqw==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253]) by 9e7fea892943 with LMTP
 id 0HigOQLvzGqxHxEAtaWaaQ (envelope-from <luca.ceresoli@bootlin.com>)
 for <luca.ceresoli@bootlin.com>; Mon, 12 Oct 2026 16:30:26 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8B07B11D70C1C; 
 Mon, 12 Oct 2026 16:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791815425; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=i7DvJv6aN3h7IEYKi4oVl5rzMxjd2FsU0tIV7NHPlLE=;
 b=NRuJnHojWKBYLYtw2PZuBZcxkecrmF1B7yx2gFkrTI6cdAb9IhhbIhfAFiQtOfy15SsZj9
 EjnvyTc8+G1tzPNq2UQDmqKLF+lZ937r3b4hVX2ERweQsKpd8BQdaKocBlr7ZUofWpxLvW
 oPzrFD/2XXwBMBzPuXyTn6MKRmeOFFMCCrre9fNUJRaWSTdiOOOgweAULt27g0p3Q9MFPO
 efML2xGfU7ha441i2JcEbzzuxnqX8SkxyLWoE9dY11S/cog7tlNJqR4PWLXlLwRbmOGIlI
 8pI2Xd7jg9av44ICjNtOoD2KO62QToJ/MNbGmn7np3o+vM90GE/iD0jwSejyYA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 12 Oct 2026 16:29:53 +0200
Subject: [PATCH 3/3] drm/drv: stop mentioning deprecated
 drm_of_find_panel_or_bridge() in docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-drm-bridge-every-panel-cleanups-v1-3-0fd272f486b6@bootlin.com>
References: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
In-Reply-To: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 9B39711D7159B
X-Spamd-Result: default: False [2.50 / 30.00]; SUSPICIOUS_RECIPS(1.50)[];
 DATE_IN_PAST(1.00)[27]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-0.00)[22.68%];
 BCC(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FORWARDED(0.00)[luca.ceresoli@bootlin.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
 MID_RHS_MATCH_FROM(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[luca.ceresoli@bootlin.com];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,bootlin.com:mid,bootlin.com:email];
 MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
 RECEIVED_HELO_LOCALHOST(0.00)[]; NEURAL_HAM(-0.00)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]
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

drm_of_find_panel_or_bridge() is deprecated. Update the "component helper
usage recommendations" docs by mentioning the currently recommended API.

Also stop mentioning drm_panel because now every drm_panel embeds a
drm_bridge and the drm_bridge API is recommended to access panels too.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 0cdc606af8d1..3f1b7faf5bef 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -695,10 +695,10 @@ static void drm_fs_inode_free(struct inode *inode)
  *
  *  - The component helper fills the niche where further standardization of
  *    interfaces is not practical. When there already is, or will be, a
- *    standardized interface like &drm_bridge or &drm_panel, providing its own
- *    functions to find such components at driver load time, like
- *    drm_of_find_panel_or_bridge(), then the component helper should not be
- *    used.
+ *    standardized interface like &drm_bridge providing its own functions
+ *    to find such components at driver load time, like
+ *    of_drm_get_bridge_by_endpoint() and of_drm_find_and_get_bridge(),
+ *    then the component helper should not be used.
  */
 
 static void drm_dev_init_release(struct drm_device *dev, void *res)

-- 
2.56.0

