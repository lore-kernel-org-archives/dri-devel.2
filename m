Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7DDF8E499
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 02:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAB410E268;
	Fri, 17 Apr 2026 02:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HmaDJ70j";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324D110E267
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 02:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmNrsqIJmAvPKZ148anQln4XmAPhPZMZOREFplWbVMcF3d+Afm8i777jSYynSGAYjgCf/TYlETKjRPYI8Sziw3HhEJ3ar0p5cpi6URQuWEFQcFeN5XnlUbckiytFv6aRbvnHC75/AnnmlKiU81yg5hciswSsgrHpryiKOuDTuE42lwUpExYfz3G2wIuN4grQM+CBOoy0x85ppLwVBCJBo7R++48/UHpfWjjE/RFAMljxqS1nBiFKOu/XrJ4OJZx/gOwqshy6cJ8GnIU6MsA6P5FolkbIWdzyQq2IfaPmUHT1SBjVAEB9xjQu+lLheHuPuuPBmV8rwzVz9HsJE44zsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waQ/DBKqSKIGDhhNCTle8LHre+SaI7FpWU90SRDioss=;
 b=dw1FhYkgZBYORz3istDMDuwKhgVHzOzRGGIWbkowMGewDmU2tuYo9YeisafM7AzdbClYvVA5z50JK3vIIfgA9AWbAvfhhZS89cvbnTPPR8BQ2d4fYCBsFe16dkkywj3y/gsJlZE1MyUXGEl+Rt2V7X+FvuEXNH19H+SxVuT/q859nzt81YxlT2BuCNM6M7zEx3r2/V76gkAbw1bipUPaCfp2lc1f3nurVpJr6E/MC+HdndMGdx5TnARTKJb7XHl7Wa9gGEUjWvj/jGzjgO3pPilU3Z++V8N6YfrZgtPQpX+78US5/nI4eW8vh4YZ9i6+7CGS47onkczGTDmuI2tr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waQ/DBKqSKIGDhhNCTle8LHre+SaI7FpWU90SRDioss=;
 b=HmaDJ70jAS2/uF24Jo2QlTdDuVV/xieK7P+tRSxd7TZxtqQx5DvCyruWx8tXeTYYY0tpAB1ndXIz9vVgr5WKBoPXQOGtguPmuxSEtvfIl4cc5gpvSEZo2wzJgwlP6snoxnecjjZ/rjtddIFhmCHs8N4ggeMOdZtFM2kG4XpVgvcra1OXkv4NxjTpgOEcnZcg31vwKCza5g5jRi+6Mw3MkmmjXl7pHzGa5aBrIZJ/026t7kI+6svDHKMs2j84vBgdojPVSaC29ALPpOL3310NOAU6EffpageIX+PefwGKFYMKP2WGdupd2nGu05QMSSRHM/NwsBkXe+Gin1nBg/IYUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 02:07:24 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 02:07:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 11:07:20 +0900
Message-Id: <DHV2A5S9UKAU.3NWIH25WV9FP0@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/11] gpu: nova-core: vbios: simplify setup_falcon_data
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-9-705d30d16bba@nvidia.com>
 <7f0ef676-2663-435a-badd-f4106cabf66f@nvidia.com>
In-Reply-To: <7f0ef676-2663-435a-badd-f4106cabf66f@nvidia.com>
X-ClientProxiedBy: TY1PR01CA0200.jpnprd01.prod.outlook.com (2603:1096:403::30)
 To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c37e55-76df-4dc4-593c-08de9c2610b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: x/leL/OzTOUisnAzih10sQv6Vq6T37++GmbdMk1tNUyYD0PJ/GHafQX9hiJy1e6QvpuwsMHTNkAd3ylC3VRjf2V+g2ZwpBPs17kpiwMPtfLGzYVU/2LHFKJLrLP9ZaaypCnRm9DnEeZySxZF0j3ZyPzyrvs/O8xtgtWz7UMfk4WcPfj38px/o5Kdb+iH9gLsutTcSKqkH7dhgFeE+U0wz4gIfB0RWMNLkYtNBtPKZYWLatZEmDFA9+zJn9BT/ovSxws+nvjAKRsL43L3iI1MPvdnvxBxum5c6jvWe0jF1u7o+nTvwD/Iju5puAATMWdqcEY5wE0oe4SE8crNM5ep5zNi35WGI+qx90Sg0Z2ZH66frZufMy3ljA5kAeV53KXyX27tbtUC8wS39ptp0j3db3VR4/OY2+JjupHmAQsqaqfyVzXEkpyakrXtm+DlOQWB05bN8XVM5rI49/+X8qlaArxpPP8c3qw5Cf3OTTmkax/60VJGptynDhyZ89/qv95nKIftaUjeNi+N+kjltFBcWgsDs5noaxcUIfKdHiYIoDVvWhi0oVsmAIdEBDmylj+GbRTLOGjWwCA43X9oZxmWUdrqbgpbni6xeUllFW+NDebmADK34g5JrSK2Nxj/jODi1HPwuNkdbTPFYrQzdVZMlDit2hpKJ0j5iC10O+IcAHvY5idOKvfy7YgYuZd84ovjZHysErBijuvztErnZn5HBvunFowgQ9srMp8w7FNN+sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emgzZGVyNno3TUZhQjVJV3Y5bjl5OW9MRFNPbzROcWhkL1RYYTdkWWxoeDJV?=
 =?utf-8?B?cWFmZ3pGNks0T0IwNkNGb1l4RnJES1krZzBoOGhHSGJQRlR4T1RqNFFYZVd6?=
 =?utf-8?B?dUNXZFJvaER5VlN0aXNuQjJ6VG9FcU9iRE9RRXZNRmNtRVdFeXN0bUZuZEpY?=
 =?utf-8?B?QUFkYkQzSVNmOW9nN21TbVVsKytlbUtsRUtlWHFqNzRzOFMvUW1tOGxGOVFq?=
 =?utf-8?B?bHlJM1ZqUEE4VmZVMEhVRUtXc3hGUWtrVG42QW50OG11R00zdHVlb2J2ZWVt?=
 =?utf-8?B?d3pWZTNRbmJHMDRFSEdPa0VnSDIwUFBycVpvT1B0NVNVc0M3YmdQRjFsVHhO?=
 =?utf-8?B?S0JYWENlSUlrRHZLKzVDcFFSSkUxQW5mT29QenZTaDUrbWI0ZUMyUlMvaTBr?=
 =?utf-8?B?NGR5dUVKT1AwRWR6ZUpFS0doZjF1M3B3SmRSR2s0TWZ5OVl2Tk9IdndNL1VF?=
 =?utf-8?B?VmQvbFBwekMzSmx0a1k3czFPYXZVakczVG0zVWg2ZDAvcXlmaW5CQkRoWkx3?=
 =?utf-8?B?Z0pvUEtqTjBiTFovZldqd09hOTlTNUNjOUpVZEZnZ0RaYTdWVGxubU9ndGtB?=
 =?utf-8?B?Sjl2SUR0b2crQ001S0xKTThYNkd3ZlE2UTk4TjY4d0ZoWFdVdEdIZ3NwV0pF?=
 =?utf-8?B?UWwrcUtDZjRVMUNqWHpMUkpnZEthMkUvSWt6YlhXRHFnUW5PL2l5Y1NMWGZI?=
 =?utf-8?B?VDh4TXNvTEdaSDQrWDJsU3lYRzFiNkNWcFpsUG5zM2xjczI1eGsvb1lkdDlz?=
 =?utf-8?B?UnB3VzhpaUIxV0ZRS3NWS09KbFkvQmg2Y1V6bHAvdUp0MTN3cWdTUHA1TXZP?=
 =?utf-8?B?Z01ycXpLVCs1ODJUWDlwTW50RnluSGN6THkzSUwrVDgwWExIWVRsWGhkcm1v?=
 =?utf-8?B?YmJqdDZZTWlPcUoraksxM00wZGwrNlN0c0JTY3FVR2p1MzEybVk1bGlyWTNv?=
 =?utf-8?B?SllaZXd2d2xFU2tTM1JUTVcrSVVLclNhNmZCdjRER2lKdGl1L3ovVVV6aVZX?=
 =?utf-8?B?MURmdU5jM0xySWNhMHdqaTI2MGhEdXhJNlIyRHcrWGZQQlRueDdFNG5qL2dC?=
 =?utf-8?B?cXdEMmxwdTRZcUtFaW8zNGZyWm9TQXVzOFFNUk12U3RhWUxjb3lhTWI0bTZT?=
 =?utf-8?B?a2crNFhMbmZLWElkWUVqS2p4OWxxYjg0bXNJQ3VESEVzTjJKckQ3RU45OFd5?=
 =?utf-8?B?ZWZNSmRJUHk1WGJJb3B1RVREL250WjFoTmh3bDRWbitFclMrMDRiUWlxc2lO?=
 =?utf-8?B?bXNXeWVyME5LdGVZQ245SDNVSG9yMHJLbFBQQ0ZQZkVNaTByUUkvYW5RZlZw?=
 =?utf-8?B?TlZ3Z1pWbC9vWGhZQytGWEU4aTdGZWlQTVFFbHFSd2NiT09nQmRSUE52VFNY?=
 =?utf-8?B?T21SaXRaZ0tmZVZ0RkxaaWZKcnJTRzhSRjU0MEhFZzQzVWY2TFkvY0RTbG1r?=
 =?utf-8?B?L0sxMU1aT3FxaFAvZGRIcUk4aWd1N09SeDFGRktROFBzcDlpcmQ3dVBvZkFo?=
 =?utf-8?B?Q05Sc1Fsa3pzVm16OER0OC9rL0FQcnZNVzFONHhQTzBKQkFQMUgxVTRRbWRt?=
 =?utf-8?B?N013RmxzdkhwMmpEOVpoTHdZMWo2M3hwR2VySUNGQWdJdmd3d0FhVjg5anpS?=
 =?utf-8?B?ZkJMbGVnc1hmcSt6aEUxWWR5dW5XSkFUMnZNZVlQN2M1bStPUTZrT1AzZWlI?=
 =?utf-8?B?MEFVaHVnMVE5YWF5QzI0NTE2anMrSEVuK0x1Y2h4aGxoWmlpMTZOOWVibGRr?=
 =?utf-8?B?R1NRVmxsZFZwS0JEb21ya2sycGZ0VjlOLzJVREpWNWQ1c083b0ZHbDRZbE5T?=
 =?utf-8?B?R05RWnh0L0hNcmZtNEFFNHR5SUtZL2pZQkkxRjBxRGVRejRtQ3BjL0NseU1U?=
 =?utf-8?B?WllZVTNvTXZvTy95M1lIYTA0bFEraVJieTcwa3phb2pDajdSOHRrVzhtNzZC?=
 =?utf-8?B?ZGg2N1FHUy9XSXNTVVdnMUlXTnVnaTdGTHc0N3ZpMzVWdXF2RTNkRFZLeGJz?=
 =?utf-8?B?OTJvS1U0djlNN1FQdW42UWp6M2FBZW9ZR3BscW90NHhUY0hYeXAxYThPdEZt?=
 =?utf-8?B?cWJGdzAzTXdaY0FkK2tCQW5qd3dGczdtemlxYWVZNkZwZVgxRVkxZkVkM0ls?=
 =?utf-8?B?ZVUrYXRrVTNKLzc0MTlybHlGME5FUUUvU1RzYktpL3NxRGEyV0JjRDBvRFZa?=
 =?utf-8?B?aTh6M0xiSFVYR2h1UjliUG5VTFBYVkFoTExrd3BuOEtZTEZVZ1pXREtqQnVo?=
 =?utf-8?B?RkhpcHZmREFMelhXUlhudEk5UzZ1YUZCRm9ZZ1BWMzgxVG9laitNbEl4NlhW?=
 =?utf-8?B?b0VSL3dMRWFNMmRrci9kYTJJaHFKemRTeVZZZmllUjZzUXVpOGYwNUhndlgz?=
 =?utf-8?Q?iJRhQIzufFW+wl/hjp+sZ357EbLfPj45P5e43i8+nFoaR?=
X-MS-Exchange-AntiSpam-MessageData-1: x8q2+8jT6WhDVQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c37e55-76df-4dc4-593c-08de9c2610b1
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 02:07:24.6636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7VkAobIIvDGMt4rpxvdpfTLYRdP5FVUS4t6aR2I2wcBN7oBN61MPZtNr81k/XEIfdVi2AwB+wNC3OtKyc6lrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352
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

On Fri Apr 17, 2026 at 12:30 AM JST, Joel Fernandes wrote:
>
>
> On 4/14/2026 7:54 AM, Eliot Courtney wrote:
>> Remove `pmu_in_first_fwsec` and reorganize some code.
>
> The patch itself is a nice improvement but the patch commit message needs
> more description [1]. Perhaps some of Alex's comments from here? [2]
>
> [1]
> https://kernel.org/doc/html/v6.19/process/submitting-patches.html#describ=
e-changes
> [2] https://lore.kernel.org/all/DHSJTFBXA2EM.1I22OK3J5NPRL@nvidia.com/
>

Thanks for finding the links, you're right, I was being lazy. Will
update.
