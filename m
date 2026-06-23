Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0A2CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD19A10EAF8;
	Tue, 23 Jun 2026 12:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Cs6po0MQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Cs6po0MQ";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011062.outbound.protection.outlook.com
 [40.107.130.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C3D910EAF8
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:42:26 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=P2IofnxzCJZ89QilvcYtKzKmp3hDgOEKcVsPx5uFZLS/dpaVW0Ops8fXepOeBIDUXrqQfT7DzKgQzQRVxjFMn6hHXYyaiC8uJ4BDxbsla7q/2rBbmXriv5YyKX8ttB0lrTdBOjL8rewWYDIoVzcJoaXvd8c51Gqpt97dKW4/678QiOMh+cyQUCqbTuwXS+3cE5g0XkTsETcFfTurZoRAjVxbtvC8zt4vC3FdAf9odF5QL7/ZL2qWTHc48+dZaYWBvLV+Rdi4acdP5Fx6ny53KbVfz27Cno2IzOwVNLaOfbJS7jp4RKxwGxsE1+Gp4S4kcv/hQ4fXP3Uu7chx/Ep2Tg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGzRl3GQFSfszcDF7dEsQp2KFbvDtvbhCAgu7YYyQ2Y=;
 b=rlTSQHMtO41GfxGlyljqvNh5Vp84EfYqouj3d8oNz8YV/5iwqAcyFWtirbXkLwQ7EsA1GheO7fFgQViHW6h1upCQU978Sg1LtGN4jIS5Eqi/6W4VejjkMM6N1ZSzgo7TerF0i2Dd2AV1SPu/krCXJoq0ZXsKbb5FUil4VknLYGSW/j4TDDYg2X9LQsSXyIKoeEP1JHj3VFN6A71E9BZ/4qUd2Z7QJoxf0/aLbWsvUJYq7X8c4QrTHbC2IfoyPYQx8d0JiJIf+ZDxVds+DM1W4bXqZX1vrCxy8RsmiguwrnwICns03l87PUI4Hvm8bzxWcackGJrXA5hEa0L+En+7vA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGzRl3GQFSfszcDF7dEsQp2KFbvDtvbhCAgu7YYyQ2Y=;
 b=Cs6po0MQClUjgPiBbYqDWM3zdCzPw2/2RdaRHtdKNhr+ik9ba15jidqwhfy6DSFoecCf227YJDFz0l+Zh6IiGbo8kVcC/8TnNbe1TBsBFRhdenW9JiQwZyT+tc54QmUlEsoR7CAhpyGWBExVmVghprWKHVXOAH4FASFSRo5FO+Q=
Received: from DUZP191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::28)
 by VE1PR08MB5759.eurprd08.prod.outlook.com (2603:10a6:800:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:42:19 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::63) by DUZP191CA0017.outlook.office365.com
 (2603:10a6:10:4f9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Tue,
 23 Jun 2026 12:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 12:42:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fU/DYQU7XiAhElxIrNSuJx8y+pKz6RHRqbs+p9/5LSJPFX8fUftE8u76NEMJ56XQN1KhMZ17qCwo70b7j00ab0m4m6DjRqRxC5EDU00f94VGwlAj+NeqxB9yvNcKgiUi0km2SgCFdS+YaZkiBXg4+r1jmjrsAb8SyShTx//iEjHN1fQuH1irKBzC3Lgdsr4CmMFIgbKuwXZdsqWZA6Q+pQvR1OOm5WX5FBiBQsgQd3SfpPJQ5cR+xoVi/iDNaAka+YaQZvE1Q6JQ3U4866tbNzT2f8i63j9lVyb3Wyrucw4k9F3jb2RMMFICM4OB0rdy4pgBNnDWkoQmqcsdfqS2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGzRl3GQFSfszcDF7dEsQp2KFbvDtvbhCAgu7YYyQ2Y=;
 b=vUau8lRrG4z25dh63HLma0i8/knIljv2+QJGI4zdn8HGNjGJ5tHuvi9uoHI/85myzo0sNoLRI11YApRqhGLzHbfp+PbvB4xfRwIp0FIgFM/Ts0FfKXE9o6uuGr08whqKBaNS8V2YFtClLiXLHg5wLVMXg5fKq6ujx72DlJE8f07HvbYokjIXAj6jDoXPQE7g52bGYecJY6DrzgWpMMp6Aq83o7D19RiM5vz0FHLLGGsJo8E+TEJAvhV0FouYxxAiDivKPjhAwAc5WiUI+WfVOG5IkMBufz5sKTnaUDPQPKBWN9LmbLf2SPXENNM1HoKu8R4Hs7ROlV5qTscw6bGyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGzRl3GQFSfszcDF7dEsQp2KFbvDtvbhCAgu7YYyQ2Y=;
 b=Cs6po0MQClUjgPiBbYqDWM3zdCzPw2/2RdaRHtdKNhr+ik9ba15jidqwhfy6DSFoecCf227YJDFz0l+Zh6IiGbo8kVcC/8TnNbe1TBsBFRhdenW9JiQwZyT+tc54QmUlEsoR7CAhpyGWBExVmVghprWKHVXOAH4FASFSRo5FO+Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by DU0PR08MB8423.eurprd08.prod.outlook.com (2603:10a6:10:405::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:41:15 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 12:41:14 +0000
Message-ID: <b85679e3-5ca2-4d36-8675-2b968d97cb5b@arm.com>
Date: Tue, 23 Jun 2026 13:41:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Fix NPD issue on partial unmap of an evicted
 BO
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
References: <20260623092413.2710066-1-akash.goel@arm.com>
 <20260623115332.7e89f56b@fedora-2.home>
 <9f9b372d-b465-4fd4-ab7a-9c399e35b4ed@arm.com>
 <20260623140942.5055457c@fedora-2.home>
Content-Language: en-US
From: Akash Goel <akash.goel@arm.com>
In-Reply-To: <20260623140942.5055457c@fedora-2.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::7) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|DU0PR08MB8423:EE_|DU6PEPF0000B622:EE_|VE1PR08MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c12f30b-23e1-4280-ba90-08ded124dd19
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|3023799007|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: XGcgREk4silhFit2EUCFpE5F5quKGNFEJJAyaidQ/mzUoclR24wMC56ye2K1QlVxSRn+R7sLeRRR4clk+d6PHYi4w9tyAbAp+XSCrkGlN+GRHFYAe6xzYebtM6QU0jTQ3RSVuIiXGukiOa7+vJS2NL96UGtFJo8fEtjzxeHUkBT6CDdW99Z94ZDlE9IGz2d9vMGGeJiNHtE/aL0MJTOhBMbz5ovfkBtFoTJlGB3GQoWi0qxfgRO0w/T/QCZbCDbrF584Jd65dY0Hu+yIbyCHGR+8CvcgHpCVueCl1mkDGuFeLbSR817DKjQ0TyKdeByIHDh5KwhgNtBT6vFoaIM6f/nvA0IBu70fBhMRztuZb7tFHNnDVskpmDM6g4Z8HdC9mBMO4+moZjeQZ6tG8L+9B5jrBW9+LQRxlDqwYANFCYniuq+3BPFWlQ3kCZTFksA6s9Oq7afaQS6uq2wTKkPMe65REcwPE0dNUv6sG899OJ4k8KVWuvUmlauzSHjxIebJ1S2gSxhtY1bGhKbMOXMkp/Z/oLL7MAIq9T2E31VfgUQ9EkVVdbLWzzXyCBF4PUJwq//QWXrbFBc5db58NydtThmP4QupQn2bRlsAsWjPiIVkY1KbIZIjwfhALpaF1FEfsphH8pArFz3P2OQi4anREdOsYWHR8kpPeRDJcodXeag=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(3023799007)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: UYVLoOrO2R6s1Yrjl5nRn9o4f6s8QCo2UOMeGoHDQ0fGT9vI46iQrFrDTX0nXIxnmJVnj1rzWBgbAhvcyygMk9a13UmKMn+ro8BquPU71yMxBaefQR2cSFIuuL83PK964Bt8mkmiUizLpAygzJvXgaOH1NorShxCiy8bTfvN8XT7tooRBIOTGAucZO7ni+OHDRFAlPya6DT1y61lqwDazQYKuw3kQi4MsNr7rUgC01BXEeau49tpvHunZ+qfKl3odPDlI16IO28ZVTH3zdkOoaoOt3C4PQ68XR/MYzhgwgqH2W2T/3HSaTjdVPiUluHko+z6MT8IXx/6Pyf5HXWVpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8423
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 76c334d9-ecbf-4b8e-dc51-08ded124b67d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|35042699022|23010399003|14060799003|376014|36860700016|18002099003|22082099003|3023799007|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: skalBxZZtlAMXHJmQAuuXNT0T3iwvkgeTaJT6Mzze4Fh+t60fnJZcd6SggeqaZgCeXudg/dttCjHTwy9bHOm8ydBCereEg2JAcjn49F4pKFvDTXzVPzrNwkuDLqRajDmUw1Tw/lKkwc7yH1kXSD/KA7tlmsYSEBJ+05Q7im1wwpe4jugGoMVPCvIIUM6ihy4dHqiYplyYuYoW3qkc8NRvL3JXdmPgqOXnYUXMmE0svySA92tEA5NaJkIdnZgjEBpumqW0Jf4b47c411Mj/psMFuNTkhU3M6/eX0zXR3O2lh4lAJ/y8p4YG6QXxML146r3+PEdAf3JjQ6XKZ1/jcyr8aKtvuuRwrvX7CTYP2S8opXj/bayso21hCuJPC9hAQhkHcEVU4T3vef02b4DhL6kCEpckjysL6aRXwGI8+K6Ixp4qYyGCVjGJmByLtEfjBPkj5mjOYxB3u7uC+me3NOvTC9lnFzJqqGtTSp8EOZiqxFGz1YAvTNSxLsF+J7l/GvDlTl2LD3hHFPdlIVCjzNT5cbja+kx16NWTse3B6M77Odzi5SnT3e+bj569HaRCFSZOfMucywBftEDeBLkbEH7bx9hTT4OJ3zLcy0PhlffVqHhQX8QW5HEE0PxRFpMXjzOrTmAlP80/0J4/kRystEWzqYy0UWhiCUm/Zx0ivkyeACYr+YH/Y40ihODttMq0g/AMkPDlLJzGqZvewdnnq2Mg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(35042699022)(23010399003)(14060799003)(376014)(36860700016)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fJmQW/VhKDUpMN/sr8L5CB6Bk5NlsRYzvirEcEH8Ct0b+NrYY6xvixNGHxV/+9PTgUTOsFAir1qcaXxLsn7Zq0ZzDysXF7Uj+ULorFFcv91zFsLZO1ZrCpv7MUtCxTAzEETI1wQZjoowsbWDJNcK6WQDgFy+LsyoppOhsQeORaCfbyKXt+f6qD+e//5GWZvCS5DgaCF9wfGIudZEPJ+LrEqVqBa3xVk2suZQwLp+T05mXvf+JMhIyAs6C0rJShTuOKRi0mqqGpmfvn1Tmw1DtpG3SKsnqFHz1HN2MZgQGzU8vMZdPk1wPAJ+L/NTZXwpsAmRavKbsaiIYTzOBOqnl+JsIFqEiPaSgIsQsIOF9jU+rfeQc9fMKHtTOds68ZON64rAa2c+pTARRHX9rh1jDOPgaIeE7DWjSefRiM2CnK1IXoS5LwUkTgYmyFBgKOc4
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:42:19.0574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c12f30b-23e1-4280-ba90-08ded124dd19
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5759
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



On 6/23/26 13:09, Boris Brezillon wrote:
> On Tue, 23 Jun 2026 12:17:51 +0100
> Akash Goel <akash.goel@arm.com> wrote:
> 
>> Hi Boris
>>
>> On 6/23/26 10:53, Boris Brezillon wrote:
>>> On Tue, 23 Jun 2026 10:24:13 +0100
>>> Akash Goel <akash.goel@arm.com> wrote:
>>>    
>>>> This commit fixes the NULL pointer dereference issue that would have
>>>> happened on the split of GPU mapping due to partial unmap of an evicted
>>>> BO. There is a logic to handle the partial unmap of huge pages when the
>>>> GPU mapping is split. That logic was not being completely skipped for
>>>> the VMA of an evicted BO and that resulted in a NPD possibility for the
>>>> 'bo->backing.pages' pointer, which is set to NULL when pages of a
>>>> BO are released on eviction.
>>>>   
>>
>>>>
>>>> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
>>>> Signed-off-by: Akash Goel <akash.goel@arm.com>
>>>> ---
>>>>    drivers/gpu/drm/panthor/panthor_mmu.c | 26 +++++++++++++-------------
>>>>    1 file changed, 13 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
>>>> index 31cc57029c12..285e7b9bc100 100644
>>>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>>>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>>>> @@ -2358,20 +2358,20 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
>>>>    	 */
>>>>    	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
>>>>    
>>>> -	/*
>>>> -	 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
>>>> -	 * so when a partial unmap is requested, we must first unmap the entire huge
>>>> -	 * page and then remap the difference between the huge page minus the requested
>>>> -	 * unmap region. Calculating the right start address and range for the expanded
>>>> -	 * unmap operation is the responsibility of the following function.
>>>> -	 */
>>>> -	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
>>>> -
>>>> -	/* If the range changed, we might have to lock a wider region to guarantee
>>>> -	 * atomicity. panthor_vm_lock_region() bails out early if the new region
>>>> -	 * is already part of the locked region, so no need to do this check here.
>>>> -	 */
>>>>    	if (!unmap_vma->evicted) {
>>>> +		/*
>>>> +		* ARM IOMMU page table management code disallows partial unmaps of huge pages,
>>>> +		* so when a partial unmap is requested, we must first unmap the entire huge
>>>> +		* page and then remap the difference between the huge page minus the requested
>>>> +		* unmap region. Calculating the right start address and range for the expanded
>>>> +		* unmap operation is the responsibility of the following function.
>>>> +		*/
>>>> +		unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
>>>> +
>>>> +		/* If the range changed, we might have to lock a wider region to guarantee
>>>> +		 * atomicity. panthor_vm_lock_region() bails out early if the new region
>>>> +		 * is already part of the locked region, so no need to do this check here.
>>>> +		 */
>>>>    		panthor_vm_lock_region(vm, unmap_start, unmap_range);
>>>>    		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
>>>>    	}
>>>
>>>
>>> I think we want something like that instead, so we can keep the
>>> 2M alignment for sparse mappings which go recently introduced.
>>>    
>>
>> Thanks for the suggestion. But sorry I didn't get it.
>>
>> I see that the patching of 'op->remap.next->gem.offset' would still be
>> done with my change.
>>
>> 	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
>>
>> 	if (!unmap_vma->evicted) {
>> 		unmap_hugepage_align(&op->remap, &unmap_start,
>>
>> IIUC, the 2M alignment is done to avoid a potential partial unmap of 2M
>> page. But if the VMA is in evicted state then already the unmap would
>> have happened for the whole virtual range covered by the VMA.
> 
> Nah, you're correct, the patching of the drm_gpuva is independent of the
> adjusted unmap range, so we should be good even if we don't adjust this
> range for evicted sparse mappings. Sorry for the noise.
> 

No worries. Thanks for confirming.

Since I had a closer look at the code, sorry I have another doubt.

Do we really need the call to 'panthor_fix_sparse_map_offset()' in the 
following code block ?. The 'op->remap.next->gem.offset' would already 
have been patched before.


	if (op->remap.next) {
		u64 addr = op->remap.next->va.addr;
		u64 size = unmap_start + unmap_range - op->remap.next->va.addr;

		if (!unmap_vma->evicted && size > 0) {
			struct drm_gpuva_op_map map_op = {
				.va.addr = addr,
				.va.range = size,
				.gem.obj = op->remap.next->gem.obj,
				.gem.offset = op->remap.next->gem.offset,
			};
			panthor_fix_sparse_map_offset(&map_op, unmap_vma->flags);

			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);


> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Sorry I realized that indentation needs to be fixed in my patch.

Will send a v2 and ad your r-b tag.


Best regards
Akash

