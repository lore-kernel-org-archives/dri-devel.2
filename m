Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B075CD5BB1
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 03:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA41610F74C;
	Sat, 23 May 2026 03:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="W6EDtdl8";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC58310F74C
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 03:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNdx6Kc5BDPOOveK3qPypOc81y/gSez5kruB2FX9QTj5vzhMpc+M+dM4Bs/9WdtwmQ8csMQs3jgNAOnPXcL/CjJaZFoKq41HsLXefj1MwUfrGaE7Vq27H/3CdHrDMUmEWbsfkZ2fwBfsnS2jqIUNd/4rZWfakipoyg13dIq7+emlQ4abFnlVMoQm0prTZjx0eDkn07xnUlv3MswRMnkzXKRR5gYV00DucjruDRxPtAoJHp+90o13cQB+DuVNi0nRo3GLs1io8aCiSYkR+wDLV73hkLxoKTQtBssmx2coyZ/jN+XsQqpb7Boq89SvDxQrSyUmkTy04UBVnLWBRTFNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hG69HPeY7Ulafi9Isz0dvij9M2QPj1UZKRg/9iaNPg=;
 b=cy67YBAHmSFxEBpXKhBobXLM8JofRaWiPwmDpKzW+n/6s5mELXBJggaLQ6h4wiKHgV86/9Fww4jXC9B95PRAp24fuVjeGGn1ICdnMHYO9cZrWp1OYKUQcJhrD/u/yFwm29jFvHTOy4rpiGaCQna6uqvtYWM3IyCDKq54Uj3RkVbqr0jx++C/v4sF20ktol1sCxrbiqhwaRcG4rKWFq8F1NIhU+aWx3rxYmxkQNRuAWT8twtipfQT1L1SNhCTqaGSPsPf8zGK12SvTfkuuaAjQpA4pQhv8zZL29B/fOLt8yP/Kchgss1qATCii0hlKPpEBFeSuY5xjWxRQSv8+FhQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hG69HPeY7Ulafi9Isz0dvij9M2QPj1UZKRg/9iaNPg=;
 b=W6EDtdl8yl7V4jgEnTb2pLcBWarVSnTlu/m45LnWxs95THWsTKhJa3GPE6eXCupWdDgiatFWWJe/wO6kusqC9WHWF0tr/ZKB+SY0oqpJv+w2J9w4Q0zeUxPYl4S0wzerWA9qR1d+y4kFgRZ0+9FXv8308Sk7WHPBy4cgzmSkymsTevjVRtcOp7fq4aosdGye073X6r7AJ8nXa4dB97Usynk1TlXQbGZs45UdCm9rELlGNKOagz8IPYckd+jEKuREBRdMayvQ/XZp5DsSV5JWNuSri+fYinqvt39q+BNj285KFqoTB+ufPHLPaBPFeynb7pF7/5GB9zagM6lcso3qnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Sat, 23 May 2026 03:05:46 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 03:05:46 +0000
Message-ID: <f93061f5-a7ea-4e30-a1ac-2883bcbda53b@nvidia.com>
Date: Fri, 22 May 2026 20:05:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/20] gpu: nova-core: vbios: remove unnecessary fields
 in PciRomHeader
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-17-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-17-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f6fed6-4003-41ee-c40e-08deb8782f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: kwp7pciwomck4M61oBgBjyC5tqM7Ojl3tFnnAWFUe9dEKsznJKqrYMYFo5mMMaOO0xlFULZKojNqJDsG3bqJYdYVHIh0KIcS9ZDk1NGHm6ZRuxXj0xrF8nMG54eFnSpV+shGjedw+QCTNyOvGl5dr20SbGc7kiYtjJIXSjSM7rzRePmiMoDRwOVrWMUcnt2TYg0jwwscEbXWk/PVn2Jn0vsoILdZyJvLbsHu/ZrQWO+2LpZXVevbOJnaPEkYjg6+ymcC9fABlveo0K7JCEeE/BDWRTPsJFNVUIuO74TIxmKs2EtZegHBU1UPvkgIq/Kqcbk0WDIwwg/D4WOHccXKdtzXXdO6RO+3uh3Y1eyASo/jOGN1Qa0xtzg3m3p6RRdV2jgEj8jQOwb12CwglYuPUEjR+iewvsPgFjdexYBcWb9DmDcATnwf9GShIk8c980TM+MHhK3tCw9dE0z4ZRy5NKQuJqWfxNr18DXJkmQTNqGYLhxZRh1eRgz9s3hdvaXEFfSr0NbKnhtUxMP+A0ZPkWiCay5Sw8eBWKU2gTgzSGtGI9lCF1uXYYDqy+qAIQSt+RZd9/1y65cZ1x4IHpVZlV0NlKW3vYG/fe7+nBP2mpuMDnRl0G8UPGOl5MbL7JsOzqDivsV3dKYwC9wpbDx9cFs2DXNoWHNPZ27w1oHcYyuDuHMFNc+JiolXw9lxpoIB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(6133799003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEtqb213aFVEeEdDb3M5TXVPVGcxL3BPb3hZeFBHL3JpZzkwM1JkTWZnLzZS?=
 =?utf-8?B?SjVIOTRtZHdzRWo0ckVla3N0Z1JXNzNNSnNZZjU0dXN5djNybFE2RURRcXkr?=
 =?utf-8?B?TytjN3F3ZWQ1YitDYTFzM0xCZHV3ZE1POVNaWGV1bTNsc2w1cFNMRWoyT1c1?=
 =?utf-8?B?RlVFSmhTaDhPTzE2cHl2YlN2ZUsvRlZkcGQzOWdlNkVVd0tEN0lQNUFJNGdR?=
 =?utf-8?B?WDQyWStxdWtYZHg5WUxaSGZjd1dsSkNQZVVGNVo5RFNvTFRNNGNHa29yUEJm?=
 =?utf-8?B?TVRYYzVnYkJySWVZRlRzNVRDVmNaRXNUcnUwVUNkb3c1dERZUmR4UThkTGVF?=
 =?utf-8?B?VzA4ak1ROE0rekhyREpYandVNGdhWE1kOXZFM3pRYW9GYXdhT3AvYWY2eVJv?=
 =?utf-8?B?RnR5NnAyRzRtdXFVOTNoVUpPRGN0SC95ajN3S0ltTEhVRDBxZzFqK2srejk0?=
 =?utf-8?B?WkhNSEpCbEFuNitxQnkzTlRXc1FWamRoOTMzVnpYdThJL1h1MkNsbyt1TS9p?=
 =?utf-8?B?dWMyQWRiMWNsN0JzNkFNcUt3Q3BFcTg1ZTE0dElPSStXRTlLd1pWZHd4OWRQ?=
 =?utf-8?B?NTVreXpLejY5K3h6WDBiWmRiWVZWZzhLZFZXV1dMK2IySzJJMDVyQWJuemYr?=
 =?utf-8?B?OWVqUk0rZkhuTWo3Vmt6THdXR0FWa3lraklHYzB6ZHNLdnpGZWp6aFhEWWNM?=
 =?utf-8?B?dFQ5VE4ya3B1Y2RwRVc4Vll6ZG9rSDI0SFdXUHJlTmZsTEhhNEc4LzRXVXpu?=
 =?utf-8?B?NzNCc2ZQQm9Qb3ZWamdlcElTTHQ3cVZ2bHVYdTA5eVp0Q29nb0xlM3pRcGIx?=
 =?utf-8?B?Y1NtNFFZMnNiYjFIaTVTNDNKQUxrcEhPRnBQQjBZVi8zejRxZTZSSlltd3RM?=
 =?utf-8?B?OTdHejYrYnZVM0xGZDloL05yc3BwNzFIZXhmQWlNODFkVWZrQjdQaHcvMmpJ?=
 =?utf-8?B?RFFXbVdVTXVMZE1POFRoQS9MTTJKVlk4SGtjcVR5WTByVUF6M3JhTXE4Q3Jj?=
 =?utf-8?B?MFpVN3ZOM2pGM3VMaFdGcHdvd2FSLzNjWktmYnArY0ZFM0p2ZjBHb092b0Nh?=
 =?utf-8?B?Q1FlKzA3T3ZoS2RkVnNVaFBCU1FJTE14TzJyWk1XM04xWm1jUFdHZTl4U1B6?=
 =?utf-8?B?OWdXU1Jid3YzS3dVTENITGJHVXltY0luZDNDUlhxNFlzYjc3TGp6TWk1Wllq?=
 =?utf-8?B?d3FxYXAzVEJKREhQdlYyT2l3akpEQ2xEWGZGUEJDTVl0WE9DZVpMUjZtTXF3?=
 =?utf-8?B?ZzdzcEo2SmNQT3Z2Rk1hZXVlenJhbXErVlhFL1NNa29oOXprci9LSW5ReTFN?=
 =?utf-8?B?WCtHSlFyanNvbUJKZldUVDBwTzBDMmVTQTdVNlNwMCt5dGZMaG9GNVpqekE2?=
 =?utf-8?B?SjVESVo0WU1YQ3dpbEdvcVdYS0FhNWNsNmluU1ZGaWZ3dVkvc3grNzZOUUN5?=
 =?utf-8?B?N29uOU5ldWJmeTg4SDlyTFFXcm9PckxQajd6aENMUEJ3NlM0eUlZWXBRUlUr?=
 =?utf-8?B?RHFWTHZ1RG9yQit3RnNKMHNKYUtteEpjMXhNbnh1MTBlZlVuYVRUcWtwRXZs?=
 =?utf-8?B?cDkrbUt1SjF0NVB5ekxkUlk3VUtldWpQRitncFUxa2x3dlhsNjB5THYvVmJv?=
 =?utf-8?B?NGhoQnM2U1V3RnE1am1ScEdQOFFsTWFJcFZpWFJDMmkxbnZJdTZUTTJRUXMx?=
 =?utf-8?B?K2VOUVN6SE5NSG91YVRJVi93dnR6NlVSbktzeWxpUWQ3ZmFFUWlwTWp5bkVH?=
 =?utf-8?B?MHJxYi9RS3NlOVdxZ1dwdEVRSHU1d2R3ZGZyUlYxNlJjSUhhM0ZYUXJZWml0?=
 =?utf-8?B?RDlCZTFMdUtlbTlnZVFBRXVSc1M2VkdpeExjSStnZVdXa1NiRmE2VnNWZWVI?=
 =?utf-8?B?TVNCb0h2bG9VbjVoTzVjR1FEd3lvWmVheUpEeSs2VDQ3NUIxUC9KRjlBbU92?=
 =?utf-8?B?MTUyQ25NeklrVXVJMlBIU1ljbjdtUUJyR2ZGMGczZEw0SXlWdXhVNFpEb3Bp?=
 =?utf-8?B?S200UjlQNjg3VmwzWDBvVW5ISXdqczVWRkJ0bURTS0FyT3R2KzUrTThXNnVD?=
 =?utf-8?B?SjdvVjE2OVYyYUxHYmJGNkQyQkx2SzYrcGhpY2llZW1NTVZPcHB3RVVQdGo3?=
 =?utf-8?B?alRXanAwVTkrZkdxdUlJMmtWQjN2Q2hWcGMvTFI4Y1hCVERtcnlWaXQ2VDVP?=
 =?utf-8?B?aTY2RHpvMDQ0WmwwcVgyalZKc0pKc1RIRzZlQkZIWU5aWml6TEI4REtMYWFQ?=
 =?utf-8?B?Q0dNVm43MCtsNlk3K0VOck1lU3pZVW1mb2s1cTBpc21pbXdkQUhuc01hWk55?=
 =?utf-8?B?cHJ4U25ucFRiaUlnVVNwandwYmZHK1Z4WnZ2ZW9wL3VNdWFKOFhmQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f6fed6-4003-41ee-c40e-08deb8782f0a
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 03:05:46.0702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KenCx26ahQfim2TVVi8/uiPeaPgeLPppC61RG2J8C1ZeQQl39K6SIiI+duTqJalCFrfBan000CrvdzMtx2wpbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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
> Remove unnecessary fields in PciRomHeader. This allows a simplification
> to use `FromBytes` instead of reading fields piecemeal. A lot of these
> checks were redundant as well since it checks the size of the `data`
> first in `BiosImage`.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 68 ++++++++++--------------------------------
>  1 file changed, 16 insertions(+), 52 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 64d100b6699b..1dca7933fac5 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -546,67 +546,38 @@ fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
>  
>  /// PCI ROM Expansion Header as defined in PCI Firmware Specification.
>  ///
> -/// This is header is at the beginning of every image in the set of images in the ROM. It contains
> -/// a pointer to the PCI Data Structure which describes the image. For "NBSI" images (NoteBook
> -/// System Information), the ROM header deviates from the standard and contains an offset to the
> -/// NBSI image however we do not yet parse that in this module and keep it for future reference.
> +/// This header is at the beginning of every image in the set of images in the ROM. It contains a
> +/// pointer to the PCI Data Structure which describes the image.
>  #[derive(Debug, Clone, Copy)]
> -#[expect(dead_code)]
> +#[repr(C)]
>  struct PciRomHeader {
>      /// 00h: Signature (0xAA55)
>      signature: u16,
> -    /// 02h: Reserved bytes for processor architecture unique data (20 bytes)
> -    reserved: [u8; 20],
> -    /// 16h: NBSI Data Offset (NBSI-specific, offset from header to NBSI image)
> -    nbsi_data_offset: Option<u16>,
> +    /// 02h: Reserved bytes for processor architecture unique data (22 bytes)
> +    reserved: [u8; 22],
>      /// 18h: Pointer to PCI Data Structure (offset from start of ROM image)
>      pci_data_struct_offset: u16,
> -    /// 1Ah: Size of block (this is NBSI-specific)
> -    size_of_block: Option<u32>,
>  }
>  
> +// SAFETY: all bit patterns are valid for `PciRomHeader`.
> +unsafe impl FromBytes for PciRomHeader {}
> +
>  impl PciRomHeader {
>      fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
> -        if data.len() < 26 {
> -            // Need at least 26 bytes to read pciDataStrucPtr and sizeOfBlock.
> -            return Err(EINVAL);
> -        }
> -
> -        let signature = u16::from_le_bytes([data[0], data[1]]);
> +        let (rom_header, _) = PciRomHeader::from_bytes_copy_prefix(data)
> +            .ok_or(EINVAL)
> +            .inspect_err(|_| dev_err!(dev, "Not enough data for ROM header\n"))?;
>  
>          // Check for valid ROM signatures.
> -        match signature {
> +        match rom_header.signature {
>              0xAA55 | 0x4E56 => {}
>              _ => {
> -                dev_err!(dev, "ROM signature unknown {:#x}\n", signature);
> +                dev_err!(dev, "ROM signature unknown {:#x}\n", rom_header.signature);
>                  return Err(EINVAL);
>              }
>          }
>  
> -        // Read the pointer to the PCI Data Structure at offset 0x18.
> -        let pci_data_struct_ptr = u16::from_le_bytes([data[24], data[25]]);
> -
> -        // Try to read optional fields if enough data.
> -        let mut size_of_block = None;
> -        let mut nbsi_data_offset = None;
> -
> -        if data.len() >= 30 {
> -            // Read size_of_block at offset 0x1A.
> -            size_of_block = Some(u32::from_le_bytes([data[26], data[27], data[28], data[29]]));
> -        }
> -
> -        // For NBSI images, try to read the nbsiDataOffset at offset 0x16.
> -        if data.len() >= 24 {
> -            nbsi_data_offset = Some(u16::from_le_bytes([data[22], data[23]]));
> -        }
> -
> -        Ok(PciRomHeader {
> -            signature,
> -            reserved: [0u8; 20],
> -            pci_data_struct_offset: pci_data_struct_ptr,
> -            size_of_block,
> -            nbsi_data_offset,
> -        })
> +        Ok(rom_header)
>      }
>  }
>  
> @@ -722,11 +693,11 @@ pub(crate) struct FwSecBiosImage {
>  /// BIOS Image structure containing various headers and reference fields to all BIOS images.
>  ///
>  /// A BiosImage struct is embedded into all image types and implements common operations.
> -#[expect(dead_code)]
>  struct BiosImage {
>      /// Used for logging.
>      dev: ARef<device::Device>,
>      /// PCI ROM Expansion Header
> +    #[expect(dead_code)]
>      rom_header: PciRomHeader,
>      /// PCI Data Structure
>      pcir: PcirStruct,
> @@ -771,15 +742,8 @@ fn is_last(&self) -> bool {
>  
>      /// Creates a new BiosImage from raw byte data.
>      fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
> -        // Ensure we have enough data for the ROM header.
> -        if data.len() < 26 {
> -            dev_err!(dev, "Not enough data for ROM header\n");
> -            return Err(EINVAL);
> -        }
> -
>          // Parse the ROM header.
> -        let rom_header = PciRomHeader::new(dev, &data[0..26])
> -            .inspect_err(|e| dev_err!(dev, "Failed to create PciRomHeader: {:?}\n", e))?;
> +        let rom_header = PciRomHeader::new(dev, data)?;
>  
>          // Get the PCI Data Structure using the pointer from the ROM header.
>          let pcir_offset = usize::from(rom_header.pci_data_struct_offset);
> 

