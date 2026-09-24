Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C14C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 17:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3249D10E6D1;
	Thu, 24 Sep 2026 17:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CvedTLqg";
	dkim-atps=neutral
Received: from mail-vs2-f23.google.com (mail-vs2-f23.google.com
 [74.125.227.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7825710E649
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 17:01:29 +0000 (UTC)
Received: by mail-vs2-f23.google.com with SMTP id
 ada2fe7eead31-79de8079842so3613137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790269288; cv=none;
 d=google.com; s=arc-20260327;
 b=BLtk1aMaA6Vq3D+QFH+JA10fM8QWEYVMJYB7L6WGdPuhm+/Ece5WKvii14skb7dmwi
 cd+/K3ZhcVQE5ThwpXxQW89ExYMDFiiHHjS6+xBoq/Hqc0RC1u5BYWstW8xWYRTD6c3j
 TYFvW2TZBdD8uNLONNumTccRqWFnE6pheDyd6xF8P58+4Em4NaQ/c258c275zW22moyx
 YJzda8HONFWQWiRm76oh8Kfh1MCrvt/wWLJZv9GALyabXxKFuL5hj/I9kVFDkQxRKGH8
 BT+bVHHuxT81Y2TeJJRPE9CfP+cHOvXgDNpzScJ3vu+pev6yN5pkUz7ChJejTtsk/Qfk
 cX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D5ljw2mEpVXr9ieEEvEb5LWcwn4WHLTgoxmgT17xzL0=;
 fh=fDQR5khLsjMM4cVPS0DJVBkWIBqahx5RUrcQi7gfFGU=;
 b=VmoBUKkkuSmyBt/tIRI6CmljZlp3yJYia77xhxg3T+w8E9+TviGd8A3CEfVlDbutOo
 tXydTrYQ7XYeo7U/l/qVF7ElVtDBnv/P8aEgwzy/FFG9VTWPIpoAXLgzPWkvyik9fft3
 6M6Bj36/n4A9OgHqaeea3sHsSPm4hsgrEhYxy7juko17QHvfvaqeIapFKC0u8GSUH+0n
 Cvwq63ep6VHJtOlrezL0s0deO3HUppHNnGeYaPPC/Mu8Nf2o9SKNFpwnDL66UT3m5wjm
 2vqVrMo/Gv6B+BJPF/38DKlqSFjMQ+H1wxoZjdUVf/nI29wkAnOkCNFgtZ1LGkIDH/la
 goRw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790269288; x=1790874088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D5ljw2mEpVXr9ieEEvEb5LWcwn4WHLTgoxmgT17xzL0=;
 b=CvedTLqgHgIUYrjcNhQms/UY6104bz4RY6YzuJOSpnU/j71Sr+3rt+oh6I92D+ATJx
 yN108X3FGQDZ5gTARM/QUfYsB4WtQjv/Cdp0mtciBWly/nPAXPiPSmpVZ9fsQkEve+NP
 7dQ4tCZqfJYbh+2cLXOi6qDT8gk76t3aIQ79ktuDcuDHEDZ3ga+uqVXRAbUQea+55rWJ
 lXHgnFD0WT4h7lHtugIZOQR8blzU1dfRPbDu8Iu++x1xL5jUgHQ2sG6pfW+mRJEBhpj7
 zCIXCGhYKrTN1Noqw441skQY2lZTdvvN6giqwloQ4bOxB8l3agfNlSraDRoyfa+Z55oe
 h3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790269288; x=1790874088;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D5ljw2mEpVXr9ieEEvEb5LWcwn4WHLTgoxmgT17xzL0=;
 b=03yx6cHwv/kLkBDIgu71WHInI6cTzWnMdYzBP7uyfbhsTo5/n5QaRaMBukrrmpL9eQ
 gE3eUnIsXP0/ff7Jw/m953r4WBo500inQxizZgMbJmDSD2c3pYHd+X/xxcHJOnKMb543
 pYfjt3JVLNAbq4e6WsuFTU4A+oax9rkvdix4/ica336B+yURFc31kjY/w6A41/GsP9S4
 RuzPip2aTtH0nPJ/Edkn106MgVO4ijnnUBoUqtE6mYZNex2Tcq1eRX1oh1CW/+V9o4XN
 HiKn0uvjlccJ12/rDkzQiXv00EGslWNt/fslaS54J/wyHy/DH3uNwzWb8+EgsYvwSt5b
 roeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAyFrXIv4MGUwctYIFXXKiw3M8Xo142NWy4iz5mbcCH+ZRcI90rxUoaZdIBbslceVbwady26ozhyQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m63+zev2bVeQkMR2QOM3EIJUvZ/9wqjLDmQANB5IDakxFyA+eS
 3d3YCGP2iXTok76/yARhbyqCJxdhuduGqXTCObM1Vq8KHM4nLDwa45ToEQCYCZSDTcwLTs+jvm6
 J4u/9YpBpoKNNuamDoB1jWwq1EavAyeA=
X-Gm-Gg: AYBFou0wi7OlW7ulmdKkso7aIB3VLLKZxsJog1A8B/ApUaNgrRCRauh8xXDEWZ7GLJY
 faHxb89PxBSNYt+/2mkwb9ACvwbhx9+g2hrFzRAnr4K65ZSUkhyUFaK3PIs9nD1b1FsZs/OwYtB
 ZigxqB4D4r9SXUCMf4BKQu7oZd+VK8rZm14jWeQDHIDzxI5pTmeIyrIV8eKmNjRJ8+rZx4ekuy6
 sm7hkhwYp1NsWta1ixsV+lAXybo/aulksGOK1DLm7RSvpQX3mcGWPa7DD6oJKNsskDvfPZ+X1dx
 Cy6/BDY7YhLppsLrxAlSGyQ17nPx7hHtEpdGmT1o6YsI5fe/fXpFOnvEngohDqvLQs+bJRnbtX8
 Q0HkWHv4oBcu3wYulMMrM0kz012zD4J2hwiQL6qYY7ks=
X-Received: by 2002:a05:6102:41a6:b0:7af:8089:2732 with SMTP id
 ada2fe7eead31-7b081f90cc0mr199413137.1.1790269288232; Thu, 24 Sep 2026
 10:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <arPTRF4qS6o1Q3vD@sirena.co.uk>
 <CADnq5_NUH1MBU15Vs287by4P37YV+6F1Q3J1e4Q4KuOvPwK9Fw@mail.gmail.com>
 <arPhsTaiqXPgCqAU@sirena.co.uk>
 <CADnq5_OJ=kP+0=iXbpcjsWbTx8=sNfov0wLSW53qLcFU0fmVVg@mail.gmail.com>
 <4ddbd29e-3524-4f4c-b6d7-1e2e677641b5@sirena.org.uk>
In-Reply-To: <4ddbd29e-3524-4f4c-b6d7-1e2e677641b5@sirena.org.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2026 13:01:15 -0400
X-Gm-Features: AclHuK8HFMIivaONWoB38lW5QaLLooQ-XLkF8rwfu_UiMAlST0T85q6tMsApcAo
Message-ID: <CADnq5_OPPnSs9Bv8LxRp104Cejf3H3JFkBE4XSfiTYgkdmjbHg@mail.gmail.com>
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

On Thu, Sep 24, 2026 at 12:54=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Wed, Sep 23, 2026 at 05:57:24PM -0400, Alex Deucher wrote:
>
> > Your reports are valuable and we always take them seriously even if I
> > don't reply as quickly as I should.  For the issues at hand they
> > should all be fixed with the following patches:
>
> > https://patchwork.freedesktop.org/patch/755725/?series=3D174828&rev=3D1
> > https://patchwork.freedesktop.org/patch/755741/?series=3D174834&rev=3D1
> > https://patchwork.freedesktop.org/patch/755769/?series=3D172614&rev=3D2
>
> > I'll push a new -next branch with those fixes later today.
>
> I'm still seeing at least:
>
> /home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/=
dml/dcn30/display_mode_vba_30.c: In function =E2=80=98UseMinimumDCFCLK=E2=
=80=99:
> /home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/=
dml/dcn30/display_mode_vba_30.c:6666:1: error: the frame size of 2064 bytes=
 is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
>  6666 | }
>       | ^
> /home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/=
dml/dcn31/display_mode_vba_31.c: In function =E2=80=98UseMinimumDCFCLK=E2=
=80=99:
> /home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/=
dml/dcn31/display_mode_vba_31.c:7460:1: error: the frame size of 2128 bytes=
 is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
>  7460 | }
>       | ^
> /home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/=
dml/dcn32/display_mode_vba_util_32.c: In function =E2=80=98dml32_UseMinimum=
DCFCLK=E2=80=99:
> /home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/=
dml/dcn32/display_mode_vba_util_32.c:3278:1: error: the frame size of 2176 =
bytes is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
>  3278 | }
>       | ^
> /home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/=
dml/dcn314/display_mode_vba_314.c: In function =E2=80=98UseMinimumDCFCLK=E2=
=80=99:
> /home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/=
dml/dcn314/display_mode_vba_314.c:7546:1: error: the frame size of 2128 byt=
es is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
>  7546 | }
>       | ^
> cc1: all warnings being treated as errors
> make[7]: *** [/home/broonie/git/next/sfr/next/scripts/Makefile.build:290:=
 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_3=
2.o] Error 1
> make[7]: *** Waiting for unfinished jobs....
> /home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/=
dml2_0/display_mode_core.c: In function =E2=80=98dml_prefetch_check=E2=80=
=99:
> /home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/=
dml2_0/display_mode_core.c:6821:1: error: the frame size of 2160 bytes is l=
arger than 2056 bytes [-Werror=3Dframe-larger-than=3D]
>  6821 | }
>       | ^

Does this patch fix it?
https://patchwork.freedesktop.org/patch/755883/?series=3D174861&rev=3D1

Alex

>
> after merging amdgpu today, note that this is in the -next merge and not
> just the amdgpu tree in isolation.  I am currently holding drm and
> drm-misc at next-20260921, there is a conflict with the old version of
> them though that was just comments but they'll be in the history at the
> point I'm building so possibly whatever git did with the merge is
> causing issues.
>
> Any fixes will also need to propagate into drm and drm-misc.>
> I'm also still carrying a build fix marking the display KUnit tests as
> BROKEN due to the issues with the conflicting changes with drm-misc
> which several people have noticed, for example there's this from Arnd
> last week:
>
>    https://lore.kernel.org/r/20260915201006.3526945-1-arnd@kernel.org
>
> None of the mails I saw about that or the issues resulting from my
> mismerge got any response either.
