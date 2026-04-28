Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A471FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E31110E330;
	Tue, 28 Apr 2026 10:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="igJFkROa";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6488210E330
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 10:25:42 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so5985441f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777371941; x=1777976741;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q7r5F7vvIB8eGhy3VoOY/ruLXo1fkht5EKt0iNNolYs=;
 b=igJFkROaJwnO09BZHXnpc7fALNYHB2d9LVXP8yCXZ573dAL3Ly2bfyrcCWWWuqjJYW
 4ZQtJ9MYRp/iwDGdo1lBmsRJQUkB6gW/PvwqQuabId+MZmAT4DvyQGWIHGRQhAU6TFeT
 jCReJRvxlrvMatyq6ZB0LwUz4Yq4BvegU4YcB1GjqPY4Z431jNPoxCIA5Y2ZtBUM2wCU
 W+wx6EG2uGvnZj5DDkMW8OGE9la3EOHxXHMdS2aXKOd0qjcY3Mo7EqSmu2zqJbnYQP89
 ba+ZM3FQSqWflTcRzVgRu1t/SalTGmlWITFaRECiFrC0eRUQoj8KXhgUIhhZ81k9x7kL
 qvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777371941; x=1777976741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7r5F7vvIB8eGhy3VoOY/ruLXo1fkht5EKt0iNNolYs=;
 b=M5B1pbaIPIP8KTx2wM6FVQ71piv3CWRPQhzxiKUnOPyLrUtxi9xeMFcImjXHsSEpIT
 0aaPGMXt8S9AsmS26ywQCXBodMih+5zD6XFXIGsW2CuohdxSB7oMhHOCAS4M2ZsXOIIb
 gbqzHRumiRhHQ220kE3n+f4/G+dZwVBLCXRyobOWCrbugLjbg9n+tKBauFpbRz3WxEJQ
 nwTyPk7DBjCewFlyJm58tU/8jgzu32r1zDR2f88EPe1MBSUoLypUYVZnzQNeSEzWVkin
 zt4GEhmdt/nGfRolAmZMdtL9o8KFrUu6yLMTNjDwiibnouEjIADQHI1IxFXvPlwRBg69
 TuQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VQM1BLYy8cLRawp9uOADbkev8OUBTP+74NHCPzVSNqlu2VPHqhssmVtsDwzm7cTPc2ZQGvgZtOo8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6XOWLz4DtyPsEd84D1mWcZniQ4gTtP/LpRH1BRH4OJ6ZqROXR
 OFRANU70A4zuvTpLXKkueG1H+ypiy40TgxtN4N7uYKr22kT6xndRvUmvozWjkY9U2Os=
X-Gm-Gg: AeBDievidOHHXtXek8XD+cKZk3oeSebjCkl/f+i3MwkOlsn4Ny1K7v1Zpqkb7RbvM80
 7M6kxzBpfjxtDikyP4SlLppmk/WDeQ6uV5qWJgu6Zb6dOQXvuzy715/FCD5b91fXPgIW9a1+rba
 5nVaJI3lAzQmWSsUXEMd29GMuuXC/UQiSZLcZ3nGJx2yMNS+rshvV9wHt/LDdxcARVp+ucJrCk+
 5H9d5n9a0j05FF05ZnKLc17OTgihENHwMDv2gK13bwWppWMNI3MqabiH/IlEEDhw4EpPab6S/C3
 DAdpkTq8w1xg7UIBcsU5LM1zpiki6JLst2CIXeZ/DO4Xklky4K322U/jHP0FpMhMDCsych7O4fD
 xwpQtLZ/ps725uPMuHlvgK4xn+iquwl58UaHRlKJUPnFkT1Avjue0sL6VCYZUYAFI4nEL3lku/5
 nAr52a1W/L2qutFVt/xbYB02KiZeDranI13XLfiPrRd5fhm9b6pSLCyajSTGs2s4b2lF8+IKjEy
 mna6Bme5FMGj9/GYkVoQZSF
X-Received: by 2002:a05:6000:1862:b0:43d:77c6:be6d with SMTP id
 ffacd0b85a97d-44647808875mr4746071f8f.7.1777371940929; 
 Tue, 28 Apr 2026 03:25:40 -0700 (PDT)
Received: from localhost
 (p200300f65f114e088cd204a3a67aba2e.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:8cd2:4a3:a67a:ba2e])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4463f4c0b0dsm5670168f8f.23.2026.04.28.03.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 03:25:40 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: "Matthew Brost" <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/xe: Don't use UTS_RELEASE directly
Date: Tue, 28 Apr 2026 12:25:25 +0200
Message-ID: <20260428102527.189593-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1798;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=kYS1CLDDr+kbvgcu3WTZErio9Ph7NQimIR8DIaYmNZ4=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp8IsXzUT00Oob8DoNg73TBwjosMQMtMdPRBhug
 eRs/ot1GMuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafCLFwAKCRCPgPtYfRL+
 Tjb5B/9ls6PsWfSLN8vT+vnwCKbljsHPWuFWXjV3X77dPw1583yxkZ7Hx4xZ4sz28ov/a3EryTs
 a3YNStBGBREcc0FtcNkd83vY6s1Wujy5zUFLufAPHfGk5o7umBILI7ZADmkdKleu+C7gEaqannb
 fLy5N2JRcOmMSaXliUmWsSN7MOYcbJ3hhMluR/T2LqhuYz1WqK+k1zGwJDN4IwGZ7QR5dsP47fb
 yWhzheOHWLuHPsaR6osudF+D1syJ8KUt62pzzoHyPokmYf4VHvu559y9Cc7qF0H6bswV75Ve6zf
 9Py2ej8WJ3yXbKFCLtMJUwwvA6GX9mdKp5ge6SjAkaaZQOVq
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
uncommitted changes in the source tree or new commits). So when checking
if a patch introduces changes to the resulting binary each usage of
UTS_RELEASE is source of annoyance.

Instead of using UTS_RELEASE directly use init_utsname()->release which
evaluates to the same string but with that a change of UTS_RELEASE
doesn't affect xe_devcoredump.o.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

(implicit) v1 of this patch is available at 
https://lore.kernel.org/20260427160902.1126027-2-u.kleine-koenig%40baylibre.com.

The only changes since then is that instead of dropping the kernel line,
init_utsname()->release is used, which is nearly what Jani Nikula
suggested.

Best regards
Uwe

 drivers/gpu/drm/xe/xe_devcoredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 558a1a9841a0..07c7c89240d8 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -8,7 +8,7 @@
 
 #include <linux/ascii85.h>
 #include <linux/devcoredump.h>
-#include <generated/utsrelease.h>
+#include <linux/utsname.h>
 
 #include <drm/drm_managed.h>
 
@@ -101,7 +101,7 @@ static ssize_t __xe_devcoredump_read(char *buffer, ssize_t count,
 
 	drm_puts(&p, "**** Xe Device Coredump ****\n");
 	drm_printf(&p, "Reason: %s\n", ss->reason);
-	drm_puts(&p, "kernel: " UTS_RELEASE "\n");
+	drm_printf(&p, "kernel: %s\n", init_utsname()->release);
 	drm_puts(&p, "module: " KBUILD_MODNAME "\n");
 
 	ts = ktime_to_timespec64(ss->snapshot_time);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

