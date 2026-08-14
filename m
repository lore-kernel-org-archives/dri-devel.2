Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495F0C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C56710E1BA;
	Fri, 14 Aug 2026 02:25:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="Ayg2j/u8";
	dkim-atps=neutral
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325E110E1BA
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1786674320;
 bh=05fYjb00YYXJ31+phLSkqPQi+wABn/rqNlkF5fHNFZ8=;
 h=From:To:Subject:Date:Message-Id;
 b=Ayg2j/u8FPvn549nWWSRSiWFs5ivamzvBnJ51ppvO/9rD3xjw44bMeNCzT+/pBkKK
 E3iMPZPwzP6j9edqXS19Cjbla/rjZc6JaRkqIrmcnLehIWar4VWSmHDd6WW1J/2B2d
 9fu08lRr+7bvbmfFXgFt4ScIJYvIeIoj5y5qr8w8=
X-QQ-mid: esmtpgz13t1786674312tab322716
X-QQ-Originating-IP: 4bqnD55VqWoLJQzWwMaI0Eywi9ybW5lEk3/kjTWN/vM=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 14 Aug 2026 10:25:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4802896716217213205
From: Chaoyi Chen <kernel@airkyi.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 1/4] accel/rocket: Fix the IOMMU domain leak in
 rocket_ioctl_create_bo
Date: Fri, 14 Aug 2026 10:24:50 +0800
Message-Id: <20260814022453.437-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260814022453.437-1-kernel@airkyi.com>
References: <20260814022453.437-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MbYyxy1Fep3Pj+UY4JV1dG8p4VtqC9gMYBVZz+li+uKhqy5kVO9qNBMi
 oGgcABFbN1HEf7XpHrBghxEeNVak2WZYJSXUHyXGZhgW+HyXTGlobnvR/2GEBgZqKYrDmzG
 Qd5o1ZFguNdgBDvYNpMldeG+sch2yjN67T0VfGS6HvL48wraXGJrC0IzIRvPgCgTDKNATI9
 kFU2/4sIzSSfhT/C7wzxhfRMTsbYPat8heBrhbWoSl7MBhZCE/YB5vWJhQy108XzNtGxECV
 C5CDskUWb0lmAA1G/ypy2y1vR/3Dk4DuxjyUYQKpYLPe3vWEA9Om1kzpY7Ms0WMCzUPb5qh
 CDg47DEAVnVjLaI0VTVH3wzvitkMy9pyDutTO5TEqxLi2kMPEdPE7SxoXIyyLPZC1VYQY6V
 xeLZu3B57otVVMcFCNxfJmHr7kR7oxckeicSC303fVD1CCoiTiwfgwMNPbPDFEv4O9f+k7R
 HtajO7DS192xmtE6e1kmQcQpnJKlXnhDSoxh4JgwP1TebOvbuEgu5kcgRoMOMuvsM0kEkiM
 P/JekH8KbckiK9N6BC9dY1vEgQqv4ZL6YQxZ25mstECHVm0+kTFPsAo4nccE9iBwUCPsrtf
 dJqOn+ffJaVAjNvN2KKbNJvaZb2/WGcHRkeuVxMI+EguZQceWq89v4yul+r+G54KM6+PzpZ
 Mvi0AAyFszDgRJZ2kODDtgDFf24KD2TyXQENxrUuWq7bHyK96iYF+2UTyVkWAOoYAB2gFGG
 ZN50cEbIkOl99UFd++ZFS3BorQowk1gQ7Vlt5pa3LsQXgAQGBiPwvvhiGA9KZLXhuFOLx+9
 NSlZXnhZmUCG5hRjecfQe6VmDVy4/F6YEZoqEaMhkhdJ5WgtEBZKeZrE0nc+Ja/Qz8AWbq5
 DzinlHJZVOvyDrDDoEJt3wnMoSALGGSku6y2uQGYvxeDhwCgEiHYBSYpr5m/tQDVtZF9J9b
 2IDeDJjt9SkvlO40DrbIq95+i2Ged6SBdgyerVTohUYJTeauYYeFAKyLBr/TLFeh4lOPDTx
 kaOpQfClD0pYBnkjc7
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

When rocket_ioctl_create_bo fails, rocket_iommu_domain_put should be
called to avoid an IOMMU domain leak.

Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/accel/rocket/rocket_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index a5fffa51ff35..438694ba567b 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -127,6 +127,8 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	mutex_unlock(&rocket_priv->mm_lock);
 
 err:
+	rocket_iommu_domain_put(rkt_obj->domain);
+	rkt_obj->domain = NULL;
 	drm_gem_shmem_object_free(gem_obj);
 
 	return ret;
-- 
2.53.0

