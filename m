Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B7AFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9CB10EB1E;
	Tue, 28 Apr 2026 14:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UpNvYXdv";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62BF910EBD1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 14:30:35 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12dc1c0b724so282273c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777386634; cv=none;
 d=google.com; s=arc-20240605;
 b=enHydoIJol541nAvvGPuY5JTLlayuvckZjL1o98D3AyWp4jQB6cuzlNO11Xxk2kd+S
 5mXQD3xW1wV/gfy3WmDxQa3tDjXvfNpHC6yC4TleOWQT92bhEW09tRlkBSsCfcmeluhJ
 tluM2TwIVhDdoTDfixXWN3SXN2N30yb134bCgnAitPwj49D4t2MPi3l9Zl8I5bCvYYyA
 V2+D4HV2rjSVIbUVCzYE/WCBOH4kOoIBL+ej4gyFgASzXiNrB6lTRnZIAmH650Fbh6Yf
 y1gWvyGaWNNwTxqvhPnsLaR3Q2zGhq/6ieh3hHU/p9eFpZ4VX8oq46Q0sOQL4YRdAeOA
 vx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mhJ0rsbgpKdN9xRBdPO4qGQxRdlZh6yNC6k39eXiAj8=;
 fh=CS+gbBuySWrRUIsDHi5fEM+2yy+zrNVX0yexpsLEth0=;
 b=LyTMlsE5TBqASFSPv3w7GD8MRrY2bEdHwjvy/WPaaAMvRO7XBqMxBW++TxVjrONEwb
 MyRaeQHytjjE7+vPPhmrwh2D2njLutSYRfaL8BfFZaaSrp6/FYmW4d0Tx8mgTBIPg9vx
 KCmFNFfHUBhbvyniyXEO0Xpz/+6zzTctxG2zLvsnwqkQ0VYKKq6rgXxS27xCR+iQ/kAp
 BdMK6+MgJp6k//h6zJ2OABJ8Hfi87xiQ2diOLw/VtszgEV21yAdFggJukHFqd7ATSZGl
 2/dZ5BvEHhAxJ/k+zmL1hzutNlF8zbezPSjXKS6ged0lfDdAEMUiWTputAjkz/iPEs7v
 fzmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777386634; x=1777991434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhJ0rsbgpKdN9xRBdPO4qGQxRdlZh6yNC6k39eXiAj8=;
 b=UpNvYXdvZfjItuY07Nk2el91OPGm45eT9gHBmqDTB/T9x/fksGcaA2DIqxL0UEr4jq
 P1Tg7Laiq/aRo3qSXnrgY+8L9IqRp6fl8FfUd85NTFS3vUTDp1tg7CW/fjAX4WHbC77A
 orKlqAQIZ1QW1ENr91s+tq1A6TDEoCrtcNBRj2+c3FtODMebLF4uXMYuTCzqiBVsZlg7
 17Yg309k8c+yt4QyWBbhSRUTxIc7f40X3I7sNTmnq4jJP9BS0YaUW00Jpoz4syazc0HP
 NVODJiGca7YrI4Pc261m9t1/YlK7aAz/kExzlbBdn+OflmwzzzF1crjDY8suMfWI0uLW
 cOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777386634; x=1777991434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mhJ0rsbgpKdN9xRBdPO4qGQxRdlZh6yNC6k39eXiAj8=;
 b=dbos6h8j2gpRlg6b04Wvr2o4ZlIGjlx2dG6mn2MjURkgV6qMC9wfndLfgqDC7GyPig
 h/sIvM2KZRYw6D164XfG2SbKD62nVBNNX3P6XQVdWAFuKKfDfNp0m7RESHUxWi8QEj0K
 Ty8QiIV1GKyHGQQgN8f1oFjg0n9jgJ2gG5qNvB9bHiJr17hptE1UPv2qIxSBfdI6KHmP
 Cs1EcHJr45+CAf4I3dJ906jyjs7Gf31lq3zIq8i7zlMwTz2ywOMnW3XkjvCok9gRRRat
 ok/l7wnEaxFImubRmeFTBuKoXnL2Djmh8uTQ1ktJZ1xJ2wq5/He8pqQXLUOWxqAQlcY9
 QE1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ98F8Ph6CkWLUDwdem5fWh76fi7j82obrQ5zB2QsLIakp/IR2hzq8awxUwtiVcJkN3hj3BMnGD9fWs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywm01f8Zg7o+k1p9vI9Mu9O6jkAKMso+vEJPr508nypQO3sEKBr
 ZMiggXbixZOKRr0Gx86SQE57mTIYawUJcGfLMfRL8Nc/D7YcLKM9C2uhr1aETg6J9zf4mUwc6Va
 e80C96XC+gBqIen5qzt6SBspfTy/INyI=
X-Gm-Gg: AeBDieti2fmzlKV6uPIFsBq3sqq7xPDg4U0u1N+aVBOcwf52ltNu8dEJyjCgGx5MmBJ
 /xceGblQRXzJiJb4ElmImFzoTZOImszekUMp859OcwF5eFiFxcLPw1+HQzJZtRzC+np2lBiNffr
 EKQFSjX/diuDBcM8VHgmrIliy85Brln1gN7TilTQzWM8uWnFy9a4QYX/cs+m3j0Qpe6Hyj5KVWy
 Ek65/ETEkpcdn9GfsHK6bh2HbUyYqDN7MZ3VfMhCPvXNTWqSsiv2juKpBISdxvGS2snTMMjsGER
 +18OhIi87SPnE+vlEWIZOHgFSeDnalsy4rf0K0wYBgLufTVR/PIbFwKGO9KV1TFl7KyMe00VB1/
 q+4UxO1aIxAQ5FIE=
X-Received: by 2002:a05:7022:2383:b0:12b:f616:1a31 with SMTP id
 a92af1059eb24-12ddd54063emr841603c88.6.1777386634082; Tue, 28 Apr 2026
 07:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260428030238.1012922-1-nichen@iscas.ac.cn>
In-Reply-To: <20260428030238.1012922-1-nichen@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Apr 2026 10:30:21 -0400
X-Gm-Features: AVHnY4Jy7n89_YBurjUKgHvfb7bYf2ARJpn_E1kgV-_zmnuaR81OWOt52reW4aA
Message-ID: <CADnq5_M4SO0b6GDfDTOy+hsV4PahyUBRFdXDJ=824DV7=NjPQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate include of
 dce/dmub_hw_lock_mgr.h
To: Chen Ni <nichen@iscas.ac.cn>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
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

Alex

On Mon, Apr 27, 2026 at 11:10=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Remove duplicate inclusion of dce/dmub_hw_lock_mgr.h in dcn42_hwseq.c to
> clean up redundant code.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> index 46f2f9833d9e..3c28a840c17c 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> @@ -35,7 +35,6 @@
>  #include "dc_stream_priv.h"
>  #include "dcn35/dcn35_hwseq.h"
>  #include "dcn42/dcn42_hwseq.h"
> -#include "dce/dmub_hw_lock_mgr.h"
>  #include "dio/dcn10/dcn10_dio.h"
>
>  #define DC_LOGGER \
> --
> 2.25.1
>
