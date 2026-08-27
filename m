Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249D8C61DD4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6873010EF6F;
	Thu, 27 Aug 2026 09:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GrLNtAOe";
	dkim-atps=neutral
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EFF10E373
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 02:21:24 +0000 (UTC)
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3964e7720afso976311a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787797284; x=1788402084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w5YaH8mokWPLQfhjUseDA3RHoFgBNedWh0XDxf4FNzc=;
 b=GrLNtAOeSBPz2p1srNvKuMXJQgMEM62iX/6uTKa4t+f02YbYFtBxGkU6vcav8232w6
 aI3Kt+l+EHFCV7j5/cD9NjtR+rfO9dCTsn+21dhIcyKcDCPq+CH53vahonXsQkeuoJqB
 u/8ue5kk63oaeAq5OBTbrIVvROmnIuM7GzSsfw56WEpLQ1dWqRf6oImk1rqzvHpvSX0e
 tiGTnGqjTaSle8DIxNr+paB9X5Obpo66hU2atKDoY8pusPVB4ok1EzwJ5T2K6MZ0DKR5
 CyN64WYq6ttsf+LABxIZBAuAgPlMnYIxMdj6wro1aW2QuG0T0AEGWfXPm2r914IZM+AJ
 jB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787797284; x=1788402084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w5YaH8mokWPLQfhjUseDA3RHoFgBNedWh0XDxf4FNzc=;
 b=K9mFS4V+vxSQcfrODk6dp227S5yDfcPZZ93BPZ5Cr2SX8qk+3SNzaLJw5zM+YU34gO
 11Hzf3y3A0kws6IMhFkPZBc0UkuSsW1EF1pbFqUcJPtxj3/jT66zqouLzf7ypiMWjmm1
 OiZZs0rOdfQUg1ERBsFT+2fJutb0K9gvETprXGjsFalMckq0RJlYconJELRm5G98Q7SJ
 TZlfbYzmQed+DAgkS7/oIsgRTW0PwGd4PylDtNcPTmPol1J5RxSkQytcI1LFdteumd3m
 gp3Q0ozhZr1+GA8iwpDN0QmdBRzxJPKPTtWkgfcOfarb+5Mdt0G3VZXHQ5olWy8HdESS
 bupg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpizPtiFpjnU/XXn97YaWu4q9HM09eWMLLTx7P/793jj5tYnAP1umgNcwimzk0FLl/HOqFmZuBYHk4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++la6Hb5Hbni8CqiR+Upvjly9rF1n/RRTDPHo+b3l/XpgmT/0lZV
 k1+/cCzA1JnXA0+WaLkN7cr+Eb30D5d0GCrExWRLQzIwkcfLaGOuXXmN
X-Gm-Gg: AR+sD13sxs8tQXAhQijk6QA16bKF+df/EtoLLCOvto7YqrszXBCOul/HWnU1l0FGi4r
 4QViYHWALD1gEzqbahqsP0zMxrH4TjynM7Gzk7RCxMTzGG9YjM3Vrbgp5vWtAMJIwGllPkLjtPa
 UPaeWfR56xsieoNmAXp1l5TH02H2OPtxO9Kk0hZr2RRC2OmSwFtqs4ocQrsD22Mqi1QlPCkbDi4
 jZJVk+PnKnYMH2F0dPtBQIUlySzdHLwRD6tvZMweaPRa9IB+Op+Qm6e1nAFRs9TqBzyOc/K9LhP
 eYIakLpTceNyvuq76FCjEGMVn4uQPw9Rxi+T9A8KFQb7Y46Rz/QrsvED2eik+QeROkUroSQw22c
 wKlU58ZHZUu2RREknzuxcSmveipbhOPhRZ6rIg9IWQ4JcMv3WdVLYhnLjxTVBzu6UMOWhoiRhxZ
 bHx5WL8aPeY0p9GuHgo1fWrfGPqMxawYpXMvxpy15Ic0ppu/VaWtiN7xT5ViU1jysdd22+Jy2z+
 iYroDm1CHQV53vBjyo1KMdL5A==
X-Received: by 2002:a17:90b:390a:b0:396:5785:843 with SMTP id
 98e67ed59e1d1-3966d203a94mr21084902a91.8.1787797284194; 
 Wed, 26 Aug 2026 19:21:24 -0700 (PDT)
Received: from DESKTOP-BDFNLNM.localdomain ([223.231.133.255])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60c291sm20850538eec.6.2026.08.26.19.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 19:21:23 -0700 (PDT)
From: tarund18303@gmail.com
To: jani.nikula@linux.intel.com
Cc: rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tarun-tarun143 <tarund18303@gmail.com>
Subject: [PATCH] drm/i915/dp_link_caps: Validate max link rate
Date: Thu, 27 Aug 2026 02:20:34 +0000
Message-ID: <20260827022035.3442-1-tarund18303@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

From: tarun-tarun143 <tarund18303@gmail.com>

Validate the maximum link rate against the source-supported rates
before using the maximum link limits to calculate allowed
configurations.

This prevents an unsupported link rate from being accepted as a
maximum link limit.

Signed-off-by: tarun-tarun143 <tarund18303@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp_link_caps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_caps.c b/drivers/gpu/drm/i915/display/intel_dp_link_caps.c
index 7b6cc6055da8..0934488153bb 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_caps.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_caps.c
@@ -710,7 +710,10 @@ static bool max_link_limits_valid(struct intel_dp_link_caps *link_caps,
 	    !is_power_of_2(max_link_limits->lane_count))
 		return false;
 
-	/* TODO: Validate max_link_limits->rate against the source supported rates. */
+	if (intel_dp_rate_index(link_caps->dp->source_rates,
+				link_caps->dp->num_source_rates,
+				max_link_limits->rate) < 0)
+		return false;
 
 	intel_dp_link_caps_get_forced_params(link_caps, &forced_params);
 	allowed_configs = calc_allowed_config_filter(link_caps, link_caps->enabled_configs,

base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
-- 
2.43.0

