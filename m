Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC2EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBA610EDDC;
	Wed,  1 Jul 2026 06:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="J8Eo/35g";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331CE10EDD5;
 Wed,  1 Jul 2026 06:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWMXNxkcWdrpLo39AglWpYMyrDGBMhwpBfqomPgTep+9/0+OyLcLXQcf5DPWIUDIG6MV8eOdPfXy0MEZiZxmA3TSVXH+BZzqS5S8X89SJpuND4TJxur2e4VEFZne4e9TTVaKS3c6a2hRyLZxwZyA0YajbVZKVQcPA+EiQnQdwhNw8vk/USRe2adZN66CoAtdHupAvMndR9WcQqi8PPdyXobMxZh2RaNsesBliVSAGVDAd4INwAzozPl3PrNVNW4J9xOqj/iyHa2np4fhrWQhSpHwMcBzorjPKJw2QZbXQcnivrumKSHeihjDkZv0+G0+aKw6TGdAGXll4xujzRSkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW/AKxORGBTU/Dpk1U2+S5rpWSXl+iR1Tc9z4DOygKU=;
 b=P8DQYe3X2g7m+wHWucH4cT4mHxVLMkzPqtp9qJVe1j58VwMnKwcUyf8XL0xFdB3jx03ruA8CvxgELQU1EQfiu08KSpBPCvlddYHI5UHRwn9I7TIyxRaTnAcfzGkjZWTghO9GkG0rEgZTEr0Meu55oV+Dd49ZUA9sak2ZzbEpgGKXlDgJcVxjZDixvq4WcBGoM6ZnsuEOcaIQkd8+D8B/pTznDJiLO/mr0xbkx/2oj3yTpTvBYoTraDTV5HxaF6HnaSgvZY65+1WE00BSUqEN66pRIWG5AaIiBdkUN5Af9AY3DplJjW/Zh3M7a5sINfCraJ42KiJRcTeDFlbsWvDMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW/AKxORGBTU/Dpk1U2+S5rpWSXl+iR1Tc9z4DOygKU=;
 b=J8Eo/35gQHMWDDm+UpAul053sFRx0JNqqzoVCLWnySWFPP8o97NvWksIAYUmQszwJHHq0V6LvATLOwvVXf4AoUN1cPFEuzBbtkdAkjcsj7WOATwkds8wcBqN76r69cU5IZret626SNwM1JO5PDB6+/NJ7MzLJnptOqB8/84srHfbBwQs69AqbJEf0kQmYkTlXVjAaCxbb7Youy8kc69XZud0Vmvjh5jjDMKtRCxQOsC6vJp8MK1IgdyuUfM+m3ex2j6gogaG1RVp+Kk5YYd/D2yZCot5cRCRXUHND0cvsB+24k+q2CTuEiu1GD5h8gQaABWedFtK2TFOz3m43PkMkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 06:52:06 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 06:52:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 15:52:03 +0900
Message-Id: <DJN1B0CUXFLF.18XU6RRRYZO9O@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 12/13] gpu: nova-core: gsp: separate context and GPU
 lifetimes in GspBootContext
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-12-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-12-5539d8469590@nvidia.com>
X-ClientProxiedBy: DS7PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:8:57::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 334d0ee6-9cc6-43c1-e8a4-08ded73d4377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|921020|22082099003|18002099003|11063799006|56012099006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: t9uVeY9gX/OnqA09YWfdqxosqz6gLYnKjG2qccdn8pU22HYlXBLi+iwCHcQ/DF0l8QJy2SMX9uO3cZcpf4Q4zv5Py3fwdTJMv+OR6meHCgx/xLKyfEvo/lT4+JtWbfyBbVpb+mmqjF+FVrprxQphgVOKyKJZLHbgA+dPf1VgquoDjGDBBC3xyGhdX6iojxiIeNV5cStvgCxS4SVCBS54JyXqejBNPWkdFYCEAqp5TFC41pVYWn0OFgTkg0JOdp79t24TX6kWFFglq1IiiyaKX9tvPj3xwUTKy86k75+gewS9DMQNMfWi+yEsNCtf9r2hSNVwBn4XB/yFHfuLnNffe/pSxm1NP9RIyK/ENCjFA1HHAxYUUfG175Fus2n2F0GfSgLGPSDf91V7yGmZpNMhjn+ImksLdr6Mij6NU7VSf4/+FAJ5a/5RvvXTqvD8zCPzUU47+LkDTN0Sdo/PCCiO+s3z630c/6hZNeVFPjV3XrRH6czGz9tJ3MBaHlJMnxwTyetHf6pNStBzqsJLTtPfaiGQitXcbh8TddJY0pdSydLAsIkS6jXpdUXrFW3Lt4lJ3r0FxDauODFw2rPYSSpFpFRh5Iu9rWbApR2H9/ejAs3mcbS3uH4MGOWXiZqdz9CXZptwChNgGOLv5l6Q56E6+hPy/e1bypOhPzL3+IzN5uWP+6s4oe9SsyhiJt1AVcGbAloeN1RHlvpWnlySDYTYUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5NNFRHbWorYzFScUl6eVg0MWdTc214dXlBOW5wRmdTN1ROR21zN1ZtQ1ZO?=
 =?utf-8?B?ZnNTTmNhSE1QUk1nOHBZL3hWcGVzdnYxS3pwMW5MMDZic3JrU3dLUGwrd3lY?=
 =?utf-8?B?UFpEYlUyeEtpbUUzUm1ITGVhNG1JV1cwWHBKd0h3NG1ENktRNGhCOVJQLzZl?=
 =?utf-8?B?S05VL1luQzd0MkVMN3BsWWs5TFNLT1Q3OW5nTU1ONzAzOHBzNnJvUkFKU2F2?=
 =?utf-8?B?Q2hKckdzc2tkbExMbjBvNmZOczlKN3dacnRvTjBtemJIWVJYUkx5ME9ldGhy?=
 =?utf-8?B?aXI5bXRGTXVEM3dWS2ZHWm5DRm8yVGM1U29lMmwrYW5PZndCOHNOLys5L3dI?=
 =?utf-8?B?OW9QRXlES1NQK09qTnZoZTJKc294aWhQajR0cFhDNWpCVGV4QUhiUEJJRHN3?=
 =?utf-8?B?NjFKd25wd1RPVmsxSnVxZzJNT2NkQzRrUGhpaW42VnlzWnd6OGhoUHNMOG1m?=
 =?utf-8?B?eEJSK0hLcTFRTEpSMTc5cVJYZWhsSmlVc0YzTkU5VnkvNTAyUDVhOStrRUtm?=
 =?utf-8?B?d0J6RTdPUzFSWUpkUkdhUWlTUmJsK0ZIVW9rUVRMcDVvM2lDZkhYdUQ3WVow?=
 =?utf-8?B?cFRlQk1PYitOMFJJTVppMEMyY2VTeDhGWmRPNXVqQ2tJOHJQbWVzNHR5SXAv?=
 =?utf-8?B?UStjV0JzNWJWa0JsbUpSRTM3MDgwZmxCbXJ1UStObTNBSjFvUUpBbzV1NHNU?=
 =?utf-8?B?VzQzOUJRTlBGU0EvOTVsanJRRldLY3JnVmZPQ0ZoTnREcVRSN1FNRDRMM1pG?=
 =?utf-8?B?WUptejE4MytlajQyVW1GWUF6b2NhdVNjeDVDbWxEV2R4VTY5Sml1YWJQUmIy?=
 =?utf-8?B?azBvSmZ3QzdoQit4RW13b3YxL1hXekF3Ty9GaHZVSUxoc1lnV1BoWDVVdlIw?=
 =?utf-8?B?eWQ2YWVpZWhpUElFWGpzdzkxaWIyY3NwZW1pL2hoL1Y5YzFsd1lnNENGTGFU?=
 =?utf-8?B?N2U3TWJpcnZjRHRLZzdxTUFPWHoxMm10V1kwRXZ4bTZvTFR5RlBKM3VIcHpi?=
 =?utf-8?B?RmhqRG8xbHRadHFpUGpSMkNrVEVhSFhUZ1hHenNaeWhMblRTb2JONm1uN2sx?=
 =?utf-8?B?MG94dEJPSEFqd2doK0NjV0MveFEzT1IweXlyMlBBazdva01PSlZQaG9xRk8r?=
 =?utf-8?B?UFZTWkZqOHZHYlpTL1JUWk40Rm9GUFFhaitib3dNR3hYRTFXcDNQSDlBY3Np?=
 =?utf-8?B?c3dOSThjWFNzclVhYVJIQThyZ1E5SVc5Q1hISHFlOWQyMHFxc1pBVXRvNzU2?=
 =?utf-8?B?Y1FHZDBGWTJyOWdOZUY0VjVZMEQ0bzU4ZWNLdTgxZkRsL2VudUlRdHcvdnRu?=
 =?utf-8?B?eFJZWUg4eGw2bTVmREZZOStOZWZEbHJVaTZqYTF3L2RwY1I2YlNWVWJpRGJi?=
 =?utf-8?B?RUhSc0FlR1o4TFVPY0tleVpoVjcrMHhaNFgwdExNTXZmTVlETzY5a2xrd0dT?=
 =?utf-8?B?dllnS2paUktPTlp4elBFQmNyQUlFMHY2VWVEMy9aQnRuZ3BnT3BSVUVyN3Mv?=
 =?utf-8?B?TnpLUkc3SnNBek5FMXBlUGVKNU5Pd0grRktHMCt1ZklpNE1HU1FaOUh1dldj?=
 =?utf-8?B?SVNSKzdicndnS3RHbkJjRnQ0TDdLbHY0NDUwSUoyeXBkUHlSdm0wc2FRRFdG?=
 =?utf-8?B?U082NHliUDRKSk9zVXVNRmFIeEplL0VncHUxOFg5a1FkTjB1MjYrY2M5Y0dn?=
 =?utf-8?B?R1RWWm8ycVk2SDBqa2ZHKzhxN1UrKzI3YXNtYks0dTl6MWMxM0VuUmFhK1hl?=
 =?utf-8?B?dVdYTDhkemVPY1FrOUhpTmF1MWJCOHJxTjlrMUE5NE1QMitybmV4NzlQU2tO?=
 =?utf-8?B?VUJDdUFQZ1NqVEZ3ZC93WU5sbTJub09vZ05MLzJsdEJIV3hQMWY1cWQ4VnRU?=
 =?utf-8?B?ODlPZ0JhaHZxQndZb0JQYXJaQ0VDcVNIc2lVOWU2UUlVcDg3a2JIbmk3VW5u?=
 =?utf-8?B?SThJN3gvbkkzblZBQ3BsbkZmbUNpRmVUSy9hU1owOEQ3UlJUQ2Z3VHM4NDVt?=
 =?utf-8?B?VkJzUktLczlrclRKTzA0K1Q4Zk4zTXBSQVlWK0xwMmhwMUZVUzZpSGVsc3Q3?=
 =?utf-8?B?bGRIdlp3U3p3NmVYTlRYQkNXaGtzdEJTYTU4Z2ZjbmI5ckkrNGxhQjNSR0Vr?=
 =?utf-8?B?OGtzejlYZ3Y1REtnYjd1TWNXRmR4eFFtUXJ6RWRvRzNIakVzTnc5VHJ0aHRK?=
 =?utf-8?B?NlVtTUxydVN3M29rc2diVUpXcnJrcE9rZStCY3Y4Q0JSR3JtNmZHRGp6TVNr?=
 =?utf-8?B?YXRuM3ZlOTJSRmJwY2ZLS1U1cFJOQm1xUHArOTV0b3lPMXYralVJSzVpVnB6?=
 =?utf-8?B?MEQvSlB0dWd1T2t2NFN3R1JKRkx3ZUhVRUpEaWVwOGdiek5lMURZbWgwRnhz?=
 =?utf-8?Q?rKAISpmNBjATQug4JtFeuEf5knQf2lcfWyQNX3zdt/023?=
X-MS-Exchange-AntiSpam-MessageData-1: 54ttxZxDEbE+bw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334d0ee6-9cc6-43c1-e8a4-08ded73d4377
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:52:06.1720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uctdNBt2aBeL/MG5OZ5Xhri3U9jvyVB3ORj1kzNL0QXnUYHmqUadGpStkkuJ6noPjXdDYxj36U6rigSPsh6g+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
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

On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
> `Falcon` instances retain references tied to the lifetime of the bound
> GPU. `GspBootContext` currently uses that same lifetime for its own
> borrows of the `Falcon` instances and other references.
>
> But these lifetimes are independent: the references captured by a
> `Falcon` remain valid for the GPU lifetime, while the context only
> borrows the `Falcon` for the duration of a boot or unload operation.
> This distinction is hidden for shared references by covariance, but
> cannot be ignored anymore if the context carries mutable references to
> GPU subdevices, as will happen for the `Fsp` and the `Falcon`s.
>
> Thus, give `GspBootContext` separate lifetimes for its subdevice borrows
> and the GPU resources captured by those subdevices, and update its users
> accordingly.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

