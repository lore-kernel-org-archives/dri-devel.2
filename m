Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DEDC79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 21:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B48789E47;
	Tue,  8 Sep 2026 21:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eVnXVU42";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C072E89E47
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 21:41:25 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396672b2565so970268a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 14:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788903685; cv=none;
 d=google.com; s=arc-20260327;
 b=Qwxy6CaARQr+Ma6VAPnKJ9NQTGPKy6kFZuOy3wNXGcRGJUdFXfY635ZjuWVE+VzlGZ
 6qQ4etV446p0bF0pZ/x9CFgmh0OKvl2bCn1L9hSMGppOzkELhEyGbrwg7HI0d2ivTRhz
 2G0uJg+mllGUbMX/AhHWJ42QYgYgb++9WgSZXN8EslTTxNraazJgeyAbXyjRcUKUKjUM
 TxIA8J5T3OE2eqYdyd/eDt3ZQ2L8gA58EyoK+XP74k+SHWgDgYvW6H2xcQ7b/I+4qE+x
 y6yCwUnWmy5b/wkYwZKv1sbWOoANmxg9Rl0XY8JHJ8K/JgRNDhbULsO82dGSpXGXdo9s
 iH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8rQkd5Au7Y+YHu9zGBjXy6N5KCdPe9r93Bw6y8CKr6U=;
 fh=pI2qF1PTuDXIacUhtti0qx2byjCND7Kk3/yU3LHpoCQ=;
 b=btnekEyRJkjrVnp/LMvFOY3Xc+MBNUrKukz9G7WPabR+E9zsCx1JQen0xZ1iwT5du6
 JPx790poPTLPRPqMTON+GjxLuZBatRorctDnkiQTdziFNmV39sDrT+0EoOr2aJIekc8i
 Toqo9EzoPjpnInBRajd4iaJikY4sEa0M17UcKX/GYyzGcJt0U6cgwhHq2/7tjYcDXivz
 WM5+lcz/JF62/8vA7Z/3NUg43uQVlvmn5uvnvSBRUf2Lqv8Tvr/KPJ6FkqX9CW2/npw+
 OWd9Ca+BdVFdpFVxyHqRmxzu1AbGpIWYtqV/BrNyk9zoDeXiOVNMLO75gHsaVUn93qvX
 6Xmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788903685; x=1789508485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8rQkd5Au7Y+YHu9zGBjXy6N5KCdPe9r93Bw6y8CKr6U=;
 b=eVnXVU42YD6Q/TdK52pBkpcReBFPM9KInHfs2N3PN45u4dObc6KTyMnXBE0z6ggFDd
 hOt45gzcYlqXbLGDynndTyD6ZoEukt2YNcaaTid2T7f92Tj7Hp2y8iev3Kmnt6f8XGNl
 WGaZ2SOpRJAzUdTcDB5oNUi4bi/MxHaYhfi2VPK/t0toQGPQvZImgOiSWN2m1cSDxpQ8
 aFbndUXLiiljt3PVBk0AWlbUc1yEUurypXnf2BdtgvBANlyVHShlt35T9/sYSlJsjX9+
 SKwJSdmNZHRJ8wHC8Mazm+b/yzjJm4TC2ZhoUk70xpRuofzY7mHXdcyUDLrdo1Vtnxo4
 TyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788903685; x=1789508485;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8rQkd5Au7Y+YHu9zGBjXy6N5KCdPe9r93Bw6y8CKr6U=;
 b=fhrbdIBPsIsRcNiMZfD9lwweTx/Y4YHuXjh328vNlWSFgnUygContVku0CPXHv6e0P
 DsUQoGwJPsCnPg1dH84nDARM7Vg98B7BP/XCTs5BRl7C2j1dK7HTDqUEYqArk/rbwDQC
 q/OWAN4UYdhfJqLo0hU83lelj7MkRWGYkMNclLeLhNrR19IqyVlHYE1cOiw8xQDSkCyq
 hPnlICRDc4ahkOX4UivoebTnb2k5ccQn64aTJw/T79RqoSuaZ4U+NKSG4Ur5PAXRFn4B
 dy06waasYJe7s2w3ov10i+i3/AmGIneB6IlxkKD7CF/CHrAA5xuUokni7kfxa/RTA8p4
 tPUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBXkqV9rF4lWj4xQTDdNpkhkE+91jMzb/0boFWM4QUvMnawAsPPOaXNzFMCyhi02onEBZ4JamdO7k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++knHpRDOK9yl71doVTqbTy/s0F/hjIu7fv2c5XP1dKlooSep9RD
 RRFS8zobQLuQ+JykEP6b9JgvyQvYZPJj4bHx8AdhvdAhYvdAK0Er2fqKqv7yDtmoV09WXKaoeKt
 0TN1FmmZXpC3gnZjuwcTsMP19pMPyDCJyzUMR
X-Gm-Gg: AYBFou22yQMYujV8YV4x0LGoOYYJpGHBwi+SiT0DWC1gZxDnEaaRhaQKOec3Qmmu1QE
 wBUrvwGYlClYewhIVNBOVAcmcq/85MGlAQYk01PRTOn0anv7JWf7wx9OMbJim577W7cJHl+xf6S
 oLKNKyAEau4j8AqiUdhmAVM/C552Wia7lJnLRE+F3WMt3nc9hm29xkeTFU13NnysDgoIivDHCNU
 KK0hvauGGesMrL+Ovy2JLIGMLuzY0SOAz7Nupn4yOnIw+30ecZ5SRKPpxnZ/42NPABDCsEVdzAd
 5nKtiC5adFoyg+r6SdbZ+XTDRxPaMykSMLkbpCm7J3ldnTgJxE/HFA9hVdK4uiqjMw6KaNZ/n1y
 CH3wqzO1k5bTpzv3iiwyz3v87HysKaOg=
X-Received: by 2002:a17:90b:3a48:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-39b3d5e53d5mr20820843a91.2.1788903685198; Tue, 08 Sep 2026
 14:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-amdgpu-ras-wifpts-v1-1-7f3b4528f12c@kernel.org>
In-Reply-To: <20260903-amdgpu-ras-wifpts-v1-1-7f3b4528f12c@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Sep 2026 17:41:12 -0400
X-Gm-Features: AcwNN1XCfKRR9Pp_3osr-NXErQWimzUuIEmAIhBaOCMAWbp5aPXAHcWmLCqHV_s
Message-ID: <CADnq5_NZKS0Ng_8sy=AS=Jby_6dCwVKMziyvRgK8XHVYEQRD1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/ras: Adjust second parameter of
 mp1_v13_0_eeprom_send_msg()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 3, 2026 at 3:40=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> When building with -Wincompatible-function-pointer-types-strict, a
> warning designed to catch kernel control flow integrity (kCFI) issues at
> build time, there is an instance around mp1_v13_0_eeprom_send_msg():
>
>   drivers/gpu/drm/amd/amdgpu/../ras/ras_mgr/amdgpu_ras_mp1_v13_0.c:157:25=
: error: incompatible function pointer types initializing 'int (*)(struct r=
as_core_context *, u32, uint32_t, uint32_t *)' (aka 'int (*)(struct ras_cor=
e_context *, unsigned int, unsigned int, unsigned int *)') with an expressi=
on of type 'int (struct ras_core_context *, enum ras_fw_eeprom_cmd, uint32_=
t, uint32_t *)' (aka 'int (struct ras_core_context *, enum ras_fw_eeprom_cm=
d, unsigned int, unsigned int *)') [-Werror,-Wincompatible-function-pointer=
-types-strict]
>     157 |         .mp1_send_eeprom_msg =3D mp1_v13_0_eeprom_send_msg,
>         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> While 'u32' and 'enum ras_fw_eeprom_cmd' are ABI compatible, hence no
> regular warning from -Wincompatible-function-pointer-types, the mismatch
> will trigger a kCFI violation when mp1_v13_0_eeprom_send_msg() is called
> indirectly.
>
> Update the second parameter of mp1_v13_0_eeprom_send_msg()' to be
> 'u32 msg_id' to match the prototype in 'struct ras_mp1_sys_func' (which
> was recently changed to support mp1_v15_0), clearing up the warning and
> kCFI violation.
>
> Fixes: 11a948c7817b ("drm/amd/ras: Support retrieving bad page info from =
mp1_v15_0")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/dri=
vers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> index 7aa818a433f6..548594373d0b 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> @@ -105,14 +105,14 @@ static int mp1_v13_0_dump_valid_bank(struct ras_cor=
e_context *ras_core,
>  }
>
>  static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
> -                               enum ras_fw_eeprom_cmd index, uint32_t pa=
ram, uint32_t *read_arg)
> +                               u32 msg_id, uint32_t param, uint32_t *rea=
d_arg)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
>         int ret =3D 0;
>
>         if (down_read_trylock(&adev->reset_domain->sem)) {
>                 ret =3D mp1_v13_send_smu_msg(adev,
> -                       pmfw_eeprom_msgs[index], param, read_arg);
> +                       pmfw_eeprom_msgs[msg_id], param, read_arg);
>                 up_read(&adev->reset_domain->sem);
>         } else {
>                 ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
>
> ---
> base-commit: 8fad652e7235dbf3bebfab1460610b0b0e75b199
> change-id: 20260902-amdgpu-ras-wifpts-c8628642e565
>
> Best regards,
> --
> Cheers,
> Nathan
>
