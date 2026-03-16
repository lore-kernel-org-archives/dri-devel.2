Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B65F013C5
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B22F10E271;
	Mon, 16 Mar 2026 08:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WCzmVbMB";
	dkim-atps=neutral
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3199D10E271
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:03:03 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-5ffe16290e2so823607137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 01:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773648182; cv=none;
 d=google.com; s=arc-20240605;
 b=RYL1uCRPtkU+2p870H/bWhkqEMv16fzfQbYGtjO5VRzTwQkwud7swR+Jn6cIxHzqD5
 upqksgbX2pa+w1gmbHutzKZe/iWRKf7F2W/I1/0lrxECMQjayz/jBfI+G7EssWv2mzLh
 +Xd58gU/svSPMY8zHMX6ZIlYn6ZnmZvebs2jYUnT5pocbS5cbPMnp6aDrtLHzFNan3ni
 arswraGjD7w26oG6K1swlVmy4DMZX8LRsTaW8HRflWWKY6eZLhvgbEkXiiuLBVSWjovt
 tFhx9pNBiPWa6c+ZVERqwv5GDy1VQeN+/Da868ttgQHnTfQTSp1xdmfZPs6j/90Y0T/W
 Oh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eRbmuWlGmZzWgA7efRphnlq71lwFWNCcHXTYn6AgAy4=;
 fh=bStgdRFaBgDkdoc1GdEV6Pp6pRLjla/AK9k0y5C9p+A=;
 b=dmrly6QxWYFoAbLeGpnUK5IDP+XKpw/e1jubarwPKGAr+8v8Qg/g6kanDPCE+ks1Ne
 V6gbCoOWpaXzjjjjTByMp1sSgiY/VhFoYDf0IDA5q+2vZQntXJ1AMDGCDkJOdJtbvN4u
 YzMY5wqK7ucXrAIpUmimUz1k8zOMxkkVgDjbRRBCRUzYKrZkb5LJ9dJb0MINuMKFGhBs
 /xBHWemM/hOfjEDnNS+cHo3NJfzx/QeqtgvO+KIEGI41VHPeOnviuMcIjWoCqp+J1n/S
 KznvfwPfWCUM7oibvjfqlQDBwn9arVw40X52GJHG2M34ONLpq/f2zZuBbWiYECk7JGK0
 2QxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773648182; x=1774252982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRbmuWlGmZzWgA7efRphnlq71lwFWNCcHXTYn6AgAy4=;
 b=WCzmVbMB2VZW2mRprs/EJQn8EUpCT24y+Nj770EBlIe0+astq26bqs0rQkTUrJVa+G
 t7dsvn2cKboVb+4kaqVNM3kHegtVq1zclCJc9EfNPeSBFj6qJFIZ1QxeYJYDUlZJdFbi
 UNsx58KmWiuTE+m5VjtOWUqCnpwWKPU7iCOcAnJR8n319SAUBSm4NvelftwK1cDUK8Dv
 54w2CPtYgi57cku2ZKu6g56adb5slU41EmW4WtIiHWcPIxYBprAXolrNOH4SEPdOdMHM
 HRr1wc3oS9xmxyu+TkcRGE7tWLF9qWD1KOd2W4/fGlCbxh1IWWgIkGyF2Uzn8E+MhPK/
 qUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773648182; x=1774252982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eRbmuWlGmZzWgA7efRphnlq71lwFWNCcHXTYn6AgAy4=;
 b=E0pxKL1CkoKnsynH3WOQTnc1DlEgsWxRMD2ACFo3hAwV35We2qoGxG5flNsnQ/XLXq
 15vJfzt9yQGQ1dRuXu7S0QRKMvfs6x7Q6d7HtOy2QdHUfmOX7q1MaZ8BzE/cHkIFFl6A
 YixDK2Fwv7rqM+PuB1aDU9ZUsavGpuDpe54SEmg/+CfY59bKgsoBaBlakRZNJQ/nccKK
 2QBXClWqaBWZPTTbj7qsym9zVv3TAlYZcO63cDy6InxRdFcjzlX7jGSQ8hb/w0lV6dLD
 bgnvOHQu+05IoVMSk9TlvMBZiio89s4rP+//Etn92cknXKWPaz4HHtL+01HYskRGINdp
 hG6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaehEIzsuwruPagS7xLqw1GADelYvHf53wkpf3d7w64MVCCaVHKi4Q+1XxmJr+YP3M3E1Ar6A8ucM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZ29AG99AvftN5bysNp3OlGm6cPS7aj9vQarb+GnmCNb53bT5H
 1oKByA1foQ8Lk3XmjunbsToko8XoieMb1jIVUklqX/jL9z3BnVg9FFFHKhiOblOlxL7G8jfCCOA
 Mt0x9dTkbrjY4YarbeoXrlLgiEvBvDOM=
X-Gm-Gg: ATEYQzyZwUgarzHXialjFCopOPdXEF1W+VJbF33vEGIQ0DBsJgGX3SYf40BJpm75Bxv
 CbQ06KFqFGaJS5AtZwbWcU1oAuOyRmEa8fdbpKVKML0HxkA0Izj/WfmUBGoZ9EPzauO+eP5u4P6
 Eb5SbYF7niBm4BN2hD9Lmilp8KarTGHdqRisg0zDNWNsvf3WVPqumQcbsJDEmFHoJJ194Uexnzo
 VTfQjzeaM5dKtaieTI/ecKpCTBplj5uyHEY5SGp+CXjqteQCJ3ihcrCpkoNA9JrEg7ILTUbwg3z
 D81eCFOU
X-Received: by 2002:a05:6102:e07:b0:5f8:e47d:165 with SMTP id
 ada2fe7eead31-6020e20d416mr3737253137.8.1773648181650; Mon, 16 Mar 2026
 01:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260315144536.515032-1-mitltlatltl@gmail.com>
 <20260315144536.515032-2-mitltlatltl@gmail.com>
 <20260316-demonic-delicate-manul-8ffb80@quoll>
In-Reply-To: <20260316-demonic-delicate-manul-8ffb80@quoll>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Mon, 16 Mar 2026 16:02:36 +0800
X-Gm-Features: AaiRm50gdkcfTDnMCdX8yuJBSODCuTTuvjktTUMybni_sKPxSjfZqKKen2r8Ekg
Message-ID: <CAH2e8h4US7Ut=u3AW6bra9kUhCo15k+sWmVw40adVE-JQ+ayVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add Himax HX83121A
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

On Mon, Mar 16, 2026 at 3:44=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Sun, Mar 15, 2026 at 10:45:35PM +0800, Pengyu Luo wrote:
> > HX83121A is a driver IC used to drive MIPI-DSI panels. It is found
> > in HUAWEI Matebook E Go series (Gaokun2/3) with BOE or CSOT panels.
> >
> > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > ---
> > v3:
> > - remove '|' from description (Krzysztof)
> > - drop description for reset-gpios (Krzysztof)
>
> And all other changes?
>
> Why aren't you testing this code?
>
> NAK, drop the tag and request re-review.
>

I see. I will send a new version later. I made changes to v1 binding by mis=
take.

Best wishes,
Pengyu
