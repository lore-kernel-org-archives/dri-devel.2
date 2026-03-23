Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD21EC01A2
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B69610E405;
	Mon, 23 Mar 2026 08:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d5NPfAF5";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9556610E2CF
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 02:29:31 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso29473915e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 19:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774232970; x=1774837770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H3kcwe+PV/doDEJ/bCveOaUQOJAnBkt6ej5mjuZP5KE=;
 b=d5NPfAF5uQ2OkK3jk2ZaQWpnPkQXBC8iWCIaeh3HPLXh11manKxGqQM2lRiek5Zwlv
 2ravd7rQmGeQb4cGbjHQkYPaOlN1EpcpRuH2mtBoiKYKefbnt5rCRcVftaGgLC74frC8
 o3/x/RSEZxjyJw8DLVsztbbI2rXTfeOBEzLjK7Sh7RxpwMbfUu0r8lX3nVySPvpuy/2t
 dbTQ5igi2xrSVqM5jLsCasnf8TNMIHYcYbtVS52N8anpAwLlFhU3QVsKs+bUFA/tOu7V
 bOjoQYpMBcq0Dlrw6AgPmlRBvxsviEEmlxLrH6otHWd1lj5wOC04rzkLMQ+7DtalxRKK
 8EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774232970; x=1774837770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3kcwe+PV/doDEJ/bCveOaUQOJAnBkt6ej5mjuZP5KE=;
 b=asxlGqPs0QzQU+0FeA+jroPVEXd4LkGY5LhFYcUa8LSHGdtsAhdvDeicNKxIBtvGpC
 aAZFsJznAaTjRNc37hm6lbgGc+kWVKmo4N4uuaIXINkHxfn/Z0cjhogowkROdi6OME/T
 26MzumiPWe73U76Eacs17x3L8snT1orHrwXLHyQrxcvNvOCWdhzQ4VScS9EfaimSucDQ
 2rFnuvfagtaTX7ySDcQAOb1V1sZd0HuipbzZLziofnXTkTBzmsDt8xBm9IZwyI9HJlEO
 ZJ06H5MZQCIcQJRtJOK464My3q3oUqzuLH9bGBNXf5k9R+YN6ovC1wH1Q5/U/g2KC2uz
 dXVg==
X-Gm-Message-State: AOJu0YxC3hdjy3psYXdxzFPDxDZSZZyoJCoNQ7hLyB/DG+ZqFaH3MgWi
 YtQV6oigwhFd8TCuFJU00FgM7hkJFcPy8VTSTs26NKh5Oq4zVLe1oS5A
X-Gm-Gg: ATEYQzx9khePXrJyPaHGoj8DjI/QzvsvGBXtUHCF24CFH5cyetcC4Oy3eO+C9Rs/iIZ
 eeL+SMITqNLk0jn6i02ij3u1nWgy9dNXokP6dehn+xDnEMBEsUKUENyifpU1kU6u0CM8ieMNf+h
 5uRaTr95+YZ14qZmYjL6oGKsO1u8d09A1+3nDv895epmLLa4XLVI11LyXSY1rrMHntWGnUMfRjv
 1Jcg/VByYW6TJYL/H98chqA7EnuXfLDJRT7X4tvfnQzUfc1lvmKyR+VMVjP/nwfMPTEvZsdDfZE
 B6rY+ThfHjoK9g+6tGcrFCN/3LBENe08D/wlSGCyzvq9j1bP/r58razhzwVkcJSwstG1mHhwJW+
 KdnnmNbIwbj7Dk1Ee5mXJjImjagUTZi8fZEiDPBw2JJzqSh08faxQHSQiYIAwe2CBOywwwL6gq0
 ZbFEGA44wEtcUHZuMwSX3BLTPd8yvwUkFI8FrVWnlB2tsMcr4dzUEbYYwoh0c8P1SL
X-Received: by 2002:a05:600c:8215:b0:485:4388:348b with SMTP id
 5b1f17b1804b1-486feb5a3camr139943455e9.0.1774232969794; 
 Sun, 22 Mar 2026 19:29:29 -0700 (PDT)
Received: from localhost.localdomain ([95.8.227.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8ba4a74sm311108975e9.12.2026.03.22.19.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 19:29:29 -0700 (PDT)
From: Onat Baker <onatbaker@gmail.com>
To: Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Onat Baker <onatbaker@gmail.com>
Subject: [PATCH] drm/accel: remove unnecessary cast in accel_name_info()
Date: Mon, 23 Mar 2026 05:29:06 +0300
Message-ID: <20260323022906.13615-1-onatbaker@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:11:26 +0000
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

m->private is a void pointer and does not need to be cast to
struct drm_info_node * in C. Remove the unnecessary cast.

Signed-off-by: Onat Baker <onatbaker@gmail.com>
---
 drivers/accel/drm_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index ca3357acd127..8cb359df13cf 100644
--- a/drivers/accel/drm_accel.c
+++ b/drivers/accel/drm_accel.c
@@ -46,7 +46,7 @@ static void accel_sysfs_destroy(void)
 
 static int accel_name_info(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
+	struct drm_info_node *node = m->private;
 	struct drm_minor *minor = node->minor;
 	struct drm_device *dev = minor->dev;
 	struct drm_master *master;
-- 
2.47.3

