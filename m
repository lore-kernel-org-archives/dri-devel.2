Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9231CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 10:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E2210E7C9;
	Sat,  3 Oct 2026 10:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S+5txSUF";
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E30510E7C9
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 10:56:23 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-677bf06de21so258329d50.3
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 03:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791024982; cv=none;
 d=google.com; s=arc-20260327;
 b=lv04kpErwGu+kyQhThtTNs2XXKf4OMqz70zQvPcFJnNXlQwmf+Q4sUByeHufZTTkmt
 gjv8ZgEw+U1HDol3GTkdmyKPhpbki4XG8Ti9K3aKg/dfRvbnmYIwCRaYEnS/cPeEdG4l
 zFGQVK3bdUiVq/dFCTx67BxAmNdq7mLT8zdZniuXWKcwOT9ES/HV2Y89XIBwvDcHC/OB
 ht+0nDEUAYQ3nwWXQI/kHxBsdZs43bMqXOOtSsL5J7kqJ4r3qP2WURUkz206QMWLitoq
 lZ/BaUxuOHuSaBlbzmgrXFHWMfeutioTQjYGlEAhKlyXwUh2T68LJEqo2RxK+mbPQD4g
 vRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zbg8OteiwvS+x/wtCL2LxCsJ9p1/QRFcp9NTsqN57Zo=;
 fh=58PlnUYIWw941wD4kcTxYy7tRLeq3BBGyGpUgPBZFsw=;
 b=s+Ltt8/96GR1JWYq65ylITRCcbSZ9twz473vVTbf4Wz5cS7aHgZmV9/0VZsZQOXpSJ
 A4MugNB8rIEubSw6Yl5MvXfQeAk3JqZtojkgP0JBEKmJX1pYA30VkR4+/lxSNAmE517u
 FdWzLKRkKGy6HC0fz5QqbZ2mQk2dtz+1sV77RTKDBhW2DDJ3PxhCyikj6r7DMysy8LFY
 i4Q6buXUH+bzC+FoDy1Nm0r2XQsY0vVKJZzEkPlseTXbZjp8Z4ZY8aowPPWYHeP5XpgZ
 luTT8VzYmGIo77Hzd5LK4Dp2JuX/2YiZzk6n9n3jx9fZ18bL/2Rf7rAmkBTWYsIhBW9L
 GtXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791024982; x=1791629782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zbg8OteiwvS+x/wtCL2LxCsJ9p1/QRFcp9NTsqN57Zo=;
 b=S+5txSUFX8GAKEUSTHFSx6Zu4DPPMFBaLIZuSyCsotnRwxudGl/c24c7o4aTVAXR0Y
 s9x+Av4YddhvOPZeysuaPRFlSI8wfbk4Y5v4DckRaQQ1Ll6VEiKEraNcoBiUs3uN8YLQ
 Zq7YrUkTiNGa2TaPqxqbPoVdSex2WyT7T09PwLUa5Y8PltfUJPPjQN1wLpp3Xdmd6Npo
 KEpwZz5Cr/KngzfewtXUtRyEV8+MvY/vtIgOzYhz+iNN8mQMen96/XOCV2KWBH0Dk3h3
 bN0Kak6v8Q25BfdHsiVLHzaAqvXUZU0EEw0yoZl/fE7XsOqDaR/3rp1SYkPWzEXfQHT+
 GSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791024982; x=1791629782;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zbg8OteiwvS+x/wtCL2LxCsJ9p1/QRFcp9NTsqN57Zo=;
 b=NXoRG5/nBnclJYsmeeCYHq9j5uMv2Fz8exLleClFYT9gsi8rZZQ+GAnawKXu9ASjtn
 QoWKDSheCaWgZcpXrOjjuuoT2hGnAwIySOYrLLyG7tQdI5Mdz5BmGzrqMeK06MsDdm6E
 iirNG6VNHlUYrbtw4VR7cmmiqLj0yHJOMUXwW7pY/fCTda8s5bV0VX9qti1J8/XPEFfG
 azr41CYW/pkKsrq6SdmvQLkh4J+i5Drz1vutf3A7UuPLbna+tDbJtHtET/F96LyVnzVv
 sN8x+JYzuO+PpICYUwjvfqnfcv5u6dKmsMFCbVIhDRb6+YKYfvAXssxcbdNMAHtwHMY6
 lK6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgIXe4MG6uMumTj6IeTdWTOM4AG1IxOvQbLVbxj/yF5U9d32f1R8p4IGiuANfUGmRbRLzXbi6Rbo0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJbHDfJrlJvbfB4SodfWZdjPIt+wN6xH0r7F80xRYzEtxfY5tqc
 9BOJ/fASNnl5gV1chmepXVCFgtwod0Gz/49pazyhZbqULeNNmVrn3KGm9U6dd+1Vq2iuZpbaPQP
 fjAcAJO8FfXPn4uxXpFQ2MvfhcmSoAsU=
X-Gm-Gg: AYBFou1twK2oz533bPWFJotD7qcGI7OUX2SrjH1p5OUO/kE53nx1tUkVaZfPBlGeag7
 3V0kTNT3sxq2aHkBdLz8wqz/DX5bzVGaCxkFV917aeaWy5eTLa5dcdB8TnDRLI8S9vTeok5Q3A4
 vDKErm4dfE7SIjQvZ1hXreUaPNrhtValQK74OdzRqTn4SLyPVYSf/U7nzcnaROWg8Quiq546eW4
 ptKYM5I6Vz3jT5T4SD0B3tkJ1hmVpFfOPoqwk90Vb2/QBuyYXw2W0415kqazKHsKmEFEeYMan/C
 /asFqQu2rfiPlNIe5jWIaH3JuDnZXopEC358Bz1yOtnx2Nv7AEJZQA==
X-Received: by 2002:a05:690e:4292:20b0:677:bb91:9d59 with SMTP id
 956f58d0204a3-677bd3cf5c7mr500139d50.80.1791024982612; Sat, 03 Oct 2026
 03:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-0-291eadfde23b@imgtec.com>
 <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-2-291eadfde23b@imgtec.com>
In-Reply-To: <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-2-291eadfde23b@imgtec.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sat, 3 Oct 2026 19:56:11 +0900
X-Gm-Features: AclHuK-QrvdqfD516PD01m-QBeGNl95QKCuJiW1zDza5GXZuHIMEOz8rjjkV0VE
Message-ID: <CAKbEznsAZ_7cu1rYauniQAv9eAfZMAvjzNUkB3k=UA0bfa6gkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/imagination: Don't include MMU defines outside of
 MMU code
To: Alexandru Dadu <alexandru.dadu@imgtec.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Reviewed-by: Gyeyoung Baek <gye976@gmail.com>

On Wed, Sep 30, 2026 at 8:43=E2=80=AFPM Alexandru Dadu
<alexandru.dadu@imgtec.com> wrote:
>
> From: Alessio Belle <alessio.belle@imgtec.com>
>
> Usage of Rogue MMU defines is already confined within pvr_mmu.c.
>
> Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
> Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
> ---
>  drivers/gpu/drm/imagination/pvr_vm.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/imagination/pvr_vm.h b/drivers/gpu/drm/imagi=
nation/pvr_vm.h
> index b0528dffa7f1..266d39f5c444 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.h
> +++ b/drivers/gpu/drm/imagination/pvr_vm.h
> @@ -4,8 +4,6 @@
>  #ifndef PVR_VM_H
>  #define PVR_VM_H
>
> -#include "pvr_rogue_mmu_defs.h"
> -
>  #include <uapi/drm/pvr_drm.h>
>
>  #include <linux/types.h>
>
> --
> 2.43.0
>


--=20
Thanks,
Gyeyoung
