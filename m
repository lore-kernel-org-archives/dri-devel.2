Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40E0CA6018
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B6A310FE2A;
	Fri,  9 Oct 2026 03:19:28 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51FA510FE2A;
 Fri,  9 Oct 2026 03:19:26 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515878t01bec5eb
X-QQ-Originating-IP: W901LGDAxK9FnKMrdb8jn/PLHEBs5fLGm4GCmdLNebs=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 851849396968121917
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:06 +0800
Subject: [PATCH v2 14/20] drm/msm/dp: Clear stale MSA colorimetry bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-14-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=sophon@radxa.com;
 h=from:subject:message-id; bh=jV+NKP5wd7+th5uGz3VcadTxsByLPMZY731XOUUipHg=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlbpHZU9IvZcT795xa3Kji/MLyYxMl7neyeTkrZ3L
 79b09vZHaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACay/hMjw45PuU5zvq2qe/Uy
 79bKKwVlradCpi3j2NL0V0V6usbydZGMDEd95NKXPMoySZn3YPKKhcWTQlqvh3LdWTvffudd62c
 Xc1gA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mw5V7KuSxHjfmVuDyOKwQHoOfPQkN//6kwHMrj5hWFN27j/nbAldC6I+
 MLbIyMTY6+UH1Fxl748tOpaoDDreD4MAEe1ADtiIuajDXW1OhXtYEg6TQfnIlGesWcTGgGn
 GPOWk/z348Wx0zd5gqs2kbOoZM9vIvVZ2r4EpgTVFn1UhedqdZTATKvjKtoXcAwXDwzW7El
 tb4MN76BcujjT2uF6lVJvGZ3Y9xgTQES+J86+j3N9unJRIB7GqXKJDCWr6pqRvlNdQoHJMv
 unNtkPBtO9UJF0bzibbG1m5JHznrHkmlhNHM9ysrEjasrOkAbxmQ6w6QmkVPdMjgT36T6l5
 d/1ToOU5zQBUFUwUXbLlSYoihWQt2vhsciseSQYIxSlTpadzEZG0RYbK5R9XInsFs0u/b/8
 hc37ZayLLYQ2uxwFdL49sMIYJGZgYgFvyB9gwGhIumIuatx1nuyp1OLuj+dAXs/4BQZ70hH
 1ox4DHtm9f+VD30D0E4i63w8LQNpPplk2lt1amzf+WcjjACHjWlnws8MdS/GzThe6MgXXpN
 VPcvKSg3nW0I4YhqlpvKOKFeDACBHHpLLkPFuHcSQowWik9aIKSBLd8bFRLTN9HVZo5eWtm
 4denaBvgA51pSJcPLf/8HH4yEs5lK9VLOm/6rHxLTD4Q+m51lm3gJE604im4myDXxjDGszN
 /BtPAygrjLCXdsyupsOkERFh12rES/QkshbFawfUPh8B/w90TDaQhJqyFjd60I9k6Rc2U7b
 oYjtyv9G53IyEHgZ82i0XnHcb8DGRwXS3bggNZLgohCU75Xx1dc4QmjE522myLEPZvLRk/H
 lM/MaDRHHoA4eOGnELv1zlKyisDqgfkcjVQYFkBa/oLBb5b/hK7nSaJTPzub99CLIueQMno
 g+Vlcdvd3O6icdbXlUEXK+BN9ZEAQCWwqj+ICJFE/V4PVL3iZY3kC/5rCFhq7+Cg2PKF5Y0
 SsyWXt11i3iWiHELVPRbmn9OomyBNleShnBYCQOSY5fIjS1glbooDa/AhhNT2/VnDbMn6KS
 g7+okWtQDEr7Z1Fbmz9LeN4bIOwtdlYXVUuxYG8Q==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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

The MISC0 update clears the bit-depth field but only ORs in the new
colorimetry value. Bits from the previous stream can therefore survive
when the new value clears them.

Clear the colorimetry field together with the bit-depth field before
programming the new stream.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 791bb3af2cad..783cafb22374 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -476,7 +476,8 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
 
 	/* clear bpp bits */
-	misc_val &= ~(0x07 << DP_MISC0_TEST_BITS_DEPTH_SHIFT);
+	misc_val &= ~((0x07 << DP_MISC0_TEST_BITS_DEPTH_SHIFT) |
+		      GENMASK(4, 1));
 	misc_val |= colorimetry_cfg << DP_MISC0_COLORIMETRY_CFG_SHIFT;
 	misc_val |= test_bits_depth << DP_MISC0_TEST_BITS_DEPTH_SHIFT;
 	/* Configure clock to synchronous mode */

-- 
2.56.0

