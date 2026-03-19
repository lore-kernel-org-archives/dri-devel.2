Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91BE1088E63
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3811110E094;
	Thu, 19 Mar 2026 02:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="biwtkhsh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3D510E094
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIiOcWU3ixPdn4SMf52fLxvvu3+nGVxYYnrPxHjKbLYx/aLd0zgjJSqEjAV9vdFVyrO77GWClhhSgDb6bs4iE6rbBRDoL0tB1H4stQ4lX1l83BXUWxLwmwpcZRgoO2Ux9ZAHOk6hjcwTo0uem9/j3ct7K5/26qjJxXU2O7PuJz1AuMUPreV2aEH+NXAiAMwt6xad0H7uFHNEaq2vkBAEqQJhW3K3tnTvguPSPLoamsCZ/RxFMtu/f2GjFFTGczcGMoQq/k+04y7islPQ7CjJwQq9oi/e83MrW4bbbEgMixpF4IQSc0VpObEHTUQd6iEo0IAOFkKeQ2tNY1TnwffPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+2Wc6le2P0VKnQkK9bhSsQ/qTOhwXF9TFeW1sB/Aho=;
 b=GcrRNTntB9m3iRd5ZIEJH949SxUYKMx22efHfsjabyuvkylCvWrjASu4Y8J2MgV5u1Rh+ouDYVMlpqAVKehSHHDPz4AihAp7kbliGYNs5BDcWranmH4RxKyBgPBsgWOIlBKP7zK3aDOz8mJeFGW2WEtWc+/awq3/ykblYjmvuHBapZ3wl1SqWdQPGyjVtEupNlKbOrELKa1daW/EDXPuOX9qf0Z0lMlqFrgg4uGhFjJUPbJ4E35teNbB6gZKgwkH74LH5rwjUEWwLbvlSR1QcUfrIfTlef5V30yHmUoPAvn8UOtDJyLoYg5Q19RXd0NEdPH8YA1cyYp8i1uVP8bkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+2Wc6le2P0VKnQkK9bhSsQ/qTOhwXF9TFeW1sB/Aho=;
 b=biwtkhshgT6wVP4ctmv0J+b6jia0xZCX5wdG6dhLltpei4bB1Iym2vrnkiTcZVevOqQAW731KWUsLrCx+IORd13dJF+zhSjSqBF+c4UQwlqtRvUr9uwLs8xQTN15YcTzkwhQ98WxehPF6SqpR0GoqEfKrb1C1UZWa1dU4YemZsZYXxkb5woXXWZMjLEabZp3r0GIN/rjBKsaS9inTC29ThS3ifwNbgKUHaH0vtDWYcwv+T7pNCvfFQpbDeZBRJ76yVNt0TbYEPx5v2RhNXEYKJoBweNkQaJ3oJf2wjxYMaUnDnDCMQ550S5Uo4MIC3yFGrxwARR8ypIy/lV5aS3HRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 02:20:48 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 02:20:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 11:20:44 +0900
Message-Id: <DH6EEM769HTJ.2LR1PGC8WZBS@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 8/8] Documentation: nova: remove register abstraction task
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-8-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-8-22a358aa4c63@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:405::16)
 To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f130524-eb33-4225-6601-08de855e2231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: bVQsRFuLaL3S54FVdNbi6EYJIeuta+3o53ioxETN76IhtQfJQdlM4BoY9UxxDSkPDI5Vkob2Cl2iyRwUQnX1TiPb2eJpMtfvpUaFyuD5ktt7OnP0c5JrBZijbUmz6+P1O8ZgfG4NUsdDIEoFZJxav8GBoXOCra52da5B0v4I0+dTvu+7f3z6+7/U22QQARDz4yNJIg3Kfc6gbc2OgdoMGN8hyFtG5mhfKjOik5bdzq5x6Cn6E2PFZsoyO1xwKF58j+ndSDU62oX+xMGZdKDund4JXtN7/6GgQHCjhwj0C0nXp9NEAXNX9mx5kEt37lnZvv5KFCgFpcN0PBG/5zxfcF2LYIht8VpV2MHvscRE116l+TRfmq7JBCY8z++3qntydLMD6mMNcc1lpYbpehr8vHCiQ3QKPuiTcuTM0Cp1p3TFDsZhwdAZeaP2NhLtD8SoAKSYylVDN3N+lUw4+lBSj3bPDAqnrpkEoYdLRsVeyfSTHFvnpZxLyfw/6L71IA9K2ouuEcMbGot3HuQTnAZxjt8Fjs84SCccjfskBQrXbpl0uKVqR2jWsOOaOP00OwuE87nlZvLRkwda7InBYJEz5rOQ4TgaQ2QjYPXZgb8OLSGR+DD9NDHk9DwHUhsmte4js7cM38la31IN23KtX8vEvTgXZsaQNRhwDgehrJLdDutvzx918Ei8kAtRI5BFnn1Z3Tp/u6SX4+GsrBjlEQTlC74Dj+RkyGqRtASNZ6iYfMUepBdTnQHTXk5CvrI9iHldM+KKswfOGoLsH0X5++rfpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(18002099003)(22082099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTcrTmZaTjNuTU1hV1JXaTBUSFp3ajdFOW44YnVDVld4ZnJyZU8yY083QVZ6?=
 =?utf-8?B?cVVSQ21xZXp0cHVGQXM4RG5jdkRzb0pNMzFlQ0gzaHp2VUZzQyt6emZWV2ZP?=
 =?utf-8?B?ejNad1FvTWFrRm1Gb3F0TUpheWRDOEFHTDdOeHdPVHpvZ1NLL3RES1c5NmxD?=
 =?utf-8?B?N2tvSDh6ZEcxS1E2akxjdldjai8wcmVpY09vc0lTWTI0SUZGOS9VVElyRkxy?=
 =?utf-8?B?K3FrUjhBZ2hDdmpHK09kQUZyOGVkTEpmamlpNFhqbk5uRnk2SUl4SmwrN0hz?=
 =?utf-8?B?ajhHbTV1L3BzOE04OWJpa1J6SDVSb0NTWGV6NW5TWXE0cTdONklwUnJQRSs0?=
 =?utf-8?B?enlTc3FTMVRSeHhLVDJaVk5hVWtCSWNMcmFJN2xWUUdRZCtORjJHdFk4THV0?=
 =?utf-8?B?ekFOUmhFYmlqcGM0QzVsRlV4WS9kN0ZnZmtGM3dUM1FRcEhYYjRKMDlRMzZO?=
 =?utf-8?B?NFJuTlhGK0dQM0YxZXljQUtqWnIvSm8xR1pxb3RHVkJXTk9XUndQMjE5TmJV?=
 =?utf-8?B?RkhZZkdIRTBRM05tVEF0ZXVKMFRwSXVrWEpMbDRlRFRjdGM3Y3k1UENySFRY?=
 =?utf-8?B?eFBHd3kxNXVXVXljZEFiRWwvZGlpTnFVTFJNR0c0NU9xT0I4SmRyK3VBaFpn?=
 =?utf-8?B?aEIrN2IzMjJ3cU13TnZYQm5uaDBERHVjeG9UM1hPTGRQUWcrWm1wRUt5TGNu?=
 =?utf-8?B?MVUrbjduUDZXTHBPTzNxclZIWHQ1V1FJOFVrU2EvNGNBc21RT3RTWjcwcnhm?=
 =?utf-8?B?RjJ1V3BZVXdCcUtCRDJ2cTFtVmkyUVJyYkQrYXBqMGp1Z0FTNzFpaHpDdVhN?=
 =?utf-8?B?Tk5FK0QxL2hmNkZudkIxY25YaHJqdDdOVXJjZC9INjJBdE9Jd1FtYm1JV0JJ?=
 =?utf-8?B?Z0U3bWxHczZweEg4YlpuaE9YRlJ4UUVzV3dsby9GUi8vaG9BVnZ4K29IaFV5?=
 =?utf-8?B?cHJwZ2lBYlQrSlNWc0RXUy9pKzl4THZVbU90T0dXSCtUMUJ5ZUxueDVKZkkz?=
 =?utf-8?B?WFpnY1hIYTd0dHd2UXl0WUhseFlxMmp6OHlqd3RTMFVFclgvYUJZckRVV2RU?=
 =?utf-8?B?YnkrcE1Xc1R1b3dacFlIQlE4Uzl1WjJHdXVXa0Rrd3VyU2tOMm1obXEydFZT?=
 =?utf-8?B?NXpBOXdZMjhPWnp0QUZJTXlIb1NNNzhrY2cvT0QyeG1QTHo5QXEzQjk2TVA5?=
 =?utf-8?B?NWtyTXI1aUQ3a29jTzhYTnAycGhaMC80ZGNpQ2cwNG1XZENEZ09Sd3VLaG1n?=
 =?utf-8?B?T3pSb1NYalJDL0RRVHRpQ2R2RXc5Vm13b0gzT0YrbXh3STVPSmZYM0ptVm9X?=
 =?utf-8?B?YlY4YkREY3J1bHhVOUZ3UHJGSnZEczNKWHk5d3FYZ2JwQjBDa1QxWitOeXVh?=
 =?utf-8?B?NlJsTGcrRkFFSUxMR1gyT1hDYWJ5VHF3c1lMMk96dVhmbERtZzl2TnJsbXFT?=
 =?utf-8?B?aktqT3M1Q3NiMFovMW9Bc0VLTEVWVEV0RkVPM2o4ZklmaEpCeUNCdUFIbHEy?=
 =?utf-8?B?V0lIS2NEK0ZWMnFuMmxESzYrSmphU1c3NGlHMEQ4dVBkQTdndlR3VkFlREdy?=
 =?utf-8?B?NHcxZUFLcCsvTFQzT3BZSXo5bUFrTjR6L1NncXF1MkVLeTYrb01Kanp0Qm1K?=
 =?utf-8?B?SEFaV1l2MzBjWjBpOElyWmJ4L0ZuTmw2Znl6Skc2WjBkeWN1cWtQcmNTT1RN?=
 =?utf-8?B?Q3VXZG5YeEFlVmFyQ3EwZWx0NExnQmwyVWUwcGpaQVNtRXNGSWgweXJLRTl2?=
 =?utf-8?B?WUpUcmdBbisrbTNRU0dzRVlsQVJjU3hqSldaWll2VmNiSFoxQkdJaUhmLzZy?=
 =?utf-8?B?ZTF3TGdPcEtGM0FGbE1LN0x4UTdXNSt0eXdTMDI3azRlckFZMEZ1WXVSWDNj?=
 =?utf-8?B?OFNmbzk3SUgrSDdXK1dBWGNxUlRUNjNCek5DbzZVQnhUY2xpKzFtc0R6S3BD?=
 =?utf-8?B?ampRcVYyTEJqelpQZHNWTWRMbTdhd05RTnpraXMxQnlLN0h0VS82MkRqZnZQ?=
 =?utf-8?B?THc4U0hFay9PR2NnV1pubndqRmE5cEZrZmh5TlFIaDVTcGZ6N0MvUm5MSmcr?=
 =?utf-8?B?YXhzVHBXWU9ieitSNDFjcTZvL2lyM2hGRWtFbzVEb2dlRWNwd01CZDcwcnJa?=
 =?utf-8?B?bGxwQXRCaTc0eEE5L2Ruc3FHZk5vYzVXQlNZeWlvZ3pRM29yTnV2cWd4MzZz?=
 =?utf-8?B?dUpaRkRLd1o0cHdzdER6VzRsOVZsMGNoTEtHZm9nS3AxWVErWm1oRFg0UStL?=
 =?utf-8?B?TDZxVHhtWHZJeEVYaVpNNzZrY25pUG1OdXdGVkVLZEtHYjU0bW04K09COUZz?=
 =?utf-8?B?THZiTXVIYkFjRTk2QzMrOThqaWk1WDRyU3BObW50TzFYakxzaGxYTFBEUlpI?=
 =?utf-8?Q?amXOE2KHRsmhP2eAdCe6dWzi/uK/e4fAGh5z/atO9Z4zI?=
X-MS-Exchange-AntiSpam-MessageData-1: 2m2Kapu63y6Lng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f130524-eb33-4225-6601-08de855e2231
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:20:48.1726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smIJgFwh6XKyWnLdgVGdXNqztnT647naLgx1I+depoYStH8bTQlurEUhQmll+wu+mjfM3OdHZXKdAtIWrBQQxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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

On Wed Mar 18, 2026 at 5:06 PM JST, Alexandre Courbot wrote:
> The `register!` macro has been implemented and all nova-core code
> converted to use it. Remove the corresponding task in todo.rst.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
