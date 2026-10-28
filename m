Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F43606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k6BkOx0P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC0A11206E;
	Thu, 29 Oct 2026 07:59:23 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AE310FD93
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:29:46 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so2154292a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793204985; x=1793809785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJQN1372r+5iUBD7obTGjY7/PAv9KAvuyEMPwJZ9IXA=;
 b=k6BkOx0P8HNIqNt9Pw14Yrp1xuB1dX/cOjh3J7wFKGtGbMUK/54Xan3mvbzUsPEREt
 B9MaO3BWSa2r41IL+9sZSEg1MGS5v5WlGJU3FApN1tm3uqmNxRVfNGDysYXDDiAUGMUE
 GNrXV4D0v+8DWomgJvOtstkAZHqOdMs9naT2hcvyEB50h3N1k13hIn53a8JtY2BWXIa5
 ZNOvrXqDjAZzGl0qmjIB1YeWQ6z8/F9yC4J7EnECI95F9gn+uiv+BlLVZ+oU+yMIwgUl
 TZ5a8yWrOnratl0lk9/KpXWwIauU5Iqczt4stmy2w2iN2XlBxa27sVVQHfcjVyqCHFHj
 25+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793204985; x=1793809785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJQN1372r+5iUBD7obTGjY7/PAv9KAvuyEMPwJZ9IXA=;
 b=TwZDNjibyOxEt82yeGI4KbieCvoyD8p621YWLc/vvh2wr0M7VDokh1oag/ncC2rMtA
 YwHH+f36jS4V+4Uu5fdDII5eK4Ii7MMhVe45VIViKiA5zuBWnT0K4azxmFRF7m07TUhb
 KKASUb6xr9ef3xUJXzySvMCHEqltaDL3g5LZwyExxjGV8wWtqj97Y1H7oMytLAzEVwap
 pucfSt2+H/KfZXPJnvWyK+/RR+AXjq+ayg1e/clXXBeq7SABO0Ajqlnkb3xRXVjjz8v0
 44l94B7pZgNXnGdfZ905a7lR/XVn2byf5U/QjLVU0whf8gOfO6Ecj27k9by4MXeWZXME
 cvGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfDJN/1y69NJG7uUTtnY9CqjwWrTKyeYpIqUIhuylTn/dIWaPGKiZyjNugAlnNAflMFlLF6mPlp7w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIp19+zlcETfy4y8gUvWAc3hjR2Yrit852+aASvvPSl2+iI5Bh7
 SORgv73XE9Zzwm2hRVfVpGmCJgnHzPanX1OA203ROLHpBa+Q3pzpr/AP
X-Gm-Gg: AYBFou2i4EEKJzDPg6jdjYeFUhTT3WEbqM2oVqb5YjwSfrgYAJ91aXazpL7gHsL4x50
 /82wIh2pLrHwm89Xyp3fqga3s2sZqr4mmfHA7heTVR/xfgz+Fg0nwyzMRgbtCE6CN1PAqK7/ASb
 c/5DZOBJ2nGUcMhEjp9/CWxzeyAlw8pvUtoxk9GZe1DEY2d74Vw3/7IBXEfP4RTNBTOUlokA4FG
 FYKvo+4xHRaBBbnrB5K0jcL1YRTSy1FAHasytxTWLA2fX4hh4Zb9M/2zumA2jxvkrU8COTLUN+H
 Mg3YL1R1x+mUqYNQAo7Zfi8ttqcbNlGWy1ba7rWfNIgRRUCF9ggIk2jYNhhRQCD86kMZ4/rgAwU
 VJ3Qmw0rwJTFV8WH5n3xIhnZIcd1qnzQFncs2t0vX0+kuwtsFCeVCS1PKjWRcvF6bcr3VHp8vuj
 vN8/3jaKBBl+/VWvzNnqklD0I+eWLwzFCspILBDjeQA13ocVcSSomlKaiQXmvf+XWiq7XMKdx07
 4+U+/6stJjCMoEOi6WYv5WT50G2lwF41zmh3rQx3nzJm6UAAFduwfqr8vuEAIVte8ciq/Fcpxop
 IDB7GLtf3kXFUJ9EhZyK+f+grlVHtEHywbohhhJMR7/rl0SziSDc/0MkjBggEtNB
X-Received: by 2002:a05:6402:234b:b0:6b4:1701:569c with SMTP id
 4fb4d7f45d1cf-6b49cb594d2mr2127015a12.3.1793204984885; 
 Wed, 28 Oct 2026 09:29:44 -0700 (PDT)
Received: from localhost.localdomain ([46.205.195.0])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b496435babsm1655823a12.28.2026.10.28.09.29.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 09:29:42 -0700 (PDT)
From: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
Subject: [PATCH] drm/dp: Keep base enhanced framing cap from extended DPCD caps
Date: Wed, 28 Oct 2026 17:29:41 +0100
Message-ID: <20261028162941.62762-1-dmitrymalovanyy@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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

Some sinks set DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT and advertise
DP_ENHANCED_FRAME_CAP in the base receiver caps, but clear it in the
extended receiver caps at 0x2200. drm_dp_read_extended_dpcd_caps()
replaces the base caps with the extended ones, so the link is trained
without enhanced framing.

The Xiaomi Monitor A24i (P24FBA-RAGL) is one such sink:

  base:     12 0a c4 01 01 00 01 80 02 00 06 00 00 00 81
  extended: 14 0a 44 00 01 00 01 80 02 02 06 00 00 00 81

Without enhanced framing all lanes train (0x202-0x204: 77 77 81), but
the sink never syncs to the stream (SINK_STATUS 0x205: 00) and shows
"No signal" until it is power cycled. The same monitor works on macOS.

DP 1.4 section 2.9.3.1, as quoted in the commit that added extended
caps support, says the extended caps match the base caps except for
DPCD_REV, MAX_LINK_RATE and DOWN_STREAM_PORT_PRESENT. Keep the base
value of DP_ENHANCED_FRAME_CAP.

With this change the link uses enhanced framing (0x101: 84) and the
sink syncs (0x205: 03).

Tested on i915 (Arrow Lake-U) through a USB4 dock.

Fixes: a1d926527b79 ("drm/i915: implement EXTENDED_RECEIVER_CAPABILITY_FIELD_PRESENT")
Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17719
Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e623ccb4c..205b6cc89 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1219,6 +1219,9 @@ static int drm_dp_read_extended_dpcd_caps(struct drm_dp_aux *aux,
 
 	drm_dbg_kms(aux->drm_dev, "%s: Base DPCD: %*ph\n", aux->name, DP_RECEIVER_CAP_SIZE, dpcd);
 
+	/* Keep the base enhanced framing cap if the extended caps drop it */
+	dpcd_ext[DP_MAX_LANE_COUNT] |= dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP;
+
 	memcpy(dpcd, dpcd_ext, sizeof(dpcd_ext));
 
 	return 0;

base-commit: feaa32dc98090b2f45f7b6f179711a6640169c1a
-- 
2.50.1 (Apple Git-155)

