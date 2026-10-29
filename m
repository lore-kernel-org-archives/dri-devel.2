Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3B606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sYS2WfiV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950A1112581;
	Thu, 29 Oct 2026 21:58:08 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FB011257C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:58:01 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1680a50e64eso383c88.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311081; cv=none;
 d=google.com; s=arc-20260327;
 b=PZSWzM/qxXivX9Ca/UvZ/f3E5PpDRSFMVqyD96SzHD/RUzZrS7LmN/ZlZvgLJtNvNv
 qsURRjpKbXu0J2c3lapN7SCWB9iFDYjXsjXoem+PI2MU1K7X/4TOwYnFURhnEBU4GB6Z
 aEux3LB+EY+x2nLlssbDf2nYAsqTqzK5boU8CSS2XQdMhUnO9JJkpaLKpJFpKSKS8uoF
 N0nkoOSGzn0+8nEkP2i9KeSLkx7rrHQ/B6y2uX4MnrF8G5kUBf0sZenGttr3klD4/RgJ
 ziMaV/TkpJWdRJRoF9Upuj5ucNhYsodMmd5350d0SxL43aX08fC3v3BbMKquDi6wM9qE
 hXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vVmdWIfDqgQ57zGphQvuVSmIneDtL7GjZgKyHckL4FM=;
 fh=dKkL6h4sEaAFldFW3RQ+rkqqqs5gnhQoAFio+WmvaUo=;
 b=VmuwuYiIJVdqUcfJLsn48/emqZCUUxtVrHSnxGiPBtwXdSTMiAxQ+2u2LPbYsdn7HW
 p0sVo9n40S3m4cBKqkZe6uHNQKt2by5B/k6zWlwnFM6/SFQ/XsuCTiwTve+sXQc3pioo
 0JyI8dzzJGpZD3gpXAuls0se9OwIn7f4ViiYo4YCX5eZ9XNRe4Op71/X4LUUrC0P7lyD
 UDJheH6YUNn9X+c/UD/r66Cah9iCX5pBTxyWer4PzjO5ZjLmXpOto3HEBS3C4vbRRhIG
 gk9pDEDQonAdYlIThg7G3bB3QeI29OhKuvj4yJWh4ETdq2knh9msWh+Ze1ydNdhA3iFT
 7PPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793311081; x=1793915881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vVmdWIfDqgQ57zGphQvuVSmIneDtL7GjZgKyHckL4FM=;
 b=sYS2WfiVVouqHex7HlXsj34i5akwOxwDXBq9MZ3PtQv/08HKLx2Ue5JVrdAPwB6191
 Rw0Zn8Y3NAeOrajmRYvl2PWu4xvPuaVf791GjVx9TQniBfXi95DtwuK8cEjPyR3FHY67
 CnkZ1PODUKpz22/kQUTNI3YBAZMGHDutLLc/Wd/dEbr1lrPu5eGUvnCX2BRWotQiuF4y
 ZLQXzf04QMrf3NJE9G8gS7yXhiyCNJkzhwlpD7osUVwga003IgUq09ukmkZmRhwAYlgw
 qe7zuyCFxX2P8z2dL71HlZfqZjmmH9kjfZWfbzzyX/cOXu/ioYwyaAdQYpXNoxIchq+W
 YCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311081; x=1793915881;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vVmdWIfDqgQ57zGphQvuVSmIneDtL7GjZgKyHckL4FM=;
 b=MhsLTHxxRqo6jgjG9VCIDyZ4JAyDM0r8g4DLDyimB00P60RcgipXgl6n47tokkqwWB
 hP3Li141JqCGexa7fF5UvecRVuCAqmoaDa/7ijinUlHqFfX3V23QyYQzcwnO03U99yOw
 07B7Bssyh4xf02SPI5Tq2njghpcBEG2xXWIGspVKIQA/8SieYkSnazZSbLaNWoQQfdA7
 v512Rn/nKCA6yETumrVAK1N5wbNmLBm5eU7qD9yT2cUEQojlCeVhskS43oHcfS82NxUO
 qV7CW/OO4oQWRNDEQs192aLxtfIcXAYskuQEIayYnuwKO8BtusvKdaK/Ylb9CBtIf8hJ
 3Eeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxp4HyuvU7zwm6/kzcyF/KDAbE9/8N0thF51TvNtdC4BB+RK3/tnYArjG4ftC6dj0jEh5M3NMUU3Uk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ9usO2zeXiOfWUNnQ//zUre6akGbKXHhvmwlWBicyxZZX028rt
 7yi+xw6owaqLJjO3IaA1H0zihV3xGuN+ZSjXYYDuajAnogNFKfM5CKV3WFEW2wbZdNRSwwwdcCp
 KW4VAr3uxn2Qxz2HBupjzzZMKL/Lw4lc=
X-Gm-Gg: AYBFou3dff3nq2Wald065K/YOvXj9Ldn8vL8Ah0iiW0RaafqPh9M5oEf3pX2q14l3a4
 vFTtoc110xsfsWNplP9oz0SydI29Nc/8o3v1SoeIYRIpOStsdYtO27j4CD0qtSmlxppj56Vkgdt
 u+p8Vu/wW7euHGmgtO+Dtnpy07BWUZqxZchaunp9H8fVvIsAmFSb3W/XWEhdyjxO21JSi7kQoEo
 ZZtxj4JXScIDnmPHhPwEtbuxysXn07XrgtE5om7F7BIJFGXbgpOC4noUYDMKpxx4WDDnji1ATDk
 IAO+riGTIxiwY0HdpeaISXePZc0UtEsUkwWGBXFOzqIXx0Sx2RwBvRuzNUj1zN+eTdLc6WHMyFi
 SLZCmU3lPE0aQ73MxMu4PfMmnonqnLHX3KQoVzes1ShoGvamJ/fb/LXrYPZDmwIGs9MUE6Y0gPL
 ca6ABQefGl9h/2fc2cXSkjIfs=
X-Received: by 2002:a05:7022:c46:b0:1a1:9106:cfff with SMTP id
 a92af1059eb24-1ac5c45fd28mr645027c88.2.1793311081015; Thu, 29 Oct 2026
 14:58:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260916144014.879355-1-ed@aicharmers.com>
In-Reply-To: <20260916144014.879355-1-ed@aicharmers.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 17:57:49 -0400
X-Gm-Features: AclHuK9xVl7f8hieJPy2X3wLzEpfApxWnh2cKeKmKYYgIZ_iAsxEqlD0F7kalKA
Message-ID: <CADnq5_MsaUDm8rcxr3_0wuEAXywxziAofOO9w-dUxYS9PUoasw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
To: Ed Schofield <ed@aicharmers.com>, Andre Eikmeyer <dev@deq.rocks>
Cc: amd-gfx@lists.freedesktop.org, Kenneth Feng <kenneth.feng@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+ Andre

On Wed, Sep 16, 2026 at 10:51=E2=80=AFAM Ed Schofield <ed@aicharmers.com> w=
rote:
>
> From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
>
> Some Apple Navi GPUs intermittently time out during SMU initialization
> when EnableAllSmuFeatures includes UCLK DPM. Leave UCLK out of that early
> request and enable it from Navi post-init, after display hardware init
> and before the UMC workaround and UMD clock setup.
>
> Read back the enabled features before rebuilding the memory clock table
> and sustainable clock limits. Also check the PPT memory states used by
> display initialization before late enablement. Keep memory-voltage DPM
> and respect the user's memory-DPM setting and the secure Navi 10 exclusio=
n.
>
> Limit this workaround to Apple 7340/0218 revision 41, 7340/0219, and
> 731b/021a revision 40. Revisions and PCI IDs here are hexadecimal. The
> underlying initialization dependency behind the timing sensitivity is
> still unknown.

@Andre Eikmeyer I think this patch should fix your system as well.
@Atharva Tiwari are you ok with this patch?

Thanks,

Alex

>
> This builds on Atharva Tiwari's submitted 0219 delayed-UCLK patch
> and Guna's diagnosis. Ed Schofield moved the enable point into the
> Navi callback, added state validation and clock-table refresh, and
> extended the board matching.
> Independent tests of the related T2 implementation support improved boot
> reliability on 0219 and 021a; those are not tests of this exact AMD patch=
.
>
> Link: https://lore.kernel.org/amd-gfx/20260824190409.1724-1-atharvatiwari=
linuxdev@gmail.com/
> Link: https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-56=
37976466
> Link: https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-56=
45652752
> Assisted-by: Codex:GPT-6
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> Co-developed-by: Ed Schofield <ed@aicharmers.com>
> Signed-off-by: Ed Schofield <ed@aicharmers.com>
> ---
> Hi Alex, hi Atharva,
>
> Here is v4 of the delayed-UCLK workaround. Atharva is credited as the
> author in `From:`, with my rework credited through `Co-developed-by:`.
> The local development history starts from Atharva's original 0219
> submission [1], followed by my move to the Navi post-init callback,
> state validation, clock-table refresh and additional board support. This
> export is a single replacement patch against AMD staging at `8a4e96cf2`;
> it is not an incremental patch to apply on top of v2 or Atharva's
> original patch. (V3 was a local revision that I didn't submit to this
> list.)
>
> Atharva, I agree that display initialization may explain the timing
> dependency. This patch already enables UCLK after display hardware
> initialization on the normal probe path. It is intended as a targeted
> workaround for the reported boot failures; it does not establish the
> underlying cause or address native 5K support. Could you share the exact
> initialization-ordering diff, kernel version and GPU IDs from your
> experiment? In the AMD staging tree used for this patch,
> `dce_v10_0_early_init()` handles Tonga/Fiji, while these Navi boards use
> the DCN path.
>
> My goal is to stop the intermittent boot failures on my iMac (0218) and
> other affected machines. Testing of my related T2 candidate in PR 61
> [2], which was based on my local v3, is encouraging:
>
> - Matt Olney's report on 021a [3] records internal-display boot success
>   improving from 2/10 to 10/10, with mixed restart types.
>   External-display results were 4/10 versus 4/5, with uncertain kernel
>   selection on the failed candidate attempt.
> - Vivek Chauhan's report on 0219 [4] records boot success improving from
>   1/5 to 3/3.
>
> These results are from the T2 implementation, not this exact AMD v4
> export. The T2 patch stack also includes a separate correction to its
> existing fixed allowed-feature mask on 0219, which clean AMD does not
> need and this patch does not contain. The results support improved boot
> reliability on these machines, but do not establish full performance or
> reliability across all display configurations.
>
> Compared with public v2, v4 adds 731b/021a revision 40, preserves the
> existing secure-Navi-10 exclusion and generalizes the helper names. It
> retains 7340/0218 revision 41 and 7340/0219. All IDs and revisions here
> are hexadecimal.
>
> Compared with my local v3 / T2 Linux PR #61, v4 excludes 020f: 3v3nFloW
> reported that initialization completed but the machine subsequently hung
> under load [5]. Their follow-up testing with a fixed memory-clock level
> [6] suggests that memory-clock changes cause the hang, but doesn't
> establish whether GPU load or display activity triggers it. I've also
> excluded 021b from this version, which we don't yet have testing results
> for.
>
> Local build and host checks pass. I am currently travelling without my
> iMac and have no new v4 hardware results, but I am submitting this
> version for merging, with the workaround limited to the three board
> matches supported by the existing evidence from the volunteer testers
> mentioned above.
>
> Alex, this patch replaces v2 and applies directly to the AMD staging
> commit identified above.
>
> Thanks,
> Ed
>
> [1] https://lore.kernel.org/amd-gfx/20260824190409.1724-1-atharvatiwarili=
nuxdev@gmail.com/
> [2] https://github.com/t2linux/linux-t2-patches/pull/61
> [3] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5637=
976466
> [4] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5645=
652752
> [5] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5646=
139127
> [6] https://github.com/t2linux/linux-t2-patches/pull/61#issuecomment-5646=
438512
>
> v3 was local, not submitted. Since public v2: add the tested 021a/40
> match, retain the secure-Navi-10 exclusion, and generalize helper names.
> Since local v3: remove 020f (load hangs) and 021b (no testing evidence).
> Base: 8a4e96cf2acd1e0340581df100b559f77ad7d855 (AMD staging).
> This is a full replacement, not a patch to apply on top of v2.
>
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index f8ca5eb9a..3ac2a074c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -60,6 +60,37 @@
>
>  static int navi10_init_ppt_limits(struct smu_context *smu);
>
> +static bool is_asic_secure(struct smu_context *smu);
> +
> +static bool navi10_apple_needs_late_uclk(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev =3D smu->adev;
> +       struct pci_dev *pdev =3D adev->pdev;
> +
> +       if (pdev->vendor !=3D PCI_VENDOR_ID_ATI ||
> +           pdev->subsystem_vendor !=3D PCI_VENDOR_ID_APPLE ||
> +           !(adev->pm.pp_feature & PP_MCLK_DPM_MASK))
> +               return false;
> +
> +       /* Preserve the existing secure Navi 10 memory-DPM exclusion. */
> +       if (is_asic_secure(smu) &&
> +           amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 0) &&
> +           adev->rev_id =3D=3D 0)
> +               return false;
> +
> +       switch (pdev->device) {
> +       case 0x7340:
> +               return (pdev->subsystem_device =3D=3D 0x0218 &&
> +                       pdev->revision =3D=3D 0x41) ||
> +                      pdev->subsystem_device =3D=3D 0x0219;
> +       case 0x731b:
> +               return pdev->subsystem_device =3D=3D 0x021a &&
> +                      pdev->revision =3D=3D 0x40;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static const struct smu_feature_bits navi10_dpm_features =3D {
>         .bits =3D {
>                 SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
> @@ -356,6 +387,11 @@ navi10_init_allowed_features(struct smu_context *smu=
)
>                 smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, F=
EATURE_MEM_MVDD_SCALING_BIT);
>         }
>
> +       /* Defer UCLK on the selected Apple boards until IP late init. */
> +       if (navi10_apple_needs_late_uclk(smu))
> +               smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED,
> +                                          FEATURE_DPM_UCLK_BIT);
> +
>         if (is_asic_secure(smu) &&
>             (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0=
, 0)) &&
>             (adev->rev_id =3D=3D 0))
> @@ -470,6 +506,25 @@ static int navi10_store_powerplay_table(struct smu_c=
ontext *smu)
>         return 0;
>  }
>
> +/* DCN20 consumes these PPT states before the post-init UCLK enable. */
> +static int navi10_apple_check_uclk_states(struct smu_context *smu)
> +{
> +       PPTable_t *ppt =3D smu->smu_table.driver_pptable;
> +       unsigned int count, i;
> +
> +       if (!navi10_apple_needs_late_uclk(smu))
> +               return 0;
> +
> +       count =3D ppt->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels;
> +       if (!count || count > ARRAY_SIZE(ppt->FreqTableUclk))
> +               return -EINVAL;
> +       for (i =3D 0; i < count; i++) {
> +               if (!ppt->FreqTableUclk[i])
> +                       return -EINVAL;
> +       }
> +       return 0;
> +}
> +
>  static int navi10_setup_pptable(struct smu_context *smu)
>  {
>         int ret =3D 0;
> @@ -490,6 +545,10 @@ static int navi10_setup_pptable(struct smu_context *=
smu)
>         if (ret)
>                 return ret;
>
> +       ret =3D navi10_apple_check_uclk_states(smu);
> +       if (ret)
> +               return ret;
> +
>         return navi10_init_ppt_limits(smu);
>  }
>
> @@ -3219,6 +3278,41 @@ static int navi10_enable_mgpu_fan_boost(struct smu=
_context *smu)
>                                                NULL);
>  }
>
> +/* IP late init follows display hw_init; refresh clocks before UMC/UMD s=
etup. */
> +static int navi10_apple_late_uclk_enable(struct smu_context *smu)
> +{
> +       struct smu_11_0_dpm_context *dpm =3D smu->smu_dpm.dpm_context;
> +       struct smu_dpm_table *table =3D &dpm->dpm_tables.uclk_table;
> +       PPTable_t *ppt =3D smu->smu_table.driver_pptable;
> +       struct smu_feature_bits enabled;
> +       int ret;
> +
> +       if (!navi10_apple_needs_late_uclk(smu))
> +               return 0;
> +
> +       ret =3D smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT=
, true);
> +       if (ret)
> +               return ret;
> +       ret =3D smu_cmn_get_enabled_mask(smu, &enabled);
> +       if (ret)
> +               return ret;
> +       if (!smu_feature_bits_is_set(&enabled, FEATURE_DPM_UCLK_BIT))
> +               return -EIO;
> +
> +       smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_SUPPORTED,
> +                                FEATURE_DPM_UCLK_BIT);
> +       table->clk_type =3D SMU_UCLK;
> +       ret =3D smu_v11_0_set_single_dpm_table(smu, SMU_UCLK, table);
> +       if (ret)
> +               return ret;
> +       if (!table->count)
> +               return -EINVAL;
> +       if (!ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete)
> +               table->flags |=3D SMU_DPM_TABLE_FINE_GRAINED;
> +
> +       return smu_v11_0_init_max_sustainable_clocks(smu);
> +}
> +
>  static int navi10_post_smu_init(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
> @@ -3227,6 +3321,12 @@ static int navi10_post_smu_init(struct smu_context=
 *smu)
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> +       ret =3D navi10_apple_late_uclk_enable(smu);
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to enable late UCLK DPM: %d\n"=
, ret);
> +               return ret;
> +       }
> +
>         ret =3D navi10_run_umc_cdr_workaround(smu);
>         if (ret)
>                 dev_err(adev->dev, "Failed to apply umc cdr workaround!\n=
");
> --
> 2.43.0
