Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A00C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 844C910E37E;
	Wed,  1 Jul 2026 11:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dftIjrNE";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B5F10EEE4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:04:26 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-474560436c3so510197f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782903865; x=1783508665; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=DzEMcOPWAAc3ya4BWHLrviknUVsExWDTeL6YrPN8Pco=;
 b=dftIjrNEVyHIVA9/KNiSFNYwMCNO7kVdQJyNRfyo7EXDUCEowa+LoNfIXltJeRW6gb
 ytHeCH0mn1TSFkn1RqyMaf7tm+2fj/QXRD2n7PrnfF/0q1i77c2yi2BvuCSrE0uj5blU
 Z68Ztg//4Mw1xYPCjBvn4czLSm0KjZFE5UEWolp4jISsO7Xi0AjRsJURBCTrscUJmQ8R
 mgSlnrq+8kTMP0jaYCxmv6Ncn5FHG7DuutofxHo0IXru2dCpONaz96uN5csnPd6ntGI9
 Q7w75nxcu6Gsmwq2CiO/3kPbDj5Gj6EQaV0S+1VyDi0pz08t3qFUoPJhMNeWp+IsYk//
 nArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782903865; x=1783508665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzEMcOPWAAc3ya4BWHLrviknUVsExWDTeL6YrPN8Pco=;
 b=oKh2b/9xLlr/K37BNwStLHl6dQxptcmf1faUfmjajM29irliB0nBQLuV5lkWW1PTpw
 42bfA2Deta1goS07S+X5sjI5UteqILloB4DHOVPvnnZMxwxRZHYcTgy7J3h64gaWTRP+
 o22TJQWjo2fol8t8+o1lue46+kTI2kfYLmklRRF2yixizy2kCoATyuHI5zTlXnbC0bp+
 EDD7R98vPH/XK5wO1XtSUjQq+IGABMlT7g0CR6wZHHlZYUycx91PSBiXMzoerVzCWGGQ
 pa5I///2wTZyC4ZDXl/29hNEREgmEM6l75TjRLrPJyQRxppmC9Bgwyrtywsbaf055f6Z
 6/xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VrbQh+Ucro5Nm4vL0IKmMvnR4JnF4t8/etvcgNsO8sGovRQAi5oY8qNOVZm3u7CAAS8sGTgx19eg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyblytgI0GHxVdy1N0RM6Wk6RiIRT/18Badesy4LC6CxX47MGeW
 FRybuakeVvhFeCyUS68Hba+j2xTP6+XBaQ8KR2AV8coLgxPeabstLZxC
X-Gm-Gg: AfdE7cnSKB6B2vpEWCzWhztrGi1CEhitCahpGny9Dhm1de/IlNsCW8izsBjkl2rmjtB
 p/ZoENY78P9fY6zhwgGZYMM+uH4cX89RkNMvhIWpTB3beUvIgzOZRQAMhoGzb0HOQ8EOx3o3iL/
 DxKN3jHhodEJdQh/D/hP48kqnQf+lL+V3fZfysFq/BtyfjBCPLd0JltS/66ZD2Ud2Ir4LccIuI1
 hL80VOnbSSjbLbIn1275WpQQ1JzF8LlvzMeVzEFXKSPTfzMxU6uzDjIApjbHgamOUTzbl9d0tck
 /SYIU0Yq1xStG/+8XQVv3SV5Tupdm5BwJFglCH3Ji93GnQIE7DfMp+hHJ9VenLz6k5gVg8/hYxD
 fMQcFNgwbMz/T1Q15USAzSY5GBCMIiy+BsmXtDDMWFU3jxpZG/cNAtzr5yfMdqTZmAp0ptWGvdV
 H9ArlzFnkAHbvw6L6OrZ+oNqSX1SJLCuw06/4q1QC+QqRS1ZE1HcN2TXOhVMs3A2vAm/d8mBhGP
 /3v
X-Received: by 2002:a05:600c:64c5:b0:493:c3e0:99ab with SMTP id
 5b1f17b1804b1-493c3e099bbmr437705e9.25.1782903864587; 
 Wed, 01 Jul 2026 04:04:24 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475641e4659sm17142835f8f.12.2026.07.01.04.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:04:24 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: andersson@kernel.org
Cc: sumit.garg@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
 sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com,
 jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, sumit.garg@oss.qualcomm.com,
 harshal.dev@oss.qualcomm.com, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] firmware: qcom: scm: add missing IRQ_DOMAIN select to QCOM_SCM
Date: Wed,  1 Jul 2026 12:03:38 +0100
Message-ID: <20260701110344.1999068-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

'drivers/firmware/qcom/qcom_scm.c' calls 'irq_create_fwspec_mapping'
so it will fail to compile if IRQ_DOMAIN is disabled:

drivers/firmware/qcom/qcom_scm.c: In function ‘qcom_scm_get_waitq_irq’:
  drivers/firmware/qcom/qcom_scm.c:2512:16: error: implicit declaration
of function ‘irq_create_fwspec_mapping’; did you mean
‘irq_create_of_mapping’? [-Wimplicit-function-declaration]
   2512 |         return irq_create_fwspec_mapping(&fwspec);
        |                ^~~~~~~~~~~~~~~~~~~~~~~~~
        |                irq_create_of_mapping

A patch-set in review proposes making QCOM_SCM visible in the kconfig
frontend, so let's ensure that it's safe for users to enable:
https://lore.kernel.org/lkml/akS_6izxrhgK-I22@sumit-xelite/

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/firmware/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index b477d54b495a..9d137fa2aa23 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -7,6 +7,7 @@
 menu "Qualcomm firmware drivers"
 
 config QCOM_SCM
+	select IRQ_DOMAIN
 	select QCOM_TZMEM
 	tristate
 
-- 
2.54.0

