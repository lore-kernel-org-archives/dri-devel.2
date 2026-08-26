Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC00C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7438D10ED0A;
	Wed, 26 Aug 2026 13:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dKuhilFl";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B4DF10ED1B
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:15:13 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cecdc24b1cso1377345ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787750113; cv=none;
 d=google.com; s=arc-20260327;
 b=iNVj0jwvwrCEtRVFYtfAjA//BbEoK3sTMK6L5brEOUbDIxr8u9dmD+4JysiO6iRryC
 ocZHdAHi1dtuE1INAStq25BRfwyqNJzNtaxn+mUrhNyaRIedcwi9bPdqn5rAOcOEPuJk
 594+eqELasG81Uu0fYCTRmhZLBjeuEKgq8lJkxpZZGHnWrvHyVWmlCnpmcbxouifnY2h
 GA/PIDf7qVKKdLYKi5iLXMGmXygKb6fV//EgZEQjK291b22oSE0xkiGTT4zHmxHje8l+
 UztuNGwhWZp4VzIlBH+h1M5vL/EQjyknjaCxT7inxyL41PIFSlN34xAAJKsARdx5bwSi
 WF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d68A414WB1dkKupG8neXp1UtIKkBQkiVmGySNMv1upw=;
 fh=Sk9NteqrJL1Ayis6xpyLyPUD8MqzFCqKItU5XQdG1dk=;
 b=Fm6z0TgHoiRajm1HVbsHm+AzXIqhIJwaMJ6TEM7JfPArQrGmF8uxO4JQgRt0PDhUBu
 fT/1mPI+F+7AoPyS4VtbWAPkqWu/EqElM+GCwRDZaaDGEyePlBixdmIHBI024fOCU/MI
 tErGfoyr6QeutipOf6zFK7w6Qz4Ke07ZK6Wmqkgi4mGkx7h65wb7MaM4YMlNcMDoEYgZ
 o3vi22QRTYGqzvz869LbeGWizXyPYVC2MG7dQOpi5e0xiTKnr+Qd22FI0yXpllyRvkL0
 W8ESsMaGCnPRV7q778UmqihvOvWqj9PEBt2k7dsY0sPu5sLGGTlImHwxW1P7bV6rcKyB
 jE7w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787750113; x=1788354913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d68A414WB1dkKupG8neXp1UtIKkBQkiVmGySNMv1upw=;
 b=dKuhilFlkRTzoia/cpBY1+3/QKt1fSVY7m3Po38etWHJYgyACAcUfZjJhlfq8tF9v0
 R4ndaXtGRdmiRR24pyWefzYX5i4I97Lkkp81r2YoMDOPP220z/BJy7lySAVFlQCQ1R+5
 cHrAhnjJSLzh4DdQmokjqo4qLM5MzeUGD/vXqoW5gYyfumS6QmqgIfRVSp692GxA44kP
 N7aHDRtvxmqt1oPZsrxIOVLggHc1fsUEX7DNvu0f+Ckz5d8h0CXeXYqCiuUFLkII0Ils
 PqRm0sS+LjJE3k08H5GiDOVNcOvvsJih4OWZf1SZP1TFYmrSnfqiygP921Ev7LHImthT
 gHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787750113; x=1788354913;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d68A414WB1dkKupG8neXp1UtIKkBQkiVmGySNMv1upw=;
 b=P4UYbmYrtx1hPTwM7sRrsJlVSf+XqwuhxGCOqCtZS+GNecZmnAqJ6cqhoR3TwLK6XJ
 w4oPBL5UjylP//E1wnzgwOH77OfeTHB66IvabUASQ/c+7TwSnhMPNZRetyQ3A4StjTg6
 eXygu0hDvGwPLtC0JhWZ6DaQAhyLioMhHKDOmpbiSU+MnUpREujdfnlrxkSFsaYyFIjm
 7QwfqiMe24ae5LwE/eqWEXqIbnYtktwKll/hmOuK3vBRqfuykxwwnhXW7YnX71TwhqE9
 IdYZ6NMha5HmTnSp/5KLQjde07RNj+QlYx1OKVjs1AVo4e228OukDhk7tXxIUHrX+E4I
 5oaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqL0A42UqVsHLNeyOVhii6vz0dqYHPGBbxt8k7N1TLVzRF0G4Gln6a2jC5jsWFBRk0qWpuvRvw0CZ8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqz84Ybqq0v6gyAJX8d0VLM4FYfOeo2gqSLXj3N+r24D7KYgb5
 19Z9gOn/fEMtZ1onN0VSod47mjiYK2gL1XS0flOVxShTcuxVtEdhNBQ3aNctJ8CqZ8tHsI1AQk8
 82QAXJFVExF5LmxECNdi+NBhjzNy1ZjE=
X-Gm-Gg: AR+sD13ZorKYmHjX/n0DF0sFLMtoHnXCdlu63IoPWMxJx/caURSwq5fIi+6oSj2u6Qy
 z6TOmYJBAJ8GN/FrW/+dVZfZmfSMobrCDrd4dLRGurX8sPxwu6bcNHLXubZgu6o3m4EwIeZGSR7
 LPPTxWaDFbWUPo+bUyTPbUIolr+5P9uqL5s3bDLO4RkJzPW8IXKPu3R7uIxYSuGSDYqCttBVAt4
 2GzRwPS1LkaXyrS/g7wh74OSAZYGHPvy8rhKrG+PAa5hFa5I9twfZoK+OkoCca6SW72hVlgCPmy
 b2XQvdUgIoBGA1Pm8I+HCo6R184PMMiTFnMtIOhR8dHZKprvqnxHudhvef3FWHaCjJBpZw3X6Fy
 t2Y341FbB18czNS4n1ndLA8q9ikujN9Q=
X-Received: by 2002:a17:902:ec8f:b0:2d7:1a3f:8db5 with SMTP id
 d9443c01a7336-2d71e51eddfmr1812505ad.4.1787750112568; Wed, 26 Aug 2026
 06:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260815180033.8958-1-linux@treblig.org>
 <CADnq5_PgZx7aDGFD5pPQ=1MvF9_N_omVojNiDQFHjs0Tqasv+A@mail.gmail.com>
 <2026082644-monetize-tingling-0abd@gregkh>
 <CADnq5_N0AxaDZswgEQ7BEcKw8mF2hnSbAQp-w9U2Fy-MaEw8Rg@mail.gmail.com>
 <2026082654-gangrene-support-8541@gregkh>
In-Reply-To: <2026082654-gangrene-support-8541@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2026 09:15:00 -0400
X-Gm-Features: AcwNN1X4LudWVwUaEUKscYc-hvggQoTSapOlPRsnZqqAC9NLjfVJYKctFGxUoHc
Message-ID: <CADnq5_N+bXX2cFjxr0xHX9Yso6+OHh=9i=61boEsRedYwid9aw@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amdgpu: Remove is_idle method
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux@treblig.org, alexander.deucher@amd.com, christian.koenig@amd.com, 
 harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
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

On Wed, Aug 26, 2026 at 9:09=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Aug 26, 2026 at 08:45:29AM -0400, Alex Deucher wrote:
> > On Wed, Aug 26, 2026 at 6:21=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Mon, Aug 17, 2026 at 11:27:41AM -0400, Alex Deucher wrote:
> > > > Applied.  Thanks.
> > >
> > > Any hints on where this was applied and if it will get to Linus "soon=
"?
> >
> > It will show up in drm-next after the merge window closes. 7.4 material=
.
>
> Sorry, but this is hitting me now, pre 7.3-rc1.  Booting and getting a
> zillion kernel warnings isn't ok, that's a regression.  Please get this
> merged sooner than that.

I assume this is the series that fixes the warning you are seeing:
https://lore.kernel.org/all/20260813143605.106104-1-mwen@igalia.com/
We are working on picking it up now.

Alex

>
> greg k-h
