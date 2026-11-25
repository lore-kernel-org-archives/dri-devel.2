Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C1606A696
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dzGnUyHJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B982410E02A;
	Wed, 25 Nov 2026 12:47:00 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABFF10E02A
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:46:54 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c50933bdf4bso1098983066b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:46:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795610812; cv=none;
 d=google.com; s=arc-20260327;
 b=o7A9q5zwU9CiJVGhvp/EDN1+yhinutTmH8S0BrAbXe/7PYiDUWpcJESfYu1FvduuYM
 /Gt9k73gV4uWnRosXvLuRlvv0XtxX5l9od9mJglc9N9+bTveyo6WX1/Ofxen2lEcSzHj
 WmqWZsZhK5ImWBxczEa39roJjHd+WPvqf9yIPpgojN3iPMYe3tiP1k7acIKDkfHHosB8
 UuKqIJNyIDw+A9ccqu4GDlQD3oexgg4zWv8cOdijiJV3Pcw3XOoXJ6OJyHBaje6H2n7Q
 B3X05VMDAwq8WpQeOy/12f63aFXImtSfErSCvUMkq2yZl/z1Yc/FeDZn38888VQps64+
 V1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IuRRg7o5Crk5KRLDhtoQ7ekunhWpm8sN3gL4hQuQRLw=;
 fh=BCybw0R/MC58O6FZfepFZU+qOdInDNW/3MISRQdfIZA=;
 b=FaaaoREi/FasoFy50j5Zj5ML7xPD968+v/7sxEjirH2WvF5ZcwNOmZiCzGGuWOAyjd
 3QPporGsAILPZ082y27JToGIa7ASlOa3Lx0gEp3yWN5Tzgu22jazPm6b2AZyKPAhLclu
 IdZywDt03n5lAQxmAyy/32BFsl8oRdMML1+WuwtnbRn7MrdoCSUS3n9WBKSqN4TPECNw
 i1P7SdvhsSQXrGVwPmiCxLvZVRsLJK0UIUA1ZGVfzmFP02LW/Mi0fkwVIpesgeRWLxP9
 n0igbcmOsrRiszTiETmXjZc0yeoUEpKBPZRWQ2O+ywf0xcVewO22tx+EQnOmmhMeBYX5
 mr7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795610812; x=1796215612; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IuRRg7o5Crk5KRLDhtoQ7ekunhWpm8sN3gL4hQuQRLw=;
 b=dzGnUyHJ78bnuDj3psG08mFLgogGRa/nL4qRXMuNSLDOxC+wphBwKEFUo5+My/tDUz
 67KqSkb6jpPv9Y8ezRNYQytOhEeQyYW20J6icCmFSVDqtc/2vZMFGeEsuS5JqQj7edMT
 sD/ac3WU/91x2O4PAybFVHsjilNTwhkCpy6Oe3yct0zSi6r8B0S5UUAnKymu3r11s3QM
 sCG/ypI3ln3eZLNuQ6qD8hVBWiZka8yPRCgKKipk5g4HZVU5/GBFvoyoQP6UodbGfPav
 Qj3g+FhwkhHDc7Z/zRKZuLhQxZJTrmeS3WoGdHvTx6rlmUG3RJKqXHKbGDZfhGILQgv7
 eivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795610812; x=1796215612;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IuRRg7o5Crk5KRLDhtoQ7ekunhWpm8sN3gL4hQuQRLw=;
 b=cOAh1F+pW8pJO7ayFNR5zflF31OJWwj6emM9qw8pOKPz2rgEAZax0rSDaJuQwPFK6Z
 vBqKOd1yfXPNn72pxEEqwfo5ClhBSY54Dq/5ILYPBPd9clbNgzSv8rMvi8Gz882EbmOP
 gI9Q5+TmDgBhsAdzN0zk/Y5RdaJkYCp6GT6RCFarDKNWUkylqOV6JD/m7fonbbPIMN3G
 Rh9OY13U48KAPrZ1kpJtRzjTL9QClljQU3lB7Whsd/B22YpmD7Ho5Pg+cnM6lrzQfVVP
 vZVlBVmABhhLW4r1KDC4qAidxv+O+z2WmTDPSg5TTOD7PHXQRt8VteGrGCagkHZgwt8W
 u7Gw==
X-Forwarded-Encrypted: i=1;
 AL+hErHEG9WD5HJZxuxUM24ZtIDc4LBEgH17JhhozW0+2LIK+uit1NfVbzkYCL8SyEZlW5WcMYg0QLegqoY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9P0aUpcx3ukkZ0ZIH9t19SH8+ZSxyqoOFm2HtfdBNo37M6CQCT
 km1g07SeQLu6HhH0MYnGG6cZSaKrff6z7v85Fhah4HZzRwOBkI+/03XFLEMN26apDVGeDKu+cKl
 HNmBa4TddoFAHKtQcK1fvoQ59JdH7AlI=
X-Gm-Gg: AZFdTZfcfDZex5xi4thuERq9C/Xw7XAe9gl30PQk9hvZPhklxzRXq2ODKs/XKBi+9z3
 iODtPIEV2NKG0aa9sTECCY/J581G5I5RwVHSmWT/CH+BBbmMajdiDdoqa3iPH/BXq/qX7TgDXCY
 Pv1xdMjVXVik4yPZZQnAv9L/w6fXmtuxuAhfwoBYC+wotxyL0yGVRjbXgwYu+z3pyRULjdjctWb
 oHxq3KzBb4+2mz8CmEarvkI3Ny/bst8varK72cLzM9Cv2SQi2fFZ6RdM7RXghcw+epowz+YyGIq
 TkZtI3Mito9Uw9A97zYdfYk7p9pG6eweqk1o4+1vOBbNmBcHkAAUSJqneVId6YYae53dkcwbYol
 rw26hObPXwWE+VBbhWnivTTH+JJQSgC3UGFupLQieppq+3XQMRuA9RUhc93/5mVPOu7s=
X-Received: by 2002:a17:907:82a4:b0:c51:37e6:e036 with SMTP id
 a640c23a62f3a-c513a86d2d9mr981007666b.16.1795610812360; Wed, 25 Nov 2026
 04:46:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260514174008.4515-1-ms.bulatov7@gmail.com>
In-Reply-To: <20260514174008.4515-1-ms.bulatov7@gmail.com>
From: =?UTF-8?B?0JzQsNGA0Log0JHRg9C70LDRgtC+0LI=?= <ms.bulatov7@gmail.com>
Date: Wed, 25 Nov 2026 15:46:40 +0300
X-Gm-Features: Aa3M54raFHFC1wO72gQwKLcaw9Cis1_IurPLDhyy4bIilG0T4ZS0DTaSVjpcl5w
Message-ID: <CAEyM3Y1QBGHedKixcW7o+9F=p7wQfDow6p2vzaK3fS4ZWP5Fxg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: handle nouveau_hw_get_clock() return value
To: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ben Skeggs <bskeggs@redhat.com>, 
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi,
Gentle ping on this patch. Please let me know if any changes or further
information are needed.
Thanks,
Mark.


On Thu, 14 May 2026 at 20:41, Bulatov Mark <ms.bulatov7@gmail.com> wrote:
>
> From: Mark Bulatov <ms.bulatov7@gmail.com>
>
> In the nv04_update_arb() function, MClk and NVClk are passed to
> nv04_calc_arb() or nv10_calc_arb(), where they are used as divisors.
> MClk and NVClk are calculated using nouveau_hw_get_clock(), which, via
> nouveau_hw_pllvals_to_clk(), can return 0, resulting in division by 0.
>
> The result of nouveau_hw_get_pllvals() in the nouveau_hw_get_clock()
> function can also return -ENOENT, which is not checked anywhere.
>
> Fix all this by adding a check.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
> Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/arb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> index 1d3542d6006b..2f59b8739fc1 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> @@ -202,6 +202,9 @@ nv04_update_arb(struct drm_device *dev, int VClk, int bpp,
>         uint32_t cfg1 = nvif_rd32(device, NV04_PFB_CFG1);
>         struct pci_dev *pdev = to_pci_dev(dev->dev);
>
> +       if (MClk <= 0 || NVClk <= 0)
> +               return;
> +
>         sim_data.pclk_khz = VClk;
>         sim_data.mclk_khz = MClk;
>         sim_data.nvclk_khz = NVClk;
> --
> 2.39.5
>
