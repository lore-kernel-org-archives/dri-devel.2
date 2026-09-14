Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6562AC88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72AC10F785;
	Mon, 14 Sep 2026 23:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="FQ9DgPPz";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7297610F784
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 23:24:48 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cda5e048fso9415e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789428287; cv=none;
 d=google.com; s=arc-20260327;
 b=BC0FOkXgvsLjTzm/beXUw9Kvx+4liO5MFeF4pL9fOVRaUrw43IHeZHVfnJvcFE08mG
 sRlxN5C4bA5VuFR+HtYjFIQimP67NHpaxvk95xlmcB8Q4eOw7Thx6R5bdDpN8EG7Bebx
 2uYpa6e/bJfGXq2UdOmKTEAKLtuV8qp6QzKu1weArUXaRLQg+oVRhJujp+zKHq2wAvI5
 /VR6hYeB5rjzNCIEOxg/3z2ZoRv6z2P4hnWxGNIdg9cXx+5bAI3kVtUm7Gh12MxMY/hS
 41CnXmcdtoA61veVx5G+r/SUiNKCK09Nk0g9eDhjl/3IPDIGxI8X9IXR9mRcZzo72M2A
 rtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ADTcopVlADt5HZgdX2+W3mZxGsC6Nw/f4SA2C2AyzNY=;
 fh=XcDSrXM5OKX1sCJ3IEvJAuKAhycwAPM5Ucx64Wdm3FA=;
 b=j0dnnBy+sTboR8awn64mqr0w3Anl8DlVLecQRXYuEYN4liNf5677o/aR+FXPRqrI6/
 Plsd00sYCfu+EvZ4o/6eK5223HymJciRC4+rsh0gemSIZaj4SC3ZuOiYbI1dBFS9ylYN
 UlojWEypc5wXgS9z5oFTRRYC89T+BauWR9MCE0gOMqVUJgrydVHEKFmHgnI8Dayii7GQ
 w9TfhajmXCfVvvyA5uFsY5gaFxJfOFYSLEAhzKmuPyMraUmypyTJwbME6Un/JR9h8csn
 jsqcKfKv4Xc4irdRcsufBzHfSsAgL79PxQQTOiGJstm9OWJqxIL+J0Q+8QKAabJjVy7E
 Nnig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789428287; x=1790033087;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ADTcopVlADt5HZgdX2+W3mZxGsC6Nw/f4SA2C2AyzNY=;
 b=FQ9DgPPzIHAWr22ckJoHAlAsnKMAd5Ya8HJ3ymhMcy5xel8C1v5pcwueoC4GYLAdA1
 XZY0w295TxXQXNPRQHix8DaXFGEtpwZPs+35nljQH50zfbaPWiWJVDeMH4SaKtge18YW
 TCSxVV0qt+dcKVh+igMAGNTt8lzAnGnDLYj876auqW+9nU1gua/MJ7z18xdqs0eeNOci
 bihSIDHcKFLQOXI9Wvr36uTDzmzkAiZs7vSLXycluHT5k6EIN+Q2Mb41Fxub1l0xo5/i
 s6xNT7mf/TiACh8gg6hPevIcvyTlIwJPBIqY7ugqnrqpjoLkYRq4t74Y4QLETAPEiQ3H
 GNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789428287; x=1790033087;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ADTcopVlADt5HZgdX2+W3mZxGsC6Nw/f4SA2C2AyzNY=;
 b=I8P5iE4b7YLuekhSluAObwVGz5ONRhnGogH0M50pVmZeAlMCebf9+tCjKY46yXdMtp
 RzNNzxthf2TEXFp8qg+M8e0NzovjqP5vuKuDdC746VrQJ+soyOooXwtyrqqdgfQEy7MV
 L7O/F+jtw+pBx7WO0zxzFoh1l8qPsBJV8PUmIo4U4WGfxMlYdQmBmWAryddQnuQCjaHG
 g/ECrlNKTPXWthIxS6/ffqPbPUEeKNbptbrujGYHVa4AwRVyj4MC/87c33J0dI6EjRbt
 muGCQq+KnQygiyhhGqeHLWCts7xAA+mxp6/hClyrp2PYDPR+kky0NCS3jiC31BjjY5N6
 ysYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVIOdqTOjzny73HU6ywkyhrj2jil/nCKDFFGk65LEdow5puriLwCmVjpJbutK9IgPX9eJwIDSD2IE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mqWpvMS5Niv1u8/HmeiUs3EztYmNnXOJpVVQI0VkP+0WXQ0DYa
 KTxqNKjNEeZv16CslNORuFR/isavJRCiZVe7ZNxK1BJrlgefUc+ERJQhD31zfPIaGw1E3V3aaV+
 T8dQ31yr0JghKeX0NwISQOyPDKaz1YY1NpERz/AkD
X-Gm-Gg: AYBFou1iYVK4mVaNl0lSifAftxIpe9L2oiq/EqifKf9jw/bjjQnnyTbS4EKPW8RL+G1
 OrBThjQdQVVeruZBnRd5+mFk36ACINLMYyFloeBbgzGaRjCSWjaNb0/XugQlOqRO/uexzUQDiXz
 6jmLqS27y8hCdU58z94rDG03XHASh5VupWdAyepmCfxx0axfmsUUhEzbt2p1k7TuOh6+hxRi1tQ
 QdpZxA8nt+k3PG6sYoNn1b52YDBlpc9k/GFGe8oJSmwApw5xSi0p29GDxyHCXTAgw16j+C2xTyM
 avke/yUJMOWD5TCQu5co1rjS6zgw8ya6H8Sxh7AomK7EqiSig/uVqa6+3ygNLEdXj7bjcCkOKZo
 BgIXawyEhZ40=
X-Received: by 2002:a05:600c:e557:20b0:49e:65c4:5539 with SMTP id
 5b1f17b1804b1-49e7dc07e43mr198835e9.6.1789428286617; Mon, 14 Sep 2026
 16:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-4-dave@stgolabs.net>
In-Reply-To: <20260914212258.2657788-4-dave@stgolabs.net>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 14 Sep 2026 16:24:33 -0700
X-Gm-Features: AcwNN1XvdVkxpYJKs11G2gw4pWvKxZyOLnux19FqWp7h1UxId6mm21NmbJI9MZk
Message-ID: <CABdmKX36Nc+3BV7e+m0eOu5CvobtO5iL40MbfWXxA_eJ4zmWzQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dma-buf: validate the attachment before asserting its
 reservation lock
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
 benjamin.gaignard@collabora.com, jstultz@google.com, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Mon, Sep 14, 2026 at 2:23=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> dma_buf_phys_vec_to_sgt() asserts the reservation lock before its
> NULL checks run. Validate first, then assert.
>
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping=
 routine")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
