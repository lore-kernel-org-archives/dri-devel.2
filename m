Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C475BC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A28F10E3DA;
	Wed, 12 Aug 2026 07:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="yK2Zufb6";
	dkim-atps=neutral
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E169B10E387
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 20:54:47 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaitmazov.com;
 s=key1; t=1786481344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1jdponTtPa9+OLliftj3H7pLIYO+6RYcGejPvhahf5M=;
 b=yK2Zufb67+//DyrLgFB683ZGsP6tZZ41aiq9eVTmADMc5g0EI6QeWWOIWJMZinmOKe6lf5
 57W2N1Pa124lWoeG8UGBNoNQLM9m0wVpU0y4Q89HBBCE6C8B0asL1cKR9RQZtECgPmathJ
 7FJgZ+rTcNBy5//rXAr2mZS2ylk8oXGzrxAHu07emPZnuM5iAUw/GqzfdW+YxMbQZ8TJv+
 iHDnEgUqLZUSjtypPZobFi+JgKV0gIOES/siaPqvV5e9aD8NDHgT9vGgcpyzvkOvwKCVwz
 vx7He5jM1VzyqCPpsdl7VkD3Tr3YErx9wudJPeCMAr08EQsEe259f2Mn/INGHw==
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH] accel/amdxdna: return -EBUSY when turbo mode is refused
Date: Tue, 11 Aug 2026 23:48:42 +0300
Message-ID: <20260811204842.877616-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

aie2_pm_set_mode() refuses to enter POWER_MODE_TURBO while a hardware
context is live, and reports it as -EINVAL. The mode argument is valid;
it is the device state that forbids the transition, which is what -EBUSY
says. Documentation/gpu/drm-uapi.rst describes -EINVAL as the catch-all
for "an invalid argument combination which cannot work", and lists
-EBUSY among the codes whose common meaning applies.

-EINVAL is returned for three distinct conditions on this path: an out
of range mode value and a non-zero reserved field, both in
aie2_set_power_mode(), plus this device-busy case. Userspace cannot tell
them apart, and the natural reading of -EINVAL sends the caller to audit
its arguments rather than to quiesce the device. The driver logs the
real reason, but that reaches the kernel log rather than the caller. The
practical cost is that the refusal reads as "turbo is unsupported on this
part" and the caller settles for POWER_MODE_HIGH, which pins the same
DPM level but leaves clock gating enabled.

-EBUSY is what the driver already returns elsewhere when a valid request
meets a conflicting device state, in aie2_ctx.c for a BO that is already
assigned to a context and in amdxdna_cbuf.c for carveout memory that is
already set up.

The guard covers the transition into turbo, not the state: a request
made while the device is already in turbo returns success before the
check is reached, so a context that starts afterwards does not change the
reported mode.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
Confirmed on npu4 that this guard is what refuses the transition: with a
hardware context live, xrt-smi configure --pmode turbo failed, and with
the device quiesced the same command succeeded. That ran against an
unpatched driver, so it establishes which branch is taken rather than the
errno a caller now sees.

Compile-tested on drm-misc-next (dc2f9f7fe), clang,
CONFIG_DRM_ACCEL_AMDXDNA=m.

 drivers/accel/amdxdna/aie2_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_pm.c b/drivers/accel/amdxdna/aie2_pm.c
index 4fe6030d2..e4f2e9cc7 100644
--- a/drivers/accel/amdxdna/aie2_pm.c
+++ b/drivers/accel/amdxdna/aie2_pm.c
@@ -94,7 +94,7 @@ int aie2_pm_set_mode(struct amdxdna_dev_hdl *ndev, enum amdxdna_power_mode_type
 	case POWER_MODE_TURBO:
 		if (ndev->hwctx_num) {
 			XDNA_ERR(xdna, "Can not set turbo when there is active hwctx");
-			return -EINVAL;
+			return -EBUSY;
 		}
 
 		clk_gating = AIE2_CLK_GATING_DISABLE;
-- 
2.55.0

