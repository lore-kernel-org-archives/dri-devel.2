Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6CE606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RiLKq6Eb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8DE10E0E9;
	Tue, 20 Oct 2026 13:08:40 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77DA310E0E9
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:08:32 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-14f0e9c6543so87156c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792501712; cv=none;
 d=google.com; s=arc-20260327;
 b=VGT7n1erPOPL/c9lG92iPmhxlEQE6/SNT1s0RZea1C40IQLq9n2rUchQQEKBjlZzBK
 mljXEU7vM+Eq0DOlqMCnx7p/O+bwi3xHQ1MVjXLeF9NzaRTB6t3SAKK2pGRdDw1ZkKIg
 QkHYqcoMaT9AHA9b6zXedi+24MEGE8AmjVgb5Ncl3/0taQeMvKBU/S4tjAt0XMGZ2wvv
 ZcLLof+/yaqmF9qxv0VPpnOZul4bj0Xy3DrDNnYBOqoAK5J+4HwTXAxw2A0TR3+0IrDm
 xKhjow4WhCs1/g4BhQfrCMTSiTF1ffLzhUkyUEhbWzAHPqaZkYY/ctD3lLCkLmIU9qHZ
 IMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BQPT2RK/Bsa2DXu0Idtw0TN37aSAQhniynYTnVnEFQ4=;
 fh=SOElsTjrQfpDwNV9x2yryLDzYKPQXWYtggE2Ryz/8+g=;
 b=OstBvH401ckybowVaUdNqSfXw3+BKvIWrwc/cfwIn04tp98pHeK43AILqNfdILoQ1T
 UdSKyNkE9NMRdZ7ZIvaa5uK2M8Um6dY6JWnYw+kFh2fMZoqd3nTZi5gPuFHk0S20qoBK
 j8ZyohgcfJ1nr12Nx8KLr5L8tltliYebLl0RfrcwpBjLpgZXR4wcyobd2ewvFimI8w8d
 pITF2yJP9MTQLoa5IjqyCGHm7DELz6Q/++fAJqeHi9zYk9URxhe3YpB7bBtAqkBtFzRL
 a5QP68/wfI5lSj/TbU6RDRcvmPSDP2iPR8IBD+oLLwSrXu+IsV9Ksjug0oyTcstL5vgs
 5q/g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792501712; x=1793106512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BQPT2RK/Bsa2DXu0Idtw0TN37aSAQhniynYTnVnEFQ4=;
 b=RiLKq6EbAGm8aOmpDg7BNTXlV2KH7Pzm+s39neMZ7Sh9er5ADM80FoZh1pwFknugUM
 By6NbU1UN+C45QHPs+Cy8ryznE3iFVYIpUXBGi0ENqUC4/k1qJKHHczU8Q7PEu+1PCtd
 RzhPzXqZc2RmXtzOg0RG4GsZkMskr7a2eVh13OS/gD/mygLjlTweThDvqqxguuwSLXN9
 GbbGWSFO29Bg/qhtAUsu8pF2X61FswgU5998WxzyUndN0AV06qHEWzgMqO/A7IDVJTPb
 RBdvl2t5ceAUord3Pkxn9Ixnbf5SyUktD14qa5Qdk2bmr1dWs/f0OJAOOx89e6dP05Ce
 A03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792501712; x=1793106512;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BQPT2RK/Bsa2DXu0Idtw0TN37aSAQhniynYTnVnEFQ4=;
 b=XFqATjzk/JYvDOZCfgZHTmsXNog01Ra3VgVOVxwV7BYTRtMkH3hK60QtSky3P7eH88
 W7a+8C/tqiXMr+KD6ZFgE3/848xm9eJKeBZDdMcjMLKoknywhx8hMIr3frOQ9ZARCiuU
 HWTLF3luvyYAtzH5R9HuElwpq21gk9DgmFd7aPxNnRCxhmUG0eC3wra0Mqyp+dkajY4L
 or2fiRaktieN1N8Moq7n3ZhMsAesZ5DHkbLyJtfAT6/dUqN4Tn9gOxDwQPFRUxEOBoYL
 VGU1hiHtKVfz48UxmB+96Pxsw8M3yDMXzKtR8s/1uqI4xbu70aQ0lFYhyPb2bXEuBNMR
 cBzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuVRwG1xm4AH/ZuYcdDeZj12fZYsnrI1ytJ0TUmKp2Jm213+UlN8VW7EAK2+8XBd49tm7ktMPkM3U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKv+r5mQOw7Z7ey8052lB2PqrwIxMQ7nKzDX5vEth63GjrNF1Z6
 gDokvcEj6sd1TmZkBxJNgMvoAwE5IRIjZGY1pOcH9ZwIsIl/1xkMx3sVyGSWB0OgbkuE0BMY7m6
 WmwpYf0h2e97DrW7uGiMZJCAl7pEyyFw=
X-Gm-Gg: AYBFou31agxWxInD6mK+a5xO1npG210V6B9OCeaX2IRzq+XogdDIuR81eDmvbyWuw8M
 XxxBGn27SkXrM4rauPc5dNOeRhacenpdFwD3fijqxmubHaYvr7w36QgjiLU+u9jdrR+NmjHeBIZ
 fyl2rvMeujqJ80emD7FtqZQ1AwYv0JPUec5NqmG6FrehNzTf2yq+mxNgtdRjFs7TUWyNPZjroaF
 tNOvpMrf3BsaY23B/XS2IZCAETiacjxKYdj0DXm0TzW526gADqlecXHZMI8upzfvMFNPJPNKLyg
 XKI2AU8NLdnBZGczorYGhafWsyXqWBKNYfhN234UgFDr79mR/qVBsH4Ng0zVRkRYG5Q1CGjOw7x
 pCdT9f9awaCcV2KxZoBEuohfuoUDMPvHqPDm7BX78I1MM4Kh4XCD7TpQiaDhvplacOhP3PuCLJV
 e2K4GWlFqV1YJPhVOBYdq632A=
X-Received: by 2002:a05:7022:170a:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-185106a1606mr23666645c88.2.1792501711533; Tue, 20 Oct 2026
 06:08:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261017130047.42080-1-emmaonana18@gmail.com>
 <20261019163538.28793-1-emmaonana18@gmail.com>
In-Reply-To: <20261019163538.28793-1-emmaonana18@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Oct 2026 09:08:19 -0400
X-Gm-Features: AclHuK8lOvRZuawupQHM8p5lVPKffeC8_Y4DUib8gb6AoG1RAy7GmZeIuewnb-8
Message-ID: <CADnq5_OP+ogqr8JHRNvqE7suYLjmyogWPXiejZJrSUv7KS2DZQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/display: remove unused cgs register accessor
 typedefs
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, paulmck@kernel.org, rostedt@goodmis.org, ast@kernel.org, 
 peterz@infradead.org, gregkh@linuxfoundation.org, skhan@linuxfoundation.org, 
 Arnaud Bonnet <abo@medichon.fr>
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

Applied.  Thanks!

On Tue, Oct 20, 2026 at 3:37=E2=80=AFAM Omokefe Emmanuel Onanaroghene
<emmaonana18@gmail.com> wrote:
>
> kernel-doc reports prototype mismatches for the cgs register accessor
> typedefs, e.g.:
>
>   drivers/gpu/drm/amd/include/cgs_common.h:89: expecting prototype
>   for cgs_read_register(). Prototype was for uint32_t() instead
>
> Each of the four typedefs is used exactly once, as the type of a struct
> cgs_ops member, so they are merely an unnecessary layer of indirection.
> Drop the typedefs along with their kernel-doc comments and write the
> function pointer types directly in struct cgs_ops.
>
> While at it, drop the unused cgs_handle_t and cgs_get_firmware_info
> typedefs, and document the members of struct cgs_firmware_info.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Link: https://lore.kernel.org/all/981f01e1-0c3b-4854-9d72-8bf22af9fc64@am=
d.com/
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
> Tested-by: Arnaud Bonnet <abo@medichon.fr>
> ---
> added kernel-doc comments for struct cgs_firmware_info
>
>  drivers/gpu/drm/amd/include/cgs_common.h | 74 +++++++++---------------
>  1 file changed, 26 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/a=
md/include/cgs_common.hZZ
> index f40b6a03fe63..79522e1bec4f 100644
> --- a/drivers/gpu/drm/amd/include/cgs_common.h
> +++ b/drivers/gpu/drm/amd/include/cgs_common.h
> @@ -63,6 +63,14 @@ enum cgs_ucode_id {
>
>  /**
>   * struct cgs_firmware_info - Firmware information
> + * @version: firmware header version
> + * @fw_version: firmware version reported by the IP block
> + * @feature_version: firmware feature version
> + * @image_size: firmware image size in bytes
> + * @mc_addr: GPU address of the firmware image
> + * @ucode_start_address: ucode start address (SMU firmware only)
> + * @kptr: kernel virtual address of the firmware image
> + * @is_kicker: whether this is a "kicker" (k) firmware variant
>   */
>  struct cgs_firmware_info {
>         uint16_t                version;
> @@ -78,45 +86,6 @@ struct cgs_firmware_info {
>         bool                    is_kicker;
>  };
>
> -typedef unsigned long cgs_handle_t;
> -
> -/**
> - * cgs_read_register() - Read an MMIO register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - *
> - * Return:  register value
> - */
> -typedef uint32_t (*cgs_read_register_t)(struct cgs_device *cgs_device, u=
nsigned offset);
> -
> -/**
> - * cgs_write_register() - Write an MMIO register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - * @value:     register value
> - */
> -typedef void (*cgs_write_register_t)(struct cgs_device *cgs_device, unsi=
gned offset,
> -                                    uint32_t value);
> -
> -/**
> - * cgs_read_ind_register() - Read an indirect register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - *
> - * Return:  register value
> - */
> -typedef uint32_t (*cgs_read_ind_register_t)(struct cgs_device *cgs_devic=
e, enum cgs_ind_reg space,
> -                                           unsigned index);
> -
> -/**
> - * cgs_write_ind_register() - Write an indirect register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - * @value:     register value
> - */
> -typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, =
enum cgs_ind_reg space,
> -                                        unsigned index, uint32_t value);
> -
>  #define CGS_REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
>  #define CGS_REG_FIELD_MASK(reg, field) reg##__##field##_MASK
>
> @@ -133,18 +102,27 @@ typedef void (*cgs_write_ind_register_t)(struct cgs=
_device *cgs_device, enum cgs
>  #define CGS_WREG32_FIELD_IND(device, space, reg, field, val)   \
>         cgs_write_ind_register(device, space, ix##reg, (cgs_read_ind_regi=
ster(device, space, ix##reg) & ~CGS_REG_FIELD_MASK(reg, field)) | (val) << =
CGS_REG_FIELD_SHIFT(reg, field))
>
> -typedef int (*cgs_get_firmware_info)(struct cgs_device *cgs_device,
> -                                    enum cgs_ucode_id type,
> -                                    struct cgs_firmware_info *info);
> -
> +/**
> + * struct cgs_ops - Common Graphics Services operations
> + * @read_register: read register value
> + * @write_register: write register value
> + * @read_ind_register: read indirect register value
> + * @write_ind_register: write indirect register value
> + * @get_firmware_info: get firmware information
> + */
>  struct cgs_ops {
>         /* MMIO access */
> -       cgs_read_register_t read_register;
> -       cgs_write_register_t write_register;
> -       cgs_read_ind_register_t read_ind_register;
> -       cgs_write_ind_register_t write_ind_register;
> +       uint32_t (*read_register)(struct cgs_device *cgs_device, unsigned=
 int offset);
> +       void (*write_register)(struct cgs_device *cgs_device, unsigned in=
t offset,
> +                              uint32_t value);
> +       uint32_t (*read_ind_register)(struct cgs_device *cgs_device, enum=
 cgs_ind_reg space,
> +                                     unsigned int index);
> +       void (*write_ind_register)(struct cgs_device *cgs_device, enum cg=
s_ind_reg space,
> +                                  unsigned int index, uint32_t value);
>         /* Firmware Info */
> -       cgs_get_firmware_info get_firmware_info;
> +       int (*get_firmware_info)(struct cgs_device *cgs_device,
> +                                enum cgs_ucode_id type,
> +                                struct cgs_firmware_info *info);
>  };
>
>  struct cgs_os_ops; /* To be define in OS-specific CGS header */
> --
> 2.43.0
>
