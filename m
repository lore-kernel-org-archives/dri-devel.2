Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA934606A695
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F368110F3FF;
	Tue, 24 Nov 2026 09:39:35 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022092.outbound.protection.outlook.com [52.101.126.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC42710F402
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXuaoFW4NmVx/j7Va1rblSCScYnquyBELlKi+9ej3hCQJw+ttZ2KpTDo3EdTDW4HQB67ChxunoQqfAUV0qiHa1xZ0w2fUQsajpUVTLyatjB7Nne1LpzBbyf3Ls9gY8nPXHpSr+P6LB4EYFIPs5zbc8cAfIljoX8uGDAwsPpyVUdd4/C3Jal0I4XreEFyEzG0fzrh88aimnfJ5391m+0FF83ItCJwACby8oJoCoxPJUzvzGDaAEVdn+pcy+jr+JCuK6iETupTukfqmg+1SR1p+ughbcqhcIBSTUdP0eGI05zcgNQ3RKqiQmvoiLBKSiZdQiPNLnyNaZ2BfYi7i2mBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLTK6VncmzGr5SZASmqw5/lkxvT4Lsj+DAdF8kNAm/4=;
 b=MSXhu5XS5F0ULNJjEczZ46KVQmDsCKPg648N2ptFN2JRvNcZioscKF4MBjpsdafTnH/KyRd+hNSdOSKMFZ7oOPF5voFpH4wOBodTioDbNSCIXrO6ZZVDbVSpdyseA+03fwCqkwuPpKPaaGHax9QsaPvfjAQIIpNHjne5NpXRQXVYEBDLqX5mmla0JuQuWsMRaqoNwm/RDbsHW7BnZ2H+f2IfIboicefYHGx0q+mxt5Rhe0vOw1dKAZNdPoukY6/yyVTqSj64cr7st7Tc8Dtb1GjQUbxpRMVqQoinUtPWT8GQlnmVpba5b3dIRCd74iCNS1nXuGA60/2t3UoRyT1FDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) by KL1PR06MB6322.apcprd06.prod.outlook.com
 (2603:1096:820:cc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 09:39:30 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:4:191:cafe::8e) by SI2PR01CA0011.outlook.office365.com
 (2603:1096:4:191::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 09:39:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 09:39:29 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 58B9840920E2;
 Tue, 24 Nov 2026 17:39:28 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Liviu Dudau <liviu.dudau@arm.com>,
 Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org
Cc: Ayan Halder <Ayan.Halder@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] drm/komeda: Free the IRQ before clearing dev_private
Date: Tue, 24 Nov 2026 17:39:27 +0800
Message-Id: <20261124093928.3220071-4-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124093928.3220071-1-Luo.Liu@cixtech.com>
References: <20261124093928.3220071-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|KL1PR06MB6322:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a1867c7-d993-48ef-2f83-08df4a0ed6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|42112799006|36860700016|261026140227099003|10067099003|56012099006|261009223027099003|261009221727099003|261102123227099003|261009220027099003|261021121427099003|261022105027099003|261009223327099003|261026121527099003|261009221227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: o5zHZi3HJSiTBQRJBes/L4GteUJS9QpHiTeBMv7Xr6Cqyk34PaDbxNelux3EfyeiEmy1XkXkDw+E4K9+ycviaWjATfBOHJ55DnPMjEOUuSvceotDIqphcI1IYWwnlUcjBjmLZod8PcsbZReyCEFE7KJBh1MFMs9eDqLr/BrRxDznYhc1n5gT8Q+q91z6+lTKFVHvag19jlkUdO9CD0mfuwJ7BOruGOJBQipHWmabKKM0TxnmBly3fbvbIy9hsyKq8iCAe40z1nuaSnRaO8r7GItw6A7Jgy09VnYnRD0pvmxZl+yGIhwXeh4Te/j0PQOuRygx2h25Lb+e3WcdlWreQajv8K31QAtr8d869notS7m7Bqctys2SFwISJdGIFSR6+mDIxv3IMPIWpeoac5aSWHyTcsdkmbI1xqxgn6s/p/17Cim5or448VwAK7j+KXlBJ/OHFJQy0BLk/LpaaOQLPoV7Qw7RSe45xwHZDKE++Y9QiMWWofNLifdaJC7+OmbaqykKXk1IHxak9PY4tFActZJRME5A6L0nPEbXVNz+yfFKpw4GK403DMofbjGvm1SRDzxF2qQJGzMtMYuycHrr0u7GMniifOG5JsNFtHMy8ob6GgEpETysAU4pX5eksgAsoyO/QXI4my3GuMHbbyvbNdpwgwqJKAD2wAyJ8ErScDzWB5M8pAsDnKPti4HiWldbsAucLM9hPwYO061Exvalgw==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(42112799006)(36860700016)(261026140227099003)(10067099003)(56012099006)(261009223027099003)(261009221727099003)(261102123227099003)(261009220027099003)(261021121427099003)(261022105027099003)(261009223327099003)(261026121527099003)(261009221227099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pdxA1GKPZP2/PYIQraz1+B4keZLIcCHqnrkV5p1mQpwdcW2fpw2b1UNNO/OlTVMa9nlID/tVkCN+3z1iTvWcjWJmNuqKcHvhTTGiZi+3/F8axLS3qp5ePFFu7KuGcTu7zWf4VteBwtLPc7SVQ5gRSJbML6vwWSp/OcU+PBu1zN8SzJCAQ8cwEue61oN+rsBqZXqCXHigs4+IbuQ+6OCuCDRMgR7AQDmuW8HNxWTf7U59Hh6jHfhzcGraRdSGesucSEqSUf11gdr0SvYYQMy4M1/EQw1kXyjSXyqYpo7cs1+lwjScuA6+kEt05ZjUCx2ZO0w9yf2P+KCUXQdi5u6bKZjLmCbhPEF6/G6ApXzPYWWNuJ+EQdMbOCrErEhCt4AZhhya5bsRso9IYpEzpdEF3rEY7DhPJG31n1j4+PtxsNSngHZfiWjc0uw/qtdzwKip
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:39:29.9124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1867c7-d993-48ef-2f83-08df4a0ed6aa
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6322
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The interrupt is requested with devm_request_irq(), so it remains
registered until the device is removed and its devres resources are
released. komeda_kms_detach(), and the komeda_kms_attach() error path
taken when drm_dev_register() fails, clear drm->dev_private before that,
while komeda_kms_irq_handler() still reads mdev from it. The interrupt
line is shared, so another device can raise it in that window and make
the handler dereference a NULL pointer.

Free the interrupt explicitly with devm_free_irq() before dropping
drm->dev_private. free_irq() removes the action and synchronizes with
any handler in flight, so the handler cannot run afterwards.

Fixes: 2cfb1981dd0d ("drm/komeda: Make Komeda interrupts shareable")
Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index 37388d45b31f..4fabe1aba25f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -334,6 +334,7 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
 
 free_interrupts:
 	drm_kms_helper_poll_fini(drm);
+	devm_free_irq(drm->dev, mdev->irq, drm);
 cleanup_private_objs:
 	komeda_kms_cleanup_private_objs(mdev);
 	drm->dev_private = NULL;
@@ -348,6 +349,8 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
 	drm_atomic_helper_shutdown(drm);
+	/* The handler dereferences drm->dev_private, which is about to go. */
+	devm_free_irq(drm->dev, mdev->irq, drm);
 	komeda_kms_cleanup_private_objs(mdev);
 	drm->dev_private = NULL;
 }
-- 
2.25.1

