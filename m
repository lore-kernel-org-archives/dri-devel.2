Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCC6FF8877
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B80CF10EF30;
	Wed, 29 Apr 2026 10:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EPf07LE5";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A35910EA24
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:23:24 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-42fbf95cca8so4746704fac.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 00:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777361003; cv=none;
 d=google.com; s=arc-20240605;
 b=Jxr4LpmqDgnQV1MKIlj2oq2fdDENykXGSUMO75UPcKFGg5zxY/bGxoLjIwWUqb+eMo
 aEsF2orzhX8x7tOnI1GQntXz2+lLtyu1gxSptbTC/anwKiCEusYD8mxfEkkbNCe8TTTg
 ZNZyaPFVdsu5Dw9CpsxrZmtauYmtexNUOnZDlU67YcQNur5hUOlfeZlHjzjvCMp9OHS1
 jbZdzDVLsbUrwt0sy9e2gkBEjamfYX+Y/Xt6D92bnLpJPNAM1wwVwijceBvHQVnqxK66
 0p7FHjMwnmIWscRYf8uQxd/ZM1NuL2pp8RgNBp6j1WVwz+tJbXe+SD4Na8Z8rO4aoVvy
 0vnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aJhMIdHzsLA6WrFu6/600XMZirRWTnyQ0tRk6GsQGCI=;
 fh=+nw/EtWkdrsfVEx5HYrgC+xuc6+Rba3zieKARVl6FP4=;
 b=bb4weFhAIb3PVWQ35bqp7XJmGbEUnrpIUXVkZk6Lgn/02UeAlmuh+TZiu7xUzvMj3n
 2ynvxNAaw5HXIYq+Vo2+C+FfEg3hkSvBI6PINfp5Xv1h4uil+Uk4Js5wFCKZgKq6hgS6
 kC6zkTL+tldPEMBciTTIAR2MgJ4dULK1gjtRJYPx9ApVuaOj+0DF4aMmMyBXZ3xL97qj
 mU688cs8s3nL68Q6zfpMnVZd796Pleo48x81KnWo9uk9IjdQwOnQ8asSSldh8z6EBYt1
 LAd9eDG2MTTGYBEa47mLS/T6B1iUJP5YZIN1khW6yi2VscrmbPnNavzzY+tNB2massa5
 XMgw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777361003; x=1777965803; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJhMIdHzsLA6WrFu6/600XMZirRWTnyQ0tRk6GsQGCI=;
 b=EPf07LE5yPxaOfppuT+vTaLXM18aCcxIbzpyXxxuqhhUD8fFm9FKvYCfikPzknfaJt
 VG/Q+TgeBAARPOytgM3LJZkdtpToToE/HK95CnOAGe7Djas9qc7/1HDTN8zgR5HHjq4W
 26lkot7nBKcjlnEcH5ynERn7EjvgPLsUrX/MGYeDTbF/g1CZSpSgzTKUaQo2/C/IkaL8
 i6WhRejtNy4jv6LAKP9T32ys2YcpoOuJokpb/MOqAk9e08G3KB6jTW2diW5Z1rM/fehd
 +hFzy2iz5puqRzY+IHsvVuSpSFNa41QJ4/D2QlvjdWbHpnhu16g6pM+Hd/T/wntk6Tjv
 yFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361003; x=1777965803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aJhMIdHzsLA6WrFu6/600XMZirRWTnyQ0tRk6GsQGCI=;
 b=Kvqlr0biK95Fu7nXRiJJ0ffRBzW/XIlu05qBCzwh/NpEyTZJfiXrP3BLxVlxp0hSpM
 Q/Ns1+sYjVBG1q/IBY9k42ztJTSXxUmXYOYRqC8q6rxq64urlx4aK48ZWkpmUY6o9Z5x
 LuvxrpgGr2LOKVuliwQEKZiAwfla+ESLZN5aEaK5+XHswzxiqsWqWSWnU3sHTUqkJyd4
 OLTf+BT7ZRvzBMe9vg6gdhtSQeBgmWQQPlDXM38zOrWMz1rX4AHvrCYz2qwB+Yzrnqrq
 d3NJMTjDmv6YBJODL1ZzqmvDGxdW8hRlYG3swFnInXGFLIVfz3E77oDXlkrOIHkNAbIA
 JRaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Z/wm2DsNcCB45yyIx0596CQ74zm3z0pJdvHaCmrnnupmkpRIWcg1o43c+SgZDSVLlb6PIcr3cjjY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+Zz/GemTUeoKFhfqKwm0QEHYmKeaclZ5itFC/Jmxtsq8hjLgD
 klix0/YusB/HgASSGmJiGKtTJi6Kr8zwmKoBWbOnYV2nWNU6D6xPIBl97qDDtvagtlbRWaYP9ZX
 st5MUB/3Qgo/3lO2JCU56OabSiD9F7fs=
X-Gm-Gg: AeBDietmMXes7xgaEb/7llADv1zUVZTqrzdDR7T0dhYN5tWaP76YkF9nGLDb9ZiS+1U
 CWpZ2TvKfyHG9UFNe4vwdMrnrxNiJ3eNhRlbOiZMkwAaNs+VoAMouov8zTo+xm0sHx83JXsuv4R
 xZ8pVibY+s/GoUmQY9JBlZB2z5cUARG7JCVwyE1zzCtvhijlQD5dstRleOf72nL3FwjBjXemxte
 seC/kDan3qdO06KBBn4h00uaNz6rDP8+Jb3X2hOfS+gQANzrAJm8aZoJEj87Worbtw0NTQBUGyN
 AsJSYo5ikLgqXJeUTQ==
X-Received: by 2002:a05:6820:168e:b0:696:1862:b107 with SMTP id
 006d021491bc7-6965cba18cemr927516eaf.53.1777361003089; Tue, 28 Apr 2026
 00:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260428063224.3316655-1-syyang@lontium.com>
In-Reply-To: <20260428063224.3316655-1-syyang@lontium.com>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 28 Apr 2026 15:23:09 +0800
X-Gm-Features: AVHnY4If7s9xAoiOwj15GEVLV2YCy53Ike0mnT00sCY4Oer4UXH77zMIh6XW9mM
Message-ID: <CAFQXuNb7++Ft9Cse60NM9oL9aQsojEj_NhVXdJp=J+o3UHFOtw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Lontiun LT7911EXC eDP to MIPI DSI bridge
To: syyang@lontium.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org, Laurent.pinchart@ideasonboard.com, 
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

<syyang@lontium.com> =E4=BA=8E2026=E5=B9=B44=E6=9C=8828=E6=97=A5=E5=91=A8=
=E4=BA=8C 14:32=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Sunyun Yang <syyang@lontium.com>
>
> The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> and output signal/dual port mipi. This series introduces:
>
> - A device tree binding YAML file describing the hardware
> - A new DRM bridge driver implementing the basic functionality
>
> Signed-off-by: Sunyun Yang<syyang@lontium.com>
> ---
> Change in v1:
> - dt-binding:
>  1. reset pins use active low.                        [Dmitry]
> - drm/bridge:
>  1. use atomic_* callbacks.                           [Quentin]
>  2. fix the incorrect formatting and spaces.
>  3. add the required header files.                    [Dmitry]
>  4. remove "enabled" flag.
>  5. remove *fw from the lt7911exc struct.
>  6. .max_register and .range_max use actual range.
>  7. regulator use bulk interface.
>  8. use dev_err_probe, devm_mutex_init and devm_drm_bridge_add.
>  9. Replace GPL with GPL v2.
- Link to init code:
https://lore.kernel.org/lkml/20260420023354.1192642-1-syyang@lontium.com/
> ---
> Sunyun Yang (2):
>   dt-bindings:bridge: Add Lontiun LT7911EXC eDP to MIPI DSI bridge
>   drm:bridge: Add Lontiun LT7911EXC eDP to MIPI DSI bridge
>
>  .../display/bridge/lontium,lt7911exc.yaml     |  89 ++++
>  drivers/gpu/drm/bridge/Kconfig                |  13 +
>  drivers/gpu/drm/bridge/Makefile               |   1 +
>  drivers/gpu/drm/bridge/lontium-lt7911exc.c    | 497 ++++++++++++++++++
>  4 files changed, 600 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lont=
ium,lt7911exc.yaml
>  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
>
> --
> 2.34.1
>
