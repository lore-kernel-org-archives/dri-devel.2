Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F09EC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9C610E9C6;
	Wed, 23 Sep 2026 15:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X2XhgQRb";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A451410E944
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:29:54 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-328664c1479so700819eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790177394; x=1790782194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PN2f2r94Ra//aycP2t8ADfFvH0BcKZKW2u5vtKT3Aco=;
 b=X2XhgQRbA56tfBne8iXq4De/WV5h7fsfmmEfpUPskfVY9HcqVs7+nJI8BVsVN1lQTz
 IOncQwateP2OyzFlorvoA7et3HA2sICcunvEj2/CYFi73uBFXStD2Nl+XnnCuv4T/54w
 d+9nODe04VsTbeLkmd90c0YDkUViSJNdn6lY0zYnegs52NjbJpSgWj5AK6EsrWiRlx4F
 RDZCNpjgP5asB4y7R8sVJJWPee9e2Fqz5UwXs5u/8cILxgbZm2yH2IhqSoXda9cd7lIv
 lMw12tvIZ1vJsW09Rs72eKKJSq1A80hPNUwBDUnRy2JonEbKpavjkjB4TNiKkLOUrNfJ
 WrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790177394; x=1790782194;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PN2f2r94Ra//aycP2t8ADfFvH0BcKZKW2u5vtKT3Aco=;
 b=Wdq2ipX7yyhvA8rGj2A0x5lYAQ77PX8dzN8mxUZY0R4VWKGo7yML48Sovv9UZfodqG
 fwaCmnq2mko2ZRX5F5DPuHe1TZhfY9iTFfopVrJ8gymj8jldRsawTxp8Vc9GcTHIp6Hr
 j3J4bze4knJX2TUp5dkMoE3W5XGeWzKQv9LlvGhFWBfBMjCGQBAG492DYRqVgR5Edn9J
 ynVCOViNlaDigp50r3GmS1Xhb+yN1kunPKul4cuPT/ylOXj2czFJyPtz1UdrmYTVOThR
 jpzlQ9d/5KgwwZXb4zyLn916GyNIspjGm8A3KdFhJD7LZm7QiGKrVwySsl2C3rf+OSTe
 Oemw==
X-Gm-Message-State: AFuF++n9O3jSuXcBLkOeXPLolmJFIYQTx+qpa5i97WBW9oyUZZnqneec
 QwNu+C+W47izr7X+synvMVyX7RaqOT7q2AJO778qlWd+uAnoPk4xB62t
X-Gm-Gg: AYBFou18Ww8xGpnC1HbH5r3Dp3WffK5sziyfALRtQHCPsZER3eLyV6FtSsBQOyym44z
 2AvxKWQg1IV0/xDfoVEIwlPKqMmKo5TZ14e84vCe3PzG+Qm0nBXWhKokFY1rEY2TZy8wP+PIIwn
 JUkB5CAKXGAciahY2GR7l6Llpl2+Ntt5S6al9eWPL+4+XJVPf+/w1CSjhkxrmnvfifKvQp3DZBx
 a1ZBc6DGQV42aQHqEWi6+SA7Jz50fpGAltPtJNp8Gz4YO3rFLRugBkUX2q5FRtrP0YTAvCzZ0Qc
 cp4IWEssmWt39hKTnw1xjqo3xaOSvjOYMiXb1yr6oNONf4Fh7xAlH6RieJlWkQemzyYjgp4YwNX
 nKy9UQV8D4xTRp2nxLEXUI3VbtZxwVa6olUF0L7ajM4FoYJEz5FrVqmaTAN3WEBOvgKI5vA2Ag0
 nP24NVldj1bt+b8m5ZhIJ8shG2wSFACqSOj7nIA25Eug2hc6jM/gOmWUQ0xiGuNVE=
X-Received: by 2002:a05:7301:6187:10b0:33e:c164:b5d7 with SMTP id
 5a478bee46e88-33ec164b694mr2165164eec.3.1790177393626; 
 Wed, 23 Sep 2026 08:29:53 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96d46f48sm14049750eec.23.2026.09.23.08.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:29:53 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] drm/qxl: use correct offset when stamping drawable mm_time
Date: Wed, 23 Sep 2026 12:29:37 -0300
Message-ID: <20260923152941.1297199-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923145018.1244740-1-qwe.aldo@gmail.com>
References: <20260923145018.1244740-1-qwe.aldo@gmail.com>
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

qxl_process_single_command() maps the page containing the current
release slot and copies the userspace command into it at the
release_offset within the page:

    fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo,
                (release->release_offset & PAGE_MASK));
    copy_from_user(..., fb_cmd + sizeof(union qxl_release_info) +
                   (release->release_offset & ~PAGE_MASK), ...);

However, the subsequent mm_time stamp casts the page-start pointer
directly:

    struct qxl_drawable *draw = fb_cmd;

This writes mm_time at the page start rather than into the drawable
that was just copied. The drawable begins at the page-relative
release_offset (struct qxl_drawable embeds the release_info header
as its first member, so no additional sizeof skip is needed for the
struct pointer).

Apply the page-relative offset so mm_time lands in the right place.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: drop the sizeof(union qxl_release_info) term — qxl_drawable
    embeds release_info as its first member, so the struct pointer
    only needs the page-relative offset (found by Sashiko AI review).

 drivers/gpu/drm/qxl/qxl_ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 591b026..65e9bfd 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -188,7 +188,8 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 		 u64_to_user_ptr(cmd->command), cmd->command_size);
 
 	{
-		struct qxl_drawable *draw = fb_cmd;
+		struct qxl_drawable *draw = (void *)fb_cmd +
+			(release->release_offset & ~PAGE_MASK);
 
 		draw->mm_time = qdev->rom->mm_clock;
 	}
-- 
2.43.0
