Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFF606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=W9rQcmyK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1FCA1121EB;
	Thu, 29 Oct 2026 10:52:02 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9614510E74D;
 Thu, 29 Oct 2026 08:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1793263166;
 bh=boRhbr+FM0tKBVcgDQpQ3P+TqBiVA+fRPepHBkPCF+8=;
 h=From:Date:Subject:MIME-Version:Message-Id:To;
 b=W9rQcmyKjgTytjMR4u3B+Cu9siLmCoXsuRELJAUCJyASY8qIF5vrv1R4Re8xnSUbK
 gVfbD2Xn5gfWWsCkvtOxb8C24mQrG1z+rSMMdKRmCt/qqVWkEJ7huG4ggEMTyHu3gy
 vlwEtPeR7oKunhFbRTPrLKlTbjeK3m4Fa8izsMHE=
X-QQ-mid: zesmtpgz8t1793263159t33143ec8
X-QQ-Originating-IP: m1XVQ5RI6q/S3Bf3iwqFd6FKZ8h9v92/ZduyIH/iRPY=
Received: from LT-LIANGBAIHUI.dc.com ( [120.237.158.181])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 29 Oct 2026 16:39:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17958232766869935615
EX-QQ-RecipientCnt: 15
From: Baihui Liang <liangbaihui@linux.spacemit.com>
Date: Thu, 29 Oct 2026 16:38:48 +0800
Subject: [PATCH] drm/imagination: retry runtime idle when firmware is not
 yet idle
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-img-pm-autosuspend-v1-1-26851840a34e@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIABcG42oC/yXMQQqDMBBA0avIrDtgYjHVqxQXakadgjFkjAji3
 Rt1+Rb/HyAUmATq7IBAGwsvLkG9Muin1o2EbJNB57pUua6Q5xH9jG1cF4niyVk0xmj7Kd6qHAy
 k0AcaeL+n3+axxO5H/Xqd4Dz/ZG7Y6HYAAAA=
X-Change-ID: 20261029-img-pm-autosuspend-7772d83416f7
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Baihui Liang <liangbaihui@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793263157; l=1595;
 i=liangbaihui@linux.spacemit.com; s=20261015; h=from:subject:message-id;
 bh=zcUD8QgC3EZy/zoKLS2pFNdag8Gz1I+LICYi+Le1+OE=;
 b=BGFNDhIg6gYlpPJnNL7ooDA1mNIquk2dbIWADun6A9/CLBlkcvx7AGym1elhzughIf07XBNLl
 a5MYEDW0pHRCgphZ4r2moevt2DG8eGpwFmP7nHX/AqDlc/SGrjvy6LZ
X-Developer-Key: i=liangbaihui@linux.spacemit.com; a=ed25519;
 pk=L9Pa1YBHFuJrRPNu/FfSW/likBvv9j2dUrR3r+YyJ5M=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Ngwq0BL9nhqb60vOODS5E0lkpgMDTR689lmmhpTtfWsJPKa6h60qF1OX
 C9Wlno9QMtshJED13MtriB5wljj+PhiQKz54qf3txEvxb2bxsCK/YFizDvw0SUIyNPH6xvi
 Fk7xQn4sFwIn8WPopURHSLHgTyXLvCLhtvnrtzhtN3fpsnfldh6qLxvfNuJKuoEKxpZt+lf
 /tCAknFMrLLKdL36ZEz7BbMiVgPgsHjRuRzTdNA4vNGo40OAQoqHBVZg01Zh3/NeryW1X3F
 u1XLrQ2RWeP1oJk381Y3ZLeP9Wd763i3XTrdSrunnEzHenSFwzkLihqYeXWvYlft0fqUGrG
 UxucaXelUwT7nw1tSFaAYoqm8WVj7IC3DKKh2iarg5YoFQ4dVlV5r9QW5P17T2SDIOpTQN0
 Uo2VSdKMAUEHYmlLJCXVVXnfNWukNTqdHeCGwvMT00jNU4PrtRP+9masxQIdbQsuR696bPC
 LD7SrPiGuXQ9IA/+fOERf6JH5tPX+FG2ocRe/7hn1iIPR08/tsNia9URjvCe1kmF/yDZqrI
 R/MEqqp5jTcKzRy+3j4dV5GfP/NuS/WWW6Jn+gu7qik6M6ChyZUUIOFQ6aw0maaMR6ptqaQ
 6VHEl7gg7wa4fE6TmNkewr78Ofo8hqSEmwsTeVjKMwZO0bBKT2tfjSVtM4Sdwi4mRLsBC8V
 psBEP0psW6pB7GDLm5zgW1TgNZpxgMfHlVBxmGHYe7bD1nwlgJcSQ2xk+8n8RuOLPyEBMYn
 lpI3egJWpYrvt677tSCg5dSKne5PRrW2dmKuYFd/y8QMqV0e3XlqgfSx3+Q1ADgYotnYr//
 Pwnpem6UUoOZrXejf2shvuVE34tegafbFqLAD98xc1QgyevvIwYCAK3eJoC9aRoZl9yb+lM
 X+T/rBfHw+FUG4XXpY6rUwsObeJh0QuCc49pm7sChXa+E3qw+lL8eWH70+5mB4lNEgxtpfC
 lRgXP48L06cpk+ei3CcJX+Q5mkjGBheJI6V0IXvu0INJBEe8sUIjVfCh8uLlnQgyQBDDcGi
 SmYVoLhfwD/vDcy1AYHFJi8999gdCgYZsVWX5v30HT1Lkyjy6z/h2y+GiyXRY=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Returning -EBUSY from ->runtime_idle() prevents the PM core from
retrying the idle check. Schedule an autosuspend so the idle state
can be re-evaluated once the firmware reaches ROGUE_FWIF_POW_IDLE.

Signed-off-by: Baihui Liang <liangbaihui@linux.spacemit.com>
---
Tested on SpacemiT K3 (PowerVR Rogue BXM-4-64) by running vulkaninfo
repeatedly. Without this change the device intermittently stayed
runtime-active after the last user went away, because the firmware had
not yet reached ROGUE_FWIF_POW_IDLE when the idle check ran. With the
change the device reliably suspends.
---
 drivers/gpu/drm/imagination/pvr_power.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index eb4b6ecdf4f..6f38249ffcb 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -434,7 +434,16 @@ pvr_power_device_idle(struct device *dev)
 	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
 
-	return pvr_power_is_idle(pvr_dev) ? 0 : -EBUSY;
+	if (pvr_power_is_idle(pvr_dev))
+		return 0;
+
+	/*
+	 * Firmware not yet idle; reject but schedule autosuspend so
+	 * runtime_idle() can be retried.
+	 */
+	pm_runtime_autosuspend(dev);
+
+	return -EBUSY;
 }
 
 static int

---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261029-img-pm-autosuspend-7772d83416f7

Best regards,
--  
Baihui Liang <liangbaihui@linux.spacemit.com>

