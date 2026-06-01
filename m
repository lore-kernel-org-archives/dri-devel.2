Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0A5CD6E60
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 09:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B371130E0;
	Mon,  1 Jun 2026 09:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WwNjMwsg";
	dkim-atps=neutral
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C55B1130E0
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 09:50:28 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7e6b5ff3fb8so990701a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 02:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780307428; cv=none;
 d=google.com; s=arc-20240605;
 b=PflI8B62YHtg3AyPvQEMQG2XI+KAMlNcvTxsIL9Ad73/SKPCe6iLz8YoW5IHL1gPUS
 i2Z3KT4oBKv0laT4Dqd1yoq2mKRKMfMyx0/wM3CLUtuUf7CY/8VUTEr1XUMOz2lv4/M5
 1wVOuveRc/2v+sXbaNUhfgAzY2zHWBY6qo8wfhIPojHshUnw/YFCEzYv2PquBRxrUtBM
 ueV72Fc2gGoLM1fx0DeyxjJlBZgulbn/5r5JwbCkXjv83bapg/BrS7pjJ7UcczDfXg3q
 M256mZsCuWOhGErUyDfBnOgT4P594+DDyi72FdM7l7vXQu7T/REgwkG2Iuv+AsJos+vo
 V2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bnswxpP7ou+7v1EMFzriHdHW22x/DG+2T+rNmbrQnJY=;
 fh=EUwDFIygQGIawKyXF7a94ksfdCiZOR7VDzhg6CEiJwE=;
 b=B8HPQXyxCBaUg6ceREKES7cjudA3f+wCsnMMa4btUn00m3Fs5haMM4ntfV2g/B96pA
 vpbuRXjukNhYCaDS4vjybzjXuQnxOC1ZN666jjgP7aVMNXmaWZtxOh5ZHJyDK9tajhpk
 tO97n7UVvIl02xpPFRsLZuHAC6pxg9ut1M733accvLofJFTzVeLjA6fNprtdZk5g/6Vw
 SRANGJD6YDdT2bT9Zbw2RzYslFauEGuuMOoKqnMBBGpeMe06eKMWHXeT5uoZjfn6W70c
 l3uwCqlqWhRxrIWvtDywv/pY3tI9spYdQkx3NKvCnS3l5MDg8z5YkH5OC9u+k4bfAzkm
 33Rg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780307428; x=1780912228; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnswxpP7ou+7v1EMFzriHdHW22x/DG+2T+rNmbrQnJY=;
 b=WwNjMwsgVijvPA3n++9hpLfbpP8785+zEVCCgrgUC7bew8qqMSn9Yh7U2LDtq6bi7F
 X+s9Za6nnzKcMCnNfDmg4kyexLXYN+sV2PznfJ8gIG06afVY3/B4CaMnmAjp7O861tjy
 fjWxkIXKxqtVVqiIrxbUCS0wmhTBluf8mhTgDWvNbY36BqRblCm9UqyBR2rNaazDs+p9
 1G16as/XZDr9LRemQ5WaRxhJ2DG5Z7tEof1TbGgFIjV+2N1ZC5kYSlUZXsIe9qf/xpKV
 Ie2Mumwc9O2PzIfz2fz4JMmRyumSlmiubt5newmRg7PU0UmDK9MAUJ68xhCvBBg55cbn
 qEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780307428; x=1780912228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bnswxpP7ou+7v1EMFzriHdHW22x/DG+2T+rNmbrQnJY=;
 b=j0ex7kXxWnOgAc/XGB20tMU7IMmd8aaEnlGgOPZuK8ELvq5GzkAG29Yxgg0Bvw8dmy
 +JO1yGbaUeG5R0Ea0I2D/igSlVESoa3Y4mXfHGVZssokJI+1C0aqICGlEGwTgLP2C2h7
 pAMQta1eu1eOgqS17lbdPCJhQuuieF4VyGCQJhlXQPPzyEIr+PDvPLTzYTsC6U3TGiUS
 w/uLgMWTLGtNrQYqW5T8ZXvBTJEitFEGHTiXe7GmxjjmfzIv79K26FN+d5zxvsRpedoT
 3HlDOr0YLB+AhQMkZ6/fVRheqsulxFsNicC8noU+HCVj2VM4VlFedkByj8Agtzwpn4Ch
 Y77g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PLaEH+SuxHXuuAFgHe4Z8Z8u1G9AjZXt6q0KFm5VDbexY2cniJdeZKoo3DVOGh83QfWqR00lYnTM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAZPksz+oGNlUrokPpy8rqDkI7kWwDJeenoul0KcURGzSNBC/G
 4w8UCtdfmn6ZuNHy+lu8Y+Um3UqEAJxApSjogWXrvIGrbOT5V+dlyL6/BYymWO6m0mHyMCXplBP
 KOPwg10wWaACj9OE/8NgG/b2j2TbeOQI=
X-Gm-Gg: Acq92OFpoTH1pvruMqQ7AYMqO4iEKnSQpiJ42FvPPyndh2bH14CmpJrjQ2OHoetiLQR
 q0fIxLIe8NksuYZgwa/tZ9v24uei1a9JTO3gVHR412Epr7R18zKwk5+ecpiH0lzy/erVQg6aFZJ
 3cdneDNLW+EDh8aV5c6VJeU6dw4jO6SgwYkdBdq/y59BBj+6evJejY7gmmCKY+vVwPGqTybO7S+
 xGltaRTR+E14cLKVvTD6Wv7UUtYa+fRAbpfg9CKdHzNZel3k2ZEM+ncvYEcP8OlqFrMv7LZbv+c
 ly0obyeviYkvxwhASQ==
X-Received: by 2002:a05:6830:630e:b0:7dc:a51c:9197 with SMTP id
 46e09a7af769-7e6a2f09a9cmr5370526a34.7.1780307427747; Mon, 01 Jun 2026
 02:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260524155735.13865-1-mhun512@gmail.com>
In-Reply-To: <20260524155735.13865-1-mhun512@gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 1 Jun 2026 11:50:16 +0200
X-Gm-Features: AVHnY4J2P8yeU1a3Iz_kc4BmXJmEswG7u61lK5rEkMW2S9QxXA_I8prY59LNgYw
Message-ID: <CAMeQTsYVf_YRyuXx2XpBG822N=nMhnRbKnUNRu8OrsSthzrMrg@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: clean up modeset on backlight init failure
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
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

On Sun, May 24, 2026 at 5:57=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:
>
> psb_driver_load() initializes KMS polling before it attempts to
> initialize backlight support. If gma_backlight_init() fails, the
> function returns directly and skips psb_driver_unload(), leaving
> drm_kms_helper_poll_fini() uncalled.
>
> Use the existing error path so the partially initialized modeset state
> is unwound before probe fails.

Hi,
Yes the existing code is faulty but calling psb_driver_unload() to
unwind the init could call backlight_device_unregister() on an ERR_PTR
backlight_device which is guaranteed to fail.

The correct fix would be to convert psb_driver_load() to use devm
and/or goto unwind pattern.

-Patrik

>
> This issue was identified during our ongoing static-analysis research whi=
le
> reviewing kernel code.
>
> Fixes: 1f90b1232773 ("drm/gma500: Refactor backlight support (v2)")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/gpu/drm/gma500/psb_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/ps=
b_drv.c
> index 005ab7f535..7218026fe2 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -406,7 +406,7 @@ static int psb_driver_load(struct drm_device *dev, un=
signed long flags)
>         drm_connector_list_iter_end(&conn_iter);
>
>         if (ret)
> -               return ret;
> +               goto out_err;
>         psb_intel_opregion_enable_asle(dev);
>
>         return devm_add_action_or_reset(dev->dev, psb_device_release, dev=
);
> --
> 2.47.1
>
