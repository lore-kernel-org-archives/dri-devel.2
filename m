Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA65ECD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 07:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D67C10F9FE;
	Fri, 29 May 2026 07:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YHEZhtP7";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53BF110F6AF
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 22:37:27 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49056b9f04aso74465345e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780007846; x=1780612646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a5m+WvyMC+bIy8a0vdthZB52udcKqc3YLrb8WNsYpZg=;
 b=YHEZhtP7KSR/ApnZiFOot8//0QimCJcwF75+LHZxo2H0tjzAq3jl3J2zSW2qm0wjMu
 40VhJQQd1oShyBq1qbYYl4ze0t+pg7V/fIni88GksEahPvxQjN4wb+gFto4i7oeIqih1
 SU6pwTzd0leVJO0gNVtAcXQrIB4wpAI1vlJ92op6AoCVcvW+OMWMD7MB6sPzi1sr4HY/
 L2U6pGaInXamQ8gMyISY9QvXbPrB5HYjtvNY9o3QiiUewpOut7Hg1XMXFXnIviJy5t6t
 W+f5c01Tu+2JVBACOhd2J+xya38iL37vS7g0MYOyVdacQegvCfG7Zg2FdEYVAvGFU36F
 TffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780007846; x=1780612646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5m+WvyMC+bIy8a0vdthZB52udcKqc3YLrb8WNsYpZg=;
 b=JcgT+lAd5O0RS/Rz8xcUfPH6c/c8CGPh3DoyxSeuD6yVnlO070D71srs7ynBKwSjOq
 B8DngfiLL2/QZscoa5BsF+fN7Zp1dfphG3B9O5IipPF2YafAuYOnoW8fCePuWX9P4Hct
 UvI4doxoWLBAGPgJtxdHXLhLLxKJ1v2JYYa5MBirPuitIzaiTpVuQnmmX6+UtQIISRwM
 vv1rlcIuDQ5aICWIRlxCL/4HnGnfmlK/NHNhOOZA8z6t1xOGvFfAMHl65nj/MBb7ARaD
 PohWb4s6lTIr/LJf2cvJxaB4Hte/4CPLAS/8rGyW/sN9BqvS2XrzScIIlO/5CiH2+2Ux
 ukUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Paxl6gIIHWHN7JigWTfGNQCaioEoerSIGCEHT4u7slawQ7FT/HlMLeRP3a/1fI+SOrosG34c4sXU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYKafM5R5ky1RFXClSjLjAnBSH1OOPsTArsGWc45xMQgINv4hj
 NkW5wULfk8npy+7v5GFOSySZRruIPaqJMHVRxHYC9/oH0Vy9+j95Yrb+
X-Gm-Gg: Acq92OEGKVX91JWHxfh8vZtJH2d7Mhw0focT2MZaoGiYfK9mNCyaSK1n7tUDYSC7Av8
 7dlHP+K0Pkyrgf71SgXILFpZoi5ob1VuDGmhmKRDl4cwv1BsO5NEEIU5931/20gA30bXwnCNZlQ
 aRbx3EsPDlJfqJpVW9nu/RWITXOK/FkSlAyDTTYJaShtamuxN/nggQlpYx3/R2V4fvyqvfp+ff7
 Kufj1EwnfcVMeWTg0CW3AugvQoq2Igdb8ae0N7RNZtDvEs9m6KkQaM992gQE+CAnEoaFvfzmB9Z
 BLYNn6rbhTEkKZt9YCyTlyTXjLgSDV9SXwwIwuAuMb9oAFO6jhE4j/mDB8NYDCLT+SaG61xtfsV
 jDF/TZNpbPy0+qy8CmuwIAYqzPJZBBvQzaNcodf8IQM2P1a28qXbu19KQdwhgHrHWDMMxakR//f
 Cth2104bMizddzfJDxmiPrHx4AjZLkvlSwl/PNl3M+Wg==
X-Received: by 2002:a05:600c:a55:b0:490:6869:46c3 with SMTP id
 5b1f17b1804b1-4909c0cfa37mr6101135e9.30.1780007845583; 
 Thu, 28 May 2026 15:37:25 -0700 (PDT)
Received: from Godswill ([102.88.111.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909ca6575csm5829475e9.4.2026.05.28.15.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 15:37:25 -0700 (PDT)
From: Godswill Onwusilike <onwusilikegodswill@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Godswill Onwusilike <onwusilikegodswill@gmail.com>
Subject: [PATCH v2] docs: gpu: todo: fix spelling of "fucntion"
Date: Thu, 28 May 2026 23:37:15 +0100
Message-ID: <20260528223715.26645-1-onwusilikegodswill@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 May 2026 07:24:48 +0000
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

Correct the spelling of "fucntion" to "function" in
Documentation/gpu/todo.rst.

v2:

Fix the actual typo instead of newline-only change

Signed-off-by: Godswill Onwusilike <onwusilikegodswill@gmail.com>
---
 Documentation/gpu/todo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index bc9f14c8a2ec..841e4e986c48 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -55,7 +55,7 @@ There are still drivers that use drm_simple_display_pipe. The task here is to
 convert them to use regular atomic helpers. Search for a driver that calls
 drm_simple_display_pipe_init() and inline all helpers from drm_simple_kms_helper.c
 into the driver, such that no simple-KMS interfaces are required. Please also
-rename all inlined fucntions according to driver conventions.
+rename all inlined functions according to driver conventions.
 
 Contact: Thomas Zimmermann, respective driver maintainer
 
-- 
2.53.0

