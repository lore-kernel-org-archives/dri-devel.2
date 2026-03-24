Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882D2F54AB0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CCE10E6CD;
	Tue, 24 Mar 2026 13:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ePqesLZJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ePqesLZJ";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2D610E6CD
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:27:43 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kOTzthOGLt9K99We6PnyVaJRTXkuHMPXZTC3iDpAOQitC4cxoIjybq5xVT1OwvcOdyp3fKx8lppuwKm2GSDiMeSaOttj0xipeGpQjXJxgyIRq2xOAtFQwWAOCyk+9HkRVv35qQ/Hj8h0KY6ca2JukAo94aAYkS9plWsZXHfEh2P0Ka2lC2hkXtk4YAwFz1ndYtCu86t0y3KMSN3pEqTfGeWuvELrcR8wRbNsdFv1Wo84WimlrGJMuXtqJuro6OipN3u942vsSsKNJuNSrAvybw6a8wkc6cqB+9aXXHbDCtrs96HLl0RZniKg/B5a7oHOFfNbOJBNoAdvBM6oV1vAZg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/wZDxNzC9QFb63s+e5IXGTSyb38B0O+BCQZOJMxpz0=;
 b=MccIanLV2Cegi+U4FGS57kw8X/jqKnDDZY+kXKd33LZ/8JTKPF0eBPzTTCOIvOSfp9pi7+KcclQ4PHKZKYEsweYqdCOCQbgtUh+dnGZkRjFd7qZ3bto+DQu2L2qxxidT51hyH4YI1PZBquB9CRL4cFN+1Rss/OF9Esq485V5ZD+MuhV+GuAjNNLxG8iz9A8HqDzVIO1qIhfWwtRH+ixLZDegQL/NM4ggOpI4GSsPXHvVBzuVp9VatvOpgbZI7RxRTewjmWppiIUu7fxId10vUBBzSDmW1YR7EsFX4lSaDhLOXI2ox3JWuDgw6ellz6aNg4wCRXXq8PLvknjMR5EJWQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/wZDxNzC9QFb63s+e5IXGTSyb38B0O+BCQZOJMxpz0=;
 b=ePqesLZJTwtSOxCpCS/dKQ3VEHd7qNYb3CiVpSTLiMUa7fav3GE7Sy1BdJRzOThCwzZRuyz4QqaraxoVpjVSQw99P4mUqe0RfJMq4JMnFobWIPoPamTVf7fBys4hHVHTQpjE4c7Ktk5gZXdmCGArgoz6Na4cjiiKgoZHUZ+P6zE=
Received: from DU2PR04CA0220.eurprd04.prod.outlook.com (2603:10a6:10:2b1::15)
 by PA4PR08MB6126.eurprd08.prod.outlook.com (2603:10a6:102:ea::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 13:27:38 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::ab) by DU2PR04CA0220.outlook.office365.com
 (2603:10a6:10:2b1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 13:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Tue, 24 Mar 2026 13:27:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfD3+a4iAlepUzA6hljkP4F6lSxPFhNZ4+JACrOsFZTEnt3m3K5Y9BTq8kYBx0AklttEXpQwJMOc+wEIuHF1SChHJFhAa78otTZ3dY2iO2/ZjVIb/8p4pH+O5eGLwdTUyGQObbTws98r+0bwhqV0HBfJXhP91MjVOaympdOVAsFk4kU6xc4APXdGVPu/mT9xqlRBzSj96Ukp6xHrM2Ey+yrq+8D3ZQgzQCGlMODhXkdkVfgPDOI9D6OlOp7VFjfErV13iuX86GIntsPrNMRKJ3eNmQko9RDLAExQW8Tm/vuMkSzfraTcNUwS4cP0NhrZErq9MRctzTAeeS7vSXNgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/wZDxNzC9QFb63s+e5IXGTSyb38B0O+BCQZOJMxpz0=;
 b=tt/3V1w0Fof5Ju4VeOJsKu3/nzyY01QxLcDr8AUUtxpEMuwR3lcLidxB+iTZ6dfvHuqRXgw0oQRhAYCoZMyQf+CPbZbPJ7gCdp7BgYc+kh9vmvcKf5Bcl0l+nIZFKtUVAX9+jwg6aSX+R6omjgR/Ml9mF/OCI6j4iTpH4VZ3r3IW0GiX+NnhneRsH1bcb6TdgzGxZI8FFEmcdwJXMhshlM7Y0RNWqdcKgajfzcb9RwACb2xl9c47wKAl97sStFRRWkS7xeez7xWX7PGj9MHprQo3ZjhXcCSZskKKOTr7qw/JTeZ6sSaJwMAmhh8HokNNMd3G7KZpIGt4KljWGr0Ycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/wZDxNzC9QFb63s+e5IXGTSyb38B0O+BCQZOJMxpz0=;
 b=ePqesLZJTwtSOxCpCS/dKQ3VEHd7qNYb3CiVpSTLiMUa7fav3GE7Sy1BdJRzOThCwzZRuyz4QqaraxoVpjVSQw99P4mUqe0RfJMq4JMnFobWIPoPamTVf7fBys4hHVHTQpjE4c7Ktk5gZXdmCGArgoz6Na4cjiiKgoZHUZ+P6zE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by DBBPR08MB10553.eurprd08.prod.outlook.com (2603:10a6:10:52e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 13:26:35 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 13:26:35 +0000
Date: Tue, 24 Mar 2026 14:26:32 +0100
From: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>, nd@arm.com
Subject: Re: [PATCH v3] drm/panthor: extend timestamp query with flags
Message-ID: <acKRCOgmEOKnbs8q@e129842.arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
 <20260319110053.909152-1-marcin.slusarz@arm.com>
 <abvhcedS46eLEYVB@e142607> <abvujKZxtg0zvFaz@e129842.arm.com>
 <abwTkBi5WvItsEX-@e142607> <abwXXFgPheyA03P8@e129842.arm.com>
 <acE9LkMYQvrGKb8b@e142607> <acFmUc-qx0eO8A1F@e129842.arm.com>
 <acJqdFEo4l4oi--V@e142607>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acJqdFEo4l4oi--V@e142607>
X-ClientProxiedBy: LO6P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::20) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|DBBPR08MB10553:EE_|DU2PEPF00028CFF:EE_|PA4PR08MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: dc52bf4d-7de0-4e24-c104-08de89a91df4
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: DoC62BJwuzzCXJDHzFTMdKFtqMkRrmHQHlqEoFdKWPJRx+ODPGL+KDQVuomexS3p09fwqS6OE0GnjLafm7SJPQ6LeyPnjAFc+aIIX4bk4axBBMho9yrAqlf95c7E54zbAjo4av772ds5SVMlg53RsEnBvdOYVHfgrwTFnlUA9HNybse2XZ/hhH+059kS3By4tBlMrqOOKt18dcq4fsQ3qq4mdZ+CVP8QMa71vzc+z9M+Pw92AM6c8WZs6KNzyejAcyfOzvqTSV30cXBnTRSoUv/Q56+AyDK1aUoYBjYj9Ojez/DGThoLUiJtIXIMjDNVAW7NC8xpDNnq7RrtmECjylxj4PJqWjgbwR9I73KFlurfI/qZg6zA8AEjj6bxJopziwmNCeXANGjOeKOfyUBWa56avLpWBbnt14NrlWq/oNgpVwezyzyTMptoc0S0WCmjyio3HkzChzHJw8PpLyB3QN7dgtqHuPbBsLWXEn7WI71vVo++cuO5IWWro0YFVyeXoDdr8Gw/YoOUQFFD623hwJ4rqbwDyNiBjGC4cs77k19myqCiMi69NWJJLZb9eNY1FTnjNgwX/+L1+m6RW57eyl76khX51jEarlr1OoG73OXLWco/AQwh+ZYiZ26Q/AFRIDvzBLCTcPTJvxfvrhcEWMSVFSqEK65DkuH198AfmuX3qUAEm7LG8MVGfYGrYUDa6LG5JLs3mK0uXfw9mof7WyZfUw1SJV8emY5vnuTwvcU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: GDhZ8eJw9+HlFhDrWGymJoHem/rTUobxJG12vEAe1L3eRkMxzwRwXnoD/GGWNQfFMsoeWLSlFD3lxecHKGhBOVoEkEtY29jKkiNlQzijCPwbVKx0zrouOxB9I6lv3B4ON4zy6KcC/9hX2fQDukMGc4bSiqM4Ld1Zp67MWZJVEVY8965xiVKu7tb057LtpggNqHMZuCT65BoaxB8pq9VVhM2jloRJoO0JjmunlgSpgJeJLKKBDixKcWAAq5XZt1z+vN0G4L6GitXerQPWgjAGlV/lYZnPUBq3p0VlHDhO+toqogv+4BVLv8T3vF32QdylB1jg+7M81oRyuBksToOdyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10553
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 67a2ae59-d0dd-4fd6-2ffb-08de89a8f8d6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|14060799003|35042699022|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZHIEoZsW+vi5Nj2UDlbm0AzCjQjrQZgNqXY/jiIlm/PN5jOS2KPDlx5q82HoKBR1Rks4yJZ2gk3vEHxMnJBmNMG/EHKWBr0RsCbDzoM5Hbmf7f4o8rvLUUp1QKvMhhLAVH3iBuPSQpJ17yZ9DSStihMtzutCvjdAUG7Bv08uv8awVcLzWFH6wfNkzKmAwhUF65l89Bj93zpHi+IqlNp2TyiFlN6u1q8sZ25XKiGloPMiqg+ZaOaAfogxNddXARwBs60LtCp5/b9Nk5JD4yYlfP5iRBk5tLzTxD6t6DU5C4HX2BGrCNRr/3q0mv7OfFPbNl6I0DN7omSLjyhOBT1ZhMDN2CYencIBZYTBM4wVf8XlKZon+cEdc1jrb3jGAHk6rExcfZBXGPXMSXcnp2NYkA1NjgU4S+lvK483L65JXPi5jBM6u6esXBVL9wkIpwnUUOcqYHpX6DdKXhs4RKYzuzqZmJ+48bwnFDkGWGsRgi2RW4H/9JKPcMmYcD+Va60duDuvC0Ggt4osmSFybwOvqTKv9s9TU6SrgFcrYUo8YSMVKfacfW6rnaZaS30ricP1PYyNfJeRVdPsl+AWkfqbPjX1Xlo8QFl3BPaMLsFglrzb//5G0p5KpuTuMHb45CpNX1yojeRHFhzvJWWoTR5zwhBDlxs6fqaxkoTqxtk6huvysF1l3F7kGR70JtzbYAJZ2UbhPxg+0L6FDCTw1VRX4RbQz5TUVC5mGJIF0iQgGvlq2HAZ60UaPK54dath2AXbx7q4OgVTfsKUGY2bUBeFCA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(14060799003)(35042699022)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5+B4wMMWH/98Upwk96Kn3ZoHLiQR6BX30lyRYToOtGcv1WSt8H6/hDoPx5PIDrJTRdtCjWX5WSUMeuG161YTSFDTzmllcmox4lqLTdBPeunT0ZD5mJ+0nu5m0Cz/uaKEkjquPOZ0W3aoSbHVuFJKR4aAWTVg/SkHggPQlvxIqXzwAp7kEvtXO4EnXqQ3vWsfqISyPBBUnlbNCZNE9bXoBSekahV2EG0FRprousA3f4z/mKDNCde5Qre1rKcf6XYvifjvH2EeAuNTBeSpGl6SC3et+a7I9qkjc/1prA883F/Mfoq3c01SAfPhg2aZ1Bszy13MQ3GPOwL+exYT7o91l2vlQB9TZEMGmYKMaUqcpCWHpP9N8D0EsXXRgySG5qQMjuxlWC5sDXkF/aNNnRmeUoEiP7vQROsMB62W0jSxbvI3EkaljvicdGOhbyI+zqfU
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 13:27:37.7124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc52bf4d-7de0-4e24-c104-08de89a91df4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6126
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

On Tue, Mar 24, 2026 at 10:41:56AM +0000, Liviu Dudau wrote:
> On Mon, Mar 23, 2026 at 05:12:01PM +0100, Marcin Ślusarz wrote:
> > On Mon, Mar 23, 2026 at 01:16:30PM +0000, Liviu Dudau wrote:
> > > On Thu, Mar 19, 2026 at 04:33:48PM +0100, Marcin Ślusarz wrote:
> > > > On Thu, Mar 19, 2026 at 03:17:36PM +0000, Liviu Dudau wrote:
> > > > > On Thu, Mar 19, 2026 at 01:39:40PM +0100, Marcin Ślusarz wrote:
> > > > > > On Thu, Mar 19, 2026 at 11:43:45AM +0000, Liviu Dudau wrote:
> > > > > > > Hi Marcin,
> > > > > > > 
> > > > > > > On Thu, Mar 19, 2026 at 12:00:53PM +0100, Marcin Slusarz wrote:
> > > > > > > > ...
> > > > > > > > +#define VALID_TIMESTAMP_QUERY_FLAGS \
> > > > > > > > +		(DRM_PANTHOR_TIMESTAMP_GPU | \
> > > > > > > > +		 DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK | \
> > > > > > > > +		 DRM_PANTHOR_TIMESTAMP_GPU_OFFSET | \
> > > > > > > > +		 DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT | \
> > > > > > > > +		 DRM_PANTHOR_TIMESTAMP_FREQ | \
> > > > > > > > +		 DRM_PANTHOR_TIMESTAMP_DURATION)
> > > > > > > > +
> > > > > > > >  static int panthor_query_timestamp_info(struct panthor_device *ptdev,
> > > > > > > >  					struct drm_panthor_timestamp_info *arg)
> > > > > > > >  {
> > > > > > > >  	int ret;
> > > > > > > > +	u32 flags;
> > > > > > > > +	unsigned long irq_flags;
> > > > > > > > +	struct timespec64 cpu_ts;
> > > > > > > > +	u64 query_start_time;
> > > > > > > > +	bool minimize_interruption;
> > > > > > > > +	u32 timestamp_types = 0;
> > > > > > > > +
> > > > > > > > +	if (arg->flags != 0) {
> > > > > > > > +		flags = arg->flags;
> > > > > > > > +	} else {
> > > > > > > > +		/*
> > > > > > > > +		 * If flags are 0, then ask for the same things that we asked
> > > > > > > > +		 * for before flags were added.
> > > > > > > > +		 */
> > > > > > > > +		flags = DRM_PANTHOR_TIMESTAMP_GPU |
> > > > > > > > +			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > > > > > > > +			DRM_PANTHOR_TIMESTAMP_FREQ;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> > > > > > > > +	case 0:
> > > > > > 
> > > > > > Umm, this should be DRM_PANTHOR_TIMESTAMP_CPU_NONE.
> > > 
> > > OK, are you going to re-spin?
> > 
> > Yes, as soon as we get to some conclusion.
> > 
> > > > > > 
> > > > > > > > +		break;
> > > > > > > > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > > > > > > > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > > > > > > > +		timestamp_types++;
> > > > > > > > +		break;
> > > > > > > > +	default:
> > > > > > > > +		return -EINVAL;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS)
> > > > > > > > +		return -EINVAL;
> > > > > > > 
> > > > > > > Can we move this check before the switch and simplify the switch itself to only do the timestamp_types increment?
> > > > > > 
> > > > > > DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK is bit field that holds individual
> > > > > > clock type values, so we still need to validate the bit field.
> > > > > 
> > > > > The if () test eliminates the default case, and if you change the switch to:
> > > > > 
> > > > > 	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_NONE) {
> > > > > 	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > > > > 	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > > > > 		timestamp_types++;
> > > > > 		break;
> > > > > 	}
> > > > > 
> > > > > then it should be equivalent, right?
> > > > 
> > > > We need the default case to detect garbage values in the part of flags
> > > > that ands with DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK.
> > > > 
> > > > DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK is 7 << 1,
> > > 
> > > I understand that you want to make sure that user space doesn't insert values into the
> > > flags and then pretends that because we didn't return an error that's now part of the
> > > ABI. But then maybe you should not reserve the extra bit now if you don't know how
> > > it's going to be used (in other words, why not make TIMESTAMP_CPU_TYPE_MASK  3 << 1?).
> > 
> > I think it makes sense to reserve this bit now to make it easier to
> > extend the interface if we ever will need to. Changing uapi definition
> > is painful enough, so reserving this will rule out misuses of the current
> > value. Another point is that we would have to validate that the bit is 0
> > anyway, so I don't see why we can't include that bit in the field that
> > is supposed to go with.
> 
> You do validate the bits in the if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS) test if the
> QUERY_FLAGS bitfield is updated.
> 
> > 
> > > > DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC is 1 << 1,
> > > > DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW is 2 << 1,
> > > > so 3 << 1, 4 << 1, 5 << 1, 6 << 1, 7 << 1 are all invalid values that need
> > > > to be rejected.
> > > 
> > > I am confused about why TIMESTAMP_CPU is a continous range [0-7] while the rest of the
> > > flags are bits in a bitmask. A note should be added to the panthor_drm.h file to
> > > explain this.
> > 
> > Well, just look at the definition of struct drm_panthor_timestamp_info -
> > there's one to one relation between field and a DRM_PANTHOR_TIMESTAMP_* flag,
> > with an exception that CPU timestamp types have only one field (well,
> > a pair of "seconds" and "nanoseconds", but from logical perspective it's
> > only one value). There's no known reason why anyone would want to query
> > multiple CPU timestamps together with various GPU counters from _GPU_ query.
> 
> OK, so what I'm hearing is: we're reserving space for up to 6 CPU clock sources (zero is
> no CPU clock) but you can have only one active at any time (because we can't think of any
> reason why you would want more at the same time) and we currently only define two sources
> because that's what user space cares about.
> 
> If you agree with this then this will be recorded in the thread and we can go back in the
> future and reference it.

Up to 7 CPU clock sources and 0 as no CPU clock, but yes, this is the intent.

> 
> > 
> > > 
> > > > 
> > > > And since DRM_PANTHOR_TIMESTAMP_CPU_NONE is 0 << 1, we need it too in
> > > > the switch to not be caught by the default case.
> > > 
> > > It only makes sense if you explain that TIMESTAMP_CPU values are in a range. I kept reading
> > > the different versions of the patch thinking that they are bits in a bitmask, with
> > > TIMESTAMP_CPU_NONE being the logical state of not selecting any of the sources.
> > 
> > That should be resolved with the documentation update below, right?
> 
> The documentation doesn't say anything about the intent for future values for CPU sources, but
> if you don't want to add more in the documentation at least we have this thread as reference.

It's not that I don't want to add more documentation, I just don't
understand what else needs to be explained.

> 
> I don't want to turn this into a bikeshedding thread, so please do a v4 with the switch case updated
> and the documentation addition and I will ACK that.

Done
