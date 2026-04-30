Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD7AFF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC9810F41A;
	Thu, 30 Apr 2026 18:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JcdZPPXq";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E78510F41A
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 18:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/tx/rLuDSbzM5e9yQdZiJBkYf8GVvw+igFnTr0aPmqTzWQkXevkQ2ZC9wwQ8tfO2d2IYSyKhoa1gu2AqP+SJmH14xCm2wOZqOsfmAKJyVeTAlY7eRGrTrWOPqeflRee17RzrVR4xL2R+tQ8O3pgI8enZrJF3L36yo6NIQJtbS52HNx55OLItkihFR/1NFnV8T/FW3ISjxflQGyEFdPRZCkD1rZWqWBcOHXCg4tzUaf0qfn0XNFl5tNJkP+yMxMaVpvxrITnL2PLdRGyE7HMwPmeWDcnQHOiGcBthqrzWhcfRTIpjpy1ecABjADZT4QGwwpBd4jLy1w2dqP8v7curQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR8wXBqJCpvE+ewZpv+FcT1JHGvwn+g2v3LS+ksQLdg=;
 b=KrVnfo3YEQrHqyIBDL6qEr2Edpx93GxOQhxIkBo7fA8efC7ziY/a7fsbkA+uc28MafCvl2maJ6czaiFb0s+8JeO+3XMZN0IRW2HhDYLrHWAvBCLqXUzGUs56An6HEIa1MOcpm8gSWNrUlAvmy6xPL0gsvnlXI6wjahMv7aubgjdSIL2PSDTz6O/x0nH+06kqTGUAa1SlQcNRqbmWgZUqS0xZbbBoV3lDooIQjAbs7fuPtsY3QI1x94apSWJi6h2DA27MVM2eRJlV2X7th2ehqhZKGz8ZUYo/50dv5ioIqulUNIzOS2dWgI/WNsoUGepSWn8FtFMeSHSQcxWG8mYPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR8wXBqJCpvE+ewZpv+FcT1JHGvwn+g2v3LS+ksQLdg=;
 b=JcdZPPXqHdQvbYOqpob4kXUTX1FjTpJsEGXeuJzGPc/zaPMEQplG7j5nEyhu7Z5P40NEKYJ7QEEp3A2NhFEZXGr/IuvQKj8XjH+p8/7iQ99kJU3kwZtssaO1x7Cz02DVZtc5ENgLCeutlsL9qtKW4XmHWSFTD3+jXozEyyk1sF8=
Received: from BYAPR02CA0045.namprd02.prod.outlook.com (2603:10b6:a03:54::22)
 by SA1PR10MB7756.namprd10.prod.outlook.com (2603:10b6:806:3a3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 18:34:08 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::82) by BYAPR02CA0045.outlook.office365.com
 (2603:10b6:a03:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 18:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 18:34:08 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:34:04 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:34:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 13:34:01 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.233.157] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UIY0Be1943632;
 Thu, 30 Apr 2026 13:34:01 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, "Bjorn
 Andersson" <bjorn.andersson@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <s-jain1@ti.com>, <s-wang12@ti.com>, 
 <r-donadkar@ti.com>, <r-sharma3@ti.com>, <devarsht@ti.com>, <afd@ti.com>
Subject: [PATCH 5/6] MAINTAINERS: Add entry for Solomon SSD16xx DRM driver
Date: Fri, 1 May 2026 00:03:10 +0530
Message-ID: <20260430183311.2978142-6-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260430183311.2978142-1-devarsht@ti.com>
References: <20260430183311.2978142-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SA1PR10MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be8342f-1fc5-4b83-1daf-08dea6e710bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: 4pKjTyBn57V207fcuyg4152DMjvUTkSQJ7kcGIBrgDm/Z4n8e7jF3IV6hWQzzZhNQoxCkQuiqqEdCsxH5F+2nZfJC5EpdQ84oUfJZzNW9ZKSk84zI9g9h0lqnly9KkPMGXS28H/KMuWYQqyVm4+DgZCCr6KIi9dbq8lutlBqoz2ahveAYgHAu4dPD74uawcCRW13B1CSSqLPOXK+K9//qUydqtK/JOWwLG+GK0MJJxFQkqd/xtIziS2NeDQhiDb9kNt6yC+EKiUqHpxwwSWUnymO86qUGLNPEWTRnLowztlxxHvGyIpOnrw/RtC9qWXBcniwv8VMvqkN60pJ79YA7cdYVWOfU6dZuCATBzwMg2vpwEWvSfcpFMiBtsQKP/ECbGc75Q+yeYTUCRUaZBiBvL1MCmO7GrU+Ya8pgYUeZlMxJ6Xb/g3eXgQRFShwEZZzIoWlA6maYFS7uA0veCOnH2M+LRfZ57MtRF6W//5HPpr5NVQadAOJ2Gh7NReaImt8Cpls6fIZ9Uo/xhW6uVpmGJEm1I4NKD8efJoTgV+wiQ5KCa1xqToLFlHU/ZQX+YdhTAjWotTVNBAZvDhLzhSf0DKYP38c6zWkOkMNMDFD08syx+z1VpNyo1fq2UXtSYZMENGljleGbRFMlivm1kc3rdi22CpWF1A5Qbls1BVw95qY3487AWNFNUeRGb987duMHPMI+nVXecY3IyLhEGcddXLTkGH7vL+JQZQAciM9+vo=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(18002099003)(22082099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l5446ALANKpRwQuotNk6IFXRc6OgcFG8faDBMI1uSC9YqbjKR6K5Slwa4UVCIgeNjtmxR4WKF2xAM8k/DqGad6F9HJGn4hTHuEhsLX9Eonj0JYKUbon795IcCv9cuYMDi23UKNWjeTJo2S4O9XJHO7S3OMC20u5rDbTLxmCFOC0iP2RcZqrDjCFUjYhCOGGGK0tyQkY8U63izG6KxW9hFbvUT3cZbQ8QyxhlprU8hkyw6ncTJfbVbAENK8jAWpsIXsUW8M8dvacbPr5kDjYM6X2dVIYJcYB8QTo2ywexbjxDaj2AL6yLLhgbjgbDnFF/GUt+HvVkTdzlZOqNnhMF+Gq1M5YFD0Q1xzMmiomz3Ms2++wbglFGVJUby2ql5h8M7QDVGr1Zk4VC882dJjttIJ4RvrlwqPY/2pv7wpG21jCkpuFPHJAWJpihIeNfxste
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 18:34:08.0249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be8342f-1fc5-4b83-1daf-08dea6e710bb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7756
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

Add maintainer entry for the panel-ssd16xx DRM driver covering the SSD16xx
e-ink display controller family (SSD1673, SSD1680, SSD1681, SSD1683).

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e80296449ba..3a01544dbc50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8377,6 +8377,13 @@ F:	Documentation/devicetree/bindings/display/solomon,ssd-common.yaml
 F:	Documentation/devicetree/bindings/display/solomon,ssd13*.yaml
 F:	drivers/gpu/drm/solomon/ssd130x*
 
+DRM DRIVER FOR SOLOMON SSD16XX E-PAPER DISPLAY CONTROLLERS
+M:	Devarsh Thakkar <devarsht@ti.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
+F:	drivers/gpu/drm/tiny/panel-ssd16xx.c
+
 DRM DRIVER FOR ST-ERICSSON MCDE
 M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
-- 
2.39.1

