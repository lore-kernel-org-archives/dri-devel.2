Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB03C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2AC810E27F;
	Wed, 26 Aug 2026 14:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jepzJ9LG";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E41210E27F
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:20:15 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1124034a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787754014; x=1788358814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/1XUCO5ehW6HIK1UxtZ/MdhG2zZvli3B4/DG5Oizxoc=;
 b=jepzJ9LGLn1kCWL+ayrUhIGycRvU0QUkaZHG63CHpCo6MPItwRbGB1LdJegsvxPFBu
 eYTXn/vgPkdLFX0wMFoJo1EugBb7UtmR4keWjbbX4Ai3XXUySKkXtaL1zFijWcE4OSgh
 /bJp38mK7jtn6oTEjRw+mVnh38Zzt3LUnpADVXomSb5JTYhkdjw6bZN0WkIF1dMfEYry
 nyrX3/B2O80ffospLU1N3fc9Gm7FIbCGgKNTY4GsZwFfaYQGXx+ehRIz2+3oyrBVGxe9
 KqLtkEJTIcQCgOHk+SrfDHNcZyjM3g4/pyrs/3+u0VguMQMOj6pljOe5O2bOWil3Wj1i
 bPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787754014; x=1788358814;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/1XUCO5ehW6HIK1UxtZ/MdhG2zZvli3B4/DG5Oizxoc=;
 b=rCvUV6Sh6RQQhxq8B4S92BdAJQie24bbjvSc38w1nZd+B/InILf1NvA5oIWAKMVui7
 nifO3Z7n7ZPnSgWwR8zsX1ABj2mxWhc1XXJe2i4ys9RS65dWaSdhSp0WNTYgakAVO+vQ
 7+sIsFVj9+QPsxM7JiDWEmYCkl5wiWZRIbxCpJ+krxcw9XJd42ay01w3l7WyJo7JmsTs
 BFpLZXSZJ5RqfNRAQr51GAy+g33qIRzkZnlMT6VhzAftXYTTQve3Mm0Nv1QFHiraKyL1
 KSFktDlJbmLOJvsXzUCB4tzv66vry4YxItK+u0pJ6rEM4ftaYt+pEJuaIwmldZKhhpu2
 8T9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOdWmN7/my9KSb6L25rnBXM4sSUUErTQrFxVrVn9bXH2EkQ3rORvkiW6LoPaesKikg2fzRvmUjTUA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mIeanXO7JRza/z26pb4YHC0XFqhGTP/hNKfWmBzbE19EyPsrxc
 Z6Nv/u72ctSS+mvGqdhEPw5jAbxScMflJV8j7MCDDMqmmc8XXCjXt6eb
X-Gm-Gg: AR+sD128XXWTdF04XkpEsPgJ2LSYH0rj6zRsgLruGn80SIsydA0b6m0iTQhUV4juSm7
 563zoatotMlwriKrWG7wOFimehSB04V2GvkxGWyKBFASWFYuiv7/tpYNNHIkrsu+eQbkB8WRqm9
 KxH8ubij9xIm180ZiQaCIyWVo92KIE/wsn8DN01y8DypiGSuX1ckHbs6R+xMOkJIEwJyXfVfkeX
 Qy0N/tmpREAbxQVV2AloKp0xoaWaIOkypzrOLM4e0Xb7Gu79iro81L9tok893I/Bp0IFCvYk/L0
 EoAexKAu3RzqCXAxTil5AqjPuKaSlaY0LsU4o/NoGYYQIe13aEHm3fMB/2YuDkC4ZCpNKyxpAOa
 A6xNlQDAwelxrdFPsXAHnkFQ5tdYwLTapwLo5AX2UQseAYv18ba8fnAXjN4mxcoQJJPCS6y6xxQ
 00Mn6XrdEnk8+VQvTvlsnUVIM0W5AOb5eAsBt3oMO5VlUXsdq5Y2QDunKG51c5mIWxL/VQFMQcT
 kZC8fT2jq54hsecVKlekjVi7X34P0R4wzw2Og==
X-Received: by 2002:a17:90a:d2c6:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-3966d3dafb9mr16370184a91.11.1787754014381; 
 Wed, 26 Aug 2026 07:20:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60bf36sm9592172eec.2.2026.08.26.07.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 07:20:13 -0700 (PDT)
Message-ID: <7532cd0d-6f9d-4278-9216-5d9aea92fa16@roeck-us.net>
Date: Wed, 26 Aug 2026 07:20:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] treewide: fix spelling of "overridden"
To: Linlin Yang <yanglinlin@kylinos.cn>, linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20260826083715.625136-1-yanglinlin@kylinos.cn>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260826083715.625136-1-yanglinlin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/26/26 01:37, Linlin Yang wrote:
> Fix misspelling of "overridden" (missing a 'd') in comments across
> multiple drivers.  The correct spelling "overridden" is already used
> 292 times in the same drivers/ directory.
> 
> All occurrences are in comments only, no functional change.
> 
> Signed-off-by: Linlin Yang <yanglinlin@kylinos.cn>
> ---
>   .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c    | 2 +-
>   .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 2 +-
>   .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
>   drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c               | 2 +-
>   drivers/gpu/drm/msm/registers/gen_header.py                   | 2 +-
>   drivers/gpu/drm/nouveau/nouveau_bios.c                        | 2 +-
>   drivers/hwmon/abituguru.c                                     | 2 +-

I would expect this to be a separate patch to even consider applying it.

Guenter

