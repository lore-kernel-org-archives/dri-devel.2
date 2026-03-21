Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3073109446E
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 11:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2743810E262;
	Sat, 21 Mar 2026 11:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="MFmtzOcI";
	dkim-atps=neutral
X-Greylist: delayed 468 seconds by postgrey-1.36 at gabe;
 Sat, 21 Mar 2026 11:06:18 UTC
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D55310E262
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1774091174;
 bh=6q1mA0koXUTg6TBWA7xMsAKd0ETTyN6V8pIWIohANrc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=MFmtzOcI9MuF368rm7knJoI95Nnn+7Y/dCAafVD9ppjFmPFu8R+T41Zl66dHCxy88
 S4a6kGZL3zKVcoW7KZDmD9vexIT6nigt302OvL1nLcvt1cjoLd4eWNHR5m4o2e6xwH
 1tSzjt9NButwfxsXUGyZdO+G3yfgeO0RIcb6ogoY=
X-QQ-mid: esmtpgz14t1774090666tdea662e4
X-QQ-Originating-IP: 8D87eRXUJrMhnxzLjRVEwHZKMsSv2YqjLT/589VuRLA=
Received: from localhost.localdomain ( [116.172.93.199])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 21 Mar 2026 18:57:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9834811083599796826
EX-QQ-RecipientCnt: 15
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: mripard@kernel.org, dave.stevenson@raspberrypi.com, mcanal@igalia.com,
 kernel-list@raspberrypi.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, kexinsun@smail.nju.edu.cn,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: [PATCH] drm/vc4: update outdated comment for renamed
 vc4_crtc_atomic_flush()
Date: Sat, 21 Mar 2026 18:57:43 +0800
Message-Id: <20260321105743.6562-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NTlTHRzUuWSgsD6GjcIPSH3vu1AUJVp7322egipXDI7Bsgc9146o1LsS
 BrJDaDIyYpiZtof21bT1usYkBG1NbeCCwScTdlWtxDPJz0eaCN2CxnXziOm7kQbfVit/OD2
 bUEH8n81fG7Sw2oCXfgztJlRKe/NUo4XPROGpqBzf6UPuhHr/daAx4HjaSnfdGa3e5bCNr8
 mLB3p0fCsRBYTuP7apPjV/pzWSZ1mR37hmVg3j6GSzX5nerkRmrtD/I4zDUV4W/6cauQcBz
 aDTjXHb2veUsZjItqUEI4EVKxATvV/e1qQNAZh7KST7NjKxIUd5JLE7P6vvoy/YJg8tcQSa
 gRdBPDBwA60dYtD6lBgiGGCz+4hy0oHGm3wRjfsyE6oSLBilPUdF9kK6X45tiEWfx8LXUBa
 WeXwXeLrXKf3FHiLzFv0zBezVPzEujD+th/9eb+pJaOpzpXsj9MFfenj90fllm8ON09dlxB
 57FF50GJlclEIiedkeaE9Pg/oqZBEzYw5NxCDK+MD7C5HMc9zm0d4kgegXJ1QB9kVn6n/Zl
 6rIce42eFkJAJVchK/kc0nhmGxHXOz2jvwtUH5dwq3t8Bhx2csPhGUIEg0JRfSOKtatJ2WJ
 w9eGLqR+1tgyrEGtFoBru2fvHb2/9eDH/TLLWaatQCwsgQnJmf4/iZLyO1SIacL3abxa+M8
 NcA0RRbOvcJpzLDjBtPCgrA4CJo9aXmheE6lTcemfgcfsGA2EAQUpsiVlKQgyzBJxLjVkMX
 mNQZGA1p6uETlLMzFcCTbMtDQOXPTiNXpRBJpK5YlbImjSQ9pMLRdSPwEn+8UIbB90uYjFO
 0DgNU1b28R0h4c7AijJODwsaFy6rvqiwHnVXPYiXI6agN3lkYLMa4agsAfL60k4GidBGW7Q
 b2QHgh5DzGhz+AVYiLn9hWb82D+HapFgADL3WfDXw0VCj+fKORdNxREp/swLLmvUFTcsFkC
 +cGncijRNLWDNVAuB53w9yXxMd9m6zAD+QlFfNcY5hQDlZiQmtGjcW5JuwF7WZN2kBGMOxj
 NuJTTuVrP6fIb3mKSERUeEfy8icdpQu8XK1SHJhRrT96Y7tIlZA0+neZOH7188ypEFFdUl4
 Wc7ZxxnCZCYwmz1a0vH+FU=
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

The function vc4_crtc_atomic_flush() was moved and renamed
to vc4_hvs_atomic_flush() by commit 8175287bdd06
("drm/vc4: crtc: Move HVS setup code to the HVS driver").
Update the stale reference in struct vc4_plane_state.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 221d8e01d539..9d4bb6144a42 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -410,7 +410,7 @@ struct vc4_plane_state {
 	u32 lbm_offset;
 
 	/* Offset where the plane's dlist was last stored in the
-	 * hardware at vc4_crtc_atomic_flush() time.
+	 * hardware at vc4_hvs_atomic_flush() time.
 	 */
 	u32 __iomem *hw_dlist;
 
-- 
2.25.1

