Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3692DC43211
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 17:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02BFF10F6D5;
	Fri, 26 Jun 2026 17:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7KVCzmq";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1AD10F6D5;
 Fri, 26 Jun 2026 17:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvfHYnbrGv5u4ndjOKGoiKYkV1936SLLQA9paTvjFgsnWn3jIxErjjsKXPqOkeRT7dMTrvX6M8AXnyYCr6y4OZMw0tj7zoIb1KEo6OSA72edSnRCvDlQrLIU4n5BwD2VzkP2/gN3TxV6aAJD4Q2IdYLh26aLarwJiiTccBZlvnwjZyu7ibd4hg9BrrwEwa6HhNQhv+qzWkS1WJis4yC3PRIVqT8XCRXmhKva675/qX3V9y3H/qiwIYz59M/QwvcrNQZ+qfocotifekYWs3WCRLbMQy3OPl0UbbEfIsRUSkmXfzGveEqQy75sCSy4bLLguC/qCsBXsliPfMGQ8H/DeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5x+beIO5JG8yGfuEZ1bip9NdUt+e3xROvQk7azY3iE=;
 b=E8IW0htMsRHmV81pzTLUakKfIosI2yoFGn+F3DAMDNXVKg+PLibgqy3I5UTlvEBHoQ7m/aAA7T395wMGo3fe4Y5ExP2jyXH8wPnb2Qqe9fscdz4m22JjJZqX0fW0TG/yir0bnh+jVY9NjUzpzXXRUTrlSYH9SNrs62BgHa1tpM10RCCukiNOhmXGxEAx4DYEvxjj5YCwpTznMLulJ24cEqEgsKDtF6mmSTcJUZ//Tw3iXTIk+MXQa/fRsjBp8oETwlo7Pbb3hHkWeXc8hUqba1a6tSbWt/JwvZ/Fjvl1LOD0c/h3kPhGB7kq61ZtTYZGRhKygo8xCqavf1hnMvtr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5x+beIO5JG8yGfuEZ1bip9NdUt+e3xROvQk7azY3iE=;
 b=z7KVCzmq34V99BuJ6+4DjxY7jH2CMaCBNnOJJmXNhPQO5v6mbG5ucvzIrXd7oGBdJdvhnnmfgSKyFjx8vbRdCusPX5/L/DN55+U4UQR3fqnXIl3NKqO8BU3CXFPXwIcMW5e8LMyTHIhbNLqufOx1zFblBE62HKRgzgmXFcPJY/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 17:42:44 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 17:42:43 +0000
Message-ID: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
Date: Fri, 26 Jun 2026 12:42:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
Content-Language: en-US
To: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260621173211.28443-1-oz@shift-computing.de>
 <20260621180154.30421-1-oz@shift-computing.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260621180154.30421-1-oz@shift-computing.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0191.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::24) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a25203e-9281-4e5b-e655-08ded3aa5372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|3023799007|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 3RRcDK9vEBwv+Zu6xn2dgbKX8mWSyNvn5Qxx02H55wppcP6nE3SUQR1CTifpCxrvMx0THGQlqLVoP44rSz6l5fEvhw/B7joo9B7pffHK4ceYN3qv2zjIaPOiqVBdhPyuYbE7+GnGkn4Z+lMwd4jXk7SPdPlzL+9VOK1R3ZWgEH0Vc0R6FRhgZbyfg10EUaXAsCuamyZmj4DML07qvyYWSMlzJ3YZmtbq9NsX4SBBhyTnOk1D1xdQrLgJNEiiPrgbe3hHfztrsmzcNjyQE5WODyJTqzUZlqFdk50SdomL5CmeVWP/1ulJznOFOMHYsOPK3llf/DuSjlZWF+lYmAvJDaxpBgzdFhWgtO0Ivy27HP82TdgOgHHzhNI/+Dm+ur5VfJ2EeEb/l4QrxPrnKqo+puWvMUGSOnsYF72tgCJcANanN9Twi3wAMZ6MJxGCGwxInRW674uBNJEzYpyoKQHRyL8x2D32txWkyKGiL+VKJ3m1fiitdPVrIXTa4R9EkFbXeXEpJdek7HelIYmaE2aePJA4l5GTvEM+9aHoF3OWBHsMJpFDBSrPrJwC41lP71yt/EUBVQwJk17ahDzisDvZ5DiBjrVNTG4hcogqZKrstKwV+h8kGBLwBjdGPp00AFuDA/PZHK9UTW2Cg2JVNbI6MSvB7N4UoS16qcyBOJbRWYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdSZXU3Ynl6V3ZtUmFzSVMwVkptSXZTYnlvZjNPM1VHa28vZW1nODRta1Bp?=
 =?utf-8?B?TkRrRlJqZmFXRGFDd041NElrWWlDSnlqcHlwZjNmUWdrQ3JSYWY1ZUFFWGZh?=
 =?utf-8?B?NW1RNk0xbjBjMUl5RnNvWGE2bmloN1dOeWJ4bmgvWjVuY3dJQ0xrbU9kQ0J5?=
 =?utf-8?B?aFVHZlk1eWJ2RkpkY0l3Sjh2azZDRjBuUCtFbnZFbTlyZml2cjdNNVNBb3pu?=
 =?utf-8?B?Y0pjM0ZuTVZJaEEzTWlVT0VXMlJXbXdOYXo2V1ByanVtSm5qcVR6Y0NIaEdH?=
 =?utf-8?B?V3pIdlR6eVpacTI1Q25MdGV1dW1MZjhwa1UxWFprVG9XSEhlbm5YaHgxYXBX?=
 =?utf-8?B?d3AxaWFrSS93OEMvNGk2b1VSU3JLaGw2M2haeldhMytMeWxKL25vdWZ0QWJP?=
 =?utf-8?B?NDV1Qk9uYjgwZEtjMmJFU3hiUDg0anVRcHVYYmtrb2xsQzE1L2hUeG5vMSt5?=
 =?utf-8?B?dVcwMFM1dXJBZFVScGlKdmZOUDNjejR1ZVo0SkZqdmNnTndiRFhGNTRvb2pP?=
 =?utf-8?B?Nk4wRVFDbWZhNW80SXJQd1NxNERNQmNLK1Nmc0RKRFU0NFh3YXVVdWhPSGhn?=
 =?utf-8?B?N2hySXN4a2duMkxtYk0rSGh3bFlWdnNrVWNtT3RKOUxNOHo4cndRbDFCTHVJ?=
 =?utf-8?B?NGpUQjF0M0prU0kyZmFkYlBXR0hHWm5seUtWc0tENWY2dmQ3andZYSs0N1Fm?=
 =?utf-8?B?dGN6RzY1MnpwWSt3cHVhTGw2a0dHZ3NtYlJVRE5WejJYcEovQWI2cjNKQXB6?=
 =?utf-8?B?R3gvTytKd2Z2WEthQUF3dVdRR3VFNS93bG9TRGIvYTNnZ1VsQVluYW95UkJt?=
 =?utf-8?B?V2p4OEFqMVREUXlCN0g0UUN4MjNyR1E2b3VTQUtvOW1MSmpNaW1meUlpTjFS?=
 =?utf-8?B?TnZleVFXR2pkcHZRVmFmOVJwQ2NuaEQ5OUIzSkZlQ00vM0hSZnQwckNKMUpN?=
 =?utf-8?B?TnBDV3FXK3hvelBZY3ZHQThZK3VWNjdYRjh2dWdOQzRUSmQrUWNDekhtVlBo?=
 =?utf-8?B?c1VDUWJzQk9vL3FidVBzUS9tbkhsdGt5akE3SzZET0FEQXJoZ0lndjBhVzJP?=
 =?utf-8?B?ZFA3UWdER0xuZlF6UW1FZ0s2ZGY5ajQ1U2lXZXlJZEhrclZnaU1EejV6Z2xM?=
 =?utf-8?B?QzNNcWtNUzBYOEpFbFJBMTZxU3pGU3lIaElqdnFPaUJyMlZwTU4yK2tTOG12?=
 =?utf-8?B?cXRjUWZMUUMxR0d5NWwrT2lvZm52ZCtHbUFONVY4M3FrSlVydXdNSitQV1lp?=
 =?utf-8?B?eTRUL21mcmZXQWxuK0VSZVc4Z09pL0wxNUV4RTJLSUFSR3lpQ1ZFa0hrZFRo?=
 =?utf-8?B?VGZ4WVlqQTFjWGwzbEd5YzViNWpjMlhRSCtGam9haWdMNCtCeDIwdVFqN1p0?=
 =?utf-8?B?STZnUGIyVGVxOTF1MEF6WVBGVkU4VWpEKzNjY1VqdUp6V244K1YrOFdrSExk?=
 =?utf-8?B?Ym96K1RRMkJ4RDArUmNjRXNWNkZIdUYyNFhoYWZnMTJqN0VzNVMyNWNJNS9W?=
 =?utf-8?B?N3lwN2dDRzFzSHNIY21JM25pcFloWldZeEtLR0lnTVdNWlczaXZNMDlubkVG?=
 =?utf-8?B?V0JLVHc2RkxlSC91OVhPZXFDWE5CUFFsSHJXNEEzWjJVTWFhVFdSbjhJMEtQ?=
 =?utf-8?B?c3kvdzRETDVOQUlEa0hHVDF2TXdVaGxLZ2VvanlIUXdxT1VGM2ZVTG4zbVdh?=
 =?utf-8?B?cWZrRlVTbU51L2lheEhtU1VlOUZCRlJLWUZ5aXJtbFRaRUFSazVtVXU0SnZZ?=
 =?utf-8?B?VXk0NGZJd203WHJPc3o5azZuemZzbFEvQjVzOVREQ2E0ZUFGa21IZFJpYVZB?=
 =?utf-8?B?M21wbnh0emNiZ0cwSkY3a3dGdkF5K0Z2c1g4bTY1MHZXYnlQdFBvZG9LajNm?=
 =?utf-8?B?K1A4dGdtaDlHd2cybzRJbE5Ea1Mrd2wxSGpodTZqS2MweWFkYWV5ZXZ5bkh0?=
 =?utf-8?B?cHdhYkEvZlk5L0NaeFhXSzZ5SFBuaEdVcjd2R2w0d0JkSS9RMzBET1hZOWZB?=
 =?utf-8?B?ekIvalBKVDdYYUNWZmZzUzVaalRUSXFPK0hpV2VZNkhkWVJHUHRQbWNybm9T?=
 =?utf-8?B?a3ZKZCtJS25UdTBKTGJqSkh4b3lyKzVMZHh1bmtHdE0xQjZ5Y1J0MjNhOFhp?=
 =?utf-8?B?N0NoTVkrR3NwRUVHeGRMM2xKbjBLQzRNLzhJRFJYNThBRm9kVlNEVGI4MGNG?=
 =?utf-8?B?OUY3d0JMK3ROK3E4MmtBSG50UXRKVHlvamVseXBJakhoaEgyOFZBbWhhUkpl?=
 =?utf-8?B?REIvZFlRQ2ZzZDVnRUJUaTZ3QngvT2E5bkwzYkZONFZXTis5aElzUExxaWtM?=
 =?utf-8?Q?NBBW5/maMdIPG4dEu6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a25203e-9281-4e5b-e655-08ded3aa5372
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 17:42:43.2682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuGIXXfWo03ftOt7as6lCG8YiM2eYh8oX1w/l0T1GeZEX+ImFlkfQgf+KB9b+z1z4+gLTaXQxzsIav6meTCdtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
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



On 6/21/26 13:01, Oz Tiram wrote:
> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
> before giving up:
> 
>    1. ACPI VFCT table
>    2. VRAM BAR read
>    3. ROM BAR read
>    4. platform BIOS
> 
> On some systems all four fail:

That's pretty odd to me.  Isn't this a BIOS bug?  Can you share more 
about why all of these are failing?

Does the UEFI GOP driver work?

> 
>    - The VFCT table is absent or contains only the discrete GPU entry
>      (e.g. when a custom ACPI override is present for the dGPU only).
>    - The VRAM BAR is unmapped at probe time.
>    - The ROM BAR is zero (PCI firmware did not assign it; observed even
>      with pci=realloc,assign-busses).
>    - No platform BIOS mapping exists.
> 
> The driver then prints "Unable to locate a BIOS ROM" and refuses to
> bind, leaving the APU completely unusable under Linux even though the
> hardware is functional.
> 
> Add a fifth fallback: request a firmware file named
> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
> request_firmware().  This allows a VBIOS image extracted from the
> running hardware 

I thought you just said this didn't work.  How did you extract it?

> to be shipped as a firmware blob in /lib/firmware/ and
> makes the binding succeed without any change to the ACPI tables.
> 
> The fallback is only reached if all existing paths have already failed,
> so there is no regression risk for boards where VFCT or ROM BAR work.
> 
> Signed-off-by: Oz Tiram <oz@shift-computing.de>
> ---
> v2: Validate the fetched firmware with check_atom_bios() before accepting
>      it, consistent with all other VBIOS discovery paths.  Save fw->size
>      before release_firmware() so it remains valid for the size check.
>      Release the buffer via amdgpu_bios_release() if validation fails.
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

