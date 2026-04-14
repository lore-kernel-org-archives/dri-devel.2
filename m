Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB6BF9D0D5
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB3E10E12B;
	Tue, 14 Apr 2026 15:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j1sSRNQ0";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DD310E2E5
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 15:14:34 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so1669386f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776179673; x=1776784473; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TOwZpBzYvLqLifJr7F7A9849bw8ux30LzyeD+wX4bPE=;
 b=j1sSRNQ0OWJJYMxKiSFytyoe1JK2i8zao3BiIfijWKw237QSBiOTMmIkQW/t/CifiR
 GNtJGaok0N7X3Zrj8io4AxTANGCe1Y9OmYGxTLP1e9A0xh4WV2CUF6Z1/D3ffJo2ta2M
 IjsnYLAJxNUu3LQgNY55x3tN0GK3PEVou93/BuCgZq5sogHJ7LkbabYbD18olioHrW4r
 E63CYGMPykxwlphkzwr1+tDGT7DGNTOPjr/apcgn27ukXxqGWtnEZdaOE2ZI3A6i2cAg
 ogL4fTZvo7E09wlqkSOnXwRFSYNW5bi0p2IDJ7vTAT6ojj8rwXY6UyMvQKA2upE1Livz
 WWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776179673; x=1776784473;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOwZpBzYvLqLifJr7F7A9849bw8ux30LzyeD+wX4bPE=;
 b=LWa3seXlxCPvSUBn2AKJti4ENhvCwtX52l0tqePAkOZ0IuWel2wzbBSP/7YgCB6tX7
 IkTHkjdx2Y8LFcs4JnvuXxvJVcrCI1/Jma+E3YllgHPNTWJMCUt+dLE90IbvAwlHaz3W
 NvXzttMunSk2GET4dhqxJL2akl6cTRyLNYUdFq2a3cKnGFYSbkta8AJ8DozRmBrUNZeZ
 BjMgFByPNFNP9Y95w4SCee0JpqOId8NJktVxFF+D2udAvL+jKMNavbfMLABRGtOOlV3h
 jWVVoyjXgqoA/+74iBz1f4WRNaB9OzDse64xU1hfvBtQE8byFBCGb5ksTNP6kb2Wgvxh
 hUew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PFoy5tjCdFiFf/C63nL2W9zTsmcKf9m3xh9Vt5wsJMgklqC68hBvAp48r+aEa9C6WhH/fXKR6W+s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwU3BGEyNEhI7RcZ2mCZg6d/gU+jUbLdQgKbCEgCSBXJxe8NFdx
 pzN9XtYf41RPYBzghOhgK/aOBgxf57mfZLHXNEMBW5LsLP5YDs2nNT9xsxz7X+EJ6iA=
X-Gm-Gg: AeBDiesZUC+dUujxCEKheMPoiUhnhvy+5EaXUX3suwy+wGR7Iu9kfWMb0x7T7aptUmb
 IFSjgRtfjgZ6/lXaNKWEhUyOSaprKOvyLQ4Eil2p/tvOH/SyyeOP6u/pYWqh+ofFYsafczULp8M
 e0p/uXPU5CkGZrzbKtpcQeGNEw1tHEJqiZ/YBKj0DH3tvjdXmtmRtOJEkhH7qAOR2dXFurF7Btk
 BRrc3ZMc6lXiBCgspegcQmbK+/RxT/fPgEgDB9Fd9NCCuN8OkRfPfTP5ppjjbbODjXB5GuQIypT
 SIVTtP4Wc6AIt6+C+lBcwWOCuuB19g+URULFNTLYxsOB7P0ehztcO/TuUAq3QUGZoFCuyPN3gSR
 RC/UNerXTD+ZJNJzbaRTdDVOuRSEpk+67AMwNPS3bNI5DBar9X2AdrEuU0dh8zFzHvGBtuix300
 GZx7X0Q/0imkpGY1m/kmzF2ppeqHao62JpruOpTtIl1P1b6BrJRzjY7uo=
X-Received: by 2002:a05:6000:2b09:b0:439:adc3:f0e7 with SMTP id
 ffacd0b85a97d-43d595734admr20994466f8f.9.1776179673287; 
 Tue, 14 Apr 2026 08:14:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d6f4bf2b4sm25956011f8f.20.2026.04.14.08.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 08:14:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 14 Apr 2026 17:14:30 +0200
Subject: [PATCH] drm/msm/dpu: fix UV scanlines calculation for YUV UBWC formats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-topic-sm8x50-msm-dpu1-formats-qc10c-v1-1-0b62325b9030@linaro.org>
X-B4-Tracking: v=1; b=H4sIANVZ3mkC/yXNQQ6CMBBA0auQWTtJB0HAqxgXpR20JqWlUwwJ4
 e5WXb7N/zsIJ8cC12qHxG8nLswFdKrAPPX8YHS2GGpVX1RDDeYQnUHx/dYq9OLRxpVwCsnrLLg
 YUga7fjwPNOiOWgulFBNPbvtdbve/ZR1fbPI3DcfxASTMqpeHAAAA
X-Change-ID: 20260414-topic-sm8x50-msm-dpu1-formats-qc10c-78b3919a715d
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2274;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=daNW5uhl4d69yIZFZewRQFFqst7fvn+JOIJGQIVovjQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp3lnXjyuO16e83pIqkj/ZpFIanlemWzuLSHOdgp0m
 eYSOaNyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCad5Z1wAKCRB33NvayMhJ0VRWD/
 42Ak2UHmBvvxPgf3HbVUpdXbs402uEX9kpFKXcY6YabdjNXKa2NLiSJ2zw3IyM3PN1jBfaJ6QgiDRY
 SzW13IVEVvaiIcroZvqG7dLF/k42Lc9uMbdDOHv4Cgw76Pj6q5oyma9kGa2bUmhobknqEMdnBeTBLU
 S3fwoTrXnBEYaNPUI2Uu2McTnn0fttzhQwyg012v/fdqY2Xwed5WBzWIQuCMx/WwZnD7+knGiyBpg8
 P8NWukq3FwqTdxXe39jFCYAq0fv6M5Qjdubnr7oeQSl3B3WNEl9fejybPrfCFkhWrwUlcHXwbzzm6k
 ECh94yq+U2i4B1qm+Sc/+/j46zGT6uyWc/iG8acUzNdpUqN0j8yZCu2YE5ZV3NN0uvXuR6TkdfWqmo
 qzrMVRZEVWP+mfWhfIH1dGz389IDXO0v6vfOF4xrOtMxMQpodtZJhKiw3T38jZePBL1U7fVR8LwPuW
 1uuQ02EMLNErtQOKbOVUqtsRAjUn385xlYLEZlGwyTG3lOjTg+ABmXhqLqT7+TwoW66/R8onwmpn/X
 WYBc9ZBjtq2ZmhfrOz60V9gVDQDhisOSe4qtVT8JEP4eglJHDNg35j2TJvILIwniHtgzssFV7j6pAh
 XWc3gjKguvh/LUaQyP9s0TvhTdnESILpRc+UyKjOSZQm+JqdwSJMfWfDfyHg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The UV scanlines is calculated with (height + 1) / 2 unlike
the Y scanlines, add back the correct scanlines calculation
for UBWC YUV formats.

Fixes: 2f3ff6ab8f5c ("drm/msm/dpu: use standard functions in _dpu_format_populate_plane_sizes_ubwc()")
Fixes: ada4a19ed21c ("drm/msm/dpu: rewrite _dpu_format_populate_plane_sizes_ubwc()")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index 6e8883dbfad4..590922c4f69b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -61,7 +61,7 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 	bool meta = MSM_FORMAT_IS_UBWC(fmt);
 
 	if (MSM_FORMAT_IS_YUV(fmt)) {
-		unsigned int stride, sclines;
+		unsigned int stride, y_sclines, uv_sclines;
 		unsigned int y_tile_width, y_tile_height;
 		unsigned int y_meta_stride, y_meta_scanlines;
 		unsigned int uv_meta_stride, uv_meta_scanlines;
@@ -77,23 +77,25 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 				y_tile_width = 32;
 			}
 
-			sclines = round_up(fb->height, 16);
+			y_sclines = round_up(fb->height, 16);
+			uv_sclines = round_up((fb->height+1)>>1, 16);
 			y_tile_height = 4;
 		} else {
 			stride = round_up(fb->width, 128);
 			y_tile_width = 32;
 
-			sclines = round_up(fb->height, 32);
+			y_sclines = round_up(fb->height, 32);
+			uv_sclines = round_up((fb->height+1)>>1, 32);
 			y_tile_height = 8;
 		}
 
 		layout->plane_pitch[0] = stride;
 		layout->plane_size[0] = round_up(layout->plane_pitch[0] *
-			sclines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
+			y_sclines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
 
 		layout->plane_pitch[1] = stride;
 		layout->plane_size[1] = round_up(layout->plane_pitch[1] *
-			sclines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
+			uv_sclines, DPU_UBWC_PLANE_SIZE_ALIGNMENT);
 
 		if (!meta)
 			return 0;

---
base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
change-id: 20260414-topic-sm8x50-msm-dpu1-formats-qc10c-78b3919a715d

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

