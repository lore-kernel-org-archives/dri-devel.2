Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0BDD58CBE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 01:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DA310E076;
	Mon, 23 Mar 2026 01:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iYvo92O5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9188810E076
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 01:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/03/YICUtZtf4cTU0Ai9DUj+dc6b4+yqRO1Bwr71mkf609pwjZ0PaYSsDeuktgEwtzPzuhow0U4GlO+4yXzzTj/RTWI/hiPctxMj0V1phHQLzog/7vEApqHuYzX1jdZ8gLzIoo4nQ+sDv5GPWhiZyFGRUVarC5iJRvLcRxRLrl2SMI6vCu8czv5pFuiQ98iPx+deWq2RY2gwItIeNaHywl4Gi4nvdcYpKOKg1gaH6e+G4yHLVIgP015L7062eNtqFCYTP58AvxpoSBi31tq8n1hEav6pzmOF2Du8MOsK87v00yuJ8Jqy3l+Orjp/kE5QbRv2n5oz9pW0TTLK4wkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGiu12cqvh/ghkEYAy5pbJSNYSaeZI1hgnnXnSiykVk=;
 b=in6krwB9l2Cd83cj66KbjJSuv72Bd2PlS7PL+Ozvsfr/qMsUn4ZcD5EcPM5AoBhjSG278P6sR9Kdc6U+EZ7SA7uZ5598pMuP9y4+yxqwh/j3vOSJVxqSP+Jhyz3Olx7v26n/GJi3+IhHFGG6xO+f9hdeMR4GAX3VF0fP5X3R6qHeGOgVAarppQ2aufUmjXk+xxr0j/SdibEwnl9zc+c18KStXKhnN5a6cIy3oIZe2Cs9UOZ1dSLD3aTGiGB3dVo7+T/2u+dZtclUOmGkKxXNNOKy8V651q6YMQXkZJRQZQrIjjIAYoX9tDDc6K6/G4+hvXEEgivOaVK0lEpyR4hwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGiu12cqvh/ghkEYAy5pbJSNYSaeZI1hgnnXnSiykVk=;
 b=iYvo92O5x0xjYVbhcz+tWKlmYyLHlNqD1BHLZrsxEDwRfTnjz2FTNhVSsKk0HtYncqZJiAybwcNtVfJjcStqcQfpLJN42vVwXIuA6oQI1xssDIjyQchwUMsiazI6kQ2hozaIzRejwSh8Bls00YPqJBa9it5+bkttyIfLQseZULOT+PmmCmwMG18umyUsXQ7AQEI/0WctzsEtEJUxex3PLyBlhqF0vyBcglaAJWJxHJgX10fNtIqXzC5z+OWnH3nsIWwzyBgCe5R9ijNIlAl3/kMqy6FcIsRZT1J9U/wsehsC17+0TduO+EoQlDcfb0ieZ5RnhxAtC76Y0q/4SknPZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 01:40:04 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 01:40:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 10:40:00 +0900
Message-Id: <DH9S1LUJY25S.28VUQ78MPW221@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] gpu: nova-core: remove `io::` qualifier to
 register macro invocations
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
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
 <20260320-b4-nova-register-v2-9-88fcf103e8d4@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-9-88fcf103e8d4@nvidia.com>
X-ClientProxiedBy: TYCP286CA0364.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fbb5e0-5a37-44b1-5618-08de887d1ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: C9iMq2XRDck6gJ09Eehc76RlaWQjsbxm6KJnlbDo6ODWEkS3m07HPOF8Mc/jTIgEzfXX6GuqE+CrYCev0VPWCUqzaWDvUXjXYIx3tn6mrC7YgT9TYWa5TtYFHNVVPbZdSJzw65mFgA4MDjBEOsDwIb+P2CJlfVJ4jea7LcrYfIPe6MXALKHnCqBVbLTQo5QJ+HU2To+vjoNmduSpzG07BI+GfatSKYSQdX0TDT1OOPmapVxFSgQD3SngJUD0Z5SledOh0SvgwRwpex59uXLqNjUPKs+sswklhLexdAf65B972imTK9yhGcRx8TOxnnywrLMLc4lRgqrbE9Y4cxoiyKN0OsbtH4p9/t2BNMdm1je4Has+YPDcqcJFk6AUsuEMI2AArwyx4KL1t6rSTHhJ6dxnMIkMTTwXECF6n0JJ90vxAhHDpQABot7fatuyd9l4Jevi+USemKmlz6IztlsUPiV86F/I2KYG9Hykrfg/sZZBCbU+FQEgk4Elrc1LoT4osNKIM2uhNQNgC/Eyn4CyM9296SKV+5SZUkE0g64KZfno5MSV38vw+3oLtG4jxVRXx1LKVo2RAeOSwduM1LyOnt74AuVi5XjmeTVPfNbvJmy5OiTIIrGNotk/Msj4bnzNvybcYukcz1Z8/7BdgJwg18LJ5wHY4IDWRwqF6MilBXjXsKqBlY0DsGEfGoz3JvbT/EaabM1wG/M+dVt1z1Bog+4ajhZ/U8JQkibDdmfym3NCXmqDc0t+lKvTjbQwSG/ErEN0I6FQbSnK6Px55uNkmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTU3MGpZclo2Tmo4SkhGVllRb1NxSEFtdWdiZ1NwUWdoV0t2Q0toRnFvYW5R?=
 =?utf-8?B?WE5vcWt4VFU2VVJUYVZNM2N6M3duT3k4K3lMZlhWbFFVYVdVYWN1VGNaTTNi?=
 =?utf-8?B?UURndzQ0RWdPKy8vc3MzM3puUGdSbFBhNjBRek5qQ3I3cXF6MVFmRFUrVzV5?=
 =?utf-8?B?djdhVVJLcHdCMU1pV3BIaUxuNHlKZm41SUZmVkFBMHB2eWo1cGJWZ2VnTEl0?=
 =?utf-8?B?dnN0czdSTzVuZm11S0cyQ1l3MU5PeGFML0xBL3IxbmNMT2Y5enQ1R3pZRm54?=
 =?utf-8?B?LzI1ekdjMGxiQVBqSlc3bHpKN1llM1VRVlhQdnVQejhhT3VyQmdEQ1VNaDBK?=
 =?utf-8?B?V1REc2FTK1c1NElOQnRnOUJsSTJzblZlWDZxK3FYTjZ2djBTUTF1WE5tL1k2?=
 =?utf-8?B?TWxYMEF1V0JZTTBNZFppR2h4TjBIcVNGVXBwRXhlU05SZ3JyeWtYbTlLdHRu?=
 =?utf-8?B?S3hHZjh0Q0J0Z3ZxVlZwMW5MRXQwUzBqdStKd29jSzR2VWRSZ0kyTnNZMEV6?=
 =?utf-8?B?TWdobE1LL0VrTFVzWmduVWcyem1jQUlWbm4vdngvUDZOQ0JLMmVib0xrdGN6?=
 =?utf-8?B?VEhCYzhTWG5EVUdQSkRZR0U2dE9LSGR2NGJqOTdjbDFIUVJDcTJlbUR3cDlI?=
 =?utf-8?B?NTIxRkRsMUpWZjZTNXhQbk5QRGdKUzF1WWZMbUlOQzNIN1RIVWFIbkhrTjVw?=
 =?utf-8?B?aVQwWGVOMlFSUVNwRVBuOW9GQkRURklNWmpzM00wZWVFZFplejBKd29KSGg1?=
 =?utf-8?B?RWR6aFJ0ZXB5YS94MitXTmFKVXkzOWI2cjZ6bVpKQVEvc2pPa0hJck8xeEtU?=
 =?utf-8?B?b0tyUjZKb284WnlUWjJQQndVU1NHN2svditMSTA0OUhzeUh5WjBLMVpCZ0R0?=
 =?utf-8?B?MHpZT3h3ZGNJdC9zRG1nenFwaFdsT0ZKQnNDamVkWElpTEVCKzdZRHV3WDBy?=
 =?utf-8?B?RE9hTEZscjlhOFA0ajRmbTJXSi9Ha2M2cU12QWV2SE9xNEV2WS9NWEVCU25n?=
 =?utf-8?B?c0NWSHpIMmRjcHJDNWFLRXFpUkRoVmZkRWhCcHEzVkZlSGJCR1NFOEp3TVBn?=
 =?utf-8?B?SEhWYjhZbllRbXoyVEVOanZlb0o5cWdGNHFSVlF6b3F0M0xTZkM2ZDh4VVg2?=
 =?utf-8?B?SDhnZXFNdWJUOXc5enhHeGxSVHdGZU14QVIxOU5WS2dCd3JTQjA1QkNtL0k2?=
 =?utf-8?B?bTUzQnZZdHFxSHBrblNyU0U4MlplTEdqMTM1Qi9wUnVGWjkweEdLR1c0TkFR?=
 =?utf-8?B?VDF6Tk05WWp3UTA2cGtpYk5xd0YzRk5sbG9GN0gyS0hFcXlaclNvNHg3cTA1?=
 =?utf-8?B?MXJsa0Z1djBjMWNPdG4wbERuRkowdXFGV2xiUlJwL2k4ck1xbkp4VFR1bFJU?=
 =?utf-8?B?MHBzTVhDOVBMZ01yY2ZtWGxDTHBaZG0vdi9ZZTRYVXltTFV6b1dSTmFJcXRC?=
 =?utf-8?B?c3pES2FNaXZJTDAxSXA3eTRxZVovRVcxREpzYkI2VFVxemduZVJNV1lNbjdZ?=
 =?utf-8?B?U1NIc3BVaCtITmpOUDFmM2s3RmRlVS9uREJxZTUwVEJ1NGpXbjR0Q2Qwc2hJ?=
 =?utf-8?B?MTZaMHhtTWJrUVM4TmNQNVRhL0V1cWpIaldnL2pPR2hhTWJnR2dUUWtrZjlm?=
 =?utf-8?B?cjcrampoUVE1cW5VVjZlTGhEOTN6d0xQazBFSi9DOVhHbzhBRW5sOElQMnc2?=
 =?utf-8?B?T2lHMHE5WklTZDViQS80TzQydEVzeWF6eHF0aCtGR3ZJZm9YczYwOWU1bXFl?=
 =?utf-8?B?R045NHhxWnQ0K09hakVRNGprOFkrRGE5Y1lOMnZlbEF1OXRIazhPL0dhSEQ1?=
 =?utf-8?B?ekJtRWQwZ0lCcmVySWdrUDFnSko5STh4Rk92Ny9DQzNMM2t1UmMxUmtWamVx?=
 =?utf-8?B?dmwxUWMxbUNia0VKZW9wRFRuNWQ3QS9oeGZ0VVF3dmx0VVNXdlpUTG5LcmFI?=
 =?utf-8?B?TzVTcFBSeUN4QVpkdlpDaEVFR0wxVHNQNHVza2p3SmVsTW12cEhFdUFsMXY5?=
 =?utf-8?B?SzR1dmEvcnEramdFNVlHQlZJSEM1VjVPT3Z1K042YU5nb2p5bG9XZWZNelli?=
 =?utf-8?B?UFFqZkFjMTJBVEI1TnJzb29xZGxmRTJHblQwVGt0V3NMRUFFZHZiZUdBdUF0?=
 =?utf-8?B?dTQwNFpwRzB3YStwRlJUTDBzN2h6NnRHSVJ5c1RqMmJ2aHUyZUVXdEpxem4w?=
 =?utf-8?B?NlRLSVJtUUlaNE1jVzNVN0ovTGFlR0ZPd284LzU3VTlSRnBQMFFGZ0tGY21P?=
 =?utf-8?B?azVQWWhSRWdha2I2MERNNldYVEt3UFpMUGNOa3pqMXVUckJuUlZWTG41SjJz?=
 =?utf-8?B?RmIzeDRxK0QyZnR5K203cVFNS201SFRlQ2cwbG5FQmtJaTN4QWRKTTE3T2lE?=
 =?utf-8?Q?dZdLghc3Hw6fnuZdZj2IExMTZDDExJwzqYwHknb7WxdrO?=
X-MS-Exchange-AntiSpam-MessageData-1: Jsbntgu9yaok/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fbb5e0-5a37-44b1-5618-08de887d1ae1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:40:03.9226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDAWsjfiUUSsiLnsLgJ91jZyE6T9GHO/ygx89Uf4/051K3vKm+6kuUF2Z9lsT9YZl2p9AFdt0fKLGNUmcGE5wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
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

On Fri Mar 20, 2026 at 9:19 PM JST, Alexandre Courbot wrote:
> The kernel's `register` macro would clash with nova-core's own version
> if it was imported directly, so it was accessed through its `io` module
> during the conversion phase.
>
> Now that nova-core's `register` macro doesn't exist anymore, we can
> import and use it directly without risk of name collision.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

