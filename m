Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C471DC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 04:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D5110E74B;
	Mon, 28 Sep 2026 04:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ET6jL4cq";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC5710E74B;
 Mon, 28 Sep 2026 04:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEHDSzZuYSCzLwV1FMgp2IwrxomupMIJ+2FVRka9vVMCTJWGfTsPDhYJ4RW8l5BIlO2ndDxGtvuFOnvGD+N+LwWqUKMYd1pcbcE3uZ3rh5cKhPfr70TKY+sg2/cmG5DqUANAGnx368jwbWpp9FUeA2fCMTuUuCVOgm0Tl57wV3+Z0H9WrC1ZpNV/VQ005ARQWbFUeEzBoaq7gwVvfORCDHXTWEhGPPA0NYnLj76npXwKubIWUfGDQ9LIOf32ByiIiiNt+Dd0sUgsj/Y24/YAlBbnVPsLfYvP/pWlwB+QR+yEgYLhC9kA1i6mkjB4iojYje/rtplgEebKKxyIjTaEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxk98QiGAOogfQNH6QIKxyT23f2aIA8nZ2xjpTkQxhw=;
 b=bnAYH/l4Hhk6+8pg0Z/1qZGmJHODUVmD/TN+AoFUqrdDPLVR7VAI0AdwoN0670JdngZsPPu8P6Xp0kX2uzhrrsyHx6GKTfbYHycWuGURSehz8wL+v5eA25Qes11xKKtlXr7FFa+sN69zTPM9cATOgAmECrfvLnRuVQ71l8ZQO2n7rmkHhgpnhP/blL0w44wLueo9euTZbpiQqCTWZlV2/hFL81GL02X7+oXYhZeZ7zAK7RYaMHeZnWJhyu1LYwR17SwqIE/+ejDDAuem1Kb8PehWhjmjS1rPTbeOEaWcMenlCQRmFMw59lW36uXU07a2ZghEaNfYUTB8MPXGj6Z5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxk98QiGAOogfQNH6QIKxyT23f2aIA8nZ2xjpTkQxhw=;
 b=ET6jL4cqk9aR73t7x96IDiv74j7TuTwurA0SRQ2kKu4noCE51ndvSx8z9io9wFGrz59q7uMiZbtKisMbUiIe0JEVh8cBH2rVYWc3zh9BjQzZhvR0ypwDaCbRmrJ2i0PSwkWDmD3sE3qWo/Muy/CHF5wNHI3v/FMs3BZG2Ke6n03C69Q5Uq+II2f6trffS2NkDu6JRbyhazmXbVmQ3eMatUB5AAEFSxsVuLHeMy6dW/eS4qKstI6nVoY3MXwY7vcEn6Sh17pLTUN+fQbw+m70HoXEXgm1jtLbsHScwM1UBHU8NQY3IwnMF5ZI8yH+/6muj7PQQ1695L5zq5Sg3asqGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 04:14:26 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:14:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 13:14:22 +0900
Message-Id: <DLQNORHZOQ6G.2JUANOA4IVHLZ@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] drm: nova: Move VRAM BAR size query to GPU info
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <airlied@gmail.com>,
 <gary@garyguo.net>, <acourbot@nvidia.com>, <apopple@nvidia.com>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260927142258.1260711-1-dakr@kernel.org>
In-Reply-To: <20260927142258.1260711-1-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0287.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fa4a0e-c140-4283-f650-08df1d16fb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10070799003|10067099003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7zKCynmSsU7hr9/YNPoXVBN0D6CUsp3yl8pnwc9p+rP6PX1VkPvhkW2FQSp52VRz1zqUKs82tg7EBNab642/gPn1Lfhk5MHEG6fmJShYmWn2Jn9j1mJfuOBQLl0YLl5B5Buey3VXOVg98FdsDuWjaIDGV6v8KnROm9CiaHeTdSK+5cmxjHfwkNwZdqET5/adR54SJqeKtEfqD+3vXYmB6wIt/32mIBJzQmU1KsjkIuEfwCULMLMyH63o6hq3OAqja2cnXPI9YVxaMYk6fGQhhNVAZH8CyyDmtEHRH0JHElHJ/EBvICVkOQdy0qEqlJTRxLEvNNgz7CG7fs7MNJmPx3JKZMZm9TDNObr93pfSSPNZE/71Nj+2xL/islHBu+Apz3JTn1za6etyDkFc6HXRO+P9/aW9PLux3hfcogVCE0SQ57TmLaP1mSDw+Q3gVTT4ZkAvk+E9m2CKgiy5nzSXrw3LynP0cHKDy4A7XKzTSQITwC68egbO7xSCt/rVZHMaKdKnyZCu2yEz0fJkjnXsc6gM6kzhwXVlaM70FYj8MBZURYgDN2LqjYqPu6B+m86l+s0M3ia3yAINKXYyUAMklpfNf2q0JXFGrU9PdCZTluz9LJABdMGXAR11jpCFeqGZB4OpfWISEaBXc93luDxY99b6PCa06cZGW3zblxKYylk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10070799003)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzBmKzBEV3crUWpWdm0vNjd4OFFzclNyUFIyT0pPSS9jaS9QV0F2QmlkZFA3?=
 =?utf-8?B?ZlA3TlNGS2ZTQkRIUTNyRlhhZVJOZ2ZjSnpwOEppbU9PclZBK3Y1Q3ZlSUxn?=
 =?utf-8?B?YjZsN2JabDQ1L2lrWU5EeXZXeXZKZlZHMDJ4ek14WmpmU09uYlFMTDd3Ymxz?=
 =?utf-8?B?MDhsVDdlZXdwSmUrUDRIUk1jREczVEJvcTZZU0V6dkUvb2JXMThROWF1K1Ew?=
 =?utf-8?B?SC9PaHRiYlQraWFPUzY2WFpUQkdEbVk3eDh5Vk5YNEx0NlZuanc1M3hXbXJw?=
 =?utf-8?B?Y2JPV0NvSzJ5STF0YVV2QTRFMC9FT2llRkp2L294UktTNVQ2M1QwenFBb3lm?=
 =?utf-8?B?TUdJWm1GZThVa0VDaFNGRDN2engrc2VSM28zcTlyRENvSEExM0pzaE1OeUlK?=
 =?utf-8?B?RzRxR0Q4c2ZPc0l0NWlzTlA0QS9lelhmMTFNLy90bFNzRU94ODkycGVyYUF4?=
 =?utf-8?B?U3JYWWZURkpWWmxSSGQ3eG45Mm4wb2dGZTAwbTYxRGw1QmQ0ZGhzZThhMXd2?=
 =?utf-8?B?VE1iNGhjZjFJajhocEJRZWhjTGNDakJwL0FpSDE5dXZMb3k4amJlV3dtQ1Zt?=
 =?utf-8?B?TlJSVCt5NHpVNTNSMGtJNW4yblBzU1pnZFBmUmZvWnY4NndsSEVaL09SRjVx?=
 =?utf-8?B?UFBhMURlSCtpbTFQN3czT21GL1ROQkJFMEljdDZMWS9RQ2ZpaGpubVJBZHZr?=
 =?utf-8?B?d29pRXNPelQ4Z29DdnVwRE5SQ3UxR04yUGpKKzhtdENzd0VDbXpESDB6YUFk?=
 =?utf-8?B?Vm5qUFdDL1Y5cWNJcGJod01RSzIzODM4RTlzejlQam0xLzZFK25OTW1jbG1n?=
 =?utf-8?B?Um1ZbndvMzlBZ2dQZGZUTHRJNzN1cjlVSzRmdFJqUnZUZUgxcVIrd3gxK0Vw?=
 =?utf-8?B?Qm1ZY0JIMm9ZQ0pVTWhiazNWT09BVUlwdTg2Mjd3TUNFdlEzR1lscWZuWWdu?=
 =?utf-8?B?bVM3YVpkOCtwYmhXZnZ4OEIxWXc4WXYyQTdORjA5VzRYU0Y4dDdJUmlaTGpK?=
 =?utf-8?B?Q3NwdmpLSm5PK0ZrcGdhb1dnZjFGK3o0MHMzSE5FbllGYUJEelB0ZW8yQmtB?=
 =?utf-8?B?WGRkNFJMbitOZ3ZMcGtxVFd5cXJ3bXkyMk9Xd01lMkRPbi8xbDhtd1oxNDlu?=
 =?utf-8?B?MUdWUUxDaFEyNVEzaFlkeWVpeHpOT3NBbDlFaWI1SE5Td0t2bTcrSnNNMnFt?=
 =?utf-8?B?TTh4Uk1BcDJzeitrUXpTaEc0RThUUmt4MlJTeGZUT1M4SERTc2NRcFl0RWUy?=
 =?utf-8?B?aXlyNG5nRmN0Z3FzeDh5VmpZeEFUVWtGRUxGcHg4VzVPdU03bi91dzJ3VlA1?=
 =?utf-8?B?S0tkVDEvVDNjUWZkVTZuWmE4cDdWVzljN1B5UW1IOTdzT2piQTdLdkpaSEdw?=
 =?utf-8?B?dXphcXpzZ0tWRUdTYjFWUEJrQWFKSkdRMitNSW14Q2R0eXFaWUhxc0FpUThj?=
 =?utf-8?B?R0VOSFdOSWVFdGFsa2lWM1VUUHoxMDBzSEJpMlQra0sxSW0vdDExSnppUlZO?=
 =?utf-8?B?OUF4Ry81NStXQ0NkUDNPbWowVW92Y3NiOXZ6c2hjUVdTQmV0V09vOWxJZERx?=
 =?utf-8?B?Mi9lL1hHUjJpdllrc0FzVHNTbjJTMjhHVklWSTZwQTY1WEZza2FkM1RGOG5Z?=
 =?utf-8?B?UHNTVEpsVEtrQkJTMWJKcWdqK3ZMNUFrOFFTRDk4TTZLaTk1SGFTWS93Y3o0?=
 =?utf-8?B?NGdnS2VpbTVocTdGdkFmaDNSTWhkTXRPZnFOOGpxWWthUWUxVzNFRnVrN0Jz?=
 =?utf-8?B?K2krQ2t1d3VOZm9QbjJlNmJGUVN2TDUwUWUxV2RFYUd5Q3Fua25PQWNXVEdl?=
 =?utf-8?B?NGFRWDJVWjJqaEloZS9QWGJadmtNRnVrbktkTUp5SnVvc214dG9sdndyTzlF?=
 =?utf-8?B?bEpKR0FHeS9pcnN1K3UvSG9MbjExTUl1Q3phbXhCd2s5QXRsa0tnYURYLzBH?=
 =?utf-8?B?V1JIaDE2NGNiUml1dUtvWkdIZlR2WWJacWtocVljZ1FxeUxBZGlISWF6TEJB?=
 =?utf-8?B?QWROcmZpdGtmMndpMkZ1bjdueERlQTJSMEhWUWljQnhJU25PU2ExZWNsUHcv?=
 =?utf-8?B?RlZlVnd2UEpRNnNwb2JmYWRHZU5yZ3BObDh3TThLOXdVWVhTMGN3c00rSi80?=
 =?utf-8?B?UUs4OG5jNUZrRTJJSUFKeElRZGtPOUxERnV4ZHg1clIyaXZpcTEvWHo0MS9G?=
 =?utf-8?B?cEI2TG1jNXNoNTQwMHA4TnRXOW4xOTlPQlp5R1phWXJkUEV3RWxxb0Y5dFk4?=
 =?utf-8?B?YnV5c2VmQ2YycHRYNC9aWUF3WWdqazhvL3dNeEI4bE4xLysrMkNmaENKcXI2?=
 =?utf-8?B?T2lmVXhMOUpFVmN4VUYrMTQvUERsclFOc3FzTFBmL3E5Z21seUM1RmhvNnV2?=
 =?utf-8?Q?YkSLPViXZZ/XLaFi07iQhzs5s8/IQFv32PigmxZSsufJq?=
X-MS-Exchange-AntiSpam-MessageData-1: PYm/pTfgiVYaPA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fa4a0e-c140-4283-f650-08df1d16fb62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:14:25.5456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pd7wMCFybOz3C3oQ74Avuvam4Ah+3DeWvKRiBJsAs6f9RYE3LufAXMcIA2VCy8vTVjG8a2xF/UEZ818eGyu6fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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

On Sun Sep 27, 2026 at 11:22 PM JST, Danilo Krummrich wrote:
> Nova exposes static information via its DRM_IOCTL_NOVA_INFO ioctl, thus
> add vram_bar_size to struct drm_nova_info_gpu and remove
> DRM_IOCTL_NOVA_GETPARAM and its uAPI definitions.
>
> This breaks the uAPI, which is still fine at this point. It requires the
> corresponding drm-test change in [1].
>
> Link: https://gitlab.freedesktop.org/dakr/drm-test/-/merge_requests/2 [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

