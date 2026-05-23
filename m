Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199E5CD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFA810E2CE;
	Sat, 23 May 2026 02:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uBkEE7eR";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD4310E2CE
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNwhXohTkRILUmef/ea5Sc8MBeYWo5FZeRWenpdOaRQ+97PTttOD0HlZJ9aExJcSjCQyUabuUCA87Jox9cZmO7atq5+aH/Rj3Pya1fLnAXLRMW4oGMwX3xNpbAtLNtITgPi8RsLga8YL3ST8hqofXS6kkOU5khgaXeHqo5JwjnlaAniWVmwCIVAMAFCavo5ka7RaDFrM/4KXr4TWUPry3y3HHqU2ofTE3w79HkrOpLW1SMumFam5ylIwcEnMXkwfAJagQn96NFS1/ByOyqxLymiovRX0cbjEOru/qcUt2hwRBRWrQVWuSaUabuW4I92tAR+zZZNjEMTr3aCZ2xm2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjHohfuwvlWF5eCKmwQueIMPUyjbjW1RFFGvwfh2Ff0=;
 b=CPbCDf3UWGZi8tS/ZMmY7n/j9acdZNEThd37cesdpfeTCoaoJnX50qeA2+5WddP7REhEnTNwdvzRKujYxeR1Pr6IKV5kodQq7SYbJwLyGpY5K4gxHdAPeTxEwtUFP0+CFsjcyNK2f2WqLypmkn/3uq9V3/MpXPQBfH74nszdVIwnZwM7R7vvWqNhjgu47QfVq2cWWZRKZaSAfPrJg+F4OHvV8Wtc+orye0jz5brdod0TWd8HTvEeNtag+c6kz8ScuQP/a7+QsX+Of1LNcqd0QiUN+OMikbYjwLchL/bzBBiJgkM9EXGT/hCqrry+IEKsqq84Bc86eQqelaU9fRYy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjHohfuwvlWF5eCKmwQueIMPUyjbjW1RFFGvwfh2Ff0=;
 b=uBkEE7eRU5hdYCMn7LEqBfG+GO7BLqG2nu5kEDI+g3XM9H9rbGZ7+QUP9Srj2Su/BfniXSEmv0Y+S4sJ5NC32HITTAWWsfg2hzfVh2oM1eX87mI4JjaCWjlXP+A1WeS4JKsUPIKkHpKREWzlb934V62u6ye9NH9Y/ZMInkCwBt8uLM48uP+4AoM3yYoWJUYJ1nD5AGAcuqCfdkbuwJrFlhruJs6KQ8KMLhL2i3oqgrdPM0q+WNlrqR55yFGHT/Y4qUPn+94V4W5XLVojRqR4GAkrATVXEjodhxhlhzOqU69fiSQj27ZIuX9xK8roP/zGyOZIn6cpOOCHfBJ2pchqjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 02:48:07 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:48:07 +0000
Message-ID: <ce24670d-1630-4266-8e3f-0b504857dc3e@nvidia.com>
Date: Fri, 22 May 2026 19:48:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/20] gpu: nova-core: vbios: avoid reading too far in
 read_more_at_offset
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-3-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-3-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::16) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed57477-b7db-4c7f-37ad-08deb875b831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 61/eq8mwy80N4Bb6jIf9Y0xlzNQm8pW2oZdHJc71WYuZQk3trR1qY6vfrIpKJs99eKzymIT1pYGeuBmViATfgEbLAXqRKvn6CLCXDzMm967GmvC0EFuGRSuN0tI8JeO7mmDYUei/9keo3QLeypeBkmx2hsnslOi8Tkx4dh4wwj443BW1j1MUMyiLnrx1aVI/5DmEbRHscupyVbkMruO/YweBAFOCPGihjdNv5Y+V5NkRkugnR67Fu9x8nDhPM5wxYKd1TRAkv51R2bJX7DPC4UOeKagVsw5JLQvbJRFMugOgObOJ3AGXRkqRmXXhOHdyaDf4inMZShZZNhIuh2GO16YEDuuRwBobflj9QODj4mEWwWy5XbWTnot8XlQVfeWHbLaGeAuNvYp4HAUapR7rTTYucycHrkWDEUisGgV5AonrL/cK5pPpG6cfYcu+n2xGV6ls2Kesq1s9P6wFNPNDjLtudHGvVcHQa1h3ww/fLRjlBhCOM79QsN/hYmeu7ukbCJ+LYnGfEB5yzjsDTQeVcN8JLh41z1uzt8I9ajkwDIccDVHRocgifhPnTMDc/Z9lWLjzkdgk9JBFu5um0X0MNhjuJ4pU4nhHb5J1gLevthCoPVrDJs5Li55xlOzlZFLQzFTxba0yHykce3cWsb03SUkL8B9Z5eLtmjjYWvJJSAK+PE3mvF39zRiYoR7HJdTm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STF6R1BTeHhjN3pQTEdyaDE5Ym1hQmI3TXVwODZIWnpUVW40ZUhHa0dzbWk2?=
 =?utf-8?B?Q3Y3eUY4ZDROMzAwVWtPTzlFMFk2UUFnMEJnNCtjQkVodi82Y0wzVFZCSERl?=
 =?utf-8?B?N25oMzNQSSs4Z1Z0aFF1Y1dCZS9BVTF0c1RNT0wyNUJWVWV0QWJKWERzTDhw?=
 =?utf-8?B?cE4zMVJrU2xzUW5iTUYxZjVMQmQwYWY3SFNzK2tmWHo4NWh0QkVYRE42WHFY?=
 =?utf-8?B?ZjdJellFTW40YzFrQkdubWI5Z2lEbjBWSU0wRWpzTTMxdjgzQkE2azZjdEE1?=
 =?utf-8?B?cGt0YVVoMkd1c040cnBJbElRSnZZUUNKYzM5aGpwNUJoblFIOUhUbTVBUDFO?=
 =?utf-8?B?a2tRdHRKOVdyeWhhdmpjRjgwaFlLSE1KS2Fxa3NaQ1VMZjJ4UXk3N3pNV2Jj?=
 =?utf-8?B?K1QrZFlQVVVNT3piUzBqOWVsUnI4b1RRbzZNTmhsU1lOSXNsTnBsWldTYTZD?=
 =?utf-8?B?Rm1STXh3YzRvNFdkZG0xV1YybEpuT1FwSFdGOU9VNjBZOTlLY2lGbTR3dXN2?=
 =?utf-8?B?aDBXT1hVK1JpR3VaYjU4SHV3ZWJJTThmZTZEQi9Mdzc3ODg4RXl6ajV0aXFZ?=
 =?utf-8?B?Y01DMzJyK0pRUjY3cHJyMHNXbVZSNU5iTjV3RS9OOFBkT211L3R2MzU1SjNI?=
 =?utf-8?B?R3ltS0lxMUdTUmdtRWJwa21QekJwTUJ6dHZ4MGcvYWsvSTVRL3NMWDk0Q0Iw?=
 =?utf-8?B?RnFXd3k2ak1XYnQyUUxNeHI5WTNjejFZZG5wWEh4WDVHOFJHbEgvcGVFRjNm?=
 =?utf-8?B?TkxrdVhRU3lhTmQwMHdCbXNLK2VOcnJGQjRBdWRQb1ovWjFSMFBXSy9HMVIy?=
 =?utf-8?B?N2x0TUJTVGdjRnFyMVBISGN4dTBUTU12T1VIQk5ESHRWVHdmVlo5TFBiV3NO?=
 =?utf-8?B?QU1MWmRZOStBT0pQUi81ZDlsUTd2Zi9xZmF2NTIveXhxVno5YzNEeklqMFp5?=
 =?utf-8?B?aHNZeGFEWVFhci9GOTJjS01SWmJRZ1R4TktmZ3NrU3gwZnczQVFTOFpBMHBH?=
 =?utf-8?B?eklvWWI1VEVHb0pBS0pHZTVLWHV3cUROeUZFYTgvd1hJcGNDbmRDdEtpY3h0?=
 =?utf-8?B?eEZJODMxcWYrSFJiQlBNWW9vcGhseEJLZ0lscjBvVEhRTlZCc1hmb0EvNlVW?=
 =?utf-8?B?M2dBb2JVenkxYlJCczZ0VkZOejI3L3NwWDFLSExuOTVzaDRGL1JqZ0RPdkNT?=
 =?utf-8?B?NENOSkNjeGl1bVVqU3FrbityOFR3Uy9HSHdDZ1pxRjJMcEZacDd6dGtoSGpm?=
 =?utf-8?B?YWtUMVg1d09ySG00UHFycUJEYlpqMFdsL0lJbzJLRnFBN3VXZ0M2NDU1Snky?=
 =?utf-8?B?blE3ZjdJdmNFemtTVzA3bnlxeUU1bkFjSG5HTWl2MmhkVWhSS1ZXcXU4U3dJ?=
 =?utf-8?B?TUVJTldtNjZWUnFLeERrckR6ZlR4SUlwOEZodDU1ZFJQOTdSamdnRWpmOFJ0?=
 =?utf-8?B?UTlDYUVnRmM4QUJTMVc4REhJSGtjUmJtM1JsdmpWNDZZQzh0ZHRwckRwOGxw?=
 =?utf-8?B?Kys2Uzc1Q3RFZjhHaytqYnlFSGVScjBMY1BINTZlK0hCUktDeWZVRDg3QlBi?=
 =?utf-8?B?cFVETDV1Vmo4aFl2Q2N2Q01rYm1wejQ4N0ExUEwveWNna3cxWDVpMUl6WFBP?=
 =?utf-8?B?c3kzbnFTNUltM2gzZEpEWTZ6VDE5MUdkaXlXT2ZsbUVKUHNjMnR3dlIxeE9Y?=
 =?utf-8?B?NUc5OUdtRzNLNjlvQjVFU29zTDFwNHdNbExwemVmTkkzbm82VTBzN3hhQkNV?=
 =?utf-8?B?ZWJIQnF5VmpoaExYdDlxZlV0eEtZT21OcVMya1dqZGg1TjBQVDJSVEV6YXpl?=
 =?utf-8?B?eG1qaXJYN3R0SjdtSE5VZGpnc2NHRGRtM2ZtZ1dmcHc2aXFybW9mbGMvTjRo?=
 =?utf-8?B?elhoQjJtc3NXVUlTckkwQnF1Qk42bUZzdnJuL2VFbk01S2FJK2wrbkhFeUpv?=
 =?utf-8?B?dDkwUXM2ZkJJL1ZvanlGSnowVkQzb1Q2RDFZR3MyQTFubnN5N3VyS3lEMk43?=
 =?utf-8?B?QTQrYUE4aGtOaDFZWWFtdFJkL1hKRmFiays3N2pkMlhySllKUVQ2Y29ObG5L?=
 =?utf-8?B?bXpzNlo1N1N3M0sySU5kRWhkcTN4ZUprRUhFRjZWSkNYZS9lYkZ3SW8ycVQx?=
 =?utf-8?B?RnFwMGE1N2JJUmhzQVlVbDFka2Vad2dObE5POE1NbnRidkpSYjg4TzgzeVpW?=
 =?utf-8?B?QWViWE1hQW5ZUkF1ZFB5NGl1SVh5VWtBYldRbWYvMDZKT2EzK2ZXeWlmREpB?=
 =?utf-8?B?aXI5akJwT1QrZURuWHhybDBGdVloTnl4Z0lmaWdNN0NjNXNhSDdoMzZpUU5i?=
 =?utf-8?B?R3lpU2k1Ymw1RWtRVkhZK25BL0Z4TWJMRUtmUTZVNW9mM0toRUVXdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed57477-b7db-4c7f-37ad-08deb875b831
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:48:07.5541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5o1iC7oLvzYsC80ZEEgPoHdag5LJKUExSxBoklJI7QJshZieTZU+llImnYEsjZlbewGjshjLvybeNEV2MhG+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
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

On 5/18/26 7:54 PM, Eliot Courtney wrote:
> Fix bug where `read_more_at_offset` would unnecessarily read more data.
> This happens when the window to read has some part cached and some part
> not. It would read `len` bytes instead of just the uncached portion,
> which could read past `BIOS_MAX_SCAN_LEN`.
> 
> Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 180928433766..79eb01dabc6f 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -185,8 +185,13 @@ fn new(dev: &'a device::Device, bar0: &'a Bar0) -> Result<Self> {
>  
>      /// Read bytes from the ROM at the current end of the data vector.
>      fn read_more(&mut self, len: usize) -> Result {
> -        let current_len = self.data.len();
> -        let start = ROM_OFFSET + current_len;
> +        let start = self.data.len();
> +        let end = start + len;
> +
> +        if end > BIOS_MAX_SCAN_LEN {
> +            dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
> +            return Err(EINVAL);
> +        }
>  
>          // Ensure length is a multiple of 4 for 32-bit reads
>          if len % core::mem::size_of::<u32>() != 0 {
> @@ -200,9 +205,9 @@ fn read_more(&mut self, len: usize) -> Result {
>  
>          self.data.reserve(len, GFP_KERNEL)?;
>          // Read ROM data bytes and push directly to `data`.
> -        for addr in (start..start + len).step_by(core::mem::size_of::<u32>()) {
> +        for addr in (start..end).step_by(core::mem::size_of::<u32>()) {
>              // Read 32-bit word from the VBIOS ROM
> -            let word = self.bar0.try_read32(addr)?;
> +            let word = self.bar0.try_read32(ROM_OFFSET + addr)?;
>  
>              // Convert the `u32` to a 4 byte array and push each byte.
>              word.to_ne_bytes()
> @@ -215,17 +220,9 @@ fn read_more(&mut self, len: usize) -> Result {
>  
>      /// Read bytes at a specific offset, filling any gap.
>      fn read_more_at_offset(&mut self, offset: usize, len: usize) -> Result {
> -        if offset > BIOS_MAX_SCAN_LEN {
> -            dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
> -            return Err(EINVAL);
> -        }
> +        let end = offset.checked_add(len).ok_or(EINVAL)?;
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
> 

