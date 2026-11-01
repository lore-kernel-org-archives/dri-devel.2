Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A00606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=softbase.tech header.i=@softbase.tech header.a=rsa-sha256 header.s=protonmail3 header.b=EBcTXb9w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F0C10EA35;
	Sun,  1 Nov 2026 12:31:11 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554E710EA35
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softbase.tech;
 s=protonmail3; t=1793536191; x=1793795391;
 bh=5CNWPC3f4Y7cj+kyGwcKKMi29wAdC6p/pBOZZ28e0cY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=EBcTXb9wZy9SYEH41vt7FqHbLnqf7GvXMvWPm9jYNy8wn/Nr1Mk49MazGTWd4z7d5
 hJEyKn0q713yBFOgiSSnarWuPJkoMa7e5R0c+e7QMYJ8FH7gomrXpu9ffVt6vgLkmE
 aX0bV1llgwgmqoFQxPpKNVyFfmPFO0ZV9KTsfAHBTcX0UHSTfvgb4mOhdC1xwo6K4g
 aHkBg5mAVEHuRoHaAcpY+G14Mp0TeQk25M79FdrrGwm7tPImSklDcIsmWvaceK4rqh
 CtAOX8gS6Yop6flHaSQI3Em4vVGouZ1z7bjE0RtFbpJIWKEXvkE0q9CBRo+lJYWE8n
 gBO7NAvhy4vFQ==
X-Pm-Submission-Id: 4jHZ0X2y0lz2Sd2r
From: "Beat M. Liechti" <beat@softbase.tech>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Federico Amedeo Izzo <federico@izzo.pro>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Beat M. Liechti" <beat@softbase.tech>
Subject: [PATCH v2 0/2] drm/msm: fix CTL/LM swap on color management changes
Date: Sun,  1 Nov 2026 13:26:56 +0100
Message-ID: <20261101122943.8155-1-beat@softbase.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101095754.33840-1-beat@softbase.tech>
References: <20261101095754.33840-1-beat@softbase.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Closing the lid of an X1E laptop under GNOME with an external display
attached moves the still active external CRTC to other CTL/LM blocks
without a modeset, which ends in SMMU faults and a hung display
pipeline. Patch 1 fixes that in DPU. Patch 2 removes the CTM-only
allow_modeset hack in msm_atomic_check(), which patch 1 makes
redundant.

Changes in v2:
- Patch 1: don't set allow_modeset on behalf of userspace (Dmitry)
- Patch 2: new, drops the legacy CTM check (Sashiko review)
- Link to v1: https://lore.kernel.org/r/20261101095754.33840-1-beat@softbase.tech

Beat M. Liechti (2):
  drm/msm/dpu: don't reassign resources on color management changes
  drm/msm: drop the CTM modeset hack from msm_atomic_check()

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 25 +++++++++++++++++++++---
 drivers/gpu/drm/msm/msm_atomic.c         | 17 +---------------
 2 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.53.0

