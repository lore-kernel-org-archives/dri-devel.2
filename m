Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C8606A323
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=RO0yMmdh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DC910F33A;
	Tue, 27 Oct 2026 09:32:12 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24EFC10F058
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:40:33 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so2572691f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1793032831; x=1793637631; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k/RQfOJkIdQzlXf5l9/irF3ArAcPBHy+Vg3AaL27hnc=;
 b=RO0yMmdhc0Db5nNaEAY+T2deBf1slmBCnUrA3YlaNCfgDsD3zjp85Y2HAZKZcQ4qW+
 faGn+MNNqZAdzwH3nFoMioIb1cLvqpnoWSe63Vt+eUCGEvasCv0pCSAjCkbwEGBZF1NM
 njqCB169WBXttRfCtlgyCZfwzO/Bn74OF5TKgLhUw3QZ4xFhJ0uY5ltTuAJ2HwoVGxK5
 JEU/CuHGSkzp7TdnVntcUr90qouiz0TinJjQMh1lBhZj0bzGNDRfEUVZ0Mc1JKkegne5
 k5M/c6F2ua2KgbTo4GDzsSueIBXvQ6SPvk6UBqdqr8NFmPoN5I/UwUzoIBY3itghItvl
 i6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032831; x=1793637631;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k/RQfOJkIdQzlXf5l9/irF3ArAcPBHy+Vg3AaL27hnc=;
 b=BgKEvPd5eY3GX7nydDnTIQuFoCBufh4tgGxxv+gRr9To+ry8uOziXLAKUFMfu4GqpZ
 AC0KSh1ZO36Is/VBnAW4IW0aKH4O59vuTHQG6tK/Wooi5dT73O6Ugb2wZ5i8EuMbvamH
 OdAYwAECxuqKSJ2QPFEjtFWrwVxKepUDHwAjCU7R2E0LhaZzA1/g0+G9X3I9lUEfcs1r
 R9+mToxC3uExOEyG0CWydWS5I22qytmoKIGm0L4fmFHt/4MG+YxPnETrIP+QE0WSB5ar
 smu2Y3rQue2NaoNrPL/RRuep59U60vxi7XepvNUPRL+pyl8KEz3H2ULf+IA8jR2zcn7S
 lnZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVW54//M5/IVzLqUpCpmu2P+rzlO9Hs3dCvjrorJSmMWTCqK+C5U5g0eKljSO2cqN2VKqHzpKLE30=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ3CkQLROJvB+AiFEShTBjj9RgAVPD5F/7d+DTQbtzRI2Dihlhp
 nDHWvBN2Jn0UXH3mkcSurqR8pqVoF/otyqXTk373wvOdJ4oqT1i2Qc0UP0E2oLNuyDYxU1f04gG
 CYmixljgEy/wcWKGN6ryjqumVSZ4jQYwqGx3xhiV0WK/gKbDgaAtSaBnPyoO/gCjMBoqa1JLoj0
 JXy83kq1gLkxKxG5nqOcBSW+hrvpod2H1IOEtgKGH5bgzMJDzzhJWr3CMWIpuaLpgYAxCUagSL6
 ho879fdKdjQ6SfBpkh3ysJff94=
X-Gm-Gg: AYBFou2vh5+Pgfzr6VH8KRDRSlyKRr/F9JKkgP00ihcK4GGaP2Vxi8gPEOODfyO4RCX
 T4SQZStw1uTzYwOpnpbdgoeT2NnG9E6WL6r542HX5Q0/rh2KRr+t1uxyJ/JD7pCnk7DvKVpvX3x
 e1wA6cNgfoyNgq37POuiQpbB8M9ZudBK0ZndIgXf6V8/QHl86d7aEzHR9nZLkYKP5qoJ9BraKsw
 TfDvgavSG2LMUMgZ+sN/31pX4T2meg2oe0+CklmKcLBxGCUKxz66eQeqV5LdgV2rLIWvMni1bes
 KXDWfZVRzemtEtiMYOP01yoi0wgSTHoVA5HxtGTV0/t+byVR33MIZrHBJ5OYE+olCJibj5StgiL
 yInLVsUP4/t4W7jYbrnplmKs0tih9AMxKS9OWPq6nUY0jAJq0kOkn3tPBocVvzwubTvdnf9cu/F
 JAxFUO/ygwURUwmtWWI3duCfs6DGcU7NxePrsPlLcFtDGQQ3pB2qAmeZhQ2QxaaOg5vxK/EJk8i
 wMoh9enKBQvtB573cwvHzOajj1YGTI6WO6T8eHNXu5SDZFOHZyrcDtJUw7uUIwx
X-Received: by 2002:a05:600c:811a:b0:4a7:a309:6b73 with SMTP id
 5b1f17b1804b1-4a7a3096bb7mr12028775e9.1.1793032831444; 
 Mon, 26 Oct 2026 09:40:31 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a30e22csm205961655e9.2.2026.10.26.09.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:40:31 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] drm/vc4: hdmi: always cancel the scrambling work
 synchronously
Date: Mon, 26 Oct 2026 16:40:27 +0000
Message-ID: <20261026164028.78792-3-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026164028.78792-1-lucas.tanure@neat.no>
References: <20261026164028.78792-1-lucas.tanure@neat.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
Reviewed-by: Maíra Canal <mcanal@igalia.com>
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

