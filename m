Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED8EF8D761
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E4E10E8F5;
	Thu, 16 Apr 2026 16:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8r/b6Z1";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2617D10E8F5
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 16:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6XNJ/WJ4IiGUBzhJ0AeSaaSbCBwtuWosRGgt3cxUBPiQl6OvOllFpyppdvBWy/ELIdLzG4Io/wvoId1G5ZMvhR7rd68nJl6gDXk0PV3xawn5IP1nJopgkl/3tjaG4CjCcL9SxeB7Xod3bDXroCP/8k0CSc7N19jKatKkWB4zXMNzAXAoiRPbD3TkjB05cfBDtKgJwd8afSC8psA1mfiuv1ofZwIpGviaDn+ULRIocV1g/27n7WPokcXI8PGRn9eQ642ZrKLtPLBr0LjKPMJNrs46sWeGZbOFEyEeeCT9sBUcPgutm7TyQDOcnpBbj1XS3xvTjuQJ20SnCjr9FzV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqjDrRDxPy3k6lHNyX6HeEDipTasGZB/mesdltANWrA=;
 b=UfpRlpH80ZlCe5TL62H4Ljh0O2KlMfV2PkgNPLNKm3+2RTVdriNrM7x/KzHJ7uCHajF3F1TFJrTnflLDiYnB1W7ZhmRj+BQ4/v14pnqiz07lhgIt/AgIZ/JJXzbXfwRgg2TmNPudoeNGFxKs5iCEsflmb5KlQzNlslN9DLlx3lRBQXo++Jfq3JZY6TUWEk7kaJCBv61JbinJk886PBDew0z9YiZJ+FWMxLt7ugk/quGx7cNEurHShGhRpbxG42WuIrMmKn8xL15pN3bOL4rRGKBOFtkkrP0ky49z7lAZz0RFvKpKQMSIFs11GvX12XfcdJEmOPKGFsAyI6qVIWbizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqjDrRDxPy3k6lHNyX6HeEDipTasGZB/mesdltANWrA=;
 b=V8r/b6Z1U2DY+yhUi8wNS9ht+kipZ6bbfmQje+WdjjykxdKU/0Dsqx4zXgBCXZnaJTuExCjRDoB4E3g/9nwij1ffMn1yCEQsjqNTeOv9bp/PvaVksTYKzr5TVQEfKIoWfvKYRXMfso8CRwv97khTtmP/heA9tw+7aW5DiOc8V6B9ag0CClDB5xLpJi4HyccyhDErHUoECYKZvux+KNbLJzkGfimeFgXLQPfuwluaud9dkv2iUNx2yo6bJjTLnLxpiEvicKfo2ixF5/LR9Q7oTnMrTZQ5pJ0zWfhJ7hsX2SeUtaZDIvNbqnXwHQAxm9/YpSsInoo2Vdfcy+BnsCfgWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BN7PPFDE2ACDA69.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 16:20:48 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 16:20:48 +0000
Message-ID: <7ba610a4-068a-45e1-9ab0-1231ab5b98fb@nvidia.com>
Date: Thu, 16 Apr 2026 12:20:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-4-705d30d16bba@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-4-705d30d16bba@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0049.namprd20.prod.outlook.com
 (2603:10b6:208:235::18) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BN7PPFDE2ACDA69:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b097ebe-0a4b-4990-a071-08de9bd41e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: LuwKxJ8S1mSUwHb/dNjlDhuJVhwu89xVyCXtD7mX/wWZxia+af03I+Q0y1SF9rmcP6nzyOowtV/2ltS+og6euOzI9lT+q3+E6MJ3AkcVmoahdz7VkHUD5irgSEC9ffa2q1yvOrYad0hmHztCu515cVEfcI3OPMWVgA4Dma633+lC4P2lWv+Rf3YVCR3Lh9wuThZ6Wg8j0mKrOUDh0O5fqj31E0QaobbxrtjdAhvIMgpkT+wr6quGY5BN3yxZd/P/D2qZoZx81CG19qSfjU5jGXNNUi0dfqsxEYzMfD+FMkCocXIrJAuvA3IRhl8wvgyJ2D/jAeJ1Gc5wIOtmI03+kjAZy8yQDVSBk0bo0SH76aBF2nCctzLiwrV0rCvuxh7EuwhymkJUH3R9ml3nnTtEoIzgiljMew1Yt4MXWTVOkSnzBOKqByD0KFQdB0xd6+ImyzrxLrpCHcOUZ6dTh1MBUUkfDuv6lxWPo5cB/0cI7BA9lYlBN0KYqUDQSwFoq8N1YuRBHjHDiVvmBuTMuVkygoLwrAlVL4QU6Fw+j5PxMDYQttOIH9g2Sggf/9m4eltQsEf+B6I0kXX/lrNCexgIgI9TnBq7clwSSBwM/vVprJzihSM0z1mFCayJ2dI24S3QUZBpuFxqrOc+r9HTNelLXVel+A10Mzw4fgn5ghX/EU/6n+V0+J2U5ippNSh6lWzTUg/wKT13QbABCuzWIYbNQwTgjaxpYbRBa0OySI5mgrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGRhRzA4WkNIckYwRHZoUU84bndpVkJSWjYxVHRYaGxJQVNvMFBYdm9ITlR5?=
 =?utf-8?B?RFpFSmsvUDFXWlZWV1RSWHFWLyt1ODBsQjhiKzF6TndPQ2pWdDVYUG55TFdW?=
 =?utf-8?B?SnREWjl4NWJlbVIxUkFaU1lvdS9TQS9hYWVpNzhYWGt4RFREa0ZHdVl1UUZq?=
 =?utf-8?B?Tmovc1VLdzAxc0Y5L082aTdMbEM0RC81OVFtdkN6M25wb2FzK2MzUEJYTnJG?=
 =?utf-8?B?dnBVK2hkN1pERHJxOUs5WUc3QUxnM3lYQ0RqWCtlQTk1azIzblJoL1RwdnRM?=
 =?utf-8?B?cmxzelEvZ2IyaEZLTStkc1lNOE9TZTNIZkpVamZac0xrL044QmtVd1FSbVln?=
 =?utf-8?B?RlFpSlMxcUpYNm9pMS91UHBNVjVnSkc4NHRScStMeC9qRTZVb3JuaS90b3Bm?=
 =?utf-8?B?bWUyN0FHZG1pbW9FNkJaTE9qUC9ycm9NTVR6VUlZZTRhQ3pMVnJvSkYrNWtQ?=
 =?utf-8?B?QWRrUzdVUmNXOWNTZlRYS0dWUDlvTzZwSExWbmR4NzlzQ0ZqRDdjZFY5MlNu?=
 =?utf-8?B?VzAvUmFjdnRjWlMxMFVxZVBFMURkWXRzSWYyQnBTTlNSSUZmSWJPclNqRjRD?=
 =?utf-8?B?aWNXeDJ0VTdvSzhWTnhDL0RaMW52aFVkVVdzL0Q4TE9FLzhaWXYyNWtrTmJB?=
 =?utf-8?B?bWxFZjdVUFVtRUtuSnUxTDFlK1J4RXNOR0tXd252UDVXc0NtRkxFN2lTYlgx?=
 =?utf-8?B?TVI2djJHYTUrQXVMUmlhU2JkZEtvelVEaVBkUWdqK2NtdUk1MG0raHRFQS9a?=
 =?utf-8?B?RnlzSCtaWWhBelpYK0ZIaEt6aSs3VW55d2poUmNHN2hORlFOVnhsLzZHZEc0?=
 =?utf-8?B?UUlqK3ZRTjI4ZExJNDk0QU5FM2RQOVJEeGdKRG1ZSGNHS0NkUmZRaG5CT0Vl?=
 =?utf-8?B?U2xpVWdyK1ZDNDk0cGF2SjQyaEhpaFA3cGxudXRjM2U0NnVYZmVhMDZ5NVY4?=
 =?utf-8?B?dEpKaGxYUys2M0RoeFFGRDF5Yll1NFU4bm1ZdFFaQm9takNQcHdTcGxVRGs3?=
 =?utf-8?B?NmdTaDlGTTc3N2U3dGJ5OGR2MHU5UkxqT3FmU0xOeWdHMWIzWnJjeWtiRk1Q?=
 =?utf-8?B?QmpOcWdwdktQWklFaVUxdXc2eG5TbjZrbWlWelZPVFk0KzVpR1IyR1N2eFhG?=
 =?utf-8?B?WU5BL0lieGFLK1VpK1FCRDZjSUdaemhTbi8walRpenhxOHlxOUV2Sm9JMnZU?=
 =?utf-8?B?Q3FTNjcxVWZmM0dUWmtUUkFCZzMwZm1YTlZpY1A5ZHRoVjVicGNpNUVEeU9p?=
 =?utf-8?B?ZnZIekFrWWcrSnJkaCtWZy9ka2doaHNSVkNINDY5aG1OWWRhakNHYjE1NEVl?=
 =?utf-8?B?MHhaVGJkM2ZKQjFhSEQ5UjBHbW1Tem5wMy94TlhUeXVUWEhsTmRoR29BOGND?=
 =?utf-8?B?dVVBMjMvcmFRVXZGbmplTkVjd1ZVQnA5NERxMjE1T0Q0MHllZnlyQ1hUU1d6?=
 =?utf-8?B?eGJTYW1XUlMycXBnNWxUYW1jUzloNlNiZTBhY3l0NjZXb3h3dVp2OFhKbnl3?=
 =?utf-8?B?TFhKL3NjejExUGgxR1FhL2VMWVN1VnRkMEU3U3Vvd3NhUDB3UDQ3Z1VVamti?=
 =?utf-8?B?ajRxd0drNXJBK1czOGI4ZlZRN04rWkMwdjVWdHRKL3VoZVRFU2MyNjh5NVZR?=
 =?utf-8?B?czVZTCtGMTN0SmtqZElmMXBQc210L0N1NlZPVnVnVkVsdFZEK0RxN2Y3ek5H?=
 =?utf-8?B?dnZRN0pWc1JjK2ZpSEpMbjFmQy9UanYvVlFpb3lnTlUvVTh1TkI3S1N0cXFw?=
 =?utf-8?B?T2pCbGY1U0o3ZGNzYXBnN3lFdXZHN2w3SEpaZFpuS0htd3FuVytkY0ZYQXVu?=
 =?utf-8?B?QTB3SEVIRE12a2ZkaE5xQk9kOCtGaEpldm9xdXh2STdlelVVRUtqcC9IdlIr?=
 =?utf-8?B?Q0NobkV0aVgvUmgyaTVtSEpReWt0YlF0alY1NVdmdzRFeWtQdmxTN1B6TVFU?=
 =?utf-8?B?VGpoN1BKb2ZJRzc4MmtWejl2eFYzZlV5OFU2bS84RUJNcUZ3MFRGL0FBWkRk?=
 =?utf-8?B?L0xudkh3SGFsZVNoS01udlhZaTFveXl4MjhybnlYZHFsUG9jYWhiLzNRaGdj?=
 =?utf-8?B?b1NaVEcyNU9YenJrMDlvRWxRU1lUQ2VNQU1LQ3drNFZqTHFQTitCWWMzdXEv?=
 =?utf-8?B?aUhRYmJhWlZYWHorNkprL1NnaVQyaG4rUGJVbXRwc2RGSFRzK1NmSFlobWQy?=
 =?utf-8?B?WGxFaDFJdTBTNEVIVWRyZllrNEIxNHhZWTZ2OFplUHQwbmhCMmY3VXlXSzJ5?=
 =?utf-8?B?N2lvR3c1dEtTNkxmSkQzOHUwczJtNGJPVVdrODhVZm1IeVorTDFScXJMa05U?=
 =?utf-8?B?bDJDb2xNRnoyaWxxUEt2aXZpUU05cE9oNWZsTUFPaEhGN08rYzdudz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b097ebe-0a4b-4990-a071-08de9bd41e99
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 16:20:48.3547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QA8TEQfMW0F6EjaHoCenc6EsrGcgvBwxEPJiLDmnyZ8BOZW5yZBpABkz5SXFBmm/H9RAOiksTxTykE/fvYecg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFDE2ACDA69
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



On 4/14/2026 7:54 AM, Eliot Courtney wrote:
> Use checked access in `FwSecBiosImage::header` for getting the header
> version since the value is firmware derived.
> 
> Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 632c8a90ea76..bc752d135cbf 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -996,17 +996,14 @@ fn build(self) -> Result<FwSecBiosImage> {
>  impl FwSecBiosImage {
>      /// Get the FwSec header ([`FalconUCodeDesc`]).
>      pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
> -        // Get the falcon ucode offset that was found in setup_falcon_data.
> -        let falcon_ucode_offset = self.falcon_ucode_offset;
> +        let data = self
> +            .base
> +            .data
> +            .get(self.falcon_ucode_offset..)
> +            .ok_or(EINVAL)?;
>  
> -        // Read the first 4 bytes to get the version.
> -        let hdr_bytes: [u8; 4] = self.base.data[falcon_ucode_offset..falcon_ucode_offset + 4]
> -            .try_into()
> -            .map_err(|_| EINVAL)?;
> -        let hdr = u32::from_le_bytes(hdr_bytes);
> -        let ver = (hdr & 0xff00) >> 8;
> -
> -        let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
> +        // Read the version byte from the header.
> +        let ver = data.get(1).copied().ok_or(EINVAL)?;
>          match ver {
>              2 => {
>                  let v2 = FalconUCodeDescV2::from_bytes_copy_prefix(data)

sweet :)

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks.

