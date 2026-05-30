Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B35DCD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 18:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24C6112975;
	Sat, 30 May 2026 18:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jlhaXVlj";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8471B112975
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7enz4gcQiLIfjVjqzal8uYVCR58CXNihYovchfiIjMQ=; b=jlhaXVljb6WdTfvCimIrHONh6a
 uyLspECgzjX6k7L2L09vPdyaRgQhZUb9skJVWhn5xXUoE1Dcd6y7HLdtW0JVL2ODVxfwvynJ/OCbE
 Dl8Q8PAwH795kB5sBhPNBZLYHbxwdHhCUbSJstMLAcSn7v0VvwhxaN10mEJFflYzCAPBXNqmksoFp
 +kOdIQ6Ir1774KH3FkfjX3ju/zbx/iitklHw9+TBKvILwlJdfgjN7t5xJSv1Ch48yyqSvvi+4g+q4
 E9hwFrv3UKn9R6S0IDrqoNg0E44e1ddtukDN8P7kofIPT19iEtY7UZ6EfLVMVr495Fx2bAe1BkySH
 1jjduqYQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wTOZW-00ALNh-K9; Sat, 30 May 2026 20:38:10 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 30 May 2026 15:37:44 -0300
Subject: [PATCH 3/4] drm/v3d: Clean caches before runtime suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-v3d-fix-rpi4-freezes-v1-3-c2c8307da6ce@igalia.com>
References: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
In-Reply-To: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=U249Zyx8OWD8Hz2fRM94kbzvHGngcO83tqep8BBUX98=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqGy6IxNb/NGgQp0Kp3Ooed5Kf/2/2JswKe+m+z
 Q84Htm73J2JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahsuiAAKCRA/8w6Kdoj6
 qjQoB/9/PkkjEsj612TpLi0gc6SKGNYTJfOyJVW+EQffiudewHyi3D39H4MRI6hk/OTeumKnVrp
 Hvl9rFJfBmkP94+TyL7VRiytTCYtRFqVX+wJ9UnIbSBILf23oGJ/x2VT7VKBbD86QWQ8lmcZCMK
 iSEs905e3SznChDjHvs63l+s7nf5hi+wPFbc0s+3Tt4yGY3cTFOhe2UAFHewOG5nm0nzL6jDigm
 RUE14l3RWEz8nbLUTEi4ZTVbtxuRPzvvhBogc9TX0bjB57dWCsNEN/Ax0IryHVr9kX5IZ6/9JW9
 1ACvngre88wwcp95q5LdowalZli2iXyc0o+1uIan3faE0WCw
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

On runtime suspend, clean the V3D caches before suspending so all dirty
lines are written back to memory before the power domain is shut down.

Fixes several system hangs reported in [1][2][3].

Closes: https://github.com/raspberrypi/linux/issues/7381 [1]
Closes: https://github.com/raspberrypi/linux/issues/7396 [2]
Closes: https://github.com/raspberrypi/linux/issues/7397 [3]
Fixes: 458f2a712ab4 ("drm/v3d: Introduce Runtime Power Management")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_power.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_power.c b/drivers/gpu/drm/v3d/v3d_power.c
index 769e90032b04..f7df6393d38f 100644
--- a/drivers/gpu/drm/v3d/v3d_power.c
+++ b/drivers/gpu/drm/v3d/v3d_power.c
@@ -52,6 +52,8 @@ int v3d_power_suspend(struct device *dev)
 
 	v3d_irq_disable(v3d);
 
+	v3d_clean_caches(v3d);
+
 	ret = v3d_suspend_sms(v3d);
 	if (ret) {
 		v3d_irq_enable(v3d);

-- 
2.54.0

