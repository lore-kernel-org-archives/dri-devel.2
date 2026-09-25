Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066E4C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EE9892D3;
	Fri, 25 Sep 2026 19:21:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qtnB3zfg";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B8D10FBF6
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:21:57 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-340d23b6a9eso89172eec.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790364116; cv=none;
 d=google.com; s=arc-20260327;
 b=FtFYgHGlpTPAcpecC7/tJ0/mcntYV30L2ZUS9btydykD7+20mGHo+bHjy0na9QVoz8
 D5t3WVp25xOFB5DSmkmmr99QnbrZsyUJsNyN8Csenxbe4y5vYPixxjvXzUBoNA4ZtaDI
 +hnazcHTh3z7BEQcwwwYqcr41RV/pz/K+Y9GykyXx13Fy19A1YMQZtVtkyCgnarr99gA
 DAWemv0mM868YRlRVgUEznF3vqh7aRQ9k4N1JxxG20efDjU6h/tnvAmsWxi3DkRBH5WG
 HBhCZG2+QuC3JefdHGl/7iextdV2yoO1sc7bBeLdFxwzBAHI3mU3c9N5nD6Fd31iQiXr
 JG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dru4kSgzG1LoMXywHn0mKxjt1DW7+3ANqKAV2u0yg+8=;
 fh=3oT7+G20ZAZJsNAB5L+sazA8EQUagokOw3qz+/N3Vyc=;
 b=m4w9YvE3ImVS320FthwVv3sCvMQK/HMbZTlkPBwHB6qDrcPncjhsiegcCeC619lE/m
 4Eme9gGOaNXoqyTtrRLIp9+fzAnXa9qlYNvMdMptUxQWJGJXEVj6+IaifaMq4tN8NrPN
 R7Evnc2BdpNmL7rcKWad5tyws9VXhJS2Sthj/kU1uzhPXEueOs121lO+0/cgsqvU8ykB
 X6rF9TiV2h2exz2x9YPrXIkMHrd5dUuFH06NHBeA2ZFvVdjak77K8T/WVUdyqmbrA8r0
 oP0VoYuLRBusVInNBE1Z3ooJH/K7voREDmVdiU7kVnANIOM0lToMETGBXDFAicHsFZHZ
 xkkA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790364116; x=1790968916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dru4kSgzG1LoMXywHn0mKxjt1DW7+3ANqKAV2u0yg+8=;
 b=qtnB3zfgRMI0gVjZ/icHZXTSS6SGZLYo7z+E0osfq34KLsgFKVrG6NscAHpnTxtOv+
 CZcBHm6teTUq0i4YVm0lNZysTsTEd9nQ8tg1LgDQUMKfNnyJFwbE2e6xIIBRJhYmFfg/
 EmN4fFMXmXyc0pK7I0tGfxd9aIeB2e2lcIDI2AG7wvBKzzS51jL+zD2cS/fu3ksvLWG2
 UxO8EIESiekHPhfKGepSfA5YeUceBOebQgVC0E0xZnPEnfvjAqtTqf+Coi1Jzmv8DNx3
 hys2O6CcInCSDMb0YWGLtjOOt9xjqw4foyv+DPxY0415/B/plGTkScZBjWo5+Kp8NVT7
 WtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790364116; x=1790968916;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dru4kSgzG1LoMXywHn0mKxjt1DW7+3ANqKAV2u0yg+8=;
 b=EHmyNNEUptzLY645nvCqLhlkx1IupkzLQ3Iwku+nCOPrysMBhNCWyx88/gPzKMQaTJ
 5r0fVkNsUGI97WhxseUWAxJ+SqN1Th+YMSfWOGRfevJlQV33ODIf3DK9mihBiLvCrg6H
 kdYAfMEsuXczvUp1ECpmfYuq2vInz0CpUZ+VC29Q8NgKqHC5jqRKlVabpvLhcaTPqKbb
 weeBGEyBRBoI7mN2gLe/I55y6/7g9RFtzaiwYmCTQl1X9THL7vgcekn8gwCKAvKjakh5
 ZogHL2Lv00ygVNzcTlyaYVOK62f2sWIRE1IYpl7HBbwSU8vj4pDwZ8+WrM7c2qTGChFt
 TQZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwONKwCR8lmxZBQTiFQYkuNrNpUqKJ7K8h+uoqf0SNWOWtt0WCydIeB8pLNwvuJJZBswSGU9p7e0O4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQCrJUMNkdpIwfXyhU+THDZ6yDb1CJgeX16XZvOd/CmBNQHjbZ
 Hw0Dp/18+AAYluXoi1ZyMFIzL/fHSZjZhCjn8bzX0ZBpUq+o7Y74ZxGjb1DV/JUJb1AtuTh/4mF
 IfNknAXYcw0MD3BZtfKwqLOX2bjwz8O67EA==
X-Gm-Gg: AYBFou1eQhYDf0Mgl+ZzngiYW9rhBABF32e2Rz/Um3rVI7TuvU6y/N5+6ZEcboz1NpP
 YQ4vFskUb7Olj+XMMMSEREL4dVxex24JXy1OSlb78abUBv9/b1Q9XcoHCeOAhgVPir0Ke/YPPRx
 eHGA9neA7xQwVbA8lzZGEPQr81xmtqcFOD2mn4yWF/CRn/KPMssJwI0OEAYGJ7stkX5jYF+PNZi
 T2E8lhLCdDnQAqWoc26b+NZXz5vU1tS2c1aYVX+0cVnXNkOIGQdwEGSyn4OaAZ4pgXw2GbyLhS0
 c+ZCAWH5SbwA2wxRxb8VJsebntwWxpuOzSBEcPI1qyHj2opagCWVRfsboLeoeuVz59wHf9vIWDA
 VvIe9x4MPD9HOUjp6TyULfic+jdaxCbh4GUBcR5w0/Q==
X-Received: by 2002:a05:701b:451c:10b0:143:8212:a43 with SMTP id
 a92af1059eb24-146cf7ee027mr1494267c88.1.1790364115701; Fri, 25 Sep 2026
 12:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <arPTRF4qS6o1Q3vD@sirena.co.uk>
 <CADnq5_NUH1MBU15Vs287by4P37YV+6F1Q3J1e4Q4KuOvPwK9Fw@mail.gmail.com>
 <arPhsTaiqXPgCqAU@sirena.co.uk>
 <CADnq5_OJ=kP+0=iXbpcjsWbTx8=sNfov0wLSW53qLcFU0fmVVg@mail.gmail.com>
 <4ddbd29e-3524-4f4c-b6d7-1e2e677641b5@sirena.org.uk>
 <CADnq5_OPPnSs9Bv8LxRp104Cejf3H3JFkBE4XSfiTYgkdmjbHg@mail.gmail.com>
 <2eaa0128-4cda-4f26-b9de-311add98a1fa@sirena.org.uk>
In-Reply-To: <2eaa0128-4cda-4f26-b9de-311add98a1fa@sirena.org.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Sep 2026 15:21:43 -0400
X-Gm-Features: AclHuK8jFToXH3081DCxGG9Esr9QUklLHKbLHdj7sbwsGE6fMm6o6HW2DqiJZHQ
Message-ID: <CADnq5_M0uB6uRvQh3jEZGVEFqmU0wp_w=wmsipXqz=Nq5QZwhg@mail.gmail.com>
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

On Fri, Sep 25, 2026 at 1:03=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Sep 24, 2026 at 01:01:15PM -0400, Alex Deucher wrote:
> > On Thu, Sep 24, 2026 at 12:54=E2=80=AFPM Mark Brown <broonie@kernel.org=
> wrote:
>
> > > I'm still seeing at least:
>
> > Does this patch fix it?
> > https://patchwork.freedesktop.org/patch/755883/?series=3D174861&rev=3D1
>
> It seems everything built fine today, I'll try dropping the workaround
> commits for Monday.  The drm and drm-misc trees are still failing due to
> the original issue.  Thanks for getting things sorted.

Thanks.  I've sent Dave and Simona a PR with the fixes so as soon as
that gets merged into drm-next, this should be resolved.

Alex
