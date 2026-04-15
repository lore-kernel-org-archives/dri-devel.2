Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA26F433CD
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E6510E1BB;
	Wed, 15 Apr 2026 23:22:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y/BANaxh";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C199E10E1BB
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeUSg1Lzp07m9EmBgVA0H9D5eeP6uF8q3slhII//bZ3FcQb2ucg7q0aIed2jF2Iz7wlzwsQN5WxdiNCkkz1za9ES3PN7z9KXnjSKVTER9KXFNMXfr5fglHitf4catXRZ74zx6FgRY4YsV55XqD2tPLABbUEVwPpakCrwd8ArqJ2nYk+QIjn1zkdv0MmCQ1FrWcOLZumypFhBhoKmDUDmlKXJc/lRdeBCpWClfxtCvQfn/BXNqs3xWcUUx2e3vYHVpw7R49l0TGuF1gtR08cM2FAC3KiuEOkCAQh6x+IYg/8uPzbJ4NNOt5Ib2HEMLnT0rPwl+nBjhpuv9p/mpu6YfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c284f1kNICY7CcrGiqJVNdOE4WRpAEiyoKbdWIQ4w3M=;
 b=rwuj0kAIwI+GmGTi6XoqTy2ptxFIfa7yFRepGfyQ+y9KJwIxaqa85AQsKdMwsfx+LztsmX+zCnzSsQZRWEq7iKHCI9fenuHyB5K6p9FB2p+tWNr1cdK4bwbIYoJXHMI6O6RKdvEcsLsGHPERXy+7x2nQT3yh6FjV38NGnYjA8TilgqC3S/58ObOtOhNDPqMdGnNeVv9L1PqXXnMLbsOGTMFUDYlpikX9hz4fzxE6s7IzUui6bmFgrTXjh1nOZh8zyFxv4N0S45SUrwiZ5UyJWz/T0Ad8kxtGaqu3JGS5yw1oPFOCE2Moja62rZz7RZUtRbBWKriXRE7Ax/4vgFaTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c284f1kNICY7CcrGiqJVNdOE4WRpAEiyoKbdWIQ4w3M=;
 b=Y/BANaxhA/BUx5ixGj20SCxtQE+M6WUMzmbOONZ3K+sY9KdwJjq59X8h6pzKT0UFgtokTM0s8gsn/7tdwM946kiiyRsbszPjEq9IyDbDrTd04dYozzIQf1vZkehd/HTLcF6NEUcRwUl3AjdhE9VfhZcbFgDhlTgEoM4fJkziEf80lE8rWfdaS5Ha876Tx3i5FTIamEIFWcMBqFTMaEXJmAeOHdS3HpzBP4qisHfpBcwBw8BPLH4d+QqeXgixleSmKXNEKqXlXABue2OKsg88Q2zd7It2TQpdrjHiTN/IebWPK8xsR85iFWEupVMvk0N6lCMlPBrVQO5GdTu8ejH4UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Wed, 15 Apr 2026 23:22:23 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 23:22:22 +0000
Message-ID: <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
Date: Wed, 15 Apr 2026 16:22:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
To: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ef9858-46d4-4541-c35c-08de9b45d8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kII2c4Y5ZZdAc6KXxLtQgpvjHA7sl/33ZimqRF8kWWGq5y4XAUrVnrk8Bf+5naN6ywpjWKnvAZmfMoLP5+6KXy91Hx4FXIoKEKhIMGYl0Gl0rrdeIBSzv4dZdZpt+lx3T+GAXk9m8V0yx9TcUBhYLYGnk0e8liqX/DqymKfOmsrDYyR1JQS+fL7AKFva35NBS0AmZAtP9oYaa52QQLXsl1X2xet141UeImrZxn+HpEAg6yrbnXzcpTdND7Lc28aG/lE9r0Kq/TkjGBCflU8d56B8hvpQsqLswDz25k5sj1Bz6LUabK5yr8ee22UUbB4rzTVZ6hLMt/AuGTNa2dIP0oLkM2jOwwur27MTfH/Hny9AVVtGzWpJBRqPqy2CIjNW6WLaPMqV7xoYhmd9WlYb/9TxuuJDEkSLlqPUxfSPNaQ4ua9lPwfuPhykSkT/3cvuPzHDv6RzSv52bP/Dg4vv/+OuIN+/J3N5aobq/m0xwDU69ssyDFWk5lcLVUYJlGcmYhDeiwIqtcurG2CCppc716yooltSyKDBki/nBlmOoDD9OPVstL/xSjyV+n2pFcwdqXZT2hRSCQKBvQMTMeTsPI0vdxXpYLJpUefTNq8/ngqP6uc0QaUyesgOxtQwkogKTdVWoVq+ELPV++15xKx+SWPmHJpE+8NNI/s6tglADRA9w2X35voUw79KK/rNbuOMDyWpCVFnRNPZxerkuTlACCv6nY6CKdxn2olAg4vnvBrFECVWcZgqGvtF/h5QydRazmj/LyMKxAN+JCSyRizMmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTBFV1BsR3R2YmZjUTBwV0dCdXVRcWkxcXlzQnF4aUlrYlhLRFB3SW5EMnlZ?=
 =?utf-8?B?d1hlSDVjU0hZRTV5R3gzbjFKV3VpSi90WG5WeC9IanNBU09BajJQVjRKMnpv?=
 =?utf-8?B?c2tlZHM4dzRqdVBBNy9sdjZxL1o2N0hOL0FtMmRZT3BUcU9LeUtYSEZaTXV4?=
 =?utf-8?B?MjB6ZVZYc1EzSDZBZXJiM1cxaHFZYllJeVREWUkreUhqc2V6VDNGb2NjNVJz?=
 =?utf-8?B?am8reFFoT0lCbTF0QmdyV2JiQUdlQkxRdmtmUVRZZzA2SEo0MFZ2cVoyTFZU?=
 =?utf-8?B?VFpMQXN2SldxdkRFUnJLZ00wdEt2SGpRZkJ6aWVEbktrWmYyREUyYjkrUVJ4?=
 =?utf-8?B?eXUwRCtXb214Yko5bmVDTUNoY0s3LzBhYjB4YVlreGI1YlJzUUZqbVc3VzNJ?=
 =?utf-8?B?NVZZWEs4QXlrRXo1OTZXVjAydFJKa3Q2Sk00VWY5QnNUdXlHQy96WVZRTzNM?=
 =?utf-8?B?N2VBZmxUSi9wT1ZpMnlTZkwyRFBkMDlvL2wwUXZyY2szaHBFK09jV3hveTY2?=
 =?utf-8?B?M3prNFFhWkt3VTlOa0g3VTdvUEcxUUd4UmVRK1ZtdzE1amZ1UHdrQUNJNENH?=
 =?utf-8?B?RW0rU3RiSjFPLzhqcmlnYjVDZ3JiU0dxL0RFVkNzVzV0UGgxR0FHRlVFTlV5?=
 =?utf-8?B?KzFHTTB1bG9mR1M2QzYreHhNNWl5cytjVElGMXorUkE0QTdVV05nWnZhdUdi?=
 =?utf-8?B?akZvZXNvSjNudnZFeSt6K2xXK1FINjV6UngwT1dVajNPTU1GMEdrSFRPZ211?=
 =?utf-8?B?b2dBTHAyT2JwVWZyZklEWThEcEtoT0daR29vQVVRQkg5dHpyeHdiOHlOclla?=
 =?utf-8?B?NEt0Ym5TWXJLQ3FFUWs4REZlRHRzcTdOU0pIc3RWMzVxbU9uR1Exd0FFK05q?=
 =?utf-8?B?Q0hQVDkzNlhFNUFyUHdaYVNERFNDTTRvcDl6Zzd6cHNXRzRJaHlIdGowVTFn?=
 =?utf-8?B?YlJsL0lSV0MxYTZkOXovUCsxY1VHdEZQSlF4M1NwR3Zucm9WSDBiaXZZaG9v?=
 =?utf-8?B?RTcrNlk0Q2FOWWtLZVBPTlBZNC85cXdSZXphVUY4ZjlQQXluSUgrRXd0L0Z5?=
 =?utf-8?B?QVZsdkN3Z1d1Q0FnbldLVXl1aW9QakxyZUNvbHAvN0I3T3BDSXhYNlRDUmpW?=
 =?utf-8?B?QmlKeUR0SHBXcXNEV0h5aUQ3Ly83aHNUZHRhdlZwYmZPQzlpeEVtY3MrYUpw?=
 =?utf-8?B?ZHplcUcxM0JobG1OMy9DQVJWZjEwbzFPemRlK0NXTWxWcVp6ejhsYzM4b001?=
 =?utf-8?B?aTJiNnNjcFdWbmR3cVNzb3M3c2ZVK2VhWWhVWUl4T0ZiMk5kNEZ0cFlHL2x4?=
 =?utf-8?B?eU8zNFVaRlRRWDdXTVVvWnJSSmN4cGFLTjByU1VSWFNDMFlEWlMzUzV3NGpX?=
 =?utf-8?B?cjhpR0V1Y1diSXR4Qlk1Ym1ENG5lTUx4cFp6YjNzVkkyaWliZFhraDhhMVRM?=
 =?utf-8?B?bUVJb0RocjF3YVlsdy8zbjd2aDZrZEMvWXFNQ0VGS0hLZEFheWpSQlVPNThY?=
 =?utf-8?B?Q1BGUEx3VHBBN1o3S2YwRVZMUitaTG4yQ2E4QlZBME9WcWdFSy8zZzM5K2tj?=
 =?utf-8?B?S3MzbWlYK2tGaEZOZWNwdmttNXhxNWFTL05CaUhDTnZsUjdmN3pFUTZDbnh3?=
 =?utf-8?B?VU0ySGxHS0dveUc2NFZpNkozVUlXak0xZ29hMkJzV3NzNzh2UjRzdXJjbnBT?=
 =?utf-8?B?cTRFckhDYjB1ditXajdSUVBpdnNhbUpRT2p5emRKVXZyK1JLdzlzcHZGZDRY?=
 =?utf-8?B?cEFwUnBleEEzeG9Pa3ZWaVA5d3ViclJQRnBMTFN0dmgrcXZkVUVPNFlkQVFl?=
 =?utf-8?B?cFdlQUZybW9mN3hzcFExQUpOUTNoY1plRFJYdHVBWDIvNk5hVHVycEUxbkhk?=
 =?utf-8?B?REw5amN3MTdjQ3B5WnVWb3VVUGtXRDVVV0RCamlsZjRWa1kvcEdDYTExeGI5?=
 =?utf-8?B?K2MycmdNdkVINStvZmpVZlc4Sjh2M1hjblhKZWxnTmtRY2JsRUhPRnpzZTh2?=
 =?utf-8?B?VFFTQzYzSFVQOFBqeEp6MjZiNUttM1R6VC9GNXlwTjh3WjFLcDd3Q2hFTHFV?=
 =?utf-8?B?ODM0MVg4ck4xNUNjZlhaUC91d2Q4M3J6b3ZxNVBXYTBzeDVYckYrQ0lFbHNI?=
 =?utf-8?B?WnVSZjNMRUlaQ2s2S1Y4cW03ZW04WGRMTzJTcks3MEF6cWtObUFFYlBoeUlq?=
 =?utf-8?B?MVc2YkNxaHJnbW03dUJYRE92a2IvYmNFQWVZSGIrSWowVmxXNUtyR1hHQk1B?=
 =?utf-8?B?Z3BEWTBLRVpZWWlaTDN1QUNTTGxhcmU2OVFnS1NYbk5pVTFVcHBveTRac20v?=
 =?utf-8?B?Umo1TnBuaUZJUVNweUZwc0RVaHNnUzB4V1pFQjUyaUIwZkdlUDNNZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ef9858-46d4-4541-c35c-08de9b45d8c7
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 23:22:22.7082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGVMe53VgPt5f+LGVDwdDt3c0rIjG2KG4FliLK/K/5YIrUlLe2pJJjbIwa0aWU3Kk5WH22ryyIjdUT8aBwMWVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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

On 4/9/26 7:58 AM, Alexandre Courbot wrote:
> This is the continuation of the `bitfield!` macro which started
> alongside the `register!` one before being temporarily integrated into
> it [1].
> 
> There were still ongoing discussions in [1], notably about improving the
> ergonomics of setting bitfield values. This revision doesn't try to
> address them yet (although the `with_const` setters partially solve the
> issue); it just extracts the `bitfield!` macro and makes it available,
> for the following reasons:
> 
> - To get the ball rolling again after several months of hiatus,
> - Because it is already useful as-is, and ergonomics will be improved

Yes, and I'm worried now that we can't write things such as Joel's page
tables without it.

Can we please put this into your drm-rust-next-staging ASAP? I don't
think we have any comments that would really need to hold that up.


thanks,
-- 
John Hubbard

