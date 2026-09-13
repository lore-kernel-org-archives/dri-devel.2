Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14102C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC8F10EA42;
	Sun, 13 Sep 2026 22:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="deWXobRF";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BE110EA42
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:30:26 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f55efe7so188270466b.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789338625; x=1789943425; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NsiZnkuoCTKPflfGB5QjfHDZOp+0VHmNtyOlMcgcc9s=;
 b=deWXobRFkeXeI0xVYe6IQfdERaubEclCJB0mkOonE+zr9sZJBEi9nZdMXrgWSzPKdC
 hK3aT+1WIW8pDAuB4/PyxXkyK/VD9PwmXoZhVAFqBY3LM/CVQPoq0lY/f+NYrijEipbi
 AECqVRW++VG0heAcA71JMZ187ZjZcPjjTUAj6wb9zHjBPEX71pNy8qaSMhxikAw4LIGS
 hVLsqvnu81M7olIFuKYYoerbWOO//a+6B9rU01bF8auJEXA+qlu+V3OQNP1/K9iHXSHn
 /fmxJjphfDRDlRA6O3INmLrijmOlwQpJNii/tqoetxkwTH31fbUBKrnQzaSawns8MK2x
 xm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789338625; x=1789943425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NsiZnkuoCTKPflfGB5QjfHDZOp+0VHmNtyOlMcgcc9s=;
 b=SLNu+l7+qwi6EuQ6BdaAf9MrSzOxJbo6+NGx4G+6RtgEWkFoOpov0km30Tmb/88vPy
 m4CfrDb+/701kFighEVWCwx0N3cNf7dWOGeo6CV/n+u2amC/kUcFawO0O5/wn9MZh68b
 YGDQIHTAJEfMScwFPfew2lnv3/e4n+lP3dG+w+zwR5/+uKBhC83MNecQdMUVhX7yqLUL
 Mss4LQ6WDSzeyMsjqglpb1mg7WYAgu3ciyuio3Z0PW57OnN1+7Cq+/MAhN5HCNJ4FnAb
 SNjuTtBjbdax/39t399JjSwlFTV558HPnL7YqVgDkIqJosKf+jlIt/BnJlIP51BKp+gf
 lsmw==
X-Gm-Message-State: AFuF++kn5TpzEM8IDzgti0oHaT9cQQTXIqaBCcuBQF9e0b9i4vvKvPCz
 CPx/5ULt+VeZ8jsg+4DGcck/twUsHs/MpRZvI3/cfvQyTFLmPurCvYtV
X-Gm-Gg: AYBFou1gLi/rOCxJ7QwCUtQlWxoN4pJKtd8SaPLwSo/VcqWnl429/GDxhWI37AVn4Eb
 Pd8Fgxkcterz4L+Hzr4I+UAHrXR68pJP228GQ0N91S4NvtXkZ4NqiBWvd62EvqMk3rNOqj24XYB
 Cu8PdnIps7izaO+e1erV48jTTvy3ZhRQhhQNaYI2AeF3keClV9e65GZD9dUdi1QzZvO2ydzqPca
 FAUi6y8ecqah+7q7WyQi7lTc4Wl/EM8erDjQU5xgXNnyJFnB+8YglswWKjzjVK0q6tGqtyxP6y8
 CmVmzraTPf33pdqAqjgDAKeUgGnatiPf5OVqApH99ZHDvBo9aLedzowUg79v95750zQohmSoMlW
 hR5cQCmWaopPA/LcTps7URMRVLH+k1BbknfczsXGaHlczTKZBkvZ5hCYyhZxzuFUiIjkK5oTAqQ
 A1M3VbO66qg8qz4j35yNPaTooH7Cjj5WeuSZ6UxeckJPw2g7VC/Ok9oYxa9rHHDxFI
X-Received: by 2002:a17:907:dab:b0:c26:1dc7:bc42 with SMTP id
 a640c23a62f3a-c29b863aa91mr4607066b.22.1789338625165; 
 Sun, 13 Sep 2026 15:30:25 -0700 (PDT)
Received: from beelink.. ([186.247.78.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29ad3e033asm48063066b.47.2026.09.13.15.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:30:24 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 2/4] drm/qxl: reject command sizes that exceed the release
 slot
Date: Sun, 13 Sep 2026 19:29:58 -0300
Message-ID: <20260913223000.695299-3-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913223000.695299-1-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
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

qxl_alloc_release_reserved() receives a requested size from its callers
but never validates it against the actual sub-allocation slot size.
Drawable releases use 256-byte slots (RELEASE_SIZE), yet
qxl_process_single_command() allows command_size up to
PAGE_SIZE - sizeof(union qxl_release_info), approximately 4088 bytes.

The command payload is then copied from userspace via
copy_from_user_inatomic_nontemporal() into the 256-byte slot, causing a
heap buffer overflow that corrupts adjacent release slots in the same
page and can overwrite the neighbouring release_info headers.

Add a check in qxl_alloc_release_reserved() to reject allocations where
the requested size exceeds the slot size for the given release type.

Fixes: f64122c1f6ad ("drm: add qxl driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 06979d0e8..049ad167f 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -312,6 +312,9 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 		return -EINVAL;
 	}
 
+	if (size > release_size_per_bo[cur_idx])
+		return -EINVAL;
+
 	idr_ret = qxl_release_alloc(qdev, type, release);
 	if (idr_ret < 0) {
 		if (rbo)
-- 
2.43.0

