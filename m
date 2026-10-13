Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E029FCC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25ECE10F680;
	Tue, 13 Oct 2026 09:33:09 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D50110F678
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:33:02 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso2613450f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791883981; x=1792488781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j79G9x93qm3T0R3P1TfLErsNrxHPzMPCo5TuV1Ni39U=;
 b=hswILJ3Pf0ntzLSdWT7OiCL0D0R9ErqQkPGyeYn1Xlb3qS2WPi9j4zNI/jA3yVnQx0
 3DXquS+PrgFNKMmv/pm45mVbWW3XZdt9wKI7TwiTrwBjXU7WvHLrCxmRyzMJphfQvVz/
 UwW6JbM7tCkIFqf+O5sbp5+wWp+GuN5C525V1LVT032U2iekPhD3g0V5L8nLIF8xTk1X
 npRpbgFAeB9LLajn1bOyObUGc/gxVbuWTWL8fdozO/LWlfnlsyyKEho88kPwln+pQj5S
 phXqWHbjBxW9VXNNMvo3Xuz2C230YEuQpE/mfiOa0z8N1SdzxSzZVgyo3PdnmqXpGtsn
 TA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883981; x=1792488781;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j79G9x93qm3T0R3P1TfLErsNrxHPzMPCo5TuV1Ni39U=;
 b=Elv2hjWlfwnLXGT7nbGOB9WK5dKn0MxszDvoQFMyQCFCJ2QgY6WUFDTj/Ky86ObU9q
 NitnwxBh0LsjXQWBhDdnyugrCAStLXNwbh7H0S6v2KmzFtnOPT6qKzNaZeOmuJR/ppfs
 Ht5xcIbst9qQycgODK6kGZHxi1jKfvoWWpA78r/z7dkA9M0tmKGSirApw2neJ70Ut43c
 53iGvJtFDZzmU4fZtlQMp+Pj2mgMb/VFWGXkD8sxvhIfIAss7qr8836p9wE7fNbuIgPE
 tvLVjrprNwDq5reNIqkB2C1AX2WjEAUUIkUYHQtnYCtS2yf+FdJHUUyRTwISj6lMESTN
 fOvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzunH0HCnPmHUyShp/Emp7hUwfRCkIZW5kT8hJQ5H1tqLx3FjRnQj3J5DnhVGxOvu/ovdlrErHaZ4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLLGepdELnuta7Le6lwJwEEZhzYRcQSSBEM8mdp7jwfyQvllIVg
 W/TC1DtkQVAwURuxzi/4Gjm5wEfTvem5kDjPQY95ePcZDVYNhDbiC5MM
X-Gm-Gg: AYBFou1PJoNeAt8Zj4O1fjf8P/TOwUJUi3XaWntDtDCFCo8MlS4IislKAkLVp1XKdz2
 Uw5RwlpvyvYGU9jMN/VRGNHN3jBbUFzqcBKQsiZ8zOKnSkw60VWn5g3fgh0kGqOYotWiszLSS33
 wUR9rnmU9/h6c/pbRKr+Fxh4jXyzCpVvtQccPhi73ZdVhEHKQ2Ey8xtfMis8r2FoRhh+7EnERkE
 EzdpHMrkEw7m7sxxlFJFE9Mpjv2ZnboK3/VU9KRMG6f+G0RfjCulrG6VRsv9bR2wHoouzUxsej9
 DjTtbLL07/Dy2ZLXZF4NMj2lPQ96D3ACdvX4Ag2bYAojL/840Sq/ttbH6IqQYZFLKxIbnYrrzIb
 8S9qY3D8CIRr7n4lHCZ2kJMVYAGkZy/ieSjV8eumAZ8I5xQdm1nCDSqe8jLqo0ZD6t748mIqTG4
 HyEdKxUJSvJVxJH7HteogZoMyIBZjMRY1H6tmuSiSNBcgjNDbPsJIDCjobpX3PvNz+GKm1id1nx
 1Y0tmZN7I2q/DK+dMIpA+0m
X-Received: by 2002:adf:e712:0:b0:488:7927:9ca2 with SMTP id
 ffacd0b85a97d-48dbace0e05mr17961496f8f.49.1791883980607; 
 Tue, 13 Oct 2026 02:33:00 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ec6sm3986774f8f.48.2026.10.13.02.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:33:00 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/13] drm: docs: remove bootsplash from TODO
Date: Tue, 13 Oct 2026 11:32:35 +0200
Message-Id: <20261013093243.505776-6-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261013093243.505776-1-maximpedraza@gmail.com>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
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

From: Francesco Valla <francesco@valla.it>

Now that a splash client exists, remove the bootsplash task from the
TODO list for the DRM subsystem.

Signed-off-by: Francesco Valla <francesco@valla.it>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 Documentation/gpu/todo.rst | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index a437ae5c71f4..e77de5e2a24f 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -773,23 +773,6 @@ See drivers/gpu/drm/amd/display/TODO for tasks.
 
 Contact: Harry Wentland, Alex Deucher
 
-Bootsplash
-==========
-
-There is support in place now for writing internal DRM clients making it
-possible to pick up the bootsplash work that was rejected because it was written
-for fbdev.
-
-- [v6,8/8] drm/client: Hack: Add bootsplash example
-  https://patchwork.freedesktop.org/patch/306579/
-
-- [RFC PATCH v2 00/13] Kernel based bootsplash
-  https://lore.kernel.org/r/20171213194755.3409-1-mstaudt@suse.de
-
-Contact: Sam Ravnborg
-
-Level: Advanced
-
 Brightness handling on devices with multiple internal panels
 ============================================================
 
-- 
2.39.5

