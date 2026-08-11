Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18187C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9E310EC4F;
	Tue, 11 Aug 2026 14:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FkSl1l8s";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8644410EC4F
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:33:59 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso34546885e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458838; x=1787063638; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0GQsznlQLpcSCbR7efR2aiMZyhiXOvWtEGgtbWbncU4=;
 b=FkSl1l8sFyvKEhyFODui/q5kZ8vb0A6u1A5O7tOsdEvdpB4yFdUlhAZh0bCOAospLs
 nEyOQfnQ3ARaZV19VP/LVBQ1MSu7hbcwuCDQB+QaWCHJCa8BcFO3/qerm13FKGWrHzog
 KjIt6Af/P/lUpAvJblf7FLT61DkVls5q6VkDSLvVvewgnclsppXQYgrCBfKZgN/JcWHD
 FnRV6L4SwsPYfJ7xbnbAa6/VDISjH/pVoahU2XyBdKZR7uwVvo+pZ/baskntTYR/SKSO
 WgMGTgB/daHGYCugWxMAUKxWs4zM8BWcya3zKi1n45jOzOT4AGimGkazYtfFfBno1DrX
 blgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458838; x=1787063638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0GQsznlQLpcSCbR7efR2aiMZyhiXOvWtEGgtbWbncU4=;
 b=KXzwHmyk0TMXC8RKo3iKRkLbQnWRbltyw3PbUVCtHIEz+AKukrIxIfOijMldJUg7R5
 r6IN5vXNyEHDGSLEw9eEIZr2guNfTl0IUjneOcdwrhjjS8Qwz5Xos/hJRkG57qXDo5wH
 tWHa2LRJJ0GO62liArXxy46lWCffTc9aRfrQHoPkf/sx0gEe9AYe/FS+qYGumueKieWd
 MenIsopzTSWg2Jqv7kTSXEiVzIPuxHsjy/pJyIX2b9FjbhPD+VYCu6kxKsrOxF1qLq9t
 1XjotJvcFroN6umo1pzw3+sQV+LgV3dsTQsKihNyffehqWZr3sfVFD/HsmhoeodDAqO8
 q7Zw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqfy5yJtF/1UmWRSqE412k7jqRxtei3Fa5G8I83jMPjjXCYvRzCz8oys4WcU71xpE5en3K/PQA46Lc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS5wuhSHu656pmtmKtbd1Vizx4HoP4EZZU/dIcWc5Jumg1yv9e
 XE7iSG81QGdBuVQ65AMgC1xaWHe9W/CZQsC6t6tOGdwIMfv9GkHXIsWS
X-Gm-Gg: AR+sD13QctamJSMnuNPnulDAMO7jkDhtXUX5I/SB039K/XX9VfAmCgXGZSYC5280jqN
 KTkBFADfqohAEvT+5UTvSSB4bxftyjsXSc3Ga8s2qVH4u7qudaMiUIMmUCljsq/BptAdBkkEKDE
 DsDy2KVOLMPaklWH/YBCtG4+GTAZimo50ns/h8PUyTMWqStQN+ZVf6EMWKJ97mwS0gKoSYUrSTa
 aSWxpe8CIGsByeKEImkXxRiq/OMFlxwcfOcp+afWGzFgvoOC+SreYhWwQRV27Dd4sf2aIcu9OeF
 FTCOCeBV8Mcs5xTckHRMEau72RIVGvv9iZnuVTV5i16PvKWkN+4Mm1Sg1qGLUqJ6IMHE33T7IqL
 BerCjaJ+WJYzWEx7WArl9J+FNapFbyzky9tL2+kTxY5PHiFAk/ZaB0jx/EIzVBBxXI0doi8Y1q/
 BvSejuRH1WCK2rqOZrhHHrzp8VZEteMg1n65fRPmcC9wo+Y5I5MEzZwRGPT/ME2jicFtDmDYQY2
 JwBSeDoP5ADfoADNRf09uSd1VjIvfHCTdg=
X-Received: by 2002:a05:600c:8219:b0:493:bacb:1341 with SMTP id
 5b1f17b1804b1-4997842db6cmr65909085e9.4.1786458837766; 
 Tue, 11 Aug 2026 07:33:57 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:b0cf:778:ae86:13b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977ea5440sm24136825e9.3.2026.08.11.07.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 07:33:56 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: ignore CS IRQs for uninitialized slots
Date: Tue, 11 Aug 2026 16:33:18 +0200
Message-ID: <20260811143318.46446-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

CS interrupts are reported through firmware-provided bits in the CSG
interface. sched_process_csg_irq_locked() iterates over those bits and
passes each CS ID to cs_slot_process_irq_locked().

panthor_fw_get_cs_iface() only bounds the CS ID against MAX_CS_PER_CSG,
while the firmware can expose fewer CS slots. If an IRQ bit is reported
for a slot beyond sched->cs_slot_count, the driver can fetch a
zero-initialized interface entry and dereference cs_iface->input.

Ignore IRQs for slots that were not exposed by the firmware. The CSG IRQ
acknowledgment is already updated from cs_irq_req before processing the
individual CS IRQs, so ignored bits are still acknowledged.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 64749750e6ee..1e230936e99c 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1705,6 +1705,9 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
 
 	lockdep_assert_held(&ptdev->scheduler->lock);
 
+	if (cs_id >= ptdev->scheduler->cs_slot_count)
+		return false;
+
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	req = cs_iface->input->req;
 	ack = cs_iface->output->ack;
-- 
2.43.0

