Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1333CD5BB5
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2CF10E27C;
	Fri, 22 May 2026 14:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNIE+BJV";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E196910E168
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:07:15 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-369002b26f4so3868107a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779430035; x=1780034835; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyiX7MahC/TLGYvEVYll4nFlnUYS5AzNMKFJNf8jQZw=;
 b=BNIE+BJVl1kBjeovPbf7KgyZoapJT0uflPfIRErvsGhtaqgTPGLhnsMkjY8Xd9gvdq
 7A46GZRErFr8xRqM8bCe4AALyjwI06PN5tZgdyKzG25sP7Xy59cfMO4Z/g2xcgtnzaaH
 /d/iR0Nc8AFKgFrdq8QAeIk97KWkPxysM2L1ciK/viKjhe6J2lud7xL+GNlBX5QI6l0s
 gTsO7R+GgFdhlatFyfAI0wOwlVYZ0w7DHuZdQPqr73CeDcBpyNEXRKndoTnALpV3djID
 ++kYv7s4hA5JsXEaGPLcthEmNO489qYEyviMvWLKWAQVDXNHZ5DK5QXjX1yXNEeVqv6N
 zADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430035; x=1780034835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yyiX7MahC/TLGYvEVYll4nFlnUYS5AzNMKFJNf8jQZw=;
 b=YVkiYAKgltLAcLfFcRcnTyvs0KqED2nSRX6GQKByKz6KAmY4L6ZB1dZZebBYQpgzh3
 n1NwQT5hheLhoc2bLAIm0WbnHH4XcNMA8lfLDOIuWYQruA9DmYW5M/SH0iaNXcpdwJew
 7LF2VktP2bYomxsyb5IDRaMie1h7oPagSm92+qHsU6kKPAC31i/kJKOtf63V0MVlIcar
 k4PiYsKDTIjQrK8+ArBC7wA9O3IlgIVPO18j5WK+gcRH6kwRph2X0uBF+kTvP4BuP5k+
 lKGILNZIDotnpR7g3auSv4E3Qlc5vh6OSlKWNmk+icxVm5axZciNwGxkxbd0RfHyb9LR
 iLHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8AsZcTOmaDHAZD87Jn/qOoakW4tkQiN471EWIzrPtT0Zh3KskA9bflfQRBw61ph2NOyV1Sxrxm3as=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNMBdWtrZZ0G5bJe06kh9g81R1HMZh7xTWt5xNWBBR3zzM++Mr
 fLZQ3QedcVuXi1ho0uq1A+U+GU98trIZtov+3IatWj6E/SLI9tnk+qvl
X-Gm-Gg: Acq92OFh/9pcs+ZFmmBiiSSWiOtISTuTcwN5DgPbf615u2NF5rMch4dPggEQ3p/QRod
 OYVERxBtjozFmqIbcrvL4XvkGVSPsgssp3tf91w/qoEIp4CMV2H+v2Qyu98unc+UGpqDEciJMKl
 mb4BJIatMEK8RooaJX/T8QlsmV8rJp3kHB1wDwi5/oY3cANmQ2WpXs5gU1H5+/ghymmMBvG+RxH
 pA6SmliAvuJiaATJlSEBmBx0fS+dDzbEQjgV83xBZDgj5O+wdyZK96AocYu0dA6OKnzc61ZbNnC
 wI5BdjF2XGWXl9z4eTfSfzBTsc9V5WCoGC2we3nZY3/kqW3CU93oMweAfCeZK/ijqqo3E6P6R1a
 37faAs4/oOhFJezlfgrygIbKhnpY5oNO1kHUB9D/9b3GJzPjUTk50Zb7cS5MfIQA7mVyRyBIsUF
 2hN1CggD21f605gjCms7ygBEEkZ7z8k/vzuiosuJrcKEp/uqkf6e05Fbg=
X-Received: by 2002:a17:90a:d885:b0:369:e4d4:79c6 with SMTP id
 98e67ed59e1d1-36a6782a785mr2028386a91.20.1779430035353; 
 Thu, 21 May 2026 23:07:15 -0700 (PDT)
Received: from radxa (122-58-25-162-adsl.sparkbb.co.nz. [122.58.25.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7212aa06sm428572a91.3.2026.05.21.23.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:07:14 -0700 (PDT)
From: Graham O'Connor <graham.oconnor@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Graham O'Connor <graham.oconnor@gmail.com>
Subject: [PATCH 1/6] soc: qcom: rpmh-rsc: Skip TCS init when RSC is managed by
 firmware
Date: Fri, 22 May 2026 18:06:40 +1200
Message-ID: <20260522060645.4399-2-graham.oconnor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522060645.4399-1-graham.oconnor@gmail.com>
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:04 +0000
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

On QCS6490-based platforms booting via UEFI, the RSC hardware solver
is already active when the kernel takes over from the firmware. Calling
rpmh_probe_tcs_config() in this state reinitializes the controller
while the firmware is actively managing it, causing a security
violation and system reset.

Check whether the hardware solver is already enabled via the
DRV_SOLVER_CONFIG register before calling rpmh_probe_tcs_config().
If the solver is active, skip TCS initialization and return early
after setting the driver data, allowing other drivers to find the
controller without disrupting the firmware-managed state.

Tested on Radxa Dragon Q6A (QCS6490)

Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
---
 drivers/soc/qcom/rpmh-rsc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c6f7d5c9c..7915f12de 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1074,6 +1074,20 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	else
 		drv->regs = rpmh_rsc_reg_offset_ver_2_7;
 
+	/*
+	 * On some platforms the RSC is already managed by the firmware
+	 * when the kernel boots. Calling rpmh_probe_tcs_config() in this
+	 * state would reinitialize the controller and cause a security
+	 * violation. Skip TCS initialization if the hardware solver is
+	 * already active.
+	 */
+	if (readl_relaxed(drv->base + drv->regs[DRV_SOLVER_CONFIG]) &
+	    (DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT)) {
+		dev_dbg(&pdev->dev, "RSC already managed by firmware, skipping TCS init\n");
+		platform_set_drvdata(pdev, drv);
+		return 0;
+	}
+
 	ret = rpmh_probe_tcs_config(pdev, drv);
 	if (ret)
 		return ret;
-- 
2.53.0

