Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E64CA9EBD
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1CD310E19C;
	Wed, 14 Oct 2026 03:59:08 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB5610E19C;
 Wed, 14 Oct 2026 03:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx+RHwTq76701hqavMFGfwz2WB2yT70yOt1mz8s5cdXWjMfQNOKICAQMeUXQZmL91TR2UeAQgdzYXjRnSDbHCrvNduC33JnkxF45n5CsqfXfGTwbh/UpPhgeqJp87QadURLe6DlYIqD7ttNqoDrbLtOy6Wk6E47zAJDLx/APYOFaKde9KSy3D2GVZEYaod2sC9pRg0YFwDN1jUXELIa2XzLNfycgnrcZroo5nYrw+o5DXhFv1dQYo/6hRmgrRsmN8DoGsyHQzocIiUAxkZddLjKdDSMf2+a80fTLvzLmAyLsS03TIoJi39r2TZ0cVnetCDWcpPJM9NGZnv3Mi8Bhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pfyw94ZAdQGw40R+dkGblS+m44vZSmVooQlohlbLGA4=;
 b=hyWsvP11RBdk6dELtr4ZQVuFOdfl80DGPteEAImAzv/ayJrnVj/3XryTdrsn+VEjI1BuD2KQGBddbydpOgmVaqWHqHHDgxheb9oR0dEUAh5oAOFv4JKBcosZFHUXeB5PVDJL7DkAsJAVRIoJuAg904hPuc65lkYyB2a11DnzWWdDdf3/CIAjPsNqvvZyFuR+REbkVXa2wugIw8iQTNjP98AavDrXDDI2+tW8MSVb5sfeYSW8XwaZP1rjin8OkwFUTWncYQQcCJcGHOzWrcCz83mBL1L72tZIBH/2HW8gLIkDcd39Ol1i98A6nQVDCVt7x3Ai/CNI4Oc9kj3LGB3Bng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfyw94ZAdQGw40R+dkGblS+m44vZSmVooQlohlbLGA4=;
 b=B+DSMIo6344kArZuZtC6n+IcrJOkEWkkRq5DVeA4VMyvl+mh45dIoLz73ZCcldDSCWbPnxSrnWZC/dD8sKfThPvk7kSZA2vDaq94tTqjcEMzMiJs4G8Q97dtA6AL3GDX6gfmBeseTJYlWjZSsHZNhtG+KoNUUgt4VK+PZL4if8kiIIFaEVM0d8ZXO6nUK6iiC0PnX5aexcpiUuaKLJvjC6emYnn3ZsJ1iP7tyhQF5RHceCWOYzRmlzRhJjQiUlUGQHL1SwvKSKrrj1oqTlmOlkDT6lwKK3WEdRt7NuxqOrSwjeIbqGvN7/fdhkdbYgGaamUg0aSf8I8om+L4nk6yTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 03:58:59 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 03:58:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 12:58:54 +0900
Message-Id: <DM49DNAJFYZT.3SWL8YOY00ITB@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 10/10] gpu: nova-core: gsp: add `rpc` to RPC message
 send/receive methods
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
 <20261009-cmdq-rpc-v4-10-c9ab8de1d3f2@nvidia.com>
In-Reply-To: <20261009-cmdq-rpc-v4-10-c9ab8de1d3f2@nvidia.com>
X-ClientProxiedBy: TYWP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: edf58fb1-ff31-41f5-2859-08df29a779f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|7416014|366016|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yfyjTRm0xohROjvwZ/eEKBdv2VmwQffw41ttQ0DF1ME++J7kMsu7OJrq2asrVxrYZ5pzqACpoya8Q4rEzO5e2a4lXezSsIjZl72We34wTXR5c/wuu7M1FDDG4F4JkDPP5yUL0oMUdS/sed73IO9f8U3m9lXnedSTx9PV+uCxvwM10SW54iIkssbBkCKqc1dnNxkjMfMeJqAUCX8adpkgqEI0JnEILXqMC70qYZjpOrcgsZmulpkUP0DS0hpBz+j6qaOVTcsl7UPbsJhWkeRp9TWvbxkUHSAqbAcd/XCBj9KXnLVWFwFVLjSIkWH2ijwoS/q9d2wA7zmCcjSuJsge5L/Foj0K8fOSiGm64MIy1+XZ4Uihf6kSndhi6Goj6f/VrjwLuzFnD0777tqLYpUHuSCtqxA28BhodRLA34Nx5pj23LvXCFfx9rntqkCyAZJ7qUmPvYFHwG/3a47+qmSRg2UvtNCtfeA5lgQey1wOm2cNAqfAJbPpugeG31dN413nBkTbpNDTtZJBTJHkVjRDL85Itr+Pm3m+AAtSt3QL0XKDYOKOl2FAaDpQV9Cj45uZKylQMx7MWLQDkKmoNnS1feMc7woBl2awR4+oMVhTp2NWjaFl5pRR65h6D6hLbfYNRLPbhiFs/I72h87Z4XVp9auOTVGBgvjSqXUIiMWKTuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2NlRC9SN3dqWkFCaVlhbzIydzk3d0x6ZENjNS9mcUxtYm5GcVRZRlNXczFt?=
 =?utf-8?B?ckd6ZDFta1kyeW5DcDBnWnk0cW81UWlaUUxRc2xzdTdTb3pxVGlqbHNjRmRY?=
 =?utf-8?B?RHgrbURuY3hzL0pzbVpGV0wyUWxJKzQ4SnhOczNIMmtXdjJXb2MwbkRBaUF5?=
 =?utf-8?B?UWJCbXZFYWdHb3RxRWQ3VGcrNi9NWjR0Y3RZR3Y5d3dLWWhjcjVhSWZ5RVRp?=
 =?utf-8?B?bllTa3JmeFBXbzBJVkZMQVRwdzEwOVRsdm1HWWhpVEFzV3doREozRWxSVGx3?=
 =?utf-8?B?RmQxZ1UrYTdxMkE3OVRyR3kvaEE5OW1JQTFzVVF4WE9ZMHNZZU1OVzdHdWJN?=
 =?utf-8?B?c283VS9UaDltVW11TWFjV1NCS1ZQa3ZCV3Z6R2l5dFkrZXU2dTQ1UDdTSWZT?=
 =?utf-8?B?TFRwTEx1S1RXbVpIZE9MaGk5S01JdDRrSTdoVjVLQnZYSEJzcml3bTcyWWJ6?=
 =?utf-8?B?dTJKSDFuUnNPcWNPcW1xVk5NeXR2Rnd5ZnIxRktuaUtqQlMrbGozczdJK09H?=
 =?utf-8?B?MEViVDZsdUIrTENiOFYxK2gzN3JBTEgxL202UWlDSG1ES2Z0N1BmTUhuemRy?=
 =?utf-8?B?L1diSlRSTVVzT01Udm1uV0FBYXl2dEszSGtCSnVhRTdJNHlWUElsRk16Nnlp?=
 =?utf-8?B?Z2N1TEJ1cjJES0w5WkYwNTVzZnk2RzlpUU45UGVwMTU1aGRveWhuQ2p2Ni9p?=
 =?utf-8?B?MEtoRjNoM2JFU0RrUFdJNndMM2R0V0xNSkZQQWRWdkJlS0l5cWN1RERMV3hZ?=
 =?utf-8?B?RFA2QzBKa1M2TGhxK1VqTWZSSmVkc1hHYkIzVFZxMHZvVEJQQWJzNCtydUdV?=
 =?utf-8?B?c2JVejRoODAvRXVtYkVhSzl5Z1krbDRmWTJsU21HVksrOURoVkZsY08rZ0ZS?=
 =?utf-8?B?dm9mcmdhcmVqY0Fza0dnY05nRE9xUG5IUUs5aEVCMG5PRXc2UG1HaFN1bHhm?=
 =?utf-8?B?cGlJdStxZ0JkTnZJOXFlZU5ibE92d3ZwamVqd1ljOTJvOHpjdy9jcDVIRUlx?=
 =?utf-8?B?N3RjMXZXQkpvZytmYys2L1loV09nUTBrSWhqUUdqUXJDMVlYTGR3VmdnR3c2?=
 =?utf-8?B?L0FGM1RUaEZTdWJQdiswbUhWeUYyV3crKzBjdCszbTVRTzN3SlNIaFJIUVh3?=
 =?utf-8?B?M1lCcktiV1lrWVBNbGgwdXd1a3ptMjhROHpIT3htMkwxV0dNamNoNEx1VGFx?=
 =?utf-8?B?T1pzTUl6KzB0K0N3WHdpTmdIdGxQTTNzTGN0bE1tSjhPc0c3T3RkaUdhVGNP?=
 =?utf-8?B?MmZ4c2RueTZiaUlWeUUxUk5nbW5NZEs0Y0laVTdZalZidkhGWi8vRVpobGox?=
 =?utf-8?B?T1dYNEgxMVJZUXYzVGYyUVFSUWN0eWI0bUVMRzJDUjRnYW9LY0RhUk4rK2F2?=
 =?utf-8?B?VHB0Zmo0bFg0ZmhiSDFqUDl2cUZIeWtaQmM4OGoxTWlnMlJCaVBMV0NIa0Jn?=
 =?utf-8?B?b3ZuTnJsaVlQbjdUY3hUZDczTW1tTEhkMHd5T0pZL3RkREpFNnAwNXNiZVFt?=
 =?utf-8?B?V1kzZ3FzbFFsdjNGbWJuZnpGNzNBVmgrbnRxN1BROXlVdXYzWCtPQVZsSkh3?=
 =?utf-8?B?a0kya3pDZHBKblJhajVlcEpRYm1sRUVMNW52eS9OcTZvZjVYRzdlYXpkMXZa?=
 =?utf-8?B?YzNFNUxaSHE3N2Z3WDA2OFpCa2NhVHkxR29rK205YUlpMmFseDdqUkZvV2o1?=
 =?utf-8?B?ZzJDelY3SXVHeDdpR3FsQ01RZzJPWHZBNHJMYlBPNWN6azRZQmY4L2V3VU91?=
 =?utf-8?B?dWZpVE1VMEoya056NVZoZWZwUGRQRXRRNmY3OHVqTUEwZEphOWtYa24xMFNl?=
 =?utf-8?B?eVVrSytZdkRjQUZ4UTRMNUI2WGZabjRrUFdBaTNLZmxNMCtaeHRrby81b3pR?=
 =?utf-8?B?d2Jad21uZXhpT2x4VDlvOWd6dkFGREZRM3BtVWhmK3RhMCtXWWdoNmc2WVg5?=
 =?utf-8?B?Qk9JTlczUWJ5MlN3aTJublp1STZjb3FzcVpEcGU4dDU4V0RGRGZiZmhOVnlG?=
 =?utf-8?B?U3ZUMDFjQ2VKQktoVWZxK3FheDZZVHNXVWRWNFB5cjFXRFlVZjd5aE1BTXZk?=
 =?utf-8?B?eThvK1ZxZFVENXhYT3ZDUEk0UFhGREpURGxjSk9PM1pJOHBwK2VXRjBnZE5w?=
 =?utf-8?B?UWI2U1BQK0t4ck9wdUh5M0hPK0gySUl3TG5DTExIZUFEZlNKemlVTUJaS1dG?=
 =?utf-8?B?UDc0dHp6NGQwZ25EUXNXSmxiSjRXSHE3WE9kblFpS0lXLzJuWnVLc1QvdUJs?=
 =?utf-8?B?UEhSNkhuSTRERHY3bldZZXNGdFJtdkQwQzVCNGxNSWIzYXVZUFJxWkdiZEQ5?=
 =?utf-8?B?QnhvcTNLckJXcFBCanorclNuVUtUWUlhMjJxb0RCd2M2R1l3S2Q5RFRIaGI2?=
 =?utf-8?Q?AT4D9BabmupcGdQQET2QLVvgu/VfA/fUJGL3Z3nlLOZdy?=
X-MS-Exchange-AntiSpam-MessageData-1: iSpSFu4Bt63kbQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf58fb1-ff31-41f5-2859-08df29a779f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 03:58:59.3355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQGI6aczaeIV0yD5uXGu5Esir8Rrw29Y//DLG8c0ffmEzscHZYtw7NHjvQShordh7uniZdagfTK510+x39Xbqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
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

On Fri Oct 9, 2026 at 8:54 PM JST, Alexandre Courbot wrote:
> Since we are going to introduce a second type of message, add `rpc` to
> the names of the relevant command queue methods so we can distinguish
> between the two.
>
> No functional change intended.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> ---

nit: should also rename await_msg to await_rpc_msg?
