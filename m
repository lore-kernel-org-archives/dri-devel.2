Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C7606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=N+ZMFoBX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F70C10FCD6;
	Wed, 21 Oct 2026 08:53:02 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0024E10F65F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:19:51 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so607122f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1792509590; x=1793114390; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4+dMbq4L94+2qmZ/kkxC5lVbK6QouDyt/ZY60T+Sqjo=;
 b=N+ZMFoBXEbzetKx6bTqHAUeLINvsuukRT8tbz3Diwm4VeOuQiVQ4ZMDGImpuf2eg2U
 tks9wd89RZseZuxkJXCVVBEJHOtrnpQRrDUw9FCFZtRKxWW0iatvHQJNrC4pVJmUbkKt
 FIXI9xZXMiubYrwkbwAldLkBfybOGSFCI1peSfKjMmQe8gYbL86odDQvgsvhwOGgiRhw
 ZkzkXHETtiwOBZ/BHaxmqw3iXaQoGSZ/7HCOYrIvs2znGjtzBkEwXVgans8O2aVVAFUn
 npN2ksIvTxVFyxlLWH9OoOm4Znv14qTVuqCA/bv2V6t1wmFIESnp9liAkt+R31KnCdo8
 okHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509590; x=1793114390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4+dMbq4L94+2qmZ/kkxC5lVbK6QouDyt/ZY60T+Sqjo=;
 b=1/GEsqbjN0mZQi3N1cKBj1AlW8xXQHkKJEU3Pi15jToTuKailxO4fT9XHOzBLRYqFx
 6B1sKFTDjaxSryVIfM6faxn9de75NrvKWRSNOVmI+NLHlNjsGv4nFIE7n4gckbBGIcch
 sIN11j5JmhojU6YxSJAGYR9JxC4ZdCpl/GOXDinoEQr6Sb/JI3IiQCVPrux7yC2IUmhr
 HME0Z5nia5IWRN3jv/rBmTw3MvlYf83WOlWZwZSj88w42OH/d7qbylL/INvQUhDFMOxL
 fO4/UAvVamwUfSE3sZyl5TvijEjmLNOmYrRKN7s03QTJePrd48ZDPTRmVoWlmVR8NO1G
 JSlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/2Cu+PLznevZ7jJ1M9YwxCxFU538SGh7evDH3+WXlIeFIEdEZakpxz43VNVn9hPMb8S8BeoZ6wek=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJVX5ztqVEITUl3BnL54v+XXOotjlsnvXmxM0lyAZHzPHM/O5H5
 0Ya4Dy+YdDhUsjzWHGuHGQeDU7Vb3g2OCIyDKHOD5pz6MxULFGgzABSuQeIqcZ/FKbcrDuyrOax
 20PbEp5QxhTUYnOpLKStiFycEmgnEapAtC0VNyxRdi9xnfafGdVryZ7+63D7kplTT7FRx2//t90
 71VcL96f5EPcIsobvMYCBRm1R0OeBG1TWejca2w/as5rKATD9IBnH6NldVIxOSyywA3Yg8US2lK
 hlU7zcN3YTBT12Y+SK0Rb/TmjA=
X-Gm-Gg: AYBFou22JJu/liS+PWI5BKnjLNGHM+Fj/cnv/8+oFxtq/RrsFSDPVVsme30fC6JHktW
 507VWn6p2kIT7gDd04jsBqKXkN1A1z/PI+DEA3GGaz3VB6lYNOg/q6cFhhQenAB6+LWNcXRgbMD
 PfuR+p7EzXEPTFk033MisK/VIkr9ZJAeP7jwk8zkcuWWxGaHB4pCp24SenDOW3ZpWlgzMUytdGT
 pb4mgnf/vYGONyND83fsBGWDkwGOh2jRS7UfRsH3D+MgSil22E7MYT6PgxiL/khxIeD5LvIhGqW
 NqX3xEqnrFAtYMehGDwg/g8iTIhBcJoLpps5JYx6qxtd4AS6NnDQ2MvEA8B80Dj9XRpd7LRucr8
 FoSR2DvY3VMgHKvSVCO6R0R3vhIpfLlkpy+t/OLrFpG7oHAw7tDTgvoPHZWlGsoo/5tWjvmuaCa
 Zs6GD8EvP+6JnWyDxRm6/q/COLBYIl4RFKpAiBnGfdij59Y+g6BI2TL90nGpRmPYpOtp9iLvM3K
 B5nA5A=
X-Received: by 2002:a5d:5d86:0:b0:48e:d40:a87c with SMTP id
 ffacd0b85a97d-48e1e7cc307mr6188979f8f.16.1792509590285; 
 Tue, 20 Oct 2026 08:19:50 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d817d80sm7410663f8f.26.2026.10.20.08.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:19:49 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/vc4: Implement vc6_hdmi_phy_disable
Date: Tue, 20 Oct 2026 16:19:46 +0100
Message-ID: <20261020151948.83459-2-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020151948.83459-1-lucas.tanure@neat.no>
References: <20261020151948.83459-1-lucas.tanure@neat.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dom Cobley <popcornmix@gmail.com>

The body of this function was missing so we don't reset the phy
when disabling it.

Fixes: 0b1dbe82e051 ("drm/vc4: hdmi: Add support for BCM2712 HDMI controllers")
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>
---
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
index 56e6a35da357..5040f014bf7e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
@@ -1197,4 +1197,9 @@ void vc6_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi,
 
 void vc6_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
+	vc6_hdmi_reset_phy(vc4_hdmi);
+	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 }
-- 
2.56.0

