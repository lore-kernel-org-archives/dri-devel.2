Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2572606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FDMG44E4;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FDMG44E4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3246C10E45D;
	Thu, 26 Nov 2026 20:58:44 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177A510E45D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:58:27 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=myhUa2xfe8a7aak5IFUgEValP43WvbtyOAwgFSoY8iXCcOaupMwBDWVdzz1t+0XSfg/LyeHQRp78wf6HDdquKRgaHQ6n4lS4Mp9RPsurhyn0M+hlHBzo7/lJHfD5CTGV6LKLrpbRhgq9WDLBPhBJOSzgZ/flU7i+NLNH7TxyLtpdcZTRWibkdF7OdBkueheQQnswEjphHS9CkLL3w2CNjBCwZfZ//pXZ6RU1O7YHZgMNFaa5RpFicGrAt0+ztXbM5/Me82T3D6m6N3ioRttrccBbsUlSNJJskRpPiwiv8i9ZhQwYPrsz84BoC9mCtXkcsVxGyEtWV8wFzWY8v5hcug==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMxStm9zuR2hzvCCYPGkrWXPBkN8SJvZPS0/X7DU160=;
 b=Q/3ggp8s6Wvpo4uGZC9ztGHK5qhzi7zOQpJjGzWe2b5z60WT4MnMe4b72JdcsWCeSvNm5zktODe3K/hyakXoEQrLl72GziuvsjujSDTMNhEPh2u/07hC7EOXSqa1wg+0SZe/POuQM2Wy/SlEpeWm3SlZJ36ObhseU0vKoKs0E6SKBhw/6IjKbO+Xe6bN1ZXvx/CvGGpnZJsz1sPhd2rgSpLTNkzjrlYoRAJBafrLafOA4ocQ8vxp8D31wDtJNsaexgFNP7veJalgEEsN8xCnuIM+xLbIAOXdIONxXHXOVNsTs864VYBJErHqK8fam2dpPVWJU1Jm2kknXvMGl4PVsg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMxStm9zuR2hzvCCYPGkrWXPBkN8SJvZPS0/X7DU160=;
 b=FDMG44E4UazKLR5GfWB5aGpGVPScX5uBnVO92/bfcU64wv0HhlVYckaKlhKVqWDntzH8pgD1SJqaykU9Q288KT5Ylda9obHnTtkjRUDJ93V6nyCaQoaHEE5buh+1pv6C+tN8yV87mlvrRl4GJn9bE2XU5M5VCyAdkg3TaPMBFY4=
Received: from PAZP264CA0252.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:239::14)
 by DBAPR08MB5640.eurprd08.prod.outlook.com (2603:10a6:10:1a3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 20:58:19 +0000
Received: from AM7PEPF00000053.EURPRD83.prod.outlook.com
 (2603:10a6:102:239:cafe::42) by PAZP264CA0252.outlook.office365.com
 (2603:10a6:102:239::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Thu, 26
 Nov 2026 20:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000053.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Thu, 26 Nov 2026 20:58:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwPngGHuulS6pYrB49T7UGf5U7rPSykpU8vuvj38zsVgEFxQ3urO9IriJuRZKPspfG4YAuZBBU/ppLcJKVjKZdPVAWl55SWi82ovlQ7YAbabPWffsGUmaz05kiwWdQqe0RiNVZI+181qavNwJWB+uCtWJvaWTsuz+i9LDUkjyt2nNbg1++OumjkXAZUiwCpdEvJf8BcoxaxJGE0862HTljXo7hP6ioMzkugi9AGZB4cl8OXUNSi67rOH5Z/cn02nxO5HjQfys4dhz20jwuLd292q8sFz1J08E5+PhdeeRup7AgkhouDbGyhxT/5OID8FfWr0GRRt7g9NoRxgACZC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMxStm9zuR2hzvCCYPGkrWXPBkN8SJvZPS0/X7DU160=;
 b=Q40Xo/0Lq7EAsz58EWsk+oJCvDVW5oVLo7nHFKp+Zoao7rGedDqtfYbjK17zqDPp7X1az0O2+ENam54VGTpjtI3G8n4aEvudE8WOel6t9WzOrYA4m2qS4CR6/u4QGPlbBYsyB+jeablEh92iwppDnTPd0rzmWAAT0DCBhqveDGS+VAegUOqwfevpjrrLT84T1Qj4LRqKGe0OEc0BKd+unfDAk9blD4aTL9zg/eAD5BUqoWtfOr9xIEUC8PpQpjXo4/qzVqg1+jzwkbMKdXbYLGIxhVbQmfMckeZEuY1f908IVRTnb5QyAgzvMp+ywtgeLN4MdVOMqIgk46GeKKX44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMxStm9zuR2hzvCCYPGkrWXPBkN8SJvZPS0/X7DU160=;
 b=FDMG44E4UazKLR5GfWB5aGpGVPScX5uBnVO92/bfcU64wv0HhlVYckaKlhKVqWDntzH8pgD1SJqaykU9Q288KT5Ylda9obHnTtkjRUDJ93V6nyCaQoaHEE5buh+1pv6C+tN8yV87mlvrRl4GJn9bE2XU5M5VCyAdkg3TaPMBFY4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by MA9PR08MB045061.eurprd08.prod.outlook.com (2603:10a6:250:115::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 20:57:45 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 20:57:45 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Thu, 26 Nov 2026 20:57:38 +0000
Subject: [PATCH v8 2/3] drm/panthor: Implement performance counter firmware
 sampling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-panthor-performance-counters-v8-2-6e7db0ec33f5@arm.com>
References: <20261126-panthor-performance-counters-v8-0-6e7db0ec33f5@arm.com>
In-Reply-To: <20261126-panthor-performance-counters-v8-0-6e7db0ec33f5@arm.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>, 
 Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nd@arm.com, rust-for-linux@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PA7P264CA0525.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db::8) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|MA9PR08MB045061:EE_|AM7PEPF00000053:EE_|DBAPR08MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 61431035-5687-4031-dea4-08df4bfffec2
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|10067099003|56012099006|261026140227099003|261026130827099003|261026121527099003|261026135527099003|261028144727099003|261022113327099003|261022105027099003|261022115727099003|261022075727099003|261021130227099003|261021133027099003|261021121427099003|261021123027099003|261021135927099003|261102123227099003|261009221227099003|261009223027099003|11063799006|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: 6XOHrN0ukEJlDKOEQG104ISt561a7gyXyOmprcVFjbOXUDVA3lZu0YbRoHjfxN4QRJY4vtCxOHJtFEC5iUUjDyCSJMN/k7dGCMjmKXH04j7FADQb0pFUc7Nm5fW0M6bCZhzs+qxdRVtqXbN9+ZTtqlBeVOXYX47WJ+Vm7ogQdSuOoR2oP+fq8xIL6HOULPVnq0NW2xJoh7C0lTC8KGh2NZS0TStT/ff5+QaFECbzjjdGRZvH1MB3QBXRoTxGR9fZ3DoEzuu+tJg8JdB4ZJnP9yvqWgR61QdaMyA6m9MUofgiywXaMw43ulvMjvK/j62dVd281LJXgaXeS1I+lVe7mPMKol3ME37KaaaAkrpF4C2I1tsyyjQ75fdyf0r1VOE/+WWfArE7F9XA7y82InFBXRRCtV76HJaZg6vaeFoaWtREVa0F9NqG+5GExbLoPEviEh7WB2oudjNSThAU+Qd6AOWrxaoNDdlBGto/69LRFn/A36jLvbtTq1uXhRwSdqUz3IHI78qJlX4g7Awr7n6DUnIRIpvT+SSW9O+PGttt4ZRWvMGt508yntdVhmGycn6mr00X4Eh9cNJmf7LwR8eE5NtnonK36lBtbBFubu99RXoFcu46Jn5TffQmQYTE4wgWIdSj/jDkwHNBBKgIqJs2P3V0GF/KjmNWbZggQsAapT5yr6RVdsAA+zuWNtcE1nAySqkJ3Wb49FzA4ya78Pg0bQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(10067099003)(56012099006)(261026140227099003)(261026130827099003)(261026121527099003)(261026135527099003)(261028144727099003)(261022113327099003)(261022105027099003)(261022115727099003)(261022075727099003)(261021130227099003)(261021133027099003)(261021121427099003)(261021123027099003)(261021135927099003)(261102123227099003)(261009221227099003)(261009223027099003)(11063799006)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: gu7wZZ8KUxX7apPNqw6+sJpjS8Y/21SdN4Ir2c9jpS1IdSfrQOiKzfiMxF1glpakddZRhRQzn+MpJb425dIBWcBpDMYG1FuSJ1gAqt5sotXFIavI+cm7xTpp3be+jwHMkJGELFKHqkPpttF9EydtH+vJfOgtsQHIxyKoew3IKoxH7mnJqpKFsrJEtOC2AzLtCdwmIKGYuNcfu7WcIMMbkiKtrpwN4XCsmfky+g0madX4PNY1BHoEp0/gzLjOyypdWH2fQn/LYK8CW6yMQqcxxQ6SPwgLNASwLcI9C5k9oh2+K8/m9q7aRsZDbsygc2eJru+Jz3w+SboJ2pJylxIlaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB045061
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000053.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0906cd56-eb9e-4571-6eeb-08df4bffeb77
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|14060799003|1800799024|36860700016|7416014|376014|35042699022|6133799003|22082099003|18002099003|3023799007|921020|261022115727099003|56012099006|11063799006|261022075727099003|261026140227099003|261026130827099003|261022105027099003|261026135527099003|261028144727099003|261021133027099003|261009221227099003|261021121427099003|261009223027099003|261022113327099003|261102123227099003|261021123027099003|261021130227099003|261021135927099003|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: k6ywxXoXI0h1rn1Wf2/f74ct9Ux9h3/mT3Lrn01eyCAGw5UakJorbpvNDvLAiepfgCPEVZly7QEa46b64IPDVPSkvyFo2sGoznID+jFdAv7ZXL5XdNU0GV5gTneu8BE3YovZC6MI3YE/kDMzRbsjid8ap86kYZB99rZqUACmM02LFwNQGIo1dcXvoHlaXlID6JeJk5NhZS8Dv/RWaChVA1ZKjW9XT5zQCAscd/PU6hbNrQ7oOwDyMRCaj6S2y0NdMOQbbfbVrIDrXdBG0fDMUnYrQR2M/Vmp0Jtfe7uASBLT7QuCkuL9bE3DnYp80FWvmfKGgdXCy+8nLyM+smTa+cxkFcOtffHxpq61fKJkNpbaN3bAv3AP6RvX3MM37QDYzhnXqdd2XNKDZ5HNqi4zWzWaJDh949k4GwNwDjMTQ8uIRtxQbP2M2fvdUCQevNiUgJcJPCBGrsQDjPeAsIdlSFD+rhm3I81MHOdzZFTYmk6lfMlZOQXr4uiGTVjVCpjbzfP6Q71cXDOofLX2GDy+rDzg9Nq60u6vQPYkZLmg+nlzaEZyvF8szOfFGN0+LGmMwN1N6CzHGKGoJ2T4X6wP892kHQBjsTivaaBYUg0O1oId9yJd4CzAzy6e7q0wijGbIFvXjt9LEdSZpRUiguHAl2YAPvNaXn35RHzMCBnxHApHq4zUZ3U3sJjpFzuSx1vwBDgIIcyyA9Dt3i3kwhckKDX+JmWDF7Nf5c8JC9cd4Q1nE+ednTLo5IurvRaS5XOL
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(14060799003)(1800799024)(36860700016)(7416014)(376014)(35042699022)(6133799003)(22082099003)(18002099003)(3023799007)(921020)(261022115727099003)(56012099006)(11063799006)(261022075727099003)(261026140227099003)(261026130827099003)(261022105027099003)(261026135527099003)(261028144727099003)(261021133027099003)(261009221227099003)(261021121427099003)(261009223027099003)(261022113327099003)(261102123227099003)(261021123027099003)(261021130227099003)(261021135927099003)(10067099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NzNj+BuOloMwwu7bDnKi25aY2bDs0l/T2+5cdVDQUCQqJBWNaicA43hvT674h2X5VW6A10qrdkIiYWJ/htNkvTuEKJ8wPn7311KoEHmeSAp0Q1l9ki9+lvY50o3hTlrkTbZj1KCIg9DVV3npi920gMgcG0+bpIpZBDEzKmeG5AFLUrlu1Lz8uAXvmUXxDqL8kgxEVJt0quW+wp7nMxWDJ0yGHG4qV1HFRetUDTT7HL2achgY5FwtbFra+7MjNzwsxkwRhkIbHbAljHJmV+tgk2l0vZId/CO5MObKUDjZerIyMTQtyp/cfJ3n7bKuLENFFPgp9jsIYw82jLw2iGXVpPZUEoUuP36tN/XX7ubeC1tNjEfU16ri2pkvhfDIssVQ52vPGpB8oj6bnWqbSYD45nLc1T8sLJtjVQ7lFO+FQbz8fvUCHYGnzl5SXU7SkS+E
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 20:58:17.1745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61431035-5687-4031-dea4-08df4bfffec2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000053.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5640
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

panthor_perf aggregates counter and set requests coming from userspace
and mediates interactions with the FW interface, to ensure that user
sessions cannot override the global configuration.

Upon receipt of a relevant interrupt, corresponding to one of the
three relevant bits of the GLB_ACK register, panthor_perf takes any
samples that occurred, and, based on the insert and extract indices,
accumulates them to an internal storage buffer after zero-extending
the counters from the 32-bit counters emitted by the hardware to
64-bit counters for internal accumulation.

When the performance counters are enabled, the FW ensures no counter
data is lost when entering and leaving non-counting regions by
producing automatic samples that do not correspond to a
GLB_REQ.PRFCNT_SAMPLE request. Such regions may be per hardware unit,
such as when a shader core powers down, or global. Most of these
events do not directly correspond to session sample requests, so any
intermediary counter data must be stored into a temporary
accumulation buffer.

If there are sessions waiting for a sample, this accumulated buffer
will be taken, and emitted for each waiting client. During this phase,
information like the timestamps of sample request and sample emission,
type of the counter block and block index annotations are added to the
sample header and block headers. If no sessions are waiting for
a sample, this accumulation buffer is kept until the next time a
sample is requested.

Special handling is needed for the PRFCNT_OVERFLOW interrupt, which is
an indication that the internal sample handling rate was insufficient.

A semi-static table maintains the mappings between the offsets from
the base of a FW sample to the corresponding block type. Since the
counter blocks themselves do not contain this information, this needs to
be done in the kernel. This also handles sparseness in the shader core
buffer region, which depends on SHADER_PRESENT and architecture revision.

The worker handling samples also drives session state transitions, taking
sessions from any transition state (STARTING, STOPPING,
DESTROY) to a stable state (ACTIVE, STOPPED, or freed).

The number of ring buffer slots is configurable through module param
to allow for a lower memory footprint on memory constrained systems.

Co-developed-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c |    8 +-
 drivers/gpu/drm/panthor/panthor_fw.c     |    4 +
 drivers/gpu/drm/panthor/panthor_fw.h     |    8 +-
 drivers/gpu/drm/panthor/panthor_perf.c   | 1163 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_perf.h   |    8 +
 5 files changed, 1174 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 2877d47c67172..09b2165bd4453 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -137,6 +137,7 @@ static void panthor_device_reset_work(struct work_struct *work)
 	if (!drm_dev_enter(&ptdev->base, &cookie))
 		return;
 
+	panthor_perf_pre_reset(ptdev);
 	panthor_sched_pre_reset(ptdev);
 	panthor_fw_pre_reset(ptdev, true);
 	panthor_mmu_pre_reset(ptdev);
@@ -146,6 +147,8 @@ static void panthor_device_reset_work(struct work_struct *work)
 	ret = panthor_fw_post_reset(ptdev);
 	atomic_set(&ptdev->reset.pending, 0);
 	panthor_sched_post_reset(ptdev, ret != 0);
+	if (!ret)
+		panthor_perf_post_reset(ptdev);
 	drm_dev_exit(cookie);
 
 	if (ret) {
@@ -537,8 +540,10 @@ int panthor_device_resume(struct device *dev)
 			ret = panthor_device_resume_hw_components(ptdev);
 		}
 
-		if (!ret)
+		if (!ret) {
 			panthor_sched_resume(ptdev);
+			panthor_perf_resume(ptdev);
+		}
 
 		drm_dev_exit(cookie);
 
@@ -602,6 +607,7 @@ int panthor_device_suspend(struct device *dev)
 		/* We prepare everything as if we were resetting the GPU.
 		 * The end of the reset will happen in the resume path though.
 		 */
+		panthor_perf_suspend(ptdev);
 		panthor_sched_suspend(ptdev);
 		panthor_fw_suspend(ptdev);
 		panthor_mmu_suspend(ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index c4be719ea05cb..f9d423e8a6f47 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1073,9 +1073,12 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
 
 	/* Enable interrupts we care about. */
 	glb_iface->input->ack_irq_mask = GLB_CFG_ALLOC_EN |
+					 GLB_PERFCNT_SAMPLE |
 					 GLB_PING |
 					 GLB_CFG_PROGRESS_TIMER |
 					 GLB_CFG_POWEROFF_TIMER |
+					 GLB_PERFCNT_THRESHOLD |
+					 GLB_PERFCNT_OVERFLOW |
 					 GLB_IDLE_EN |
 					 GLB_IDLE;
 
@@ -1123,6 +1126,7 @@ static void panthor_job_irq_handler(struct panthor_irq *pirq, u32 status)
 			duration = U32_MAX;
 		trace_gpu_job_irq(ptdev->base.dev, status, duration);
 	}
+	panthor_perf_report_irq(ptdev, status);
 }
 
 static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index 534cbe79a4f1a..2b095f9b38430 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -198,9 +198,12 @@ struct panthor_fw_global_control_iface {
 	u32 output_va;
 	u32 group_num;
 	u32 group_stride;
-#define GLB_PERFCNT_FW_SIZE(x) ((((x) >> 16) << 8))
+#define GLB_PERFCNT_FW_SIZE(x) (((x) & GENMASK(32, 16)) >> 8)
+#define GLB_PERFCNT_HW_SIZE(x) (((x) & GENMASK(15, 0)) << 8)
 	u32 perfcnt_size;
 	u32 instr_features;
+#define PERFCNT_FEATURES_MD_SIZE(x) (((x) & GENMASK(3, 0)) << 8)
+	u32 perfcnt_features;
 };
 
 struct panthor_fw_global_input_iface {
@@ -249,6 +252,9 @@ struct panthor_fw_global_input_iface {
 	u64 perfcnt_base;
 	u32 perfcnt_extract;
 	u32 reserved3[3];
+#define GLB_PERFCNT_CONFIG_SIZE(x) ((x) & GENMASK(7, 0))
+#define GLB_PERFCNT_CONFIG_SET(x) (((x) & GENMASK(1, 0)) << 8)
+#define GLB_PERFCNT_METADATA_ENABLE BIT(10)
 	u32 perfcnt_config;
 	u32 perfcnt_csg_select;
 	u32 perfcnt_fw_enable;
diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
index a4167bbc33adc..be2618ae31070 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.c
+++ b/drivers/gpu/drm/panthor/panthor_perf.c
@@ -2,6 +2,7 @@
 /* Copyright 2023 Collabora Ltd */
 /* Copyright 2025 Arm ltd. */
 
+#include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_managed.h>
@@ -12,8 +13,11 @@
 
 #include "panthor_device.h"
 #include "panthor_fw.h"
+#include "panthor_fw_regs.h"
+#include "panthor_gem.h"
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
+#include "panthor_mmu.h"
 #include "panthor_perf.h"
 
 /**
@@ -39,6 +43,76 @@
  */
 #define PANTHOR_PERF_EM_BITS (2 * BITS_PER_TYPE(u64))
 
+/**
+ * PANTHOR_CTR_TIMESTAMP_LO - The first architecturally mandated counter of every block type
+ *                            contains the low 32-bits of the TIMESTAMP value.
+ */
+#define PANTHOR_CTR_TIMESTAMP_LO (0)
+
+/**
+ * PANTHOR_CTR_TIMESTAMP_HI - The register offset containinig the high 32-bits of the TIMESTAMP
+ *                            value.
+ */
+#define PANTHOR_CTR_TIMESTAMP_HI (1)
+
+/**
+ * PANTHOR_CTR_PRFCNT_EN - The register offset containing the enable mask for the enabled counters
+ *                         that were written to memory.
+ */
+#define PANTHOR_CTR_PRFCNT_EN (2)
+
+/**
+ * PANTHOR_HEADER_COUNTERS - The first four counters of every block type are architecturally
+ *                           defined to be equivalent. The fourth counter is always reserved,
+ *                           and should be zero and as such, does not have a separate define.
+ *
+ *                           These are the only four counters that are the same between different
+ *                           blocks and are consistent between different architectures.
+ */
+#define PANTHOR_HEADER_COUNTERS (4)
+
+/**
+ * PANTHOR_CTR_SAMPLE_REASON - The metadata block has a single value in position three which
+ *                             indicates the reason a sample was taken.
+ */
+#define PANTHOR_CTR_SAMPLE_REASON (3)
+
+/**
+ * PANTHOR_PERF_RINGBUF_SLOTS_MIN - The minimum permitted number of slots in the Panthor perf
+ *                                  ring buffer.
+ */
+#define PANTHOR_PERF_RINGBUF_SLOTS_MIN (16)
+
+/**
+ * PANTHOR_PERF_RINGBUF_SLOTS_MAX - The maximum permitted number of slots in the Panthor perf
+ *                                  ring buffer.
+ */
+#define PANTHOR_PERF_RINGBUF_SLOTS_MAX (256)
+
+static unsigned int perf_ringbuf_slots = 32;
+
+static int perf_ringbuf_slots_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int slots;
+	int ret = kstrtouint(val, 0, &slots);
+
+	if (ret)
+		return ret;
+
+	if (!is_power_of_2(slots))
+		return -EINVAL;
+
+	return param_set_uint_minmax(val, kp, 16, 128);
+}
+
+static const struct kernel_param_ops perf_ringbuf_ops = {
+	.set = perf_ringbuf_slots_set,
+	.get = param_get_uint,
+};
+module_param_cb(perf_ringbuf_slots, &perf_ringbuf_ops, &perf_ringbuf_slots, 0400);
+MODULE_PARM_DESC(perf_ringbuf_slots,
+		 "Power of two slots allocated for the Panthor perf kernel-FW ringbuffer");
+
 enum panthor_perf_session_state {
 	/** @PANTHOR_PERF_SESSION_STOPPED: The session cannot sample. It starts out stopped. */
 	PANTHOR_PERF_SESSION_STOPPED = 0,
@@ -76,12 +150,36 @@ struct panthor_perf_counter_block {
 	u64 counters[];
 };
 
+struct panthor_perf_fw_block {
+	/** @block_count: Number of blocks of the given @type in the FW ringbuffer. */
+	size_t block_count;
+
+	/** @phys_mask: Bitmask of the physically available blocks. */
+	u64 phys_mask;
+};
+
 struct panthor_perf_bo {
 	struct drm_gem_object *obj;
 	void *vaddr;
 };
 
+struct panthor_perf_sample_block_iter {
+	const u8 *src;
+	u8 *dst;
+	size_t offset;
+	size_t data_size;
+	size_t block_size;
+	const struct panthor_perf_counter_block *src_blk;
+	struct panthor_perf_counter_block *dst_blk;
+	const struct panthor_perf_enable_masks *masks;
+	const unsigned long *requested_mask;
+	u32 counters;
+};
+
 struct panthor_perf_session {
+	/** @state_wq: Wait queue for state transitions driven by the sampling path. */
+	wait_queue_head_t state_wq;
+
 	/** @state_lock: Protects session state, sample flags and pending requests. */
 	spinlock_t state_lock;
 
@@ -143,7 +241,7 @@ struct panthor_perf_session {
 	struct drm_panthor_perf_ringbuf_control *control;
 
 	/** @samples: The mapping of the @ring_buf into the kernel's VA space. */
-	u8 *samples;
+	void *samples;
 
 	/**
 	 * @sessions: The list node tracking all registered sessions.
@@ -162,8 +260,90 @@ struct panthor_perf {
 	/** @info: Pointer to the previously initialized perf info. */
 	struct drm_panthor_perf_info *info;
 
-	/** @op_lock: Serializes high-level session operations. */
+	/** @rb: Kernel BO in the FW AS containing the sample ringbuffer. */
+	struct panthor_kernel_bo *rb;
+
+	/** @sample_slots: Number of sample slots in the FW ringbuffer. */
+	size_t sample_slots;
+
+	/** @em: Combined enable mask for all of the active sessions. */
+	struct panthor_perf_enable_masks *em;
+
+	/**
+	 * @fw_block_size: The size of a single block in the FW ring buffer, equal to
+	 *                 sizeof(u32) * counters_per_block.
+	 */
+	size_t fw_block_size;
+
+	/**
+	 * @fw_sample_size: The size of a single FW sample in the FW ringbuffer.
+	 */
+	size_t fw_sample_size;
+
+	/**
+	 * @blocks: FW block layout for one sample. Metadata blocks are consumed
+	 *          internally and omitted from userspace samples.
+	 */
+	struct panthor_perf_fw_block blocks[DRM_PANTHOR_PERF_BLOCK_MAX];
+
+	/**
+	 * @sample: Pointer to an upscaled and annotated sample that may be emitted to userspace.
+	 *          This is used both as an intermediate buffer to do the zero-extension of the
+	 *          32-bit counters to 64-bits and as a storage buffer in case of automatic samples.
+	 */
+	u8 *sample;
+
+	/**
+	 * @op_lock: Serializes START, STOP, SAMPLE and global FW configuration.
+	 *           When both @op_lock and @session_lock or a session's state_lock
+	 *           are needed, @op_lock must be acquired first.
+	 *
+	 *           The sample worker must not acquire this lock, so synchronous
+	 *           session operations can wait for sample delivery.
+	 *
+	 *           Runtime-PM references must be acquired and released outside this
+	 *           lock, as the PM callbacks also acquire it.
+	 */
 	struct mutex op_lock;
+
+	/**
+	 * @session_lock: Lock used to guard the @session_list.
+	 */
+	struct mutex session_lock;
+
+	/** @session_list: List of all sessions. */
+	struct list_head session_list;
+
+	/** @pend_lock: Lock used to guard the requested sample field. */
+	spinlock_t pend_lock;
+
+	/** @fw_sample_requested: A sample has been requested. */
+	bool fw_sample_requested;
+
+	/** @set_config: The set that will be configured onto the hardware. */
+	u8 set_config;
+
+	/** @last_fw_sample_time: The CPU-side timestamp of the latest consumed FW sample. */
+	u64 last_fw_sample_time;
+
+	/** @sample_workq: Workqueue to handle and accumulate samples. */
+	struct workqueue_struct *sample_workq;
+
+	/** @sample_work: Worker to consume available FW samples and expose them to the user. */
+	struct work_struct sample_work;
+
+	/**
+	 * @ptdev: Backpointer to the Panthor device, needed to ring the global doorbell and
+	 *         interface with FW.
+	 */
+	struct panthor_device *ptdev;
+};
+
+struct panthor_perf_fw_block_iter {
+	const struct panthor_perf *perf_ctx;
+	enum drm_panthor_perf_block_type type;
+	u32 idx;
+	size_t offset;
 };
 
 struct panthor_perf_pool {
@@ -179,6 +359,37 @@ static size_t get_annotated_block_size(size_t counters_per_block)
 	return struct_size_t(struct panthor_perf_counter_block, counters, counters_per_block);
 }
 
+static void
+sample_block_iter_init(const struct drm_panthor_perf_info *info,
+		       const struct panthor_perf_enable_masks *masks,
+		       const u8 *src, u8 *dst,
+		       struct panthor_perf_sample_block_iter *iter)
+{
+	const size_t sample_header_size = info->sample_header_size;
+
+	*iter = (struct panthor_perf_sample_block_iter) {
+		.src = src + sample_header_size,
+		.dst = dst + sample_header_size,
+		.data_size = info->sample_size - sample_header_size,
+		.block_size = get_annotated_block_size(info->counters_per_block),
+		.masks = masks,
+		.counters = info->counters_per_block,
+	};
+}
+
+static bool sample_block_iter_next(struct panthor_perf_sample_block_iter *iter)
+{
+	if (iter->offset >= iter->data_size)
+		return false;
+
+	iter->src_blk = (const struct panthor_perf_counter_block *)(iter->src + iter->offset);
+	iter->dst_blk = (struct panthor_perf_counter_block *)(iter->dst + iter->offset);
+	iter->requested_mask = iter->masks->mask[iter->src_blk->header.block_type];
+	iter->offset += iter->block_size;
+
+	return true;
+}
+
 static size_t session_get_sample_size(const struct drm_panthor_perf_info *const info)
 {
 	const size_t block_size = get_annotated_block_size(info->counters_per_block);
@@ -232,6 +443,15 @@ panthor_perf_init_em(struct panthor_perf_session *session,
 			  create_args->shader_enable_mask, PANTHOR_PERF_EM_BITS);
 }
 
+static void panthor_perf_em_add(struct panthor_perf_enable_masks *const dst_em,
+				const struct panthor_perf_enable_masks *const src_em)
+{
+	size_t i = 0;
+
+	for (i = DRM_PANTHOR_PERF_BLOCK_FIRST; i <= DRM_PANTHOR_PERF_BLOCK_LAST; i++)
+		bitmap_or(dst_em->mask[i], dst_em->mask[i], src_em->mask[i], PANTHOR_PERF_EM_BITS);
+}
+
 static int
 panthor_perf_bo_get(struct drm_file *file, u32 handle, size_t min_size,
 		    struct panthor_perf_bo *bo)
@@ -342,6 +562,292 @@ session_from_handle(struct panthor_perf_pool *pool, unsigned long handle)
 	return session;
 }
 
+static u32 compress_enable_mask(u32 counters, const unsigned long *const src)
+{
+	size_t i;
+	u32 result = 0;
+	const unsigned long ctr_per_bit = counters / BITS_PER_TYPE(u32);
+
+	for_each_set_bit(i, src, counters) {
+		const unsigned long pos = div_u64(i, ctr_per_bit);
+
+		result |= BIT(pos);
+	}
+
+	return result;
+}
+
+static void expand_enable_mask(u32 counters, u32 em, unsigned long *const dst)
+{
+	size_t i;
+	const unsigned long ctrs_per_bit = counters / BITS_PER_TYPE(u32);
+	DECLARE_BITMAP(emb, BITS_PER_TYPE(u32));
+
+	bitmap_from_arr32(emb, &em, BITS_PER_TYPE(u32));
+
+	for_each_set_bit(i, emb, BITS_PER_TYPE(u32))
+		bitmap_set(dst, i * ctrs_per_bit, ctrs_per_bit);
+}
+
+static inline bool
+panthor_perf_fw_block_iter_valid(struct panthor_perf_fw_block_iter *iter)
+{
+	const struct panthor_perf *perf = iter->perf_ctx;
+
+	while (iter->type < DRM_PANTHOR_PERF_BLOCK_MAX) {
+		if (iter->idx < perf->blocks[iter->type].block_count)
+			return true;
+
+		iter->type++;
+		iter->idx = 0;
+	}
+
+	return false;
+}
+
+static void panthor_perf_handle_fw_samples(struct panthor_device *ptdev,
+					   u32 extract_idx, u32 insert_idx)
+{
+	struct panthor_perf *perf = ptdev->perf;
+	const size_t ann_block_size =
+		get_annotated_block_size(ptdev->perf_info.counters_per_block);
+	u32 i;
+
+	for (i = extract_idx; i != insert_idx; i++) {
+		u32 slot = i % perf->sample_slots;
+		u8 *fw_sample = (u8 *)perf->rb->kmap + slot * perf->fw_sample_size;
+		struct panthor_perf_fw_block_iter fw_iter = { .perf_ctx = perf };
+		size_t ann_off = ptdev->perf_info.sample_header_size;
+
+		for (; panthor_perf_fw_block_iter_valid(&fw_iter);
+		     fw_iter.offset += fw_iter.perf_ctx->fw_block_size, fw_iter.idx++) {
+			struct panthor_perf_counter_block *blk =
+				(typeof(blk))(perf->sample + ann_off);
+			u32 *const block = (u32 *)(fw_sample + fw_iter.offset);
+			const u32 prfcnt_en = block[PANTHOR_CTR_PRFCNT_EN];
+
+			if (fw_iter.type == DRM_PANTHOR_PERF_BLOCK_METADATA) {
+				/*
+				 * The host must clear the SAMPLE_REASON to acknowledge it has
+				 * consumed the sample.
+				 */
+				block[PANTHOR_CTR_SAMPLE_REASON] = 0;
+				continue;
+			}
+
+			if (!(perf->blocks[fw_iter.type].phys_mask & BIT_ULL(fw_iter.idx)))
+				continue;
+
+			blk->header = (struct drm_panthor_perf_block_header) {
+				.block_idx = fw_iter.idx,
+				.block_type = fw_iter.type,
+			};
+
+			if (prfcnt_en == 0)
+				goto advance_block;
+
+			/*
+			 * The four header counters must be treated differently, because they are
+			 * not additive. For the fourth, the assignment does not matter, as it
+			 * is reserved and should be zero.
+			 */
+			blk->counters[PANTHOR_CTR_TIMESTAMP_LO] = block[PANTHOR_CTR_TIMESTAMP_LO];
+			blk->counters[PANTHOR_CTR_TIMESTAMP_HI] = block[PANTHOR_CTR_TIMESTAMP_HI];
+			blk->counters[PANTHOR_CTR_PRFCNT_EN] = block[PANTHOR_CTR_PRFCNT_EN];
+
+			/*
+			 * The host must clear PRFCNT_EN to acknowledge it has consumed the sample.
+			 */
+			block[PANTHOR_CTR_PRFCNT_EN] = 0;
+
+			if (prfcnt_en == 1)
+				goto advance_block;
+
+			for (size_t k = PANTHOR_HEADER_COUNTERS;
+			     k < ptdev->perf_info.counters_per_block; k++)
+				blk->counters[k] += block[k];
+
+advance_block:
+			ann_off += ann_block_size;
+		}
+
+		perf->last_fw_sample_time = ktime_get_raw_ns();
+	}
+}
+
+static size_t panthor_perf_get_fw_reported_size(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+
+	size_t fw_size = GLB_PERFCNT_FW_SIZE(glb_iface->control->perfcnt_size);
+	size_t hw_size = GLB_PERFCNT_HW_SIZE(glb_iface->control->perfcnt_size);
+	size_t md_size = PERFCNT_FEATURES_MD_SIZE(glb_iface->control->perfcnt_features);
+
+	return md_size + fw_size + hw_size;
+}
+
+static size_t get_reserved_sc_blocks(struct panthor_device *ptdev)
+{
+	const u64 sc_mask = ptdev->gpu_info.shader_present;
+
+	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 14)
+		return fls64(sc_mask);
+
+	return ptdev->perf_info.shader_blocks;
+}
+
+static u64 panthor_perf_block_mask(u64 block_count)
+{
+	return GENMASK_ULL(block_count ? block_count - 1 : 0, 0);
+}
+
+static u64 get_sc_mask(struct panthor_device *ptdev)
+{
+	const u64 sc_mask = ptdev->gpu_info.shader_present;
+
+	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 14)
+		return sc_mask;
+
+	return panthor_perf_block_mask(hweight64(sc_mask));
+}
+
+static int panthor_perf_setup_fw_buffer(struct panthor_device *ptdev, struct panthor_perf *perf)
+{
+	struct drm_panthor_perf_info *info = &ptdev->perf_info;
+	const size_t block_size = info->counters_per_block * PANTHOR_HW_COUNTER_SIZE;
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	const size_t reported_sample_size = panthor_perf_get_fw_reported_size(ptdev);
+	const bool has_metadata = PERFCNT_FEATURES_MD_SIZE(glb_iface->control->perfcnt_features);
+	const struct panthor_perf_fw_block blocks[DRM_PANTHOR_PERF_BLOCK_MAX] = {
+		[DRM_PANTHOR_PERF_BLOCK_METADATA] = {
+			.block_count = has_metadata ? 1 : 0,
+			.phys_mask = has_metadata ? BIT_ULL(0) : 0,
+		},
+		[DRM_PANTHOR_PERF_BLOCK_FW] = {
+			.block_count = info->fw_blocks,
+			.phys_mask = info->fw_blocks ? panthor_perf_block_mask(info->fw_blocks) : 0,
+		},
+		[DRM_PANTHOR_PERF_BLOCK_CSHW] = {
+			.block_count = info->cshw_blocks,
+			.phys_mask = panthor_perf_block_mask(info->cshw_blocks),
+		},
+		[DRM_PANTHOR_PERF_BLOCK_TILER] = {
+			.block_count = info->tiler_blocks,
+			.phys_mask = panthor_perf_block_mask(info->tiler_blocks),
+		},
+		[DRM_PANTHOR_PERF_BLOCK_MEMSYS] = {
+			.block_count = info->memsys_blocks,
+			.phys_mask = panthor_perf_block_mask(info->memsys_blocks),
+		},
+		[DRM_PANTHOR_PERF_BLOCK_SHADER] = {
+			.block_count = get_reserved_sc_blocks(ptdev),
+			.phys_mask = get_sc_mask(ptdev),
+		},
+	};
+	size_t offset = 0;
+
+	for (enum drm_panthor_perf_block_type type = 0; type < DRM_PANTHOR_PERF_BLOCK_MAX; type++)
+		offset += blocks[type].block_count * block_size;
+
+	if (offset != reported_sample_size) {
+		drm_warn(&ptdev->base,
+			 "Could not align fw and kernel perf buffers, feature disabled.");
+		return -EINVAL;
+	}
+
+	memcpy(perf->blocks, blocks, sizeof(blocks));
+	perf->fw_block_size = block_size;
+	perf->fw_sample_size = offset;
+
+	return 0;
+}
+
+static int panthor_perf_fw_stop_sampling(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	u32 ack, acked, req;
+	int ret;
+
+	req = READ_ONCE(glb_iface->input->req);
+	ack = READ_ONCE(glb_iface->output->ack);
+	if ((req ^ ack) & GLB_PERFCNT_EN)
+		return -EAGAIN;
+
+	if (!(ack & GLB_PERFCNT_EN))
+		return 0;
+
+	panthor_fw_update_reqs(glb_iface, req, 0, GLB_PERFCNT_EN);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
+	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PERFCNT_EN, &acked, 100);
+	if (ret)
+		drm_warn(&ptdev->base, "Could not disable performance counters");
+
+	return ret;
+}
+
+static void panthor_perf_fw_write_config(struct panthor_perf *perf)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(perf->ptdev);
+	const u32 counters = perf->info->counters_per_block;
+	const struct panthor_perf_enable_masks *const em = perf->em;
+	u32 perfcnt_config;
+
+	glb_iface->input->perfcnt_csf_enable =
+		compress_enable_mask(counters, em->mask[DRM_PANTHOR_PERF_BLOCK_CSHW]);
+	glb_iface->input->perfcnt_shader_enable =
+		compress_enable_mask(counters, em->mask[DRM_PANTHOR_PERF_BLOCK_SHADER]);
+	glb_iface->input->perfcnt_mmu_l2_enable =
+		compress_enable_mask(counters, em->mask[DRM_PANTHOR_PERF_BLOCK_MEMSYS]);
+	glb_iface->input->perfcnt_tiler_enable =
+		compress_enable_mask(counters, em->mask[DRM_PANTHOR_PERF_BLOCK_TILER]);
+	glb_iface->input->perfcnt_fw_enable =
+		compress_enable_mask(counters, em->mask[DRM_PANTHOR_PERF_BLOCK_FW]);
+	glb_iface->input->perfcnt_csg_enable = 0;
+
+	WRITE_ONCE(glb_iface->input->perfcnt_as, panthor_vm_as(panthor_fw_vm(perf->ptdev)));
+	WRITE_ONCE(glb_iface->input->perfcnt_base, panthor_kernel_bo_gpuva(perf->rb));
+
+	perfcnt_config = GLB_PERFCNT_CONFIG_SIZE(perf_ringbuf_slots);
+	perfcnt_config |= GLB_PERFCNT_CONFIG_SET(perf->set_config);
+
+	if (PERFCNT_FEATURES_MD_SIZE(glb_iface->control->perfcnt_features))
+		perfcnt_config |= GLB_PERFCNT_METADATA_ENABLE;
+
+	WRITE_ONCE(glb_iface->input->perfcnt_config, perfcnt_config);
+}
+
+static int panthor_perf_fw_start_sampling(struct panthor_device *ptdev)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	u32 ack, acked, req;
+	int ret;
+
+	req = READ_ONCE(glb_iface->input->req);
+	ack = READ_ONCE(glb_iface->output->ack);
+	if ((req ^ ack) & GLB_PERFCNT_EN)
+		return -EAGAIN;
+
+	if (ack & GLB_PERFCNT_EN)
+		return 0;
+
+	panthor_perf_fw_write_config(ptdev->perf);
+
+	/*
+	 * The spec mandates that the host zero the PRFCNT_EXTRACT register before an enable
+	 * operation, and each (re-)enable will require an enable-disable pair to program
+	 * the new changes onto the FW interface.
+	 */
+	WRITE_ONCE(glb_iface->input->perfcnt_extract, 0);
+
+	panthor_fw_update_reqs(glb_iface, req, GLB_PERFCNT_EN, GLB_PERFCNT_EN);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
+	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PERFCNT_EN, &acked, 100);
+	if (ret)
+		drm_warn(&ptdev->base, "Could not enable performance counters");
+
+	return ret;
+}
+
 #define DEFINE_SESSION_STATE_CHECK(name, _state)			     \
 	static bool session_is_## name(struct panthor_perf_session *session) \
 	{								     \
@@ -353,6 +859,7 @@ session_from_handle(struct panthor_perf_pool *pool, unsigned long handle)
 DEFINE_SESSION_STATE_CHECK(active, PANTHOR_PERF_SESSION_ACTIVE);
 DEFINE_SESSION_STATE_CHECK(starting, PANTHOR_PERF_SESSION_STARTING);
 DEFINE_SESSION_STATE_CHECK(stopping, PANTHOR_PERF_SESSION_STOPPING);
+DEFINE_SESSION_STATE_CHECK(stopped, PANTHOR_PERF_SESSION_STOPPED);
 DEFINE_SESSION_STATE_CHECK(destroy, PANTHOR_PERF_SESSION_DESTROY);
 
 static bool session_has_overflow(struct panthor_perf_session *session)
@@ -378,6 +885,13 @@ static u64 session_read_extract_idx(struct panthor_perf_session *session)
 	return smp_load_acquire(&session->control->extract_idx);
 }
 
+static void session_write_insert_idx(struct panthor_perf_session *session, u64 idx)
+{
+	/* Userspace needs the insert index to know where to look for the sample. */
+	smp_store_release(&session->control->insert_idx, idx);
+	session->insert_idx = idx;
+}
+
 static bool session_has_space(struct panthor_perf_session *session, u32 needed)
 {
 	const u64 insert = session->insert_idx;
@@ -387,6 +901,382 @@ static bool session_has_space(struct panthor_perf_session *session, u32 needed)
 	       insert - extract <= session->ringbuf_slots - needed;
 }
 
+/**
+ * session_accumulate_sample - Accumulate requested counters into an existing sample.
+ * @ptdev: Panthor device.
+ * @session: Perf session.
+ * @session_sample: Start of the destination sample, including its header.
+ * @perf_sample: Start of the intermediate sample, including its header.
+ *
+ * Firmware enable masks select groups of counters. Copy timestamps and accumulate
+ * only the counters requested by this session.
+ */
+static void session_accumulate_sample(struct panthor_device *ptdev,
+				      struct panthor_perf_session *session,
+				      u8 *session_sample, u8 *perf_sample)
+{
+	const struct drm_panthor_perf_info *const perf_info = &ptdev->perf_info;
+	struct panthor_perf_sample_block_iter iter;
+
+	sample_block_iter_init(perf_info, &session->enabled_counters, perf_sample,
+			       session_sample, &iter);
+
+	while (sample_block_iter_next(&iter)) {
+		const struct panthor_perf_counter_block *src_blk = iter.src_blk;
+		struct panthor_perf_counter_block *dst_blk = iter.dst_blk;
+		unsigned int i = PANTHOR_HEADER_COUNTERS;
+
+		dst_blk->counters[PANTHOR_CTR_TIMESTAMP_HI] =
+			src_blk->counters[PANTHOR_CTR_TIMESTAMP_HI];
+		dst_blk->counters[PANTHOR_CTR_TIMESTAMP_LO] =
+			src_blk->counters[PANTHOR_CTR_TIMESTAMP_LO];
+
+		for_each_set_bit_from(i, iter.requested_mask, iter.counters)
+			dst_blk->counters[i] += src_blk->counters[i];
+	}
+}
+
+static void perf_fw_request_sample(struct panthor_perf *perf)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(perf->ptdev);
+	bool sample;
+
+	scoped_guard(spinlock_irqsave, &perf->pend_lock) {
+		sample = !perf->fw_sample_requested;
+
+		if (sample)
+			perf->fw_sample_requested = true;
+	}
+
+	if (sample) {
+		panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PERFCNT_SAMPLE);
+		panthor_fw_ring_doorbell(perf->ptdev, CSF_GLB_DOORBELL_ID);
+	}
+}
+
+/**
+ * session_populate_sample - Populate a new userspace sample slot.
+ * @ptdev: Panthor device.
+ * @session: Perf session.
+ * @session_sample: Start of the destination sample, including its header.
+ * @perf_sample: Start of the intermediate sample, including its header.
+ *
+ * Copy the counter blocks and clear counters not requested by this session.
+ * Update each block's PRFCNT_EN value to reflect this session's enable mask.
+ * The sample header is filled when the sample is published.
+ */
+static void session_populate_sample(struct panthor_device *ptdev,
+				    struct panthor_perf_session *session, u8 *session_sample,
+				    u8 *perf_sample)
+{
+	const struct drm_panthor_perf_info *const perf_info = &ptdev->perf_info;
+	struct panthor_perf_sample_block_iter iter;
+	const size_t sample_header_size = perf_info->sample_header_size;
+	const size_t data_size = perf_info->sample_size - sample_header_size;
+
+	memcpy(session_sample + sample_header_size, perf_sample + sample_header_size, data_size);
+
+	sample_block_iter_init(perf_info, &session->enabled_counters, perf_sample,
+			       session_sample, &iter);
+
+	while (sample_block_iter_next(&iter)) {
+		DECLARE_BITMAP(enabled_ctrs, PANTHOR_PERF_EM_BITS);
+		struct panthor_perf_counter_block *blk = iter.dst_blk;
+		unsigned int i;
+
+		bitmap_zero(enabled_ctrs, PANTHOR_PERF_EM_BITS);
+		expand_enable_mask(iter.counters, iter.src_blk->counters[PANTHOR_CTR_PRFCNT_EN],
+				   enabled_ctrs);
+		bitmap_clear(enabled_ctrs, 0, PANTHOR_HEADER_COUNTERS);
+
+		blk->counters[PANTHOR_CTR_PRFCNT_EN] =
+			compress_enable_mask(iter.counters, iter.requested_mask);
+
+		for_each_andnot_bit(i, enabled_ctrs, iter.requested_mask, iter.counters)
+			blk->counters[i] = 0;
+	}
+}
+
+static void session_copy_sample(struct panthor_device *ptdev,
+				struct panthor_perf_session *session, u32 flags)
+{
+	struct panthor_perf *perf = ptdev->perf;
+	const size_t sample_size = ptdev->perf_info.sample_size;
+	const u64 insert_idx = session->insert_idx;
+	u8 *new_sample;
+
+	scoped_guard(spinlock_irqsave, &session->state_lock) {
+		if (!session_is_active(session) && !session_is_stopping(session))
+			return;
+
+		if (flags & DRM_PANTHOR_PERF_SAMPLE_OVERFLOW)
+			session->overflow = true;
+		session->sample_flags |= flags;
+	}
+
+	new_sample = session->samples + (insert_idx % session->ringbuf_slots) * sample_size;
+
+	if (session->accum_idx != insert_idx) {
+		session_populate_sample(ptdev, session, new_sample, perf->sample);
+		session->accum_idx = insert_idx;
+	} else {
+		session_accumulate_sample(ptdev, session, new_sample, perf->sample);
+	}
+}
+
+static void session_publish_sample(struct panthor_perf *perf,
+				   struct panthor_perf_session *session)
+{
+	const struct drm_panthor_perf_info *const info = &perf->ptdev->perf_info;
+	u8 *sample = session->samples +
+		(session->insert_idx % session->ringbuf_slots) * info->sample_size;
+	struct drm_panthor_perf_sample_header *hdr = (typeof(hdr))sample;
+
+	*hdr = (struct drm_panthor_perf_sample_header) {
+		.user_data = session->user_data,
+		.timestamp_start_ns = session->sample_start_ns,
+		.timestamp_end_ns = perf->last_fw_sample_time,
+		.flags = session->sample_flags,
+	};
+
+	session_write_insert_idx(session, session->insert_idx + 1);
+
+	/* Since we are about to notify userspace, we must ensure that all changes to memory
+	 * are visible.
+	 */
+	wmb();
+
+	eventfd_signal(session->eventfd);
+	session->sample_flags = 0;
+}
+
+static void session_emit_sample(struct panthor_perf *perf, struct panthor_perf_session *session)
+{
+	guard(spinlock_irqsave)(&session->state_lock);
+
+	if (session_is_starting(session)) {
+		session_set_state(session, PANTHOR_PERF_SESSION_ACTIVE);
+		goto update_session;
+	}
+
+	if (session_is_stopping(session)) {
+		session_publish_sample(perf, session);
+		goto handle_stopping;
+	}
+
+	if (!session_is_active(session))
+		return;
+
+	if (session->pending_sample) {
+		session->pending_sample = false;
+		session_publish_sample(perf, session);
+		goto update_session;
+	}
+
+	return;
+
+handle_stopping:
+	if (session_is_stopping(session))
+		session_set_state(session, PANTHOR_PERF_SESSION_STOPPED);
+
+update_session:
+	session->sample_start_ns = perf->last_fw_sample_time;
+	wake_up_all(&session->state_wq);
+}
+
+static void panthor_perf_handle_fw_events(struct panthor_perf *perf)
+{
+	struct panthor_device *const ptdev = perf->ptdev;
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	const u32 extract_idx = READ_ONCE(glb_iface->input->perfcnt_extract);
+	const u32 insert_idx = READ_ONCE(glb_iface->output->perfcnt_insert);
+	const u32 ack = READ_ONCE(glb_iface->output->ack);
+	const u32 req = READ_ONCE(glb_iface->input->req);
+	const u32 events = (req ^ ack) & (GLB_PERFCNT_THRESHOLD | GLB_PERFCNT_OVERFLOW);
+	const u32 flags = events & GLB_PERFCNT_OVERFLOW ? DRM_PANTHOR_PERF_SAMPLE_OVERFLOW : 0;
+
+	if (panthor_device_reset_is_pending(ptdev)) {
+		queue_work(perf->sample_workq, &perf->sample_work);
+		return;
+	}
+
+	if ((u32)(insert_idx - extract_idx) > perf->sample_slots) {
+		drm_warn_once(&ptdev->base, "Perf FW ring distance exceeds capacity\n");
+		return;
+	}
+
+	if (extract_idx == insert_idx)
+		goto ack_events;
+
+	panthor_perf_handle_fw_samples(ptdev, extract_idx, insert_idx);
+	WRITE_ONCE(glb_iface->input->perfcnt_extract, insert_idx);
+
+	scoped_guard(mutex, &perf->session_lock) {
+		struct panthor_perf_session *session;
+
+		list_for_each_entry(session, &perf->session_list, sessions)
+			session_copy_sample(ptdev, session, flags);
+
+		list_for_each_entry(session, &perf->session_list, sessions)
+			session_emit_sample(perf, session);
+	}
+
+	memset(perf->sample, 0, ptdev->perf_info.sample_size);
+
+ack_events:
+	if (events)
+		panthor_fw_update_reqs(glb_iface, req, ack, events);
+}
+
+void panthor_perf_report_irq(struct panthor_device *ptdev, u32 status)
+{
+	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
+	struct panthor_perf *const perf = ptdev->perf;
+
+	if (!(status & JOB_INT_GLOBAL_IF))
+		return;
+
+	if (!perf)
+		return;
+
+	const u32 ack = READ_ONCE(glb_iface->output->ack);
+	const u32 req = READ_ONCE(glb_iface->input->req);
+	const u32 events = (req ^ ack) & (GLB_PERFCNT_THRESHOLD | GLB_PERFCNT_OVERFLOW);
+	const bool sample_acked = ((req & GLB_PERFCNT_SAMPLE) == (ack & GLB_PERFCNT_SAMPLE));
+	const u32 extract_idx = READ_ONCE(glb_iface->input->perfcnt_extract);
+	const u32 insert_idx = READ_ONCE(glb_iface->output->perfcnt_insert);
+	const bool has_sample = sample_acked && insert_idx != extract_idx;
+
+	if (sample_acked) {
+		guard(spinlock_irqsave)(&perf->pend_lock);
+		perf->fw_sample_requested = false;
+	}
+
+	if (events || has_sample)
+		queue_work(perf->sample_workq, &perf->sample_work);
+}
+
+static int perf_enable(struct panthor_perf *perf)
+{
+	lockdep_assert_held(&perf->op_lock);
+
+	guard(mutex)(&perf->session_lock);
+
+	if (list_empty(&perf->session_list))
+		return 0;
+
+	return panthor_perf_fw_start_sampling(perf->ptdev);
+}
+
+static int perf_disable(struct panthor_perf *perf)
+{
+	lockdep_assert_held(&perf->op_lock);
+
+	return panthor_perf_fw_stop_sampling(perf->ptdev);
+}
+
+static void compute_enable_mask(struct panthor_perf *perf)
+{
+	lockdep_assert_held(&perf->session_lock);
+
+	struct list_head *snode;
+	struct panthor_perf_enable_masks em = {};
+
+	list_for_each(snode, &perf->session_list)
+	{
+		struct panthor_perf_session *session =
+			container_of(snode, typeof(*session), sessions);
+
+		panthor_perf_em_add(&em, &session->enabled_counters);
+	}
+
+	*perf->em = em;
+}
+
+static void perf_attach_session(struct panthor_perf *perf, struct panthor_perf_session *session)
+{
+	lockdep_assert_held(&perf->session_lock);
+
+	session_get(session);
+	list_add_tail(&session->sessions, &perf->session_list);
+	compute_enable_mask(perf);
+}
+
+static void perf_detach_sessions(struct panthor_perf *perf)
+{
+	struct panthor_perf_session *session, *tmp;
+	bool retired = false;
+
+	guard(mutex)(&perf->session_lock);
+
+	list_for_each_entry_safe(session, tmp, &perf->session_list, sessions) {
+		bool teardown;
+
+		scoped_guard(spinlock_irqsave, &session->state_lock)
+			teardown = session_is_destroy(session);
+		if (!teardown)
+			continue;
+
+		list_del_init(&session->sessions);
+		session_put(session);
+		retired = true;
+	}
+
+	if (retired)
+		compute_enable_mask(perf);
+}
+
+static void panthor_perf_sample_worker(struct work_struct *work)
+{
+	struct panthor_perf *perf = container_of(work, struct panthor_perf, sample_work);
+
+	panthor_perf_handle_fw_events(perf);
+
+	perf_detach_sessions(perf);
+}
+
+static void perf_sync_work(struct panthor_perf *perf)
+{
+	lockdep_assert_not_held(&perf->session_lock);
+
+	queue_work(perf->sample_workq, &perf->sample_work);
+	flush_work(&perf->sample_work);
+}
+
+static int panthor_perf_session_add(struct panthor_perf *perf,
+				    struct panthor_perf_session *session, u8 set)
+{
+	int ret = 0;
+
+	guard(mutex)(&perf->op_lock);
+
+	scoped_guard(mutex, &perf->session_lock) {
+		if (!list_empty(&perf->session_list))
+			return -EBUSY;
+
+		perf->set_config = set;
+	}
+
+	ret = perf_disable(perf);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &perf->session_lock)
+		perf_attach_session(perf, session);
+
+	ret = perf_enable(perf);
+	if (ret)
+		goto drop_session_ref;
+
+	return ret;
+drop_session_ref:
+	scoped_guard(spinlock_irqsave, &session->state_lock)
+		session_set_state(session, PANTHOR_PERF_SESSION_DESTROY);
+	perf_sync_work(perf);
+
+	return ret;
+}
+
 /**
  * panthor_perf_init - Initialize the performance counter subsystem.
  * @ptdev: Panthor device
@@ -399,6 +1289,9 @@ static bool session_has_space(struct panthor_perf_session *session, u32 needed)
 int panthor_perf_init(struct panthor_device *ptdev)
 {
 	struct panthor_perf *perf;
+	struct panthor_kernel_bo *bo;
+	struct panthor_perf_enable_masks *em;
+	u8 *sample;
 	int ret;
 
 	if (!ptdev)
@@ -410,16 +1303,112 @@ int panthor_perf_init(struct panthor_device *ptdev)
 	if (!perf)
 		return -ENOMEM;
 
+	ret = panthor_perf_setup_fw_buffer(ptdev, perf);
+	if (ret) {
+		drm_err(&ptdev->base,
+			"Failed to setup FW ring buffer, disabling perf.");
+		drmm_kfree(&ptdev->base, perf);
+		return 0;
+	}
+
 	ret = drmm_mutex_init(&ptdev->base, &perf->op_lock);
 	if (ret)
 		return ret;
 
+	ret = drmm_mutex_init(&ptdev->base, &perf->session_lock);
+	if (ret)
+		return ret;
+
+	sample = drmm_kzalloc(&ptdev->base, ptdev->perf_info.sample_size, GFP_KERNEL);
+	if (!sample)
+		return -ENOMEM;
+
+	em = drmm_kzalloc(&ptdev->base, sizeof(*em), GFP_KERNEL);
+	if (!em)
+		return -ENOMEM;
+
+	spin_lock_init(&perf->pend_lock);
+
+	bo = panthor_kernel_bo_create(ptdev, panthor_fw_vm(ptdev),
+				      perf->fw_sample_size * perf_ringbuf_slots,
+				      DRM_PANTHOR_BO_NO_MMAP,
+				      DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC |
+				      DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED,
+				      PANTHOR_VM_KERNEL_AUTO_VA,
+				      "perf_ringbuf");
+
+	if (IS_ERR_OR_NULL(bo))
+		return IS_ERR(bo) ? PTR_ERR(bo) : -ENOMEM;
+
+	ret = panthor_kernel_bo_vmap(bo);
+	if (ret)
+		goto cleanup_bo;
+
+	perf->sample_workq = alloc_workqueue("panthor_perf_wq", WQ_HIGHPRI | WQ_UNBOUND, 1);
+	if (!perf->sample_workq) {
+		ret = -ENOMEM;
+		goto cleanup_vmap;
+	}
+
+	ret = drmm_add_action_or_reset(&ptdev->base, __drmm_workqueue_release,
+				       perf->sample_workq);
+	if (ret)
+		goto cleanup_vmap;
+
+	INIT_WORK(&perf->sample_work, panthor_perf_sample_worker);
+	perf->rb = bo;
+	perf->sample = sample;
+	perf->sample_slots = perf_ringbuf_slots;
+	perf->em = em;
+	perf->last_fw_sample_time = ktime_get_raw_ns();
+
+	INIT_LIST_HEAD(&perf->session_list);
+
 	drm_info(&ptdev->base, "Performance counter subsystem initialized");
 
 	perf->info = &ptdev->perf_info;
+	perf->ptdev = ptdev;
 	ptdev->perf = perf;
 
 	return ret;
+
+cleanup_vmap:
+	panthor_kernel_bo_vunmap(bo);
+
+cleanup_bo:
+	panthor_kernel_bo_destroy(bo);
+
+	return ret;
+}
+
+typedef bool (*session_state_cb)(struct panthor_perf_session *session);
+
+/**
+ * panthor_perf_request_sync - Request synchronous sample causing
+ * @perf: Perf struct
+ * @session: Target session
+ * @cb: Callback for the expected state of the session at the end of a sample.
+ *
+ * Perform a synchronous sample for scenarios where the sample must complete for the user to
+ * unambiguously know the state of the session. The two cases where this may be used are:
+ * - starting a new session (initial samples): any data from before this sample must not show up
+ *   in a new sampling session.
+ * - stopping an existing session: the eventfd may already have been signalled, meaning the
+ *   user may not find out when the session is stopped and continue waiting for more samples.
+ *
+ * Return: 0 on success, -ETIMEDOUT on wait failure
+ */
+static int panthor_perf_request_sync(struct panthor_perf *perf,
+				     struct panthor_perf_session *session, session_state_cb cb)
+{
+	int ret;
+
+	perf_fw_request_sample(perf);
+
+	ret = wait_event_timeout(session->state_wq, cb(session),
+				 msecs_to_jiffies(1000));
+
+	return ret ? 0 : -ETIMEDOUT;
 }
 
 /**
@@ -497,6 +1486,7 @@ int panthor_perf_session_create(struct drm_file *file,
 
 	kref_init(&session->ref);
 	INIT_LIST_HEAD(&session->sessions);
+	init_waitqueue_head(&session->state_wq);
 	spin_lock_init(&session->state_lock);
 	session->control = control.vaddr;
 	*session->control = (struct drm_panthor_perf_ringbuf_control) { 0 };
@@ -507,6 +1497,14 @@ int panthor_perf_session_create(struct drm_file *file,
 	session->control_buf = control;
 	session->accum_idx = U64_MAX;
 
+	ret = pm_runtime_resume_and_get(ptdev->base.dev);
+	if (ret)
+		goto cleanup_obj;
+
+	ret = panthor_perf_session_add(ptdev->perf, session, create_args->block_set);
+	if (ret)
+		goto cleanup_pm;
+
 	xa_lock(&pool->xa);
 	__xa_store(&pool->xa, session_id, session, GFP_NOWAIT);
 	__xa_set_mark(&pool->xa, session_id, SESSION_REGISTERED);
@@ -515,6 +1513,13 @@ int panthor_perf_session_create(struct drm_file *file,
 	*sid = session_id;
 	return 0;
 
+cleanup_pm:
+	pm_runtime_put(ptdev->base.dev);
+
+cleanup_obj:
+	session_put(session);
+	goto cleanup_session_id;
+
 cleanup_control:
 	panthor_perf_bo_put(&control);
 
@@ -537,12 +1542,12 @@ int panthor_perf_session_create(struct drm_file *file,
  * @user_data: User data to set if the STOPPING state is successfully set.
  *
  * Only sessions in a stable ACTIVE state with no pending samples and at least one slot in the user
- * facing ring buffer can be transition to the transitional STOPPING state. The session gets
+ * facing ring buffer can transition to the transitional STOPPING state. The session gets
  * transitioned from STOPPING to STOPPED by the worker after emitting a final sample.
  *
  * Return:
- *  - 0 to request a new sample and wait,
- *  - 1 to skip the re-request and go directly to wait
+ *  - 0 if no state transition or wait is needed,
+ *  - 1 if the caller should wait for the state transition to complete,
  *  - negative error code on invalid transitions or state
  */
 static int session_try_stop(struct panthor_perf_session *session, u64 user_data)
@@ -571,6 +1576,13 @@ static int session_try_stop(struct panthor_perf_session *session, u64 user_data)
 	return 1;
 }
 
+static bool session_is_stopped_locked(struct panthor_perf_session *session)
+{
+	guard(spinlock_irqsave)(&session->state_lock);
+
+	return session_is_stopped(session) || session_is_destroy(session);
+}
+
 static int session_stop(struct panthor_perf *perf, struct panthor_perf_session *session,
 			u64 user_data)
 {
@@ -582,8 +1594,7 @@ static int session_stop(struct panthor_perf *perf, struct panthor_perf_session *
 	if (ret <= 0)
 		return ret;
 
-	/* TODO Calls to the FW interface will go here in later patches. */
-	return 0;
+	return panthor_perf_request_sync(perf, session, session_is_stopped_locked);
 }
 
 /**
@@ -597,8 +1608,8 @@ static int session_stop(struct panthor_perf *perf, struct panthor_perf_session *
  * gets transitioned to ACTIVE via the worker after a clearing sample.
  *
  * Return:
- *  - 0 to request a new sample and wait,
- *  - 1 to skip the re-request and go directly to wait
+ *  - 0 if no state transition or wait is needed,
+ *  - 1 if the caller should wait for the state transition to complete,
  *  - negative error code on invalid transitions or state
  */
 static int session_try_start(struct panthor_perf_session *session, u64 user_data)
@@ -631,6 +1642,13 @@ static int session_try_start(struct panthor_perf_session *session, u64 user_data
 	return 1;
 }
 
+static bool session_is_active_locked(struct panthor_perf_session *session)
+{
+	guard(spinlock_irqsave)(&session->state_lock);
+
+	return session_is_active(session);
+}
+
 static int session_start(struct panthor_perf *perf, struct panthor_perf_session *session,
 			 u64 user_data)
 {
@@ -642,8 +1660,7 @@ static int session_start(struct panthor_perf *perf, struct panthor_perf_session
 	if (ret <= 0)
 		return ret;
 
-	/* TODO Calls to the FW interface will go here in later patches. */
-	return 0;
+	return panthor_perf_request_sync(perf, session, session_is_active_locked);
 }
 
 /**
@@ -657,8 +1674,7 @@ static int session_start(struct panthor_perf *perf, struct panthor_perf_session
  * stop the session and restart sampling.
  *
  * Return:
- *  - 0 to request a new sample and wait,
- *  - 1 to skip the re-request and go directly to wait
+ *  - 1 if the caller should wait for the sample to complete,
  *  - negative error code on invalid transitions or state
  */
 static int session_try_sample(struct panthor_perf_session *session, u64 user_data)
@@ -703,7 +1719,8 @@ static int session_sample(struct panthor_perf *perf, struct panthor_perf_session
 	if (ret <= 0)
 		return ret;
 
-	/* TODO Calls to the FW interface will go here in later patches. */
+	perf_fw_request_sample(perf);
+
 	return 0;
 }
 
@@ -756,6 +1773,12 @@ int panthor_perf_session_destroy(struct panthor_file *pfile, u32 handle)
 		return ret;
 
 	session_put(session);
+	scoped_guard(mutex, &perf->op_lock) {
+		perf_disable(perf);
+		perf_sync_work(perf);
+		perf_enable(perf);
+	}
+	pm_runtime_put_autosuspend(perf->ptdev->base.dev);
 
 	return 0;
 }
@@ -846,6 +1869,57 @@ int panthor_perf_session_sample(struct panthor_file *pfile, u32 handle, u64 user
 	return session_sample(perf, session, user_data);
 }
 
+/**
+ * panthor_perf_suspend - Prepare the performance counter subsystem for system suspend.
+ * @ptdev: Panthor device.
+ *
+ * Indicate to the performance counters that the system is suspending.
+ *
+ * This function must not be used to handle MCU power state transitions: just before MCU goes
+ * from on to any inactive state, an automatic sample will be performed by the firmware, and
+ * the performance counter firmware state will be restored on warm boot.
+ *
+ */
+void panthor_perf_suspend(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf = ptdev->perf;
+	int ret;
+
+	if (!perf)
+		return;
+
+	guard(mutex)(&perf->op_lock);
+
+	ret = perf_disable(perf);
+
+	if (ret)
+		drm_warn(&ptdev->base, "Could not stop sampling before suspend, err = %d", ret);
+}
+
+/**
+ * panthor_perf_resume - Resume the performance counter subsystem after system resumption.
+ * @ptdev: Panthor device.
+ *
+ * Indicate to the performance counters that the system has resumed. This must not be used
+ * to handle MCU state transitions, for the same reasons as detailed in the kerneldoc for
+ * @panthor_perf_suspend.
+ */
+void panthor_perf_resume(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf = ptdev->perf;
+	int ret;
+
+	if (!perf)
+		return;
+
+	guard(mutex)(&perf->op_lock);
+
+	ret = perf_enable(perf);
+
+	if (ret)
+		drm_warn(&ptdev->base, "Could not resume sampling, err = %d", ret);
+}
+
 /**
  * panthor_perf_unplug - Terminate the performance counter subsystem.
  * @ptdev: Panthor device.
@@ -856,10 +1930,27 @@ int panthor_perf_session_sample(struct panthor_file *pfile, u32 handle, u64 user
 void panthor_perf_unplug(struct panthor_device *ptdev)
 {
 	struct panthor_perf *perf = ptdev->perf;
+	struct panthor_perf_session *session, *tmp;
 
 	if (!perf)
 		return;
 
+	disable_work_sync(&perf->sample_work);
+
+	scoped_guard(mutex, &perf->session_lock) {
+		list_for_each_entry_safe(session, tmp, &perf->session_list, sessions) {
+			scoped_guard(spinlock_irqsave, &session->state_lock)
+				session_set_state(session, PANTHOR_PERF_SESSION_DESTROY);
+
+			list_del_init(&session->sessions);
+			session_put(session);
+		}
+	}
+
+	panthor_kernel_bo_vunmap(perf->rb);
+	panthor_kernel_bo_destroy(perf->rb);
+
+	perf->rb = NULL;
 	ptdev->perf = NULL;
 }
 
@@ -867,6 +1958,9 @@ int panthor_perf_pool_create(struct panthor_file *pfile)
 {
 	struct panthor_perf_pool *pool;
 
+	if (!pfile->ptdev->perf)
+		return 0;
+
 	pool = kzalloc_obj(*pool);
 	if (!pool)
 		return -ENOMEM;
@@ -880,14 +1974,33 @@ int panthor_perf_pool_create(struct panthor_file *pfile)
 void panthor_perf_pool_destroy(struct panthor_file *pfile)
 {
 	struct panthor_perf_pool *pool = pfile->sessions;
+	struct panthor_perf *perf = pfile->ptdev->perf;
 	struct panthor_perf_session *session;
 	unsigned long handle;
+	bool sync_work = false;
+
+	if (!pool)
+		return;
 
 	xa_for_each_marked(&pool->xa, handle, session, SESSION_REGISTERED) {
-		scoped_guard(spinlock_irqsave, &session->state_lock)
+		scoped_guard(spinlock_irqsave, &session->state_lock) {
 			session_set_state(session, PANTHOR_PERF_SESSION_DESTROY);
+			sync_work = true;
+		}
+	}
+
+	if (perf && sync_work) {
+		guard(mutex)(&perf->op_lock);
+
+		perf_disable(perf);
+		perf_sync_work(perf);
+		perf_enable(perf);
+	}
+
+	xa_for_each_marked(&pool->xa, handle, session, SESSION_REGISTERED) {
 		xa_erase(&pool->xa, handle);
 		session_put(session);
+		pm_runtime_put_autosuspend(pfile->ptdev->base.dev);
 	}
 
 	xa_destroy(&pool->xa);
@@ -895,3 +2008,23 @@ void panthor_perf_pool_destroy(struct panthor_file *pfile)
 
 	pfile->sessions = NULL;
 }
+
+void panthor_perf_pre_reset(struct panthor_device *ptdev)
+{
+	if (!ptdev->perf)
+		return;
+
+	guard(mutex)(&ptdev->perf->op_lock);
+
+	perf_disable(ptdev->perf);
+}
+
+void panthor_perf_post_reset(struct panthor_device *ptdev)
+{
+	if (!ptdev->perf)
+		return;
+
+	guard(mutex)(&ptdev->perf->op_lock);
+
+	perf_enable(ptdev->perf);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
index b5da4270e5061..4a8ef97689451 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.h
+++ b/drivers/gpu/drm/panthor/panthor_perf.h
@@ -18,6 +18,8 @@ int panthor_perf_pool_create(struct panthor_file *pfile);
 void panthor_perf_pool_destroy(struct panthor_file *pfile);
 
 int panthor_perf_init(struct panthor_device *ptdev);
+void panthor_perf_suspend(struct panthor_device *ptdev);
+void panthor_perf_resume(struct panthor_device *ptdev);
 void panthor_perf_unplug(struct panthor_device *ptdev);
 
 int panthor_perf_session_create(struct drm_file *file,
@@ -28,4 +30,10 @@ int panthor_perf_session_start(struct panthor_file *pfile, u32 handle, u64 user_
 int panthor_perf_session_stop(struct panthor_file *pfile, unsigned int sid, u64 user_data);
 int panthor_perf_session_sample(struct panthor_file *pfile, unsigned int handle, u64 user_data);
 
+void panthor_perf_report_irq(struct panthor_device *ptdev, u32 status);
+
+void panthor_perf_pre_reset(struct panthor_device *ptdev);
+
+void panthor_perf_post_reset(struct panthor_device *ptdev);
+
 #endif /* __PANTHOR_PERF_H__ */

-- 
2.43.0

