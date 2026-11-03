Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497860819F2
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=hpRxbvzX;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=hpRxbvzX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E6B10E4DE;
	Tue,  3 Nov 2026 10:56:08 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A92F10E4A4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 10:55:56 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qGjfaDsK5YqRo5eDs1Via1HOq9lcBB+YvssZxhtUJcpW1eB5uufnaVK/2xWlQGQpRrzksI1RoeiCNkMGtZx5PuYVTauim9607wxbs31au32+CGCZqBG0tHqQwxKqVzPch2+qvUUfbRkgD3NQdelMH/HegHPL0UfpdiJw1jh+VmVloLDO6VckewtMwSjMJ9tYgjfPX3plNvCDc3LFi9ZUzSStXvZEah4+2Qd3ILWnWb4QaRg/wvdCFa6XZAdBII3OO+zxeeyL06t4DVA1lEMxkh4fZoyLGT8TWGKQZTWFaI2/+EI65V+5tZiyfFoSAI32k5X98c43HzDiUiZUDg87oQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FvwUTJw/maeJvtYudQjvfiStGL0xbrXQrUd8DFGaZc=;
 b=mMj1dyFRKE+u3kvrbBXrHQUn3fkH5/lk4pD1Q+2J852/lM7oHz14wqKITbwFlS2bid4GRYTZ9cKJ7g90H6+8AW9h8xk1boy/x5GYcRAcYg70j70T5wuMcTUN42XwTinnAFgv7ZreXC8++6LzyIW30TXGkzcjrD7lXdrS66Ct86mB2VkYlBLR1E4F3T3SsT5t/2EpdC9jcnViI18Ki73ZJAolYnjZJfi41sjWZrPk+m5umNq6aQsMTQaRlROil8Pmka0JKBivFY6X891trYNuYmbMmfQhr0sYyLPtukfotRRHaRRozD0wTzcqnLa5/KEbHhgxTKPiu+yewT0Jfw8KNQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FvwUTJw/maeJvtYudQjvfiStGL0xbrXQrUd8DFGaZc=;
 b=hpRxbvzXPqMaK/N3y1QQ+I3t6YjRxV+ZjRnbCIyFaK2anj/Hok3XvD4nbNfy1PIOIOBmfbnTpKvli3bWwjBGAfj1cB2DsyNrAgB5x9RFSLWMGPm3+M4MDNBFL67HxGHy7tNMVpwjS9DGE02AhcpUWfq09azvUq0V9r1WWhbDj6k=
Received: from AM8P251CA0007.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::12)
 by DB9PR08MB8409.eurprd08.prod.outlook.com (2603:10a6:10:3d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:55:49 +0000
Received: from AM1PEPF000C1ADB.eurprd02.prod.outlook.com
 (2603:10a6:20b:21b:cafe::2f) by AM8P251CA0007.outlook.office365.com
 (2603:10a6:20b:21b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 10:55:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000C1ADB.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Tue, 3 Nov 2026 10:55:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Af66zRlcbTnjWDJyXVdqhyA0xQimf1NsyUhysMHKinWK59HtyAwPXt7tSAWSXg9SR/CdtHyq4bBytP4EVeju9Si3Gx0vK3wMUyYJynQGkh3USBtYmUCXEq3vX7a51+5D+U4X5NVmwfb9ge+0gS+DB9jC1WMbqd5jp2SVbrJrtwMwLRR5rFp+hOD1u4F8jhEyH863cOTDAqQN9+/Bq4NSkluNgLdFz64ySGc1Wm18NJPra7Gi5lrLP1AAbwfpffo86as9sb1N923wUMqmjY6pzugbUjXVRTtPaHw7KdxeSkBHF7/6MspSudmpq49Calk3BxpXrKqSp1S0Ef1Qzf+7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FvwUTJw/maeJvtYudQjvfiStGL0xbrXQrUd8DFGaZc=;
 b=PmtKb2nfiZmdDD+/mhScDUlwyJ0SMexNGUgPXpzNpgYTUwukec/S1de7pJH4sSWVdKWwMHbBqIAMoSAbAsXVqBHsOpno2huc1i+RAMtXnIksuBPVwdimUMZqOLImCOZJCIgFoP5pCG2ECfAbozo31L4QMpBe9rYWcpLSnzh0I07NBOA+GN/2YL8Bp9yT1JLgUXfFG/ekYZErPyLiIAF2fRScyCfqeg4dSdjq5L4QCV4+K1Yuwiv8ZMVM6bz1s/GNEHR6ccmUDTF6RFK6Oq/8uZZPoRgSSP3UmM4XtmCINgsz+CVZjwCoqxnaBYe4ptg7Dg0DccTLaMTKuDQeQTqhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FvwUTJw/maeJvtYudQjvfiStGL0xbrXQrUd8DFGaZc=;
 b=hpRxbvzXPqMaK/N3y1QQ+I3t6YjRxV+ZjRnbCIyFaK2anj/Hok3XvD4nbNfy1PIOIOBmfbnTpKvli3bWwjBGAfj1cB2DsyNrAgB5x9RFSLWMGPm3+M4MDNBFL67HxGHy7tNMVpwjS9DGE02AhcpUWfq09azvUq0V9r1WWhbDj6k=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by GVXPR08MB7725.eurprd08.prod.outlook.com (2603:10a6:150:6d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:55:15 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:55:14 +0000
Message-ID: <546e5e37-2fec-483f-a74f-eabf7cae1b37@arm.com>
Date: Tue, 3 Nov 2026 10:55:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Add more reviewers
To: Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Florent Tomasin <florent.tomasin@arm.com>,
 Daniel Stone <daniels@collabora.com>
References: <20261030144305.666845-1-liviu.dudau@arm.com>
 <20261030144805.667158-1-liviu.dudau@arm.com>
Content-Language: en-US
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
In-Reply-To: <20261030144805.667158-1-liviu.dudau@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0081.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::19) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|GVXPR08MB7725:EE_|AM1PEPF000C1ADB:EE_|DB9PR08MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ec12d3-076a-42bc-b13e-08df399904f9
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|261102123227099003|56012099006|4143699003|11063799006|261022105027099003|261026121527099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original: VCjJtDRIiEF+uDaQMiI+C/HTMu6W5XHyienLo9QnWy2UjdtwY0QoxOZW8TWi0tPdhdKv/PAw+Mvv6KtReemcTeG+jC+UhjWq+dZdmsHSHxxXL5ffjL1BDz+yGa6t8dSr3CLierA84XLysRP6h/CKRz220an/24G+IRnMkF/qFdLETC8pYW9AZBb0mdQgJ4LUmKTU2LdU4jYpNBask2Fq0V2EPHe8csgfveHbIinWY85tsFjFWQPkIPSYUZB0jb+z52OvjT6bGWUH4Ytck6mjIxtduuItzIssoIi6YN4PvhQazm1PQpwJOWZek2D1H5RGpqfx67SnbtNNKvrWZUKON2eBGhrmPDBkWSRDPyGl6M9ihlbsne0SIf6ul/j2UKewbKR9y85Pv/4EKcWBz6gBdSq45K+EjmOLyey9fs2rdqnz7wH0RoeYYvP+UeJ2NSdGUzQ/eQs+lEnkU1jinTcLM+H5cX6qJ2rx8yRy0tngHnzOr026SVPUW1/Rb7WtT3ayye0AWPLAEgTNUiNLkrRoNz3tQTDtXDbTvEM8AgoNXGUDpFfH5xeBhK77ggq9dL8KP8M3j2JlluQYvJvnCMlifk9ttIWaUJhqL79iu3AL0wc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: aNKYEsBJ/XL4Pf1gfV1p1U1c9jfIC0SVxhBm++2tuVrQbC7xhd2zl81ClDf5WWSFMZUX34nEP6UzvuJuMPSX/Fa/XrEENnvd1S5FWbl/T37xiBOD8Fsg3H1RQDrOUNv6mZIddhajDvdyul4OIHkk8X1AvmfdWN8pGflrO8ff+gF/fTyrK8IiKK79r2IfES0Vy2ogXC9r6VwjXXefiki1Lmm2J6j5CDYKqq0JMp7Zbz5f+8l/vrNrhhFSFCB6dm98ISNkDlC/ocJOBvj5KVggI0VvLQPV1HqettFM6txZHUQhELyKItkrIvQCdNi/G6Wlb1RblzbtdPkUf1dBvD5cnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7725
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000C1ADB.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9f033e4e-33c4-446b-7d07-08df3998f0a9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|23010399003|1800799024|14060799003|36860700016|82310400026|261026140227099003|4143699003|11063799006|56012099006|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261022075727099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: w9f2HZ3CWqNIkcOAPGplrvWh7k3g0wUDIo91gnyt6/edx86qM4Y/4FMsiR/mhLXWZUPFPd8KcGn2HEoHL0Jl0rjs/ytl+qWa8ofA/PKUEGi5m7Vq5anX8eJILhBOgDx4uQzKkSxk9VVb09npLUx3nL/afrqnRejYoFErgA+FDM7pnqdOml5S97+PznlwiWBQbW+gevRPGCaXjdR3oP4WoehZHqfthXh711sH3hiKDaWcS9yERDTa6rr69lk3qX7+0SP1ustQ8BynS6aQjVYjm4ActytywyBc6u4pHPcsCsnSvht7erLTqDz/hk26iJ+nV8B2fRaPblgFwZm8oSfZSQkC6VDOlmwqcXYrePxvOlHIY++I4YRjhQ+0rFeJprrJgv2k6WKfAAq5CH6JN9/zipOUj5xg/e2yGMm7BqdPWrmbJPR3fvZ7+iG/KU0d34VilPg/FMebjUL9CgfrWQIKB7ld53Ozu2nBAVzYY1cvwlLoMx30O+TIG/EteM0uF+id9FvztTte9TiuidFdhn+2/ztcOubK5bcDdb0Vhv3m1VKnfMayoei40oFJhOTWjSWNfrsQY9qYIIUROmm9rMwk9Plf0gEkFvTdX/B/R1T3yZRgAZg/yNjwJ0gD3BoBWNHdpTSItc3pmfKPu8UQDiHTog==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(23010399003)(1800799024)(14060799003)(36860700016)(82310400026)(261026140227099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fDY6nNDPkMsbtjhdqPyKFqziijrRgGUdxZlMx3tlj1rlmz17cIwgNP9Vg7eY9jvotXo7qcwprkbVZTgyfR5SdQPXZtxaNqufXEwzBMIN7pm+LPhT5UtaoQ1Nlnhw65nGkksYN7f0L5S2AUfzKMsoxskquSNHHaCGvrdiJbCy0Ux5Z3nozp8z1t0G3xllcWgKvggVNYgEf/uMGxs25eY3jddyRZ4GD6tH7H0O1I2W/JRFRzJ6uBr/5zEgVzYuT76mLGN8tmnZuwRVmkZvA6rKpbJwPBZkWaM/+c6HlONZPA6dQNXqTWatLCOKQoqcwudk+8xeaCBi8/9OXUYbxgi3ar8S7fpHDddz2iFVzkeNeUfoNG+6Cn9/N9UKJ55/fQLjiFw4qVUK6yCPgJWVSLM5NW7hMm2/yYI3jMU0ebqeZBktYaVxMUq/Qp18SiYVQtTm
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:55:48.5205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ec12d3-076a-42bc-b13e-08df399904f9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000C1ADB.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8409
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 30/10/2026 14:48, Liviu Dudau wrote:
> We now have more people that can do reviews and contribute patches
> to Panthor, so add their names to the list.
> 
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> ---
> v2: Forgot to add Chris Diamand to the list, fixed.
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89ea35a35c680..ef92c462a8381 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2321,6 +2321,10 @@ ARM MALI PANTHOR DRM DRIVER
>  M:	Boris Brezillon <boris.brezillon@collabora.com>
>  M:	Steven Price <steven.price@arm.com>
>  M:	Liviu Dudau <liviu.dudau@arm.com>
> +R:	Akash Goel <akash.goel@arm.com>
> +R:	Karunika Choo <karunika.choo@arm.com>
> +R:	Lukas Zapolskas <lukas.zapolskas@arm.com>
> +R:	Chris Diamand <chris.diamand@arm.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

Acked-by: Lukas Zapolskas <lukas.zapolskas@arm.com>

Kind regards,
Lukas
