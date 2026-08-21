Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345FCC5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CCC210E51A;
	Fri, 21 Aug 2026 11:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iEftkRXn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3B310E210
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 11:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAwPc7twpv+beqrleosj5UEJj0dppLgaYoF9YwXyChWkEGIWpkah70ZJkRJgmNj1R1soNq3iF2/LPqiem+ivDXhHJW1OPFpNLhVzlE5V9+5DL9TyYtBDVuvampH/eD7eEPqordAMlm8Jwhya4wbRx5d+tMTaQsCSC7lidJ/KPfAL8zWDazoY0gDTkGRPxKnbZSvdAHqyYd9OPVXHB/+KtGtsfIFxMCotDWd+0xTKl7Wdm/uL7EcRlsocxLQkUiZhF2G9mk1refmpv1wuVg2aKNePSwLN+8R08eUL3LLCZHOvOjN0ht4a+ZpEUimcr9ANKniTv0G37P4EwdIekgRkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+FD3cxwsPBEVfcdpAaDsY+pgyRgOX5g/eQeXf+Wp8Y=;
 b=k3h4K4PruRN1I/uGZ/5ZAVzIGQewBrWO9lEzorcvrJLIrV5WP9MV2khXehUuAgqc6M4+53rIp0OnIu1gDgWm0kUtX5779N1m346gyzxlxHIEiLPMRIJsfaR4pqm1LagjR+sIDMp/dMenQLVoBg3vGlh3T0yNas/B4ZyV24F1f8e6iVN984wjVTT3SR6vQOZfNvO013GaVr7h5YosnKQ1AR9f1bPCBrIrm8R/J5btZT2NhSKFhEn6gYidikrA2aofX4Q7N7jSHV6Zd4HoDX4WidMqBQWUIfxmxSHsoKT2leq5q7LlkF+UeWn6ikdsNU07kwHXCaIkMD3SryK7pWMCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+FD3cxwsPBEVfcdpAaDsY+pgyRgOX5g/eQeXf+Wp8Y=;
 b=iEftkRXnVL911+BNzq26shvSS9NVecPFBJOKUryNpRD8woFZStGhAWoL2naAeRcMtTzENlQomKrvGejt226RbsnJbZmtI/8BqPF8QS09MoFDLbj+WuNF/HZpDlMJwlzlSzS9C0ix9GwRsBPMCyuyUajqZCprsJo5Mfax0FJXLeUNSsUn0DoJGWsF0DmBvCqboKtn5hGpWR+/8YdO+pRKTLO8fsv1BbnYsPRSqFAFt7AUsdkwmLDVb9a3KZvAXCCMBwVYiRF6hEAKYRVQeuNTHYgBMEbze0HKKQvUT5foDHOUy95XM+RJRKS/NMuksGEhq8WKs72YaoDjUs+ZO/Sg4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 21 Aug
 2026 11:04:38 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 11:04:38 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 20:04:34 +0900
Message-Id: <DKUKM54OO276.1TNUL0KI6BFHD@nvidia.com>
Subject: Re: [PATCH v7 10/10] rust: use Alignment size constants
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-10-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-10-a5872e64d8f4@nvidia.com>
X-ClientProxiedBy: TYCP301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ccb7f8-a41b-4878-964d-08deff73fde0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|23010399003|10070799003|366016|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: nmxjRUZUpuAA+Ocpyz02PrBqt0A6BE3qVMo/wwnM2sf7qkZk3cJv1VH7V8wbRUeIz52V1KqR+pmxwBOaaowdD1CYI+mOV40jdlyKqcIttmgJXKwDFgwLrAMYNvu8uA2e4G2ZP0db9e0P1QgyhvNpz8v1ikbvXm4tV0MMJg9FHGQb21pMQrs0Wyo6QDYsQwEKA3N4jwqdq5wxSsFboR1e4kHMOEFpamPM67njEXPbACkVBCb3R9UeaxGoXbtBuyPzqizxczofku8tsN/eM+l/RhIeZXLsmZw6NqEviwMbQ9DbVUuyRNjJqohN1t2LOB5gaLhDPiKMBhukL4noE56PRkKbMsyPhUiVQtwRGHJU2gwOPWKVPbj2yeLB0dzFFtTl+G+/S0jX7Y0SXPQR5ieNY6AAYDtp1wQcVlZQ1a9IEVh9rfBjoUuyuqK8MT9EFTKXYYP0eJIXcCLfZ7LpYtt+2e8zkJGDvfTx8q3YJeCR7NHTvMI2UCz1aboHys/KIgSwwgupPgv6ypcu3wa/eCelcRB8IiJGtZKl/ulqOX6LtpQ/6PmSBL8N67Lv0bgH8CpLfDLQHwzD85h+7yKcCkn+Yd3EzyilhRDkBfwfM/OK4Fc7Ntd5bQYvNLIJnFRX9d+7NRxxy/hiv0CWuRS4facGruCNbqs8w5qnhNSpja0B07E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(10070799003)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS9JRC8weFFjWGgzbzhhY3FSNkVad3dETFVvNXBkanU0RUVpTjlpaU9Qa0pZ?=
 =?utf-8?B?V0t4M3c0M3M5K2prVTJPZzRFSmVnK3pWbjYyamNYY2FlSlRLMUpkYTlhNzhI?=
 =?utf-8?B?T0d2SStxc05RSmlydnA4ZjByNjZhZmcxSnljWFBTNkJCTGxEaWlTdzdFZy9Q?=
 =?utf-8?B?NVhhTlVOeFp5UGJSTTV4d3hKeW9YaE1EdXoxVnhxb1RxTmJIQzlQUWp6MEU3?=
 =?utf-8?B?d3JPelN3YUpWNWtHa2cxMmViRlh0Si9EMm1TbDN6alZyK3dXRXMrYWdRSzVk?=
 =?utf-8?B?eUIxbFZ2U0RSYWxScS94MkFoZk9qeCtKL3k2ajluVjIyWFkvZDdWdWJ6VGM2?=
 =?utf-8?B?eE1NYkw5S1d6U2tqQ3BZQWkrZlNpR21EamZUSVQxM1FlQlZmU3NLcy9pSHZh?=
 =?utf-8?B?R3pJT2tXbHg1Mmp4YThUUm1NWUQxdlM4SFlQVW1YcDMrNjJxdHdOQ3hkZWpX?=
 =?utf-8?B?eFF1b1VNc1RzTXUvKzY4dkczUUZwL0c3V1ZOejl6RGlGM21sbzV3WjV0SndU?=
 =?utf-8?B?cHAyN1o4ZHN2QW1oLzZ0U1pPamFtdm9mR0RqQ05uRktmaHllVE96UWJwTWRu?=
 =?utf-8?B?TUg0NHlmR0tTMG95ZE1aZWNvN3BnUmdSTWIzVkZXS3l6YXpvZUxQRjNNSnBK?=
 =?utf-8?B?TkFKcjRRcGpDdm5Iai8rNHBWMEkxNDJERHdoeHZ4T3ZrOFBPcjhScng4Sndv?=
 =?utf-8?B?R0xQazl3WkRlNTlXeGw3N1dnd1IzYVN4aTZKazNsV0k1ZW14TDlIMmpvU01V?=
 =?utf-8?B?YnVhT1VXWlczckg1NG9HT2dZZytGdEtuN2NONVRUTXh6Um42R01LbU9LVU9k?=
 =?utf-8?B?MDV1WnJtdVZhbm1TY3pKNzF1Q1Fja0pwSE50Z0FoL0M2NjZSVGdQRjlPVDUz?=
 =?utf-8?B?VHFjcGZ6SHhZallDZ1dlQUo1R3dkWVBYM24xODhvMnBweDhtODhhcW92T2Ni?=
 =?utf-8?B?YVA1S3ZhcFd6VUlqZzVXV3hmc29Cc3NEOE9jTGdKTE9TRXJhNjlXQzhxTUJC?=
 =?utf-8?B?bTQwalpubkllUmtCUVh6Vm0wNk51YjZnN0lMTE9KR0M2em93ckdLVlU3WGto?=
 =?utf-8?B?amcyUWUxZUpuRFh2ZVVKRmFJZngvL2JUZENoaTZHaWJOaGNnSFZ0VWFBSFNG?=
 =?utf-8?B?YktnOFdTZ3hPYVFBTzd0VU9yZzZLZlBPcmdGTkFXbDZXd1pRajZhTU0rd1dD?=
 =?utf-8?B?VUhHZFd1RVZhQzVYaG5PWlhLSll5V3owdkhBYWdYeHhlbVNIYWRreEpYZVYz?=
 =?utf-8?B?OERWcUE2RnlUeTJaU0lwTlFLRG1sUVB0RXl2R29Pd2ZkQlB3eGtMUmcvelVG?=
 =?utf-8?B?b3Z3eDErM0tBREs2aUd1ZS8rbmkxbUtCQnJ5V0FDU0V2aTJTV2s0cHN0K0g5?=
 =?utf-8?B?QXA1bitGQlJONy9xWjVKMVJnOWNScHQyOGIxSndnY3RXK051UThBTnpKUWpS?=
 =?utf-8?B?aVVuZDlFY0dLbSs1dnBNMTEyVkRvblkxa2d3RjRua3NzSlk0UUVPaFQ0TEZP?=
 =?utf-8?B?M3Nsb05aUytjRUhKTHBpejd0ZzVEYzNiK1Jja3RBMm1qQVVQT21EYnJBTC9v?=
 =?utf-8?B?eDE1V0JXREtTU1czaVdCMkZqRTJEQytzcEFaa0tneEZXR3VvdW81NUkxRDd3?=
 =?utf-8?B?aHRldFYrOWZQUGtKYVY5VmRrc09NdW9YWGI0NStQejFmWTJaUzFYOHVrdS9t?=
 =?utf-8?B?VGZFNHZ4cVA3cVUxbCtMSnBKZXh6SzkwaUdTY1BpVUdCM1lzMzh3dk9rZXFZ?=
 =?utf-8?B?M0JyUDlTQzlRdzdwSVRYQmV4ZUtVR1hJSVRpMEFJQm1RbXFubE1jVE8vazh2?=
 =?utf-8?B?QWNDOGdSdDdQZE9tUzZSTVFqWDBRRjdWYytzcUZzdzV6MlRmRUp0YytFTExk?=
 =?utf-8?B?eFhWUEdoOXNuaWJVbzlWQTk0K2dkR29iQmVCb25aeUtWYllJcjIxZzdmdVJ6?=
 =?utf-8?B?YUdiMmF2WUhEbEt3V2RLS05IdTlWK0QvVHN3Z3kyb1ViMUZBQmllOTlvUnZr?=
 =?utf-8?B?QnB2eXFNazFScVhzRHhoeGdTdWJ0eVdoY1dDY09hU2gwQm5qejZ4bWtlWUJ3?=
 =?utf-8?B?QW0vV3JsSjgxN1JBWlBRbXVMcitFWjZiWUlhTXlONEliYUJSeC9xeUxsSFl2?=
 =?utf-8?B?eTE1MGtvZXNqMCtleDBGSmFiMlQ0MitNTzBKU2F2cWh1aG1BeVlUem9INnNE?=
 =?utf-8?B?anZuVHQ2UXRCclhYSzJHcmZRcDVkcWNwTEphY0l4a29GTjQwbVM5c1kzUzdU?=
 =?utf-8?B?S1k4WmlIeDlrWkx0cU5iaytvU09JTGNtN1cwM3ZtRURla2s4N1Z2L0VXZXFB?=
 =?utf-8?B?MjFCdG1jWTUvWFRaaHNJQTlFdEZSRVlhandPZVVVRmRrNVNGUnMzdm5GbUVB?=
 =?utf-8?Q?ESh51lk6qXmTQVWJDLRbToD2RI1BMjG9UN6KLUSYkzd7y?=
X-MS-Exchange-AntiSpam-MessageData-1: 9dYuYLQy2KmMXg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ccb7f8-a41b-4878-964d-08deff73fde0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:04:38.0828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzeIMAwU+lxpYHEGm47tdaOih2jbEQFB4dn82vxEpwKe8d9QFTzNVr3+NROFpxnQ9B5TECR0rgZ3VtuVwd7HMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
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

On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
> Use `SizeConstants` for Alignment that are implemented now.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Maybe move this right after patch 4 since it is closely related and
doesn't depend on the rest of the series.
