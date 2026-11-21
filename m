Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD84606A6AB
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=M4+Yzn2o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE3810E4B9;
	Sat, 21 Nov 2026 00:54:29 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA8810E38A;
 Sat, 21 Nov 2026 00:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795222456; bh=TWvI7VFhPqVoejMoYnNWyolBP0UuGdR6q+jNhmXzHOk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M4+Yzn2ofINAEYTxhBaSZmgM2i92MK6mhDjvQf0zTNMUZHUN8jm3clGLrcfdo4rwS
 PTqQPaUrMTEil0zmQO5n6APk2dykdgBhQmVDZ2SXwLWy7+OmDyUzqdk3sQbTksfVrA
 BsfDInOIkDOwuK+bz8IrNXxu9w8mY5s4rhHQ8MUw=
Received: from ThinkPad-T14 ([42.80.74.187])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id D8985C1C; Sat, 21 Nov 2026 08:54:09 +0800
X-QQ-mid: xmsmtpt1795222454tjrh4y459
Message-ID: <tencent_D44B8524BAF46993C808B9E7EEBB0AEF4C07@qq.com>
X-QQ-XMAILINFO: MfyZhnzsdR6YCsSk8JMpUnDzA04WxXOrrtYiGRv1QzTAZbAm3DjlumyXJuThRv
 +pboSHx7mS2B6A4gqgUvSy/zXhUDB01CLBaZT74CUTaylU1lM3Skk6gEF5q0TcIf3AQEiRctzjUW
 bncsmUiMcqdJPhl4U5HZa/cItfHpuQr8FgRos23f07Nubz8PpHXZF2eC7XmKYdi1tlaAtjK4h3AG
 r6Yij/hWxa/5WIfsndoAAoRCBQIiEnBNrrzA4EuCrOiGmiVlImb4wbkeHK+062n32i8NZsZfnRIU
 Bx3P3ESp3zfI4GYxKOBGmqywFfl84mt3dl+HCmRWS+mHqs+7USzqGV53LLoW3onjjhilfjTgVOUu
 044EyuzvVC1oQc3+gctNhb5ImQNzfF09VUWMp4b3efdoVPUvIqsCJtywzV6z3qlNT9VUGiF2y0rM
 j0d3OQkBVwWRJ6QHWsdKyThc7dZuqvOGSuFBMTns9KjvLJZDex6IJeLxoFteFS8u6w6y+re30+J2
 uw4cRBq4jE0AGx5R2UTNUvtY6n6K97VDDrBeVfayCSNpc/qqNiGECBya+ncZo2x90mWbAWJCNrKN
 xPK5n9Nyax8gVUWePGGr8idjoXl5GO1wdZZB4jE4RqVR7ZE7Xszl13MOAc93+/tFWcBuEQXEH/xR
 BWzoIrsFfbS3rDyGZBjD54Gh8phxjfCRwiS5weWnwhIgyA8tvInmhB86J20NDKkVdeC9hEsMcciG
 veE6xUpP2aSRDhClYeusRc6dlCY32reNivz8/jjN+wHjKfS1zBnRrZLkGadBKr51hrDhcXwJ6wwe
 CSoXc/vNgnQGXDbfIiVZlhskdoshQ8qmaXZo3P7e+02t2JUup7nTyGnjfkf0IItIDw1M2FOe0Pt/
 CMS5wg7/2HbgUtSG2TxDmE1W4J6dfNU/mtIvqDUEpQmAgMzRq8Asw5MEGc635z+4PJYYIq7KdpJE
 LWyRXoWTamEPXhVIdqQq1q4S9FeJOuMrUUAWmo3yBN0Rkb8UNYVQmNBw0QEwYBS3QOE7KHSDRal0
 hikjs3L7YDnezBBnjO4bkf4pLmJn/qYQEZyqCD1Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v3 3/4] drm/i915/display: Check gamut metadata DIP support in
 LSPCON HDR detection
Date: Sat, 21 Nov 2026 08:54:08 +0800
X-OQ-MSGID: <20261121005409.17626-4-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121005409.17626-1-fighters390@qq.com>
References: <20261121005409.17626-1-fighters390@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

intel_lspcon_detect_hdr_capability() asks the LSPCON whether it can do HDR,
but not whether the port can actually transmit the gamut metadata DIP. If
an LSPCON is hooked up to a port without that capability we would advertise
HDR support that cannot be delivered.

Refuse to claim HDR support in that case.

Signed-off-by: Yitian Shao <fighters390@qq.com>
---
 drivers/gpu/drm/i915/display/intel_lspcon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
index 9ceabbc..797137d 100644
--- a/drivers/gpu/drm/i915/display/intel_lspcon.c
+++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
@@ -137,6 +137,11 @@ bool intel_lspcon_detect_hdr_capability(struct intel_digital_port *dig_port)
 	u8 hdr_caps;
 	int ret;
 
+	if (!intel_dp_has_gamut_metadata_dip(&dig_port->base)) {
+		lspcon->hdr_supported = false;
+		return false;
+	}
+
 	ret = drm_dp_dpcd_read(&intel_dp->aux, get_hdr_status_reg(lspcon),
 			       &hdr_caps, 1);
 
-- 
2.53.0

