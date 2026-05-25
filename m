Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0E9CD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE8110E002;
	Mon, 25 May 2026 06:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOM46988";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA2610E002;
 Mon, 25 May 2026 06:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBzSRZKB0FdNB00s+c8yhmitVN4pvNkH0VgcH3o7QmywXWWsjrw5z2OFhoCYiS9b/JIpj2E1H3MNBQ+4Umc1sIBgYC7ZjrYnMQQShTOOKQdoR4PBUTczamjuBtYZmM38cWv/OPBsvm72yHhhQg06Bt/m0pRpswE4dSkZ60Kk/2GqwzcK2L0fy6wIUxZstiQ+I/b3RydUl5/y8ZGljgKSJy+OFdUakjoWt1ub+4PW4+/vGPiWr8SxOBZF0uWYJVOB0USNoZB0bAgZVqBw7e+xun1zN9ypN7GNNSkoPW9MmmIhqw07TdzNZBa+uv5bCovsnQr4ii+tXeiDbyKRiikW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMCiRK3mEB3H0p4SF2oCL5yd5OxCkI04qLu1OSbGi7M=;
 b=ZRbrbKYQKgLgo0PT4feSaK1XlP0/1gM0jrJ8CPKbSx/WcG8674RHl72QEBMoJASqHy76aJbgCg02kl9EML/oSmkHsYIhHtBIzmAf6T4eKJF30nLquFr2DKyYrJsIKotDCZEn/xVLDcS9Ob2EAvJi7bhSJluPLkpOI//QlY2OEk3pGqL4PGy4/kTGz7lM8eD9VhxsW+RkCN2lRRge23ihcOhtq4JsZCmnB6bb3kul5y+2gx4ZNXQc8OorA9GXU5R/I9RYycKnyTY94z+Vh0XYMRY9K5BKdrvIcy0BdEi+4wCADmEgWn6Fjhkc78yw/zsfGheE+tqHruFyDCiAFFUmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMCiRK3mEB3H0p4SF2oCL5yd5OxCkI04qLu1OSbGi7M=;
 b=rOM46988H9CZdNwGTT3nQgyomh99B3CnAD9TSRW0tYiWMPxILm9ikByJnL/pLzUCkjNJuLumx3G487XgfMMYb5ONMblnLkbV6tTesku96oMSNbZMUG1SZ/g3aBsYKM2qaeG+O8d0XO7YwGNE9zZD/SWGJNxgP5INPQp076GwPSdPEBlzxYV7a6fGuxKkzS3Vyus85MS9YEk+D0maeBd7av/YvA+bsemkR6wv3lT7l/s61OsKaYtwcZ1rQBst080PV0Jq4RYMP7VcwAI6JZGj7WWKEpBrJ2ThKBhT4ivTlkQi2+pc1hGXR3rKmljod8KTvRB0pCKfvbM5Mza3H8e4IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:03:34 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:03:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 15:03:22 +0900
Message-Id: <DIRJ3KSO7LDQ.SNFY5ITA13W6@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 22/27] rust: auxiliary: generalize Registration over
 ForLt
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-23-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-23-dakr@kernel.org>
X-ClientProxiedBy: TY4P301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: ab323916-e19d-4d79-1d55-08deba235622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|7416014|376014|921020|18002099003|56012099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: SfDdZ5y17tPEo4Q2TgdGWUhVjn5DeGLMMT2cInOR+doyLULc+cu4k7sG/w3CesJr04gLQpq6gVwVrPyWfKel1rzHtzuCcKPWWSKpVxHkFnNq3oMP0qOnx9dLlarT1Zjlh6brw6mHKPKzNWp6rgFTTl1jL4h1N+eTtvio0BxCeyuDOh3eN5IYCPn5t4ygDLEzXUuprLbqUOOkd/c1kZDOYvS7yRGMIqAojpJ3tNgOWWM9PWU6Z5zmGy6O2cyWkMlKq8CAQgeO4yfZkclzE/0rnfUTiSTvLhgw0eLT9tU4K1iFJGjJUp16UrLx8XvRMD5SUSZeEUU+y4V1O/VeJ4iPi0zMLFAjfETHwOrrOFtWrx4zjkQuKYNNvGQXvR6Y6Xzf0vF8eS0S5Na9JhvotOtT/utpWvNWHV7A3wl0biaqyamwEL8NjXnlUGPj4NAL1LjPvqKiRi0U1Z1gGNdvzrT1T24wl1LT22WXTq5RBbOTfXyZrTbxGECUTNBAoym6reBjkKZwVAxGSYR2hCTQOiqafG3FocNxevYeYQwqHfO9/bcezGWa0b8oLSRhN3CVqJo5LlyJvwkhbK4jyRft4DBqx8gcob2JbGlBNlatyJQ5zuTqD7RUPBwCCXVyNgtFWL+06n7Ugqa0f+tnhJixeD7qPXyEXnl8IQx0dhOVs+6NU6j6RWb7Z1d1Jx6vtOtmUJ7Y6b1E8K0j0ockqXrY8KDAeZfsjF6gEPdjrScita/OoE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zyt6dHBvVGduVGhKVUxmRENSY3hSRlhmWnRDamVmZlI5Z2JQSWYzYmpncWlP?=
 =?utf-8?B?bG9JWkZHVnlsendQYVIyWVFCRGhmYVRHNFY0Z3h3dzJaa21NSzR3VDRndlps?=
 =?utf-8?B?akN0cm1zSStRTGwzb3BvMWgxZklwWWt2M1UzR3pWTUVxSXBBd2RpdjRoenNV?=
 =?utf-8?B?eHVmZnJoaUk1WVc1cktjMVU3bUVUenVzMWNNRkd2aGZZblNuNVVjQk9zdDVh?=
 =?utf-8?B?MXJpbGhtR3RPaGE2WVU5UXBXZU1wa1FianVLazlPckVjT080WU5SaXJCbVlr?=
 =?utf-8?B?OUhlaGpuMzlCZW0wdEJwZ21UbE9HRldLQUxZWm1NdnVxYmNSSEN2Z01tWUtI?=
 =?utf-8?B?NzB3YUpzNFltSzdBckZhZDZ5K1ByZ3ExMW42V3c4SjVUZ21yMUFhSFVqLzAx?=
 =?utf-8?B?V0ozKzJvN1ZpR3I1ZGlPNE44dHlZRGRSQjdMSmJiN0tSd1VaQWpvV3ArSUZX?=
 =?utf-8?B?UzQzbHZHOGVmM01KcllYYkNZdW1hNDlOR251WDduUXlJM3RVVzV1N2NFTmMw?=
 =?utf-8?B?V2NDVm9FcHhTTHF2MVA3OElPcUJWVVNic1A3MFVOUVZYMVNucVNjRXM3c0J1?=
 =?utf-8?B?VlpyK0tGRFhFQTIzbWFRRzZFbE0zRmhQaWdZZ2x6ZzIrck1VaXN0Qy9WY0VY?=
 =?utf-8?B?eWp1dCtzSFFxMFBBRi9DUmN6YjI3NjNMSmdPNlJsWXpCMHQvdUc2OXJPc21v?=
 =?utf-8?B?RjZFMVYvTXpOSjJ2cVFLUTQ4cUo4NENYY08reXRkMVBFYi9HY3VCODB2azlq?=
 =?utf-8?B?NUFMNlRKNndMN2x5U0lQWkRrVjdla1NmZ211dTh3eFUxS05NekNJYml3TkxR?=
 =?utf-8?B?c2RJenVEc1NXTHB6K1JuVUQxWkYxb0I5aGZUbnRjWlF0d2NMTnZoOWVVQjFF?=
 =?utf-8?B?bThFUkRoYlI2U3d5SDYyZ3htRklxczZNY2ZHZUFVdkJCN2FIMEVOeHFsVXJ4?=
 =?utf-8?B?ZmFpQ2VNVDBzOXg5bnFqT0YwTWV2SjgwdHhGcnJndEl4NFlpcHk5eXVkcito?=
 =?utf-8?B?Qnh6VVdEV0pMSlhFdjZwWFFBQ1BZeFV6NktOUmVqTTExTWZtRzM2NktCUEg5?=
 =?utf-8?B?Z09rUjQ0ajNTbUJvWC9GclFpdFBNTzVRdGJPMDRmSmJFL2ZOaUFYa1lkR0E1?=
 =?utf-8?B?TGgyZW9FcjA3ZVBXSngrT3Bnd0FoaW4zTFBvdHg1cHA0ZkY5NHZZS1pZNW1K?=
 =?utf-8?B?OTBjdmpFWjZaVW0rcFl6Sk50UmRCMGNpRlZmZ2VrbE02b3RKRVNWUnR2VnlW?=
 =?utf-8?B?YlBGeFA4d3JzNXlacUpuZlpzaXBkZXBoczB4d0k1ZE5Ra1JIMUFMU1RjdVBE?=
 =?utf-8?B?eEcreWgvZ3Y3L2dZbExNU0xXcStQQThoSEZENUV2QjdXQ1REczRtREtXNzhP?=
 =?utf-8?B?b2hieXJVenBGQ0h4dTBLTVlxckg4bHE3aUdEcXE0WTJhVHFSa0ZiRWxSUXFN?=
 =?utf-8?B?MzMxQTFISUg4YmZ0clNIaitzckJpUS85OTU3S0VDcjh0SzJMWGZ1YmpOTi9C?=
 =?utf-8?B?NHJkUVdSYXZxZWtTejV3U2E3RXNHSVRnSzZZNmVjc3pRMktzQjhXbURJY05q?=
 =?utf-8?B?NFJkcmo4dm1FMjlIay84RlVyalltVk81cGY4VEtubjJvZnoxZ01YSnFuL01s?=
 =?utf-8?B?OUZPbDV1OHQ3TVNScGY3UEluemNVOEVXdWwxeDFFN2tNbVI3emNqYk1wL2x5?=
 =?utf-8?B?NVNpWkkzamp5aUJNR3JwT3FNblFva3JWcXdWclBvaDc5a05JdlhqZW1JclE5?=
 =?utf-8?B?ZmlxQ3YreGRlcFdlem9qL3BxRHNwdlpOckg5azVVU2hjMCtyUlJZZitpR1Q2?=
 =?utf-8?B?bUwwQW5ManJab1E4UzhNZGhuaWpaaHFZNFIzd3REMFU0Rk95QWpCSml2NWFG?=
 =?utf-8?B?V29GQndpVlQvWmFZZUxRQWhvbGpFb2dqYXArbXdUMTg4M0pNU0h3VnV6Ykl0?=
 =?utf-8?B?TzlBOFlmNDVZRDc0UWdZRTRPTHF0aWx0NTBCVWxOaW43OFpmcFVQamJHOFha?=
 =?utf-8?B?VHdPQUgwNWxyQVFDcm1Ed3JqanFjR25aWWx3aTlJZ3JIcCtPdWhDZkNkakli?=
 =?utf-8?B?TGVnbFRGR0pTb0krUE5nNWZGc095c0JOWWNNdS9OeTJtWTdYRDlHekRURnV6?=
 =?utf-8?B?NHpVYmdpQk4zYm5rSHdrZmRKQWlyS1RuQnVUR1VIVFF0NDhCWERUVWlaRW8v?=
 =?utf-8?B?QXg1dkpKaTB3cVhmdkwrT2pQMmVSaGZkYUEvN0ltd2VYQUVQanJNSUlYZE92?=
 =?utf-8?B?NW01NkJ2L2NJWHoybzBaMk9La1RpcVBvNC83K0FuKy9UdUsrVUsvVit3ZTla?=
 =?utf-8?B?a2J5NW5CN3hCTGcyN3J1UTBsekFXMGk1NDk5T2lVeGE3bUhpWUxrWE80VE14?=
 =?utf-8?Q?pMAnFVGyOc3Jr0BPIQtpV/c+9TQIuIa3R266P7TgO7daE?=
X-MS-Exchange-AntiSpam-MessageData-1: 7VWoCbYmf3OGBg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab323916-e19d-4d79-1d55-08deba235622
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:03:34.0391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJkNy8XKES85UQi/Ii1S15LUqqfOVjI9nXCpAhYY21Mpvv6vNLhViLeiliZNxMxjE5OEEJaHNEbVbjYq4m774A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
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

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Generalize Registration<T> to Registration<F: ForLt> and
> Device::registration_data<F: ForLt>() to return Pin<&F::Of<'_>>.
>
> The stored 'static lifetime is shortened to the borrow lifetime of &self
> via ForLt::cast_ref; ForLt's covariance guarantee makes this sound.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

