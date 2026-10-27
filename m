Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AED606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W4ItAAYH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 030F610F54E;
	Tue, 27 Oct 2026 13:37:25 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D9A10F4D7
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:37:13 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-363cd582f45so395144eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793108233; cv=none;
 d=google.com; s=arc-20260327;
 b=YWTQ9vVSiPQuvJIheLCztqLG1N8t7/Rr7K6HBuO8STErUhLl8/RT5r8apBWsuQG65y
 TtKLIKcyZWTldVGp9mmDfX8O1+6Y3LzjWSDTgPhkYtUz3UdCjnfTmr1SHR6FEpAP7GL2
 qSxMn1uBUv0SJV/Iqyj03CIkOed9sckO5tAUOB4YZXu+O33iJLiI2D3tvktBu3MEcqqa
 PzABZ70Nt0stIFDbXNRr/1FAkdP4p/bUGcmh0ITVlMDqlS/RmjkY4T4U6/FeR7MZYWbR
 ZbkJSyt1pzDrnk8pVbcoUH86WYM8lc+/z0rWq8FkULgxne5W0i4/SDDX+HT6GEqy1TSx
 xcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FufhvRCtL/dPRhc2t8mrLa65DAQwulVvCxNep8YNhyQ=;
 fh=Lz7yPiyIlrHFq5PerXBw75pCe8+HaBK26XrCYKa4GrY=;
 b=P1HOmH7Oea3reBbvZUIRIzoBs1B81FbuXCexDzpiD62QAgYJYchOTe0Bj5T5wyW+ct
 LU4BMPvxG6CU2FEKnxvUBZ9G34K/Hb+q2Dn8sQ6edqDAyoAz+kdKu74OiRZZ72HavJcS
 W/yOMKiqO7Vi3SPtguYG/CzOkYaw0DU4I3Sf8ha25M1adxR8Ta83QkcUImzU0+QPJ/Xb
 UWJ5uqObR4H63oMNIyBJD3qswv0s/JW5xUiPRqfqHtuZ4UfJYWo+KgjkuYhPIjUm4pEq
 /iqeTTdj9Eiz4MwRr7RqBGwAqyjtFBP9F67z5nMVRSmxzkbgkqxKgi8RAkLteQn0PzLp
 xPEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793108233; x=1793713033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FufhvRCtL/dPRhc2t8mrLa65DAQwulVvCxNep8YNhyQ=;
 b=W4ItAAYHjOEzs/mjfx16NkQDuPN3bWREWq4XOLTgCR+/jmU5S9L53xn5Ae2BmqzMto
 fGonpUBNgP09ea5Zp/C9UWuaLa8UZh9mO7SjIZm3aX+rymETNlmQZaGqG7tPhDUh07nZ
 6Xgc1ZDCogu332JYuYBscFjF8kHltFGz+sbdjpUfGnAVtmF5yAgYnGODhHGaiMPYrULl
 5ckLccCQ91leyFqb28WuEYXgUhPR69sVS7Qd/7QEduylYZLDycb4ze5kJL1K14usPfLH
 YVw89vg1uUlkeO4btI7xkDr2uvw9gt36OP70hLMR4P4TPgkc8SGMwjOC/VeJyh3X6OfW
 JWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108233; x=1793713033;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FufhvRCtL/dPRhc2t8mrLa65DAQwulVvCxNep8YNhyQ=;
 b=ZwIcTM8kr571ZMunNltColjzjMRxWAKshf+b2WKvNU6fYVd9x+a3321h1qQOjuBVPQ
 oqqISzDUKwN12rzpivnm7yafpGikjNn3YNpa5s5ds/peVw4HJdAfHXoly6fJ5BmludDd
 aDWXmQWpcQFgBREZYyOKCuGGGSCLSKuxfHID4utyszeaoM6C8UWu6fW820iXR+5l8nm6
 9O+xxmFIET9IX1ZOBBgVDUJPTBFXYyfLDUMULuWPWF8+ySjQNsTh4NklNnyDUOaQrCzN
 Hu1n3tvBLrUP0GHyMB9kScVszJHi8jh2YzJePL5zqZDkXOfvNEEXYnJ53Bar635vZDOT
 oXvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6K+01e3HnaiXHHJEuALlSolzHX9O/k9j0VKfac4L6/OeGl+9wu1FiF4M15LprhU3xFZUNl+k+wZI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJtPPI2GyFKsVMQ4ROfnqsLYSNm2UshJmfgGB47d4o2J+QTML4S
 O9lD/05Tp2lzbsYpO43dOEtxyY39kj4+BOER8h6KkcSILEUNLoATbOSNvvek+XWXiFxYASlFANK
 28rKVkTo7VR8wToVY5X7qOXpSFH2sjtk=
X-Gm-Gg: AYBFou2j5weWR7BGX6g3/ldOeTqAwRQ2bkOe03s2LwwOZjhdsx8WqBnY20rX8NMXuNA
 ObFFLlEnBYELyXlYB6FK80z6F+j0GRE2vP+OImHnXM7az7pxMB/D79Ja3iQuG91GeVEUQS2LOH1
 7biJETqFKxOLvQp7o9QWggrTIbeAZD3QR3MFvsjcThA1JaL3cTxPCWHyONvPus11gXkoRTtRM8e
 pg+cVRIIrqKDcPHf+xAXCnUyts+vmuhbUEmdJOUHFabhmIEtT+VcJ9bH20DsYS/NQHAEgthncmX
 0jo+kgkipyu5nA8daVAcGrEkpkXzzTMXgUw9XXyqqr+NlMu4yzMCSOiaGglT+JAKkHuICoNoGx4
 3SYoKibzOWESDAxBvKHW+n3Em/lhU/8SouI5k/w1pL/GS6Ee9346nnafl4QwF/fR8DHUi9dF82e
 +Nli74w5p3P4CHNNmeK/W3YDg=
X-Received: by 2002:a05:701b:430a:b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-1991b142105mr20151825c88.0.1793108232858; Tue, 27 Oct 2026
 06:37:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <a826b32d-597a-4c01-8b30-218cbca8627a@gmail.com>
 <e0573e72-dcc1-4ff2-8cf2-53aefde912cb@amd.com>
 <CADnq5_M8f2Hgs06n9EXUaihGsr6YEm6G4YFVQmPfQbGU08XkBg@mail.gmail.com>
 <6f79a3e2-5510-4018-aabd-45fcdf5dcbb3@amd.com>
In-Reply-To: <6f79a3e2-5510-4018-aabd-45fcdf5dcbb3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2026 09:37:00 -0400
X-Gm-Features: AclHuK-wHTgKpLhkTxBfx8DFmsearMvG8jH9zbeIpPdOt_OZOMlG9BJnbkLKU4I
Message-ID: <CADnq5_OTLQuD3B6-VUgZv6wGjhFNY_U77wqdv5Y+e25+O0B2ZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: reserve 64M stolen memory for Apple 5K
 iMac
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Richard Lane <richardlanedev@gmail.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 9:16=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 10/27/26 07:57, Alex Deucher wrote:
> > On Tue, Oct 27, 2026 at 8:21=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 10/26/26 23:46, Richard Lane wrote:
> >>> Apple 27" 5K iMacs report a single 2560x2880 tile (28.125 MiB) in
> >>> VIEWPORT_SIZE while scanning out up to 64 MiB across the relocated EF=
I
> >>> framebuffer.
> >>>
> >>> Override the stolen VGA memory allocation size to 64 MiB when matchin=
g
> >>> PCI_VENDOR_ID_APPLE with a 2560x2880x4 viewport size to prevent
> >>> framebuffer corruption during boot handover.
> >>
> >> Hacks like those are usually a big no-go.
> >>
> >> Why is that framebuffer handling not working with DC out of the box?
> >
> > The GMC IP code reserves the memory used by the display hardware from
> > the pre-OS console.  The gmc get_vbios_fb_size() callback looks to see
> > what display viewport was set by the pre-OS environment.  If the Macs
> > need a workaround, that's where it should go.  Since these displays
> > require multiple display pipes, my guess is you need to double the
> > allocation in that case since the current code just checks the first
> > pipe.
>
>
> Could this also be a logic error in that callback?  Would it be worth
> double checking all the register values in that callback for this system?
>
> I know for example there are a few different IP specific implementations
> in gmc_v9_0_get_vbios_fb_size().

Not likely.  I suspect the issue is that these systems use two display
pipes so we only reserve enough memory to cover half of the display.
On PCs the vbios never sets up MST.

Alex

>
> >
> > Alex
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++++++-
> >>>   1 file changed, 9 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_gmc.c
> >>> index 4204c3c750a8..8b196fbfa724 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>> @@ -1232,7 +1232,15 @@ void amdgpu_gmc_init_vga_resv_regions(struct a=
mdgpu_device *adev)
> >>>          } else {
> >>>                  size =3D amdgpu_gmc_get_vbios_fb_size(adev);
> >>>
> >>> -               if (adev->mman.keep_stolen_vga_memory)
> >>> +               /*
> >>> +                * Apple 5K iMacs report one 2560x2880 tile in VIEWPO=
RT_SIZE
> >>> +                * while scanning out up to 64M across the relocated =
EFI
> >>> +                * framebuffer.
> >>> +                */
> >>> +               if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID=
_APPLE &&
> >>> +                   size =3D=3D (2560 * 2880 * 4))
> >>> +                       size =3D 64U * 1024 * 1024;
> >>> +               else if (adev->mman.keep_stolen_vga_memory)
> >>>                          size =3D max(size, (unsigned)AMDGPU_VBIOS_VG=
A_ALLOCATION);
> >>>          }
> >>>
> >>> --
> >>> 2.55.0
> >>
>
