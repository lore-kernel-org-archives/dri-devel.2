Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0F4C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C225B10E67D;
	Mon, 10 Aug 2026 06:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z8FiYSzT";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD52910E10B
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:49:58 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c9ef3e1337fso620916a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265398; x=1786870198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ohuKFNYedefwgEV1kOLtJZIOQiLf64k0Qg77YlHmp8s=;
 b=Z8FiYSzTCEovlS+3L/EvVq87R7B+nm43iAuTyX5TCujgT5FdJWC7PmrXRLmcmifbxr
 QJq2zvIZlgBZ44qDHkLqluqJGVFIAEgxZpv2XSnnMH1EHHTn0u9+zd0TzE/V9LAWIUFr
 h/J79rIv0+AHgRFr2V8orei5SEdDM5A3R9MtYSF2aJurloLX5c66kuCpEafItVikadXY
 jWfJG9sgwiZ/PM7+6zn2v4+Ani+MUzTWg9vvj+d/k4jaxXZSGl7osICUGuQhqnCtLCB1
 U3SjVV0VpHlZrFNYgab4VJ1SXKitFIz48Ay0WUNAxuay7ht1nDE3mBr+Xpae+R0zCbB4
 4JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265398; x=1786870198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ohuKFNYedefwgEV1kOLtJZIOQiLf64k0Qg77YlHmp8s=;
 b=RDfiTDP67BvBAUJU31O9BJM9+1AG/Stoiyl3WaBdEsBl5BqJoVBed+rVJp1BpM689L
 YNDLDojeiO6fd2OMmkpwoDKCgLLKTSbi41Txd81wItpLjSKQ5nqyAgMwoZJy+qB8OC0r
 gPOHzjPEL2CWLt6ZcDG6W8yG8q3ErZnUHJqiOe7Vx9SAZ+xTiTUJOeMow/DPBA8wYwkF
 impLdEybjyYt7GwfbQIPt77OCZvFLqYOLZK+qsEqJTi6FhDJWQF5oUcveJjAvxGAHwwo
 dTGjpE2/6++YO4g5tX9DXqjyJ4cLYgrHXwirMycbNJPtXj9EOKixsT2Ck8vdzD8DV841
 W3AQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKHOVG1cHHHUijOeToZZUDN044OlPCrINI/RnOF4VmGJe130lomqtNAjP6lhJrOeUaY/UpOPQjzhM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxC91kbwOiqr887yqVYjjOZRwqPKypLT9p6pmVD2cHmspwSsXHo
 vMOer7LF+ieHsPpWKYuj7g+xDjYTYRIgjVldeKb6mn3y4EYsqxejaKtw
X-Gm-Gg: AR+sD10XbiAM+I8yN4OeQ/3F41jaNXlbAwKa2+Rf5bAihZ6E8SY0tv8V1pGF9qDfWdD
 JASHlVPlU4s7vAPvxGIQyQ2JHTlQx24SyXOkeB5cOETEWSaeX9gdShUJoicF8sNlrK6ttW7C08g
 nCy48cjjsZkBXcmS2TDJ1lOQMnMiXHxN5d7PdvnwQ7++94cJ/uCEledP6Q1V/DZ0ERl9prAE50d
 XTIQdjMi3UCgtZdQ1hDf7Vz4ctn0I20XYDsjPRCpNx/DeDbji0YIuEjm6vpHOWuwwc5zvJw78Jk
 5i+SvmTqlIb2KNnG9ONENjezjyxcjAVk7WwYR0T5BMMW/zzBU31/Etu1Y5vcbHFjLdDlCQ2bQ6S
 VTCeP8qUNZZoRwlnwHG78z25D/LKT0qi8DIGo8vNOdIR9JapC1O0JlmJqR1RHb3WuNfI9JTmZPo
 lo1jKJMwRX0wJRBiULBwZB5uAHQMyPasV6fstsHdRQ+rbChoD7iefJ1JeOp30RO/6+h3FBk618a
 utO5yOra5M=
X-Received: by 2002:a05:6a20:6f02:b0:3c4:511e:26ab with SMTP id
 adf61e73a8af0-3cb85ded984mr46153927637.3.1786265398022; 
 Sun, 09 Aug 2026 01:49:58 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:49:57 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 5/6] drm/amdgpu/aca: Fix off-by-one buffer size parameter
 in add_aca_sysfs
Date: Sun,  9 Aug 2026 08:47:34 +0000
Message-ID: <20260809084735.9743-6-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

snprintf() guarantees NUL-termination within the size limit specified by
its second argument. Passing 'sizeof(handle->attr_name) - 1'
unnecessarily reduces the usable buffer capacity by one byte, causing
sysfs attribute names to be truncated early.

Pass 'sizeof(handle->attr_name)' directly to snprintf() in add_aca_sysfs()
to allow full use of the allocated buffer space.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index dcddeb381628..3da3d369a918 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -682,7 +682,7 @@ static int add_aca_sysfs(struct amdgpu_device *adev, struct aca_handle *handle)
 {
 	struct device_attribute *aca_attr = &handle->aca_attr;
 
-	snprintf(handle->attr_name, sizeof(handle->attr_name) - 1, "aca_%s", handle->name);
+	snprintf(handle->attr_name, sizeof(handle->attr_name), "aca_%s", handle->name);
 	aca_attr->show = aca_sysfs_read;
 	aca_attr->attr.name = handle->attr_name;
 	aca_attr->attr.mode = S_IRUGO;
-- 
2.54.0

