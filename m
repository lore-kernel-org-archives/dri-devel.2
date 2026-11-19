Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754D606A332
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D990112388;
	Thu, 19 Nov 2026 12:39:01 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023119.outbound.protection.outlook.com
 [40.107.44.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B8C112381
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH/hHPQANJ/KOtb/kGwpaJpCf9T8CBL4eaaLX5YaI/S+rkHEMt0CDNwyASMwUoYbIY6OuZpPTq9nQov++2gwz02hLLjG5NNxwtxKxU5lbGko+ZymeIMEp8qV9ihRRzK5+b2tS/LAKOMX6xsWuQF6mo7WCjQcMGwgeJjTKj7O4qITK2JNpxjM4kGhIRRjL9N1T4HDEUrj5h1QkFQOL6vk61EhBmBZgDXxG/8RSLZOmTLdyleEYSpiERwdGnG85mgtKcjKRqtGiRMKIu/i0BE8V0gsuXcN4Va+kEUr2soa+fZdTdOA5jx0whtaogJXkAAF+2IYGbr8e1FuyFikeru/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkkWyi9YejJCPrjpd5g70y3S4r4LZjrNgic2YB4itmA=;
 b=BfZ3xLYZ1+Rwq6UOTJpBRBvGd3/x6cCRm/vpyKwFLQfIdYoKfXkRmKuhB5JB/eKWA8m2vI6oyURqiDB5bGC6I6vK2qUfJZSBv1385N+hx46dR4lfyqHWZHR52s2qNmLQEz72fxBUogzR0uDV052YxAVPn4JSREBpnXUJJxpr5Rin5C/2idheEvsfYSO4mAHtLFalXlRP41Bkb1ARCfIZIlnP+OSg5Y04NdN7Dn/1WDKioR5RzNtJDfOx4Pnu61cSRzL2mfPw5tUvhScKNQSrl5R2St6oqdCifnpS+YTP1oUVBWvN+svvumt6kNiLEqYNvx0uVh5U+LuwmlwRXtg1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) by TYSPR06MB6969.apcprd06.prod.outlook.com
 (2603:1096:405:31::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 12:38:55 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:4:191:cafe::61) by SI2PR01CA0004.outlook.office365.com
 (2603:1096:4:191::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.11 via Frontend Transport; Thu,
 19 Nov 2026 12:38:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 12:38:52 +0000
Received: from cix (unknown [172.16.66.176])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6023F40920E8;
 Thu, 19 Nov 2026 20:38:51 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gary.yang@cixtech.com, fugang.duan@cixtech.com,
 daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de,
 daniel@fooishbar.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com, cunyuan.liu@cixtech.com
Subject: [PATCH v3 6/7] drm/panthor: Add CIX Sky1 compatible
Date: Thu, 19 Nov 2026 20:38:49 +0800
Message-ID: <20261119123850.2994625-7-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
References: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|TYSPR06MB6969:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 12ce8a6d-ffcd-4440-9e35-08df463a127b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|23010399003|18002099003|22082099003|261009223027099003|921020|56012099006|10067099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: X3aBaSF4Dq5ZZzvYJNwAyUMU2Q9ta2L1DpsPmD7xdDn4C5JuxyGe6VaxRA8AtahDgpd5W8bQN8aspGT7AOWsPJyv1xahtftVNuAOuP89lTYfSuC9KyQR0MhLy5PAay373Xa/HOIXXyk5qpL0gzkjTEcmtQP5XJbdr65GkegH6pQCU5T97j2WxbEy8a8FnWPgUdljT9zZq6tWbSki3EY3yKJxkTjYQojwUfPEyoh8lk2nS662WTgsXSFItYbdrIsGvUgmVpHZXpxBgOG2ZYV+bPgdzK/fsUQ/bPKE3pam702p4jvC5IoK8Jqhsd2zzgkz1n+d1/M8TxhIAxICFXK0cNJB1pERx+V4/SXbYo5odRgo1PF7Bg60vL8MOI26n1rl1J8WMKgps7XcuTO/Zt6VIUZFoUNUWlCgK2/ySPRZZdHEEuc1GzArgQ7JNGYXjHVtKYz/yqZnKSFTAOyQ642i0yrYzR+ZS4+ZNwLhbWxp1ehvQglgd/dB4Yopaqn6+G7+hUsXRjnRlyRGiZeJxEsJpUj+SJq9XTsBkr2VKEe3WE9iZQhr298RxTBJIWhqyXG1Jr25SHJ8idXW93EaQ6nWIE4YYoIiA8EmTdexQBsttxtTHrLYqIbknsqQIEueMW8bcVney5mwrvfKSE8GxJEcqdwyf7cd+MAtR9YzzI1jyS+/pfLvWYz4ZLdJxCG4MBSbEeku+5/t2M0aEpg2YvRPaBONBy46Jrf4ON4eGXUbbAG3ZvmDuB6oWa6I5zblPJZo
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(261009223027099003)(921020)(56012099006)(10067099003)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YIukUpAzQZc/7KWhNRy8RjiKnT+nPvsSpppDE4oS+Aiu/hzcPC9Bydaj5CUc5z2Z/tI5077QT0G6sSgbK+v51cyu6WRW8TIOyw1qxJ/9l/BNppAWZ+XBD/Z0b6n0qun7U+2cQ4dU9gcJ6ggFCscVI91Rf+Jewm0XEDsTopIkuQ8pcQihg51/CItY7UDnqudEhqRh2TTw4GuG6ZjAdHAA/pBDRCFp8QJYpXk79XnNxBqOOMrOesRdpdKcrrkt/2IESwwI13+m0FB/HJ+QPlEzxNjedtr4Vc4h2OgV+fGjQ9tmpiYP6o9w/6lsHVc6QNDWnx+lKan9XET8vXOLzUZi7GOGmt64fGPL/do4WJSpAsNxBFSmWGuYz5kKbDnT6+9UGMzI7eI6NlFJRE3VJy41cwqhTd5FEsqSWz/Ut+QyliNbW2CtXYawXi5InKHopxGL
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:38:52.8769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ce8a6d-ffcd-4440-9e35-08df463a127b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6969
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

Add a match entry for the Mali GPU on CIX Sky1 using the
cix,sky1-mali compatible string.

Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef4..51fff7eba4a2 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1878,6 +1878,7 @@ static const struct panthor_soc_data soc_data_mediatek_mt8196 = {
 };
 
 static const struct of_device_id dt_match[] = {
+	{ .compatible = "cix,sky1-mali" },
 	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
-- 
2.53.0

