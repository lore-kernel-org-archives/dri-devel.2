Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E539CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E46BB10F518;
	Mon,  8 Jun 2026 14:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="XwaT/Bgh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XwaT/Bgh";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013059.outbound.protection.outlook.com
 [52.101.83.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D6D10F518
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:41:08 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VuuHGGbzRCj0Mubg/7x+TM3P7fcm0bs5ia4c9x7vHpVMtutVv5DKlgFIruDNOcZs0Z2FI/dX78qUWJag0d0mw0giDXI2BchT1UrDZSM6GPwjlPkTon6ihY2m23yI5Jc6wOcNHtEno2uojL/+Th3/EhW27uqmS3u6e5MKxHLPzDJi2XqJW0svNNdO7uFMN2GCZw1VBydiaYGjywcFvSx8hqdcuxkdQg5BJucKFTszuBK4X8VAKggI5Ox3hoazT+8uDkbOlGnHJ28viRpNNpr3MYzc9U2ehjpipCPHqHQsKpx3Q3UHbvpDfCYlDaqiTvTdxzLqs1QApMG2yVYmPNdzCw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elrzKKMc6mRAQeq52pLdkemL2gT37+P/CVy/qpSG5I0=;
 b=KDDUMrq8PQM2zQ9HHCcmls8bz3CO2dVCM6iOP6lWKjhBbpI579xReBcpG0gyJUvXWCWZyRuY/AyY0ccmd7dcn9gHLTtvPulCHSIf3MYqAen+ksr3KdKdZBuZUYGM+i2frEAS5Mpzt063Hef1VAkusuPBFjCw6H/fD6XBQpyxC/SJPwk/NxZAVxpgms99AeDsGSuamHjJpMr7S5nJCssNUXkbNrL94LseyhrJGF1NdEDbdI/1n9US00044HHsOgdO6xFDioRza2BnSWgRwqu9pI3Ih1MNFHtD9DQcTIkVHEwiWpHK1zzTASFdtQJXJiM/sotgU+lefbcB2iA8kQSJVQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elrzKKMc6mRAQeq52pLdkemL2gT37+P/CVy/qpSG5I0=;
 b=XwaT/BghFBLnGixpbz8aeJBICmzHxK66lLLHZlJwlRzL+wVS7ZN7A61JO3MVExdFMUfrnHn2tDjsF7f/LDO4s6Ma0Q+M3jUVvWqTKmjwAMBVkEcxRLHV39x0W7wetI4Oyh18x0jjgiZqUal/Bt0GPgkcySs+ddlDfjmQl05c+w0=
Received: from DU2PR04CA0165.eurprd04.prod.outlook.com (2603:10a6:10:2b0::20)
 by AMVPR08MB11976.eurprd08.prod.outlook.com (2603:10a6:20b:773::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 14:41:03 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::23) by DU2PR04CA0165.outlook.office365.com
 (2603:10a6:10:2b0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Mon, 8
 Jun 2026 14:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via
 Frontend Transport; Mon, 8 Jun 2026 14:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co/IbPuyGLgmD1AEYN2xwQ+VMD6zZRj6WW/MzHI0BZDxeaoMg44fCiP/VpORLelbDX3TEbII0IBNELhmPDEK2+Hlbp5EiFusNrcjMkjpTkczW2skNL71JDmhizjJiMwDmhK2/wOpllRvM5wAJ41/1o+55tEWjURljq+cK4GgUeNqpQqOXYIniLQlKl5Bcln5q2TBDL7EAbcGlA97TH+qw/EbT+XvhODtZf/pH3BzltjVtOJECt9k4Ymf7z1zZ0n6XLlBtMyCd2ahlDNoOg0eNJE7CrTzB3Ykp6B2L4QHDHN3UwBvWdUAp0AWUmu6EucQfa4HTTqtsOQRowcJYU/k/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elrzKKMc6mRAQeq52pLdkemL2gT37+P/CVy/qpSG5I0=;
 b=aVKqPDyz4olhKXdN3+HvvP3hNoDpQsbpRikf/hmHR2kJBoFZBvdeQSTRmEUQpfxKiA3a+8XFE7+vvLyYfelKbHRJbnvLQXTAHbIsxPxGPiR7oSDMYCf8WiasDrDcOgdiTVv4D9svwk5Rkn/alpJKEwTztak9gj5aKWTtxq7vINBii2rKRvI6ColzOajeGLsr57QEExyXwygFawiULJKxZQc/YTnjdzMhHzTwemJROwgc1arjIvX73c1YD8akzQTT74q2YxvNVoZtfg9D2WCjwsAfB3matECXfYpjuPzY09zCCJKDWHHUktnNw1S9FTACLpO5mlQRaxBd8lpZfXw+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elrzKKMc6mRAQeq52pLdkemL2gT37+P/CVy/qpSG5I0=;
 b=XwaT/BghFBLnGixpbz8aeJBICmzHxK66lLLHZlJwlRzL+wVS7ZN7A61JO3MVExdFMUfrnHn2tDjsF7f/LDO4s6Ma0Q+M3jUVvWqTKmjwAMBVkEcxRLHV39x0W7wetI4Oyh18x0jjgiZqUal/Bt0GPgkcySs+ddlDfjmQl05c+w0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS2PR08MB8997.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 14:39:58 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 14:39:58 +0000
Message-ID: <e3c32d54-b85b-4ad8-bd6d-120c4dbfead1@arm.com>
Date: Mon, 8 Jun 2026 15:39:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/18] drm/panthor: Skip devfreq when no OPP table is
 present
Content-Language: en-GB
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-9-karunika.choo@arm.com>
 <20260608160822.1038d08e@fedora-2.home>
In-Reply-To: <20260608160822.1038d08e@fedora-2.home>
From: Karunika Choo <karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0495.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::20) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS2PR08MB8997:EE_|DU6PEPF0000A7DD:EE_|AMVPR08MB11976:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e69248-1410-4477-5a87-08dec56bf76d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info-Original: xnQ5BFz0o15Uf+w07QEAvaT6t1iewMXJIs7V7/dvUYSz3qbhKTl9+EZsVVwjGy9LzmAqY50+nNEemHYCVffh4Ia0cgHKNgufkoD6kAx9og61fbVoSE3bWpkIXv5X/RO3qAGRZguYw5UbZXGhpX8oNEZFdF7cAbVyflMBPdNn4nsd9ojDtDx7DnhZSOLVYLJ9wbAr+Kub7R+k8ukVmzjSzvpBsOA9dnYdpmaz1vd89ceHcrudDD4XMNv+I3eTbMk44rc4tYuuz8voSfOqq7g7tengINZ8SU8S3nATzv5CfCooyuPfHiBiXAlrCVzHmnTL2voW3OV5nnJmZFH3coDwCOADkvtmY4QwECmD97pj57rmLBBbVQcPg3EhnnhNcLdFyF2Ix6UpPm9oMYirY1Rld6R1GUvtKpugQ+ijeKwKKkpCxBc13reOyv1dK90CVcliyV7G3LG2VOPcAuRzHCzvBGN0P1KO7Hr8D4ooX64hjIWgONTuPY4iQ+1fifaBq8Ej/nh0zD2VYDN3U+KVd4WAbvwJv+gsIlkYKjtShunfZDfyy07YGQY4WSD4qpL8FIDE3bEHqMNsYjzhOvRDYNpBGeRlug2UrmmwmHduJdFbjNklhB31T+232mS9Zd2wOgWCE5+InJhvx11h997FQFzZg9TJ3YV7nVeDypPLuNE6TZxpr4ZDXH5vit2+vCoFKo8w
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: RyeRqY/aTJRgW4B6Vre6QE0GHsSxVTrbQENOpA2ivGGLqWXOjmIa8S3WR8oLqZdLwDyTxzZRVhtQqLYReOiLoutaftjPJmc9v7XbAb6idSiU/so9ZABpTmjNCPIJ+xldzuOuWfzLVIbJyEVn8gzMSx4nlCYHMqg4/Vj/G985Q55bpnKSRcNEaCggFoA/TOdGo5u8CTCV76QNmxqyZ9MEHnKRxOyyiXV1h2B5Qb8fiPcrh0h/VL4B8EijqNxyWExxkWqeDKHYANqwLiQFlRj9czCbAqcXFCc5CPVc+MTONOipKz3iM1z3/wSszRTnpGboQBxev6qaMWj3JJTRFkWLbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8997
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 677674e6-630b-473a-b12f-08dec56bd052
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|35042699022|376014|82310400026|14060799003|1800799024|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xuIgK3n2Vxryq1/Sg/KegJmNhrcws2pPx1+eSxp1oyQStXl0RSzsR79mRoznsHmx3aFMsdmROytTb01QdJP6Jke5pdp4ez+RwIQHYylP13BlVER0lu2Iu7bvODXsX+eRLui7V0546yOqEqHUuAr0GjvfMFtsqLxi4cl8vnffRfXOpxQRqyZ2CBCqt4FCZmLwGfYijGt+3uDP/BCc4oA5vFUxkXWaSrBh5r7grOgqD9KkT3MCUH8hfOENelRS8mjqxSF7GzqI59xXfUmxXJollYsyZbXWgpeg1aGeilspnfQfGEiKBrxR4JdjavQ2CWv+Xm2HZVIkDei+3GmwTe5BYae77JwVJTFZk28RIHsk7hBcYoYIT4Rxwwc2+BA7PL4xzXuZdcm5EwxsG/zxxnqD7AonWbR1lxMmQqU3gn1lml8InfJkkCpYxvVHkhNMNIr+c3cSBmgSL7p8/YAUWPGPcGuGKhyRq+br82x/hwLhORNaTYsHBF7DAzpa8EZtVh6k81E8IIG9+4f2G5mOQNXsww5x+drw/vK/Qdse79vA2ESJSd7KbHQJ5K/+Wa+iaqc16/5zBb+SBMDNpwbK0x0KgeMQHFeJ0CxS5bUxIK2Mu+ppm+Lp/SQWb/r3gv4jxJaTCr79+nl3wsuQgIxjyTkjUjKkhz9rHIz2ekRybC+/BvywWk7fvS+pgYThTlz0UnTmVuh2tiIMypEGvT2O23I7kU5fRUkKgTRcjABC/X9x5Qs=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(35042699022)(376014)(82310400026)(14060799003)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7PO6JwZP1uEJ/ZfB5OUxlrMxDx/gW/w/RttF0IwQxVeVgveGILs7ZLcUtoDnWgrrWrXn3d+Zd/vEnr5qy7jOYq3UR03JY6qtjWP+1Zd0f2WWBB4zjyA5q5T8cf8mqILddgBuXi8/RPkT0waKyTLoM2RgMVpOBD43zyUdtoI95CUShSbGjiORtTdE5tcvSzFP677ujmSm86bpfXYdiOLnOL2+7w3iFBegb+KOYBaXu9u6glD//2C3mq1P2RDoxnHgjmrMUKtfkTYakJGPwOizFtMIMM+yTQ7i/gCSftHyGA+nndzBIEBLqsR9WkqXp5sOCWvIA7Su87aly5kBslDz1Wyxj4liLRIeQUaCHeVvCQLl95+jBpj/cGZEvHOjx+9JLxvAAkdPvAw9IGJZJ/hr7mXm/hFBcbgomkVpFpB4i7i6R2/2MTnXYnEHOzeuLjC7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 14:41:03.5475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e69248-1410-4477-5a87-08dec56bf76d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMVPR08MB11976
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

On 08/06/2026 15:08, Boris Brezillon wrote:
> On Thu, 28 May 2026 16:05:36 +0100
> Karunika Choo <karunika.choo@arm.com> wrote:
> 
>> On Mali v15 AM systems, frequency scaling is handled outside panthor by
>> the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.
> 
> OOC, is this still handled as clock frequency changes? I'm asking
> because the recent perfcnt work requires registering clk notifiers to
> get an approximation of the number of shader/top-level/coregroup clock
> cycles on a given period of time so we an calculate relative GPU
> utilization, and so far we've only considered clk notifiers as a way to
> get informed of these frequency changes.
> 
> BTW, this is already problematic for the mediatek GPUEB design, where
> devfreq stuff is delegated to an MCU, and we don't currently have a way
> to get notified when this MCU changes the frequencies.
> 

I believe we should still support initializing clocks and registering
notifiers for them. We are just disabling the devfreq subsystem in
this patch.

Would mediatek be able to expose a child clock or logical clock from
ther GPUEB driver to Panthor so that we can get these notifications?

Kind regards,
Karunika Choo

>>
>> Make panthor_devfreq_init() return early when operating-points-v2 is
>> absent, and guard the devfreq helper paths against a missing devfreq
>> instance.
>>
>> This keeps devfreq enabled for existing platforms while allowing v15 AM
>> systems to probe without a local devfreq setup.
>>
>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
>> ---
>>  drivers/gpu/drm/panthor/panthor_devfreq.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
>> index 2249b41ca4af..c3252ce54437 100644
>> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
>> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
>> @@ -148,6 +148,9 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>>  	unsigned long freq = ULONG_MAX;
>>  	int ret;
>>  
>> +	if (!device_property_read_bool(ptdev->base.dev, "operating-points-v2"))
>> +		return 0;
>> +
>>  	pdevfreq = drmm_kzalloc(&ptdev->base, sizeof(*ptdev->devfreq), GFP_KERNEL);
>>  	if (!pdevfreq)
>>  		return -ENOMEM;
>> @@ -267,7 +270,7 @@ void panthor_devfreq_resume(struct panthor_device *ptdev)
>>  {
>>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>>  
>> -	if (!pdevfreq->devfreq)
>> +	if (!pdevfreq || !pdevfreq->devfreq)
>>  		return;
>>  
>>  	panthor_devfreq_reset(pdevfreq);
>> @@ -279,7 +282,7 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev)
>>  {
>>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>>  
>> -	if (!pdevfreq->devfreq)
>> +	if (!pdevfreq || !pdevfreq->devfreq)
>>  		return;
>>  
>>  	drm_WARN_ON(&ptdev->base, devfreq_suspend_device(pdevfreq->devfreq));
>> @@ -290,7 +293,7 @@ void panthor_devfreq_record_busy(struct panthor_device *ptdev)
>>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>>  	unsigned long irqflags;
>>  
>> -	if (!pdevfreq->devfreq)
>> +	if (!pdevfreq || !pdevfreq->devfreq)
>>  		return;
>>  
>>  	spin_lock_irqsave(&pdevfreq->lock, irqflags);
>> @@ -306,7 +309,7 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
>>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>>  	unsigned long irqflags;
>>  
>> -	if (!pdevfreq->devfreq)
>> +	if (!pdevfreq || !pdevfreq->devfreq)
>>  		return;
>>  
>>  	spin_lock_irqsave(&pdevfreq->lock, irqflags);
>> @@ -323,7 +326,7 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
>>  	unsigned long freq = 0;
>>  	int ret;
>>  
>> -	if (!pdevfreq->devfreq)
>> +	if (!pdevfreq || !pdevfreq->devfreq)
>>  		return 0;
>>  
>>  	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
> 

