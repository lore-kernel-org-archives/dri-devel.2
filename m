Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E4BC982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF0710E949;
	Fri, 18 Sep 2026 16:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pP1sMWkm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pP1sMWkm";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013042.outbound.protection.outlook.com [52.101.72.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD0D10E949
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:40:13 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AX4yxV2QqAaFnvLd7G9nHtJ5Jt/vXegT69RAsr1u+VtlrNyeaYaG8YxDQh2iXIC1Qx2qAu3CMQcNyxZUgC09aSIZKP2oTD48HnqG8nw++gf+DlvRUjj5aZ4B4y0aOjNgQaz/vXWsp1RFrcfUjDADdrFbX5g7jP/FtcD52A+NbwlMg5RjY28hrLbvEubw7QEBEmzPT21qXcrQWlPzuYG1x+KbPfIk8obyBr6Ot5GNRh82TfZRroxA0tkZ+aSn2HYKwHl2dCA3hNPL2Ej8F6EsJ6EJ7twJ68PWnKNXYFPylGaiJueIYAfMeOYZDETA24A+y6ggHks5ngzww4RDVy6vDg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxkFMPC27bBpErC8Ucky9pke3NfCOlbHvOo8uhahTSc=;
 b=sphbQFPBS0Alrllz0+B6bLGCiN9PxVlRE9HRjajxujXgFY2G72mN73j/RKyxklp4Yj2158vRBA5NWJZtFGMZ1gpCvoaIu6YugMNs5oUISLedQMuhLWg9Q1YKbcrFwtcTDURBUsqzo2kLB2IB4Z4+0gXXTdgVnKzhEDpmPVxEXHIB1jABtaWBArU+sBab4EatH61sHVPEXRVVFHSRsozQSs5BRSZV+srMSq96qE6bEVOb8/jjaGpqUmb7wLczHXQONQlUvCfrpQZQ/3OShUPfQrw+XwAR0jjP7tzxceqgN66J3Mj9nYCU7w+x8DtyH33rSyrWgrVnU6SCqZ3JgDtqHg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxkFMPC27bBpErC8Ucky9pke3NfCOlbHvOo8uhahTSc=;
 b=pP1sMWkmiFUynAXzqyjMMP2W/ZpkrJtQFVuHRqxCiDxn/9r9zCHUvrUwkvKj8XIPebehmdrBXHQ23P7elVIKr7x1RXAV8+wc0Im0BD7PFdmc/EcDhg3lNKKaNkCHiDgRSYCvj0iGKQSmEqMF+bAYLMWxwgbVDu/p7Yq1K1wKlnY=
Received: from DUZP191CA0069.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::22)
 by DBBPR08MB10556.eurprd08.prod.outlook.com (2603:10a6:10:531::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 16:40:08 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::85) by DUZP191CA0069.outlook.office365.com
 (2603:10a6:10:4fa::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 16:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Fri, 18 Sep 2026 16:40:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvkV4RvU38LknKp1xdL6Itsxr10PdnJnmdnmX1J5vjEnhEo3foPKZTlqdQbME6pJ7AtMquBUW8YwPEAQpJcMuR+749+MZwaSbonywVC2gdJ0iQuik9HgMWOIdH7rN66TE02G8H76hPJk01JpQG9Vl2sPFq8W3UTGk5k5Fs9jsa/LqdEPg6EGBiYA4Kon/4arnrx5+zMgM7pz5BHqEnjCsw7cnDUA/7YStq/T/D5YHbR3K8JhYr3lVZgmPktjLOITk4KM9rOUcbS11vV5J2zqpE5X3OpNuBGSOCljzJlY9exBSe1xDSFQx3E6RGVvEzHRMF1vIedid1yvL5EB0RhndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxkFMPC27bBpErC8Ucky9pke3NfCOlbHvOo8uhahTSc=;
 b=P7aEF67rGWiq9uU0eOUAtm+h2bA9JliWj638Qt5c6W/G2fH2v3EcgL3GnoIwKlO5HLiooQnI5blvB747g5a7HUh9840JTP30hals9Q4kaOesL4uEIxxde3nUDAiZ3BkTClwoE56/t3QhBJgMdVTNabengZcTRoaWiMI0QOmWS/dLeb1AOgi/2l9/WTvOb8x1HfdKw4+XVAACBYyncxGJhyzEq7mYhUXDitpxhZZyTB97TJF3V5e3THWezpsfgXFnGesxCKZZOq3zhZyjrJ9Os7K9ybkmWrU0IRwEh5/aiRk9sLBGa6pQh+uRSpro0BweHkO9gvg4YJCNFl7kPCQrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxkFMPC27bBpErC8Ucky9pke3NfCOlbHvOo8uhahTSc=;
 b=pP1sMWkmiFUynAXzqyjMMP2W/ZpkrJtQFVuHRqxCiDxn/9r9zCHUvrUwkvKj8XIPebehmdrBXHQ23P7elVIKr7x1RXAV8+wc0Im0BD7PFdmc/EcDhg3lNKKaNkCHiDgRSYCvj0iGKQSmEqMF+bAYLMWxwgbVDu/p7Yq1K1wKlnY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by AS8PR08MB9314.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 16:39:35 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%7]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 16:39:32 +0000
Message-ID: <d331b7a4-804f-4e99-b278-f3aff02f2a4e@arm.com>
Date: Fri, 18 Sep 2026 17:39:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/panthor: Consolidate the is-huge-page-mapping test
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com
References: <20260917-panthor-fix-partial-unmap-v1-0-c7008f15fea3@collabora.com>
 <20260917-panthor-fix-partial-unmap-v1-3-c7008f15fea3@collabora.com>
Content-Language: en-US
From: Akash Goel <akash.goel@arm.com>
In-Reply-To: <20260917-panthor-fix-partial-unmap-v1-3-c7008f15fea3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0337.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::18) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|AS8PR08MB9314:EE_|DB1PEPF000509FA:EE_|DBBPR08MB10556:EE_
X-MS-Office365-Filtering-Correlation-Id: f88f70cb-c833-4562-bbb2-08df15a38024
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: uqDWYKyhaLfGpax+AlJsOWBtraWX18pHBZY7kJsBn8dfoEVMegKBrxBU1c2iOv2Km5CSpOuzlXBFW4CyvNqG5hT1ziGFC4qlc81LJo+gbx0YeGbSZVqBSOHH7UbuCb9HZJf9cmq7cc4KwBXr9I0n6Xv+V7VOPfUIKJLoZXyJn96lO0KXZRQ3vyHpdqbt+nCc2C/WOq1/7tcnQbyZ/VLA3pUSvCLA087JHl94PfeohRoH+8xDX58muLQu0y7TK/zPzXJKY9sv+T86l7XFck4bC6bpPR9Yp/zSx8VsA22/d4uDv1/+9KLcxCiR/5P11cAP4SDnfzVL48ZOz9NNXNvmgwfPaND32Ho+JgIEeGOv7u+jx1TpmdcB41Ld67PEAdX8dHGw9OgZRGizvxvm98yKo2trcb0l6T2SzCdMb7d6zpywPDzYwEgGDohctNtlxDFR7qbEU+a3Xc9lvOTdAVc8i6fw5bVruaTQQ1ypShCUdf3eyfgw3XZ22Hceo6EYUwn4M8B3MYmZs2Es0VGNzFvf1bW1rnWY8RCAqPR0XxDsygLXbt4srN8Hi/5ibRFdSt2JnlkvNAm6uarUcQXeWkm+TT3XYib/q2Auwcu5773dAvfhed5tCgNi68e5vKmoh10z+2ROsLpt2E7DlkwtCrti5kw/cZAC8ro539Zx/nb2DNQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: wchtBCelLVJC6Wsg5Eav7n3Q8y5HINGFZPledzHtaxMVW42uxfwJq42sH6SFPI+Vs9sOsZz6BySh65YyWxJVIjoWRnZEfPdp/7VZJ0FSc/24ScmdiDDY/m2RbnjmAal8OsQKHdZLXe+exvrirE5OHcyHNTh6YicFIxdH0QsdxbHNWguRmT+0m59bO5txtHeg3NBGMmFHCkBjeT/ZL1Cx4WwyoucNeE6fVCm7emXb3cIyZFnTfYt1cG9VmkWlvoefj/TbvTieUev2eacPA00+Sx0NDMtxoZOZwp1oWwn5rIN45WOJvWeqOkQ+61Qj6/xXWIodVJ4UrhQ1BSWyrQokKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9314
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9401feaa-d4eb-4514-7a9b-08df15a36ad5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|35042699022|23010399003|14060799003|36860700016|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: lbArNSzc7Z+1s0KfwcpfKEbexu2Ip8r3VKqxbndoAdAA8kv+kqR1SMoiEDZTpZ+BUnRIHs1gcPZ9h+dWTGVB3/cHBSbE0e5wGwesxlvvyDL6vWji+2r7RJwnfyQ9jRnkYH6Mfuc0sE/ThIHJWt3ofKpbdfLUyj+vWKxMR8udurv1/RC6rVB1gTUZoNqXACTqXiKhdVQN3WUDCXwU0TUKwd9pGojZkVHZlviSVKODYFchLsWihgmWxC/9uwoGQRFWa4pnDsc3pdherRNNurt3j0P0n5jkx2H4KGhccEFoQnaMZawcT9gluVJ5rmLfK4ceHJGla1DbFHJWkcHqhN1kIQzA6qklOQYy6ylIpmsnUL2aPcekkJuGcdeywEFFkS3f9j7ErIcB10/wlo/R0m2Sz+t6sVejD/7myrVHhMxZliem7qmwHtkylK5TjIixhRmBHR9BF2Gmql7hF2lGE/6iY1kYkJkVMED5E5J5oHOzMg2JczPXw+KPah/whL2kWX+NPw305NM6Uc6AavldOIZbWKSQJSaixpPWcbN3fQF+A6mAOjkVn5iROOfmpBT49nZClwPXjRHeQXe0WDciCJ0LLuZ5Zx3wv5cm8ddIQEV8eI6tp76yKZrlQpiJbG+xxop099u5n+1be3FgXCqxdD0LQnciWqZagK1nUzg3EoLKFuvvXf5VSBh9jKoyPnW8HA0zbUO+9vyQtzYg2VEuuQEnSA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(35042699022)(23010399003)(14060799003)(36860700016)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zq+peKRqSBCd1QnAsXhCF80MpEVdSySK2FbMvwiu1mY6GbuSVsj41ThBjqtRxIkybXejFjz9JDNZ83TXxbQxEPaZRxIlhRgkxxV9noLMbqdFABW8r/gDwCIR1eJV+TGERM+2qVYgZqAue+Ns0yCUfAzAo5OowsP71wan4GeOcxuGaDLuxWMJNd4dWgw12bpE/5T/4taknAKNBJNwB70QTJldn3dMBOc/8NqLggEiSuefqIkarklg/HD+3N7RTXLJGaPn9cS71Oy48YDmQioccufeWbPN5KghT4B1salRpMrSqn3i+g3e/utYWCVx5xaOFueJ7a/rb7k2WykD2NMWODrtQFW4SXEtawMki22m6iRMvGx00QkrROEvOdN/QdeKvjz9TUwcKlaDHvgz1GOwFk+Ho3dIutXt1aAn2jBtLgD65knwT3tZB28splGtbqzR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 16:40:08.2565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88f70cb-c833-4562-bbb2-08df15a38024
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10556
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



On 9/17/26 13:33, Boris Brezillon wrote:
> Right now the logic to determine whether a given VA in the drm_gpuva
> being unmapped is a huge page mapping or not is scattered
> in two functions: unmap_hugepage_align() and
> iova_mapped_as_huge_page(). This makes it harder to reason about the
> logic being implemented for very little gain (some simple checks being
> done twice), so let's consolidate all the checks related to huge page
> mapping testing in iova_mapped_as_huge_page() and leave
> unmap_hugepage_align() as a simple user of this helper that aligns the
> area to unmap based on the return of iova_mapped_as_huge_page().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---

Many thanks for this improvement.

Looks good to me. Makes it easier to follow the logic.

Reviewed-by: Akash Goel <akash.goel@arm.com>

>   drivers/gpu/drm/panthor/panthor_mmu.c | 57 +++++++++++++++++------------------
>   1 file changed, 28 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 6cef954e2cba..d2897099763e 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2301,10 +2301,11 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>   	u64 aligned_va = ALIGN_DOWN(va, SZ_2M);
>   	pgoff_t bo_offset;
>   
> -	/* If the 2M-aligned VA is outside the mapping being tested, we know
> -	 * it's not a huge map.
> +	/* If the 2M section being tested is crossing the mapping boundary
> +	 * we know it's not a huge map.
>   	 */
> -	if (aligned_va < mapping->va.addr)
> +	if (aligned_va < mapping->va.addr ||
> +	    aligned_va + SZ_2M > mapping->va.addr + mapping->va.range)
>   		return false;
>   
>   	bo_offset = aligned_va - mapping->va.addr + mapping->gem.offset;
> @@ -2337,10 +2338,21 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>   		return false;
>   	} else {
>   		const struct page *pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
> +		struct panthor_vma *vma = container_of(mapping, struct panthor_vma, base);
> +		bool is_sparse = vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
>   
> -		/* In case of shmem backing, we know we can only have a huge mapping
> -		 * if the bo_offset is 2M aligned, meaning we can skip the folio size
> -		 * check if it's not the case.
> +		/* If the unmapped VMA stands for a sparse mapping, always
> +		 * assume the backing storage is a THP, since the overhead of
> +		 * unmapping 2MiB worth of 4KiB pages and remapping some of
> +		 * them is offset by the logic of working out whether it's
> +		 * the opposite case right below.
> +		 */
> +		if (is_sparse)
> +			return true;
> +
> +		/* In case of shmem backing, we know we can only have a huge
> +		 * mapping if the bo_offset is 2M aligned, meaning we can skip
> +		 * the folio size check if it's not the case.
>   		 */
>   		if (!IS_ALIGNED(bo_offset, SZ_2M))
>   			return false;
> @@ -2353,36 +2365,23 @@ static void
>   unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
>   		     u64 *unmap_start, u64 *unmap_range)
>   {
> -	struct panthor_vma *unmap_vma = container_of(op->unmap->va, struct panthor_vma, base);
> -	bool is_sparse = unmap_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
> -	u64 aligned_unmap_start, aligned_unmap_end, unmap_end;
> -
> -	unmap_end = *unmap_start + *unmap_range;
> -	aligned_unmap_start = ALIGN_DOWN(*unmap_start, SZ_2M);
> -	aligned_unmap_end = ALIGN(unmap_end, SZ_2M);
> +	u64 unmap_end = *unmap_start + *unmap_range;
>   
>   	/* If we're dealing with a huge page, make sure the unmap region is
> -	 * aligned on the start of the page. If the unmapped VMA stands for
> -	 * a sparse mapping, always assume the backing storage is a THP, since
> -	 * the overhead of unmapping 2MiB worth of 4KiB pages and remapping
> -	 * some of them is offset by the logic of working out whether it's
> -	 * the opposite case right below. This also holds true for op->next.
> +	 * aligned on the start of the page.
>   	 */
> -	if (op->prev && aligned_unmap_start < *unmap_start &&
> -	    op->prev->va.addr <= aligned_unmap_start &&
> -	    (is_sparse || iova_mapped_as_huge_page(op->unmap->va, *unmap_start))) {
> -		*unmap_range += *unmap_start - aligned_unmap_start;
> -		*unmap_start = aligned_unmap_start;
> -	}
> +	if (op->prev && !IS_ALIGNED(*unmap_start, SZ_2M) &&
> +	    iova_mapped_as_huge_page(op->unmap->va, *unmap_start))
> +		*unmap_start = ALIGN_DOWN(*unmap_start, SZ_2M);
>   
>   	/* If we're dealing with a huge page, make sure the unmap region is
>   	 * aligned on the end of the page.
>   	 */
> -	if (op->next && aligned_unmap_end > unmap_end &&
> -	    op->next->va.addr + op->next->va.range >= aligned_unmap_end &&
> -	    (is_sparse || iova_mapped_as_huge_page(op->unmap->va, unmap_end - 1))) {
> -		*unmap_range += aligned_unmap_end - unmap_end;
> -	}
> +	if (op->next && !IS_ALIGNED(unmap_end, SZ_2M) &&
> +	    iova_mapped_as_huge_page(op->unmap->va, unmap_end - 1))
> +		unmap_end = ALIGN(unmap_end, SZ_2M);
> +
> +	*unmap_range = unmap_end - *unmap_start;
>   }
>   
>   static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
> 
