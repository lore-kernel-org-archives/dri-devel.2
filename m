Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8A0CD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 17:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54AA810E2C0;
	Sat,  2 May 2026 17:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jmMzJR/9";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC0D110E2CA
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 17:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ73FC3uGc0slLqfuAXQsH5i9dtBsV6vB2jeAwj+bqlyG7KS/52CF9Sg3fuFCGgyvBn+Xj4ZFr0hZGLIHul4IvT3feCA7vDlHgxNSPhPLk6JuPq39hvr4YD7ssAXGbbn7Q6b8mnr5WrO0ZsiCjEtcQq/r6tz1dOUb/a93OdmzKUoJt5nM3cACxswtWMoTu9beDM+mMum7TsM6A6/BZhCE82XQggDSQ/SJdr7zojcJIlzHmwrlwZxgZGgcCuqf+d6XBMypYGSNHy0jHKDBjjH1wf/JJDUwL9D1/lxejh+sqLl3FGGtvyuTCuVNJySuH6DWdNDzGShEWzfLIgMmPtISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRatYbbvrDtQBhkz5LP2XP4tKx/fIUURlyWHKZu9yD0=;
 b=LVReM82bZigHP0DTPHadXCv9c75OHcIAiSWfsIEcRQmlfWXXdBq+tFZ77fn1zQ6mvJcWK/eboqSXqn0kQJyBla5tBw+z9rrPqSV+VI4cyFH7VYd4KI/cKYlBJLYd9qxIBl+5fSjPZsbjYvijbAFro+/yPPKKNUzakp3tKSYIcpgSW/NWhK3QOlbXJrDOSEwI42XjC3L5G7Z8dtSpnM1JqLfKc64UH3GTUubFfoJtt9wPwZNsqQX11B8TDLEtbs+lXjInjYvmgi04TZ4lxESZk5+ClGIONoa5nSLxMhu86obXU0KzZOtvjoJv6Cyz8/GNRfMYH7+det4LqedAfo39CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRatYbbvrDtQBhkz5LP2XP4tKx/fIUURlyWHKZu9yD0=;
 b=jmMzJR/9Y3rFzSMfiNv22es1hOJUMqp67Vze4czo5lrzzFhZXha5zhOf37ka+fgOavFkO1WsGVpThqUbIkb9CbVdJeqaA+Qo3UUG7FGZdxpsedBbxckWyPhjhDtH16/nr9pKwwcy9MG3xv0RnVCHosfDJuhGH5cnLE5uEHCiIC1GAky09TdhfkwzkHjmzsyNfHxLRT883sj0+tw1JH1gnZi86SmjOT59y0HpG/qr8E3VGlkIcArCr3FT1UsARtnnzgP2tZfxstRJQ+rEsyuRPNllZA/a/NWpUMC06bSmolYBnir3iebhAsYnanZEE3evzCAV3xDOSYRIChB6Z5AHiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.23; Sat, 2 May 2026 17:55:11 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 17:55:11 +0000
Message-ID: <a9d1fc72-a5aa-440e-88cf-b04882c24878@nvidia.com>
Date: Sat, 2 May 2026 13:55:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/22] gpu: nova-core: mm: Add common types for all
 page table formats
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-10-joelagnelf@nvidia.com>
 <DI8B094FNUYM.3MA4K3VXN53NV@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DI8B094FNUYM.3MA4K3VXN53NV@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0086.namprd15.prod.outlook.com
 (2603:10b6:930:18::19) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: d223cb7f-6e1c-44a8-e9b9-08dea873f434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mJ8otZAZsAc7zOrY+uIdjk7SJ6PiTXcTGeCI86yrxgztvAq91JvjE3gVsa00nxKS+JzC6BFDqJmhkoijn2ndzbUgybW4zlXegCMmhHQq9pLIDlzRNp51wyEcKlo0H4CRNPHm33vYdEOW3ml0uHmT7fdD7l39o85DBsC8QOyr+lEYcuQbnMLhh8EYg0pgUF3BzxFUt2ogXa+Is21A+1h6g3HB3We1asbdzPi5QRtPG9DvVa7lWdAvNo4hXpZiKHJwF0Ys0BYT/ydOkkPZ+cLSM9iR5nNyo0v37WJzIK/Duno+t7du2qC3pxEPAVcSuYZfYWHNT2SFPv3/qrDRYqi7hbYC3ZoAAU8oSmOQZD1aIgH38pyqcH6rcowfJ+unFzkghFY8+eTYL8FC8HuKLLyMCyZ9S1AHOU0iZWSmjVZy/mUaTccSLDyWK9yb+eJ6elz9YF1RxEQxqJjbzfhoKdKFt76qCSA3R9A7k6kp/g263nXfBB06xS2HAyhC+CDwA5Jf0N4Z+gZxkhfaGc6vh2B/o124DRuUt+xJhX4BPZM1cjL7r0ycKmqsAxP+ThngKaMDNHW2C9jGShuOwgsiAt93qBqz00YDDst55pN1rRL6tMJGQVnSSPnB3tXue+pegGQnYXTciBcbXGay0Kzjd4lT/lM/uzMbtDV1J9slekjbsjXpe6xtvIeGGEGBmcTqsM35
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDQxbXlwZGRaMnVKbnl3SExKS3FZZXkrR0Q1bE5xQTlWWDcvVTJaZlFDTGN4?=
 =?utf-8?B?Zk9qWnZ6T3BrNkgwME5EQ1E4dGRTN0pTN2FFNkdOQ2lEK0p0dUNYZjhrYSs1?=
 =?utf-8?B?RUd4bi9sdm1DUTdyNzJLK0VlQjZQRUcvM2VNeFNCQWhQcWx5UlhZdmpFRS82?=
 =?utf-8?B?TnNXVkhWNHlhc3VIaWJQZFZoSWppb29KV2ZYOStKUUdxeGdrMDNpdWk2MG1s?=
 =?utf-8?B?S2t6M1hlTHpoaGpZcXZiajFVck9Pemd6WHRBblJkdGZJSVo0dUlrM1FFczJD?=
 =?utf-8?B?L2NKRHFIRDlTOEM0d1ZHb3lRL2Y5aklIWGpLY1pTVFpwcFZqUWxBZGc2MVkx?=
 =?utf-8?B?Qy9YTWRFVVQ3VXhzZXFWUDJHVnVxU21lYXZPWStrRU1GRWFvZS9HNC9aWWc1?=
 =?utf-8?B?WkZLOHNnKzJmVnVYV3RUZjFpSEhDTXo0NGxaQ2pjallybmttZVA4dVdCei9s?=
 =?utf-8?B?amU1SVA5YUlSSTd4MHdYamNkdjNHNW5JaFpWOUhvb2RmMHNUVXIvaGJrSGE4?=
 =?utf-8?B?eXl3eHhhS0ZyeWpMeThZRkhtdGJZUGJTU2oybUFqQTlSVUIzSkpmRVZQdE14?=
 =?utf-8?B?R1lyZlhxU1UyOTNpWHcyby9ySHNQbHMrK1RhR294c25vVzJHM1BMblprTkph?=
 =?utf-8?B?dkoxQzJjeXVKL3VRc3BZR3kvVU5rOC9NUlBsSVZtQlZTZk9qUWdvd2wyMEFo?=
 =?utf-8?B?L0xWMVhNMjFMV1hjVjh4bHdVQkhCd2xtb3BYa1FETU9jbmwzTDRzTkcvOTV1?=
 =?utf-8?B?cWRtV0wrTU5DTi85LzQvL3NydzFLR0JDYks5VXE0NVV3Ry9zUEJHd2pUTEdL?=
 =?utf-8?B?NUZ2R2ZzMFNENkVFM2ptYjcvRWswNm1wclFjeHdIOU9XOXU3cDBoOENkeG1z?=
 =?utf-8?B?UWhDYjNqeVV5b0JYdXpxdGxEUklscXcyaWRRRVlsVTdmTG9SbkVrZkZaVUVx?=
 =?utf-8?B?VTdKSEczalM2S051YndrWmsvZVpBb3M3VWFNOGpaUCttU0xwTlQ1S2RQWGVw?=
 =?utf-8?B?QzdtRHlsems1cHd3Nk4xZUFiYVRuWi95ZTc0dXVYREZYdkE3TSt0QURWNVZF?=
 =?utf-8?B?RGU0a1JjVlBKcS9uZXlPYnc0RnhkclM2OTR3bUlsUkdqeFZHSEluTWVDMlpW?=
 =?utf-8?B?cTg5TnFUZWFCSENSREl5ckU5eGFaY1IzQjg2TkNqVFlyYVZsc1cxSktwU2Fh?=
 =?utf-8?B?Y09OOFFST1E4eWdoQisyc3dqRU40TE1NVVVLWEFuTTFrS0ZFSGpxcVdWQW1Z?=
 =?utf-8?B?d0RtOXhZbWwxeFlmdzk1Ymh2TVRmcHlGdGVuL2Mvalcxd3l0RUszOXZCTEFs?=
 =?utf-8?B?OHdqUTdjc0pJQ0tScXFtYjMrNnRsM2NPNGU3MGdFY1dTQVNvNURHQVlDcDhp?=
 =?utf-8?B?MHlvajVHMnRvZUpBM3JuMTVyZytEUHpQY0UvOFlBcmRYWUV5TE1qaGRjNDNu?=
 =?utf-8?B?YkNQQ0FMcE44WDFxUVd3ellidW0zL281U1ZaZ28yQUlMVmlLa2tFMlNtSGh1?=
 =?utf-8?B?OEJxQ1BkRGlIYkxPa01ocVJOTWtFYWlHTmd2bG9vd0ZMbFhLY0VTRmgxN1NH?=
 =?utf-8?B?VzlSZnc4bUFjVjdhWDdSNjhwOTJ4UDR2R1FKMWhHQXVDMXpQL005T1oxZEJD?=
 =?utf-8?B?WXRLZkhhY2xIdlZYNHl5b3lXVk05azcwTDc4YUFqNVh4UUFkRlEwTU1oMTZH?=
 =?utf-8?B?YkFrQ1c5UnI0bENWamVxN0R6Zkh0cndUY1NlMlFWVjFBelR4ZC9xbmlPZ2xn?=
 =?utf-8?B?VGJ4VXBacnY5SjJtZGozUVlvUEt3RG8wQlNIc1J1OVBVSDlTRjZVLzRxUnB1?=
 =?utf-8?B?WG52V0RtR0JlQ1h1ampXZ2tGZHFwS1VxYllmZktBeE13KzlrcTdxbXZiUHZO?=
 =?utf-8?B?NGlheUlxczdNeVlxMUtPTXl1ZzY5RnpnZEVsY1lZRGtBeE5TVzAxL2pOZiti?=
 =?utf-8?B?cm5nRHR2ZG4weFBFR0M5UGtXY056MktZNUQvYTc1OHVFWDdzME1kTE9DQTF3?=
 =?utf-8?B?emhqRTQ3aFFZWGtGdHZ1SGtoRGsvbTBhRmtaK3oyMWZHV3JLbVNpLzNhQmV3?=
 =?utf-8?B?UVdId2pJVlZ2bjQ3dG1sVlYxQVFhczkxZEJwRlpSOWd3dnhkcHYzclk2WDBH?=
 =?utf-8?B?THJOczUxc0ZTTWpHck4xaTg0SlVvZVlWa1dNTTlLYlluZGhjT2NkaVlOU2ZE?=
 =?utf-8?B?S1JuQmNkY2JkaFU3b2JncDdsSUFBNzZYK3JsbFhCUlBXcWhPb0xidmJrSTZn?=
 =?utf-8?B?K2djUmlxbWVMb2F3Rm1nemhYTldqSW5ZUTdsdU1naS9GTE16czREeWxBcFVU?=
 =?utf-8?B?ck1zT05vcVMrb2RocXdYQ0xDbDV6ODZlYU9nclFiWG9YNkZOU25VQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d223cb7f-6e1c-44a8-e9b9-08dea873f434
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 17:55:10.9785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46uugDIyAU+5FhtQFYTPl2+dRa6J5G7su1JfnXs6sbR430aXWyTiroZH1DcHiSuPHeRnMjutB3rT1o+DkTOMRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
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



On 5/2/2026 11:42 AM, Alexandre Courbot wrote:
> On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
>> Add common page table types shared between MMU v2 and v3. These types
>> are hardware-agnostic and used by both MMU versions.
>>
>> Cc: Nikola Djukic <ndjukic@nvidia.com>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/mm.rs           |   1 +
>>  drivers/gpu/nova-core/mm/pagetable.rs | 157 ++++++++++++++++++++++++++
>>  2 files changed, 158 insertions(+)
>>  create mode 100644 drivers/gpu/nova-core/mm/pagetable.rs
>>
>> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
>> index 8b8a86980bb6..045e35c92b78 100644
>> --- a/drivers/gpu/nova-core/mm.rs
>> +++ b/drivers/gpu/nova-core/mm.rs
>> @@ -32,6 +32,7 @@ macro_rules! impl_pfn_bounded {
>>      };
>>  }
>>  
>> +pub(super) mod pagetable;
>>  pub(crate) mod pramin;
>>  pub(super) mod tlb;
>>  
>> diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
>> new file mode 100644
>> index 000000000000..637ff43ea83a
>> --- /dev/null
>> +++ b/drivers/gpu/nova-core/mm/pagetable.rs
>> @@ -0,0 +1,157 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Common page table types shared between MMU v2 and v3.
>> +//!
>> +//! This module provides foundational types used by both MMU versions:
>> +//! - Page table level hierarchy
>> +//! - Memory aperture types for PDEs and PTEs
>> +
>> +#![expect(dead_code)]
>> +
>> +use kernel::num::Bounded;
>> +
>> +use crate::gpu::Architecture;
>> +
>> +/// Extracts the page table index at a given level from a virtual address.
>> +pub(super) trait VaLevelIndex {
>> +    /// Return the page table index at `level` for this virtual address.
>> +    fn level_index(&self, level: u64) -> u64;
>> +}
>> +
>> +/// MMU version enumeration.
>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> +pub(crate) enum MmuVersion {
>> +    /// MMU v2 for Turing/Ampere/Ada.
>> +    V2,
>> +    /// MMU v3 for Hopper and later.
>> +    V3,
>> +}
>> +
>> +impl From<Architecture> for MmuVersion {
>> +    fn from(arch: Architecture) -> Self {
>> +        match arch {
>> +            Architecture::Turing | Architecture::Ampere | Architecture::Ada => Self::V2,
>> +            // In the future, uncomment the following to support V3.
>> +            // _ => Self::V3,
> 
> The architecture definitions for Blackwell are now in `drm-rust-next`,
> so I think the next iteration can handle this.
> 
> Which reminds me: is V3 working? I remember some fixup by Eliot
> wandering around, have you integrated it to the series?

MMU v3 is working. But this series needs more patches on top of it for
Blackwell, I am carrying those extras in a different tree based on this
series. The fixes from have all been integrated (either in this series or
that other tree of extras).

Have all the base blackwell patches made it into drm-rust-next? If yes, I
can rebase this series on it, pull in the extras, and continue posting the
next mm iteration with blackwell support.

Thanks.

