Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F1606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B0zD2JgK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F68B10E578;
	Sun, 25 Oct 2026 07:24:03 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D7410E7C7
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 06:00:47 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-980c4258105so1187946241.2
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 23:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792908046; cv=none;
 d=google.com; s=arc-20260327;
 b=jvELwzAL22iTToXeQq0j5C4sTH4QXkSTwsBb7XaaWs9wsIqRKns6ZcMDxkZWgjTYS2
 8OLm25RPIsuekRSB268Mg0k7cJ7oUEvZr1fw2J7nkHNd/t6Y5ThBOQ2+eGCetCeWOpoz
 63zGYPaa1mEjQXPTOsTex2PVBrM6W4RcLqzjPPpHsUwNg61o099KZnSnR5WC3n0nyRyZ
 CxON3PV3M32AQSmX8j7YAHzC2oj1l9vEy8/Bx1JqEQR94lF8HtvVtQl83wg/uweFhtyQ
 WTXpCY3ekyi0lvh6WAm9gyX1dn5kiFa1A/apjX7kNHcV1ORo3QJfOIHUskRAARDHZeYe
 GIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K5aG9/sUaDY/v6QVU25+fMMSYhzDkzcZSaaIiSDMnYU=;
 fh=QUnIkU3iaI+0Pv/b0nQWoZZ7Z92MDcHhtH122Q0ChT0=;
 b=MVlqb385knOooPtlfYVNYKXcilKAm9h3jSN5IYyKP3S7lP3MNBNrX9CnHW3cd3BI4R
 niAcbF3Pyrj8SXH+i1JG/fEMnnvLw28GI5Z7WPMNa3qRBPz/L+M4bS14nNsXBU+7N/qr
 8nAIWwfrkCxj5ZCFlb7Zl7O5/ypG693PLajCG81GQba6eqIJWyQQlj2o2wXLFy2k1i/Z
 X5scqXIh0mu7JyIhH4KjVwJW8ujBBqriPemS2fjeFo57tSk9EFzmULbjXDh1tHLBsyoy
 L1Ra5POWtSJ2RqoJRbCtUyBUnDxdHerK7OLjftLn37Kkucl4kZhqURAABwnAAeLLVgE4
 i/Ew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792908046; x=1793512846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K5aG9/sUaDY/v6QVU25+fMMSYhzDkzcZSaaIiSDMnYU=;
 b=B0zD2JgK8r5QyGalxWCvO66GKOCsU6TNKTf6LcjEA1W4XZYMGvcg3PvldUr1A8uA2x
 l2EGPUv6E2TqN6XPJAuFMzwGft7TJeNFPz5vo51evExmZojgOubDdyZxamp/RGvlGC4x
 yjiwVYXcItrLtccswyWtJUNBiotXoKXws1aAFBdsnwIp4Wc0nplG032h+AgOzvWFBBhx
 aU2C8eFNhlMsljZPiNZjZ64Ib3eper6c6iM3aCqvXaIT+UWagLR818V+0TdCtD6DQSmw
 Nj1IyBYSe+p8r5sYO/MDA3ahR41vY0beTizyC9M8SKe18V35vcJWq431wqzRc8xf1a+v
 SDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792908046; x=1793512846;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K5aG9/sUaDY/v6QVU25+fMMSYhzDkzcZSaaIiSDMnYU=;
 b=W4lTxPzHRvXMZexPdLFDRaNWTMKoh8/3Z+MhguatLwHNx85702zbJsOjhaNAmy+lnx
 9iB08OsZWfCxHJIhAp7p/JhLE7HZo7JvP1DWWTq3nFl0Gtg3UKUXqwv97rOxrBob4dfO
 32U3KJxMI+gfVRArRMZPZmDrY7hzN/kDWQZf9Jfa27WhR9WlueLJ7etBN902bciBQXYn
 +XDQ62poyQs2FLwbmsgPu5FqKWTc9Bommlg5/BLlgilUgbAqbjmPgbpSzHCDQdnVnuHz
 eeA1S1U/gnkoxflFqhSS/mK9nyaP6Fvy3UYjcZGtmbgtF3+MULxia5pzbcD4qgc5CSrM
 ZF2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7swVT+isfnIPgf3NYALAMY2xtv/jz4dZVTn4jwqve2sw7ly43PcFaSE1NGX8lxdIUY5rdl6c8xNY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKpN0okI4glJ0/FvuSGvBatU+lLVPwrkVHSY1WUMc9bT3cNaY54
 HaYI5gGIrRqdl6yeWxqVEBjoGsqkyjitmeV2urCCNxPfRrv0sm43zOexQWSyP+Oe6jmqxGcr2YJ
 FK5qHm7inJvS4+gSOpIPuOvMwSNt5/OM=
X-Gm-Gg: AYBFou2LIIMfTuNqGN44kNIyzHeCFUCueicpvMWMYRgCnh25ZLcljHuqaiqNBsowD5N
 O8l6kVP2R24IEF6iX/n4F21NWSZz7AGFfZn9SBezOLBzyiNnTi9ciX8lc2lvab3ap0tdFagfD6k
 iqF3hoU/ssiEjH7Md8I8Oljy+9poJJq2ng6LaJzxXgwUByupGc3KPqQ4nUDwaS8ipl2HUmEARFw
 SjQjxTORt7jcO1E69CKvzJTdEiaglHhTgj1+4m+CUVXhX06h6kf3HFwChU67LOtTzZ5L6r88QlZ
 +2VdaV7/JEllpGAMJGEaKz1PlePtRncdLX47tgyWNs5anLnxiNfOW20n1f1t/zz5vOQX2wjeOme
 gaU7NWFEEGSTdMI72F0BTxTjItKPQUALonEw=
X-Received: by 2002:a05:6102:3fa7:b0:7c3:3f26:8785 with SMTP id
 ada2fe7eead31-7ce5cc37c83mr1116161137.7.1792908046029; Sat, 24 Oct 2026
 23:00:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025052136.389541-1-dev.adityanagar@gmail.com>
 <2026102519-polymer-gorged-bc90@gregkh>
In-Reply-To: <2026102519-polymer-gorged-bc90@gregkh>
From: Aditya Nagar <dev.adityanagar@gmail.com>
Date: Sun, 25 Oct 2026 11:30:34 +0530
X-Gm-Features: AclHuK_TcOcKb9WAKxu1FqX-QDlLrI_sal7kxnj4OmX_2Ibk9PcCncKk3AAFZfw
Message-ID: <CAHLX7j6Ue5gVxc+bLZS5kphO39bs=Jf55Pc4nEyN-aiqtnmndQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: remove unused argument from
 FBTFT_SPI_DRIVER()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-staging@lists.linux.dev, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 25 Oct 2026 07:24:01 +0000
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Greg,

Thanks for the explanation, understood the message and I apologise.

Thanks,
Aditya

On Sun, Oct 25, 2026 at 11:25=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 25, 2026 at 10:51:36AM +0530, Aditya Nagar wrote:
> > The _compatible argument of FBTFT_SPI_DRIVER() is never used in the
> > macro body. The device tree match table is created separately by
> > FBTFT_DT_TABLE() in both callers, FBTFT_REGISTER_DRIVER() and
> > FBTFT_REGISTER_SPI_DRIVER().
> >
> > Drop the argument and update both callers. No functional change.
> >
> > The argument has been unused since the macro was introduced in commit
> > c222ea5d2f33 ("staging: fbtft: Deduplicate driver registration macros")=
.
> >
> > Found with checkpatch.pl (MACRO_ARG_UNUSED). The change was prepared
> > with the help of an AI coding assistant (Claude); I reviewed it and
> > build-tested all fbtft drivers with W=3D1.
> >
> > Signed-off-by: Aditya Nagar <dev.adityanagar@gmail.com>
>
> Sorry, but please read:
>         https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh
