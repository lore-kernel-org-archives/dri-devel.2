Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B21C606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X7UXFdgU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D336410F305;
	Tue, 27 Oct 2026 09:32:07 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4B910ED36
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:44:59 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-705cb6ceebaso1902588eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007899; cv=none;
 d=google.com; s=arc-20260327;
 b=TbWXi+p6vGCAQG/fwlcfgvUYNXThULUFSgQvzBu2Jhqvf4uGiZIstfR6wpBV/NA8Jc
 atWhnDz8Lm/gLMOOh9EMigWaKMcXd2tDia/IYay3T6TK/9hZwFW798MGBEEbA/idjFqZ
 nWGLlBsFAwT40bbpWQ2HyFe18mYQ44qvj09Tk90fijU7Ko+weg4ZjWn8mwyR7de6M2RJ
 f6Xx6AY21iRmvs/kStzPDu6h8PT1qH0B3tZoe5F/fh4SvXD8uMbWb13JXPXj3Y4OXOFd
 Gv4cQY+u4nvwNiSIJc8tfnZcnnaWQtPKe5mBeRucMSx40A7hT+ei/RjRWezIxyjgCBay
 6/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YySXXUFBOHmytywvVTLMkHqN01ZYut8GdXtuh1QQB84=;
 fh=Ac/vhb+NRS8TfwEUL7OEIS+sPToFAd9EloFdbI8QWEM=;
 b=gGD7UI5wLyRXHvWOOhGmf76pDbDqd4bnPWdeaua5ipyOHv7Y7/xuAdzwtJHOhn9/6X
 5mWJuJUpMCJKQrb721ton5YfoXw9dVJ5B7uZ8TciQny3xHyv3vMBFdpwi8+vI82t8M1Z
 gz7ie7WVuzCfjzsVaJ3OhYrESZv3uMmD42T7pQ5e03kICh6ZCGWv/KrFljI+855o9i4X
 HDyeyI8nZSj5FWLkLbV6x/5aKyiy4M1kO8fKb/VSqjiYtDnTE+hwalWzYBgJxQpO7oav
 pdw1RmDG9F5Cx0RBnYjImWCopYXcCUKV2aE4gKRvvwkt1dWfTYO6vrXMqz/wuii6v60w
 KOeA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793007899; x=1793612699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YySXXUFBOHmytywvVTLMkHqN01ZYut8GdXtuh1QQB84=;
 b=X7UXFdgUp8l30BR1RPZT0m9nep5dbSQ+rLbZYjsRn9vUVZ8ADN9fcekT2rjydjZ1Lx
 t731dZfyPnUxmA7MOCX7/3VqI0Fr3J7n74oTzkO6cBq5fcHYWqfT16Mn464TSW5XP1n7
 V+TpPk8ZZN0viMp3cmgC9QuJMGdhDgN1jyIvUnqabLSm8e28mB8uZPFrxh+exiTWmsRH
 GjXs40ICdqVcVtLwnjundaqlU4QnAi8liux8xn+cuGuhMI1KQ4wHytPrNytsg3BEsvpg
 puwzvPz6UP5JLbINq/qho54j16ytR6SmmETIVl6ZF09YYxwY+LwVQb38/TZf4cDZUTH0
 XpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007899; x=1793612699;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YySXXUFBOHmytywvVTLMkHqN01ZYut8GdXtuh1QQB84=;
 b=tp1arvMF2iIaXLoY1v6ww1jwIkuVfb+RFJWGER4rBScvwhSnL6p0Wv5k3kJtBEDV6K
 JgxIeVwu2gPGV3TvXlUQr7G8krFs5EDG/p+J47OMMM5Ww5dnN95fKfxaO3oXFES7pR/c
 v6nVueN5f43iew6b/SLpx6lmdS7zN1cvrKlWsPq0d1FQGerppv4NWB5LQvCI19shNgDs
 0hgJu++1nPhJskrQRJ0ZKLYEGQRO8NN0/E2AVTHUY4xsH5Gy5JFx5STMLZm54f5SZryF
 VAR6q3A6b42fpk+5nJT2aEXKchKK/bz9HWNW3Gjy/cFBJIjTz9BF8uTsI3yHgM6WJEfE
 OhzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFo+V8BGcEegpP8GSwZGb8qQz06Du6TCifWXQMOpYgQkYB6FvMb/n5FsWVygNTdlhJeO+fWdmkWsA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKQppjfTholEZBXt8JfYtwsu8lfhUAEEd/FsROT5xgjX4jv1qa1
 u0RyYQ4Si5fCuYBsft5SqysBNqb2SwBb4zkUa9ElFk7bJrXfx2Vnl2WGRsFIVAW6BfnoCahQ+im
 f90yd+3UVw199GFEsFY2TEGGi1Nj+L8E=
X-Gm-Gg: AYBFou0gTEm+nh9FvuYswqyymZV2QWCyITRG5zBr/K0e4bnXB+pLX7NVtLeT8/zup1g
 T2GKbdk++IkXgYT4LE1t7ARflPrIyX7TStG893q/DAICN+Gxycc+WagiVHaGe0mK8liF80uCl46
 x13Y2byd8a7VzHkIQ3/GEfUprRcZs0+ogTXbsttSmNSRtZZeHQr15dY/ECP0V9+o8PDolY/rYFr
 ZZlkQlvTJPWuq0PIucaFfFvQh7/TbHw2p8q/WeSfPZIpUjT4zP4/zLpsQz7bvUsA7CN2SFGARD9
 jxUj727jIrJyMXNpu9H2+vAdiX8d3FAEav4KhDAdWxwkvEyveKxbwc9jkvHoN2/qhvs+docdIvt
 /qH1ZhNqs+rfGF9WjkMKj2pjfCtRhBFSiC7l2BFmV98Kd6bXjDfrl7jMURzrCqVGbsI5iGhioe+
 vIdhfga2/6lYi5mIq5
X-Received: by 2002:a05:6820:7089:20b0:70e:2096:8098 with SMTP id
 006d021491bc7-70e20968319mr679857eaf.83.1793007898903; Mon, 26 Oct 2026
 02:44:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
In-Reply-To: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 15:14:47 +0530
X-Gm-Features: AclHuK8g_L7SXnsINc9C_3whJRkCHOJJj2ujrSiDjnaE7GbNryakHGpTdm_klP4
Message-ID: <CAGLmz9KsGrVEFRO-dQv559ArJRKs7yOiR5wY4T_aFAeuvNhg=Q@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
To: andy@kernel.org, gregkh@linuxfoundation.org
Cc: dennylin0707@gmail.com, cenzhang@linux.microsoft.com, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 error27@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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

On Mon, Oct 26, 2026 at 2:54=E2=80=AFPM himanshu bakshi
<himanshu.bakshi478@gmail.com> wrote:
>
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
>
> The fbtft_init_dbg() macro is not being used, so delete it.
>
> Reviewed-by: Dan Carpenter error27@gmail.com
>
> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft.h | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.=
h
> index 40a7567df1eb..16459e4e0ba0 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -420,13 +420,6 @@ module_spi_driver(fbtft_driver_spi_driver);
>  #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
>  #define DEBUG_VERIFY_GPIOS          BIT(31)
>
> -#define fbtft_init_dbg(dev, format, arg...)                  \
> -do {                                                         \
> -       if (unlikely((dev)->platform_data &&                 \
> -           (((struct fbtft_platform_data *)(dev)->platform_data)->displa=
y.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
> -               dev_info(dev, format, ##arg);                \
> -} while (0)
> -
>  #define fbtft_par_dbg(level, par, format, arg...)            \
>  do {                                                         \
>         if (unlikely((par)->debug & (level)))                    \
> --
> 2.56.0
>

Hi Andy,

For testing, I have compiled the driver successfully and
verified that  fbtft_init_dbg() has no call sites in the kernel
tree.

Thank you for the review.

Thanks and Regards,
Himanshu Bakshi
