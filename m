Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05C1F013CA
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1551A10E4A0;
	Mon, 16 Mar 2026 08:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iepxQ2vh";
	dkim-atps=neutral
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4694510E4AA
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:19:24 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-56b672c68dbso956976e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 01:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773649163; cv=none;
 d=google.com; s=arc-20240605;
 b=TArvrjF9k2+MnQ2Hr7iRY0XCkElTfP+SWrgj8zfR8E2ApQSR/ZD4vdcnd3p1E4GDGA
 V/nIQCVBRMb0w3VSWoDO7fgZ7uhlRtWi1wOnLtwdYOEgQbRQDjvPFxzFtzdlUAK731YX
 xzP6ueqRfgoqusGWmJXZtdSiKas8EY7XW1ulXuxdVUBh7sDx9m/jxFFWOvV6Nn+CLuk9
 PWCjH79goQ6zQr7ycYZ5MU5PWwA3ihRVvEqIR7vn8OcDloiDWdVje/c+9Mlv0otG3FJj
 rN9scNH4PMM4OqE5B/9BNvvrcHvEHQJh6UfgOFXpQIlvoNS1l6SIz1geQgPvQsftpiiA
 zmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z92d2h4C2EUu0ME+sfNVOt2211TfUL2AGc7b7GuFF7E=;
 fh=iKuPgeySls6pIx28rR266HID4CJtWMbaP15R00uYiGI=;
 b=drDOAoFR2SaievqKRjYTyigdJ+o0zHUviYJkdKpToZ3byJ5nzvZEUrlf1C8HTidXu5
 iuyV6mmNO3PiOHH8jmE6dzSO8wb8SttBFbJgSkgutrTnhX64VGWqpj9Now4zqJChwd5Y
 3gCa20KhmvhgULsfQr5dx/lddxQHFMPE75bm6nnRFqeVjYaY/OJfcjLYuB7+cdEKTO05
 NOH0vWaiGYAJbv8cm/Thn22zoUy9uLM2c23pKmEaFDiqw3cxW99AJ0XIy5Yty8JGoWSM
 ISfjBLxd88fhl8KI9lHEq2qKXZ8Rnz6KgKKp07aSit8nd2UdEnts68V7RslrmiYH8ked
 N7qA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773649163; x=1774253963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z92d2h4C2EUu0ME+sfNVOt2211TfUL2AGc7b7GuFF7E=;
 b=iepxQ2vhGJ6V65djZwCrc5mG5+kfC05cLihlGL5e/elyvdu07E89MRxZ8DPP7t85/F
 qbH/SrLTep+68jSA8b8C/b/mT0v88EthSisbOYdxWkt2iOwN2fIzGI0+CfIuWzUbuq9c
 sCxbbrAcXKducOitY9cdPYoxTmo54vpDY58iE13OFFhH2PIjmil7VREQDh2VrluR1C94
 65Tbw0nEIqaPzhwUgKFRhHeZb+SyjC8xCGTAfqK5QVGOweVlGKgulmzQu32EhkZaNYld
 vP1XRBxtBSG0zrXNjmspm7OVK4a90/c6e/89CKl8uQnVm78ghv6pP2C2W1RYLlHWbtoM
 7EAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773649163; x=1774253963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z92d2h4C2EUu0ME+sfNVOt2211TfUL2AGc7b7GuFF7E=;
 b=mnnmwLsJT2G2tRZQxUg7rK/h7lDrwXdP8bDL/40kxqBvqhZNZIfJdjZ0gg5+Juw5IJ
 R3fCNiDJEpRRUUAz4SS8ILxj51wj7+i9O9I3W6Gvrybm20bTevwEQ0MXKifgMn9d/TGT
 NZQW9Pn1h+Xufn5WswKjNWzPskSB5/Z70THQ/iIhux4RxKZ8Ub2DjAD8W4Ord6FxMViO
 KxMfbtVExib3k8+MuDAOmkuWiiaFWdwNjZySPv4voMaGnkoDCP5HvwoA4Xw41ryJv1pP
 pDcIaVGAM2znMLDrc0jyggUSZFDwKYHY4jmo+Bm5RYrwufYQWevL0I9mGP7lZaHSTSCi
 1OOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzbNmWbWiSmYlqMtq6AIlMN1SPE5CGPDZ6MEiFYSN4+4X31VRTiLbaf05ypqrzu5jFxQbHlJ9xz3k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGSNFcUinz92R5lv5si9LQMFPBHtM4kUl092mFOZeAnItCqfXs
 ksJ2GU4FwPl8cPFaAatgK8rMMz61/k40EFADWOp7nRZaim/Yjk0Q5Yc+NbFcZJwTaDrfjY0Kviz
 a5Hhs+e5GX4Sw3tnsQc2yb71aeQ7STZ0=
X-Gm-Gg: ATEYQzxwTPulFSAT0v72SmEttgWnU7zAXOAnahRpXeGjtK0bUnv1XKgZHKf5w2Ab3gG
 Sr4R5qlSBigrHKIQ7hNVgcgmWWEGj2twlcuP5Wp/gwdeoJMlToMgOaycZQVd/1ArkK/2bvCpRCZ
 OMjgnlaewvYzCS+eSQZLkJk24/LhyggVI/lu3hU4zwcLbpzn/g2HmDlKkQNvwjLjudkJHCtTusT
 2WUckRJt7gfIy0zxsSjSm3ZkrHyD3x9ZU+RMhb/PgfW0MymDxjCduszz9W7Jr5xDNws1bB5gYGb
 syJcDBvBF2sHXz0FTws=
X-Received: by 2002:a05:6102:38ce:b0:5ff:9ef0:9978 with SMTP id
 ada2fe7eead31-601f47313cdmr6960412137.6.1773649163216; Mon, 16 Mar 2026
 01:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260315144536.515032-1-mitltlatltl@gmail.com>
 <20260315144536.515032-2-mitltlatltl@gmail.com>
 <20260316-demonic-delicate-manul-8ffb80@quoll>
 <CAH2e8h4US7Ut=u3AW6bra9kUhCo15k+sWmVw40adVE-JQ+ayVg@mail.gmail.com>
 <6e00e9f3-0ff2-422d-b79f-fff8ebd47e58@kernel.org>
In-Reply-To: <6e00e9f3-0ff2-422d-b79f-fff8ebd47e58@kernel.org>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Mon, 16 Mar 2026 16:18:58 +0800
X-Gm-Features: AaiRm50gLbGdGr8rNok5-hrG0NMe2RJownVmEyvoHJPIbWUrNakdDWolpC5BLkU
Message-ID: <CAH2e8h7x-xFYCDNx3BL25wheYbz_CAwX_QiO_ETxNvzf44e-hw@mail.gmail.com>
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

On Mon, Mar 16, 2026 at 4:15=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 16/03/2026 09:02, Pengyu Luo wrote:
> > On Mon, Mar 16, 2026 at 3:44=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On Sun, Mar 15, 2026 at 10:45:35PM +0800, Pengyu Luo wrote:
> >>> HX83121A is a driver IC used to drive MIPI-DSI panels. It is found
> >>> in HUAWEI Matebook E Go series (Gaokun2/3) with BOE or CSOT panels.
> >>>
> >>> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.co=
m>
> >>> ---
> >>> v3:
> >>> - remove '|' from description (Krzysztof)
> >>> - drop description for reset-gpios (Krzysztof)
> >>
> >> And all other changes?
> >>
> >> Why aren't you testing this code?
> >>
> >> NAK, drop the tag and request re-review.
> >>
> >
> > I see. I will send a new version later. I made changes to v1 binding by=
 mistake.
>
> And EVERY patch you sent must be build tested, which would tell you that
> you made mistakes. Why do you think build testing your code is our task?
>

Thanks for your suggestion. I will remember that. I thought removing
the descriptions would not break things since I tested the binding in
v2, until I found I was using the wrong base.

Best wishes,
Pengyu
