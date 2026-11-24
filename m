Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD3606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ioSnjfs2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8FB10E500;
	Tue, 24 Nov 2026 05:23:17 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90AC510E2DD;
 Tue, 24 Nov 2026 05:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/Zaw5BC/KK1flCF7p6em43+tt/dM6Uhx9Mzf7CzKS8QLx3UgnLd+5XzTQ/U6iS6kRbAFggbLOK167bgvAiAP7VT4uvVXrrPK1Ba5LmVPKbuJi1HjE9Ax68/s0cevKUVDWhkm8qdVuZlgpbC89XKl1FcmQ48+M9gQW5GbmYXK1K9HH3/93tIhU+0+0OuNjGKKGOQ3Tfb3BlZBEpR0ECsa3sznK2FTcWTSAmoZJKhegSn+6D3FbOMFWrWLRRdSPp+ihricVNq2dqJF5SgPsTcxpqvYVKflGJLOXTGrlteHsQckQqsySoaltJxBVz0T9HIjGgcKCJ0euoOcXUXeqI1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS40u57WbsnWrGfFZR7FgmIXveYppdaH5x7lXmhOHXY=;
 b=nlZgvbYJjSWQ+Jo+9JYHeLQyqaOmg0WZE6X86YEsqLeZUUqAxxA2Tya8z8PmuBL4pW0uy2mptqjoViERlPvdfZRRMsXn0bBa5DCLRvhT4coZZIQ06mmPU5sNaZl6VME4beKwDmcAokt+utVqtrxFP22Op5qNLsf1wqkMg7qKLd01h4FSxPxLd6UDRP2E5VO6YfrJMJxTcZjhq5gbVk3Ve9DhtTlEsw1zeau1bT4IQCx5bzy58LRPNcaW0ZI72kLN0Fk2RcIdQ8S/7SKYlkqeo/MwGZUkJw8OTqWfV+cPQ5ZxA3wBjiBxS9/Ew4Yyb7Qnz+mFYGBr3t/pYzW33esBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS40u57WbsnWrGfFZR7FgmIXveYppdaH5x7lXmhOHXY=;
 b=ioSnjfs2OOjHl56Vn9V2lOSebBWFee/wYDc2wqJTgdwtLtXzdFmSuIjVQw3m9p1Fkb0vs7Ikt8eUgtzg2fW2LJXdjeXKnr+5NFPz+7nR+5AMg14aDgEpizAJtMD2hu7E2xn+SdLXQUW/cEODzOpQEaLzloGcIvq3MpbyVsBTC+6gJ9Z9t4JBaprzXnLQXl3cYbWn0eOwSzIfwcF0Hkh9USAFoWvfwY95mVNwp18FDyzacVJBnmXJ/NV2B5SpA5Vu6wRgT+lg41sb7gv5kIy8Sp+hEmNVGf4I/KLX8b1SlnkaJhy4d2SCnXVXGBB7OQUdIFiOCD097CZ/TlutC2uNlQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 05:22:26 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 05:22:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 14:22:22 +0900
Message-Id: <DN36TVRHP5RJ.1VH6LBMSEG5MA@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2] gpu: nova-core: use Init for firmware initialization
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261122171353.963020-1-dakr@kernel.org>
In-Reply-To: <20261122171353.963020-1-dakr@kernel.org>
X-ClientProxiedBy: TY6P286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b259c77-2eef-4db6-a775-08df49eaecf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|22082099003|18002099003|6133799003|56012099006|11063799006|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: nMbNT5wB0BlGZCeRX0XqihG3t7jtv87iUCL8H9kL0ec0LjXZ1rVJwyU04KNGCj5+4cTWOitmBHV8xCHWuYLGaNOA4F+xoDYehFNfq6BmwIN2QBW5z6Z/1tylDTYerRUy7UvYStPkc0uuOmgf4z0Ic64uEUlg4IVU73R7XNPSc9MeibhqPSNaRTMnQefpTBzovw0RkgIiBNN7cl2EsZLxBCBD09ZQU+c1uP9cbiskSlBFqKgc+6YCcKBTNkbetPljbxTC5srOzNeX8QTy1n9wuBe4itUf/L2V9vudt96c06G5GK7J2LmwlCeKdsXhKsByr/K+13ZYCV4220rit2MP2BdAD+BjJlKirEFBDUjohjnCBci6E6o+n63NU2Ymg97zgUxj/nSKHax2fljXZGYy0344Bw4ezDY3IaSVPAZTKd4+j797IkeVvF4riUmFDX+8N1UVwuJaCTl3gjpf2Lv27bCtesKEEz6JVhE5HAqSFEM6uJqU0XwxAE4Xw5E+dPJfj0xtxUaYhHofr5QWKxQkrAJNCGCersPXRZkvIVJmNZraFJ6/hWqrcgTkDgwAGYS/UnQjCYpxYWgCVGAYZ22tLRieiCEPOM6RZyTXTs8qlL8vzP9zpzNLj4V5c+GqLC/ehDLXmpBryELhqxhy5G8Cp/xePsqZ0pp3FwPmPl3IsY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTNNeXYvbG5Oam84eS9LUlNlLyt6aHlzR1g2QkwwbTU3aWVsQ1YwRjE1MXhp?=
 =?utf-8?B?UVNqM011SWtoeEpIcDRBdExNbUMrTTNVR3hocFNOT01PN2Z5d3VLOHIvSEN3?=
 =?utf-8?B?THNBRXRLSEJYczNMUmxNUDRSak91S1V4NjBKVlJvMmJjTTZSRDBHTnloak4z?=
 =?utf-8?B?dVkxVnJINmxONU1ibW9oOEFEU0xCSXhXL29jNkROcUEvREpkWkRaazJKUHlo?=
 =?utf-8?B?UjlQbWR1Sk15WThyOGRvYlpxQ3Bua2N1RjBLM1ExNnlta09qWnFlWEdMRFNX?=
 =?utf-8?B?RC9kb3QwQjYvRDk1bHlPQ28vNCtaaUlwaWprckVSaWh6NVlLRS9SNVNHdHUw?=
 =?utf-8?B?K25seDEwaFAvWHk0TC9MRnYwcDhkdk41MjBNdmJQZEM4c3lnZnZzeHoxNjcw?=
 =?utf-8?B?OFVRMWwrVC9VaXJWdUV4SzQvTTlmQzdMS1VYSzV5YS9DZ1cwTjJZMVQrUFc5?=
 =?utf-8?B?OG1TeHFmMjAySEFJL0ZXaU90bnpLSkhSQU5PdENQaC8xRTE2YWdIazJhR2Z2?=
 =?utf-8?B?VGZEV0J1ZG8vSDhnTVRFNGw4WVdyb3QwWlp5YWFFaExGeUE1TVNYeEdQT3Fr?=
 =?utf-8?B?R0ZhK1lSY0lob2RPUHBWQkVZL25Md0VXZE00QVl2WGtBODhIQTNVMkpiWGto?=
 =?utf-8?B?TFA2UUtKVHZCVXEwdkVKSnJFSkFJV0VobmZsdkxwOSsrVEZuZy9HUUo3QlhG?=
 =?utf-8?B?VkYwZWRpc0Y5TDBFWjZ5ODJLSHJkUUc0RUVKZHNUWWhSeURwOVBZQkswOTVt?=
 =?utf-8?B?aFRQOVZQQkFoYnZ1djhlSnVoT0QzbmFHUkIyOEdWUmpuTnB6TVVGUDVYa2xM?=
 =?utf-8?B?dEkxS0xTMVFqTmlnTnczTFJDcks3M0VwUkdvTyt2M3ZXa0xNdmpGbGtYZVhU?=
 =?utf-8?B?VkJTT2d6WldNZ0lIQXI3OE9QbUFsaWFYNGpVUTBScXp0am1MM1crNVNwM1lk?=
 =?utf-8?B?NVdkcjYvQno2a0ErbkszM3Mray8wS1RzeUpDS2dQajhyWG41MUdVaDg5RGov?=
 =?utf-8?B?eFBoRkNnVDFCa3hQSllndWR3SEhKbTBiMmpqNnladzQ0dnBzUm9NVDAzdTBY?=
 =?utf-8?B?OWxMaHRhNGdWQjRyZUNzd3ZVc2dkYnBGYUtFTDFHdldLTmszM3B5ay92ZTJG?=
 =?utf-8?B?bGdkS0U0SEpZdGhzWmVVYlJvcDhjQUZmWktzR3VaZHA3bWtJdkIydnVDRFJx?=
 =?utf-8?B?bXJVdGRJb3pWUmNQS0NKQXJFVithaVpvVnJSMEx3WkR5VUUvSUl0QWpyRENo?=
 =?utf-8?B?L3cvSmp1bGVrVXRxZVBrNG5uK2NMSFREcklwVlFrOGY1Ylphb0gwVThGaDdh?=
 =?utf-8?B?ZzJLNFRCbkR3Uzg5L1lQeUlKWERrcjh5ZXQza2NWdmYrV1VzYi9IaHBYK3FG?=
 =?utf-8?B?RjBrNThNbzlwMlByMStRYXh4RzNjbm8yb2V2OUo4ajRzb0JxR0JIdlpNcWli?=
 =?utf-8?B?TzgzZUYvclRObnFZQ01GZ2lQbmw1cU5WMEtPU1dJb2txa3o0KzJ1UXNtbDRG?=
 =?utf-8?B?NStpajJZZVdWMHBoT2tLaURieDBCdlZrWE5XaThLZ3ZtZWJ5dlpqK3pSTksw?=
 =?utf-8?B?RlZ1TDZ6K3pDbGlkd1FGeWhZMDB0TTdVOW8xck8vVVJObTczNFg0ZGNlbHh2?=
 =?utf-8?B?clQxMHphZnZBRjdISXE1Sjk1Um14OTl2anMzT3ZpalZVeHdJaEFwUERIb3VF?=
 =?utf-8?B?YmNSSkV6WlhUM1FRQzJxTUowUmhoV1ZaQnRQNE9tcEEyY0g3dkRGb0ZPalF0?=
 =?utf-8?B?UjBvYVo0QnpwaktzWkZmYVkvcWR1dHh3UUFNOUlNUXU3YkFUaUVTN0hMOWZH?=
 =?utf-8?B?RUZyRXlaLy9VUUs3NklwNGxUcEQycWIrRlM1NHFyeERyVzVnWHN5L1M1bGY4?=
 =?utf-8?B?aUc0Sm44aW9PbUR5YjNaNzllZ0JzUHE5aktYelpkQUs2VXcxNkFLNjZUbGxJ?=
 =?utf-8?B?eUd1OXlHY200WkZmS1U1b0FveTdGRjg1QjVNUHY5Q2U1WXBBL3FDY2JDaWlO?=
 =?utf-8?B?b1lFeVUvcVhwSHFSc2RrY1BCeVplNVJoT3ljbHVqbms4YU4zclNta0lTWnEy?=
 =?utf-8?B?Ni9Ud2hycnN1WnRTcUNPcEE0aE9FSlhQNzR0N01aLzdsVnBWb01qUmNLczZl?=
 =?utf-8?B?THZuMTVadTZoajBoajRHR3ptLy9hWmJ1L2M5c3psNUJUY1E4eWdwQ3cyVFdZ?=
 =?utf-8?B?cUp3QTJXaFNzRUorMUN1eVdRa0JlQWVHWmFsOGI5eUZ2YVNFaUVQS0VYcHJz?=
 =?utf-8?B?N0RQRlZGYjFaTXh0YTM2Q1BLNzA3TnZuWjhPNmlPZXdvRnBJdklhR1F4bjQw?=
 =?utf-8?B?Zk5aK0xFdjRyZERXZjZHRmJSYThYYUEyWFhlbkxERFBaQVVhbFVPMjhYT3Uz?=
 =?utf-8?Q?WOIbsTOvlLuGQcyJJbs1jga+CnLKSy6W195YuRB9FmlOK?=
X-MS-Exchange-AntiSpam-MessageData-1: h3WKzFhB7gYO1g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b259c77-2eef-4db6-a775-08df49eaecf1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 05:22:25.8547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8iEHnauHRMqAS4pKsMXE9ay+UvtXjwlHHbIKK8dD7etVs31SdpFtdbbkZnkUTOtfGBfTYLQcI0X6t6ayZAduQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 23, 2026 at 2:13 AM JST, Danilo Krummrich wrote:
> Now that SGTable no longer requires pinning, move Radix3 and GspFirmware
> from PinInit to Init.
>
> In an x86-64 build, GspFirmware is 312 bytes, including its 216-byte
> Radix3. This is reasonable for the stack, but returning it by value
> increases boot()'s local stack reservation from 432 to 1040 bytes.
>
> On TU102 for instance, the nested hal.boot() call reserves another 1128
> bytes for locals.
>
> Thus, keep the KBox allocation and in-place initialization.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> Changes in v2:
>   - Convert to impl Init to not increase the overall stack usage.
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

