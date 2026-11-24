Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB825606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB4110E7D5;
	Tue, 24 Nov 2026 06:20:52 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023073.outbound.protection.outlook.com [52.101.127.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCCB10E7D5
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ikkxp3ME74nPMIN0yL+sf8xKXjKuFANgA+lLp9iOS9Kd1gzs83rFiXkH0YX/dARS5xHiufS+QLaFioN+HvpbeAx6rbrKFFB7FpXOf14lvEmXTjwevy8EKh6bP+PnmzSaPfwRwWxnvVJMOZcJgJytDITDaxzr/0pd31RZzMJ5dvKpw6ukxm8niQxYC/eMRQfzGKrM1JKONzdcFGp5gKMxg/C4sjZhFZhhXx4Ki+ZzDpUxuXWyMmp16YQyU4+aSs/XnzlIe4eSeBTIZzKHGRjXhH4Boa3/naRehd8CUBcF4TRWVdPizcXujnh5DVVVTY6t2pw0t5Ta/g15w7U1ZlYrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ2NeUROqKIM1qkArGoQxaXUmesQVvge98lKAIja628=;
 b=bwKstWJvSPfKwVMeFFvlGE5DAX5+I7LSJFOe5z1kdoe+Woi6SRoM7X3BbGJA9kV+zkvTzvAOI4F5abQwL2YculR+rNmZHjV/Y0m9rRGdaGzuhTo+m5RxDwKUfaz9Lb3HfW8G0wvAV7M6GLMX2lENtH7Vop1chI3kw4J4+NdlwegLczdOCsK+EDZBAq67tsBwjJw+ep7gdFVupMYka+HnZOLXD3qxlRs9h6dO0VZPhzpT98Z4wou2k5d8wwj6LKOFoY94QmmRH/HSnB2FkaDJKUO5xxA7RCjF0XNraer++9wHU+WUZazweK1MgBxGUk7aUUC13EHtUjkt1MdaX9WNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI3PR03CA0014.apcprd03.prod.outlook.com (2603:1096:4:297::15)
 by SEZPR06MB5342.apcprd06.prod.outlook.com (2603:1096:101:7e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 06:20:47 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:297:cafe::2b) by SI3PR03CA0014.outlook.office365.com
 (2603:1096:4:297::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 06:20:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 06:20:46 +0000
Received: from cix (unknown [172.16.64.42])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0347C427EFC6;
 Tue, 24 Nov 2026 14:20:45 +0800 (CST)
Date: Tue, 24 Nov 2026 14:20:43 +0800
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, gary.yang@cixtech.com, fugang.duan@cixtech.com,
 daniel.almeida@collabora.com, aliceryhl@google.com,
 p.zabel@pengutronix.de, daniel@fooishbar.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com
Subject: Re: [PATCH v3 5/7] dt-bindings: gpu: Add CIX Sky1 Mali support
Message-ID: <awUsu8VCu9HdzSLe@cix>
References: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
 <20261119123850.2994625-6-cunyuan.liu@cixtech.com>
 <20261122-efficient-lobster-of-foundation-abd517@quoll>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-efficient-lobster-of-foundation-abd517@quoll>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|SEZPR06MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b6f106-91fc-4ddd-cbac-08df49f313c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700016|23010399003|1800799024|18002099003|22082099003|56012099006|4143699003|261028144727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: dKSOuN17JmoKfTBpdyzCTMPcf6s1k6oZmK1428VjX5ZKTOjVI08pFUgRXTmfEsRmsaO7jZEzSBkd6h+ALxXD6sLsAimaImyDI9AJ6ylgX+5pTIULRCip6EDAPpa3+NDLC363QWP6cZkXJ0UOGt6kMOJqjC3bQ6N0CN4t46yIoYR7dwYAxiAvQyjq+1vPutxNembZ1zC+esUwgKCA8B7jMXgdZddKl5SzrjvbSKno4zXO1fGzLeNiVjoORatz2AsICJHF9ytf6DtzyEfc0KSFcX35VDrAc1krlrXrmXwTIDU9ytb2fxSVEm4tcyHRKM+VhWAhpz0g/RjNmwkJ+Q+4E5ZSt42qKaEXiAOykbrhs6jkbGT/yP7vV03ZKi433O185hEUODcFxZQodjkkWgDG+Pw4104gqCBjP6Vwgb+3g+dgbNXynhfjY0sq05OFeEzTSWQykdMjzosnaI85ZLEybXKvAjJVRXhEZovAz3NUhiNowOJpGWROL4MGxH0izawTlxPKJ4ZjdAtLbE0rEs1jpZoem95Sk9PH9PqlaTpCOIi5tmLxEDNNfZ/YzynLfZHXBtytjSE43IusluTP4adob5+anQnlORaHph2HO8lPd4A/bQdzVST2MB64P8qzFdAvQjKJnPKVZOGU+WVL5v6Aoa4FsclDHn3e1aTbUdzD1qI86NBKWm58D57H3oEsUvU/xuSqv+F4JklYDnGXq3RNRQ==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Eivp4tG8gbPEfbi0Rf21LjkQ73w6fpg82OT+xj83CNWxb8bbonoY8LQJYW057RI/Zz35NamkF+gyLrgA1j9GotPF2wZD4mE+WlPQGnMCUtIcWFYdzOPZeC6MPqzhqR7iEPMvphCLNez8euZKpEqycfZj0zK3i1tIYhID76s3L9t2eJDOekcMMdPJH+kWnUvdWJUauWBAnWACOM5ZIVbcwlifwHIdYDYyCglIxVTfFsjNKeeAGD0FaHiE092vnk5B0GVoElPH4Kt6HFLd59xB4OsDFHQeWz9AXGFoH/rcu/9hKQAv+eZt3lGKhLCLLP2Xa11YrnKSeuM1UmL63yOXAyOslpbMR7GR08aQufjjSNe57stjjQKvr9rJNf2/ViHZ7stfeY2cziLilWQdRci535emmDYua1kdIHHHspB48dsg0awOEXvZ8KyVVv7ahykP
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:20:46.5732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b6f106-91fc-4ddd-cbac-08df49f313c6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5342
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On 2026-11-22 18:01:46 +0100, Krzysztof Kozlowski wrote:
> So what changed here exactly that you decided to drop review? I run b4
> diff and there is no relevant difference.

Sorry for not noting this in the changelog. Compared to v2, I added
"arm,sysc-alloc" to the required list and example for "cix,sky1-mali",
so I dropped Conor's Acked-by out of caution (I noted this in the
cover letter, not in this patch's changelog).

If we decide in patch 3/7 to drop the "arm,sysc-alloc" DT property,
this patch will match v2 again and I will restore Conor's Acked-by in
the next version.

Best regards,
Cunyuan
