Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016C606A333
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BDB10EE1B;
	Tue, 24 Nov 2026 07:36:27 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023137.outbound.protection.outlook.com [52.101.127.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C1F810EDA1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhHG41tD+tmBfxwgXU1pMWdn8rtT9Pi/WprqcV2UKURxOPYw0yRAMkLoVNLcrbzoPkKAYOMQZcW5ewQYEVF3Rh/pyFE4qUFS75nNE/JQjqmG5UOS1d+yzakNP3f/FNHK8DovQ09Jjeszc+bQFIPsZzTkwgcOFwHS4FFnu4oBBoX0ugTNeWLvXWHaPRF1ZPsU0hVmxse/giAuBK2NoWlgXgxvOvLGHjC0yc4wlFkBQ0vm4k+DjP0qykyTwBrS99jJe2325rhB7mwSvHXJaZXuGj30ApDFV3E5QogzyhAAb/KekEjO1wwSiU7a3jxVnSAbY4XYSc6DPZ40xQ7XjJY7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLTK6VncmzGr5SZASmqw5/lkxvT4Lsj+DAdF8kNAm/4=;
 b=Jiw+6NNOkq/HGV94OUkqwBqBAWgHzx0CaJ8A/YfnHOoJ04YttDK4fukbi242dCUwQh4titxaWW1+wjyNnPTVeVfVWBfLQiblYedRmnitfMfIwJoD9futpId4kYSuIbKfdUY+amHzUNMRZFKRYQooPncf19CqH0bVuXxbuAouHy+NC9Cpt6Si8IrWoRTjFaZmSjt6K/cvFr4KtTcJsDPUNA0vGraAPN1nD/Uv8zeUj37rPKYEQe0e+xcOYEp6DY5vTz6dJR9zqKLH1WstmR0ooa7VD9glccA8zqjAc4jkQquyODfUudoATEp89fc55XfmgYYuMSxl3P5QBQA3AHHffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from KUZPR04CA0009.apcprd04.prod.outlook.com (2603:1096:d10:32::17)
 by SE1PPF00709BB50.apcprd06.prod.outlook.com (2603:1096:108:1::404)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 07:36:04 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:d10:32:cafe::a3) by KUZPR04CA0009.outlook.office365.com
 (2603:1096:d10:32::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 07:36:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 07:36:02 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C9DC940920E7;
 Tue, 24 Nov 2026 15:36:00 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 cix-kernel-upstream@cixtech.com
Cc: airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Wuyi.Shen@cixtech.com
Subject: [PATCH v2 3/3] drm/komeda: Free the IRQ before clearing dev_private
Date: Tue, 24 Nov 2026 15:36:00 +0800
Message-Id: <20261124073600.3124817-4-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124073600.3124817-1-Luo.Liu@cixtech.com>
References: <20261124073600.3124817-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SE1PPF00709BB50:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a4935a0e-7ac8-4ab7-e95c-08df49fd97c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|42112799006|376014|36860700016|1800799024|23010399003|22082099003|18002099003|261009220027099003|56012099006|261026121527099003|261028144727099003|261102123227099003|261009223027099003|261009221227099003|261026140227099003|261021121427099003|261022105027099003|261009223327099003|261009221727099003|10067099003;
X-Microsoft-Antispam-Message-Info: WpU24c6RxVPj0vwGMll82sBEUPsmnnWB4WpFslG7CqSJ9ad+uyBfFlgkq1itbkobKvOv1uS6kUJTDA5nBoYHoUlf7gocH0ufxHqTlw8MSr2XUtRO3oB0WYP8O33vR2Hkr9WIF6Q9KAHqqoL9fqWlC1E0QRdbKGU64YSR9tzdW222v/JfE+Ppojx6jMOtiGG/KC5YwaO6hsLtVxbsTMQkM9t3Skp0ZNuJJcGsvnZeLkFdczDW+lbDX9pYf3AFiyuwS+o0XoxKuBAzXty6AnEXuiL/1cD8nzp+4cbZxpZFqhBzbNQgO34ihupcB0vYJwf6/tjVVZdJu3fXgFd6EiGz/eL10Wzt6X34uApaKVZDctMnWi1oB8lFlJRQKrswYCCMNURMvytSABhyCPKl7fqyZS89WOA7OqokJHS2Mmc8kpIhOseInUumgf+5nd22up/JmYioiTa9PsMr/eqlGpmhjHtIko2aHg7859owq27DgKWrA5k0wkMuHnXsnq2XAExS5ajLZAJBqHHpZCiwj2YtqzjfGM92rE/obR1hRA0PC+of51cb8m9jNLrN7l+Pyc67zRzS8ITVFpmglV8i4c31oaO9Kcb13QKFba/wM34Xn+/BS1UDHlz7lSqQo0JEYDddmzpbrrh5scnM4YWPeRwx6hBzLbzdnhQnHYKNzLaagxNO/2caPqm8bX/CXadVusbqcy5yiQcKd7OwRWmwqx2JKA==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(42112799006)(376014)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(261009220027099003)(56012099006)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(261009221227099003)(261026140227099003)(261021121427099003)(261022105027099003)(261009223327099003)(261009221727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vOmehZEx9JmIQjNVEFml1aJnrU4I5scKeo/q3PadoKdeiFKdRaZNWIyoUpvZ2vlkdhw1Brha9O133M9otI0a+v1F6qdSRcfGzacHPS1FNKh3LQnULnDEgPWwyK/geAGcIZF4dTBpAdz7/afLhxztYrk4nn5aRvUeuixtHk6x3zKHXEkPZM0tv8RLXj2fz2faMy3XMTUS1GZkXbYJdNF2QqZxYdK8YYmXbn130pUJ4pvCopy8lCX9++EsandgWBrkLu0Pu//KRGfkmBm4EY24jgA4rmntmdWKUZ/In8GELU1fmmaInglRonRb25dhBNsbYH1u/NNVaSgpN/mjdRNiYr8EDwoaWMNuObhD2W0tGkHvJ4ibD1ToTcw0kqHYpvNpt1Kl90ubOyaR2ywbOAxZA1/UZmVMBh9cHscnCTIbZcl5msbupXxE1iiNcDO8ZYNU
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:36:02.4304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4935a0e-7ac8-4ab7-e95c-08df49fd97c9
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF00709BB50
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

