Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABAC606A6C5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GsSjm2cv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0BA7112CE7;
	Fri, 20 Nov 2026 19:21:04 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB8A112CE7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:20:54 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-55d3563e50eso7208471cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795202454; x=1795807254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e1XirmZmVETsTLq+R7/7pu1z8pB6tndX7yNuc+ysxdQ=;
 b=GsSjm2cvstVK7BtnUaqwXQajVxO/Gkx5+xMShsamuStKEY8JSlWYSF+8iLcH2EcNQ7
 7sFQtxQzsNCYJ7ycBZzdAwwG5LS3eF1nfgTPuObBtTVmM225qkFq6iVoFrfxxk065eGw
 cJU/mgxMtDclZyiykrZ4m9pvTsBPZH0yWcRvkLAPh4WglVrjr/jGYIaQq0c4fzRK0xpq
 X0I7rtYkWL2FAkcyD9d8fC3e18d67S86mAQyZMbta9Dpe9r4wWt/Q/tkhzia0A7QL4/w
 4W5G9dUc4Tn101dJ8wsmNVYP9GVctMU9+GWYEF92NldMrgjoSltaeFQhF7qSTWjjaOhw
 wFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202454; x=1795807254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e1XirmZmVETsTLq+R7/7pu1z8pB6tndX7yNuc+ysxdQ=;
 b=dd/DA1r4Jvm82CAqeGJgzso3Pu20refaXxL/vgDeWnsibDbSJve9KpGqge1MavPs57
 Bu8yAm0EhG+d7mxXLFJAjgjZWUt9Cf8nUFHT+X06LN1F0PEigx68s+BFzrtL60OyzsSR
 51SxB1u6yCqz/bTdjbFFzbTNK2YCDbQ0u1bnC69SZiEz/ElYfYx/4BKwD6dy/fKGdcZQ
 eYkE39BgeXOLAxB8h2TDM/ICinXcWk4VjgdwUJWdSdRshqFUgOE16o7V4dMiQkN/fJxi
 sdmbl1+QCJzjCcIs9uk1qaPTfrdD51QA61rcj/Xe0kGhhbWVv0KIxV7eWtGDnEY+maq6
 EmYw==
X-Forwarded-Encrypted: i=1;
 AL+hErHNnKsl0BWIlMDiJOdud+PEAtvxfEh6fSPh1t4YI87uYTkk9aXlFziydUrhPky+1ujy53gmlPbFfDo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/tdt+7bhZ289579iCw40zctKJxE/B/rthb5viHoSyYr8ozgIKK
 oCE2nl0cDQ8Vnt1Fa400Kwn4IZNtryu/05QWUC+VsV8x0G0e2Mb+f+Ia
X-Gm-Gg: AYBFou0LRUb2wtPr27UgvmxSNpoUsVnllkMpy1xIlsx1h3f5xX3xRyt/eSsh9E1ZMHc
 rWQCLlf6ykls46YGGmtz7Tr0iX9iZwB38HqEyER23Ynp0A62vKxap4fCmB8IQWVIG62CrjAZtUr
 6Dt0zYac9rLgi0aj5hyxiow+Ca7tbBPHM7+YCk0cs/Mu4qF7906R+ZNpraci0hN5jHFnHqT4K8e
 g0tvBdchsco9ryjON/eOo9CJemMjNfSAKMS55i+9MlVwUEU2eAlA9dN8pBODGNEK8Bt7A8sSNnM
 lhA25Xj2VgL6qro32vSvjJ75Ulm9tQt1/nw7lzZp1tU2nZwQY75Jejre9dL8IHiJHR/PwQurpVq
 yWyXaZVTm4pksu7tMs94b3ERRCcBYVW7kfUOUqmNartBAmSy0nZkxDYC8UudBHt2QxCv/zHF7e2
 BjfNCf3iMUU3oPxA90t7Xisqcbxg96oXCXlpKVfS4KHJ2jQJeUtb6te0CXvEJVPhEqNNlbZAVHL
 ay7E0bsCHgPidUgG9DFwhj1jZ9ZOv9eteND86+ie7RI1/Qu4B2O1HIYe/pVzIMFpilHr87XCgqT
 KDA0w+z4869sFdbsAxi1S/ZGLW4p5A9/tFqUokb3zl2haH20/GoHbzYVg71N1KIT/JMKJ39vKG1
 HLplOzqlBEV4jwaanjYIroOIsgwtSYPYXpwQjs9qgyAYHYZu5Oirg72JQR1OGLgdxO8z/Gt8XA/
 9/SMjJkUVZHp9wdTg/CVOyRs6Wga8E+hZFWtgRXJvf91f10qk2zjXqNyJRetWojS45XwVgI5hUW
 ltqth5m/zt6p8/6YKp3mAZn2Sn6HSK4p6WAFpdnyuWwdA==
X-Received: by 2002:ac8:5d90:0:b0:55d:32ed:38bb with SMTP id
 d75a77b69052e-55d76a5af68mr73041501cf.42.1795202453655; 
 Fri, 20 Nov 2026 11:20:53 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net
 ([2600:4041:5024:4b00:d420:4621:169f:8773])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882e2c6sm31475921cf.12.2026.11.20.11.20.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 11:20:53 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jim Martin <jimmartin@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 2/2] drm/msm/dp: stop the rate-set fallback at the lowest
 table entry
Date: Fri, 20 Nov 2026 14:20:50 -0500
Message-ID: <20261120192050.73315-3-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120192050.73315-1-jesse.casco@gmail.com>
References: <20261120192050.73315-1-jesse.casco@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the sink is driven through LINK_RATE_SET and rate_set has reached
index 0, msm_dp_ctrl_link_rate_down_shift() falls through to the legacy
switch. If the lowest entry of the sink's SUPPORTED_LINK_RATES table is
one of the standard rates above RBR, the source drops to the next
standard rate while LINK_RATE_SET still selects index 0, so source and
sink train at different rates.

There is nothing lower to try once the table is exhausted, so fail the
down-shift instead.

Fixes: ed100aa239be ("drm/msm/dp: Enable support for eDP v1.4+ link rates table")
Signed-off-by: Jesse Casco <jesse.casco@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index c8d097d65..8d7b6da17 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1558,9 +1558,13 @@ static int msm_dp_ctrl_link_rate_down_shift(struct msm_dp_ctrl_private *ctrl)
 	int ret = 0;
 	struct msm_dp_link_info *link_params = &ctrl->link->link_params;
 
-	if (link_params->rate_set) {
-		--link_params->rate_set;
-		link_params->rate = link_params->supported_rates[link_params->rate_set];
+	if (link_params->use_rate_set) {
+		if (link_params->rate_set) {
+			--link_params->rate_set;
+			link_params->rate = link_params->supported_rates[link_params->rate_set];
+		} else {
+			ret = -EINVAL;
+		}
 	} else {
 		switch (link_params->rate) {
 		case 810000:
-- 
2.56.1

