Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAF2C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5654A10E1ED;
	Fri, 18 Sep 2026 16:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="lRYNilAr";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lRYNilAr";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013012.outbound.protection.outlook.com
 [40.107.162.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396F410E1ED
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:36:20 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vWjE+EX1Ma1fS0QzVkD/I5g9Tov0+bOU27CBBshJNfqR/8VVgLa/BqxjwwJDqPXwB6HOoTxnhNoRBlIfNx3767a3DMRgFcKhgeITcAugXY3Tdvo87Nh92QX8v8FFZDNyJ7zFCIaYISFb2K6r+iPKhjZYyPaWfWrdfdJffxrBizSmB8Y957ARmQ9pcgsNlohSSX64XLjHG1XcG/f1crhkVsGuRSbSzoaXzydFTuZf1a5idtDaRoGdqtJ7o7rgOcxY99KBxpH7g8qaNARYw4NA3BHzKqZkxylKIoxg/AbNcq+fisClMQ6NZ4nYmaDPc5nfkBdYU4F/x2J97DzQ+EfgIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6BBk3MICNM5RwkNsux88bydtNdgcd7sseNNy/Yy5Ec=;
 b=X+24azRn8PjsgFZl0n+OH7CZALDpm7V2GClO7kUPxTlTBrcBCIynCOkymOQ0mA7etvD0da+5tcOipkdKWL9PiBLb0GmEt+3w7lvx2S1MoBz3jozeN+lzMOdIF5qt8lbb6d/FCvVCYbazi/o74NY1AK52qBeS/0Lh1zfWWVyOt6IFpnyi1RYf9IQ8R2Ie9mfSgktaSOkEm0vsSzLgJwzWP0b3o5i33sFHhyNBbpq8rBL20aHX/qnZnXicetT8bGrVbgR5cRZQTFrv0V3Ivk7Upq6a3kmpVLD+lxXQGf/PtGRw/fyocfWZ3re+fLfpkYnC4/rsmk7l17b9Z1H5k0+v0A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6BBk3MICNM5RwkNsux88bydtNdgcd7sseNNy/Yy5Ec=;
 b=lRYNilArgaVdwfUdR+cjGepuqa306jL8/dWW2KGdSMn6msGJ9DJRMwwY7/Sl5Q7hFaOLtfRPUGLjf128WRLf18ILShApYbMnNFXgHb/hYAxL9dDQZ8qxV2hzzagR15hYwpNbYhZanUGaha3FyX01CTzmRA7D724gupoQ/0pxB9Y=
Received: from PR1P264CA0076.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cc::11)
 by DBAPR08MB5846.eurprd08.prod.outlook.com (2603:10a6:10:1b0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 16:36:15 +0000
Received: from MI3PEPF0000847F.eurprd02.prod.outlook.com
 (2603:10a6:102:2cc:cafe::3) by PR1P264CA0076.outlook.office365.com
 (2603:10a6:102:2cc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 16:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000847F.mail.protection.outlook.com (10.167.240.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 16:36:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZCOCSqXUlJPkrshHLuirHqbO9k0YpY2Ohd0+/QAYqUg7jvdC3zi/GdI6DESR1BdP6bGVfAdD+M63weOXqMYsG7CFo+Gq5dUoecqVVFDWJC0aqLY5RHlR0l4kK3kb70Jaqaw0pPKaMpyiBvK82U7sixPHEeiYCnXDOM/m/kmy8uM7u1u9g3iu6Z9tnT4O5oyiJsOK31hpf4szFKNxsOUtJIoE9GmWgcYR9O2y6ilQqzAXi5Fto1eSiEmqkzsBZMfKxw3LnkD/l8xxKa/TCLkIBXrapQUrBZ3fTuhYPfB2oghtQ1wk/AyJqwEIs/EtJT047eR8mZjC7Qp54gAsvhvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6BBk3MICNM5RwkNsux88bydtNdgcd7sseNNy/Yy5Ec=;
 b=RbBIw0pl/UoM8x9IVcFBO/14xL6togMX7oeaamf71wJTKbXhikEK3Fi/NLjhHZQlJHkIU2PeJSpJuio+ZLrJmMK73cjZD22ayFTHyv+Hxrqp5EXKdISt3ZQ9WoPk6aeyJKTaNUtRQvIWEUr6JrBd+aJGcdqGDMOKikoxQWEyz9EFb//1LtdrqGKqan2dWrX45qP1dBD40ZK2HXz2ko/DdgyUuxvqd4RzJqTGKsfpYXmRD9Ve2iHOjo9v4yn9OUqW8Xin5pgXMe559Y1kJGgMonD4XU/tS04eanUPV3tAMlmjSMAyNaTsOixPJ+mwqMRNeCGphqVizVjjTjqhCvLFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6BBk3MICNM5RwkNsux88bydtNdgcd7sseNNy/Yy5Ec=;
 b=lRYNilArgaVdwfUdR+cjGepuqa306jL8/dWW2KGdSMn6msGJ9DJRMwwY7/Sl5Q7hFaOLtfRPUGLjf128WRLf18ILShApYbMnNFXgHb/hYAxL9dDQZ8qxV2hzzagR15hYwpNbYhZanUGaha3FyX01CTzmRA7D724gupoQ/0pxB9Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by AS8PR08MB9314.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 16:35:41 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%7]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 16:35:41 +0000
Message-ID: <a1db5217-5ba0-4ce9-a23f-40ff16d16477@arm.com>
Date: Fri, 18 Sep 2026 17:35:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/panthor: Fix iova_mapped_as_huge_page() for
 imported BOs
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com
References: <20260917-panthor-fix-partial-unmap-v1-0-c7008f15fea3@collabora.com>
 <20260917-panthor-fix-partial-unmap-v1-2-c7008f15fea3@collabora.com>
Content-Language: en-US
From: Akash Goel <akash.goel@arm.com>
In-Reply-To: <20260917-panthor-fix-partial-unmap-v1-2-c7008f15fea3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0516.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::9) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|AS8PR08MB9314:EE_|MI3PEPF0000847F:EE_|DBAPR08MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1bdfe7-5a3a-44fe-d7aa-08df15a2f51f
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 7bKM7tsgRHFlRyZfGGs+pgsTqenrsZhSd1GX/OS06ov/1LQqgPv3mbbbS78TulflHzT9oyUT719H7pkHXjWkQS4n7QzP++MheiWSFmb34KyC001jCZDxYYREOA8OhnhCkeh6tw7mvgOm/4mUl6fD3ZO1hJt3zdafeL9tLynYKo7kJjkO78YkZbufAuaO91jtTkH9gNpjUkjNZIPqHgpA1kDqVmzC3zbbiEmUawmVBOjxIuNMcDGGjCW+RQT/Y3kekJySLkf+w8U3VSPTYFwwR9Eg7RdHS1Nz83dyqlLQXnUHHoUGDT4yf7HtRJJWdhHgG3AY63s8ZoaI0aM4GypcuDLHb3dVCSnGCdFeslgGSwbheWg4Q6F7Qb6fSK0M1yhOVXm5EJcloKfXq8XWP8jY62fTYPkJhVBfAZeQvHisMmOI5lK/4MEPbhMwvIsPycnfeEw5bLsZ4mjywYepJlBVARyfZWX/b7mqmPwqUYYaa//bKpxZ2uAb8XnTDEc/9ovKtSXVu0nEfGalCZliZRSdLfD7G1myMHX4yGV23cTd/UaAYNgk7JF9qXb4NKd/f6xCNOPeNmQzzUtHHDf36gdgq9zrThO6opC2V9cB3HWL6a3L5+sQjiognnuLPDmTQQI1Vttmpq4B5lT/tjlR4E6eslJWS02MRTBO/8A0ueDkJyo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: y55BtTbFklTP4gvda9F1UNH4mFBQAvL/R38OfkAyWVmX1ANRyf8cgwPFJcp0rYU4SU2Ln7eSAVnqP0bh9Bg7oNyHKWdZrbJIstTv8/6nJC6RdlltqVyOmn2JK9ekAddCdVDYzqWrqn4MtOhgH8T7D4eaV5XwAjxDoI4WCbN7CiGV40G7fuQ3PA+m20GEruSOy3ujwv943pAIpjEAZxKeKfom7zUHNLGdNFJcKlZEB+oSJnNii4PnJyk99Gz3iSGkf0RXp9Cf/CaUQ7Ii0NUlhofcmfPTcOwLs36t26qFkYkY0AsjLH5WeM5eMmt484TQCIxxu0IFX4wKxIkyQL989w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9314
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000847F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: dde9e1ca-e807-4ea6-a564-08df15a2e114
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|14060799003|35042699022|36860700016|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: yofpp0vmtllpAMM+oj7/WOGbmoA1JKO/eet2ruaeucIfoMItNJgfvUQOP+CEp4hITJDrtWIffZ5D3Ac3pbH+cLTPrwp00gi84jDeNFhyz/jfcJylrNAG5lV48c7j3SbJBT+MpGgIKty8Bpnn5JDHw5ICtYg1QdRimoJaZLYHYYdBw/Yflaks7/OIBzoC3kKGYPckT3JgI+T9TSNKcl2oScLozcxBgpQlz+XN3Y548OMLF1X75o4crnZiCxsaPl3gdilvvfAcD7dENDqXldLPxrjIghRJY8e60KZoXrJYgHuYJz64gGxO2IwFK2Ie5rxOpVjxCLJ1bShBmBOfGvDZ969HjNGS5or1sQPowJvFYcg1BaAX1lb53W6iubMUwPYqBcxgxr0hYC2VrD95ii0RjHeboLlPCKHKgtzbMkdMT01iHFgoFbI65Bu1Og47D9D8if8hW2j80uxsq0hxg9SFrE31tudOoCfm/xgjKqZuF1xAJZgEh7OKpgKRHm715WaoLMDIogVPF2PhCIyvZgpbezzG5OZWLZYwBoXtfwHMAo81jhCbxdeSY72o+FLfiBGI7EcBCcrx19kbNLvpo40W76uq3u9SgtfyT0ZC45qQrTkNFYcXUIdwRPVZcLtFO3/u++I7fs56DzmBnpM9rLAtGWYTEYpIO7ClnLfe4+pAVEsX6JhxwM3faaFwdXD45zhwSXZf0AVwntMdRQ+evXRlLA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(14060799003)(35042699022)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9R2dGmZBcGqcKaRGSsQitHCjl6NE9DD3e2hNPNuRJfQfBCwm2U595TG0bxL6VW2EApxICZo8qJ9zswqSaNkx+/kZYcOexEe+XBrtUwvoF5Fq8vA58HQKV1gSbMP1tPfkaudjh5czXmf+S4abvagL8w8koSPyJQCWs4vaCggp0IlJ5v5dHdhAQtuZsH1CBj6zV33oF8WjLe/mPQv/tI484uPUisbBT5K81EmMZedQynnNnCY1SmDblNtAmqg+PsRe3kvofqfAPP4RyCbxNupS980bm3JXkWYNNE5JdAEv6QBCzKppq+wJa+qmVSPPRz/+TKyROz9bY6anbpFHFi2g/lL3eIjiLrWX6QTLCT7C3lg2s38ouUR1ozNkziV/18aZmV1hR5RTK5w/V8XGdMspqVuGvFSwrr30rUtMIS4BDsTekSgS1RDJ9aBzcaxNE+rx
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 16:36:14.9638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1bdfe7-5a3a-44fe-d7aa-08df15a2f51f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000847F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5846
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
> Imported BOs have no backing.pages array allocated, leading to a NULL
> deref when iova_mapped_as_huge_page() gets called on them.
> 
> Implement this check through and sgt walk to reach the position of the
> sgt targeted by a VA, and check that the DMA address is properly aligned
> and the size remaining in the SG entry is bigger than a huge page.
> This is basically matching the logic in vm_map_pages(), with get_pgsize()
> being replaced by a simpler test, because we don't care about the pgcount
> info.
> 
> Reported-by: Akash Goel <akash.goel@arm.com>
> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---


Many thanks for fixing the issue

Reviewed-by: Akash Goel <akash.goel@arm.com>

>   drivers/gpu/drm/panthor/panthor_mmu.c | 44 ++++++++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index b0a7033480e6..6cef954e2cba 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2299,7 +2299,6 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>   {
>   	struct panthor_gem_object *bo = to_panthor_bo(mapping->gem.obj);
>   	u64 aligned_va = ALIGN_DOWN(va, SZ_2M);
> -	const struct page *pg;
>   	pgoff_t bo_offset;
>   
>   	/* If the 2M-aligned VA is outside the mapping being tested, we know
> @@ -2309,16 +2308,45 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>   		return false;
>   
>   	bo_offset = aligned_va - mapping->va.addr + mapping->gem.offset;
> -	pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>   
> -	/* In case of shmem backing, we know we can only have a huge mapping
> -	 * if the bo_offset is 2M aligned, meaning we can skip the folio size
> -	 * check if it's not the case.
> -	 */
> -	if (!IS_ALIGNED(bo_offset, SZ_2M))
> +	if (drm_gem_is_imported(&bo->base)) {
> +		struct sg_table *sgt = bo->dmap.sgt;
> +		struct scatterlist *sgl;
> +		unsigned int count;
> +
> +		/* If this is an imported BO, we have to walk the SGT and
> +		 * check the dma address/size alignment to determine if it's
> +		 * a huge map or not.
> +		 */
> +		for_each_sgtable_dma_sg(sgt, sgl, count) {
> +			size_t len = sg_dma_len(sgl);
> +			dma_addr_t daddr;
> +
> +			if (len <= bo_offset) {
> +				bo_offset -= len;
> +				continue;
> +			}
> +
> +			len -= bo_offset;
> +			daddr = sg_dma_address(sgl) + bo_offset;
> +
> +			return IS_ALIGNED(daddr, SZ_2M) &&
> +			       len >= SZ_2M;
> +		}
> +
>   		return false;
> +	} else {
> +		const struct page *pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>   
> -	return folio_size(page_folio(pg)) >= SZ_2M;
> +		/* In case of shmem backing, we know we can only have a huge mapping
> +		 * if the bo_offset is 2M aligned, meaning we can skip the folio size
> +		 * check if it's not the case.
> +		 */
> +		if (!IS_ALIGNED(bo_offset, SZ_2M))
> +			return false;
> +
> +		return folio_size(page_folio(pg)) >= SZ_2M;
> +	}
>   }
>   
>   static void
> 
