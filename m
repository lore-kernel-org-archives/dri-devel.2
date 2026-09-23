Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED22C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4BB10E7D0;
	Wed, 23 Sep 2026 08:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="V+Jrp8DY";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D4010E7D0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:11:17 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c3ea1f6so411707f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790151076; cv=none;
 d=google.com; s=arc-20260327;
 b=PE12hKpUhOXlJmzG7w3GQQ44VARwsIdOjRTV0Z0lNbxuiW3ohIlC5czRpjV2JUwBqZ
 gp33boM2UP/VPrZmiDkaq/I0YtsGG16U5uZtH6GqcZ+Rh49O2ygEgslAJXKnfmzkdBXj
 FMa3QGRu6Hj328uihvzgRn93hHZ4/y55EstPoFN+mPSbQ6qixFR/9kkhY+JFv112sVQ3
 s6JaKXoRyKF5HHnoXvf0pmaBgrJF9yhXHlrzKdKdvw+uk/8ERs8h1VtmFV+6pQUoGW6W
 euY78Z8II3hEZrK5wjP2fdA4V60QDShR+tggYI+0ojXcwNHHl2cETqc3O9i87tYlfMUw
 OO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EdibQdRi79AEUk8N9XrOaQNDDtETqxgqjr2V4CzPR1g=;
 fh=DVWd38MMwUOUR752aFpGGgla8z6MHHPAWx3vhlFFYxY=;
 b=Gm6i5p4Ss7Cfibz6T2CG2Ccd7PMR7e7MCn/4fR24X09USbQ84tZRF3tLAO2CA5mJma
 OGkuBSKZGu3yny0FHheCm5U84o0dj+uttfo6D3nFCO3iz5jKCR2uhNisJt2bOXeFiVta
 SSaUNHRb/rpK2TvMPQEJrOhvorbwK7LYcQPOTOmhnhFjJAkQwbX3yoP1l+8eEu9Z0pGR
 9B8B4fzScliEO18lB7+S0qGxrqMPJBcEu25gOV4anSYrnCorLUz4hVCGC5QrM2+FSPR4
 IxY7JMss8JRXJfZ1alg4F3GuWMSIxQkbnKjPAl9l98F4BdM7SuDrIAjugO5E2ioTjNmM
 RZVw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790151076; x=1790755876;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EdibQdRi79AEUk8N9XrOaQNDDtETqxgqjr2V4CzPR1g=;
 b=V+Jrp8DYxOXJ/SsBYTcEGDvsWJd4S5NOI/2NOZlYID13iTOlr2Kh8D4vKSFsoxsvFS
 QEyICzASCVz3GX3bf19PoXrk0s6S3Pbf8ilx7IcYERXzIribBCBU4187FF7eUC0JGRMg
 ViFCyRvuRR7UjDZQnLCv/hAAh68vidrPNG79tG5TGK5LNVvjpnyJvSv+ip5pjiDcHh/Q
 5QZiavywCGhZSJmDbeSpq3DCqhzw/VvEQoS70J2mUiYYo711mJ+d6ckKSo2AHNZNVtBh
 xvedfw3w2fIYCjRV5AiMuvQutN774KsF3xGT1dZBkruylscH3DH2JbbyvTTVkgYPsrAp
 wwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790151076; x=1790755876;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EdibQdRi79AEUk8N9XrOaQNDDtETqxgqjr2V4CzPR1g=;
 b=eVczI9p2YFypHm5aPcpNfbR7WPijoG3ulSzU3kcPplI6MiHRv28aDzBNdX/Nt/haby
 KaakuoFAKiJDcApBoHWoOcRMykgbE4A6V+pkFrw3/9sL9692lXtv/masP2LOL0lGUpex
 YmuQ/Ua1E/StwkSQ+J9bIbo1F4maxSB+r0TQmzO3EcpvpL2x1L3C6ky7iOJCmhKQdIDO
 0TlMBSTbWqMHJcJzbNoej8rrABrR6/XbjaboVIH9BVLFOt4Nm3BEmfC0tRqZGCh+RLXY
 tdqfvLF23pgIndpJZgpRzU2J+sZiEaggzm2nj5weoJyxp/xYtQ0+UppkVRNZ/sRJvp4F
 fHUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2e3/j0VNFP/YvbJ1mdV2mXfTAamKLkaCctnJ4s6DwLMILJ8/2xl9eKLuabrlePgNUx7CTGVLi/2A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgN1GrjR62WHi3LUlOuWPFkWiWgWtA180qQXZIz7ahmgnkWVOV
 DXZIiwumW8LSS89gW62LQV260tEp7/EHE/sAZcQB7MuUSSb6dI9Acf7gHHrzvO9TZC9cHId5ys1
 yTPUmfYpDoYbnfuFJD1/4Eg8S9Zr2CAUw9Gyn6hE5
X-Gm-Gg: AYBFou0vFWkYImffSJyhVtH1FoolV1Jmfr/c0KHTNHvyWahfFTk6xNCNyCKxOMdX73Y
 MLHklr0qYxNgjSox6bKUwJbLw/sy0YJ2B0n1+skmAszY0H3iSQ5DwREld9qe7nsbOdBfwrZhbkA
 ucGbOe0vSZeTQILzHGOytyw0zbHMf8305xhjlIGZpkbiRt/5s2jWrxUwWSMCZrB8UMeIhkAQcv/
 ETRa9XHYMcdr4MLrxnsKIrxgbpJADU4CdO9SlO/q6MxggBRcP0z/VRZYL0+KkJkwBMV1zGVG7dX
 hI5PTgSXjYAb5ZSX9jQyJKAeshlodfBoeCqMm7AkZi41hD7m9PuoJZKrWwpAhI4tJ1nd6g2k58d
 Z7TYVJOWij/0s+xmReBTb
X-Received: by 2002:a05:6000:2681:b0:486:f767:8be0 with SMTP id
 ffacd0b85a97d-48867086ab7mr2788619f8f.12.1790151075171; Wed, 23 Sep 2026
 01:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260910-b4-doorbell-v1-1-f3ca2f501600@collabora.com>
In-Reply-To: <20260910-b4-doorbell-v1-1-f3ca2f501600@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 23 Sep 2026 10:11:03 +0200
X-Gm-Features: AclHuK-cN3Y_6juBtWNq28GEXbcnGNxIQ1BXWgEb1aIXGrQ22BX1Va4FD9IYMnQ
Message-ID: <CAH5fLgi6iQcTNOyZdpdB=d-AzniTPg5Z7uCgW2y3DQBQ8XxUxA@mail.gmail.com>
Subject: Re: [PATCH] drm/tyr: reduce size of doorbell array
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 gary@garyguo.net, boris.brezillon@collabora.com, laura.nao@collabora.com
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

On Fri, Sep 11, 2026 at 1:02=E2=80=AFAM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> Currently the number of doorbells is set to 64 which is an architectural
> maximum for the Mali GPU major v10 supported by Tyr. Since each doorbell
> needs a 64 KiB page, the doorbell array alone would need 4 MiB of registe=
r
> memory. Since the doorbell array starts at offset 0x80000, its exclusive
> end would be 0x480000, but the rk3588 device that Tyr is compatible with
> only provides a 2 MiB iomem region in total.
>
> Reduce the number of doorbells so that they fit into the rk3588 iomem
> region. This is consistent with Panthor=E2=80=99s doorbell id assignment.
> Doorbell 0 is the global doorbell. Panthor assigns the remaining doorbell=
s
> to the active command stream group (CSG) slots. The number of slots is
> capped at 16 (MAX_CSG_PRIO + 1). Therefore Panthor uses a maximum of 17
> doorbells. The 17 doorbell pages span 0x110000 bytes. Since the doorbell
> array starts at offset 0x80000 its exclusive end is 0x190000 and so fits
> within the 2 MiB register region.
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Merged into drm-rust-next. Thanks!
