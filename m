Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D77F459EB
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B642610E989;
	Fri, 10 Apr 2026 15:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XfPj2VEa";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7568610E98A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 15:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyg/fKr1832d8HydeEvi44g7F0/0YKh0T91NMjSIhTd3aQeHX776uhTn21jJmbmUUQZO10Q2gxhCaGaNStRz4vY7KWRVFrl2R5w3zU+VkWSL5+fPO5OtrFDCIBlRml277xpgAoen0oaaNR7tw0NqZ6PoiZ6nV5hc4PvC+ubeLhpFi+tFqN1U9/0SiEzB0JMlcZxeov15wT/+wolo1pXAasnbhLw2I3gHCofHhy528LwHCz4XQWff4U2HVctcDhicWT/PK8KPaR8ShSi8jPHwX4da/JtgBiNvGUd2jfE1Elef2R/28EHZ6g6zdaMkQSaftYG8DLg+lwfBWF2wQ8h47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hYmnB3mPGdjjkoM6y5sTkea18ufxPdSYAdZ3d7eRsY=;
 b=ZzZu2xMrw0ZPcBh/xc9GUATc144kIapXgvT8XiFKGrfJDEjpQ8OtmbcJD8kbZ7cAvvV9jS6XMeJ9TwFAkUPRVlDPUdGMnIjjnhdy2Hfiz7821cjgZKWv7cWA76Dt3fECcPYqFtcPPWXS5SjcKSJwRywceGjfWMbt8rQYy/J3VbItslczB8XPh7uJadyS2FP+bj+mj6ERlIkcd+ouEv1e8C2NZrncjdx0pi3VJnHrnqdax2ROTcoDOdEiFINCl+dCM9noLvae2mQfMY/7rH+RdbYAUYB9CuuUg14IiPbn74GSb6+Zv7+5fTfBWZjWgjVFq0eyzlFz6Pyt5U1n2ZB7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hYmnB3mPGdjjkoM6y5sTkea18ufxPdSYAdZ3d7eRsY=;
 b=XfPj2VEa47wfze+cGbHFP+UsoLJcv/J/CDoCdgdypsMN1ibjjFfZR9thgvf67OLEJyd/cHm5jmwJDVX6wCbkY+Mc11wFH+vApuieY+4v2V2hftD4sjsRsW9yRecr0GDLuZFF3UpUVwGJxpPBTF4HSffrnoR8MWlor+RsJzQ/IuhQRX1i87b4ZCy0PuW0GhnmcIPbzwKee5AbW6HTzJAlkAygP5MMUYsw7kc5g7JxZ/E4b1qkAPmUDvSu3gvT2OqeHtSR3HKthR8c9AEdzXEo8chPfBmeWTeHT+xdqOFWFIAyqce9nqJl+lAI86IceFLroJGodBr4N7zENWNa6YDtDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 15:05:47 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Fri, 10 Apr 2026
 15:05:47 +0000
Message-ID: <edff8db4-a3a5-4b21-a8e6-9871206ddeb9@nvidia.com>
Date: Fri, 10 Apr 2026 11:05:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] gpu: nova-core: vbios: use checked ops and accesses
 in `FwSecBiosImage::ucode`
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
 <20260410-fix-vbios-v1-5-bc6f71d153d6@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260410-fix-vbios-v1-5-bc6f71d153d6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0091.namprd15.prod.outlook.com
 (2603:10b6:930:7::10) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: f81a6c9d-c50e-4a41-1697-08de9712a52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ca9VFJrb8AbUjgQFG1nkZHqEjhzU/0s7LAd3Kal/TLwWacV/WsHVXOutnFqdiZL28IukPQIt+BmDxCMuoQ+va6m0EQK6mIw7a3jqTrPxLA2+ecDZLXx+7aU1yB+TGgIV9PhIZeOq81tn06oPOuAKYNo+9oVi2N97BeM8jsevuDqUt1g8fh1q3TsgmQEWC61PSV/VL7z8ON6TQ7UCbNFeJn4xQfi/5gqnmo1h8WvROIR6eD9cP8eU2yd+4edYudWqSqDqwC6/iAVAbMtzsWlkD6L9t1YM+lxT9/BIM+BQdzk1CsvV9RPIZFWPkj/glIpaf08y854veSvsICHHuzgvmDMhBvvXUik/QexFqZSHCrdUefoODcU4nEif3ncMMx3RnA6n6YtDv2hGlz9vEpoO013eZFLdfww0dzHcYZeca9TReUzoFqSLTvu9zdAWdP9QAOjmME5/f5cQGZSAFblTRKO1S8tRy6LiX7e6MHLcnkXhYZYuYfKjrtspYc/tpLJVGbpHpTIPlOL8DJUlpSwm2KE4Ly3+146G4r3NdEcHk/Re5bju8OhkcZ58sP8L0VxwrWmN5DfL68SpafLs28kKYR3yPuSPKUiXF6lApdsGtspt8eF+V4C5QA0FtzSF2BPUZh/EDK+rC3PP7uj+sWJEhUmADpLQI4y/E/yQRPB9SUOQGiJFXlLmnLEsOkeN30m+0pNu26Me7hOnq+JH6QinVDn2aYMSZcYTsuAGgVLlbmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXMvNDFOY0dGOEV2cjVFdlQrdWRCczRwdkFHYWw4UFk2NnVtYTZ5WmQvOUw0?=
 =?utf-8?B?b0JDekNyc0N4QTM4c052eWFteHhMVGROMlI5UlhzV2dkSGxXUVFLZkZiQVVo?=
 =?utf-8?B?N3c2UWtyR3AzWU84MktqOVB4dXdSaGY5RWcxdjEzUFRPSHF5VDR6b1BERUZw?=
 =?utf-8?B?L2lvT2dSY3NkR1phNW8zWXMyazZxblVwbHkvVEoyREx0MklpYVpMQXBsc1gr?=
 =?utf-8?B?TVg5bjluV1cxQk9PRExFbTBVNzhqVXhNUzFsRmgyRnd1RE0yWkpBWncyRDRN?=
 =?utf-8?B?T0hPQzZNZXZ0ekpTY2NEQ1dicTMzTEpvMmJuQUpHOWZZT25UcUkyS0VZL0dD?=
 =?utf-8?B?L21Sd2gvRHZ3V1NkK1NhNVliMWNIU0IzZ3k2Sk5rTWc0b2xPQm9IcFI2TEcr?=
 =?utf-8?B?Rm9QaXBldzd1aUREZmlEREhoUXNsSGNPWnJNeWRkaEkwS041QmM1dnl1dkt2?=
 =?utf-8?B?ODFyUWNYNUl1YUhyeWlXMlBYeld1c25kTlJ5Rk9NbTNDaGs4WnV2V0ZwV1lr?=
 =?utf-8?B?Q3VFUkgybHNWWm90Y2RpcXlKSGtsMkhYWEJQeVVkV2VUenVCUUpWaUFESmgy?=
 =?utf-8?B?SUFGQmV5M1lhTkhHd2djRlpWOHJ4ald2bHVVNDJ1bnZKV1ZVc0M5MSswVnZp?=
 =?utf-8?B?Z2hzV3ZtSDR1SGZYUE9TZ3QvNkY3VXY0OExsTjB3dFd3bW12NVhDYnhESUZU?=
 =?utf-8?B?Q3I1aWVlZ3V2VFZ1TzMrckR5WURXeWh6ejY5bzRyRS9ya0NpVERla3RpNThk?=
 =?utf-8?B?S3MvdVBIVURDVUdmMjBtaDRIYTFrNENSN1VOdTJPa2tYdXdNZWQ1Ukk4NlJE?=
 =?utf-8?B?SjBsbmRNaFowdW9TSXNuMyt4aXRKWkVEeEF6VXRJL1BUY2RuYnM5WUxKeWVM?=
 =?utf-8?B?MEptb1BDSVJHclp0eXZVc0JGRlNMUFZLbHErck1xblZRN01BZTNpajRIazZr?=
 =?utf-8?B?QzAvc3dDSkdySmdPZjc1V3Rad3A3UjZMSmpTY0g2K2tDczFJOXZCMW5UU3kv?=
 =?utf-8?B?bTJDYVhXaEovb3Ayd3ZFNjRuQU1zZFpuTk8ya1NKTmNFWUpMU1FwczNBTEZW?=
 =?utf-8?B?eWN2ZlVGVzVqRnRDay9sNjZBcEZ1MGxxQnpzVm9qQ3oydTFUVmdReTFrdDhh?=
 =?utf-8?B?S3NWQmJvSjBoTlJQQS9mdTI5cEMxRTZEV0JyTG9MdnVSbWUrcFJqYmFrNU5P?=
 =?utf-8?B?NzN6MXh4eTh1djZWdEp6VE1OTXA4NEwxV3FkMkM0SGluZ1Y3bGRDQ3FlUno0?=
 =?utf-8?B?RlpQVHRKUnIyZEJkNTRST0hNNmJJRXMrV3B4SitnUUtwL3dNeWpxTXAxT1hY?=
 =?utf-8?B?NGpZUXl5N3pNR3pNNDZDUFpNU0hBKzA0b3hJdkV6WHg0cldCK2M5RkV0VTEr?=
 =?utf-8?B?RVZPTUVGN1R4bzR0d213WGhhaTVzRU8rb3RlNmlpb0h0c1BTaUdNMFFOa0Fw?=
 =?utf-8?B?c1k1NkZRSE9xUzMzOGxjc2RJSDEwUHJKSFFHMy8zRUxkWGZTc0RqV1hpT1BP?=
 =?utf-8?B?dFZoa2V5UnJGV0NSaDBNTXhGanRReTk2WHdZR0JlNGpxQUhpSzRkMzRqQkts?=
 =?utf-8?B?bjhnVHhEd3JKTkJxdGRBUGNmYmtRMkdPcjRscnJhREtqQ0NXUWlWeGo4ZU54?=
 =?utf-8?B?a2w2SWNwWC9iM2RKdi9ESjhwNWpzZ0xaNllUVjZIaVdhb2g2bjZySHMzMXNo?=
 =?utf-8?B?RGFVOGdwb1FnKzR5ekNyVndkY1dnOS9QdWVQVys4QlA0MjkzdVIvMlZhNEpF?=
 =?utf-8?B?Vk5qN1hRNW41bms5LzZOMWZ0U1lmcVVCSHdEeGhiU3poWnpKd2w5WkduZGM1?=
 =?utf-8?B?S0l0TWk0ekxFSlNqbk5rRFJBWGd3eXE3c2lKMERSWFBjblhKc2N4Q0RzcVJs?=
 =?utf-8?B?QzI3MTg5Z0Z4dldtMThhcmRUTjBmYW1XVlZlQ04rSHlIMzBnMStMR1prOXA1?=
 =?utf-8?B?TmpHR1hra2htQXN6aS8xTW1rNWFXL3BkeUdpeDFMYWJIYWVMM2huN0k2ZFBP?=
 =?utf-8?B?ZFg5QThqUStOc3VSOE0yVUc0Q080M0FxYk42ZEpoZG1MSFR1UTE0L0JpWTk4?=
 =?utf-8?B?blhNSnZSNHdmVmZoeHhWajlVWUY0ME5qeFptMWlneExVOHU4clM1bjIrUnZo?=
 =?utf-8?B?ckRuZWI4MmdiZkhJMjBPTFV0WGNyUWdXVzl0Q2EyeEJaeHlkb1BUYjJiU001?=
 =?utf-8?B?U2pFdlIxMHZGVWswd0tzaGFxNWlHTGhyK2Z4ZkxFRFZRd2hrNnA0ZUtyT1U0?=
 =?utf-8?B?L01yZW83RWpGMnlxK3c3MUlEWGVFSSsxd0R5di9Gb0tpanZ6Q2REbERLb2hi?=
 =?utf-8?B?b1JidDNCVEw5OFY3K05VdzVIMllSSWFtSjJHSmp1YlJGdCtqbTdlUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81a6c9d-c50e-4a41-1697-08de9712a52c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 15:05:47.1359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9NIMqWQ+Y2RAI0aDiwrs/vqVM1Q8KiOsEvNUZoNJnmHmsQf+X+G/Ikztmfqyf3Rzhi+qOXaxEUIeoW3Mljlrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com> , one comment below

On 4/10/2026 4:38 AM, Eliot Courtney wrote:
> Use checked arithmetic and access for extracting the microcode since the
> offsets are firmware derived.
> 
> Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 3bd3ac3a69f2..b509cd8407a5 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -1027,16 +1027,21 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
>  
>      /// Get the ucode data as a byte slice
>      pub(crate) fn ucode(&self, desc: &FalconUCodeDesc) -> Result<&[u8]> {
> -        let falcon_ucode_offset = self.falcon_ucode_offset;
> -
>          // The ucode data follows the descriptor.
> -        let ucode_data_offset = falcon_ucode_offset + desc.size();
> -        let size = usize::from_safe_cast(desc.imem_load_size() + desc.dmem_load_size());
> +        let data = self
> +            .base
> +            .data
> +            .get(self.falcon_ucode_offset..)
> +            .ok_or(ERANGE)?;
> +        let size = usize::from_safe_cast(
> +            desc.imem_load_size()
> +                .checked_add(desc.dmem_load_size())
> +                .ok_or(ERANGE)?,
> +        );
>  
>          // Get the data slice, checking bounds in a single operation.
> -        self.base
> -            .data
> -            .get(ucode_data_offset..ucode_data_offset + size)
> +        data.get(desc.size()..)
> +            .and_then(|data| data.get(..size))

It might be worth adding something like:

data.get_slice(start, size) -> Result

in R4L longer term if the data.get(start..).and_then(|data|
data.get(..size)) pattern is common. It seems to be so in this series.

