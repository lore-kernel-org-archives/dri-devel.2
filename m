Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733A2CD3430
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 14:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C3210E71D;
	Mon,  4 May 2026 14:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b/oyOobq";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2179910E71D
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 14:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtQEWognHEbwI8lBUfc2O0NdwAKnLHzvaHWtwN4CzCJParheWCejVa30W4bhovRXoch5RGqwaJ/sspWq42HuBAzc4uu3A2AoqpisoT4ASizfz1tuSDHU9K9xrYpO/XJSCFXR0jZB6lg6RCbAWX3rQEWhrNeqivJ02GpGk1Hq1SXbkspLkZ01d3dDBVsVEtOwVBTa0lRP30OlKFyV7JsZYUmZCzV/2VkyDtiNE5y8SG5YLYHLmpaR526lw9xbYuimAARF8urGtpAnapBvxPRibe48ehde0Mn0P3w6TO6w3+5oaYEfzSLC2B3lSSF/1AjB62YYBcHdruhyzehsv6QsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYWVDycSe3BcZ5LOWQtHpULXem6x6vqpb4M3RQk3oj8=;
 b=GNZ1JJ3mSxx4BKosXGgnhFTVUkvDlZG1J9f81R1QnCEXkGkM22/MeVYJp065Oi3c8Z4H/xfYZWvPzySij5NVkgOu46kMaSWBYN8wNZRl5Yj579ud4QxJjeLxZrsGz2Qb2Kpqg5wbacolc+QY6C/xNmVTZjQJuvRDJHog6Z4OfSBqAi1hr/6uiWSonQH6D7WMoFw7iFGYlrlPR2G21UyF4BaKEcONixE2lxleNibRUukAKfLhHOcAIduvQ9QQytlTpBi+QmxMxs1AObtl+eRSZaXiMTd/LwOwwTXJjwpKFRddMr012jRYTJDJECwUyJcnTTDkXvz9RlhaRjlinS/VWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYWVDycSe3BcZ5LOWQtHpULXem6x6vqpb4M3RQk3oj8=;
 b=b/oyOobq6b+rRIymEX2U1slgy5Casygyb3mdxU7uVFu4zzHAcOape2STG83rgHDik5wojT64cIqMha9OFMWNxyaUDT6bcAZTTnkVI4BNf9RBh7ixiqG1PsPeDbY7m6QiXKu82Q8t4ynkaFFJaM78b1PETrDqbwSIh7RZvueinXV8g04JK9leY0rdnHDKP/FfsP1yxExp0UIpRADWREiruNwi8FitisZLbOjj5tq+/GXqhxi1tSMQL/ZNU+PHJ4cArznBwDoPNYNVvSEmOYtExBojwjhaNsABItsroa4NxG3sUx96vxX9bnzNMxv6dFMZbKMa3niQs0D/k42A0cRTIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 14:31:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 14:31:21 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 23:31:17 +0900
Message-Id: <DI9YR10HH6PE.AMLEZUV7701V@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 12/22] gpu: nova-core: mm: Add page table entry
 operation traits
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-13-joelagnelf@nvidia.com>
 <DI8B0IOXNP2L.1NFX4OTABNHA0@nvidia.com>
 <53c88538-dca7-41f1-bb2b-856035728c69@nvidia.com>
In-Reply-To: <53c88538-dca7-41f1-bb2b-856035728c69@nvidia.com>
X-ClientProxiedBy: TYCP286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: f77395cf-6c35-4a00-5d52-08dea9e9cfb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|10070799003|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZjInu+eLA6DUcqKlwvl5Vm54eyPLx/RpRzOQ2GXLpXcmHM7uc6Bzr7sJIi8SzrI+1/1Lz3FH69vtkiVzVGbJ8doXwkER8rCj5WyEt1OlU3pEIYhiQ5L7eS1j4SrBWCAKc2e0/Uf1xGYyJkRyad5o8xSFTrWZ1hFIzLOYZ7u0TYMzCdNxPXdKtSw3nE8iGEYMZWUo34etPxER1BZo1vGQt+aP6qGp7bnCG5+ZedO/OGZWuMlEsptZnPulWgduIBDe6gvZzr9SsQNXheONAxbJHX6isuXf1SndRgWEMqPZLuULnzOIkEnC0etr/q+p6d7pCyWN+ZwEyRElDScEHJbCa8TnEDz9xhZW8rZJlhdNRE/Xw8yEwomKI8BjHLkc4sO5kdJwwDClgn7KYeJg5R14DGQHuPXz5Ln4dN9ZaJmsnmld3TJjst2PJ0wxsE3Z/NgB3T9w5McXt3uqstgknbAMiEtqI4fS7ljrzgG86srj1rO0S2aHXSiNfgIbditQGzLgi7ql2cveN6Mv9J4J8R8rksX4c4L5Zv2oTijRMIgmwvnuhhBh/B5q9AV97Urmf0mHTOGaqKD4rysWlUiwBDpIkBowvqyqg00R3WADXQN84Y+Eo++g3+Jcv1uuURn4Nl3OU9t//T42buiy4ziPn+eb0K0TE+cYGyF78q4tH5ma0UuT5Zx2vITku5rByWnoqB1L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZyMjdVaFlRY1FDZXozZlpqNWJDOEtnbUg2aGR6Sy8yanJZMElvanNLNkk1?=
 =?utf-8?B?SmdyaEFHUTdEdkxKcUJHMU56KzJSV3M0MXVuRzJ6Q0ttcUE0QThUYXh4dHV2?=
 =?utf-8?B?YXhJdEQxRnFIbUt4R2wreCtyQTNRWjIzamgzZ3U5bTJmVFRuTEZQQ1NtSUFJ?=
 =?utf-8?B?bWVJR1lCbHIyYWY5TWhKVEtaSzVBaWdNSVQremhDWHZvdVpjNGhKYlZOcnhG?=
 =?utf-8?B?Yk1OWnBqaEVWQ3pXZzNOZ0hZLzlnYklNbnYrSitwaFdmTUY3T0xjNTlURUJF?=
 =?utf-8?B?eW5aNkJmNGxSR0JDNlFuTTNKTzRaeisyUkZ0RVJVYms1UnpyTHQ4TG1Eb2Iv?=
 =?utf-8?B?R2ZPUXE1OFVCWU8xVTRYWTh1a3BLbE1FaExDSmhmRFUwRmxLVVZ0M3lwQXcy?=
 =?utf-8?B?V29CWDFZVmlEdHVvUWVWdmFkUEs5VDRGWkhIWndYaDdpMi9LcFlIYWZuSDZh?=
 =?utf-8?B?eGZNTTI3bGxFZGhuT2dLV2Z3enVzR1d4SXJ4QmdVYUVqd1htSFRwUURUQnBY?=
 =?utf-8?B?eHpBK0d5VU5IMkFRbm44dUMzK1NacCtpWTVEazVMczgybG9iajYwaGtsb21I?=
 =?utf-8?B?RUpyeHlKMlJzeERzb0xFUHgrL3dTRFJmQjhpRzA0L3hGWXlsVmI5dDFNeGg2?=
 =?utf-8?B?cGo5RGROSngxWVYzQ0lTNE80Qy9JdTE0eUVKQitxRHliMThLSUNoZ2dyT25J?=
 =?utf-8?B?ZitPcktYRmtrci9RdHJoaHJWdDRLL2RjaDBQU3YySzdPTmExd1dyN3NtN0JT?=
 =?utf-8?B?MlFGU2dGRWZPMS9JQml2bjJiQm5yWVJETzAxdkg3enU0WERpOXFnK2hKWEZH?=
 =?utf-8?B?bU1aMUZOOWV0MXJJQzJNdmpvL081S2NPTGRIOEtrbEhkZEptVDBLbkhkTU9o?=
 =?utf-8?B?MkRYMnhpK0crR1I1RUM1MmNCKzBOT3M5Ly8rTzRtMCttMlJNcytqMXNXQXpw?=
 =?utf-8?B?THl2c3BaMkw3eDMwSVFKRENiZHpjWFNtRG0yemxmNFNLR3V2ZEg2T2R3U3Rz?=
 =?utf-8?B?VzJYcFhwVGRTWTRLb3doRmVJN2d4WmR5blVYOC9DUGZ6QUFvNm01TzFPeDAw?=
 =?utf-8?B?TlpkS09PSTBnQzE1VjV2aE5kVStxeEVia21qMDFaUC9obUpJak5RaW1Dcjh4?=
 =?utf-8?B?Zi85dDhGb1ZzSW1RU1FUb3hianpuK1YzNktFYlV5aE5aWG1mZTIvbkFWRmN0?=
 =?utf-8?B?UGFJTE5aYzJwYk1jbEdVU0QvNWJLVmVrSWRRU2JubS9FRTVFYUFlY3dleGZ5?=
 =?utf-8?B?OWQyUVNNWEpKVlU1TjVUUG9JKy9mK2paZVF6QXJ6UG4yN01Db2x4NjJpUmNI?=
 =?utf-8?B?eWJ2d0g3M3I5dDZWRGk5QldnMEFZSlN6dkFhRzZISEEyTTNEYVV0OVpNWUlr?=
 =?utf-8?B?UncxZm9xRzJ1Z0dsUTlabzk2bmFMRFc4K0k5aGhzanBzcEpTSnMyMnpTNU9Y?=
 =?utf-8?B?K3pZSlRMd1A1RW1QTzI5Y3pVcEloQlptYzNyVlFtSjVjVnlkZnhaSjdBS29j?=
 =?utf-8?B?NG5odmExODAzdVQ3TE9hakdLRkpoRVc3ZkdJQ3gwS3ZXU2JybmZQekYwWGc0?=
 =?utf-8?B?Q0VIZGF6bE8zdVNZK0lKbm9tYzV3NmMzSHVxYzNBUXlpOTNzN3Frd0VrMk5W?=
 =?utf-8?B?L0M1S04rbFNZSFNieHFWQ2NubUwxNVFYNmdvWlJBVk0yakVqMWc0RkdYRWg4?=
 =?utf-8?B?M1BLNlkvMk10ZjVOUUt1cXQ3L0szWlFObEZvWDBoWXUxRzRuVlVYdG91WmRN?=
 =?utf-8?B?cEUxUGJyRjllODRrdHRLdFNRNXlvMnplejRMdWhITnE2L0RQMXMxMElBamZW?=
 =?utf-8?B?V3JpZ1ZxeHJXTUNqZlZNbHpDUVBPdXUwR3JKT3pNT0MrcE9LaWovd291d3Mw?=
 =?utf-8?B?Vm5sa1EwdjM1VUdSMkllREVzWXJiTFowRk5xaXM1d09RaXZ1TEVzeENvbkR4?=
 =?utf-8?B?ei9xalpOdGpxMHoxRXdEb2pzblNtQzluL0R0eklWVWs1Y2grWHA2Z0VKS0hS?=
 =?utf-8?B?eW12U2dVbW90WnExSnZBUDdBRmdhS1J6UkJQRkJpSmt2eHkxTHMrbWNZVGlo?=
 =?utf-8?B?K21BZ0tCaXkwOG0rdXlDU3ByZElsZWpZZmhpbkg4cFQ3eFNWS296cU5zZjJw?=
 =?utf-8?B?aFdqeHEyZTRZRzZTMFpodU1JRXRKWWlKd0J5SDRGR0lwaHB5Y2JjbFoyeE9B?=
 =?utf-8?B?UmI4UU4xVTdXVE53K1pTbkkrWXJCTmIzWWtKSHFxSG9aTWkxUVdVRGRzMkw2?=
 =?utf-8?B?T1Zrc0pHRzRUSjBFS2hsckYrbnZzYXpkckZoYkwxaEFua29rVFNGTnBmeFJa?=
 =?utf-8?B?UXBuZEJpOU40WWVPSXYrYklhMklScEpCY0Y5RWVyc1BOY091YW5Sa2tXdlVq?=
 =?utf-8?Q?0VE/5TjEfDDilUl2fswdmnDPs50JbmQqDVQAFMHRykEvL?=
X-MS-Exchange-AntiSpam-MessageData-1: DL6tv7uww3EmKw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77395cf-6c35-4a00-5d52-08dea9e9cfb2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 14:31:21.2157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmzPd0RD13dwWaE0/y0g0vSiEO73XzfL+ChwN+zKm3RGT22Auz2FQQS6Z9zB8LJE8knNYsf4mAYXocmX3+WbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646
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

On Sun May 3, 2026 at 4:19 AM JST, Joel Fernandes wrote:
>> Please reorder things so they land, as much as possible, in their final
>> form. In this case this probably means defining the trait *before* the V=
2
>> and V3 page table definitions, so they can implement it from the get-go.
>
> That is a reasonable approach too, I can try to do that, but it is
> misleading to say '270 lines of diff that reviewers will have processed f=
or
> nothing' which is nothing but fiction. Please look more carefully, the
> patch is iterative on the series.

For context, here is where the 270 lines of diff come from:

 drivers/gpu/nova-core/mm/pagetable/ver2.rs | 150 ++++++++------
 drivers/gpu/nova-core/mm/pagetable/ver3.rs | 120 +++++++----

But the number is not important. My feedback was that refactoring code
right after you introduce it is a strong indicator that something should
be reordered/squashed to prevent unneeded cognitive load on reviewers.
This is particularly important on long series like this one.
