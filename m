Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D486EC44500
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 10:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3948510E18C;
	Sun,  5 Jul 2026 10:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shift-computing.de header.i=@shift-computing.de header.b="e1ZJaISb";
	dkim-atps=neutral
Received: from mail.teamster.cloud (mail.teamster.cloud [213.136.73.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C96710E18C;
 Sun,  5 Jul 2026 10:16:19 +0000 (UTC)
Message-ID: <3e2a862d-53b5-45b8-9c00-08d3e69b0508@shift-computing.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shift-computing.de;
 s=dkim; t=1783246576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VriRytiQr29dirxj3h6p1cI/zmJWkfrX2iDUkcXvSxc=;
 b=e1ZJaISbUDRcccPVLfc34+fKgs/XaiOzmxa7gxK9yGA1csK6GP8jTdhihsUiq7lE6Clg/R
 aQ1o2FN5WK9C9QRMnlQ6f7f+QthG+Dts3m0CojYZqrNk9flQdaIRTDz8F+Ix8P+QZVPKel
 FENX+wSSeuIwRVvbEg9Vctv32aDUoOcmRCr0cYMPOYERwBuTG/of59f3Ua48uPSr2qsgP8
 w644leKAHcHZJ1C3MN+oZvrndb+EgeChVJHY/8SO6V6qZePNN6yI3NBW24Hlo1+iMiQh9T
 yJ0Z1cHRRZkenwan9k2bXGJiM3yTTOB6QbyiUgtVXCZIlwEButw8V0nYioon9w==
Authentication-Results: mail.teamster.cloud;
 auth=pass smtp.mailfrom=oz@shift-computing.de
Date: Sun, 5 Jul 2026 12:15:56 +0200
MIME-Version: 1.0
From: Oz Tiram <oz@shift-computing.de>
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260621173211.28443-1-oz@shift-computing.de>
 <20260621180154.30421-1-oz@shift-computing.de>
 <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
Content-Language: en-US
In-Reply-To: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ---
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

Hi Mario,

Sorry for the slow response, I'm new to the kernel contribution process. 
Thanks for the review. v2 addresses your questions: -

The VFCT does contain the iGPU entry, but with a stale PCIBus value from 
BIOS POST time (0x6A). With pci=realloc,assign-busses the iGPU lands on 
bus 0x0B at runtime, so amdgpu_acpi_vfct_bios() never matches it

This is clarified in the commit message along with a note that the UEFI 
GOP driver initializes the iGPU successfully, confirming the hardware is 
functional.

The VBIOS image data in the VFCT is valid — only the PCIBus metadata is 
wrong.

The firmware file was extracted directly from the VFCT with dd, skipping 
past the ACPI header and VFCT_IMAGE_HEADER. The commit message now 
documents the exact command and byte offsets.

The patch follows.

Oz

On 6/26/26 19:42, Mario Limonciello wrote:
>
>
> On 6/21/26 13:01, Oz Tiram wrote:
>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
>> before giving up:
>>
>>    1. ACPI VFCT table
>>    2. VRAM BAR read
>>    3. ROM BAR read
>>    4. platform BIOS
>>
>> On some systems all four fail:
>
> That's pretty odd to me.  Isn't this a BIOS bug?  Can you share more 
> about why all of these are failing?
>
> Does the UEFI GOP driver work?
>
>>
>>    - The VFCT table is absent or contains only the discrete GPU entry
>>      (e.g. when a custom ACPI override is present for the dGPU only).
>>    - The VRAM BAR is unmapped at probe time.
>>    - The ROM BAR is zero (PCI firmware did not assign it; observed even
>>      with pci=realloc,assign-busses).
>>    - No platform BIOS mapping exists.
>>
>> The driver then prints "Unable to locate a BIOS ROM" and refuses to
>> bind, leaving the APU completely unusable under Linux even though the
>> hardware is functional.
>>
>> Add a fifth fallback: request a firmware file named
>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
>> request_firmware().  This allows a VBIOS image extracted from the
>> running hardware 
>
> I thought you just said this didn't work.  How did you extract it?
>
>> to be shipped as a firmware blob in /lib/firmware/ and
>> makes the binding succeed without any change to the ACPI tables.
>>
>> The fallback is only reached if all existing paths have already failed,
>> so there is no regression risk for boards where VFCT or ROM BAR work.
>>
>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
>> ---
>> v2: Validate the fetched firmware with check_atom_bios() before 
>> accepting
>>      it, consistent with all other VBIOS discovery paths. Save fw->size
>>      before release_firmware() so it remains valid for the size check.
>>      Release the buffer via amdgpu_bios_release() if validation fails.
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> index aa039e148a5e..86064c753b09 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> @@ -26,6 +26,7 @@
>>    *          Jerome Glisse
>>    */
>>   +#include <linux/firmware.h>
>>   #include "amdgpu.h"
>>   #include "atom.h"
>>   @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct 
>> amdgpu_device *adev)
>>           goto success;
>>       }
>>   +    {
>> +        const struct firmware *fw;
>> +        char fw_name[32];
>> +        size_t fw_size;
>> +
>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin",
>> +             adev->pdev->vendor, adev->pdev->device);
>> +        if (request_firmware(&fw, fw_name, adev->dev) == 0) {
>> +            adev->bios = kmemdup(fw->data, fw->size, GFP_KERNEL);
>> +            fw_size = fw->size;
>> +            release_firmware(fw);
>> +            if (!adev->bios || !check_atom_bios(adev, fw_size)) {
>> +                amdgpu_bios_release(adev);
>> +            } else {
>> +                adev->bios_size = fw_size;
>> +                dev_info(adev->dev, "Fetched VBIOS from firmware 
>> file %s\n",
>> +                     fw_name);
>> +                goto success;
>> +            }
>> +        }
>> +    }
>> +
>>       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>>       return false;
>
