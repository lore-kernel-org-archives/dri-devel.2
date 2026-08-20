Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107CEC5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6740B10EFA9;
	Thu, 20 Aug 2026 10:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XxvYHQnI";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D7710E601
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:01:26 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8518b3ff3e9so1544995b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787216486; x=1787821286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H1cXU6F1o2rHz57g5Mrsu2Zu2w5oL+wJQFcFFRp68YM=;
 b=XxvYHQnIFUBuVWLJe5TGCRdgkdVdqhFlc4m8co1brbIx9uuBwH31FyMZW7mMxZAJ5H
 fAtmLk5PW5pN3qiL1vXjw+LIR03mJkOewBcz5/TSR5bfJQU9gv9FWORLicA2QlyW52/w
 JMPyrqnlOOpxNjzxXO9YrbxJBzB8eADMILA8MDrHyQcLO7KUCrpqhybv+ukO4HP126e9
 ANzh3WcZK0dJrm3Ti0oG2NzXX1YsOw0LhfFOmGYLgpS7B5yYJ4dRz3d6laXpaVIId+g/
 6SuGP0GUR34iBDwJDmydyHdhs4kRkfhtixMuH96qqrPXkLMwSW7J59B0OvKYf68OJ75f
 bsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787216486; x=1787821286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H1cXU6F1o2rHz57g5Mrsu2Zu2w5oL+wJQFcFFRp68YM=;
 b=RTRmxSu0x3uC3+c6o/ZcC4BQyZIzDcY2QyGMSYD5ShC12KaRNEmov2s90AtYq7ZrVk
 GC6/OYcsLW19Jhg7VXYhZF32NUG8VSJMRbQjHOZRQdoYgea1lVDULQQSzQAlYmzJb76K
 dHhR1ohN4DTqjeBwk6gRMYNnRMjdJ8NvlkPO9viNsKio6EvCS9Q/WGpgfAUoMlQqz/Wd
 H5Jvws0aThL4qAy+mFHRMmj4YAaFQEJswpgw4WZ/c2ljv9abTYvpdYf2vdOz0wHp+Tcr
 /WV6d/2g8TOY3WpcTk9gTlJG+LnYG+5LLEc6KeRH0Uj5supdt0dW1olkhGqqgi+DkBeP
 SU3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpggGJKY1OIlh2qsQ0Z3IYrg6nIbypLmaTONKptESt9I7DfP7yy7GoTJ68HqhrRBcyxbyK8bEOzZ3A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrSxOBQh4Co3YBYs9PFaIHQjj9rpvVjsr1wVvxy6QJ1Yj4JbyU
 EWVeqUhfW6CJtmTDn/4NxT7bmf94VufvrezAdFLlrxToASzwEgoDGCI=
X-Gm-Gg: AR+sD126nyvvosRiPmkHJ9C7GZY0jTN15wW3UxO9ukKnqD7dSK+a16MdahwQc3xmKsj
 cGUFXq8KdSIpuu8j132mzK3yATodgALtnMwE5ACxT3vWul9+mtxBXoN/x7KPqCqOP68VH9hHQbp
 HSfHg8E6jnIcIVArbi4IRg1qJCSI4W6X9wpXhctAx+5T4JNa7qXAX8tHBLL6wJChrev6wsnJhIR
 Z4vGLJoMd6A+HrkfM+A/H733hP7gLXq2VdxBf4mH6JyZf1HDui7Q9ecS9zn82RMSOEpQ6ng6Z8Y
 wb3GES5nsWU0R03EZZVzV/NAXWT11yOMvJHxareZXXlRVyCHvEVYVdoklY1Z3UbhNWbJhxHo0wI
 L1TsuRbiGX4/KT8A8UIvA863LaIoFs3xUAXh6bJsmi553KGVUTsKaReTxFwmW+CtT/e/tDZ+dyP
 8GhlAJH6ndDO4zUw0V0onjM5SKyMCjE/HNuLHgV+byS+NHyk+OZ9lErDq+RCp7MUOEgw1Sm65cQ
 TDwfU80CAYa
X-Received: by 2002:a05:6a00:18aa:b0:848:6c9c:4074 with SMTP id
 d2e1a72fcca58-851d3805df3mr18933563b3a.1.1787216485656; 
 Thu, 20 Aug 2026 02:01:25 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3362860sm1408804b3a.8.2026.08.20.02.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 02:01:25 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] drm/panel: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 20 Aug 2026 16:01:19 +0700
Message-ID: <20260820090119.2107869-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 10:07:27 +0000
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

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from its suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c | 8 ++++----
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c b/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
index d5c7210de4af..11e11abcba4a 100644
--- a/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
+++ b/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
@@ -149,7 +149,7 @@ static const struct drm_panel_funcs nl8048_funcs = {
 	.get_modes = nl8048_get_modes,
 };
 
-static int __maybe_unused nl8048_suspend(struct device *dev)
+static int nl8048_suspend(struct device *dev)
 {
 	struct nl8048_panel *lcd = dev_get_drvdata(dev);
 
@@ -159,7 +159,7 @@ static int __maybe_unused nl8048_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused nl8048_resume(struct device *dev)
+static int nl8048_resume(struct device *dev)
 {
 	struct nl8048_panel *lcd = dev_get_drvdata(dev);
 
@@ -171,7 +171,7 @@ static int __maybe_unused nl8048_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(nl8048_pm_ops, nl8048_suspend, nl8048_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(nl8048_pm_ops, nl8048_suspend, nl8048_resume);
 
 static int nl8048_probe(struct spi_device *spi)
 {
@@ -239,7 +239,7 @@ static struct spi_driver nl8048_driver = {
 	.id_table	= nl8048_ids,
 	.driver		= {
 		.name	= "panel-nec-nl8048hl11",
-		.pm	= &nl8048_pm_ops,
+		.pm	= pm_sleep_ptr(&nl8048_pm_ops),
 		.of_match_table = nl8048_of_match,
 	},
 };
diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
index b18af526b54c..455a4237b1e1 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
@@ -382,7 +382,7 @@ static const struct drm_panel_funcs td043mtea1_funcs = {
  * Power Management, Probe and Remove
  */
 
-static int __maybe_unused td043mtea1_suspend(struct device *dev)
+static int td043mtea1_suspend(struct device *dev)
 {
 	struct td043mtea1_panel *lcd = dev_get_drvdata(dev);
 
@@ -396,7 +396,7 @@ static int __maybe_unused td043mtea1_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused td043mtea1_resume(struct device *dev)
+static int td043mtea1_resume(struct device *dev)
 {
 	struct td043mtea1_panel *lcd = dev_get_drvdata(dev);
 	int ret;
@@ -413,7 +413,7 @@ static int __maybe_unused td043mtea1_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(td043mtea1_pm_ops, td043mtea1_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(td043mtea1_pm_ops, td043mtea1_suspend,
 			 td043mtea1_resume);
 
 static int td043mtea1_probe(struct spi_device *spi)
@@ -492,7 +492,7 @@ static struct spi_driver td043mtea1_driver = {
 	.id_table	= td043mtea1_ids,
 	.driver		= {
 		.name	= "panel-tpo-td043mtea1",
-		.pm	= &td043mtea1_pm_ops,
+		.pm	= pm_sleep_ptr(&td043mtea1_pm_ops),
 		.of_match_table = td043mtea1_of_match,
 	},
 };
-- 
2.53.0

