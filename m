Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A647606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJKquw9e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AB110F03A;
	Mon,  9 Nov 2026 06:26:40 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915C410F03A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:26:34 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6b4f7d3cd98so591430a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 22:26:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794205593; cv=none;
 d=google.com; s=arc-20260327;
 b=Kn5z7TLJuh7L/8fKUxQKJg1qv6PxdiVmQe7fStjWrrBixR4a3qCLGlwCuymVM7o5yJ
 NiO4J9X/xPk+rEK2alLezMdMQRDxPmeEniHwIC504enIFBBgDjcM94QHcosWqe4GXfZa
 gFv+CWJepBorq/Rg/RkNC1Xo8Cpq1UWzzoEcFMpEU9/1nKJaF3UCm8GgRUbB72Zoo+G+
 XTtQh0/hL9dAmevqn4pd7EpRgwoS9VpytRFulx3qgnvdQVHkQMkkOvtSZhJoRksa0iHv
 Hb4CldOctBUdhInGsYiGc23dsjHO6IZNgYQGoZfB8FAKyEsb7RYIs+OSSNk53g3mZQFB
 npEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ykvFmB/P1Bmh81AzJEgrc4PNLOLEhcXrqmQ6oe5iqEU=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=JsIrf794MolylJEavJc3sZK7Zr5g6cCvif1zHXh//hNvslW+qgEpTauto62ui3QCsP
 Amc2yCEJRfhCA3yhXYvPHtbDsncna2tEcgsLmtNBrqySLie4muSQxf96cDvcqeZqMKx+
 fxpHsSUZUEXBJVaNMCAuJ5ErCNeEYsbYWgELOiodjUtZowOuKpa0ZRopzUwa034XUNRH
 8JS34nEIGLU1ihlkdZHprsYdldkSreWWgo684F3JmnZ8jcImVjjmev0bIPEITGy8/v7A
 UrfY4yUFSL8a8lvfJAF0+cgAEQhVGOmZgJlHqNUaJ9mKeUiBLuul0/H4KZP69XYSSr9k
 ry5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794205593; x=1794810393; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ykvFmB/P1Bmh81AzJEgrc4PNLOLEhcXrqmQ6oe5iqEU=;
 b=BJKquw9eSfh44/K6T3e0O35jkgYbi3z7b2CkzcYqz9zfM2cMBU7ZZADOJauLQL/jAG
 XrCfiZP6L2LyxPlg+PEuYo2/nYNwgEeFom0rzEtIpQZklCqPcVG+JWII/9sgN9wBPE61
 pR6oELAZcGyyBeMb9iPutll+Sra4J1+TvX1Fmk3Lugjxqz5M9AFUTpUAs45sNxVKwDAK
 /JWGRq4tqhn2ReTKgj3FOulnX9otReTv3GpypW4KchiLk90NzG4UutAZ8sOSGD3qXCSR
 nDjKnNHWBdmBcmJB07rCpjNNcoUOWGHchJJ+0F7bD9lxpdqR5gAlMq+Lm8V17Pu9k1L8
 5IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794205593; x=1794810393;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ykvFmB/P1Bmh81AzJEgrc4PNLOLEhcXrqmQ6oe5iqEU=;
 b=sqvOhxtHtXDP+ssfQ/9MO0xHnoiP4C9uEUNOSN0QOL0u/uIf37GCMAcMONmU7+fVBC
 QoK+a3rJ/1v6GQTdQnj1tDr+j/d+XIpA7KhPLGjnrY2EAAkFPiRDSJN3MTIgVmKBOABQ
 X45ldhZ14Zj0CNK/AiVx3PXGwMtwI94cJEEqie32spnTA2z4lS94mKl5iJX8b3Qf1V9A
 AyFGEAUrSP02sHrhW+JatC6Jk/t5kJf1/TC7ZxpqZZmqcAMUZ7jiTiMI/BZ82iAdcRKP
 +rLhtD5+cisn8YY6Ugm8Q2MK9OqwrRoga5MCTQu7JQtpJyYjZ2E4S0E1pOju2IEEeZzL
 FWWQ==
X-Gm-Message-State: APuU4Z9RJ5vCTFln9EQCN2w1U2eDE3RqeDOTIEzBJDQ4iliCbjq8XnYu
 Plbsb/5sqi8VFPpor/8W9PyhsKq4jYwdXfUbvvAMQJumh8tRggziDceG6o4LW5NyMsS7vIAK/Mb
 7QHrFOCS4caZNsaQaglaAcr6jIqV7Iro=
X-Gm-Gg: AYBFou1shTCq0d5wB7LiqvhbPmTYRg4lYSbD66tOpcNaNdqkMGPJVU9Ip0R66cX6paW
 xj0BztTbloCsxAkeegPOVLN6z5a67kivd01xfe75pbJla00pr3p7SWR1bGmK5/oQEDnPJkC3p3B
 werdJfpVGrgsCECFi5UAW19qiGqaZ/CVblfI8Awhe/0twGuo/spf1tyQ6pTGAQPL/xJ1JbkFRJq
 Ky7smGW1DVqbQSD4MqoSIqHXM1p9g95ymcbteFVYAcG1lgpSGX7ro0RoeqkAebyaVl8SD4OBDRL
 89EXBgLUOAvsvg06SjARIkolTCLi4Trcnhk6vrH83uBhywlZcdKbQo9nw9U6kVdaxF2vAPLkvvP
 chEDLf9rj7xMBD0ZJxp4MymdCVYFzC1ZTfAMCUMH4YcVnK+xSYK+C6AGjChQX8ik3ypRuedY=
X-Received: by 2002:a05:6402:4503:b0:6b4:583b:daf5 with SMTP id
 4fb4d7f45d1cf-6b7224a1137mr2026880a12.43.1794205592415; Sun, 08 Nov 2026
 22:26:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
 <20261109055451.17458-7-operatingsystemsdepression@gmail.com>
 <sashiko-outbox-204484@kernel.org>
In-Reply-To: <sashiko-outbox-204484@kernel.org>
From: "Operating System's Depression" <operatingsystemsdepression@gmail.com>
Date: Mon, 9 Nov 2026 03:26:21 -0300
X-Gm-Features: AclHuK8tjhK8AU9yR3CWjirSXyrFVPfP6XLJlrG9dLNVyWAL99hsopP0U0HDyK0
Message-ID: <CAFGNeaj1q=cwNn56Ye2CW5dDLVDCyYkbf2MWEtSFNnO6GtkXHw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] drm/gma500: Add software-only KUnit coverage for
 SGX page tables
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000fd70fc065fd20ad1"
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

--000000000000fd70fc065fd20ad1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

fixing,  sending v2 in =CB=9C50 mins

--000000000000fd70fc065fd20ad1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">fixing,=C2=A0 sending v2 in =CB=9C50 mins=C2=A0</div>

--000000000000fd70fc065fd20ad1--
