Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BA9F531C2
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5AE10E500;
	Mon, 13 Apr 2026 18:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AqOjuwgL";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF0E10E13D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:23:34 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1277863a912so391265c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776104614; cv=none;
 d=google.com; s=arc-20240605;
 b=bhke5BQryCc+Dkvhq6oxRH0QXaSvCeMqUNXh9YOKgJOexN76TW3N2Akg9dEQB3dBdd
 hTZiM6MrunM1K/iUPvd26CAVhNl1UtavjmuJqV7T0uMXYNoOGA8WiQ5PO37AyPDJ8TCG
 PjDHJhLkvBsJw4azAskBjnRtA5zQ7V+bE+O8O6dSJr1o6ZiIDOlcHWD1GmqtlICq5GDh
 uR3lfwm6kRXmMIofBMV0d/O6krSCy2aST6SPF9vv74rkq2vlJTbWdnYB+13rXpYusaMd
 4fXCrjdfaraInI8rcDPPtwnHbMhUl5TD5Hq7VFKkA8y7jnRB0QnVf6/L3qj0sNuOgcpj
 he9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=An4JK7d4T1eGJnlpfGik9vJYn6Y98TDJK/A6PG9VAsg=;
 fh=scGfJyHqs+fKJXhD8Eml+DYa50Av3mCtNWA2WMyOWYQ=;
 b=XD0IpzUOAqm2fhp0N5sKPc53m0Cz1t+tluNW2xepjxfvnEF/3bMR5Bfgs+r2Am2F1u
 jhD+KzS30xKp074CJjvnkizQOzUKpHt0+yCQH6NG5pIb2GhM2G7ueIsrRyx7wdzWyY1Q
 nrgXbK3xvKtfSVNmV/kplXedf4xCKBikP0TxBpQkP6Mq1GaIVxu6vSzpQb40RhH2cYev
 wYE/BJcHdwAMbJmHWLLeozz4mMVEajVkPh8n0AiE8dCBGfiFxW1V/3uCHeFuSz1t8dyZ
 UxN1T8w1KqoCsRS7BCYJ6LG20eq4QF82yPP0GaZXej/I/Qo/gEWpLnM3dtXsUOa+LJlL
 Vyrg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776104614; x=1776709414; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=An4JK7d4T1eGJnlpfGik9vJYn6Y98TDJK/A6PG9VAsg=;
 b=AqOjuwgLkSTr8rOY1uUEbmK7Uls6ih0tqI33cI5bThYkl3JH9+dK+FyyD7mhA5VkxS
 rmC947xUA/eMnO200N/+O5rvvmvYrkDSO6mcwXrHS2rixNEiucXn8ji6hGU1JbsFz8CT
 ZOatGxs7rb9j1tvnPCkqfyenlb6V0HYkf4Wbu3OzdxUYZwTnSUpse9K9qC6WRivwZtbX
 gwdwYzffEKs26fGPBeku8+bfzQP4o2yuds2Y5LM0+v3R/VKiX26DwJb7DDnpIjdnKPbZ
 pz8cjuK6mQ4M5vZMk6eKrIFHTTKckyG5vmh72D3T+ER9Midk6lXGZQPWO4FXg2/85rQd
 pyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776104614; x=1776709414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=An4JK7d4T1eGJnlpfGik9vJYn6Y98TDJK/A6PG9VAsg=;
 b=GZdb97Vi3DC78Yqj6OwQOttZhVhoByMuviC4bwZbN82qW1p6EC/YyUrlpCCves7vZf
 AmIeUuz4nN5xkV8W55S0wpBkjaWp6oWixwpO0z7qlmw/MWXpxDDxXe6ZM+9B3R4kkR4Y
 EoK97FZxHJFd0ZQxYX8xU6FABbODe2+7NAG2oIX/1Dp9c5yM2PyUCm1ZrLWn37vfLZZJ
 0CUVVOXqOtMo1rRSAuoDXytlBndQGIjAFidOzm0m7epU+9f+PO9Exqlw98ea1mc/rUtw
 r741icmHQgakX82/o88SnPLHyXmFXmGW3MpExMNaYmbJ8u49U1mlNQjB4EdgmHnt0Uj/
 ARPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hlkxB93v3T5tY+w4sXPtx5CRaHxZ6QfvJxLSgO3wVWQns+4j19Y9XRdmQZPHLXKvFDNpU89g78ME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy33hSkPw7mrxOCfzO19GgRlt67zf3nSv6YQR25FfKvhr6/PHMI
 aKs5OKigyvUVmqIX+J4i9x084LsrALBiD/wp9SepnKYZG5JwpJNlKLoQkgw5WNmEOmQSMSdNNZV
 eELsRphrgH2HTElVl6+3KSMjh6Qgw3bk=
X-Gm-Gg: AeBDietzXIWhB0YTqpLSz7968vV9h+XNvr8Kwx8tjGGC73wEez1zJvq/5eWWzZFBiQ7
 zkOFv/zWyOQik5WxiEeEsmMPqf06d6vg+qjX2oSUGil0mxyfGhNE/xVc6M40Clm/NpI0A6uM14x
 rW2uC57NpBfBvNRGXlCnS1qMmk26YTi2bxrLxstYZHvhN/sJ/lixsMfIR/ZgUdzsb2KNMe3r/u4
 dJwOcjfN0MMyGD4Avgftl3g2JRQCD1mVl+ctp7KWH07OXC6z+qM1Deop1/F6+PzrNRwawRTLnj5
 7stN1jtf6jZUdSTvndShy6mQc6lMRtPGigssorWCfecEYNz/5jGfBE2erxl/pm/GNUe+5A==
X-Received: by 2002:a05:693c:3109:b0:2c4:76a3:bdfc with SMTP id
 5a478bee46e88-2d5838e93eemr2983048eec.0.1776104613801; Mon, 13 Apr 2026
 11:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260407181407.1052586-2-thorsten.blum@linux.dev>
In-Reply-To: <20260407181407.1052586-2-thorsten.blum@linux.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2026 14:23:22 -0400
X-Gm-Features: AQROBzCf-wMoHRshxqW11QnJtwMo1Vt8jMJXSXXZ-lSPV9mxoaWE_sl-W08jpOM
Message-ID: <CADnq5_NVfEN9QcmuJJfUAw24MvoqsAoHStnTvM7XhrCj=87_GQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: replace nested min calls with min3
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
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

Applied.  Thanks!

On Wed, Apr 8, 2026 at 3:19=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.d=
ev> wrote:
>
> In dce6_available_bandwidth() and dce8_available_bandwidth(), replace
> nested min() calls with min3().
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/gpu/drm/radeon/cik.c | 2 +-
>  drivers/gpu/drm/radeon/si.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> index 51a3e0fc2f56..a13635443833 100644
> --- a/drivers/gpu/drm/radeon/cik.c
> +++ b/drivers/gpu/drm/radeon/cik.c
> @@ -9063,7 +9063,7 @@ static u32 dce8_available_bandwidth(struct dce8_wm_=
params *wm)
>         u32 data_return_bandwidth =3D dce8_data_return_bandwidth(wm);
>         u32 dmif_req_bandwidth =3D dce8_dmif_request_bandwidth(wm);
>
> -       return min(dram_bandwidth, min(data_return_bandwidth, dmif_req_ba=
ndwidth));
> +       return min3(dram_bandwidth, data_return_bandwidth, dmif_req_bandw=
idth);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index 26197aceb001..4681ff28630a 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -2150,7 +2150,7 @@ static u32 dce6_available_bandwidth(struct dce6_wm_=
params *wm)
>         u32 data_return_bandwidth =3D dce6_data_return_bandwidth(wm);
>         u32 dmif_req_bandwidth =3D dce6_dmif_request_bandwidth(wm);
>
> -       return min(dram_bandwidth, min(data_return_bandwidth, dmif_req_ba=
ndwidth));
> +       return min3(dram_bandwidth, data_return_bandwidth, dmif_req_bandw=
idth);
>  }
>
>  static u32 dce6_average_bandwidth(struct dce6_wm_params *wm)
