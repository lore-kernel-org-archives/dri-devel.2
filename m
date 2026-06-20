Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7AFCD4F26
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 14:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCB710E206;
	Sat, 20 Jun 2026 14:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tefSJnrA";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA3810E206
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 14:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzPAtyF040aWBgD0vjIjFhx1l1U5iB12B84yv53i0tje0O/J2tAqoNjkDb41YopM02e38OXnQ0EdEVfIrSLSurLKh/5O+4nAPvJiRKEZbx0cYzq/bgvCr5O6EpIg7XlHVPIMUGnUWFduGv+zrJzvKpy0nV9QdbEKQKtFG1oKdB4nGHaZiSUc6bJnqT1Yw+/hnoXHgIYapghcf3GqDnxtZq6cd9RokoLP7GDS7R9W0Z3kta2eYYi34wUtMsYC83VGqp2gym2Tjx6r9gcYHW48vzSMMXPuFetYYP4opMF5S/Cr9U36pZYOMzEosIXSeJd+/RyVus/iZN2BkNQ5f0S9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaqlayg/wDxPKf3wHGWHQV720/2RkaIPhG5Y4cAsRgM=;
 b=qw79FAqj8Qnl9hK8UMur8l0upq+i0RH0y8IgpTGFLpn3tMx2qe4kdGYQVDeSAkr4+K+X+I+6Vl3cu+QrUm6ge2LpzKtG80joKFJL/5NEhnLYK5qm4Sa3JPsPXLlz5Tod2dTLNnDP4zbTxLICfLIY+UZGqNykhIapZi8kqd9yCJ6JJgfQYeuPhVpgmHBg7fgthNvwQPZKguIitxLXFPxrRW6BAIdzoZgGGQodFCr5sVMEeG0dNqGXV5LyAGy4bHAjSsf0pLJBJK8CkArOxus9yo3gaBIgfc1T/ljsUhjkDFjpbuSFcpcWS4rOB6Zh3wuwNsyu49TkxqZNFdfEhqmH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaqlayg/wDxPKf3wHGWHQV720/2RkaIPhG5Y4cAsRgM=;
 b=tefSJnrA9175s/im7buzl9I3orolCkZwxe5Qs6LX2qUTO0k/XdeUaC7WIiVK7FO4egF8tNJqQQy3iIhSOZXF1YmztePtKkrUGqwocRbEvl/Dm5sfA1oPWZCfURCIDGvzO2rlWvA7SS/8ejL9L6g7tRPMHAJoOkNL6qUVReQ6XkhuyLx0HjCLmNlviwQQcZQJ2qZinc5OyMMRNLfDBp32KBrvwkzqiQ6QcRqIF1QT4B3/2MQhMOSskOe4RJLl6UyYAe1mn3fLeqkmtVvq5bVZBNolnvs1/iQ3AsqeJn5xR9TfEATPt+u1IsVSZ60t7ebuG2ZOi52b68Rgf7SH23VCUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 14:08:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Sat, 20 Jun 2026
 14:08:39 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 23:08:35 +0900
Message-Id: <DJDXP9BBZB95.1TWARVNHKL0WE@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 01/13] gpu: nova-core: fsp: limit FSP receive message
 allocation size
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-1-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-1-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: TYCP301CA0078.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc5798b-22d1-4da7-81e0-08deced56d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: o5+ZMLNkonIZvGOfH2pZQBJ3asQ0dzleu9hrNAZP9qDLR3ffRXE+zlkzwLP1xCZ9CKGJjwOKpC47SzgpRwKmL9a2pegI6WWFgVy+PNWyzwGWDYhd+K3Emod3klqnFFe7pOExe1FmR/GvPO3OUtxIMkwzkS7WmnS/Y+f7RMI9G6ANLD3+5WMTmaLmhV9LqiIep+WHtBq6w0VU8FHXkimFm5IcSR4Zp4NU6X9cYNpSmr+FWXKPMTjC3aS5h1NHWrEfSAMNjcdoC9wf6GyPIOU+KrbPUzBmzR2VhT+23qV9/HR9J9Pl/pJsLTf/2jUz/vXdVEMBJBdH+fDUsMtNRAzb6CI7h97UoikbRkUyOPD7nXVYsoRlLI950pJwWNH7G6gPAJzGgSLPm9HvsUzs/UEq8dU65PjKoTiBblXlUAr9ic3ztutT1l3sR6eeUCLXuMZxwtQ0dHn9F9aoyCn7Xt80XWYrAT/ga4c9rL0rLZUA/9CTbF+T4pKBMqZK0hmfmXIKfE4ujQVq8SyAxUCqNPrUgLeyEevJ3/Wvz/9I1ra2ImH2YzVbCc0T6vo66zj5beQQHcckDt7Ds7UhG485j1801rH8VCA3E3Zq5mw0/wMesJPl3k1WoIciOHrQgzJnLYz/aOUteJryKnDhcsvBS9udiD9Y8RX9UXHDdQKl/69Sipc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRRNjZVaTB4amduZ2E1Vm5rK1VScm9mSHZXQjdacTZ0WjdmVFlGRkRvTFZB?=
 =?utf-8?B?Y1RFUjNPb3hNU09JbmtQWVNyL1Q1a28zaGpJbGE5YWdtQitRcjA0TC92NFVS?=
 =?utf-8?B?Sy9hWWZvcEZMTkZkTytsN3NMMm5ZOVQ2dTN0R1Y3VzlBWGJWSXdqa0tjK012?=
 =?utf-8?B?eE03bmk0YnFwUTAxejBSbjhTMXlOSTkxT29lWStIQ2syS0lxVXZUcGVjZzZR?=
 =?utf-8?B?Sm1udUdsUDltaVkzYUQ5Qi91blppYTRQRDlqd0t4QWRvNnNEcGpLcXI0TFVo?=
 =?utf-8?B?NXNUczR1Q3RlVWkwUG13anZVd1gzZEYrMkRLS3FVekdZbTM5ZmFrVkFRNWp0?=
 =?utf-8?B?ZW9lb2M1TnV0dFRpZEJWaXM3akVPRktJL0o0R25JeEIvS1pNNXJPQmxLOHVO?=
 =?utf-8?B?OFVHekFLUFMvSy93YUl4M3ROZldyUUFkNDFhQXNFd1JRRmJSNzRjVlNmL1Fv?=
 =?utf-8?B?OTdOZGVYcE1CaDhqa3RZd2l4c3A0eVd4Y3VxSHlwcVowYW0rWTZXcGJRS3Br?=
 =?utf-8?B?K2RSQ215R01tc2puYXBLSmw2TUs4WS8vck1MMUpLbTVXK1BTWHBhL3ZZd2U4?=
 =?utf-8?B?ZnRERG40M3Q1NTlJTlpQa3Z1bURybEl0OWUrWWNJNG8wTGtUcHplaFFIbHBE?=
 =?utf-8?B?QkIyQk9qSTRLYzE4YmoxRk5jYm5zbUo4V0dHM29mL1A3YXN5bllWQ1hydVlE?=
 =?utf-8?B?eUlOL21TaXFxeXFFWXRKM2RYbEFFbHlOck90U3E0T1ZHUjVCYjJZclVYNFZU?=
 =?utf-8?B?ZkRqSUZ0MUp6aHZTWWl0Qm1RbXE1QUtEa3B4Tk8wb2JxRjduT2VMWFZVRTNO?=
 =?utf-8?B?R3NlK2dzekJDMFVPNW9UdDVnc2NadFhZb01sdlk2VEFsRUc5ZHRLdk52dTlm?=
 =?utf-8?B?TmNTWkV6Qisrcjl4MmJ4ejMrMTJKVFMrUWQ0bk5LWGpZMGd4WS81dFowbUFL?=
 =?utf-8?B?K0dJOGJyLy9lbXE2N2szZXJyVEM2d3RYZWZHd3ZUNXZDVWd5OGJ5ZUw0MWFi?=
 =?utf-8?B?WVV1cGpBSFJDdnoxbjc1dUFkNnUrSkpoVFZBZzBuSy9reEpEM3JPZlVPUExI?=
 =?utf-8?B?SDdkaFpzblUxREcyWVJQQmV2K2I2UndTT0l5UlhiTndSb3dib0lWN05JeVZS?=
 =?utf-8?B?Q01tbUE2U2JudHFEOXhiUk9rb0wxS0E1UGFCZVN0OU5PUy9ZaE9GV3BBYVRp?=
 =?utf-8?B?bG8wREpqeWNqSDd0SUloUGxOLy84ck1aUW1OQldzWkNKdHMwZ0oxVGE2cmxv?=
 =?utf-8?B?eGVESWp1NWpRZ3hJYVE3TDcreU1kQ3F2S21hdzFFMVRwWTUxSUZ2eGVuWWZ2?=
 =?utf-8?B?SW93TWtuWmNnN1U4aFdLTkx2cWtEUFdRanJ1WFQ2aFViOE4yT25xRm1KSGtk?=
 =?utf-8?B?ckFRNlVQUjRLY2VTZFlEVWFFTkxXQzdVcXlyeUV1N01CZzRIYXdFRGZodGI5?=
 =?utf-8?B?dWh6VG5WT0tOK2N0bTNSQjVOc1BYbnJ2b05hYkVEU3BNaWZpTHU5TmpDWklD?=
 =?utf-8?B?WnNSMlFuSXBBdWZTYWdrWkRUSHJoQUI3a2dsODkrZHp2ODlyazA3R0VWVHJ3?=
 =?utf-8?B?WC94VmlBZEE0V0R1M2crbzRMdmhiNVgzb3hIVzdpZWxxQTlMUW1uaGk4L2Z3?=
 =?utf-8?B?cnFmUDgyMkljOE5vWGlub0dld1JHdlJOUlZYV0ZxYmRtK0lSUmp4cVJ4VlZG?=
 =?utf-8?B?NVVOYW8zbUFmWWhXbzBXdTJHU1RLMmJIY2F6eWxybFI3NmtRWGcxYnduUUxZ?=
 =?utf-8?B?QVpoK3JmS1JnRnpwSnE0UVl3VmdjQXpTRHNKTzhXZkpiR213ZGNKZHcwZG9t?=
 =?utf-8?B?b0g4a2ZDUWVXaWl3ZGV3bHJVVG1xTXV5U0VlSVZ3djZpVVlEOXMvbGRoUFda?=
 =?utf-8?B?NloxdmgwVWJrT0pHL0ZlYk9vZFFIWHQ3bHlxSjJTRUFScDJBRUE0TXdZMHRZ?=
 =?utf-8?B?KzlJSWtZeFJZVkJkdm9PcDRaTENlVi9DNVVDSkZDa0ZCZzFkNGhBY2x0dGxC?=
 =?utf-8?B?Ylcya2l3Tmx2bDV0Z0RGcWxmRFZJUkpYdDVNL3ZEa1pvYTRnZmhSaDcyUktR?=
 =?utf-8?B?TkUvbWNUb1p3bEppSms2d3FOWngrY3BkSm5LUURrUUlWWjNGb2p2K0pKUDEz?=
 =?utf-8?B?QnpobGJsaVo2dm5BcmlFd3dkM0lmcjc0Z0wzMTE4Q1oxcjFPaTNNMXoyaEZH?=
 =?utf-8?B?RHU3RWJDM0NrSGQ5OVhxUmk5c0dOeU8vZ1N2dG9nSmZjejR4QndqNHNyTmZt?=
 =?utf-8?B?cXoyWks1UXMvbTljbkt5NnR3Y0dPVDNPYXhlZlY5ci9meFRkV0Z3b3BYY2Iw?=
 =?utf-8?B?bmFiclBRSmpHeGw2Y3BTZTgwNlpGWjlEUFZXRWR3a1VvNCtxeWU0UHkxNlUx?=
 =?utf-8?Q?ri+e/sXRqw8HO1VD6XhFgNtT/Q9+yDJyAZ2XO2B8uH4Ak?=
X-MS-Exchange-AntiSpam-MessageData-1: SX4G15oiUzrRlw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc5798b-22d1-4da7-81e0-08deced56d4d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 14:08:39.2116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaJegV4JvaNYSPr6I/rN7QJwBkq4qgxuqWjIPeWu2pal1C5u4KnVb9qTdsAe9patuy8iep5SGHejV9aCDPSWKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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

On Mon Jun 15, 2026 at 11:40 PM JST, Eliot Courtney wrote:
> Currently, the FSP receive message code will try to allocate whatever
> was sent without checking it at all. But the actual size allowed is
> limited to 1024 anyway, so discard any messages over that size as bogus.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon/fsp.rs | 36 ++++++++++++++++++++++++-------=
-----
>  1 file changed, 24 insertions(+), 12 deletions(-)

This patch looks like it does two things:

- The size check, which is described in the commit log,
- Reset the message queue pointers even in case of failure, which is not.

That second item also makes the diff a bit difficult to read. Could you
split the reset-on-error behavior into its own patch?
