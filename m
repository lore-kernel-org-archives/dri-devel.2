Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812651088E62
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FE910E7E9;
	Thu, 19 Mar 2026 02:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NbTcf3pz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010060.outbound.protection.outlook.com
 [40.93.198.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14BAB10E7EC
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QScmyn0iYheix7bh9KlpFAuqhNfrC0vOoeKipCOwJV81+6+QH3J5KsXd5Er7TPJhWPdz0LczaaF5dDpH+YDA7dRIl+9UIafdentaOBRL34rTt0+AKXkSxNFxN/LBke6IBXssVmea+dnxBcVe6flXGGewE+7CUzThQ/UFkbtPq6EKHfPUlbJ5guk8TeVU4wmwt6P1KMecwTWY+yl3rWWyoTboe5JSVpgAYU4azJ8uwHSxe2pyx8qRk6LYrAYFfgb8ANi/PjGpUcMH/tHK6aLRPn8+6TSnPPqSytgXpgfBGEwriFFZg5DzHb1wKUjDUodCYxksnQrCloucT4OQayw6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjbbQJ7VCiz9mhsVI+O2CMseNhKl3+t2/JGUOgmt6Dg=;
 b=OBWPjz+KGK5gCR9ce1goKVY/qI7EQSnhscLpy0MZJO9Hqx8/Omzg+po/A8/yzCHslizzfXWin07a8mqKiKJrh1SHnz+2BBhXlZwzPqfL31EH4YcRicC/GBYxpTpzBSD/L6AJ84DBeWGp6cmxYHsFovaTj+dcFGv3Mx/ywpUarIJdoqcNkhQr4r5BUW8XjBkV53h9ccCEhy/q8i+OGhR5Zpbfj/2GJZlhIsPXVB5UU35wwBhYYBChd0DJIavzRRYbfyZEx29ak0E6EHdFsKqWMHLLNs7J1f1F+okQZOfX9nuQd7aR+nBrh0hEkbJg3iiQc/r9lQM+sj2Ka2U4y3EQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjbbQJ7VCiz9mhsVI+O2CMseNhKl3+t2/JGUOgmt6Dg=;
 b=NbTcf3pzguiC1vDP0L7W6r8yJVsb25X0nt6fXIHOwJECP6cGQrJppW9358Pm3TmT2IUkLdpDBtkS0Z/I8AityCeCXfLZbN31TPDndv25ISkXYCHz/TqLj8/fQD5VRQ5yF7U+0PKNDEYXiOWU+OigkcB9smhRNhGn09VoEx4ggLofSQbIP886MAD5qLcyzI/VaGeFo87JXcDq+o2j4N0GE2MlbmlYUON4Vfa+wrqDR++UBiSLIjHnzaefdelwr9Cy9LJgLE3n7haAInlB4PQ7AuVlcdJ8FKuDoIj2TeCPUqT3hZBfPLFRFmxd+LZsSV5dwsThy1fay2Sscvu+7lUCqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 02:07:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 02:07:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 11:07:04 +0900
Message-Id: <DH6E45KONHJD.15LJ780SCTJPC@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/8] gpu: nova-core: convert PMC registers to kernel
 register macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-1-22a358aa4c63@nvidia.com>
 <DH6DL5899CLZ.2FMG8UQSNEII7@nvidia.com>
In-Reply-To: <DH6DL5899CLZ.2FMG8UQSNEII7@nvidia.com>
X-ClientProxiedBy: OS3P286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f5::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 481c8ecc-2867-4bea-758a-08de855c394e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: hesI+iK4wYlDpAwi23wWcfrs4sDn+7cbPTBURs5MsLmuHDMaFyp8J1304MV/hQISAaGsGwEx1Rrii3pbfWzXI75CQyPJd7CbcIAy1mU+/Q4egJlcehIB/QhWUpknC9iShap8OCao/bK/96GvTf9HnEv6e4tML/CwDq/sgqn28Tojp4AiHTkfRVh9GN8xj1YNt50Ayq8hx8AbvvJb8BtCptL3MSNBGPhBMRp0T91ogW89Mjfh4wW7SxTabePpKAP2uqiOT2v4GD1Y3zWss0J1m3d8SWczh7n6mB7PF3xoNZ85iDoQXbsIX9oaGRpXxQSaiiuroRPzGpIPplhxCd02O76S7HAfAI/ODn0ZLpzoGxEMcZicYp49SjE3yayNS6bkn9SLD1y58gW5ljol4vvDrDSbhQi9R0VMq6DeFn/4XindpOF3MuK70gRTEaNe+vcwzYjzREJf3CzW/Knkb9CwBDd4OnO5BfqQnLuF+CiKDhGijHSwljzGIz0LggMgJt5ZyQo7ax1XjyEEIBd3uSjHF/XZ3K5y3PgA8I1g+cynq0+Jtb6RWMHoaUTyu8fRXZOOED4dTKL3iKG+sGJT+9ZNk1XHctSf72iCHHm7aQI4Yq4B4uI3zw86qd1JDgnJjbxYncNxUdRYXwaapLmAJF8KV5OD76kjDsWkicmvnkLbgZQP3ayuBwwshQGboAUvKrMZOsrDo/nInUFAv5HOjlksvefZua/0GEr6dquLYkH0ORE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFZvTmJzT0o1WVhTRW1JU0RwaWFXd3dyYjBMaGZnZUpUNTFVeEVydDliYUV4?=
 =?utf-8?B?SldyODQyVUxkNWFFZ291aUt6ZVJjZlM5YThuRXc2OHFEaFNScVdOOVlOWmQ5?=
 =?utf-8?B?bmF1b2kwd2EzZUc4eC9NQzVlWmg0alRSNE94a0xDM2NQam5UQ2QvdTdEMENO?=
 =?utf-8?B?ZmRQVnpWV3NYY3JYUytRVDFxNEJ3L0V3UFVJV2d0MStRL1RGNVE3VHB5aUZG?=
 =?utf-8?B?SFpJQjJLTFJDNS9VdU5VNGliT2VFdEk0VDI0cmdVbFNCT2U5cDF6Rk9XWEw3?=
 =?utf-8?B?SWd1MnVGNEpPWkhrOWZjanQ4UGRHTTI5RnprOFpHZFBqRXRjMXBmNVFnZWxl?=
 =?utf-8?B?RHpZN0JMd0pscUtNL2x1aEQ4UE10NE1hdnBsT0xYMWpHbDZSRU5Ba2xqeGkv?=
 =?utf-8?B?KzBLWmNpMm4yS3Z1RDl0V1p5NGxuVkg0VXJ3WDZpZGMvcm4vNEhZMXVBZ1c5?=
 =?utf-8?B?M0s2MDBMa1Y0bUl4NW0ySXVzNitJU001SGRUeW5BU1lPTER4Q2ppYk9VZFJJ?=
 =?utf-8?B?elRHVzBzaWV2YmROdVhnNVMrNDhmM092MFFrVDNNSmc0SHY2am9na1kzaTJz?=
 =?utf-8?B?U3dOaHJ4emgwdjgraitSZ2dyMWd2N3dBWEVBbTlwVWhXTTE0NGQ5aDUySmNX?=
 =?utf-8?B?OEtTYStRTTk1T0ZCZTNxYVJlRGF0OHpFeGowZitpRzZyeHJXRVpYYU5oV0FF?=
 =?utf-8?B?anhhcWJEVlRGVjRySEx2NzdKZTRRWXJidm44OG1nVjRLL1ZEMzBVVGNQeG9z?=
 =?utf-8?B?ZVZ1S0ljUG1aYzhrNG5ybEc0dTJDbVdQeWU5aXJTZ1BxZStWODk3VitpZVpk?=
 =?utf-8?B?RXhtbXRNdXlrMStMNXM0ZXVEZVFDNTE4NDgwbm10akJNZlpLY2RuZGdlWkRE?=
 =?utf-8?B?eW1qaWZvdW5VVHZuRG1qL2liYWE4MlBaTG5pcitRUUFqVi9jTFNtTjIwUjY4?=
 =?utf-8?B?cTdQUTJLd1Z3WEljeUZtT0NyOEYzUW9CM0NOa0dFa3B2ME5mSnppU1NseVJT?=
 =?utf-8?B?bWdMbTUyRXdDc0E3cWNoamVUb1p4RVdOb3lKTVIrQ2o5S3JIS1JmT0paRHZE?=
 =?utf-8?B?c3hiUFdiZ3E0TFhIaDkzYWJ0bXQrSjg0V1NuQThralptL2lYRHpxbGY2M0hK?=
 =?utf-8?B?ZEdPTUdqUW9LM2JiZHZTcGwxMThRRTJoVVV4WGxNWmh5cy9yQmUwZnRQQUZT?=
 =?utf-8?B?WHJZWUZzSjZxWlVlUlFrT1cvaTN6VWpLVHlrTFBRbVhZZXBNU2JhdTN1ZHYr?=
 =?utf-8?B?cVhOdUVBU1k5SDRCOFkxbHJvQUFtOWg0Qlh0MzB2V1VSSjl2TGVmd3h4MjBk?=
 =?utf-8?B?QzNuODgxazdZaGg5aGdLV1RWZDQwV1BlaExOYWRKZkE4cnY4WTZNQW80M0wx?=
 =?utf-8?B?eHRkY2tXbjRYTGtNcWJaM0JrWk1XWFRzdU9JcGJPWVN1YVRCTVBTWDhkMEky?=
 =?utf-8?B?RkNMWVdQNXVZb205Rm1uWGhhZVVLVUJBaE40UDVCOFphVFkza1Z2b3JvVStq?=
 =?utf-8?B?UHl1QkhxdmZKWHZBMnFmcVJETDBFMXFqVFJSYTRMQ3VoWVhYWTFtZ1h1YzlJ?=
 =?utf-8?B?dDZhVzkwY3R0dE1lSEp1SktGWjlhRFIwVGxqbDZSQlUwTDF0R0M1VTBJTDBY?=
 =?utf-8?B?VExEYW55OEpFQisvS1UzdkZUeFV2Nkx6anpTMGFPZWxaKzJCc0NPa3orYVQ2?=
 =?utf-8?B?VDlvQTd4ZkVuNUsvZVU0eWkwY01kaVZyU2lieHBUOFp6YmtmZGVhMGxja3E5?=
 =?utf-8?B?Wm1oaDYzd0M5WmdhRFM3TjhQSEZhQjc5WU5PU2I0cmtLYm5SRXlLK3F4empR?=
 =?utf-8?B?dnF2ZWtPTXdDOEFPTkJ3R250NEV3N2tVZCtPVnRTKzNsTXdLbUNUaXBhdFdQ?=
 =?utf-8?B?VmdQSWxFLzk3Sjk0TFdENDZBVVJwM1FwZCtGTDQ4NzNnOHhlM1QxOFJlME5v?=
 =?utf-8?B?RUwzckY3U0JFU2p6dHZPc1JCd0YydllWVHErd3BLRnZjcC8xNHlFV2I0clNB?=
 =?utf-8?B?UWFuR21ha1dzMUh2WXlqbnBWKzVnL09MRUovcGJjTUkzZGhhczh2YXFPQWxX?=
 =?utf-8?B?YTNmbVJFbitwSmxjSHRsWUJPS1FaZllhU0R5Vm42WDdFK1NQOEZlUHcwcmYz?=
 =?utf-8?B?SWtGQ015VldxL2RtbUtrYnA2dEhucThEQlBsd2hsbEJ0UlNSeWtyQWNPUmsy?=
 =?utf-8?B?WWhmTFJuUDdEMUpJajhOTERRQUFOUVg3N3plc0p3eVpLdlZiNTBVZ0xSMVBH?=
 =?utf-8?B?QkxZM0lRcXRBd3MrSDFJRHN6ZXVlNCtoSXhKdXBmS2YwTm5xcjZNeHhycWk1?=
 =?utf-8?B?WEIwbHA3UXZGZVVnbWpnMXhvaHRvUE1oLytGZlJGVlVxS0I3aU50K0s3YnRq?=
 =?utf-8?Q?avcXp/7ZkUpy+9msx+RBfDKc7WkF9L9NVZv/GLLVObCdP?=
X-MS-Exchange-AntiSpam-MessageData-1: xB5yWYeQgdv3jw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481c8ecc-2867-4bea-758a-08de855c394e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:07:08.2032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpDGMtd+PXq55H44xD4YDETrKDzJesDkzrhS6kPH9AGDYtWxjm8wY20e4QA/215VHDN1d1X2s7yWmSEPRNQO0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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

On Thu Mar 19, 2026 at 10:42 AM JST, Eliot Courtney wrote:
> On Wed Mar 18, 2026 at 5:05 PM JST, Alexandre Courbot wrote:
>> Convert all PMC registers to use the kernel's register macro and update
>> the code accordingly.
>>
>> nova-core's registers have some constant properties (like a 32-bit size
>> and a crate visibility), so introduce the `nv_reg` macro to shorten
>> their declaration.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/falcon.rs |  7 ++--
>>  drivers/gpu/nova-core/gpu.rs    | 37 ++++++++++-----------
>>  drivers/gpu/nova-core/regs.rs   | 73 +++++++++++++++++++++++++++++++---=
-------
>>  3 files changed, 78 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/fal=
con.rs
>> index 7097a206ec3c..4721865f59d9 100644
>> --- a/drivers/gpu/nova-core/falcon.rs
>> +++ b/drivers/gpu/nova-core/falcon.rs
>> @@ -13,7 +13,10 @@
>>          DmaAddress,
>>          DmaMask, //
>>      },
>> -    io::poll::read_poll_timeout,
>> +    io::{
>> +        poll::read_poll_timeout, //
>> +        Io,
>> +    },
>
> nit: // should be on the last import?

It should, thanks.

>
>>      prelude::*,
>>      sync::aref::ARef,
>>      time::Delta,
>> @@ -532,7 +535,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
>>          self.hal.reset_wait_mem_scrubbing(bar)?;
>> =20
>>          regs::NV_PFALCON_FALCON_RM::default()
>> -            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
>> +            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
>>              .write(bar, &E::ID);
>> =20
>>          Ok(())
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index 8579d632e717..d81abc7de3d7 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -4,6 +4,8 @@
>>      device,
>>      devres::Devres,
>>      fmt,
>> +    io::Io,
>> +    num::Bounded,
>>      pci,
>>      prelude::*,
>>      sync::Arc, //
>> @@ -129,24 +131,18 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::=
Result {
>>  }
>> =20
>>  /// Enum representation of the GPU generation.
>> -///
>> -/// TODO: remove the `Default` trait implementation, and the `#[default=
]`
>> -/// attribute, once the register!() macro (which creates Architecture i=
tems) no
>> -/// longer requires it for read-only fields.
>> -#[derive(fmt::Debug, Default, Copy, Clone)]
>> -#[repr(u8)]
>> +#[derive(fmt::Debug, Copy, Clone)]
>>  pub(crate) enum Architecture {
>> -    #[default]
>>      Turing =3D 0x16,
>>      Ampere =3D 0x17,
>>      Ada =3D 0x19,
>>  }
>> =20
>> -impl TryFrom<u8> for Architecture {
>> +impl TryFrom<Bounded<u32, 6>> for Architecture {
>>      type Error =3D Error;
>> =20
>> -    fn try_from(value: u8) -> Result<Self> {
>> -        match value {
>> +    fn try_from(value: Bounded<u32, 6>) -> Result<Self> {
>> +        match u8::from(value) {
>>              0x16 =3D> Ok(Self::Turing),
>>              0x17 =3D> Ok(Self::Ampere),
>>              0x19 =3D> Ok(Self::Ada),
>> @@ -155,23 +151,26 @@ fn try_from(value: u8) -> Result<Self> {
>>      }
>>  }
>> =20
>> -impl From<Architecture> for u8 {
>> +impl From<Architecture> for Bounded<u32, 6> {
>>      fn from(value: Architecture) -> Self {
>> -        // CAST: `Architecture` is `repr(u8)`, so this cast is always l=
ossless.
>> -        value as u8
>> +        match value {
>> +            Architecture::Turing =3D> Bounded::<u32, 6>::new::<0x16>(),
>> +            Architecture::Ampere =3D> Bounded::<u32, 6>::new::<0x17>(),
>> +            Architecture::Ada =3D> Bounded::<u32, 6>::new::<0x19>(),
>> +        }
>>      }
>>  }
>> =20
>>  pub(crate) struct Revision {
>> -    major: u8,
>> -    minor: u8,
>> +    major: Bounded<u8, 4>,
>> +    minor: Bounded<u8, 4>,
>>  }
>> =20
>>  impl From<regs::NV_PMC_BOOT_42> for Revision {
>>      fn from(boot0: regs::NV_PMC_BOOT_42) -> Self {
>>          Self {
>> -            major: boot0.major_revision(),
>> -            minor: boot0.minor_revision(),
>> +            major: boot0.major_revision().cast(),
>> +            minor: boot0.minor_revision().cast(),
>>          }
>>      }
>>  }
>> @@ -208,13 +207,13 @@ fn new(dev: &device::Device, bar: &Bar0) -> Result=
<Spec> {
>>          //     from an earlier (pre-Fermi) era, and then using boot42 t=
o precisely identify the GPU.
>>          //     Somewhere in the Rubin timeframe, boot0 will no longer h=
ave space to add new GPU IDs.
>> =20
>> -        let boot0 =3D regs::NV_PMC_BOOT_0::read(bar);
>> +        let boot0 =3D bar.read(regs::NV_PMC_BOOT_0);
>> =20
>>          if boot0.is_older_than_fermi() {
>>              return Err(ENODEV);
>>          }
>> =20
>> -        let boot42 =3D regs::NV_PMC_BOOT_42::read(bar);
>> +        let boot42 =3D bar.read(regs::NV_PMC_BOOT_42);
>>          Spec::try_from(boot42).inspect_err(|_| {
>>              dev_err!(dev, "Unsupported chipset: {}\n", boot42);
>>          })
>> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.=
rs
>> index 53f412f0ca32..62c2065e63ef 100644
>> --- a/drivers/gpu/nova-core/regs.rs
>> +++ b/drivers/gpu/nova-core/regs.rs
>> @@ -35,20 +35,64 @@
>>      num::FromSafeCast,
>>  };
>> =20
>> +// All nova-core registers are 32-bit and `pub(crate)`. Wrap the `regis=
ter!` macro to avoid
>> +// repeating this information for every register.
>> +macro_rules! nv_reg {
>> +    (
>> +        $(
>> +            $(#[$attr:meta])* $name:ident $([ $size:expr $(, stride =3D=
 $stride:expr)? ])?
>> +                $(@ $offset:literal)?
>> +                $(@ $base:ident + $base_offset:literal)?
>> +                $(=3D> $alias:ident $(+ $alias_offset:ident)? $([$alias=
_idx:expr])? )?
>> +            $(, $comment:literal)? { $($fields:tt)* }
>> +        )*
>> +    )=3D> {
>> +        $(
>> +        ::kernel::io::register!(
>> +            @reg $(#[$attr])* pub(crate) $name(u32) $([$size $(, stride=
 =3D $stride)?])?
>> +                $(@ $offset)?
>> +                $(@ $base + $base_offset)?
>> +                $(=3D> $alias $(+ $alias_offset)? $([$alias_idx])? )?
>> +            $(, $comment)? { $($fields)* }
>> +        );
>> +        )*
>> +    };
>> +}
>> +
>
> Is it really worth introducing this macro to save pub(crate) and (u32)?
> Are we definitely going to always be using pub(crate) and u32?

So far we are. I'm not particularly passionate about it, but I think
it's nice not having to repeat ourselves (and potentially introduce
typos).
