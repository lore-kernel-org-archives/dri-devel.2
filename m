Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C07606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=NRQ4dnCH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22E610FCCB;
	Wed, 21 Oct 2026 08:52:03 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703E610F676
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:19:53 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso2129531f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1792509592; x=1793114392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KlEtfhBXUX7O98YWsvuju/yUjikM5NzbWYCqPri8rV8=;
 b=NRQ4dnCHRNRRDKMrqOzKjOlKA625W+IqY+FgigTXbC/7q26rJWfYda7GwfW+ieYO6P
 /0q+A7hlUjkBwsnU9aW7ltWCC2X26Py87rlnI3iExRG+6TTGoFz5norRse2hpchum27Y
 MZtoBXQdNvjNzIcsb4rsYZYqVgSSOBlsBhWsT17Z6qXbyHoKb+jQQfnTMHQF7RnuQZ64
 y06plR2p+WAJ7MTwP6vtivmgmOkcEuPd/jUGZ/Pap9qnoxjlliB2EdOtNMNqj/CxJtoG
 TKCYbA8WAA0OzExCINTKy6uiuJEkWpIfcKWHDJD/YLtbbZbgNwVjlh3MArO8HoGzmAhO
 WC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509592; x=1793114392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KlEtfhBXUX7O98YWsvuju/yUjikM5NzbWYCqPri8rV8=;
 b=oF/ZqoZrnt0hzntEbODnTunj0N+XxfwpDIi9an6SRqtaX361oiBitHAH8MBg7DN90M
 W06ZyhVt5DnxAvFm0sJ10lGMAFFzBgpF4t6zSt6gzntWPQK2CB43xbrA9cYS1lQ1ANql
 h7k4gZKPx+Ry3auzVKMBxZ52v3xjAT+3c0SLU2O5+4Stm6RE2CUyZpoqAVx98SNoFKtp
 PNvvlOFwIcCBbKiP+pNnHviIa5MWv+MPB00hOc45vfTOdli3+jKRG76knAzHPP9k1FSo
 ZL2Ls2R8O5Ts9ZM5tdgxocWXVzCe+yZ4xIcPoKi9p20aIQM7ykUFcCdZaG5GULXOBBYu
 UuBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWbyMfgupTHrmA4FwoOqMh3PmxVUCyaBGXfTfjEixCAbT8H5Z7kqLkGwp7iA9uEY6novpXZUkGpcI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxDmRB+t9bXmDdU3zSHQafgfrfbbhQ6iS9gAZ1O3zFAMgEKnDh
 gI2jC33UYVPh9cxqymMowZLGrj/VRUra2YlHCEDsMaYEK/qVDBtSR+lRYCRNPXBkUt/+lYzxx/J
 pBPmC9t3DILJT9EqXZtP82wBsOHz2oanBFDmObzIohWtUYDXlGmUjPCPWGgRmF8p5ygC5myNkhN
 p2U3j8aQks0+TkSnv5sjDIY2FJMmfbNQXnVoXRC8m34ZRp9N7A9aw9z7Dkt6aMNoKvfl0RcKlEM
 v4eRU7iuz5nQ9oGGydb47Mih9s=
X-Gm-Gg: AYBFou0Q+J9+faxbhqia4sCTyBVHQO7/FOL3c2WDFjhoKmvLFInhx1q1DHom7ZUTnOS
 dUSw7usN9YHuYwG6W3d7wTRuOs5jb4hgWQ07pQSQiN4eIv/kH+0KKN+ga8Nlgwq8L0VvDarX4ie
 eB8x2mbTryst1IDTkqOBAdD2c8JVJeIpgEm9QZIB0/k3/dlaxpGu0dqBapVnf79VdJUtzPD1bmv
 jMPsakuSv4ZP/cFEcrp7jiKLnQAsy8J4iPvUEsqAt06JE07auMbogpuQ0FpiisaleZcWJYh6Vat
 1ZGwpNAxXTUfyC7/xch0shTUibJqOqbPL2VGrfEDmMsxbM5yIruNN+LvxneEKgPj9eBLCOA/O4w
 O+XxzXi7oqa6l0lg7aZfpJHK1b2B00WM7ovUz/ee8CBlgjhfTu2XWCq++nCeLl74vufREWqSNpp
 Yn61ykmoBGKCWAN5v9EsG+r1dZvY5tIuz/AJIxoZwVHjPhmX6TTnQhiTyPlIt8h49DMWc83lULD
 ScxHO4=
X-Received: by 2002:a5d:61ca:0:b0:48b:10af:f85c with SMTP id
 ffacd0b85a97d-48e07fcda0dmr14392093f8f.37.1792509591741; 
 Tue, 20 Oct 2026 08:19:51 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d817d80sm7410663f8f.26.2026.10.20.08.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:19:51 -0700 (PDT)
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
Subject: [PATCH v2 2/3] drm/vc4: hdmi: always cancel the scrambling work
 synchronously
Date: Tue, 20 Oct 2026 16:19:47 +0100
Message-ID: <20261020151948.83459-3-lucas.tanure@neat.no>
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

The scrambling work re-arms itself every second while a scrambled mode
is active. When the output is disabled, the work may be executing at
that moment rather than pending, and delayed_work_pending() is then
false, so the cancel is skipped. The running instance finishes after
the disable, sees the sink report scrambling off, writes the SCDC
scrambling and clock ratio bits back on, and queues itself again. The
sink is left configured for a scrambled 1/40 link that no longer exists
and the work keeps running until the next enable.

cancel_delayed_work_sync() handles both states: it waits for a running
instance and blocks it from queueing itself again.

Fixes: 257d36d493e9 ("drm/vc4: hdmi: Add a workqueue to set scrambling")
Assisted-by: LLM
Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 2cc46036f11d..4a386e053d3f 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -843,8 +843,7 @@ static void vc4_hdmi_disable_scrambling(struct drm_encoder *encoder)
 
 	vc4_hdmi->scdc_enabled = false;
 
-	if (delayed_work_pending(&vc4_hdmi->scrambling_work))
-		cancel_delayed_work_sync(&vc4_hdmi->scrambling_work);
+	cancel_delayed_work_sync(&vc4_hdmi->scrambling_work);
 
 	if (!drm_dev_enter(drm, &idx))
 		return;
-- 
2.56.0

