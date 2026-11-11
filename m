Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C51606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JM14IQul
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E69C10FD10;
	Wed, 11 Nov 2026 17:20:49 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7834010E431
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:20:37 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36e2b1db9bfso94227eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:20:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794417637; cv=none;
 d=google.com; s=arc-20260327;
 b=TvuUuTgZWlv0pyEllCLFzDVZF4LZjWfOK+cq+ukOqBXJ0wx9cHjnD9StTjeLPwfIcn
 a0y8+NXFSnCEgVEbwwLxbfsLu7/s9H/GoK1R1reFZxUInntyr0W0rFJElV1+FQBBsha4
 zvmfR75mcOyqTNVbl4Wq0JOkqSEp2qDw6lt4f1G1Opfms4nhukcRC5Z79xTieHgOf7aY
 3lTXec1JeBcNFDMzZDJIlVbgd2C6F/Ed2ZHGn2Q4c5z6DehBDbTv1HOBaqRHdk0ZPU2W
 aq1jYTKnNq8FTgGiU5zw4jin3rd6pw8TjB1NT1a348oBipwZV5kz7dWndIwQIqpdcVPe
 C1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pxB40q79An19C6sh7p3I+5Mbwo7e0V/V+8imyCMYB8o=;
 fh=Ek0yIhlQOTwBqoC8bGunAV0s31qqptEWx9vT/HPo8RY=;
 b=Eyf/7ZoTxHiqxU2mAQWiStqbAogXweh6kCbd86XekkMIrthQA1RaDHRRbdffVlVN4/
 nn9Hbp4mIa6xgBe9b3/cH5+VfOIW0fUJzUh05Irv0Jg0f4/4ywOlcNkGQzWW5uXZO4eV
 znp4K8ITfzyl9l9KyTKepJBZnKJz6K4TXI8I2tB14y50YVCxE8O3o3jH/5BJSIZeb8sd
 RQg2eaI/R0p6FLcOiu3C2hOCH2pZGpqG8XbIbSPLqnLGzV1h6PaJ99Z1qvwT/zhilJSy
 xUpyeR+pWDQhIQla4DZ9KtcoO5i70VkaBlunQ0mnHS7L+9MBfBQp+jzIGG6mFA9euWU5
 Lv+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794417637; x=1795022437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pxB40q79An19C6sh7p3I+5Mbwo7e0V/V+8imyCMYB8o=;
 b=JM14IQulQOEEz5Spj6cxdLOfLouQLxXmmlq0xiej2qfldOVxCI5EGXcYY5Ric/YKFs
 dCEqfzWlMJJKSmUaRu39WNwu0nW+LqkM/0nTBPj9owqpqgsm4FCYEBfkdg6CqOYlEZdW
 iOSHnRwR7JHfjxCp2ZInp326yS50sexirBLW5aWanxnKZ5nXLu6qZBei1t0w5JjfpBmR
 mX71IVclbjCyLcEj+eY5LWQX/+9kYWRyFVhOQDTON6sbNeRZx87RDQutgPzE8qVVQrSV
 RRP3zVmnsGwboPY4BpI/QtaZBNfL7L0p8J2onJXZR6t4xTV6CXR94PllJMiTgug83cIs
 rQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417637; x=1795022437;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pxB40q79An19C6sh7p3I+5Mbwo7e0V/V+8imyCMYB8o=;
 b=bNidS2WGFsMsUqDxNMKMtabd/nxXeeqvTzC3HyAwz0sVA62ImIs+5he9IpzeMLHmfQ
 yp6HrjPt0rP49Xi2j7B4CKlzQgKk+zqJfnXhDf5ZWazEvW17RgsuP7xvawXBIXxwtunF
 ZTlO+0d5XQH1olI0CkkABz1Yg6X0qJUefS1x8TeTffyAoNKdvI1MPgpAD5QGbXFdL3CR
 nN/CTJ8YuPVIUqwk2T/ErDz0XM3GCXZCJ0CMIwmk4njmKk4eYkAMKKWHV4LxIZxdj12G
 9Ls4MnfW1IvWabu4NGhjs45yfgKdB14lAr4sUq9ZWZzqCvsYYCGDBBPn9wvAwnzs3pxx
 ma/g==
X-Forwarded-Encrypted: i=1;
 AL+hErFvELktlTZE2iYSt+tkOIuwTuF3ol98Omw/g9bVjbZSY68/u1n5BkXWZ+usfQ6aACRlBDX6MGmhinc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z82vcKfAEr1AHk5VOAUsouSK07xCD+9HFxp86Ss98gfWNU9o6i2
 btZJMKR3bQXB3PbIcjuL8EJczX5E+EHy5nGFWONNZir6qm/n4Z7le46Y+SDVhR3pCHKNZnQdJg2
 aqAHlII6dLSKIODJ1oTm2B5MPnSjLFbc=
X-Gm-Gg: AYBFou3Tsy1mFwW0hXKUlwka4bG6taXcUHE5tNZm3pPJIAPkUG4f5ceW4gEW9zzwkii
 W8Eg1tkdI/Ywy7EhFRrarHwM+U8ZCJcLxi3FNjJQiB8viHevGX8Xv4z/L//Anr1b4iTScGZxKIT
 C0C5yrhZ5vNHJ19X+RhiGzx5t3kZPSuMg+cM3jeQQmKJPrdRaCJyxBgphp+8jnQ1w93kDe2bM3n
 ZXM+5eu7cKbqfgO4finkImgQn+PaG3Gm2Q6Wl5Urds11rJeagvpGf9lao/sQou/2tYOAQn5kLUn
 /rjcFADVmPltzkD8G1zsfymZQ+LV1zy4SdfNbX0SQsPMOwNF6kx/8bigT2uck1KDfE3weHlLe9R
 I3hY5V76JYP73jgAIS3y44sRB4uBuw/IRRcuuG6Bo0Qxxmn4aur8xbcf7UgzWVIJgP5ktYpi5Oo
 cfZvnW46kE+1m6EJSocApAqZUv6oluI9uy9Q/IYfHoji42R0ucr/UwrFVOc4I=
X-Received: by 2002:a05:701b:450c:20b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1b3c02cf135mr4365930c88.1.1794417636541; Wed, 11 Nov 2026
 09:20:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110160429.892673-1-colin.i.king@gmail.com>
In-Reply-To: <20261110160429.892673-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 12:20:24 -0500
X-Gm-Features: AclHuK96pzFNcsCpriytYsF_JfHFuBx3rYaQSacUjjgQ682B45jmkk_N34BB_lU
Message-ID: <CADnq5_OWtqzN9VDK7F6F_FBy9XkDmk_1jAMR6bivEsJABe1rag@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: make the read-only const array
 fw_err_code_msg static
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

Reviewed and applied.  Thanks!

On Tue, Nov 10, 2026 at 11:31=E2=80=AFAM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> Don't populate the read-only const array fw_err_code_msg on the stack
> at run time, instead make it static
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ualink.c
> index d025b4183b29..91c863649972 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -5427,7 +5427,7 @@ static int amdgpu_ualink_metadata_init(struct amdgp=
u_device *adev)
>   */
>  static void amdgpu_ualink_remote_error(struct amdgpu_device *adev, u32 s=
tatus)
>  {
> -       const char *fw_err_code_msg[] =3D {
> +       static const char * const fw_err_code_msg[] =3D {
>                 "Unknown FW error status",
>                 "FIFO overflow",                /* error code 1 */
>                 "Invalid RB command",
> --
> 2.55.0
>
