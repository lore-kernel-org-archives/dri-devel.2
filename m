Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315ECC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F9B10E829;
	Mon, 28 Sep 2026 08:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oAo8Fy/Z";
	dkim-atps=neutral
Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com
 [74.125.230.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D7D889E59
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:31:37 +0000 (UTC)
Received: by mail-qk2-f40.google.com with SMTP id
 af79cd13be357-93c5a24e868so70718085a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790440297; x=1791045097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MSWaUNt8N3BGw3JWkfdkKuhOhB5GPof0nwVAxfKx8+0=;
 b=oAo8Fy/ZqmbeRU0AcgfRVrr83VtFbXImTwNrVjJd1RU519Ip3PBGz66FDVaWVk73GT
 Q68xRlbuJ4pSBhjTZZ2+KfyeQWNyTR5wzCQWn3JDsoMgOSbtet8AahfmDYT3X1pZfFuz
 hX7IJG/Qur+lC7iG3UizsZkyVZMtUltlgyfaLCjTWnCkrf8kq2ZCyrwQYDU9Vs+ydJ/n
 lZIIMfkT2mID+Uc5ZDG3mB+2U58U7+fgdLFZBJz+o6HKCc2vQPW0fUP7uWagFMiLWaGf
 8/0s1KmDPJj/dp1yKd4UBbugxUzCPpda356yEgQP9ZEuJCmkn34m3FNviSNfmSJ3PoTh
 S2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790440297; x=1791045097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MSWaUNt8N3BGw3JWkfdkKuhOhB5GPof0nwVAxfKx8+0=;
 b=oi1yUx7Jwj7UDmyCJC5ik9q5X0yXF2Q6HXf/qfdkgZfiJdQs9FsumDfj4JLTnHDXEE
 fM18yR2LTeLcTsg0LU0yy82AhWhdE6jT6dPJYIyTLYzDXdvykCTZobXL1b/YFFicLyni
 QOCHg4T1uoWj/N949wdRtHez3yVj3OkmpSKsHVV1PjoHTN+BDUNzLv/c5qIAEL2HTuw6
 gCoU5DMBOvI5eo6x1bRs/J4pq2iiQSezQqFXKciserXPjtDeDOb+s/ALNkPY+G7sGiVI
 +rutiji8P76UBa/6YsG00KOpk+BoEpeqJSrkY2GdxLKusAbkSd2nU3akIDNJEic8kfuL
 akBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwf/F4WiNMAcmWkFg2TNllim5VAv32jVp/w08eFiT1jf1+NjS1UC2T52ErtaxECPKAct9vPaRTgt8Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nuB5Nc3Ju6qjQcjKBULblrlfR41UiykxuUPPs0ykNftNHmyJFc
 sXyWUPSd/a6r1hgLFJsff/vwRe/8o3r11lrRfvx1QoQbjPYBczxeK474
X-Gm-Gg: AYBFou2RGMEEUX9oLWCfZCh/7a8UM68F0PKDS0uPzK2QBxLWtGgq4zZELVn80HhMO3z
 kDOWj/7auFpHLMJwsxU61h4ec8keOSfP0EzVI2zPRoJfr3igvzErMc7bUC/h3rj/67olHGMjxg4
 hQ8N7w5kxWb6cjjKewWXq0YkpBQatbbsSIMAg1zZ1W5GsqL9vJH3xmCFYql1fJHih+aXUSuJZT5
 Fa+a+06OCRdKfFvH6o4VeJUYa2y6Z/7L73CaTnX+rRaPD7FqYO7pFmFwCPy5Vsqzi6JjJ2407ZY
 WtSUzfodHeeR93Gh0eCDrEplHbRHZtY17nSEpi/jkJSvEkle5FmwbWqOtuVPiitzLzGutAZSzCg
 WLXH4rf1i4qzqJ13ykrk+0pKftfDWKDGLe5UWSa0JWBZQiu4dxx35fn1qQUxKrsmRIFgWSxaiww
 /DBXXcAjVwjC0J+1wxszHKcnsMCACKtjbbtf/TyzmyJvG1ZYvqselZcZ1mmMRQQJNl/9EkyGASH
 fnoqsEuhK53M7CpnSbPkfPA3FDwIHihFGr1q/xTyyw75JE+kiU0TqMcqEw7yDt3CtQ=
X-Received: by 2002:a05:620a:469e:b0:93c:62a9:d5cf with SMTP id
 af79cd13be357-93c62a9d67bmr260766085a.56.1790440296574; 
 Sat, 26 Sep 2026 09:31:36 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:4040:29f7:9600:f571:6178:b590:34a4])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c4fe09037sm341332385a.27.2026.09.26.09.31.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Sep 2026 09:31:35 -0700 (PDT)
From: Dillon Amburgey <dillona@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Dillon Amburgey <dillona@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, christian.koenig@amd.com, krisman@collabora.co.uk,
 noralf@tronnes.org
Subject: [PATCH v3 3/5] drm/qxl: clear the monitor configuration for disabled
 head zero
Date: Sat, 26 Sep 2026 12:31:21 -0400
Message-ID: <20260926163123.39217-4-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260926163123.39217-1-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

Disabling head zero leaves its previous monitor entry intact because
the inactive-head path only clears heads with a nonzero index. With
another head still active, QXL continues publishing the disabled head
as a visible monitor.

Clear head zero using the same path as the other disabled heads.

Fixes: a6d3c4d79822 ("qxl: hook monitors_config updates into crtc, not encoder.")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 51087cacff74..05de8dd3144d 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -350,16 +350,13 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 			qdev->monitors_config->count = i + 1;
 		if (qdev->primary_bo == qdev->dumb_shadow_bo)
 			head.x += qdev->dumb_heads[i].x;
-	} else if (i > 0) {
+	} else {
 		head.width = 0;
 		head.height = 0;
 		head.x = 0;
 		head.y = 0;
 		if (qdev->monitors_config->count == i + 1)
 			qdev->monitors_config->count = i;
-	} else {
-		DRM_DEBUG_KMS("inactive head 0, skip (%s)\n", reason);
-		return;
 	}
 
 	if (head.width  == qdev->monitors_config->heads[i].width  &&
