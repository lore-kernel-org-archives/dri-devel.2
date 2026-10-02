Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1A1CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE6510F9A1;
	Fri,  2 Oct 2026 19:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VQNl8Fku";
	dkim-atps=neutral
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com
 [74.125.227.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8592A10F9A1
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 19:10:38 +0000 (UTC)
Received: by mail-vs2-f42.google.com with SMTP id
 71dfb90a1353d-5c8319dd4a5so3214919e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 12:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790968237; cv=none;
 d=google.com; s=arc-20260327;
 b=g4PB7noICA9tJZgj/DA2CbJdLFuODEw58x8INrtvqHg/Z6UUiG0B/81wnzM0itGebS
 /idTBqZzfrImKB+hmkIqziN7TnltizUHaFytjVd8iyee8q7sysRNQW4iI8GZ4sUpJ4No
 urNkJA/6rrsC5ScbzQLk9JSb/puXS6UENcbLjtVATZhyloxea/NqoVmpGtx8g05oYlwu
 MwL+sU3ltGhKJJuGrxErrdyGipa1nxM4u8qVEClrQwajJnWhBFBEfd1Lf5JMMjibgjWZ
 g1o1IWrGZvakvRq6sxBcErtJCu3+X7SBqOxhAeV2swD3DZF/fr2kf6LNU3Qemq8rKERl
 GiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1g3omsTMsYA6NLMPlVoAQ+bgFVlwbEDqlJ8MBK/lW3M=;
 fh=pYHdDzPVUp8r1j9UDWLy4pWedde5LAIHtK/STjsKE3g=;
 b=BExYaj749LG6N1LJzvrHu44oOADU4xxPasmuRsV7EijhRxY7yxZIncKuojcb6v1t9D
 8KZFkih5T8N3w7036lSkvg0uJ9L5gacmdfVN/fNp4A60+tIcKhx1s5AICjp/AxBFfaze
 pITIRm40K489i2AYpf8XWnNsb3fsSggYWpI+CvTlirajk52pWvbjcDOMTVqRY/mLmL0j
 6o+gQiHQjZbXMqbfa7tc0vQ8J2D/D5HE7vJJOBy2EwlA/vKR4zuHU0KFvKTNIyuVTyyF
 59OsMCxcR1d8Dh7h53y0jYO0wr2fBhCX+fnKh7dgNcR0ckXg79y4p84D10jZg3TVl1kT
 XXvg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790968237; x=1791573037; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1g3omsTMsYA6NLMPlVoAQ+bgFVlwbEDqlJ8MBK/lW3M=;
 b=VQNl8FkuMKr8slWOAOhQtFiKqXlz0IT803RzsY6TxzjlGd/ufSDUm99lvHx+ryZygF
 mIH5UH7DxOVtiDOXR7jsI4mg/oq+/SyYLu/omM9MwVbrpwwvUnDKshZqxt3d1GDVvJ0i
 BRhwF/dsOB5ZMrmDFOzzmMurO7kXITnNEOAbe7m4/h3s4QDUTMm7cUWclyliEZdAd6Mx
 F8wCD+LRZq92qWi/UysJU5LC4RHHZdKAVSydb+ZhjEFCa91FRR5ghfKpAKvkSOloRwxD
 iRk0/4cdOjHC2evLrHCNJ42Nfph5o7pDmI0km31Z1t3SWrvuWRL8zdqibcgJNIsMg8Fi
 /WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790968237; x=1791573037;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1g3omsTMsYA6NLMPlVoAQ+bgFVlwbEDqlJ8MBK/lW3M=;
 b=0Gxv33j8Fi3qrPbH033o4Vi8sC6sMFvLX9QFYroGEp70OPqeR6TB7p4UUN3lOdHYHM
 4bkp30V7wSYEFOGjaHFNJQAK2FpKvFLJG1mtxLjaaidWiy7vrZ0PANEYr7j/eZ+6hVNK
 LDsDMabScghfzPjAkrmyiIhvZ0LfhDqSLLrkPKnIJhnZognXOhRl8eXy79IoukjBRPD+
 1OtmvHDgQ7OL1TDpyugzy28+acVYzMaNPW40c+K/y5Ovv9xnbQfgY1jZ3zupbiLLntep
 FLU8LsAZnuRk3MbIQRIW2Z5ud8fWD+w1Ns+dPVC39u5zyLc+xxe5bVZpbwMjUD91kmUB
 aiaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLGhMKtKzd1+qnPPDj+gtN2TpK/CTkC9ZAfjf7YKZ65itMAATDAYIQ0GhR2oFpx/+xHca2P3fr/40=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJFd4LpA772Vs6M9MYuq2aDIK0Gz86nUzhmvBOHQwJIUoB+o9jr
 U1sm3LtAQQ+BxM7IiUtbFW/dSEpw90Rd33qc+2+dEiMGdQBxA4uBW/WXSvz9UKDU83Ff8iuWS9Z
 DHQh4OhgP+8U1ewOLvuWPKiCKqPlI/tY=
X-Gm-Gg: AYBFou1cMOzjZsQAs70HHw7kQ8dwBJyml7sSX/rI4WeyTZDNzVyEUDdv10kb0GFcAUB
 MWRJO+kNUYTCPiDXPw9QAnAJgzS039CpoEtkKQ7HP3c7OQHEkvG229TrKX2JR8vVbqazpiJMc1s
 FIzJmM+JjLzsMAts2V0bxs9lNZ5EqdtU+eCHOtA8MO/3i6GvHvvVz6M/T10cVsyQXohFa88/13C
 cEexOI/xCKSgxVhfps1gdmeZ+Qk5d+oGTW+vVXmI2fqybd4ToJrvuJC6t1+cFdG4cCgQe2lO5XJ
 KJfxhR76pKLgVqYAJnvQHorKOGGG65daCAkLHdvLtegHycv78Sz/U19uNJtVgisOcOzo/77qb4a
 HiInVMTw6HlBb7RI1FoQLlH0hdMEQBCeOGQ==
X-Received: by 2002:a05:6102:e0a:b0:7b5:4700:3a58 with SMTP id
 ada2fe7eead31-7c0f54adbebmr792755137.31.1790968237259; Fri, 02 Oct 2026
 12:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260815-null-fixes-v1-2-0df9dda951fb@gmail.com>
 <20261002171818.281885-1-Capitain_Jack@yahoo.com>
In-Reply-To: <20261002171818.281885-1-Capitain_Jack@yahoo.com>
From: jim.cromie@gmail.com
Date: Fri, 2 Oct 2026 13:10:10 -0600
X-Gm-Features: AclHuK8zRY0hMOMSSnnxlFny3tvMylToD5uT6sSAGguetyweFEx6Xv_BTi4bCcs
Message-ID: <CAJfuBxwGvKQrT_CVtvk7xX7pbf8WyE+LS=KAFyc9zSxD=v686Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/nouveau: Fix NULL pointer dereference in
 GET_ZCULL_INFO ioctl
To: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
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

hi Daniel,

thanks for testing this -
I didnt want to screw with my firmware,
but you're clearly prepared to do so.

I just sent rev-3, with another null-ptr fix I need locally.
Im pretty certain the patch you tested is unchanged,
but if you could test rev3 that would be marvelous.

fwiw - mine is a GA107

01:00.0 VGA compatible controller: NVIDIA Corporation GA107M [GeForce
RTX 3050 Ti Mobile] (rev a1) (prog-if 00 [VGA controller])
Subsystem: ASUSTeK Computer Inc. Device 125c
Physical Slot: 0
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupts: pin B disabled, MSI(X) routed to IRQ 101
IOMMU group: 10
Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=3D16M]
Region 1: Memory at fe00000000 (64-bit, prefetchable) [size=3D4G]
Region 3: Memory at ff00000000 (64-bit, prefetchable) [size=3D32M]
Region 5: I/O ports at f000 [size=3D128]
Expansion ROM at fc000000 [disabled] [size=3D512K]
Capabilities: <access denied>
Kernel driver in use: nouveau
Kernel modules: nouveau


On Fri, Oct 2, 2026 at 11:18=E2=80=AFAM Daniel Campos Ramos
<Capitain_Jack@yahoo.com> wrote:
>
> Hi Jim, Lyude,
>
> This one repeats here every time.
> Setup: an RTX 3060 (GA106) passed through to a VM, kernel 7.3-rc1,
> Mesa 26.1.6 (Debian testing), firmware-nvidia-gsp not installed.
> nouveau probes with "gr: firmware unavailable", so nvxx_gr() is NULL.
> As soon as KWin starts, Mesa's NVK asks for the zcull info and the
> kernel oopses:
>
>   BUG: kernel NULL pointer dereference, address: 00000000000000f0
>   RIP: 0010:nouveau_abi16_ioctl_get_zcull_info+0x17/0xa0 [nouveau]
>   Comm: kwin_wayland
>
> kwin_wayland dies with it, so the whole session goes, not only
> acceleration.
>
> With this patch alone the zcull oops is gone, but the next NULL
> dereference follows right away, in GETPARAM with
> NOUVEAU_GETPARAM_GRAPH_UNITS:
>
>   RIP: 0010:nvkm_gr_units+0x9/0x30 [nouveau]
>
> With this patch plus Zhenhao Wan's "drm/nouveau: prevent NULL deref of
> gr in GETPARAM_GRAPH_UNITS", there is no oops: KWin starts and
> composites, and NVK refuses the device cleanly (vkEnumeratePhysicalDevice=
s
> returns VK_ERROR_INITIALIZATION_FAILED).
>
> To reproduce: a Turing or newer card on nouveau without
> firmware-nvidia-gsp, then start any Vulkan or zink client.
> Both fixes are needed for a desktop to survive a missing firmware
> package.
> Whatever helped find it, the bug is real, it repeats, and the check is
> the obvious one.
>
> Disclosure: I did this testing with an AI assistant, Claude Code
> (Claude Opus 5.5). It built the kernels, ran the VM and read the
> traces under my direction; I checked the results on the hardware.
>
> For this patch, tested together with Zhenhao's:
>
> Tested-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
>
> Daniel
