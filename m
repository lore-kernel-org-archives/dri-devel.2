Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D875CD8CAE
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B3C10E120;
	Tue,  9 Jun 2026 07:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NgX6DbxS";
	dkim-atps=neutral
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D53B10F9A4
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:14:20 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id
 d75a77b69052e-5176096116fso52562701cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 13:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780949660; cv=none;
 d=google.com; s=arc-20240605;
 b=LiFjJf8hee4g4SVFW1AKsXOHtGLF9Uz4orYz9CJvKxM2BlOIhkJDtphPKItm9DFmVW
 aWLQ48RSl3gM9JIXhAOxCo8rRO4RiXznTkitrZW5y+lMSLJUM3FIT99o62MkpTT9sTpm
 MpachBrWCGcq9HZUGx+QnIj2yAp/YNltCWibq45GMraql+U82NokmSSz8QZZONk98mX/
 /3uqQExV3DHQ1+f4atDuaigvVqVpk/bGCLhujbNmdWVUaoSclI/8zPK6yamdVQSJJPTc
 z1WhrDJFInrhOLpNaBcyhQUutYAN9C0MLpyZgxNkq54cXHQeeMrEPxAvCO0a3nXuSWZ2
 ZH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/dA7nHtKDKNJB1xvn6tpMv3RRTNJP3ds6phR1G5KtzM=;
 fh=HUWqhNgRtCPdUbzuail76TH4E1iOXCyNDT01QYuPRoU=;
 b=Zihmautv425zh/0Wk1634yGSJvGtrOgEGHkgtk1Zb46lFnVNCZchyJGiBT1LdKYbX+
 /nm57KC7H0oEqYcWWdDBV4sW397c+vVsruB5SjCVWdkh+ZLl5ZfTQqdeaYUwvlsubt18
 ao8xjRtU5QaQb9mAOQIlkrOeygmlxJgJsZpZQmT261NPpRlmdWpQOnLFu4vqlaPhN9w4
 +Md9FWeiSSirYv+6yoUIP2KADJ4cfUbUWE7gXza74fS/fvBNf4fP9AYgw7UL4YEJtHI7
 wZ5cPOvhZItNh9TGB4XIsM6BHxwGL55ilsv5BDzx2DTyOHj9feVvZxJXDqZPwQOesUbb
 lung==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780949660; x=1781554460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dA7nHtKDKNJB1xvn6tpMv3RRTNJP3ds6phR1G5KtzM=;
 b=NgX6DbxS+jH9t/v4QirhuwNgv2prjxKLKrTry/Ocgg0oeLg0QpGPzvSwfTa/NXhr0A
 JfXeKX7/YYmL+Ab7hVee8KqJFAEys2LVH0CH1TNteE9QUlMFwWYOnnpoY+EUMOEOj4EO
 K7tCLg/lhY2L/XZnnlBynQ7JYcBjs+QbQHZetw7FJlccgc4Gj4oLJGv7WKBJO9QJXLsf
 MuwVE2Msd+1e3jowzxQxMchqVniQtMTGHuU+flWRsfFl5Ki9dFCOQCW5Gl3gRtm6U0Vr
 NPhIFBGYMSbnqNsiO5JdlWJq505bkwx20pWXRJ1NmWLGmJXOcGpDJl9BODJGH95u5XVV
 YFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780949660; x=1781554460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/dA7nHtKDKNJB1xvn6tpMv3RRTNJP3ds6phR1G5KtzM=;
 b=SuUoJcNmaQc8JsnuRxpdb6luqMHYSZGhekSbN7x7owfch7X7pEinxKLy3/zXTSYvXp
 o+qWNSwgWgbUZYRV7ZkjRwm4hNT3BkOiTidW0yYTcUuy8pxxX/ZRIf2ZY4Llh0HZBaM9
 Bvgso0LOZ7hbaB1IbuMsJCkXDCIZKgGeUcDyvUZ0dg24pE8fX7pZ7HxobZIGvMurvnLW
 8tMkmgveorHyJaKuFyX+FHcATd/0hOVHXqjIY7H8pKVv0r1f54wKKjWRcxS1R7tazGjp
 KreN3p4SrIjiJ+ykr8HvTWd2Tqxwho8G5MIdnGqFp6rFu0EyOEogsI8fLvg2BhHI2mEE
 uxSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ998+LEh+UAoeTPksW00TzvvZNqht1J/rNv1smAQwGITcli8fygPp1Z7CcCrgzV3Xe05m19c4luoCg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzpn2gl7P2Ql2MtaFgPLgyOxjoap84tztb+H6TYWKfksf+lQLP5
 y1QEy0ab0nwfubp1pw0eGPn6D6HEWQvNe46sgtO0nlx/i7dyTY0LX9es1dG0/fATeKc6ZtfroOc
 RznUY66fM0YOu2DSXnA6yfDQ75vi56kg=
X-Gm-Gg: Acq92OGtpHQu5FDbaUCgYVJLC9Hrb/OHVCjwCCXRh5MyQt+EIXo4Uo4RQx510ZyFCyS
 SDWPG7ushK3f+JIeEZc7NT9V3eUu5uuUVjR+wNukJzDaDSgAhvoHj3X6TPIdFpaCfRmu3/mWNka
 LgBDGTlTLYG55fNe7y6Ft0EjkPeuqppyIi3/jUrwmxeNsewtNnOaC9aggbM/oswGh1luYBUJNia
 ZpymT4pd/+dk4UnXqPC9GyTCo7xw0UwCai+SSrRNlh45LB5DAOTM2z0VDn6vIhuFpmN8OnTJ6Bu
 rmt6QHmZ+gXUTcBRWuCh0yNa/nDCa8TrJudUDPbErPAt5/oJ8VpPLwRT3o+I7YYvZrsa12LFGHz
 2xD7palwioX2KAs6ZSl8vvJtZQvF/68MPMgrMJUTS9XD4P1I/
X-Received: by 2002:a05:622a:4c0a:b0:516:e0bc:f485 with SMTP id
 d75a77b69052e-51795bccd78mr250053541cf.30.1780949659407; Mon, 08 Jun 2026
 13:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260607210203.229613-1-deller@gmx.de>
 <b80a379d-87e4-45c4-a078-09e84a840895@suse.de>
 <1492766a-c349-4cca-932e-bf608b922b6b@gmx.de>
In-Reply-To: <1492766a-c349-4cca-932e-bf608b922b6b@gmx.de>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 8 Jun 2026 13:14:08 -0700
X-Gm-Features: AVVi8CfEV3v0auRJTkRcEi93MvfSHRgJyvHshN0YpjCioQG4b_F1xB7AGV74yp8
Message-ID: <CADkSEUg948W-XT3_ODe_6p4i5Y8AKEcP=rmJ+7qJq30Uq0d_EQ@mail.gmail.com>
Subject: Re: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 09 Jun 2026 07:16:14 +0000
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

Hi, Helge and Thomas,

On Mon, Jun 8, 2026 at 12:58=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
>
> On 6/8/26 13:25, Thomas Zimmermann wrote:
> > Why is there a 64-bit division at all?
>
> Not sure. Might be platform specific.
> Maybe, because you add two integers and divide by an integer, that the
> compiler then chooses to use 64-bit integer division by 32-bit integer.

Actually, I think the real issue is that
arch/arm/boot/compressed/Makefile defines "static" to nothing when
compiling its copy of lib/fonts/font_acorn_8x8.c (via font.c), so that
the font array is available outside of the object file. I assume that
this causes various unused static inline functions in the headers it
includes (such as <linux/math.h>) to be included in the object file
because they become normal inline functions.

Ethan
