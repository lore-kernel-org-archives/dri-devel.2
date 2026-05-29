Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ABECD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 19:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19843112452;
	Fri, 29 May 2026 19:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GaXcVkGW";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFAA112452
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 19:23:53 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304d3d3d8f8so154973eec.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780082632; cv=none;
 d=google.com; s=arc-20240605;
 b=J+8H1syrloa+JlomCJt0GQtgbdQdMOPfTE3QO7//kAVLVZJOcutbKGLwouYc2gXdeu
 f/H+g92nYjnMY6X2B2zVhMNbBZ/4XOL5AYKGYWa3qJfBaTTx9MWIfREvejxm7awr07TV
 +kRtorHaxCpA0aOtga/9mhjabGaFPEpXsd0hq9nI5/VjrKzJBewC/tfDvYyyguR7wFhh
 8X0wvD9yqJEDGqBkNJTC6lKaZ3sEj+aZ8t+5rQMPFdHB2i/EIRsmeFP9fxU1U/H3OqSs
 HeD5yylwLy+iV2SUan7rTAm8WHBCVy3z39wpszCjMJytNShF/4CL2lyNDPwAYcHrVIAN
 wuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oxt8Q+W2WsDLa+wW/HdAmzz3vSh3SBOrxOS7ezVfgWc=;
 fh=t6Iv26EIsnOPkUIsFZdcF4iWHmd50As+Cgjf0YslfWg=;
 b=fr/3MA5XHmeA6QGFASEIzSraX/1ORXlsxI6+fGZ6v7DcH/ueHIWzNvU6F/X0sOVoEb
 yYFSORd7aX3U3Rt5JcHhky/egmMFHd5NJsmOz+ewfZQJTFPLx80grXn5ONzj4bcmSqrE
 CCfXtCDI3sSR96Kw1JQiHH6NM1rhywdNJeAXTF79L0BV4+5Myqq0o9vfK1I14t95xy1y
 Rq4xFsvZLU6OLQXsnshApYvy7LmhZKdeDaOVYwn9FcRpvJgInLbMGZUYIWjX3O34QUZ/
 ZSJIGDIhs5uGoPCy9sPbvuZWsvYyP/nbEU9Kw2e3Mk8bC/OWEsdjFitg0DygBKlUOXuw
 n9lg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780082632; x=1780687432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxt8Q+W2WsDLa+wW/HdAmzz3vSh3SBOrxOS7ezVfgWc=;
 b=GaXcVkGWdjegXuHK1E7Wa71vmpw0clhYV2/2pag/rj7k6Mz3wENI38Db1hku161InT
 EXJ1MTMfzsM25W9D1sd901XeFILPRM8opPPcRcznFDRGyZ3ec0VS9qfdmqoUiACvp3n2
 dR6z+KI2hcSqz4GhutYbyE+K8sm+FdcKqX2wu1BJQFfI8KchQoBgI/wiPW59q7LUEo7/
 Lr0gzjcevgOaP1yGabC1shQ9hQTGs0F+cKrB87SGGyKLSYf7geYPfexhxiQM6ZSN9ZY+
 dkgD6CeV2+X8+JjoOx5Dz3iD8MNQBfDb7iQOnUKnpspMLAzPpMU8ntr7PYWYUehfaOoL
 rIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780082632; x=1780687432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oxt8Q+W2WsDLa+wW/HdAmzz3vSh3SBOrxOS7ezVfgWc=;
 b=ppifHQVzy3Bhb1T9kkmP0xdnPiXJAyxS9SXISPZ+s1MeufY62oqfk3PIcCO9n1o4FN
 pe6UM8ydpwNJgOd9Z8XZmgy9nibVRpie0Ybg6OQtcZHqe42Zb+yU+WCu8er9GmqcCeLa
 8d1Lm2Le6i7se3PvB6/01/SWOiDIoya+C2o5rfp4yrZrijS9482EXKmQ1Jr10h8gmI0A
 MClpbsOMadvOKa6Dzu5XHJVoFLWaOEn4ecvXVzs5t85ulEfYja2+rq6IWA4AMp178/wb
 66T6wodfNdDf7pMZTtHAQ4rj9T43/4RPOl1iv0tJ5X6g8BrAbUdI+GBp4IBz3vtTkBh8
 iOSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Uc+YytvHJ1SAjZVX2F1ZWmUc/sWIWzsj8NPgEJfPrA+5NL8JNVXE73SDrn7/Uwp3BiEj9fZnuMiY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxH6lVp/VIxQAL6HUKhKOV1FYL5vZnRDZeEv0R8+0Rywm56VESj
 4Kkm44VMGBUaMgBn+84amk/taTR7YNTs40cUi/3sKVrjf3QhLZNuZmcekVMET8bscFDLSYb0dSQ
 82slvgXxo2b4dwuMsgCwtiXYcNGYhGcc=
X-Gm-Gg: Acq92OGrsHzwBc4XujgHJ58CnAGrEbMkG1JuD2gCggtofvZakmzsxMtJo1f4qS3oYwk
 cnFEWqcJFP4f8Blc/KIWRnz5vwxmk2jHZkCRaJEPJi6em8tqRGI5L74lBOqWn33wbgD5r0a6+Dz
 ovkO8CEezSdY0e/ud2leKFZzL6VcSgl4+f37UamYKJMPL0dx9cjZIepeam+O1ejjRH38tv6YIyf
 V3zT2kioEFb/KRIHYzzI96URRRALo/r1CLx+u5eiUAyYgb8bBA3TJWG12ttaNVATR7o4LNSl0Kf
 oRajsDWr0mjYybid6vYY4R0OrK5Sk6OMo1Y9Jhx4fGuo090Uk7/Fzx1DV7wWODfmczxt35u0Qyj
 ZmRQ1jmmbW/6TnV4zGfP7fglk5VcE5RWAHQ==
X-Received: by 2002:a05:7300:fd02:b0:304:c73b:79ea with SMTP id
 5a478bee46e88-304fa65935fmr269421eec.3.1780082632355; Fri, 29 May 2026
 12:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260528194646.819809818@linuxfoundation.org>
 <20260529054139.120182-1-ojeda@kernel.org>
 <20260529185046.rc-reply-001@kernel.org>
In-Reply-To: <20260529185046.rc-reply-001@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 May 2026 21:23:39 +0200
X-Gm-Features: AVHnY4JA7t_ZnbW45aaa6F6ZMDmDXu8KTbZJaiGNMmTmWANvKuJkOpXJv3srhGY
Message-ID: <CANiq72k=M7bvd0ne8thLQFOOYACM5dRoDdNkTbeyTXaeL7qndw@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org, 
 broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
 hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
 linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
 patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
 sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
 torvalds@linux-foundation.org, Miguel Ojeda <ojeda@kernel.org>, 
 Daniel J Blueman <daniel@quora.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 Nathan Chancellor <nathan@kernel.org>
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

On Fri, May 29, 2026 at 9:17=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Thanks Miguel!

You're welcome, happy it helped! :)

> Right. Rather than dropping the deadlock fix, I'm queuing the upstream
> follow-up 53676e4d44d6 ("drm/msm: Restore second parameter name in purge(=
) and
> evict()" for both 7.0 and 6.18.

Sounds good, thanks.

Cheers,
Miguel
