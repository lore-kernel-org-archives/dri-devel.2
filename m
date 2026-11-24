Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441AE606A688
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=f0CmUK5m;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=f0CmUK5m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9158810F77D;
	Tue, 24 Nov 2026 16:21:01 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74D410F678
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:20:46 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Cc9QWu9ivu7MRQaZZBvxQa9VQH2MkRcRacYoLmlVTZGBtGg6JTmp2ZYRBamHukDhxm9U2uLlqe4DY0W6hhwFdqFKgVFNblFbkdcmFmJeXX6PxT4FCqDHUVNvIK1cy2B80EDhKyB/ZmqgleUSk7FRcuv5ZqwBRvZPDPn2cdt/ZFhPQbM//SbiNwsvlzYAt2rd6QOE2wx4jm0gOGf5T/FtoWgeEUx8xmbr7ONobAM2VcpOGVyJ9+Zlchp/VK3l/KSAmpRA+0Kn7/7XuH4wPEekJq6ixcNIjz+diNXIXPtLchpqiQZj+HTwzEgBnSvdXaXb0YjApbbZIgBw3QV62FJO3g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBdPzfqaw3I9VEq7FPDhOhUUobb4VQFBvzAqzDQAxt0=;
 b=l5LZ7Wj1YNGBPQj7Q0UoDDzCMv5hT9DtV9GGkVm/I3N1LRmGrXw9JxqpGK3Ds9qX7rSWK0QNsQtH/sm1HVcPIw1sSgwnqX5aLmskQ16JOwkdHegZCmqCtXok5CNfQ/rOYuBQBW5trQY36ORzTqXGazHUgKsflQPRdNMk6bVg6HyWpZOCQB+dXkkSkyq+cxBHe7FMW0mzeI6vZgZ8w5Hz3B1fEPrehmXggZ9z4RH8OizPHQRNoL02OYBCa2phEG+58Od7aqhq7x8pb9Ih88wDtQejFyDMqej99xPWz93UeNISEPR6zkiMykUznUeEdTTsoBB8lcpYfAQ1wDC8XTRplA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBdPzfqaw3I9VEq7FPDhOhUUobb4VQFBvzAqzDQAxt0=;
 b=f0CmUK5mRz1G+nELdttjPUJ77u58XPtgd4uum90ZtjzKK9bpLDUzZaPcVTcp3RlCVZKGz4/Q70ARQCabq3fcHi1tJpOMRhNgVYDxnPOa/g2eQCKj5EZcet8FUYDTfWIUu+4qN9G9mWKNHW+0LbTxUaRe8imKVDAjQnCf5cw/oeY=
Received: from DU2PR04CA0266.eurprd04.prod.outlook.com (2603:10a6:10:28e::31)
 by GV1PR08MB7801.eurprd08.prod.outlook.com (2603:10a6:150:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 16:20:33 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::9f) by DU2PR04CA0266.outlook.office365.com
 (2603:10a6:10:28e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.15 via Frontend Transport; Tue,
 24 Nov 2026 16:20:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 16:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFIvKtY73XY9BpU8i+K15B5+ROnipf441SUW/MOp5o8D/tse78JaCz+n1ZM83A5DezNKJcLyZq4baaMM2UdvREAKtvvMWOwqBZP4xqurhRKVJJjaKaSy6JnYIL2xyoRtPz9xO1JWy8ghCJgIO2JLoFmmYQvcuFC7U2SSfzOCgIUH4fF9kRKYE3DEBa7OYqydKJzGHFux45Y2y+v1HMkSgA6oV3ZN0bTTQf0PlTmA1qZwoixFAMr7NnFUaCjRj9AfKoJFWWP0wY8GhNYDbzdGWhOy6PsQMWa9UcdDSnCRP9mNsq7Va+LWNh6xp40i7AqNYq2sJSLc3ybMwTvll2iQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBdPzfqaw3I9VEq7FPDhOhUUobb4VQFBvzAqzDQAxt0=;
 b=Ue6ABKhYZbXSJiGUpxhB83D/sG5bNoVHim62mGH0DuXSFz3GTkrUGcE1ckTlreTzLOsLUrCVhZkEZpGkuxkxiWR2FUZIA2iIdLS3HAo0NXcxhMU3kiCfddNr5fbQo5m2LGcOosQptsmiN2nzg3BRXWE99TFPvMp2mBeDuSFxPnpWANj77Foty4Zo6TgN9edJgcrVxPBcuBQ7HEdZMWgQoOBzWIz2LMV4/yritsyjtbY5/vRKJdrcjw8Q0pPpaP5CSwsZnVDkqF0gwxzor0nhmyW2pk3wLOHsmCt7QarIbD4E1xc3/OUqpgSk9DRV38Cm4aMkvbhv16gRLWdVbe62jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBdPzfqaw3I9VEq7FPDhOhUUobb4VQFBvzAqzDQAxt0=;
 b=f0CmUK5mRz1G+nELdttjPUJ77u58XPtgd4uum90ZtjzKK9bpLDUzZaPcVTcp3RlCVZKGz4/Q70ARQCabq3fcHi1tJpOMRhNgVYDxnPOa/g2eQCKj5EZcet8FUYDTfWIUu+4qN9G9mWKNHW+0LbTxUaRe8imKVDAjQnCf5cw/oeY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com (2603:10a6:190:53::6)
 by PA6PR08MB10858.eurprd08.prod.outlook.com (2603:10a6:102:3d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 16:19:58 +0000
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28]) by MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:19:58 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/9] drm/panthor: Add initial Mali v15 support
Date: Tue, 24 Nov 2026 16:19:38 +0000
Message-ID: <20261124161952.1053586-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::11) To MMZPR08MB669593.eurprd08.prod.outlook.com
 (2603:10a6:190:53::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MMZPR08MB669593:EE_|PA6PR08MB10858:EE_|DB3PEPF0000885C:EE_|GV1PR08MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e44276a-5806-4d10-a883-08df4a46dd20
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261028144727099003|10067099003|261021121427099003|261102123227099003|11063799006|56012099006|261022113327099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261021123027099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: LbJidfoNELOcjaFoXKoYZVbdPH/Om4wcMsEJFNxVZFCs3e9ulfBFwICg5L6xSDNW9Rsy5AAd3feMwXL6RnQn7Sd8EHS5qnIlhdfQiQFHS2LLaSzBalVh8Lwe3ZPlV/EjqZOEI9CzKECat7xx/ojgEJNXyNdLujpvfYd5/nOoTqDaiBFI6FiLnmhNJ6/WqQtnaNvLOHIkASR5hODc9rh4IOA2iSdMPbaKDp+BUoXUqUozfmpZ9pzMnKADO7HnpwZfpmEICghWwhQxXpWr+sVDysem8nK9ulsrhlw2QuplP6TE2+KIw6pQyG3rv2Uy4TKmF9e26XMwPM0IWCjD05JeGuhC9FuadhnI45Gxwgcdd49UEG8vF9lF+omjVPNHZ7AGXAaCOSnJMuz5pU0/JQ/5nle3Y3hA/NaNXAmw4SukV7yogtZziTEjZlKQKjNlvpLULS1bblzggKbMSHGkTlQ6imYSeK7F3t8xPBSeTUoJYNcLoAvGnLrASVUtGSjV6K1xMpj0YIShK8RcTZh04os4FkrA/65bC6ZaMNsqiWAArnJUSHxhrbWsdDygYWd6OHacASrUnnIMRXIQWBfLAhgbYSoOcYqjhzAtacARB3op5JGV7Y+au0lBGfa+Amsli9cO
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MMZPR08MB669593.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261028144727099003)(10067099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261021123027099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: TCerZWla7zk/xzvGnl6roX+rnrZ0PoXPxZICI1NebyAmCQbd36MktOsd/CYdmQZBXHmgmL2xYOEZgeXGVMBmKK+YgjyLUIjClwwAelPVymPUVHxx8UMQBNw7fs3n/kYY1KY0C1Ed0gJ8GAWkmDGSrLacXrYMLCosv5ONQhMs8mSn61gpfz2JKnCbm3+M+R+2rwzSSMqwTwEjj38axmahfYEO3nTLTU8B6AnCbvO/iNoqs7cwfzDdGyNleKdzGlQ+QVnA0W+gZtFGGMiAahyqVP5p6L28d9izh+g/jF54TL209U5vK5u9qZWKH8acboZ5IALSCSST3cpTF7zRcoW92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10858
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 45995e3e-14df-4af5-aaa7-08df4a46c863
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|23010399003|36860700016|82310400026|1800799024|376014|261026140227099003|261102123227099003|261026121527099003|261022105027099003|261022113327099003|261028144727099003|261021123027099003|261021121427099003|11063799006|56012099006|10067099003|261009223027099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: ueiUNv59JQ5tzUSEeTJnbPnyjm7dYMiQGfIgCnO9jTDD6qrbWOk3tqLfpb1+QEGzC4gT08z7qKoXLhyQl9qFsIi+yeCGrru2LJRTuKLNzjaZWtz3ECTWeALkDRwmySt8nB5qe7MsbIfYQYFAcxJ/wf3i02GdT8jkUlWGepFFGmrVBuVzJktKQDwBARa15rf1+uMbxmi+CdQ5agFd4s3cqPQs9JgnNB8BwZNyU9LwiAh+Py7Kzk0wX3Kc76P5cG3TtrMPe2fTlyL7GyBS+NxnlkF6YtFQA7VNV0rtAGAoFhEgfnv7fisgT151qs/B30GLNDuhYgAlHA18pl44YlbVYetJXbmHo+Mwtn5s4x7u0E2YycKmmUTM6bUG1DkNFxH8g1wH7d0yYY44wqKrzPQY8vFi/UeECYqtTwNqVyegzLKqara4iLwYv58aDHUp4dRgyTBVjHMHKf15sSxVymQyJhu5pD+3EVIIRuMImnMPMloKXwWRSX9vgTVDhJiTD4/KgX8jePaYSgbWXeSgRRXHdmeB9eZcxIJSb4CjgzwHwe3zx5GTHqIRsWY0i5EBWWIy9hfppG9Fp/PWv/jhwojoMx5ze0JZ1erepz3XDTCbu7rR48JvCAmO+PTqk4rUu7j/u0Qv24nchwE3OgMvfqOVJQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261026140227099003)(261102123227099003)(261026121527099003)(261022105027099003)(261022113327099003)(261028144727099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L6LnQ22BrDNsGpswwR17A5O4c/GAmzteA7nBz7sMZUtzuBdcOdVo/+DB3VvlM7Q/7pw1pXvy4/sny6r4H9VRs1EAyrdwtXGXkFGB9fL64KhXyKyCoNX/5Y98FbJxZ/IglbCEp7EQeyBtER9Ko1YmZoetJGQqy5AmmJuKU1UvlbJU5KxI23g0ptK1UVJcHj1dZVjPybX8Ko6zcS52rHyYa6du33r7QYiIG5Lb02bKUcAgfUk6XUhg+Syx6tq2vWVaP2+uyRw2N4OadkMyr1oiZJbTiQOE92iRA6sBAGKNEz8ENJGsEJdUAHyS4+bbHMS+B09h2oLBM7jHNzlV4eRrewJGnRBQ+MvnfMSATKBj14kRHX8tcEvjael0ZtbzaZmEu3Z6u4Qr7XjiPsTRw7alcURiNYglXz7VcRep+M1mDHN3GLLdrYZh7z4/kRTIYP0j
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:20:32.6984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e44276a-5806-4d10-a883-08df4a46dd20
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7801
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series extracts the initial hardware support from the previously
posted Mali v15 virtualization series. The remaining virtualization
support will follow separately.

v5:
- Collect R-bs from Boris.
- Removed unused DT properties.
- Link to v4: https://lore.kernel.org/all/20261119154604.2519184-1-karunika.choo@arm.com/
v4:
- Collect R-bs from Liviu and Boris
- Squashed 64-bit GPU_ID decoding [PATCH v3 05/10] into v15 enablement
  [PATCH v3 09/10].
- Defined devfreq_disabled flag panthor_soc_data to disable devfreq
  if it is set.
- Link to v3: https://lore.kernel.org/all/20261118175332.519657-1-karunika.choo@arm.com/
v3:
- Split out the initial Mali v15 support into a standalone series,
  leaving virtualization and arbitration support for a follow-up.
- Rebased on drm-misc-next (fb191ef626555)
- Drop the $nodename constraint from the AM GPU binding.
- Require the arm,zena-css-mali integration compatible followed by
  the arm,mali-gen5-am fallback.
- Update the binding example to use the new compatible, three-cell
  interrupt specifiers, and a single GPU clock.
- Omit drm-maxfreq-panthor from fdinfo when the maximum frequency
  is unknown, as on AM systems without an OPP table.
- Fix the missing blank line after declarations in GPU_ID decoding.
- Link to v2: https://lore.kernel.org/all/20261110153907.3241978-1-karunika.choo@arm.com/

Kind regards,
Karunika

Karunika Choo (9):
  drm/panthor: Ignore -EOPNOTSUPP for shader-present nvmem lookup
  drm/panthor: Rename neural accelerator feature macro to NX
  drm/panthor: Move register access helpers out of panthor_device.h
  drm/panthor: Parse and store GPU_ID fields
  drm/panthor: Move register base offsets to the HW description
  drm/panthor: Derive MMU AS register addresses from base and stride
  drm/panthor: Skip devfreq when explicitly disabled
  dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen AM schema
  drm/panthor: Add Mali v15 hardware support

 .../bindings/gpu/arm,mali-gen5-am.yaml        |  63 ++++++
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/panthor/panthor_devfreq.c     |   9 +-
 drivers/gpu/drm/panthor/panthor_device.h      | 105 +++------
 drivers/gpu/drm/panthor/panthor_device_io.h   |  84 ++++++++
 drivers/gpu/drm/panthor/panthor_drv.c         |  14 +-
 drivers/gpu/drm/panthor/panthor_fw.c          |   7 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h     |   2 -
 drivers/gpu/drm/panthor/panthor_gpu.c         |   9 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   |  42 ++++
 drivers/gpu/drm/panthor/panthor_gpu_regs.h    |   4 +-
 drivers/gpu/drm/panthor/panthor_heap.c        |   3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 202 ++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_hw.h          |  61 +++++-
 drivers/gpu/drm/panthor/panthor_mmu.c         |  47 ++--
 drivers/gpu/drm/panthor/panthor_mmu_regs.h    |  23 +-
 drivers/gpu/drm/panthor/panthor_pwr.c         |   2 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h    |   2 -
 include/uapi/drm/panthor_drm.h                |  23 +-
 19 files changed, 554 insertions(+), 149 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h

--
2.43.0

