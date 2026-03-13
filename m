Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5068106FD9E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD31010EB11;
	Fri, 13 Mar 2026 08:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KCvpqIyy";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D13710E441
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 01:53:16 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7d75371d873so1964653a34.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 18:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773366795; x=1773971595; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Je77iCsOrEuw63H4T4mEYukShtJgkZJQLEZYMkoBqT4=;
 b=KCvpqIyylOCpqqTdkCPph5QbuCMofd5Mmn4OOSSTaPiz3xBpv0Tmr0uEIvSZHkpZcF
 csiCpnTDowMVyk3jzgERR3AVjzlZC8+fbpcfsjqYCkFEMSMIUOWGNjVMmhXNtLuDy8ed
 WKRvvH6dlK53SJde4x/uQAoiy+fpnw7svYPLmXqeBQprpD8UyA+prALQ4UqENyWp20km
 o0UEbbY/VnZjxQYcwlVAjSOFv7WNtAEv0lowiac56gv3dOQLLir8ivQeh0N02olB4WVw
 sYssViEWDLIXz8MdZOL9M8+LbMHZYKEOF1FyvyUBeMfU1EfVER4LRzMno/Tr2iL25uyT
 0+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773366795; x=1773971595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Je77iCsOrEuw63H4T4mEYukShtJgkZJQLEZYMkoBqT4=;
 b=kPblu6r9Ltr083DlfHIj/qgti3q97weWH52wObatgNT7822UqNgvxzRrZCI4H0h3/+
 s5ruA17xH688xDwXTIX0ALe+RWYWOipmki+mwx/Wc+mz2ZS2MxSxgPkLYu6eHkj6s1oE
 o/Xf8qaPOMYuw3jrtjrxXWhl5kbnziFFW7LeLXGcV/N2kC0wymVtezgOoSwzn3Zq05md
 xTLzWTpAQDfxGy0KLMRWqOQMFmNqbGxycrut3O/WJQ8XCy6yJUyeTUh5YzeKamY4hcV8
 N4jyPx5I2OiDBXTdIcVMiR1X9uA0fkdi567awj77wX2tut4zLiImQQMtCA6Zr4XwKx2o
 6nSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXMkZRiwr1AwJ/g+bELLunl7UyLrYdFv9PYojtuu2VxxKgqLtVwktmOjgHJkiYKF7iHy3WtjRaPGU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYlRjMEXDfL05JfIkgF13mWzOIlPtEacZklYD74X+m6YSFPUV9
 qf0BSJLdc6v4mjIUAH6TBVmz2EhJ4cUgj23cqaGY3VKaoVtEOCG3kdFZ
X-Gm-Gg: ATEYQzzXYIn62hGHXEiW+lemztsJTg5uHLbGAUwdTP6GvJr0JuC9oyjAGojBEnWmJgu
 1okFIg1lmkRTx5rr6U+WMl/OeOjAM/p25aaQDC1QvKfdfPxiYjukkESG23IKtoQt4waCQnJqJ5K
 5PR6PnPNFfprHQaByR6hOq+J3KsdcwGUR1mCcvRM6XcpIEVyON1z5ke4HyS65BLJ9CKfgErGIKg
 uvh/I9UsmN8Z0o+tq+um9p5uvw5uYg0Z5vx9IpLbx0YwOQlWBBViigOAIJ3yz+re8EnXiiWHPu0
 zwbzVAanCnOMTY/hUOEJij41vg2FeuiBP9QbN2ItEYTMCijzZ/bSUgUCF6I2Q3YOiFlA3NeyEtW
 j4h0OqvYA7r7vLspZUzy7+HMrGNqZ1qvOBfj0sfqfVxZfZwgRobdSNqalKsQjjHmu8cU5bVY3EA
 3RokH/+WyAkJ2vEnCopYpPCFyFchHjktDvXGoiu8mJ/FRAlGxN13elYng/9S3xfHuoXNtK
X-Received: by 2002:a05:6830:4903:b0:7d7:7b6f:d53e with SMTP id
 46e09a7af769-7d782311bc6mr985481a34.0.1773366795315; 
 Thu, 12 Mar 2026 18:53:15 -0700 (PDT)
Received: from Mac (c-76-107-126-43.hsd1.tn.comcast.net. [76.107.126.43])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae68a4bsm5314729a34.19.2026.03.12.18.53.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 18:53:14 -0700 (PDT)
From: David Baum <davidbaum461@gmail.com>
To: alex.deucher@amd.com,
	christian.koenig@amd.com
Cc: lijo.lazar@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 David Baum <davidbaum461@gmail.com>
Subject: [PATCH] drm/amdgpu: switch XGMI sysfs show helpers to sysfs_emit_at()
Date: Thu, 12 Mar 2026 20:52:26 -0500
Message-ID: <20260313015226.39727-1-davidbaum461@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:25:02 +0000
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

The XGMI sysfs show helpers amdgpu_xgmi_show_num_hops() and
amdgpu_xgmi_show_num_links() currently populate the output buffer with
sprintf() and then call sysfs_emit(buf, "%s\n", buf) to append the final
newline.

Convert both helpers to use sysfs_emit_at() while tracking the current
offset. This keeps buffer construction in the sysfs helpers, avoids
feeding the output buffer back into the final formatted write, and
matches the style already used by
amdgpu_xgmi_show_connected_port_num().

Signed-off-by: David Baum <davidbaum461@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 11e56df1d91b..13fc7247fe23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -469,12 +469,12 @@ static ssize_t amdgpu_xgmi_show_num_hops(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
-	int i;
+	int i, offset = 0;
 
 	for (i = 0; i < top->num_nodes; i++)
-		sprintf(buf + 3 * i, "%02x ", top->nodes[i].num_hops);
+		offset += sysfs_emit_at(buf, offset, "%02x ", top->nodes[i].num_hops);
 
-	return sysfs_emit(buf, "%s\n", buf);
+	return offset + sysfs_emit_at(buf, offset, "\n");
 }
 
 static ssize_t amdgpu_xgmi_show_num_links(struct device *dev,
@@ -484,12 +484,12 @@ static ssize_t amdgpu_xgmi_show_num_links(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
-	int i;
+	int i, offset = 0;
 
 	for (i = 0; i < top->num_nodes; i++)
-		sprintf(buf + 3 * i, "%02x ", top->nodes[i].num_links);
+		offset += sysfs_emit_at(buf, offset, "%02x ", top->nodes[i].num_links);
 
-	return sysfs_emit(buf, "%s\n", buf);
+	return offset + sysfs_emit_at(buf, offset, "\n");
 }
 
 static ssize_t amdgpu_xgmi_show_connected_port_num(struct device *dev,
-- 
2.50.1 (Apple Git-155)

