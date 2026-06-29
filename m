Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7A9C43638
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B9E10EB4C;
	Tue, 30 Jun 2026 07:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EmUNDOPm";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C4110E0C5
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:07:17 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30c591fb1cbso5387073eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782745637; x=1783350437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nBucK9BctEyorzwpXgdpAjl0JFGTNYaAkDM1NigzWIU=;
 b=EmUNDOPmmAAOf/FvO2J5ouTtp09o+3NhN51xu30je2k/ufTIpuQRl+6K6zn0VSXlqa
 na5/M7CKE6ew2b5x2ZT6fDD1h8e+AY80uI/zb6kf+q9IxhNO0U1ioH3+uKpEZtWJHF9h
 nPyKq7guEpnOsPwPyORiE+2ux/B/0D62xVl07Yt1FBVmo1ASH4BcFGL50heDnJiHHZ+D
 R4p0bPvwIyKnHaEN3tfyVsMRNhwm23cRVmpDGrJ533l9wGs8EcyOjprYKsEMzswhZcXI
 rDGtUlx4ZaDiqtUJsl2dvy4W9RmoZJlM5/3kMZFa8UYCZyjGOLwi3Qll+x/sQXT/peT0
 GJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782745637; x=1783350437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBucK9BctEyorzwpXgdpAjl0JFGTNYaAkDM1NigzWIU=;
 b=LXrL+q+sMi9Tg9faxXMm5cESlMZAGKl5MlVf/6D11QnT/vnTEYz6cQpJzoBXHv6DS0
 Bau/CmnpI5I0MTxxOeOJPILz34yPXth625EwE2g8uzAkKkmffXh2R26Q1JIPLsOK2Aa1
 18IDYJJh2otZaZFbXt5ugWU8rh1sZ7T4+d+EJ30+1RWt7uEQ3iCp8hBP8Pv2ENDN8EZl
 PFryxTEB4TJWBjybdonzyWPjymihuKa7Y0/ZXvfUCMYDxUZVaCtKc4xEqsW1iGQWVbrd
 7HAX+tBjIggJTNUnbsVR5sH8wigcoUPBB6vcTWSjlLNut4OMt/FXBMSm+Z6oIrCGr3R8
 SNtg==
X-Gm-Message-State: AOJu0Yw/BGoSYCHL6mTnv2QeH4CTwjHiDhluWh8T1/UX8A/p7B2yo77m
 hwAqYERVTdJpRDTaAU9qEs5HKgfxDpuen1L9Dq1bLxKJLsvBOatFhQ+r
X-Gm-Gg: AfdE7cmqUzZmodFw0SIRTx5oWj5Sps4sjyUn1ZFQ6UlqmmdhFvyCxN3/TsXVh8P7qnH
 tSw2eVO7DSSGzuW5c7ptRnewYdqoQCsU0NALbZihFqSeecoFPbPkeLpp4MgpoHjjBkQW77jnVE2
 uQl7Zs/eefujB4Q4mruYoRE04mVZ2cggntkAM1cUGd8ZtINpIPk44iTen0RF8PlbGIQ6jKTv6Di
 TsRJUByZE1zfUcWYgwHIhyGEkJd/eRq+ODsU+V3RjLFT7kxVKqY660Z8LYLzVmhGMzB3El/wm9e
 MKpOyBR7vWEzrNzckKD2nZRWmhwXMyPAcEvFc8bw5SeAaCx8ueL0BpQJTVfWTci0sEG0vKD8QhW
 RVSflUaIk36Tew6Wovyg0/zsAb0+2VIZDlvKrU5PLiTQCouX70etawLfUYpO00+ccyjp4Qdju2r
 9W+zeZlXHCQTUbSEh5LzO5mheZwRA=
X-Received: by 2002:a05:7301:3807:b0:30b:ed93:5cdc with SMTP id
 5a478bee46e88-30c84df4aa2mr14269685eec.31.1782745636954; 
 Mon, 29 Jun 2026 08:07:16 -0700 (PDT)
Received: from evo.www.tendawifi.com ([103.98.7.180])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ec79d4746sm14838131eec.13.2026.06.29.08.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:07:16 -0700 (PDT)
From: Archit More <architmore303@gmail.com>
To: lizhi.hou@amd.com,
	mamin506@gmail.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Archit More <architmore303@gmail.com>
Subject: [RFC PATCH] accel/amdxdna: Replace sprintf() with sysfs_emit() in
 sysfs show functions
Date: Mon, 29 Jun 2026 20:37:03 +0530
Message-Id: <20260629150703.71734-1-architmore303@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

Documentation/filesystems/sysfs.rst recommends using sysfs_emit()
instead of sprintf() in sysfs show() callbacks.

Replace the remaining sprintf() calls in amdxdna_sysfs.c with
sysfs_emit(). There is no functional change.

Signed-off-by: Archit More <architmore303@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_sysfs.c b/drivers/accel/amdxdna/amdxdna_sysfs.c
index d9e359ee8182..8b4749e6c380 100644
--- a/drivers/accel/amdxdna/amdxdna_sysfs.c
+++ b/drivers/accel/amdxdna/amdxdna_sysfs.c
@@ -18,9 +18,9 @@ static ssize_t vbnv_show(struct device *dev, struct device_attribute *attr, char
 	struct amdxdna_dev *xdna = dev_get_drvdata(dev);
 
 	if (!xdna->vbnv)
-		return sprintf(buf, "\n");
+		return sysfs_emit(buf, "\n");
 
-	return sprintf(buf, "%s\n", xdna->vbnv);
+	return sysfs_emit(buf, "%s\n", xdna->vbnv);
 }
 static DEVICE_ATTR_RO(vbnv);
 
@@ -28,7 +28,7 @@ static ssize_t device_type_show(struct device *dev, struct device_attribute *att
 {
 	struct amdxdna_dev *xdna = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", xdna->dev_info->device_type);
+	return sysfs_emit(buf, "%d\n", xdna->dev_info->device_type);
 }
 static DEVICE_ATTR_RO(device_type);
 
@@ -36,7 +36,7 @@ static ssize_t fw_version_show(struct device *dev, struct device_attribute *attr
 {
 	struct amdxdna_dev *xdna = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d.%d.%d.%d\n", xdna->fw_ver.major,
+	return sysfs_emit(buf, "%d.%d.%d.%d\n", xdna->fw_ver.major,
 		       xdna->fw_ver.minor, xdna->fw_ver.sub,
 		       xdna->fw_ver.build);
 }
-- 
2.34.1

