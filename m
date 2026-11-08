Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD1606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 03:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eC6fUk/e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F9410E04C;
	Sun,  8 Nov 2026 03:35:20 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D822310E04C
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 03:35:13 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c4d21051042so18243466b.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 19:35:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794108912; cv=none;
 d=google.com; s=arc-20260327;
 b=ilce7uhT1SCVNKPv0AuY7PwqXHXWccFmsbzT4iXtoFR16RwopEJHDAs1SVHLnpP0Re
 oSbtlzTjrvFeIe5EodbiaNDoYhPFdH9IudhoiW5nqP0w8spkCvVDnFynHGadavsXRlvu
 h5R79pOjlt3keXd7k12DlK4gj7gY89zD5BDiJnQSCaXXdNidhSYHnxhVDT0PXMR/YWjp
 rsBaixnFxkhiQ4PZYJ5nAJUnvQHA3wAV04d7rlH/aUUDwwQOstRuE7+Hy1U1uOtr/MoN
 ho/MRQTkFiZI3oV4eDkjYqXsaswktXZHwKyjI44FZNIVaQaaedxJ4nCIfVkgu4dSyYC7
 wgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wN9G1HUXB4IDEVwSoyfIfIAzUo2IecRbIc0wl2PxRVw=;
 fh=Zxvqd2FqT4mv14um2loPp2nXSWTNcECwNty1Vmod62U=;
 b=sVBY9uK1yPwmtL7/YLEw0vKD5jl9QTquP6O03vTINDAgf1oZx2K0RDI7/iwDzK0FGQ
 p9T9JFLmh7AlI0WHejWeLQQvH0r65GJvCrL64WxKbAj/YaEU8JFsdsuOshaTniuhgWvi
 CA+RuNi2vzSg6d2BguiENg7ZYGXRSQQbK9yx241COTZ3AsQeCOaBMT8HNhZOroNvzIjW
 E1fSr2S461V7ZKfY3AkZre02vCYS6JTbTpe9q1Af41aZPyjPXKSpQ8hoOGu94kyqOK5W
 EETuXQ/M2nvx8E8V/2zZ2IelXHpeiE63R01/0zIjPguYRreFk+nEUDRW1fnmFBPhYO8d
 6uSA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794108912; x=1794713712; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wN9G1HUXB4IDEVwSoyfIfIAzUo2IecRbIc0wl2PxRVw=;
 b=eC6fUk/ee9g62HuloFmI4bf3uJ8FKu9FwCfsHKm6xm1XrwfPHfTRXqJFsnb3U4Hzdm
 Ni0GeAhKDCfCCHcpfUqvWoBV5y27uDk0TqxaPJf2qnFQRJfE9BUpfs+zAnDJGnwpkddT
 0dN46YjgwzYi8NSknAmKQ2MW421UtLvcEM7R/WWNdEJYHcc4ypDZf4ItuID4GQn6W1mU
 NKTtttx+ELHtbhfkpGEOBVF8/yKU4nv5RswyQFd6+G5fRZLw0xEKoD04D3vI1FUbEyKO
 vTgGx/UVdiGgARp1UXgiqG0U2uRdv6a/kur9tSscsqG1a9avH7oZdh0ISRPR2AJgwO0e
 z5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794108912; x=1794713712;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wN9G1HUXB4IDEVwSoyfIfIAzUo2IecRbIc0wl2PxRVw=;
 b=SXD3a/a1G91qOtiZvb0KGDxT5u0UnitkUGDTpl6M5jZAYU0UxJgpBEdG29gf23sW7V
 5T+3jaqODw7ZTG/pMqw4mKG+RoFOXmwJxWHpgWtQV9tpEIAaQyOWP6b+luwhgsuMfeks
 jxbX19JMSVYXIegmnyPLuYV+SBtdx2fZ0cT/pHdzIoU5p4JTgExM3icNZ/03Uokp8A7Z
 ToU7unsyangUqw6vTeZx5Tt9k4p8rJKRRe8p4nJy0kz4PeIN3I9n7jgJgGLRqRylW/HU
 Wg+zryG4ikDy6c98lrxWBI+eXZUBuqAK4InwA17EX+ddM4hfOqPGoEZIOIA3gK7eORNT
 RZrg==
X-Gm-Message-State: APuU4Z/+aTbPw7DOocGnAh2HnePDWA/Mc0cbDNc8j7fYAMulZw9g4u5W
 y9kUlIn2UsX3NJ0uoyCvNGnyal40lPa0vSLUCFD5qUae1m/2vc6IcJmjNVtHfM5P1xK3AVuA08n
 biT2grBACjCO+MnivTnnNur677lWNbq4=
X-Gm-Gg: AYBFou0NTi2SGyFylvn8IkNfzhQg/CcJJ35kMKlKmxYLxRe0O+X28TbnEX4fgmMtBdr
 OvGjSDlUDgN6E93a0dN57LeCpBNEfJRK0NX8pYtCUH5YbcfWTD3pNi7WPCliGZFe5m3YQwOGDEh
 dUZmf8K2eBtgt+zaoGzp+18Cw4GfJydNaTvRLceIwBBiIAZczd0E53Cv0RP7wAjNiEkDAGVsZoz
 e28hrriS6F3IKjjqLbmRYldCYqu7KbgXfop/srmpytINgKzg8WOhVKf6bAMGePkeHX5PgUHH4K5
 qk4ALWd0RqAhic6LwR9d/vYJDTe+8RmjwrAqk4sJgz+8k//1KRAoGugEOzX0DiMlqOs9i6J4Ey+
 osfWItHa7gbmgL9lBXioxtyngyJq+kdYNX9W500WB1uANrWX9Sq8UfGxKrrgbbFx9Badqg0HL
X-Received: by 2002:a17:907:72c8:b0:c40:9b75:84af with SMTP id
 a640c23a62f3a-c4d6d35bdc4mr36997166b.8.1794108911965; Sat, 07 Nov 2026
 19:35:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
 <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
 <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
In-Reply-To: <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
From: "Operating System's Depression" <operatingsystemsdepression@gmail.com>
Date: Sun, 8 Nov 2026 00:35:00 -0300
X-Gm-Features: AclHuK95iFE_fqGJ8Pb9pv4yFyto02VIbuAqmDQkAAltepg49f97TG_-Ln-iVbg
Message-ID: <CAFGNeajahc1Amwqg_hX43CfcJEq1E0xQK8Grv0sCukjT1TK0bA@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000062dbc4065fbb8843"
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

--00000000000062dbc4065fbb8843
Content-Type: text/plain; charset="UTF-8"

Also Patrik, about the KMS modernization you mentioned, I can help with
that too, I have GMA500 hardware available for testing, and I might be able
to send patches for that as well

Btw, I'm also working on 3D support for the SGX544MP2 used in Intel Atom
Clover Trail+ devices. Since it's a different platform from Poulsbo, would
a separate DRM driver make more sense, or could some of the gma500
infrastructure be reused?

I think a separate DRM driver might be the better option, probably

--00000000000062dbc4065fbb8843
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p>Also Patrik, about the KMS modernization you mentioned=
, I can help with that too, I have GMA500 hardware available for testing, a=
nd I might be able to send patches for that as well</p>
<p>Btw, I&#39;m also working on 3D support for the SGX544MP2 used in Intel =
Atom Clover Trail+ devices. Since it&#39;s a different platform from Poulsb=
o, would a separate DRM driver make more sense, or could some of the gma500=
 infrastructure be reused?</p>
<p>I think a separate DRM driver might be the better option, probably=C2=A0=
=C2=A0</p>
<p><br></p></div>

--00000000000062dbc4065fbb8843--
