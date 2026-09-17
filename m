Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D810C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 19:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE41010F090;
	Thu, 17 Sep 2026 19:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GqqbyXVD";
	dkim-atps=neutral
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2825310F090
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 19:25:26 +0000 (UTC)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-9105d241693so463246d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789673125; x=1790277925; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NWTMcQH1C+AONjQx5Jl8m1ayn/JT2ZnanuB0BziOVNY=;
 b=GqqbyXVDOhV6CwF3S0vij58hzUkCI/g1q4EfRrqrqfql0u8xXkxGXWFoI0GjuL0oOv
 aHxp3fGRPFkt43HtsdfM31nmmAwu6xZDRofC4+Rnn0lJRVSpVLz4VZBfTItuS3BAWenu
 WjZlrQt2H0ixaCjvLeMyaI6OauaWBzGRD9rIVZquxxmavnW2hoqWPlaU3XEtJuCB9fk8
 wg95lpIsyzcM4lYNQnw9T6whxdYBbHKZvsmqtzM6alFwMhquD+gOWeP0QslP4Ro57For
 5TYrR4ieCnHdF047p3/ef5wv2vvwqZ6DUq8PGLpHVFh4lDDm9dVGSL7+Okapa54Ogjxt
 IRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789673125; x=1790277925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NWTMcQH1C+AONjQx5Jl8m1ayn/JT2ZnanuB0BziOVNY=;
 b=G5ETgMzxM9QyD6UuW1XhhZHbjQUV5W639+CIrgUMdBBEpWafv+OGs0rjCSBFtN2P01
 9wN1v288JvIy48L+1KRORWuzgXCfCJxS9m/gmsoVMAdUwQUUEtJ3q9PiHlGc10mFdRIU
 PclNDOkBiyeemCttKZKKzdcK+M/iCRUIj74V48QTZghJXVNfw4muiPAbpwpKhD1kZ74X
 ZlcnuCfhbTmDRE+dKDgVNwW6yoNOp9msxMxN25NfRl03deCLkWub0VQPpwCZz1UxpSx4
 CjKzsFhKFXndKCmpTDCqW5vI8G8qpgSjkMf3Sy42jF12VesDXX3//xLXtAEAgsR5YDvE
 Os+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwHsKf+gT/HCSVlPf7DgUsRUuAk80K9WZ/5d1BmGy4i5VwxlmukR1fHL4bhv5eHCDf7pa7K2oVv6Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mVSqC2bRnV3u+2OscJstBPHkkLa2Qx0SqRsVzhmhKyU15OYDs3
 tway3sTxdzOBMtKn+psV/ZXWLatCUTsDyXPnoz21WvULtTRLre5hX2o=
X-Gm-Gg: AYBFou3u0KZpAAprHI/oP7IrIhS/rY0GFAbaFZKVAnUuIAl5NnCZv4iGwRpiMuXSy8d
 yWginre0PRoOGNSx/R+Fqg3HcxX/7aqXWX4UZvQWvCNVGvN/vtmKldPDS2dzvAw2kDwozp2zQgo
 /ZxWdphzKNLl4qn767hX2G5tLghi2euPfsp8vXX1+zfl0vN4s9wGkkcnLWAEhsbuP6/JLhK0m4I
 HwbAjuvk/KoLJ3DAnryCIxug8kBdMpU5rum5x451va+Lfc2fF8kPnLl/v4OkqcZX+inaS21Ll+Y
 rTx9LtWegBKu9aFP5GpTYeYLftDIcgPlxgn+3yvrY8WkqUUKi0UayI/+1ExaHkqXMNhrx4ecK8H
 HGV+csjMoNlS9UBKIcUObs27VuPN1yDfCbRLGyTdkO9MyXJFey5OYBUV7mnBBRqdHEfStfo6qD8
 k5uAEa8zmRQMxRRT8cw4xcb0gOTqvqE5AqnN3gzT2KcFmNRatd4BiwmcT/gKw8467RBx33Fy/FF
 88lFXJarAH9+BzJ069Tg4B8H62CnSvg1wPHSUbH8C0wRN6LtHMD4Up+RNqAY5tFFu2EIcyX4Dd5
 bs/b8+fQo9uJdJuYHuOlJl3Aeo6scXRHNATbag==
X-Received: by 2002:a05:6214:14a1:b0:910:3453:9011 with SMTP id
 6a1803df08f44-91254cb14b3mr2393886d6.35.1789673124900; 
 Thu, 17 Sep 2026 12:25:24 -0700 (PDT)
Received: from localhost.localdomain ([104.39.169.225])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252a794acsm5546826d6.0.2026.09.17.12.25.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Sep 2026 12:25:24 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] accel/qaic: Cancel Sahara read data work on removal
Date: Thu, 17 Sep 2026 15:25:12 -0400
Message-ID: <20260917192512.56205-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sahara removal cancels fw_work and dump_work, but leaves read_data_work
pending or running. The latter accesses the firmware and the device-managed
context and transfer buffer, which are released during removal.

Cancel read_data_work after fw_work, which can schedule it, and before
releasing the firmware. The MHI core suspends and resets the channels
before invoking the driver's remove callback.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code. The same omission was also reported by the
Sashiko bot while reviewing the Sahara relocation series.

Fixes: 7fb19ea1ec6a ("accel/qaic: Support the new READ_DATA implementation")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260701105055.8D4371F00A3A@smtp.kernel.org/
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Validated with static source review, apply checks and strict checkpatch.
No build or runtime testing was performed.

 drivers/accel/qaic/sahara.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/qaic/sahara.c b/drivers/accel/qaic/sahara.c
index c7c0b3eb4b65fb7776a6c724cb3105046cf6f7eb..6487961bbf14a1c284caf91f500968b90a064ef4 100644
--- a/drivers/accel/qaic/sahara.c
+++ b/drivers/accel/qaic/sahara.c
@@ -879,6 +879,7 @@ static void sahara_mhi_remove(struct mhi_device *mhi_dev)
 	struct sahara_context *context = dev_get_drvdata(&mhi_dev->dev);
 
 	cancel_work_sync(&context->fw_work);
+	cancel_work_sync(&context->read_data_work);
 	cancel_work_sync(&context->dump_work);
 	vfree(context->mem_dump);
 	sahara_release_image(context);
-- 
2.47.1
