Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDA606A339
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=hjiQDRUB;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=hjiQDRUB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DF110E14A;
	Tue, 10 Nov 2026 15:42:04 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013008.outbound.protection.outlook.com
 [40.107.162.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379898913D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:52 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GQ1ikXymjFSy1i0x2E+QPCzQhdN7znEX6rFYO8P7pc4pxkULFJmL09ia+Hq50hiCYZiW00WChF8xMEEMkr1Nq76keXb3aeaXqeGeqF0e08VEDaQ2/Aanu3He54GuWQARzXSc6sTzICarSW44OCBUN7P6WZkFrYv6yl4e4L1yVW8qq8+2XJfSsMhhtwfe/fRiibbv62zmItdJ4ik2enCox8W48jmpY0w79PGBumQ1Jy8ESBebLtNWoWzYtiZCB4+UboqmSDg+vfpJqOLuYFXc0yppWf+N+PN2oklJpQGZeouYByf2ZZt1ofgoFp13SsBLFpUwxGGnqz1hRDmqIItwSA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLQ4ZBoyVCgB7h4D21DCmQw8+2XMvfzU63HPSyIwaYo=;
 b=BFT0E4dehRV2caYy8cE6fIUeKQHrQKeO5OR9EnF270yjQDY3IX6EEzaIBpqGVfkYzlm1lbsg6CY+lkgC49fBjVGBkTnc2TEJfqYf3k8BArLN7oJ3QjbU6SG1GC9zFLv5CUPvfK9tDl44D0EaxIVVsuu9S8zkMFKrT2vVtKgdtPFXeBAemzP2Be3xpCWPz1Mxq88eEie7OG0n4ThhNNqF0OkKtkbI2TEn9mq6RdeIl7KeX1can1Zm1p6U0/WxdfTFMk4RbMxt+xGyhi4XITv9SzuHfRnc3elz6txDLBAHTUTwu2dYCbL4EarEDbpZSBLd8GAKafRg1aqD6rdbiV1VDA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLQ4ZBoyVCgB7h4D21DCmQw8+2XMvfzU63HPSyIwaYo=;
 b=hjiQDRUBwecvA4brweitzZNeM5DkcdKWgQDtlW/NJyy4/twZHAK25NRZblKEue3rvfowSIceRWBoYmnkB2YPxCXN4ihX3W+LxiuGLO6ezrvCWlRr8o9y2HbaWmJKdm66+/pDKl22RUr7nWMs7nlxTu2YVKPyzBFNqTvZt5mxqYk=
Received: from VIVP296CA0106.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:355::14)
 by AS8PR08MB8396.eurprd08.prod.outlook.com (2603:10a6:20b:566::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 15:41:48 +0000
Received: from MI3PEPF0000849A.eurprd03.prod.outlook.com
 (2603:10a6:800:355:cafe::47) by VIVP296CA0106.outlook.office365.com
 (2603:10a6:800:355::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000849A.mail.protection.outlook.com (10.167.240.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbdUZhdmozpCYVWI5wwkewhNa5jSor2ZPuusXthYXzptgda6z7Zna8BNLvCmv0GGdV+e7092Wn/sEew6D4Ggu7AG7ZT+IUm7QbQyMLI+MXNVP5AbO/EL5ZA5kYmX+1EDH0aqZI6Zg4J24zU/xUYnMnmlvM3WeZ/LaEsCHSY0mC0xKPm7Q7Kef2sLbfoI8HGrDmDgFa/YiwqsolSU7EVF7LPakbo83dJKri9T7kS+xfp0dloqfyPt794pZe8KJGeevUETsTDs8l8X2SVKgS4If0MXwA3SF1vJYqkkIA4gd7GGU6zrJo31U/RnnarKdxkqzYwofrbPuoyGz/fDw0hDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLQ4ZBoyVCgB7h4D21DCmQw8+2XMvfzU63HPSyIwaYo=;
 b=DcDvRCdKY/ko3xgDmkOIU4QHcc1rjLDGVSLRJTKSMaXSu1giVxcAa8lQ4uO3jYvdKaoquxVcNSVo2ZwzLlB5ZyqYUY+xeesLmfaCaJ3IcvjlCWw7+1Ae7I8KSWBHTtf7z8SPm/G0q9fP+Qh4QPvivuGBjSm/Ne5nv1UTGhP9LSANCyVq5CFDXzuPrsp+PqCmdaBdtz01npAfPnshcxyhLoEvUYnyPKE0nrh+etDc8WHhO0ibA0rRqyhXSKUZKkQuL/l8qe8EnDg/Y3ks6AUPFj1lSwMQu4PviETM6LwFfKjuAKtjIn/NrMGX0d5UHKSfUCQIwANlxX1KSk3uFyg8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLQ4ZBoyVCgB7h4D21DCmQw8+2XMvfzU63HPSyIwaYo=;
 b=hjiQDRUBwecvA4brweitzZNeM5DkcdKWgQDtlW/NJyy4/twZHAK25NRZblKEue3rvfowSIceRWBoYmnkB2YPxCXN4ihX3W+LxiuGLO6ezrvCWlRr8o9y2HbaWmJKdm66+/pDKl22RUr7nWMs7nlxTu2YVKPyzBFNqTvZt5mxqYk=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:14 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:14 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 21/28] drm/panthor: Request AW to yield GPU access on idle
Date: Tue, 10 Nov 2026 15:38:42 +0000
Message-ID: <20261110153907.3241978-22-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::14) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|MI3PEPF0000849A:EE_|AS8PR08MB8396:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e208dee-4c16-43e2-d198-08df3f4121c6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|10067099003|11063799006|261022105027099003|261102123227099003|261026121527099003|56012099006|261026140227099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: 1+tN/YQ8lx7GZimCMSS9aw7CpsPjb9p1aW0hglcNedcVz1TYNgZfhb7Al/DNG2ufEc4IXPfJU3sq/IxybRd0UDz3pq7Ti8KMdXl2ZRWfENXK/AuPXiuSpSpvlUHu3MgFkvY78C3BmMXehiZLD/Vx7422g89/Smw+Yh9c/YJTegFhICQvFxupE+fqFrqQLZ0RWE6qyyfGUSG+1BxbBoM7Anbtf+0MV4TjhdNtmkyhbbB/m09c9+ymeOhiYNiC+vmWpzE6joN8vjtYqssHwQRh3oqHzJHteDjDpdMlzM58J5ceFdMEgY7+pyNW0i8kOWn7y65k7nydU17E9SNh9yWVuiXyniqmJssMLWdmzIMq4ea6U99LAlGazhzsWmIyIDxWtEkAp4MEZ5nYoRxvdxP4/M8j4d2rauDH/bOqIk9VVrZXDKiF15UgpP2XELiyDmDsSnLwjjQSXI68q5cpKIow3+samYxJc6Kq9KUm9VwGpSRqREUyDPA29+UFL6l4Q+GpPydG6bYA70AxWnZLz0bu+JtKI6Yh3EcqbxEuXj8WBmUnkD/6wE+jf8D35trNoPS/331/4Sc1LxeZjPdclxwL4K3cyrvibh5pP+JMziOX3ce5HzA9JWCuFB0REv4q4yi4LvM5WCy+/gLVro8b5dLDjJxp6xnjAZ6FvaRnkVgh8qQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261022105027099003)(261102123227099003)(261026121527099003)(56012099006)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ZYiPCVFx7N84t4IvY3bFEGvvnNX/sV9gnwa1FIoMAT2Ua02vTIXoxPqKEVmhosGNlwi1tzqLaF71Gsu5vhVbJSIZMqFGcvtYnJ74haYmehMf6ByjaPnSs03Xg6tEkSLgMwZSUSJsoYtAiemKiuO2kzyKfO3TPqK9H2e9wzMIdtK5tKD+RG8FEsW3/juqzz8g6rvV2Lmge78jaQ+jTpriW/3NmGr4+GA9g8azoc0Ma2PwabhjrajcrvHpzepNeW+9mVkgtAlWM3B3bYRSyCGJhhJvc2gi209EflciA/9jYE1XH7E01aatzk1qQLJ0O53tMpZg9HeIBYhLkS/aGAQS7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000849A.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f8295e83-e87e-4856-7dec-08df3f410ddf
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|14060799003|376014|1800799024|35042699022|23010399003|22082099003|18002099003|6133799003|10067099003|11063799006|261026140227099003|261102123227099003|261021123027099003|261026121527099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003|56012099006|261028144727099003;
X-Microsoft-Antispam-Message-Info: sHvY3hbD1exDB+Ik5T4MA6Nz0zB50Oit8fXUJR89jG5Vo/SUM2I7o/nOd4OuZMYRfp/GslLQWBMQJa0HeNYpRaT/+CjjuVH1M84AUofILRMGTc5SuJVYkc167G0irPpa/I/ZxcPapFhDsnE13TTi4J1uwqge28+dm/NBDBqF34gkvuVeftasOZA+uxyf5bxM+MvCcwrohGnO2RixPFbF6JClH9FixQUogFSLlwOtBGyliZmMjVfRLXd3RfeEW5lc0AZ3bjgo56jotGP2nAGy0/6AtziiNgf9zQaOPYBWIusYKS4Z27B8OCCfqp/qg1eNF9+grsRQaCLC+yB73bfF3wZRSPzH9e7BUCw4XJ69liRFwSEbpCoAxBFjPNYE4gCZUOY61n97oGak6kTu7XX4L/qsGrw1O8EodqnVUWosyq+eOUi7jbQAnUhNRMFFtdblHPZSwoGgO/YPvxm055MR/pXnnzW8otV0nCI5+qzI7ecK5Grl2h2nfMerfYzSzfZVVayObi3VqBjP+6it+21O4QkCHQZsCBLZNzmT3Gof+WGvra8h4Sme9MuhBX7IEi3/E7EhKHdoQHhsFeUjkWiaEXsnsqcSrY/n/Q6RiwbrOcfm/yfBFrM3dAAxbgBq049qtII8RrfzAlkZ+tJqHTeTPnHikZb3ihw5058rRKpgoUtL/7LTT83j3YcCK5YhsbVeqBdt+ToyUjgp+X9KlIuGzA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(14060799003)(376014)(1800799024)(35042699022)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261026140227099003)(261102123227099003)(261021123027099003)(261026121527099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jLsvZrrMaYXfDisC4JNIDDMIp++bpkr1JlB7f9wItU88sagwBSpJoPU17Zk8lGYmBJD1DK+2gtZ1XineQjWqz4ip994Y88MSpi4P+oa1xCB+BoPogDdHWUfsf0uxnKKUhZsR7ZDyP5dRgMPqlbBdD2GyMtbhy3CjiaLL+94va3iR7gH1g4BxK88IacepT2Jf6dvaRzhBfLDVi2Hox+m01UtqOyuZlIJr9fJmKgvlfKlgEBsfObwA9dIjpuqERa+kdqPTlwXVjCEjiMVENs0w/mSFmP0ddxdxjYClAgO0o7r/vjt8Vi1wA9NxjJB/BIRTgeNHz++ODL0u/r8nNAiqqkr8fnGET7v9fWeybfg6ZtabxmFYF30vYs+xPGMprZN01PWHq2kDaXX1b6XCCCQr1va75ZMDu5SE4lo/rBU80/stG3nr10EN+4u/lbHEaDJT
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:47.8863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e208dee-4c16-43e2-d198-08df3f4121c6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000849A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8396
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v15 GPU introduces a YIELD_IDLE command/interrupt to signal an access
window to relinquish GPU access as soon as it is idle. With FW v2, the
GPU is immediately yielded when it detects the GPU is idle and the
YIELD_IDLE interrupt is raised.

For latency and CPU scheduling reasons, we want to avoid constantly
yielding the GPU the moment it goes idle when there is only a singular
access window requesting access. As such, we only send YIELD_IDLE when:

- The GPU is granted to an access window and there are other access
  windows requesting GPU access.
- A new GPU_REQUEST was received and the currently active access window
  was the singular requesting AW.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Align with arbitration scheduler retry work changes
- Align with sched-to-AW interface changes.

 .../panthor/arbitration/panthor_arbitration.h |  1 +
 .../arbitration/panthor_arbitration_drv.c     |  5 +++
 .../arbitration/panthor_arbitration_sched.c   | 34 ++++++++++++++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 02e1debf1d75a..0fcaf393a7d33 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -67,6 +67,7 @@ int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 sched_id,
 int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 sched_id);
 int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 sched_id);
 
+int panthor_arbitration_notify_yield_idle(struct panthor_arbitration *adev, u8 sched_id);
 int panthor_arbitration_notify_err(struct panthor_arbitration *adev, u8 aw_id);
 
 #endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index dc63e85ace3de..4bd558d1984e7 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -303,6 +303,11 @@ int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 sched_id)
 	return panthor_partition_control_close_window(adev->pc[sched_id]);
 }
 
+int panthor_arbitration_notify_yield_idle(struct panthor_arbitration *adev, u8 sched_id)
+{
+	return panthor_partition_control_yield_idle(adev->pc[sched_id]);
+}
+
 int panthor_arbitration_notify_err(struct panthor_arbitration *adev, u8 aw_id)
 {
 	int idx;
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
index 16bd0fac2514e..f137b73deaa32 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
@@ -53,6 +53,7 @@ struct panthor_arbitration_work {
 enum panthor_arbitration_retry_work {
 	PANTHOR_ARB_WORK_STOP = 0,
 	PANTHOR_ARB_WORK_CLOSE,
+	PANTHOR_ARB_WORK_YIELD_IDLE,
 	PANTHOR_ARB_WORK_COUNT,
 };
 
@@ -186,6 +187,17 @@ static void arb_sched_queue_retry_work(struct panthor_arbitration_sched *sched,
 		arb_sched_queue_work(sched, &sched->retry_work);
 }
 
+static void arb_sched_yield_idle_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = panthor_arbitration_notify_yield_idle(to_adev(sched), sched->id);
+	if (ret == -EAGAIN)
+		arb_sched_queue_retry_work(sched, PANTHOR_ARB_WORK_YIELD_IDLE);
+}
+
 static int __arb_sched_stop_locked(struct panthor_arbitration_sched *sched)
 {
 	int ret;
@@ -382,6 +394,10 @@ static int arb_sched_next_locked(struct panthor_arbitration_sched *sched)
 
 	arb_sched_grant_locked(sched);
 
+	if (sched->phase == ARB_SCHED_PHASE_GRANTED &&
+	    !kfifo_is_empty(&sched->queue))
+		arb_sched_yield_idle_locked(sched);
+
 	wake_up_all(&sched->waitqueue);
 
 	return 0;
@@ -431,6 +447,12 @@ static void arb_sched_retry_work(struct work_struct *work)
 		return;
 
 	switch (sched->phase) {
+	case ARB_SCHED_PHASE_IDLE:
+	case ARB_SCHED_PHASE_GRANTING:
+	case ARB_SCHED_PHASE_GRANTED:
+		if (test_bit(PANTHOR_ARB_WORK_YIELD_IDLE, work_tmp))
+			arb_sched_yield_idle_locked(sched);
+		break;
 	case ARB_SCHED_PHASE_STOPPING:
 		if (test_bit(PANTHOR_ARB_WORK_STOP, work_tmp))
 			arb_sched_stop_locked(sched);
@@ -551,8 +573,18 @@ int panthor_arbitration_sched_on_request(struct panthor_arbitration_sched *sched
 	 * Grant timer for the current AW has previously expired, request it to
 	 * yield the GPU.
 	 */
-	if (sched->grant_previously_expired)
+	if (sched->grant_previously_expired) {
 		arb_sched_request_stop_locked(sched);
+		return 0;
+	}
+
+	/*
+	 * GPU was previously granted to a lone requesting AW, YIELD_IDLE was
+	 * not sent to it. Send YIELD_IDLE to it now that multiple AWs are
+	 * requesting for the GPU.
+	 */
+	if (sched->phase == ARB_SCHED_PHASE_GRANTED && kfifo_len(&sched->queue) == 1)
+		arb_sched_yield_idle_locked(sched);
 
 	return 0;
 }
-- 
2.43.0

