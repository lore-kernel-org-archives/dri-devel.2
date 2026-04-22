Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B95FA1FC5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249E310E032;
	Wed, 22 Apr 2026 16:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iEg1xrhM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iEg1xrhM";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C484E10E032
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:09:27 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=zAY9MPEzg7JQhhaZ6I7BBp5Z4I6/+n+ri9l7Zuva+3uSVpLZPnKffBnteNTqgNNUYzkCxWUqwMTzdFDJm0RbMxYuuWrbP1bjo82ttkv3bwIVi9WZ8q1ZBSMKGfm3MrbB+S0SPIzYGZEuKQfK9SklQ18Jem2kSpji0RyUemvoP918SnyPQLcHRIGssJUJtr4ynL5KJmM69KYRaqvW0bzveBws0fJiSFaMe3qtex7037RE+dFoM8i9GDMeeSvrAK/xi/Kra5yYMWRYnwlvxEd7JrEoLKXVktHC5mtNckjlcukxouXG6Xv+FZjZReO1gpJYn2cuNk0kXC66y5TvE8LbmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRZHs0qV4bC1+L29aZWSRoH54A9TAHBDeMPaJosVWeY=;
 b=JjPfGFpQOOdh27opMj3xRcv98Bak6BRrWI3cm4/R3WElTfOXWcpX2lVPVqo6vqymTKTppEEplSldjoTcZOxJ8z35CEcFKaRIha2Y8HyGh/6qtiiA5vEx361hFOK0RfdeWE2+LTPmLVZ2MMBBMC5WH7ejHcRlJkehmxF4Ks5nvif0yruUeQ2LhqjC+leTaqtHBLqKKa0f1VZGMQ4BqqJNaKcnYWBMA0CH5+v2neVGMV+uFSfdyQvdRxrPvXME3lHi81cT4EP54dt0KaNlKDmyQNaQvEe6mOlJUSrD+IiM2qnAA4qmuBOf8K3UvDmcFuaEIdBlNWQu3sN0Jjk5EqaXSA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRZHs0qV4bC1+L29aZWSRoH54A9TAHBDeMPaJosVWeY=;
 b=iEg1xrhMep0JsXrsb8wrpcT3vokdPx2CwlaJaczj5ZvfeghHapH0UQ7mmnos7pJCG6h9WNGg/vk7E4n5VOxELFMrOXuLRK4W5fH09+zgwpnJD4KzY6i43sSIjkfP8FPyegA9QB/YB8Oyo92JeR3fbNEIOS1ISFG8nwH4TGgfnvg=
Received: from CWLP265CA0427.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::14)
 by MI3PR08MB11908.eurprd08.prod.outlook.com (2603:10a6:290:74::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 16:09:23 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:400:1d7:cafe::48) by CWLP265CA0427.outlook.office365.com
 (2603:10a6:400:1d7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 16:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Wed, 22 Apr 2026 16:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wou5MyuDYvXPMjwQL5q0Zi1RXH4H+8SqREDo05X5V/hr1wF91aE3/XxwxQpmQ4LcDtcKW07zHzcaEwWcS6YMa4LOtRuAJI9QX4SsesJvZbzIVOHh5cR8qbBTtr1nRxa3ICPU79MpsowGg72utbKzaq2703efblasOIy3XF+0TeEj6mQSsy0Skg0JsbPogJd/jrzgaompimHXVWqqalFH6afs4F7WwKcNRegZP4TLEWO+YcF1b4tMGTBb6h5bTNDUGeTdcc+CAGjqLWUGbUwlC64XG1u2hKVfkJsZ+UYDsEPVfWt6MGUvOznYx1fUJY3wMvx1iUtkHgnTJ7ppvHfhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRZHs0qV4bC1+L29aZWSRoH54A9TAHBDeMPaJosVWeY=;
 b=IWlEM2EC4zz0j4wcExE/1f29B9drQwWzDqPkXFb42w5+MmrJjMvM5FOq2AXsMeWQv+XhIbkM4m4HgICNmPceBftCJHu+srONd0IuYQf7RJ2P1i/hY7RVtsLEVXYc5wx88Xzfpfc0G5tMIz5YSBROY0px9rXQgUGv3qmK8i2DSMS+0knnP6vxt/kbjqkPKofx+F8WdogaJ135Cc6U0364MkxVixsfd/XKxAHugg9NcU+H4IIpBUHWc+2dtdWkOA96LpyeKRfsB0sRN48+HVz0/sCE+ocpEWvh+gcMboZL9JsMnwE1cN3TT7IsRy+nbITApPnvfO/Sc1wQLwLvblnW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRZHs0qV4bC1+L29aZWSRoH54A9TAHBDeMPaJosVWeY=;
 b=iEg1xrhMep0JsXrsb8wrpcT3vokdPx2CwlaJaczj5ZvfeghHapH0UQ7mmnos7pJCG6h9WNGg/vk7E4n5VOxELFMrOXuLRK4W5fH09+zgwpnJD4KzY6i43sSIjkfP8FPyegA9QB/YB8Oyo92JeR3fbNEIOS1ISFG8nwH4TGgfnvg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by PAVPR08MB9284.eurprd08.prod.outlook.com
 (2603:10a6:102:303::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Wed, 22 Apr
 2026 16:08:18 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 16:08:18 +0000
Message-ID: <b6c97926-57aa-41dd-99f8-c5f0397e002c@arm.com>
Date: Wed, 22 Apr 2026 17:08:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/panthor: Store IRQ register base iomem pointer
 in panthor_irq
Content-Language: en-GB
To: Steven Price <steven.price@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260412142951.2309135-1-karunika.choo@arm.com>
 <20260412142951.2309135-5-karunika.choo@arm.com>
 <53a66bbd-7ed5-41d9-a15e-af17f292dea1@arm.com>
From: Karunika Choo <karunika.choo@arm.com>
In-Reply-To: <53a66bbd-7ed5-41d9-a15e-af17f292dea1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|PAVPR08MB9284:EE_|AMS0EPF000001A8:EE_|MI3PR08MB11908:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ae5802-c886-4800-512e-08dea08984db
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: aiPRexzeXPY5wUA8i7ybDR9OnMunHf2yuPjwLpiMq8AXW0R3MuEEWX/7wU66EhqdBNwfXNMFLjnuuvJYjsFY/86XmJiejBTVrwpd1lQVpr0NeD2Vr/9K1qHbzvAA2AoklDtitDGimBjvNQGjB6fVCGB1DaBn4WJ911nT8d+tyhCKqh6dhrgM0zRUN4xiOb33uclPDq5ghmzhtnuHtT1B8aYbV+nIOAWeUZhMtLna4N0zdHMQLLBKMKiKUK1S8bTnmCC0QF0nocu9xZE7seUOuxFI3JargtkNKiy48o3jYpQtZ6wxqsFyXjx8dGXI6V7yZ/FCGrC5/IAPZuO0i+4n/1PHwqkHXrtQNpezvs5+7ITxd8GR+UtSpc1BxbK4COEJ3ifKvCZzvaeixk7KOwJWXbomWC6Dl/R8sCK0vUxz5AyRS+qRqnNNrQpyvTInlZq5PzCqILc9LU+F5zJnQ+lomQgo7Da4JSV2dwtlJXvo5RSPeFqPDs6X6019SLlo6X2JSnThRmyevAT7CQzuJ2LUFnA2NaBvA7WJfEyp2+JQOay/oCMUlEqZQXd9dosw2WyrnrZPEK54AwRI5gn6x3DSvKV/ge419T14EV1AoiQtVZRhlAgoNgM8loE01xs/rgZomzjh5V2W7MOx878M0F5nH2+kP7uMBOU3Sa0XvkJlcv1LPlDa+rVuAcERzzwsqPWnZzF/pfIMceuV5QzzoccQH8wmPw2cXUM81ZwcuC0wBtk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: RRNvjWL3BdgFiD05WWjIEw1tRTPY2ey+ouX+pI5FT/NLkH1svsxGGAPlDqi3uBjQxU3V5VZGPgCJTaZ9z4BE0TXRm7VZ66c3qd3mJ+QwdN/1yAqem5Rsol1YHS8GVpYgIL5NnurANNnBxgw7LXvcT9bUL8HuvGnTkKq8kVQUAV+W1vBccmOg9Yebc/VRoFSH+eCxCwwGTNWDgQ8cgmFv8xflYKsBAJBTmwsx0Rzdja9BHeMH4QI16+LXdqgaiKWO6odIhovWaUn1GkIZvlQ/GGfr23trgLB9dKC57KzKXtrAEGOl4G+o24GBnPxV7TOGP4X3cUgdvAkdZyGWUKYQ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9284
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fac57616-b9db-4c0c-ead8-08dea0895da9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|376014|1800799024|35042699022|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xfD8LXUg8fZBxUMABKBdfxfHBB6ng6IQH5THrCeya/90p1NPOucKUmGIvlaTP6j+ej4s6vZRN1ON4Oir9XTk+wkWhhOR9yXS+a8QIcOmRfYQ4DcZLHoXxMBG7WLIEt+Ga6mYvihzChT2djIh8ueQBfVJF/+zOujvIzd06Vd89xWnYP4R3D9b1ws6DFDDMmV5ysRsa9ibqZi2QyKUejA6bLOhCTJkXtJI/VVmnLU9mw3DgokCN2ZHRqGCNVVNR+k6NC537rUVGmJ4K3OILsAAi2AN8mfo3P/+ca01Hc9NdZzoGktik4ePX3ZBIaj0sg6tBJ9BQZLDoKLBA1tjXIRgbaAdIf8BUupfZKIp8TXbGAZUjDgoIinAyESmpHC0iG31GQ4LW0JwaDrOJfnGOLVM5XrUhZxFdGXHpIf1DMlkrbuuBDttz+KIraCW7USr8/+lcDYxjoBgj4YOmtkIgCDIa15TuAK+ODBjGo045cdt2tJGgZ/V5H56d051WVe0kHz4gxIaZFTGheQCg09JRjuLp6PzlgsjhUdUsH4oy/MuT3UHSCnSHeBCsNKjwX5lGzPbSI0n66qtsS31Kn6lRFrlWQ+gxHr5VBH2DOX+En73E2WHL8E7LzpLQklgbbv5u6dttidiImIPvgOQT4GAPGyRmpqQDFl40rXm6fXHHneE9X6csj7lqojjDtP14Yqy05dgYxmbtjT8V69plWmMUaoT2Qd3vfpisW4MyXUAKeEay0moncJId+29utlaFvDlukuxmHplf80EC+jUltw5j1Mhnw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(376014)(1800799024)(35042699022)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bpBTSp6jloLKPouMx6JeMSHkoi6Ai1mQOZuUhemspBmdgE4LARiTnT5qSLEInqbNNgZ+92HLmtxd7tjjPl9HmFONBtcfVMu9icDR8OWSmbFB2f7CAYf2Z1BOfb4TGlRTeB8Fh/x0+ki/mQAO7x38CvSdyM4YXogUhwIMfcoiR3NkEu72rqXP9fVCjPuG1LfJ4FfK3OSe+D1Nf92f/e1jCap7RXSw16JLnxQrSC/YRDeAuZCseGesX7J3bFhC7UF7E0gDLVjsib8MoQvlOXxtkUz8p5nItdS1L7I2+c9x2h+G8bPTfTci52Me/n5P37LwVlSobZtvjnSh6S8wkTwm5dtwye0FVzoevBv8Z23fTmtuOWQsVqg7UMOK5w3fd6A/g9XjU3FBcY0jjBLvT03oAbr62K3YzEkAimvEywviH81bCyu6yAiXir+wP+kPYETZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 16:09:23.2275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ae5802-c886-4800-512e-08dea08984db
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR08MB11908
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

On 22/04/2026 10:34, Steven Price wrote:
> On 12/04/2026 15:29, Karunika Choo wrote:
>> Update common IRQ handling code to work from an IRQ-local iomem base
>> instead of referencing block-specific interrupt register offsets.
>>
>> Store the interrupt base address iomem pointer in struct panthor_irq and
>> switch the shared IRQ helpers to use generic INT_* offsets from that
>> local base. This removes the need for each caller to expose absolute IRQ
>> register addresses while keeping the common IRQ flow unchanged.
>>
>> No functional change intended.
>>
>> v2:
>> - Change IRQ request function to accept an iomem pointer instead of
>>   computing it from an offset argument.
>>
>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> 
> One minor comment below...
> 
>> ---
>>  drivers/gpu/drm/panthor/panthor_device.h   | 32 ++++++++++++++--------
>>  drivers/gpu/drm/panthor/panthor_fw.c       |  5 ++--
>>  drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 ++
>>  drivers/gpu/drm/panthor/panthor_gpu.c      |  6 ++--
>>  drivers/gpu/drm/panthor/panthor_gpu_regs.h |  3 ++
>>  drivers/gpu/drm/panthor/panthor_mmu.c      |  5 ++--
>>  drivers/gpu/drm/panthor/panthor_mmu_regs.h |  3 ++
>>  drivers/gpu/drm/panthor/panthor_pwr.c      |  6 ++--
>>  8 files changed, 42 insertions(+), 20 deletions(-)
>>
> [...]
>> @@ -1470,7 +1470,8 @@ int panthor_fw_init(struct panthor_device *ptdev)
>>  	if (irq <= 0)
>>  		return -ENODEV;
>>  
>> -	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0);
>> +	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0,
>> +				      ptdev->iomem + JOB_INT_BASE);
>>  	if (ret) {
>>  		drm_err(&ptdev->base, "failed to request job irq");
>>  		return ret;
> [..]
>> @@ -162,7 +162,9 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>>  	if (irq < 0)
>>  		return irq;
>>  
>> -	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
>> +	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
>> +				      GPU_INTERRUPTS_MASK,
>> +				      ptdev->iomem + GPU_INT_BASE);
>>  	if (ret)
>>  		return ret;
>>  
> [...]
>> @@ -3229,7 +3229,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>>  		return -ENODEV;
>>  
>>  	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
>> -				      panthor_mmu_fault_mask(ptdev, ~0));
>> +				      panthor_mmu_fault_mask(ptdev, ~0),
>> +				      ptdev->iomem + MMU_INT_BASE);
>>  	if (ret)
>>  		return ret;
>>  
> [...]
>> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
>> index aafb0c5c7d23..11c43de1ddd5 100644
>> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
>> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
>> @@ -70,7 +70,7 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
>>  	}
>>  	spin_unlock(&ptdev->pwr->reqs_lock);
>>  }
>> -PANTHOR_IRQ_HANDLER(pwr, PWR, panthor_pwr_irq_handler);
>> +PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
>>  
>>  static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
>>  {
>> @@ -464,7 +464,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>>  	if (irq < 0)
>>  		return irq;
>>  
>> -	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK);
>> +	err = panthor_request_pwr_irq(
>> +		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
>> +		ptdev->iomem + GPU_CONTROL_BASE + PWR_CONTROL_BASE);
> 
> This one is the odd one out because it adds GPU_CONTROL_BASE put the
> other panthor_request_xxx_irq() calls don't. Sashiko also points out
> that there's an argument these should all be using ptdev->gpu->iomem in
> the final refactor.
> 

I understand that it is slightly different, it is only there to
illustrate the fact that it is a child of the GPU_CONTROL register page.
w.r.t using ptdev->gpu->iomem, that would mean that we need reach into
the panthor_gpu component to access the memory, hence why we used a
separate iomem for this one.

Kind regards,
Karunika


> Thanks,
> Steve
> 
>>  	if (err)
>>  		return err;
>>  
> 

