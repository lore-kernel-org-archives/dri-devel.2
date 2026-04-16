Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97224F8D761
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0AB10E8D9;
	Thu, 16 Apr 2026 16:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UMb3TL8X";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5451610E8D9
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 16:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwFZzWTmrRQOfF1SSOHpjwSR8MED6jyNVMOKAMj1zq2874Se/AyqVGChGftOOew6e8AGy+Kly9w6aaZ8tgb0S98zhGK0Dxgx/TQFddFZkPvYfq8Ldpd/54tJUjNXZJUgj0JBKzF5Nm81pH7YlthNX7mhaI77NgBtS5v5nvDU1C5d6tn4i6mO66ESTGZrg3uOBuqz2ssplcnMbikG/PWyhOFh1UZ4HQ0YNrOrfRQwJC3GNynlmk4r1n6cAIdVXVVUaHoROLdgM0G95yxIqDE3uOouMgRv9G69jotoyZqmvluz0sk9QZYGcgeTdutIMcmaSojbpiPouk78A6XoXlgAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGCT93BeJjLkupxkB8pOkRVFW7/pb44AbEoiob74G1E=;
 b=EpYKpwivPxtYhQlmbHdHY0AKlgylEkWoDO75NllFQ31oO0uHs+Sgew8DHUFOuEeyeDz4s3xyQya/UbS1AjW+hyUHo9S70VqEf8+xLyasiX3venCDQqYKVxa9Trn4x1us7RdQGFo8h3USoBIRElE5StqVlS2xd/ldIBdduylBsthHbia2FlL2hJU749LOZ1+X5d8yM8cr8P0yY3m1gBeXrOXhU94rnFklwYwkEDGwHXg4r7/4D+O/vNGyXLvkzD9JmT8trNjqlj/+/e7UKmggsZOOEpcS7/gO1q3eFDyk1rQRqsiNwml3WMSuQ1gtGLeeeQHnZSgWFb5DMMaoEDKRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGCT93BeJjLkupxkB8pOkRVFW7/pb44AbEoiob74G1E=;
 b=UMb3TL8XQd52AaCbLcSINf0HSOQbKN1BH/X6zPiofYZ/7chpSjtebotv1IviDSy2t8VtZH0e4ov0nyG79rhvjIGnOOm+b3zesoHh0FctOBZgZYGM7137FgwhSu4GbIH3ZVLB/75Ry2IfGs9cqw75HRyB/L23ZTAJD+b6yvyNLnUZLgjNW8UdtiZs0tDtTn8ORHeczOA/CqIDZhvJg8x30TZoDb0Bq74KS/LUf+vo5om7IPgU/+iLBOXiJ3SA/xX+s4xqRMefMFTMM1hNsBB+lO+9/SQcnAe7ZmmrH4VNQbRrmmnRA+b43RNHrIoRQffNeJJCRTXRWzldLww4kjuTvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 16 Apr
 2026 16:13:37 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 16:13:37 +0000
Message-ID: <54b13fa0-9405-4fc8-ae41-fd1d310c7aa9@nvidia.com>
Date: Thu, 16 Apr 2026 12:13:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] gpu: nova-core: vbios: compute FWSEC-relative
 Falcon data offset
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-8-705d30d16bba@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-8-705d30d16bba@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:930:45::9) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: d70b4af1-dda5-4d67-046e-08de9bd31d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: kqIzntjiClOW48HnOMRppeuSByJbzciNo0YYX5UNT1ndKcpHC3QhyNvpUPicbqpoKUZOS571x1PlVAio8tB0odZkJVn9QsHjBOPkOI+Sg6tO0s8h+CFYAtHRZBu+kdyCo+fZwP7FLCG9aOIS/GE1zj5H7JvO/+jziN9DZ1sJ2DHhV0h7o63ebp949mc/4QfqQbAx5iZ8DxBBbF9f3xHQ10820YcnWMIS6JC7b77WQq6Zn7fYGUKmEmKzQ16ZrLNunJVBcc4uRekjDKrCY822DOJNSksMH4T6n1nqf/wHi8AxXszsnX6SoClMWY8VFBArhb9Tbe7Vim7lmB2MJ7CqZFfIkZ8/Nxg8NKF4JkepmCODZw/DIIdLKTFm2nC/uiPqcCHLlus1+fMwed69RYXrAa9hFkBt1y0kjivHyTq6OMTTyJDMY7XcNeeVJApjDBT6fHWKc2kkBCf/9SSqgnuNJ48Ob1wP6yADNzwzmdjdFNNgF9z61l0r4eolCg/PcDcenSJ1RrgWBULR8uaVOWJcwWR2WEBD49fiV3LuiW8Xjq0l5hamWtV1G95jG5VXmCBHi/22WZcDuRDpHQ4anNJzBSDfYqIMfU6ADZoaatIwadAc/469dmZrHtd2Hi9RbvjL91qoQ3t9hMEu8wL4FsLoXKPpeL2/ED01XSOsj0BkrVuFSx2HR+mncA0ZNLoYXapZvFwx3bYjWH4h+qLyZUt/tNVvfJxcKAiJ//ZgcyHeIuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1E5REJ0SHhuOUxLc0FaemhCenBlY2MxUUxUclMyTm4wNWNuQXg3RVBVL0di?=
 =?utf-8?B?aVZkTjMxTDRjdHd4NlZIbzhhNnVaeFB4MlMvdUsxdE5heWpCMFdPYkczL2lq?=
 =?utf-8?B?emRvWm9reElsMmVNbTRmNzhzTWFQWFpVWldBVmQ0YzdCTTlUNEdOV2I5QUNz?=
 =?utf-8?B?aFdLSGE4aVhicGN3TzY2cFAydXBaZ24xQ3BVdzJjK29RUVVuQ2Z3cm82Q1Mw?=
 =?utf-8?B?bHo5eUsrM0hsZVdNdFVpYzVhaFQ1Tk5CTzQ2UUFOdU1tQjI5aUpzVU9EVXF1?=
 =?utf-8?B?UHJUV2xmcXpEWXNQWERXaFlGTEFManFuNkNzbG85TlhZS1RWZ1ZiZmVkdGFq?=
 =?utf-8?B?aHZaTnRKem1XWnFVUTg4U0t1RVBWald4bU55cWt2S3ZvMVRubkhFbERaVSty?=
 =?utf-8?B?VFZYS1hEWGJ3QlN5VWJ1K1dPQWM5a2JyY0MvdWJPL1hZNzRGM1M4VHlXVDYz?=
 =?utf-8?B?YTM0WU9LK2ZabHJBS0JpemZwSTNyV09QV1RIRGRrRTcyRCt2K1BFMjRLa1hH?=
 =?utf-8?B?RVB4RHRKY1hYYjA2T2RJc3ZodUN0cllsZ1NKaUkzM0V5T003dkJZMGRPdjFF?=
 =?utf-8?B?MW01d09CQ051MTZIZ2ZQS1I0T1dRcUdKWTNCUkdrZzR6SFlYUGVmd0Y1N1Nh?=
 =?utf-8?B?MlJWeEF0ejEzNW1UeHMvUUNTeXZiZXl0bHVCTGlkdWRZQ1pGVjljeXRDZUgy?=
 =?utf-8?B?ejRBMmNlY3dETUJRbS9kQjNYWmRaSmsrdFp2eXkwbjllNTJRUUhjSHFLZ1JU?=
 =?utf-8?B?NVU5bHVRT3dKaVRmNy9YZ0lEbHdqQnFYVGNJaWIyWVU3bm5UYzBWUExEeVR4?=
 =?utf-8?B?Sjk3R2hOSmxtUWkwejJlSVozYnpYL0F3U2NNT3RMODE5Y3ZyNC9SYjUrL281?=
 =?utf-8?B?MzFGMTU1ZzFQajNGL3Avc0dDZnV3eWk1WVhwWldBYjdkYjNsb1NQRkFtYWVS?=
 =?utf-8?B?OWNRRC85UGNiVGQrQTcwTXZ3T0JYRDg3b1YzMVBlQmdiNytSM1VJUHFtOHor?=
 =?utf-8?B?eHJHTTVEeG9ubVFJY3VXYThtS212dnZzTVlYNlBPRk5JL0lZcXNJQ3NJZ3hr?=
 =?utf-8?B?REE2a1IzSWxIbFpMdEEwOTc0VGkyNndWcXlQYUlMaDRqRFgrLzU2Z3Q4QmNW?=
 =?utf-8?B?WnVlK3FxVzlybys2ZjliMW1OYjhVSE5uY2pPQ0VmeVc0Z2l5MWVMSHIyWWs1?=
 =?utf-8?B?NmVKTUUvTmlGTE9MZVFiNk5KVWdmWTRrN0p3ODZpUjhKang5R1dPR3I3K2Fv?=
 =?utf-8?B?UkxYWURyeU5XTDBUZkdQVC9wOTJ5c0hkQUJ1ZmtxWng4d2dhL0F6VXBlSGs4?=
 =?utf-8?B?QU1wS0lIK2NxV0o5ZEdmV25NaFBsNVJSekVpNFFaZDJ5dDdpTUE2Q1ZXb0lO?=
 =?utf-8?B?amNRYzhQNjhhZHJvcFppMEhIRW82N0plMko1QmE1cDk4OHl4Z0R1b3lWWUJE?=
 =?utf-8?B?TXNzUUEvLzlwOVllRGZXcmpNR09qTElqNWsrSkVRV1NWUDZWTUptK0ZpNkE5?=
 =?utf-8?B?akRBRktZcXVIUlNXZXN4dk90Z3NyRDBUQWVaSlNqVGhiVXVkOTRIbUU4UU1s?=
 =?utf-8?B?enRBR3hpeVFhbjUwaHo0c01yVUx3TkswaGhjOWJyeXM1Nm5COE9tSHVtdFVF?=
 =?utf-8?B?UGdXMEl5QUdMWjR2cFdyYS9kRUdlRUNtVXFoamJ0L3lGd1ZRdjhlSHFVanJV?=
 =?utf-8?B?ckhXRzdXRmVMV0ZvTFlKZGRkazllOFp2WGd2TDl0VlZKeWdRczd2NklMdGw5?=
 =?utf-8?B?RDEwQ0FhTk8wNEE3dUxYWWhkWEJCcnNTaXRrSlFJQjRmUlhoQ2FJQnBWVlNI?=
 =?utf-8?B?UGxjaGxZZ1I1RW9uR3lvcmJGaVFlQlhTa1V6K1B3SDVOUG9YalFkc1k5Zkxa?=
 =?utf-8?B?eGRrdHgyeFNlanZNdE1rTmdCcjk1ZFhsYTJrMkNHUFJZTXlCOWZhalc1d3FH?=
 =?utf-8?B?WjJsWVFJQ3dNL3pseGtOME0rMElZWE1uU0NzaEM3aTJrUW9XZ29OS0dwMXlr?=
 =?utf-8?B?Rll1T1VQOFVGaytpbG14MUVhV0NrYkQxMzJacmZXL3JHTmEyL2FQQ05TQVZ3?=
 =?utf-8?B?clMrUDRpejJrbldJYVZHKzNEL3Q3anUwUFlyUXZuT0JCOXM5UTlESHovWUFv?=
 =?utf-8?B?Und0R3YzSmsvekNEZGpNRnZtRDJOYkpXcnJyOE9pWUdRSEl4ODN3ajRkTy9L?=
 =?utf-8?B?QTN4Y3poNUh2RFNscnhDRVVPQTg0RnFpbWZ2dkNFQzFUNjdlSG02dVYwN1p3?=
 =?utf-8?B?RTVkQk5ycjIrems1bVJyV2FLNXhVNTY5ejJYVk53NmpEMlhFMjVJK3VMeFpy?=
 =?utf-8?B?RnRtUkY0aGdZczZXTUhxb1lpb3BqQUVtaEZUU3dJTFNtTUNXdU1iQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70b4af1-dda5-4d67-046e-08de9bd31d7b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 16:13:37.2767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOrqXxiiYckT9luchbr+Tx76nYGQuk36RQOHnwBr9xrZJODUaPg2qhFMaafawnhPm2AsBVrkfp8Yfn92wt8SAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
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
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 01f65d50cbb3..0c0e0402e715 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -765,33 +765,29 @@ fn get_bit_token(&self, token_id: u8) -> Result<BitToken> {
>          BitToken::from_id(self, token_id)
>      }
>  
> -    /// Find the Falcon data pointer structure in the [`PciAtBiosImage`].
> +    /// Find the Falcon data offset from the start of the FWSEC region.

The comment change is incorrect, this subtraction is just for normalizing.
It basically normalizes the pointer wrt the PciAt image.

It is only after the following in the caller that we get the true offset
within the FWSEC.
            offset -= first_fwsec.base.data.len();

I suggest, let us rename falcon_data_offset() to
falcon_normalize_fwsec_offset() and update the comment above.

With these changed, please add:

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks.


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
> @@ -908,15 +904,9 @@ fn setup_falcon_data(
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

