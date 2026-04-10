Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A97F44873
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E6E10E962;
	Fri, 10 Apr 2026 14:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="apk2luYc";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E3E10E962
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN1pPVSKqALQ4cyHIuOX8wlhsVqAK5fmQEJYQUsj68DjRAIjB80lU5DtlNEWHDr7h8udhshZPLRXHNVqQkKOW8fJjcytGwpmEFQ/WTRGzzZh2reLLh6NXxay8y/JL233/oohFHJvR625geOBmvl1nWRyMxl8pUBu3Lhajy/QB4cissntxenNsH6oGxg6wTZz92GJZ+w1wyhtyAHGKAu5WMmZCqz8eE1Y6Ri2Z+TCuoQbB14uebjXIrRy66b0K9fE1O8YYbdrwh9cgMw3hLxW582n+4LCkQz1U1sLofO8xszE5HpEdCbU2EVCCBd14G9nBf5+QNSF6ujVJdQZy3J9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uejLG2N29MxFLyBSLBDat9fjpgH/LzQXOBKngztnrQ=;
 b=aFXSqcErWnrimoqNTVTXVV/3mYWBWoQaHYG8P3hVOjArdtz+rKnd6Yb9iqhJ826g6LSA/d0gH5irDsTDE3WfPtn0bIjY3j4ec7BV/VWfQsBoiT3aU0QeF6+SKJorrRn2pIL90Znuyh6MddK2Oq2RLwQ+oDRFWEc0hOgPVyj/8r4vIDJTJI30M3XnYbX9EQ3DXYMDfXK+dWNHN1Ev3Ar7L9oUR47DOy82MIFN5hGxU5Bij6vDT3xWniAScKiNus///WP+mXOT4t6eLAXaUd32gDYYwkohlWA3qaJzlTm5/vERfRsyJ0wVFo87OX1VeKmwvOzw9NBfKW1kh2P5NjPPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uejLG2N29MxFLyBSLBDat9fjpgH/LzQXOBKngztnrQ=;
 b=apk2luYcLromQymnu0yk0qpGjb15L+wf31/HuMeZZhsSAVjfGrBHwxMrwH6G1zfxjviW5y70OjP11Qw30ZIBVKFs539VqdH+HtcfiN/ZbffOGcFFREzto6xdAtp3xxrEBhMIVwTXFhFh+kr9VClHIGMlZM5/HnGuGp0KNIa3xVYfb6eWVkrgTqsCYZPiFPk5YxFzRNfsZANA6iU+VFMVZiwIxIJYM5KWUl89RnAjxslbSwUJPoFWGwyt3brCpBHddSx4j3+tV5UYRifmhPtnobTjiqX9+svW670xv4Wo9aPew1TyiCm7aCghgfLiVVr+XxFhY8AoXTDtc1MQvc7Gng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.34; Fri, 10 Apr 2026 14:08:48 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Fri, 10 Apr 2026
 14:08:48 +0000
Message-ID: <b90e1cb3-d6de-41fc-98e6-0e744666069b@nvidia.com>
Date: Fri, 10 Apr 2026 10:08:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] gpu: nova-core: vbios: fix various cases of reading
 past `BIOS_MAX_SCAN_LEN`
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
 <20260410-fix-vbios-v1-1-bc6f71d153d6@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260410-fix-vbios-v1-1-bc6f71d153d6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:208:329::30) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: a341dce5-7415-44bb-1697-08de970aaf3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: V00+sjFj5pdrOZt/YX/shl7L/s8kbbw3Z9GvA2C9zd53rlg9C2+ehcWK9q+0EVNTbZDHOyT5Qv4w8NTqa3HzPslnDb31ENBluy2UJaiSivjPRV6qY6N6eiZoAfT11Qi7S8C5nJ5mBSSuznJYAsOmST6ws42zrYFz9NKjxj3hCQsBBpe2AtR38UqoKiByxLFqADmG1KvfLzGG+9zynKJtIdhINle6X3f9/GMGMFsrlmqDpizbR31RVvKq9n/dkIy9/iGq/3g1yUqptVQqMGFIgLfQE4V9AoDVHGBbxRtWR0U5JNuNIktrsijDrLuAc82fMLrIBn0ORSXO/H0tv/BCDcTwY3FYD0/q4XBt6mK0caesImh6Jkwx44GfZ94VFEqikK70RSRFa9Wz9GdbeF8zMRVi1BPZs3MBNz7wRgPOBtRCr6ZIyIVeE6i/VrnTdhE4v0u2fxaU0sp7v+QRqD/Z9PzH8RLgOs9VaDFOOvZ26Z2TXKA2wozB8SU6ftwprqZauH2PBBDrSAespYZsKDA1n8XuypZZ4Jxzk+YzNFvx0OcxCHLfDj3YABbOVfdTEo+dm9gCsUO1oz8rbpWCn57MOEBwRAHkMeJ5xFZ36S2vsaaJGI8KltI25svLFVE49CpIDInIgjjzIoGjGEnxYGy+pxIdfCv6i1m9+3MeDCWv8qkJmuirI/G3jYm1+NH66fgAujDjKhUgudAgzK4KurvTspT/IhktKbEIoJg17o+enN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFJXVzQ2V2ZzVFZuWDYvTWw0RU1Mbk8wODg1aFVlOW15bkdkS3lTSUpqdkdE?=
 =?utf-8?B?OHVLN3FlTnpaRUJiZjJnWHNDckFpYzRwc3QvRnFZaWpJajJQZExXRFB2dDN6?=
 =?utf-8?B?djZJMmpFUjBzUEZCTDZHMTFJVGdkSzh3Nk1FMCtoR2tsTTloc2E3NEZvNmZP?=
 =?utf-8?B?NFlZZ1ptSTJVbFREK3RDTWdQeWlDU0lpcWFvNU1paHNyTkM2aW5IU2xsN3Zt?=
 =?utf-8?B?eEdHU3FHbjZyYXBKV0E5YUxJREVNS0t6THNGREo4cHJqOTZ0ODI5TGUyREc1?=
 =?utf-8?B?TGY1U0hBVGF0Um03SEFFak9EdlRRdHpoTGdzblZYTHUyRjc3RmphMFFiK3dl?=
 =?utf-8?B?QUtVZElEcXJLSjJXSStnTHhXaGFsb1Q4RjRCZy9pSWlISHI3WVUvUHNCOWpO?=
 =?utf-8?B?NEduSDNER1pOTXZYaHJNRW9kR1hnRDducUdTTnkrajUwbDRCV2dzUER5Tko0?=
 =?utf-8?B?TDVZQ0tWUWdhNmVOMVppaXlOVHBJZ3JpcURmQm5FTW14SGh5N200K2dicjMz?=
 =?utf-8?B?NGRzb1lvSExvSjFRdGVSTWlocVRHcHBXSUFEREF2UWhqSUJBTlpHM2lFdWEw?=
 =?utf-8?B?MW5HR3IraGE5V0F2SFRvSXZlR0xJQldrTmZKNW5ObVpyd3BLczhNVytRVHhX?=
 =?utf-8?B?VXZDOCtXR0FTbWxrbFdzS2lJNVM4SjRJT0YyK0NMcC9Ccld1em5sTUhDSU16?=
 =?utf-8?B?NlpKUEdWUnY4K3dEYUNhTnF1d3I1SzVsSUFEcXhkTHRkOTYwTGdqSUpZejNv?=
 =?utf-8?B?RTJLYXBqQjhFUVlJSWlvUXdWZ3JOY3R2SG92cGhTQlNRZUgvRlM2S2NVaTNo?=
 =?utf-8?B?cGw3Y3ZNWExvR1I1Z25CLzhEajhLWWxTa1MrUGdJaERUTi9YcEpyTC9WRWc4?=
 =?utf-8?B?b2pGWWswcVB0RnhXS3lnRm9jQUhqWkk1K0xIVGZuVG1iUVJncnpBMEoxdEY5?=
 =?utf-8?B?cThZcjRNR2hMTytxMlJGWmZnK3NBbVpWbGgwZU5vTFAyTHZDY0pjbG4wNXB6?=
 =?utf-8?B?b3lYQ1lseGhuaGdZbmMybkJqaXRsaSt3ZzdpU0ZUbmR3UDM3dFZTUU1kZ2cz?=
 =?utf-8?B?NjBOZngzQ0JlWEZaY0hLNFlUbkt3Rmk5MUZqUDhwM2JhWVVHbjNRYkY4MHEw?=
 =?utf-8?B?bEpmRVRCNkh4QkxhaEEyR0g1NGt4bFA4NzlRK0xmMHJMMDhhMUUram95UlpZ?=
 =?utf-8?B?NnlJTmdIK1hYRHhYaXNjSGJ3T0NudWMrTFEwdW9SK3VtVWFXVklYeU5Namxi?=
 =?utf-8?B?RVNhQ0huZ3N1dEN1aDcyR0x4MS9WRXFROHpQMVk0NEtRanZUcnBlcXd5empI?=
 =?utf-8?B?UEh0clh0bFVmWm9TS0VpUWRJaXRmMU1aZGRBZzRrWFkyUkRYeVVub2VpZHRS?=
 =?utf-8?B?NkVMZnd0RnNESEtDQUhQNGNFQ3JPMFVJVHYzZThTeU5zYWZoNitFRnc0OExI?=
 =?utf-8?B?Y1dnRmU3QW1SdzZ5L3ZOaVdhMU9hM1VHMTBaakwzSXMxMnB4TDREa0pvTHhs?=
 =?utf-8?B?RGMxbGFqYm1oYnQ5Z2RQZENwTU1LTlJ2NE9xeTl0bWFORXYyZWJkdzhkRVpB?=
 =?utf-8?B?NmpJL1lnWjhkQk9XSE1oTVJMTTh4ZkJvZFh2VEVicmZ1d1hoU2ZubHRrc1dB?=
 =?utf-8?B?ajNyaHFPdmVIQmllNlo2WkxpRyt0Zm5HNnd2YnQ5cEhQWVQyc05IQWZRUzFY?=
 =?utf-8?B?UXNOcjVZMlZXQkNxdERueVV2MmR4WnFTRllCR1RjdlpUcXRhWEl1NUhPVXMw?=
 =?utf-8?B?YzMwS3FkMFZsdFpMV3BMZEhYc1FwRVd0Uy9UQ1RQdWU4dzRKSFZEOFVSU291?=
 =?utf-8?B?QlVlVk1WblhjVjYyRnZuOTBsUWRSOGdiU2lFK2ZLL0R4YjNEYjJ2dDgyY1o3?=
 =?utf-8?B?cVVsamRDd2paQ3Urb0Zhd1ZzSnlqZWx6UHh6Unh1RVIweDREaEFkVDlPWldv?=
 =?utf-8?B?TmpFd1l5cnZxd2hNRXRMYmt3MW03SG1pUjNMZW5PS3FCMFJTK3gzRDB0dE5z?=
 =?utf-8?B?cU9tSy9nQUFaQWVhRE1UYXlXeXp1NS9WbnRwS1N3Vnl4YTIrZjBGVTZVeFpz?=
 =?utf-8?B?VWFSQWdhdUhpMnFLNjJDTnp2U0owS1N6RTh1MWRyNENpZFpTWGZ5VEl4RXpY?=
 =?utf-8?B?ekE3TnhPR1RpWjNFQW8xZnJUdUQ1aHlSZnZBcU4wWGEyMStnVGo2VGxBUXJQ?=
 =?utf-8?B?WFJXd3l6UTdIQ25CY1A0SCs5MWxFMThvWTFZYzRqTmtUVWE3QTlkUGowRGtB?=
 =?utf-8?B?T0ZSQXhNcVNFRFZDdUVtTTZwVnk5dDlMa1V4UkdjcFJkZXZ1bVFtRjMyS2xs?=
 =?utf-8?B?US9IRC83TURvK2Q3SGQ2RUtqaURmZlJPdXpZM054NGNwK2FXcmRoUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a341dce5-7415-44bb-1697-08de970aaf3a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 14:08:48.1532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50OLmh5PHuozOFHkfvdEWmlgMj+bWHhmJWw1CMDyPeHxF1w6G3UwSsywgELVKuq5ajUH3hROr+ZiLARun0jXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
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



On 4/10/2026 4:38 AM, Eliot Courtney wrote:
> Fix various cases that allow reading past `BIOS_MAX_SCAN_LEN` when
> scanning the VBIOS.
> 
> Fix bug where `read_more_at_offset` would unnecessarily read more data.
> This happens when the window to read has some part cached and some part
> not. It would read `len` bytes instead of just the uncached portion,
> which could read past `BIOS_MAX_SCAN_LEN`.
> 
> Also add more checked arithmetic to catch potential overflows.
> `read_bios_image_at_offset` is called with a length from the VBIOS
> header, so we should be more defensive here.
> 
> Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index ebda28e596c5..6de7e58e0da0 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -132,17 +132,14 @@ fn read_more(&mut self, len: usize) -> Result {
>  
>      /// Read bytes at a specific offset, filling any gap.
>      fn read_more_at_offset(&mut self, offset: usize, len: usize) -> Result {
> -        if offset > BIOS_MAX_SCAN_LEN {
> +        let end = offset.checked_add(len).ok_or(EINVAL)?;
> +
> +        if end > BIOS_MAX_SCAN_LEN {
>              dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
>              return Err(EINVAL);
>          }
>  
> -        // If `offset` is beyond current data size, fill the gap first.
> -        let current_len = self.data.len();
> -        let gap_bytes = offset.saturating_sub(current_len);
> -
> -        // Now read the requested bytes at the offset.
> -        self.read_more(gap_bytes + len)
> +        self.read_more(end.saturating_sub(self.data.len()))
>      }
>  
>      /// Read a BIOS image at a specific offset and create a [`BiosImage`] from it.
> @@ -155,8 +152,9 @@ fn read_bios_image_at_offset(
>          len: usize,
>          context: &str,
>      ) -> Result<BiosImage> {
> +        let end = offset.checked_add(len).ok_or(EINVAL)?;
>          let data_len = self.data.len();
> -        if offset + len > data_len {
> +        if end > data_len {
>              self.read_more_at_offset(offset, len).inspect_err(|e| {
>                  dev_err!(
>                      self.dev,
> @@ -167,7 +165,7 @@ fn read_bios_image_at_offset(
>              })?;
>          }
>  
> -        BiosImage::new(self.dev, &self.data[offset..offset + len]).inspect_err(|err| {
> +        BiosImage::new(self.dev, &self.data[offset..end]).inspect_err(|err| {
>              dev_err!(
>                  self.dev,
>                  "Failed to {} at offset {:#x}: {:?}\n",
> @@ -189,7 +187,7 @@ fn next(&mut self) -> Option<Self::Item> {
>              return None;
>          }
>  
> -        if self.current_offset > BIOS_MAX_SCAN_LEN {
> +        if self.current_offset >= BIOS_MAX_SCAN_LEN {
>              dev_err!(self.dev, "Error: exceeded BIOS scan limit, stopping scan\n");
>              return None;
>          }
Very nice!

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

--
Joel Fernandes

