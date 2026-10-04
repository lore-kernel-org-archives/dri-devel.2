Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD9DCA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9890A10EAA7;
	Sun,  4 Oct 2026 16:48:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="YLCPLDaC";
	dkim-atps=neutral
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com
 [74.125.227.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D275910EAA7
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:48:00 +0000 (UTC)
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-39569e136f9so199500a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1791132480; x=1791737280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KdB1HW0x985FxmlkTK+biNSXAopRw3hFrVwg2D3Jjaw=;
 b=YLCPLDaCAHOaa/HMMqvc2yCxjCAFQ8Df2y9mLuAkqGvG3wrfNG/NKkJ6VKVf7BqW6e
 ooVLC6DntCTb/xD3FCBJ2nN3vfQCDi1AKCCQZ5zzxJ5OmXRVj1+xtIg3OWDvUuzWnwQX
 cNdASQ8cbfMGjmIpyyLli9KIBsRc7s2WcBSAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791132480; x=1791737280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KdB1HW0x985FxmlkTK+biNSXAopRw3hFrVwg2D3Jjaw=;
 b=wv6rklc8LV0AKRhzdhG7Px04AJ15ugfUF6K89hsi55hpkbxPS8Z/b9w2d6g1hxOd4U
 y5406xNdXMOBa4wpZhnCDq4H7KfFa8s7xBXV4QxUMpGX2E/oN7DEwQkwfKfB1yLk/XR3
 nREQEHjkwAXhG/IRE41WVz+evFknbo8+jPPWwDSAwhbIGHuaNubtI3P3/IOjaR6lYMDI
 l9fGy8Wg8nFFE946dOesIQlZ4yWIYrESYPn2vO/ySm1t8kofuYPpNG9ob/+rMnmaohoj
 C3QKpg8fPTWQWESx8827ZUxAKm8SIMZzjIR2chca8XTJ0HtFsVBl8RAYdh/BnaGSXgIH
 0YyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2iNiXUYvi+F5JdGMHckdZwGW77bZaPZMvyNiOj4PNTNC93wa/jtp2XzriR7zDX6XRqEBXIXzlhxA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKHVvpBzxo9DBiP3rcDpgZQ5QkgrgXZgThoDsRXiRQQ0QA9B6q+
 sImrhv0buUbiXS6tFYh9/UalPao6gi1MT9mWMxc1egw4DBd/pzuItTod+Te8L7/TPzs=
X-Gm-Gg: AYBFou2m7Xzm/htduMEcXBXEibiveXFtiJhWb/g3Nh4TKYtedmy6Z4VXtoaVOM3mysh
 ffHQb6nLf9R3sjRAk28eV4S9nDm9UHCaF+nNWMh6CMBGTlrdyrWqHqoVlz8zjXAPe6D3oJjkUZC
 O9Tt+wAJcey7zA8vxEbSZSExrqBwyuEUP5YP3u0PQmF4C065tS5pFbKnDRmS2ftAyVQa61xtGNe
 fQbWyDUUuxAA1BjKplAd8pLskbryHgiUGWauLT6OXqBqUIG2J3HJUkSNXQv6fwmvzGIWyjmEWsP
 Z7/pLvpYRPJ4kEsf12HIooxKlCn14ltiqEzm6YfeZwc9VKUtvifQ/eCAM82NTYycoXRmADo6RbZ
 CK9kzr96AxVZ/GuGoir3vZgDyhYbzyDxEtoRXWsV0pTj0cDNoF9d3D4rDpBCGxo6Xudhcxr2r3n
 epUXgpj0YJXiAox+aMe72MkcRIOX8cH7gXnUUF+3RieSOETdmybH7vxvylGFNYmyhuxR/OvfTz
X-Received: by 2002:a17:90b:514b:b0:3a7:ecab:c4c7 with SMTP id
 98e67ed59e1d1-3a7ecabcd6dmr923970a91.34.1791132480338; 
 Sun, 04 Oct 2026 09:48:00 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6dd0cd76bsm6500454a91.2.2026.10.04.09.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:47:59 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sidong Yang <sidong.yang@furiosa.ai>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/3] accel/rocket: Use an unsigned index to copy the job's
 tasks
Date: Mon,  5 Oct 2026 01:47:26 +0900
Message-ID: <20261004164727.466164-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004164727.466164-1-sidong.yang@furiosa.ai>
References: <20261004164727.466164-1-sidong.yang@furiosa.ai>
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

task_count is a u32 from userspace, but rocket_copy_tasks() walks it
with an int index, which would overflow for counts above INT_MAX. That
is not reachable today, since kvmalloc_objs() rejects any count above
INT_MAX / 16, but use an unsigned index to match the type.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260711063638.61B411F000E9@smtp.kernel.org/
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 319365ad7976..428de5a7cb03 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -78,7 +78,7 @@ rocket_copy_tasks(struct drm_device *dev,
 		return -ENOMEM;
 	}
 
-	for (int i = 0; i < rjob->task_count; i++) {
+	for (unsigned int i = 0; i < rjob->task_count; i++) {
 		struct drm_rocket_task task = {0};
 
 		if (copy_from_user(&task,
-- 
2.53.0

