Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC5606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ikojqqjz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21311120FC;
	Thu, 12 Nov 2026 12:56:25 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A3710EA8F
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:39:04 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-3700ed8dbe3so5972027eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794415144; x=1795019944; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+GAFVM+nLFUYlbY24SmfVdNvtcwr0CEHKsDIq3Mqz6E=;
 b=ikojqqjzmgZOHQyOwrCsKAbOpbw4sTc/eKVSu9Dfp4yIaXNjqeLicCztCrDJYjDTKL
 +oAyVJkbAJL7+dfGajkIy2OYIKomF+44NudY2wfcyjzr0W9Qd8ECaBD8IPpN55FQa4rL
 I9oRLBUM5oBo0TjooeLfpiKsjbm0xMkyt9mgBA8nDDmbUPUg0CCDM4wzWrkA9BJ4Gw7K
 1ZmtgM0eJY72+ZPkOkX+k2AM1HZN1gt1zK0JubjluTWbLbGdlJ8waR3KIfbNEbR0uELQ
 L6zerw/BLuWtYxSGPFt2DG+EV13YU0RCcYhrLTFrkhutB594DNo50f3h40tViV1rOHJv
 WLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794415144; x=1795019944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+GAFVM+nLFUYlbY24SmfVdNvtcwr0CEHKsDIq3Mqz6E=;
 b=og7or9g10togUKZcsBuH9VKyIhdb2K2MdNuZ0Vr5w8hSmylWFkPog09SBS0DN+Tkh4
 wHo9OFZcJoqbdSikw2q9Ucwfgux4l5Qs7Ssd/B10JD8flc4kNLgwyTTwEBNFCrJG/kFy
 vfUNNib8li4QsOyMqnZ5/8ESzAkf0iy/G/qa5mqNmg9nlryt3DrMLOQgSHR4BRVHIguk
 4qhL1sw9AHCjxGen5PkRodgghmhxnQ4l1FdJnqBUO97UfjDGCl0fXosdOw6Nm15wt/Zs
 JEWaIsewRwKnrdifltuJgLb67551FX6RexOE/87nCHtKyUHelozGEqELHpL5HENiU0rH
 ZL9A==
X-Forwarded-Encrypted: i=1;
 AL+hErGoopn75nR7ujw/X+GDmxbzxyhawCarI/Uyt5JlDibUFXiV5Y1K73LcoRlbjsg23zMknr2vPcMynMI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8fVbj74ljXCfSuAY2Opi+SVCyvSiERuBBNWjOt5AMHupqaEZc/
 Q/iLFTNDs9ywe69zH2WqNcTR55TA5C9k42Rt0t/eA4SspRAofBWSqoXn
X-Gm-Gg: AYBFou3PUYiTRegwKTFrKdfUq5JB9nh34RMrIILaifgTr4ZlfcvtVKstRoY4wAvU295
 dHUGPPpfWrzC0trj3ql8IbD3I9xxCUwg4KQTmsl+PUxOOdQd5gYjDXaAZW3A9cOz7M5Io3GzOG8
 HQYK5iFE4QlJc+VyZwwqhSm0tss/Y7MNKKrGXvZjBkIusy7rbCh+WYuoHxxvmeObKHICgwDY7e7
 rnwPF4IbTgb1I3I3ay01TktH5mLkiPQsoFzLpylhY3iBngVWjbWA0O0BNXPL2DHREA4Y7QuSIxK
 4oq/53iM1Z1LQLvtlBCfW5zKJq2TuYaekEehnA48Dl3/R8njPZx/RV8Z9b+Jq8L19kieCf/ZFqI
 Xv/ZBRdMjY6efad5axXU+IWLEuClHlyOWtOf6aLKLdGAMjXB7Ln2O5FbKI8Om8sH+DwMCGRJxmo
 clhaWI0uX30csBQPjFH11DVV2dcjKqRK3vCfE6bk+aZKqSKtvHWFMm9frBtEm/UU/KA4+ORFVcu
 TBGLif/mrZw1NScDfCs9y6/+t+9GdHGsNrsgA8/f4MIK7iiPErOs3dZfuKz2pqHdaFWyIL9xCH8
 1vmjVxGNWiAiVjC+IgIy4DSjsstBiySQ6nF7b9hC5+pKmDo=
X-Received: by 2002:a05:693c:8201:b0:376:98e7:eeb0 with SMTP id
 5a478bee46e88-37698e7ef92mr3137525eec.7.1794415143641; 
 Wed, 11 Nov 2026 08:39:03 -0800 (PST)
Received: from himanshubakshi ([2401:4900:1c2d:8feb:6d7e:ed5:ad5f:62ed])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520bf3e18sm35046496eec.16.2026.11.11.08.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:39:03 -0800 (PST)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: gregkh@linuxfoundation.org
Cc: andy@kernel.org, error27@gmail.com, cenzhang@linux.microsoft.com,
 dennylin0707@gmail.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Himanshu Bakshi <himanshu.bakshi478@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4] staging: fbtft: remove unused fbtft_init_dbg()
Date: Wed, 11 Nov 2026 22:08:19 +0530
Message-ID: <20261111163819.143147-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

The fbtft_init_dbg() macro is not being used, so delete it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
Changes in v4:
- Add Reviewed-by from Andy Shevchenko.

Changes in v3:
- Fix tag formatting as requested by Andy Shevchenko.
- Add revision history and testing details following review feedback.

Testing:
- Built the fbtft driver successfully.
- Verified that fbtft_init_dbg() has no call sites in the kernel tree.
---
 drivers/staging/fbtft/fbtft.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 40a7567df1eb..16459e4e0ba0 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -420,13 +420,6 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
 #define DEBUG_VERIFY_GPIOS          BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
-} while (0)
-
 #define fbtft_par_dbg(level, par, format, arg...)            \
 do {                                                         \
 	if (unlikely((par)->debug & (level)))                    \
-- 
2.56.0

