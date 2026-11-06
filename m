Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E26606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Peyabi0V;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Peyabi0V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F197110E435;
	Fri,  6 Nov 2026 14:31:02 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F8E10E435
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:30:51 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WA/L/jat5Nqc+mx+TBwdPp78IGHMU40cNrqGiKgJhFSK9MMmsU/UPNYExK7P6I+Y3aKruWIkntVwYGwPcVkPn7ElO0FTWNlwlVCMAsygg4XWJk2uXJdhuFShTUxz1dUbkzmQz4Dy7HWKn4y8O1uR/W87oXF+t7Wn1uzeAjcBVGMrJKrx2L2hC5TVQzpsIjvveaw9FrV3uN5h8YjHDm8GDtM9zBBsdpJKw7Rb260+MkxE3C59joWEc+ftbfMs6g5YMvF795z7ByOYQnaw2pnuJMCTrPYvsAYpQEn+w0qDMZYXr/rEYLWwVPGxPJh5jCKgT3AyPYlYYQojxNyenCnMvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq+41/Q26boLhL3CuohefDfFczhQJ0XSODdaLWWeDqc=;
 b=xsUH3MSfOL1RLac857T6sEf6VSaZzKy89nJC2Y0NdNw2TWpy9Eyj93SC1Nb+88CJtyMFfoAKFhmfqHxSenehsdMWUIMcmB1FTKDofbgXbfJJQa2QxCsi/Bfv9kjv6/y02Fz0RgvvQH+yIL+b16kRvAYZ8ulR2YXE9yqWAz3nKwnb8mUARuHeV9Kxj4LpZYbbxw7wmAmtyx0gA4kuOyMorYz9mS4P4DBwUNargvKxcSv6QpNUZwj0LpHzyhETIyvhhWidaqg8F/XKEqaqkpUpIhssDUFOOKBoROLaeFi0vwDu3qbgpVT0jiIfNFPkg9fkt56ApxrH6SxSPMQ3ILv0XQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=suse.cz smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq+41/Q26boLhL3CuohefDfFczhQJ0XSODdaLWWeDqc=;
 b=Peyabi0V5OFKDOqr7q7pptQANSkBy1FJ5K6aEAn8C5Kv6d60cNlz6kxNHelweBWQ0mD98cC7iXXcNJ9XABDHKJCNKIxDRmNej0lEndN8MIWAhg4/6bnLzAULK97Fgi9nuydGw8a0R04VG5wcOIvfzVvVJp1nVJ23iIGKWw88bL4=
Received: from AS9PR06CA0119.eurprd06.prod.outlook.com (2603:10a6:20b:465::15)
 by VI0PR08MB11709.eurprd08.prod.outlook.com (2603:10a6:800:310::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 14:30:44 +0000
Received: from CPH1EPF00000524.eurprd05.prod.outlook.com
 (2603:10a6:20b:465:cafe::90) by AS9PR06CA0119.outlook.office365.com
 (2603:10a6:20b:465::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 14:30:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000524.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 14:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrWh/Y5VMla4rf5AhTEfriJNsb+yFlJY2oE9nptfLgYAhs7R0oWLFj+EA8isjfCPbhLqsQoNSOJuC9VyOz1cuNToyqaXvNVjsUSsKNabkYAxxqm6PV8VdPDy5nPFXWSKOIeYwgQKMxxXPtLe9J7XoUiqNDwVKa6ga/mRjTodsywgDTJ2bEWjmJhXfe5DAlSeXvs29BrrV997IaajH0KWmKjMwWNbdgimL38n7GH4GAamSsY8QalvJvzrLCsREhNoMcYQdvm9JqcuMi+3PMNvhW3kHVaCuUb44f/LJ5KgNnenWOx9Ber2vlgOuoZFr0wTLHMFV3AU5OC63mOOCcCCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq+41/Q26boLhL3CuohefDfFczhQJ0XSODdaLWWeDqc=;
 b=pbWUrNg12ClJ2AAP+w3WrO5mFehmpousspprQnzbSWLqy7coJsqYTi+8J9QFLhG/76JCTmu5k4+3W5q6q9mLZr+MwYJslEqvfuMqcqY+prc7VywLSR+0+2ggDE43uSw8auL4rTr3zdPH6Y5TKlbZ8RvxlB50RqEWEGbXi7v8iaFEnPt6dwfrvJQKyljIY/1IQFCe6oRyLAyvQh43MMML8/9YjaKhQTniZOYNaeMAg7p1Ik96bs5jJzD8e96NpQJb1Bny5dnXC+iyLnt8b9UmpX5dsFz8HzBVW0YNxz3Im82+Gx8stomQHVTfg3nlOcw2ehjh6seWjQSPK5lvdvEjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq+41/Q26boLhL3CuohefDfFczhQJ0XSODdaLWWeDqc=;
 b=Peyabi0V5OFKDOqr7q7pptQANSkBy1FJ5K6aEAn8C5Kv6d60cNlz6kxNHelweBWQ0mD98cC7iXXcNJ9XABDHKJCNKIxDRmNej0lEndN8MIWAhg4/6bnLzAULK97Fgi9nuydGw8a0R04VG5wcOIvfzVvVJp1nVJ23iIGKWw88bL4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by VI0PR08MB11381.eurprd08.prod.outlook.com
 (2603:10a6:800:2fe::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 14:30:09 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 14:30:09 +0000
Message-ID: <803191ed-6597-4b8d-af7d-812b1b494fee@arm.com>
Date: Fri, 6 Nov 2026 15:30:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add scope-based cleanup capability to eventfd_ctx
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
 <20261106-hinein-lagebericht-abbezahlen-cb826d68d175@brauner>
 <bba04255-5dee-4dd2-a877-5e169edceadc@arm.com>
 <sp6gvawt6petvrlky7g6pqaqsp3jwouu6ixarevis5m5vd7fwe@xjxeakzi3nn3>
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence.csokas@arm.com>
In-Reply-To: <sp6gvawt6petvrlky7g6pqaqsp3jwouu6ixarevis5m5vd7fwe@xjxeakzi3nn3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0611.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::10) To AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR08MB10291:EE_|VI0PR08MB11381:EE_|CPH1EPF00000524:EE_|VI0PR08MB11709:EE_
X-MS-Office365-Filtering-Correlation-Id: a06b969d-b38f-4874-44f0-08df3c128a42
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|6133799003|10067099003|3023799007|4143699003|11063799006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022115727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: chsBg0wiyiajp0z9q5D7Je9fq8WEuSxga9V51RsA+gy0ZTLmjBs5YgoaCwIsKcAVIoqYVhqHKvCvCWgYnG29F/6HiMlzhdKtCqD1xI6r+yW47ud5yRN3Oxix3JHPHGkrsvUm7qiv9hwdJRU78SahHmpVHF6UnVipUPRAwXd+x/C+339xiebLmu4ZAnXAPNGVCdPCS2KmJWI+kaHesnh7xFUv8/4QeO7Gk9sQLoeGQTTeW5JLhuscEDnmWohNJBW0woVK0JQkLwTq10vHSXlM4nXzq1myFZCedvWZl6Q8mzMPdEH9oHG7xpdRqkHch1s4H3kbLsHTAl336BLQAdTgIXI1sUXZ0C17OfGSO/BYA1pnTRxfkIu2DWSwScUklmg1GMtKmqEczGC7u7JiQT+5KPY/2IKYnEoHQnSQTM1EcPu4B0jbtXtclAaJfzJJNfcobryUOKwyZCz3Ev+/obhG9WE4B1u+HQEP1Ia6J9Fd1Ano2W1BsAItOuwha1UOEIpl4dLKH+X87sah5Qu4DfR/TV7f2Y8L+wRF3Cf5pcIe+lvY52jRqND/FggqGc3PuQYqriA6uEHRcYSQw0jhiz9VdheoCs+TygjUhjfLPFOGCeByl5Gsikih/cKWoAncI+YkDu8wIvmWHaL83DkCGHQFqTdG5LtyqtoGTret6YVYItM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR08MB10291.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022115727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: p5/mWeYUd3wJq5xq3CtA7zeKKOnGCMLshE5ggbX8GQmDsNBI6dRcgX20PJXBImNB8vLLpL5OeAVlKMirFOeEpH65fOePLJrw0LcUpzeiroVmrh3WM6cwEogbYcM/o9XfZ6BXtEElKhZ8p2CUjebPfSWVoMxECOM1I8aglLHpRDVBY6pbD0Y20UeBtzJAMKCxU//BVL+qMMLgL4e2qLwrOiuwi1VHmpEcP5urErw1CWLVrzpQmQbRCtEF5z2IPH29pZXKuDijB3qDQ8RT5d0iOEcPoxlJsgdKp5rSxzSzPFVhwiEAx+RhO7kmGzgj+q0BK+LAMg3l9uU8IMrv4OWzuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11381
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d5d29393-fab2-445c-106b-08df3c1275b5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|14060799003|23010399003|35042699022|1800799024|376014|7416014|6133799003|18002099003|10067099003|22082099003|261102123227099003|3023799007|261026121527099003|261022115727099003|4143699003|56012099006|11063799006|261022075727099003|261021123027099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: LHtUYGxJVv0B5LXSk/korFA+Pl3/rjwQSHOYd+S0eF+J0haBEsp9qGrNLmvH/XoIVdtLOslmQ1TLxqZ4mZveMXDoAFtVKv6p36eaVDvGoorSARHwMA5GTfh7rSAIJZfdYR49xTq5N0pTvcQqt/a3ajcNf56b+J9htBenMC2YWwaplUj4prfE6rvWi+/KN+zEjMvzezpadf5OGhktMMLW5QNeBHcPgO5LIcFooyaHXhRUtO78vXA8F3z4IP9qUs1vLhqlnZaAvL/riiwSA5ARCVjX2SbEgcFsZwyRpHKPUlIV7zXl6bQ9k9jX1BCSH+bb/1pLLhGq5DOz9SAyJFKleWTRweLVwDBMQjRZgzqOvS5sOnBdibUWvNtUcKs4evvJiDjEidp5m4JlJgr6nuz9arDmfD7EyA+A/LZVrNCQJbPR7muLNA6pnPgaOsUx4UNE+ngrnrskJBZZvrX+NyY9iGyWaLpX6cK65ua89DOqUTG9AL8zML/92oLzUTMB2oaVNgbwFkAWLVXrGirvM1XwDh2BsHm5ZCMRqIvZ4HI5deq20Tq7Lqxdd2sEMB9bJJMrjMVYa/gQCsFXVApyqADD6sdxXVRb+Y/LX7nktVRTKGQ+CS+RZYZhhxSVDoHM8ZJP8W/UQDmjn4QpjU2B8mBgV1RtxfUekNkXbo3OgrviWDArbKzE/sqgEEOavp82osAnVZe05ViCOCfAoxh06xmXgQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(14060799003)(23010399003)(35042699022)(1800799024)(376014)(7416014)(6133799003)(18002099003)(10067099003)(22082099003)(261102123227099003)(3023799007)(261026121527099003)(261022115727099003)(4143699003)(56012099006)(11063799006)(261022075727099003)(261021123027099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y1Ht8cnQEr0WDPMpQxxrM1R4ha7eqpG2mEr76DD8r/Q1pEiMfO8mlA3oWeGHEt1DDlbAxOKj7QS0wiBkNxUbl/iaQ4+4rFmg52jTRbwgl29SeAqdhui7HsolOT8pc3mEopWfJRN6c0DGxREhdO9fPirdh13+B6Zn+V2/tZFBz1h3afS/Z9RDjP6CvDeZbDO4jdUuhlZL8pOdqpCZvbMZy/2bk4+DExRgd4qo/dccK+TPfrlJBx4oLTo9XM7zYjTJ0fwC2ukXp/O1ThGTbwZtfsdcA8czZoFGMdBtkDlwoU7jZsqCNn9SQ++2iPbDP3hP2ZxJ/DpNUrcZH+GThf9rhhWVd9wRrCJYIX2OkD/Vcy5UrkZ2l8Q1aXiJyYK1NOOxiqLnmzQWyqWpGFj1Pbo/X9Fx9qOZ6enqPIj3J3gDS8CRkH4KZW3Tvfggz6bcWsj5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:30:43.5121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06b969d-b38f-4874-44f0-08df3c128a42
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11709
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 2026. 11. 06. 15:13, Jan Kara wrote:
> Hi!
> 
> On Fri 06-11-26 10:31:58, Bence Csókás wrote:
>> On 2026. 11. 06. 10:05, Christian Brauner wrote:
>>> On Tue, Oct 27, 2026 at 05:22:00PM +0100, Bence Csokas wrote:
>>>> Add __free() support to eventfd and update drm_syncobj to use it as an
>>>> example consumer.
>>>>
>>>> A minor discrepancy I encountered is whether to put a semicolon after
>>>> DEFINE_FREE(). It seems some in-tree code does, some doesn't. In the end,
>>>> I followed the example set in core-api/cleanup.rst, and omitted it.
>>>>
>>>> Signed-off-by: Bence Csokas <bence.csokas@arm.com>
>>>> ---
>>>
>>> I'm really having trouble seeing how this improves anything
>>> significantly. Probably others have the same impression which is why
>>> this doesn't get a lot of review.
>>
>> The goal of the __free() API is to reduce the number of goto-based error
>> paths. Normally, you'd have to keep the state of every local in your head
>> for every early return. (Has it been initialized? Has it been consumed? Or
>> does it need to be freed?) Then you need to arrange your "goto tree" (error
>> labels) in a way that frees everything, and then for every early exit, jump
>> to the correct one. This can be quite complex for some functions. Look at
>> KVM or HyperV eventfd code, for example.
>>
>> By contrast, you just mark the local var with _free() and an appropriate
>> destructor snippet, and the consumption point (the point after which we
>> don't need to free it on a return) with no_free_ptr(), and the compiler
>> instruments every early return accordingly.
> 
> Sure, but there's also the other side about which you don't speak: unless
> the destructor is trivial (like kfree()), there are implications about
> locking, when resources (such as references held by the object) get
> released etc. So it can also be more complex to wrap your head around
> __free usage than around standard cleanup code.

Sure. Thankfully eventfd_ctx_put() is one of the pretty trivial ones, 
basically just calling kfree() on itself when the kref drops to 0.

> So unless __free is providing a noticeable simplification of some goto
> hell, cleanup in many functions or similar, I generally don't find it worth
> it...
> 
> 								Honza

Look into for instance mshv_irqfd_assign() and weep... And then imagine 
how much simpler it'd be if it were using __free() instead.

For the example in 2/2, I deliberately chose one callsite where it's 
trivial to deduce that behaviour is unchanged.

Bence
