Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A11ACD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 16:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9102810E556;
	Wed,  6 May 2026 16:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GMmi/8Va";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005E610E556
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 16:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXWRe8rVo2MdH56vDfxHD2I78i5FwwbMlWMsfQvyuteuFFtnT9B3uvvYk4Xs5q1MNb+OrRypyaZAfJbb2Iks9e+S5XWKMg+Msz/ykA2/kiML2i5NPFdXp2qawjaSjTWvJ9aoYY8SiyJcbeHoUDcFXoriLliV8DTkHf/aD1xQRgnV/VX4GstB1BEz1JYe1UxlnvsGq5A/mIvnzlOkG9REILMTefiErZmj9kTErbEc/n9E61GBNTEjs6rOa2/T9BjUcgC2SOUX9HoHVbX6DiMb8UtbGjz4U1pL4Ps1q+vmSOA/i3pBLtu3zfRy0EkXNN5atGPntVawqDF9gJ4QnVcuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C1G/YQbDfk3TDGrvXEUFjA5pOIkcxhBBG/lJQVeH6g=;
 b=rA4RGodTy06SAx6s9f2aYma4Metw04SZWSI0wl1TMRQWY67ZTi8R5G8zJHAWhbmWrHEh3WopXY5qtANXGp+AVuHwKsOcU4BP1q2jwu1M0mLTzs7eTLpj10HDJKCc2qmbAS51xMomQBCu9V1Q9Jg+UsX4ec3z3S3yXFwGipLE6mKfviZrjhwXAIzX0JvJwTYAprXd1qbDWdCH+IP7YOWJvnZjNMTvsWOv0w3Bs5VWSpZcSRavOIIi2nzBU4pI1kLE/FKu1WuiVFeT12lxPnEdex0UBVme7rT12LcSpzXQYIlWYJoNA0mXz72Q1LSvifL6M2hVzYWhvnGgfVMav2I9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C1G/YQbDfk3TDGrvXEUFjA5pOIkcxhBBG/lJQVeH6g=;
 b=GMmi/8Va7DYoR+krEtgKFxjNl39BzL2BsNLZOVND0FhF8EEY2CxIxFZRMHNgeaHwF60Ilaa22M0UXa2yypLdCl5076L9wZ6xG5sMFzcCytrF4tve9KuN/Q5Kn8pO9dVg3g3QbTvLQO9BVBAZhBBv4YjTRAX/ay/lTkWa1BZI+soYgmOeq0RsJ4I+ObIiKgu/vChq+qyx9vpZ2MFt1ZmHttUQ7iz5CIdu2mrSil4ABSS3BxbLcXVkyBi3SPcve2LUMb9S6lzTJMBUJyeN8oiNLrvSP0fmajY7jxZJ9PmAu/kO6HoQDyy7Syd3KoGq7ObzzdEmyBvwznY87eI6LbEtBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 16:18:19 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 16:18:19 +0000
Message-ID: <871a3194-5960-4e94-b177-6173c49167be@nvidia.com>
Date: Wed, 6 May 2026 12:18:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: maple_tree: implement Send and Sync for MapleTree
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org
References: <20260506135122.GA1432412@joelbox2> <aftiZGt3HQe0Bf_x@tardis.local>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aftiZGt3HQe0Bf_x@tardis.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::17) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cafef02-74c6-4df2-e36a-08deab8b162f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VlhWOUlnZlduTJDMJTCRHDCZGKX6M3Rqz73JeciSOEcYtoeRczQaXbUCvvhTLU/49NiCvz/ilgbZw1Yntx9RrgbR80E8Pr9YzSyvu3jzORID/yXq71yNleXArFcJlxKuM/YLPvTBtVlg0rPTimEB7Vf9012d2cp1sBkay+oZZqPmFQXrtf0CX8suv/YJ7/p1CMyXIU60rP5K95w3VF+VxAyp/QWRXP9uCulT7LKT6T3k290eq9cwZuzDgwGKjXmCnVb63ZPkxOXK7jq90H8z3RHAjUnbDYqGJ6VgSjbhK24MzGhpOkSX2uX48A/63muNa4eiEqbF01CXeotUa+/YB73cn0F1psaXbRg4IrjDY2wQ4RI0ECe2u1gUj/l4ZyhKkeTersLbduk/9wujHkZMZ+Yko9VHmCBAXfNdOY3YBYhEtAOCDUANqC89Ervf1bd2q+y/t72IlzgZuDc/roYNJ2WdtaDpo3Lb2x+gZZcOIaARVQQ8RPTccQgvCI7ZeGO1CVE454Y7sgKmF+mAuGeL0w3A61ViwEUe714kIv04ebtP5GdZlDAx+X6tIpsCWedRw79lKZ0nYuF0x5P1yGeVHAGV+gxUKLLx7lZAHPxfoFDn12J0XCd6FdBqp5iDjIUK5fgvRO9gIboD5Shup7I43B0iTF9D8iDvNoM1XeXb7sWlW5lrKX/OLYW2CvR63efkBpEDPN4MORai3yc6VarLgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRDam9hSmFLL05XaU0ySHJtYWRoUGlkTXJNUmJ5ak1pblZxdjdwZzV4UmVj?=
 =?utf-8?B?UHZCMHoyN050bSt0Wmk4WVdER09yM2NydjR0QU8vZm5jWitYZ3FpNmZxeUNy?=
 =?utf-8?B?UUdoLzhpZXVaVkd5elhKU2dUeTRlUzFBZmZQdVdLUFFFNnczdksvR2tieEVi?=
 =?utf-8?B?UTNuaVh6c0g2OXZ2ckpEZXI2VlJPd2ZRakZsZ0pqZS83MXhqTjlFbzFsNEpC?=
 =?utf-8?B?Zk8zMlNHeUwvc2J2NHZkYXp3OTdWS0p2U2ZqQWczall1VWlFR0V4Q3V0cFJU?=
 =?utf-8?B?VVFsUmZEK1ZvNWt1STlxN2VZS0llY1Z2TnEvYXJBSTB2andjeU9xU0dYSlhT?=
 =?utf-8?B?em5oVU9EWUJrUVhzMnFGZDgwVmJXb2s0K2s2ZjZiRjNQSnB4K1lKQWlyR3F2?=
 =?utf-8?B?dmc5TzdNUmxpdVc0eGY3MFg3ZThkZm4rT256aUdwb3YraWx5MEk0RDRZRlV2?=
 =?utf-8?B?WHk2RjNHTjU5Vi8yS0VWOXpsTTJUcG5QcThPb2RmYUtCck9NbHllUVUrSkg4?=
 =?utf-8?B?d2ZHelhaYlVUQmtFck5jREZtZ3hvUktJSlZyNE9DMWZJMnNZWGJObFpVcERs?=
 =?utf-8?B?U1dOcFY5Y1B2MXlTM1UrL3V2dVBKTWNtOURuSmRDQjBJZjIzOVMyTTgyR2RS?=
 =?utf-8?B?VmU5UWNKeEIrc3p2QzB1R2cvbVVTSnk3cnBFUFExS3pCcDhmSm9DaUdUSkZo?=
 =?utf-8?B?bGNESForZG5FVVVYNFE2T2dVQmh4S1VOTVA5Vkczc29PN1dDL04rUUsydnli?=
 =?utf-8?B?eDFSUGJ6c2tTUDBnOURDM21HM3VyK0IrVEljQ0dZSXdCRERORUxEYlh5dHhC?=
 =?utf-8?B?M3ljNzdoZ2NwMkFIZUs3UnU5WTgyOHZLVys5cU1mRUVKTi85TVdpYXIrSEtq?=
 =?utf-8?B?NVdiaUVBZlJFWDF6ZmJleUVSMHVNQnpkNnBOWHJXMUI1d3MvOUFNM1p6amFF?=
 =?utf-8?B?d1REZGg2bnFiU05FdDExbVJTMjlHYXJYWFY5TXBSME5tT2xzMkRUdWIzRXFB?=
 =?utf-8?B?aVdtZDFldmFPczJ3Um8yMnl5YkxHV0NHeE1FMWJHdHNWMEJGQ0NjZk4zOUhq?=
 =?utf-8?B?eDFGMGtxenEvTU5qanhBUjVEWWY4ZThIRjFSZjNRa3F1YjlMcFJHaExLRTNE?=
 =?utf-8?B?RmFYWjM1NGM0bEkzSkhKQWNvb3NVVG9uMVdUdXJIRVBDSlVQQTNMTk9SVzVw?=
 =?utf-8?B?Y2JYTElNNnZZcUY3dDI5bjVtRHpZcU5JRXNSM2FVaHFTOG1sRmJLRzhvdE9m?=
 =?utf-8?B?bUlyY3FRVW5yWHRXTThBWWlrVk9DangzOEphcys0bFlUditFTG8rYVRCVUxq?=
 =?utf-8?B?ZGU0KysxLy93VEZ0WDdiSk55OEVpYityV1kvZEZBejQ2R3Q4RDZvaDA4MUg3?=
 =?utf-8?B?WjZsUUxNMldCRzhQcS91Vm9VSFNldkFKMlJYSlpxUEFld1F0V2NQRlZvU09M?=
 =?utf-8?B?VEVKWkNPSDRSdnpIM21LcDg2aFdUR1JneW9BeUxLaU1BR1hiVHEwc1NCZ1Ba?=
 =?utf-8?B?TFBhc1k3TlJFUnlsUXpIMnhHZmtBZFQva09JblpYNU1Ua01DemtmbGZudDZi?=
 =?utf-8?B?d2oyQllycUE3UUhSQmQxcHFoNHJXclRwMER3MHl6WjB3a2FYZ0s5Y2lFUW9q?=
 =?utf-8?B?dkJ3SFF2UCtUZDRhU0VJNm1tb3hKNi96V1F0TDc3RlRSODJxWXB6Tmwwbm0v?=
 =?utf-8?B?ZmtvWkpzUlBCN3Y2ZXFpRFgvU3J4ZU9TN0hZb1dPQ3BaVDhtTGkrWjNJaE5N?=
 =?utf-8?B?ZlFHUkZueXVxdUtQTnpkRW9ESmpQL2xGS1FJQnl4WVo2S3JDUE0vRDhjcVBv?=
 =?utf-8?B?S1p6YVZWempaaDJrRFpFTEEvdWpTaWNlQVZUU29iTzBqQm9UamZ5a0hFbHQx?=
 =?utf-8?B?VlE2MURuMlg3YllmSlFFb3JNSmFvTFEwKzRsN3BXemd4VXQ4T2NnaDd2ZlFM?=
 =?utf-8?B?R21teUZhdzZZUTIyTHN2T1ZnbVQwa0xNYkdTYVJCQXlTYkdtVVFVTVZ5VHJI?=
 =?utf-8?B?dEdybWo3WGNpYjV1alZ4R2h1QzJaZVVRY1RIdlhVN3ZLS1JrN3lSMFBCaWg3?=
 =?utf-8?B?SXBCTGRGMzZnR3BSMjdLZHdoWDd2ZE9QaEtENGZGdTQ2ZnAyUWxrVlA5ZGwv?=
 =?utf-8?B?RlgyTDhrMmhmc2NxUHA5eDY1b2N5bDZYS3d6dFFiSThLcEJqYXpyZ01FNTVI?=
 =?utf-8?B?TmVxV3VVTHJ1aExYcU14b1l1eExyZHI2WHlkR0dUTWpPMlB6OTFVUWx4Rkgr?=
 =?utf-8?B?Z2d2UTNTU3lFZVJmQXJTM3NmWi90RXNmb3JHTFdCTk9rbFpLcUNyVkNKa3dt?=
 =?utf-8?B?OTV2OUp3SndHb3VuK1Y0YTZibnRJWHMwTlQ0bUUyMy92ZytrNUpiUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cafef02-74c6-4df2-e36a-08deab8b162f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:18:19.5894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgI/rp1vS/RdqG3Fq75pVy4UyD/SaK6x05hv29K8ARsgTDWZpw0dU1oKyeW/34p3kRINJf/6GgE8GAME3bcApw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
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



On 5/6/2026 11:46 AM, Boqun Feng wrote:
> On Wed, May 06, 2026 at 09:51:22AM -0400, Joel Fernandes wrote:
>> The C maple_tree struct contains a *mut c_void, which prevents Rust from
>> auto-deriving Send/Sync. Following is an example error message when using
>> MapleTree in nova-core's Vmm.
>>
>> This propagates up through MapleTreeAlloc to Vmm, BarUser, Gpu, and NovaCore,
>> causing NovaCore to fail the Send bound required by pci::Driver:
>>
>>   error[E0277]: `*mut c_void` cannot be sent between threads safely
>>       --> drivers/gpu/nova-core/driver.rs:77:22
>>        |
>>   77   | impl pci::Driver for NovaCore {
>>        |                      ^^^^^^^^ `*mut c_void` cannot be sent between threads safely
>>        |
>>        = help: within `MapleTreeAlloc<()>`, the trait `Send` is not implemented for `*mut c_void`
>>   note: required because it appears within the type `kernel::bindings::maple_tree`
>>   note: required because it appears within the type `Opaque<kernel::bindings::maple_tree>`
>>   note: required because it appears within the type `MapleTree<()>`
>>   note: required because it appears within the type `MapleTreeAlloc<()>`
>>        = note: required for `Box<MapleTreeAlloc<()>, Kmalloc>` to implement `Send`
>>   note: required because it appears within the type `core::pin::Pin<Box<MapleTreeAlloc<()>, Kmalloc>>`
>>   note: required because it appears within the type `Vmm`
>>   note: required because it appears within the type `BarUser`
>>   note: required because it appears within the type `Gpu`
>>   note: required because it appears within the type `NovaCore`
>>   note: required by a bound in `kernel::pci::Driver`
>>       --> rust/kernel/pci.rs:294:19
>>
>> Implement Send and Sync for MapleTree. The tree contains no thread-local
>> state, and all shared access goes through the internal ma_lock spinlock.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>> RFC->v2: Just adjusted a few comments as suggested by Gary.
>>
>> Sending this separately as discussed in the nova mm patch series that needs it:
>> https://lore.kernel.org/all/252a4eef-f4f4-4edf-8154-06cae4ad8518@nvidia.com/
>>
>>  rust/kernel/maple_tree.rs | 29 +++++++++++++++++++++++------
>>  1 file changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
>> index 265d6396a78a..2400c905270d 100644
>> --- a/rust/kernel/maple_tree.rs
>> +++ b/rust/kernel/maple_tree.rs
>> @@ -16,7 +16,11 @@
>>      alloc::Flags,
>>      error::to_result,
>>      prelude::*,
>> -    types::{ForeignOwnable, Opaque},
>> +    types::{
>> +        ForeignOwnable,
>> +        NotThreadSafe,
>> +        Opaque, //
>> +    },
>>  };
>>  
>>  /// A maple tree optimized for storing non-overlapping ranges.
>> @@ -240,7 +244,10 @@ pub fn lock(&self) -> MapleGuard<'_, T> {
>>          unsafe { bindings::spin_lock(self.ma_lock()) };
>>  
>>          // INVARIANT: We just took the spinlock.
>> -        MapleGuard(self)
>> +        MapleGuard {
>> +            tree: self,
>> +            _not_send: NotThreadSafe,
>> +        }
>>      }
>>  
>>      #[inline]
>> @@ -302,19 +309,29 @@ fn drop(mut self: Pin<&mut Self>) {
>>      }
>>  }
>>  
>> +// SAFETY: `MapleTree<T>` is `Send` if `T` is `Send` because `MapleTree` owns its elements.
>> +unsafe impl<T: ForeignOwnable + Send> Send for MapleTree<T> {}
>> +// SAFETY: `&MapleTree<T>` never hands out `&T`; all entry access is serialized
>> +// by `ma_lock` or `&mut Guard`, so `T: Send` suffices (`T: Sync` not required).
>> +unsafe impl<T: ForeignOwnable + Send> Sync for MapleTree<T> {}
> 
> I think you missed this:
> 
> 	https://lore.kernel.org/rust-for-linux/aepRx2jgIKmoRp-r@tardis.local/
> 
> ;-)

Oops, sorry about that.

> 
> But on a second thought, should that (we have methods of `&MapleTree<T>`
> -> `&T`) happen, we could always guard those methods with T: Sync. Maybe
> it's worth to keep a note on that but, anyway
> 
> Reviewed-by: Boqun Feng <boqun@kernel.org>
Ok, so I will leave as it is then, thanks for the tag!

--
Joel Fernandes

