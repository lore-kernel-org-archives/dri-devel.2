Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7F0109446E
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 11:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F349010E252;
	Sat, 21 Mar 2026 11:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="ToQxlQ01";
	dkim-atps=neutral
X-Greylist: delayed 370 seconds by postgrey-1.36 at gabe;
 Sat, 21 Mar 2026 11:05:56 UTC
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A21E10E251
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1774091153;
 bh=MOUtJ6/axzF2+QPaYy+xN8l58Mkru+lvFILjciFCmWE=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=ToQxlQ01DcMh+9hcrh4T+cBFDK0THIQpOqpp5cydPTM7hiqqpTC4QHO2YEqH+d5s7
 hA4J3aE8p0CazpgJtrQdm6ac+Ki/R+qhJ6yl4fhbhQX/37iwukChGdaK4SO/YFZuQw
 SOjivIGPi5x016ODYCEn4rghiVGTYx5ETJs5pLwA=
X-QQ-mid: zesmtpgz1t1774090651t3354de08
X-QQ-Originating-IP: tuOZhwxQ6KoXRSJDsnU528AwKqbWypJJ0nWaI7oplL8=
Received: from localhost.localdomain ( [116.172.93.199])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 21 Mar 2026 18:57:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3681975746362421811
EX-QQ-RecipientCnt: 15
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, timur.kristof@gmail.com, tglx@kernel.org,
 mingo@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, kexinsun@smail.nju.edu.cn,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: [PATCH] drm/amdgpu: update outdated comment for renamed
 amdgpu_fence_driver_init()
Date: Sat, 21 Mar 2026 18:57:28 +0800
Message-Id: <20260321105728.6304-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: N41+Pi3tT9xw0gds0PaMUfhIsGKfBwtLYO3KvUJBjJLBudWmCFnS5AQI
 xcSbsgBMfxSAQQCJpAej3danlu5ReEephCVO8lP8q52zHAlCiI7DPBCGEVufywujUvMat98
 zjdWFDVyIJR0pfvrwuRGJTyiuf31Gyg2jOT/WuVYgiYwvZrV0rDEbGO+W6vN7mi8RKkFF23
 ceiuM1rorKH0o1QSKFBcRp/tKbx5WVBXmTgqXGbVXustrSju3+P8ULfpG+4tqforH3j0ZRV
 9w0inem85UUoqgVkYMETWSDe0vL0jp5rmpOrnP3Md+eIyS/Rts5RDhJLCBBv64PsJ/OhSc1
 9fdYwFNHjlhpGuXw5ne8Oik/GcyDzjBBmMtwK4jUODkUccL9Sfio22L0Ce8sw9TbJh5s5JH
 QbEsLVFKfkXE2OxEOPvcCGLzF9uXeC5pe4MvtB0lnTDI8js05PRPW3JUURa1lZDU6pgZz2x
 XKCeCCZlBDnuKpRAzBHo0h0EDB/ELykerX3yHdNCb+CCI8CSIbQ116Mq+bEdRZEuk0Hc0+i
 7JLcaFbWhzPEQHZhiZk02FOuZFQBV3ooh7MHmsIZoMYPCTwM9GIzVWuqB/9/2blRO1gIuqW
 Gs6rFEs4wfPb/euDy1J8VrscRXmatoCYiRQ4NqsPmeY+9HZrnrl5hMjI5qNaXlMMRHxyAEg
 6PePlzRblLeZTrGkuL/uhVBYZvHqNMTq4/Pu3rtlgGUsNrmnDUqk7ufd2nsq+KE5I93tJIF
 qwklXwmenjPPzubkbqVS4/LOamtYaP1lWk3C5Yu0YOOXEGVM/IdMd80jCUgxyS0i2WnyhEE
 FdtRaWF0SOQiYhDJSVD7XQOq/XQYBSrOCNbRywhXKa2sZUCinbGWQV05r22IUkeczvhyCs5
 dSV9RWPbu/7zf0wY/Ph/WL8ldFf2JKRPaqJDEdC1FrMMXIkvKBgE4uatphorZQUykzvb5/N
 Aq/Uyc+lSNP+G6QAom6FKBpgCN4rmpxWjeIqvGbqJPqT/Y+S/plhJuWigg6mRZJVzGKlR8z
 fNzdoh73eL7FkMQA+43jNA3BtsXkwnamOKT4WE01Mo8a8DT1oyTdU+KLOD1NM=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
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

The function amdgpu_fence_driver_init() was renamed to
amdgpu_fence_driver_sw_init() by commit 067f44c8b459
("drm/amdgpu: avoid over-handle of fence driver fini in s3
test (v2)").  Update the stale reference in the
amdgpu_fence_driver_init_ring() kdoc.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 1054d66c54fa..37534f66c755 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -458,7 +458,7 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
  * @ring: ring to init the fence driver on
  *
  * Init the fence driver for the requested ring (all asics).
- * Helper function for amdgpu_fence_driver_init().
+ * Helper function for amdgpu_fence_driver_sw_init().
  */
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring)
 {
-- 
2.25.1

