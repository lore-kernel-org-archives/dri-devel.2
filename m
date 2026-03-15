Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D90F3028C
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 22:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1E910E172;
	Sun, 15 Mar 2026 22:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MRsf6GkZ";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D330F10E1C2
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 22:35:03 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so22170375e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 15:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773614102; x=1774218902; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znGS+Mck/fjlL461oenTPc621FO8OCxXz1B08x0Zo7Q=;
 b=MRsf6GkZNiVbVaqNiWPfwcnPARYNfkg4KWqnkibSSAl7LOSrX4xWNO7vUbaa571/gn
 qkii5bq2XxIZ0sKKWJp8LotBzjlTM7M11WEOTxqGq3NcfCEpzOc57NH+e/hRvUYOLMMD
 YiEqFHX+x7myeGffuzZ/Djvc1nvvazFfHuI9hGex8hi/lznrHONngatvjeSsEuDL6Ma+
 SzNUbhQb6GdFlsfqGLJxqB8TWileZDZcpjikTrx7SsckyM9jEA5LsE0ewJIyr8VzORdj
 2/C01bT2VY7tICiIPBT27EWW/2J+UUSqdAUBHxG9akiLaKN/P/qsNftRDzZxwwG6gZPa
 JXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773614102; x=1774218902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=znGS+Mck/fjlL461oenTPc621FO8OCxXz1B08x0Zo7Q=;
 b=brVyEbObDEBAFrcZB2xNMZEY+4pLBYf4selpQe2h+j/Lg4zX+l3HTVbN1jLnd8ycPT
 lAXSEJHciZfjh5DHE8LADBuxPIndeA3rVxGnSTzClJV0xFtbJmuGJRPC10CDKuTfsufj
 WcLRBlU/0EM93DFhBJcwTeZ5ITY/WPJWgKEMmhKJcSA4ar/nl54axlCrwSblUR2sMYxa
 k2zzPvCZ611xEyjez3f9WkvMBXsaiNreW6jokRyUKaK2Iq8OsKQguDsw2/BkLK9tq2UK
 3btWoVRDaK9UY7zhI3hExR4kQd37PpNCjfeffCeH2FEBQSc1ihvdH5iEMVrS+Z3VNK6u
 A8TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUIoRdJMpWwy3/Q+wEHzr6PjpqPbMZeYaZYFwvkfAFLZX5c6Ic3kyVrPQ0vzK35g56P3HY9J6jBEI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDxw0jVlUMRbUSvON9eclLQzF0uLTH7PCS4r4N20xTcRtxTUQx
 qAJsVPGC2YP/Eeqk/oIlSom39t+6YhqaP2zLsUyOOtJ5RGnIrMmHBKYFNUDiB+Bf01NrdA==
X-Gm-Gg: ATEYQzwEJ9ZgCEOQRX76rTPdwjd8HOZ0Uq9IBb1pWn3mjLpo9D+EhKAO9UbMxmOqI6a
 B8MHhGdRqvmWOoHx3T+rWWYlRwjzCyfY7k6P2QsADQ8zfXxo4zXUhwZY39YgF58f58FzVJYqXgG
 +/alrVMr8AV1gCXk8jUE8ChKIvyhbb1h9OELx/Kc+gCSsOl3PJb/c1Isb/zD3sTrx/IjtCCfmB8
 sLHpPRfPPXqfOB2Dx+kBPkMa41/sVHUvVSn2wWeOPMq0yta1xYJQZsvmyMyBpMt/Oc5wrE+EWCv
 +RcZ6lhzeQQWw+PRAWMVD1YuM71CDsBKol+Ce+0rtwh/EWSr8r5oxH49q9VID6Jl4ecJe63EyoW
 at1Ed/Zh9YtGU8ictnTl+MM6yNuNkCr8KAgSrnCiBTZ2FZW5ez4YMy7I3XYKlsYSvDjyjbbz8Oc
 dOPPifpFO7gmVhddu4lyifh5bu+J6KPaTs8pjGr2Nn8V5+X9AS4L4imqY2G20VkNkJkEdv7gpK3
 pwVSbSbNDrKAFHqFxOu
X-Received: by 2002:a05:600c:1e8b:b0:483:b505:9db7 with SMTP id
 5b1f17b1804b1-4855672ada8mr177228055e9.32.1773614102266; 
 Sun, 15 Mar 2026 15:35:02 -0700 (PDT)
Received: from localhost
 (p200300eba70b6e00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a70b:6e00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fed7sm352005815e9.11.2026.03.15.15.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 15:35:02 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] drm/amd: fix force_yuv420/422_output being ignored
Date: Sun, 15 Mar 2026 23:33:06 +0100
Message-ID: <20260315223307.45807-5-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315223307.45807-1-johanneswueller@gmail.com>
References: <20260315223307.45807-1-johanneswueller@gmail.com>
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

force_yuv420_output and force_yuv422_output are intended to force a
specific pixel encoding. However, if the display doesn't advertise this
capability, the flag becomes ineffective.

Fix the flag to actually enforce the encoding, regardless of advertised
capabilities.

Signed-off-by: Johannes Wüller <johanneswueller@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 82c8dc8dd39f..9b298879de53 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6650,13 +6650,9 @@ static void fill_stream_properties_from_drm_display_mode(
 	if (drm_mode_is_420_only(info, mode_in)
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if (drm_mode_is_420_also(info, mode_in)
-			&& aconnector
-			&& aconnector->force_yuv420_output)
+	else if (aconnector && aconnector->force_yuv420_output)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR422)
-			&& aconnector
-			&& aconnector->force_yuv422_output)
+	else if (aconnector && aconnector->force_yuv422_output)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-- 
2.53.0

