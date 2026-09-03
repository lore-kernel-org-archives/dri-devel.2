Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD69C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB2010F556;
	Thu,  3 Sep 2026 12:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="r1Lx73P5";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497ED10F554
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:10:24 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C2E442704;
 Thu,  3 Sep 2026 14:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788437331;
 bh=UBQwu7EkiRyHayJZV5qVkvS/RwjElam8/bIbMRrRAvU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=r1Lx73P5L/JpFPfqrnTJtvidZ8nW9GWqbIlhfzv9SBcFcoCa1mH+PwJsHUOsRpzn0
 5ElgUerTPodREuN2iZkVJk4bfBG9a5K241Aj1VZOPaluMMaG6SoaKA4zLo6Rb8t5Ol
 pM4vKHBlP1bCbNl2DHLR1YifmjiVjA68gwfnDDGQ=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 03 Sep 2026 15:09:54 +0300
Subject: [PATCH 04/10] drm/tidss: Remove extra pm_runtime_mark_last_busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-tidss-pre-beagley-v1-4-93928baa8b12@ideasonboard.com>
References: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
In-Reply-To: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
To: Devarsh Thakkar <devarsht@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=797;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=UBQwu7EkiRyHayJZV5qVkvS/RwjElam8/bIbMRrRAvU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqmWOnZ1U4kjcF0QjKkh5qSqRtbscA5mRPgtZfk
 5Z8JFMQMOWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCapljpwAKCRD6PaqMvJYe
 9SQhD/wORDCV0Jyc3U94bzIlSY7YITgBId6KPfMs6+w/vb3gl7JMF6vdiW3rbl05AGNYmXzwRvZ
 JHuQEE3Wn/+l0Eddl+xe3BS0gN9mCSsCTfZNzl+njWP49Q7gRsnjLx7z1hx5DEuGJJ/HChpb8QT
 2UrqG3+xI2xWLdsR+D9+mTnWQULoQpz+wihK4BpV1fai6ouDVYAAz9mMmbPNtNHtA69EaYRb0+Y
 Lp+3Ej/gF3B7wuiA8olEcKvn2QrW66ww/IFXtndjIe6jjrJ3a1M2JlgFGgHHr8U+gGqBVrPn0w6
 /HYw7ErG6xHoR0ksvBCmj2DDI6Rm5mJDI5IS7mScVwTM/CDJIS7koIrwEQXWaUfnX1n/KI20AiX
 HV94Teltne/hurR9L0Whp8BsREjbpIfYijbs7zzNs3HFhYJHuTB/Xde5YLSbGGZKOaiH7Q35DWL
 hTjw73IBU8YUFXqGqEeN2PsgIDBhkMgyBFaPdVd+U1gQDZKjIylMqEXqwJMDz8KpSqfBUvP6Mva
 ChrwC/6G0hLCqGuW7F9RAeqsMCmNbgJGJQ9Ux+U6p1gR8Y1ZUaDMPOx3vaAxGUQHAgOxCcXWCd1
 QK35yliR/4uTS88yCN921rbL49tYQxl+ty+2ErqDuQwVWRHFjVlB7fzRHGPbvur2aWvmW7GkHwX
 N5EXOBS4U0cDluQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

pm_runtime_put_autosuspend() calls pm_runtime_mark_last_busy(), so no
need to call pm_runtime_mark_last_busy() explicitly in the driver.

Tested-by: Swamil Jain <s-jain1@ti.com>
Reviewed-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 1c8cc18bc53c..5cb3e746aeb3 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -42,8 +42,6 @@ void tidss_runtime_put(struct tidss_device *tidss)
 {
 	int r;
 
-	pm_runtime_mark_last_busy(tidss->dev);
-
 	r = pm_runtime_put_autosuspend(tidss->dev);
 	WARN_ON(r < 0);
 }

-- 
2.43.0

