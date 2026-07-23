Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2790EC531C9
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8041310E52B;
	Thu, 23 Jul 2026 02:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmTzTXwe";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C44E10E52B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFt6/7ejSX2P36ZHRwcTEeqvKZyOwdhySvcOmQaZFcoJUFID5oEb2jYfVw3Wmgichsz89ZoJfhLEBSVtho8n7IpumSq9gpe3kjltGMZ4QVewnjJyFkZHI85WJH6H4NPZRtAze4kEO04815m+4XV5iKs8IHfxHqln0M5fko2uVrTnFo6fCpOXwcsI/bk2Z+7Bdg5qPHl9uO80mA165lGAqqt5UmsdIYQAV74Mq7vFPG8eB6yzqfQSLjwPTBTjh7AHLWSMhdzL7eJ54bDtT/sIPBJQj7XoJX5PeEkytqv57PGTnk5dyXmkKymT1k3GRldDt/x1SQp9s+t/HtIM+maNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uB4Z+U/WYlAdAFNDjGObc/ArrlwSZLhLekeMxSLd2Y=;
 b=pyvc+txPE+iFk727aN+xMYPDt07JZBU4uWicy38my1Q1ojJKGyGZgYXNAT/zx4MqkN1e1uMvQuhPPglauIUWi6tFC412Tr3G6tkWY76G9D+qp+z23a1XgqrN5vhwc90ogrDXpPh4P8nCdvYeS4qRmcLH2jgj5s16MduQTvRzdyZWZbsxGdbbwLeoy7R13Q2bQEYnXRcQ4oa6Lj3oQRgKS+I/Mobr36tR70Ejocg6u7TCtt65QC8C0sY2ndAbBbgF+BSWzTRobwG+YCjak4TS0GdRssWWLf/OZwJisWyEMyHUXMW+GLa1p2hscS9I6O6ZwbdGdwrNX6JOPQn50tRtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uB4Z+U/WYlAdAFNDjGObc/ArrlwSZLhLekeMxSLd2Y=;
 b=DmTzTXweMmico1IDix1geDb800cdKyh+cZdegVQh9jYXAl4N5lUd3Wzik3fnF4m2XCa7jJarQcP0xr2HyRjqDl/dyfxdGSTyk5OhO7nopEvYczd6GP80iacKvsBsq4Qam015dOdzdy2pLsjeCmKNZb3B8Gz5UJ87sgRsHNBIT0xvH997x07EHc7Q/429xo3ZwVEgPrwMY378IlpQ+N71NcfEA7oNqHUGVqxRKyndWp2gnZBtXNH6k2+/o00d/4kaRsXc14h5KQjFiK5OBJDkjBv07AHx/Rd02MnjPwKcXJTXFNe4HE4Q2STmfVtFCZLJwLwi8yZFqLocc+8IBAAbzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:55:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:55:25 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 11:55:21 +0900
Message-Id: <DK5M1RHMEK7H.2AH2AGBW62HWL@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] gpu: nova-core: fsp: catch bogus queue pointer
 issues
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
 <20260703-blackwell-fixes-v2-2-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-2-8e3d8bc32bb9@nvidia.com>
X-ClientProxiedBy: TY4P286CA0140.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d6077b-6dcc-4b25-773f-08dee865d829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: N+fI7dHlY2x8Ke7P4tbfcfiiMr9ZIseWQiUfG98vQCYpRgJizDiuk1NZ1hvgG6mnqFKTB1yahtco/mmYe1xSrp0rxvV24Jczb7ZI+8yEhWZoFgcMo3LHry0hIQ+/ittsRZ+ryQj8MHlZVVH6KEo5WdyoZvQ/qGo0z5cJj7+8R4x33Nz4L5PsI24KyW9XmjVa+iXDM62LIIwHYzsAmsVbsUj/PAzvy+9c9ECKy/JbCDcEpZEYyIabwn5jSu8uPW86NApYE34jOMdJIr2cp8J+/HehtV2pPDltQAooOTJ0VbTHthOK2VXhNHdQs1J8iT1uS9CGcY22u7U+kYlQy1jKAMsSi0Qcd5UKVb6nHbOh1qR/LzpIU8FXleyrRQqR8SlDjgFdqDD+aNUJFCUDPuO/o9eKdDfEZm8QBRtk8DBU9ijpF3F91n62QeU8ZoUX0FkNjG2Ive9a5WOqpPAOyONQRTJlMQHSzVdcmIHoRMdE7lBNfruic63TjQn3Py3NqugfvxfQuHSUmR+Hvo9CaRga1hhJj6/x6nNV7/yFZhhd8GoirQunXc6kTi6Xb47myXIGgLRIhBU/lGfWSpfDryfkr8X8BI9rpUint6RFds+qeI4bavBIzNzICsQ62Tr4o3aQKjlQY3kx/nW7N5uaM8AdDQ8EYuHbcSYWnM5p2ZG8iTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEQzY3dPbDFBblMyR3BzcEVpUDhYa0l0aWIxMmpDMjJkaENDVllpVWZSeU5B?=
 =?utf-8?B?Q3JkWUlxVmRYZUY2QmRaSGdGZWRxSUtqL084S2lPRkozVU1ZMlhPTXNIazI3?=
 =?utf-8?B?d1F6UlY0c20wd2Z4TEtEK0JFcDhCb2lWdFl0UXVMWTkxRk9xb00wbVlocEFu?=
 =?utf-8?B?T3U3NkFQODg2NEJSTWQ2bThsS2NRc1pKdVNiN29oYlpwV0c5eElCekdUVU05?=
 =?utf-8?B?Q1RWM1JTTkk4bjZsWlZLM2gzVHlMMGVXa25DUXRRYkhzaFJFRVJTYjBKTlhV?=
 =?utf-8?B?bWlhb09heG96VHJUNWI4VWxTaHhoMTdCeU1sNHlGNVNmb2NKMDhKVzBhUVlv?=
 =?utf-8?B?QmR2VDM4MGl0Z0w0d0lMeTBoWUJKQUYrN0tWbDEweEYzeVlvLzF2bEwrSGtp?=
 =?utf-8?B?WVhIc3l1VklWRVAyaExvanAwbDcxWVo2RWkzTEN1eHMyZFEvaFV2aGFCUHla?=
 =?utf-8?B?dWJVemtJZUxISzQ5MmxWT1V0R05iaGZaYytJZHEyd3pPa0lJaldqNmsvQTNE?=
 =?utf-8?B?WFh4MTBMcHBRNHNyN21kRmx5emEzQkJHdllxV0k1cFV0R2NSakNJYncwZDlt?=
 =?utf-8?B?K2xVc3dCL2tEQ2ltZTJQWEg0bTZ6RVlnTDNVZGNlc0NqTVdDcnk5eTVCaTRZ?=
 =?utf-8?B?aE1JT1RBVEtZUDh1WHhSWWZ6czMzNmdGeTZ6bzZLdVF3V2p1ZlVLU0ZjeHF0?=
 =?utf-8?B?dHJGOGUvSHp5UHZVbDU5WVpTa2pKdVpHcS85S0NNMGh2NUlPZlVTRkQvbENH?=
 =?utf-8?B?RGgzNnNjSXhLRWRWeGlsTGVnOU43b1g2OUVvTWJXMnJaSVQzbkpsNUtwTGNC?=
 =?utf-8?B?VGFOVUwyOWdSYWFRZUhTQ2FtTVRQT0NJaXJTS2hUbWlJb3FJdkhSMTA2dzM5?=
 =?utf-8?B?c0xGVDMydzkxWC9nL1ZuYVBtRE5pL2htWWI1SFd4SXpneUZSQXNRZldaV0tB?=
 =?utf-8?B?bExuMGoyMWsyVkJ1cUtIUHBWSllVYTd2RjEwSDRtd1gyelVyVFY3dDcvRTJz?=
 =?utf-8?B?M1hWblJXTFQxZTdFQWpJZnFmR3dZRE9pcDR1Ly9hZ1pBWXBHVjdtMHFUdW1D?=
 =?utf-8?B?WUpMTTVUM0laamNEb2xJSjVjRFBSSURoUldHVEZ5NUxNc25yaTFtWVQ5RVU2?=
 =?utf-8?B?bXRSVThLTkJVbkhOd09YcUVoL0I3UTRkcWZvUGNaZHdkblRuN0pmY0RKMDQ4?=
 =?utf-8?B?d21HSW9kUFd1ViswTWtodCtmVVRWYVl6TmdYeTcySDU2azYvbXhxeEV1SnFi?=
 =?utf-8?B?b3AwK1pVM2dhUG9RMHpQUjZsNFJiYy9ZVWFDS2NveVdsTi9hMHFIcTh5YkdI?=
 =?utf-8?B?Qm43MDI5bnY1alBkRlFaRGo0STd1T2NuT0U1UzdDU2wxZWUrcHh2MFJ6MnVn?=
 =?utf-8?B?MGtqYXZkUkRyWENLUTdtcE1GWHpFTHhRcGFCa2MxOUJpM09nOEplRll4Wldw?=
 =?utf-8?B?cU9TRHlzSisrMGM3dEhZWEV1ajRNVUpCWjc1dGlNTUcwWDBVd0RabW42WmFK?=
 =?utf-8?B?SDhxSVFkM2RPSVUyTW15RkszdXRvZHhQMVQ4TllvNTRaVTAyL1ROTGJDdHZP?=
 =?utf-8?B?R0hjNE9uRkxQOVlHMGlWdE9MMFdHWjhSMmp3bXlMSy9ldFpYK3M3OStjWUJp?=
 =?utf-8?B?SVpSb0RDSDAzUEtPOVhNQmxtaVdMT0F4SGpTUFd3Um1Oa2VkcEdHb09PWmZH?=
 =?utf-8?B?K0wrR2Q1TVBPNCsweXNkVFpnUW1jUjJraDdiOUhFYzF4QzM2TlJ6Wmw2ZGNK?=
 =?utf-8?B?OExNbTZHR2MzMjFZeGtrdDBXSkdUT3AvR3liVk9jSlFHVW5ONU1BOGZmcHpF?=
 =?utf-8?B?MjBDbHMzMUx3R2lKVDgwdXBiUTNiZWh6YXZyT3E2d2tDRHl0VHdiODBXWE4x?=
 =?utf-8?B?TENxL1FNSjdnRFhsSE9sZ0pTcjl0Y2dPcGVvbTdnaWNsRDN1cGw3Zzg1dFQx?=
 =?utf-8?B?UDNUQS9jMU1aSUhwaGlOR0pBSGlCbEZ4cTVIdERFakZkb0V3emZwcWc1RVgy?=
 =?utf-8?B?RXlVMjMySU5pTDFkRHpxMisvYWNsMWppRlRyeTBaVFVhb3Z0ckpWQ2wwUkVR?=
 =?utf-8?B?YVpDbFUzc002dUtya0RHVVF2SVVnUzlMMnlrWHptYWF5WDZ2QTJKUEtZL3k3?=
 =?utf-8?B?T1hEblBPN3FSYUwzOG9oTGNia1pNbTRjOTE3V3N3RzNhTEg3anR1UEpsVnFt?=
 =?utf-8?B?WS9tdnRmMS96aVRndEhSMWh5MEErZnVBMU5ORlV5ZlZCL0U0Vkg0WmVoT2wy?=
 =?utf-8?B?RGZmYi9maHlHZmE0N1VIY204UndEcDJSdzFubFNYSEVjVzNMSmJ1RlVQbU82?=
 =?utf-8?B?RlJMczloTUh2YXBmeVY2Zm9RejdNZURQOVlsc3J3dlE3aTR4RGIzSlVOUktB?=
 =?utf-8?Q?AVL2FjT+bZzyt2N9OPEwcqqvQEsrFJFAxDUaIK9bOS8rM?=
X-MS-Exchange-AntiSpam-MessageData-1: 0+Y/V+X4MJY6jA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d6077b-6dcc-4b25-773f-08dee865d829
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:55:25.0746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju197Vo8badmDXWDJZ/3IHuzTM/PbLJ6BC1xIIsWeHAFQSW7EH16/NthaVyfchhK6te53C3s8gSK5utyJzL4Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

On Fri Jul 3, 2026 at 3:22 AM PDT, Eliot Courtney wrote:
> Currently, `poll_msgq` will report a message of size 4 if the queue
> pointers are broken. It's easy to catch this if it occurs, so have
> `poll_msgq` return an error in this case.
>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Merged into drm-rust-next, thanks! With the fix mentioned below.

> ---
>  drivers/gpu/nova-core/falcon/fsp.rs | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/=
falcon/fsp.rs
> index 7cd9604d1f4d..3752448df431 100644
> --- a/drivers/gpu/nova-core/falcon/fsp.rs
> +++ b/drivers/gpu/nova-core/falcon/fsp.rs
> @@ -109,19 +109,22 @@ fn read_emem(&mut self, data: &mut [u8]) -> Result =
{
>      /// Poll FSP for incoming data.
>      ///
>      /// Returns the size of available data in bytes, or 0 if no data is =
available.
> +    /// Returns an error if the queue pointers are bogus (`tail < head`)=
.

Let's say which error since there can only be one in this case.

Also nit: Let's also move this to its own paragraph so the success and
error cases are clearly separate.
