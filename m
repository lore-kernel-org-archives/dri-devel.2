Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B52606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MylnB0aR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C805411202F;
	Thu, 29 Oct 2026 07:58:57 +0000 (UTC)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B13810E053
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:59:58 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so1131309f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793145597; x=1793750397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bBTKol9N1nqETGHQsxayqsr3cv18S0UQTtkfWd81H5E=;
 b=MylnB0aRrMD7MUQ7YpAGqlwDSrIHZLtSSbx0PeuyRvgSv/d8elrecrKosHXYQI3MGO
 0sQIsKywAOe5fwpnxLR9x2hnwYhGrafdHE6CkfyJzhfiMRvPXlWR/Y3ve0lv0m+O7wFL
 aNkzzPerXYCFKTxz7s96YFBcbIUlIkSmaf89qWD+N6O1uquVUKXyys0e6WBroBC6vtzk
 yYkWpBPozZYLgDyZPIxGRiJ456gAERbgcUMeFZrAWha86td2g7fSfXRyX+H6cIx/2SuX
 ZAQ+sJRww98HtnJmYRF4YYm2ef/at7qa+1/aMdvf7RFM0QKbJheAtgV5P0Ln1SoZWMMT
 YHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793145597; x=1793750397;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bBTKol9N1nqETGHQsxayqsr3cv18S0UQTtkfWd81H5E=;
 b=DbtYrY1PMtPlgC9IXIHxGw52DbcP8s+/lMTf4PSYiaz4R5xsaCKbU+nnv9e1it/crb
 Fr/ZHm8n9VaD07yC+Lw6g+wGcwT5B+pm0WTmw1Wxz0BtdmivM55B7wVbhTQApT7rUJFP
 LGccd+gTGcIkFzgbI25c9PQpm4lbeL4fM/tX+xL8cCazXlArLr4pQGb8CZsbDo2Uj0Uq
 jDE91ySj0PoOiQ1QGDdQkew4X3RupQhthHAftHOls8/qfFYlFNOh3e8QR9lT0HJeXyQo
 K8KrJ3lDfCF8naZ9HaM8+Ui5xI7Zb4guskMD2AzgD1HtbHva31IqQwqrYzsRPiGFt/4b
 +0zg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3o6ZAS5ws80ehJR6CdTajxiSQWYJW0KaMHavSEkDGj1+Nu9Ziup2uyg0vzSZrjx/27L8ZVrgDIOM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIiON+XCLLmAy35JZPyFOv3x/PG/nm5/BkgXvzK+EuXR7Fhd3TV
 R3dmfgFXZVDJrGPXa2g96LFQPR1Ji/AclGMogxHCuYKVKYXtxsXO6LSk
X-Gm-Gg: AYBFou0szVsSV5ViKV/35GMxPFlCQFY1Fd0Mwb9nEcAjmyiUuVn6GJRGUXpjN9DmGuM
 lGdWzqLz42aii7xzwBhUw7sSP9QgYRcR/7BmmBEqliG0ihH1aDh4LL8EGfd93NlBeur5AEo2gch
 dbHW24N6tsYty8LU2DexLBjDCYpcWs+QbOlo1HrBPq3OOcu/5pyqXRIaKiBzfe3AjJ5hoMhXi9d
 sns1rbXSzwhWZ5Tyzv2DPwY3p8gjj5KiSqax+378eTiaS9CLb+N4QHcddBwMbpnkzH8yrbtHT7d
 9GnLBiOUUrtOUVYSUkKtaqcZBByC5eqivpytOAieeXyMsSfSMT6ehvBPGaK8Kr+q0OarodIaK/k
 N59pKOf8Hk7JwQjp89ik09lCMBeLRzOS1AgP3adT3YQZxXhA2+REiYFh2fEGFW6Ios5zdfdiAZE
 KT31KyfK6P6CZwpdSnTw09O2peLki3QEey2XJ1ON8daHP+5GJw4wM0+jlTSWqhMyJGYMX26DKIc
 RRZVHSUsGGm3ycINdvxHDnNoWwhEG6sdNiDmYmOCaCVqTfY
X-Received: by 2002:adf:ebcd:0:b0:48e:4ad2:32e0 with SMTP id
 ffacd0b85a97d-48e55a5a8bemr6497483f8f.29.1793145596732; 
 Tue, 27 Oct 2026 16:59:56 -0700 (PDT)
Received: from [192.168.1.12] ([31.94.68.191])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4be6sm23200698f8f.37.2026.10.27.16.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 16:59:55 -0700 (PDT)
Message-ID: <138497f6-2271-4229-87f1-4e42e9d2b581@gmail.com>
Date: Tue, 27 Oct 2026 23:59:53 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: reserve 64M stolen memory for Apple 5K
 iMac
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <a826b32d-597a-4c01-8b30-218cbca8627a@gmail.com>
 <e0573e72-dcc1-4ff2-8cf2-53aefde912cb@amd.com>
 <CADnq5_M8f2Hgs06n9EXUaihGsr6YEm6G4YFVQmPfQbGU08XkBg@mail.gmail.com>
 <6f79a3e2-5510-4018-aabd-45fcdf5dcbb3@amd.com>
 <CADnq5_OTLQuD3B6-VUgZv6wGjhFNY_U77wqdv5Y+e25+O0B2ZA@mail.gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
In-Reply-To: <CADnq5_OTLQuD3B6-VUgZv6wGjhFNY_U77wqdv5Y+e25+O0B2ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/2026 13:37, Alex Deucher wrote:
> On Tue, Oct 27, 2026 at 9:16 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 10/27/26 07:57, Alex Deucher wrote:
>>> On Tue, Oct 27, 2026 at 8:21 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> On 10/26/26 23:46, Richard Lane wrote:
>>>>> Apple 27" 5K iMacs report a single 2560x2880 tile (28.125 MiB) in
>>>>> VIEWPORT_SIZE while scanning out up to 64 MiB across the relocated EFI
>>>>> framebuffer.
>>>>>
>>>>> Override the stolen VGA memory allocation size to 64 MiB when matching
>>>>> PCI_VENDOR_ID_APPLE with a 2560x2880x4 viewport size to prevent
>>>>> framebuffer corruption during boot handover.
>>>>
>>>> Hacks like those are usually a big no-go.
>>>>
>>>> Why is that framebuffer handling not working with DC out of the box?
>>>
>>> The GMC IP code reserves the memory used by the display hardware from
>>> the pre-OS console.  The gmc get_vbios_fb_size() callback looks to see
>>> what display viewport was set by the pre-OS environment.  If the Macs
>>> need a workaround, that's where it should go.  Since these displays
>>> require multiple display pipes, my guess is you need to double the
>>> allocation in that case since the current code just checks the first
>>> pipe.
>>
>>
>> Could this also be a logic error in that callback?  Would it be worth
>> double checking all the register values in that callback for this system?
>>
>> I know for example there are a few different IP specific implementations
>> in gmc_v9_0_get_vbios_fb_size().
> 
> Not likely.  I suspect the issue is that these systems use two display
> pipes so we only reserve enough memory to cover half of the display.
> On PCs the vbios never sets up MST.
> 
> Alex
> 

I tested doubling the allocation in gmc_v8_0_get_vbios_fb_size():

	if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
	    size == (2560 * 2880 * 4))
		size *= 2;

That eliminated the corruption across the middle (45-60%) of the screen,
but still left a band of corruption along the very bottom (95-100%) of
the screen.

Dumping the DCE registers inside gmc_v8_0_get_vbios_fb_size() on the
iMac17,1 showed:

  vram_start = 0xf400000000, d1vga = 0x0
  CRTC0: grph_en=0x1 surf_hi=0xf4 surf_lo=0x300000 pitch=5120 vp_size=2560x2880
  CRTC1: grph_en=0x80000000 surf_hi=0x0 surf_lo=0x0 pitch=0 vp_size=0x0

Even though only CRTC0 is active at EFI boot with a 2560x2880 viewport,
Apple's EFI allocates a full 5120-pixel stride surface (mmGRPH_PITCH) and places
mmGRPH_PRIMARY_SURFACE_ADDRESS at a 3 MiB offset (0x300000) from
vram_start.

Because CRTC0 scans out 2880 lines at a 5120-pixel pitch starting at
offset 3 MiB, the active pre-OS scanout spans [3 MiB, 59.25 MiB) in VRAM:
- Reserving 2560 * 2880 * 4 (28.125 MiB) places permanent driver BOs at
  ~28.125..32 MiB, corrupting the middle (40-60%) of the screen.
- Reserving 2 * 2560 * 2880 * 4 (56.25 MiB) places those BOs at
  ~56.25..59.25 MiB, leaving the final 3 MiB exposed due to the 0x300000
  surface offset and corrupting the bottom (95-100%) of the screen.
- Accounting for the 5120 pitch and the 0x300000 surface offset reserves
  the full 59.25 MiB span and eliminates the corruption completely.

For v2 of the patch, which of the following two approaches in both
gmc_v7_0/v8_0_get_vbios_fb_size() would you prefer? Both tested working.

Option A (change whole function):

 static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
 	u32 d1vga_control = RREG32(mmD1VGA_CONTROL);
 	unsigned size;
 
 	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
 		size = AMDGPU_VBIOS_VGA_ALLOCATION;
 	} else {
 		u32 viewport = RREG32(mmVIEWPORT_SIZE);
-		size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
-			REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) * 4);
+		size = REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
+		       RREG32(mmGRPH_PITCH) * 4;
+		if (size)
+			size += RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS) -
+				lower_32_bits(adev->gmc.vram_start);
 	}
 
 	return size;
 }

Option B (add Apple 5K iMacs quirk):

 static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
 	u32 d1vga_control = RREG32(mmD1VGA_CONTROL);
 	unsigned size;
 
 	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
 		size = AMDGPU_VBIOS_VGA_ALLOCATION;
 	} else {
 		u32 viewport = RREG32(mmVIEWPORT_SIZE);
 		size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
 			REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) * 4);
+
+		if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+		    size == (2560 * 2880 * 4))
+			size = size * 2 + RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS);
 	}
 
 	return size;
 }


Richard

>>
>>>
>>> Alex
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++++++-
>>>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> index 4204c3c750a8..8b196fbfa724 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> @@ -1232,7 +1232,15 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev)
>>>>>          } else {
>>>>>                  size = amdgpu_gmc_get_vbios_fb_size(adev);
>>>>>
>>>>> -               if (adev->mman.keep_stolen_vga_memory)
>>>>> +               /*
>>>>> +                * Apple 5K iMacs report one 2560x2880 tile in VIEWPORT_SIZE
>>>>> +                * while scanning out up to 64M across the relocated EFI
>>>>> +                * framebuffer.
>>>>> +                */
>>>>> +               if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
>>>>> +                   size == (2560 * 2880 * 4))
>>>>> +                       size = 64U * 1024 * 1024;
>>>>> +               else if (adev->mman.keep_stolen_vga_memory)
>>>>>                          size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
>>>>>          }
>>>>>
>>>>> --
>>>>> 2.55.0
>>>>
>>

