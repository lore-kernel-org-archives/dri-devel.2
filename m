Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6656FB5E8B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 01:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D8910E3D3;
	Tue, 17 Mar 2026 01:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gDpIOs9E";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A9410E06B;
 Tue, 17 Mar 2026 01:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcF07FB0rKaG890HzsFYuzOZ928Fj7tzOGmaGnfJLQe6Gq0mmyahwqPNo+Xb0moM2tUi7jz/L7AfxFF4O9hENI0cBWj9Zl8I+jV3AFvsl9OUWUAiPMPoOAplZEX7/aJGZEIK1VGicnGXJeVukRpyb1nvAEq0SFaI8trAyrp7CfkWJk1iy0YwbOoCg22CMDIjkHyxChxu+hopDLFe1S4jcLLEBHn2EX73/BqjurYNyivVLv7kTuTMxpvl0nf86XpgAv9qS3rvmnFfvf+aZzGmVCkB+8IUZvXuse8UilxWVClfcr5XRUgz2A06TIqw/HrpxjIniBJnBXmbCZXvQEDkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ffd4KaXvW++s1kwVCHWXI8Y3ppFKInwYcBs0d1LIeM=;
 b=UoABkb20f6h14ERbG0xwIIUFCNUbJW3NOjzz0yhdUeNqW5GvcQ/oCv0KpzI2a5c71VAD5qSqUjP6DR6oRiDsLZxJ/WWy+Bl3RiVc3BuIWcRX3ltwoSvnNUIdpXEd7eoOstddQ3LZ3/ZDHhDFCvkMAUcJH+pIjFg8RAXGAkOIzK40z8Wmc++8eMyOcjrCDFuk0w22H1fXcLyCXIHNU0BJS6DfFYP028gcg4qO9NVWAdPjwbq3V6a3PQOkTvUsu5YFDdYHeqIPw38VV8sWfT8Pl345QeSjQ10WnEKQrUNxnG7kvHqmKDIXIiZSViXZ5zVwbzLSp4nW8A7FlEvi3wQWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ffd4KaXvW++s1kwVCHWXI8Y3ppFKInwYcBs0d1LIeM=;
 b=gDpIOs9EjxbLTS1+zckSSIkyH39vkeJozOmrxeYrG5NxdlRIbYW/nFH3GOh2vsuRjGOwL6IzT8uJ8vQTHBvAxZpPSj/DC5g9KhMjVS4ND4WJRF/oxrwg3Rs1O3RKak1762mXDExaLnnZd/TfR6oy5XeYym9NevbeedK+FN83QINGPvlRjxXMPniyr9ctUOZLeP4ujChpVLn/znM6/RoV/T1xAO4zIaLSrE7fa0IecE7fWLuyjXLCzZrq+O5+lBxjePKT5gUQbkxodNMAwdfpRtzxAtnZ0m25o+F2A4nTQKnfig7isj4rKO/+npUMJvwdGdUt38WDNjI3uSMjtw3Kgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Tue, 17 Mar
 2026 01:02:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 01:02:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 10:02:16 +0900
Message-Id: <DH4NHGJ54F7M.2R42KYTV1700M@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Koen Koning"
 <koen.koning@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jonathan Corbet"
 <corbet@lwn.net>, "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Huang Rui" <ray.huang@amd.com>,
 "Matthew Auld" <matthew.auld@intel.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Helge Deller" <deller@gmx.de>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy Ritger"
 <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, <alexeyi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <joel@joelfernandes.org>,
 <linux-doc@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v12.1 1/1] rust: gpu: Add GPU buddy allocator bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20260308180407.3988286-1-joelagnelf@nvidia.com>
 <20260309135338.3919996-1-joelagnelf@nvidia.com>
 <20260309135338.3919996-2-joelagnelf@nvidia.com>
 <DH48DNAQCE0Z.2EX23VD27CQVX@nvidia.com>
 <efc10902-2ee9-4cb3-a4cc-442998eef01a@nvidia.com>
In-Reply-To: <efc10902-2ee9-4cb3-a4cc-442998eef01a@nvidia.com>
X-ClientProxiedBy: OS0P286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9d::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: fedb78f5-abe6-4ac7-8546-08de83c0d78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R1VAPJPZJYJvgJi0ZEt66dnnE4Ta5MAM0zSPdIEyYmtKtI7zYeGVeggdiPqIM1TqEOER9BKDIL6Vbd8UnKyPqAxUIgMSSzl75VGGmCSCqRmooBwBYkQtGER5DIyjQy5vg6Nznd2epArfYaLSlzCX/UO2zlkhLeAQ1jlvz2vOYPFIqHsuD/3tzgAPXbjBNZRNVmkEuiAaKj1Vw/yMzLps1gcLTACapj+0UIUVT9MbSDGnyX80SahsvfGzUAUGqUyvl0Yx5ajHBuMu/gQdKIIawb7z8M+3WpPotIRfRfce+mHPbd0bHUXoV7vmomR61+mfy7Tr4mVdc+R3HqaYm0bLKXhCdtFRJwAeJ1JhytRvpBEZ2biff/bjy8/c8PXLA4Au4ARfWBGCEfZFfiBpMJK5ERg0c4G0tbp82V7YznN6OyQD6Xd8K29X+WcufCdal6WlwlCQX2MuhOdf+/acgjbws4U6jcpZWglkAH1FjxLwKg3bZT6FF5MSwPq9UbuZ4JEYtre0P1gEY715dBMvMtvaHHfT8y0ozILv3/ysxlEboha16qNXUyE2N7h/oOz4KyAdIug6VX+3j1tFWN1G3YrWAU/UL4nDqPslcu3kvjHC/1z1MXa7OAVr+QiOph7+5YKMmWRH6xobfmNtxFQulUiFpUCJDABGNzDJlcAbW4keIY1ITjrV/1ushjm2ILwb/nuZ3pOQg8ZY385JMFMqi2X5lpu0LQ2x2Kmjx7VgTrVLNds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1JTEY4dFE5TVl2THJnTXZyckdCTExtemNGa3laTXlMa3ZVNG1CUkFZMEwz?=
 =?utf-8?B?OWpCVUhXcnd1VjB5ZHc4elBzMUFXRXJqQlptcGF6V1hraWhmVTFFdHdJbTJ5?=
 =?utf-8?B?KzhkbFJmNjh2SGZyc01HNzJ2NHRaTCtoV1ltRC90TkQxR0dRQWdYV1RxSGhH?=
 =?utf-8?B?UCsxOUFhUC9EbDVKU1d4eFVDOGIyWURmdEE5SlBMV1lCc0xhcm9GTzRxaTVT?=
 =?utf-8?B?VGNxaUYrUFpGMUdTTWVsS3l6UXpsaEdRdTA2UzBKTHJNWFlaRlJPanJwMmRH?=
 =?utf-8?B?T0MwSjkvMU9HWkljbXdKakJ5WGZIZUR5dkdRWFVzaW9NMDY2bFBSbytWbThZ?=
 =?utf-8?B?d2hLdEx2MUxyYk10ZE0yV1BGQld0ZWlHRHlDbGNxZW1EOUpyN21wZThQRmxK?=
 =?utf-8?B?TW9mMmZiL2hSd2ZyZjFrQjJ4bTJZSHVQZmN0bERUTXhYc0IrN1dhLytIemds?=
 =?utf-8?B?QURFSE1Ic2krb2VnQ2QwamFhak9odUR1UERYUTFMTUVKM2hWL2lvSUpFTldZ?=
 =?utf-8?B?bktCZEo3RCtrT1Iydy9yNVJaOTF5RzQvOGhYVEtiNDRWUk5JZmRNQ0F1UlZF?=
 =?utf-8?B?TzZXQWFqWkdBdFdhcW1CZFgzUDhiNzM0YjNFSDRFWlRoYWRON0FKMktSZTVh?=
 =?utf-8?B?NlhUT3RSZEFacUI4SXJxcWZPd0lEMTVzbXlFOWJJd2xoT0dsS0NFVXlvYlVK?=
 =?utf-8?B?Y0Q5YWtPVG5DRXpyYXhsV3NvemMzQ2xPUURhRWswc3BLRDZXR3laUGZFN3BD?=
 =?utf-8?B?UWV1TWVCYlNObmxsWW9LWGJKdDJ2UTNyU1c4bFpTTklYWmx6dE9UTUV2RVJv?=
 =?utf-8?B?dlYvWjZDcVZNQTNmLzdJNVplQkQrenNVSjVEQ2V2dkVtcDY3UHlUbzExVHRF?=
 =?utf-8?B?ZlJTVElGbm5Ud3NCMWw0TzM5Rlk3ZzVtT2d6bkFVUGtueE9PWWlQZ3ZXZHZU?=
 =?utf-8?B?RmdzdnRCa1FnTGRDcmJpaG1mQzFEdldzWEZpMWtuZkE0M3grY0hPWXNVZUt0?=
 =?utf-8?B?dXlXTGczRFBxN3ZHWDdBZVZXM041NytWeUhxdUM1NHU5Qmg1M21yclhGb0hp?=
 =?utf-8?B?N3BNVGgvN0l0ajBZb0E5UnJvUnEzdlRlNURtU3REdDVRRnZkejBTcmNHTVNr?=
 =?utf-8?B?TXlYOUNTWTV5dGZuSXZmVno5LzlWNEs0M3F1T0ZHQ0QyRlVPa0pFV3JvaU12?=
 =?utf-8?B?Zk1mRHNMb0VpWk83ZXhnRGxmUFc1MElJbytFR1E2TXBTc2tlbXRXN08rbmll?=
 =?utf-8?B?Q0Urb0lkTXAyemRHb3crYnB6Z2FNS1hCSEdIWEJhK05GcGN5dWJaYjdOcWM3?=
 =?utf-8?B?V01WY2d5TDl5dzNLSFd5bmR5OFZ3ZFgzbU1NcXpEbzFmKzBQekNkR0VvSWxE?=
 =?utf-8?B?VEtqT2RCSjFQV05UaldPOVUvTXVCTUM2TVV6bGdRNjN3SzNhamRhaGdWdXFU?=
 =?utf-8?B?U2ExZThuOVBpR3JEaGV4R2NKemdqSU9JblIxc3NkSnZZb0c5VGZEQTllODht?=
 =?utf-8?B?MTQyN0t1NzZKVnhKQ0Z6Ykp0ZVVWa05ydjBRSFVrbVJDZERRM1JaR3hKWG85?=
 =?utf-8?B?Y01uNHBHT1VuSE40blRORWFvZUJyOVVIeDZZbWJBbHlwTWQzMzF1SHhOWTlL?=
 =?utf-8?B?VEUvc2tBd0JaVitTVUlNZVBzMlZqbEFha1Q2RldaaGYwUERuQ0FPREFTMUNB?=
 =?utf-8?B?bzhwZmN0Z0pqY1dIcDhYVXd5cWxzVUV3THREVVhkTm9yUmhRQ2NpV25MOWxS?=
 =?utf-8?B?NEM5SVZLUmpWWmtPYzYyeDlkTXgxOG1rL3REekp0ZmUzcUJER1JlNFBWbERJ?=
 =?utf-8?B?UnBZVkRmU2taWjhFNi9XWjBFNUIyRXRXK3d1WU5qTFdmMDR0Y2FxeGNhUkNk?=
 =?utf-8?B?WmRCUngvYTQxLzNrNEpvUC9SNXo2dnpqdkVQK0lEdGRBKzhRREZscEtrSFow?=
 =?utf-8?B?WGE1ZCt0OEdmNExxdXFzRDFSYVRPRm1pZ2lyTWp6dTE0OEkvTXBYbkJEUVg2?=
 =?utf-8?B?NXQwcnlxamRlaTc3UzlKbVd5eUNHWmFTTThRTE5IUEw3VlI2MXdla3hYdXFZ?=
 =?utf-8?B?UTBxQlJtMjdvQUtpaTlKMjJxbDJKcm9WdURsM2JyUXYvRzdtRVpHOGtRY2Jv?=
 =?utf-8?B?ZHdSMk1XbzRJZ0RlVzB3VFJQejZPVGxUdzJ5clVFUHdhNGVHNERCeUVNL3ox?=
 =?utf-8?B?NEMzZnZFZGZCK1kxSktsVldZZm9FVi9STis1SHlmRndUam9YRlVjSk15aUo2?=
 =?utf-8?B?cWxmNzVBWDJ6Nk5lYjVyQVNyVzlZTk1QeCtlYit6RVZMSU9uRmZjcVNkYnI3?=
 =?utf-8?B?Y2FiczBkaklVbDNoalZzMkwwN2ZXMFZzQWtabXdvT2tXeExrK1FTbzFYUzVI?=
 =?utf-8?Q?L2rRWI4ZlrBXTbgB/FJO2FpcXx0HeutHCZE64VCZKbNDA?=
X-MS-Exchange-AntiSpam-MessageData-1: aam2B/KCQaBKCw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedb78f5-abe6-4ac7-8546-08de83c0d78e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:02:21.0404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uSV5rRkKv5iS1wZChag0vivSGVaRMVFYRWXI9BYXx72CKx5iNSW9FTDIQ9f/8es8Q9/2LOvWGCZmAMJHSa62g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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

On Tue Mar 17, 2026 at 3:51 AM JST, John Hubbard wrote:
> On 3/16/26 6:12 AM, Alexandre Courbot wrote:
>> On Mon Mar 9, 2026 at 10:53 PM JST, Joel Fernandes wrote:
> ...
>>> +//! // Create a 1GB buddy allocator with 4KB minimum chunk size.
>>> +//! let buddy =3D GpuBuddy::new(GpuBuddyParams {
>>> +//!     base_offset: 0,
>>> +//!     physical_memory_size: SZ_1G as u64,
>>> +//!     chunk_size: SZ_4K,
>>=20
>> `chunk_size` is an interesting case. The C API uses a `u64`, but I think
>> we can reasonably consider that we won't ever need chunks larger than
>> 4GB (or can we :O). I'm actually ok with using a `usize` for this one.
>>=20
>> One of the first things the C code does is throwing an error if it is
>> not a power of 2, so maybe we can even request an `Alignment`?
>>=20
>> I'm a bit torn as to whether we should use a `u64` to conform with the C
>> API, but doing so would mean we cannot use an `Alignment`...
>
> Alex, have you seen my Alignment patch [1], for that? It's sitting=20
> around with only Miguel having responded, but seems like exactly
> what you're talking about here.

Not exactly - this patch provides a shortcut for creating an Alignment
from a u64, but it doesn't allow to store alignments larger than 4GB on
a 32-bit architecture since the value itself is still stored as a `usize`.

But that's really a theoretical worry of mine anyway - nobody will ever
work with buffers larger than 4GB on a 32-bit arch to begin with.
