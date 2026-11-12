Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B5B606A332
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vOTJa2wV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899F110F45B;
	Thu, 12 Nov 2026 07:52:48 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6045410F19B
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:52:42 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a0880a46e7so350182b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794469962; x=1795074762; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MfIiMtH3vcQ8rnl3Mz2iz7HrvbyC+ZkC2w1Z98pOQoE=;
 b=vOTJa2wV4ogZYhopMfX95mGV5OQ/bAqgpFLHbEfnJ76NmtGSHHIRyL9gUqgo19Clou
 k1HMoKbPeSZ0LIG+4kJYLH89mp3zr0Kt8Qnte0/MI+znLv9YvltLKJR7OH/MGuCfmKT8
 DrSZweZA624bx7nPq+Sk7qZy5hun2Qe3zRGrjknfX+tN6qkwdggxvnxlq8n4QG9dDpWu
 X6WkPfDeStha/X0p74Hb8RNnKC8cv9I8Fw/1moZnRRas4PEoKM+xy89DsRb3e1j6rQ6a
 DVvSJGtOF6vOCaBMYj0eUm5OBELw92X/lOWY1YHPFO/GvBHcQKHMskRmvl66VBnXQ7Pf
 7u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469962; x=1795074762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MfIiMtH3vcQ8rnl3Mz2iz7HrvbyC+ZkC2w1Z98pOQoE=;
 b=SaAEyxWjORaFqy4PB3utcne5POKsOygkBDtm5tjq7Q/mYja9xHT0PKQ9hCVx6K861N
 YIEpq+20Ldw67glY7onjWIqtF3glKFybQ/xGbxRf2CqA0dKGMp5BlhHRnxnRgFHmsnAo
 rh6OtaIdpjhLoil1WpfmaMIbbAx0L9Y9S+18X0V8qOSVQvnhROsf0KMQMjZI/frlSzvr
 MIkD3onNizxGoSu5djYdShL6Xls7YYzlVbnVNFERogVO+YcEXQSwzYn4/7zc48nDLjx+
 5nfURceIKEs1ra3tFUpPDGI7LG0ke5VwlzAZBT3wW17iEEBeOtuCVudEucUsAsa5ExBh
 mIeA==
X-Forwarded-Encrypted: i=1;
 AL+hErH0ktj+wDzze8cJ62Fn9gANvUXS08xchdU8nlgRclOeHTK3/Vji6rIv4m64TxEsFmGHX9V7gJyZiLY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8wGrIjxSjJPT4DG9+8NzleWL+H5JMTXcNLZ43XDT3jA7XeFk/l
 I7KBAO3GhoYDN38loYU6gXquXhQwp/U91kYOeitsllzrFIelp6ygjUDeaO1/2VcGFIyjfSvD+2c
 g6wnk
X-Gm-Gg: AYBFou3XcFUt9kNB8RnWjKfbabD5bhLGkT8M2wHJd4ogANM1gJsh+/s6/10xWP5MYAC
 jTUURoiCbnb9IJ0Z7gYVC9OtVBGDiwcNKaunUuNcTM14mDYsfdHZo+ERrAqg2ZCgdXYZgoyDjwP
 B3JvVeUwlcnFWi1mIy39bC4xv+xW0zZa8Ltf0o3dJw6erOBx8r6SdUvtlwJJD3e+7Nl50HLYZ0f
 4DTV3gRjlveUF+8SxG9SR6N9mCow+vHbj6sAVTyK7GKQ1/lDFRy2QvYP0G4R4esLrpH1u7jZuIC
 m3vfSx4oplCIoLXMXP+xSa+sy/htJG/Q/ZZJmKeMrfk92+DBMfhW+vopMnWAfttoaAxsOq0w+QP
 PAtKTRZbV/FGZaFilVy7wjzPZM8bRvsWIY9IEMrd9WJWH2ioizjxYfDQfDK43ziydPesPfUKhIM
 wU6DJGep/Ml83On4L6Ped8uieLOmmzpkKFzi5HFZ8SQJMyhdF0TTpbZa2eO5wPXKjN6wPloRZES
 LQ6tfKtPXRcNdkJCwOHSRU0k7xxVgbFgl5jfhycw+GquXI3BRPhsSzoxZg0m17yJlnOvRNi0Nls
 OfscRH6azoUtDAVfFcD5uFupagW6UX3UstcAY0pYiTYli7hYX7o=
X-Received: by 2002:a05:6a00:b41:b0:8a0:3617:b53a with SMTP id
 d2e1a72fcca58-8bd5cc7ffddmr1156441b3a.18.1794469961776; 
 Wed, 11 Nov 2026 23:52:41 -0800 (PST)
Received: from [127.0.1.1] ([116.237.168.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab5f3f99sm3131256b3a.51.2026.11.11.23.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:52:41 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 12 Nov 2026 15:52:06 +0800
Subject: [PATCH 5/8] drm/msm/dpu1: Support wider writeback width in dual-WB
 case
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-cwb-upstream-v1-5-a6a88d928aa4@linaro.org>
References: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
In-Reply-To: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794469928; l=1480;
 i=jun.nie@linaro.org; h=from:subject:message-id;
 bh=b9gZBtsMHkv6i4rFUNaaYmsibNAluP0D+iRz7WdouOA=;
 b=nriIuNstQpH6u1NeHbBWbbt/EWyGeA/Ja61WQashquCcYkdMxW4+ytxZE/H0TKh/NUh1w3eVV
 VZeK6dZRQ9mC9DpmXS95dnr/dImCWX4Ploqmh5peeRVL9BqlJ2sbVRP
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=O9aRQ3+xXWihQiRRgStCET+eFXx1EZs43Fh0Xh+8Bu4=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Current width limit is 2560 with single WB interface. 2 WB interfaces
can double the limit in quad-pipe topology case.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index e7b09013ae4c..b1177e4bd16e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -14,15 +14,11 @@ static int dpu_wb_conn_get_modes(struct drm_connector *connector)
 	struct drm_device *dev = connector->dev;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
+	/* we support dual-WB at most so far */
+	int wb_count = min(2, dpu_kms->catalog->wb_count);
 
-	/*
-	 * We should ideally be limiting the modes only to the maxlinewidth but
-	 * on some chipsets this will allow even 4k modes to be added which will
-	 * fail the per SSPP bandwidth checks. So, till we have dual-SSPP support
-	 * and source split support added lets limit the modes based on max_mixer_width
-	 * as 4K modes can then be supported.
-	 */
-	return drm_add_modes_noedid(connector, dpu_kms->catalog->caps->max_mixer_width,
+	return drm_add_modes_noedid(connector,
+			wb_count * dpu_kms->catalog->wb->maxlinewidth,
 			dev->mode_config.max_height);
 }
 

-- 
2.53.0

