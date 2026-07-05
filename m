Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA54FC43602
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 10:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9844410E17A;
	Sun,  5 Jul 2026 10:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shift-computing.de header.i=@shift-computing.de header.b="qhch+gqH";
	dkim-atps=neutral
Received: from mail.teamster.cloud (mail.teamster.cloud [213.136.73.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38F610E011;
 Sun,  5 Jul 2026 10:01:42 +0000 (UTC)
Content-Type: multipart/alternative;
 boundary="------------aXquASgd4bfF5C0BLT6MRedz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shift-computing.de;
 s=dkim; t=1783245699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1DWz5iFPQbgOXTbscbgpXgMQyuhwr4aUySyAtckuOzQ=;
 b=qhch+gqHapGnpF3ESkEHyLl8Jfe3MTAcPO40L5KapxJHWpfGaYHILSpzOZAwqRAadbc2LO
 32rGlxFMHm7VuLFAyHMLV4WDHeAbg1nCIl9BfAuEbTCtRud2XOeqLWDGbXnOAkCelkz07Z
 coLUZpC4CqXnu66AmqKUbnV50tp3/syGLp/AdKkwvB5OImSCZJjYOGpPnWhX8CubR4SC4V
 kwG5faxHrKf7kbYAprE/VjUGDjr15soVB/JpiU/8wir7JnpnNf3o42jkISS9tnN8Z9uJ6y
 oaGE+VSPRE3XKjWOpw6fgxqMisMRSPUzqHzXsuk43ndROMWNtJmMQAdOhHHpDg==
Authentication-Results: mail.teamster.cloud;
 auth=pass smtp.mailfrom=oz@shift-computing.de
Message-ID: <1d26dd23-924d-434f-bfb8-34c6c7a5b6e0@shift-computing.de>
Date: Sun, 5 Jul 2026 12:01:19 +0200
MIME-Version: 1.0
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
From: Oz Tiram <oz@shift-computing.de>
In-Reply-To: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
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
--------------aXquASgd4bfF5C0BLT6MRedz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

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
--------------aXquASgd4bfF5C0BLT6MRedz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <font face="monospace">Hi Mario,                                   
                                       <br>
    </font>
    <p><font face="monospace">Sorry for the slow response, I'm new to
        the kernel contribution process.                               
                  </font><font face="monospace">Thanks for the review.
        v2 addresses your questions:                                   
                                    </font><font face="monospace">- </font></p>
    <p><font face="monospace">The VFCT does contain the iGPU entry, but
        with a stale PCIBus value from BIOS POST time (0x6A). With
        pci=realloc,assign-busses the iGPU </font><font face="monospace">lands
        on bus 0x0B at runtime, so amdgpu_acpi_vfct_bios() never
        matches </font><font face="monospace">it</font></p>
    <p><font face="monospace">This is clarified in the commit message
        along with a note that the </font><font face="monospace">UEFI
        GOP driver initializes the iGPU successfully, confirming the </font><font
        face="monospace">hardware is functional.                       
                                                              </font></p>
    <p><font face="monospace">The VBIOS image data in the VFCT is valid
        — only the PCIBus metadata </font><font face="monospace">is
        wrong.</font></p>
    <p><font face="monospace">The firmware file was extracted directly
        from the VFCT with dd, </font><font face="monospace">skipping
        past the ACPI header and VFCT_IMAGE_HEADER. The commit </font><font
        face="monospace">message now documents the exact command and
        byte offsets.</font></p>
    <p><font face="monospace">The patch follows.</font></p>
    <font face="monospace">Oz<br>
      <br>
    </font>
    <div class="moz-cite-prefix"><font face="monospace">On 6/26/26
        19:42, Mario Limonciello wrote:<br>
      </font></div>
    <blockquote type="cite"
      cite="mid:716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com">
      <font face="monospace"><br>
      </font>
      <font face="monospace"><br>
        On 6/21/26 13:01, Oz Tiram wrote:
        <br>
      </font>
      <blockquote type="cite"><font face="monospace">APUs (e.g. AMD
          Radeon 780M / HawkPoint, PCI 1002:1900) have no
          <br>
          dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four
          paths
          <br>
          before giving up:
          <br>
        </font>
        <font face="monospace"><br>
             1. ACPI VFCT table
          <br>
             2. VRAM BAR read
          <br>
             3. ROM BAR read
          <br>
             4. platform BIOS
          <br>
        </font>
        <font face="monospace"><br>
          On some systems all four fail:
          <br>
        </font></blockquote>
      <font face="monospace"><br>
        That's pretty odd to me.  Isn't this a BIOS bug?  Can you share
        more about why all of these are failing?
        <br>
      </font>
      <font face="monospace"><br>
        Does the UEFI GOP driver work?
        <br>
      </font>
      <font face="monospace"><br>
      </font>
      <blockquote type="cite">
        <font face="monospace"><br>
             - The VFCT table is absent or contains only the discrete
          GPU entry
          <br>
               (e.g. when a custom ACPI override is present for the dGPU
          only).
          <br>
             - The VRAM BAR is unmapped at probe time.
          <br>
             - The ROM BAR is zero (PCI firmware did not assign it;
          observed even
          <br>
               with pci=realloc,assign-busses).
          <br>
             - No platform BIOS mapping exists.
          <br>
        </font>
        <font face="monospace"><br>
          The driver then prints "Unable to locate a BIOS ROM" and
          refuses to
          <br>
          bind, leaving the APU completely unusable under Linux even
          though the
          <br>
          hardware is functional.
          <br>
        </font>
        <font face="monospace"><br>
          Add a fifth fallback: request a firmware file named
          <br>
          "amdgpu/&lt;vendor&gt;_&lt;device&gt;.bin" (e.g.
          "amdgpu/1002_1900.bin") via
          <br>
          request_firmware().  This allows a VBIOS image extracted from
          the
          <br>
          running hardware </font></blockquote>
      <font face="monospace"><br>
        I thought you just said this didn't work.  How did you extract
        it?
        <br>
      </font>
      <font face="monospace"><br>
      </font>
      <blockquote type="cite"><font face="monospace">to be shipped as a
          firmware blob in /lib/firmware/ and
          <br>
          makes the binding succeed without any change to the ACPI
          tables.
          <br>
        </font>
        <font face="monospace"><br>
          The fallback is only reached if all existing paths have
          already failed,
          <br>
          so there is no regression risk for boards where VFCT or ROM
          BAR work.
          <br>
        </font>
        <font face="monospace"><br>
          Signed-off-by: Oz Tiram <a class="moz-txt-link-rfc2396E" href="mailto:oz@shift-computing.de">&lt;oz@shift-computing.de&gt;</a>
          <br>
          ---
          <br>
          v2: Validate the fetched firmware with check_atom_bios()
          before accepting
          <br>
               it, consistent with all other VBIOS discovery paths. 
          Save fw-&gt;size
          <br>
               before release_firmware() so it remains valid for the
          size check.
          <br>
               Release the buffer via amdgpu_bios_release() if
          validation fails.
          <br>
        </font>
        <font face="monospace"><br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23
          +++++++++++++++++++++++
          <br>
            1 file changed, 23 insertions(+)
          <br>
        </font>
        <font face="monospace"><br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
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
            @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct
          amdgpu_device *adev)
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
          +        if (request_firmware(&amp;fw, fw_name, adev-&gt;dev)
          == 0) {
          <br>
          +            adev-&gt;bios = kmemdup(fw-&gt;data, fw-&gt;size,
          GFP_KERNEL);
          <br>
          +            fw_size = fw-&gt;size;
          <br>
          +            release_firmware(fw);
          <br>
          +            if (!adev-&gt;bios || !check_atom_bios(adev,
          fw_size)) {
          <br>
          +                amdgpu_bios_release(adev);
          <br>
          +            } else {
          <br>
          +                adev-&gt;bios_size = fw_size;
          <br>
          +                dev_info(adev-&gt;dev, "Fetched VBIOS from
          firmware file %s\n",
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
                dev_err(adev-&gt;dev, "Unable to locate a BIOS ROM\n");
          <br>
                return false;
          <br>
            </font></blockquote>
      <font face="monospace"><br>
      </font></blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------aXquASgd4bfF5C0BLT6MRedz--
