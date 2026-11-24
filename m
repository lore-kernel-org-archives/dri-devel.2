Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF6606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=F0lO1nWn;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=F0lO1nWn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A395410F76B;
	Tue, 24 Nov 2026 16:21:07 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D0210F66C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:20:53 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Zop57T5mMXbQXi54MabUzPfqfsA6zI5UoRxHx2W0Tk59nF0pjJxym7j7eLMjiBW4LsGDHrHm5uor8ZGwMlQ6tQlgqNjS602chOFtwWC50z8dJK8WagDsk8H4ikaIXBKU8oe7vAUuHc8W81uXrUw439cgn2KgKTdx4WzuAGXzkI53mfu90k7LT0qG2c7gHtPyg75lo2bqJ9O/SDgWTQHZnjxsnY3t03qt3jx0GWN/jtt28bDkCGQ5LyKn0TX6ZpvEDDxf/MCkaXFKe0sU3oGijxHsTUbhg+dsNlObinsD4a19HnjgbDSHJ+ZgwlSHOVnyZ4ITjZPw6BX9alDLys8k4g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKVO/THJY9BXThyvAQKAPS01Xdo9l61yZj6Z8u/uegM=;
 b=nTInHW5JZ7rLvE3RWI/OCv0uMVNDBv0flzoGPd1IOysXeT7iZNjg+gKwCHa50AnBL4RS5TbB47EQPHFSmxEshDApUu48AzuK4HQHTMNfntxHNIpg7nQ/pw/ibHgiFFiQO4296qK6lMbk5gxuWhsAqVF9uyulGcTNWUEiFAWnebF/jKDiLxKyJaBBu8wQyxmw9unfpx39kkUYGi+ROKEGaGdqRIsanfRIoGycBL1pdANQ6bsD2R6CiEUK54nJaWXfSlHRHzj8sQd02/kOZwtLdawbHRKeq2hFvox3E8IwJCggdWpM7UO/RZEV4+Sqi/HqgEVoXztEU/TkCiUTsvkxVQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKVO/THJY9BXThyvAQKAPS01Xdo9l61yZj6Z8u/uegM=;
 b=F0lO1nWn6DevDsQmtA2SF+j/q+0X94h9l2KFy8hspLFu0s1PQznISajyJyMy5OAQS6Y5WrIO45hPuq9PlDgXwmaNBXOma/rNitcz3HCwYO3YoEH/NwxqobdXRarUd+7LxdZBpGKfmuL1t/NPhUNKHdPERbQZGJnOPjMECelzcCw=
Received: from PAZP264CA0162.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::21)
 by AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 16:20:48 +0000
Received: from MI3PEPF00008492.eurprd03.prod.outlook.com
 (2603:10a6:102:1f9:cafe::b) by PAZP264CA0162.outlook.office365.com
 (2603:10a6:102:1f9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 16:20:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008492.mail.protection.outlook.com (10.167.240.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 16:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuPlW2vKjIy/Bgjsz0Hf2IkEslxmVKgYbDwSwvVqgdr7ERoxbFiz5gSvV/m2kTWVeMJpqApZnqwE0IoJ/J2hMjLOurdcg2ojSqNA9Dro0bJ7WGzm1M38zipVCdZxe2diT7+7iZ0Y+2cLA8VrKXHG+iHSB/2zrh7nU6XDwTf6uYPWsJ7s+ddfKhFyYLgQCRZRSrEmquTaA09CjK/zyAAHy9ajM7EZLDpMFvB0GXhzjFn7tAsqwU8gk/go0EfJF/hmXkaHIsh8HvMb61JopzrnPS5rOpBoCu0u33uvhpZinnRl+hxwOp3Xp83kcH7OOWwZDlWmC7Te2BJMdF9+3JJxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKVO/THJY9BXThyvAQKAPS01Xdo9l61yZj6Z8u/uegM=;
 b=ChmBMaMjW2bA2uIpGoQEXDQLDhrOBG/c7Vz0lG1JnPnKf5Qu8D2XdbiOs8x0zfm+zZimI1OHveg8Dq1oSEoDfHQO2Lq6nwujmOm79zt/hQlFIHMVLYLsSpMWi6RGVKRvBcM2WW2OPnsNvcrC2cGERgNqeTVEFhEDTbJqr2hl33KEV70YMxQ/IFpSXbks+FyuzIMo9+pQvVG2/ecset2Qn27d4BFQPsK2GZqD6td+Y5pQRtmfs2R1YiVjOxFbF1R33rbCUZveJcTghL+WoPFqsooqEpVnnr5n2E3+vLq77daipDVmCidZpqFDMOl087ORPII4/5iNgjJbrqPxc9bIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKVO/THJY9BXThyvAQKAPS01Xdo9l61yZj6Z8u/uegM=;
 b=F0lO1nWn6DevDsQmtA2SF+j/q+0X94h9l2KFy8hspLFu0s1PQznISajyJyMy5OAQS6Y5WrIO45hPuq9PlDgXwmaNBXOma/rNitcz3HCwYO3YoEH/NwxqobdXRarUd+7LxdZBpGKfmuL1t/NPhUNKHdPERbQZGJnOPjMECelzcCw=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com (2603:10a6:190:53::6)
 by VI3PR08MB938182.eurprd08.prod.outlook.com (2603:10a6:800:374::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 16:20:10 +0000
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28]) by MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:20:10 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 3/9] drm/panthor: Move register access helpers out of
 panthor_device.h
Date: Tue, 24 Nov 2026 16:19:41 +0000
Message-ID: <20261124161952.1053586-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124161952.1053586-1-karunika.choo@arm.com>
References: <20261124161952.1053586-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::16) To MMZPR08MB669593.eurprd08.prod.outlook.com
 (2603:10a6:190:53::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MMZPR08MB669593:EE_|VI3PR08MB938182:EE_|MI3PEPF00008492:EE_|AM9PR08MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 123c1959-0533-41ea-61df-08df4a46e662
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|11063799006|56012099006|261021121427099003|261102123227099003|261026121527099003|261026140227099003|261022113327099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: GeyLBIWlzKKklx9WVQMRng1PJsrvdFrYdfoUR/DyNv4/CwlgbTwmV1zFbkm1iKg7YMNb3iyzBsFnxtIcfYuFSxvyypkiXbOSDfVgavzcjgyXx34zWN7QxqKkpfWNic6NlsXm4ggU4RdLPsGDANXR7vssl0L/oYHKej5GjnLPn9IW4ARsNRrvPgUyX7tQ4P0VMjHUKxlTrtzIdDu4H/3F0RJmJvcf372bKwBV+s9t340DU7gP+ixe+DT/q5hbgJ9ZFQxXksHXmg1Ec8lJFlt8FEwrAiivkG0GQbgm5tUIapFUPj+C+zrNjTkmtjm7Iqtp+HWeMgVElszRD2q6la5Sh+Nv3RlVFYSGYBXfgl5BkHobr20mLkFFQfUaheDmZFkmg2w17XRrkg2cJyQPVCvTS6dhzvujW2/Eok9fMddytFRYESYolFMm8ik26WaG02B84OQpIRFMqkbdkpK+y5+YtV7hVd0B4X0K8rwqirBNk+CK4pN8eImZ6NTi/1jJkoahX96T187K4xlDopjOrcmAOKuNRw/mZUoiw84l0/SUQp+rbQ/sCqhvqL9mqlm5v+SvTmY4usyX+wxXqoVkqII4bamnpJ1at9pDh5Mrk4r/VEI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MMZPR08MB669593.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022113327099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: nsYOAU8KvRjQUPgyY6VB+XrmXaK3JimSNaPawTPYWwU6AuSXxAU00YzfoFxL4NGTnq7CpCWDE1m5UycMRA/c7Ty0z0UatwCqD7cThPScJbWF+L2sMKBxwOuWo7x0qZIR7PlEus/WMWZiIcrFEXvoR1CKpo76W1ljEkwwQzX0WvfIAX1gNnVbp7tfDgLtRNUkmj/BXqdomRBcKIWl3ALUu7pU30zUP85sc9rFBAb1HtVW1ti5JBJV0Pnxd2WovyHRpFLd/pFJbAAm6yZ9g6AcKGUtNnJ6L8OdGnAx6xy0N99AW9XHYIgCgmZAQq9jgTM4Kek0HGT7s4gTnGzualWnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB938182
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008492.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 576f9a84-22e9-4b92-b1df-08df4a46cfcc
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|35042699022|14060799003|23010399003|82310400026|10067099003|11063799006|261028144727099003|56012099006|261021123027099003|261022105027099003|261022113327099003|261021121427099003|261026121527099003|261022075727099003|261026140227099003|261102123227099003|261009223027099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: ZFyw5RZjZOpHkL+2o/8Pg3GtNWO/HYtgZsnQQjCZZ0u9+sMGJ+oL0o39BtGLYKOYp4hVQFVajjMw+dWyVINSZ8EgQCdOI9gar8f5+NzO3Dfj2q+QvjcUfcuvxrPvwzw7Y8Wl9hETsEAm/4KbLfBVm4eGkfdmx7h22kNC+CsggPUHSU5uS4qsCP0enel8HYEaCw+BjrUo69hvcD3mCKkYdp0OycaFVacPWWF95O/RtX17wM3Oip0AUggJtccTEZj3HMoCET0z6oSFfjGaBHtVqh1fl9WIRcogk9w1k2QsIt83q0asEQBrBZl5pEgslG55I/jsUMCBSEJeycEVUL6MJ4en2zB4Ko9Mt8jDELTlD6UqQBbHMGy//WfHtMTzFFqmpwd/WTvfnONuUpE+7Ho3YUb1CwSpc4wWxSk8HfLfZt2z8WyQdWTkiijCNjGwSjMwfZTPu7eAlWlRD0dWECQQCam3trwdYyMi5WudpgynK/iZsEwRfUdIw0ACGOkePpXW0gLF+Sc8h8eb2LKsPeTXCwQ07c4CXL5VVzucIZNCRUHZrBDlrdeQN3XqGjv2QrBeGYYxz0R0+HQetFRdAg7OpLXE9SXTJdDkz9CyuVKr5cJcMvbt3bYaGh/01aXl5+YZ75hqTchFjnpf8IBk1fuPbQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(35042699022)(14060799003)(23010399003)(82310400026)(10067099003)(11063799006)(261028144727099003)(56012099006)(261021123027099003)(261022105027099003)(261022113327099003)(261021121427099003)(261026121527099003)(261022075727099003)(261026140227099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P8TfCVVD1pLYc/W6Zj3UgyobgN1fu/IvnnJz9yChA6jE7DTTC0N055S6GP1ireZxKKLl+40SXJW3GqGovl9rfgFsTVJkzK5dO2761MTKGcnkf1hk3lKNQwci3eyE1H38YoIPcHZz5X4B2tKaka2bdh3PJ3TebPNAZpYJG6XRFUiDF4Cdh73qUcD0WWD7V9a3/XxoXauHwrsyNsFGTnTdSFN8kq0ZPMMcdiBwNYAWUOEPS3rotQyXpXJatSS5M9s90PC5ads/WxPipuDD/ljdWlVTZh5j/7SAmQpH/KfuOgeotPNiYeCNy9HHNPrNsUAmIJJS40c2jUT4w6A9I5vd83RFhaS8BB5JwYsuhfRWIVPHx6YFcNzXMcgSEF9rBeGnNDfo++uy2O9cMlYyR4b1+bwamjPiagF8gI2a1jp13hG20UJeP8YxOQ+Dbhd/J4z4
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:20:48.1064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123c1959-0533-41ea-61df-08df4a46e662
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008492.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5892
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

Move register access helpers out of panthor_device.h to allow reuse by
other panthor drivers that will be added to enable v15 support.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v4:
- Picked up R-b from Boris
v2:
- Picked up R-b from Liviu
- Fix includes raised by sashiko
- Link: https://lore.kernel.org/all/20260922205441.263661F000FF@smtp.kernel.org/
v1:
- Includes "panthor_device_io.h" directly in "panthor_device.h" instead
  of peppering multiple files with the header.

 drivers/gpu/drm/panthor/panthor_device.h    | 73 +-----------------
 drivers/gpu/drm/panthor/panthor_device_io.h | 84 +++++++++++++++++++++
 2 files changed, 86 insertions(+), 71 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd414..4add31b12cfd7 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -19,6 +19,8 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/panthor_drm.h>
 
+#include "panthor_device_io.h"
+
 struct panthor_csf;
 struct panthor_csf_ctx;
 struct panthor_device;
@@ -495,77 +497,6 @@ panthor_exception_is_fault(u32 exception_code)
 const char *panthor_exception_name(struct panthor_device *ptdev,
 				   u32 exception_code);
 
-static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
-{
-	writel(data, iomem + reg);
-}
-
-static inline u32 gpu_read(void __iomem *iomem, u32 reg)
-{
-	return readl(iomem + reg);
-}
-
-static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
-{
-	return readl_relaxed(iomem + reg);
-}
-
-static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
-{
-	gpu_write(iomem, reg, lower_32_bits(data));
-	gpu_write(iomem, reg + 4, upper_32_bits(data));
-}
-
-static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read_relaxed(iomem, reg) |
-		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
-{
-	u32 lo, hi1, hi2;
-	do {
-		hi1 = gpu_read(iomem, reg + 4);
-		lo = gpu_read(iomem, reg);
-		hi2 = gpu_read(iomem, reg + 4);
-	} while (hi1 != hi2);
-	return lo | ((u64)hi2 << 32);
-}
-
-#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				     timeout_us)				\
-	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				       timeout_us)				\
-	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
-					     timeout_us)			\
-	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
-				 timeout_us, false, iomem, reg)
-
-#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
-					timeout_us)				\
-	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
-			  false, iomem, reg)
-
 #define INT_RAWSTAT 0x0
 #define INT_CLEAR   0x4
 #define INT_MASK    0x8
diff --git a/drivers/gpu/drm/panthor/panthor_device_io.h b/drivers/gpu/drm/panthor/panthor_device_io.h
new file mode 100644
index 0000000000000..ce417c64abb44
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_device_io.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_DEVICE_IO_H__
+#define __PANTHOR_DEVICE_IO_H__
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/wordpart.h>
+
+static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
+{
+	writel(data, iomem + reg);
+}
+
+static inline u32 gpu_read(void __iomem *iomem, u32 reg)
+{
+	return readl(iomem + reg);
+}
+
+static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
+{
+	return readl_relaxed(iomem + reg);
+}
+
+static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
+{
+	gpu_write(iomem, reg, lower_32_bits(data));
+	gpu_write(iomem, reg + 4, upper_32_bits(data));
+}
+
+static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read_relaxed(iomem, reg) |
+		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
+{
+	u32 lo, hi1, hi2;
+
+	do {
+		hi1 = gpu_read(iomem, reg + 4);
+		lo = gpu_read(iomem, reg);
+		hi2 = gpu_read(iomem, reg + 4);
+	} while (hi1 != hi2);
+	return lo | ((u64)hi2 << 32);
+}
+
+#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				     timeout_us)				\
+	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				       timeout_us)				\
+	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
+					     timeout_us)			\
+	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
+				 timeout_us, false, iomem, reg)
+
+#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
+					timeout_us)				\
+	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
+			  false, iomem, reg)
+
+
+#endif /* __PANTHOR_DEVICE_IO_H__ */
-- 
2.43.0

