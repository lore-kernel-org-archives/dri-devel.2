Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB1FC5DF69
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826CC10E04A;
	Fri, 14 Aug 2026 02:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="BxlejEfZ";
	dkim-atps=neutral
X-Greylist: delayed 154501 seconds by postgrey-1.36 at gabe;
 Fri, 14 Aug 2026 02:25:54 UTC
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F21410E4E5
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1786674335;
 bh=zwIQVsJa3bKVMiFSZ+kPNaDWDdjE00ekRDJBwDGVRHQ=;
 h=From:To:Subject:Date:Message-Id;
 b=BxlejEfZpiHpBD13kqh95waqcwroRvlN0Hz1hOeuKkIcVmMrDR4MEM8Gg+89e1M5L
 W/2fmz4MobI9hEItALRdKp2gKr4EKO4t4+o9Z6jFpS9r+Ty7P27NFtMhMhfhEqpmb9
 iaIBy3TykWCxqFPZXDe1HYoRzVkY0QGSNHKf2Xok=
X-QQ-mid: esmtpgz13t1786674326tbdf7c49c
X-QQ-Originating-IP: b3yIyDj93Zk6Fw5hzBP5dySljjYsCy8cXF5fAZrH/yE=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 14 Aug 2026 10:25:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7240023971590159997
From: Chaoyi Chen <kernel@airkyi.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 4/4] MAINTAINERS: accel/rocket: Add rockchip mail list for
 rocket
Date: Fri, 14 Aug 2026 10:24:53 +0800
Message-Id: <20260814022453.437-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260814022453.437-1-kernel@airkyi.com>
References: <20260814022453.437-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OE1h366RMh4bPIWp9FHW6/AyL21r43hkn7NAzLdL/UoB/ZlYxeaJpgBe
 jsmaXS+sgNe0JQ+ktXJK+DapnfYapIM8J7P5e3OPctWLYAti++KpBE6pJb7kl3tXGQAhiVf
 zhYkFdXNLhvWJTHYq+68z/DTy+R9Jqh2KTouquLFmP23/uJVu5dmlx5O/HV/IpcnQk3B1F6
 hPwpYHjYHciJeCbGnKQrBZBLIC0OobpUjU8GWHsGW+1SVUuGbVBxCT5l75s6DUwjitXgm4r
 DyRRGtTQ+jYvmfld5drhgavFWEnnLIPaL2pn6GUzZjuO8mmOKJNYyv/8jLB7o3jDN2/VyWD
 vM6IFkYmt9/Mbei0dOwwzbtYTL7tRS22NLKbJ71q+sRiz5OHAExzzFeBTqtPOsBpyijwkJ/
 ACgfnCVPIe1Qa4hu+TC3lrg4w8ZId0uDhBpjb2Sjl2+7x3n5KVNftlo5xcZRXCC/APEVedW
 M/UIpAc0yGfj2n8s8kGALfteq36TI3TeaHKdjVS1DAO5jgdgfdOm0JU+iMsQajlTyUJhnqP
 sixjDoq0sIIRcxmCt2TVNNqmMXq6xJcvaT/emRnIYKimf/88Jlnw4E6x+WaTipt2IN9SB7z
 qG+jOyyG/yJQhiDPorbqRBIHOH62kS6JznEN5fTlNrkz4reCff2Osi035wpwBHeHJD2DfK8
 FpMc0cyRN72K1MwGsHPi65DRq7s3spGgyMUKjjB1dKxRruHhQhozTvI2lxEojBSvZi0QUq6
 S/aG0yawPQHN8JO2LzTBFkIgoDSEAI3mhXN7SXbQI8eDrwOXCbU7x7iSvFClUXgGI9hfQuq
 GDTieul7ZVYpUF0qg1WorYi7ZN/HrhTwJmzvAYgTr2D0mtp5u+nZdvcnHW0fwHyGoyKJ1qw
 bpxC4Fxd5FLU44gAw6EYz9V9Zwj3fJVS0WTSdUeFS1jWjm7eiXp1XY9EhunHFbHNts5XgO+
 1EoVSu6m2JN5nS90NJfMfcz+lT/vtMj8xMY8wXSDP/MQLgw2pfaM34z7yt9hrgGjn3hHcBu
 QNeVWI4HWqdOeZHuTyi4ufGGs/2vC2QGNTX1gNQDV5mHLxpsF+
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The rocket is a DRM accel driver for the Rockchip NPU. Add the Rockchip
mailing listso that changes can be tracked.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a8b0fd665ce..388ec1758ce7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7942,6 +7942,7 @@ F:	include/uapi/drm/ivpu_accel.h
 DRM ACCEL DRIVER FOR ROCKCHIP NPU
 M:	Tomeu Vizoso <tomeu@tomeuvizoso.net>
 L:	dri-devel@lists.freedesktop.org
+L:	linux-rockchip@lists.infradead.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/accel/rocket/
-- 
2.53.0

