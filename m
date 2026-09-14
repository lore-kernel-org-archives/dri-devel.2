Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A760C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3272810EC33;
	Mon, 14 Sep 2026 09:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pGkKmuw8";
	dkim-atps=neutral
Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com
 [74.125.231.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD0F10EC33
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:04:32 +0000 (UTC)
Received: by mail-oo2-f40.google.com with SMTP id
 006d021491bc7-6c2613d8157so674610eaf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789376671; cv=none;
 d=google.com; s=arc-20260327;
 b=ECRPdsa3WbA3wleTCL02HhuT9gQx7ESVbq3h5id93clpoQ2iTMd1kr3h9r7CS6XKSz
 mTKNTJRIC9Ci02mz3zAy/e1kDTu+zzToB1Y/SVyF0Bqo5WgWpoA1OJ8r6iRkCC9gYJLy
 HqovlddYq0cvurlbx0D+KMR2ZIKt5WsE9O3IZvmh8FFiSWRt3BsGAXLHKPZ925xkDmVV
 2gxY+b6hjcdxywqRfumeF2EAKwHKAMJvjVoLPSgnNEOvHWsUDvSBDhjY/qHCgypOnwJR
 XiX2mie7MxhE+xxYTSZPKd2ONq30ylWQI/Yw5KERNXOthr0q8lUqL53MVnZxukMYQJmu
 AJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6hZ4sLkAvzKguvhtkssQGq15W26aLKtU+1jNPbiNdg8=;
 fh=BEV9Q974r5LfnchnZHqy/eUc46bQkY/0YRiE6AYrRLs=;
 b=e2aOtRTBho9w+hPvNuEa0/uBivqFpDs/i14ga7ZXWasZ59qb/ssL39CkCHyg4F0je3
 1dCqR1fev0MlHQgRbu92wWN1UQV+FBtNrE7l1XQIG6uHLB6SbzaK9FO3K17D4upIpTkj
 CD2fCZEklJ7+UNDmqrLPFMKW4JfSEMcAqq3NjeZ/iqVwt8b+gATNWVSsqSOxfAVqT+Re
 Q5EFLzoCp4WeAB5oAM01ZPYqQcgzSD2JOt6BCtF6t7YP/ufrVyRxxTulMs+w4KEvHMmH
 fuYA98SJfYwcNSTRi/2hY0GYKXcX8DUXy+eV9GeTaY/gr7gfmAzDuVRJtCkJd0OVCh1U
 eIVw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789376671; x=1789981471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6hZ4sLkAvzKguvhtkssQGq15W26aLKtU+1jNPbiNdg8=;
 b=pGkKmuw8CTQgFUJjJcH3EegbtUDf1ugYuyWuW/9v0Dd/DkrCDIGzdzGX/AGxmh8qpr
 9c2gOFzGsEHDeO0ZRVJxyoVMWWnaGJbKpETtDBDF8+6PzJUArZpQgbZ6/VFga7XRqK7b
 C4WsShLa7+LxB4Eq/tHa3NvwYH+7S6vN2NPyJ7r8fs6qMe6g+7k89KCbSGECIMpf8jce
 3Dw/iMUZn0CNxBqgN2fbX0uahQ42OW1iNfmHmD17fKT9XOxs8Dl2IOsL+r0hDqZe0imS
 PlWOCvtdnH0I42sr7eACDXRLm4Az5WhmZGBLEmfGyvGAJVPAAZArJ1mxOPUBR3mqs20v
 OQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789376671; x=1789981471;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6hZ4sLkAvzKguvhtkssQGq15W26aLKtU+1jNPbiNdg8=;
 b=Al7tLbUPuvqcPmg/fEjOTaBbTshMk57hP8eI3jkNSift0MYWVlgicicRG1Y0SLrGZH
 vW3HAQIZmFVVQjMD6GQI5eUw58DckFvoaA437UDISGVIRKAn30ZKPrI1jzf15UlBb8L8
 P+LAUjTuc6SWbZ1EHierx1CCLBgj+zR6MYuf5M3vtwSknXE0QPPGzqhkjSAQAO9xteXE
 XHb0tPjpt2D61uIwVADqY0jowEwNwaRMnRS6DK98fRqLvX9bVSxp6OnQ5a38qy+YfY9X
 y/z0SzJCcHxUqm/SeA3B+ekZdqeB8KXyD8E8K+Fum7ZMo9kjnwpSzOu9TEe/u4hPzClu
 wFxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuftDdscOIU4/ULVatM3iGlRlsWKYNgM5ELQRgWwSoDT+PThJgsdVCcc3bfcDbTy+0aZO++orXOws=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mpNAeFC/exaSdUlJhyrjFz+H1b/mVrdwVMAbF5eTi/3Lyvjzio
 zIeLgSesFD5pJsxyy/RVJ7aiEg1iADT2WV12qmd0/ttJVM/tS2IQqu2weDSCSgyNrLFPLzD8AeM
 +9DHRj2/sdCAmciRUYCdpMOMQ9aPiYLc=
X-Gm-Gg: AYBFou1Dc2wEGXFkFbgFbDQ9fBH7LwsxWvbRTaTo2euIyIk0De9oDwnIyq9812kqtxe
 zudfQNjg7xRujO5NO6N7tTsvg8QbPLFU+elC59b+vqjl9qeUZ9DVTmquaK9g0DnrDJkpePVsytc
 DYVqXr4z8fSiGSsZX6oqLaG7LdT5ENkW3nbjyFdP3EmP1OJn/oD+cgUwCyBThcHIP+GpURqlpBN
 21fy7PYysWa55ulfewZasWNVxSzI2F6kIKSzuRe31hnN+GWim3agk+VpZDUzPDn8w01ck22oXoS
 xxT+TqNA9nTLMBacF+yg9bqFOyoMIPEujDBJmx+KhxWgBQVujJc0VEZQTtzG6UJpsRPaar5/A8M
 QkezwRMXAwI3ZDw==
X-Received: by 2002:a05:6820:4cc4:b0:6c3:8216:6358 with SMTP id
 006d021491bc7-6c542537ac0mr1319314eaf.29.1789376671216; Mon, 14 Sep 2026
 02:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-7-amit.barzilai22@gmail.com>
 <87tsnxl3jg.fsf@ocarina.mail-host-address-is-not-set>
In-Reply-To: <87tsnxl3jg.fsf@ocarina.mail-host-address-is-not-set>
From: Amit Barzilai <amit.barzilai22@gmail.com>
Date: Mon, 14 Sep 2026 12:04:20 +0300
X-Gm-Features: AcwNN1UGx_5yKvwgvZgvxzGgxcllCpI8_ZHciIS7iNKYuuND6gS1iU1-Bj3Y5Ts
Message-ID: <CAOEgbEqtmanqwuX-hLNG8HwNn1+NMJZUzbNFavkJEpqfQAfLfQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andriy.shevchenko@intel.com, holofermes@gmail.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
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

On Thu, Sep 10, 2026 at 3:00=E2=80=AFPM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> >  static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8=
 *cmd,
> >                             size_t len)
> > @@ -271,6 +310,17 @@ static int ssd130x_write_cmds(struct ssd130x_devic=
e *ssd130x, const u8 *cmd,
> >       unsigned int i;
> >       int ret;
> >
> > +     if (ssd130x->device_info->cmd_params_are_data) {
> > +             if (!len)
> > +                     return 0;
> > +
>
>
> Can len even be 0? If that's the case then I guess that makes more sense
> to check and bail out early regardless if cmd_params_are_data is true ?
>
> For the !cmd_params_are_data case, the for loop will be a no-op anyways
> but still I think is cleaner to check as the first thing in this function=
.

I leaned on the no-op loop in the second branch, but I agree it would
be cleaner to check this and remove the edge case regardless if parameters =
are
data or not.

Addressed in v6.

> > +             ret =3D regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cm=
d[0]);
> > +             if (ret || len =3D=3D 1)
> > +                     return ret;
> > +
>
> The len =3D=3D 1 case is for commands that do not have parameters right? =
I
> think that adding some comments explaining this to make it clear why
> there is an early return.

Added a comment in v6.

> I'm happy with the implementation now, thanks a lot for bearing with
> me and your patience iterating over this series.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

No problem at all, happy to work with you.
Thank you for the review.


--
Thanks,
Amit
