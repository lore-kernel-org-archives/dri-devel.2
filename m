Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC380C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 18:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD2210E1AA;
	Sun,  5 Jul 2026 18:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="novHhvne";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED76D10E1AA;
 Sun,  5 Jul 2026 18:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnrvTVnqLUyoR85DRSXaPXRIzHLymNvVDsP83olu78ov/mPfrZblkOoNhugzMrHM35w7Cn/NvLNbvlTcF9yZgcgptVxTV39blulOWZowrDGxi0rJ8WncqU0JVd7SNBKIGG13FoCGJpbHKkpGPAFSjlmJiWAXKMBxrkJ33xWADDoPwBDxZJbzXtc71oQEDL8tWP2NQgGA4/iSuDnaI7FpHy8kTxiwkhSoz+THCVKCHGJezcqy6SFFJkUsc4FPoZOSoPaZ3f2VeKN3Pe4O41RrRbqj1eSGJvkP9la2E8Ky7v/asEBV30O4NRtDzXHIU+T3EARICc09hHiRv0D9faZnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PuA1zyjWeYZZ5Gz9HtZpCO/tDHcW77gy5O7CDuYlqM=;
 b=VHtaPGn62M3Zqc5nviMpP3xbUFat/6SeANssMZ853cR2qk1vcJsu6mq++b/166lfbtXD0mhicP6XxHueSOHVh0/d8frRI6HcBFSLwzzTXYQatUvWhPNHfW07T0VRCyJTUR+iHJ4lpioJAkosJd9RHaNEjixK8iXJbcHZYdTgZ9AWgSTsZNz5LbkBrTo5yapTMaFRpMKmXmVaFvSsSzS6/Jjk9N8arUQha3ME4hgIkxuZMcmxVuubI030M7oie2mrzDol4CUe8f/LB8dvunaB7aXSjKHFL/JUWsyGBpPDOGD02i0mUorjA5+7nK7vu2OIh7p4x0ArORmSeLQ5C54ySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PuA1zyjWeYZZ5Gz9HtZpCO/tDHcW77gy5O7CDuYlqM=;
 b=novHhvneBBTjqVSMug8jquty3cl5271DbIIPZ092W6iw5Z71TnZupJdcpd3lymjg3sruD1Ey7zE+q8+hpP4LtEnrLxjfCHQezFfQeQibWZB/w8HyoQRPxa9jy4wbML89AsqZ23SFoLdlshlUt3gnzeL0i4lus7qz+4qSJD4RIIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Sun, 5 Jul
 2026 18:37:42 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.008; Sun, 5 Jul 2026
 18:37:42 +0000
Message-ID: <a8339282-e3ef-4a4f-a135-968f94855e76@amd.com>
Date: Sun, 5 Jul 2026 13:37:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
To: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
 <20260705100436.6877-1-oz@shift-computing.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260705100436.6877-1-oz@shift-computing.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0895.namprd03.prod.outlook.com
 (2603:10b6:408:13c::30) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 910b0065-bdb5-4153-d90f-08dedac47fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j7CorNdHECKpWpuYdQMsXaq4mE+Dd0PdfH01TIYApHYDyLWzjuYpdpayvDG2lcq9sFy+YhfFGEfSfAmdcGy/OCVSEkFXnO9uUKpYGCqu1X+T6JMRqyz6PCAGqw/nrYf2dVRqWiUUg6xSXn6N+etN/Mr1hOURUwAJJYP47BHS7E3KmK7lGpWuoncPImh3ZtCPOV2pneOz0liVPUeH5DErvLeYiuMER7fAWRurBbPRB8mib8yVoFp/w6AIczHnWuXKy4CojVgly8hNgHciqKSt2uqNnCd3ise0AIUL2BieZvWefYxa3jMYhx91XZXMexIlDaXtyZJNGy50KSRoJe2XJfubd6Ur3qxvFQqNGlqsI1Ry1/ybAR/rbywKeuV88bYxUeU+t6nmy0GWCuGaDFf1suEu4Fthed84YzrjTQhlyySVoBFxiwV3/6qnnnh24F6l8hDBkHrs5KiCRBHeWgJhDikRP9wzCwi/CVLiNqh0wjpFi2Flt1eHL7ZBNdTy3MW4FO6zwggoCmwJwTsyWTJhojT70zbGNNjcGJOAtTQ8Jof2udxcLZ6yg8xF0BU0kVhXsyqpQksne4yWdm6lA0FbMBV3A9yaTVdIcffNv82lQFSwbD9Zx8KOOcYkab15x7yfTp77BO2RFA2Zxc3AM526MKspNoXtdNlgEBNojlRy5+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFZiWHhqMDZMUEtuWUFFRHRiaW84bmZOLzJ2RnIzbzY1UDZNYTN0WUV3Skc5?=
 =?utf-8?B?aTRnTUtxQmc0Z2JTYldBNFpvZjUxV051UFJSakw4MmVQYmxyOUFpbXFwMHBz?=
 =?utf-8?B?NUZBUER5ZHRrOGM3eVBVc1pCUzdOaVdvQmdwc2NQam9wd1RhYUpSd0JLNGpY?=
 =?utf-8?B?b0taSGFDQWJzRmN0ajJDQm8rWG9hUjVFWWwwV0hxZHlvMVdmYjhFMzZYb2V1?=
 =?utf-8?B?Q2grMDE1Y1o3c0RrM25VTkxJcThoem9YcHVSSkl0R085MWQ4dExkTjNRT3Y2?=
 =?utf-8?B?QWRtTDMvSVRwOE0xV2duZytHS0RsMFMvZnA4NFBaVWdIYi9jUVZxZ3hpUXg2?=
 =?utf-8?B?YjlyaVNlcVJPSVo1eEpZWjBoTjRpOUJNQ29iMjl6NjAvWlFZT2NXOWc1MzY3?=
 =?utf-8?B?TEZMUFFUTm5ITWNMeGFILzVDSWJBeDJqUDM1R054a2Z3VGF6cVp6WWppTTIr?=
 =?utf-8?B?QmhYdzBoUWxTemNHNU1uQks2a1JUclN2UnNneUhJRElYWFJ0OHo4NDZWRHpS?=
 =?utf-8?B?T0RrTDBwWG55WWVQSEx5N1IvdndJWTZmbkJ4VlRlLzZrNWxKWlV5Z0x5Znlr?=
 =?utf-8?B?STNPY0RSbUw3SzkxVzJFZnVTM0hvTGJXajhOL2JoZWxDM0dpYnNTOGNWWmtq?=
 =?utf-8?B?TlNmWkh4MXFmNlE2MGxUekdiTjdRb1haK1c1d0N0SU4wNG04UXFla00vdnZD?=
 =?utf-8?B?d3VUMS9nR1p2czVHcTFmN1VTcFc1amRORGdzclUvcDRyUjVFNTVrOGwyNmZY?=
 =?utf-8?B?SFdKNmlpbHJNSWxaREJ2VXNMVVFoTzdVd0NSdjNpMDNzd0hJenlvc0ZUYTlN?=
 =?utf-8?B?cWQvbjVXTE1PckMzd2U1elZ0NWtacHRMa1UwT1A2cFhpN2E1Q0FMNFBpdnVG?=
 =?utf-8?B?cFEveGV0MkhaQm5CSUs0S2ZIT0czZ2o2NXowd1dyTVVzR045UUxSaHNnMVM3?=
 =?utf-8?B?VXZOQjdOdGtveDl0TEovdENQaktZZXY3Y0tXa0R3ZTkyU1hJOG4yejgwSC84?=
 =?utf-8?B?aTJ3WTdLRFlkUHJaQjMxTlBnbTZZTFgrNjRJMWJGYWxCUFF3WUNjcHlIbFMw?=
 =?utf-8?B?MHY5OUFyTnhpRmxTYmNreUQvbzhhdmJOcnpLUFVha21UbmdpRFJCWXcyRVUv?=
 =?utf-8?B?WGRMTGFDWnhoRUpSOWY2cHhzY3QyaHUrNitaVDh2M0V4OXZUM01IbmpUUFFo?=
 =?utf-8?B?TU0rNExZaXdMeDNqa3htc3FwcDVtVlNQWENsb3RnN05LRUxRcStHd3R3REFF?=
 =?utf-8?B?d0JBdExTbE5HdE9uaFkzNXpYMC9vODlqRllQZHlITHNZZ08vbXJ5dlBieCtW?=
 =?utf-8?B?bnpWemowSk5ISGZ5VVQ1a2ZNMzhsaXJlOTNNVnRNTGNKelc4TmhSRFV3a2ph?=
 =?utf-8?B?bU9lT1JJcWM5YlNVSXRnM0FHakt4UGJGUlpjT09nNjI1REV0WVJxVmJHc2Fo?=
 =?utf-8?B?WUVmR1dVNG04M0VSQlZhemdaR0hWb3JRaWgzS0hYY0ZJV0ZRc0ZJM0ZXTG5u?=
 =?utf-8?B?aFVFSkJBOFI3KzJlUHpLQzJ2bkhuZFhiR3ZUZEFzN1FnRnZTUHRGTnllMGxx?=
 =?utf-8?B?T3pXVG5ZdEQ2bXJKbWU1T29OMjRUZUphS1V1S1ZNdjRpeTljbzFVOFJUalE4?=
 =?utf-8?B?R3lKS0J0V0xTV2dKaHVpMDkyMEpMTS9mNExPTUVBUnlYc2JOZ05qVG5rUDVH?=
 =?utf-8?B?MU85N3JqRzJzVkJLTmI2dGlRaGhGdWMybVNDZEFJRkkzT0tWUit1clhvMVcx?=
 =?utf-8?B?eXNvUEVoTFk5cVUxZnJRWkVNTXJ0emdjLzB4RWI2aXFwQ2xRRjVna3UvNDdw?=
 =?utf-8?B?SFNtRURIQ21pQUlwbFdYV0UvMGV5dzRXb2t2QnRxa1gzMno2Z1BNZmlFcFRS?=
 =?utf-8?B?ZG9TTU9hMlZaektqeWlibWZIZDlTMkFsTWRlbURRa0YyU1FuNEw5MThjdGdJ?=
 =?utf-8?B?RUJGcmZ4bkxwYVhRa0k5Y3h4dGJ2MUIwbVJ2dDY1b0hRZEdCcTh2bXpIL0dz?=
 =?utf-8?B?MFpNVUZzVnF5ZkxxYXNsV0JQRkVGZG5wd3ZkZWErUTFTcG5pbHN5M0IyQ0hB?=
 =?utf-8?B?R0ZBTitCQi84UlNBeW94YWU1clBvSjIxVnExbFp6Q21iVHNCSVFjRlBSNVo2?=
 =?utf-8?B?OEh6Z01LTU55Zm5TMWlCUmp4UVdRVGVNV0JyTGx2OVRmWVR5c0lWTTloVk8r?=
 =?utf-8?B?ZTFaaXhHdnNGM1JPRFpjNmlHOXlINFBCVm1Ra0ZiTzE4R2VrbWJMOUdYSDdK?=
 =?utf-8?B?aWpyMnpLaHBFTnVtZDBiTDBtd3Vjd050ZXB5b3pQdlVTNU03ay9IS3JMK0tC?=
 =?utf-8?Q?Tbmkq8U15wZqUpx2m6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910b0065-bdb5-4153-d90f-08dedac47fa3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 18:37:42.4774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlXvL5bEn7T7To/O5MMvM2s5N33nlmnpef/N9GrYrng+nds3DIwaC7HwJtaeqW6wBQCvjFjYaX96AisMAF09qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
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



On 7/5/26 05:04, Oz Tiram wrote:
> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
> before giving up:
> 
>    1. ACPI VFCT table
>    2. VRAM BAR read
>    3. ROM BAR read
>    4. platform BIOS
> 
> On some systems all four fail.  The specific case motivating this patch
> is a hybrid graphics machine (dGPU + APU) where:
> 
>    - The VFCT table contains the iGPU entry but with a stale PCIBus value
>      from BIOS POST time (0x6A).  When the kernel boots with
>      pci=realloc,assign-busses, PCI bus numbers are reassigned dynamically
>      and the iGPU lands on bus 0x0B at runtime.  amdgpu_acpi_vfct_bios()
>      matches entries by bus number, so the entry is never found.
>    - The VRAM BAR is unmapped at probe time.
>    - The ROM BAR is zero (PCI firmware did not assign it).
>    - No platform BIOS mapping exists.
> 
> The UEFI GOP driver initialises the iGPU successfully for early display,
> confirming the hardware is functional.  The VBIOS image data embedded in
> the VFCT is also valid; only the PCIBus metadata is wrong.

So the BIOS on this machine is actually totally fine; it's just when the 
kernel is booted to reassign busses there is a problem?

In that case; why not detect the kernel was booted this way and keep 
track of the original bus number when reassigned to avoid the issue?

> The firmware
> file can be extracted directly from the VFCT using dd:
> 
>    dd if=/sys/firmware/acpi/tables/VFCT bs=1 skip=$((0x68)) count=16896 \
>       of=/lib/firmware/amdgpu/1002_1900.bin
> 
> (0x68 is the byte offset of the VBIOS image after the ACPI table header
> and VFCT_IMAGE_HEADER; the image length 16896 comes from the ImageLength
> field in VFCT_IMAGE_HEADER.)
> 
> The driver then prints "Unable to locate a BIOS ROM" and refuses to
> bind, leaving the APU completely unusable under Linux.
> 
> Add a fifth fallback: request a firmware file named
> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
> request_firmware().  This allows a VBIOS image extracted as above to be
> placed in /lib/firmware/ and makes the binding succeed without patching
> ACPI tables or BIOS.
> 
> The fallback is only reached if all existing paths have already failed,
> so there is no regression risk for boards where VFCT or ROM BAR work.

What happens if the VBIOS changes in another way one boot to another? 
You might have some other stateful information that isn't updated.

The whole thing to me feels like a hack for a behavior we can control in 
the kernel when doing reassignments.
> 
> Signed-off-by: Oz Tiram <oz@shift-computing.de>
> ---
> v2: Fix commit message: clarify that VFCT contains the iGPU entry but
>      with a stale PCIBus from BIOS POST that mismatches the runtime bus
>      number assigned by pci=realloc,assign-busses.  Explain that the VBIOS
>      image data is valid and document the dd extraction command and byte
>      offsets.  Note that the UEFI GOP driver initialises the iGPU
>      successfully, confirming the hardware is functional.
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index aa039e148a5e..86064c753b09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -26,6 +26,7 @@
>    *          Jerome Glisse
>    */
>   
> +#include <linux/firmware.h>
>   #include "amdgpu.h"
>   #include "atom.h"
>   
> @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct amdgpu_device *adev)
>   		goto success;
>   	}
>   
> +	{
> +		const struct firmware *fw;
> +		char fw_name[32];
> +		size_t fw_size;
> +
> +		snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin",
> +			 adev->pdev->vendor, adev->pdev->device);
> +		if (request_firmware(&fw, fw_name, adev->dev) == 0) {
> +			adev->bios = kmemdup(fw->data, fw->size, GFP_KERNEL);
> +			fw_size = fw->size;
> +			release_firmware(fw);
> +			if (!adev->bios || !check_atom_bios(adev, fw_size)) {
> +				amdgpu_bios_release(adev);
> +			} else {
> +				adev->bios_size = fw_size;
> +				dev_info(adev->dev, "Fetched VBIOS from firmware file %s\n",
> +					 fw_name);
> +				goto success;
> +			}
> +		}
> +	}
> +
>   	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>   	return false;
>   

