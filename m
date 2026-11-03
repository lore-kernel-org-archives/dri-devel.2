Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770C606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=usDCqEUF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8009410F608;
	Tue,  3 Nov 2026 14:35:49 +0000 (UTC)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67CE710E4BE
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:35:42 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1680a50e64eso52166c88.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 06:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793716542; cv=none;
 d=google.com; s=arc-20260327;
 b=Ad+VbQx9gCD3JmOwdUvLElVY5b78OvbDCasMRovTfQMgVOrbHlI1PkxbV2ThwC0ChH
 O8+fcjsvy3GyzQdWeB8Z5sXKINs83NblFUEHvq0rbUjcYo4yVu6OqgWDF3QPROwGskUw
 RJ6Us6SehbChi8dJg5qO22iLEhjB1h5so/hinRbaCKm70XoA9UO+kFI8wwIg4cnyPRYu
 A/+2d7lhkLzc/7PA3pXN+9avNrG/vqpcO1PwLvbrf6pTN2gAIdX5ADZjkwV+v3vK4aIK
 Pz4bA8Nx6g6y284US5i2CmeSjAc5XfoZnF4//qGKUAwWN2efiFoZ0vof4lNJowhI5ofd
 65vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XR0Bzo9nCDXtzTFfI+PIJF4f5OVzgMjX1gFs5CwTiGI=;
 fh=GVCYpvA+6VlUbcAAW7PApJ/B6kDuJhRdZY1RDEPRcZE=;
 b=AHNwgwnPy4TvJ6A7cl/CvrHuvQmQhzn+Gb//YkpoDX/jGIJlc45QiE3bgKUnYyWKH2
 vveOvik+3oM0vcGhZNzGcixlvbjpWVQ4qBM4/KXXQgN1EshQwlcJRmf4RRklnawIvHS+
 yVHgyhrgYcxIFaqxxsAPUX4nAGdW/5Io8E6JuJKTxh1EccfxG3OHG5/x0/u+DwXWLwK0
 XEsATgMb1QHhB4a50dV9HCIGO6wwKmz0Sj4Yxj2yOaM2dw01pnlwhjaAUEauAfTu6HsE
 fqYbUp0LKzW0p6mM1r/KxoLjTKKvhNQsxTb2KL5dHhmSDA9wyiqFZLeOKzBJuaOA1VNN
 NjxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793716541; x=1794321341; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XR0Bzo9nCDXtzTFfI+PIJF4f5OVzgMjX1gFs5CwTiGI=;
 b=usDCqEUFWoXzQ6/hwKyMl5x9sYpKumcMZfpxKptr1aizHdkSFDQ8PG5gYCvQyy9q6h
 3KaqdpPlxeTD50ZSWw4PCCriGt+p0i66QM1NNWF8bWvzuSTOrZ8quOpIJDv9hAzv5pX1
 8clg75QZjYIrgWqHe08KpW+gOXNXeckws4JMLJOC3BQA2qe5dX3+tdRFN96KQmmCE8Fg
 7k5IwjhRXW4C6ukRZUmwEegeJg+iMpA3wZ/bkVD5sWd93tTDckdVc/Wkzw7dKYGbhx7H
 qzogHrHa0wlCuMzGWBdQGUoGJG5RsWwt6caqmCBF6QWH8PxM6WEd9IviTE/52PdxuzfK
 MZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716542; x=1794321342;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XR0Bzo9nCDXtzTFfI+PIJF4f5OVzgMjX1gFs5CwTiGI=;
 b=b/2whb3zsONlOLaB8UPqWFqD0RLGCk+ziUuO4ZD3OidiocqP1DM4nyHS6slt23saiu
 Q+sZUTGhN4Fc6K4C5HfqRTn6VsQqiydmscqJMa+nnj/F0Oqg1wYibKOdMWC68FbXfPr9
 ayfyZAWqfpm327eZHYgcAlQsYOVj9SaAeoKVTqpzDK5EGuvYJRvSh2AN+yE96pPXXuBg
 BZ5hpuTz5LzP7z0aoInC/4k/Z/9JTmG5XFJn16ftLz7QUdNW3pe1IyqNErTvuZ5rFcgU
 x0MrhycszuDHzW9CtxN/2bJ0lBjHkiQ413V74VEs9+9fpmZqpxRYoxgbk7pljEFlfUyf
 qO2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs0BlYGL6/+qzb3k9FhNDf00BGNQavfvxOMIj0r48x4Vh9UWhL2CHSHkXzg2XKeXjbn3Nm+jnAf3o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/FiFCnKZtAuyx4nXvTmEmR+tkFSH5tQICKlKbisOoPGkotoTpN
 mKY1j+kkdYvDOvKWmjCFLS2MYkurVMCi4BTn+gIkrxA/cANmUiBoMpfDvbvLydQ2iDKA2bU+wbl
 vzU0L+OwoYN4ENp2ZQA5RgoScIhjhSMQ=
X-Gm-Gg: AYBFou3csVbIyKVpi/CldXoCdtHJbaQQQTkloWM1UbelPnTgqTkSrUisxHTWiPcqXaS
 J5T5nyk6qrT2pYR5Ex+ptvCooPyTIm2gpIIq1Kfi9sw+acB1gnpbfkGSiq0oW+Gz2RxQQGupR/+
 lZ9xD09UceeOABDdzwYcCQVtRATHKte1PnHoAbr33puxLX+qMMjFMdgsLjTPqBl5cHoRNyZXnQF
 SE3FYftVHbKOKrd4y4hFol64igyhSxIJps5SJ4TyNh9jFk45RM4Wuo2xE2wpxd04mso7u5GlpFT
 7tDeurKUWb74yYsFWHw0lE4G2kqV15rI3St8jVlIjaG8+4HSyhJzSc7fqPkZRet+PkNKtxPf/iI
 eaF2O3+VKkXW2i3gXD+bfXafQ9vUfskW3o6/AbZuUuO94SclDb6UfLGgWLr9jFOzmGIVktv2FCh
 inwKKwfojLkvmrJRjr8TZI92o=
X-Received: by 2002:a05:7022:b053:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1ac500d67e6mr32546852c88.0.1793716541521; Tue, 03 Nov 2026
 06:35:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024162109.307247-1-dev@deq.rocks>
 <20261102232450.61301-1-jahs@jahs.net>
In-Reply-To: <20261102232450.61301-1-jahs@jahs.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 09:35:29 -0500
X-Gm-Features: AclHuK8qKEQ3sadc6FgPVgIka6386fD7xEODSenxCq71uFCEpk0SM6ipVCbP90w
Message-ID: <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the
 MacBookPro16, 1
To: James Skillen <jahs@jahs.net>
Cc: Andre Eikmeyer <dev@deq.rocks>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 3:21=E2=80=AFAM James Skillen <jahs@jahs.net> wrote:
>
> On Sat, 24 Oct 2026 18:21:09 +0200, Andre Eikmeyer wrote:
> > The Radeon Pro 5300M and 5500M of the MacBookPro16,1 (Navi 14 boards
> > 1002:7340/106b:0210 and 1002:7340/106b:020f) stop answering SMU message=
s
> > as soon as UCLK switches into its third level.
>
> This is the hang reported in drm/amd issue 6005, which has the
> umc_info analysis and test results from both boards:
>
>   https://gitlab.freedesktop.org/drm/amd/-/work_items/6005
>
> Could v2 carry a Closes: tag for it?
>
> I tested the patch on a MacBookPro16,1 with the Pro 5300M (1002:7340
> rev 0x43, 106b:0210, VBIOS 113-D32207P1-019), on linux-t2 7.2.11 (Arch
> v7.2.11-arch1 plus the t2linux patches) with this patch on top. The
> userspace pp_table upload from the issue was disabled for these boots,
> so the corrected levels came from the patch alone.

Can you try this patch instead:
https://patchwork.freedesktop.org/patch/765668/?series=3D174386&rev=3D2

Alex

>
> All at DPM auto unless noted:
>
>  - both "UCLK level ..." lines at boot and again after every resume,
>    pp_dpm_mclk 95/496/598/736
>  - forced pp_dpm_mclk switches through every level transition, idle
>    and under memtest_vulkan load (57 switches, every 3 s): all landed
>  - UCLK pinned at level 2 (598 MHz): llama.cpp benchmark and 180 s of
>    memtest_vulkan, no errors
>  - 60 min soak of llama.cpp runs with idle gaps, and 30 min of normal
>    desktop use with the soak running
>  - 8 deep suspend/resume cycles (rtcwake, lid, systemctl suspend)
>
> I ran these with the internal panel on the iGPU and again with the
> Radeon driving it (apple-gmux force_igd=3Dn). No "SMU: No response", GPU
> reset, ring timeout or DC errors in any of them. With the stock driver,
> level 2 hung within seconds.
>
> For the runs with the Radeon on the panel I also had
> amdgpu.dcdebugmask=3D0x1. That is for a separate DC issue (the MPC pipe
> split on the 3072x1920 eDP plane makes DRAM clock change unsupported,
> so UCLK stays at the top level). It is not related to this patch and
> I will report it separately.
>
> Tested-by: James Skillen <jahs@jahs.net> # MacBookPro16,1, Pro 5300M (106=
b:0210)
>
> The testing above and this reply were prepared with help from
> claude-opus-5-5; I have checked the results and the text.
>
> Thanks,
> James
