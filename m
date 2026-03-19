Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E36109022E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6953310E8ED;
	Thu, 19 Mar 2026 14:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X/doa5lV";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0541A10E8ED
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 14:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9LHZAi9fVoBM8zqFDI1m+cHjLeUEOEVRjU7mH3cErCya9F0k0ESv4cIPQP22QmLpAt6KOUplCbVEv4WY3k3SoXDs8Sh2DcuIwkY8Eokp6clXVWQHs3ee2dgssF3yivPL5OuE/DkBqgCfEJe7+w477Mq5eJhNbGOLcAA/YwrP+LcMwVBHRMYUMtXELuF6mxhZsibPCDLwTlkRGcrAUqtZBHARGgjzT/5RA/Vvb7C8K0LZnsxbSwnB+z0dOX8Fhe9big3JfOwgQzNm2BPIqk1MEWdcRSr3J9ozXwQPGkeSzS5rImOWbEVUUs9s6OXuc8MjPJt/Orin/UyyrX6uubX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4qbYp4r7dPG3qYJ8ExKGtJH0EIZYwxY22mo05bIKcE=;
 b=n5bWA/h4PAdkPLtaMJcI9xpnbtyDI1KwLyLULiSf/IOAWN4DEJltYPDXMkq7kimDur9ijx1Gwbm02OP5hNFNeqg1QZZ2DPzpHV1Vy6A/UsHn21AmkTBrDoH2mB2wepnD/AnRDta2kGVG9xhbZn5Lafj88TDgge9M9kyZivs4cxh+NhoJuXMfMLRu/xjnqe5IiU5Y8s6vLNnUj9Aant4wia3ZhjIGMYPQswCax5QhIMbNuXtF9Prxl29ouQ+fpZqTDe/vK6bUCK7jJKKwkw3K/FTdhEWKnmy8j5DpOFwv0AZkzPR1hGNTaHHIinDO8bi6GVu+KZcSjpc4Y8/gvfri0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4qbYp4r7dPG3qYJ8ExKGtJH0EIZYwxY22mo05bIKcE=;
 b=X/doa5lV4AXu6N+U4/GQmeIg2RR7ZjNu0Wv/MhICT4w7hKxDk1a4mywdm0CfJkHmwN56VdGGiJamU4GpFCje5k3Q08NucjUYad0+bKxMZJxDB8W1HDPJ0ZS2tkV3RcHbblKmOZHEpKKtcqrNzk4MiYUnMVXpjpEOdXGeTVB5kzFwC9L/1jBrt8vVv2YCxQZV0HoJaubcsrtn+aZi1JT2tkl3AWmN3SZbPAVG5FTqcAggSvTEZTk24avkgl0j+FODfdbd9p460c+pQtjBzkr78zl6rEC4wDaF7Bwz0r5pWXguLGAEsFXj9rY+91+X0WhLFj2TsmUz4mCW+9XT3/dLQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 14:34:27 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 14:34:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 23:34:24 +0900
Message-Id: <DH6U0CO238C0.MHQ7TUBQTA9L@nvidia.com>
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
Subject: Re: [PATCH 7/8] gpu: nova-core: convert falcon registers to kernel
 register macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-7-22a358aa4c63@nvidia.com>
 <DH6IJKX25H7H.28NWD4KJSXX73@nvidia.com>
In-Reply-To: <DH6IJKX25H7H.28NWD4KJSXX73@nvidia.com>
X-ClientProxiedBy: TYCP286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f98f920-1fbb-4ca7-41ad-08de85c49fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: X4IGdTImngURu5AAdGWYIXyELdAkGOdfLTpXYlI0+L5i0yHY4kMUIG2MtZBKeu8MpGlr2eyKsgf8AbcqSXt3K7LcBrAXc/izf95TzpVJFlhTgnY/PJEvTn5jyVlF83yMrrSr4WhpClLYl1EsCVn10QKPl1C7Qim/xeaMEQEg9cbq+f4EO5A+wRltclJZcaAybhWvLGfV1oFT2XkSfB6p0+xaPQZ7Wpv+nuG0qy4LOcpQnmCKaEm++LU3SwtUGPXOvr6MZhhcLBHCOmZchbzlc8D5Q2EgX6Oo4nVl/Ffqiste9un5KOWLE2X/p8sEA0KC+9ejygFBIzOt029aVtHkIgREkJPdTpIdDA/45Vb1xC+1/b7XZuRakL/yMk87Fl2J1B00JwBGQprjHJBM9UvnDAl7DgTzGn9l0I5Tw8KcFDe09S8jut+rAAcMGPpeXXI/2+lQ7RKqgWxaOVtCNw/qS1zXjPNc3EqMlwU790dOETClbv2N7+7qTmgHoyrF3ESANRQIwOFwSS0iSaRXnOyrEvQoGJ71XGXUTO/2Iz5qbTOPN5CAohJN8f7+S3V10SZnP8sYcQZHUZTfvHK+eUqTvNR9my5BqpnLbZHtqC5EU8day6Q+B0wJOFoDwUpRpo2dBjAGE8XaYR7zy5NQw2eVVH6mYGMqYkfLznNxch9dg2MALd3p4iuFJ1C6SOf3V9rkko9Z0G1p60RWcrkCCIbR0MSunea9a10nj4OQ63dLhwvMYzmWuF00v+vt0DZz93eb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0diS0V6di9PUUJYbHdBdTRZOHNoSDF2YUFSVW5XeW5Wb2xSQzdSY3JueitC?=
 =?utf-8?B?UE5meDE3UnY3R0ltZXlGWG5GMGR3UDBEVFFMOWhyd2IyemU1VGREai9vMG1i?=
 =?utf-8?B?dEh0UFY5eWc0RmRhSWJsM0V4eHd3Y3pPbUhCVEViaUQrQlYydTExQTFReXlT?=
 =?utf-8?B?aXFHamk5QVV0c1orL0t5bkxpRVlxbHVEYTZTQUlzR3dBQk41Y25ZRmpSWmZ3?=
 =?utf-8?B?MW0xL010L1grSjd1MFljRjlmTGEzU2t2ZUJHVUtrZncyMjZ6WGdwYWZnZmlG?=
 =?utf-8?B?Z085MGw4ZVJZVlFJTzhOM2dybG42NWgwSWY0aG9CWi8rRTA3ZDJ4OU1xMzZy?=
 =?utf-8?B?RlZIWEFZenhMUjNxbDhEUWxNbjlCVEw4UENjM09EeVBrZVhwaFZaQmw1N0pm?=
 =?utf-8?B?dklYUVRSQmo3SjhQUDc0cWlpYlh4cXdRTzY2UnhKdWdueUFuVVZnMFlQYUxZ?=
 =?utf-8?B?YXFYM3FNZVZwT0lJZjJkbXlYUDl6MG51ZmZiUXNsTllIS1dkaXF1TS9nbjUy?=
 =?utf-8?B?T25QYkk5OWp3YU4zOHdSNHd4emsyK0dJcTcxcmJldmgvZWYvRXlTN3I0M2M2?=
 =?utf-8?B?R1dpVDBUQ0h0YUNDWlh4b3BqUnlKWXp0TEVkM0JrNzA4Sk1qR2N6ZGRRUnYz?=
 =?utf-8?B?V05nbWFLcUZudWI2QjJSb2JBb1dFT1BDaGFMV0E4K1hVSUtOT042VnRFOXlI?=
 =?utf-8?B?TitDbzhYYm1BMStKcUNmeFNhT0xta0RsUjE1U2FkcW1ydVp1ZENKU1JLbnYw?=
 =?utf-8?B?S3ZUdzBwL0h2MWh1QTlHTWVwbnpvS0I5MTFuaGU3L3I5d2F1amtjb3VUN3Nj?=
 =?utf-8?B?SDVJZ0dXcjFxWDEwUG94c2UrR1ZGWmdFS0JBbGJFZGs1TGFaYWtJOXE2SG8x?=
 =?utf-8?B?SmxVT29DTXVZSVN2QnlXQU1sVmNjNHRKV3I0dWFVc045R2NpSUxLanhlNWNG?=
 =?utf-8?B?bFBQNlJUdGkxQUpYaGcwTVJVSUJmdmpWTUtvMVZ1V0pzQlJEQnh3dGt3N3hz?=
 =?utf-8?B?YmQvSTFGaE1pV2RNVkY5S2FVbHhnbmM4TmlaWWtsNTZUVjROSFdjSldza2NK?=
 =?utf-8?B?SFdkT2VLRTRwYTFseDBzV2FCbEpEZ0l6dmtybTA1VWpDVTMvV1hEdkJGdERV?=
 =?utf-8?B?NldtekRvVW16cmZVcDdwSnFRc2NObm1KbGl3NUNiYU5zRUoyRnFhaTkwaFND?=
 =?utf-8?B?eE83ZWxZWmFURit6NnpYL1VzK0xYRnJWSzdyaVp6RTFGOWFaZ09TcHV2ZEJ4?=
 =?utf-8?B?YnZrWUwzUkFleGQ5d2NDMjUyQXVGb1pBMkVadjZzWXBhbCtIRnl5SVlQemZl?=
 =?utf-8?B?Nm9mdktLYW90QXFrQ29tRGxpa2UyMUJsQnNoOG5HL1k3V1FRcVRsRHluZEdi?=
 =?utf-8?B?T2g0dG1uT1NuSGlISFBNdmQ0a0hIVmFnS2NNVVZONVRiY3FjWjA1enZzTlhF?=
 =?utf-8?B?QnEySUVaODhkTktlMlZkUXBpa1MvNjBWQlBQMDZ1RFY0SjdEd2FZdDhlSjRa?=
 =?utf-8?B?SkgxMjlKd3pRZTdwODRhN21nQUtiTjZ2WXI1VmdEOHB0azErRGxPZE56NXpm?=
 =?utf-8?B?Unp1Q3RvSE1rZ1FEUDNqU1VGODMwQWJOZUpMOStRRjBGNmhKeGpBSE1FRmQw?=
 =?utf-8?B?WFdpdUUzRVpyWVo2U3dCSlI5RktTa3pVOUdUbTBhWW5ST2NERkxSOW0rM0lh?=
 =?utf-8?B?RHhMemdFK2orYjZHbkRVVk5mektDNFhRZzNvSmNSc0VnYmFjOW92QUVyQ1RQ?=
 =?utf-8?B?dTUwWlMzVzJuVDJxN0VCQngwVEZmMk1XSEtQSVQ1ZFpaRzd6Ris3TGprTUFo?=
 =?utf-8?B?YVFGR2syZlBIb1BjN0VXMHJDZERIY2RIaytTbHZzZUhXOVNCOEVZWjFyVHY2?=
 =?utf-8?B?bHd5d1lTSzIvcXhBZFRkeDlYbmJwaDBNNnNWM0hzc3d3UHNvdlVPRm5WRW5S?=
 =?utf-8?B?NmtXOC8vL0hDL29TcVR3Z09mb3k2amJaUW1pYllDNHE2bUpJT0Q1MFplaXAw?=
 =?utf-8?B?RXFZS01TUFI3cWorSnJ0TFdWaGQ5NjRYZTRLdE1OdWRuM2M4cXZ1dFZNeTlq?=
 =?utf-8?B?ODZlV2R4Q2pwWjR1WHBGVWxzM3FjNlNaU2ZCOHRQelJsd1pGT0ZuWnBvQlFh?=
 =?utf-8?B?YkZHTVpCcVV5Vi9WTG14ZzRvekx2TTlsUW1DV0FZdnVodnBKd1JiZlozTElw?=
 =?utf-8?B?MXd4TTNaZlhicmxySFhBSEtmNm5iNXJzdGh1U29jL3hDYmVJbUxFSVpyTEo1?=
 =?utf-8?B?SldDaHdQNi90cmtqWmUzeEk1bTlIOGx2RmhEcDM0QStkSUpkL1VxOVNPcG1F?=
 =?utf-8?B?Um5aOTZZN0swaTJRSk02dkpzNmJHaGdJM1VpRlF5cWhqMVNBRlByM3BCZDJS?=
 =?utf-8?Q?czUFySgmc+30YIS+GHkeZL2Io+VZXyJD0euKPK2n+X3vy?=
X-MS-Exchange-AntiSpam-MessageData-1: klcgmHn3ATX1BA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f98f920-1fbb-4ca7-41ad-08de85c49fa2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:34:27.3111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dARSyek96yE+WZSNZMsn2pJdJ/RlJD125Cy+j9O1ZvoPgrELBWd93dRbBy4ciypCJhHgsqcmnFnA1brpJlWE4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543
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

On Thu Mar 19, 2026 at 2:35 PM JST, Eliot Courtney wrote:
> On Wed Mar 18, 2026 at 5:06 PM JST, Alexandre Courbot wrote:
>> Convert all PFALCON, PFALCON2 and PRISCV registers to use the kernel's
>> register macro and update the code accordingly.
>>
>> Because they rely on the same types to implement relative registers,
>> they need to be updated in lockstep.
>>
>> nova-core's local register macro is now unused, so remove it.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/falcon.rs                    | 333 +++++-----
>>  drivers/gpu/nova-core/falcon/gsp.rs                |  22 +-
>>  drivers/gpu/nova-core/falcon/hal/ga102.rs          |  55 +-
>>  drivers/gpu/nova-core/falcon/hal/tu102.rs          |  12 +-
>>  drivers/gpu/nova-core/falcon/sec2.rs               |  17 +-
>>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  19 +-
>>  drivers/gpu/nova-core/regs.rs                      | 350 +++++-----
>>  drivers/gpu/nova-core/regs/macros.rs               | 739 --------------=
-------
>>  8 files changed, 421 insertions(+), 1126 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/fal=
con.rs
>> index 4721865f59d9..90afef40acd0 100644
>> --- a/drivers/gpu/nova-core/falcon.rs
>> +++ b/drivers/gpu/nova-core/falcon.rs
>> @@ -14,9 +14,14 @@
>>          DmaMask, //
>>      },
>>      io::{
>> -        poll::read_poll_timeout, //
>> +        poll::read_poll_timeout,
>> +        register::{
>> +            RegisterBase,
>> +            WithBase, //
>> +        },
>>          Io,
>>      },
>> +    num::Bounded,
>>      prelude::*,
>>      sync::aref::ARef,
>>      time::Delta,
>> @@ -33,7 +38,6 @@
>>          IntoSafeCast, //
>>      },
>>      regs,
>> -    regs::macros::RegisterBase, //
>>  };
>> =20
>>  pub(crate) mod gsp;
>> @@ -44,11 +48,14 @@
>>  pub(crate) const MEM_BLOCK_ALIGNMENT: usize =3D 256;
>> =20
>>  // TODO[FPRI]: Replace with `ToPrimitive`.
>> -macro_rules! impl_from_enum_to_u8 {
>> -    ($enum_type:ty) =3D> {
>> -        impl From<$enum_type> for u8 {
>> +macro_rules! impl_from_enum_to_bounded {
>> +    ($enum_type:ty, $length:literal) =3D> {
>> +        impl From<$enum_type> for Bounded<u32, $length> {
>>              fn from(value: $enum_type) -> Self {
>> -                value as u8
>> +                // Shift the value left by the number of unused bits.
>> +                let b =3D Bounded::<u32, 32>::from((value as u32) << (3=
2 - $length));
>> +                // Shift back right to create a `Bounded` of the expect=
ed width.
>> +                b.shr::<{ 32 - $length }, $length>()
>>              }
>>          }
>>      };
>
> This can silently truncate stuff if we typo the wrong bounded size.
> Any reason not to use `Bounded::from_expr(value as u32)` for this?

`from_expr` is tricky to use because it assumes the compiler optimizer
has enough information to guarantee that the set of possible values will
fit into the `Bounded` - and drops a very obscure build-time error if
the proof cannot be established. So it is really for obvious cases like
`if x < 0x10 { Bounded::<u8, 4>::new(x) }`.

Here we are converting from an enum, and in my experience `from_expr`
does work, but I still prefer to avoid it if we can. The bit-shake
method is another way of obtaining the right `Bounded` but in this case
you are right we can lose data - although the use is purely local, and
temporary until the `TryFrom` and `Into` derive macros [1] are
available.

The "correct" way to do this meanwhile would be to generate a match
statement handling all valid values, but this is a bit more intrusive
for something that is temporary.

[1] https://lore.kernel.org/all/20260129-try-from-into-macro-v5-0-dd0110081=
18c@gmail.com/

>
>> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.=
rs
>> index 4ac4e9126db8..08d9a9697adc 100644
>> --- a/drivers/gpu/nova-core/regs.rs
>> +++ b/drivers/gpu/nova-core/regs.rs
>> @@ -1,13 +1,10 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> =20
>> -// Required to retain the original register names used by OpenRM, which=
 are all capital snake case
>> -// but are mapped to types.
>> -#![allow(non_camel_case_types)]
>> -
>> -#[macro_use]
>> -pub(crate) mod macros;
>> -
>>  use kernel::{
>> +    io::{
>> +        register::WithBase,
>> +        Io, //
>> +    },
>>      prelude::*,
>>      time, //
>>  };
>> @@ -314,60 +311,147 @@ pub(crate) fn vga_workspace_addr(self) -> Option<=
u64> {
>> =20
>>  // PFALCON
>> =20
>> -register!(NV_PFALCON_FALCON_IRQSCLR @ PFalconBase[0x00000004] {
>> -    4:4     halt as bool;
>> -    6:6     swgen0 as bool;
>> -});
>> +nv_reg! {
>> +    NV_PFALCON_FALCON_IRQSCLR @ PFalconBase + 0x00000004 {
>> +        4:4     halt =3D> bool;
>> +        6:6     swgen0 =3D> bool;
>> +    }
>> =20
>> -register!(NV_PFALCON_FALCON_MAILBOX0 @ PFalconBase[0x00000040] {
>> -    31:0    value as u32;
>> -});
>> +    NV_PFALCON_FALCON_MAILBOX0 @ PFalconBase + 0x00000040 {
>> +        31:0    value =3D> u32;
>> +    }
>> =20
>> -register!(NV_PFALCON_FALCON_MAILBOX1 @ PFalconBase[0x00000044] {
>> -    31:0    value as u32;
>> -});
>> +    NV_PFALCON_FALCON_MAILBOX1 @ PFalconBase + 0x00000044 {
>> +        31:0    value =3D> u32;
>> +    }
>> =20
>> -// Used to store version information about the firmware running
>> -// on the Falcon processor.
>> -register!(NV_PFALCON_FALCON_OS @ PFalconBase[0x00000080] {
>> -    31:0    value as u32;
>> -});
>> +    /// Used to store version information about the firmware running
>> +    /// on the Falcon processor.
>> +    NV_PFALCON_FALCON_OS @ PFalconBase + 0x00000080 {
>> +        31:0    value =3D> u32;
>> +    }
>> =20
>> -register!(NV_PFALCON_FALCON_RM @ PFalconBase[0x00000084] {
>> -    31:0    value as u32;
>> -});
>> +    NV_PFALCON_FALCON_RM @ PFalconBase + 0x00000084 {
>> +        31:0    value =3D> u32;
>> +    }
>> =20
>> -register!(NV_PFALCON_FALCON_HWCFG2 @ PFalconBase[0x000000f4] {
>> -    10:10   riscv as bool;
>> -    12:12   mem_scrubbing as bool, "Set to 0 after memory scrubbing is =
completed";
>> -    31:31   reset_ready as bool, "Signal indicating that reset is compl=
eted (GA102+)";
>> -});
>> +    NV_PFALCON_FALCON_HWCFG2 @ PFalconBase + 0x000000f4 {
>> +        10:10   riscv =3D> bool;
>> +        /// Set to 0 after memory scrubbing is completed.
>> +        12:12   mem_scrubbing =3D> bool;
>> +        /// Signal indicating that reset is completed (GA102+).
>> +        31:31   reset_ready =3D> bool;
>> +    }
>> =20
>> -impl NV_PFALCON_FALCON_HWCFG2 {
>> -    /// Returns `true` if memory scrubbing is completed.
>> -    pub(crate) fn mem_scrubbing_done(self) -> bool {
>> -        !self.mem_scrubbing()
>> +    NV_PFALCON_FALCON_CPUCTL @ PFalconBase + 0x00000100 {
>> +        1:1     startcpu =3D> bool;
>> +        4:4     halted =3D> bool;
>> +        6:6     alias_en =3D> bool;
>> +    }
>> +
>> +    NV_PFALCON_FALCON_BOOTVEC @ PFalconBase + 0x00000104 {
>> +        31:0    value =3D> u32;
>> +    }
>> +
>> +    NV_PFALCON_FALCON_DMACTL @ PFalconBase + 0x0000010c {
>> +        0:0     require_ctx =3D> bool;
>> +        1:1     dmem_scrubbing =3D> bool;
>> +        2:2     imem_scrubbing =3D> bool;
>> +        6:3     dmaq_num;
>> +        7:7     secure_stat =3D> bool;
>> +    }
>> +
>> +    NV_PFALCON_FALCON_DMATRFBASE @ PFalconBase + 0x00000110 {
>> +        31:0    base =3D> u32;
>> +    }
>> +
>> +    NV_PFALCON_FALCON_DMATRFMOFFS @ PFalconBase + 0x00000114 {
>> +        23:0    offs;
>> +    }
>> +
>> +    NV_PFALCON_FALCON_DMATRFCMD @ PFalconBase + 0x00000118 {
>> +        0:0     full =3D> bool;
>> +        1:1     idle =3D> bool;
>> +        3:2     sec;
>> +        4:4     imem =3D> bool;
>> +        5:5     is_write =3D> bool;
>> +        10:8    size ?=3D> DmaTrfCmdSize;
>> +        14:12   ctxdma;
>> +        16:16   set_dmtag;
>> +    }
>> +
>> +    NV_PFALCON_FALCON_DMATRFFBOFFS @ PFalconBase + 0x0000011c {
>> +        31:0    offs =3D> u32;
>> +    }
>> +
>> +    NV_PFALCON_FALCON_DMATRFBASE1 @ PFalconBase + 0x00000128 {
>> +        8:0     base;
>> +    }
>> +
>> +    NV_PFALCON_FALCON_HWCFG1 @ PFalconBase + 0x0000012c {
>> +        /// Core revision.
>> +        3:0     core_rev ?=3D> FalconCoreRev;
>> +        /// Security model.
>> +        5:4     security_model ?=3D> FalconSecurityModel;
>> +        /// Core revision subversion.
>> +        7:6     core_rev_subversion =3D> FalconCoreRevSubversion;
>> +    }
>> +
>> +    NV_PFALCON_FALCON_CPUCTL_ALIAS @ PFalconBase + 0x00000130 {
>> +        1:1     startcpu =3D> bool;
>> +    }
>> +
>> +    /// IMEM access control register. Up to 4 ports are available for I=
MEM access.
>> +    NV_PFALCON_FALCON_IMEMC[4, stride =3D 16] @ PFalconBase + 0x0000018=
0 {
>> +        /// IMEM block and word offset.
>> +        15:0      offs;
>> +        /// Auto-increment on write.
>> +        24:24     aincw =3D> bool;
>> +        /// Access secure IMEM.
>> +        28:28     secure =3D> bool;
>> +    }
>> +
>> +    /// IMEM data register. Reading/writing this register accesses IMEM=
 at the address
>> +    /// specified by the corresponding IMEMC register.
>> +    NV_PFALCON_FALCON_IMEMD[4, stride =3D 16] @ PFalconBase + 0x0000018=
4 {
>> +        31:0      data;
>> +    }
>> +
>> +    /// IMEM tag register. Used to set the tag for the current IMEM blo=
ck.
>> +    NV_PFALCON_FALCON_IMEMT[4, stride =3D 16] @ PFalconBase + 0x0000018=
8 {
>> +        15:0      tag;
>> +    }
>> +
>> +    /// DMEM access control register. Up to 8 ports are available for D=
MEM access.
>> +    NV_PFALCON_FALCON_DMEMC[8, stride =3D 8] @ PFalconBase + 0x000001c0=
 {
>> +        /// DMEM block and word offset.
>> +        15:0      offs;
>> +        /// Auto-increment on write.
>> +        24:24     aincw =3D> bool;
>> +    }
>> +
>> +    /// DMEM data register. Reading/writing this register accesses DMEM=
 at the address
>> +    /// specified by the corresponding DMEMC register.
>> +    NV_PFALCON_FALCON_DMEMD[8, stride =3D 8] @ PFalconBase + 0x000001c4=
 {
>> +        31:0      data;
>> +    }
>> +
>> +    /// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_E=
NGINE` depending on the
>> +    /// falcon instance.
>> +    NV_PFALCON_FALCON_ENGINE @ PFalconBase + 0x000003c0 {
>> +        0:0     reset =3D> bool;
>> +    }
>> +
>> +    NV_PFALCON_FBIF_TRANSCFG[8] @ PFalconBase + 0x00000600 {
>> +        1:0     target ?=3D> FalconFbifTarget;
>> +        2:2     mem_type =3D> FalconFbifMemType;
>> +    }
>> +
>> +    NV_PFALCON_FBIF_CTL @ PFalconBase + 0x00000624 {
>> +        7:7     allow_phys_no_ctx =3D> bool;
>>      }
>>  }
>> =20
>> -register!(NV_PFALCON_FALCON_CPUCTL @ PFalconBase[0x00000100] {
>> -    1:1     startcpu as bool;
>> -    4:4     halted as bool;
>> -    6:6     alias_en as bool;
>> -});
>> -
>> -register!(NV_PFALCON_FALCON_BOOTVEC @ PFalconBase[0x00000104] {
>> -    31:0    value as u32;
>> -});
>> -
>> -register!(NV_PFALCON_FALCON_DMACTL @ PFalconBase[0x0000010c] {
>> -    0:0     require_ctx as bool;
>> -    1:1     dmem_scrubbing as bool;
>> -    2:2     imem_scrubbing as bool;
>> -    6:3     dmaq_num as u8;
>> -    7:7     secure_stat as bool;
>> -});
>> -
>>  impl NV_PFALCON_FALCON_DMACTL {
>>      /// Returns `true` if memory scrubbing is completed.
>>      pub(crate) fn mem_scrubbing_done(self) -> bool {
>> @@ -375,147 +459,81 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
>>      }
>>  }
>> =20
>> -register!(NV_PFALCON_FALCON_DMATRFBASE @ PFalconBase[0x00000110] {
>> -    31:0    base as u32;
>> -});
>> -
>> -register!(NV_PFALCON_FALCON_DMATRFMOFFS @ PFalconBase[0x00000114] {
>> -    23:0    offs as u32;
>> -});
>> -
>> -register!(NV_PFALCON_FALCON_DMATRFCMD @ PFalconBase[0x00000118] {
>> -    0:0     full as bool;
>> -    1:1     idle as bool;
>> -    3:2     sec as u8;
>> -    4:4     imem as bool;
>> -    5:5     is_write as bool;
>> -    10:8    size as u8 ?=3D> DmaTrfCmdSize;
>> -    14:12   ctxdma as u8;
>> -    16:16   set_dmtag as u8;
>> -});
>> -
>>  impl NV_PFALCON_FALCON_DMATRFCMD {
>>      /// Programs the `imem` and `sec` fields for the given FalconMem
>>      pub(crate) fn with_falcon_mem(self, mem: FalconMem) -> Self {
>> -        self.set_imem(mem !=3D FalconMem::Dmem)
>> -            .set_sec(if mem =3D=3D FalconMem::ImemSecure { 1 } else { 0=
 })
>> +        let this =3D self.with_imem(mem !=3D FalconMem::Dmem);
>> +
>> +        match mem {
>> +            FalconMem::ImemSecure =3D> this.with_const_sec::<1>(),
>> +            _ =3D> this.with_const_sec::<0>(),
>> +        }
>>      }
>>  }
>> =20
>> -register!(NV_PFALCON_FALCON_DMATRFFBOFFS @ PFalconBase[0x0000011c] {
>> -    31:0    offs as u32;
>> -});
>> -
>> -register!(NV_PFALCON_FALCON_DMATRFBASE1 @ PFalconBase[0x00000128] {
>> -    8:0     base as u16;
>> -});
>> -
>> -register!(NV_PFALCON_FALCON_HWCFG1 @ PFalconBase[0x0000012c] {
>> -    3:0     core_rev as u8 ?=3D> FalconCoreRev, "Core revision";
>> -    5:4     security_model as u8 ?=3D> FalconSecurityModel, "Security m=
odel";
>> -    7:6     core_rev_subversion as u8 ?=3D> FalconCoreRevSubversion, "C=
ore revision subversion";
>> -});
>> -
>> -register!(NV_PFALCON_FALCON_CPUCTL_ALIAS @ PFalconBase[0x00000130] {
>> -    1:1     startcpu as bool;
>> -});
>> -
>> -// IMEM access control register. Up to 4 ports are available for IMEM a=
ccess.
>> -register!(NV_PFALCON_FALCON_IMEMC @ PFalconBase[0x00000180[4; 16]] {
>> -    15:0      offs as u16, "IMEM block and word offset";
>> -    24:24     aincw as bool, "Auto-increment on write";
>> -    28:28     secure as bool, "Access secure IMEM";
>> -});
>> -
>> -// IMEM data register. Reading/writing this register accesses IMEM at t=
he address
>> -// specified by the corresponding IMEMC register.
>> -register!(NV_PFALCON_FALCON_IMEMD @ PFalconBase[0x00000184[4; 16]] {
>> -    31:0      data as u32;
>> -});
>> -
>> -// IMEM tag register. Used to set the tag for the current IMEM block.
>> -register!(NV_PFALCON_FALCON_IMEMT @ PFalconBase[0x00000188[4; 16]] {
>> -    15:0      tag as u16;
>> -});
>> -
>> -// DMEM access control register. Up to 8 ports are available for DMEM a=
ccess.
>> -register!(NV_PFALCON_FALCON_DMEMC @ PFalconBase[0x000001c0[8; 8]] {
>> -    15:0      offs as u16, "DMEM block and word offset";
>> -    24:24     aincw as bool, "Auto-increment on write";
>> -});
>> -
>> -// DMEM data register. Reading/writing this register accesses DMEM at t=
he address
>> -// specified by the corresponding DMEMC register.
>> -register!(NV_PFALCON_FALCON_DMEMD @ PFalconBase[0x000001c4[8; 8]] {
>> -    31:0      data as u32;
>> -});
>> -
>> -// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE=
` depending on the falcon
>> -// instance.
>> -register!(NV_PFALCON_FALCON_ENGINE @ PFalconBase[0x000003c0] {
>> -    0:0     reset as bool;
>> -});
>> -
>>  impl NV_PFALCON_FALCON_ENGINE {
>>      /// Resets the falcon
>>      pub(crate) fn reset_engine<E: FalconEngine>(bar: &Bar0) {
>> -        Self::read(bar, &E::ID).set_reset(true).write(bar, &E::ID);
>> +        bar.update(Self::of::<E>(), |r| r.with_reset(true));
>> =20
>>          // TIMEOUT: falcon engine should not take more than 10us to res=
et.
>>          time::delay::fsleep(time::Delta::from_micros(10));
>> =20
>> -        Self::read(bar, &E::ID).set_reset(false).write(bar, &E::ID);
>> +        bar.update(Self::of::<E>(), |r| r.with_reset(false));
>>      }
>>  }
>> =20
>> -register!(NV_PFALCON_FBIF_TRANSCFG @ PFalconBase[0x00000600[8]] {
>> -    1:0     target as u8 ?=3D> FalconFbifTarget;
>> -    2:2     mem_type as bool =3D> FalconFbifMemType;
>> -});
>> -
>> -register!(NV_PFALCON_FBIF_CTL @ PFalconBase[0x00000624] {
>> -    7:7     allow_phys_no_ctx as bool;
>> -});
>> +impl NV_PFALCON_FALCON_HWCFG2 {
>> +    /// Returns `true` if memory scrubbing is completed.
>> +    pub(crate) fn mem_scrubbing_done(self) -> bool {
>> +        !self.mem_scrubbing()
>> +    }
>> +}
>> =20
>>  /* PFALCON2 */
>> =20
>> -register!(NV_PFALCON2_FALCON_MOD_SEL @ PFalcon2Base[0x00000180] {
>> -    7:0     algo as u8 ?=3D> FalconModSelAlgo;
>> -});
>> +nv_reg! {
>> +    NV_PFALCON2_FALCON_MOD_SEL @ PFalcon2Base + 0x00000180 {
>> +        7:0     algo ?=3D> FalconModSelAlgo;
>> +    }
>> =20
>> -register!(NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID @ PFalcon2Base[0x000001=
98] {
>> -    7:0    ucode_id as u8;
>> -});
>> +    NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID @ PFalcon2Base + 0x00000198 {
>> +        7:0    ucode_id =3D> u8;
>> +    }
>> =20
>> -register!(NV_PFALCON2_FALCON_BROM_ENGIDMASK @ PFalcon2Base[0x0000019c] =
{
>> -    31:0    value as u32;
>> -});
>> +    NV_PFALCON2_FALCON_BROM_ENGIDMASK @ PFalcon2Base + 0x0000019c {
>> +        31:0    value =3D> u32;
>> +    }
>> =20
>> -// OpenRM defines this as a register array, but doesn't specify its siz=
e and only uses its first
>> -// element. Be conservative until we know the actual size or need to us=
e more registers.
>> -register!(NV_PFALCON2_FALCON_BROM_PARAADDR @ PFalcon2Base[0x00000210[1]=
] {
>> -    31:0    value as u32;
>> -});
>> +    /// OpenRM defines this as a register array, but doesn't specify it=
s size and only uses its
>> +    /// first element. Be conservative until we know the actual size or=
 need to use more registers.
>> +    NV_PFALCON2_FALCON_BROM_PARAADDR[1] @ PFalcon2Base + 0x00000210 {
>> +        31:0    value =3D> u32;
>> +    }
>> +}
>> =20
>>  // PRISCV
>> =20
>> -// RISC-V status register for debug (Turing and GA100 only).
>> -// Reflects current RISC-V core status.
>> -register!(NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS @ PFalcon2Base[0x000=
00240] {
>> -    0:0     active_stat as bool, "RISC-V core active/inactive status";
>> -});
>> -
>>  // GA102 and later
>> -register!(NV_PRISCV_RISCV_CPUCTL @ PFalcon2Base[0x00000388] {
>> -    0:0     halted as bool;
>> -    7:7     active_stat as bool;
>> -});
>> +nv_reg! {
>> +    /// RISC-V status register for debug (Turing and GA100 only).
>> +    /// Reflects current RISC-V core status.
>> +    NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS @ PFalcon2Base + 0x0000024=
0 {
>> +        /// RISC-V core active/inactive status.
>> +        0:0     active_stat =3D> bool;
>> +    }
>
> The above comment says "GA102 and later" but right after it has
> "Turing and GA100 only" which seems incongruous.

Right, this comment was for `NV_PRISCV_RISCV_CPUCTL` but it likely had a
copy/paste accident.
