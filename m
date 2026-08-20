Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDCBC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D3B10E0D3;
	Thu, 20 Aug 2026 00:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubmcy6GP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D094610E5B4
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 00:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxImAcEb2onqulEQx4Tjcb0L0omr5XUKn3bYbK/mvd64KzDVpusiT3z7HmloKEI07V6c2NVt+yrDGclwFIEql2tDOuQorN+yRnej7toea99YF4q6fomW1ub4t5XAqf//5s0aTc+pCuwmv0lXDkYxrUkXtIrzQsWjuAo/aH4pg4KxSIGwAjOG4GLjMRfYwxw62/+eI8uzjsORzBmCPUl4s/RRkddxq/1s/BP2hrrfzyW0e0XRCegUimz2B7OMOOq0t+GWNiib9YHTtfNEMBG4DJDvMG2YCpPiSCDGammV+f9RzN6ozSfyAIWumIIKjTQS4OWYQctHNcsIvfUN78hfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/V5oh+gy5HuYuQ7f0Oom8C9HBPWLYejpmcTOwHfROc=;
 b=i2ZtOp7+ehE2XRDrRyPAVUkI5oeQdBQEvtmtD8beT/oI/8yvOnyf7YrE2+9R6ZZnFBcq2JOLGi8cD4H6z5iqTH4YD6blGsOyFVm2RdGhIgtfB3tIYufeSyXufSShsD5t/1g7zVMalcQMLO1sDDdmZvpG13aBKgzj2OsgqFmZUbx6x7+kxSejJ9BMmPxmCJvHocFsJA5d8UnNoCDxfGgjxGQToP4Ux7smjMgSRBDdT+QwY51tAoxWcFWLe+j4GHAGRYkmKsXM8BpfCYiJ8yxNgp5HJcTphChfQfC+Mw0H4uMmLrCDyRYEYzgibZ2b/m8QehVkMAuHGMZ/6K+Kkj9nig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/V5oh+gy5HuYuQ7f0Oom8C9HBPWLYejpmcTOwHfROc=;
 b=ubmcy6GPQL/OnAhx/JH9mRYa/fppq8L+kTkcLRqmK/MOcW10ixhxSXjfHxk2+eXeFPhsBZGHYjKHUa6Vwp5oTNxsl/bDOUdn6qfUHM19IX50mY81s5SagQZNegaFkX7JV8Y8bLrLgslIxHRc4GEpMQ4vbePa2LsVWu+Onlo3jHYToU3ee13PBo5Se3QytJk60wxUxHTF+RVtlkqy2ouPYLGbESDUm82jITZzu/Mr1ji9x897zaTlNjRYsYLZtZj2N6M5yiRvfVjD084I5vGv03l2FSNT5Sm9Y9AhwHp7erI/3la4uGgYGY1kOonZix7XfKiabytIWZWddZMKjbjLPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 20 Aug
 2026 00:34:56 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 00:34:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 09:34:52 +0900
Message-Id: <DKTCLGI8RHLG.17R4H0FFO4N6A@nvidia.com>
Subject: Re: [PATCH v2 08/12] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alistair Popple" <apopple@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-8-65a00b3c7309@nvidia.com>
 <aoY1pT_TC1VSKMzQ@nvdebian.thelocal>
In-Reply-To: <aoY1pT_TC1VSKMzQ@nvdebian.thelocal>
X-ClientProxiedBy: TY4P301CA0037.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7f3c5e-ddb8-4fd5-8082-08defe52db60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|10070799003|7416014|376014|56012099006|10067099003|11063799006|4143699003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: YJUWLCBU7BAkeS2YqQ/G+jqnNW9hd+xoY1lo/MV5pmNpUsEzg1gT5wp9vGeTknuG8whbAs3FXWEtd/9uLc5W6vocpsFLaBrZPen0V9nA2CaVip0fGv2pfoAACqt4b7SfW7rSo369utZ87t3ADMOaO61ERmMbqlWI+hlg6wImd0qm4z9chyD6sFdjrnZNtcsJgJxB6/VfziA8RtPUlwLitRCBO3OJyb/B8N/ZUGkcj+wupehb7/rHtfMNSacq9MDNEo8K8hrVmTphAGGfblom1TEE6CgY7t6jPhBeZSlp/Z6U0CF9mfRqytmNaOV4gTaFypV4SoQH8bDe45tkoia6/2qrXAmiRiiaJPcQ7tjmbgiP9N5Ph1W/C1k0DFGONxuJSW+5DSVnDKG0J/frz1G9A3thq4o4e4d19dAvwJyx6Dty7C9z+y1OT2x3V4x0lN0PEmTaQSTYqzfuz7Bfm3ZzpUPgA57edf9okIOgbe8ka0eNnx2bXGPxN32J4xTnouciaoC3e52JTrBotNOwI7vDtI685kPQHYRGhfpxBs2+jnnI5xoTiNklS0GVqUIcJcYrEyXQO4i4k6PLJPY4pSzk6goXkkbeTIs9NYwnhpIF1yfO2bSBbDHHahx8YXjV+OPGRld5POJAeq10nr2j/q+9PbJEeD5l9nyTNN3cRw1rZmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(10070799003)(7416014)(376014)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFFPRkx0aE1kQitnalMxOGJvZGJWWHhWOG9Md0kyYWRnd3E3bU8zUmpiUnZw?=
 =?utf-8?B?Y2NJNVc2NjVPYlJlZk4xRy9MblJuLzkvNnZjQS9yZWRDdUdFSVBGVk5yS1pE?=
 =?utf-8?B?a3UzbUN4RjF6QUtvam4xbUJ1ZWUyL3QxM3I3Z1F6Mm01VG11WXZGK3A1RUtj?=
 =?utf-8?B?VUpkL2RmNVh5NkkwMkZraWxRVWVUUzN0U21lWjVLYnEwS1BjV0docGljcjF2?=
 =?utf-8?B?WjZsMU5EN2V1emhIa0N2NGxYaVJoNyt6SmVhaUZHVmlQcjNPKzlMTENSSzJi?=
 =?utf-8?B?SExkYWxiYUhCWWpDaHk4N0JhQU1NdUNWU2phRU8xN0FuOFc4Z21FZFIzZHV0?=
 =?utf-8?B?TG5qUFBSZzA2Y0NBSU9MTkZPVDNhem5YcXlUdW92YjdDcG52dWtPTXMyeDdQ?=
 =?utf-8?B?dFNobXQ0aHdDNEJSa2F5TWRHN005YS9lS3hFYlNOaWNxWUM3ZmpGL2NmenRq?=
 =?utf-8?B?OUplU3RlZ3VxWERlZ0lWeUZGa0JBWGZ2OWI4ZkhYbFZDRU5pdS9aalpQRU9k?=
 =?utf-8?B?eTZiQVJHNGQrclFMMTNTaE9od3NwQWF0ZEdDQ1RrVmJkSGJFWVA4ZlRsUXU3?=
 =?utf-8?B?V0xVUnFsdXc3cjNHcndDR0FiSElva2o1emlxTW54UTBCczhONjNBdjRJR1BQ?=
 =?utf-8?B?cVJyUDFpL0I0TjJEVUY4VDJYbUI4VDdsKy9uZmd0dmZKSXZSZGtGMjdWVm5j?=
 =?utf-8?B?Y2R5L1dNcHNjdWlsYStRR01QU1pMMnZ2TFRDTjQwMzBmYmE0eEVWcXdjVkQ1?=
 =?utf-8?B?TGsrNHdPeXZPVkpMK0FsNERzeXNXUm1xRnhMcytCelZRTVh3WXlSeGNDc3dP?=
 =?utf-8?B?anMxQ1RJbTFzSXZrY0tNeDZFY1lHcEhEVlhJc1JJejRLckhxaWs5TUNjSUFq?=
 =?utf-8?B?OWVLSUVkZ3BHL1UwYWJyWXMzZ1lpQ01CQkllR0pOKzh2aGRDZzQxYVBRZS9a?=
 =?utf-8?B?LzBHSlpXUHlsaWo4Rit3bzhXVERBM2ZmOTQxalBDdDdRY1dvT0pTdmRSUmFu?=
 =?utf-8?B?NVdDZHMvMHlsUkhoMnBKOVNnVHhPTVZyc2lPYlE5WVhBTUpvVXhibWYwS0VJ?=
 =?utf-8?B?Tyt1WW1odnQzdXZ2ZC9YbmtpK1BVVVJVaXl1S2lwWFpNWGc5UWVReHJhSzN5?=
 =?utf-8?B?ek5UMktvMVdkZ3ZCVlZuWnd5M204MjhuVWl4dWplRjU1NnZHNzRONGlFVjBu?=
 =?utf-8?B?QUo0K29sUUN2dnRGNVJXNXQ0SldJcDhWVHgzdkxPMlRuRGEwMFlSMGRvN0Nx?=
 =?utf-8?B?d09zb3E1S3pMTlUrY2xVNVB4MHY0OEMrak04aG1SWVhjSXdHS1M2SGt1bGNl?=
 =?utf-8?B?VzZpSmtSMFNBZjlENXRNRW9yNEFwdnJtYVFXbldMckUrNEZJSWg2QkRGa3Ew?=
 =?utf-8?B?OGpCQ1liaDJMeEtBV2ZkbEx3d2MyWlZpSzhKMVU0NXVoYkg5RzNSUXhFY2VO?=
 =?utf-8?B?UDNOb0gvK2ZzTVAvUlBGTDNCZHZoNWp6SzNFeExEeW5OM0NuWFEzL0o1N2tB?=
 =?utf-8?B?Q0tmSnZoUmYweGppL2VBcmE2ODFzazlRak1iQnVScmQ4YnRyMGo2c0tUa1RK?=
 =?utf-8?B?VXpBQVRDaHBZQTlscDFxaXVDQ2FMRmRxWXljVHNpR1NpWkdmSFFHSVBvRzQ3?=
 =?utf-8?B?eDB4VU5rd1k5RUlBeWVHY0NmcG9sd3lFTWk4cGU0YndESit2Q2FaMWlyY1dt?=
 =?utf-8?B?SUp3cUx2SkdrN1VTL3NTdzRIdHFJMkVIb2l4YUJSdkxKTFhaWFUvTjNDY3NT?=
 =?utf-8?B?NjVGSXQwbnBSOHBlNG1tZWxIYktHWjVuUThvZU1YbzNmdTJmTjVlckdObmZX?=
 =?utf-8?B?SWIrVkxiZlJEQ2w4dlB5SEJnTlNrU0JwckpReGtOeml3UENyeitlbTE5ZERY?=
 =?utf-8?B?dGRUZ1dyMUt6Nkh4QWhkN3hLb01aSEF4VnB4d3l0LzNUVHZVRGJMUjYwQVlO?=
 =?utf-8?B?RTZBeUw2VGdvR01CL1NtaDFxR1h0YVFneE1lRWFSZUhKckhsVmxZc0FTM0dl?=
 =?utf-8?B?Q1JIaWJPS2VUaVpBeUdPVUorVTlHMkZNMDRPMHZUZmx5dFhtMUVRaWVmaHhV?=
 =?utf-8?B?L0FXOXUrdnZMZGhRQ1dPcjc3dG5sVUkvNVBHdWIyRUppWGJPdlpXS1Y3VE1D?=
 =?utf-8?B?TGtZMk9LclgxTCtQT2ZVazUwR0wxWTVVZ0lxbSs2eVowcjNTTzVhU3ZyTkJB?=
 =?utf-8?B?WXZodEl6eVdGZ1hGeDJVRTNQaWtZdzEvYnpkdlZob0gxcHFaU2hLSkJ6bXN0?=
 =?utf-8?B?cW9JdVdyL0hrNWp0SWNZdklsLzFLb0I5emNMaXk2L0NxN0hUWXMrY04vU3NH?=
 =?utf-8?B?cXdrQmZBSGJwWTBCU2FoRHJzajVNQkdvdWlhUFcyM05meHFiNjdzTmFwWWFt?=
 =?utf-8?Q?VEe85uvureSo/mNcFG6toR6sb7JNOTydTR3MP8JsrHIMN?=
X-MS-Exchange-AntiSpam-MessageData-1: 9fENqNePCTZvZw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7f3c5e-ddb8-4fd5-8082-08defe52db60
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 00:34:55.7842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOSHtz22mEAQap2NnCc72uCcpXLmBh3RkowYJ3djX2Ihg41Czi3GQu01RfPM0z5TeMdw3SiRkOQpwtO+l4SFMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
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

On Thu Aug 20, 2026 at 8:05 AM JST, Alistair Popple wrote:
> On 2026-08-10 at 23:55 +1000, Eliot Courtney <ecourtney@nvidia.com> wrote=
...
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>=20
>> PRAMIN apertures are a crucial mechanism for direct CPU read/write to
>> VRAM. Add a `Pramin` manager whose `window_at()` returns a typed MMIO
>> view of VRAM through the 1 MiB PRAMIN aperture in BAR0, validating the
>> view against the VRAM region and repositioning the window as needed for
>> the accessed address.
>>=20
>> A view borrows `Pramin` mutably, so the window cannot move while
>> the view is in use, and it inserts an ordering point on Drop.
>>=20
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> [ecourtney: split the registers and HAL into the two preceding patches]
>> [ecourtney: rebase w.r.t. Bar0 lifetime changes and register projections=
]
>> [ecourtney: drop the window guard and mutex, use &mut self]
>> [ecourtney: position at init to avoid reads, reposition in window_offset=
]
>> [ecourtney: return typed MMIO views instead of read/write accessors]
>> [ecourtney: insert an ordering read when a view drops]
>> [ecourtney: declare the window location, drop the doc examples]
>> [ecourtney: add the copyright header, doc and naming cleanups]
>> [ecourtney: the pramin module is mm-internal]
>> Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/mm.rs        |   1 +
>>  drivers/gpu/nova-core/mm/pramin.rs | 178 ++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 179 insertions(+)
>>=20
>> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
>> index 07dce4ce2473..ef5b1cad56c3 100644
>> --- a/drivers/gpu/nova-core/mm.rs
>> +++ b/drivers/gpu/nova-core/mm.rs
>> @@ -20,6 +20,7 @@
>>  };
>> =20
>>  mod hal;
>> +mod pramin;
>>  mod regs;
>> =20
>>  /// Physical VRAM address in GPU video memory.
>> diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/=
mm/pramin.rs
>> new file mode 100644
>> index 000000000000..20be3fc471ba
>> --- /dev/null
>> +++ b/drivers/gpu/nova-core/mm/pramin.rs
>> @@ -0,0 +1,178 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFI=
LIATES. All rights reserved.
>> +
>> +//! Utilities for accessing VRAM through the PRAMIN window.
>> +
>> +use core::ops::Range;
>> +
>> +use kernel::{
>> +    io::{
>> +        io_project,
>> +        register,
>> +        register::OffsetLoc,
>> +        Io,
>> +        Mmio, //
>> +    },
>> +    prelude::*,
>> +    ptr::{
>> +        Alignable,
>> +        Alignment, //
>> +    },
>> +    sizes::{
>> +        SZ_1M,
>> +        SZ_64K, //
>> +    },
>> +};
>> +
>> +use crate::{
>> +    driver::{
>> +        Bar0,
>> +        NovaRegisters, //
>> +    },
>> +    gpu::Chipset,
>> +    mm::{
>> +        hal::{
>> +            self,
>> +            MmHal, //
>> +        },
>> +        VramAddress, //
>> +    },
>> +    num::IntoSafeCast, //
>> +};
>> +
>> +/// Size of the PRAMIN window (1 MiB).
>> +const WINDOW_SIZE: usize =3D SZ_1M;
>> +
>> +/// The PRAMIN window, which is a 1 MiB window into VRAM at a fixed BAR=
0 offset.
>> +#[derive(FromBytes, IntoBytes)]
>> +struct PraminWindow([u8; WINDOW_SIZE]);
>> +
>> +register! {
>> +    base: NovaRegisters;
>
> I tried building this on drm-rust-next against the base commit
> (4c9ba407018e8deb06dbc643112bac8f40404f95) but am getting some build erro=
rs:

I think you also need [1] (the v3 might also work, but not tested yet).

[1] https://patch.msgid.link/20260805-typed_register-v2-0-c3ca142220a0@gary=
guo.net
