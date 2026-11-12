Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09796606A335
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0YO+/Ahq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6497C1123BB;
	Thu, 12 Nov 2026 22:18:07 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A201123DF
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:18:01 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-6de0079fe11so22738eaf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:18:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794521880; cv=none;
 d=google.com; s=arc-20260327;
 b=A5UnimnWeW+0zjgQZtal6LJWiqMHe0MkyX4gfeN026O+p/wS4LBR6x1gLsT1pX40c1
 9F9jRQc00PEdALTfTDYpHnc2q9iwerHpysppPOXpcdG6CjPjMk/auuDNR+kWufxzguM9
 gy6bSIsDr19qkp4UTqWgWT1DkmOlCaAQwFD7Lyt38zIEGwcLjMF4T24ksZMC1oqzsk/1
 DVcmmQNxZcAxMqZlssFNI4k08d4B2VeVkRabgTRKsI03HZOz+V7xWfiQ5ztGA14yf1D7
 nltxs4LwsK5ZtVTQAih2bVW8pDLfi/zOqAEngrHbNILoVtEQtkzY14tbMiWdsKzdq5nQ
 mTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=psdFpjCIYItqoCV3zld+fU2KEcPb1MgRoHlxQPHBj2Y=;
 fh=Bi2D8HelB8eZI2ua/jaGSfRWuX7tsi7YCoi+EZSFKEM=;
 b=ZxOW6PjUQgA6AUStOpBzIlQilWEikgOJpTlsNhFOD6gOfysfzPGz9/qjV+Yil++X1q
 QP7gVKQD7q0nREuv/jqJn2fjkOVdSRE8pVH7yPtMYem6u+SJO9ixplh3R7ZqiSX3DL0Q
 WZCLtQlvzEZDMPDD7lW4wTq/5uOz1HGlQQY1W1txgGKfRpXSuXY7J1iTBv1AL4OevCp1
 LN6FL15M4tfO2OLhPOCH1ha2TTlrXuMbQaBGS28MRxHuKvjr+Xi4uMEHlqIcI4qC1k3c
 92osbH8B80q3WatWdT1p8Tlc+otcYWmkmr2X+G+JiZNR0SPeZcAp7H49+DQLnRsvxcDu
 Z1FQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794521880; x=1795126680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=psdFpjCIYItqoCV3zld+fU2KEcPb1MgRoHlxQPHBj2Y=;
 b=0YO+/AhqLT6NlF1QOXML2lkB2bjnok17dQGR15oG9TVcdJLM5YdhE7I18zMzo7l9Sm
 D6LOl9b7Akri4dyIr762P/LkgUmA/zjn1tELolYdhViC4xhCldJmNG3AVoMLnWqnmizn
 ubq/GJlDmZkUYYaXG2HB+zstbENatCAoK5D87PN2TZrdKb5WpsTJLnZ1CBl2XFiw6ToY
 +hvEXFuwqRr5gLw6jN7OSyguSNH2acFlxhJxM5T7LmdPq5stF0u+CzFS0q9Mmv+zzKa2
 50CjdwCmCtct+l/MOWpED/ZAoIhRJjW3IhIllsTJwiFiju5ktLzQ+YKdRHRQUXXuCMTO
 D8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794521880; x=1795126680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=psdFpjCIYItqoCV3zld+fU2KEcPb1MgRoHlxQPHBj2Y=;
 b=s1VJ7/mrRcXblHFjJb3DUfDIRU/W4zgHr1fqhVuxfm0W2+RUKj5D787HvB/Gj5FyRG
 f++wzJou1OkbEehLE02kBBpuIIpdQ9uEG3AmIW1IvckioW6BM5sJPZEA0lLfghSiDHdb
 M6TfOcJgfL8V7LPyjaEZJ0krUt5ehspQtKtFJc7NVntBqpIUyuRiEGcFFdiuvmlitmHW
 UjKk8DkRyABRvgRBQc9bq7taKYsCKEPoTt4/kJ7WXGLHn1emVmd/AzburHsYHLrs1K+T
 1Yh8g+4UxvDZBq7jVPHSXR/4xNE+UDr55fr70P7Tc/moLIAFXoYueA6zdgh1/vvLxjIW
 0dTA==
X-Forwarded-Encrypted: i=1;
 AL+hErErlily7kq4QAH4aqfQKdxnAeXCfqdQTzML0r9LGB9L9AwJ+bErOuLJK9C1OOtRFFu36EOqPTGcJ9E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+UfGVctv/WfocCfpgGtvaUyGLWpQnTC/MNRXZz4r+/zKVP16aj
 o2WgSLcqW95tnTWlSpw2LzUd6yT0OSqePZIlng1yX+EyGh6CcWggpgT/K9CDh9Dk2kZiBsG2CmD
 AT1GYguEmyGGNffeO+Y9jGoTLMjVpYvk=
X-Gm-Gg: AYBFou2AyjvhntrVtj8XVSENYeSJgaZJhOwCuT1+MZdCP2gP1bKvK0QyvhwqSE0Ccwc
 7GSpRL8Uo9YeWv+25XVr/mrktuCDKyS2dEPGolxfZ1WmVTaYQy6FPPNwTVS63lr37gEaircCD1g
 f/0MOhEyitgANAsHw0AuJTMRwQPR62/1XusFmwj4FFDU8AQu3UtQsP1sVrRbwG50Xp4NXF07gO3
 egsU7YIZAJsG9Bps2vud3z6SlbE7bSgaGssvXXxiWVjuswrAzK+QFj0LbJoOVOB/9zTTAZa0/Hk
 gIRp0JsyTqF7a3sLNtfINMQuXC6rip9f2b2msdHwdjXAGuzVwIGtNyLHjNBPtQkSFtajzE96ePL
 92furxVwNKfXlVJZY98V3Hcztcf/tj8hMoC8n/4ikm7SPKPSlkZvim9FXrNDK+aYCNq0qM0R0jZ
 StBTVixE6zbMkuUTLV4d572QBmNxTvuRijBWgic5d/04VyLV15Q7YiLoT8+acO
X-Received: by 2002:a05:6808:2220:b0:55c:866:20de with SMTP id
 5614622812f47-56e61801b33mr711596b6e.2.1794521880319; Thu, 12 Nov 2026
 14:18:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110011256.157652-1-ayush37735@gmail.com>
In-Reply-To: <20261110011256.157652-1-ayush37735@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2026 17:17:49 -0500
X-Gm-Features: AclHuK-df_vccOaqqVAFUznT-7qkiRVcZLObgYhZxxXeA24pixt6PcSBum-qZPg
Message-ID: <CADnq5_OJSeR4vKDUmYXRZMTzftFuqzPPumMmYAubcDTd99VKVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix kernel-doc in amdgpu_gfx.h
To: Ayush <ayush37735@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked and applied.  Thanks!

On Tue, Nov 10, 2026 at 6:51=E2=80=AFAM Ayush <ayush37735@gmail.com> wrote:
>
> Fix kernel-doc warnings in drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h by
> adding the missing 'struct' keyword to amdgpu_rb_config, properly
> formatting and aligning member documentation comments, and adding
> an explicit Return: block for amdgpu_gfx_create_bitmask().
>
> Validated with ./scripts/kernel-doc -v -none -Wall -Werror.
>
> Signed-off-by: Ayush <ayush37735@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 31 +++++++++++--------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 5939e1fb3..96f4e4ce2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -181,7 +181,7 @@ struct amdgpu_kiq {
>  #define AMDGPU_GFX_MAX_SH_PER_SE 2
>
>  /**
> - * amdgpu_rb_config - Configure a single Render Backend (RB)
> + * struct amdgpu_rb_config - Configure a single Render Backend (RB)
>   *
>   * Bad RBs are fused off and there is a harvest register the driver read=
s to
>   * determine which RB(s) are fused off so that the driver can configure =
the
> @@ -191,34 +191,28 @@ struct amdgpu_kiq {
>   */
>  struct amdgpu_rb_config {
>         /**
> -        * @rb_backend_disable:
> -        *
> -        * The value captured from register RB_BACKEND_DISABLE indicates =
if the
> -        * RB backend is disabled or not.
> +        * @rb_backend_disable: The value captured from register
> +        * RB_BACKEND_DISABLE indicates if the RB backend is disabled or =
not.
>          */
>         uint32_t rb_backend_disable;
>
>         /**
> -        * @user_rb_backend_disable:
> -        *
> -        * The value captured from register USER_RB_BACKEND_DISABLE indic=
ates
> -        * if the User RB backend is disabled or not.
> +        * @user_rb_backend_disable: The value captured from register
> +        * USER_RB_BACKEND_DISABLE indicates if the User RB backend is di=
sabled
> +        * or not.
>          */
>         uint32_t user_rb_backend_disable;
>
>         /**
> -        * @raster_config:
> -        *
> -        * To set up all of the states, it is necessary to have two regis=
ters
> -        * to keep all of the states. This field holds the first register=
.
> +        * @raster_config: To set up all of the states, it is necessary t=
o have
> +        * two registers to keep all of the states. This field holds the =
first
> +        * register.
>          */
>         uint32_t raster_config;
>
>         /**
> -        * @raster_config_1:
> -        *
> -        * To set up all of the states, it is necessary to have two regis=
ters
> -        * to keep all of the states. This field holds the second registe=
r.
> +        * @raster_config_1: This field holds the second register for set=
ting
> +        * up the raster states.
>          */
>         uint32_t raster_config_1;
>  };
> @@ -587,7 +581,8 @@ struct amdgpu_gfx_ras_mem_id_entry {
>   * @bit_width: length of the mask
>   *
>   * create a variable length bit mask.
> - * Returns the bitmask.
> + *
> + * Return: The generated bitmask.
>   */
>  static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
>  {
> --
> 2.53.0
>
