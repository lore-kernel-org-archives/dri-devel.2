Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1567E99040
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE6710E8A2;
	Fri, 10 Apr 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AK/rnm81";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9640210E88D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 01:39:26 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8c70b5594f4so149835785a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 18:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775785165; x=1776389965; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LbmLmSM6DVlP3rK+1kHNDWZ++XMdSOh/sxx/yDae12E=;
 b=AK/rnm81v8dttPxSIXhaaf2Rs92xCicD4JXzKFA14up4ZA8CjMU0rA6h8ML0htceaU
 Wra251mNBfVTl+VpJ3gsSsWhmnyRyo9x/0z2ml8jfGigTbuyIQviPeDVpHjBtX+rbj9H
 JDgUSqq/cnQ37n+/7oNQJc89omr784IkOUEfTW0LHx1YcY4PXV09rLBpJGzXmRJQW1w1
 lzjwAxAQv/SDPdHhSVNH3sMe7EEDv1bnvHcBCJ2S3IquRrKP0hYlKFrx/1RMsw8dlITA
 n3ipDlgPoXiLlUgBDtBRnzfMlUQlGicdZy/rzKAYFriA3F2u9lgE+B+2mDRkC4d22jt+
 VGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775785165; x=1776389965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbmLmSM6DVlP3rK+1kHNDWZ++XMdSOh/sxx/yDae12E=;
 b=IJdHQOqP9iJdetye/jKoAh0FGUe3X4plLbbR1l0yBKgbuMMgAkkNSnyIAoAi7vbpiL
 qvSw1cp0xfp1ro6rThz6kL5LdcbGUCabz0RIeJYYj7p/S/cbDSy+pYFPKJfCyAnc3HBF
 3j6cW15bK/SgVKGcS3u79i+8ax/aIEe12pms/Vfe/cI/6BScY4gHDFp163r+ufFR/5p/
 nEuLANs7TTAg7NPCH68TeQKgM0Qunw5XTQtyUAMk9DgfihcNZ+RJTzmxbUlHslxZzcjP
 zlqMWGPcNugNqZX/TseRsI+XO98bSMoZz0OEE7X4+fNsqZvNZW3lc6xohmOshxFxk28O
 Jhog==
X-Gm-Message-State: AOJu0YxCxhwf4OtHeCAgfdPKNVgJVX9dOit0VACyKhKKSkl1a4Qx0kx9
 4Ll+THJorKivU55IVa3m6+5/E+tCtZK9faIGL1P5yku5THyonXc8rOv2wmw6sJFFbNaUtA==
X-Gm-Gg: AeBDievO2mcW8I5GeUpfP+LL01h2hrLNGAx4aM8HMuAjWJR+lnvq4PBVoA8K1/Gj4Lo
 3f3BRmW5q4IYfjGLxhkr2NAjGEhbw4i8nuoO8ywG6DpCwkrgIL8vWm9ch2dbxN2GwkGK5tDdLf8
 pHq+b3ip/+IEqFujfoS8NIkMtw+zcmR6Dd26Rfq1b5XB4owalODsmcZgoTx57kqSyfVkqeOVj7c
 DsUjpqJVvrPw7fLfGHL8BnwfJeW2MTe877NG9i2DTVunIo6FFPInbfoGQpG3FKyPfP5Zv7y2N3s
 axugB8SoO8zyHPYk+VOnpLcdvpIhzp+hGejR67QnO7oWut4AWnKSGrs2W4Jf7Eg3V2XcfXleNP/
 1bFNBGbBHloy6R1eIjNXIFAcn/ljfAMhHUHfjDCDV+GHTU+ck0HM9v4iJSERnYIvwy+wQUDjS66
 eqe0Mmi2kzUToin6m2x1VfUfd9IBSoPSPsXsSSN1/i6NYuDWBYNflAV/q+iNdn410gAP3JPluiG
 pncg128A5FGaAN+gWXoTp3WfUgeojv4EKsGs/8=
X-Received: by 2002:a05:620a:254f:b0:8cf:de26:91e2 with SMTP id
 af79cd13be357-8ddd03a2c5cmr148941085a.16.1775785165305; 
 Thu, 09 Apr 2026 18:39:25 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb6949954sm98525285a.21.2026.04.09.18.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 18:39:24 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: mcanal@igalia.com, itoral@igalia.com, stable@vger.kernel.org,
 Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] drm/v3d: Limit ioctl extension chain depth to prevent
 infinite loop
Date: Fri, 10 Apr 2026 01:39:07 +0000
Message-Id: <20260410013907.2404175-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:06:48 +0000
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

v3d_get_extensions() walks a userspace-provided singly-linked list of
ioctl extensions without any bound on the chain length.  A local user
can craft a self-referential extension (ext->next == &ext) with zero
in_sync_count and out_sync_count, which bypasses the existing duplicate-
extension guard:

    if (se->in_sync_count || se->out_sync_count)
            return -EINVAL;

The guard never fires because v3d_get_multisync_post_deps() returns
immediately when count is zero, leaving both fields at zero on every
iteration.  The result is an infinite loop in kernel context, blocking
the calling thread and pegging a CPU core indefinitely.

Both i915 (stackdepth = 512) and xe (MAX_USER_EXTENSIONS = 16) impose
an explicit depth limit on the same pattern.  Apply the same defence to
V3D by capping the walk at 16 extensions.

Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 18f2bf1fe..491eeb6b3 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -802,12 +802,18 @@ v3d_get_extensions(struct drm_file *file_priv,
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
 	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct drm_v3d_extension __user *user_ext;
+	unsigned int ext_count = 0;
 	int ret;
 
 	user_ext = u64_to_user_ptr(ext_handles);
 	while (user_ext) {
 		struct drm_v3d_extension ext;
 
+		if (ext_count++ >= 16) {
+			drm_dbg(&v3d->drm, "Too many V3D ioctl extensions\n");
+			return -E2BIG;
+		}
+
 		if (copy_from_user(&ext, user_ext, sizeof(ext))) {
 			drm_dbg(&v3d->drm, "Failed to copy submit extension\n");
 			return -EFAULT;
-- 
2.34.1

