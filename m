Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7447C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1623C10E1AC;
	Sun,  5 Jul 2026 19:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shift-computing.de header.i=@shift-computing.de header.b="RcM2Qs2o";
	dkim-atps=neutral
Received: from mail.teamster.cloud (mail.teamster.cloud [213.136.73.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96B110E1AC;
 Sun,  5 Jul 2026 19:11:30 +0000 (UTC)
Message-ID: <42e07bbb-9384-4871-a345-e0fd6c00a772@shift-computing.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shift-computing.de;
 s=dkim; t=1783278687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eIbBif1E3L3kt400WoRaCxmz8+S79E+m8Ey7hk301xo=;
 b=RcM2Qs2oOFtWFLYIAQAR1cTyS7h3jjcSjBP9b05ZUY/Ww2wi6fJ4+AwtvAGpp0dQBCg93i
 o75Kf+1tOfLcNO+hKl8FYGf4Dgo9c48NaRPnfgQ8k184kE8ggbrlbpsRTShp4TMRlN2WDR
 jz3Kp7Bkzh/VrnbArCdlW0xurP/QX6xg7dfPRqPq3zqQRBoNhHFJoiVvt5KMXZ8JX6tnjY
 /cTsHceGtWAs4AfuXSHEvhGf2FWMJOO3xk5rSoXSqTe8wYWwOdQ+0k6nCAxFfKIjob7626
 L5LM2yccprjCw23XCa8ShFya4CzgLRSK8XScV6YskXAvIFp5rM0traou+bstxA==
Authentication-Results: mail.teamster.cloud;
 auth=pass smtp.mailfrom=oz@shift-computing.de
Date: Sun, 5 Jul 2026 21:10:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
 <20260705100436.6877-1-oz@shift-computing.de>
 <a8339282-e3ef-4a4f-a135-968f94855e76@amd.com>
From: Oz Tiram <oz@shift-computing.de>
In-Reply-To: <a8339282-e3ef-4a4f-a135-968f94855e76@amd.com>
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

   To make sure I understand correctly: are you suggesting that the bus
   number in the VFCT was legitimate at BIOS POST time, and that
   pci=realloc,assign-busses is what changes it at runtime, causing the
   mismatch?

   I'm not familiar enough with the PCI subsystem to know the right way to
   implement that — could you point me in the right direction?

   Oz

On 7/5/26 20:37, Mario Limonciello wrote:
>
>
> On 7/5/26 05:04, Oz Tiram wrote:
>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
>> before giving up:
>>
>>    1. ACPI VFCT table
>>    2. VRAM BAR read
>>    3. ROM BAR read
>>    4. platform BIOS
>>
>> On some systems all four fail.  The specific case motivating this patch
>> is a hybrid graphics machine (dGPU + APU) where:
>>
>>    - The VFCT table contains the iGPU entry but with a stale PCIBus 
>> value
>>      from BIOS POST time (0x6A).  When the kernel boots with
>>      pci=realloc,assign-busses, PCI bus numbers are reassigned 
>> dynamically
>>      and the iGPU lands on bus 0x0B at runtime. amdgpu_acpi_vfct_bios()
>>      matches entries by bus number, so the entry is never found.
>>    - The VRAM BAR is unmapped at probe time.
>>    - The ROM BAR is zero (PCI firmware did not assign it).
>>    - No platform BIOS mapping exists.
>>
>> The UEFI GOP driver initialises the iGPU successfully for early display,
>> confirming the hardware is functional.  The VBIOS image data embedded in
>> the VFCT is also valid; only the PCIBus metadata is wrong.
>
> So the BIOS on this machine is actually totally fine; it's just when 
> the kernel is booted to reassign busses there is a problem?
>
> In that case; why not detect the kernel was booted this way and keep 
> track of the original bus number when reassigned to avoid the issue?
>
>> The firmware
>> file can be extracted directly from the VFCT using dd:
>>
>>    dd if=/sys/firmware/acpi/tables/VFCT bs=1 skip=$((0x68)) 
>> count=16896 \
>>       of=/lib/firmware/amdgpu/1002_1900.bin
>>
>> (0x68 is the byte offset of the VBIOS image after the ACPI table header
>> and VFCT_IMAGE_HEADER; the image length 16896 comes from the ImageLength
>> field in VFCT_IMAGE_HEADER.)
>>
>> The driver then prints "Unable to locate a BIOS ROM" and refuses to
>> bind, leaving the APU completely unusable under Linux.
>>
>> Add a fifth fallback: request a firmware file named
>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
>> request_firmware().  This allows a VBIOS image extracted as above to be
>> placed in /lib/firmware/ and makes the binding succeed without patching
>> ACPI tables or BIOS.
>>
>> The fallback is only reached if all existing paths have already failed,
>> so there is no regression risk for boards where VFCT or ROM BAR work.
>
> What happens if the VBIOS changes in another way one boot to another? 
> You might have some other stateful information that isn't updated.
>
> The whole thing to me feels like a hack for a behavior we can control 
> in the kernel when doing reassignments.
>>
>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
>> ---
>> v2: Fix commit message: clarify that VFCT contains the iGPU entry but
>>      with a stale PCIBus from BIOS POST that mismatches the runtime bus
>>      number assigned by pci=realloc,assign-busses.  Explain that the 
>> VBIOS
>>      image data is valid and document the dd extraction command and byte
>>      offsets.  Note that the UEFI GOP driver initialises the iGPU
>>      successfully, confirming the hardware is functional.
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
