Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA02C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303A610F158;
	Fri, 31 Jul 2026 06:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LD3tXXHN";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8077910F158
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbST50OfRRGau4/OrzP7isR/5rO/akUFCwYzefwY+YhaVTy17gLJKoCPXyneo+Za9iiTPvZCmqjoN0XyHs/xvW+l+FyU4bM51eUBrb/LTl29gwnIwLjon+nxQqezdy8z8T9juQUSkMWanNyu5QGoMeDy1UFfzNDLoN+lOGi9cNt5I+Sne5sdF4nNJTsVqWDmJ0VK2ueKH3KcyA5BTEbg4Yd/92dHPPDM62CJQQG2YR+V31RhgF2eMWt9QOZhpKn74rERhYtC1cTo+cEmCYvHLe9VpE3jzxXPethzxICC/UUZ/z7QvCACgZgDDiynP0HJxQGFcpeJLtMsUrrzNtB+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EY4P8jX/db7QARc0sf05oN9pYfZ0SaSDNk5aTPSNsE=;
 b=F+jpvr/KTB9LNaUWdVspcRQ02DW9WzB9SRbCHy+0nfDN3O7DKAZJHZ23TGT/tSLsGvtW4na7exaHtHsilk83VM3roj+Glo/UxPhkgeYkStmFG67B/RZxf3pPs86g6XeofEdl1iI11qLC3BT+f5AjIUqIYL99mzsJZf0iCeMSbjfkypAePuZrfPr63DuJJ+1f2J3Ac/AIMH9yurXZCa6UlRvgzRtJ68+M9p2KDLWd87mM34tprIzrm3IpeACZWhR5QUtciZQ966QlEASXV7CXxRCUkWXJcBTxe3FSJDDz9yFHW25N1rD4ZAOPexkUChSyG6HOCovkmkA8qdshL9d8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EY4P8jX/db7QARc0sf05oN9pYfZ0SaSDNk5aTPSNsE=;
 b=LD3tXXHNVnE5ZyKm5ppSGfz8fNKewG3bDuGgpGFBQZzyxTm9GUK5MMKUYs7XRIlE96p1yVbKtJHWgGWnbiAXKwpRyK5fTpTszu6yqdRn58OJiuvAwrWUcSBFad/lp4IRpm6TRJYFdy43jaNJAdXk+iyOuqzSgGmnw5Yw7IsbotgAoBZNaOYlV7d1y3A/Iim5LFokqh0jIwKQvWZizfrBBkIs6xZDF1VTfJRK3L+/FlbagWj6iD1AtcJRnhsnjNVIMVYjUzkoMtWtZ6BB7QIl19yuhusG4rr0bPiTAucoBA1a8GRI+o1UPQuH5sPb69xZnF3hoPFoVYRDC5i9hFAqQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.15; Fri, 31 Jul 2026 06:04:57 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:04:57 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dri-devel@lists.freedesktop.org
Cc: nova-gpu@lists.linux.dev, jhubbard@nvidia.com,
 Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 0/2] Add libdrm support for auxbus devices
Date: Fri, 31 Jul 2026 16:04:16 +1000
Message-ID: <20260731060416.1400253-4-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731060416.1400253-1-apopple@nvidia.com>
References: <20260731060416.1400253-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8P282CA0005.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::10) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 324a0725-3271-4de8-ecdf-08deeec9a5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: CyX+9qB0khvudbrjN2uJsXICwW+/o8skenv1vNhppR4YunHWaD2p1l/2figpP4EVLRvHbM9T/XpijGDxRX2jfw5jcRfxWvtzls6nTMbF7pO2/71mCgdwPxSu714ynb+RaNr8a0GNcqBASN2l1xe6fkc0TY569t2NltAhiE4Oj29twAvAL3Qe/vCv7qfSfnuUh8Yb++HxHLF/g1GL3VH+Yvldh9+GFRS3xw/6XUrfZ0qX689vbB4tDKyr5pOpWJHNPbdaHQSOxGSv+ytJqD/zuMnl0p/L69mlpPFaUcqc1Io8Kup2foP+K81Ss3jC7ySLiwzFbXKZmgWgVzgo7gLFIaqrDHyaBvnXRcKlfbTzMw+es1JAWIghVPfW9nxAL9grDRjTJST6d4MKcOxwE3X9AvSL/SXCeQ5Vv99DZsSd913ka2KZzwabavz00lob77LYtiBrPhSUD+MHSNWlbypjDJZT0Ldcb2zOECPNy8k+eHYJxAMSqhTsr8KqwygpJxc8qDINHIxwcYAbx0RyAwuCrL3o6SWMRF6QXkxOkCLxMn0XQNwUNejJP6U8z9Xq5/Y6IERRIzp7yTUqIxTgSsuSQvQ47oMG0XXlA4anJqW/8WTif44OLOFzzNGJa9UBRhRAVVU17+QCxOX8Qlp2CneLmjhDaSBm0RnDNZfTTkEvP7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWYPVemTht+nUexuPPlQlrdzE8g0ZZHhxcQH2b1iOiMZ3eVsEMnVgSuacYwK?=
 =?us-ascii?Q?Qgu1HlrPNgvLBkOCasiigcYgj0PTbtE0G0WowOI1Z7RJdiJ/6wDt0iAfZxRv?=
 =?us-ascii?Q?wQBbec6SFK2rZiUG+U/VV6UwyCcZV6Gm5m/MkVANVyMg6ePPSA0rlKbAezFa?=
 =?us-ascii?Q?4rwu+2d5tTMbqaja59SJyz+BKr9SWSW9dqcff6dT4/iZK4YBuzJEWU1R56FN?=
 =?us-ascii?Q?cI2/ruyBUO+M/f10hedG2/85CLk22PyBTu2IUQf37mKvJ3QB+cRIlaf7xn/Z?=
 =?us-ascii?Q?SLkEzjzgzkigQ3PxuAQIfFPuQnIj2zR33/MxC9uKXSBP+3uiNo320atvPp2c?=
 =?us-ascii?Q?t7NztsWYzMJGuIQblCFEf3vSihiRmvp054PI41QB6VPfJM5f84SQA0skm3tn?=
 =?us-ascii?Q?yhhk8JZYZSe7bhU21RIjM7Yr6pQ1+xWLppm6htwrgfd3EmgHIYgCT2NT59bK?=
 =?us-ascii?Q?dwMQ51LX2cWKGIXufGzOiUpsIdVGHI9CFSGSNn6GW4MjSurO0/G3IfMio62d?=
 =?us-ascii?Q?nFCMOMChoO0rSoCusCo1+v5qZWXWemelqs8glJE6HPn6VoKvo4nCD9x/I9e3?=
 =?us-ascii?Q?sQ7iUjqHDmolKVhb50m4C9xOhn0JCvJmny0j4R9oIipmrW2Diz8FukjhT0lN?=
 =?us-ascii?Q?xw5CfNFz56OEccli8yr6sGj8cMQQDzyLTfYCGO5c8jFE8IlLEoq+k5HW0aTn?=
 =?us-ascii?Q?tbBx5eXYdLHyB0ck6WyYjmS9yPWr1l2HLoMYd0T0U29k7AeoSfoKlCyWXQh1?=
 =?us-ascii?Q?CkO3/c8eEcGnEr+zWSs7JZwpJM21eqdG/8jQnsz9RAP5GZ7Tg8h4jZpmffA8?=
 =?us-ascii?Q?mTOKaGUdm4zKtItXjWfjoETCTJJNsY7KDW7UU6cL0uWbPV2J2Nn4Z8vPQsfP?=
 =?us-ascii?Q?lY6clank4khuKA5AsQQM77qCfHu6nSAfe/hVhH2+AbTMIUwItadY4biwygSX?=
 =?us-ascii?Q?D9c8nO9qJf2JR/acm5erFwiLyOoU0FzqEtb7RpIuhRUSBJ702duKHUDoVXud?=
 =?us-ascii?Q?KiM1aQU0SjaUxU0t4n7bBKAsCzWZt5bymz50jcMssnCcD1ZraBYPKWtgYuPY?=
 =?us-ascii?Q?Ez+UZduU9MFHjmCclnbWo+qpyoSwxR1OlX4x7yboDu/aIZiHbT/GdaHWX7ca?=
 =?us-ascii?Q?iNftWuG8sa2M1sESFrWYWIMkOK7c+YPbnt2KGWc08GP/ZnAiIYeDXyY/ziHF?=
 =?us-ascii?Q?aJ8E8jE0MsNO59xxcJ5WKFMwGk8loaI0D4SWeMSAcbAdqAdgkWcVkJ1i8mm5?=
 =?us-ascii?Q?RfchOPYCQs8cg4BHQgqkroGBSfXbf0ZCpfwEIQX6wjMQqVIYjE3GvlIWA5tZ?=
 =?us-ascii?Q?euD0JjWQTXa1WKoE/JnHRmjkbjGDyFbczpJhubKy6m/6TEOIBPw5iN+KarIF?=
 =?us-ascii?Q?wPbzZe1eGJxdL4rLz3IgH9/ZtLllGwlTQD5mF2kl/G2vxg5eeV6wa6qmUVdK?=
 =?us-ascii?Q?x6IlpcwJoAxPXpeax2IGPVKMJaKPx5TE0gIrbKSPMcFP+rKgMoFvjk5rYgeN?=
 =?us-ascii?Q?tFmbZlfjmcY1GRI5HVJQyD486SyBIcxRszkYoljyoyFqo5x6YDPsFADkL4s8?=
 =?us-ascii?Q?3LkJR2gC6W8RYbcXYAZAKS4tD4yE+Ix0IyVoZYTykLs15qq17Y3OcFf+09n/?=
 =?us-ascii?Q?RlUvaqmUoyNwPpRG9MFXtGv0cmHYH0PoOeJxcheVQ3eKmpcFOqjB5zVvx2l2?=
 =?us-ascii?Q?nH+3y6hedmGyClTGNGBwu70rnuO/zHwQOXXujtn5FuqnRMuw/ETPbIF5ytVq?=
 =?us-ascii?Q?obWJSqSOiw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324a0725-3271-4de8-ecdf-08deeec9a5c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:04:57.1614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTfebDQ4rqJuXFYCL18GXnc0GJos3JfuKT/cHpCv/sfz/a6kOctMwDG2uW5krfJ9B/Fq+DuLljxzQWougX5bBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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

The new Nova[1] NVIDIA GPU driver exposes GPUs as logical devices on an
auxbus. Currently libdrm doesn't support auxbus, so it ignores Nova GPUs
during enumeration. This adds support for devices on an auxbus.

Rather than follow the lead of virtio and resolve the logical auxbus device
back to the physical PCI device, we add a new bus type and associated parser.
This is because in future it's a single physical GPU may present multiple auxbus
devices, so it needs to be possible to resolve individual devices even if they
share the same parent GPU.

[1] - https://rust-for-linux.com/nova-gpu-driver

Alistair Popple (2):
  xf86drm: Pass PCI path rather than maj/min when parsing sysfs files
  xf86drm: Expose auxiliary bus GPUs as DRM_BUS_AUXILIARY

 xf86drm.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++-------
 xf86drm.h |  12 +++++
 2 files changed, 130 insertions(+), 17 deletions(-)

-- 
2.54.0

