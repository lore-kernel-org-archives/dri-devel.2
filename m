Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C55E937E3
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 12:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D903910E2A6;
	Sun, 12 Apr 2026 12:26:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HBBhhzca";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AA810E2A6
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 12:26:43 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c76b87931b8so2162158a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775996803; x=1776601603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1LE6huvR6spyj6pXFbXVnPFFoN9AhuKNeTxygPGeaug=;
 b=HBBhhzcaw6CBz29/VBvTTUzmaXZb8p0TdU1naowqBKq41dFtkLLtWpnYIqAShacxaq
 pScV2NLxa9pS0NgIiaNBdOOh9yDsqRlFdT+1H+dK7i+RPsceSd4fC38jy2Fdee9yDYvR
 SPe420Ic+3EBF0usKNc0jAfL8+rQw2hFcKc4QI7Eo07tzb+i26xG4/9toNtddzgFwHmK
 IaCBMX+qf5Ch8rNDG8RQP9o7Kt2iz4pKs5CsQNg5n3PkUzn10lHNgyVOCGP+BR0bx96x
 7jqq3fOwvha1Yih2DtMBCCHkOJoTHAQUWZDB6LR0F6ii2EPp/RenyYzllDNCGFsLD9qt
 rdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775996803; x=1776601603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LE6huvR6spyj6pXFbXVnPFFoN9AhuKNeTxygPGeaug=;
 b=a533hCSA+UmKoMvTL67h5URHgy+5QwrB20oyqiwMnrMmtGQIRKzeRl9mtt6wCpakyr
 OviUki8xm4J7fLvphMioGJ3MvXvqp34tvLaTycdhWBlcFdQqwxbrcV9jlW01fz1De7oV
 c2IA+UYYOmDkH6uS1h9UywlyHQDuINUPD5lqR+Cg8xEuEg/uW1AqO/7BQ4DiKbGPRwVA
 qFbp/VhPm6IGsWzbcTYY+6hN1VUkFZCtPP9v5obmn6bx1MHGWUNY6wo1DqT4m+057Pof
 rHTc2MOmQ9JY2wM9L3XigGyePhDubQGQpB3EcZfdWNrFDH6zG6+kah0Qs5Gq/bxQ+ZGb
 4BhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhA468YULLD/VA1Q3QBjXKJ7UDDHBU1buJJAzXWmZzAss/kuwefoL0WKn7l3Wiym5cnyI+8tDOqLI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPF+hNDlUuXIrMLom94w2MOKasyCQ/gA7B1LPn7TeE0XSORvAX
 Fh0+8SaNLj1wU8D6GMma74kAJDmZA0/93kVDu6NNlp2Gu+43S8dKpw/2
X-Gm-Gg: AeBDiespLPP0DcUbGyi8gaazvLwdfOiIiZI/Kqp8RFu8Udiuy/tE3+HxpEA32G84YRs
 m9UgEXiIHjiaUlDddbI1A2EmgxriUFosmJAV5ZceSSK3JBC07iuoi0SLQhIvbIZFc/nE8MFC9zC
 PpnZxSifX5XqfdIX46FxiCCTzV2PhD0lq8r0mhxiGYIhyOKTJxQRuiqxst93AxLoYJUUV8p4KgJ
 iTj2aYd9VOFhnr5FtxKAjsJiVUwZ3vDDKVNZTNAYHai43E44L3hgzfnTH2Qqe2l6Huxx7k/gLb8
 p0pQn+zBn3XLJNmivGX/GviZdL4PGB5BhCU9Ej00KxuxXgiOPI04o4i8RHCLOkTuklYMCgL+Ly5
 kRt7tXcNN3jl85eUKhPGkchOdX25m2HZM6eKU2sO977QsRO/ptCOVwim7hDBwKYvxfwsIxU2gwq
 LvUBnDCnuMdVNgUw==
X-Received: by 2002:a05:6a20:1592:b0:39b:e789:7d20 with SMTP id
 adf61e73a8af0-39fe3ff14c3mr10951914637.44.1775996803341; 
 Sun, 12 Apr 2026 05:26:43 -0700 (PDT)
Received: from lgs.. ([101.32.189.54]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79218fc462sm7633431a12.8.2026.04.12.05.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 05:26:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 Mark Zhang <markz@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] gpu: host1x: Fix device reference leak in
 host1x_device_parse_dt() error path
Date: Sun, 12 Apr 2026 20:26:33 +0800
Message-ID: <20260412122633.2487800-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

After device_initialize(), the embedded struct device in struct
host1x_device should be released through the device core with
put_device().

In host1x_device_add(), if host1x_device_parse_dt() fails, the current
error path frees the object directly with kfree(device). That bypasses
the normal device lifetime handling and leaks the reference held on the
embedded struct device.

Fix this by using put_device() in the host1x_device_parse_dt() failure
path.

Fixes: f4c5cf88fbd50 ("gpu: host1x: Provide a proper struct bus_type")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - add Cc: stable@vger.kernel.org

 drivers/gpu/host1x/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 723a80895cd4..f97567e6ae87 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -452,7 +452,7 @@ static int host1x_device_add(struct host1x *host1x,
 
 	err = host1x_device_parse_dt(device, driver);
 	if (err < 0) {
-		kfree(device);
+		put_device(&device->dev);
 		return err;
 	}
 
-- 
2.43.0

