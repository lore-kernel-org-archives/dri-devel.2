Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7FFC9830D
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC7210F002;
	Wed, 23 Sep 2026 13:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ze9qvFjP";
	dkim-atps=neutral
Received: from mail-dl2-f37.google.com (mail-dl2-f37.google.com
 [74.125.229.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D96810F058
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:45:51 +0000 (UTC)
Received: by mail-dl2-f37.google.com with SMTP id
 a92af1059eb24-14373bcbfe5so23215c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 06:45:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790171150; cv=none;
 d=google.com; s=arc-20260327;
 b=TGlSwIy9148PWzYKKAOhiZ0vp4y2t0mL9Dkv96ahoyObr3gzgVYG4X2air48rSPVbU
 SKxhu07yU6k2ERNGgsWw/d83NXxQqBCJ5xBRlQy7IIMKNsDPKNcJtdT0gg9I2hk0xrWA
 mRw64SEwtQ8OOa2D7/l9HmTgadG5jHQM3Egfx9nFDCFIL1lnFLDtCaxkFKv+9HQ8ZpYR
 SVdmTMHdOrLDn3J+z0/RJd9IXiv3rg+1+fZq14TZn9+fZ+PIVz0OzOHP+MRl1W0cW9Qt
 IWu+ZrXz7RzUnpbMuWm+I/5gl0yARbsKsFHPehbm1GNeq6fd8zPl2jiWPEAi8lD8pXJE
 QWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HctvDPTtuOL5MhTLFfz6tCI4gTGEFCKNG8C5WWR9dmo=;
 fh=X6NdC1IJ7vAyFXOdETPBewHJfOq79O0lgU4oQ3dNw18=;
 b=TXB6Oi7CYc0jxHn1Ixd0njVg5300zkSyl3cjs5ACdko6+GViCGT9Jt7WtXU+2KzeWN
 UKDtxncDRWqpnHBvFNptnZt0V+5prtyGJ8hKDCruAdI3LuIB78ovwcakw3XAtGHgIhlI
 uKMkudqUFLx2Y8ek2LHl0Ri0JjpN5pmAvvmyHLPdsP3Asqiyv5fonMgv4RvOxyNRHFR0
 FtYuoo6kloYHDtTr6BUpuAWo0af5faLvKdU8zoTteEvvagTnh9zEVWTU/UHUiD4rkeXH
 pRRZmjCFPkQehUgm99sc5urw15hNnR6m1DxRKDHYUOnJXXCKIN/Vt0OaRpD8x/yiBtLT
 XDEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790171150; x=1790775950; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HctvDPTtuOL5MhTLFfz6tCI4gTGEFCKNG8C5WWR9dmo=;
 b=Ze9qvFjPX8AFrmjTqT5lVF6NPpPq/sl5Kx0ZvG8JZeLHEvWA7UVgE1RZ9qVfNkCVN3
 TWk/lRcd34d+ldRxwQON1nO2hmVcuBl7hWXSGks/pepDNXihhltta6CwEt0mF6oqnmX1
 qRp5/3kISq8Z5+igKxWfmpyLXHCrDar5NLCaJpePNFL4vS0WOWoaicfW7Idzln/p63Lh
 gftKMRfumhsX+byd7n0aj+5TkFnqSYo3HCVuNqXb2IxQB5W/5+ULBt0ulK1E7MIqhS5V
 eGQ0g/AAwE4VZxdHND+Wf4h7Ru9dEd4tEMleInyC6SlKrls3+YoyQdLKCrNJZN21XmqU
 3YIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790171150; x=1790775950;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HctvDPTtuOL5MhTLFfz6tCI4gTGEFCKNG8C5WWR9dmo=;
 b=zuQJ+H/RX59M3c/Ry0DrCGay8zOivjI516MOBJu4WDzYWELUqPPCs7GZJEn0AivNY9
 t86lual7XiTr2dyNDL3OuDC4Cv4Y3gcu5OGWlmpjp0QEWPvbiUENzOL77pdPlm1NGq3P
 E+Sd+Fiq59SnjDzeSApeHpPoZMSnrqcHGRt15GXAOiHRi+ObJEzAgE1ZM9wIY7FlDTSh
 ps5H50bjkoUoJH6MADjSD0H6kWusubhBTheiCN0gGrzngL7J/KPs7rtE58UPQO9Gim7Z
 WenQKLc6D/aj7YekjgMuXkibS7jASUV0Git+xDsNCFTmUBfQ11jFfqRE08+JQus7UWEr
 dszQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIWifLwdNyJiVhGnldsVYzMmHXHHSPa0qCjTghgH2bYKtxO8U5oG8Dtd/gIhGcyzyfjdVcB/g05XE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ktrCzXRC95v+yzBrze26M6xuCkjIY6uOCdVDmopXoYwa/fo5TD
 TFdjdV6IdoDyhW2eVN9DV3lpBRVGvVuAKQPnIrvT1MMJ2mamw9oVoI+PzW+pv3WQqztJ9bGMG2v
 E3J4AvFQQCu7n0CEUTRcalCelb/+npSE=
X-Gm-Gg: AYBFou0oFm6bCpdXqOi2GN8BzjBIwpJemjZzXc0JhUlahdZjnBZ22pPxm//Suwhr2ks
 P0OAOzLzrIw/KKOq2avZ4YVmYobrzdzgCyBqnpfPyunVXIYmLAGVdyaRIKf6yzoBqHTiH2+yu++
 DmTed5CKJsjd3krreYRuvPHeTLBSCHkYaJ/5KV3RIsPEtChTub5No8LyCxlk3uxzlShe7vzrxtn
 7ve7d7zWznTrLMgk34V+9dVV4ddPxF65I22A94wVlsXxlYxVw4JwFgPbmNahe9Jp8Up7/fyCi6W
 hPQ7rPETF40KP1VOSfocCDiWKkr9AkyE+LBegP9iRSd6gZ/lefx9PBb32SGpvH8G0aC2yuXMlF0
 cuv/4AU4IJ4omJ7SmHglS5BPKS3aF4poyuK4wKWphLg==
X-Received: by 2002:a05:701b:4517:10b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-144f8fcc55emr4442748c88.0.1790171150250; Wed, 23 Sep 2026
 06:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <arPTRF4qS6o1Q3vD@sirena.co.uk>
In-Reply-To: <arPTRF4qS6o1Q3vD@sirena.co.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Sep 2026 09:45:38 -0400
X-Gm-Features: AcwNN1VvuVKZ728jo-o9478RCdxxAm4oEfsFVGIbnAnLjFz4EvjQl-J3APv6aG0
Message-ID: <CADnq5_NUH1MBU15Vs287by4P37YV+6F1Q3J1e4Q4KuOvPwK9Fw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>, 
 DRI <dri-devel@lists.freedesktop.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Wed, Sep 23, 2026 at 9:25=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> /tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_memory_pool.c=
:87:37: error: stack frame size (8264) exceeds limit (2048) in 'dc_memory_p=
ool_create' [-Werror,-Wframe-larger-than]
>    87 | __must_check struct dc_memory_pool *dc_memory_pool_create(size_t =
size,
>       |
>
> which I am exceptionally frustrated to see was caused by commit
>
>   bc3f07516a992 (Merge drm/drm-next into drm-misc-next)
>
> which merged the bug I originally reported in the amdgpu tree:
>
>   https://lore.kernel.org/r/aq0vYhZXtMqA41wZ@sirena.org.uk
>
> and then in the drm tree when that was sent upstream without the report
> having been addressed in any way:
>
>   https://lore.kernel.org/r/arJoCiRM1hRbgRb5@sirena.co.uk
>
> neither of which have had any response at all.  It really seems like
> there is some room for improvement in your processes here, currently
> that's three drm trees all held out of -next with the same fairly simple
> build issue.  Can I suggest at least check to see if the code you are
> trying to merge is in -next, the drm merge was done after amdgpu had
> been held out of -next for several days.

I sent the PR out on Thursday and you reported the issue on Friday,
then the weekend happened.  It was investigated and fixed, however
Dave reported a different stack frame warning yesterday so we are
trying to make sure that is resolved as well.  In addition we've been
trying to figure out why our clang builds did not catch it in the
first place.  All the patches should be available momentarily.

Alex
