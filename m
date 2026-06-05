Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A334CD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB0D11A5A3;
	Fri,  5 Jun 2026 08:17:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="gcsDIrLk";
	dkim-atps=neutral
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C28F11A5A3
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:17:54 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3967726bc47so15475951fa.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 01:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647472; cv=none;
 d=google.com; s=arc-20240605;
 b=f6FXuH6qp54/RMrlzP9z7GJBEBcKjaz0wp9lDKXD5InPmVCg7VSipggFTYFnVfaH84
 oquF+fBoLzO5YvmxiuxccWMHLr1ufvDyupwdQfoqTKfGpLt8J0tNHBnC89+FBEuWcS6z
 UgGR4hHDAJqASUUDYk+1BaJZXBcFp2TG1UEwBdQtPthWaVBWDpQr341rt+TlZJjM5jNc
 xTXEdR7zCtIxJRXpc53a0A+eOOc6FBCrnQmmyBXxnRDyB2/aAwRu2ArEehwkApuFLxmU
 V0tqhewed9upqvozMznZx0U1cQb5oFhdZhp3VX24QysfQfKGlUClX1ObZ2Ejh44SUYTc
 MeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GshNk6hqdERsSbaB2Z1CfprWH4emt6q325uGqdHRGJc=;
 fh=M3x34e1hiGLfflaiteRtEVqJ0EwUWbycfm/qbUZiEHY=;
 b=Nn5OYhRo29CaebQ6ZTEHqEYN3YG/4S61RV2MJTWaTP3R5kwX/XwDRY6SFSWbrRs1P8
 SkOlM7IPEUIhqPb7YPVTndb+8Asqxh3YCBhQBViMkxW3BjZFz6eNZoGPqn2cnQLexS/G
 +sF1k7beyGcsOrD+t42n3nUjHbPJNUuyfZ3T3kn/wSBn7gHiGhLoApAwpychIbl4GUzK
 jROtrgH43vMTGyth/m6k7/tPhWo/T3kQJ4hHX9gp+WmgB4PXC0adI64eG0MajE8WbYiG
 S3b3STsRfgn4kaHe6VBiEeC+2jmc1lM4d+jZpswSd+YNNtXDcObUTW1UE54ivp5vNFtu
 VLZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780647472; x=1781252272; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GshNk6hqdERsSbaB2Z1CfprWH4emt6q325uGqdHRGJc=;
 b=gcsDIrLkVcchjZLQZN3uO5YohWStLcW24FG/hWcOJgMeIohkyNdz57gWE4GdeXjQTG
 IOjclHgYDUr/RHlHe1JWbNVJ5nOlSw/BJJPzmo/kBNo6SWw6md6pmGsBXIqsWoPd262R
 GlhItSmcYDTIU9DtHcW1lR+9YkVMtiBDPXwyQQl1fPQaFF4L9mbZ9o7mV7yyczhKrUNR
 fomB69JqoNrpk/+DWbjb8frgmz2lYVsZ5ipdGggvP/Ksvg/VGQj4DH5Pz/79eUcMz+Ea
 essKGFwTb93iwad55p7C4ClJNPYud+Lzy1dFTNe2G+NBYq21lQBwpzCMN7RzVL2QANEk
 QjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780647472; x=1781252272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GshNk6hqdERsSbaB2Z1CfprWH4emt6q325uGqdHRGJc=;
 b=m+6rvKkIje2Rpn/dFna9E4YH2EQ1RKcsRRLxvGsapcyIIDzgdHd9KbJRd7ha/N/Wk1
 WQ3ehBy8YiPDBo40Wc+jUXlmKzd0rh8sy3QUSLdtS8gBHd0bQuoE2+8Vndpk4OkGRnlX
 9CbS9JpwcMTwwrJ2Z3tfmt+1WQtWooyZczv4Vm+UoZgyTu2DRWX4tOvH5/tDOUuSbCnq
 3uBBaAJKFhyOkELFZ68aCaUy1urhbSZ/awkV4xbv96SAZO9FC2PkftS2CJKAV1f4r2im
 P7C9aeABUmyj+vpzZCz2KpIIEJ2BTQPgAsW46vATWsaZKNwneIKp9jDrSGKw5ujz0wC2
 1YxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DXL6NNGxvMaWAiI0qax3DYN7ryyZBSlFfpH/BxxD1AFHiPPGmvEXxOY4Pu0QKyy1Driuf6LOhlSk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxk4WiFDbDguNRsssIBr6ArWyNU34dXWUokKdEDPTP0SglWbNSE
 +kSg1WcIPvxCdR73UCndBhySxIg5160zxiB6P8xf/MwdJRDTh+jvDhTN0NxCEl0llSQOorpVwOl
 +hUdkqi9YyqjTwzg4CursvfCrpddV82HGW0ME8WYOUg==
X-Gm-Gg: Acq92OFoSCl5v8wgaFqz6ZEB3X997jI43ZXQDTIX1XO/m8GxTP9fjDFBK+tazoYvShO
 YtU7TMtKutM38DT8+9TIQzlv0N/CEsvvkuyvOCvzbGxn+xD0fYV0aUQS/GMK7w5E+g+WdRQRq8m
 vwVqqA7Q8ECCdVbUCDVoQ5rLdpP0fmeghml8gjn7rDagLs9iRT0qi44oUf/cxwlNCLGxy2OJDgx
 J8CivV4VhNNP0LE1SCgRP2LdjmFqPhRf9qdu2mbFYpFXMg503Ql4OZq1hCR5s+eH4mDal2OoF98
 XHRAJmg9goQJUFmKZ75SoGGZrksOhhyHWTPjMcP1dOcLl7GvFP+IAHKDv6itDQ==
X-Received: by 2002:a05:6512:3092:b0:5aa:6a12:7d58 with SMTP id
 2adb3069b0e04-5aa87bc8f89mr1091140e87.30.1780647472453; Fri, 05 Jun 2026
 01:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260430091532.115846-1-marco.crivellari@suse.com>
In-Reply-To: <20260430091532.115846-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Jun 2026 10:17:41 +0200
X-Gm-Features: AVHnY4IuhXbRWmgW3qvThGM_fJ6-oZeENjOwDFVRnx3TBfPIYCa8aiSdzM1g0O8
Message-ID: <CAAofZF5dMD1Y5+eswi0u6xmTHaMZEcGVTtXe7Ps4vFiCxJFKCw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/gm12u320: Replace system_long_wq with
 system_dfl_long_wq
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Hans de Goede <hansg@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
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

On Thu, Apr 30, 2026 at 11:15=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>  drivers/gpu/drm/tiny/gm12u320.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

SUSE Labs
