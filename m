Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A00606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LINaNEGQ;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LINaNEGQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9F210F6AB;
	Tue, 10 Nov 2026 15:40:10 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621EE10F138
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:39:58 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Y68Y2ZBLawViHKwDhPOO0HJ3sIkhMpBEkz5WW6OivbOsl1Ct+je8a1IbxyEh+GF72ePAdj4bLUU5ZKSDaY3uNFlmSiQ9R0aadodhvJ6EFY/crr/kfQZd7tGqXOnloA2t+M7X1D2KlJ83wUNSBcuAT5UC5yNEFDJWI2+jGGK9nWP/Rc3yv1fu3BQbRFEMfySY0pCfhRh2YdJVoNqWsARpLzsxokUfMR+69PVOQ1Yw88xAPHk4daIC4EiDvyz5aZZZ89yOdE6NrZfeeCgh8RHdc971ttUu+qUtVmqgcGwT3LEK068E9jrlgLb/Cb6soTx46NtPyiNcTawsW5g9MiwUSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=919dcPp3YZsoAcNl/5/hSakXNZXrur7iOBAxEa1CgTE=;
 b=ylJFeav7Vjs5kj63CF3NjRMdmw3flzyXgo4Al+bqkpSi9/uvIJV59GauG9gHjOSqsG27kQRrCCL3tgSI4jJcqGW7rrhq9dSYf9mV8+a1OeMSTfo63VX+Wa4SmgIo4sOlTRj2tMTQJGZIgBurX+BFTaeB5kfeNP8IIhLr86oF/4CghqlVALaSJn2ozedBs38BUZbXmSU9AZexoo6D64HfcIR8yVrhvCNvW/RlnuVKUoniDH0G6YaQfcw4CyR7KYXJlLg1pkzzRYxnh1cqnhTNpxUwnb0CMraFqniAcQ5q6wJlDOKO9L3eLpBl95611b/CR3sEGcZ473QLJWU6/Hgx/Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=919dcPp3YZsoAcNl/5/hSakXNZXrur7iOBAxEa1CgTE=;
 b=LINaNEGQjfG675aNLC5DVhalaPCGTD5O86HCOwQ8KzYpy6UB3ia3t9/0gNhn9+2YzHbJLUvUpYRVFL61qi8qIvOXRvRljsMTvJkfeUo6/9md0JfT+aU6G19nxuDG39IdbdCmtTVybGSWGsI+G9150FdkCvqvb+nLKcAxG7IlU3Q=
Received: from DU7P195CA0014.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::25)
 by DB9PR08MB8411.eurprd08.prod.outlook.com (2603:10a6:10:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:39:52 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::43) by DU7P195CA0014.outlook.office365.com
 (2603:10a6:10:54d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:39:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTGGSzQII2Qo/hYX0ThSZHhQ69HhoRNwgD+JlagAJibjPSx1mhUdgl/3uvLzaF/nOFFur05O4j7t6o2kX6u3bXydw06RrZf6n84lQqEfZcef84Er9s5JOH7PcCWwW5dqqAvKfGVxfly5ahfVRkF8LZBdAveXOApB0aoAwBmYckcGcDPsiHMprLsq994hG0R9PUN8gDtwHZgtn0taltkgHRF8g+dJi8/5J5VUFSKB9xhY8JRFrKDkcwXA8P2SqyCrgOo7mkK+rOn7CjgjrkoExVPnnM6s1FaSMjWCJ4QFEAjRc9oaVWgl+eZJ1InJz5/w+OpalZEfmQ2azWA3zZAZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=919dcPp3YZsoAcNl/5/hSakXNZXrur7iOBAxEa1CgTE=;
 b=PPphpp2gG491I5x5SOQHZxRhvR5dVrqLAcct+cK39tUXgy/YBbnKysBU9DSFopuPM5jhv3Kg/n1zRU4YeMxqTxhhTXMrcQKvG9hs/bTMyeXdJI8c0uVvyKhmpyTn60CLnhg2/cD0HbHq5bO5gi9HMGP1gcbpKTvVKab4YY/t2wGnaxTGO1SxKPn2XphbtwUBcAA7Ydh8Dwh9UbFz2Gl/uBl/gZiB2X2d/0MbQxvInU24hDVZZdJ9SxtcfwJ+ltxcUkue2oDuxRQtXl+p/vv4Y1DnlRHRd4uREwTWPzWt3T6F9Wne2FjTtv2XsqVZUqxr9jkvkMnLHwa2CgFKeO6ihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=919dcPp3YZsoAcNl/5/hSakXNZXrur7iOBAxEa1CgTE=;
 b=LINaNEGQjfG675aNLC5DVhalaPCGTD5O86HCOwQ8KzYpy6UB3ia3t9/0gNhn9+2YzHbJLUvUpYRVFL61qi8qIvOXRvRljsMTvJkfeUo6/9md0JfT+aU6G19nxuDG39IdbdCmtTVybGSWGsI+G9150FdkCvqvb+nLKcAxG7IlU3Q=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DB9PR08MB7844.eurprd08.prod.outlook.com
 (2603:10a6:10:39f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Tue, 10 Nov
 2026 15:39:19 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:39:19 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/28] drm/panthor: Add Mali v15 virtualization support
Date: Tue, 10 Nov 2026 15:38:21 +0000
Message-ID: <20261110153907.3241978-1-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0412.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::10) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DB9PR08MB7844:EE_|DU2PEPF00028D0C:EE_|DB9PR08MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0b9d65-8b6a-497b-3f8c-08df3f40dcaa
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|261022075727099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|56012099006|261026140227099003|261028144727099003|261102123227099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: FamX4hJCTCVpXRyBpbZ4Bsex3jQ9N0lfQLVYpNU35gOE8eBPKHAEh41ZxDWXIbA8gwJzldw7co0SBv0m2KEPO2N06cGZCxhJJ9id0L1iiAp0HBuUWdTV/t7YK+p5AMSzdQYoaq5THk8tJfJ2HAJbbvAFtBt0L4PNCftq2UrHRpI8aifzMLG9RIa/gP/4KwgScJXmKjv0MRqtWpAnHLqrTbFevkzWY0gyK8kLxAAlP+21P+BP2fWA99w6aN/3r+AvDKZPY6xtgGqMG2SMU2cVlukDYMFgvRY7Ml1d+Oza0vp8+lpW91n1rjYc1nfl+x43fDfQs9Iul68LbCILJZSgKpS8KUuau0JnYqbMoxaa2J7Oov5E1YhaNZc0HZ8WhuGa1B4YWXt3q+SgZVcsnSfIt2HwG4r3FlLy24epQvpOaVUAMFn64tlSjY/QzdilbyjEcHHmURs+sebtZ94UjJWFR+ktE0vGxzaoGSg+o8ZVwZfYvpEbkAxZ32YQhAeLzdomuS+9DF2bFHge/3yYCxsyBOutE1s46zZSumRzPtGDzEd41K+BfVXVI1sD56O0fqNdVba5jXOLSD2jigkbgPYGtu4plltVfgjpS0mFaPC2NtqvRWhEovnWJDMygHOjGKPC
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(261022075727099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(6133799003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: wNpcVwl8yIM20+vsC/lP+ggCaJWXPzKDeQTrJInyXFY75iBB2zmuUSXUrGvZ4snnvK8BDXJ4sNT+0VdQGQxGu4Ks/cLu61Yim82ukzGpiZRageXoRSVvXPBFEBux/6SaHVwi0QY/wKV2E7LBr+CaPaXJbhrdTvfI4NKxLZ9Mjucsk6/srtiom5pfBT4yOBJ2Sj88LS09+xwOOltTPKpTXwvfWnyr5hDrD5LTEFaQACY23iMrgxBKdkUY8gdc1zwtUoWMF7KbdmZv01kh2RyJvPdFHXLy2YUcTDLfg5Q6gHyTe1wVUsa+X1QNXwRL5S9NGe6o2ppkOx2Oj3CPJWz3dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7844
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 049a2a63-1bf8-447f-4e73-08df3f40c8bd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|14060799003|1800799024|376014|35042699022|18002099003|6133799003|3023799007|11063799006|56012099006|261021121427099003|261028144727099003|261102123227099003|261009223027099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: kBIUAkpQFnRx3iKBElxU9PS4QQVqsI/IuVgu3eaGaQl4G3hsqgcYrPJPTtq7cea8jsGyEp95OLD/vn5TLgq0rkHCkkjcj9Lx9i8GicVt6ZW6jNGGvKTEfprg1UNej2Fc+5tTJ/pUV5q9fqpikAcqT7udRFrvya86qs9uMhvSKNkG19qq8h6vUzt74dTJKOAj4gzgFq2c0kWbnEcJxVKCAR9yvM7D/72iU2qYlWoAISYTfGIuxq4s5q1GhwR+eBTl/QqqDV0q573mDq4pFZ5x5rQ49MvMFsZma4ZgXYXhRts7llsgTt041DY3QhEHQJtHeaeNhm40Tc+dNTxwQHQxXbMwivbMV6oVzBib4+zkZAp+kfTTK8nbOK9TRv8sUjI/oC51bXtv55IXoQHdgbakoPgMxlr4cIkbvRwD/aEHc1Ny5XYQvTVfxkgx7kQybGY6xD+EFyjTI1dkng3NmZhJ5pHWroobHLqUr/m5vuLHJi30V0tmnG6QS8EqHdU84/q84M17evRP/EvhbmISL4RQqHh/Dc8otKlBI4MRxjQ6MgeRnZEMXXfNOlhUdJ8sgjhfNl0hqzJznDTciYPZaVERwb6Y5LJQOguqVa5Haq1wz6rjzzR1FHaky/hVBqJ7vLtCPAdTB+gjfOjJcQPW//3P54V8WD3Q26Twh7mybTBrOYI=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(14060799003)(1800799024)(376014)(35042699022)(18002099003)(6133799003)(3023799007)(11063799006)(56012099006)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ki79q2qqnKNB0kVt5bh665c2+Otje9mjMUncnR3ky1/jy5rUVKdg3mHdpCT+8Lga5BkdZX0DSoNQRbPy52ClEiMLXu/u0ptiVir1g/6PfeMlBJCV0Q+zPx/S7fDGihH+2+r64nOo67MDaxOgSDCKt+I/mFRnKDKgcxBdc0x6Kgs0Y1bovn4/DukmRmpc5RKZ5hgPZcmXpxeyiQN9XdFiya9M+KYM8c6C/P0Z2XkpjUHeRGtxeYuEjb1YvMu0jMlqxCBtJCV9IhjBf6IisUm9t33QA5Jn3nRP7C4Aj0uelMCJrmuQ2SBnsLgydXTYuvIk2cuJPd9b3fTiEXETesf0Xq1lAGGnoKqC+7CswKQ8XmgBfwMHnTNJKVG7zxbL5hVwbefN3s71gVQK+jXJJoITxF+4yuioIEtW6HLItvvkKGE2aByDSAhBTS6oIm4oHxV+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:39:52.1334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0b9d65-8b6a-497b-3f8c-08df3f40dcaa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8411
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

This series adds HW-assisted para-virtualization support for Mali v15
GPUs. v15 GPUs provide 16 register sets for job submission known as
access windows (AWs). The GPU hardware itself is then time-sliced across
each requesting access window.

v2:
- Rebased on drm-misc-next and collected R-bs.
- Moved the Mali 5th-Gen AM GPU binding to a separate schema.
  Extended the AM system and arbitration bindings to describe
  resource assignments for GPUs that support partitioning.
- Corrected neural accelerator and GPU ID naming. Preserved GPU ID
  log output for older GPUs and fixed MMU interrupt initialization.
- Fixed runtime PM rollback and driver cleanup. Protected register
  access from shared IRQ handlers while the hardware is powered off.
- Strengthened AM protocol-version checks. Reworked message retries,
  arbitration command retries and timeout handling.
- Protected access-window assignments with a lock and saved requests
  received before assignment. Assigned all access windows to
  partition 0 when its mask is absent or zero.
- Reworked access-window request, grant and yield handling. Resent
  pending GPU requests after an arbiter restart.
- Stopped scheduler tick work before system suspend. Fixed resume
  retries, autosuspend after yield and cleanup during device removal.
- Improved handling of GPU access loss during firmware waits and
  reset. Cleared stale software reset state on resume.
- Added partition recovery during probe to ensure partitions reach
  RESET before arbitration starts.
- Bumped the DRM version to 1.10 for the extended gpu_info fields.
- Link to v1: https://lore.kernel.org/all/20260922204535.2850094-1-karunika.choo@arm.com/
v1:
- Rebased on drm-misc-next.
- Added device-tree bindings for the GPU and virtualization components.
- Improved GPU identification and register handling.
- Updated AM messaging to protocol v2.
- Improved GPU scheduling and recovery from timeouts and failed
  commands.
- Added access-window assignments through device tree and earlier GPU
  release when another window is waiting.
- Improved power management, driver setup and cleanup.
- Fixed races involving GPU resets, loss of access and late grants.
- Kept frequency reporting available without devfreq and documented
  scheduler timeout settings.
- Link to RFC: https://lore.kernel.org/all/20260528150546.3168527-1-karunika.choo@arm.com/

Karunika Choo (28):
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
  dt-bindings: gpu: panthor: Document AM system bindings
  drm/panthor: Add AM_SYSTEM platform driver
  dt-bindings: gpu: panthor: Document panthor-arbitration bindings
  drm/panthor: Add AM_PARTITION_CONTROL support
  drm/panthor: Add AM message helpers
  drm/panthor: Add AM_RESOURCE_GROUP support
  drm/panthor: Add arbitration scheduler
  drm/panthor: Route arbitration events
  drm/panthor: Add AW assignment tracking
  drm/panthor: Handle partition control INVALID_COMMAND interrupt
  drm/panthor: Request AW to yield GPU access on idle
  drm/panthor: Add access-window support
  drm/panthor: Synchronize HW component PM transitions
  drm/panthor: Quiesce scheduler tick during system suspend
  drm/panthor: Route HW component PM through access windows
  drm/panthor: Tolerate access-window loss during HW waits
  drm/panthor: Prevent missed post-yield cleanup due to reset
  drm/panthor: Reset partitions before starting arbitration

 .../testing/sysfs-driver-panthor-arbitration  |  18 +
 .../gpu/arm,mali-gen5-am-arbitration.yaml     | 198 ++++
 .../bindings/gpu/arm,mali-gen5-am-system.yaml | 196 ++++
 .../bindings/gpu/arm,mali-gen5-am.yaml        |  90 ++
 MAINTAINERS                                   |   2 +
 drivers/gpu/drm/panthor/Kconfig               |  20 +
 drivers/gpu/drm/panthor/Makefile              |   3 +
 drivers/gpu/drm/panthor/arbitration/Makefile  |  15 +
 .../panthor/arbitration/panthor_arbitration.h |  73 ++
 .../arbitration/panthor_arbitration_drv.c     | 451 +++++++++
 .../arbitration/panthor_arbitration_sched.c   | 882 ++++++++++++++++++
 .../arbitration/panthor_arbitration_sched.h   |  45 +
 .../arbitration/panthor_partition_control.c   | 525 +++++++++++
 .../arbitration/panthor_partition_control.h   |  29 +
 .../arbitration/panthor_resource_group.c      | 373 ++++++++
 .../arbitration/panthor_resource_group.h      |  20 +
 drivers/gpu/drm/panthor/panthor_am_msg.h      | 182 ++++
 drivers/gpu/drm/panthor/panthor_aw.c          | 689 ++++++++++++++
 drivers/gpu/drm/panthor/panthor_aw.h          |  57 ++
 drivers/gpu/drm/panthor/panthor_devfreq.c     |  29 +-
 drivers/gpu/drm/panthor/panthor_device.c      | 112 ++-
 drivers/gpu/drm/panthor/panthor_device.h      | 146 ++-
 drivers/gpu/drm/panthor/panthor_device_io.h   |  84 ++
 drivers/gpu/drm/panthor/panthor_drv.c         |  13 +-
 drivers/gpu/drm/panthor/panthor_fw.c          |  27 +-
 drivers/gpu/drm/panthor/panthor_fw.h          |   2 +
 drivers/gpu/drm/panthor/panthor_fw_regs.h     |   2 -
 drivers/gpu/drm/panthor/panthor_gpu.c         |  13 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   |  42 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h    |   4 +-
 drivers/gpu/drm/panthor/panthor_heap.c        |   3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 209 ++++-
 drivers/gpu/drm/panthor/panthor_hw.h          |  59 +-
 drivers/gpu/drm/panthor/panthor_mmu.c         |  47 +-
 drivers/gpu/drm/panthor/panthor_mmu_regs.h    |  23 +-
 drivers/gpu/drm/panthor/panthor_pwr.c         |  36 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h    |   2 -
 drivers/gpu/drm/panthor/panthor_sched.c       |  21 +
 drivers/gpu/drm/panthor/panthor_sched.h       |   2 +
 drivers/gpu/drm/panthor/system/Makefile       |  13 +
 .../drm/panthor/system/panthor_system_drv.c   | 344 +++++++
 include/uapi/drm/panthor_drm.h                |  23 +-
 42 files changed, 4939 insertions(+), 185 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-panthor-arbitration
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am.yaml
 create mode 100644 drivers/gpu/drm/panthor/arbitration/Makefile
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_am_msg.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_aw.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_aw.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
 create mode 100644 drivers/gpu/drm/panthor/system/Makefile
 create mode 100644 drivers/gpu/drm/panthor/system/panthor_system_drv.c

--
2.43.0

