Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48E6F54AB3
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE7D10E6CC;
	Tue, 24 Mar 2026 13:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="EvHjgbY3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EvHjgbY3";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013013.outbound.protection.outlook.com
 [52.101.83.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D0F10E6CC
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:27:10 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=l4LuMfzTmWApxqY7bNtHPt6FQ9UMVCZ2tCxxvCSchofRJG/DBbC0bReSKfrFZgcOcwhnkVRDPnVk7lPSha6vgQcrkLPq05NqlkdxQ+EbVLcUTBsh+ZZNqWLe0j5eUiGyLOJsKKNARXcOQbqDORZdC29E0l8lDnkeh+CCY7rvv7b4RC6VOYNpHrzF3xbeSLNlD45dnkJQWC7Qbnv+kFLsPk4l3ISbbzZLMIxqGOywf9lPwdQFAepPFOurd+guvQ0m2uGi3Fm79nSfB1ACcRi6qS44QnM+S3fx9gHSO+A6wj6BpZv19x1zaAYKo6WLEwlcg7YoNzrvWkwh/5PsfNIdLA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5yztpstHbemM8UiwMw8hAZOuKy48k1iVOerYJ9kf0A=;
 b=gDZ3cPdSEHYZdIVhR7KWP53dtV7xUTD6U4V9bqNpS0xDjSqz1K6f1b1sPFWZPiEgDN9Wih2hQtpCnDzVP+RAR9+GJCMeOT7foW7s+HIfmk6efzwra3OGVm+oKhZ9Or+NSJY3lKcxbjuUdnpzHT7aLSYEMnOZCLYYtIR0K+udJthttMgMIQaNDxfzFcADH5Qc6gI/iuly3bZnVbE/SVI0akUHub7E/WgjDqV3Dbd9cJ+Xljq8ze0Bi+I4CDU0xohJBCAI+/Ht0Egwkdk1AN8mst/Skviwanr6Ra15QTC1f9KHTd8gH3L8bulJEj0hqMLIbgRdt5nH+baPiEQFPVznkg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5yztpstHbemM8UiwMw8hAZOuKy48k1iVOerYJ9kf0A=;
 b=EvHjgbY37BWIemSnmIvaOuClXbQvImO8t/pf3JCpr8QU9Wb2zM/3jp6T+yaUHPrSebymSxwSVPguPVRdDvx7PDklg1pNVKfLBCyeINuV9c1uVQetJB9ZcEoem2xrWJjTNJ9oD7ADYiR9OyBZdImUq5iGb7JMK6FyFo+C6YCDP8Y=
Received: from DUZPR01CA0200.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::10) by DBBPR08MB5977.eurprd08.prod.outlook.com
 (2603:10a6:10:209::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 13:27:04 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:4b6:cafe::fc) by DUZPR01CA0200.outlook.office365.com
 (2603:10a6:10:4b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 13:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Tue, 24 Mar 2026 13:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCzSrPpcoQy3WwdcNiaiOmOXOoE4PjgF0b0/Hy699dDjLmuPOHpb5QemL0tTv3pof3rNT5RhVrIC5wCqoxIzCpDEqxghdDfSNjkXBu6GD7fCwB0elwWoKFVSLhEMzVHcqjO/ErYKP+d0E0QYgPRpJxwa/VnyOJ0sPNCs0soFNPqDB0HqmA6W5wCnYj+3aSAs9jrQl3SQfuFm0U9XPPfImlPOOLRT3QTZJoIcyr1cw85OF39jf1hDfMS6FE8vB/Gu+323nWrNvcRLiIGFH4Qmtm8LjdzZQPOoatB6TzFgUbNOD1b7b9dRg239ES76+YzBRsDba/lC+qs5SALFirtEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5yztpstHbemM8UiwMw8hAZOuKy48k1iVOerYJ9kf0A=;
 b=Zwy8IyJtTeVSoidnDd7EHq8rQZYpoJXHcEVOgZig0SOLsIz1RENR+9418uj5Wu5rHQITwOixMlvHYxbf9CpRIKV+7OISNxCk/EdL8MtMQbBMWA5bHgekFLYUadmuQCZjh+EnnSYkV2GvJsmCoFNS+FiQpXgSgShPXGR4BN8oGj3HtEdE7Hd5+MyfaPK0Nbv62NLjZgJYHw/H2R0N0gxUkQV6jSgaBkTi9JmnTZbCG5eU04BXmartV6TdqfzVJ77y6cdZWtXGkGkjF8/N4dLiPl1OhxU4g42De+33NqTCjdA0YJ4cPjsaFuDGLiRsy+SwWeGJKh2nA+BFzoBNPVSPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5yztpstHbemM8UiwMw8hAZOuKy48k1iVOerYJ9kf0A=;
 b=EvHjgbY37BWIemSnmIvaOuClXbQvImO8t/pf3JCpr8QU9Wb2zM/3jp6T+yaUHPrSebymSxwSVPguPVRdDvx7PDklg1pNVKfLBCyeINuV9c1uVQetJB9ZcEoem2xrWJjTNJ9oD7ADYiR9OyBZdImUq5iGb7JMK6FyFo+C6YCDP8Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by DBBPR08MB10553.eurprd08.prod.outlook.com (2603:10a6:10:52e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 13:26:00 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 13:25:59 +0000
From: Marcin Slusarz <marcin.slusarz@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lukas Zapolskas <lukas.zapolskas@arm.com>,
 nd@arm.com
Subject: [PATCH v4] drm/panthor: extend timestamp query with flags
Date: Tue, 24 Mar 2026 14:25:57 +0100
Message-ID: <20260324132557.1707286-1-marcin.slusarz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318112952.645160-1-marcin.slusarz@arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0612.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::6) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|DBBPR08MB10553:EE_|DB1PEPF000509F0:EE_|DBBPR08MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f37f103-2f83-4b5e-4989-08de89a90971
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: zdzz1uRXA1qfSDDHpJg2PbxAgZeEMKQ+uprJzPgGcxmQ9qaz1u8U1rQ9dSFWVhUQgm2sGRkU1/h5RcpPkI4AdLU2v3+TEpo5oXEC2DK87qU/L7sJWSu9vGt1sR8PCKc1rCl4JTLRM5cU9Jy4sfzq9vKFW6B2JNPjSGb68JMsbDWG4yKsuct/RBKAbM4OHYfCk1QGOVmylpoL4HA48/xlzIxlgKI8bae2LA4EQWLYFv07I8h3Q5ThIDtAfq6gFJwXvCUJFvRndMmBsnzxuApXzGVX5EHmWalxwbUqqBoO11nCtBvntkqjK+29WqiK7zn8FnrTnm+Sv5iXBn4iiV4m3DjkVYxYsUxraPUgQBATYmzAgtTLIfamSnTUhgL6mGyxZZgqzMyMTk4Jya/MJS/rwiSFW6XDqqpIxX9/BBoChnNsM5Dopbk5haBXzJO5NWniIqsWf+pnoQ3nu9ya4pVr5v+W5gQEzKEf+oezMj8FSe+AmmufplKIJQZVl6Gv9RdDRzxay+iQ6wnsXihnJCZeb1I8Jh2efPR4CSu9LITPcdQY9q8W6JtG5TTScfsjofQlces9IQfUfwJU9q/mJzpp4xcrp6SYlJgq37wTLuVYpc+Mxz/ROuXoyxP6kUX6TfLgrY+o0miegvfRHkIcLtduRE1d+FezdACaZ1jHmu7TEpmZ2Y7KetQWr8+Zl4H3CQRar28PTO83kNaMMpBkwEZveXnLm0VE/H+whYCDp9UqCu8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(7053199007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: wByVfJMnsx2UQiKedZIttk5HGjOMMhlclMFJ3KbK7WTDt0tEcKLdtVCle6mXoviJbpFywlTxT2reJMpjgIDX7xarLhrxXjBQlFAAbAZh90GMG5238nUGbCEcs/DDeuWakaPFzOGHbnh8+sLvro6VKKL6QlTPEoiXoNbc1d8DSXhAzBYiIRIbfqOQLyC4QQ76AeJmTDIh8gFp7uACZwGhWDgEnIi3d9LM6e5yrA8klFxpyjhWFS3PiC8du2rhu49W8iMn0zeRs6iHjxQcZ0PFXsMWhVWoCCuewcMfz1WA0Hkyskg6AIDO7D6iccCsIMeKOGO0oXF16TPkLNEuvScHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10553
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9e82f574-db9f-4249-fbae-08de89a8e351
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|14060799003|376014|36860700016|35042699022|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: mUi0q72W5JvqvGqFoU1c6nGI2JzPNSoq/8301kvxuDcJsDKks8bZx0+ZqxCCf9sCplpu0wuxm8trt47Z2t06hAKCTE+jVb3lrDr9YHOQwsuDq8Sbu6suf9Ce/r7OwXFJCJb5QrEL18qw9StJeZRzYCgigFrrSq2vC3parukMkTawPc3Tnwv4zj0Izz8URdZ/cKYFv73qEjDQNmChRSBzgvMb08dKcseEcE/U4wW/H9mxeJ3JfGddWa+dAGupmoD5eM+n5JDVj6+pQZkhtQnKCmAq1I+pBrh+uS/RT4T28hlVSH7HCqbC9x9Dck9S46CCtkxPBrcyhwwdQ8Uqp/uGeQ5HbrXe8BSLj53CZi+FgYLnjc2VbFRiVg8af9u7CP8ctUD1URNtWCiyxfKicTd/Oejy4PhTjr913tNhzoxQ7HZpRzterwgP2TKvrN79mpP/GXKGDpayfi/zUSHRUUmrSUu4e2kZapvbPiGRKDItI5zX/m/JorcE7pZTuESzhmgFCv8z67jW+rvyGD3sRzPtpA3iS2f6ifUhYpX4kllk6/gsJvwkkuL5p4SUtZiTHFg4S0uYN8VPBom/rduM/u+TglrG2CZ+nB8dhJvmX2plyO9vZcyMk0F2rxWthAC/A8rH85xLpi1Ul5F6kbwH+DlkIa1XeNigsNURPy5HpKXilbcqBRRMVZW6uctCb1NhDZf/FnF590KqsZx2bKDLacVkPHq2RY7yComfxIJuF1lCh5oBhg7B3//5WLQyeHZjWk6HOYaMJpePaQ7TXeUT+sSJRA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(14060799003)(376014)(36860700016)(35042699022)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ceQcRERqLx4guoulYqAc5lRcc73p1qv4I+VeN+Mwi912np5ijrCc79uA5k8Pk/2mQbUqsKxOPAOZMfL5UJY/QZIY34RiIPtakQBikzO/SVipH+Y7oBIEWfg0w+1628QHW+1FEakn270NBZSzf315jP1HfzVQ/ZR7hSVPdPHiXwduYMGLTcqB9gTvbr9G3VQP7+iCM5EIb94I+FqO3GjUjhvlp9nm9o7KKZsFuSa5qvZsKMQBZuhNIceQQzSMKJhdePhTn0hdwbai5B1ZVM3R6qI2GYziSFmR3Y1MDJRkDDlefXP4vkON/jWyLU9ayYp+zQGQHatMek6BdZY4jm2UDeJZyr1vFKsugYTsV+/8loJ9/ZoVLXhXL+GjQy1yu+mrYh7fPN6larWfkmiDwKme6ID3vr1tcd9bvGrkFuBcnvdUwCPofGYs0I0FvI/CQ0Do
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 13:27:03.2991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f37f103-2f83-4b5e-4989-08de89a90971
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5977
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

Flags now control which data user space wants to query,
there is more information sources, and there's ability
to query duration of multiple timestamp reads.

New sources:
- CPU's monotonic,
- CPU's monotonic raw,
- GPU's cycle count

These changes should make the implementation of
VK_KHR_calibrated_timestamps more accurate and much simpler.

Signed-off-by: Marcin Slusarz <marcin.slusarz@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes in v4:
 - 0 replaced by DRM_PANTHOR_TIMESTAMP_CPU_NONE in CPU_TYPE_MASK switch
 - extended documentation for flags
Changes in v3:
 - {} around multiline statements
 - added comment about default flags
 - added VALID_TIMESTAMP_QUERY_FLAGS
 - used u64_to_user_ptr
Changes in v2:
 - added DRM_PANTHOR_TIMESTAMP_CPU_NONE
 - cpu_timestamp_nsec extended to u64
 - pad1 removed
 - copy_from_user -> copy_struct_from_user
 - looking at size replaced by looking at flags
 - more comments
---
 drivers/gpu/drm/panthor/panthor_drv.c | 134 ++++++++++++++++++++++++--
 include/uapi/drm/panthor_drm.h        |  63 +++++++++++-
 2 files changed, 189 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 165dddfde6ca..9e65af453119 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -13,7 +13,9 @@
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched/clock.h>
 #include <linux/time64.h>
+#include <linux/time_namespace.h>
 
 #include <drm/drm_auth.h>
 #include <drm/drm_debugfs.h>
@@ -761,22 +763,135 @@ static void panthor_submit_ctx_cleanup(struct panthor_submit_ctx *ctx,
 	kvfree(ctx->jobs);
 }
 
+#define VALID_TIMESTAMP_QUERY_FLAGS \
+		(DRM_PANTHOR_TIMESTAMP_GPU | \
+		 DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK | \
+		 DRM_PANTHOR_TIMESTAMP_GPU_OFFSET | \
+		 DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT | \
+		 DRM_PANTHOR_TIMESTAMP_FREQ | \
+		 DRM_PANTHOR_TIMESTAMP_DURATION)
+
 static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 					struct drm_panthor_timestamp_info *arg)
 {
 	int ret;
+	u32 flags;
+	unsigned long irq_flags;
+	struct timespec64 cpu_ts;
+	u64 query_start_time;
+	bool minimize_interruption;
+	u32 timestamp_types = 0;
+
+	if (arg->flags != 0) {
+		flags = arg->flags;
+	} else {
+		/*
+		 * If flags are 0, then ask for the same things that we asked
+		 * for before flags were added.
+		 */
+		flags = DRM_PANTHOR_TIMESTAMP_GPU |
+			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
+			DRM_PANTHOR_TIMESTAMP_FREQ;
+	}
+
+	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+	case DRM_PANTHOR_TIMESTAMP_CPU_NONE:
+		break;
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
+		timestamp_types++;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS)
+		return -EINVAL;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
+		timestamp_types++;
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
+		timestamp_types++;
+
+	/* If user asked to obtain timestamps from more than one source,
+	 * then it very likely means they want them to be as close as possible.
+	 * If they asked for duration, then that likely means that they
+	 * want to know how long obtaining timestamp takes, without random
+	 * events, like process scheduling or interrupts.
+	 */
+	minimize_interruption =
+		(flags & DRM_PANTHOR_TIMESTAMP_DURATION) ||
+		(timestamp_types >= 2);
 
 	ret = panthor_device_resume_and_get(ptdev);
 	if (ret)
 		return ret;
 
+	if (flags & DRM_PANTHOR_TIMESTAMP_FREQ) {
 #ifdef CONFIG_ARM_ARCH_TIMER
-	arg->timestamp_frequency = arch_timer_get_cntfrq();
+		arg->timestamp_frequency = arch_timer_get_cntfrq();
 #else
-	arg->timestamp_frequency = 0;
+		arg->timestamp_frequency = 0;
 #endif
-	arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
-	arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
+	} else {
+		arg->timestamp_frequency = 0;
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
+		arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
+	else
+		arg->timestamp_offset = 0;
+
+	if (minimize_interruption) {
+		preempt_disable();
+		local_irq_save(irq_flags);
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
+		query_start_time = local_clock();
+	else
+		query_start_time = 0;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
+		arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
+	else
+		arg->current_timestamp = 0;
+
+	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
+		ktime_get_ts64(&cpu_ts);
+		break;
+	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
+		ktime_get_raw_ts64(&cpu_ts);
+		break;
+	default:
+		break;
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
+		arg->cycle_count = gpu_read64_counter(ptdev, GPU_CYCLE_COUNT);
+	else
+		arg->cycle_count = 0;
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
+		arg->duration_nsec = local_clock() - query_start_time;
+	else
+		arg->duration_nsec = 0;
+
+	if (minimize_interruption) {
+		local_irq_restore(irq_flags);
+		preempt_enable();
+	}
+
+	if (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
+		timens_add_monotonic(&cpu_ts);
+
+		arg->cpu_timestamp_sec = cpu_ts.tv_sec;
+		arg->cpu_timestamp_nsec = cpu_ts.tv_nsec;
+	} else {
+		arg->cpu_timestamp_sec = 0;
+		arg->cpu_timestamp_nsec = 0;
+	}
 
 	pm_runtime_put(ptdev->base.dev);
 	return 0;
@@ -851,8 +966,14 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
 
 	case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
-		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
+		ret = copy_struct_from_user(&timestamp_info,
+					    sizeof(timestamp_info),
+					    u64_to_user_ptr(args->pointer),
+					    args->size);
+		if (ret)
+			return ret;
 
+		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
 		if (ret)
 			return ret;
 
@@ -1680,6 +1801,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  *       - adds DRM_IOCTL_PANTHOR_BO_SYNC ioctl
  *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
  *       - adds drm_panthor_gpu_info::selected_coherency
+ * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1693,7 +1815,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 7,
+	.minor = 8,
 
 	.gem_create_object = panthor_gem_create_object,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index b401ac585d6a..0e455d91e77d 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -409,6 +409,38 @@ struct drm_panthor_csif_info {
 	__u32 pad;
 };
 
+/**
+ * enum drm_panthor_timestamp_info_flags - drm_panthor_timestamp_info.flags
+ */
+enum drm_panthor_timestamp_info_flags {
+	/** @DRM_PANTHOR_TIMESTAMP_GPU: Query GPU time. */
+	DRM_PANTHOR_TIMESTAMP_GPU = 1 << 0,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_NONE: Don't query CPU time. */
+	DRM_PANTHOR_TIMESTAMP_CPU_NONE = 0 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC: Query CPU time using CLOCK_MONOTONIC. */
+	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC = 1 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW: Query CPU time using CLOCK_MONOTONIC_RAW. */
+	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW = 2 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK: Space reserved for CPU clock type. */
+	DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK = 7 << 1,
+
+	/** @DRM_PANTHOR_TIMESTAMP_GPU_OFFSET: Query GPU offset. */
+	DRM_PANTHOR_TIMESTAMP_GPU_OFFSET = 1 << 4,
+
+	/** @DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT: Query GPU cycle count. */
+	DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT = 1 << 5,
+
+	/** @DRM_PANTHOR_TIMESTAMP_FREQ: Query timestamp frequency. */
+	DRM_PANTHOR_TIMESTAMP_FREQ = 1 << 6,
+
+	/** @DRM_PANTHOR_TIMESTAMP_DURATION: Return duration of time query. */
+	DRM_PANTHOR_TIMESTAMP_DURATION = 1 << 7,
+};
+
 /**
  * struct drm_panthor_timestamp_info - Timestamp information
  *
@@ -421,11 +453,38 @@ struct drm_panthor_timestamp_info {
 	 */
 	__u64 timestamp_frequency;
 
-	/** @current_timestamp: The current timestamp. */
+	/** @current_timestamp: The current GPU timestamp. */
 	__u64 current_timestamp;
 
-	/** @timestamp_offset: The offset of the timestamp timer. */
+	/** @timestamp_offset: The offset of the GPU timestamp timer. */
 	__u64 timestamp_offset;
+
+	/**
+	 * @flags: Bitmask of drm_panthor_timestamp_info_flags.
+	 *
+	 * If set to 0, then it is interpreted as:
+	 *  DRM_PANTHOR_TIMESTAMP_GPU |
+	 *  DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
+	 *  DRM_PANTHOR_TIMESTAMP_FREQ
+	 *
+	 * Note: these flags are exclusive to each other (only one can be used):
+	 * - DRM_PANTHOR_TIMESTAMP_CPU_NONE
+	 * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC
+	 * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW
+	 */
+	__u32 flags;
+
+	/** @duration_nsec: Duration of time query. */
+	__u32 duration_nsec;
+
+	/** @cycle_count: Value of GPU_CYCLE_COUNT. */
+	__u64 cycle_count;
+
+	/** @cpu_timestamp_sec: Seconds part of CPU timestamp. */
+	__u64 cpu_timestamp_sec;
+
+	/** @cpu_timestamp_nsec: Nanseconds part of CPU timestamp. */
+	__u64 cpu_timestamp_nsec;
 };
 
 /**
-- 
2.34.1

