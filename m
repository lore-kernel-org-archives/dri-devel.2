Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903C1CD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D606010E00B;
	Sat, 23 May 2026 02:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZG6EhmfB";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1011610E00B
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPd2g2btP8ABpyzxLYd6YNY0wxdi/MuAuXx/rrK2xFxpme27KrvTVaAGXPuwl3eEMVvxuo2fLvYdbaJr/uCoWbf8BO/zIak6Wf3Gm7I5Xu1PAcJUPIgDcYoemn86Iioh7I49KRbH05MN5YsIvkLPGulm992cJgj6qtPKEOMmM4qKKfLw+JcQ9dBsHACZh2w4XzKWgXhBQxZYW/VUnRHb71BN+7jo4tQTXVU/dARgBYRkm5eFAgURF3+tt4gG1sb/s0NAa3MM9YgdfxLE26gxzamOrbC++ngBvvYuwNBWrAzVgFzOUuUtif8esiq7pH4TTOMVktGe1M5P68gBuRS1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skCbHmSiCfyMlp3iY1Gn6GvFlco5Mucq8oA0kGI6DNI=;
 b=XsWoJhl3anKB+Y9yV3DlpSKP9tfMZSdjdWSJfrGy6c8QPbKN7i3DfCkY3FqTwpFXGl9KF7KAOW/C6wnF/9qUAa+V5IOXYcvXFvxozpdVO/xEbqgeJHcS+Uiwa8JT3+ZueiMglX2RSMwZJhSx2e1CXe94GPSKm/chwYJ3G3pYVBjj+E6/WacCpttuCx4qxN9/ahshGsGkERgClxMqLN7eeMWQJFDqikvzEKMK7HVLUDXUNAcgGZOl3AedYYqPmzDFYrxvos32NOAg6Lcha0hDpESBEiMgvZWs2C5ovDpNJz+VSblUi9iL66rZ20X9Z7iV16UTzsuzNCILg+tbev666w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skCbHmSiCfyMlp3iY1Gn6GvFlco5Mucq8oA0kGI6DNI=;
 b=ZG6EhmfBoBGgml1bbW527g7rl+NyZ1nSQxGbGiqGQ3wzP0K1y1Y47ypKgkpI4x2CEUAogwVA1wf+zG4YDBNEbAfgZrdzV9uguSJrKzvlrVhzFaTighc3d3xe5MlVu3qMDURuAb5YPP4u0yNINlR7GlBV0y8FTKx5xSindkBAkNwCQnT1xSE9PWZItZPU6gM6Ghnbn9A8/ab8hwoXpSFLPQThUtBc6VI/PRZ0t20gDT2AhlC4uVOcSCQhiNr+XI3bT8usBZGn1YjOGekcGmIsBZFj0BmkMImICGcukzFDiDk47/XwRBTjpytiWIZMqKjSfvsgaxACRHe0MZrTNmW0CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 02:46:55 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:46:55 +0000
Message-ID: <ac72984b-1118-4115-bfaa-5e96f53957a2@nvidia.com>
Date: Fri, 22 May 2026 19:46:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/20] gpu: nova-core: vbios: construct
 `FwSecBiosImage` directly from BIOS images
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-14-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-14-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: c1906bab-39c7-406b-a9ad-08deb8758cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6jg48Z6got83u6WDBFVnMTrhOdcAXjGNGGUcjJ4cDSPo1e2jyUq2EEij3cBSOa5c8/YXDuG7aT3t+a06DIis4x17lREwSz8qjOtfQ1CIJw+8v4Vb2boOpUoHABhjRPW4OyjHF79Hb9bcMCEv3FOiN5Z6NLmLPG82aXiiApzExbtpYpd1TvDkSknl0HdwoHa79odU9mBnirMx2Oml38auI2uxHFWC5gDjXGYffjEMpKeUuyBLk8V9VeDw906KDbHKl/WbLUONNgUg5hZkzJ+9bVUZqFbTUaHOJjW5mVZDESbe3EgNYC5iD1pmSJCHd7E9be5QwYbBk/eIkKyYXNpv7lFsGwcnpCFqefgwNiGs6bKB02ok/4Equbv8nn+pBwnk01MHiAKJBzWtPjWbjD6GQpKby+MyvsZbuwxRq6g/WXtmp8HsZUzxi73MItjrFTsol3Y2St4RB+Kcgrakf06tbSbSIJLl24bxhIk1lyPXvGmL/96aeDR9R31Fwrlew7Ek47/KAnPfP7JYUm+tZX0ihfUY0O9zaQGDzDwY2Ub7qC8ZbbKVuqrJ4RzrrfVZ5raGjDAMRW5bl7J1kdV6E81mKb9sWoPUsps1n6zBaNxIKvsft0iCXum8PkrqHFOfEXiIPhhCX5MzZLKTCOIJNQMJCaXNAnstULki46NylJ35BRfeG8qoscaRM/XPOX/5OEcK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1pxbnc2MWpOM3FXWEkrZmZXczJCR2JFQm5DUnV1UW5wUk5EeHM5VlFoNmlk?=
 =?utf-8?B?Q1JSUE9zV0ZsSzJHN0x3N25xSzJGck9PZHRsWVNNVS9KY1dNT2RRMy96bmpt?=
 =?utf-8?B?bUovc0pyNjJiWGtzeTJPT1QwUGx3R3dkc2p3V0JtenVEUDgvU2Q5NWdLcWVh?=
 =?utf-8?B?L29keTJrNzJhYmY4TVBRTVk4b1hoOFpQb01ybkFsNXJ1ckdtK0lXQ2Vsdi95?=
 =?utf-8?B?b0ZIeVlyMzdCc0d3SkZ4VzQwSzgyclJVSXJYOHlNT3ViQ0U3dFIrUXNTeklz?=
 =?utf-8?B?ZU9ROUYvTFlEZldvZXcrSno1VmpWZm9xcitXaml1Yk1SNk5KazRPV2lHa0di?=
 =?utf-8?B?MkkwK2RETUJIcEpZMHFIdnVKM2k1bHJ2cStsZUMzMktaeEdWdDlsaTU1WDda?=
 =?utf-8?B?M3JQRmdCMXFLeU9pL2tiQ0R2c29pR01jZm40cm1Eb3ozTkczeVNuUk9VM2k5?=
 =?utf-8?B?ZlZxS1ZHNktpM0ZNUnVHMEdnbW1kdFgxRVR5YzFSUDBYT0JuUGlSMjB4dGVX?=
 =?utf-8?B?TEVsSnZIb2VreTJRSzFjMGs1dEZTQi8vZXd2dEcwYmZsbXJ1S3g5ajNKUGJl?=
 =?utf-8?B?VW9NblZmcHRPU1pEdzhiVWtjK3FxQ0dQVXNMdDJidzZpNUNrSmw0bzRIZzR2?=
 =?utf-8?B?d0hySXFkalJKSEovTVhVTm84dDhNTytZcFJkTHpaeHZ6dUZSOUFUc2puM3Zv?=
 =?utf-8?B?RVNSbmpLTnNnMUVPR1IzRUpHYXNTT1BFWWpZZVhsRFZtTms3MlVMcFNXR0RX?=
 =?utf-8?B?dmlNWi9Bbk5GaW1kRDZsaElOTEJ4cEFjaG0yTVVWZWtNS1lpYUFQT1lTZkl6?=
 =?utf-8?B?RFA3MklhVXA3NU5Kcis5WjRmdHpheS9FRGxhNzRic2VjUHQ4UjlQcnF1YWdv?=
 =?utf-8?B?U3g3a05kOTcwUjlSbFFiVnRGdG9FYTVWMHVBMURJZS9qNktJb3Nhc25NY0RQ?=
 =?utf-8?B?ZGttOXc0OXZLQW0reE1vdHB3dFpBM1V2RG5TUnJUSWJTaFBscTlLUVF2clNy?=
 =?utf-8?B?Q1VNZXpyUUJwUXpNejNOQW5RNUdOdE14VFJZVjFQM0NKWHp5QzAwbHh0U1Zy?=
 =?utf-8?B?bVVxVGxYelE2YUN4NXM4ZjYreFpPNVJwN2VuUTBTSXFmeGwwNjRPQ1I1QjUy?=
 =?utf-8?B?aGdWaFZLRHBVM3EvaTVtNE1uL3RZSlZGNDdVU1kxNElMcGVIeFpmY0tsVmZT?=
 =?utf-8?B?T1hPVHdRMkY2am0vUW5RdVQ0N09GRUkxczNXSlRzOTJ1TElyQ0dDTTVBTHl5?=
 =?utf-8?B?MEhwU2VxbVVwdHIzR01YYmlHZWdIZ0xwT1dhMnYrOWdPTnBUTU1CWXVhcm5q?=
 =?utf-8?B?SC84cDd1cm9uOFN0YXA2NCtSZFRPcXNqUXdJT2xmTVlyV2FGdDNIT3Bja0JJ?=
 =?utf-8?B?Mk1TVEtyL3J5cDJZUUtwb09QbHptOTVjczlYdjVXdXZFR1JzWkl0MTJpYi9K?=
 =?utf-8?B?N3MxbUEwSjlSMURjeTdlMnE0cTRPekZ6cU5Meld3aW5oTkp5K203U2RBSnZo?=
 =?utf-8?B?SSszalFMYVQ4ZTVnTzhqM204U3BCNE5SOXcwUFJ1SGN0eE4yNS9FbTBZdEdU?=
 =?utf-8?B?RWpLZ3dIR0Q4VkpOYnN2RVJ5V3hnYTFrdVlsQ3hMSjNyb2Q5Y1gvbmIvanUz?=
 =?utf-8?B?ZmJoZ0wyNGJMYTl3NVRKVVpldFJLWFBWY2kxL0VsaGdwMnFXQmlzaFhZUjBz?=
 =?utf-8?B?SWMxdVdnRjVGZHlkMmVKUStWUUhlcHY5dGY4Vm9RZlcxWGdPWFJUaXFSWFow?=
 =?utf-8?B?ZWN0QS9rOXhRNU5Wd00yUXE3ZTczVElBNndhcFhNQnd5ZmJqUEpRVWY4MkVM?=
 =?utf-8?B?Zlhya0Q5VGl0aUF4YnBpTThzQnVKRzJEQWpuTDNFZ2N1UFhyVnFVODZxeDlV?=
 =?utf-8?B?ZDAxTXJOZ3dIdFlhQ0xRbHVXdGk0ZXRicjVoeG4vRmlrNG5jRS9tSFpwSFdQ?=
 =?utf-8?B?RDkzN1VnVDBjSlM3L2EzQjdxS09DWkc1YmRuaWVtUmtmWnhKUGVRQU53bWVE?=
 =?utf-8?B?VHZ0OWRPc2FsSlBaYkdTNkJNek0vUXBlb0p2TlpoZVRnWFFSazRTNGo0VURz?=
 =?utf-8?B?TzJZcTl6Q3NJeFNYbmxQOWlRQUU5eXo2S3dRN1VDMmlyRnBNT2xxWk9xaE1X?=
 =?utf-8?B?UU5MK3B3WnMrbU5IMVUvYmFKWlViRHR0VXJEUXoxL1ZodWJWTXBXRURyU25P?=
 =?utf-8?B?NnlYWDVMdGhvV0xYYW5DZDVLcFRmZGlXYit3QUxYMlZUdVpmRm93Z2c1NHEz?=
 =?utf-8?B?RWtCSWlUaDZ3bVh6NUN1ZVl0RXd3bkh1UkhQSkk1TElrVEpLM1pwd3M0TTZi?=
 =?utf-8?B?VWdoRVZ3aXNVRzNLWDYvU0p4SkkvazZyaDdSYWtyVTJ0ZFZ5M3ZJUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1906bab-39c7-406b-a9ad-08deb8758cea
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:46:54.9815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHO2G+0gigAkror/Se+ktx1Nfu9DkO1N1lElJpvM3titphf+V/FaDKoPuQE6cw8QZiMq6TporkfBJl5D37OYAA==
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

On 5/18/26 7:55 PM, Eliot Courtney wrote:
> `FwSecBiosBuilder` now only contains `falcon_ucode_offset` which just
> gets passed directly into `FwSecBiosImage`. Remove `FwSecBiosBuilder`
> and construct `FwSecBiosImage` directly, as a simplification.
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 98 +++++++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 59 deletions(-)
...
> -impl FwSecBiosBuilder {
> -    fn setup_falcon_data(
> -        &mut self,
> -        pci_at_image: &PciAtBiosImage,
> -        first_fwsec: &FwSecBiosBuilder,
> -    ) -> Result {
> +impl FwSecBiosImage {
> +    /// Build the final `FwSecBiosImage` from the PCI-AT and FWSEC BIOS images

This needs a period at the end of the sentence.

The patch looks good, I had to look pretty hard in order find that
tiny nit. :)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> +    fn new(
> +        pci_at_image: PciAtBiosImage,
> +        first_fwsec: BiosImage,
> +        second_fwsec: BiosImage,
> +    ) -> Result<FwSecBiosImage> {
>          let offset = pci_at_image.falcon_data_offset()?;
>  
>          // The offset is from the start of the first FwSec image, but it
>          // may point into the second FwSec image. Treat the two FwSec images
>          // as contiguous here and subtract the first image length when the
>          // target lies in the second one.
> -        let pmu_lookup_data = if offset < first_fwsec.base.data.len() {
> -            first_fwsec.base.data.get(offset..)
> +        let pmu_lookup_data = if offset < first_fwsec.data.len() {
> +            first_fwsec.data.get(offset..)
>          } else {
> -            self.base.data.get(offset - first_fwsec.base.data.len()..)
> +            second_fwsec.data.get(offset - first_fwsec.data.len()..)
>          }
>          .ok_or(EINVAL)?;
>  
> -        let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
> +        let pmu_lookup_table = PmuLookupTable::new(&second_fwsec.dev, pmu_lookup_data)?;
>  
>          let entry = pmu_lookup_table
>              .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
>              .inspect_err(|e| {
>                  dev_err!(
> -                    self.base.dev,
> +                    second_fwsec.dev,
>                      "PmuLookupTableEntry not found, error: {:?}\n",
>                      e
>                  );
> @@ -987,34 +980,21 @@ fn setup_falcon_data(
>  
>          let falcon_ucode_offset = usize::from_safe_cast(entry.data)
>              .checked_sub(pci_at_image.base.data.len())
> -            .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
> +            .and_then(|o| o.checked_sub(first_fwsec.data.len()))
>              .ok_or(EINVAL)
>              .inspect_err(|_| {
> -                dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
> +                dev_err!(
> +                    second_fwsec.dev,
> +                    "Falcon Ucode offset not in second Fwsec.\n"
> +                );
>              })?;
>  
> -        self.falcon_ucode_offset = Some(falcon_ucode_offset);
> -        Ok(())
> +        Ok(FwSecBiosImage {
> +            base: second_fwsec,
> +            falcon_ucode_offset,
> +        })
>      }
>  
> -    /// Build the final FwSecBiosImage from this builder
> -    fn build(self) -> Result<FwSecBiosImage> {
> -        let ret = FwSecBiosImage {
> -            base: self.base,
> -            falcon_ucode_offset: self.falcon_ucode_offset.ok_or(EINVAL)?,
> -        };
> -
> -        if cfg!(debug_assertions) {
> -            // Print the desc header for debugging
> -            let desc = ret.header()?;
> -            dev_dbg!(ret.base.dev, "PmuLookupTableEntry desc: {:#?}\n", desc);
> -        }
> -
> -        Ok(ret)
> -    }
> -}
> -
> -impl FwSecBiosImage {
>      /// Get the FwSec header ([`FalconUCodeDesc`]).
>      pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
>          let data = self
> 


