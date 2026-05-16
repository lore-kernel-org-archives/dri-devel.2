Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7017DCD4F55
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD1F10E6E7;
	Mon, 18 May 2026 07:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pde+B6vm";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E23D10E1EE
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 21:01:50 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488d2079582so8847505e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778965309; x=1779570109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c9ekvX0DWIiiJWYzSLMlzJT6YU8iYAyRXmqi1P20r90=;
 b=pde+B6vm183UKSsi9gasG+pd4twhuGSRqDGy3nL6hsEQPZRZ42P2+k/XwnGA/DVVjo
 GZ4CnfTzFVApkYM+kdI11wJ1dHmbH6tHhiaiwOpS8zr2SprCH8GrHKoSpSx9sWypMt3n
 TiirpeNgNKsaL2ZF1deicM2JFvW2rL0usv1ogerufrU+DMiYivKgE1Ag3XefpBHDB3Ry
 g8KEYnETCB4QiZcKPk24JrxTXJbx9Ew4enxTOm0vZ4XgoEcEg1S2TqMa7c9qaJQQmNkX
 cBu4SCDcw2UwCarktbBPhxwWXSCx5jvUMbUQfpQKZ7RRUbAFoRd3tPBLtUI/+eaJOCVs
 mk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778965309; x=1779570109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9ekvX0DWIiiJWYzSLMlzJT6YU8iYAyRXmqi1P20r90=;
 b=ozn4qNZMtM5d3xeB5bng2u9TBpWvHUcUQfHSq6ExcwApPKNaz8Hj10GEv9P75Rzqlb
 PnDWXlz8c0Ktw5rct1um8tneDcSSkC4P0KC+vFI6mHbfPU6QEAyr5vX1NzmAfdeGcd4+
 385m9GSdZG2v/lFn6F4DWJ/q1JdSBdwxVo0Il7STojgbGKr8C50YXmh/5qpcvYFCb6ot
 +dLH2hg5TI4MgjFLPAKDjBimFqmLcYz2UQaIYjW+SHUqqlFZCV8ifGi4sp1tadJPg0Pi
 ThZywHxMaHjtDrDNvTWHSvxdzek+QAw48nUNyx4O3MZ6adEOj8KUld2lvgvjnXIqBiuL
 y2Xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/EGyLWvQTBS2keOQlz+bZDdkJQf+7UJQALLciQFjrdxZUlx+rFhq+W4wHTArJzwq2KV9YAf2wsobI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7saUxCHKT9L+7DQRQqWwxTDc6ShZdAZsMPrktvCbxObYAAM5A
 fugp8M6YxnrNh66A42Fl9QRfMFq7jYkDm6NR9RfjQKy2G8S4W1okSpKe
X-Gm-Gg: Acq92OH0D4oz3ag4TqO+RG8RxOEn8+TBKmTfWQW3hI1BqBlAf6Yh3WUlq/W8Ezb7uzU
 Q33GDBUtuHMXqAj66eoFeeImiTEmArCc1idZwAnPR8lohWjJ7JNKY9jOj6VX3p2v3Awilh3TEf8
 Hf11RO8NRDMxGm4rfqzSFvEBPGzuCLdYi7y94mB7senMr5j9vv7WFjrg1+jG2/ija7xfMKNBwDm
 T+oJvRP+wW8+4bDbs2XZtmPbYPTUO+HuQntS0l9QRf4R0pnklDjRs3ngSOloFPSe7lboKL+YAq8
 ZLlvv8K0oIwncz5RJJebTXE6xTQlBICW3OUbVAtk1oL3idyacOVfL9WBYXw0vPI61D/aMSH7K9/
 wH+kfVsIKV/HLRf21lnRjfWJnPy/grGCQ9QX3Rvi1V98eUVugSbSRxtVLU+Z6pR8n4VnN0wFQOk
 rMEDRHPJpbcUDJPyEaG0/xX3Xn/bqW7Rhx
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id
 5b1f17b1804b1-48fe59b047bmr142612965e9.0.1778965308595; 
 Sat, 16 May 2026 14:01:48 -0700 (PDT)
Received: from Godswill ([102.90.99.61]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694fcasm131254605e9.5.2026.05.16.14.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 14:01:48 -0700 (PDT)
From: Godswill Onwusilike <onwusilikegodswill@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Godswill Onwusilike <onwusilikegodswill@gmail.com>
Subject: [PATCH] docs: gpu: todo: fix spelling of "fucntion"
Date: Sat, 16 May 2026 22:01:41 +0100
Message-ID: <20260516210141.42971-1-onwusilikegodswill@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

Correct the spelling of "fucntion" to "function" in todo.rst
documentation

Signed-off-by: Godswill Onwusilike <onwusilikegodswill@gmail.com>
---
 Documentation/gpu/todo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 841e4e986c48..7526ed31b0af 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -1001,4 +1001,4 @@ DRM driver that can run X11 and Weston.
 
 Contact: Thomas Zimmermann <tzimmermann@suse.de>
 
-Level: Advanced
+Level: Advanced
\ No newline at end of file
-- 
2.53.0

