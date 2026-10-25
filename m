Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D2606A329
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sFQkuUGq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 909DD10EC89;
	Mon, 26 Oct 2026 08:37:29 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA4E10E139
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 11:32:21 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so2264565f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792927939; x=1793532739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KwZRNYaRjnJQ3q//ESU6BdTNHHFJgWcA5paXgJ8+8F4=;
 b=sFQkuUGq8LMkFfhqqDwhoL59GIbS+yWJjHaXn+TWEoB87X8qhQPdoryv1TvOfBpaJ1
 Bzj6+RuYeEqpiYnro960PZrabSOphbJbRqCuvIGOj+qzUh6kuvLuTl5CcZzzfzi67r/y
 2UGSSWPlJKV+Wm6euy7+RETQKOMkN++O6aNOZ5gzjNozhDwvuCLiyJqCxjbns6qB3N2N
 G4+VTdxASJUyDM4d3VnqKJ2jCt+qU+9x4QhFoxBCirtiT1TfL0FtjpN5igOlS10cjfnb
 dB9T5rkeIA+Z30SxJzdWevl/mKQa4MlvllVrB0/NRpdT13QPi6UvAoLjjsdrtiOUDo2Q
 QfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792927939; x=1793532739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KwZRNYaRjnJQ3q//ESU6BdTNHHFJgWcA5paXgJ8+8F4=;
 b=mBuYcPdAWpg3lhVuJFw6qo2bBr5Dbwg1MF0FtxJPvR7+ITmfulToVUNjZgzOrX1z9D
 msuNG9gyP/Z+0pCi9YPTvvUgPLH6XNGG622DnYvMyr2ZaV8F5IZcBuZp7wpj8cnsbuM/
 kuFmKK51nTSo8qV3WcSpPlm5N2HNOuru9y/ETfCpg0xAKuhLy6QFXGINcxl8prgw0mUe
 aRjX/VrPZ/A2nBudEFl47eegJCACUJz3trhlq9XOaQ1it3G9Xw/Fwx2JwmKsoI+E1L4c
 tiQSKwuTkD2h57Sah4yuw2gbhZWbUWGavTxa8Hwioivf8wEmwDO3OW0KvtE7tyHc3y/a
 JvHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByuHZ1MKhgfQ+TbqMU9235P7TwU+41N3m4GMkBC/k5awL1HyCePfvwfxsRglrMwR0J+nSYBXas+JIA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL5WtDQvXLAq5Btk0wlbD8ZBylddEnRwWG/wfSdGlIgGKJO9GnV
 vhsMU8khVTV2GnJsen2Qgc2Jz24AGKDr2ha1h7GoyRJE1w1tRo1RRBYj
X-Gm-Gg: AYBFou1qPLAeE27HqoA5IoX+Q7sCcfoH0mSt5KFzifVAj2sQHHPwZQ7eV8nmioxQr7Q
 UGXg4iu8II3+RI8iHfceBRL0aA/4fzoygZHuWZKscrnOyKSK0x5TMhW1lHIB8SxAreZP/zGdbyI
 k2+MeSB218Wf+oN3ocGWE/joDCg66qA7oDGtxVh/dTDSEghLJ17SauV+UnQN9d6F6hhSvIj7K4W
 VWLIhl+lCXmz+4oPDDVs9QIwlESUJQ6Ka0HuC/Pelu2KgA1qXwgAFe/uB4yLMspCn4o2/3y7Bb6
 GPdm5c5TouhI2zj/NBkqTXXjhzT6GMLt9Ra6NkL4gbmboBjegLTzkqb1nXjrnNP8pZvZEYvPORl
 YMhy/97luZiBfhSx+1OBCTGl6l9AKVaZpiWJmljf/FoFFJIBMeWbncdwSDUMoX+i0rXRc5Q0Q/o
 S3502+u9BW4aR9Cik5smrAuk4dWg/1bDrPyVW8G2Iy+TXWM8QSQJ+65I3d6EbKd6gNyuqby3lR7
 UUBV+n4vUQ0sRQrWmuSVm1EC9kUGpnf6ZN6LW1nhkWpAYxac3matogwyPoT5vHY
X-Received: by 2002:a05:600c:19c9:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4a35ae90d8emr76649695e9.11.1792927939411; 
 Sun, 25 Oct 2026 04:32:19 -0700 (PDT)
Received: from fedora ([2a02:587:85d4:400:553e:11c0:d5ab:5792])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa097sm129609655e9.3.2026.10.25.04.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 04:32:18 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mail@taterr.org
Subject: [PATCH] drm/i915/dp: Remove redundant link capabilities reset
Date: Sun, 25 Oct 2026 13:32:00 +0200
Message-ID: <20261025113200.25097-1-mail@taterr.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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

intel_dp_link_caps_update(reset=true) is already called prior to intel_dp_reset_link_params(), making the explicit call to intel_dp_link_caps_reset() redundant. Remove it as requested by the existing TODO comment to clean up the link parameter reset flow.

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d8c0d9381471..0e753824bc28 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3674,17 +3674,10 @@ void intel_dp_set_link_params(struct intel_dp *intel_dp,
 
 void intel_dp_reset_link_params(struct intel_dp *intel_dp)
 {
-	/*
-	 * TODO: Remove the following reset of link capabilities, as
-	 * this isn't needed after intel_dp_link_caps_update(reset=true)
-	 * was called.
-	 */
-	intel_dp_link_caps_reset(intel_dp->link.caps);
-	intel_dp_tunnel_uhbr_lanes_wa_apply(intel_dp);
-
-	intel_dp->link.mst_probed_lane_count = 0;
-	intel_dp->link.mst_probed_rate = 0;
-	intel_dp_link_training_reset(intel_dp->link.training);
+       intel_dp_tunnel_uhbr_lanes_wa_apply(intel_dp);
+       intel_dp->link.mst_probed_lane_count = 0;
+       intel_dp->link.mst_probed_rate = 0;
+       intel_dp_link_training_reset(intel_dp->link.training);
 }
 
 /* Enable backlight PWM and backlight PP control. */
-- 
2.56.0

