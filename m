Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00426606A337
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=zJoUEMa9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3701310ED40;
	Thu, 19 Nov 2026 23:20:53 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021124.outbound.protection.outlook.com [52.101.100.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A7D10ED3F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or5Tsos3nLLrBr/RPPMmy2OzDHzD0DysnbNlPcFyJY6Ynqspc+KDdrZQvseybsHILT+zBncEsyWy7vc0M5bynFspBRO3WamfwM2sqCkkzZn1dTG0mJWI53hC/4u34GmZpgsh+MEDGVZDL1hv4fhd5VSwP7cIRNi49CZtv3+cmJdQXWSH9158N+1ZZWV6Uu3+8wkQOjFq48f/UOFxs5QaQA6uRxjys2d6fQHw1K7s0a0QbMH+s7pWXA9jhlfhECZOc/ZyuDgCwwyHxN0cYnx6rKyIxwEUVA3UYJzZSnziS06Y/ocWwuGRL77H2E9qKPSie7bCh+u7hPQVCht2r5N9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFdIBzj7jPjmAEYdYqSTKueuk4HqrKc/euTpVsaWTeo=;
 b=lfZXgAOD/ckTgqbpQbgqMmzIthsH4oTiKAUkdJu9btMlS3SquLd2Umx6tvi3qQH8gwmJSWYngEtHS4zLfl0k1niOI4HQiunBDcLSaloy5y5ZEjxOX7WjB378N3NfxxNQLV6kL9BYc12GRSrXvZiov6xrdpmin1vZ35FnuhgUPYU/6AYOgBWjlIntIOkRJ9WdZl33q9lWzlvKWqL/2ZhSEZ9IQYetCSNiTSSyxGr3IXNCxMHZ4b7LCucw+5IqZi+SZ+B4m9KKjB4SLI3SWKawPF66sDcoWtxEYCH3ezY80xH684QB7DtjwC0Dt3jxlTAzd4gcE7ndB1bLMvWFNui/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFdIBzj7jPjmAEYdYqSTKueuk4HqrKc/euTpVsaWTeo=;
 b=zJoUEMa92gzBLW9/biBJ1h08ZEXo6P29Yptwt9CCD1BNTqwBsizbJkfUkYNTv6NxNG/j9Uf2yZDtL30ybHWtUc44qU5WW5f2FTEdPS1VuoaAvBDbkXLCSuv9vO7X5BkCaPqu3N9w/geTwQdLNGlz+DULx348Ss4M+QBRv5Z/wqI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO4P265MB3630.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 23:20:43 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 23:20:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 23:20:41 +0000
Message-Id: <DMZKMS731XM9.2TGXEFJC1ACM4@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: "Sami Tolvanen" <samitolvanen@google.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: gpuvm: rename UniqueRefGpuVm data accessors
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
In-Reply-To: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
X-ClientProxiedBy: LO3P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::11) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO4P265MB3630:EE_
X-MS-Office365-Filtering-Correlation-Id: 600a6d0a-7236-4901-7ea4-08df4693bb21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|7416014|376014|1800799024|22082099003|18002099003|921020|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 0MkftwlTqU096olooa26LAX6zcvigeS6LFBlCNJRUvsthZ8qsm4iwaYpEiSKsEZYT2EBOfHEFboIoPUiBJukktfNp00p1N5koA4k7SutNiyuWWByW4guKH/ZFU/sOjge+xrUqYoNqpchvK4Bgye71zzpxSMDRCjKlhfKv8ZHt46qCwaPPyp8ym0KgXdcgBkGLmTdlBR9M1GTccfGusRq7GihdGpdhD3mrQj1ntOT9YZIvOkbxpNUda8bUjH1o97TBaSBZbekqxNs+YIIIXAFUD9H2Oc+UeVs35p7pTyV2UaDYNQk5w3ARhWkQTYTvTgiujUCPYE/6iWpQiD6exAeMCKlgMAyRtlgIYXntr+eVVsniL8C3uWwsBOtUtZ4z9+JXdwl0mV2ivYOxPdkqCJ+9gzbAAPQfF2NhPrRBufK7pIdoZ9tLgHfieI+Vo9POE4dJblZ6MSYNcazdC+t4rmKKbN8uuEPkZpxNuVbbaFh+GmBCqtwzXKbdJGcmJYnreY+tGikAusYqntjK8UIMhEYwVmt/KQfj5wbm9cS27Z7WcJoOoi4oXbn4ho1rRxgK7QCipiiVViGJJzkkZjb1BulbFQVBb6e0k/VDULhmDZf5tQlI7QstmFCCVMZIdrLXsMVyVscXXMMzsL5uiIIBUfTxso40mDKSTnm/h/5Ut5+XZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(921020)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk5oTUNCTExhelk1QVQ0dXVyUThGaWw3MkE0RmcxaEl0OGFyVDZUMjFoalVD?=
 =?utf-8?B?L3VXdlhsTUJSK20wYXY1ZlFCTnIweWpSbndrU0Vnb1BZSG5YSEhpem1OQVRB?=
 =?utf-8?B?VmF6NmI5WGl4NUpBejdIaEw1bU1McHloaTRTSjRYNGx1dFQyckozQ2JDT3Zk?=
 =?utf-8?B?VER2YWViZzQwZVNCb0M2UVo0LzNDdkJCOXRuUFJ4cm05Yjc1MVpzSGRNdkZD?=
 =?utf-8?B?VzRwMXBQM2h6U1ZTWW1CaTNXVDR0N09LdS8wNkd6aHljZGU0UU41Smd6dzV3?=
 =?utf-8?B?Q0hnQUd1dzZLczFULysxMVk1NXBucnJHTmhGVDhONk5PdzByMitkVGVYMERw?=
 =?utf-8?B?dVZMMmlFUW5nUElzUUpqb0RUMmQ5cm5TZkYvMUxYUzBJVlBFSnpDaFE4VERR?=
 =?utf-8?B?R1NYaFhNNDFXL3NzNFJLTHFYQThwdGcxREYzSGxKMDhBMlUxaDdwcFJ0Z3J1?=
 =?utf-8?B?Y2huQ0taYUt2UmgxRnk5SUJ0TVJUTmhSOVd3WEd0Nlg0M0pMSjgyR1A2K0VL?=
 =?utf-8?B?SnhVbUVEUEExRmdqTWQ0N0pwcldtRExuU1NPM0ZJUG4zY1hsWmVmUWVNVVpq?=
 =?utf-8?B?c0tsODhhMjNmT1d2N3JWNlBWM2lndWNicm1SMTlUdmY1eDFuWHRDMDJybzR3?=
 =?utf-8?B?MGJQMmVEV3NuYTRFTlVDS2phWnBPSFUvUzNjblppYURTOHhkcDl6K1dsNXow?=
 =?utf-8?B?eXo1UTFDekU1cWpwVHBNMlFJTkZZRm5uSnQzeTFPaXIyUWJZdHhja1AvNVdr?=
 =?utf-8?B?YWhoVXlSUVowdDdZODJsVUdZR0Yrb2x3cFVYY0VqMzhlVXBiUUpFNVc4QnlS?=
 =?utf-8?B?Ykx6NGJocm9BRExVTkVrelhQZjJnYmpaVzhadzNUZGZ4ZHNoRHlwWjFCTEVO?=
 =?utf-8?B?UXhHQ0FhcUJjak1Ya2dzQUJXcFBLRnZnYjZSTXBPOGFiSUVuaG1IMDBZN0RZ?=
 =?utf-8?B?b1B1Z0wzL2wwNENEQjF3eDBob1pRbmtXLzhVWDhHZWZMVVVmQklnZ2VvZ2tP?=
 =?utf-8?B?dDVEUDFJRUFkVGd3dnRTcmtLR255c2ZhdUdzblhudTREbk5peG40bk1TRlhk?=
 =?utf-8?B?MkZpMytZbEVxaE5zTTN2VWhsME5CVnVjbUZLUHFTZnRaMU9WSmlySmhaUUNH?=
 =?utf-8?B?QUl5T0ZHZDJKblptN2xlWVYrRHRUZkpPRUxkNVNXbFhnSjMvcHdOMFdadjVM?=
 =?utf-8?B?ZnV3cXFXZlJiSEVhc3VlN0FGSlBWc0tlZ0tXeHZnemdnN3RqOW5ER1ZGL0Nz?=
 =?utf-8?B?U2x6U2dET2syeGphYnB3YlZTeGN2Ym9rUUVaMWlqTFRkcXBmemZSUVN4L0w0?=
 =?utf-8?B?c01veXgzZmNRS0J2MGRvcEVmb05hMHAwTVY3ckFCZDVxMEZ3bFlWQzdnM3VY?=
 =?utf-8?B?ZzRzYmxya3JnZzBZRXcvK1hzZ2dqSkFHQlhnbGlMUk5nMnI1d3ZaaXM2ci9k?=
 =?utf-8?B?WVVvdHVEeERtUllsZGtNNVQ0Zmt1RjE1MjZ4UERpRjVzdEtIQXNIK0V6NXpn?=
 =?utf-8?B?OHh6ZkppQ2NwK2tkcys2NjgwOVFIcENHOU9KNWFhd3NFQlpJSlRidDJUbExF?=
 =?utf-8?B?dXJHUE92N0FYWVJZVnl5Z0s3QTFsa0NrTExCclkyL0V6b3JOTEdIY2hRWTBh?=
 =?utf-8?B?QkZuMlJtSkpuMmRKb1pOd1ZxeThZRjNXcHFNc1Z3RGt0bzZzQmNLZW4xYVdF?=
 =?utf-8?B?VXZ1cmlPcUkraDBaMmVyWVgwVTVrOUNDOW5jNVYwL0VlY3BTc2xENHJTbG1E?=
 =?utf-8?B?NUFwZmltNFZ3TXRCdmpTUWs1cWZkZTZTUUtrbS9YcFN5dUVmSU44MnhVTlBq?=
 =?utf-8?B?b2FpZU14SDQ3YVZnRCtzK2d2V2FTODJrdkJvc2gvYTdER2ZLakFEZit1Qzhv?=
 =?utf-8?B?OGphcENodnRucnFnVEh4TzhCK2x2OXdDWER5YWhSdTlySWxPN3NSam9Tckxz?=
 =?utf-8?B?RXdUQjkwdUhOSDlYaGVrNERlVDljNXk0d0NrVE94SW5rTzdaTE1wWXVWSGdS?=
 =?utf-8?B?V1NzRWw0SXJjdkY1K2JKUlJNOGx1SVhSM3U4WUR5MVJFdm5Ycm9xMHhha0hQ?=
 =?utf-8?B?U1RNZ00vcGFvR0VGV25ZTE15alRLbXI2azRaekUrNFVJRzJVZkdwRXczSUZh?=
 =?utf-8?B?Y0hxektZSjNDQW5OMmhMNk1PcjBFK1E5c3hyTU5Pemk2Z0NsYkhhdHQvODFK?=
 =?utf-8?B?OTVaNzN6RDBrbE93UnFyWmJETkdTN0M2bERhcllDaC9hNzJNYVM3QVJ1Z2Uz?=
 =?utf-8?B?dUtQei9QaGQwNXhDdC84bG1TbHNLb3BjV3NzK1RRSnNJUVpwSDFXemJXdVFV?=
 =?utf-8?B?QjNHTUNrdVVoRHFTYUJWSm11c2N4Tk10L2tHbkQzRHEzRWQvcnZsdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 600a6d0a-7236-4901-7ea4-08df4693bb21
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:20:42.5086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8/CDbhKgotAKjVWLSFKCZpKRudKYP8BUHjuUnZER4/h7CWXwEdiLVLXeymRtSNf2e7ZIIzIWaPdHAdcisxiMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB3630
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 4:36 PM GMT, Alice Ryhl wrote:
> `UniqueRefGpuVm` currently names its shared and mutable data accessors
> `data_ref()` and `data()`, unlike `GpuVmBo::data(&self)` and standard
> Rust naming conventions. Thus, rename them to `data(&self)` and
> `data_mut(&mut self)` for consistency.
>=20
> Link: https://lore.kernel.org/r/20261118111653.448550-1-aliceryhl@google.=
com
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/drm/gpuvm/mod.rs    | 4 ++--
>  rust/kernel/drm/gpuvm/sm_ops.rs | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

