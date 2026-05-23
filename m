Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54925CD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6B7E10F64C;
	Sat, 23 May 2026 02:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="e06bYmlW";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F6FE10F64C
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwK1TskTr/U4n9nJbjphgJFZhPrr5UQLOsh99V2II2oBsRSAeFjapyK3GRoCD++H34KZKxUwNuC2oPIaSYle3JDrRmWdKSQ7Y7nHcSqvFP5A9Xb/zDHohxlv8jAqpCGJoMOFZpPwxC6Xjv5g/L+7pKAuvCwR8WTAA+ALaOb/WavL8Y8sdzdW+qQU91jDNut8s9wduyUNE66gH3K1KBnXHauSQXtUPJNwVPiDd0RO3fV9muVryzi4wJnDxLwSvzTGz4Oqyv/c0SzC/yOrmramhcvMZkEuZsJZ4H3O+C15flfaa20Jbxee0aMkYsVrikd6L4O2TNyAvsT0YMmPPBrnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbXtnylBRerBZbLVVPbCuHJlfyueRB8Znl7dPsXyOd0=;
 b=dW2z2MsdrspdTwrTR2MoNr8Tpej7ythxUREDKrEyPoU7jnOfKgTn8cQMJhHmIIzihfA5LddWdTaCZM8lYr1snKRQpHJFclQ2MG7AEmzARoTR8a25ycWuO/KvNPaUE+kTfXqB/ghnmVgJi/qfTANUB/qKvJCHadISz++4Pr4aYAaiusfwdWixW7YgaKk9n0ThZ80hHdq+/dJjDlw1LUOdQGQ6Zv/TTc52XIXiFZ/eIDMrH0x2ygPdfDvOI4DhpBcwci5i5e+3AsQzVJ9F6mh8swaiMpQppYrn4eU94ji4ShapWKrnDHymYd1Hhv4Yg+LOeTnTWBSSD86Ob3pEwXCwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbXtnylBRerBZbLVVPbCuHJlfyueRB8Znl7dPsXyOd0=;
 b=e06bYmlWCof371scAK62I3VL74jeehbtQLoVQxVYhkg2c3L32VagE05z5QgOVnWoGEsuqLdBEou/tdMgAi7irvJR1iUCDxB8bkvomHgDRG4yoCPtOL9rj0XEMtIa5OUZiR6v1Klz28NUnT2k2xbVybyRX97YKtuUfsR6h1TENsSPJJjVds+XvURQ5Pmue+McDfFRJygH+ZITgPRQao+DMYDyi9cyRaQU9nfbV+tNnl5O4zfsTtQXAwz2iGmlAwC29/CS9j4AdWxDSY7GZKyxYS5s40RY8hAJLuD71z8ibW3Xn3FzP7qMFtDrG971UeYlvptk0Piyw68TJED/8xHaRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Sat, 23 May 2026 02:50:04 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:50:04 +0000
Message-ID: <a6768b2a-aa68-49a0-8928-ba9a2fb5e4b9@nvidia.com>
Date: Fri, 22 May 2026 19:50:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/20] gpu: nova-core: vbios: compute FWSEC-relative
 Falcon data offset
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-10-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-10-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: a5583469-9993-486d-6659-08deb875fe0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 1M0atKGxYlVcRtbOaQdHSB1btpvrxHGlSGjU0/mDl4hfZto+ibXeQTjFOdt+SvBy5vU7K29iq/HyUoUcB5mXKdxwLnWDhAZBPjBEbVh5rxQ/NV1bk7hAKWZL3YqjRIKJMfXf5qt8+lbOBylhTjoyury/DteD2QnPCR6UXX34k47tWc5aAmS7XLe1b+RZnWeraCYjIoUDGD/HODOa7AIU/ZPhGQpMhy1Kv6lW7K48aHLOa1wlrFJotWm8yHzrYonmyy5ixg/2XWmyVrtn+BUMAIKCGEBAPZq1oLfln8sQBFGczoDMTUPVDspm1+P6OzLj1vbSGwNi5rBY/Qo35q5kEnSPXd4Lih7pn49BZaSBQoycrkVM0skSJ+OC1KfyC6CQ26OBVNTyjDhr0vUIvQNbWKaQ2r/J1Do5iQJcNoE4AeJ+HY3P5tTPFyAWCXpI2GjoVUuRa7IuCeroKn9Tuwl988iMOooVFT8NCHU6/u7mWni/cFexcxUI4qJeqDpXgoppS2Lj78lo2mPPb9IJJS9lIy3glPxJYxZYcck24FdCYcJiHqa3QWDBihYhNn9ZMfnZKNYhWBekp2w9tkwOXKk5gDDi4n7PV/yRSFOqpPly6YykB8C7mH6sONKYf9R9Sjbw0jULi2babSHxvVA6Ha5In0nAf/BGGvIp25Z8oclc1Ypd4IJghYpHEUjzmFg7lNC9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUVZdW5rRmNJN3BYUjlPMHJjNm1vcS9DMDd5NGo3QVVrVmN4bGdqcWRVTnZ0?=
 =?utf-8?B?cmZMSHFmMWdXNmhrZ1ppWDgzaUJ0RURqaWp4amFCMzlQM091QXF6OXlGZkts?=
 =?utf-8?B?OWZkZkRZWm5jenpFZVVTdzdYa0RoMmRTRVFyckNkaTBadTdnNUdBRHBpbmdj?=
 =?utf-8?B?emZEZDBNT1RPVEsxRklJVTJNakY1WXdIbGx0amRGdmlPd1QzOEd1SzRnSk9D?=
 =?utf-8?B?MWExYStXTHdIbUptK0pXWGgyNUIxamFnMFk3blhzV2pFc1ljbVBYRWNoUUQ5?=
 =?utf-8?B?Ti9mRUlkY3dyaUpkRmhrT1IzUjlOTHVJK28xUWRWcEtqeUcrRzZrTndPdGVy?=
 =?utf-8?B?SElHM1U4SEtRTm9oN0cwNXBOaEx5MllhSVk1cEpNYU54UGowQXJ5eXZnUzR0?=
 =?utf-8?B?UmxUcmk4MHd0Z1ZpdXdJbGJhVWl4clNWdTFFa05HNUFtZEdRdUN1Skk0NVkw?=
 =?utf-8?B?RTJLQTVGRldadCtjVnRsOVdQdnNrcUNJaXFCaFl3NzdHWDcwbjBzMHQxaTls?=
 =?utf-8?B?dlZRTS8xdnVXSGFNNm1mN0R1bmVOVmVFSHVqNzVZcCtaZC9QRm9EZVZJNmhi?=
 =?utf-8?B?bEFsY3ZwYjZ6VnVIaWJpWUJDUUU1b1lTaFRVTGdlSDFhWndUWDZFMVBRMUJC?=
 =?utf-8?B?NHMvS1EvdmkwY3NqVk9LN3JDdU85TDF1NTBETDE0RFFSVk9pTmxWa0xUUThZ?=
 =?utf-8?B?S3EyZ2FrbU83VEZ3cjFLMXlMREVrS1c1SkxZdS9pZEh3MzdLa3pRNWpGYTVX?=
 =?utf-8?B?Q3JKbnFkQythNGZMYVRWZUwwMm9qYUFDWFltYkFacTd3QWNqdXdlMTBBWHpP?=
 =?utf-8?B?UFVNWWhVaks5QmxwbmV6bkVkdllneThzcUM0bU1nd01GNE0rcm05QUNFc3ZG?=
 =?utf-8?B?aUtrbTVmK0RtdFdUc0ZvL3hLbHhwT2toMjZRUnZ6aXExcVl6RUZFRjIvVVBG?=
 =?utf-8?B?WlhYTDlSRERudGRuZUgybkdsSC8vZVZiTzFVSG9ianBJTGpVTWVWUlJybVhY?=
 =?utf-8?B?SEF2TitrTFlnU3l6OEpqQ3lmOFFEOTkvK0pnb3MyQXUvdjJiblRNSWtOLy93?=
 =?utf-8?B?azVtbkRCNFBVZ0hycDBOK1ArUkFGeVdsTHBwSnAzbjFoUk82NXB1S2JNUmZz?=
 =?utf-8?B?R3F2NHNkcllsWVFqRmFGNGZYL3RWNVlwZDgvVjBTZ3d0ZVl4T050Z1c1UmIx?=
 =?utf-8?B?OElEWjJHVUhCWHRyRXMyK2V5T0FvVkgyWm5uejhkQzZ0aStYYytQdlM4WmxC?=
 =?utf-8?B?Qk80SnQ2ZDVXdWl3QnNkT3NyN09OenovdE5xWUVUTUhtT0ticVg0a09hNGhV?=
 =?utf-8?B?QjQzSGM3cWlmVXQ5ZHFGUXRtUDF1Z04vZkhtUldoR2FYbFBRV0VXV2lkeW14?=
 =?utf-8?B?cEJkemszWHhSdWoza3pFb3FORUxLSzZpTVFqYUl4aFg4c0VjMnVSNDF1ck8r?=
 =?utf-8?B?N0wxOE1pa3R6VUZLQ3pyNlBibWh5clFrZ1ppRkY3REJGR1MvZTR0ZkZIZEhW?=
 =?utf-8?B?c2p6Z1B3UWI5UUhncUloL1JNU2o3OHFzQzJFQ0VJQ0hrL0RlVVFQcC94anM1?=
 =?utf-8?B?Q2ZFVEtObmF6T0k0U1VxVy9yKzdvamZidFdnVkNqQ0JWTWYxRmUxWWd0SG1C?=
 =?utf-8?B?YjBHOERlblprM1NhZTdodm03eGNGeXlhVmF4aVN0N2xDMndpVnN2L05yNCs3?=
 =?utf-8?B?TVlaMGcvL015WXFSbDNleW1jZGN5cE51eGhYOGJNVUdmc1oyM244MFUybFAr?=
 =?utf-8?B?MWVpNndKV2E4TGNtU0dYaVY4QktHQXJacmx5elA2bzNNWVoyTjBTRDE4S1Mz?=
 =?utf-8?B?R3VaMlhmTDlHa3JWdGRzdW9hUHVHRG1SUEZBc01MT1pzZnJQekdUSDNFTkFM?=
 =?utf-8?B?dVh6WGNzOGhseFdtSk9memhucHlzL0EyRFNhNWh4bnA4WVNVTUtWT0NZYk9p?=
 =?utf-8?B?bmpwU0orWW43M1Awd1lKUjhJZU9MK3RZYmljRHNqTkpqdWJsc3VkNGlyd0gz?=
 =?utf-8?B?RC9KZWN3Y1FRR0cza2pqZlJ1T3hpTGhVZ3FveUwwOFFKb0FiNWtvM25WRUM5?=
 =?utf-8?B?aDRReW1SRjZrNmNrQ3FZb1FWQ2ptWnlTU1ViaG04bmtQbmVub1h1WlpSTGpr?=
 =?utf-8?B?L3JpTFB0N25KSmhNd1dtQ2ZwdXVxSzQwR1JMcUtoVHY1T25Jbzg3eTNyUTVz?=
 =?utf-8?B?MXpjdnpnMEFvR082RGhRczA0VlRyR0NhRzJnc2NpTXlrV1BXZDViTkJJVFhh?=
 =?utf-8?B?aGxNZFdqU3Q0Y1hYKzJ5UGZCRjNIdlpwQlJDc3dmcHp5eTdqRDhJSFpSdkYz?=
 =?utf-8?B?eGhLcGFxalBjcDUvS0ZUYXYyazRjNlpxM0pkS3EweWxlV0tQQXhDUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5583469-9993-486d-6659-08deb875fe0b
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:50:04.7341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+evd9s3evwvlV0NNpf4Y6T6p8mqTnAa0pOmtdBIvye9ifBKhxonhUCf0QVXdSkQUT7Uanwnqy1ygZrQMVpE2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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

On 5/18/26 7:55 PM, Eliot Courtney wrote:
> Push the computation of the falcon data offset into a helper function.
> The subtraction to create the offset should be checked, and by doing
> this the check can be folded into the existing check in
> `falcon_data_ptr`.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 48 +++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 29 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index cadc6dcffefb..ca101b2b6095 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -846,33 +846,29 @@ fn get_bit_token(&self, token_id: u8) -> Result<BitToken> {
>          BitToken::from_id(self, token_id)
>      }
>  
> -    /// Find the Falcon data pointer structure in the [`PciAtBiosImage`].
> +    /// Find the Falcon data offset from the start of the FWSEC region.
>      ///
> -    /// This is just a 4 byte structure that contains a pointer to the Falcon data in the FWSEC
> -    /// image.
> -    fn falcon_data_ptr(&self) -> Result<u32> {
> +    /// The BIT table contains a 4-byte pointer to the Falcon data. Testing shows this pointer
> +    /// treats the PCI-AT and FWSEC images as logically contiguous even when an EFI image sits in
> +    /// between them, so subtract the PCI-AT image size here to convert it to a FWSEC-relative
> +    /// offset.
> +    fn falcon_data_offset(&self) -> Result<usize> {
>          let token = self.get_bit_token(BIT_TOKEN_ID_FALCON_DATA)?;
> -
> -        // Make sure we don't go out of bounds
> -        if usize::from(token.data_offset) + 4 > self.base.data.len() {
> -            return Err(EINVAL);
> -        }
> -
> -        // read the 4 bytes at the offset specified in the token
>          let offset = usize::from(token.data_offset);
> -        let bytes: [u8; 4] = self.base.data[offset..offset + 4].try_into().map_err(|_| {
> -            dev_err!(self.base.dev, "Failed to convert data slice to array\n");
> -            EINVAL
> -        })?;
>  
> -        let data_ptr = u32::from_le_bytes(bytes);
> +        // Read the 4-byte falcon data pointer at the offset specified in the token.
> +        let data = &self.base.data;
> +        let (ptr, _) = data
> +            .get(offset..)
> +            .and_then(u32::from_bytes_copy_prefix)
> +            .ok_or(EINVAL)?;
>  
> -        if (usize::from_safe_cast(data_ptr)) < self.base.data.len() {
> -            dev_err!(self.base.dev, "Falcon data pointer out of bounds\n");
> -            return Err(EINVAL);
> -        }
> -
> -        Ok(data_ptr)
> +        usize::from_safe_cast(ptr)
> +            .checked_sub(data.len())
> +            .ok_or(EINVAL)
> +            .inspect_err(|_| {
> +                dev_err!(self.base.dev, "Falcon data pointer out of bounds\n");
> +            })
>      }
>  }
>  
> @@ -989,15 +985,9 @@ fn setup_falcon_data(
>          pci_at_image: &PciAtBiosImage,
>          first_fwsec: &FwSecBiosBuilder,
>      ) -> Result {
> -        let mut offset = usize::from_safe_cast(pci_at_image.falcon_data_ptr()?);
> +        let mut offset = pci_at_image.falcon_data_offset()?;
>          let mut pmu_in_first_fwsec = false;
>  
> -        // The falcon data pointer assumes that the PciAt and FWSEC images
> -        // are contiguous in memory. However, testing shows the EFI image sits in
> -        // between them. So calculate the offset from the end of the PciAt image
> -        // rather than the start of it. Compensate.
> -        offset -= pci_at_image.base.data.len();
> -
>          // The offset is now from the start of the first Fwsec image, however
>          // the offset points to a location in the second Fwsec image. Since
>          // the fwsec images are contiguous, subtract the length of the first Fwsec
> 

