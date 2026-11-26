Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C404606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=A1v2kBGQ;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=A1v2kBGQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F7010E3FB;
	Thu, 26 Nov 2026 20:58:44 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1188C10E3FB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:58:27 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RQAxUGWLS/KL0ntLwBDyAZ2AWVAW2dvnJB7i2MU0P45BHYwYl7XuHHUVpmz1p2GR9SBwwBzFh33jhLUBkxcLI7gYkRaFgj3Pn0kqvJUQW+O5WLEWItUm69z0cxinJzd4kQh00nvsnQRATFpQupR4C3vrv/KaT2R+NGr/yA4f6YPXSKdTGGgtOMmz+GYO7t0331LH7f8ejSq9U2bQM4DQA4UuU7SMNEvZYqvjS/X1i+5w9593y+ibqlvtOpBWw5kvWYyaThN5cfrQZYNsVV+R9+LXlfP2CZO8TKB+JciICxoCzZYZH8C+XNk1RAb0hLGoE5vxxCHNwNTbYUgjJRUY0g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JLVeZgUeKt48OmAhCrN5Gu2rPd5g7mg36poEMnpbUk=;
 b=Uio6YT/bBxSygehmhlyyIeVlVSDAmZ0LqVedfE/G3ajpAugGCLw4nfIBdYjc5DLw3R3Fq7Sz0mhYQ+As3Y4d82k0UCGmLeD+V56afbuaGa4M3R5mvk62P0VJLbU8tr37e/i9M40bo/wpWD68TyyXPSnOgT6KGh912ir+m272s9EkgA//XyOON4eilQwLrW83nEnwnSO2CyoPbvJNlubGluJPkLxfU51eKOpnlzuEdyl3Mwfjim+JYpcHbyuCJy7bBMYoQUAzdsH3Ds5BfWn36fmmPbiIutR/Mp0RdOu95SaHJ1bNmoyxvYoY6FkacTLU9bbLi/tR+D2wr3AJkaqsGQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JLVeZgUeKt48OmAhCrN5Gu2rPd5g7mg36poEMnpbUk=;
 b=A1v2kBGQySZZAaV9MDMHU89ZHJ68YH5Vd1bfqCcwSsCTUeToB3wI7nScbxASaqihETpNUNe/35Hm27YNQcoiVpNuT25OSgB/zglYSPVNJDeIeWTmjjZXgbWPCYj8+vyblcdASPQi8THEpfC7MzlG1lda3SOHsWhkDgydPguuhe8=
Received: from PR3P191CA0046.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::21)
 by MI3PR08MB12008.eurprd08.prod.outlook.com (2603:10a6:290:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 20:58:17 +0000
Received: from AM7PEPF00000052.EURPRD83.prod.outlook.com
 (2603:10a6:102:55:cafe::35) by PR3P191CA0046.outlook.office365.com
 (2603:10a6:102:55::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 20:58:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000052.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Thu, 26 Nov 2026 20:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjB42foQqnyOCnSzAzFk3ANt7R15QeToS2cTy0ArQ5XjNIgU77Vc2WhmQkrWdz3T7fB3we5WwCwCUIV+RML/2PTM6bh0JtvU71cXxhKiivqu4fX6sTF7jhyuvOfnrWTL2iJ7I+gh0eDCt0uUaGs3EtAC+EbeBOrdWvuH77GiHZd/fEDLCEvDphwWWsQjE6aU0o3SNmS0F1dliF0aqJ8ZjU/pxEGJM8MfnhqOh/w02IiWNKXS66baCqtZJoqVyXhbd/tFZlJaiKZ+KqgUt1qqUsx3AOAh7yGUs93L13J7hjJ0et081AZvu8hxqDYSyqCBbWqCZ9dYvheVTmbCvTpFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JLVeZgUeKt48OmAhCrN5Gu2rPd5g7mg36poEMnpbUk=;
 b=rj5gkPYC1SDiYBUr/mDv1KHwlPSTocqoJ7aJGp98SZ+1xolXyRy/ilO2eV/IhGhbUiAc+OlhfsihReKIxrcSgGMRk2VpCPAVqR/tjF2xcHpfPd0yzSDWyQaJh/C/5cL0/DPgRKNZNaZPO6FTdpGZ1loEuuHNqPuA50xJuYH2eh+VEdfs0XxYa/8McTjMIdCBSWR8NK9aXGU2UC2r0F0r/kE/JZmpjZwNtxTgnwZ4sBpnW0otvxzIvzM7kzhVzyo2oWNWOB/jUXMV1DokzzqChOFwwIJZNrxK6CagYPgKxvEQVEn8oh529+yfwp1qwXo24dEXFven6pXlB1e5BSMmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JLVeZgUeKt48OmAhCrN5Gu2rPd5g7mg36poEMnpbUk=;
 b=A1v2kBGQySZZAaV9MDMHU89ZHJ68YH5Vd1bfqCcwSsCTUeToB3wI7nScbxASaqihETpNUNe/35Hm27YNQcoiVpNuT25OSgB/zglYSPVNJDeIeWTmjjZXgbWPCYj8+vyblcdASPQi8THEpfC7MzlG1lda3SOHsWhkDgydPguuhe8=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by MA9PR08MB045061.eurprd08.prod.outlook.com (2603:10a6:250:115::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 20:57:42 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 20:57:42 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: [PATCH v8 0/3] drm/panthor: Performance counter implementation
 with single manual client support
Date: Thu, 26 Nov 2026 20:57:36 +0000
Message-Id: <20261126-panthor-performance-counters-v8-0-6e7db0ec33f5@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAECdCGsC/32Nyw6CMBAAf4Xs2Zp25SGe/A/DoZRFakLbbAvRE
 P5dwLvHSSYzC0RiSxFu2QJMs43Wuw2upwzMoN2ThO02BpRYygJrEbRLg2cRiHvPo3aGhPGTS8R
 RFHXekca8MtjClghMvX0f+Ufz4zi1LzJpb+7GYGPy/Dn+c7V7x0pJpf6v5kpIodBcMK8LWWJ/1
 zyejR+hWdf1C5D2DmPYAAAA
X-Change-ID: 20260529-panthor-performance-counters-594dea247c2b
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
 Mihail Atanassov <mihail.atanassov@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PR3PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::12) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|MA9PR08MB045061:EE_|AM7PEPF00000052:EE_|MI3PR08MB12008:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d837c18-0c7c-4c2b-1ca8-08df4bfffe24
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|11063799006|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info-Original: Vty9mJN+MAsZ/bgxj0oDbo+ytVRy40YWaVnrt3V3SSZWzWxsClPRz8cd4ppsz2IgPPxYa/jjMPDmp8i43gCAnqksG4MHeHVVw8dztcHd8bO/D+kc7ljP0I337mI6VhNfCnegvwI9/VuXamI5F0/LCE0JlYLzLK1OoKWy7fF4PUYAyCQM+mSbWdoW5FXv73jWeCp9DK5JtnlVjV9DXEYs1Yfea2bQ7srYi0HPZDeOA8Mg+ndt/h71faERErsJVd5bW1bCUoZbpSWLqmbdAGuLHMym0koCj/BHj4PYLsSiiAe1LVfc+xXCxgltOBL4g2yUIjo4uicnoh8htw6mS0mmwqWN7rk7KUzdaR2Zbd8XbUKfN+aCwYxNbWvsPzvL7JDAXhZ398izkWWnwbIwEXDPmhWF4T271lDYTELFmU2mdUXMJK1CDVurgEA3vZJxaBk5uriCt40mMq1RlHI3xKBkZz4fhR//DrPIxVEq0eq5Mlm5XQTkgnyGleyBUzR45q9/x2YMzU7u0vW4A6oe+AlOKz37WD/3NxbdY0+18/f66LVq2S8Yg9ZGTnfQ/dCDOJoD04fskxxa+44S5ynXizXyotaOCKv6vtza3Neb6lDIP2eiZyKSlDYkGLwc98k9mS5mOo0tCMzmtddCyfNiPKv/c6QK2Muekr8LQjclCAazShI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(11063799006)(18002099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: KrAr4SkdtJwRigFsS+mM982eD8ml7L9z3qEq/BJo6NPnbhw4stx03ViAvKvcveeYMS1IcxrbzZ/sVl9ue3q7zoVUkFqCe1iEBGU1YyXqRWSs306N6Rp3nkMOTsvavbXR361Gt7g9HIETdqI00DZMyNpsAQIh4HiiAKOAtRxzTmPIa+2g+bXHvIDsTK3Ph0XXUAPtsFxQWBz/DrOBdxdiYofWqrkxdP4JGMeljQdTbp3EkCvMPvaVLJEj5T0Tmz8q2Bsorfw7PgiQHrngBScNFZB1K28BjG3xzDE+OZEDa15pvl1BLYzwvaFkObQGI5rJ+46m//3ld170vfhJ3X6jjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB045061
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000052.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6fadd52e-3dab-4247-a8ca-08df4bffe9bd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|35042699022|36860700016|23010399003|14060799003|6133799003|261009223027099003|18002099003|3023799007|13003099007|921020|260925021911599003|260925021311599003|260925022911599003|10067099003|56012099006|261102123227099003|11063799006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: sleNz+shxYM60tMxYxOws98vM7wV1loPNMtgeQgnJX+xxZMYuuLFWjv7/RnmiDKjuw+n/ot629HHk3tRQr/zWubkqobsT9UOx/Nex/CTL35UWqCp57bHmz2KQNHkHVg5nCnAfox3bxIqWL2PfOcUsZ2W5X95EtlR6YxEHMGd6otJphXuexMyuCoPchJLLmv4RTN38REf/KPrAbp++A0K4dOrGbDK8JwHr5yk9lJxhwnyEEYJuvNKF7dUkqlP9lq3KhoJ3dHNNV7Ob5yJKD9QP5EzcCJ8By/1r8+NX++0NhPIrT1hu99SC2fzEi3kljqgxVq0e9jORippFw/BwDjIV64JTRRAG1LHjT2ShbcIkDfsPpzfpTYdNmg8bu3kC84szjhA0wS98vbF5yG4HcXfOAl0NyxirdSTwuVjVJlZCecaQG9Duvi8zFHK9/gXgST0kqmX5mlf3doe1U2TuWEK32cQwTQgiUqvNUsojX+soWjHuEcdUGSsHKuOBMBFef8eKlHRwuE9rQLbclqUrDsFWkCPZocnn7zHPRXIS0IT8VFdNNivZMhEsPDFlG1x5qgyEjbqBnVDjLYhPn/3XPm3000ri9TeywkvruZZHKG+CmIdmMaT5+VE5ORbO6WMJd+JHdgltLc/wmQ1JaaBMRH3b/DF4OGLvw9PNpkNhPXbssoZdKwqGjUEN1/8xYn5/lqS
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(35042699022)(36860700016)(23010399003)(14060799003)(6133799003)(261009223027099003)(18002099003)(3023799007)(13003099007)(921020)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(56012099006)(261102123227099003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hrrxa6rTYJvoy0hDUMuU37ygxx0fuZl67PsYJNXNyXQO5oJ5T09Yf9+YnoGyswj5aoYHHYN3IKSNzQ0qPjcWw411wBV2UsXvdiahtyHC51ThK9XpZh76Yq/oJC6FS55WaadiMbKxSxUKw2OrtPZzI29BhvcJ9QlVuDGBD1lap45N2Nbjm4b9I3OD+SD+0hRgUr3sP2vUMZV7EWRLKBoGygwb7PzAga2WBsKWpsM++u25GDmV2SS4niyh7ZVsO5vuYI6VPxmeu/49l8tisKZ3P9cIx+26C3BWp3CdcaWR9EZOYTA7tZyagW3q+0J5DHIPUZ6VtqPnGvMsJYPddagPGWbb4zFjXKkiaLRjMufzxxJjuXbbQy+PSoYMAS34UQdkBfvcOHa9b2EzEPQnf1/RyOeRZX7i+AHq/uxyvGIfePIeg9ZJvhg0ydEiE43XYkF1
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 20:58:16.1403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d837c18-0c7c-4c2b-1ca8-08df4bfffe24
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000052.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR08MB12008
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

This patch set implements initial support for performance counter
sampling in Panthor, as a follow-up for Adrián Larumbe's patch
set [1]. In response to follow-up comments on v6, uAPI features that
were not being populated in the original series are now dropped, leaving
only the features necessary for the initial implementation.

The Mali performance counters are controlled via a global firmware
interface to point to a buffer that contains samples of either 64 or 128
32-bit counters per block instance. Each of the block types has its own
32-bit enable mask, allowing for finer-grained control of which counters
are emitted. The size of the sample is dictated by the sum of the
FIRMWARE_SIZE and the HARDWARE_SIZE fields, but neither the FW nor the
HW provide sufficient information about what block types are present at
what offsets. This information is architectural, and may change between
different major versions, as well as different firmware revisions.

To work around the instability of the counter block layout, the kernel
maintains its own offset table per GPU, and provides that via
additional block headers inserted into the data. This enables old
userspace clients to interpret a buffer copied over directly from hardware,
and lets users like libGPUCounters[2] embedded in an executable retain some
level of support for counter sampling without being updated.

The following performance counter implementation supports a single
userspace explicitly requesting samples via ioctl, and managing the
consumed samples via a ring buffer and a set of control indices. The
user client passes in the resources to create a session, at which point
they can explicitly enable or disable sampling via the
PERF_SESSION_START/PERF_SESSION_STOP ioctls.

Samples are requested via an explicit PERF_SESSION_SAMPLE ioctl. When
the request round trips back to the KMD, an eventfd is signaled for the
user indicating that the sample is complete and can be found in the
shared user/kernel ring buffer.

Existing performance counter workflows, such as those in game
engines, and user-space power models/governor implementations
require the ability to simultaneously obtain counter data on the same
driver. Though this is not enabled out of the box, handling for multiple
sessions sampling at different cadences is added via the sample
accumulation handling.

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/35024

Changes in v8:
- Consolidated the series into three patches.
- Converted bitmaps to use DECLARE_BITMAP directly.
- Documented session_try_start and session_try_stop return values.
- Added overflow checks for the user_sample_size.
- Reworked session destruction order.
- Reset session state on start.
- Added graceful failure for perf registration.
- Documented interface use and memory barriers
- Fixed ring buffer size wording in the uAPI docs, and relax user buffer
  size requirements
- Link to v7: https://patch.msgid.link/20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com

Changes in v7:
- Move the perf commands into their own ioctls
- Moved session tracking to the pfile
- Fixed padding on uAPI structs
- Removed the sampler abstraction
- Moved new registers to a separate commit
- Drop the offset argument for session creation
- Drop the count of enabled clients, using the session_list directly
- Removed the r-b's due to significant changes in the patches
- Added check for CAP_PERFMON on session setup
- Fixed architectural handling of prfcnt_en
- Link to v6: https://lore.kernel.org/dri-devel/20251215171453.2506348-1-lukas.zapolskas@arm.com/

Changes in v6:
- xa_erase -> xa_delete to fix up dangling session issues
- Move setting user data into request callback to avoid setting it on error
- Embed the enable mask into the sampler
- Added helper for sample_enable and sampler_disable to eliminate duplicate checks
- Drop PM reference on session enable failure
- Drop the panthor_perf_em_zero function
- Added R-b's for the first several patches
- Added reading of the PRFCNT_FEATURES register on supporting architectures
- link to v5: https://lore.kernel.org/dri-devel/cover.1753449448.git.lukas.zapolskas@arm.com/

Changes in v5:
- Started re-using perf info size fields instead of
  recomputing the size where needed
- Removed panthor_file pointer to the drm_file
- Fixed ordering of subsystem unplug on init failure
- Using the kernel struct size to allocate memory for user-passed
  uAPI struct.
- Inlined panthor_perf_sampler_{suspend,resume} into
  panthor_perf_{suspend,resume}
- Inlined
- Updated all callers of CIRC_SPACE_TO_END to use CIRC_SPACE
  for correct ring buffer wraparound.
- Free the session and sampler enable maps on termination
- Drop the return values from panthor_perf_{suspend,resume}
- Update userdata and end timestamp on accumulation
- Removed the ptdev checks on suspend and resume paths
- Link to v4: https://lore.kernel.org/dri-devel/cover.1747148172.git.lukas.zapolskas@arm.com/

Changes in v4:
- Added sample size to the uAPI.
- Clarified the bit-to-counter mapping for enable masks.
- Fixed IRQ handling: the PERFCNT_THRESHOLD and PERFCNT_OVERFLOW
  interrupts can be handled by checking the difference between the
  REQ and ACK bits, whereas PERFCNT_SAMPLE needs external data to
  validate.
- FW ring buffer indices are now only wrapped when reading the buffer
  and are otherwise left in their pre-wrapped form.
- Accumulation index is now bumped after the first copy.
- All insert and extract index reads now use the proper, full-width
  type.
- L2 slices are now computed via a macro to extract the relevant
  bits from the MEM_FEATURES register. This macro was moved from
  the uAPI due to changes in the register making it unstable.
- Consistently take the sampler lock to check if a sample has been
  requested.
- Link to v3: https://lore.kernel.org/dri-devel/cover.1743517880.git.lukas.zapolskas@arm.com/

Changes in v3:
- Fixed offset issues into FW ring buffer
- Fixed sparse shader core handling
- Added pre- and post- reset handlers
- Added module param to control size of FW ring buffer
- Clarified naming on sampler functions
- Added error logging for PERF_SETUP
- Link to v2: https://lore.kernel.org/dri-devel/20241211165024.490748-1-lukas.zapolskas@arm.com/

RFC v2:
- Link to v1: https://lore.kernel.org/lkml/20240305165820.585245-1-adrian.larumbe@collabora.com/T/#m67d1f89614fe35dc0560e8304d6731eb1a6942b6

[1]: https://lore.kernel.org/lkml/20240305165820.585245-1-adrian.larumbe@collabora.com/T/#m67d1f89614fe35dc0560e8304d6731eb1a6942b6
[2]: https://github.com/ARM-software/libGPUCounters

---
Lukas Zapolskas (3):
      drm/panthor: Add perf setup and session management
      drm/panthor: Implement performance counter firmware sampling
      drm/panthor: Expose performance counter queries and ioctls

 drivers/gpu/drm/panthor/Makefile           |    1 +
 drivers/gpu/drm/panthor/panthor_device.c   |   15 +-
 drivers/gpu/drm/panthor/panthor_device.h   |   12 +-
 drivers/gpu/drm/panthor/panthor_drv.c      |  137 +-
 drivers/gpu/drm/panthor/panthor_fw.c       |    7 +
 drivers/gpu/drm/panthor/panthor_fw.h       |    7 +
 drivers/gpu/drm/panthor/panthor_gpu.c      |    5 +
 drivers/gpu/drm/panthor/panthor_gpu.h      |    2 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |    4 +
 drivers/gpu/drm/panthor/panthor_perf.c     | 2030 ++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_perf.h     |   39 +
 include/uapi/drm/panthor_drm.h             |  479 +++++++
 12 files changed, 2734 insertions(+), 4 deletions(-)
---
base-commit: 97429bac371273886238bfcf63d78e7405cacb46
change-id: 20260529-panthor-performance-counters-594dea247c2b

Best regards,
--  
Lukas Zapolskas <lukas.zapolskas@arm.com>

