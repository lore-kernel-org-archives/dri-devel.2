Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E5CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1F210EA06;
	Wed, 30 Sep 2026 12:43:24 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB3F10E9FB;
 Wed, 30 Sep 2026 12:43:19 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772149t5ca4bd4e
X-QQ-Originating-IP: JcZBTyhuJdZpzGdESlzfbp/HAoMyVtn4JCzBrntk5yI=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16091105934519302883
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:48 +0800
Subject: [PATCH 04/13] drm/msm/dp: Serialize HPD state updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-4-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
In-Reply-To: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=sophon@radxa.com;
 h=from:subject:message-id; bh=4R5WtlgbYBEGi97B0xYUPrFsM6fIlLqdyl22Nh5WU78=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZfmXMzov5X5xyFH/UnUSfGkW+m7k3hOtKpO5PS7q
 W7Zscivo5SFQYyLQVZMkUUhnmEue2XutadipXowc1iZQIYwcHEKwESydBkZvpobVKySWJCz6X1O
 WyHrpvVXXT78+PruUcOneyx7DScp9DEyXC3eKSm5+Ibac4czbkkyj07WTZl4vzRW2teCcdP5F2c
 v8gEA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NfykWmRlrd2ofle7ERWdYOGpP2FtmLdrhYmkDG7HCzDeTUidS25kc83X
 xVcQYfkPiA2ovvO/HCWM1MkzmyzY1kwrSbGQIKtD/o62SDoPaiIFk3zGJe2b+7jzp8lxjRF
 YGcCKcWDEkIRoWTOK/3BxTwMyqhJ+zH9NwbiwC4LlM7M1d8INLQjg9/sQmeb8tNBnwoRGfz
 8yVEMHj80WHGHL63beCir5xfZOeFkajg9qEsBU/kPYMlroR5oC7OVC27gi82ShCpwkAO04C
 cjrXCAU+3zF+yPjucS+lBe5ix8Iu9sO7OLexbZovgC5Yf2VJmxfiKmpYoSLGrCGCb3lbH/U
 N2LLZJZIE+DRMa2rsKhOTXRIN1PFE59V8PJjC0kIv1dlGTe/pi7fs5Xs8FjkC/UKsDWW373
 6PuM1TovEtOFLG2sU2GBnnYPRoSScqcmGHSBrak6WrzqoTEoDFmmwGL5sBmbYTnwTR0I09O
 E1dfwLVTzWPu8FDXsEhJmbX/IMmyZ8K/DzrAcKauyoPvKHXdbb62i4vudLCPFFaz7C46PtN
 R2SK7LgvkcwkXKMv7RArNbOXrbk1oh4ZsNNnOiIMKmALJn09k5SwT331zNZ23YjL6SuIts2
 +DFNB+JAbwy0zzg46tc13THYuNOMitPsWDufHkwyL7x0hjOdP9bctTHM8TEeIsokJ7h4apO
 l6JrmGu/l4PWE/CM2Q2fEBghOFxLyz3kPsn3gjK4aNMmoWMexrcv32hBNSOVcbGk/o6dWRq
 jwcfvFRdyTZFPli2D0hPvJrTgOpO3bdP+9qm7mgSw833ic70gUh4IVmKAGXKrmmDxIeDtqa
 5cThlB9tnr7c6/qU5HeHp8QQsR7C3N2hXsfwTF80/1tkapdpD6QxxxKl5VMV7MB+5oFObQ4
 5ayg1IkbfwCcpEN5ABFimyf5xsA577oP9iZDDL+LMC6Knex9gio6o33Q4O7JZBnpBGjb1/4
 lmSfWN4fV3aQJ4vvorYbiC22J+3rWtDiF32Pn0mxGvSzUwkaDWw3xJa+sAJgJKzqBuVJ5mQ
 BSjDv0oVv5MylnkqauLpkSgK8E8Tci7Duwb0quIg==
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

The plug and detect paths hold plugged_lock while accessing the sink
state, but IRQ-HPD processing updates the same state without that lock.
Unplug also changes the video-test flag and AUX transfer gate before
acquiring the lock.

Cover those updates with plugged_lock so that users of the connection
lock cannot observe partially updated HPD state. This also lets stream
failure cleanup decide whether to preserve AUX while excluding HPD
processing.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 4dcbd9b99d06..3ca039ff57b8 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -450,6 +450,8 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 {
 	struct platform_device *pdev = dp->msm_dp_display.pdev;
 
+	guard(mutex)(&dp->plugged_lock);
+
 	dp->panel->video_test = false;
 
 	msm_dp_aux_enable_xfers(dp->aux, false);
@@ -458,7 +460,6 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	guard(mutex)(&dp->plugged_lock);
 	if (!dp->plugged)
 		return 0;
 
@@ -500,6 +501,8 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 	u32 sink_request;
 	int rc = 0;
 
+	guard(mutex)(&dp->plugged_lock);
+
 	/* irq_hpd can happen at either connected or disconnected state */
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
 			dp->msm_dp_display.connector_type,

-- 
2.55.0

