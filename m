Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEE6C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A484910E9F7;
	Mon, 20 Jul 2026 16:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A7b+ylua";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E149610E9F9
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 16:18:19 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so19125895e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 09:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784564298; x=1785169098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qGVMU58DedF0lFl2nbNJfL9G9Ib4nLG39lz05m1JVHI=;
 b=A7b+ylua+zugp1LZA9jkjzK1ZpEYqSLxZDbGvGPCkq4ghoWZAEuwpAzZ4k4+kAleri
 QzhBEi4y65adQrtOpxKyuOZIQH32awIo0rlR4aICPfdslZOjLV6z4FwOB16XSwK0bmDI
 puEMZtFDvVI+rbSpy1W0KC18v5XcB9rSrmpQDiVH5sZssJyLrVlP4ZsuX9ncb/hd1szY
 P8F8BpXHJyInboA+oZqFVP+9nPMfCCD5zURvUphQKK4B/tkIuEmCB54qXHxsY/PQnKqV
 UPfgEYowK0WvEzOrpyBh+DsvqCCuRNEz/iOmqoSTMOBJSsg+g1RBWklhkwG3XI3G57iA
 lGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784564298; x=1785169098;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qGVMU58DedF0lFl2nbNJfL9G9Ib4nLG39lz05m1JVHI=;
 b=Vj5gKUjaeEM9boqn8Le3YxM8iidePAchvYBeCoqgWGLdXfpvb72gsNmDoJLX2POs02
 Q45m9SjwNGuM4ggCH6r8J6v4/sxwm/5zM8ob/UA/6BLZfUf3JvdpcD5fkqHpQouqx6NG
 EVSk/13MDnhKyLUNUgGSIFlEsM3SBb7oKQT5jA2wQNo74zlPxL2JBEpM5qBL3bNw5HO/
 vnZjaJ6nmtDlUws9bDSi5JZERKePaPXLEvi1p2N7T04Fb62+jeTjiJ5wEjbs8QmUNOWI
 Lw0t7o92DILX9YUTrOiM2+KbzPHxEeB8yIIOLx5VC1i+EWFI11/X7raPTVLDTBL6Nc4F
 CyIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFTJcyw/CuckX0L+vfjlAtRTb5hmBrSgPF+ilnTv5sY41woDHNSEB88OJVrlt50YUc0BpDcEv2l64=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4qYJWNZJ7uZw5d0bxPnUCxf0yQLLR+ZTAiWiHEVWNgf0s4HlU
 mQP2gKmRtI8lHICJR09j1fMj/q1YRl4qDuf9pcSsRxyzzdLz4NbXUSMm
X-Gm-Gg: AfdE7cnHs9VS+C5c7plB849p3BgeMkEnL+YRjFnN69WPnVUKfT3HtgmYSEQQVISEGCR
 dbZ4cUGQKMvfw+5UEbg1EY+hlMepWExJnk++Cj9fPTZE3DoBn1qYwRUVmfBnUj6DzwkhWHn0F8g
 tQfLdx75V23mktDXkeCvnyRlUZUgnzJCa8dfG0JdzHGOzW/Epqu1RGJ0W+0roszfQBDRmktLO8L
 o1SgYQiq1pA4t2nW/N81foLXUPDu6RUAiA9hHsILCZZIF2jpApO/02Q/ywb6CjtfBr6jCxienyx
 +DUeJHKDw35uFb3Au2HyAEdo1CiT4jUWXMSJN5XjfRXxqE+uW2yB3jO6xXlm3zo8Gay6t/+zw7f
 t3qLUjkkogECa+VeNV5CBLgxEoIJ4+xa/1P7bnD5rE1IRM9tpodWwo0B6GxDDFmDq7gNiEBv5mG
 E+
X-Received: by 2002:a05:600c:4fc2:b0:495:5b02:23b0 with SMTP id
 5b1f17b1804b1-4955b0224c7mr82155365e9.26.1784564298066; 
 Mon, 20 Jul 2026 09:18:18 -0700 (PDT)
Received: from localhost ([5.83.201.220]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed2313sm30862995f8f.23.2026.07.20.09.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:18:17 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/bw: Fix spelling mistake "threshod" ->
 "threshold"
Date: Mon, 20 Jul 2026 17:16:30 +0100
Message-ID: <20260720161630.326016-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a drm_dbg_kms message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_bw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
index 546d5ccbe052..c71082852cfa 100644
--- a/drivers/gpu/drm/i915/display/intel_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_bw.c
@@ -625,7 +625,7 @@ static void xe3_add_peakbw_threshold(struct intel_display *display)
 	for (int i = 0; i < ARRAY_SIZE(display->bw.max); i++)
 		display->bw.max[i].deratedbw[qgv_points] = PEAK_BW_THRESHOLD;
 
-	drm_dbg_kms(display->drm, "An extra QGV point %d added for Peak bw threshod of %d\n",
+	drm_dbg_kms(display->drm, "An extra QGV point %d added for Peak bw threshold of %d\n",
 		    qgv_points, PEAK_BW_THRESHOLD);
 }
 
-- 
2.53.0

