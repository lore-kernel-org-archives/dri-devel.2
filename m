Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C418BC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C350A10E13F;
	Fri, 18 Sep 2026 18:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZFLdfW8m";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B947A10E13F
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 18:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlGTU1dYSLqymDnVd5j7iKZyYw1Bb9jv2rKuaqhee7r+Gqvn+5dayc5sjvt3AGIrZCcYwqXhc3jLUZOp14hXlP7TiTlQWRJsRmOxudXGlLZB3ZPElPma1DPsEhJ1q4J1T81HAr3fD0cT3BTgyl4x737XizNKZbVKMqXp4/uHNfj/TLJhJz7Zd1Og5tvkr22rN6egHlcdxreJt6oYGebGv6H7MWRSP0DMQyZs0E0tEyG8tB8pYh8BYW7uElnk4OfISnwPd4j5B4MgwcboCBeGb71lNpRqEC7UWvvXGABAPRQhSKQOyHzHgGvqq7Mub/mCT47wl4a54HAISQPkvjrxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXip487AwB3QCP50KrkA5KKJruLYslFxtJ9s8Kx4GDs=;
 b=tXzteToXV91iVs4AyThHrX4x8E774AmFbawMvyFyQIgxtK/CrSV7Qq9XLguLWJelq1v/xP7pD2TRQf0LYJVuwZDoT0ohYIWajt+d2HeMigscIwjOKt2aANMbQUYBAar82AVcuwESIpjsrPJkImn4DhyT5XlQYb0cnMZ4IwJwt7Iu/j/AQSTiE9skv4fNwfL091/v56R0OIDY195L5T/VWrsJcv4wfBaAF6KNzvPXmpI5cbit3Q/BUei6Jl5je16DczWbPGYUP6UqfBxdxUyDiLQMQ9a4Uf+q9wYh5K4wsPbXOrF9hiC7IE8hYktZ0Dbbji2I365TfIg7avdBGYKtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXip487AwB3QCP50KrkA5KKJruLYslFxtJ9s8Kx4GDs=;
 b=ZFLdfW8m5FKnqtg/DUbcfdI1KWEpa5wX5njuX2y+0iEjv2mr2mcRTpWbV406hFAXk4X9bmYbwaarHj5pTwSjN4hdFipiPKeIk9n8a5wg1Ha67DJ+gLfYcFSOz81mbI11nqMFGmo+KLCpYDv0BTUQG/fb17kRdf7X1pGQg2GpvnEU3wFOsGLopsOd76W+ynTauyozU/10ugb4o2QyuaGqoS/mSMjEU2qMv90/CXNIfzdKa/F8Vz1GAlNwl2xJe0iGWqqgGr+sI7CIXhEHTrxmYpWCh2UZHyofhGw948zUJbtSfbusHq7hmUEtxp8CNm1sai8vsEzyVZsnh7GwUp//og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 18:03:22 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 18:03:22 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 19:03:17 +0100
Message-Id: <DLIN1ZH244ZA.3JVCE0YKWAQ6B@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-1-0f90659e711d@nvidia.com>
 <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
 <DLHGQN9VQ3TE.JYI851RVF7VD@garyguo.net>
In-Reply-To: <DLHGQN9VQ3TE.JYI851RVF7VD@garyguo.net>
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad0169c-212a-460a-ad75-08df15af2000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: fqR0ohqDvEVceEwo+dB30ktdYbv3ucgLZfp/NTMGPDeSxrCBoHO+eXv6cb/M3+X61BN6pdLaTT4VyZQS+CCgtOamsBAXX7qz6vxpHJEv2BHp5QyiTg/V7t9W95rmogMGoVVphdgJM9JQNVl3ujaUt5KJOlt52u0fMFY9oM71Xb+fMM6pLtZptUh2iadh+pad/BGNzOlMehbVVQWbdD3E9qV0JCrEkEfZjz04NWthmQdBySjfK2xcQTSFL2XM3EiZP7AU2+N4WCod+8IrrDHJgKRw7/QO1KSMbdg+IaPIX+NZmLRXNrm5sYjEp3G3PDWDWhFhnKXjmleMuLXD/K7nZIMGCxmW3WN1cOIJ/5wDKJNLX6fNJ7HvnZ8nO6y5vAL3/46czCgfUnw8VLhdpDZxHPpZtUo81wn0Io/keL8SFXw35x/YE/hIWu5l6S19CLnTyDQmA4mx1wDbUL4gtQz8rczYoNmsuWzlEo8Vy3Fh9VOs5jeagsJ17zvF0F3HNhAuKA9plpbZvLyauxBaBKuR5oANa+JKVSxylMhKDx/ug+Ru5cnINJzHjnTX5pI/fMOEVtgKx0nW5tJ9VwroP/fZOz+vJHhYHcFhC6PKQsavzglCwT4DUsExaXfeFnpsGszmiqHV/69Wbr36Sma7qGGFDNRwNsSBkrA9KkcZaWHLIVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1FiYTc3TDlPbXBFNVNkY3FPckJHcXQxNjdMdkl5RXgydS9PTjFSTCtON2Y3?=
 =?utf-8?B?ak9oUVJ5Y3NvRWZyS3VUSC8zNXRVNm9ZaGhGenhrUENvV3dmdmgyanYzZnNN?=
 =?utf-8?B?dStJVm1CWEFvdHVXOURKNUYwNmlxcDBqOTFoMDJSRndGeGxjbmgrNE55N1lS?=
 =?utf-8?B?OHRuYUpFK3NEQnJIRXIxQTJza2ExK25aM0M2eUUraUtVMnJFVmtOSUVSbUFy?=
 =?utf-8?B?clNjRXhwWkgrL0N1RHRsdEVYcDk2cjFrNWZOQTBvMlhBQXYrNjd6VDNIbTgv?=
 =?utf-8?B?RGdFU3o5QTlBWitWZFJYOTZGNWpMVFF6MTFCeDVqWFoya0FkRTVwbERLdjN2?=
 =?utf-8?B?T0hJaHQ1MzUrQ3MwL3hubnRnWXBOSERubmthWnBSUnpnakM3cXF2SmozQ1F3?=
 =?utf-8?B?dW5CWnpSdVIxY3hhSEV2VmRHaGVqUlh6SDliZVVUb1N0Vm5IVzg4UXZEb09T?=
 =?utf-8?B?cTJMTmNDMG90cFhPTUxRZUhDSkhOYzBvTU84WUV3VkZFTnhXUDBGZTdIVnVj?=
 =?utf-8?B?dzhxRGFLcXdCOXZ1OHZDeko4ZjN3dnk4YkpvSTZnTlN6dkFSOVd2SmJ1bit1?=
 =?utf-8?B?VHNLNzBTbWFTZU5NVXZ1aTR1QTFaeFplUEY1WlJSMFNYTXhYUlArejgrYW93?=
 =?utf-8?B?TGZnUWtnLzdYbzErUzdjdHlqWk83dTRVenAveGdqcG91Nldac3VyNlh6SVRR?=
 =?utf-8?B?cU8wd1BNWm5BQU5vTEs5aDlhM2xIVGtNRDFRbWt0VWxJblpTbytzR2VkRE1y?=
 =?utf-8?B?dW43c09OZnRkUG1IQ2IxSmxxZzJ1UitRMk81eHVKTHNhb2pUb0R6Q1BjRGZR?=
 =?utf-8?B?Y0ZkakxIY2NaN0VSK1FGcDNPaHRHaXp2NzF5OFd5N2FGQ0pkRDhXbWZHWWRE?=
 =?utf-8?B?RzJiQTQzL25ab3BVOVlSeDJBU21UaEp5bnQ0eGQ1RlVlaGhER1RxazZQTk9v?=
 =?utf-8?B?RTNBSkZEUFFPUDBEV3NONFZsS2wvMytCVFBpRGpNQ3NrRk5BV1gxUG5FN1Z5?=
 =?utf-8?B?VHhvbGJXUHZRWmVsMkFlN3o5WjN5RXl0TTJtVW1tQ29vYVQzQjNqTld4MnEw?=
 =?utf-8?B?WkF5L2c2ZlVuL2VBV0VMRzFPWGJidmtVYmpxZlVCMEJ4K0FkTjBRVUY1cjUr?=
 =?utf-8?B?ZW4vSEo1d2U2QjBtVXR1Snh0SHlveHhMaVl6VXdDSWtwclVBV1B5b29ROVE2?=
 =?utf-8?B?VmVIbVNSV0pEU1dFSUtaRzZaSXhsd0RwSk0vZkZWS3hoWURYSDRWZnR1bWZY?=
 =?utf-8?B?ZG9COWxvT2lBbDFBb2tmd1dmQ05aRGRDZVhLbDVkV056cFQvU3ZxejBMWm1r?=
 =?utf-8?B?STZOQkIwSExPMjBLdVlFZThqR2cxNnd5YWdHQ1c3UDhKRjA4UU9MbTJQbE5J?=
 =?utf-8?B?dUlSK2pMcFo0eXR1eURWMGp4TVRadXc2RkFzSHd5ZHBCTE9IQ3pRU0dpME1Y?=
 =?utf-8?B?Zm5NbStianU5YyswQS9vRkFqZmZ1dHNFajdzK0VNM1hVNThkSWxvZExaVEZs?=
 =?utf-8?B?VzZnL0Q4RlU5bmdBT2RMVHdnY203c3ZqUXpnR2dpdmZqb244R0RUMk05OXhp?=
 =?utf-8?B?S3hNM25BajAyY3U3WTZIS2tmWGlGVUFBeUVsVXlsT01lNWkvSFRwSUxSWGNS?=
 =?utf-8?B?NlVFRlpFTS93MXZCbnNGYUJEek9NSkw2UXB4eXNOMnZUTTRQZHNvNE9tM3o1?=
 =?utf-8?B?SUsxWnNZeW41elVHRGxvOEtVQ1lNRkdQUUdsVlNIYkF4YUswT0Y0OGw4S2dj?=
 =?utf-8?B?aHBoY3UvUVJtRzduS2JUWkd4T1dGdUVLUEdaRk1RNmp3blY1N29vcHluL2JP?=
 =?utf-8?B?RUsvN1Fsc2J6Q0JxVFArbi9NV2FXYTc0YWJHVUd0ejBWVnAxZ05QdFRCWHFN?=
 =?utf-8?B?c2pvWDJJdTd6SDIveWJpS3JSMk1tNUdaWEtUV0VVcCtIT05ZbWF1MGhaem4z?=
 =?utf-8?B?a0JwUzdzVjhIODNiR1BTUzNWc1htSE4waCs0RGRndnkxOGFxUGtLQ2lnaGFH?=
 =?utf-8?B?SkpzSTFQdUVWTHdpMDN1WllYeHZ1ZmpITk1nNjNwWWRzYkczM1Nla1RaMlVq?=
 =?utf-8?B?RUlTWUU2U3ZRQjBRa0pRN1pTYkpJYjl2WmpTQWpDWWV3Y1dwcEM0aVNvbkph?=
 =?utf-8?B?YnRoRzZ1b3k1L2tvY0puQzdaNWJNaDcvaHVYY0FHSGdPS0MzbHl4Z1BFWnFo?=
 =?utf-8?B?Z25oN1hRV1JpZWp6NHVndTFrenkvMVdKSzVMMTM2RE1HYUhPTlJjQmpPVVpI?=
 =?utf-8?B?VXZldFBqL3FmSUY2NEhuL2h3SWY0dDA3cXhONnNrWlR2YXJjU2l1Rm5kdXV4?=
 =?utf-8?B?L0NDcTZJc3NIdFI3Z2xLT25xWkVpSEdDY0VvM25lcnhyVjk2bVRSUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad0169c-212a-460a-ad75-08df15af2000
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 18:03:21.5577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XceJ6dXrRwLYyHwcq5zAm9fok8AaX2u2y2P3VWaVFeUOqgnGYBC1yA/tg1hTD6wzVmwopE4100fLYALsnISVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
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

On Thu Sep 17, 2026 at 9:53 AM BST, Gary Guo wrote:
> On Tue Sep 15, 2026 at 8:39 AM BST, Alexandre Courbot wrote:
>> On Wed Sep 2, 2026 at 6:16 PM JST, Eliot Courtney wrote:
>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>>> unfortunate because it disincentivizes using it in interface boundaries=
.
>>> Introduce a macro to make it nicer to use. The macro `cv!` (for constan=
t
>>> value) takes a const integer expression and widens it to i128 (at build
>>> time only) before passing it as a const generic value to a new trait
>>> `FromConst`. The value is then converted and appears in the
>>> associated constant `FromConst::VALUE`. The trait is implemented by
>>> NonZero, Bounded, and Alignment and lets values of each be constructed
>>> from constants without a verbose turbofish syntax.
>>> For example, `const { NonZero::new(1).unwrap() }` can be written as
>>> `cv!(1)`.
>>>
>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>
>> I don't think we have any user but nova-core at the moment, and it
>> benefits from this in several series (patch 3 here, but also ID pool and
>> later r000). Miguel, is this ok if we take it (i.e. the next revision)
>> through drm-rust-next?
>
> How about a topic tag shared between Rust and drm-rust-next? We could als=
o
> remove the old num casts API as part of topic tag and fix all existing us=
ers as
> part of merge.

Not opposed to the idea but IIRC there was already some pushback to the
idea. There doesn't seem to be an urgency to remove the old num casts
API that justifies doing it now with a more complicated merge path.=20
