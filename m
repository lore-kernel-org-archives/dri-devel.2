Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A711CC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD5D10E5DB;
	Wed,  8 Jul 2026 13:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shift-computing.de header.i=@shift-computing.de header.b="yBAcjNRw";
	dkim-atps=neutral
Received: from mail.teamster.cloud (mail.teamster.cloud [213.136.73.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972F610E110;
 Wed,  8 Jul 2026 13:10:32 +0000 (UTC)
Content-Type: multipart/alternative;
 boundary="------------CCDUz4vjeoeh1Zq5hUI00ac0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shift-computing.de;
 s=dkim; t=1783516230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1306caePV0eL3QTcHMb8P2hoRGdgLrKRtCqXS5HIOPw=;
 b=yBAcjNRwOBHW3C+CT0I/7QuJXY5Y1e6ZtsbQpowW4dSwrrISNVIV8KurHWEQ42BKI14p2r
 3m0BX3xglJrP3JYPaaMOieWaeVhJGbrgkFU0jkb/t6jiQQ+bwyasKlTBrWXAK4kmzw6exx
 FN590J4chxsDSkkGVlNo/XUQi4k++6+nb82OICpiKBolH86lZmyP6Rgj6SnpDy7nVh9NCo
 iedWfONBjPLZNnKXNzirT2QXHHKeGbQ3tYU1kPgmWVhLSyYxkl7WYdGkYk5u2x37tu36Ky
 3bOP9GnoePOpm3tYx+7lfGoSO0Ey3woEPsWJ6KyXyHHAe8eWspmc1g8KXMewYw==
Authentication-Results: mail.teamster.cloud;
 auth=pass smtp.mailfrom=oz@shift-computing.de
Message-ID: <cc849fb3-224e-43c0-bc50-67fd025009e7@shift-computing.de>
Date: Wed, 8 Jul 2026 15:10:08 +0200
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
 <42e07bbb-9384-4871-a345-e0fd6c00a772@shift-computing.de>
 <bd1f1632-f53d-4bfd-9d28-5b66e466366c@amd.com>
 <80f34509-9781-421e-b60f-1b8c772a01a9@shift-computing.de>
 <8dd56d76-e46d-43b6-831d-27e66fa2879a@amd.com>
From: Oz Tiram <oz@shift-computing.de>
In-Reply-To: <8dd56d76-e46d-43b6-831d-27e66fa2879a@amd.com>
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

This is a multi-part message in MIME format.
--------------CCDUz4vjeoeh1Zq5hUI00ac0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mario,

 > If you drop that - does this notice still come up?

No, the notice does not appear without pci=realloc,assign-busses. The 
iGPU  stays at its POST bus (0x6A = 106), VFCT matches directly, and it 
fetches the VBIOS without any mismatch.

However, dropping the kernel argument is not an option on this machine:
without it the discrete GPU (0x7449) fails to probe entirely:

   amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
   amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -12

The firmware BARs cannot be mapped without resource reallocation, so
pci=realloc,assign-busses is required for the dGPU, which in turn reassigns
the iGPU to bus 0x0B and triggers the mismatch your patch resolves.


Thank you,

Oz


On 7/8/26 14:55, Mario Limonciello wrote:
> Hi Oz,
>
> On 7/8/26 07:36, Oz Tiram wrote:
>> Hi Mario,
>>
>> Tested on a Morefine MNAS X1 AI Workstation (AMD Ryzen 7 Pro 8845HS / 
>> Radeon 780M iGPU) with pci=realloc,assign-busses.
>>
>> The VFCT entry for the iGPU has PCIBus=106 (0x6A, recorded at POST) 
>> while the
>> runtime bus is 11 (0x0B). Your patch fires exactly as expected:
>>
>>    amdgpu 0000:0b:00.0: amdgpu: VFCT bus number mismatch: table 106 
>> != runtime 11,
>>        matching by device identity (vendor 0x1002 device 0x1900)
>>    amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
>>
>> The iGPU initialises fully and drives the framebuffer.
>>
>> One minor nit: the dev_notice format string ends with \\n (two 
>> characters) rather
>> than \n. The resulting kernel message has a literal "\n" at the end. 
>> Same issue
>> exists in the nearby "too short #2" dev_info -- not introduced by 
>> your patch, but
>> might be worth cleaning up.
>>
>> Tested-by: Oz Tiram <oz@shift-computing.de>
>>
>
> Thanks for confirming.  Before I split up this patch and post it in 
> smaller logical pieces can you confirm my proposed root cause is right 
> that this issue happens because "pci=realloc,assign-busses" was on 
> your kernel command line?
>
> If you drop that - does this notice still come up?
>
> Thanks,
>
>> On 7/6/26 02:56, Mario Limonciello wrote:
>>>
>>>
>>> On 7/5/26 14:10, Oz Tiram wrote:
>>>> Hi Mario,
>>>>
>>>>    To make sure I understand correctly: are you suggesting that the 
>>>> bus
>>>>    number in the VFCT was legitimate at BIOS POST time, and that
>>>>    pci=realloc,assign-busses is what changes it at runtime, causing 
>>>> the
>>>>    mismatch?
>>>
>>> That's what it sounds like right now.  You can easily drop all the 
>>> superfluous kernel command line optiosn and see.
>>>
>>>>
>>>>    I'm not familiar enough with the PCI subsystem to know the right 
>>>> way to
>>>>    implement that — could you point me in the right direction?
>>>
>>> Well there's a variety of ways to do it.  But how about we start 
>>> here - if we make that specific busnr match optional and instead 
>>> make a VID/DID match.
>>>
>>> See if the attached patch helps.
>>>
>>>>
>>>>    Oz
>>>>
>>>> On 7/5/26 20:37, Mario Limonciello wrote:
>>>>>
>>>>>
>>>>> On 7/5/26 05:04, Oz Tiram wrote:
>>>>>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
>>>>>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
>>>>>> before giving up:
>>>>>>
>>>>>>    1. ACPI VFCT table
>>>>>>    2. VRAM BAR read
>>>>>>    3. ROM BAR read
>>>>>>    4. platform BIOS
>>>>>>
>>>>>> On some systems all four fail.  The specific case motivating this 
>>>>>> patch
>>>>>> is a hybrid graphics machine (dGPU + APU) where:
>>>>>>
>>>>>>    - The VFCT table contains the iGPU entry but with a stale 
>>>>>> PCIBus value
>>>>>>      from BIOS POST time (0x6A).  When the kernel boots with
>>>>>>      pci=realloc,assign-busses, PCI bus numbers are reassigned 
>>>>>> dynamically
>>>>>>      and the iGPU lands on bus 0x0B at runtime. 
>>>>>> amdgpu_acpi_vfct_bios()
>>>>>>      matches entries by bus number, so the entry is never found.
>>>>>>    - The VRAM BAR is unmapped at probe time.
>>>>>>    - The ROM BAR is zero (PCI firmware did not assign it).
>>>>>>    - No platform BIOS mapping exists.
>>>>>>
>>>>>> The UEFI GOP driver initialises the iGPU successfully for early 
>>>>>> display,
>>>>>> confirming the hardware is functional.  The VBIOS image data 
>>>>>> embedded in
>>>>>> the VFCT is also valid; only the PCIBus metadata is wrong.
>>>>>
>>>>> So the BIOS on this machine is actually totally fine; it's just 
>>>>> when the kernel is booted to reassign busses there is a problem?
>>>>>
>>>>> In that case; why not detect the kernel was booted this way and 
>>>>> keep track of the original bus number when reassigned to avoid the 
>>>>> issue?
>>>>>
>>>>>> The firmware
>>>>>> file can be extracted directly from the VFCT using dd:
>>>>>>
>>>>>>    dd if=/sys/firmware/acpi/tables/VFCT bs=1 skip=$((0x68)) 
>>>>>> count=16896 \
>>>>>>       of=/lib/firmware/amdgpu/1002_1900.bin
>>>>>>
>>>>>> (0x68 is the byte offset of the VBIOS image after the ACPI table 
>>>>>> header
>>>>>> and VFCT_IMAGE_HEADER; the image length 16896 comes from the 
>>>>>> ImageLength
>>>>>> field in VFCT_IMAGE_HEADER.)
>>>>>>
>>>>>> The driver then prints "Unable to locate a BIOS ROM" and refuses to
>>>>>> bind, leaving the APU completely unusable under Linux.
>>>>>>
>>>>>> Add a fifth fallback: request a firmware file named
>>>>>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
>>>>>> request_firmware().  This allows a VBIOS image extracted as above 
>>>>>> to be
>>>>>> placed in /lib/firmware/ and makes the binding succeed without 
>>>>>> patching
>>>>>> ACPI tables or BIOS.
>>>>>>
>>>>>> The fallback is only reached if all existing paths have already 
>>>>>> failed,
>>>>>> so there is no regression risk for boards where VFCT or ROM BAR 
>>>>>> work.
>>>>>
>>>>> What happens if the VBIOS changes in another way one boot to 
>>>>> another? You might have some other stateful information that isn't 
>>>>> updated.
>>>>>
>>>>> The whole thing to me feels like a hack for a behavior we can 
>>>>> control in the kernel when doing reassignments.
>>>>>>
>>>>>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
>>>>>> ---
>>>>>> v2: Fix commit message: clarify that VFCT contains the iGPU entry 
>>>>>> but
>>>>>>      with a stale PCIBus from BIOS POST that mismatches the 
>>>>>> runtime bus
>>>>>>      number assigned by pci=realloc,assign-busses. Explain that 
>>>>>> the VBIOS
>>>>>>      image data is valid and document the dd extraction command 
>>>>>> and byte
>>>>>>      offsets.  Note that the UEFI GOP driver initialises the iGPU
>>>>>>      successfully, confirming the hardware is functional.
>>>>>>
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 
>>>>>> +++++++++++++++++++ ++++
>>>>>>   1 file changed, 23 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/ 
>>>>>> gpu/ drm/amd/amdgpu/amdgpu_bios.c
>>>>>> index aa039e148a5e..86064c753b09 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>>>>> @@ -26,6 +26,7 @@
>>>>>>    *          Jerome Glisse
>>>>>>    */
>>>>>>   +#include <linux/firmware.h>
>>>>>>   #include "amdgpu.h"
>>>>>>   #include "atom.h"
>>>>>>   @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct 
>>>>>> amdgpu_device *adev)
>>>>>>           goto success;
>>>>>>       }
>>>>>>   +    {
>>>>>> +        const struct firmware *fw;
>>>>>> +        char fw_name[32];
>>>>>> +        size_t fw_size;
>>>>>> +
>>>>>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin",
>>>>>> +             adev->pdev->vendor, adev->pdev->device);
>>>>>> +        if (request_firmware(&fw, fw_name, adev->dev) == 0) {
>>>>>> +            adev->bios = kmemdup(fw->data, fw->size, GFP_KERNEL);
>>>>>> +            fw_size = fw->size;
>>>>>> +            release_firmware(fw);
>>>>>> +            if (!adev->bios || !check_atom_bios(adev, fw_size)) {
>>>>>> +                amdgpu_bios_release(adev);
>>>>>> +            } else {
>>>>>> +                adev->bios_size = fw_size;
>>>>>> +                dev_info(adev->dev, "Fetched VBIOS from firmware 
>>>>>> file %s\n",
>>>>>> +                     fw_name);
>>>>>> +                goto success;
>>>>>> +            }
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>>       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
>>>>>>       return false;
>>>>>
>
--------------CCDUz4vjeoeh1Zq5hUI00ac0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    Hi Mario,                                                           
                                                                       
                                     <br>
    <br>
    &gt; If you drop that - does this notice still come up?
                                                                       
                                                                       
                                  <br>
    <p>No, the notice does not appear without pci=realloc,assign-busses.
      The iGPU  stays at its POST bus (0x6A = 106), VFCT matches
      directly, and it fetches the VBIOS without any mismatch.         
                                                                       
                                                                     </p>
    However, dropping the kernel argument is not an option on this
    machine:<br>
    without it the discrete GPU (0x7449) fails to probe entirely:<br>
    <br>
      amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init<br>
      amdgpu 0000:03:00.0: probe with driver amdgpu failed with error
    -12<br>
    <br>
    The firmware BARs cannot be mapped without resource reallocation, so<br>
    pci=realloc,assign-busses is required for the dGPU, which in turn
    reassigns<br>
    the iGPU to bus 0x0B and triggers the mismatch your patch resolves.<br>
    <br>
    <br>
    Thank you, <br>
    <br>
    Oz
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/8/26 14:55, Mario Limonciello
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:8dd56d76-e46d-43b6-831d-27e66fa2879a@amd.com">Hi Oz,
      <br>
      <br>
      On 7/8/26 07:36, Oz Tiram wrote:
      <br>
      <blockquote type="cite">Hi Mario,
        <br>
        <br>
        Tested on a Morefine MNAS X1 AI Workstation (AMD Ryzen 7 Pro
        8845HS / Radeon 780M iGPU) with pci=realloc,assign-busses.
        <br>
        <br>
        The VFCT entry for the iGPU has PCIBus=106 (0x6A, recorded at
        POST) while the
        <br>
        runtime bus is 11 (0x0B). Your patch fires exactly as expected:
        <br>
        <br>
           amdgpu 0000:0b:00.0: amdgpu: VFCT bus number mismatch: table
        106 != runtime 11,
        <br>
               matching by device identity (vendor 0x1002 device 0x1900)
        <br>
           amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
        <br>
        <br>
        The iGPU initialises fully and drives the framebuffer.
        <br>
        <br>
        One minor nit: the dev_notice format string ends with \\n (two
        characters) rather
        <br>
        than \n. The resulting kernel message has a literal "\n" at the
        end. Same issue
        <br>
        exists in the nearby "too short #2" dev_info -- not introduced
        by your patch, but
        <br>
        might be worth cleaning up.
        <br>
        <br>
        Tested-by: Oz Tiram <a class="moz-txt-link-rfc2396E" href="mailto:oz@shift-computing.de">&lt;oz@shift-computing.de&gt;</a>
        <br>
        <br>
      </blockquote>
      <br>
      Thanks for confirming.  Before I split up this patch and post it
      in smaller logical pieces can you confirm my proposed root cause
      is right that this issue happens because
      "pci=realloc,assign-busses" was on your kernel command line?
      <br>
      <br>
      If you drop that - does this notice still come up?
      <br>
      <br>
      Thanks,
      <br>
      <br>
      <blockquote type="cite">On 7/6/26 02:56, Mario Limonciello wrote:
        <br>
        <blockquote type="cite">
          <br>
          <br>
          On 7/5/26 14:10, Oz Tiram wrote:
          <br>
          <blockquote type="cite">Hi Mario,
            <br>
            <br>
               To make sure I understand correctly: are you suggesting
            that the bus
            <br>
               number in the VFCT was legitimate at BIOS POST time, and
            that
            <br>
               pci=realloc,assign-busses is what changes it at runtime,
            causing the
            <br>
               mismatch?
            <br>
          </blockquote>
          <br>
          That's what it sounds like right now.  You can easily drop all
          the superfluous kernel command line optiosn and see.
          <br>
          <br>
          <blockquote type="cite">
            <br>
               I'm not familiar enough with the PCI subsystem to know
            the right way to
            <br>
               implement that — could you point me in the right
            direction?
            <br>
          </blockquote>
          <br>
          Well there's a variety of ways to do it.  But how about we
          start here - if we make that specific busnr match optional and
          instead make a VID/DID match.
          <br>
          <br>
          See if the attached patch helps.
          <br>
          <br>
          <blockquote type="cite">
            <br>
               Oz
            <br>
            <br>
            On 7/5/26 20:37, Mario Limonciello wrote:
            <br>
            <blockquote type="cite">
              <br>
              <br>
              On 7/5/26 05:04, Oz Tiram wrote:
              <br>
              <blockquote type="cite">APUs (e.g. AMD Radeon 780M /
                HawkPoint, PCI 1002:1900) have no
                <br>
                dedicated VBIOS ROM chip.  amdgpu_get_bios_apu()
                attempts four paths
                <br>
                before giving up:
                <br>
                <br>
                   1. ACPI VFCT table
                <br>
                   2. VRAM BAR read
                <br>
                   3. ROM BAR read
                <br>
                   4. platform BIOS
                <br>
                <br>
                On some systems all four fail.  The specific case
                motivating this patch
                <br>
                is a hybrid graphics machine (dGPU + APU) where:
                <br>
                <br>
                   - The VFCT table contains the iGPU entry but with a
                stale PCIBus value
                <br>
                     from BIOS POST time (0x6A).  When the kernel boots
                with
                <br>
                     pci=realloc,assign-busses, PCI bus numbers are
                reassigned dynamically
                <br>
                     and the iGPU lands on bus 0x0B at runtime.
                amdgpu_acpi_vfct_bios()
                <br>
                     matches entries by bus number, so the entry is
                never found.
                <br>
                   - The VRAM BAR is unmapped at probe time.
                <br>
                   - The ROM BAR is zero (PCI firmware did not assign
                it).
                <br>
                   - No platform BIOS mapping exists.
                <br>
                <br>
                The UEFI GOP driver initialises the iGPU successfully
                for early display,
                <br>
                confirming the hardware is functional.  The VBIOS image
                data embedded in
                <br>
                the VFCT is also valid; only the PCIBus metadata is
                wrong.
                <br>
              </blockquote>
              <br>
              So the BIOS on this machine is actually totally fine; it's
              just when the kernel is booted to reassign busses there is
              a problem?
              <br>
              <br>
              In that case; why not detect the kernel was booted this
              way and keep track of the original bus number when
              reassigned to avoid the issue?
              <br>
              <br>
              <blockquote type="cite">The firmware
                <br>
                file can be extracted directly from the VFCT using dd:
                <br>
                <br>
                   dd if=/sys/firmware/acpi/tables/VFCT bs=1
                skip=$((0x68)) count=16896 \
                <br>
                      of=/lib/firmware/amdgpu/1002_1900.bin
                <br>
                <br>
                (0x68 is the byte offset of the VBIOS image after the
                ACPI table header
                <br>
                and VFCT_IMAGE_HEADER; the image length 16896 comes from
                the ImageLength
                <br>
                field in VFCT_IMAGE_HEADER.)
                <br>
                <br>
                The driver then prints "Unable to locate a BIOS ROM" and
                refuses to
                <br>
                bind, leaving the APU completely unusable under Linux.
                <br>
                <br>
                Add a fifth fallback: request a firmware file named
                <br>
                "amdgpu/&lt;vendor&gt;_&lt;device&gt;.bin" (e.g.
                "amdgpu/1002_1900.bin") via
                <br>
                request_firmware().  This allows a VBIOS image extracted
                as above to be
                <br>
                placed in /lib/firmware/ and makes the binding succeed
                without patching
                <br>
                ACPI tables or BIOS.
                <br>
                <br>
                The fallback is only reached if all existing paths have
                already failed,
                <br>
                so there is no regression risk for boards where VFCT or
                ROM BAR work.
                <br>
              </blockquote>
              <br>
              What happens if the VBIOS changes in another way one boot
              to another? You might have some other stateful information
              that isn't updated.
              <br>
              <br>
              The whole thing to me feels like a hack for a behavior we
              can control in the kernel when doing reassignments.
              <br>
              <blockquote type="cite">
                <br>
                Signed-off-by: Oz Tiram <a class="moz-txt-link-rfc2396E" href="mailto:oz@shift-computing.de">&lt;oz@shift-computing.de&gt;</a>
                <br>
                ---
                <br>
                v2: Fix commit message: clarify that VFCT contains the
                iGPU entry but
                <br>
                     with a stale PCIBus from BIOS POST that mismatches
                the runtime bus
                <br>
                     number assigned by pci=realloc,assign-busses. 
                Explain that the VBIOS
                <br>
                     image data is valid and document the dd extraction
                command and byte
                <br>
                     offsets.  Note that the UEFI GOP driver initialises
                the iGPU
                <br>
                     successfully, confirming the hardware is
                functional.
                <br>
                <br>
                  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23
                +++++++++++++++++++ ++++
                <br>
                  1 file changed, 23 insertions(+)
                <br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
                b/drivers/ gpu/ drm/amd/amdgpu/amdgpu_bios.c
                <br>
                index aa039e148a5e..86064c753b09 100644
                <br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
                <br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
                <br>
                @@ -26,6 +26,7 @@
                <br>
                   *          Jerome Glisse
                <br>
                   */
                <br>
                  +#include &lt;linux/firmware.h&gt;
                <br>
                  #include "amdgpu.h"
                <br>
                  #include "atom.h"
                <br>
                  @@ -457,6 +458,28 @@ static bool
                amdgpu_get_bios_apu(struct amdgpu_device *adev)
                <br>
                          goto success;
                <br>
                      }
                <br>
                  +    {
                <br>
                +        const struct firmware *fw;
                <br>
                +        char fw_name[32];
                <br>
                +        size_t fw_size;
                <br>
                +
                <br>
                +        snprintf(fw_name, sizeof(fw_name),
                "amdgpu/%04x_%04x.bin",
                <br>
                +             adev-&gt;pdev-&gt;vendor,
                adev-&gt;pdev-&gt;device);
                <br>
                +        if (request_firmware(&amp;fw, fw_name,
                adev-&gt;dev) == 0) {
                <br>
                +            adev-&gt;bios = kmemdup(fw-&gt;data,
                fw-&gt;size, GFP_KERNEL);
                <br>
                +            fw_size = fw-&gt;size;
                <br>
                +            release_firmware(fw);
                <br>
                +            if (!adev-&gt;bios ||
                !check_atom_bios(adev, fw_size)) {
                <br>
                +                amdgpu_bios_release(adev);
                <br>
                +            } else {
                <br>
                +                adev-&gt;bios_size = fw_size;
                <br>
                +                dev_info(adev-&gt;dev, "Fetched VBIOS
                from firmware file %s\n",
                <br>
                +                     fw_name);
                <br>
                +                goto success;
                <br>
                +            }
                <br>
                +        }
                <br>
                +    }
                <br>
                +
                <br>
                      dev_err(adev-&gt;dev, "Unable to locate a BIOS
                ROM\n");
                <br>
                      return false;
                <br>
              </blockquote>
              <br>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------CCDUz4vjeoeh1Zq5hUI00ac0--
