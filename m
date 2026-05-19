Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1B4CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57D610ED4F;
	Tue, 19 May 2026 14:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bN3ZXwji";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05B010ED56
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779202059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLSJynfj/SfMKra6MuoVzzg6ibW6tvdwMbY0XP2994w=;
 b=bN3ZXwjipU7jfjtTm98DM2CtuZkQqVELwocd1XY+x4bs+KP/5xw7lpnWULE58zv3CxXST9
 ktS4zTXE/S10f5U2ZlbrJJ33Tu8NB13S+lhJcLOm1JEeXbsbZveJdvyvmFyAniIbfA3FI/
 oilRyUX/CxWfoMn+q9VVtwhRdvPGYxk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-yCs6ucHtNOCmZZfdIg90LQ-1; Tue, 19 May 2026 10:47:37 -0400
X-MC-Unique: yCs6ucHtNOCmZZfdIg90LQ-1
X-Mimecast-MFC-AGG-ID: yCs6ucHtNOCmZZfdIg90LQ_1779202056
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso3137609f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202056; x=1779806856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZLSJynfj/SfMKra6MuoVzzg6ibW6tvdwMbY0XP2994w=;
 b=Q4a4UKhPrTdIGqCmMZDxoaJu29gz5hHB+31JS3kBWGnzYLiabbtR1ILTJ8JkqpMfnH
 DeEr/1e4OtnINTWi5hWIz+IqDWKERyngcbfmSLz4z8nsxdi40oVgseubke98SfXaO+LR
 oMdixxSvy/dMH817LN5z4jhTOtMRyIzjJ87ho0UcjIAsVvn6IepUP05pvTaXlwxX1Spx
 w4nUhMb4QZRPjSwlvRA1R2QBTtE14JKRbKF7Dc1zlNxKZxwJ7NDbsfafhTChu4ChWqEq
 dPA/4DJIwqbhPFc02UqC4Efspq1Y40l06gAxQnPVXLbbfd1fzL6LiZ9teydbyvoPUMgN
 yA9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cRnir9TwQXDsW0Zr1Oc/s3/XSeAhXEFp85mGT1Rac+u7/dz+FACUQPCzDRMu8SoeUOPm4Baujv9Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4P17lG/9Lz51KnTCQNzEcGRPhhpKTMvviC7ERGbqAlgEongEP
 gQ1DhAEVhjvLF7xsuB5iWPK9CabtsWIJhPCth0DA70u2RZ8boP7l4C4CenzUyfdGRelNsfGvEUQ
 IrbG0ibPBga0T/auhP8T5QiSJQZU/xQ685JMpMmMaYZuy9h/cOx6gqVLfqtfwGrPHYRQmvw==
X-Gm-Gg: Acq92OGssvh7aw8yvZ9E4qWZtF6Af6+7aRX/GoqGoFk5R3p+Tn4lsUrimeGPzqqR5c2
 YYk72uBNoqOJxgCd8GJ/S5uqLIplYkJtO6lz4grHSH33Po69JvL+H2MQjzGVt13/do1OYfhkM3j
 FU1mWLMh7gcUaId9CKrbpgpRIIMKux/XvmNB6dLrWzeQqhQg9FqBSwz2TU6+6vSupl0JWvma7uj
 GgcZ6UMxNJPpkl2dG1PcEwSV3O1UgatHQ/n9OFJFtqOqosd7y0sY6LP6jGqkV/mcjyphMVLioEM
 1/+pxBDQC9xDmvgAzElfwFidoZqCW7sNMiu0AbKPN3YmyyPdGoWOm5ws8DG8hYm+PYECliPx+iI
 bt07gS/mcc2CmrEuzm0yQ2pKwBibDWuY+hmzNRYi6YiuwBSI=
X-Received: by 2002:a5d:64c6:0:b0:446:708e:1e8d with SMTP id
 ffacd0b85a97d-45d955021f5mr37986701f8f.30.1779202056258; 
 Tue, 19 May 2026 07:47:36 -0700 (PDT)
X-Received: by 2002:a5d:64c6:0:b0:446:708e:1e8d with SMTP id
 ffacd0b85a97d-45d955021f5mr37986653f8f.30.1779202055797; 
 Tue, 19 May 2026 07:47:35 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2f738sm45113118f8f.16.2026.05.19.07.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:47:34 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Samuel Holland <samuel@sholland.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 6/8] drm/sun4i: hdmi: Use the common TMDS char rate constant
Date: Tue, 19 May 2026 16:47:02 +0200
Message-ID: <20260519144712.1418302-7-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519144712.1418302-1-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IUespcnNTc-totvgubY-NeC3tP3iIXBGn6ALUDDT8-o_1779202056
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Replace the 165000000 magic number with the shared constant defined
in the <drm/display/drm_hdmi_helper.h> header.

The old comment referenced "HDMI <= 1.2" but 165 MHz is actually
the maximum TMDS character rate defined by the HDMI 1.0 spec.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 07e2afcb4f95..723a6a11c94e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -189,8 +189,8 @@ sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector,
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
 		return MODE_BAD;
 
-	/* 165 MHz is the typical max pixelclock frequency for HDMI <= 1.2 */
-	if (clock > 165000000)
+	/* HDMI 1.0 max TMDS character rate */
+	if (clock > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0)
 		return MODE_CLOCK_HIGH;
 
 	rounded_rate = clk_round_rate(hdmi->tmds_clk, clock);
-- 
2.54.0

