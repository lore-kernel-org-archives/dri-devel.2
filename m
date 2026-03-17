Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28151FCD0DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D4C10E748;
	Wed, 18 Mar 2026 08:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I2gXa++t";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C201610E1B9
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 19:00:47 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-35a1d4a095bso127800a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773774047; x=1774378847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5pUoPYvzvdY/i+3VyCKmXdQJFa9RgqmeQepWrHmR+w=;
 b=I2gXa++t1BbszbhmMQv4hFVcP6r+PL/rryMMDT1X8IFx6bFjeroNKkYJ3sNxovPQ3T
 0538Np60Q1KGSrQfYgV6cbSG442RbaLwXkI+CWZzxy4wZfB2HWNFnGBXpg67xD35ZhEN
 jjOA3JwsZu20JZgT30e5y9PZU6WlMINkClmvD6GM3NgiVOzYutru5mhXsLDTTnM9caI/
 mSostH9WauluE1sMUDZYWE5frzuBo+v7aXgaU3P55Ie8aaOKer+sLRF0vmuHNtq7lOaW
 ZK3zJ3hrzuMB3BSejca3Ly1EGUNJTMmJsixVSRRS2bYufPAhqx1XWF38kU/RTMdPFyN0
 StUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774047; x=1774378847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G5pUoPYvzvdY/i+3VyCKmXdQJFa9RgqmeQepWrHmR+w=;
 b=rkeV4brTwQWKrYI+4BEdDKOocvQcnjnSRqDSNpt8yAzYD1fxvsxzHDa23GuDpm3nSD
 aVDI8qGkdZ8njiiZuHtNJptNiJpqTC+yztTh4YVzvcXjzFiwj2atNY2tNwYNAliaTAsq
 zIn9fqlCBrFaZGN14kHyrcLwkeOEiYvanrQSRHyuBoITnHz9EHR7VybmEaKFaGOIh6HM
 YP9Zq78/DM188YuTFG6GmCWSfaI1BxRqad2gW/4tkN6Q4fn/bWevjyBqu5BL51OAcDWJ
 LJIIrD597yVDw1QjC7DMiTF/dYQ0Zxpos1NqEqkmcLw/O/+KCmgqaBT+pbTCf5RYWeyt
 0ptQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5T735KxuVTqMdhIG7JA7mpF6UKgmv7Lic5Tz4jFW61aB4I5D1ZYM8LqQsX5hEcpt+uuQHMT2dJyQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXg7Hfpp6VLnp7LaKQqPCPaDR2rTLfVZTkhCzN3h5D9UbdvNpo
 uSjHZvicyle9F1spmt4nonr7/VsAQ2fgo7CkMEirIAkTbE9JhIr61+wY
X-Gm-Gg: ATEYQzyFOsLs5JupDCZ2jVSgKPK7m4qvz6FbQsuWkOBEECAxWYIkEM89xJ75bJKJGiX
 MX/eeyUl12kR1b2QnX2UcKDKADwumcT9D0L/oIqVR1npIBPXhPSz9tBWMq0fmneyMgMfZI00f0D
 yGDl+FseOZjjmqreEvPsxSUbC/mokyib06wJGSHjf+sdxTMvBFA0VKsXjwycOixT5QU1XhWy/oy
 PjLDnl8s9IMT/WkeyvKejwBisQSXQvFaiaHZwdbfgUPOVG8xlLY9CfNgK62pl7GEOjFcwzwnDS8
 wlNbxvowZkSFyBCorrX0hJV54yR8Rk9ZN7CDkwx5o6uVVb5Th832bUAFNgMi3PQKpu7pOaqgjeE
 0XtIwaBMb71eJIJesVpwRf173U29ckqGfWFr4H+sEqMUvJm2UIZwk9EXztExG8uGP+tqZBtyoYz
 VYI2TV5h/K7aP5jjW8+0ncpRpw2EDXwewTnxj9mfci93FirM0nxxEURKuuG2X/th1CuvDiL2FZw
 jjj3coOM7YnV8QXg/JRfnKB0xrwwI6zMTRKAL5qNUSPbCR6QwxAtayIeRt3ldPD5bQYDg==
X-Received: by 2002:a17:90b:3a47:b0:35b:9f51:a755 with SMTP id
 98e67ed59e1d1-35badc14391mr3481930a91.18.1773774047144; 
 Tue, 17 Mar 2026 12:00:47 -0700 (PDT)
Received: from 2045D.localdomain (76.sub-72-110-123.myvzw.com. [72.110.123.76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5a2c60sm196240a91.9.2026.03.17.12.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:00:46 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: gregkh@linuxfoundation.org,
	dakr@kernel.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
 akaieurus@gmail.com, me@ziyao.cc, Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH 2/4] debugfs: fix placement of EXPORT_SYMBOL_GPL for
 debugfs_create_str()
Date: Wed, 18 Mar 2026 02:59:11 +0800
Message-ID: <20260317185920.43387-3-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317185920.43387-1-hanguidong02@gmail.com>
References: <20260317185920.43387-1-hanguidong02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

The EXPORT_SYMBOL_GPL() for debugfs_create_str was placed incorrectly
away from the function definition. Move it immediately below the
debugfs_create_str() function where it belongs.

Fixes: d60b59b96795 ("debugfs: Export debugfs_create_str symbol")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 fs/debugfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index a941d73251b0..edd6aafbfbaa 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1047,7 +1047,6 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(debugfs_create_str);
 
 static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
 				      size_t count, loff_t *ppos)
@@ -1142,6 +1141,7 @@ void debugfs_create_str(const char *name, umode_t mode,
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
 				   &fops_str_ro, &fops_str_wo);
 }
+EXPORT_SYMBOL_GPL(debugfs_create_str);
 
 static ssize_t read_file_blob(struct file *file, char __user *user_buf,
 			      size_t count, loff_t *ppos)
-- 
2.43.0

