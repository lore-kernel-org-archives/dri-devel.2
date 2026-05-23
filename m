Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF280CD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B97410F6B6;
	Sat, 23 May 2026 02:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WXOO4wcw";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011014.outbound.protection.outlook.com
 [40.93.194.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED4D10F6B6
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kszhzM+MABshYCiwJGQimkubBoZ5jfGO2oRrCWxYp57X3sE1G8jjbwELN2Fl2PseO2I2DWmlg9Z1faNxjaHQISXNvQL3t6Kk+Bs88iD186kB7sT9+4qD+xuPpRD3KZiiaV9T9xHW9KUa3ULxpMMs/KESUyUIRX8uhCc/YHQKiMCeyqsxf/jH1zDf12mOIQuS67ZZDioxlRzQswoi55rceww44EyNmG4/AGeE4c04xzdbHU4EAT65z84v/S5lo19QA/JHPp0/dfArEgWEseQ1RQR8WbYQsz3uBxre4ZANF8+d1azqcZ3OqDgB9kPIqxCbrdSJErthjl8qFgV/RiEIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yPVnYXKiAzmdvwJF7GYrVmy4Ot9gZtO4L74pt8pEoA=;
 b=anenc/IOM5yLFFo5jAe1ViWmjsxFavjhl97WAFeXm/vcS7Go6wrKNFHH4QRVa3MESHZdiZhyS1s+Is1+o6/MKiHNMKVqcBMh10AyCBI7fif/MTL8SXMIe76sAGe5UyciR1dzxt7zdAHToLHITOChFOat8/aJqkRJ/nPqy2qhMgA3qhCUFTI9sFxiqFFP4F4v9S00wkK1yWmqct0sn/sHV3PdAElAvlLX0fem0vcJaczVlaBcwcmSPsuXyR30zprGC8wdzt1SjNWFP+B3HiPOkqJK0ePdN+DG+DEbZZMReDH+6JOvgrw5Nk1Na3TLE47ewSlnJDSgvmA9yYubhEwG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yPVnYXKiAzmdvwJF7GYrVmy4Ot9gZtO4L74pt8pEoA=;
 b=WXOO4wcwKnejzUw+F4PlW8TTwSzDKb51ynlHeY4Yj2uWONXcZIrrKgxtTyLkUQyXhHwyl+LBYZ6To/SlFyUA3ORp48gS/R609tHT9MOpFyjy325sJv3PkkG/RKQyPTTA6eayhnEcAuzqD/Z2VlFmmBVUMjXJlTIamDse7gl83caZsirLw5fYJ2qT80PObGlvAZ2E/5TtiehRysNXP6nBOMEh3hM0dxZmzDtxKj0luEZx4e4LvT9w1j2NlyYVlhEl29MWqTOjGf6lD/f98GE0/bmx2jJ7OxHwskDLGmEMXsl6GcVUePplS83vgpWI/Y6ziwsr6sPc1WaLA4/P6AmwBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Sat, 23 May 2026 02:50:19 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:50:19 +0000
Message-ID: <99d8ad95-3838-4bf6-9c07-68babe9f3f9e@nvidia.com>
Date: Fri, 22 May 2026 19:50:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/20] gpu: nova-core: vbios: simplify setup_falcon_data
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-11-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-11-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 178b7b4b-3886-43d6-c99b-08deb87606fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: SOnPvIdCdiLXwiaLWEALgVPOPBi2QACuXQMWwKa880CSj4F+4wYgLTx3ztchWguP2VS1biD1tNPFVPW3lPzjPGEa0B2UctqNbeSB/dOkjstQl4mPVahq3rjbbq1LqPr8TsaE06lowU02vYjvucdAXZ/aHoF0RdxXjeXwDfcaHhdoIP1Z6YLHMu+VF6H2l9MVJ5pVf+WQ3z4LIJLWHhdvKA0l/RdlBcC8giaJ1BtoYUEYF/qYzEVcgX5aIuyv4NpdFGDVtIQnwudY+tcdgjuhgGhOyGLJC4MHRfyb7VCaBxt1Qr0dmdwQomWNkoL0t7/MiZNCreGb05OTi6WfqRE23NqGOWrLKZc6frHCdKcIyBjr2iCH2fexa4qoPD917VDxhpk6Xq3YnJ4YdA+rEPP/CPlOmw1+N8ofGiUlITs41Mml/9LPcGtvIdEBvp05ZQxLh1ChyST1dTystE9Fx4tsrp2vVqmWjt4IvrVevzv7VgGytSLBP+JQ5Cma4za2G/Gyr9QgLLm6elz7SxwwPvbxCt8RYGT7+lluDAdLIxkyIu0qi/R4g5UBK1oZeR4y8/C8RDe/ZT4+Z7a72TSI+8Eu9ROCf1Ht2l9bxUlP6qfWwhgiqZtTjhH9P6MdoY4Hno7ErY/+SxEvCBdoYOj8O20J67Mrb2g6nSo1hDoID4KzyFkXzD3qytAMDRFHJWp3QDF5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1gyQk4rQW9NU2JaSnhVY1prWnA3TGcvMHFJOGtGY1N6SjVyTyt0VWJTQkZT?=
 =?utf-8?B?cVVzU0U5bThYMXBNeHJtMi9hYjlCL01VYW13bWI5Q1loRFRkM3FuQWlPaWp0?=
 =?utf-8?B?VDZqTnNNWEpsVWhUOVdTcS85U2NpMUMrUk5SV2lnQ3VSUHJlemRMUmoySUQz?=
 =?utf-8?B?L21taDdPcXdoam5RY3lyODRiaGZhR0J6SGZzcFJqRzhYcElzVXExUEpQVnZF?=
 =?utf-8?B?a2M2a21vcDhWMFF0S0VYWnNBczFjODZzd0kwdVBCbDB5TDNiY3VXajdpQUVN?=
 =?utf-8?B?ODBPa0FobVFjN0dnQTBCQzdrVTFRbE1DK0U4aU5mZHAzdDZtU0VpQ0xOU29u?=
 =?utf-8?B?eW5zTis4TUZrK1lyU1k4ZHo2VExyMEZRRGpCNGdZUVVkQkpUdzJGSEVyaWVW?=
 =?utf-8?B?RElvcndZZm1VVktDZmFSMmNjSTM3dTFjOHozVVEzNWUxMzgrNzhpVFJySHFk?=
 =?utf-8?B?RkViaVRtS3h0bjBpWkdGVm05ZU1PSzltOFVZUUF0cklmTi9IbWZDRVFXUDNz?=
 =?utf-8?B?bnhlVml2U29nVUlwdlBLN2pES25CZXJReHlZWkV5ZnN6dE9RMUxkalRpajB0?=
 =?utf-8?B?SUdzU01kSWo5aDJOeU11bU1UdTRLVmJPdldkOTViSmNFZjN5R1owZ3U2SHor?=
 =?utf-8?B?ckhuVDY2WEwxOWcxUG1qdHFESk5tOFIwR2ZGVXN5bHowc01vOUJSYUtqZnBt?=
 =?utf-8?B?WlpRVjQ0S1dxd1QxU0NOZnJSNGkwaVFqYzdxZmY2aHJieG1DVGtEdXdJbkly?=
 =?utf-8?B?ZEF3c1hVNVcvOWVrREF2QzJBYlZjRG5UZi9NenZOYjhVQWxGeVVWTnFGOTU0?=
 =?utf-8?B?cEMxWWlycmZjaU5MTzRHN3pjcW5qdTRyeDl0MzMrd3p5bXdaM0E2QjhHc0J5?=
 =?utf-8?B?eHJKV1BzRUhhY2p0SG9SOVdWQ1lQTUcrSXBybXlVTUwvdFBqTU1mdVA5eWFD?=
 =?utf-8?B?ZUVrbFVVbm5jNUE1RUMxN0xYVmgwREtLWEVBZmhGSjB3VVZkNlJkVGhreXo3?=
 =?utf-8?B?anlobmQzRW51N0JiSEpMbDFEQW5ZdzRTSkgvL1duVmZFWnE0azlxVXBnL0Z0?=
 =?utf-8?B?cmtST1Z5YVh6ZVhPaXhyUk9vR0ROOWYvQjJ6Z0V3Y0FsZjljRCt6blFheWZj?=
 =?utf-8?B?cmI3MXduKzJSWDFwM3krcHpLSEdBV1hrVXc3WUEreUYwWmJ4ZURvYVVYZkFB?=
 =?utf-8?B?MTZmK2J0TFpGZWVwSDlUcFRINm1SWmViUVBlWXNESUY1bkMwblU0bVQvN0hO?=
 =?utf-8?B?Wlg0U2hZZFgvUXVyN1JyZE9RSlFmVFB1K21oTXA2S25JYkVBL3ZJbDJzb1Ra?=
 =?utf-8?B?WlNFTU9pMEwzbFdYazMwTnF5UmVFMjdqdGNscFhHRVpCaWdxLytHd0xJTkRP?=
 =?utf-8?B?N2ZjeFFoVUljRnptbWZ4a3RSN3FocUp5OTcwRkNKOEpPOHZEOVNhSjlPUFE0?=
 =?utf-8?B?bnJZd2pENEc0ZlBiUFQ0WDI2WWE5dGxGQ0JmR1BHak4vTDZNdVFwWU9yc1hI?=
 =?utf-8?B?VHM4OXJqNk5kOWxtdkxOdkZ1Ykx1TTJ2L2ZHZitxRkZVY1BCb0d5YkJpc05w?=
 =?utf-8?B?eVErT1JCdHUwSVA0aElBUiticE5OdjRpNXlGMDRCQWZTUnNpblpQOWJIbDJU?=
 =?utf-8?B?U3pETDZlNnFobDN4VXZhR0x0UmhOMmZKOVRjalJZcmorcXZCd2s2b01GMmxk?=
 =?utf-8?B?Z0ZtV3hjUHMvaEVNQmdJclRDaVdOeUxHL1NpTGZ4ek1vSVp4TW9GQWhKUlMy?=
 =?utf-8?B?M3hOdnU3TDhwMkJROGl4RG1Wci9YNGhDc3NxNWJxTDV6WFlUMmhsN0QvM3hT?=
 =?utf-8?B?MFk3L3p1SGt0VFV6dXVrRmFHek8wcjYwMHJOak5YbWRxS2gvWk9nY05YK2JR?=
 =?utf-8?B?VW1SK1lnaHVneFJSQ2JEU2F0ODF1aEJkTGU2QUNMeUlKZkF1Zlpjc2VtRDUw?=
 =?utf-8?B?UDNwNjNqU0hXQmVrQk1wMFJlZjRxcE5iQ0hkUEVwclFVS045QnJoVXMrektO?=
 =?utf-8?B?VDVsb1V0Q045aEN0REhaMXdnaTAxTWN5cjdtWThKUVNKd3ZVTElkNVU5VmVn?=
 =?utf-8?B?bmZQQWU0WVhzUGQ2b1FNcUFnS2hUbFZWUWpuL2VOa25XLzVhdWRWdlFqUEs3?=
 =?utf-8?B?dkNKM3BKQ1E0R2d0NmM0Vncrbmx4WjlDbmlZN2wwU2xiTTAwR1JlTkRHdk1S?=
 =?utf-8?B?WVZYV01Kb1RsdGpnZnptYURuV3pydUl6SFJpdmhwOFdYM0RnZnpPV2tLcUx3?=
 =?utf-8?B?VGN0OEc1REhua0xSTm01YVQxSlRuOHppdHJ4U0lSNHRRcGxBTkYydDBlNmQ4?=
 =?utf-8?B?cUVVM2NaOVlaSHF1WTV3RWpQTVlQMDd0c1ZwUkVXK2VUVTQ0Q0tkdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178b7b4b-3886-43d6-c99b-08deb87606fc
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:50:19.8019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x304tyfk8BKWDUSyIigfOUB6XOmKErvHR3rgigzPCnALHerVI4ObpxwQgNbDmQCLZqdYIWMSqrWY52ll636CFA==
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
> The code first computes `pmu_in_first_fwsec` or adjusts the offset and
> then uses it in a branch just once to get the correct source for the PMU
> table. This can be simplified to a single branch while also avoiding the
> mutation of `offset`. Also, adjust the code after this to keep the
> success case non-nested.
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 54 ++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 31 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index ca101b2b6095..470e0e2a81ab 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -985,48 +985,40 @@ fn setup_falcon_data(
>          pci_at_image: &PciAtBiosImage,
>          first_fwsec: &FwSecBiosBuilder,
>      ) -> Result {
> -        let mut offset = pci_at_image.falcon_data_offset()?;
> -        let mut pmu_in_first_fwsec = false;
> +        let offset = pci_at_image.falcon_data_offset()?;
>  
> -        // The offset is now from the start of the first Fwsec image, however
> -        // the offset points to a location in the second Fwsec image. Since
> -        // the fwsec images are contiguous, subtract the length of the first Fwsec
> -        // image from the offset to get the offset to the start of the second
> -        // Fwsec image.
> -        if offset < first_fwsec.base.data.len() {
> -            pmu_in_first_fwsec = true;
> +        // The offset is from the start of the first FwSec image, but it
> +        // may point into the second FwSec image. Treat the two FwSec images
> +        // as contiguous here and subtract the first image length when the
> +        // target lies in the second one.
> +        let pmu_lookup_data = if offset < first_fwsec.base.data.len() {
> +            first_fwsec.base.data.get(offset..)
>          } else {
> -            offset -= first_fwsec.base.data.len();
> +            self.base.data.get(offset - first_fwsec.base.data.len()..)
>          }
> +        .ok_or(EINVAL)?;
>  
> -        let pmu_lookup_data = if pmu_in_first_fwsec {
> -            &first_fwsec.base.data[offset..]
> -        } else {
> -            self.base.data.get(offset..).ok_or(EINVAL)?
> -        };
>          let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
>  
> -        match pmu_lookup_table.find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD) {
> -            Ok(entry) => {
> -                self.falcon_ucode_offset = Some(
> -                    usize::from_safe_cast(entry.data)
> -                        .checked_sub(pci_at_image.base.data.len())
> -                        .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
> -                        .ok_or(EINVAL)
> -                        .inspect_err(|_| {
> -                            dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
> -                        })?,
> -                );
> -            }
> -            Err(e) => {
> +        let entry = pmu_lookup_table
> +            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
> +            .inspect_err(|e| {
>                  dev_err!(
>                      self.base.dev,
>                      "PmuLookupTableEntry not found, error: {:?}\n",
>                      e
>                  );
> -                return Err(EINVAL);
> -            }
> -        }
> +            })?;
> +
> +        let falcon_ucode_offset = usize::from_safe_cast(entry.data)
> +            .checked_sub(pci_at_image.base.data.len())
> +            .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
> +            .ok_or(EINVAL)
> +            .inspect_err(|_| {
> +                dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
> +            })?;
> +
> +        self.falcon_ucode_offset = Some(falcon_ucode_offset);
>          Ok(())
>      }
>  
> 

