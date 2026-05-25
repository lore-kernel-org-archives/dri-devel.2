Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AEBCD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 07:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE26710E02D;
	Mon, 25 May 2026 07:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQgezYIf";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FFC10E02D
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 07:16:50 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so25764255e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 00:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779693409; x=1780298209; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=24zthJvGUKXcZPIu9w9sob21/I+YzFqoj+uIkca7DtY=;
 b=QQgezYIfqDr4SnCVjBIhNcoEIzLJxtuQPltYFB84xmAnZGGbJ5YnWzR64ddJ/XdpS8
 Do0xOLdBEZ+Y22A6YxCLZXSNqus0PgH0EeVkgTmSmunfZSfR4J5fxLTysKjEDZZiY5ii
 x1lCf1Yz1q2gDV6mB5XwdCu+UeI2d2qiZxY0c3qNkWGjUkmm3c9IVpsYc8oOc4h4F7Fn
 YiQcxG8C56DGhDxXL7sC9kVcdyk0MoF7N+3j3NKVnwcfWtxOXtYZSizlAAjP7+YXyVDR
 Xfg+3LR1jLH2q7JdAb+ThzMa7a9pdnY/5/m6SiYcCrSNW5isYzcOrn5Sn5425YrSvwnt
 KuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779693409; x=1780298209;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=24zthJvGUKXcZPIu9w9sob21/I+YzFqoj+uIkca7DtY=;
 b=CA+EWd/XaM3I166AVfkfH8MjCtlOYB7X8P4Zv4EaBlkSggP7B5IKfXeySedGZcUehM
 iczhCyMIgkocRHF4aouZyj47dHhOuWYuKjIwCtnq+iNuvzdXp/ZVUl9iKlCxjpqYnsHG
 7O9VaLyr/mM/0pTyAP+aaEZ6/6WDHHruOdUhvqAyHHftfuhK0Qqz2bYich1AzYU8XEqm
 YLay5YOUW0pj5J+mUms/YRVck+FGXFbO0J8R6vkUdHx5yTAEX4rJ5jUVfGiJpHCaZeRQ
 DC1ohVHruVuya8b5z2CPtXAFCzpeWMWjPsT1r+61PLXn0WU8f9mU+pslNsC4uHpJQUv/
 D8Cg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NJx3crkiP7kjnDmERtqmkIqN7f6e3+if6VOsi6K11vfCUAFfgIdg6vAE5HC5TaH2q3WJKEUkE8E4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxg1QX8pZyv7EJnfS/96+n3q2okoPmg8/S4q/C6aPICEuSf5t2D
 wBxzMXh5hr5AhVzrL+kFBkdS5uO4AgOt6sdj809LR9ZAwT7wGAzF/8rVe74iCR1g
X-Gm-Gg: Acq92OExC2ZDPkv9IElUOsQxp/sm6gKg5dyjT1XfN44apUXDgwlpeLnryS4YTOJOYyj
 dLM8EPEAA92+NltgdxaMHD8gWX0881U2Gx82R3aaSJ6kQV+k1nS5jwSaUFWcmvZ9iKINX6RuTPv
 7JiRpk8rPXmBFa1aOqg9muH6lQTf2N13b9Ae1R8ynnOP5jGFjnxQW7CfSEloczfyiD/qzSqlLc7
 hCvD85tjH11N5QCViYA8zHNImKsNoquKf6M3pgd8MgkVxkqsFKrT6JUAVHAJ5g3AFNZCFqh5P/b
 Dzt0XAs01YD2CiTGQJ9Ex5L/dkp/Safb9WXqY79gszp7X6UEVNvxdjZJL6Ko3mSErGgymPVoyHJ
 BQhJQ7/AMr56Zf5cLUhP9y5gp4TKECuUFx1XoUruMAJATEZQqWGsODKnLqMqcaQ/7Y7+z8m3VEw
 GLc02FOM713BflOjpRkMRp1WBu5BIqeZit221374V4Kn4w
X-Received: by 2002:a05:600c:4510:b0:489:1c1f:35df with SMTP id
 5b1f17b1804b1-490424a682emr203079855e9.10.1779693408960; 
 Mon, 25 May 2026 00:16:48 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd1780sm26456454f8f.16.2026.05.25.00.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 00:16:48 -0700 (PDT)
Date: Mon, 25 May 2026 10:16:45 +0300
From: Dan Carpenter <error27@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm: zynqmp_dp: Fix uninitialized variable in debugfs()
Message-ID: <ahP3Xagt1LJrhmFl@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

If the *ppos is non-zero then simple_write_to_buffer() will not
initialize the start of the buf[] buffer.  It doesn't really make sense
to allow non-zero values for *ppos, so check for that at the start and
return -EINVAL.

Fixes: 28edaacb821c ("drm: zynqmp_dp: Add debugfs interface for compliance testing")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 7fb11b0a44f0..847179476041 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1888,6 +1888,9 @@ static ssize_t zynqmp_dp_pattern_write(struct file *file,
 	ssize_t ret;
 	int pattern;
 
+	if (*ppos != 0)
+		return -EINVAL;
+
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf,
 				     count);
 	if (ret < 0)
@@ -2028,6 +2031,9 @@ static ssize_t zynqmp_dp_custom_write(struct file *file,
 	ssize_t ret;
 	char buf[sizeof(dp->test.custom)];
 
+	if (*ppos != 0)
+		return -EINVAL;
+
 	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

