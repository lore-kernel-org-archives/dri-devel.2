Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809DC606A322
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fxqW06az
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB0F910FC6B;
	Wed, 28 Oct 2026 13:42:08 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B3D710FCA2
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:42:02 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-46556b9e02cso607967fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 06:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793194921; cv=none;
 d=google.com; s=arc-20260327;
 b=Xcr7MHiptBolGSZu5SNDTY/J9aNKIpDQY9MKfVp3jW5r12Ip0YefmSssv3/wNu7CW0
 NQlK3UTv07NcOOUz+RUc7R72k/mlAGj02RDTOCo4EDI2wKS/ZpDizzFq9rLSxepPieOY
 EAY2iPDA+WC60COBGuln5y5WyMAuWk1JqBhmULRnYPOBqr0DYcnMVdTmBNxVqqxDU6W/
 b74nJDokbbQecUNgdBE4QzA+KEhAKl0xRzlmfmp5fa78A/5/tAybAoURk/vXlnPHmFbD
 QFzVFk2/bgiXtDeM5gC02MLfVi4x33VCGkKre4ZMaHIwC7fpYeMZaIpZi7JcBcoJZCuL
 rnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HWavZ6/zSVisPj33wFjAW+QGbNYpScdop0n6pN4rj5w=;
 fh=c6V8/V1mS4vPmfMkqKTCccpC6ji+pMvxXBywmgZEQc8=;
 b=eNq97JZKuKTPwVgSAb+euSoM/RbGo7vA1li7vpqP41/YyuZhr/OO6YakHtHSlrZuAt
 9VGDGJi61V/gnXHuHZ0DZb7cWJKfXgk8fHxH2Ce90ENN2h6Fx0nVISckDIraKtlqGljL
 j15y9I5yDBEx7t1Oi24HENV0ZLxM6Mo5FlpyxdPtS1Yd3Q+rkKg3JUToIicL9Wm53rtx
 W7x/l7z0InwtWhkgcvp4hdEr7md1ssITvJydQyv75DZi/Y7WvybxtX3o9yn+IxUyGmnU
 xPK8HCwuXdL44n9xm5RQpgKX+O8fo/ZdZec5Q7I4zBS4FhWCwGj8LNMkPGaLWAav7ezq
 0M8Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793194921; x=1793799721; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HWavZ6/zSVisPj33wFjAW+QGbNYpScdop0n6pN4rj5w=;
 b=fxqW06azlEuvOR1SCOAOt5pYZaahFNFYe3RoXWlHHuV9ilnbH19qCNPKixAA6KP8cJ
 WoCgadAIYTziNro0yaPH6EDSqw2wley3/nWl39pqU7wW/Dl91/bQ2XMvthorcNBlTobx
 fM9S75FlToEn4gcLHIGXY2YurwiGcMVkg5wntNYj7STzY+XtVG5ZvbXOvzBLToOP+gBR
 aNAk756a/SXtmGUkXu4yIyKW+8IgAlxYii3IbZIlrRLRt7J3QynklhkJEaHADJxhq5bD
 Vh5ZMxogYSNcFrl/e4Ywf03McHIHVEExGmJnFqfvt9zDDI8OImuZkiGr2Az5Cl29YhiL
 icag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194921; x=1793799721;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HWavZ6/zSVisPj33wFjAW+QGbNYpScdop0n6pN4rj5w=;
 b=IDhq25gm3xRUBXfeZv4RlOaNPJoe7T6vgtLDxdnGPzoP7fU/yzCCQWR6Z6IjOn2JAm
 38LSWLopwam06zohwqgP1yOU+N7/EEVkU5sr3/KydBH9jc2PKNAoAnG09IMIqZOMJKcs
 YQhmumPkjydfyLyUUsLrM1OrpgZwSs25QH2kkXm11dssQbY7iMyh5eJvumCort0n96OR
 vhe3BX2PvXZOJQ+47KT5PavHqOuAljA9SafpXExTs4cBJ9gP277f+5G1+1BVqTOuqRx5
 oKJxHkbOI1ZFx7TsOslgkdZHnQz2SryPC7RA5xhY0VEUlVYjSemLMZ7vevzCh4paX87S
 xh0Q==
X-Gm-Message-State: AFq9FYKVfP0p7Q9sfD1O1z+CrXD3aTUjMEAChtFFncsh+gSyjym5GZc4
 WsbV1JDgrwi1TEG40PSLQAOBz7ylX0x1PL6cOvZfFAWVOb0/rKQ/0X6JGtR7ywGmmjRsYN7/Ue0
 lEp5C7fGlFw0tLrC2N5NYYz3fpvf5P/4=
X-Gm-Gg: AYBFou2vIt8JiXHnLVwftcL5vmKUooQpbkmwjjjqWqKRMxpfP+OJ1C87F8wYumdmrPP
 6ArKIi75ttDWix5QLD/QGJuuL9pnfuhEUQEYriYUYEd3EZKtCrBd3iUKtoM+5aCunOOUJrSHU77
 bfxbrC0FtFw2z5g6gPL+wzccUuFO4Bc4Zf8XGW7Ze5eWKIWUt32H13Fd+FAtaQv4M44N0PfoBQg
 v2g/oxp3VdXWYHy/b2HyBxR0OLdQk4yyqhrVG6/A5TowyxGW40czubogZrv4TvgQEUZ0IE3GjJ+
 dNa0n1wV6DPyJQaIjnI4rnzXf+5gZL4309Fjb2cVkru2tY4mj2PCAti67mWRvubwPYOCKZiWOpu
 S0EXrkblsQVNGInSV91YcliVPw5Dmuz3k7Lem4eiSaKcy6oeOAmOHaYkdOoj/pM5+Fme3jfIE
X-Received: by 2002:a05:6870:f202:b0:49e:cbe:9968 with SMTP id
 586e51a60fabf-4a89b867a92mr3003622fac.28.1793194921538; Wed, 28 Oct 2026
 06:42:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028132536.375927-1-ziaowang2007@gmail.com>
 <20261028132536.375927-3-ziaowang2007@gmail.com>
In-Reply-To: <20261028132536.375927-3-ziaowang2007@gmail.com>
From: Jie Feng <hjf3108@gmail.com>
Date: Wed, 28 Oct 2026 21:41:24 +0800
X-Gm-Features: AclHuK_zqJxUnPCaNFg8MbtA5PoBLjeNjF1hMKIEkWPTHAkMWku6PNDEB4ByHCM
Message-ID: <CABOQOSUsZ6C324EXJgVKeshpQ3druMU331n9Gp-bOC18FimQXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] HID: quirks: Ignore Valkyrie USB LCD devices
To: ZiAo Wang <ziaowang2007@gmail.com>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 at 21:26, ZiAo Wang <ziaowang2007@gmail.com> wrote:
>
> Valkyrie USB LCD devices (0x345f:0x9132) expose a HID interface
> for vendor-specific display control commands and a separate USB
> interface for bulk framebuffer transfers.
>
> The HID interface is not intended for input and should be managed
> by the dedicated USB display driver instead of the HID subsystem.
>
> Add the device to the HID quirk table with HID_QUIRK_IGNORE to
> prevent the HID driver from binding to it.
>
> Signed-off-by: ZiAo Wang <ziaowang2007@gmail.com>
> ---
>  drivers/hid/hid-ids.h    | 3 +++
>  drivers/hid/hid-quirks.c | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 91319aa651..d135ea8f06 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1704,4 +1704,7 @@
>  #define USB_VENDOR_ID_HUAWEI                   0x12d1
>  #define USB_DEVICE_ID_HUAWEI_CD30KBD           0x109b
>
> +#define USB_VENDOR_ID_VALKYRIE                 0x345f
> +#define USB_PRODUCT_ID_VALKYRIE_LCD            0x9132
This VID and PID pair is used by all macrosilicon usb display adapters,
so it wouldn't just affect this product.

It also doesn't seem to negatively affect the device and is
useful for debugging, so I wouldn't recommend ignoring it.

>  #endif
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 793db001a6..70ada7320c 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -226,6 +226,7 @@ static const struct hid_device_id hid_quirks[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_YJXCHIP, USB_DEVICE_ID_YJXCHIP_MOUSE),
>                 HID_QUIRK_ALWAYS_POLL },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_GROUP_AUDIO), HID_QUIRK_NOGET },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_VALKYRIE, USB_PRODUCT_ID_VALKYRIE_LCD), HID_QUIRK_IGNORE },
>
>         { 0 }
>  };
> --
> 2.56.0
>
