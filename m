Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11924606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+52HW0H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977831122F9;
	Thu, 29 Oct 2026 17:18:49 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CFA910E301
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 17:08:34 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so20284975e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793293713; x=1793898513; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2penUq1it6r83a80cbOdtkqLeYJ8CYDR8X6q9mSqcio=;
 b=T+52HW0Hmi7reX4DHWpMYdmabssBrDtHK8hPc6fa4jlrzjGQM955cuqY98TkuJ1ErI
 pvx8RGu8VM3OSrsr8p0VdlWRqAeEv1Jxv9U7hHFQ0awac++AusmnIjH3aZKlqToix4xw
 SlQuE0rzxNki5DPOjQJatU28CKipjYGNYCMcVvyjLCOXhGdQFzEoHThburU2jljh1s5q
 HUuk0DWOoQjqb7MSBgJr2KmnfGw8igd8IkjHHDzLdpvZfKSp5WbjMh3yMUV0dd9yyjn/
 baJD/Q3yP194BXFHLnDFJED49HzoBXO462SRBEmur80w/nL5a9vBkQ/koqR4uqfiUahi
 Xzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293713; x=1793898513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2penUq1it6r83a80cbOdtkqLeYJ8CYDR8X6q9mSqcio=;
 b=fU62MzNmMrC2iHzGkDOfoJfe+THI+WWLlngL2ZZHBIBtQ8T7qcLbWpYo76KWhxcaRa
 JmcO07yGoNBkwCBmIMoWEARB2huqsohcTi6S5JRU3FU+FF3EsVmpZ3rO9x8IA2dst0bE
 Fi2t6JvU4GKH+phgIqOCfN5bGDCy3z43s7kuHW5F2S/6DAwfpT//sSpRPbWt/4Ewr6Vp
 1zonjqnFNK56vrrEWEn8o1O0HTZwxABqv0oLf/jAwa7+upQCagmv+lEYMpL1nvaldsAO
 aalY1N3E7DI3XC+5mNE2CxEOmhiyc8w45JN2fgqSsw8NbTB2ewUShwefzoUJq9XAk1Gy
 4ZcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhi4HJfQPVsgQeyQWCEvhVHqyy/C4IAXbOTAcoT80aKUAru63CEwsLzQNOQGg8toj/mq+qrmblow4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKNqNhQXNplIcuPgLSrbS1UOydyxMqc3bbMvvnCEPVpoUa51loC
 9Yx/kYdcP5oqLYkF6BOKAzUaTPD8iy6VgtDQM1QoVv9B4d9LQDRWr1U=
X-Gm-Gg: AYBFou3LKOU6AAQxrjDP7675OUk+xFs+4Dr8iAXZNrUVZccHCtontWv5kPWIRLuD99X
 1ZpkXNBqFbGdq/+EozAmYhELqGb0OaqE0tNqgiVeooa9SDbm5/h3/SK3cYRs6cw4cDLPP0/eD+f
 uraksnu+QWoZqetapL/QWy6dQxDsx8RzSCfRhiePYZyxFD4Yah1epwWYcxoZYS87zL2leJSaJrQ
 vHddpNvRv+507jha6uiwQz9E46Wc1VEBPxbaMuygezZ481Mi6hcbCPbky3YnhiQmhj0Yoz7YhTt
 N87QwK8pNhj3fhbm9UtRx1cU8fNrXVLwwWPVYj1HsLJbjESa5xgU0uZ3v3Di25xr3yBhhpIjFfm
 ho289lnfosC77hfpaYkI0ycwkR/aRzhnj2cnT2Ppqcc/q5rDfxwV3gAF4JQgtwyGKmp47T6iZVf
 hxV/SFY2iVBhUrppEXeEjg7jB2/9MvrxrFUeejBR2w2QtdQCT/wD2yoz+5OCAmOYm0jPnzmJ3o3
 jN/Q+HkwH7dzfICJSZ6UE8D2pCMnL+hKjeJ3giNP+CTNoFRJRaE/UVf747GCkty0kNJncZPDyw=
X-Received: by 2002:a05:600c:4f55:b0:4a2:1398:dd05 with SMTP id
 5b1f17b1804b1-4a9661ab508mr141416555e9.16.1793293712558; 
 Thu, 29 Oct 2026 10:08:32 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm82284925e9.9.2026.10.29.10.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:08:32 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] drm/radeon: validate ATRM return buffer type and length
Date: Thu, 29 Oct 2026 17:08:31 +0000
Message-ID: <20261029170831.915318-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 17:17:59 +0000
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

From: Tristan Madani <tristan@talencesecurity.com>

radeon_atrm_call() copies the ACPI ATRM method return data without
checking that the returned object is actually a buffer or that its
length fits within the caller-provided size.  If the ATRM method
returns a non-buffer object type or an oversized buffer, the memcpy
writes past the destination bounds.

Add a NULL pointer check and ACPI_TYPE_BUFFER type validation before
accessing the buffer fields, and clamp the copy length to the
requested size.  This matches the validation already present in the
amdgpu counterpart amdgpu_atrm_call().

Fixes: c61e2775873f ("drm/radeon: split ATRM support out from the ATPX handler (v3)")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 1da6bf1c17ff3..579ba1c1f23a4 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -183,8 +183,13 @@ static int radeon_atrm_call(acpi_handle atrm_handle, uint8_t *bios,
 	}
 
 	obj = (union acpi_object *)buffer.pointer;
-	memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
-	len = obj->buffer.length;
+	if (!obj || obj->type != ACPI_TYPE_BUFFER) {
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
+
+	len = min_t(size_t, obj->buffer.length, len);
+	memcpy(bios + offset, obj->buffer.pointer, len);
 	kfree(buffer.pointer);
 	return len;
 }
-- 
2.47.3

