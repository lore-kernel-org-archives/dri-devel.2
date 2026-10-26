Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ACD606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tIVvdFIR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C0E10F31F;
	Tue, 27 Oct 2026 09:32:00 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8596910E1C2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:24:41 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso4689741eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793006681; x=1793611481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EKnTU2YcJJTvtAtaAZdLOGPL4mJYMsQRUA55KN9Oiyc=;
 b=tIVvdFIR3xu9dePuHz2JU//bCTemKtGSv2RDtDEF8xXJlIcsL4AHI0kRpkUeyMyL7g
 zJtglzCuOjXDTfTEQe04ZKfXHfLw7nXWuHwgLtiC/Rp0pyp0h652y53NkECkaLskBvIO
 zPSwgPlI0hXcOFHVP7jryjTMiqHRlP0l1HULos/xZoP9UTf0ZQap4+iuoSTX3Y4aK2VJ
 c/O2HboIPb1L1DMoKj6J3nBLt17I7f8U2Rh3jS1b1s5iyyGVtz95ZVKj+Bu3KaV51W1G
 Tutk8X4eNgtJTzwNba+SMG8gOsH0LDQr0M5yOD2iqaxl/UQC/Ej4mNgt9Z+m7BXGrzyH
 xD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006681; x=1793611481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EKnTU2YcJJTvtAtaAZdLOGPL4mJYMsQRUA55KN9Oiyc=;
 b=YpdEiEnEtXjGda3N/LFnbaqxVYPmUugPsIF24YI0dsC/ids4cJyfq6zQ+3/06x7bvr
 dk2WCeAiCMkv1pP9KWMCJXq5OQa3olAtqLOZWlkSNBEKfkVmdVFSuEicyAYu87PfvJIN
 9O1NBCqwqQUndB/OrameNDH7azP3iP3uI+ZavnajJh7bmeiuvTxyAa1QAgSpvpNHZGlO
 0RIe6OZbmA8M7Tepuj2lrNBAdjjpcVWf2D5ryT7uzw7nrrKD7poBvieAc8KtZS+r37Sx
 lgtND+l4x+tZ6GRIeySnRvErk6m9RQUMtKbkrP62ufsy0UwxwhszCYIkjUV7Sx5Ix+eU
 eOHg==
X-Forwarded-Encrypted: i=1;
 AKwUvByeXvs1movXjFnGzvBBmUeS4650rQerFn+J0072ZG3GpJ8mb2ifkNT06TeASby9VJJnX1LSsAk/mAU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJSBv8sUNHxtGCEYG5PdFLbHxtIN9NrBdIXR9A9mWf3khE+Dnx8
 tk4NhsXh5l3q5Ts+U73mFeL9AF9SaR+g8A5P3fSieoFyY+FD9IQkAaD6
X-Gm-Gg: AYBFou3anAyKdLw3yRibt72Iofid7fbVH1s92swVzpFnxqqpgwli5bO9R1y34PFoyQX
 nUOhqZi2sx+qNC2oe7BrhAbFPbRnfw9Q294vDvZOiLBtc9gAT+RcXe2FfE+rVpY4OALHggoEyim
 K+TSyRS3zHpNHSvvrHU/CDuGsTNFc9D3+fZBXHQtyvjUr26TltPvvBB3810tMdHFgdJCylZP+HL
 0WtcgMaFlG+tbYY4o7Er+SxqOQ4DLOhYrjOJtj/GMPtFw3Km/Iaq0IM2vGAiZ6LlqavPMiD6xrC
 IkZWDVp3lon3In58Zxzf9zn+Snj/OdzxUc5qH+0m4ExHxdhy112QKg+R9CAx3N/QhqVrvhH74af
 2toddLpG9GUUi9gnIxnEcLDXpn/87iBXIlM4n4vV71/7w2yTOpfWXmWjoRvi+jclzmeMjfzTpjW
 ZI2FnXNG13/5hHxQ5W9e2lP/kw8PCrtxruGW88BjwIWJNDsD5YdJ2vJCTjXPXKpbJO9WtT4JXKy
 7OZLxtvtqrMBVfghIFEQcUn4mVKOK3KB1yEUsj/ipj7M5urQstEQx3WJow+m2Nfn2u6fJup/lA=
X-Received: by 2002:a05:7300:fa17:b0:369:fcbb:4d4c with SMTP id
 5a478bee46e88-369fcbb4e9dmr4419186eec.7.1793006680504; 
 Mon, 26 Oct 2026 02:24:40 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8c576ebsm23648985eec.3.2026.10.26.02.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:24:40 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dennylin0707@gmail.com, cenzhang@linux.microsoft.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 error27@gmail.com, Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
Date: Mon, 26 Oct 2026 14:54:23 +0530
Message-ID: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

The fbtft_init_dbg() macro is not being used, so delete it.

Reviewed-by: Dan Carpenter error27@gmail.com

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
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

