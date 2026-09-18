Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77565C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9159E10F480;
	Fri, 18 Sep 2026 16:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="FzRLV2My";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FzRLV2My";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9605D10E954
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:49:23 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wI7UUqsf7EN4YP8jjeVSzPqxLcpk9P+vemUapVi73SiV2Mo0adLujC1cqAcAEUgLIxddHLWKXxYs2/PoPvu+urY1oMRnJCV+JZu3z+xDNtM8Nh+vHXwMjer66NhIltnb84JwGWQ3iKi+xhw13NFzjJ2jAepjA94H4gi74a2aCMRNIw0jKlRTSz81l7aBapDKnwEtqHPY78ijUUPXZ0YWdGcdudGM4ZG0KetcBENXDCa8UP9UTMOhB+aAj87eCRiIj/rKAxbn2Un8gto7CbRBpgpZZU0pYuQbtgFCIjF0yl2JdFjTJKPIJ9JIqqB8UUMSP66LGKTZgz7YzftrGodb5w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsjMqik8bGGmL4/SXKbODKjsV/mB91Quf3nlfDYT5dA=;
 b=Y0P7wLA3F7kxfGD9sC5uJY/LMO8+QGyAmrDOzPq71Aac9bZ2d7DYlSUbeiyTRSUo916echVsg0ji6uNmwu/AxeSbs9CFmYEddt0ZVLtpRLWyUd4rOtTtoB9MjCifWr51Vn6TUaOhItQrfrNuBRyWjyKxOmNj1EspmWB31JTYnHOYMhrdLf8WBjOzlG8Gw/1yQcv9bFwIh359NQiyGT1SnTe+8a58bISnHi/XwJt075IrZCqjo9zz+Wi6m1gbNhY/PWbEXviSvo+AfhiX7dpJwlYcyLeOYpnSoLjyJt5CyG2OEegI//6A4rzzIIadPXZdCi7/9ezjFZNnEt7WCOOUdA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsjMqik8bGGmL4/SXKbODKjsV/mB91Quf3nlfDYT5dA=;
 b=FzRLV2MyF+rVTWGgzhxPsmk1RdVp3zNPIkU6PkwaCCSN9cDCWhjO5M/NgnSbTzIYyHZXS5FM7OZisR29WCDyF3vmsBB1Hl0DfjC73ebl+mXWU0Z/G37e6KG87R/jTf18caQtTjjsWfjddy+AuEnDH8WZcxmCw1dKqKUgf1bnT6U=
Received: from DU7P194CA0026.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::23)
 by PAVPR08MB9186.eurprd08.prod.outlook.com (2603:10a6:102:30c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 16:49:16 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::78) by DU7P194CA0026.outlook.office365.com
 (2603:10a6:10:553::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 16:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Fri, 18 Sep 2026 16:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HegPTFLcNO5LGBTFkc/DPoNRbOZeo2Fy3lhW+eTDFzW4ZGjV6eo9QsHqEAv9WceqLvGbZc3vlMzncECieF/8v49wl4Djf2Vs4qG4k5h9BMMmUR3MBQchW2qx2XNPLDgo5ny81+VFUmYAGNodYTyRYfAq1zPtI2e6asuq905wzCQtaLVVV31PYhiHrHR7Lji4LVzKTxbumLrxhQ75/BYTxaCAfft9rUT/3UEYDn+TlRcJ0vHtz+9jHtuk4/nmA1qbkNwdme/nE6qU4TQkSywbkql2JPYpAz3OZFEz8AC3zAnx13cxKxx+ih9IxDhq6U0y8D+axlePumPfNiGc5KQiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsjMqik8bGGmL4/SXKbODKjsV/mB91Quf3nlfDYT5dA=;
 b=xepWjMeTXceJ7F32OTLJuN7WLHcNj2JQsMfoOqYE7Nm0ASzrLKNCwiwE58ubax56jENsl9PzT7IbY3fMsbscXAGzJzeTv50058iGv6Z+EsZggdUEkZBJrlvFd7bKbxAyH5zHyGa3QkMDx/DdUWY5Cq5Xih34cIGLqlpDiBRdeCXs6WgQ+pVAWZ1nNtwMq6+t61KlRgmE21YjbZT+Iz5UVV2h2+IBEVQTE7OEl/ppNBivWIYJmUrs5wZaIEDT7wrDQfHKHZBtGTCSooztJgS6TPgO/XpRoFW0TAk5NPbC5aP5FS5X6bLeusNX22Oznr/izZLK2KLlkIHrwkHiGqA+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsjMqik8bGGmL4/SXKbODKjsV/mB91Quf3nlfDYT5dA=;
 b=FzRLV2MyF+rVTWGgzhxPsmk1RdVp3zNPIkU6PkwaCCSN9cDCWhjO5M/NgnSbTzIYyHZXS5FM7OZisR29WCDyF3vmsBB1Hl0DfjC73ebl+mXWU0Z/G37e6KG87R/jTf18caQtTjjsWfjddy+AuEnDH8WZcxmCw1dKqKUgf1bnT6U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by GV2PR08MB8511.eurprd08.prod.outlook.com (2603:10a6:150:b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 16:48:43 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%7]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 16:48:43 +0000
Message-ID: <c7077b55-a96d-442c-b21b-25253817689e@arm.com>
Date: Fri, 18 Sep 2026 17:48:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/panthor: Actually check huge-page mapping on
 sparse regions
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com
References: <20260917-panthor-fix-partial-unmap-v1-0-c7008f15fea3@collabora.com>
 <20260917-panthor-fix-partial-unmap-v1-4-c7008f15fea3@collabora.com>
Content-Language: en-US
From: Akash Goel <akash.goel@arm.com>
In-Reply-To: <20260917-panthor-fix-partial-unmap-v1-4-c7008f15fea3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0650.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::20) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|GV2PR08MB8511:EE_|DB1PEPF000509EE:EE_|PAVPR08MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: b68e2c9c-ac3e-44af-33e8-08df15a4c6ea
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: CuCqRNQ9ywe91G8rzKRfNtkp0Tkvg8Tk1VUA+0l3+7RWks4mF0qmWbSC7bQfo7xqdpMSvQxO7i2wWLea2cgkDURWwt91sAlVlHTKYoaIWj7UTrT9H7+xAGzUjfXlhKv8cDWGkbZaR9VOUsLCp0nGFugbA/Fc20GDj5DelFYCEh252jOvP/L2SGfDxclC/tRc7AoUwWaGIjpny5pk32y1Xm1XIciQYYo7Lazri7lXWXQKY2vLeLg/L0z6qYIz1CgG1Z5Q4RPh4to3okcRsAaF7KdAY6E3G9KBBCDz9C/H9tWoeL8gY+p02sJGd7zgJnmhs4j8YVB+Ta7oUG4nCjQf8T10fT4uK3bJIBNU02BTetnUEnlJuzGQSkxdFQqfLc/9Y7cD8vNpwHNR2/b5LgT/xha9FmQPOdYzzBPrRKz+ss5ckoiAuBWllyil2kFUkfi2J8K+FzucoWRVqioZUZUnRYQ7lg1D9SqKRi5NjcMMMl4Ghmvv5hORyokku9EqXO29uMKf6uYjsxyWXE+KCCuBXizGbrrnqSNigWy8ZIgVUoerySAPGB6u2ggiEtqlW36v+EncRc11sooeeo/Mnj2qfyJ7WHrh0yZDA9eIz0d7zXqE7Lfw0glKhUWGe2YvUFg7nV1WOSrK2Sym95fQMZFYNp12K1YzLEL1Z21zzigRzIw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: nwC1UhChzrt0oJQtn7kjiaRXoNLWoxI70vcKVaDt3uegzj7fR8GEBTBgSjLZFICvsM1EK1dvARWaZHnPLCzP+zBdFNkqvLMe5RPNHEOaoCHieppfdSLzZRAOK+hxr4eY+Gh03hePf+qQaIOzVK+sf3kJprmIbr8lH2BBzSGnXChsQzM6Ylx4Sk56Kc9gaaoMd/yKY/0gtf2mKAR99gD0PVLOV4GstFA+uPRXb7B6DysbaLqExK3qw8b29RRRPez9LTpeLsY66UgXeZQethyMWWNJX8xqxxyJ1X5PFSUViQR/Ec7ookilG7lHyvtBEytRV3QcYmufvxmfdX0SDZBwoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8511
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bbb8ab60-fd7d-4dcc-cea4-08df15a4b31c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|14060799003|1800799024|35042699022|376014|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hOWYYRW8Gf0G818mxBblmBgtdXiEtslFY+iYM042nwXAGKz32U6OIPzneLdkbhPoSobRCdrjiYCRto8Z/Z+HeAcwWJFsf0uoKuAK1Jxu8BhYRmxTf7my5T1pOHoQHwbvz3z2bnGN2PGCAuA8quLH2OZcQmeuzXupBPpBp97bK2/gehZlQFMYgNZhYXaaBSTkceom/jMBieIdIlmP+N1ZwAsMHAndBef0ZJHcJaQUfrWERJ5UI267NHFA2SffSj7I6EBOKXJsYVJ3mGeuFJyA6MT9SbOFYJ+GX0aWf3KB24ZnhjWZn/LG/WsK/J9K67tN3unX1aGY9Cxsq6v9h/7HtAoNdts2Ab967dt+CDIARLnyAI7hzhY4KI20MCMBrH4UtiP2E8u2hEogs30a2xWVjZYwDUoMmEppPIvUgX1ETcjiMn8VYaNZqP2YT3IivfAIU/q1zBvhNGy+NjeZC2DiceQIzbO1iGvPcC++Ki7DBTERwNo1MJS6V44tqkYV238R9ATh5h1R/gwPDydQLOl5h+9UVKqUsaEsMKnHznYceewg4hK1yhRAqVPW07e1FFzwV3fAHmexvvfNjyr0xCedvKU4+HSje/1C5drZOt30VQiyNuKqooC0UAy3EbRiA3u5vIUnsjLmSW1hM8vwaRqTlp5t2/FtaqoO5UecxsN74D2zBkz2TbV7kGd/XkvAOckApOlsfz3DPZrvNoESI3aVLA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(14060799003)(1800799024)(35042699022)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0ybYxz8JBk4UE4W0TaK8xmk3oROlx9xlg1P08h6EBRGcDEVppvomwWe+FkRPzcpm1lESe/C/dZxqOkShoYo77EQfY9ZhP8LwuCiDjlOyo/Ln85N+mKomUFK6suVbXbDLbjR6sqz0J1kUGx/87k17Kt+6Ju+rzITbTOp+5WloExZyLYEpCtzNS2wPjG5AiOCpmJyfgbQwSDBHSGJpC9fei2S2nFGEU8xJj2Vz28b4l4D01lg11ieIKjowGvCuWWA5/ng/H9qlzKMi9sMOkpApdYxvKfRZ0b3dGaQ4gjcWoWS9AjqI4YuGD+mWjZTEI6n24tUW0J8JY6F2jfy5/8IhuBSu5lEAvQI5BzDanKDYOpqo3dhb1OPJazgRLKF31HuYRvIeOCTkP/z9HNIYgrm8EmaIh6hJRfiJXcMup6KDMKcy5jPzWkphusUchL+zin5l
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 16:49:16.4955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b68e2c9c-ac3e-44af-33e8-08df15a4c6ea
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9186
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
> With the recent changes to iova_mapped_as_huge_page(), the check for
> huge-page mapping of sparse BOs is actually simple:
> 
> - for a sparse mapping, we know the BO offset any VA in this regions is
>    va & (SZ_2M - 1)
> - the VA we're searching the BO offset for is the 2M-aligned
>    aligned_va value
> 
> This guarantees that the BO offset to check is always zero in that case.
> 
> This is simple enough to let the code check if page 0 is a huge page
> and save the unmap+map dance when the dummy BO is not backed by a
> a huge page. So let's do that and kill the comment that says it's too
> complicated.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---

Thanks for this change.

Looks good to me.

Reviewed-by: Akash Goel <akash.goel@arm.com>

>   drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d2897099763e..01564d250adf 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2337,18 +2337,18 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>   
>   		return false;
>   	} else {
> -		const struct page *pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>   		struct panthor_vma *vma = container_of(mapping, struct panthor_vma, base);
>   		bool is_sparse = vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
> +		const struct page *pg;
>   
> -		/* If the unmapped VMA stands for a sparse mapping, always
> -		 * assume the backing storage is a THP, since the overhead of
> -		 * unmapping 2MiB worth of 4KiB pages and remapping some of
> -		 * them is offset by the logic of working out whether it's
> -		 * the opposite case right below.
> +		/* BO offset on a sparse mapping is chosen so that 2M-aligned
> +		 * VAs point to the start of the BO. Since aligned_va (the
> +		 * address we check huge-page against) is 2M-aligned, the BO
> +		 * offset is guaranteed to be zero.
> +		 * Check panthor_fix_sparse_map_offset() for more details.
>   		 */
>   		if (is_sparse)
> -			return true;
> +			bo_offset = 0;
>   
>   		/* In case of shmem backing, we know we can only have a huge
>   		 * mapping if the bo_offset is 2M aligned, meaning we can skip
> @@ -2357,6 +2357,7 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>   		if (!IS_ALIGNED(bo_offset, SZ_2M))
>   			return false;
>   
> +		pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>   		return folio_size(page_folio(pg)) >= SZ_2M;
>   	}
>   }
> 
