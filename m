Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511A1C531C9
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B8610EF80;
	Thu, 23 Jul 2026 02:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IRWodZD3";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367C010EF80
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zH3Sc6zawWC1bGemSYu11NtYBcg3Iu2xMMVg6jPg1QsPZnqcHRcIA6eHSX8FSTqmTdsjaYbtau1YTg0KBFDzlzIxxYOjnnjxhXwpfApnmX6q4k6H7AqxYF7bCDkGjsrHTiQSB5NPBtXIxM7oSI07mQZxKHdMWypvbdj/ebNG9XwlvBaQc1bLL/R/9qUtnkjrq3PXc5Y0wDe5qKR80PpciE3UXuN6iLh4WKiE2cJ+GVqlOeOQt2k1kEohTCfPKswXkcT74zKRL7MN99/Fx1MLQhbEaA1kWdHFYraPX3UxAf4NS5HvGoMO8FcuICv5Eml9FN2zrjUcGLMxJBJ9/xR0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38e9siM6td1PizVYEUHXy1MUtrS/4vPQ4lquo3aMEPg=;
 b=yyhEWg+wEk5Orwgb2KRaRVR4dDKk0TkF6fWS1RUmtPj7UiNCoqd7TQ0ZGfk6OIo80MqBAAHzPrkP8rif4Nb4j/UlKAAFPxjXw36DGyIecK2fkq8675GX87lruCNHP+nBGIS5LLINU050s6Rezcq3Uzpgl10YuDPokBksy/HOxsZ0KuKjuoZq/BjnuNB9h0s3aaMDgjc7V/zUG6axv6Gqd2vHVU1+DrHlYzS1Ml70ZVzJZbgoO5+MVwdevhmaxZQWMMhFHjb8GvTyqj+lFTMfciekJxyQ5N5u6zwTH9c2Opy0XxsyYoO9WamS3hF1l6uS3ZaOByi03ObB6faZmqz7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38e9siM6td1PizVYEUHXy1MUtrS/4vPQ4lquo3aMEPg=;
 b=IRWodZD3OBtz4xGyDEh1zDy+pLKVy4WfqRc/ZOZFpyU37WCw9YSAsNKCybPUuGliSdksYhvGLdHiNQKS5G7nX/BSZPymh4PlR9ewZVPIB2dA+gB/G3/jsgAkYkCPl6Tkr/CTQAjXFzN598PoucVtHhD6Y7fkgE7qmPnR6yzqPhxmO//Gf8YLgTLjOos4S4prwjfoPfpnjCXSQMDQu5QwmxDeqY5xG++T/CDob6CG0HhXck1vSg9tHS9L3XfAxOsfxgfmcOMsaeWgTLkFzssoMGIdUH5CrhkSwV8Wdv/E7585gUPhzS+FbqJhWz0L/vNGjjrpEQ05vk9MT1HkFOfAvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:56:43 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:56:43 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 11:56:39 +0900
Message-Id: <DK5M2RGC0B4S.1QM3X5JHA3F98@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] gpu: nova-core: correct RISC-V HALTED field
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
 <20260703-blackwell-fixes-v2-9-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-9-8e3d8bc32bb9@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c25099-a20d-49be-fdc6-08dee8660698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: HMZ/ZRkOay/9lw7a8DDzflzaC6bEqOdiEqVt8non7nxR5WKSwgYA06bhVFseiM/YQRVUhWE9Qc0VRRkievwrvVyw7vPxKpukBnNYzgJg2QSSN/KxqRMddr3RKaL4anWU6SML+C27K9bxBptTSdd8hz9xlC6R7jLQ2sYBU80j1mUUdDWKIYSY7hseog92yAJARp6RTwKLWQc4ioEB5Btm99bZqYH95BWPqs6IR6BZ/L3VIdkmv+Xlphh1D1x21c8GwnedbksRxA9+p4yvDap/L5PxMuuNCfSDupQUSTOF6dkLgjsg1anFy4izmXMKFZ2g12MJmmBb/oDxC2dvVEGVRgvuQ7z8z90RT0tu8eNGVUA+2prAuAe/D3UzrFyLses+UQkmFcUmD8v75rcop78cLzZCBWyVjqv9sR0rVCiJTpqx8xkL/yw0hJsCIjKH3xb70klOlXBe3BNzqtzQv8L0zDq0WVBLdkT621dZ3XDoM8z2PK4RHrPcdc4OxYWFJ1xjyhFlaLIdROAKq7e7eN2PwxPYJ2yUlbM2lXTndUs4Fxe2F01gNs9kO2w9S6rZK3ALZH7cnp17SdwaAYFtsn94JZQ4JhGzA9/Z/hNw5RN2ZXzu3eHf2l2rZg0g5LohAFXx1n3EEXGom6b3NxSe9Z2sK2ZTN9uSPKGQrpMEU+/ibgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGl5a1FhbVlzc05Ua0FVdnh0WVkwNlpLUTM0OGw3TkpNQlU5eTZHd1RwdVlS?=
 =?utf-8?B?NUtJcTQ3UitTY1NwOU9MOTN0MGZhb2tRTklndytsRGFkS2VRVnQ3QlFIWU9P?=
 =?utf-8?B?a1VmM3k1MlZ3K0d0eU5DNWlmRks2QjRiL2QraEl2dXV6WHlTSVhweWhBeDlq?=
 =?utf-8?B?STNXck5OU0dWMlIrdDg1MVhuVTZMZEFHZFBRTmUvUTA1MlUwRTB6SkJvSTVI?=
 =?utf-8?B?eGVjdERlZGd1YWh4M3IzS1RxZUlEYVVQRlJLYkFlMG8rem9LRFBBMTErbzMw?=
 =?utf-8?B?OG9qQWphcnJqT2F2SllTNWNBY2pTdWhBK1lCVExaNkl1WVkrZDBRL2xEZWtB?=
 =?utf-8?B?RTZtWGpKck9qdGlOeEZzZkdBd2c4Qjd4TG9xOFpKc3B6ZjRZZEpWRkRmc2hh?=
 =?utf-8?B?UFpMQkErOXMyUWJWbXNzOEg3SkxFZmk1cnh4Z1ZaSytxK1hzTlJQSXNTdHYz?=
 =?utf-8?B?azFzMVdKQmk4YTZHcjRMYm9xalRCbDJycWVqSXJpM0RtZ2h2SkpHMGw5Mmcr?=
 =?utf-8?B?b2JHaXZ6K2JxWjJmdVN5RjFmKzFJVCtEbStLZUxkcUxvb3BpeWUrMFBnaWdI?=
 =?utf-8?B?OFJFaWJkRElNem5CTjVRZyszWHBmNW13QjFGN20zOE1hS0l4elBPTjFUSFRr?=
 =?utf-8?B?dnJoMUh5YmdTVVFxSVVZdGcxTkF2enQzbDFHNWlaeTdYQUI1WFJVY01qM2h1?=
 =?utf-8?B?WHVLM1QrQW1vT3dycjlBYkZ5b0svOGZabVpiZUVNWWpQRE1PMkY3MWVvNVkw?=
 =?utf-8?B?NmZEVW0ycEhpTzcxbllzRTlYYmdybVoyTFQraWdGNHNTeUpJQjFXR2Z0Z0Iv?=
 =?utf-8?B?KzBrL3hETWZpWllKakxIWWoyWjQ5WGxjRDNVTWJwbFVkSnZ4VzAyOEZQaFRq?=
 =?utf-8?B?cjdaMlpJUDdBUXNwQmVDQ1JKc2U2cm1OYTdnNkZLMm1XQ3JpbDUyYlR6Ukc2?=
 =?utf-8?B?UEtXS2NEb2xLbTVWMElBN3F5SVUwS0Z6MnRyTGxpSXgxMGRVUzdTZ2U3WjNh?=
 =?utf-8?B?RHRETWdvbHV1NkE0OG96bW8zUitOYk9DaDZ6WGtneUQwMGdHdWpRSjMvSDFU?=
 =?utf-8?B?K3BiNFI2QldDYzhSSC9tbWRBTkx6WUxBVm9NdHZUQlV0OGxFUmtQR2VGMEpy?=
 =?utf-8?B?K0hCWGUzZmZKTkNPeldoZ1FJN2IwbStHMmY3ek5IQ3VJNTRWN2hTekhHR1li?=
 =?utf-8?B?MnBFT3J1MEFXS2x2VHR5aFh5akErU0hwV2lZY0dpUU40L0xrNmFpZzRPWDZk?=
 =?utf-8?B?SXl2enI5WUVsQkJDbkpxWm82bFRVSDd6c0NhVW5OSkVaOWw2SjRPSWlnUSta?=
 =?utf-8?B?SVlKaVFWT2RrWVNUTGxneS8wdHl0ZzBpOXgrbG4vNHp0MFczVnNVdEFmbDh4?=
 =?utf-8?B?UFBwbWN4amxMYmdsL2hRc0xqbERsOTJWTGJtSHhUdVFwTGtUbDNYK1F4RUM1?=
 =?utf-8?B?UkFDdnZtR3FFTW1MNlg5TlJRL0hlTUZPT2l2c3piS25MNUQ3WUtyNFlEb2dK?=
 =?utf-8?B?eUVGcjdWREhudzdnUU44UFdoWEI2NDNmZFJlb1M3WGdRdTh3aUlJaXdhRHR5?=
 =?utf-8?B?NldIMmNYQlZCZFpGR1krcWtoOHROUzA5Z0xzbFRMeVU5VktjckgydUh0VE55?=
 =?utf-8?B?SFRjak9GYzZhUWJMNVhqdG52YW84VXN6K09aYVFid0t6NXhtOVdQaWtualI1?=
 =?utf-8?B?Q0JWVlYyc0YyQmFleGRHTkhHOXpvT1pqU0gybWpYbWlrREdHRWVIczdCaUZm?=
 =?utf-8?B?dERlWGZNcVR4a2kwZm1oMTJtSlVleFV4bllVL2JiRDA5emIyc1djRnhQYnpT?=
 =?utf-8?B?TVk3REg2d1VJNk9HdmFQZVBXRnRiZk85VXNzSEIxL0c5bGlOOVdNcyt2S1I5?=
 =?utf-8?B?S29yY2ZIMkJ1TTV2aFFScnA2NThzY3cwWlBQekxvYXZMb3pWVkJPb00rUC9p?=
 =?utf-8?B?SitEeFo5d0djemVKVTIyNDZINVg0ZDlOKzh0Yzd3c3lsRFRQT1RkT1hTQUpQ?=
 =?utf-8?B?M2s0MjRXTENCV2dXZm1uWmlSdTl0Nk12T2hUVGJDZnNHcG1kZldjbEtmRUtn?=
 =?utf-8?B?Nk5hMVJObEpBVWVaTkNDT0xaSGJtekh0dGZpM1NlVG5QaGtoRStWRUFXOUZO?=
 =?utf-8?B?V2ZDbENzcTErbU15UzQ2QW9iSUx2bU9mbVJ1anVpOWRZT3BOMVpSL1EyLzNw?=
 =?utf-8?B?Ujg1SW11dHpFa2Jyck9GRzVtbTNORDFrWVQrcUtWeGtxMXJVN2luQ1JiK0RZ?=
 =?utf-8?B?R3FFTUIwQkRvSDZoai94U3BTUmNtRXIvL3gxSy8wMnBNdnV3QS9rdmtmWCtD?=
 =?utf-8?B?UG9XMHhYcDE2MS9HME5lcTBvK2VaRjliWnRYZmI2TnZHeXgwdnIzVGJUQlJy?=
 =?utf-8?Q?tsMeij1C27AmNwj/1q3cKVku6oLmsK6IRmKMsBNzJzfye?=
X-MS-Exchange-AntiSpam-MessageData-1: DmLpLSsSRxLpkg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c25099-a20d-49be-fdc6-08dee8660698
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:56:42.9656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aCS7QktUSeqv7X7LhXRpLiq9OqUes4IuyMCa0npwBVHmwShCkp3NZGax6+YSszjDHVoJVPizGcXa+qxKv4WKw==
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
> This uses the incorrect value, so update it.
>
> Fixes: bb58d1aee608 ("gpu: nova-core: falcon: Add support to check if RIS=
C-V is active")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Pushded to drm-rust-next, thanks!
