Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52E606A33A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4wWbJFA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA441121DB;
	Thu, 29 Oct 2026 10:51:58 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D86F1121A5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:18:32 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c40e02b2ebaso305365566b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793269111; x=1793873911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dOEmoLrkij3HmYBFR+Syf3gWz1S3EKgtiAPD6c4+pN8=;
 b=e4wWbJFADQ6Rvivr2M60Ktzft79PX6sD9r7BiEk23tKnM/lJC4bxGFG6e5bqR7Zb1D
 8e0VJsmX/uWnvV+7UarkHy5TfvntmfZdv5aOkBXi27D9UzMkX6E3lh41pFj8kUTpW3BU
 O/eKK9Uh6XFzFPS6Y0ZgFZAb1WSFRehB1E0EztHs6VdKb/BevaK5l2xaWDV4PGtKW90l
 DQZkP0UU8dra08Cdt+TQtj+NAUFa2ZjNJhzv+H6ulfzfny28oFZFziuIdhk5GeYe1fhT
 FmCcL8d0E3nhPXy9z6AzO4nolFfxxc46OP5J+CSSaCBoTx/qz3Lb9I/iLp9eF52GFX5t
 A5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793269111; x=1793873911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dOEmoLrkij3HmYBFR+Syf3gWz1S3EKgtiAPD6c4+pN8=;
 b=XLuFGQ27s0YIWIyF3tfIkRibIJ5SxJI0t3v1mUWfDJKgaRuk7hvglL53PiUrMQBzAN
 pdzpEyKdfCw9XD6/TJrLQfHIa+QBUMp/Rzn3rJP4T7IICkCosZOE6kKsstpedEh+ZbsL
 2Z3ThNTBRLsRJ0vps+WP4Qn07JACKR5ArpDz8MHsF/WohUdbwG84GKNquPLhTyavkVWR
 cMklcf43aFbwIV+yI1scmgXckyLObBYEKoZk8gBM1Rbx2GglwEXOoEk05Q0pn4lSOeOX
 Y7O2Abjm8f2pDNdgd01eXOfLP+z8PGxiXcuXewQ2cmcxF3svWbwMaYyV2nQgM0URdh3E
 H/sg==
X-Gm-Message-State: AFq9FYJmRPU13gECr10JlJ9Mt+6MJDAxuS5bFuhT9+Ntz1x63sDeehha
 Tg926eO4If4X+XGPYWZkuZbaxuakK00l7lZclnC8kEL9vA1tiCw5M2saLanLVIKc
X-Gm-Gg: AYBFou3aPr5DrZXWh3dwSoIDnK2n/MnzjOz7WjnzjYBLG0BA9NUL5RhR0mXjut9+4Sf
 V9WmH2YKF5TzHa1uTlFatiZauKKuIUNa0moJa/fROayU8iBFGTcj16M78DoneIpwYpmCIWT85VS
 HnHUPdSWexj0mcJPj6btXIZmsfOszbIdibVYYCJZbqmKu7QhZM6sVCVfzxliY1sIrqM4vopz+K0
 mcvWfHFaPLUonJyU2NG6PuGUd2aLbyM2bTevn+hAq8c31+BmHBGp5s6+Rohvasuyrp2vWhqBhAa
 gbMgqUytNwjmljIh9n2gWayPbvydqnPmDN7O69puXueqrUxsYQr8nmvawJS+Y54dT3I3PStptjI
 7CfqLr7WKLLjsciv48HzyRZiph7CF1N6sFwWEua9FyB5hMPAbwU4Ov736hDDT5HNE6dyqB5rPRR
 u1VNCB6clSZlcu/1dy6a98EzbEKqOugPyvYy145nubapba/N343hC789gi9y31A+mzn32ENjBci
 BxtELJOpsx68NkEiEpnMW2wvEHcxaE/X3oLdF7Jv13Gx1CDa+iyRzZ5E1pVtjvXYEHhGpvAy+yc
 iKkn8mkGn7nGBvViyGiqahSL649+o6dbp9/jhLiX1P2zS67h104Q5aPp45DUTzQ=
X-Received: by 2002:a17:907:930a:b0:c46:a5bb:5740 with SMTP id
 a640c23a62f3a-c49bdb64c4dmr397674666b.5.1793269110523; 
 Thu, 29 Oct 2026 03:18:30 -0700 (PDT)
Received: from localhost.localdomain ([46.205.195.0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd66c6dbsm712145966b.59.2026.10.29.03.18.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 03:18:30 -0700 (PDT)
From: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
Subject: [PATCH v2 1/5] drm/dp: Always use enhanced framing for DPCD r1.2+
Date: Thu, 29 Oct 2026 11:18:22 +0100
Message-ID: <20261029101826.72773-2-dmitrymalovanyy@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
References: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 10:51:56 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DP 1.2 section 2.2.1.1 says "An upstream device interoperating with a
downstream device with DPCD Revision of 1.2 or higher must enable
Enhanced Framing Mode". So for r1.2+ the DPCD revision is enough, the
DP_ENHANCED_FRAME_CAP bit does not need to be checked.

Some sinks get this bit wrong. The Xiaomi Monitor A24i (P24FBA-RAGL)
sets it in the base receiver caps, but clears it in the extended
receiver caps at 0x2200, which are the ones we use:

  base:     12 0a c4 01 01 00 01 80 02 00 06 00 00 00 81
  extended: 14 0a 44 00 01 00 01 80 02 02 06 00 00 00 81

Through a USB4 dock (CalDigit Element 5) the link trains without
enhanced framing (0x202-0x204: 77 77 81), but the sink never syncs to
the stream (SINK_STATUS 0x205: 00) and shows "No signal". Forcing RBR
does not change it. Connected directly to the laptop the same sink
syncs without enhanced framing, at RBR, HBR and HBR2.

Make drm_dp_enhanced_frame_cap() return true for DPCD r1.2+. This
changes behaviour for every driver using the helper, but only for sinks
which already violate the spec by not setting the bit.

Tested on i915 (Arrow Lake-U), with the dock the link now uses enhanced
framing (0x101: 84) and the sink syncs (0x205: 03).

Fixes: a1d926527b79 ("drm/i915: implement EXTENDED_RECEIVER_CAPABILITY_FIELD_PRESENT")
Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17719
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
---
 include/drm/display/drm_dp_helper.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 5b05a7fbe..4f20f60db 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -160,6 +160,10 @@ drm_dp_max_lane_count(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 static inline bool
 drm_dp_enhanced_frame_cap(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 {
+	/* DP 1.2 2.2.1.1: enhanced framing is mandatory for DPCD r1.2+ */
+	if (dpcd[DP_DPCD_REV] >= 0x12)
+		return true;
+
 	return dpcd[DP_DPCD_REV] >= 0x11 &&
 		(dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP);
 }
-- 
2.50.1 (Apple Git-155)

