Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585B9C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A353F10E39E;
	Thu, 16 Jul 2026 17:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FQg1nPwd";
	dkim-atps=neutral
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789E610E3A8
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 17:27:17 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-73791ee3612so4916451137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784222836; x=1784827636;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/+e23JcNVFx8gZSSL5ANTlq3xcFQyDrwuzKZn2ex4fg=;
 b=FQg1nPwdNQEzYSkrx6CPYUosje4P9UINOkJ83PGOmxG0XIIQrEg9MMxH5AEtSPSmow
 O1bxo/RyMPAC/Da92Bl/Or7Ezt8EseQYLKtOQisM+W+8ljUBpuJSsyfk3NkJxFsyvO4R
 Z81Ca3tPk3ADo4FLOsj2fVcumz76LyBtEu12k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222836; x=1784827636;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/+e23JcNVFx8gZSSL5ANTlq3xcFQyDrwuzKZn2ex4fg=;
 b=nxAu/WgYotW9rMTjeNMFe6tQmjoKPPaqv46g/Zu0UXOygZ5rNLVT/mxME+teu8UCDY
 L32ZxUwJkzZmQaAjDkEswYNjKG2HboTwttoacF9vnkJA1vsQLQ5cvm42oPRRPJKid/yb
 Yh/eyks/us9bEeCCfAfjXmPPgV9BeK3Qye6u0CRQai7r05QK2IWi8RkyvTywwQLLxx2n
 ea+nPCFnFF175RmixscIz4TXq3hRyU6C4UYNpDJStXt5CujjuJ/zGbSelVmIHKj+yLZv
 OLhrfc/2ggubf2XPEVBebdVYiWF3eb1nuW4vODCXQxcKmtnjFkJ4s5O7zG2nfYGfrNF3
 /KFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCMRiYMLZV7nsduvQrKyuW2GETV88EfjIDDaKrLbBmCjxDyCITqVGIHgyBsWecDtsObR7YHLtLqVk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVI7l08EMFGsJi2eLN1UOcLahMN+1R1ULVejr4p0G5gsjmxukM
 2VDK3Cug0PZC9DWlSadO8CK0OshSfGA3RYD8gKuLvlPPPGIBV/fsRm7HEMbGVD0QpfE5Fa96TBn
 SETg=
X-Gm-Gg: AfdE7clyeaSR/vT9mzrRdKDW0lvkkuHj9UetI0gKkYnQA23V+OThp1heHvXHcK3Veve
 7ZfhFSzclLEAN6hylX0kHjmj+2OX7SizGYjBi+86GJnUP/NvhNPVlrQePeB+18BcVEmKzFi/rjz
 TA2NJfh8VJWbeLeuLrjlM9NX/U/0fYpn01vBAQk+1Se8SUe7qKF3Y5E7nGTGwYXylkgzoecl8Cl
 N5Ti/HZ+Rpi6RQX8v07SGXdtPsPZEp0vvMR1Y+Jxg63lJ3pRlp0qwRe6oWtuBZ61BUg0+y7b4y2
 xJTdxjDtnzBs4+7Lq4h5xSh25hP5dv2CQwZxntJPU5eT+U9ZuEuzPdKIyxJUY9RjkezSx0BXNRJ
 VGBk+Elb7qjo+/n54sb2hV05jnM7NUNzwq3jI+EMxTovvG8b2sUG0pKj8eIRjjF7nhl8UzvY1UZ
 dB4cUi6qwv7m0Sv9x9IzMM28taD2t9MiB1mPv44+ev
X-Received: by 2002:a05:6102:4424:b0:737:172e:e4f6 with SMTP id
 ada2fe7eead31-74599fb7d9cmr4678215137.16.1784222835895; 
 Thu, 16 Jul 2026 10:27:15 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com.
 [209.85.217.48]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96ed3184b2asm11947367241.5.2026.07.16.10.27.14
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 10:27:14 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-737de525d2eso6908271137.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 10:27:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+NNE1ZCgsLQpWUVcQbL5724DAUkKgmnuHyqaqIuRf8KriVK8aBkPwn4Pc4+Z47yTQ+S/CBSJ3CSc=@lists.freedesktop.org
X-Received: by 2002:a05:6102:b0c:b0:737:9003:ac54 with SMTP id
 ada2fe7eead31-74599a5eb5dmr5200594137.0.1784222833541; Thu, 16 Jul 2026
 10:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260716132245.1565121-1-johan@kernel.org>
In-Reply-To: <20260716132245.1565121-1-johan@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 16 Jul 2026 10:27:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZPhzHU+Pet2m3L+Pqc7mOPfZC-f5p0OuNL79wNZPxRg@mail.gmail.com>
X-Gm-Features: AUfX_mybrPewzceVCMAi6NXhHey442sHFF_0almrtqjFhI8TDoSlKrFVRqxrFQM
Message-ID: <CAD=FV=VZPhzHU+Pet2m3L+Pqc7mOPfZC-f5p0OuNL79wNZPxRg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: take i2c adapter module reference
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi,

On Thu, Jul 16, 2026 at 6:22=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
>
> Switch to using of_get_i2c_adapter_by_node() which also takes a
> reference to the adapter module so that an attempt to unload the module
> while in use fails gracefully instead of blocking uninterruptibly.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Worth adding any "Fixes:" tag? I guess this has been using
of_find_i2c_adapter_by_node() for a long time...

Sashiko-bot review [1] seems right, even though it's pointing out
something that isn't really a new problem and is very much a corner
case where someone is crafting an intentionally ridiculous device
tree. If you agree, I wouldn't mind a followup patch fixing that, too.
;-)

[1] https://lore.kernel.org/r/20260716133420.187131F000E9@smtp.kernel.org/
