Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34ABC55162
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 05:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07A310E204;
	Mon,  3 Aug 2026 05:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g9UvhvGG";
	dkim-atps=neutral
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94AC410E204
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 05:28:25 +0000 (UTC)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-6688acd1a51so4304481d50.3
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 22:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785734904; cv=none;
 d=google.com; s=arc-20260327;
 b=Czt07Lyu+u+pZIsT6qb46avnvSGOBY3V2wHl+9nPfBRR7Pe+r+OPdhGT+BE+xkp63d
 rkjGvNgTOTCc3kXnLJ+UNhalhe8OxSFbpizogXe4Gz27JGyW27mohOdYOtKN0z7emYld
 Egpd77Qy1l9LrAbSKubXsyWeivdh1+LiXpFbF1SIt5Kq6R0CocLNqZPVjmU4C73wu6nh
 35Yva2mHS1cblQ3U1+pXlENzuKTLDMJn9MbJooMhET4TfE6Ps37uFmCOSbOZZLhrpq7+
 RbvtHaNuy38dhV9ac0Fblg0QXe9DvaL77NwJIdS3D4bJ3HwhCReJfU7Xvc4i0OpHc0lq
 Cgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K50g3LVe2JIlyne/f7MYa/IcLR6llYiCcw8Ef17gXBk=;
 fh=44j9ZpdrkV0kfM26AhMk/b59X8/b4egUJVtBOHthJ5I=;
 b=OKKhKTwLrsSfAKCg1+eCPePDZqWNICMf4iihkUO1NOIqQoByx8uAJhGy70jkXYpdnE
 JTO0e0Wt+tga0m7CmfQkpPHyIy8d1tzbjIIlgfc13uLkHt2ZG0/JCEk8BfS/hBhLMhcP
 5sBnl6f7klV8J58z3HQWmLO7UglkOp+c8TQmm8f0WgtyNr3KkWeT1zWntSQ6cvuMCPwA
 lJ93I+gDBB4eaGy59W3TeAPz/cqpa+Fo5+E7mPoAikO69UViKoayIMC5NprxKMrESatK
 MMf4ut8shjP9dvcpIhc+CQeg38ONucxdark0dlzgZqHUNk2GMYVa/BAZFOVx7iWCvQ+f
 c3RQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785734904; x=1786339704; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K50g3LVe2JIlyne/f7MYa/IcLR6llYiCcw8Ef17gXBk=;
 b=g9UvhvGGkvRKXBbQ7eYPeMZAEjc3jnHcgh4gbtkgNsNvsAS4K2J/MkffQVBk/VabsY
 0wGPzMNVAq/VjdC+JL4jFqFp6+dGOZUs133DBj+ZAERB8XS3VfXzdTLS9MKt/GsMAj1g
 Ugkn38qbwR8+kxWltXD7lb05cC/J5awY8s0tZBjlhZkMdWdmc8uX/sAriI3kM4e6lWqF
 8DYcaE12AFXvFUy/U2w5huuVIlEI4FL4YZqZ4azx0kPawaufyCTJuLKqJDKtA22LgqDm
 TcQoiiMb/3dCJZlwvXUg5OFINm2nCYhj3IN0rmdZe+NT6K0+sG4jfpMoIHFvQyMFsjZT
 55UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785734904; x=1786339704;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K50g3LVe2JIlyne/f7MYa/IcLR6llYiCcw8Ef17gXBk=;
 b=hFJ7Yy1jJ+xZowY5q0LOFKIRjwi1kP5Idt0UsD8oCHnBCmJ96XfibC8865hlq5DG1X
 r+dMg/IvNOaIG/Tf6Bip363AFmADFFvSl45QBFyDTqN3Dn3PvQgg09eIfE7z6NHKrvxI
 7Je6KqCTOyvJvVQLdpw5tE4vXPMFtdNHwDYb5ofi4dvdZM8H5fVucxeTVDROUZbSU9Yo
 Rs/9RB8CTMFk7kWyUZNZskH+YR7GjQFoUbtJcwKUr+TJyIJgYBSi+p7+ScmR9M0hV71L
 Cb+57bUp1CpDVY+XnTJsy+UO4Y3DYrJu3FJ8+qcPLO5qoBeYPp+0PdZOdMssgBhOX1oG
 vrxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEqzrjlU5+/Ywfl2HotwKPOA2W/Pu1b8DYAGohk4JKeLCu8fIk/ePtGIACjUmCDbA8FNm3blEyUwc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4SOvYfo/r7n+90eBDRZVzm4k3et5Zs6xKkS9mj/rsqULdEUGg
 AkCIXkRaiPIE6FegnN2yYyPuE+1ZG4m/yctS9y0YZ4RRu4Kyzv/4OWaQY8SCn1ZP9QyIHw/epGQ
 4PeOlAFmr/ULfn+3MiCyaIwBoytcspQA=
X-Gm-Gg: AR+sD13M6AmF1hU/GcFDVTEB0/m64rlk/6MeGoNhv9PGOcPvKBCI/h/3yJ9uzwYPQlG
 Z97VUU9n70GdG5rsz6RJUZzKM+k0gZvsroEvCNZZ25zXArXOmWCpPuhQyTvI+zSSF+uDq3o78IZ
 n+EwVny8gH91WrhlZfrOM7RHM7pM70J7cuWIRaBqTuyhS1YO53jz/xl3GXcZrqBbPlSiesOCXjX
 cQpPXdYawhLzkv45LjwY09szCBJ/RUNUzRaThB4xB4+SVX+Da4R0cyQLhCr2NXIdC6llyHgZ5Qz
 ls5EPC7moBo0Sv4i5P2+ONsCGaQnxOloY9cm8dC588V/2PnxxxTeMQykIWn0AHWM8EDmLu9bDSy
 27JIWz8mWzsz6jNsqgOt3ZRAQikVpcw==
X-Received: by 2002:a05:690c:6701:b0:7ff:1a93:be35 with SMTP id
 00721157ae682-81fd4a6f84emr111918477b3.16.1785734904411; Sun, 02 Aug 2026
 22:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260730204604.1729505-1-lyude@redhat.com>
 <20260730204604.1729505-4-lyude@redhat.com>
 <20260730205633.9AF051F000E9@smtp.kernel.org>
In-Reply-To: <20260730205633.9AF051F000E9@smtp.kernel.org>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 3 Aug 2026 15:28:12 +1000
X-Gm-Features: AUfX_myCuk4f-IKfNaeeSw-seOnjdRXgmvV5zKiXoeio5KdDQO4TXcGu_APjeoI
Message-ID: <CAPM=9tzFg34jBT7-YYncOoYfvpvXvGnymuYeR6pQ2bQ4qeV4=g@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] drm/nouveau: Fix drm_driver struct/nouveau.atomic
 parameter handling
To: sashiko-reviews@lists.linux.dev
Cc: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 31 Jul 2026 at 07:13, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Critical] Embedding `drm_driver` inside `nouveau_drm` causes a Use-After-Free of `dev->driver` in the DRM core when the device is unbound or hot-unplugged while userspace holds an open file descriptor.

I'm going to agree with sashiko here. We don't want to embed it.

Just create two copies of the struct, one with atomic and one without,
or use some macros to do that, because anything else is just going to
have messy lifetimes.

I think you could also move the atomic flag handling earlier.

Dave.
