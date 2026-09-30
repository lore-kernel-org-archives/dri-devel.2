Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C55CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E7810F36C;
	Wed, 30 Sep 2026 12:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZGx3PtJp";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC6F10F1DE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:59:20 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-3a4c8262465so368119a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751560; x=1791356360; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jtiPJ5UGtiZsDhZZbOoXQnFvgnva+qGhuWA36rHa5rs=;
 b=ZGx3PtJpTDv3jrvpr/MA+u1yYSwOAMN8bjkwu3nd/DI9xv8FPdc74IVxgqbn3sJbY+
 jJqmBm3KeglPuldiyAXDLfT35hLh3jSpJ33YmxBEfJaTkIHc/aJ/XD9VTtAavluzA77i
 FF+SQFQ22i1TUgdXoOI/Mw8LgD83J9Z4lEQRQ4cJi47UA6tKvk+olJpRt2+XhwZ8NONd
 wkHq1CuVS4aWmfvZY01hqzo3jGhBHlSC7TLgQMl0tFJQ3luZQoveCnEMHan4FFhscrWT
 /qiUP7tLTofizGHAsc0wQ1NfBV1ySUurHOnwJqXzSLHGK+WwDlwCrvqcCW1YypnomwIh
 lpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751560; x=1791356360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jtiPJ5UGtiZsDhZZbOoXQnFvgnva+qGhuWA36rHa5rs=;
 b=UH7dpkw5iLv0kRwTKXYbplzYgUcgQuK66wolbEAPguYsdm4FHNuM4m/sNdD/Y1NtAn
 xhOJt2VUFeq475he0FPEz28fa6s78Nyp++qyOeTDugHGc7PSlZaBmytYdOeYfn48Zpfp
 24I4ugroB/AjuDnb7L7JMifKN08sOOHKN0ilvuMHKKhbGrSREahvqdOaU0IyP6R05ZLL
 BOBq8FDwGmTqxBLL39wHW+oIfdfFixIyMn6Bg+3PAkBBwN3uHfqzP3Fp9QTdtagFXE7c
 Q7YpmrSYWsdbAV06tIqt2VJbXck2UD0eFmx8WjATfkOb3wb/kAANT1siKFJa9BMALrTD
 dSlQ==
X-Gm-Message-State: AFq9FYLgM58UgL/10BNGaJuotm1fnLm+/NmvVIYB87G8hwC/uJ8L5MVw
 tlr8s7vd83Ku8rba7o36a1PS/1hDjl7BMpvAYCwR/z4rlaLqCNEh75tX
X-Gm-Gg: AYBFou3/zB8evTGs7kXinnzzqVH3TwgKee/snzEnD23lloPn93kwg8qpen30sk0g1wC
 sfdCJaitqvb6uoLnX1FN+Ntp31dVAQFKhCwfqcW7PEkawjgSKeJLieJiNIZL4m5VXeVH64fbXGw
 GVCkpG6zNhDacM0daOYtDEVWICRm78m1EWhylppg+o28H8qYwJr4bKPzEwZfTmCs3SvmbEJ2lgY
 dMxi2HtKkNleQPKIZswRT7B0Nr1fALapL+wDMUu7rostzMguRa1u7eR+aiz2JSXsdMbYdPCYUwC
 eouHPvXBVn11J2GLt36AaXlhefXJrw/b6na54eiQaUgLYmMGRb43y/H9n+7q9v3eqDVH4TWVVes
 fA8Wet7egzrnkOamGxtqMHOvqsQ/WH8HoVZu7PjsAXxbaq8TCIqpb0RZ/mhCFwTWzycdpeayhVT
 UPgvbazyUrNuLXyAUn7AFbzWbSIb1nPAgPJISseWqoqjdvrgxLJIqpOToCbNhBnY/lDIAeUk4GW
 jmdRIy1y7JU9y4sq6tjH8Pn47ikhmL2FIx6aHcAXy3ucN05nK9iqyUR8HLtrwiSqQRQkRGwurb1
 30ngB0TVxg==
X-Received: by 2002:a17:90b:4f4c:b0:3a0:49c5:d3c3 with SMTP id
 98e67ed59e1d1-3a4d18f52e4mr485973a91.53.1790751559670; 
 Tue, 29 Sep 2026 23:59:19 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4cae9ffaesm2010442a91.16.2026.09.29.23.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:59:19 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 4/5] drm/gud: Fix bulk_len divide-by-zero in
 gud_flush_damage()
Date: Wed, 30 Sep 2026 06:59:13 +0000
Message-ID: <20260930065914.393939-5-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930065914.393939-1-benquike@gmail.com>
References: <20260930065914.393939-1-benquike@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

In gud_flush_damage(), if pitch or lines is zero (for example, if bulk_len
is smaller than pitch), evaluating lines = gdrm->bulk_len / pitch can
produce lines = 0, triggering a divide-by-zero (Oops: divide error) in
DIV_ROUND_UP(drm_rect_height(damage), lines).

Add checks for !pitch || !lines and !lines before the loop in
gud_flush_damage().

Tested in QEMU against Linux 7.3.0-rc3 by setting bulk_len smaller than
format pitch during damage flush: on the unfixed kernel evaluating
lines = gdrm->bulk_len / pitch produced lines = 0 and triggered
Oops: divide error: 0000 in DIV_ROUND_UP(); whereas with this fix applied,
zero pitch/lines checks return cleanly without faulting.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index aa7792966287..fa726e3d849f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -340,8 +340,13 @@ static void gud_flush_damage(struct gud_device *gdrm, struct drm_framebuffer *fb
 	pitch = drm_format_info_min_pitch(format, 0, drm_rect_width(damage));
 	lines = drm_rect_height(damage);

+	if (!pitch || !lines)
+		return;
+
 	if (gdrm->bulk_len < lines * pitch)
 		lines = gdrm->bulk_len / pitch;
+	if (!lines)
+		return;

 	for (i = 0; i < DIV_ROUND_UP(drm_rect_height(damage), lines); i++) {
 		struct drm_rect rect = *damage;
