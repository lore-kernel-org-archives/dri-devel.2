Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D3606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MSgUe5e7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 094621129F8;
	Fri, 27 Nov 2026 10:27:45 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFB5112997
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:25 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so4166209f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774464; x=1796379264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mLyO4AhRjnRtKKiwchzwSdvyP2jX085GcQOLd7xPquo=;
 b=MSgUe5e7WhtYV/xFMjdF23W5Id8dUrRD03dBOdUrjUswjKDwRDsc0NXr29mIWf0yEY
 ve6fjevamHr7qFhuBkitof3LOkKoZWFUsljgZIbZoxWFlkjUa2UFjFBl3w441iO6OAKl
 vRKwAKZgHmOUlChxIzYT3XOS9lXZLkeO3k50r5O5HHkDoTFnF7H1g5oxL78Xe/J1sJoW
 iC0gt/bEQYPRO5+eCQCTQ5/6l6Df4lPmJTqMdnLOTWq85tdySwoaHfl/QcDHd4Ggz9x/
 v8B846RL+pLmRzfauElAEtC8Fiq9udvrKrOuy/EKTa7cZ2Mqmc6WAvgnHUSSjUXI7Jvd
 npGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774464; x=1796379264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mLyO4AhRjnRtKKiwchzwSdvyP2jX085GcQOLd7xPquo=;
 b=KNCbkWXXiTihvz7fyVkpupaSAWDQDRPBcjx+VlP0RWWZYV+58FlDsOoPaGikjFrlrD
 288jiS3S+N2v2u9ZKhyFGA9ejxv8hJEI/h2r43J7Ek7MDBfnXmiFxDogqWZvTHjkZUgg
 SIm+hJYTOchwHssrvSWcV+eDS6d9DsSEWWlBiWLoFqiQqOE4nglb/57Otk22vVhmEmFn
 FlBKo3FpJVFnXcjX00mVMUVpcNPt0HUJS2dt3rSUByfSGXg0PJnpl8FgnWcgXt95thRf
 rqrRTbkIe7r8cZUZXqo+sMKjJhfbXLK4NNWdFqy3XmGiMNqyLn3lEzGu3Fg65YatKqy5
 kn2g==
X-Forwarded-Encrypted: i=1;
 AL+hErFO6Ki0WLJOzs8US680pQw3jf6FA8F1NEGdikzY1uvQxQFWb5+PyMFgWpPYp50FdjvkeQfKryLW+eM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/OOjCujK0Do8V6BZPYrRcx/D6rZp3mivd7OBM3GrqaA/9q7dqs
 uHvse8+vR/efSZL6U/P5Mox+tpJRCD2IAU4L3l0rABxYn/6Cf44lxTw=
X-Gm-Gg: AZFdTZfERHkuY3MN+rDTJrlsVlox12uuA74vofiqDhEAoKX0zDUqovxSGB5P3J7uM3f
 PUODUtFJBIAt+jzZcwBxY4h4kW7gdQhM+SNDtveBbtPEgXcrXTE9Th4Gc4r7ovoj/r1Ex6YVovV
 gSjAJMpDcG83NkNVjQUVz74ZxnkGHdLBolUF4jWEYrzrkb4v1ePCUk06xe4ltDfv/0G7nP9sKWe
 svg51yHAubUJ5XOuqdcYNXA+M1Szij6k9XH5VrYlJ6PcgFMGrVzSLB39WC8rdK7J7gUb0jD9B7H
 TtaqW+Ae5pgpbQQ/53OpnUeo1ukwghHBCcUiwnf/3Dstw68HXu6T7b3NafSpTA3SkgORXSk6OLw
 0/uq59Gc46Z1vxb4oAukOAwJZQZ5GO0B2ykaqTtaHLsZO9wN1n9Rzn4sOE5N/Q1ahSbE0TDGB7Z
 kVC2kqU3CJo6UBehmKxTdGlmxj19sJojZF6K0jIs9Gd3U9YVDkT2J+/jkZ23C/FaJ8ex2Pajy7z
 jPlXhve8xWhPdGIOolzbefhmF59y5sI6a9kkql/xjjptep56rMgg56zgZ68Qcn+rm7m8mynAS8X
 vSGoX3l3jyayZ7JklO9iaBDBupuCuttgwERonQ5+/xK/5FzCLdn6IfdjiLS60Ojtky0zJDsjs3k
 YoL9hHlPPWrENrcUeigbBYPvd49izuXdYZxWQt29+4/CaUnWAzqkDOoFl2Lo=
X-Received: by 2002:a05:6000:299c:20b0:4aa:2bf2:4d98 with SMTP id
 ffacd0b85a97d-4abb0f3b4b0mr35473305f8f.29.1795774463951; 
 Fri, 27 Nov 2026 02:14:23 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:23 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 Dale Whinham <daleyo@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH v2 01/10] drm/msm/dp: configure voltage swing and pre-emphasis
 for all active lanes
Date: Fri, 27 Nov 2026 11:14:08 +0100
Message-Id: <20261127101417.24303-2-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
References: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:27:44 +0000
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

msm_dp_ctrl_set_vx_px() only populated voltage[0] and pre[0] in struct
phy_configure_opts_dp and relied on phy_opts->dp.lanes and
phy_opts->dp.link_rate remaining unchanged since
msm_dp_ctrl_enable_mainlink_clocks(), which leaves them stale if link
parameters change during link maintenance (e.g. DP_TEST_LINK_TRAINING).

Populate phy_opts->dp.lanes and phy_opts->dp.link_rate from the active
link parameters and program voltage swing and pre-emphasis across all
active lanes to match the generic PHY DP configuration contract.

Fixes: 937f941ca06f ("drm/msm/dp: Use qmp phy for DP PLL and PHY")
Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz> # x1p42100-lenovo-ideacentre-mini
Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index abd3dcdad03c..b896196cf244 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1374,13 +1374,18 @@ static int msm_dp_ctrl_wait4video_ready(struct msm_dp_ctrl_private *ctrl)
 }
 
 static int msm_dp_ctrl_set_vx_px(struct msm_dp_ctrl_private *ctrl,
-			     u8 v_level, u8 p_level)
+				 u8 v_level, u8 p_level)
 {
 	union phy_configure_opts *phy_opts = &ctrl->phy_opts;
+	int i;
+
+	phy_opts->dp.lanes = ctrl->link->link_params.num_lanes;
+	phy_opts->dp.link_rate = ctrl->link->link_params.rate / 100;
 
-	/* TODO: Update for all lanes instead of just first one */
-	phy_opts->dp.voltage[0] = v_level;
-	phy_opts->dp.pre[0] = p_level;
+	for (i = 0; i < phy_opts->dp.lanes; i++) {
+		phy_opts->dp.voltage[i] = v_level;
+		phy_opts->dp.pre[i] = p_level;
+	}
 	phy_opts->dp.set_voltages = 1;
 	phy_configure(ctrl->phy, phy_opts);
 	phy_opts->dp.set_voltages = 0;
-- 
2.25.1

