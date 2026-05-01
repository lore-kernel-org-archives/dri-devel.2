Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88175FF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 06:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E7810E4FD;
	Fri,  1 May 2026 06:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DAUROPYy";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8324610E4FD
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 06:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRNecOkwiFkOzpNRlgJjCiJvbkC6PWgAUxHT/IQponwa+y7gtJaPj/KvzaY703l8vwO52WxPDk0U1z4OHRGDbKW4g3fobkw1dTYQWvmOSCPL+M8vvKJ7XL8K3/+5BEuXpeM6sPmpS2mY1fHUu9Z0hWKbZtXGngC/gak3wfYtdQFgf6eMy7wVH0OSaQ9sampBLJJmUWN/BzILHl7O0IBD2/66NHeqeadCeYvSHrWlgLB43kowoO7ozna2/2ozUcbX84XkdBUI4xkgPseE6JsULNqq18S52dcRwCpOZSixHO+eWbRouXI7mQPLlZnv8q+jikfx6t4Y4hwiIxhfAaJDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYR1n0wHUoDOhZ63pCLoAB8b90wChKlOMxMW88ZxsR8=;
 b=obCTB28Ci7eEyzFxxuNglVk4hMvn7ladKmSmcvK/qCh9KtIRLabx6wQyZseqHi07gNsSeXvrkP1TTXepqVj/HWKiGypFg3nJDQXm9bvcqH4COiVBqYpKbAocQ7GAh9XwMvcn+ix7LsDECXaatFXFdiqqI+CmivV0avnrFcDj1E78kiRWmT8C9aDP1QSnFhT+PIzJwU5CvOMzqe0UlGcIx31AUWKuYAEJ65+bLeJkNZzJEdgQARfdIhMNI41nixkCJlqkxQfX1sl3l02wX3XdmD8zZLFWz/MCy4WMcfsnC3Xl8Qlc00VEZgw5l1Q2ZBfJkmjOHN6D4JEbu2i23rjMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYR1n0wHUoDOhZ63pCLoAB8b90wChKlOMxMW88ZxsR8=;
 b=DAUROPYyg8eLr06NPKaGkgtXI1kFTfe2/cvkyg+qoIy6GgwWIQYvtBYNXXJ0dHuFqBTuxTJNCZQHowNTyhJwdirDTPAG1yfkoMvyjh7/VvM6V8/vOT1fsyPOmGhXyHTAYtpRT+xISynrSh55Ww3FgK30DWRdRDRIKRWxgpzj+8p1h7sZ+OcVaa3jgYuX75Af6lo59VSGyplyq4dve23QBb8cDaUtL80YlNYP1o+fUm21FVAaZTOAh5VaQci5ZxNNNRbXagayyLT2+nA2rmEfY1ZeqL36JsgtgvHHG6dzmEMSByZl3Hn9gr2+mO8hWgju2gSkmohJQAtxaMqwkEvHwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 06:07:38 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 06:07:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 15:07:34 +0900
Message-Id: <DI745Q3OM229.3LB1T3DCVYESL@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/11] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-4-8f648aef7a85@nvidia.com>
 <DI5OVZXSRQ04.2QHKSMV6WDHWI@nvidia.com>
In-Reply-To: <DI5OVZXSRQ04.2QHKSMV6WDHWI@nvidia.com>
X-ClientProxiedBy: TYCP286CA0273.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fd9d94-905f-4c98-c213-08dea747f23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: OiQ6kQOZ38UAVssfQnPcj8ey+bJ/e9R/9BAolw22DJ6e9i4tejY85BjU8RAP0O6HSEmpTCf03qvI7lmIiRuk7XGIWCrkIvpyaGtDxHCgWexHLi/vcUvcmmjQdpom1Lz6eBd0FHvOeNZaNL1o76khjrqCqh6eAZ8qkAZmOgmAHJplrW7GR99fbIKtJq/SEBVzKIvEFeYBOD/2BtrITr7qYs7lI26qjk2XV+pcNCyTN6eQof9yFFQsxUvpZmOoHIO1/+ZBHBg3GMshmKZj33gtoPkdV5DRI2XG1fL9XowoAWQiNh5HCZ4/WkjzqMqhPHDh5bKvMU8bOYGGZOitu/o+j0QHK3wZVlu6CIJtFNBPFAnNRal6VN/Tqr5TdihL2cxEbNzpX6vnmrGGDWMGWbMj/nv1epW/6FQdklUQWuSRz4//xP4ILo0eiSYZoGoQpFSZIGwEKFxWNCno8moIKZHBgGC3MrtBf2hWEYtoavOXtL3rQQwijgYgN3vPkifuFVyHIhe8RZgADv9M/YwskezgwBRE3S3vnfT960/7lw3+uNPjUZs29CmX7QZ0dfvNx//eMtQFBdGrOb7kIYUC4s+IxG+q6qBU8RGMAglnmxf4X6X5aJMbVRt8vi/2UKMAPNJ/dIvOQksytUJF2ygJoMe5XBFn/6hW1xFPcpNE+Ve4urLD+h4GVpjz05aQoInQsSO/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2FCL21vaGdadG1xWUdEWkEvK0JNelRoSjlzcTljd3dzWHJwbDM2NitBRHpv?=
 =?utf-8?B?emRLZkdUMU1DUkZlaUgyRGg0blpRallmMHZmRklyUEhDRjlWSDFMWUMwSzhB?=
 =?utf-8?B?NVFtTjZsRndDQXI0cWt3ZllZVUFNb1hoSzUza2VlcG91cUtJSlFzdksvWlVT?=
 =?utf-8?B?ZkVqY3Z6dEkyLzlPa1ZSNlpmcytXR3lEdDV2QzZBL2Q5SlNRdHc0Tno3ZW5k?=
 =?utf-8?B?YWtIZGJhaW5aenRUd1l6amF2MHcxR051Tndaa1dTRVlJcWZnQjBrVXJoeWZ6?=
 =?utf-8?B?dEhxN3lQaU0wUVhIZGc4QmI3Y3VyYXBPaFowVEZheUQrZEdjZENOS3luKzJ5?=
 =?utf-8?B?QWJKcGlnQU9CeUtFaEFWRGFaeENuODc5bk1PZDZBSmZ5QW1teGk1TkN5dUwv?=
 =?utf-8?B?TXNqWDZhdmdCeWpTbWhpRmFNVHg1N3VtbmllUGRuWSt5cnhPZEQzM2sxaGFU?=
 =?utf-8?B?RXVMYjFyQTFRQXNJTmRqSlgyL0V4dngxeVJZbE5RcEVaeUk2eXhHcjVvRUJm?=
 =?utf-8?B?RXpuNUl6cU1xTzVQYm5Qa0hjWmx5VUVRblVhS1krRXY5ZWVEV3BaMDFSQWRR?=
 =?utf-8?B?SXFBbU9PTlpPc1d3SWRNbGlqRURMMmxKbDR2SVV1eXB3MmcyY3ZaaE5KZG1G?=
 =?utf-8?B?R3dQbU45UnNGOTNYTTBuY3p2RU45bUdqeUxEV0RsMmlrTUZ0NnExS1VMdFZp?=
 =?utf-8?B?SVhBTkdRYnJLUVIzNDlnREdwNEg5N283SGVxbFpXU3RzZTZITG5SZG1mNmtZ?=
 =?utf-8?B?SWJJU2xCNmlwTlhwYUJyQmZObktYYkYwL0d4RkV2T2FVNVNILzgwZFpqMzhm?=
 =?utf-8?B?UXBGV3VoaENzMEh5SDNRWVhhZ2RiRVZVYWF3WkIrK2hIQnB5VzdGMHZta3pt?=
 =?utf-8?B?WHF5b2FTUVVLS2tYSkJsRCtDWjNpcm5uWjZMR3BNOUltNUh2Z0dOR3k2K3FC?=
 =?utf-8?B?RGpmblpMRFA3UE9JUStoRzNJNkpEVUhKOVI0VDBWRm8yMDZ0eTFRVDN1cVZM?=
 =?utf-8?B?bll6VjU0SlU1MXB5K0dtY29nYUdBQ21Jb1AzcGk1SXNWRW1vRnU3YzY1dloz?=
 =?utf-8?B?SmJ5alB5eUU2NzMxUXFYT2tDTndzd2wwV3hrZHNoSGtjbG1zM2QvaTM1cERn?=
 =?utf-8?B?QjNQcVY0WjBJYmJZYXFUM0M3TklmVnN4MG82K0pBNncrOHpZUzdpRVJCc3Ba?=
 =?utf-8?B?bUNGdkZQRDRYT0FCWmxxNE5RTi95WW1hOE1YNitsYkpwejd1cUIrMXM2L1ha?=
 =?utf-8?B?OEVDY0VKb2RqTzlCZGc3QnJxY0ZoYjZUbFdCVFhjZnJXUnllS0pFYnFRR3gv?=
 =?utf-8?B?ZldFTFU0Z3VWMHNOaFExUXNZWDZWclJUYldJaTVBbTVUMjVLN1hUK3RHVUo4?=
 =?utf-8?B?Q0RUeGgxSnlOTHYyQi82WnFPdmZmQlhMUGhlMTBIUWNUZmhuYzNEdEovbzV4?=
 =?utf-8?B?VXNONDJWR2NpSURhcUo2dlZuRWVFMEE0SEhCL1YzTWgzVStpRS9xQnYrKzI5?=
 =?utf-8?B?S3FYbmE2bnNUSkJIK1VQamlHNGY5S2RjYWpaaTQ4MHlNa3ZJajhidGhaa1dY?=
 =?utf-8?B?a0l2c2RRTnRZZlV6Z0xZblNwM25YV1RYMnpYWWYrUUV1eXh4dm9YbEllSzd4?=
 =?utf-8?B?WmQxK3VpNGhqeEFPVkpIdHMrWUt0VTdqWTBtOVMya1F0ZndsNU5qWkRDVElR?=
 =?utf-8?B?S09aK3RJRTMvK3VoUlNjK0xrcHBENjhQbjRTa2NZQ1FkZWRNNENOZWhycE1O?=
 =?utf-8?B?VDE0Z2VsNENhY01WTCtnWCtXb2txU1k4c1ZYblM2VFFWRm1Hem5lek9qd2Nm?=
 =?utf-8?B?TVhZbU9PdjlCOUNtVXdncUhvMGpacUZtV05jTVZEV042Y2IvRGYrYTA1RjNP?=
 =?utf-8?B?WXN0SXBhdElMbjAwQ0dWTHR6bVl2UktsdzlzVU42djBKZnZRNkZvODBwUnBn?=
 =?utf-8?B?ZU5teE1HN29qNFd6RU82OVlCV0lBTlB4Ly9mM2RVUU51UEZWM2tTUHNNRVpt?=
 =?utf-8?B?bkJkS0p4Rk1QV1hFazRMZWZOOVY3ZGVaNDlXRmRNWGtub2N2K054NmdxMTQz?=
 =?utf-8?B?U3VmNmtmckNVVm5KVzJwZEhUSDRSUjVXdWVhc0Vrd0wyRm53ZW5Vd1dXZmpi?=
 =?utf-8?B?MjZuaVdnMDFMdWdLZ3ozZGFHRWlkRnQ4YWtkUExWQnp4Y0xxbTd6WGFXcjI0?=
 =?utf-8?B?YXlIbUVrM3Ivd1hhTTJGUlBiMHZnaytSSXdmZVJkY2ZJQUgyMGhwV2k2OXU1?=
 =?utf-8?B?MFI0ZmNMN1JWQVU2NVNJUFZVNTVydmQxOHZiOUpLbG5tVDE2Qnp1ZXE2SHNx?=
 =?utf-8?B?dEl6N1RWOFNVNmt1S2c0T3lEMFlGVlBNdTZ3RGdodExFY1VzcEdkNSt1a3gr?=
 =?utf-8?Q?/zoPR3H6JM8gL/MjMCkGZ4P7fiwUr096loyCdg1md1UuU?=
X-MS-Exchange-AntiSpam-MessageData-1: Qox+43R5YUleHA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fd9d94-905f-4c98-c213-08dea747f23e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 06:07:38.3230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iU//+639l2PNAcE52s46D5pD555Tjv3PKr9QEvIX1BuUZTC5kwZRdlG/wbvlo4w57Jz2esFK8ALmBoPUL0MpEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
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

On Wed Apr 29, 2026 at 10:56 PM JST, Alexandre Courbot wrote:
> On Tue Apr 21, 2026 at 5:20 PM JST, Eliot Courtney wrote:
>> Use checked access in `FwSecBiosImage::header` for getting the header
>> version since the value is firmware derived.
>>
>> Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode=
 extraction")
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/vbios.rs | 17 +++++++----------
>>  1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbio=
s.rs
>> index 632c8a90ea76..bc752d135cbf 100644
>> --- a/drivers/gpu/nova-core/vbios.rs
>> +++ b/drivers/gpu/nova-core/vbios.rs
>> @@ -996,17 +996,14 @@ fn build(self) -> Result<FwSecBiosImage> {
>>  impl FwSecBiosImage {
>>      /// Get the FwSec header ([`FalconUCodeDesc`]).
>>      pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
>> -        // Get the falcon ucode offset that was found in setup_falcon_d=
ata.
>> -        let falcon_ucode_offset =3D self.falcon_ucode_offset;
>> +        let data =3D self
>> +            .base
>> +            .data
>> +            .get(self.falcon_ucode_offset..)
>> +            .ok_or(EINVAL)?;
>> =20
>> -        // Read the first 4 bytes to get the version.
>> -        let hdr_bytes: [u8; 4] =3D self.base.data[falcon_ucode_offset..=
falcon_ucode_offset + 4]
>> -            .try_into()
>> -            .map_err(|_| EINVAL)?;
>> -        let hdr =3D u32::from_le_bytes(hdr_bytes);
>> -        let ver =3D (hdr & 0xff00) >> 8;
>> -
>> -        let data =3D self.base.data.get(falcon_ucode_offset..).ok_or(EI=
NVAL)?;
>> +        // Read the version byte from the header.
>> +        let ver =3D data.get(1).copied().ok_or(EINVAL)?;
>
> This doesn't need to be done with this patch, but once the kernel-wide
> `bitfield` macro lands I hope we can use to to define a proper header
> type for this and use it both here and in `firmware.rs` which does some
> nasty bit masking - see for instance `FalconUCodeDescriptor::size`.

Yerp that will be nice. For this specific instance, not sure if it's
worth it though since it's just get the value of one byte.
