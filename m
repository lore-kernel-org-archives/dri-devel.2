Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1160A2600
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=W7kma3Fn;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=W7kma3Fn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A71110FEE6;
	Wed, 18 Nov 2026 17:54:34 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DFF10FF07
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:54:23 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nrHSJqnOYuZlOZ9J2Q0wch5919HHyN4CMcFw/q/8br0SFNmGtf8jOK0Z8ihhJsImZUX24FQFRy7pfkCYVnZtHJOPuWyLDj/czmIZmCo9lqJMZcBwwpo58zynQqnB2TLqu1fI/8c8EKNnzoWWaag83xmBQITyUW1WlSUf0CcZPa37r0/nkjtYVQYkdehfHRp6BacLNKuXHJZCN4UVGH9r+jGJ5rm4CoxBOieSGek777/Ur/tvoGuyJK2u9wPMBsyltwFrvycTcCWlo/HqLnhZ7F6f4rye8XXTUemJyVHrBYXreT+QoRzkM9vTLHgPwE7Lr7Is3RK9hoVPlMTI/EgldQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LFv7CDb/zCrYc7tmmmqRyoX0HTBZsoliUVgVFic7QE=;
 b=T71hA1QxZsUMMR9aOmwipNm8B2+1xxYZ/DeOp+/TMPfibvqZ7OM0Z6to/Wcc449MLbZ5yhbf+TxDSBxVzit2STcB0UI7nDmzm+4w0d/THAYhXvwaKuUnpfjb9sI6hDtc9ufjDjeW09tk5YeEoZ1z9S+CA6lI9lhcw7WLpusEGSaVeH/VdiOQ9oWAd6wesS6mWKRgkas1f73235n3gb5x2VnVEDReeJBBXDh7Kyt9PxDJjZ9bk2zA2xG7N6sXhWmoEx+OmPC9fVVo9Ns4LHBogLUWgwk47yilNPFOTlcnftrbMGg+ck0O0cPbHdBO1fkp32LAvzH4+4FMACFJ4/sj6g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LFv7CDb/zCrYc7tmmmqRyoX0HTBZsoliUVgVFic7QE=;
 b=W7kma3Fn6H8/4wodM/5SjnhW2KxeT+Xycu5nK2NdYeeMgCCGpnFtn7VLjkPaJOQfJ68nP026DSDCPudHTjCJ6p5eOYQTyaj/V6RbDuoG7pDWRMEAIKBh9x9XrT3qIVxmM9ylczzapuIMk1iBsf7svdXuCuvY4nIuWfleTha1QJU=
Received: from VIUP296CA0038.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:34d::17)
 by AS8PR08MB9743.eurprd08.prod.outlook.com (2603:10a6:20b:615::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:54:15 +0000
Received: from MI3PEPF00008482.eurprd02.prod.outlook.com
 (2603:10a6:800:34d:cafe::1f) by VIUP296CA0038.outlook.office365.com
 (2603:10a6:800:34d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 17:54:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008482.mail.protection.outlook.com (10.167.240.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 18 Nov 2026 17:54:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLdSINR8HE3EgndD8VEn4+InNDKz1o6ANr0KOTEkiS+HUyO3KiZ1ZjuLLpCnUptS91/4eyaV1GezXRsfxPROmVsSbmM+73DvTcUapPFfsbV3AzDGbKOy8IQbYVKpfdGFqNpCFn8KOoIv3PAT9RSGDBiAB+3vRGSGcpcRAyn/ZUUJGx0eVgP694z+CFs2Sxzr6jVSfv7h3JLSB6rEnvijwlmc8xsudDENsp7neMRJEoTvBU1fKeU/LNDeUE/tc69gxyTkz3tfsMFdsAZQdAi4h8zW2M9xzRuTv5HknTng9bMbcfvnynMMQmoTaWx5PHLTCOZVJn6mdvMbbbUAJ3u28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LFv7CDb/zCrYc7tmmmqRyoX0HTBZsoliUVgVFic7QE=;
 b=RfTTrdiaO6ErOmVuAIw2624wd4hQpimlekC02O/5nIpTa0MtW3fbjslFmlV1snezaFnjXlCNWM2BMJHUZJ7HhGrAyJUmkpjWYu9Y9HqTzFCY2QSQqSUVtd0ek94REDbiES3Kn9Qw6M0sYsBaH7WakzzsbNqAECVRmlm+92OO5rfJnuwG/6RTsI8G/SWGr78uFuiRJ1EdXeVHIHu/loU5x7x01PrERD7B+V4bJhByN6d7V3ChRoUrflTumjHB9bt0cW2e5kzEXPhhPHtXnM42pHHntHenuEIiNM/IuSOCcY821xl3iYmOqzEI06TwA8x3nCT74myxo8YbovjhKhrY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LFv7CDb/zCrYc7tmmmqRyoX0HTBZsoliUVgVFic7QE=;
 b=W7kma3Fn6H8/4wodM/5SjnhW2KxeT+Xycu5nK2NdYeeMgCCGpnFtn7VLjkPaJOQfJ68nP026DSDCPudHTjCJ6p5eOYQTyaj/V6RbDuoG7pDWRMEAIKBh9x9XrT3qIVxmM9ylczzapuIMk1iBsf7svdXuCuvY4nIuWfleTha1QJU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB7739.eurprd08.prod.outlook.com
 (2603:10a6:10:3bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 17:53:42 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:53:42 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] drm/panthor: Add initial Mali v15 support
Date: Wed, 18 Nov 2026 17:53:16 +0000
Message-ID: <20261118175332.519657-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::16) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB7739:EE_|MI3PEPF00008482:EE_|AS8PR08MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: 37610906-3c32-40ed-4d0c-08df459cf5d8
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261022105027099003|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: nbF005C6RtmPQKkAZkxS9Tp+oDLX+sW7/l7a68yo9Ak5XXrykszzXC7Jfk3E1tYjZcCh5y8RFQe8HBpFI0Q/OXyAH9Nc/OtosusTxbaXd1G5vhWxOP4OrmaW6CjauttJ502G9cPGPPVlMccRo8fS+FmarHQirKPfz7CqZNvmeArrG/5AQRkc99CnTD4fUiZZokZhXvxB1JfR5WvhYAYp2qsUjy06Tp+OoQjyu50qyf7TFw5w6C+ReW0bLw4Ao1cUV9nlOQpAoFXhxUPJXoj3tD+fdJzZnmqZTKgGqiLoUkZ28pgOdHGVI8Mp9C8x69DK0z61wCmq/SWlXKm38s41Hxu2QyfNSFrmTJry7H1tZDu1GxauHJZvtUU+Sc8Bx39VXNcxtDD7u8aQkynxx+Xr64+8+GmBR658GE4pq0W/W7U37k0ElI0zgGpVrDkCZ4vTijtbAEfdtJ2Hm9tQQaUgYViMR6f9BFPqRWTb9W3FJVpSE6LypntuyM+vYR08NGGckyLWg2sdOjuuvEmL81fssCOEOKBqvrjENUQcPluT522Dto3qOmm6ZjEsbvfRho1dDQheIwO1quMAebsjmumls3/QZgCmeg1Kis17MUK3YywqR4PvVHFzgit0mUMbSIXU
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261022105027099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: kYLXLh+GwoLeFmEubyouvmWj3USCVyUz+hjKJwKYEAi4wBY/hCzuh1kkWT/3cG7rNR5gsCVx8MzMuAQWHA2lk6GC6iNDGyMZlZI7jmusj1WeM6rOFoKMvQDZgOmev/AZxM8HrHidPczumsCC9Zntcy+xly9PnVCREUMSJ9Y+pTsSw3U0KlW+Gl+Y1CfEDEFZdFK3gmc/e5M3cSFaPs26JoJorZsO0lfV2KDMhrOE0DmMyS5YyYmO25x/Ij50T8K2J9KTzQNtfYuqw+FIR3MPZ8HQyAbrjA96cKqsjZJn1cvM5rp4r9F4cLgzhSBSXlO6UeHxeWk3bKqPIi2qKY8Rug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7739
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 97eacb35-9cc9-429b-9bc8-08df459ce22a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|23010399003|14060799003|36860700016|1800799024|82310400026|56012099006|261022113327099003|10067099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|11063799006|261009223027099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: YtBcCysImynkhvBN3w8cK26XkeIbJEpdn3QzkH399ZiMjR6N/pZWEBs8W9K/6vfHLX/UbWrpUL56Hh932i9VS7+Gs7SMfVU6VQQeNddhPS9+7Vxp23Gm5bFOOUI1o0xe4oQoauri5wwNkZ3wpJoZkGpakUG7st+BTj5sFAKZTZezxq2A4mdPa1x7AZtLdJ6HOYRKIdhi2pFcXb+XYzh/F++WAgfp3NGUqFY3ii79VpJSHIY8Buucc0Lit13MhC22nKldKNhsDaQYLT7uoVPUuY63ShM9kvywVHZAIrNEVzvAKeMCp6L75Y0kjzf0vQrrVQBw4JWELzUrbIeAYx4XfJ2mFd7K3wNnFyuMhctzNk7WfdgzBInxgV62n/6YRvcr+pOmoVTVPzF8lJt7NVnQ9TQE8jjEnXLPrgjy73l9rfLosbygjgpt3AAT3NxpFMQ3cex/F9JmHpJe+ERNnpNeGVMh2uyBHpQgRs55QHA6J0Ytkv9ZBTYWnOSItIYtI5ZuBd5/7/YTIeCJ4WIf75NZ5hcPH1Z0A5zc4P5Bdh+v1KbLGppt3fQKLpKWEgqBUMOoePnhHWsAIAwb+vc8nSNrkKZrtA5jS2e+iLXJMne0Shv0a/4dASU7hOTb4RE1l9YleiSp3UTjeBSsiUa9pE6/pg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(23010399003)(14060799003)(36860700016)(1800799024)(82310400026)(56012099006)(261022113327099003)(10067099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(11063799006)(261009223027099003)(18002099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PUcTmDoWlgcpqMVyT3OeoGKwnQ4t6cnB8oIGe6u0qe4uQ1IjKDhodBG8kTF/IbyDUWrhtk3nd6YMQEZ85yPfarBKFaDTWVpfGzMLv0GNUuYRfQeu0T187MH8szJ6vWJ7sX2diowAatuYZyv9T36j6TjVujthvEY1xW8kReNVezYF/ZBwSlBiX7/gh11DMBdVTQcRWtNVukxrrlXopgEZpiw8vHN59RGn010pVqwQc9xjQ3LiCTfcDxgAG6+w2er/2Jr5vcr6Skq5+oFWfuqI31IeXaKzf9buJ5qiOe1YroUjMsiYq62PZGfCl6gflFVzVjkTe8iR+chYElvvlsZ0SMuOaJfm0Tv3BfZDd27TnbzGHO/d7HMs8K9o5P/dW5XuaLkgSGQV34cjtYwidgR2Ovyxd1QdJkPYGhXA+LL26kni23JWJZVJ8nnID7c3MPrg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:14.9844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37610906-3c32-40ed-4d0c-08df459cf5d8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9743
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

Karunika Choo (10):
  drm/panthor: Ignore -EOPNOTSUPP for shader-present nvmem lookup
  drm/panthor: Rename neural accelerator feature macro to NX
  drm/panthor: Move register access helpers out of panthor_device.h
  drm/panthor: Parse and store GPU_ID fields
  drm/panthor: Add 64-bit GPU_ID decoding for v15 GPUs
  drm/panthor: Move register base offsets to the HW description
  drm/panthor: Derive MMU AS register addresses from base and stride
  dt-bindings: gpu: mali-gen5-am: Add Mali 5th-Gen AM schema
  drm/panthor: Add Mali v15 hardware support
  drm/panthor: Skip devfreq when no OPP table is present

 .../bindings/gpu/arm,mali-gen5-am.yaml        |  89 ++++++++
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/panthor/panthor_devfreq.c     |  29 ++-
 drivers/gpu/drm/panthor/panthor_device.h      | 102 +++------
 drivers/gpu/drm/panthor/panthor_device_io.h   |  84 ++++++++
 drivers/gpu/drm/panthor/panthor_drv.c         |  10 +-
 drivers/gpu/drm/panthor/panthor_fw.c          |   7 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h     |   2 -
 drivers/gpu/drm/panthor/panthor_gpu.c         |   9 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   |  42 ++++
 drivers/gpu/drm/panthor/panthor_gpu_regs.h    |   4 +-
 drivers/gpu/drm/panthor/panthor_heap.c        |   3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 202 ++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_hw.h          |  57 ++++-
 drivers/gpu/drm/panthor/panthor_mmu.c         |  47 ++--
 drivers/gpu/drm/panthor/panthor_mmu_regs.h    |  23 +-
 drivers/gpu/drm/panthor/panthor_pwr.c         |   2 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h    |   2 -
 include/uapi/drm/panthor_drm.h                |  23 +-
 19 files changed, 584 insertions(+), 154 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h

--
2.43.0

