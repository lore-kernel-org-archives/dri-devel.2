Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A005D606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MzIfJ1em
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02328112A06;
	Fri, 27 Nov 2026 10:29:03 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC91112993
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:31 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so5630814f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774470; x=1796379270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJUOBB8U95qqxwIcvt8j09z1Ro30l4rqtcLjgd7Ggo0=;
 b=MzIfJ1emp0m47+/dAFS14/7/GusnUCPUiPQ9Xi+VHDb5ZGsDwBe7yrowtJCGJ2h6Ke
 TQAMuBiG1aeRXcH2T5GOLMpxSIz0LIylDaI8V/3ModIDz5sG3d1ItJbYHw2orRMl6SxT
 /7dvoZ7xcybHA4f/wLBJuYYKk2y7Euyl1yxfvS4HayESZIKy/pFkZjRpv43RRZsK3HdE
 hn9Rqf3FibVe4pdSWWov0CJNsKUL1ZsW1c19wCp2Y8y1tmuDMe3080cIe39YfXOCurEd
 1qD7z6zL1OYiietGEJjoedSKzvG11bA8+zYbo1oNtmAzlW8edFsm6n8F2VXQ47enXQm/
 E0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774470; x=1796379270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fJUOBB8U95qqxwIcvt8j09z1Ro30l4rqtcLjgd7Ggo0=;
 b=h/qz9wVjg6JCg2lSgNLpfWETseuxNEYxzOQ1R8DamCJ/4xT7cgQaptOz/29UP+6Iu/
 dKamozEnPfLHjbLWItclO9swo8z3fTplQNFh05/PE0rT19iBwiKTxWg/17HYPssqxDBG
 DZYRmGvLumdLB64C5bLnEiraDrgm+6cy/VrRccEk8fyMkjZKxPNpzt/quvQ+Pi7eta2a
 wXpK8BR8ZlnVvsLJ0KAVeKiP3K6TJLqcO0rXN8aqxxIOQYhkOIQWK/EDkXRmPG46NSGz
 SKZXaVu4Gv8zL4yq3dDe2U7SBuxMkz2oMh3eMZ/503GYAQMx9TKeoyqdxm7JMD4sQoqW
 bXvw==
X-Forwarded-Encrypted: i=1;
 AL+hErGyCBX63PbfMjZ7pRfPbBBFPSZNyjbHvesGHyp3NXj6e2hQOuBPslD4x26t3bMuokblb5df0IizGL4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/5RPCPpm0MYlrIesf3LUlxbYCHO62KcGLbxl2HW5sZ3eWGKLIX
 PDZFi0pgDfqZ6TdDvmPDm5i4hVA7hAohSUQWGgKru9IjGI35ZMkyYYI=
X-Gm-Gg: AZFdTZd7yEjDR9iVBvAJKdXpLcwFSZTQLutWi5XyID6w8bBNXU75+rB2lYv6qSjvkQK
 UHb7unWL2SUoTknKNmmGNq8oNGkYUL/DFqO0qSXXHvfp5gk83F2DtgFWVLiA+zYkiQPR3fl2ZPy
 KYGqZffEoWP04uzTzLrdo0GHTexx1z0Ys0ahcCPo5okp71uwMLKYhx+r2yoAMAY14oAWVxcB86K
 zM7cAt+eK+J6KTanR1Upiu/W31x56o7h0Rh8gX+eFlzl9B3jCl3YnkpA5f6dYXeDZ7GStaRe1ue
 aPH2QM0YNR3Y3MDFrNGL1VUgWL0/zlq165F9GZg7Bv2IcbRRrIIOhp3MZqwGR/22XfVf9rgiS6n
 NUAbY12YruLESd+idch+b4Rx0WrtRTxtL85F8ALoYSfULllNp45phRwj7bLsq+K8RlnJ9qqY+dk
 h9bH/Bx2gVQNMfnBNz68COX7aIVQ213t0p6Lh0LK+xNa/yBFOmxSQdDGxOFZJa1V67da2SLclh7
 Wx7Ydis6NCC8hUt0mryBXvGS8i9ZO8/sR0AkM8iAkAMcIpluDzIrnfZJIpWE09rHahlMobZIvfc
 uj8s/vVWDrGrN1F3bpju73kNwrwAcA0cnZZxY+BklImx58sq0LccpE1D7rtfn9SuzL5Dl2h7/cN
 yjauyvglwV8ecTivhIgqOuH2ZZHlAkSJaWOfFlxgTNXYBs4657iJiQkUSsCnlVnvInZ5H5YyHkZ
 QOqguboQ==
X-Received: by 2002:a05:6000:4812:b0:490:88e5:92d6 with SMTP id
 ffacd0b85a97d-4abb57f6e95mr45513944f8f.49.1795774469450; 
 Fri, 27 Nov 2026 02:14:29 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:29 -0800 (PST)
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
Subject: [PATCH v2 05/10] drm/msm/dp: avoid synchronous runtime PM put from
 HPD IRQ thread
Date: Fri, 27 Nov 2026 11:14:12 +0100
Message-Id: <20261127101417.24303-6-gianfranco.mariotti94@gmail.com>
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

msm_dp_pm_runtime_suspend() calls disable_irq(dp->irq). When
msm_dp_hpd_unplug_handle() or msm_dp_bridge_hpd_notify() executes from
msm_dp_display_irq_thread() (i.e. inside dp->irq's own threaded IRQ
handler) and drops the last runtime PM reference via
pm_runtime_put_sync(), runtime suspend runs synchronously on the IRQ
thread and deadlocks in disable_irq(dp->irq) waiting for the currently
executing IRQ thread to finish.

Use asynchronous pm_runtime_put() in msm_dp_hpd_unplug_handle() and
msm_dp_bridge_hpd_notify().

Fixes: 3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")
Fixes: 5043357e75ba ("drm/msm/dp: rework HPD handling")
Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz> # x1p42100-lenovo-ideacentre-mini
Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index b8373740275b..3c15f984b29e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -495,7 +495,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->link->sink_count);
 
 	if (dp->plugged) {
-		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_put(&pdev->dev);
 		dp->plugged = false;
 	}
 
@@ -1627,5 +1627,5 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		msm_dp_hpd_unplug_handle(dp);
 	}
 
-	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+	pm_runtime_put(&msm_dp_display->pdev->dev);
 }
-- 
2.25.1

