Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381D8CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A2A10E8C0;
	Mon, 28 Sep 2026 08:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PjynjrjW";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D148410FA48
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:53:25 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48881a62e09so279791f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790340804; x=1790945604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HaRnV5HNxYS3xKGjNmztf83AWXiwarq2vGsbWimUVzc=;
 b=PjynjrjWZxKfLAwKS3FhHqBr85Kd4ToViljwFeYz5hqQNiI/0P4twqDC/bsVkbfRr5
 5q1qFlhfHrGzW4S8QFRESjG9nOxkp2jzY/zOdZTBjWzeT3clXPWlazgjkkCCWVG8wOuP
 GkwXSDH6JG9XFEs/hDSEc9gKvVIAAoIwxmybQi9Ja6SVRqU6upzO0cthK3ltzRgVR6y+
 Ouav+cL0yZJVIhJ4tjsZ0CiYT1MI08hZUf2B5xvYlobWQd6ZBDu2AvzE9cQZwwd98SLC
 inUYhQgEfeh0sBcnM7DmvvNyOcNpADi+zhBu6+YVjqoJTdlnIsNd4nHnkQfsKraheBnh
 BE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790340804; x=1790945604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HaRnV5HNxYS3xKGjNmztf83AWXiwarq2vGsbWimUVzc=;
 b=usmiH0frOieOjD1ZTUhmboTDxCuT1o/fMgBi8Gc9Dmh3TedR7them/LDeiRvYJXFcf
 dioBT4Dg55Ocyd1HBza8KSKvmP22YNWmBVIn5HhDGXu/L5OsTuJwwd0lPq1yYuf8qpF6
 Ns0ysNOErRdtKQOqDDgrphqa69LSfmyHZdneoCpx0LtSrbrq1hNM0wHJ6QYWCovVK74M
 5rOD12WzrAKPNY62LGIsICxlW0wqWTWhiliv056mMeAsV8qtbSKetSE8ydSdSgIHf+B+
 hoP/FmgDIoIQ+w0qvqq6nHF13mHjg6CgxjSKgqqnIgmCyVVub+H0s1x9HB+h1fjuvVgU
 7XGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwChnYPShU/GQjawv9TQOzpVKJtfMt5wkZ4NQX0lZovBOeLmS8qMzmPd2qxx03CUU4QdkQNonGJQek=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mpBjs1cvedGmwtnI18471Sk3H1U9OJdBndEGaRaEIplxtyVe6C
 LX03jiDMcJVVjZXCuNOSMmW+bIVIPwuhHcGl3nnKS5WdGulhZjDaCSlN
X-Gm-Gg: AYBFou34fMK8FSZnVOFMfmnVimu1UFeUoTmAfF4erbqTxgPfzO5pAwVwPPHnuP3ACe4
 Rn6uZmUmFyLip2VBBCl+R5cI0vWeU5UG3TBadaj7KwK2AaR39SEp3gogn6PLevKrj+6n3+dcD9f
 2dZyADwT0Pt8tM3mptmzeUXTrvdwDPhad5BWbnV9htqZK+AVXI337txNUeBfWEyaVI595DsBE4V
 fZZv06gEVjs4cIkORMNm6AL0iI+utDV3wDVpB6yrdBq23ZRu/HIDkxXM9K3O14OYb8TQ3OPq/Rk
 Z+fcx4nBIDY2codtltwPe45va1e9pzMf50Ohe65c67hWHW5tuAkl1vvBqrFLwKSUSe6/wDGpQfk
 gGyVpOoTAnylvmHzN/HQhUGEN/OAf3ZPAK/Ia32H2lTnvkfPTR/x5v0Yaa8uJaXM+k8ztcYUXZZ
 6s+LLt19A7gn3tSUurl6qBidnDOEKxQ0ixgfp+UISpV6kotqr4+/Tenmvq8NlIR5iaSUJu/UPGa
 zStNtLIng==
X-Received: by 2002:a05:6000:2083:b0:487:463:92d3 with SMTP id
 ffacd0b85a97d-4887171a473mr9808865f8f.20.1790340803845; 
 Fri, 25 Sep 2026 05:53:23 -0700 (PDT)
Received: from localhost.localdomain ([194.154.195.114])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4887a355826sm7170296f8f.18.2026.09.25.05.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 05:53:23 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: don't report link training success after a reinit
Date: Fri, 25 Sep 2026 14:53:14 +0200
Message-ID: <20260925125314.16563-1-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

When every training attempt fails, the retry loop in
msm_dp_ctrl_on_link() ends on a successful
msm_dp_ctrl_reinitialize_mainlink(), leaving rc at 0. The caller then
enables the stream on an untrained link and the display stays dark.

The retry counter only reaches zero in that case, so treat it as a
training failure.

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2434,6 +2434,9 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN)
 		return rc;
 
+	if (!link_train_max_retries)
+		rc = -ETIMEDOUT;
+
 	if (rc == 0) {  /* link train successfully */
 		/*
 		 * do not stop train pattern here

base-commit: 4c253ac4b29b8c6cc6fdef8f92d4facde62e63b9
-- 
2.55.0
