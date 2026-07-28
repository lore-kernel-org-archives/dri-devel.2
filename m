Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611DFC54F53
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E4210E7E9;
	Tue, 28 Jul 2026 07:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="JNI2Wuwt";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C9510E358
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 01:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1785200737;
 bh=abrj0YhkjdX5tIEw1QYlhdxieuLgqQ+aot0tju4kSGo=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=JNI2WuwtuIBzEoKe9qh4X4evFWllqWx6ySLc+Um73cA0whw54D40RFj0PlXxzqPOd
 1hx7drZbbbWkbvCmdreTsTBMDg0DAT9w1/IfZFpRJ0pHucmDuvJI0MxO9I9iSiWrk0
 E3i6haleN0oOEPbuMVy4QoRXr7MZUOtK4LwJ0k7A=
X-QQ-mid: esmtpsz20t1785200729t3d4b9290
X-QQ-Originating-IP: a2tKt8NaLB4fW8LMxzOmxD7eLoRxrdnEhFFebeT55yw=
Received: from snode5.. ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 28 Jul 2026 09:05:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17787826967055244228
From: Sterling-Ash <liangbaihui@linux.spacemit.com>
To: Frank Binns <frank.binns@imgtec.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
Subject: [PATCH v3 2/2] drm/imagination: allow probe when no power-domains are
 described
Date: Tue, 28 Jul 2026 09:05:13 +0800
Message-Id: <20260728010513.1627950-3-liangbaihui@linux.spacemit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728010513.1627950-1-liangbaihui@linux.spacemit.com>
References: <75c9382d2bda766aa459b00321153d715254d1a4.camel@imgtec.com>
 <20260728010513.1627950-1-liangbaihui@linux.spacemit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NAtipnnbTPeaCe3+ePoEXunKLK732IY2Mx39vHQruFW1ZY1NJW5TTLgu
 ZO6zVyaZryJEzz1eXOFHlfs43NYKhUHSovd/2td74GNOR4Wg8HCTwbVb3dQYuz3i9FVQC8T
 NXXKoM/MLapVNNIjG17WcIb+Yc3vXVPWqIogFcb0+z61n1hLiUraG7aE7X4qIaTqVmXMSxl
 QYmkNSjv694jVqQyFlqtb1ajpilqdcQ84Gvd8VWeLeMjVpNKZJXJX8BKkOX7mhyiuQOAa41
 7Jy4AF1Eolly4CKuCjBY32V8zElFV8Ewra8iYG7q763ArejUEoDWKSzroi/tkNO/Tyy7CRk
 R0derfZfqBSQAOY5uXwmd84mwopOZiJ/5U+0q+nD8F4ZGR8FbJmN+069Bxr4UHxLIh93P6Q
 Dp8FjEpj1F7wxRdgsJegooTAMj+w/cpQeHZhvaxpZYnbRJ+s0oEjp99w7HcXJxW/lOJv+CY
 44ojXGeqoq6lsZynU4HVmbxzYTJHXK8JtN+5vVhvXuDGmZBu5fw11wB/eerdthLJcqeFcan
 mn5U9RI3W4oTPtD9qbvx3izCfIaza69eOP7EPe3XlvTetRnijyLK8/uHP9u/cZ1Nsnv8Rez
 F5h19eFIbSKt+q1lQU3XQn2ZUWz5bjCZUWBS1boZdyjSyIr/paoZaxaaugxPSv4YIIkebfB
 Mf0u8mrKNiDnO0Kbov+B85i43jZP5HdUhPGqUvbCzopS7m6dqCw+bzqxoG5OpWpdYQDFbdp
 chVLEbvHyPMQ/YLt245Ky1UUlXYIB0czREA3rd1ewZxkmY2jc+EzPdw10oOtRoF3210pXq+
 YbgDrRlsQh/31uuslbbTdpLpfCxzxp1+w3RVLwe3+LhBFIfTUSeVX1PRqTlkoetAgS8iNVU
 /hL2yKqftGbJ2/NfQbh8/JuXaI/cIkvaEA1v5lpVLAjA3p7rLwGkULU160SvhnkaAbkISDl
 RWewezgbRqwyLw8BTgxemW/fWYb3B+/0iBP9sKINjjK6sc82OMONGG85dZ+UA7lhRGnEWcZ
 nmsf+qWQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

pvr_power_domains_init() currently fails probe with -ENOENT when the
device tree node has no "power-domains" property. On some platforms
(e.g. SpacemiT K3) the GPU power domain is brought up by the bootloader
and is not modeled or managed by Linux, so there is legitimately no
power-domains phandle to attach.

Treat a missing "power-domains" property as "nothing to attach" and
continue probing, rather than failing.

Signed-off-by: Sterling-Ash <liangbaihui@linux.spacemit.com>
---
 drivers/gpu/drm/imagination/pvr_power.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index a71d5b35601e..5751e2d814b0 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -635,6 +635,15 @@ int pvr_power_domains_init(struct pvr_device *pvr_dev)
 
 	domain_count = of_count_phandle_with_args(dev->of_node, "power-domains",
 						  "#power-domain-cells");
+	if (domain_count == -ENOENT) {
+		/*
+		 * No "power-domains" property in the device tree: the platform
+		 * handles power domains transparently or at the firmware/bootloader level,
+		 * so there is no domain to attach. Treat this as non-fatal.
+		 */
+		err = 0;
+		goto out;
+	}
 	if (domain_count < 0) {
 		err = domain_count;
 		goto out;
-- 
2.34.1

