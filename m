Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72012FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D201010E45C;
	Tue,  5 May 2026 18:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="d7NfTron";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D9E210E45C
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 18:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPHCkGPSD3H2VlXYSKUWDW7mN5rN3aXnmjJr1vuT5cnhc6tn+WBAwojpDhaUF6ZkEGielU7u4gYcLPjVDMg+ddXQFnzDsWzT1ntmtB/xI4scg4VPWrdEvdCdneoUFnZHQ/jSGV5JIhnJzWqG/rk7UzYUmPZAsSVYYp53OLxF/GYVoRm0o1OdpZN5p8Lh5dpqZe+a1trJC52GPhOhrbAIF2V8xccU+8kb/TrwPbfdsqGy9XE1URr2vtFfEx/gSia/+F0rP6hvt7iXMNOWtreseaJ3O8VvrBirvvUKxkTucWJL1IjDj7SqlFQPjwOF2x170ONDipwptbuEpsbfEv7uYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDSd+ebrnnM+iQk547kYnPG3tTTOjQGHMyqMbFTsEYc=;
 b=gKA37ZLPqGGN7r4kpWafX8HJugj4596e/vt9x7kSzF/jIFpqMpMxyi98/rJMTByQSHb0aGTftYOhwT5RHziHWOHa/nhx9oHN0NeblTHFgMxJcRVvUFjFtHS5xfly0Wtr9NOkxWzPqxgasD0jz7kj/UCBfHMkRl9rWf2qbxBy26yty0ujTIJBqenVek50WlvgOWcVW5DdAC5191DRnnl1MhbZjb2gJwIOfF45r2v05dQy0g8/a5aMie0+5+hUnqC2y/Up+u3lSFFT49Q+HvV6iFeHbTsBLLYyiW4ig38j6+g7EVMyP/z4PQW1xnW27LdloRBEgfgw57TcW2Qyss/7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDSd+ebrnnM+iQk547kYnPG3tTTOjQGHMyqMbFTsEYc=;
 b=d7NfTron81rd1twUsU+h0LwPDJgPdaoOh1PlnTggIjuNxP1zF57TkY5gyE0gEwr3ScPes0NB9BOKnla451f7EjsS1QIc0enBbCQ+Pw5YaO+8lh1Gj993WtQZwmL8qzajnWjKLyayvGmDbcKvsGorsz7/fQcCeqnn/8BH1zN7I7NnmTqZYHwHQRqDY1AtSVgUJTbhUp5UEHmqOWXh69ydlRyVRdXGwvRT+fEULNq03GlyM1JAKs8Gvc7P0MJVtqRzmdr72NjXb2kMr+6YQ2oxWZ9y4yYOQcRUUBeiu8bAi4TEAa5pxVBmbuc2lN9Uday4eZBb4TDWtiop0BdBCqroVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Tue, 5 May 2026 18:54:49 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 18:54:49 +0000
Message-ID: <520ff92e-b470-41d2-96d6-3360a8f269ee@nvidia.com>
Date: Tue, 5 May 2026 14:54:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/22] gpu: nova-core: gsp: Extract usable FB region
 from GSP
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
 <20260425211454.174696-3-joelagnelf@nvidia.com>
 <DI8AZQ06LCJR.1LDY75WJI77PM@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DI8AZQ06LCJR.1LDY75WJI77PM@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:52f::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e81fd5-6b6c-46c8-b84e-08deaad7c81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1UwjwTz0TRv9qLYEnR/XG6V30Zn7borCAH8BPkZqEWxV/Xpufxp7U5rjea+1n+fFN6b5LfWGPUuZ0U6ADfKdoJRv59UfhiMWUTI8d7r8/Jp52pm16EieZIr7p3XdysNdfeTMxYQqQfHoZMA8SLYaCg1dqDkbjHdo2++k8/FL/tyVKzEXWK+AwQvv4VtLdXnFpLtMuxjcw1vuUVuEuSDZvZ11dHwQVsGicRahjydvBZA7xRQnnV93Al+SHE3GpWCPJvwsd4IO8nFGnsr05LCoSrWWXPpkttc6QnDtG9WR0xBuulkqxNcFlM4yaC+D0YT5jLjJe0XJdxMPKHrGXlll5tIpIZZVIw9rAdTvu47mWljJngeB6c3YInYbhbtBgQPuCzpCHhaFK7JNFAG6qeT+YzRRyr4Q/eJb39MRK/FgGkTTsPU+rLMRJ5afqAhfcEk83BHWEbg+e7tHaZDbkiAB+rNAnb2S5PA/QU+rPbWOy2Hg2e9R2uK8wzCmPwwh3/n6Vb8n6lPEyw6vC/4PlxqJC/W0hKQm3222WMWgGRDK+zr7OoI9Y/bxD9+MuK82f3h6eKV1C3w1nL6ushhyccSCb99LrkpSA2m3aiTTbVyxGTQbDYthrwJMaEZH0Cw6KQw5uS34gfM+/BDZ1eh3o0gDKgxXq5/+cCMwMlSkDxbyfq3gBdsKugRNNOVk/PEiek1X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2pGK3cvMTEzYXMyaFNrY0ZLQWxDMTcvWEFrT1Ryd241KzdubmdBeEYwYTNU?=
 =?utf-8?B?b21JK2U2cG9GaTJkeE5XRTdacHE1eitua3M4TTR5ako4aTNNVHlvYkprVUZh?=
 =?utf-8?B?TGlIWjdnSGNHMDMvd2hQU2p2WCtoMWpjUEFZL0krb0RhOWVnQlU5bkpNNXAw?=
 =?utf-8?B?WnhranAvdnc4TnNiT1BMcUhMV05TZ3BnUGYraHU0bi9rQkN3ZFBOekxmUitu?=
 =?utf-8?B?K1QzUTFRZWoxdFM1WlJ6VHBVWW4vOGJ6NkxYL1dRazExWUZxdm1IQ3czU1Nn?=
 =?utf-8?B?d2Y5MFYxUXMwZGxhWUYvMC9jV1IyZ0FNUDlIY3o5OE4yMzJlQ2FSN0ZjcjJB?=
 =?utf-8?B?dU15RVdDVlJSMlMwTlpJWERlSkg5Z3FvMkJZS1lyQnUvcUwvN0VPQ1JMLzh1?=
 =?utf-8?B?Sk1oUlFGMklWOHdXV3FXR21hc1N0M09nVFlRbGpsSTlUVTNpaFIwSUF6SEoy?=
 =?utf-8?B?RGFISWdnbkgrdDFFb3Q2Nm95MWduVkF2UGxzUkNtVEN1eTFrYmpCL0ExNG1Z?=
 =?utf-8?B?aTdHSVRnalk1OEtabDQvSVA3cDBCU1JQWW1Kek1EQjJVQXZaekhRa1dzRUVt?=
 =?utf-8?B?NWlnRDVSVmdrYzU3SkErdTVLWkpNQ3ZDelN0TXk5WVNoang2NmVOUHpvRU44?=
 =?utf-8?B?WnJQUytOeHFKY0VNSURla0tNWkNyV2V0d3Y3QWJJZXM5eGRBUjJXSUJZOE9Y?=
 =?utf-8?B?NS81Qms0Yk8rWjJLaXlYcG52NWRRRERIWTRRYU1CdzdoWHErKy85QWdTandL?=
 =?utf-8?B?ZzNsYVczQWl0MU9mc2ZKcWVhK1B0dW12YUVqb3ZDM2J1OC85VVk0MjVOMnpB?=
 =?utf-8?B?bE9nOWNqMFI3Ym9tTlJPdGhKMzI0QXZIeTFQcEJZdTVqMmZQZW41dTV0THFj?=
 =?utf-8?B?SmVpSVExTlNFd1VmTnZlODBmUkl2VE1CZmdWbW9BVnVHQTEweDVNaURYZTBr?=
 =?utf-8?B?UU14ZmxlSElBbE4ydnQ4TUh3S25FR1FZYUdsM3J0bXlGSkJSZUxVQm5rYlFN?=
 =?utf-8?B?VlBFN1pieDhKN0pWOXJ3eGJkeGpsU0NDN0lZTmM1QjJrSDJrbUVzZHlNZGt5?=
 =?utf-8?B?bm8zVGEydTcxVzJaNXV0T2x3KzhxMFJMK3VSQ0pQNENxSzNWczduSkVvMmw3?=
 =?utf-8?B?TFB4QXN0WU1IWmlLVFRUbXk4anNUZWtHcC9relZBVkMvaEZucnNpaTJKQm9m?=
 =?utf-8?B?RXZZam5yeVhScGlwOXRCNnRRbEJiQkl2SXBiZlpHM1paM1VJVjU4M3ZOc2lQ?=
 =?utf-8?B?Q3Y0a0hra0hGaGxYQjdzU04zUVZKbE1mTkorS1hiTW40TUdvbG4vVW1GV2FW?=
 =?utf-8?B?cDE3Z2hJR1BDMWovTVVmL3ptcU91NUFvS2EzRTJsTlhWak9VMUt0VTVuYWkz?=
 =?utf-8?B?cEx2WVZXSmRRTkNWOVBNNksxaFdrQ3FtSTkwMGtoN2Y4N2NEOWNCK0w2WkZk?=
 =?utf-8?B?czdKSFM4Snpqd0h1L3VUb00zSG9PcDRuSU9yZXlpWitERytlbVk4bkttMlYx?=
 =?utf-8?B?a1UwQzhNaFBWa0xnSXVJKzc1UmcvNUxaLzlnUzV1anR4aDVZNHQyWGRyNnZm?=
 =?utf-8?B?bDFpbVEvYnVHdWpLR21JUExGdncvTzNkMTB3SjkrRHE4ZFpiTDNmWnJnMFlL?=
 =?utf-8?B?eG1NT21zOHVWdU90TGh4ZjVsdTRFa2ZhUHBqdjYxaXE2aG9sNnAxdjdxb3JD?=
 =?utf-8?B?cGFjL0RSR0dvNlJkWDlNSXJzelBsM0huNHBQS0lwelFRdkhvR3g1SitZd3Rk?=
 =?utf-8?B?UzFTcDhRdndyU0Y3cERSY1F4ZGVZS2U0YXBDS0FHTWtSTHZtalJwSE9tTm9O?=
 =?utf-8?B?cUUvaFE5cWRMd0pwMmFYVzRjOVUxamJ5c2JvRXUzOHZSMEFKMDdoK1VDd3ky?=
 =?utf-8?B?NHJWTUwyWTFLZWlLa2EvUUhWMlhBM3BsR3hzT0t1dWNpUXI3ZVpYbVgveWM1?=
 =?utf-8?B?MGZxTFB5YVBxdXhya1R1YjVwcU1Jbm9tUWJsaDk2bndkUFFheEpkZW9PcFQ3?=
 =?utf-8?B?ZWhPODk3M0t5aXFJTThaV1JPR2tIVEdnaWQvSTl3UExTWGEza0xWNk5vL0lB?=
 =?utf-8?B?MHZRTTdqbE0wemNHSnU0a1RjYlBNeUNabUNxYVNoNmpDM0IrTGdrakNjMzZp?=
 =?utf-8?B?dUZIYVdkcVJLM0pUelpyT2tNbUhEbDA2aG51VUwwV3pnT0U3M1VKZVpwTFJ4?=
 =?utf-8?B?cG5tdEM2RmhaMjNkd0dvL0JJc1FqdHNpZ01GYnppTVFwWTVraTdVSjhSQzBT?=
 =?utf-8?B?ZDZhR2Y4SXM0blZEWGxDYXN2ZFlhcjRnVHZHL3graHYyNFpWZkRZSDMvd3Za?=
 =?utf-8?B?eFBYN1R4eVZNakE1VFlFN1RBTS9Xbnh1Ulc0UkFpVXhwMlhhYnBRUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e81fd5-6b6c-46c8-b84e-08deaad7c81b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 18:54:48.7655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sI1RWEf/EidCNlovXtGUUnwxlbpp+fQ3kFuHT/Z1rwlnq44Kb/+lB0zhkKv0do7CdMfBjl+3Cp6B5/yFLnMWBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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



On 5/2/2026 11:41 AM, Alexandre Courbot wrote:
> On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
>> Add first_usable_fb_region() to GspStaticConfigInfo to extract the first
>> usable FB region from GSP's fbRegionInfoParams. Usable regions are those
>> that are not reserved or protected.
>>
>> The extracted region is stored in GetGspStaticInfoReply and exposed as
>> usable_fb_region field for use by the memory subsystem.
>>
>> Cc: Nikola Djukic <ndjukic@nvidia.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/commands.rs    | 11 ++++--
>>  drivers/gpu/nova-core/gsp/fw/commands.rs | 45 +++++++++++++++++++++++-
>>  2 files changed, 52 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
>> index c89c7b57a751..d18abd8b5f04 100644
>> --- a/drivers/gpu/nova-core/gsp/commands.rs
>> +++ b/drivers/gpu/nova-core/gsp/commands.rs
>> @@ -4,6 +4,7 @@
>>      array,
>>      convert::Infallible,
>>      ffi::FromBytesUntilNulError,
>> +    ops::Range,
>>      str::Utf8Error, //
>>  };
>>  
>> @@ -189,15 +190,18 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
>>      }
>>  }
>>  
>> -/// The reply from the GSP to the [`GetGspInfo`] command.
>> +/// The reply from the GSP to the [`GetGspStaticInfo`] command.
>>  pub(crate) struct GetGspStaticInfoReply {
>>      gpu_name: [u8; 64],
>> +    /// Usable FB (VRAM) region for driver memory allocation.
>> +    #[expect(dead_code)]
>> +    pub(crate) usable_fb_region: Range<u64>,
>>  }
>>  
>>  impl MessageFromGsp for GetGspStaticInfoReply {
>>      const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
>>      type Message = GspStaticConfigInfo;
>> -    type InitError = Infallible;
>> +    type InitError = Error;
>>  
>>      fn read(
>>          msg: &Self::Message,
>> @@ -205,6 +209,7 @@ fn read(
>>      ) -> Result<Self, Self::InitError> {
>>          Ok(GetGspStaticInfoReply {
>>              gpu_name: msg.gpu_name_str(),
>> +            usable_fb_region: msg.first_usable_fb_region().ok_or(ENODEV)?,
>>          })
>>      }
>>  }
>> @@ -233,7 +238,7 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
>>      }
>>  }
>>  
>> -/// Send the [`GetGspInfo`] command and awaits for its reply.
>> +/// Send the [`GetGspStaticInfo`] command and awaits for its reply.
>>  pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply> {
>>      cmdq.send_command(bar, GetGspStaticInfo)
>>  }
>> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
>> index db46276430be..a34d29280430 100644
>> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
>> @@ -1,5 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  
>> +use core::ops::Range;
>> +
>>  use kernel::{
>>      device,
>>      pci,
>> @@ -10,7 +12,10 @@
>>      }, //
>>  };
>>  
>> -use crate::gsp::GSP_PAGE_SIZE;
>> +use crate::{
>> +    gsp::GSP_PAGE_SIZE,
>> +    num::IntoSafeCast, //
>> +};
>>  
>>  use super::bindings;
>>  
>> @@ -121,6 +126,44 @@ impl GspStaticConfigInfo {
>>      pub(crate) fn gpu_name_str(&self) -> [u8; 64] {
>>          self.0.gpuNameString
>>      }
>> +
>> +    /// Returns an iterator over valid FB regions from GSP firmware data.
>> +    fn fb_regions(
>> +        &self,
>> +    ) -> impl Iterator<Item = &bindings::NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO> {
>> +        let fb_info = &self.0.fbRegionInfoParams;
>> +        fb_info
>> +            .fbRegion
>> +            .iter()
>> +            .take(fb_info.numFBRegions.into_safe_cast())
>> +            .filter(|reg| reg.limit >= reg.base)
>> +    }
>> +
>> +    /// Extracts the first usable FB region from GSP firmware data.
>> +    ///
>> +    /// Returns the first region suitable for driver memory allocation as a [`Range<u64>`].
>> +    /// Usable regions are those that satisfy all the following properties:
>> +    /// - Are not reserved for firmware internal use.
>> +    /// - Are not protected (hardware-enforced access restrictions).
>> +    /// - Support compression (can use GPU memory compression for bandwidth).
> 
> "can use GPU memory compression for saving bandwidth" maybe?

Done.

> 
>> +    /// - Support ISO (isochronous memory for display requiring guaranteed bandwidth).
>> +    ///
>> +    /// TODO: Multiple discontinuous usable regions of RAM are possible in
>> +    /// special cases. We need to support it.
>> +    pub(crate) fn first_usable_fb_region(&self) -> Option<Range<u64>> {
> 
> Let's be forward-thinking, and turn this method into
> `usable_fb_regions_iter`, returning an iterator. It is trivial to do
> (just turn `find_map` into `filter`), we will need it later, and for now
> the caller can just do `next()` to get the first region.

Done. Indeed, it does not add more LOC while supporting multiple regions.

thanks,
-- 
Joel Fernandes

