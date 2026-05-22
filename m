Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5AFCD5BB6
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB5C10F665;
	Fri, 22 May 2026 14:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rdeMXCdK";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C5910E168
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:07:29 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3660ab73adbso4862353a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779430049; x=1780034849; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXHEsP6MIsIy0oSjkFIfzW+qvl+16XTQ6Ealt2erRAM=;
 b=rdeMXCdKjfi5luPi/C8m5FynzORhBns+tkRhuOYd5zwNOPeD4exgxsmBmT5Gy4skRP
 v3+umqmYFCN4ZzAJ0kmpZZKgZza57jMSGCHXEagbWaQMXsNPmdrzvu9s5jATtZoY/8FM
 N0jsLMgJVJq93GXH1Xkeyf4A9IxZXj/7i3eKX8NLYQFAl4F6yOEyp4CXM72Q4joeGZaC
 hZ0PWfDhyHwXxkOUg3YEhrB93wYGS+B3bw+7N457Ocnq4BPA0ytf1XiMuNBFGbNBHbwf
 +MNgJ1It8lKyTC9+XjFJxycACVN02xsUem3uKpQiUZOBPAlt4yPbbU5xei9P22kkSeLj
 yeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430049; x=1780034849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NXHEsP6MIsIy0oSjkFIfzW+qvl+16XTQ6Ealt2erRAM=;
 b=OllhYMAlBJwsWsH+eiCtXu2MvnES/9zxxed9pRo8Eks5S4+JirgHSDtIWMJFkNHJYl
 7759p//bR63Q+0ve64YEtWLUoSGe3S9vNRCfMIoztFW0rI1+82W+Nko0mTOZLbEbuNAl
 4cC/4JwXdOssTzUOglLJTdXsjmdJs0/5EfzOEbfxh7h7QN9PU1VOzmlboBedxiO5f+7f
 UpgpojvAnGTrNAAQwEGgNaKBhZGEuTRMJyp7dwv29FKXrnIF4OkNV9WzqVYpBI2sLV0G
 APlk8uFwrX5ftfqNPWt8Cnw81imfh3vQSQnxzvBJp8+N/w8rY/gORGmC4Hax54drlNR9
 XA2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QtN99UW1aoYJbjItFTAO1UF5/YOEfwxdCOpj9dPzf2J6Kazxs/9Kb9AH0TrhU7rCOXIlDtuWzK9Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybKambgPOQAQZZ46+6JvuWOLc4/v96sU1oaM0Q556LKphVDQnm
 jrj3lt6Rs6JZjU7jmF+f2wxLwb8gE3MgEyvgcDpCfNAhm+daBPdhycix
X-Gm-Gg: Acq92OHG706x09Dsm3o/7poQihOzIBmRkg3XDry/XOI+MyzPb09dINMYQ2IkQ3NX/LJ
 0wm3LEDzVRtWMmf+6R0EDudVcf1Kk1ftzJiYZfxCAFqb6LOWL7v4iWzpj/sHh9b/av8bZriMVTY
 yP5qJMmBalRsiQrS444WZI8Nbpr4AMezAd2ZrhILxR9PdGT9BDTo3c/n8e4p6XUQS3Wj2bqrp3U
 yBl18q0zmMA+r5jTpL1+tYiLW+c8gIoWpQu03Y7UjNh1JSS3+TfxIDmsVYXot0aXOaD602dR5Xg
 c0zrkz0JxrXmQv4BcJVJtKGZqmumhjTM1/Cwlm6KO3Tg0kqfXn7pEcsd2sAhhwQC5nT+KSl0l11
 J4U60I56mqIK3Gfduq+IuQjD2/15wcYJChZnDde/O2YLNzL21Hr4r8tXIGYXg45kWgOubmYjVwl
 SGES6GNEGkBXG4OQcGRISDGJuW8/b921B01LL9EG0jRPbaPcQtU2tCkLAGMiWUbhkeWw==
X-Received: by 2002:a17:90b:6c8:b0:368:7398:df8a with SMTP id
 98e67ed59e1d1-36a473cccc4mr5285786a91.4.1779430049070; 
 Thu, 21 May 2026 23:07:29 -0700 (PDT)
Received: from radxa (122-58-25-162-adsl.sparkbb.co.nz. [122.58.25.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7212aa06sm428572a91.3.2026.05.21.23.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:07:28 -0700 (PDT)
From: Graham O'Connor <graham.oconnor@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Graham O'Connor <graham.oconnor@gmail.com>
Subject: [PATCH 3/6] drm/msm/dp: Limit voltage swing level to 2 for RA620
 bridge
Date: Fri, 22 May 2026 18:06:42 +1200
Message-ID: <20260522060645.4399-4-graham.oconnor@gmail.com>
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

The RA620 DP-to-HDMI bridge used on the Radxa Dragon Q6A does not
acknowledge DP link training at voltage swing level 3. The bridge
requests maximum voltage swing but never completes link training
when the driver attempts level 3, causing HDMI output to fail.

Cap DP_TRAIN_LEVEL_MAX at 2 to match the behaviour of the vendor
kernel, where link training completes successfully at level 2.
This allows the RA620 bridge to establish a stable HDMI connection.

Tested on Radxa Dragon Q6A (QCS6490) with RA620 DP-to-HDMI bridge

Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_link.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
index 76125e9c0..ff0d8e99d 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.h
+++ b/drivers/gpu/drm/msm/dp/dp_link.h
@@ -24,7 +24,7 @@ struct msm_dp_link_info {
 	unsigned long capabilities;
 };
 
-#define DP_TRAIN_LEVEL_MAX	3
+#define DP_TRAIN_LEVEL_MAX	2
 
 struct msm_dp_link_test_video {
 	u32 test_video_pattern;
-- 
2.53.0

