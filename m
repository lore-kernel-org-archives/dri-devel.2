Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F9DC9832C
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9071910E1FA;
	Fri, 25 Sep 2026 19:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S0Zaxd9h";
	dkim-atps=neutral
Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com
 [74.125.229.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14ACB10E1FE
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:57:30 +0000 (UTC)
Received: by mail-dl2-f43.google.com with SMTP id
 a92af1059eb24-14521fc1d76so9318c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790366249; cv=none;
 d=google.com; s=arc-20260327;
 b=MOWmtePzejvKv/W4kFEgexdgHtl4jo8jxFhMWSEdcW7xZYtR37/U8gEBcTnVM3nUIC
 anMZKsmhLYUVU4DR3KqLsLEdd3OYhiXeWkDxObuiAeiGzpkyq7/XF+ix2mU4yzI39R7r
 57+6DjxzHGBUmyD47IYnJsQWkixo3fiQt4qFKG1WTmtc4lqJed3SYXBubjVtNAnvObyj
 1SkTmDIeClhC6XGzRKLTzWKQFeWo8BV00Ixc/TsNdO/1Hhjt725klz03nzCg2Fkj5ORn
 dL3mN5Hb235kJiUJG6EwhXcwLAthTM8emGsAcJpyDsOeqOB2q0PSWz4FIBeBhBU8fMuL
 5uUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=axs1kPa4bc+XIuL0qGjxc7cQcq1kYY+Dg4E5A6x9s3s=;
 fh=HzUb7QQTUQMBw4H2pjPlnkLiTRjCY/DSHvASr9UtJI8=;
 b=QutE3EdNH2nmyrehL00ubnF8l0HWlcM/NySeVY4n2/3rUAnOkmlEhpHW7z/h7kEW5g
 5ClW9j3xeuie9h1RbaaHMsZOHfu6ZOJ918D0TtEnyOTyJ6kAuinO6+dFPl90tLa1Tg/4
 eegKhgtdwLhivc1Cr1TtN7NABZg64wpzE2hkXRg+hWSgyOQm+HGjjXkBbI6QX1wFso+P
 tzkIkB7pRYgOKdCCAGzH/5C8pMlqkLC6knj2uFfkXRzTZFTUNmm5LD1RD8PzGlCh83tJ
 MYx4FE6XBBnxF8vVx5RPOSnvjMzw0pJ8F/eqtvxGhE28nab0HyUzncXzsfdzdf6zT8JK
 lP3A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790366249; x=1790971049; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=axs1kPa4bc+XIuL0qGjxc7cQcq1kYY+Dg4E5A6x9s3s=;
 b=S0Zaxd9hzHyGleBG5WCaixa3XCjz0OvRadY5Dis5K1ny8RJzfPvDXFMH1S1h/mWobU
 TpFOU7avlgXuNsy0isV40VJ37L5ieQszDcAzSiwn9Cardi61+EBh0e2LUTdtae7IMCKE
 mm/UwLoQXXMhsc+l5qeHQYjnJdMHGmDgmjbdZq/ZYsPCgrapV6kCXQd9herR7Co8z18N
 znLI+b8EgFb527RI5e/y8s4wCa7MJHY8qph8lS8r+UBR2K+XwrZTDtCJk6u6yAX+Q6NC
 Hhab+0Z2FgpQAfGGjD2esgkarvbdZbQxBE51QkuCZsvxy8QAen/dA7eCeE8V9CqPsPRF
 EuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790366249; x=1790971049;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=axs1kPa4bc+XIuL0qGjxc7cQcq1kYY+Dg4E5A6x9s3s=;
 b=REm4/yvKuT8ynOVn2ZzEZIkaSXKJa1sbOtA5tkeWbuML8a3VK4njhKZBKekTI+weOh
 /9DJWBLAcDg1jp0GVmjH0COJOsvL7HSOQrPzWDszmokDitaC3LU7G3gaROiv3N3ZHxDm
 ASgR19+V6ojU7knk0wU5E+mL4/peGh6bWm6ubFjmcFdOZsjOoxmZho0BzCgT0JzvX9ne
 4nnLfWmSlU24HqGINGhXtCIiyIwCpPJErwJMRpUkq9o45wFGUrV6wKMoee3EQbGoDBRw
 PGyiMOjEqNA1Slfw0tszNJ2sMEc67RHnf78blfqSlcRXsSc9emqvN8sQSr6WKpbcVNfV
 eOGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKx1qMm5zNqKzj+Pn3O+DrZp9OB+K/ANC3TCn2hUCb9CafR2YHZRMC7zadCE9gm4d3WESGlubo/l0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lV0EzzMb2VUYYxMNFWgUJMizyg1xXXVpByKf4Kq6jFiVFlZ6Na
 Z4rdzkbSHqurJoVCwemGXpcNLMjKXJh7d1N0nBodipy0TGoJYanxP8PWu8gKXy9ldxGWvtyLYWT
 7xxrWAnTKR2nQjkjBZGA8jZi5561yTRg=
X-Gm-Gg: AYBFou03tgfqtcO8mh35cgvdq0AY6kqtE00Ry+adICSj2nb4ITS40EhV4SPJpgRwOQg
 njmR6WC1zfzAu9zz1aMpLaJ182ZFcTfRkyEELxE4wjY+eL9p/ipIcizKs2gQDUWFOfX3lbARDv1
 qZBdb8t8yndoSMtwW3BzB1yP9yY2pLjPW8v64s3ujtPI62p7uv1uMns9KL51LMgxOVJPmQRGj+N
 FNC29Vo4NX/B8JQValjDbBg0BNHqmqW6r+IHlaf2j07axAZQ2U3o/E/+lA2F/JtiUsaJaYtlryH
 zo/ZU4Ak4lSQwINREXYKw5dTMEc3h4lU7gVS86+YdGykRdC9g0snKSbrhOoO9FT0Lh0eWu4MRIF
 eemMAgm9fAibQ0lpOBXtT+YzXaIBwJYpsqj6qOqyrtA==
X-Received: by 2002:a05:7022:3c0f:b0:13e:5a51:148c with SMTP id
 a92af1059eb24-146cb31161fmr1265733c88.0.1790366249147; Fri, 25 Sep 2026
 12:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <arPTRF4qS6o1Q3vD@sirena.co.uk>
 <CADnq5_NUH1MBU15Vs287by4P37YV+6F1Q3J1e4Q4KuOvPwK9Fw@mail.gmail.com>
 <arPhsTaiqXPgCqAU@sirena.co.uk>
 <CADnq5_OJ=kP+0=iXbpcjsWbTx8=sNfov0wLSW53qLcFU0fmVVg@mail.gmail.com>
 <4ddbd29e-3524-4f4c-b6d7-1e2e677641b5@sirena.org.uk>
 <CADnq5_OPPnSs9Bv8LxRp104Cejf3H3JFkBE4XSfiTYgkdmjbHg@mail.gmail.com>
 <2eaa0128-4cda-4f26-b9de-311add98a1fa@sirena.org.uk>
 <CADnq5_M0uB6uRvQh3jEZGVEFqmU0wp_w=wmsipXqz=Nq5QZwhg@mail.gmail.com>
 <47218081-0338-4a3d-bca3-8b0b5a3bda14@sirena.org.uk>
In-Reply-To: <47218081-0338-4a3d-bca3-8b0b5a3bda14@sirena.org.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Sep 2026 15:57:17 -0400
X-Gm-Features: AclHuK-Cq9d27p6uURRwzJuINctgLf65y86LjQs4-Pqe-rCewP5XBlqi-cNgrkE
Message-ID: <CADnq5_MFMriR-b3eX0mTZShPDgUBgwoObgumEjJ9cJqdmDM6xQ@mail.gmail.com>
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

On Fri, Sep 25, 2026 at 3:37=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Sep 25, 2026 at 03:21:43PM -0400, Alex Deucher wrote:
> > On Fri, Sep 25, 2026 at 1:03=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > It seems everything built fine today, I'll try dropping the workaroun=
d
> > > commits for Monday.  The drm and drm-misc trees are still failing due=
 to
> > > the original issue.  Thanks for getting things sorted.
>
> > Thanks.  I've sent Dave and Simona a PR with the fixes so as soon as
> > that gets merged into drm-next, this should be resolved.
>
> Great.  Someone will still need to prod the drm-misc people once the
> merge is taken I guess?

Right.  It will be resolved when drm-next is subsequently merged into
drm-misc-next.

Alex
