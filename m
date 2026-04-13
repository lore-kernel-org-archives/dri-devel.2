Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109B0F3ED79
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5898410E312;
	Mon, 13 Apr 2026 06:20:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EFDWg6ps";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58AEF10E30B
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 06:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RETt+ouXRhoxDERmegy5VjhgGLhsDBQQzWc33RvaUV7ZvGKCW0/7Q24mAtLOxIBzH081xxYa/TytagA5UXaw1kSGh8uvekePOWGvspf+5cB6ffHBTAkupenfIsmobgKygwmzb2Px5aaN+TI9vVD3Owud/bGdDCoT7iyc5Nxi/w7Cxb7lOkVz34hLao44KnQr2YRYNBNacWFUkpy+7ABtGOFJoEjMoqCgLchDF1XGOS3AKpUZLrpmCwGwgrKHlaA8wJLHuIFGdleSlBg4ikBfVpYgg6a9YsFknhpPUe5u0MjwimBchQgf2WRZRdELPICqi9YgQe7wbwjjSEkkcSX8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtsvZDlcMHiSJJmO1qdybQvr7Ve9Wv6vR/vFxJXeWTo=;
 b=X6HdNjBA2JeWR5bIqzMOuNtkFd1LCbAwWr/yO9p8MiimD+7l7s58AjVbLeusLRmzj7IH2XfNN+sAU18BWruU8+GIBTyK4LXfWeAN/tRJEf6kLBbymupaEtR/2HJsvxCRAXOxjtia2bhYanDVP9+C0HM06MKUR1hf4BnjSV4XvRWzHFQQyWA9CqP2zvehMCQ4BVDBeLHLp2spupb7A3eUtOhz0HmkGU9rMsSRyo05J6SATgTd4AE+wx6vWMnnXHhwmLYamiWIxTcdq/52e3yMWKzvBVDLb3FqZykPqZ1fWGI7bxHegf5LbwtMDew17zr3QFUAf+qpKWyGtcThcGnBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtsvZDlcMHiSJJmO1qdybQvr7Ve9Wv6vR/vFxJXeWTo=;
 b=EFDWg6psaQhHwjA6/ysrcPsNE9xDClk3vNbO2c6cyW4PmPJq21vlgfjjq3jNGjxHmIY5O5fC+IRPul2JMMxmHx75TOSjGjRIHO/kyiR2BeKko6YgL4kjCpdRnPG/OMGRsgVnMD2llAoCh0PIwgGULfpIl4o8eERnZtFQ3BVqKnG+arM7vtLQA5wY/OykcIaoExrwyveNiKqgdiOVSCHe2k57d1ouub8vAoVCm2wRIJW33DYJVbK+B4HVIAFvVj8Gt2U2/Hq1YE2wlpH5n+izsYV8lP2hlx7BShCf4FwwhNMUEZNxSPuY6AHbm2NpQHRWxjAE/wwXHw6YTY+CiXhA6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.45; Mon, 13 Apr
 2026 06:20:42 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 06:20:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 15:20:37 +0900
Message-Id: <DHRT5WO1KNM9.7QPD97ADIC3O@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] gpu: nova-core: vbios: use checked ops and accesses
 in `FwSecBiosImage::ucode`
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
 <20260410-fix-vbios-v1-5-bc6f71d153d6@nvidia.com>
 <edff8db4-a3a5-4b21-a8e6-9871206ddeb9@nvidia.com>
In-Reply-To: <edff8db4-a3a5-4b21-a8e6-9871206ddeb9@nvidia.com>
X-ClientProxiedBy: TY4P286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::18) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6740d8-a0d7-4ccc-22b4-08de9924c92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: skts5wdFV2XdIpSnG+IQxmnUx4jcVhPxwFFoP/iKnzwsB9h5gAysTPGNHrRrckppBUUhCWJs9/JFbKQ8RaFhJi4Tr4pbO3PBEG4dCHkREEJEFxBr2xVJlUC1QVA4ezZZephEHYCxA+VTKvOEXZobEH+mwMEZDwHai/6fkzfaL9MzxZIcYaaOajhx35SE1lsTYwpPEaaTppmvGTE1v5EODnkobZ/3vnDiT3hfVMruh7uIlOtOaeLZMir3KPJFfeJSf1r3+pPmbYr8wZJzMFFDQlop88JvIw0LkKFkxT1U7ANw7MxLhu+PkDbbh6ndAQ8DfKiSk0N/kgRAREHOJBrbsRYxKNNFXzUm26XS6zM45guO14l6wqAng7/W/Qcy66FlFQRMtqsphBGfAPwma2uLuFxaf0T7sGPeDEAUnj3yGgSpc6q5wTCftdeJ92kZHAmGVNitb2azCWmht84B1mryI46BhObNTn9GE/fBHD6H9IoiUs2MGy+PQzvtlBE9YqpsCbssKgG7VBRlNxAca6lbjrvGSSkifq8WB7i46DueNvpGbW46RivqDm3aHFcrJscqcEOps7seVX1V+i2C+UeRTXtEMIWX7wbqQ56Hz7Msk/bnQfBg+foH82iUQn6pe03eNBiBKQVW+gVom0qOEyjxz/Avt+gJyyj1/kXJvnpsNd7OxwHWgzLqS15OQ2mMiGNPLjqBw4rnav7chs3FZqX997pE1zDS/l/RueuwG0RocO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJWZVhoOTNpN2lWZGpEMUdxMTZ1WFZpUnhndkYvNnlDckNaeUNMTWpTbDhX?=
 =?utf-8?B?YW5FSHg4ZmhhTkp0RHRQTlI4N3dzdzVnTDliWitTeUFmR3h6RW1CRGFYVVNS?=
 =?utf-8?B?cFgzMGlwVG10K3hMZ1J1eVJ6My82S1dDS3RCajZtZkcyU2wvQU5lc3RiaTdM?=
 =?utf-8?B?bkpNQ20zTFlGZWhlQWVXMTRxYUhYbUEzakRYTDNNVWJzbVlHSXpSNTlLRVZN?=
 =?utf-8?B?bUtpTjRxY2xZWE8xTE1kaExrd1ZoVFFkNCs3bDB2TkdEN2tmbEFPWklZaldr?=
 =?utf-8?B?Um1TWXRGOW9NR29taTZGek0xcDR2YVltTlFnUW1FeURUSG1sOGVhUC9nT3VO?=
 =?utf-8?B?eEVlT2doV0hURlYwWmk1K1BKRXNZR3JxV2tHcDhRaFl0ZTlsSm0vVjdNak90?=
 =?utf-8?B?aXZTTW1RS0UxQ0NHUFJBVnJGclhzeGdxKyt0eGNETlNId2tVU0lqdDJselVX?=
 =?utf-8?B?ZUVibXNnVlNKR25JRGF6QmM3TUdENy96OUpWUnVyYXZkaFFYS1JzZ2tONUZa?=
 =?utf-8?B?OFlwNXM4YTloOUREN2xlOFhtTVJmdlBzT1UrRUZNOUlFaUFGcnNiQ1hqVjl4?=
 =?utf-8?B?VmVYeUFtWU1qRDI4VFFGbUltUldwK2JUcnA0YWFtZFVYOHpsZ3E5MVI5bStZ?=
 =?utf-8?B?bHBQdDZhN0JvSHVuK2g1TG9xclRVNzNBcStPWjVrQ1FDN0dmWW9FNGxIQjdM?=
 =?utf-8?B?d0huYnJBUHNMQWU3ZEltT2NramNYSE5iMkFRM2NlRVF3ODA1ZytHU0tZdXdJ?=
 =?utf-8?B?ZkxKbTdIakZ6VHBMN2FGRmtCL1MvelNtTHVXaUhnaWo2WkFjekplVE1wdkpv?=
 =?utf-8?B?RnVIYlZmT3NTOHZKcnpWbHZUcS92K0JKSmdqWGhZdmI5bjBmVjNMaGdWbU5K?=
 =?utf-8?B?RDYzV3hWVFlwK1lJc1JvdEM3VEJqS0wyU3NKTno4M0MzYjRUSWNUNGtXV2NW?=
 =?utf-8?B?My9IRkdJUHRwMmV3L29yU1FiL01HdUljaGNzTndhWkI4Y3VvRDZnaEVXQTdz?=
 =?utf-8?B?ME4vQmtlVXNuSHVSSzVabnlLOWhVNW8xVzNoL0xCMmVUMjZBYlptNlIyWGdB?=
 =?utf-8?B?bk1md2p0cHNtMWUwT3BZc0ZOMExqK0dNdm9pTnBDdktoYnNObDVlUXBwT3pv?=
 =?utf-8?B?K2VaUmNmY0pMdkdsTWJ4ek9JdzhDNEw5NGExTXpFcVBYYjJrMEI1OW5iL0xl?=
 =?utf-8?B?R0JpYS9ieWRUUENOSmlqOERnSWhjVTNiVXpxK3RyZkM3MkF6SWFLeVBnNWJj?=
 =?utf-8?B?Y3h3VDF4aWxQZG5RVmg3R3JIdTdPaWhDaG0vK0wwem5VSjdselE2endDZVBo?=
 =?utf-8?B?dHVKQnFhSlBibkxkSjdCMFVCcWQxOE9VUHNscG5abHlBOGNodnNzc2hSZGE3?=
 =?utf-8?B?NUNkblRlQW92TEFldE1QMW0wMTI1ZXloQ09sd2pRdnZTdFpwNU54Z0VWYzRZ?=
 =?utf-8?B?U0xXWHdPMk43MnZxTjByMmYxM21QZVZOTGJKd2pSb1M4MkdrRVBDcndQeEk4?=
 =?utf-8?B?Zmk5Vis5bzZBWDhPR2VVeUpCTGNnR1Z6VkZVLzF2ZG9EMkdUQ24yclM4dTFM?=
 =?utf-8?B?dm9UV1JkOUljdG50YlBPVDlJazVXVXprNjhjM3FISm5WajBVZVk4Y3pWNFNH?=
 =?utf-8?B?bUY0NmZYRmRuUVovU3lGbGdFcjlzQS9mUlo2Q0dKRmhUUmVhd0pJZTlONGhx?=
 =?utf-8?B?amw2RnVua0xhV1BxZGZCM1lmdUJURHZnQ3h0bTFPcWMrbGE5S0ZhMTVBWmVm?=
 =?utf-8?B?eTJaVllhSk5zQnB6aW5zTFNlR1E3eG9MejJKVkNIdHFiZml1NWhzWjJ6SjFJ?=
 =?utf-8?B?VGJRNEhtSGRLN0kvc2ZTMlBmaE5uYkxjZElIWXp3MXNad1ZrMENYaU02QWht?=
 =?utf-8?B?SFlPbHRON3FuM3NBemlCOVRqZnU5dzNoaDJwMnNxUWZRYmNjcEFYQUNJU2wr?=
 =?utf-8?B?V09mYnMreE1YaUk4Nkk2OEhMSUp3Z2UyRTlCM1Nhd0hLaERwRytPWjcvYTMv?=
 =?utf-8?B?Y29zeGVoRXFCS3lsUzF1c0k0MmZHeGRiYjkrdWJQOEpsaXpKNjZPSld6Z1V0?=
 =?utf-8?B?Nk14bGljaE1tTDFoTzhueEdhU3VNT3FlZmF5UEJiWjN5azRuNW5pdDYrb3c3?=
 =?utf-8?B?cnNjbEgrZFk0NEVBd0xUczloVTE5ZTA3WGFkekVnOHNocEE4NHVnUFJSZVJG?=
 =?utf-8?B?TVdaTE5qaEd4b3NaOVBGU05qdnJqSENXak02UW5VOTNzUkptWlFZM1FwYy9T?=
 =?utf-8?B?aVNlZWZTL0RxSjFvakhPeStZcFVHVUlLYmgwN2E3QU5pcnBxSUV3VE43OEFh?=
 =?utf-8?B?QkFoOWI1cFdFbVg3MlR2RXNZS3p6cENJZXBhK3JXcDM1MnQrbkJ1RWJ2bmps?=
 =?utf-8?Q?3Q/k+rq0xh0BBAgyK9oF6yzFoRel5GmaGks176rRQv4aY?=
X-MS-Exchange-AntiSpam-MessageData-1: tS/cYBWJZ5OcVQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6740d8-a0d7-4ccc-22b4-08de9924c92a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 06:20:41.9194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSviNUN4xAFe5scjG1Jiz/Ao+J6HQUrYQK0Kj6Afrb+x7lZqPKgHrTLUR64PXW4NI1YXsBiy4U5MW9xh2VgpAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411
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

On Sat Apr 11, 2026 at 12:05 AM JST, Joel Fernandes wrote:
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com> , one comment below
>
> On 4/10/2026 4:38 AM, Eliot Courtney wrote:
>> Use checked arithmetic and access for extracting the microcode since the
>> offsets are firmware derived.
>>=20
>> Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode=
 extraction")
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/vbios.rs | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbio=
s.rs
>> index 3bd3ac3a69f2..b509cd8407a5 100644
>> --- a/drivers/gpu/nova-core/vbios.rs
>> +++ b/drivers/gpu/nova-core/vbios.rs
>> @@ -1027,16 +1027,21 @@ pub(crate) fn header(&self) -> Result<FalconUCod=
eDesc> {
>> =20
>>      /// Get the ucode data as a byte slice
>>      pub(crate) fn ucode(&self, desc: &FalconUCodeDesc) -> Result<&[u8]>=
 {
>> -        let falcon_ucode_offset =3D self.falcon_ucode_offset;
>> -
>>          // The ucode data follows the descriptor.
>> -        let ucode_data_offset =3D falcon_ucode_offset + desc.size();
>> -        let size =3D usize::from_safe_cast(desc.imem_load_size() + desc=
.dmem_load_size());
>> +        let data =3D self
>> +            .base
>> +            .data
>> +            .get(self.falcon_ucode_offset..)
>> +            .ok_or(ERANGE)?;
>> +        let size =3D usize::from_safe_cast(
>> +            desc.imem_load_size()
>> +                .checked_add(desc.dmem_load_size())
>> +                .ok_or(ERANGE)?,
>> +        );
>> =20
>>          // Get the data slice, checking bounds in a single operation.
>> -        self.base
>> -            .data
>> -            .get(ucode_data_offset..ucode_data_offset + size)
>> +        data.get(desc.size()..)
>> +            .and_then(|data| data.get(..size))
>
> It might be worth adding something like:
>
> data.get_slice(start, size) -> Result
>
> in R4L longer term if the data.get(start..).and_then(|data|
> data.get(..size)) pattern is common. It seems to be so in this series.

Yeah, this sounds reasonable although I think we'd need a name that
makes it more obvious it takes a size. I had a look at rust standard
library code and it seems a common pattern is to use split_at_checked
for the initial split. Unfortunately we can't use that yet I think since
it's in 1.80.0, but maybe we can use it very soon.

I had a look and it looks like there aren't really other existing
patterns like .get(start..).and_then(.. get(..size)) in the rust kernel
code. And in nova-core other usages of getting start..start+size slices
have local proofs that start+size doesn't overflow.

For the most part in other code hopefully we have local proofs that
start..start+size won't overflow and we can just .get(start..start+size).
