Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048A606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XtIx3yi+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0786B10E8F2;
	Thu, 12 Nov 2026 13:38:21 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AA210E5F7
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDOuBbeKJz6UegccSJRyjZEcj/FGl0cbWHCILNGuDOKevGl905KM9WfqP5W/yRX5fAXwiJNnlaTCZ3NjAJJhtCY0O5qiGb4e7+mfTRQcRDlV1ZHRbf8rc4Xv7d9U0I+cPD+kl7nERDTEz7BerFdSvHyekfHzYHtk9kUgGAXS8FHzJg6GRbe9Wj/lzCa5h3CrXdsIxthkctQQqZZaL1sKZI7jhN24Y8ZtH4PfOdf6wDBKQKfIKdh4vtnkLuAzXPY1Xz2v2obSEAIadFsCqqHdG/CGzJcsg2JDtibsLVsQGba9pkJn2fQ3EAsAfGqLMuw6F/m4IH+C8GN4CMpnLZ+Uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgpVc9w+PqcGnQYtRpJUaYq90w+BMEIYZHCdzhkr2Yk=;
 b=b804QEQr0iagOjyB2iiEZuUFyRgPAkCEWOPFaXLrmwKRvWlzGKSUIiCStnoepUMsTtcT+4LR5mM7FlJcdNfanaSi/5G6gH7Tx6II9k7oQkjtw5D22BRJ4GqofDxVlTtJ3lpCJ1G8HrT/VzWMO08SjsTLswF+ObLdf/aJM8GqWNkkfrKkOYXpDpo+qEFL9mpaCUgAQfCcB7j/bTMialrFpOn9p8KlZlnw4KGBVksUdkeUBRMQ0SWXJ+zmJktovISY7CLK/PJvV8hdQ96ZnvMy5Ze8VyttlQzDIVkmsZwaVGpIcYCWRhubf0vEWjrm40OsQJRa/dn4Y7pzu5umh+vaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgpVc9w+PqcGnQYtRpJUaYq90w+BMEIYZHCdzhkr2Yk=;
 b=XtIx3yi+gt509qrXR2kGTXZpr1QsGX28ZVtm1Iz9vtDbiPCc73YLunFOpkg1UkGTZYX/h8eRJG8D7nvwiYSsKeqInM/eEqtUAtmW0ORpvDJ41S018lfdbaH3gNrCkI4TH8/POBA0jCPIistbxJojzs5HZbtuMGSALr5GgKTcoiejRoOeKtL/egG2AccIEP1nIVf46tLktSm7pezFWJW08nxErbO1KJ5BxWOnXLNY93sfCOtVhpfOayx0bhH7CXuP+tDqXl1c/PGg1qHUnjtR8bWHa9L1GBYkrRimvSPvCoHujjBDLmeokK7etKyOWziqXijv6jh1VKlfq/qXhfyR0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 13:35:54 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 13:35:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 22:35:51 +0900
Message-Id: <DMT9T6GSVEK2.32Y81TG3H5927@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v11 4/5] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-4-082aa9bf5a91@nvidia.com> <avNXkJjOoTzUu-1r@yury>
 <DMRW81BTJRI1.6KL933YC1FM8@nvidia.com> <avTUWznKqpgUI5M-@yury>
In-Reply-To: <avTUWznKqpgUI5M-@yury>
X-ClientProxiedBy: TY6P286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f258ed-e5ff-4e51-61d3-08df40c1dfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|10070799003|1800799024|366016|18002099003|22082099003|4143699003|11063799006|261026121527099003|261022105027099003|261026140227099003|261028144727099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: J0fM8oMB14wn9d54bzV9nLmbQ1cjdfB0KfA4RtI0K+bn6DfzWl5BHpWlZi8MiO1v5fxDD03AGAtmRjFsIm3stkNkg194ryb4q/Ldwl4XlrDrTG9P+u8nAokVJ8W4kETEHS8/58aQuJu03RtPfdJL/WF6VCQgdpe/x2Nxz/OCkHSxR0vDwok5ZgPPUVuCh9LGs/VckOoEC+YSYfXNy+812WL5NjawOVEocnNi8cQlP8dF38msBb5aBcU0PmF8+8V9Y09EztJ6r+07vfuEn0lPKLCX/DUPvYpGctACr8fEx6bQg2GOT1dMbY7PvYrBA9YhJeq+NNJm4a80gVXozOm9qip+NXIZ+YubMrdGC9T4NBNx1ygJjZW1DJYVEz0i3AXhAewFqsc/vP/SdqQId9hoXRHpYdQ5NpKXzT8jl88MAN793XM8QPn/V+MhZs+V/xtM9klcMmLqP6YkO07p4A4cDnz+2ErWuxeFKdF4JGxK2RKZvKp+zkQAwaDFF+lTXgoY1Jpxs2Tsi+nB01VZPYRHcyiVrl5+BwUOYwBideFNkv/Rj/HHlwzVGalq2G3Q4DITNE6MfykOAksJBKV12LSHPsMvDtD3pY4v0X3GMo6SmQlI2hsRpVFDqvRTxmUCSggUv9LRSHLQY4nOdJfeuwmHCFmc5fBbGQ8pjNCtCYG0MdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlphOSsyK2NrY0xWRzJyM2VlT0NCRisrdXVZSEVjbXM3ZDJHOGFnaUFOS3Va?=
 =?utf-8?B?OVdSVHBqZmJiY3dpNjZCcFBWYzV0Z2Z1VS8xL1NyemlETmRxVVVoMENOOHR6?=
 =?utf-8?B?NlJ0UWI3emtJTlFQZ0Z4NXdZemhlWGttZk9JYXVYNiswa2ZzejJjNVFHNnMw?=
 =?utf-8?B?QkVzVFB4WmZZV3JYTEZGbzJNUzRvZUpST2ozNTZHRER2eXp0MjViWmRSa2Vz?=
 =?utf-8?B?NlNpVmFkdmJNOHpkK1ROczY3S2tlcmZRenJYSk9KUTBwekI2Uk01NWJidU9s?=
 =?utf-8?B?WmM5bjlwRHg4bFZ4dnBDaHM5cnJYK0w5L2h1SzRkaW9pOHdOMHVBRitUOHln?=
 =?utf-8?B?OENZY2VsanB4MjNBV1AxT2IrbjRBSktGdWo5OGhKMks2OEMybS9oaWhkaFhU?=
 =?utf-8?B?UEwrQnVaTlZmbCs1dnhWdnpGUTlENHRxcG1LbmU3djEyTGZuQkp0WjNWT0l6?=
 =?utf-8?B?RHg4RWtUeERHL21WS28rUkpTbW9GNkN2aGpudGxlQUNrVTAxTXR6NlllK0ZZ?=
 =?utf-8?B?d01XVnB5ZXYwTUZpSUVpZU1tMktvZ1hneTBVZ2tqWlpTOS8vbVBmQi94N0Y2?=
 =?utf-8?B?UFlBcndreXZBQXovVDFiU3ZUTS81ZWgva0xFVHhLaE1ocmpLcWZzTGZLelBL?=
 =?utf-8?B?UlVIOWcrVHN1U1hleXR0Q3VzMTRaemhnU0Uyd0hJNG1mYkl6UG4zcG9YeFF3?=
 =?utf-8?B?NWVmNVVDUWNJTFNSVm1TK0pHWVI3ZUcza1BsdksrSXJSdVk2Ymp5OGlMSVlL?=
 =?utf-8?B?YUM3RUViVU9VYzkyaDNUN1lZUCtsemhwanlaeWlWTzBhNm9vVlFldHVmanJr?=
 =?utf-8?B?eEs3UVlXOVlIL3Z1SE9NK0tWUUNhZFdjcmhOdkpuWk1KL3BNazZZTlJpUkYy?=
 =?utf-8?B?ajVpSTZ0LzVyd1FaMTkwNnRaRGtGWHdwaW1CUWVYWnA0N2VYR3NqYXJTcUJo?=
 =?utf-8?B?a0g1Y2FEMlprM2VJS1l2S0hGNDZiZjQ1U1h1bmxacFJ6MjFnWjJkQ3F0Rmc3?=
 =?utf-8?B?dms4cUt4MndNci9BQmIyMzdHQzF5MndOYUsxbG9kNWF5OUh3VmhZVkQ0aFdQ?=
 =?utf-8?B?MGdFR00zRWExR1pPTlZiVTJJbWtKOW84VzJpTVMwYlZvRkliVHhLdFNJU1lt?=
 =?utf-8?B?RkdDRVZyejk0WFJwM29aQm5xNmdmZ2E5cDlCTTR4bmNaMWJ3NzV0U0JqYUVs?=
 =?utf-8?B?Q0dSVjFQbExDOVdUN0o1Yy9hSnlRRjRHZEIrd2htbURkbUs1KzRZZVlST1Vw?=
 =?utf-8?B?UmcvOXlXdE1ScjZlYVBNUGwrdENhb1hhOEpLdlB2MVB1VlA0TlJESFlpcVl3?=
 =?utf-8?B?TlZLdkhuUkQ5b29sVjdFVWIwbnZDaVAvMW94Ymt1MXlZRFJpSVZhTEtIbHo0?=
 =?utf-8?B?ajMxU1lBRWlaNXRlbXRBcEQrdHRSNm5CdFBqaUtjejVaMXY2OVBJOFlBTHNR?=
 =?utf-8?B?NDJwRTQwOVd6czd1dVJyQmM2Q0M4ZjhCcjlsUXY2NkVkTkNQMXlFOHp1a0RI?=
 =?utf-8?B?bWVPL3FsYUxTamQ5WHVrelF4OFp4Y3VVbklhVjZBTkQrbk1IdVRjbDBXZHY0?=
 =?utf-8?B?MDR5L1laM1c5S2R3d1hKZEJwSUJzRGNoSnVoUkNGeDJ2NHl0UktFaDg4UmJ4?=
 =?utf-8?B?NHFxWTQycHZoRi83cGZyTFVsbXJQMWQ5UXZOR0Y3Z0NRb0dTM29hS0JGNFh1?=
 =?utf-8?B?Z0xXOFFqR1VLMUYzc3VKSGdINXpGQkFOTUhpWUsxZWM2dGQ0UlpHaGh4eWE5?=
 =?utf-8?B?emxrMExQdzNXL1hrNE1EaUFNdTArVDUzQzROMnpJM3BTdnUxNk1BaENpTDlK?=
 =?utf-8?B?ckpweUdCMGt3WmM3amN1M3F3bVQyL2E1dXFzUXJtempjV2JuYVJPSThkbDl3?=
 =?utf-8?B?RGdub0ZvSlQ4K1RsVTBJTVNWT0lhSjEwWTBsb3lnbnM2aUFGaTJHa2tSKzJt?=
 =?utf-8?B?SFNSSCtUYmJDOVkvb3hob2RvSGRJdVNURHJBb2JlQUQzNVJmMDU1Tzdib21O?=
 =?utf-8?B?VzQzZUNFMkJTRlIzcXNZUXdUY3BOUzVjTzhFVnRDQ3FZdG1PWWJXN2c1RVNX?=
 =?utf-8?B?aTFFdzhsSEJrZ1BaYmFQZlZlRm51T1lGSkN2WkYwZWFwdkh1SVZsNEFFdXhL?=
 =?utf-8?B?Y0R4Um5HeVpDaFVuRmVjNXcwUi9lNTUxRjNRZE5Fc01CV0xKZGN3OHFUNHla?=
 =?utf-8?B?Q3gzSjloYk8zVlA2MEtoMnYxaGltUnBRT21nanZQR0VZWU1JRjR0R0Z4S0lS?=
 =?utf-8?B?dldmbkpRZ2h4T2dEUG05ZUJTRXFQM0dlaGsyVS9EbTM4eC9YMFU2eGZxVnZ5?=
 =?utf-8?B?RksxVExnUlJjZU5iY0cyWXhpYWlOaDlDc2hwRmJiSFVxekUybE5KYVpFbUpI?=
 =?utf-8?Q?FHycmw6R4eixgSmd0HFPsKm3rt5Q4T7bGmRT7PSDS/eTd?=
X-MS-Exchange-AntiSpam-MessageData-1: VT82QzWui+lhWg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f258ed-e5ff-4e51-61d3-08df40c1dfd2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:35:54.0384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzrk3FCMeE49nxlkvxKMtTD5mPXSiKxcqsv5AvDQbWWxY7wz9Tr9AAaB7P/gFBsbLhcLCYZnwJmyCBFnFdC3Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 5:47 AM JST, Yury Norov wrote:
>> Forbidding zero-sized pools would actually require *more* code in this
>> patch to enforce that rule, and would not allow us to remove any in
>> exchange afaict.
>
> I trust you here. Maybe declaring nbits in the allocation API as
> NonZero would help - IDK... I just want to make sure we're not
> bloating the implementation for unneeded and confusing functionality.

I think the current code is pretty much as simple as we can make it for
our use-case.

Of course we can always tune it and even update the API if we find out
it doesn't work as well as we thought, or that allowing zero-sized pools
create issues. But if we forbid them preemptively we would actually be
adding more complexity, which makes me think the current approach looks
right.

