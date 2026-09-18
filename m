Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF38C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381DA10E94E;
	Fri, 18 Sep 2026 16:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="U4mxiv85";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U4mxiv85";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011022.outbound.protection.outlook.com
 [40.107.130.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C1810E949
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:34:59 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NKpz/Ri6FShWJ9kAZ/7/nlaw68SbVVzloHPwoPi9qHgI5x6TKZhtkKq/9POpqtSOVeBCSlQ1ztCc+SzqXHAf/q0Nr4sFZG4TrwDUQ0IxANkgrDo8oFrLheexxcG7r6glSwfFBxqRMQLOwwUsK354Xj3b3A1UzYIFaVufHVXeUCq2Xc1SXIMabqDvO6Msq1ULuUar2yn55KwGEOA5hGvPcHF2IPiXF/tyKMR5UW/zutDOPR65hacgZnmHOn68C/4BrLGcDMa4wv9I9HF9fPdIAtVDBdccgJ4GVOsrk0afxzcylu7aDudLEJ+zBWJ0oLq109MIa44h3chWd798523c+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njy1ljBTIBS45uHS3bFwRA7yT00UJnon+00CHocTlBM=;
 b=XExuNfbnnBjAtd0Yi6OB92yz0foUv7i99c3o6sQHQnMrvs6OQllES11zAHYheRh265C/1XUwC29CrGZcTbonrIfq9mbbjbyBKfxmDu6OO4acWzWM16fsod5aOIeaye6FC/hRZxi5Kl/ye5qc/ULm6l3Ta77TF8Zd+EVZpmxlJpfqY8iqY32GQBwH8Nc/oKn0Qnsnw5xAEVPZUe0gFUS0GqeCc4cvoTXA5OwRh0cTWmaunVXLZK+mG17V6qN6rq0HsD9nzbTQHo/GA0tsQFrZRuXps/rdVO0jYSroPhAcaoCDY7ydZ/tCg0q6Ad0WriLDQTv9/S5FlftF+S5FyERjvw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njy1ljBTIBS45uHS3bFwRA7yT00UJnon+00CHocTlBM=;
 b=U4mxiv856GHIocOkqbmppKSX4GQ/vMTQmQlk68O6AHOnUDkUceROYRRwqfJkXPg1oIHTuM1b6TpoFfBiXkkrB3y47HFGEupxbv2/NFmZPUTmktkHcqRs4DxYA30/0gSPT8REvfHZ9mzxBhaPfDK0IX3ScCL88XIPkAlWV/LG7/U=
Received: from PA7P264CA0307.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::9)
 by PAWPR08MB11201.eurprd08.prod.outlook.com (2603:10a6:102:46c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 16:34:54 +0000
Received: from ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
 (2603:10a6:102:395:cafe::6a) by PA7P264CA0307.outlook.office365.com
 (2603:10a6:102:395::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 16:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 16:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4XZ/Mc8mCvJEHEJXn9AuFcZlbhOuvIMw4sWcX72bxJzQT7Je26bcJPxVRUVUDFQzx8P47ofM6WyWwl5JMY2WLZjRwjjzwoqwXRG2uuHARUshd1HvffKzqSR1FUHzA62ioinlK+BBOJPvvVIcA1x090DGXhBF1Pm7WUFqaGmtpJJGt7EWnC2DRyz5nGKFXXRNtcEim9MSGC3Nl0SJyiUx5LfxpQYDEIiLoxSzkb+5NtKr9C36SYkDp3UwXIbx5mlLPvNJFXC5Y3iavB+Bp6X6MvNSP+okZVMkqjjIte5tu5VXTwzjiTjyDDBxjiGqYImhub30zuHbUDDOC1RcjR+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njy1ljBTIBS45uHS3bFwRA7yT00UJnon+00CHocTlBM=;
 b=Gc+CiEW2RGu75NLE3qCe9cSkZXJN1yETzGSsJByWsdm+m/W4EXCMFnSnlrudXHDfp+/lwz7qlsuobQq5ggzDgS6bvxkFn4cKweGqQD0PGtFg8YwjZ74Umy095uIaHv8TX6FSAYCY7fiARAkaPDsaRQ4AWUotCc+mvzPJgHVCcszw2SmmIjMhlrxVAsh0Zcy1ZiP03J+BxZ718N6ioCfPfAIvzgT5DEofcx0KUE0a9x1ZbkuY8hA/XmsXSXXuQW/atwfYPma4M/UdjlTp+Bik6hEQxry0Blq4VnhP2uVrFMu55AYEw8GW29UJxCYkY4tQpqvLct/PN2MbHqqB2h13TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njy1ljBTIBS45uHS3bFwRA7yT00UJnon+00CHocTlBM=;
 b=U4mxiv856GHIocOkqbmppKSX4GQ/vMTQmQlk68O6AHOnUDkUceROYRRwqfJkXPg1oIHTuM1b6TpoFfBiXkkrB3y47HFGEupxbv2/NFmZPUTmktkHcqRs4DxYA30/0gSPT8REvfHZ9mzxBhaPfDK0IX3ScCL88XIPkAlWV/LG7/U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by AS8PR08MB8924.eurprd08.prod.outlook.com (2603:10a6:20b:5b2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 16:34:20 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%7]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 16:34:19 +0000
Message-ID: <faa4e20e-da0b-4848-b560-9553dce6ab63@arm.com>
Date: Fri, 18 Sep 2026 17:34:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/panthor: Avoid false positives in
 iova_mapped_as_huge_page()
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com
References: <20260917-panthor-fix-partial-unmap-v1-0-c7008f15fea3@collabora.com>
 <20260917-panthor-fix-partial-unmap-v1-1-c7008f15fea3@collabora.com>
Content-Language: en-US
From: Akash Goel <akash.goel@arm.com>
In-Reply-To: <20260917-panthor-fix-partial-unmap-v1-1-c7008f15fea3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0499.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::6) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|AS8PR08MB8924:EE_|ZR1PEPF0000E6B6:EE_|PAWPR08MB11201:EE_
X-MS-Office365-Filtering-Correlation-Id: a8eaebf9-5981-494f-afc8-08df15a2c4f8
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: b/9Gq3DFRCv+PfEWHdMNF5Fd+DNu6adB08OlQDsgOxhvtXOQ8cEogceQMBDPXh9dkKsEcarWkG+JxbfxANwU2oznRNR3mPmp1aiSGfA+DT0iIvE1jsaCQzhoDjvNBmwDX1rf1RAxNB42xjjIi9SbqvliVeFAGaYY88ueNZb/A2kGYZSU20cQcGdbYWG4RZ+E2tt3Cx1Tu0b+dsjX/LE/xaGwXe96Y63CqNdoRWLeztbXip8LbQCXGnk7rrZGIWZBKFxX1/qY4t7o15r7+pGQ5zSm3hh2UAPIbKnvlciu21KOu+rbbvsuC0pkOnvQfn8AZDuene9inSwXHz881abXFvzXVrnhdCiNNP98QP1TLPMGRhrsxgTNOJHMzTDXUfKdU4z0vzf1v+Jz0EZsWDVbdrmu6nShbNJuif/EQLqriu+c/DaGdRg8pzQz7MrjeaxKUQJ4c3hfMMVNwgGipC0D93tXcmugR9TAgt5N+5j9TTUqp8ThO9BScjLjp7Cpu56rv0DJ1N41bdWIuIKxnK0tYGb8GtNv8hMMVMNn2NMF5WzWUl5Y9biuJ5isWCKzjQZ7gaWGJPriUBiEuh4UkTaCyKRJSmhQPQvlwa2BScHl6x0+bSCyyGMJfBEEbvD08G6e0SL1qJOTVY2phs9JM9VW/sesgkv7LYExkKrq1orHNE4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 2ymTML95A3VFo9G9XEc747lGUX9B+81lawVJG/UNo1vUu7YL9DpCSKcQ7e1XN/53+3Q1HMozcotVoEN7djrdIxjLZ/sYK6PhkczYyPH3y4Adv0mQegP7kd5mXo0K1MkEBC6LIiVN3TFD8MGM/slj/y2U4GXyeak2jcHJg/fEcKDluHvk7mPcOdMNHzt2GN0zTYY8v0F35X5c7VuBRXxbeRLlfhIM+1k7Bz9m3XynPIzf7CwgqA1BtfEXeVrJVwEgC6Hk2wD5Lk/IwK5aaNwvzIsleoWc5UTUps8K7Uheplpvsx6GeSNShhT9z89E6K/qKHAFYLPKcZiWplIXanixug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8924
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ea54457f-649e-4990-ff4e-08df15a2b014
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|14060799003|35042699022|1800799024|36860700016|23010399003|22082099003|11063799006|56012099006|4143699003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: ozSpx1vBCzXNIxLlph/g+opHm9nr2pqasDyRMsmjb93nzGaiiOQ2rkTHD59TumT6TRUHGwzLp4UbOSmmnTt+se5cPafLJFN84SKSyCsAHtIf9GOZbEtbCmiNf0766/Z1Q9dUvkEwRed7cHxcXpjJbOmnaS3X/B5HeGOup5fs3ShUh28OYLEePyRcjWXRb+n1JUFPrWxCt24D0Tzix234/xzvpMXph04Z9NUXMFRcLLrDwo+SLDaocKsnHUFkNhzDKfB3olYaZ7YgtM/aNC8VGEgFsypoQKqpooiKoOAmV/0KgfZuaKWWz1ye0oBJk7jw7i0okkyALv6Zv34hnJiO8Avj/G9Ca7IVem3T81KL+BJNymGDirz2XgNzbiy8opnyKIA6bm/tsAmxCCaO3D6xvLLEwnhXAhkKr3VdvXuUFWI4gA9/lREdFo5Q+NrZAZuPr0j5HjhAgJSDEo6PZ+1k90ZELahl3Qn/NH+KTHhbwg8qRdjhZDswNN2QHj6F502kQtqpSaKjdjVkuFwOikoJaxZeFVVW6N6ZNO2JziljQgRQMKp27bzDuMfea/bdcRrqPg15OEJJZ2QTwZMb6k+eSLwkCBZKNYJbLiBQnBMnDZI/n/LqBbkOhEy1bCUCSsB73HgHH4hcN2ZnEwdWg0VmiyVPKNPqznIlhojkpzAukB3q5fSTfNuzJRIYwwDtrQNFKfeNju3JYlsd/rXDwEXtgA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(14060799003)(35042699022)(1800799024)(36860700016)(23010399003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GJDPvhEJ+gNBqTVY8aAf5hhMj3eMYPIpsZo9/YK7CNlPVmy1G2hLxZo17NFq70vz8paiIPRznRcZJBQAFe3IR3JJU9txYs+ZqC0QUWCrZ5SfGHsQtOEAHam69UdiZ0o0VGiORvqevWmW8HQ8mivYVXNyhXFk9SIvWSe57augf1MYKEPetbpQFCCa5YMllT6fFFceU7L1k0VPHk4wBLobhvGGyc1j3JQQ0G5OAKwLpIOOHxKWZd84AQc9+yw82zRbbmZx3S+NCIIM9eWe+sLoxo00ZLUZ32cLKpmSXsMlDCqO6ipNFUW2v06ExcLFqqXZjqphaf0XrEQbdXy/kJrj3ExB4dfVWHsnaEHo5yDxeY3Q4BRJf9GL91qAy//tSQsIPf6Z9R7282qWDG1AwgC+ODF8hSLpdtSc4H5B5eX3OP5jTaNHaLMRBK87CVxQTEmb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 16:34:54.1860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8eaebf9-5981-494f-afc8-08df15a2c4f8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11201
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
> The check on the folio size is actually moot if the BO offset matching
> the VA we're checking huge-mapping for is not 2M aligned as well.
> This means that we are sometimes returning true when we shouldn't, which
> forces an extra unmap+map to deal with block-mapping splits. It's not
> a functional bug per-se, because the unmap+map sequence will restore
> things in the state we expect them to be, but it's better to properly
> optimize those cases.
> 
> Note that we now align the VA on 2M address below it otherwise we can't
> check the bo_offset alignment (both physical and virtual address need
> to be aligned, in addition to the physically contiguous size being 2M,
> which the folio size check ensures).
> 
> These changes force us to pass the drm_gpuva that's being unmapped
> instead of the new mappings that will be created to cover the left/right
> sections we remap. This changes makes the logic a lot easier to reason
> about, because it doesn't make sense to how things were mapped by
> passing the new mappings that are not yet in place.
> 
> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---

Thanks for this patch.

Looks good to me.

Nice idea to take advantage of the fact that shmem would attempt to 
allocate a 2M folio only at 2M aligned offsets into the BO.

Reviewed-by: Akash Goel <akash.goel@arm.com>

>   drivers/gpu/drm/panthor/panthor_mmu.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 9f63a048df61..b0a7033480e6 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2295,15 +2295,29 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
>   }
>   
>   static bool
> -iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr)
> +iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>   {
> -	struct panthor_gem_object *bo = to_panthor_bo(op->gem.obj);
> +	struct panthor_gem_object *bo = to_panthor_bo(mapping->gem.obj);
> +	u64 aligned_va = ALIGN_DOWN(va, SZ_2M);
>   	const struct page *pg;
>   	pgoff_t bo_offset;
>   
> -	bo_offset = addr - op->va.addr + op->gem.offset;
> +	/* If the 2M-aligned VA is outside the mapping being tested, we know
> +	 * it's not a huge map.
> +	 */
> +	if (aligned_va < mapping->va.addr)
> +		return false;
> +
> +	bo_offset = aligned_va - mapping->va.addr + mapping->gem.offset;
>   	pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>   
> +	/* In case of shmem backing, we know we can only have a huge mapping
> +	 * if the bo_offset is 2M aligned, meaning we can skip the folio size
> +	 * check if it's not the case.
> +	 */
> +	if (!IS_ALIGNED(bo_offset, SZ_2M))
> +		return false;
> +
>   	return folio_size(page_folio(pg)) >= SZ_2M;
>   }
>   
> @@ -2328,7 +2342,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
>   	 */
>   	if (op->prev && aligned_unmap_start < *unmap_start &&
>   	    op->prev->va.addr <= aligned_unmap_start &&
> -	    (is_sparse || iova_mapped_as_huge_page(op->prev, *unmap_start))) {
> +	    (is_sparse || iova_mapped_as_huge_page(op->unmap->va, *unmap_start))) {
>   		*unmap_range += *unmap_start - aligned_unmap_start;
>   		*unmap_start = aligned_unmap_start;
>   	}
> @@ -2338,7 +2352,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
>   	 */
>   	if (op->next && aligned_unmap_end > unmap_end &&
>   	    op->next->va.addr + op->next->va.range >= aligned_unmap_end &&
> -	    (is_sparse || iova_mapped_as_huge_page(op->next, unmap_end - 1))) {
> +	    (is_sparse || iova_mapped_as_huge_page(op->unmap->va, unmap_end - 1))) {
>   		*unmap_range += aligned_unmap_end - unmap_end;
>   	}
>   }
> 
