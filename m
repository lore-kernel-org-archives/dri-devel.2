Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C2606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSTctVan
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB6C10EED3;
	Mon, 16 Nov 2026 13:27:24 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9C510EED3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:27:14 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso2871397f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794835633; x=1795440433; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RqAZHHXkpbjp642q2K0HIZ7cIhQ/6QUCJipqLujd8Vk=;
 b=vSTctVanOW9CYyEmErfmN/OFfjMNEbnD+xcBR7JMMekoUZ5tB4fIsGC4Tp/ymOQZGc
 jFo0jrXE5TuEf1LoBo+FQ/MhETO5QnTTLuLP3FB+GQdsB25oYBzsTemjxJusOyNhVRSK
 8WEPeVDT+fBMXCs68SqUuIBrWwEU1Oby8XFTI4Pvnv+Dibdy0kaS8mb8eTgt/YjKz8na
 /b19OV35XbmtBaHbodf9ifaIhmgdYcUnh0ccAv5PunNXw3X1/vUI47sFnR6heVJSs6KO
 7OYqGMWkKjEkh3IKpvxky4EIad2BMiNXXm6QwvWSJQrNJL2tjhQdVEImo4/jIkU/mOAm
 QMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835633; x=1795440433;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RqAZHHXkpbjp642q2K0HIZ7cIhQ/6QUCJipqLujd8Vk=;
 b=DH0tLn5d5WJ6g7ooxBDWF7WesamTuIesvx+qLqlC5XFErDxq5T5DH8CSK8eVl0ct79
 iJRY+PCDB9nJsL/pf8hdGmzkHofh4HdazvaYkB3fxKgqU/bxDc624SUnQq7Tj5djaFF3
 Iw7Fn8tBySZga7AYjUjtk430npsUfj3YovSj5KhRm9Nlkty9xG4FbRlqAJX12z4PGdIS
 0Y+nZRC7SaN/XIzC4ypx4kRaG3d4jFePCKhvCevfFwNY+LMTZa1rR+SBEPxPIjOOp5rU
 YZlGuga5JJTOzsJ+F2OVhdW7jYXvH45/L4i04Ohcbz1NtCxWjR7zHtg3uwOThxAyqE8c
 E/iQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFJ7wtNlLWmxwW7U3QwMUP/F6mnhOPd2uwn/a/I3DXm9UVC4b/8nTapKgB70F9G9LIvUN2QL5gFLfk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9/YeEc5O3YRqToSmrDZ5WYDtpSuQm3AkQ06RxLQDXZWQXL0Omx
 wk/a6ZSzbDiSGCzieZT8RL9TzVbaRHvo7sBCoSd7eK+1k5buWuTHnUYw
X-Gm-Gg: AZFdTZefZGVh7m8QgBm/K4+30j9k3ou9oAUOwPbNt6KM7o2NW7i4u4wFHb53KuQfJWQ
 HiDGaalJ4ycv/Hr65vPJhOY4muXpBcpITJIHUrHULYoGFdsvm8+eEN5mHxa5CSaqc1CHFp4JAAO
 fK1VL6FSt1R9W2i+QIQiiuBe2JUNEzRWmgCU3csOmbs63ezk7fDw+hcyu1uHP1JFFSxcpcs9SjH
 eJlbIGm0+BqiPCySDhPdfc91AEWlVazX77F2JlLh1KGIO0XxuQXtSHwJmjxs9Gkif4sptqePfy9
 cIPEQxJcczxRaftFa0nGb1AYyuhlVuDAhBtVqTbRnR8AtQ+9/K+SBrXi/ChEReuRF8ucCi2dcll
 LvVbFYJHhj2rBdPRR6LMEFyTVnxcyYtpmSVGuqiAXNv/+NVsKSuRFyI4rm064vZBBzSkM/UaYjs
 ydrDLXRW6DUltpYwJAYDK0KrHSa4Ih13Ch8u5sKKkdEQkIPj4s52UUfpjlrZ0vTxSykhW/O6/fe
 ecpQh0gIkZvhR04wUJ4j/WlfbMG/IysqwewadQ80PcGNsd3t0mNE6SJdZycw/lCytEfcQ0pq/U3
 oyB96aYVSNsPVOIF+ZKwi/BZlE9zNVvoQtgJm6EyGAo6HgAz8Z+Ec90=
X-Received: by 2002:a05:6000:4715:b0:490:50c1:f359 with SMTP id
 ffacd0b85a97d-49c723fba07mr22874709f8f.39.1794835632796; 
 Mon, 16 Nov 2026 05:27:12 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm40370240f8f.7.2026.11.16.05.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:27:12 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] drm/bridge: Add atomic_sro_install_state hook
Date: Mon, 16 Nov 2026 15:27:04 +0100
Message-Id: <20261116142707.1299360-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116142707.1299360-1-maximpedraza@gmail.com>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The state readout core lets private objects take the resources needed to
keep the hardware running when the state read out becomes current, but
bridges have no way to use it. A panel left on by the firmware, for one,
would stay marked as disabled.

Add a bridge hook and call it from the bridge private object.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/drm_bridge.c | 12 ++++++++++++
 include/drm/drm_bridge.h     | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 45a34bbb8f14..cdfd6d44c8d5 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -629,6 +629,17 @@ drm_bridge_atomic_readout_priv_state(struct drm_private_obj *obj,
 	return 0;
 }
 
+static void
+drm_bridge_atomic_install_priv_state(struct drm_private_obj *obj,
+				     struct drm_private_state *state)
+{
+	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
+
+	if (bridge->funcs->atomic_sro_install_state)
+		bridge->funcs->atomic_sro_install_state(bridge,
+							drm_priv_to_bridge_state(state));
+}
+
 static bool drm_bridge_atomic_compare_priv_state(struct drm_private_obj *obj,
 						 struct drm_printer *p,
 						 struct drm_private_state *a,
@@ -674,6 +685,7 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs_with_sro = {
 	.atomic_sro_compare_state = drm_bridge_atomic_compare_priv_state,
 	.atomic_sro_readout_state = drm_bridge_atomic_readout_priv_state,
+	.atomic_sro_install_state = drm_bridge_atomic_install_priv_state,
 	.atomic_create_state = drm_bridge_atomic_create_priv_state,
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index b73f3424ed62..630af5b3fcf2 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -967,6 +967,18 @@ struct drm_bridge_funcs {
 					    struct drm_atomic_sro_state *state,
 					    struct drm_connector_state *conn_state);
 
+	/**
+	 * @atomic_sro_install_state:
+	 *
+	 * This optional hook is called when the state read out from the
+	 * hardware becomes the current state of the bridge, once the CRTCs
+	 * and planes have been installed. It gives the bridge a chance to
+	 * take the resources needed to keep the hardware running. It can't
+	 * fail.
+	 */
+	void (*atomic_sro_install_state)(struct drm_bridge *bridge,
+					 struct drm_bridge_state *state);
+
 	/**
 	 * @debugfs_init:
 	 *
-- 
2.39.5

