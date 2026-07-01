Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928C4C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E118010ED8D;
	Wed,  1 Jul 2026 04:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dg1ejg1O";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E646D10ED87;
 Wed,  1 Jul 2026 04:16:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLNrXI0ilM6etD3yLKT1tT7/TvwUpyQALsPdhv3hggp9VtiMIptSTp0Ksks/3EdoVaQDThVWP/aYzWuYi2r3+dIxmpK6U+CnzBtnHQ8XB0/R6wrrAajbaz9Iyk0nU2okY3/QhTesyWGcK2QvTF0DMCMxiinKdaPiLMiZOwT8UpGx8eZkpuZRRwPal/CK3WiHV+46qFhvHM0XivgveUWoCtq9pWCQBVaVR7DcHovsY4ye0DzKntvu/5601BS1/COTomHDUZ/T1kkuMlp52lnDAVuv1yu+Eyuts4qc6wTfsuQnV92cGNawUGOOTS8r8stlTUe+El0AKBa9m1pF3XnhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wm0lbYnQbVnV/rjyNZtjQ0+cwQXxR0ngBUimZWrmiU=;
 b=ESrMj9Az/QddVx42RqE09Lg/H4zn2XZcljr6YQ9GZhZli5LfGYRVRb2feXTqBnDXV8Fr7krheZNW5NBG7ExZT2VyYvvoQt376lo3M0WLayZvsAFJPv5Y8f/onbOlxPOHqwKSsXzXBmH91LbaSJyyyhs9WWDlzFne9c0HOTLjZ17KAEYZtG+pzjiUiqDw1d/EhLLyWG+55J7OnO/QQduJSi44Pke8TTZ5u1nJONFahAjp0Zstr+khlx+RYNsKoGRFZWSm1poXizgdxlnGxjSwCaag4wa8zZMP3B0Zxm8vUHuzMWrjKLl3tb8BM6Hewx4u6v1cHQIN6GXhglZaZSbSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wm0lbYnQbVnV/rjyNZtjQ0+cwQXxR0ngBUimZWrmiU=;
 b=dg1ejg1Oyb/UzFM5En5k/BVV6qeDbXap27r2GPjYKT6KetCnAUxaVRNRxW4EZ5DnF4hyWbILXoDv+/XHsxvPB12zcMIkDgNyNJsoSLX3ueEUJkVYY802arcWncdRiqDTbGtWZmbhjYCXkQGVWC/tPeMRK/xlsWLGozs7UByc+CT3b1F3x+j5o+JSBapygxCrkWfEPMVh4iug5o1mZgaMfjgX7D6/O9/S5LGncS3yujCke+6dF4F/h1dw3tKsm3qk7bbj61prqYRjROy91F+21ngIIudjlQwMdKiv/iV/T+RG02UErnJB+mj3X0UvQJnVpug1mSMg5aqHWSJa+9nwOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 04:16:47 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 04:16:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 13:16:44 +0900
Message-Id: <DJMY03860757.3SDRV7IW25YXC@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 07/13] gpu: nova-core: gsp: turn FWSEC execution into
 HAL method
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-7-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-7-5539d8469590@nvidia.com>
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: d330b819-35e9-444e-5eb9-08ded727916f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|10070799003|1800799024|921020|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: mIC1enWf+Zo+Oet0/10kMZgrp5E6UKtCXmRglO7JH8iJBkUB+3fd5dPW0Psc4ra7KpbAiRD3N1PrPfYF8TIhIyPk27EVNN+JxYsH/N/tEKxSSSyD+oiv5DtZAzjOtEfQeUjray11FhzcPOAVCDWP7SP+GWgcG8vgnfJvM3dm9gyZ7Ologb2ImYiOvsafjcAg9T6qpCK6VZUGuECKIWRvcAjvNZkDmRk6WuLLxJEb/SEhzXy+773lw1f1ugmCPrIIcFUTnTgDUjD5PXkdUNfdC1Aq37J8U+hYy/8gP1GVIEOOytJg4ggRPOhdW0dgEYj5je6+aYLu1iz8LSwwx14xkOoC8uU0l28qnolWwyIjRHsUqdVWPOrqmc39dGrDV6twa1jYpyCD1ODf5BPsHsxYr8s2MWsyOaI6V1NEqXuWjQoEfsld+34KolzYIxPrEJs8FL4dryzaREGuQebJSC+gdPj+byuH1QA0rf/+ebnnG0ndGnkpzC7CyKuGB6wy1vwlOOiBCqDC86zUWm7rJUD+Mqe8zUQa0vkravpLo+G9RecDjWDDg8qSrvwj/1cS3BvL7kEzzG7h8g1yAj3LnikB/KSsOMu2GmHFDMPiPGr2u1dfNi18ba0TPal9oS/Y3hBlRZmb/NJ/xFLrbmAAGWNj5I6yaP2sibWHuJo7r/xqTIxv5fh0BEVQusjp2vdw79R5HCeXT87WG8wI2i+BUHp7cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(10070799003)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFEwdUFWRjRkWDVUekN2MUZ0dUJDSG1BR0tOaWJkUi9FejVrdzdnYU51a0o4?=
 =?utf-8?B?WHkyNkJlRkJSMFRhSlo3a0lhbHhLZFYwQUp1d28wcGhuQVlXTVpBR0VlaTlw?=
 =?utf-8?B?N0JsMEVPb0o2UW9kR1JJaE5ZOXNQTWI0OWNod0UrUTRxUVpGUGc4bW9lRVZO?=
 =?utf-8?B?b2w0dUs1T3dOSHlJZ1BBTXc3QTh3Rk9sVHpEeUJtWDkrZ1k0dm9oekFnczRr?=
 =?utf-8?B?ZFhwZmJrdTdrS296cUM4dWVDbnBkVTlJdVpIUldZNTcwbDRNRTlGWG9xaGQ3?=
 =?utf-8?B?cmc1eFJBT1o4QkRMODNqaHh5SFRxRW4zSi8yYlB1dnVYUDNUS21FMVJ4R1h0?=
 =?utf-8?B?QlVad0FBK3FxMS8xZXVPUHg1TitJcmNJWDZUQWZySjZDQ2NNWmhjY0FzY1hS?=
 =?utf-8?B?Q2EwbnYrN21XSjJOY1hxWkF0dHA4UXhTSXIwOEVraTNRTTRyd2pGR3E1WXla?=
 =?utf-8?B?QXNjdUJqNnFRVnc4aTRncmdsMHVLV3RNTFFvQ1RxWUF0QWJtaU5WbFh6dlNO?=
 =?utf-8?B?RWk2WkhWcU5SSWFXTWd6VHZCQk1odXNsQzgwZkkrbTduZ29NeDFLd1VNMVpG?=
 =?utf-8?B?U3lMbzByaXZKYW02S1VIR3hKSHZTcDl0TFk3ajdCSHJBNTBXSWZGa0w1U0JI?=
 =?utf-8?B?OVFPRW4zR2t6cExXekxmVU93Q0RpU0VsMUdSUWdKZzBsVzBYNnFLUytiUkxP?=
 =?utf-8?B?b2ZJZ1FTU05YOG8rOGJXbUlwSEMxYWZueGVGd3V3M2ptcWdtV3d0Ym5reEJ2?=
 =?utf-8?B?RDFCbnpqUXVlblB5L0M0eHJIT1BLU2l5WlVrZVNLWWd1MTA4RHhCUnRyd3VG?=
 =?utf-8?B?Q1Jwd3NhbGkxQ0JESmVRc2tMaEhBaFdLdDhkVTV0R1JVVHNUUTlqR1kyNnA2?=
 =?utf-8?B?VmNTeXp4UWNhbDM3MThIN290WUNYV0FDS1I1TVVVMjZrMWJVUWFLcDJKcjYr?=
 =?utf-8?B?Nm9qcHFkbll1SFFKdVJwdFM2M3gzZWM1aGZUbWhLaDJhNWZTTG56NHpFbGxw?=
 =?utf-8?B?WXNlOERXSE1oYjA0b28xeDR6cVRSaWp3VGRPc1dRZzZ3aEVaNzR5b29lZDV0?=
 =?utf-8?B?NFh2S0RJYWJtOThXOVIxQU96TEpjMWltQk5HSGVKWTc4bHV1akdFNHlXK21C?=
 =?utf-8?B?M04wZzBJaUhuR1JtMDRuSnRObUw3VFBmNDQ1YUVHd2RZcFVlanhCLzBjd1hJ?=
 =?utf-8?B?SXpSdE4vblBCeGtPcFBlWDRZc3kybnl0d0dVQ0I3RGg0NkdKKzdlMldNU3A2?=
 =?utf-8?B?ZHFOR1dlRVpUWllJYVN3Z1ZqNGNybWpJV0d1UkV0ZUtIMnRqVk5vWTV3T3N1?=
 =?utf-8?B?cFpoRForbWI3Z3FHdVNMVDlmSDlLallLT2k2MnZIRElTNERZemZ4dHlUYVVW?=
 =?utf-8?B?NWpKOERzOTI0Ui96MWhIZUwwRk1scSttWFZNZFdzT1FnaW90Nm9XcU1ZYUpj?=
 =?utf-8?B?TGZodVM2VjhUdGxYVytTbFVnV3dIYkoyWEUyOWtlSGFyZno3UExMb0ZidmMr?=
 =?utf-8?B?NFU5ZTBzRDVaUEZIUHBvUTVyaGlBbWR5a0NjMnYwdEtXSHFSc3ZMMjFVZUFQ?=
 =?utf-8?B?dncrMG5wMzNDYWc1Tlg4bGNZUEhzK1JCa1FtQ3lEVi9XeVJjWEFtTlIvdGEw?=
 =?utf-8?B?Vkx6RXZOcld0TG56SW5mT1lQRE9KY0p2amVvVlFmVkpiVlMxdGlyT3FETXM1?=
 =?utf-8?B?YUFFQTVjQmUybjBlOGpCRDdVS1RNa2NLT1F4YXpONUxvQjUrcGIxdGdZSUR2?=
 =?utf-8?B?YXFaN3RxKzM2bmpRMzNhQ1hDcWNNTUV4M01pbVhYa2lyd0VRZWRGWnBMMnY4?=
 =?utf-8?B?dEw3bzV1NGFGTko2czlGZlViK0Y5ZFZZdkpuQVVab2VFV2pjVGFhbkJtN2ZW?=
 =?utf-8?B?SUt2K21JWWN0NUdWazhnWmtJdXhyNGZFbmlHU0JIbUJXVFFFa2NrT3hrQ3ZW?=
 =?utf-8?B?RUFqTlFzTzBCcmJPcFh5SjRwL0ZubFYrR0c3bG9oc0luSWZuRHQ0VW5HUkc1?=
 =?utf-8?B?VERBbEdIY3paYVJobm5yeTJxQzYxVzNoamg0dzJ0ZTFHdTY4bXdLWFM0WmxB?=
 =?utf-8?B?ZVZUdzdLMkNaS3FmLzNYSkIxTG1DV0VrUmY2RHlmRnJESm5TcHFLdi8rVjhm?=
 =?utf-8?B?S3pCc09Yc1NuNlI2STgwRUtJZ3NFczI3NjUwNkVBVUVWSHRyTnIwaXFkQmg1?=
 =?utf-8?B?YUs0M3UvZlA1djZiOUM5UkIzZDhmQzhyVUJCWTVRY0hGUVZHcDh6a0hNazc0?=
 =?utf-8?B?aXZHSFNHdW10WG9sTHM2SWltS1RobVdZVnNOUldKanNvcGJsUXhSZjRKSktL?=
 =?utf-8?B?bUtwenJIRVNESk0rOC9QQmt5NFByMkExOXg4MGltd2NxclV0ckVHQ1ZjdWFE?=
 =?utf-8?Q?RVnco2j4TuehXHXqPvmBY6jWj0RACjDsIqKkMgu8WhMt8?=
X-MS-Exchange-AntiSpam-MessageData-1: r7TUI0GsMctTag==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d330b819-35e9-444e-5eb9-08ded727916f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 04:16:47.7978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBMOTjy9Cgwn4jnb4aNrg0muZQTsNImiLsfGoYu+mfIeU27e9bH4mvJh1qOGPg0fCwqf3riu0uSaC8XYpxnkqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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
> Turn the `run_fwsec_frts` function into a method of `Tu102`. A following
> patch will turn the "use FWSEC bootloader" property into a flag of the
> TU102 HAL itself, and making this a method will allow the code to access
> it instead of querying `Chipset`.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
