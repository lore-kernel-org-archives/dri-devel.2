Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E63606A31B
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MP35hMwZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5837B10E231;
	Sun, 25 Oct 2026 08:52:12 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218FB10E231
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 08:52:06 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-35f036b17easo5274792eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 01:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792918325; cv=none;
 d=google.com; s=arc-20260327;
 b=YPWZ6vAtR+dHoGvNjtWrPtBtRK7+hSt/pPq0+wQ/dAWLvwy3IFL/gvsoyz4J8Rl9Hc
 ABg3k/BM/CRMpjGF4QY8CSbk6NvsBBMUuFEgUnFMIUEf6ICIVPde+2aMv/loJJQr2RPh
 Ph9ENBlr3FH6ZrzJKvaYIoRkVHCGIKKKfsCyxqxWQTNBJMSCenwEwOIfdU9NwN8qf2/e
 EdlNrrfvy6I9kX7wP/MK7+VWoutnGY1qbhPEduhi/ukMFM8Ut1mw38r/z2qcOkiBsTYG
 dAPF0/vIjTQY9u9itqQlLwCEJmmKSr0jzG0tatMWcDwct937nvRKWBOMuseDUEkEKYO3
 IBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bc41FckTcBQthvtCzkFLVNCK1+fJ08FUf/3Pl3O3aMU=;
 fh=eYefsXtsmM7WxG2P+kka1Cm6yyPOdPBC9JjRqI/veIk=;
 b=nFPGopwqJCNjVqOH0txfjJqJMp77BVz9voo8mNLt4v5gsTfuMiEUmv41Qr7xMGq4W2
 MEEw6CH2ybaZagfwi4MPzq0NQNNhN66Y/owuPhZzKJziCB0Lw7TfbqPDPqmFetnyEXkf
 gXEUjoHB0Fgdgljhcm+aD+f5uvUsXMckD94J/yjVv0FkdW8w3+k6ev88jdaod7/lCYeM
 JnnnpRLVWvp+MckGG/0WY0paZId5krJbqSf6mFavGtCIpk076FTLG4BcWeWqDnjzCMVw
 oioygqPOHRhUYOaXCzcwnVfMWdrTboxQaMavXDkitzgYt64PSZ8wpANq4BMi+rzJAV61
 8hlg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792918325; x=1793523125; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bc41FckTcBQthvtCzkFLVNCK1+fJ08FUf/3Pl3O3aMU=;
 b=MP35hMwZQb2CI+MDXujGfRgpQFz5iYxV7ulWGN+n/yxgwHToFG8QSkRjDFJq/bQcon
 xbr2ZdktvPqJzguvW+ekJQYXBnI06ocSSkn9M0rRrGiauoXEYf03FbTzd3bQGDXzleNy
 QNiCVdf+63BIQQiz+d9LbdN1MxvciS1U4/N9PvhKR47sF+la+LmBk18L1hiaqBee3IYc
 8rsNtIQqWdAFzHdJ0yHz1J2ye8/I7G8e3Nt1iUq254YZjZeCHd4xrEM8Sd+b/m+ncc8A
 rQO8KFxWdGkWS0yRjgIki1tmR7+t1Ptcgw/HWuOJoQI4fpwj/EvNpNfzXENHEZ6BCV0c
 9L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792918325; x=1793523125;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bc41FckTcBQthvtCzkFLVNCK1+fJ08FUf/3Pl3O3aMU=;
 b=p8iTJywuZg55H7czjKXIyObwUesYXlZkaJ7zpQ9HjES1/CRKtEYSbIXA6SOCGgX+mr
 46O1rockfiU7ZwzSXN/67JIvGFO6wsbi8cjq7Nu44EJ6f5FBmh+uAYlPaNIhRENgErLW
 9hntehxxRMZZIVhTijVWv0wBuOWtm6nVz2ISHgdlO4/tcpUzaVENClBHA2mINamHgIuG
 31h2eLKJcEfZhIBCqjXVEpiZxCF59utu+2UthROTe8Av2ZjPawzT9pFphPHw8wrJDJth
 7ZAMklW89hUrz4zISweRJAm0p8eagyzR09fgO026JG0Am8T1KYu5Cj5E6PiFROCGxb5F
 VewQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt7+ddWSPaIjFDa//iZwd9uq290+i6MPrJrVdQPuVKpj8Jj9tjXlUDpacdYeEsNkVYSa0pBqYIFwE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKOipgx1gt1bkQ1/o1WVgEpB2o4TzHsMWUY4+IMtwuxq1POuWfe
 py2ngjxhX0f2b7rtL2Rk/gEZKLdVFYCL4119YfWoGu/e5AsceMKI4G6vRWpe3faTSinHSvw1wLf
 YVyQxismt1b3xLQXjBgs7K0rh/Pdu4xo=
X-Gm-Gg: AYBFou1vlQYsYDtjLkFEtSTyD6VhRiO4uoTv28KubE34Z0XG0bPhviZs5BpKxUMd1Uq
 lLXrZLTZXdYkKtfJB3d1H61Aihny0eUA7IDbINnw2fTybualSdWcp78Oo/5a9FIh1ir0/bSc0/M
 teYXH+mr3wmOyKQXJv3WmSizyw1EUF3uaqS6P05Ke71bTsOGXWgO0gyHuYA0e5eAPVhMBPtcHcc
 e73m8j8nybzjtGDHUOmcvPXz79M98/AFnkmCj53TXNV7YDm6KRRVXkGh7IEJam7nsyEOizCu1og
 q4RDe1J9Re20iJGAchOm126f1Lo792fCLbjuHN4dL7qVWfal5A8uSlLaoorumO6odFUgN9Sx0Sp
 W9JjzAfw25fAVp2jXcBcDWSROLImaX1lwTrbGSK+nMQyn4jWHG5itvkujG7LaCNk77QXD1w==
X-Received: by 2002:a05:693c:66c1:20b0:35e:51d6:9f6f with SMTP id
 5a478bee46e88-369e84f5952mr5827731eec.27.1792918325200; Sun, 25 Oct 2026
 01:52:05 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022132259.240717-1-clamor95@gmail.com>
 <CAPVz0n3Vrzb96iR5ZW8zvmruZ4aK0hKGKpJ2T9Ys+bSPCtLWHw@mail.gmail.com>
 <CAPVz0n3gzV+gAu_gzp3oTG9VOu-YiNSiQA0SdCFApKsi0dGjKQ@mail.gmail.com>
 <0g7damfVTZ2r6s4H0kv6Lg@nvidia.com>
In-Reply-To: <0g7damfVTZ2r6s4H0kv6Lg@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 25 Oct 2026 10:51:53 +0200
X-Gm-Features: AclHuK8VdLvGZN3upYS8jizoanUHoPG-jyCBtPV5Pp4C9VbRI_nvkyJWhb9qq0g
Message-ID: <CAPVz0n1G0cDuUj7WRfj9YRgvMSd0sqSCjnir2p=QxUGu5BWTXQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] drm/tegra: Add support for 8-bit CPU interface
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BD=D0=B4, 25 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 03:4=
6 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Friday, October 23, 2026 11:14=E2=80=AFPM Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
11:26 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > =D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 10:53 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > ...
> > > > > +MODULE_ALIAS("platform:tegra-dbi");
> > > > > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > > > > +MODULE_DESCRIPTION("Nvidia Tegra20/30 MIPI-DBI Type B driver");
> > > > > +MODULE_LICENSE("GPL");
> > > >
> > > > No separate platform driver or device. If a separate struct device =
is
> > > > needed for some technical purpose, we need to create a minimal sepa=
rate
> > > > virtual device, but unless there is a strong reason to have that we
> > > > should be fine with just the dc device.
> > > >
> > > > Thank you
> > > > Mikko
> > > >
> > >
> > > ATM, I use bridge framework to describe interface and I am attaching
> > > it to RGB since it basically uses RGB to transfer video data. It work=
s
> > > pretty nice so far.
> > >
> > > You propose to replicate how RGB works just for DBI?
> > >
> >
> > One of the reasons I used separate pdev was to be able get mipi_dbi
> > from it using dev_get_drvdata() from patent (dbi bridge in this case).
> > DBI framework seems to not have a way to pass it in any other way,
> > unless you know smth I don't.
>
> Right, I think using a bridge is fine; passing the mipi_dbi interface is
> properly done in other ways. The direct parent devdata link is a bit of
> a "poor man's bus", and sometimes it breaks down, such as here.
>
> MIPI DBI is comparable to MIPI DSI -- both have a hardware channel that
> sends both pixel data and commands. I think we should follow DSI's
> example and have a DBI bus and devices while keeping it as simple as
> possible.
>
> The DC driver would register a DBI host and the panel would bind as a
> DBI device. The DC driver can then supply the mipi_dbi object in a field
> of the mipi_dbi_device.
>
> This is a bit more complicated than a parent devdata pointer but much
> cleaner, and follows the existing DSI pattern.
>

I understand your intentions, but ATM kernel lacks any DBI type B
framework. No hosts, ho devices, noting granular. Implementing
everything just not worth my time to support 2 panels of device based
on Tegra 20. And I am talking not about time to actually implement
this in the code, but to upstream. DSI framework is huge, copying even
part of it to wrap legacy DBI interface and ustreaming it does not
worth hassle. And yes, I am a poor man, I use a parent devdata bus.

>
>
