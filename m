Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABE606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b0cSeM7z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045A810E769;
	Fri, 13 Nov 2026 12:31:03 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AA310E769
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:30:56 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6b7221c0f2cso1784698a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 04:30:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794573055; cv=none;
 d=google.com; s=arc-20260327;
 b=NVxpmTOB4BbjWjqY0/whWAh2GqrWJyySdGYnKaPWxfo0yAZWBZPN613v30CN1FpHdT
 1SrcWYgz+LSC9ry5NT93WhuVj5LkMdbxqeBQ5xhVQ4fhCHayXf4juwmEmg83ztJOCqFC
 cI8PMvCsHbIXCs2xNVyhiXSBt7hwEvFv3YMJaHxKw6DZBHvnxiF+/X8G/M7PL8Zd1FHO
 OM5lUIxYYDGejD/gGtLJGp73RAE+pvoJIvurtYRg6opqiFxV12nONuIAQM48YT8XmJZw
 p/c+AbfAEalSEOrOCbv39AidTtxKwns++GT7RgzC3O24ZX6E9pgv8G2MQ0A4yHBb37pF
 /nQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7nfzSGmH/SoAYiA+dbtIr3OSkraGI4b86uhs9emiW/c=;
 fh=Hum0lSLqpGvf0vEQvX8lZ96vySU6bx/fXPEiIVMZ+cs=;
 b=D+Gx9goJNNSq0vH5GYYqOFpip0d44eFBu7rCacrgiKTqrIvVDluqRiKd5bJAYc3l51
 o6ji/MrfuWi3qqfxwc9WtjpmF5MI/jL2hkVM8K6Cr5VyhluC5biBU/BH28jyU/YXw99i
 g6iMRO5ADI/0nvVLBKYdv1C+yI4GC+KhihPx+DAJa78nS+A0pnHLSSuLpd6p7rjRodo4
 9TpYrrR0eRz6nz5HTrECkRQ9gfVIBLUitQejh+pLtmV9hKvSnJF8wPQ36qpq+tVkFr4L
 pN4nyqBUPzO7cs4c7qF/feNg/PfDO7N8Uz/M2K2VaeSrpDrp9eRrIttZdh2aMa1RDs1f
 m3SA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794573055; x=1795177855; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7nfzSGmH/SoAYiA+dbtIr3OSkraGI4b86uhs9emiW/c=;
 b=b0cSeM7zoWLZ9RbKeTLZ1tJ/DLWUt6YMY+I3ccFIp/7WMZTp8kJe3BqB6R+tsVF2Iz
 vU6KCtFzayqg43SUa/5n98OQ4mG3loo71qWQ0k7tHQfI44tD6KaUai0ioLOR4r1m2a50
 OfGF13LEXz5/oBwkKoP1ge1p2ZOxxVrnjVJwBJfgRQvBy8DPoSQECzHrF4UjCXiOK3H/
 hpay9uApI97KysGnR4uMQF+9J1KvIv7LNEIfl6vDpW7WMZxrmB6jDuy0fGLpt60C5BWO
 oCrbj4agKb1fKdvfMTNeD/gVvLHn0PC0BXFwJVVcpzmxVPVdXs9IJovCTWgadvR1mCeo
 FO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794573055; x=1795177855;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7nfzSGmH/SoAYiA+dbtIr3OSkraGI4b86uhs9emiW/c=;
 b=zsT/3TVBI+JF3AGM9yUs2ceZ/ilT4Yfo0nT6FhrZcOAi+RMZR5hNQHNIKYMOJaYWGG
 Zk6RQFDGVtfkJDw2Q5CmrExv0z5b8yzfJD7vGb1fTB1SoXeXe+2j7TUpjYv5J/hlJFEF
 qqv69DikWg4cLS/HQgKNn4D7WOri7J9iFA9Ej+63zPtnD/alnJr28pmN4xlOhzbRItwS
 auyDJHi6gHOMqZTJdwsY0rJCw/I5UzxmYSEp8A4Ft4KJpnRllfPteFTYuh9+PB/kRxHY
 WXkYp0vSn7gieTj+nvbZtQTnnK0xM2d9ZskPsJbaRMSo/UcswlyuN0RNAig8mP5XFfKf
 IUAA==
X-Forwarded-Encrypted: i=1;
 AL+hErG4m8C4U1XVHal+sXOiBnqnIPBJr0twYU0OEp/D+NY7tKZpqEf6+mqq2HZW1nyawxRTa6TOk9gPcLE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/MdLN9/UAXWZ0OsODTzK65x8OqEBlcx2rRqgm408ZW0+/4k1Fb
 NWzpCx3gYeJk7pdxvyK13btry06YeALMCC3YEXl5pHiR1bvQ1K6lrI3TMGjrnwGouXm35PvwzDT
 Qx9UV1ZZ89V0DJ1TTWnfVzonRHQZw0GM=
X-Gm-Gg: AYBFou2D2MEEeoyYK4ysF+e1gvpcYt/HfNoPgaJftxKsCyPUOwoTJyN9RjLQKYIDYd2
 ZO1+S0PNW+5AnR16fZvNC1ZV9rooO4qB2O6x84ow1mXWGeqIowEdzSE30A0Uu4Xpj9kDh9ewwJF
 Ucq5M7HV9W3ACqObZczdG31m+x/PdOmI6gNq1DqlBovtLQFmZpeh1sP0Z8HOw/xlEOlw/zWF45N
 ySIOQ9fXJAtFaOIvZ3ybBRKf7lyVujPr4qirMSBssiKEtCnCys0CH46n+LwcCJwq5VYVeG9e8kF
 iJGrxyPU96zK2GVVDg7SX3Texg8IT2Zrb0uVo2WGii3KJivc9EEKdACKFyUhIad69fe9xt03Hn5
 Op2Rr2uH3GDChR2CGqDbINVILtF89L8Mm0+K8umgdFKK72UKQhR7gAuf+z3o=
X-Received: by 2002:a05:6402:c51d:20b0:6b7:749:4bff with SMTP id
 4fb4d7f45d1cf-6b7c0bc3facmr1556065a12.26.1794573054532; Fri, 13 Nov 2026
 04:30:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
 <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
In-Reply-To: <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Fri, 13 Nov 2026 09:30:41 -0300
X-Gm-Features: AclHuK_a70bDhuFPjKhxQTxb3ROSxhiMWB54BMOWkaQqjNMx7PUnPnLznsOdmvI
Message-ID: <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Joseph Telaak <jttelaak04@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 dri-devel@lists.freedesktop.org, Joseph Telaak <joseph@telaak.dev>
Content-Type: multipart/alternative; boundary="000000000000705f65066027993b"
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000705f65066027993b
Content-Type: text/plain; charset="UTF-8"

The old 2D acceleration code can rest easy; I'm not going to touch it. I've
been working on my own hybrid 2D approach instead, with good results. The
CPU was indeed faster for fills and console scrolling, while the GPU
performed better for large framebuffer copies.

Ty,

Gabriel

--000000000000705f65066027993b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p>The old 2D acceleration code can rest easy; I&#39;m no=
t going to touch it. I&#39;ve been working on my own hybrid 2D approach ins=
tead, with good results. The CPU was indeed faster for fills and console sc=
rolling, while the GPU performed better for large framebuffer copies.</p><p=
>
</p><p>Ty,=C2=A0</p><p>Gabriel</p></div>

--000000000000705f65066027993b--
