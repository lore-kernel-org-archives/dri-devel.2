Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA3606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jt3ZGGY7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6721121DF;
	Fri, 13 Nov 2026 09:18:10 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E83D1121DF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:18:05 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso1641132a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:18:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794561483; cv=none;
 d=google.com; s=arc-20260327;
 b=q2NgjesX4+mB4y2yLSA6oQZCHDIuxiSVGKpUvFEJ9FeH3fHf9vMn3Ip3iascZZSNqM
 8LoDaVFcY9FDdixnKvEsVg3nfpQ8o5m2/xbz+yAxnc6BL7Lw3dkBHXZI4qtnj1cULTlb
 H52Hu27ZffuSxzuTtJWyIJR99z7M1BYtb4DSHXyUojGcYTWBmdwy+yvlGxskSRhS47Iq
 hhYPvbwkSwhW5DW3brrqZ93T0snm0u4Lf+2t5pixYZolHgU+91Pt/SLwv+Lcvmvlut+G
 SEANRKVrxvW9vxD+E7NN6uHK+uGNw9paGuJ7QeeLoYuL7rMGRBOaHqnYTY5sTfx4DhME
 f84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IaKttQrS8tdNaJ2/0cYs78c8pa/9CgvmLL91mhIXr+c=;
 fh=XKZq0ZF1vey/SbldVxIax6fqSzD8H76r/p9opWhETms=;
 b=BmKRzS4NJ7MlmXZWmN4CBzuc61nHT7w/flDiWg55GH4hja1QqFnw+EQfnq/JHgo5h2
 CO8uZq+BI5cOlomURDYyuXp+g5kxuKOwGD1yreeLl6IfD12y/6QcPD6Fhqb72BQ2FDjU
 cYQUAQ9+b9CvQx9rCd9eVXLvRInglMOy/pR0bcX6tl21sYXP/PDBMoX7En+Lxpd1IWX5
 vpaCPMRz3IeSR0QXGRE44fHFvrao50ifwz4pzcGK1C3Wz2SuQmjaomuPx/x3ujCL/1Wj
 5zJB2MGPrsv3GL6CmNMGCbzyw/S9gkoQ9jpkmHxChetesS6DbBdsDMgMzmSqGmdGZPGx
 pwgQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794561483; x=1795166283; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IaKttQrS8tdNaJ2/0cYs78c8pa/9CgvmLL91mhIXr+c=;
 b=jt3ZGGY7zXYq/rSS2zjC12RaSlqpIAUNbN8eUhC8Iboa/HO+82aJMuoTQdLPbnNPng
 UdOZAodAqlLt1lJhRjMuWNohxkKlCfygTw8vKh8NNOAREaZGkNy7qIIltqJDT2Ro7Di7
 IVEFmILSOq747DZlTSuHjCUe18Gp8Pbzr0NQliYIeFLRp5MnHiY/RG74jCuPetQnG6Kb
 l2ZFd6oLRHMtCxZU9odTa2BcpsPbblvSU6Y6YYW3mwzaX3+Lh3FhHgAAOMgdMQLiikeC
 rsPSNItE00VuMfYpWFr60HtMXCUx5mvaDNk+R0RADrDuSTkQ9lu4Bk9f0OmXxaQhiPT9
 9nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794561483; x=1795166283;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IaKttQrS8tdNaJ2/0cYs78c8pa/9CgvmLL91mhIXr+c=;
 b=RZxI/B6DpUTQUxwPY/q4OUQ3fmEOPqDN/esrM3spGm5sKBIVTTkzX0m4hHmkzrMIA1
 fnKGMGIh0Ip0XMS3q1HpqS4xqxkXNa+AIAANUEi9hwqFwySVfJDyi6O3kKGrtwWJaVFA
 Ax5sP4jD405mVIq0pKnMQrjfZ4LA8A36yZOeF1KSsuBhzYryUkknznoYZ2qRMf2ou3TM
 Hxrl5jbuKSWw2J68g0Na05GHjhl3LPT4fcI62hVW9LeTPjlNWPHphriXeQlkp97Ecqa0
 0TWeQWrvJnqahsQ5c5dLCTxT61qd83LQ3D840+2PoK4A6tJkqDqbbelvI1dKKRgB8S6n
 zjNg==
X-Forwarded-Encrypted: i=1;
 AL+hErHMI++gtfUYzqjgkRTG/elbX3P+eDFGDdyF5OT2JxNECaOv72AtAhopB6VfNPIOhZrl8x+3uq6YdEQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+MajdUv2JhS5cS/C8ldqBTNqbdhS5pTnyaHsBhF9QAiFfkt3/U
 GUmaUtlls/LgYeNkie5492dhbSaBrt34ZzPMZHc2zHbkfy4mMWIPB0Y7NWP8qjPY4CpTNIQkirE
 vyHUWn26mUimHpcSh6fPo6xl5yH7YFU8=
X-Gm-Gg: AYBFou1tjUygdPv6EEI51e4dtbgNH6V8gwyQuTxXaDayCmdiD27a1T/F8v6jmeHvAgg
 ThN0x08LTJ8xKTWCchyHj6IOqQhi9cx/P/8HtwJ90M5aigaLpXTadSeEKEdvWtEg5/sgDrgNnzU
 /XA01bqcBFKDiDxS6KOkVRNOu49xtyCvNIwtKsaQyyYWuOWO6LqVXFjQYRxTm6P9WNOC5EGNXrz
 m3su0q7N4AWnwOI2MzIHm6H5iSIkGoWldTuMO9lZ236X7SZLd+IYTVKkwwiAAbbph3EZlAVJP/M
 gRdLWSVy7nf+kUgJBCj+o2yxgT0QrdGi9PZBSyh+dLvs/eAuPuZ6FNa0d0RPN0KnSuaqrSEPWaL
 MoJeCsVN9xvpfgxSG/oQz4oHNXhKKD3XM4qgj/O4XjTfDyz9iBxos2JmcQj7KmH49iH38tfU=
X-Received: by 2002:a05:6402:460d:10b0:6b5:76b9:5040 with SMTP id
 4fb4d7f45d1cf-6b7c0d189c3mr1522118a12.41.1794561483071; Fri, 13 Nov 2026
 01:18:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
In-Reply-To: <20261113085341.61992-1-jttelaak@hotmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Fri, 13 Nov 2026 06:17:51 -0300
X-Gm-Features: AclHuK_yaydiPJ99MnDiTwkOkjxUjSQmeHhNWjHSrHL_TZxHbJFKAGs5pMyFvBI
Message-ID: <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Joseph Telaak <jttelaak04@gmail.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, Joseph Telaak <joseph@telaak.dev>
Content-Type: multipart/alternative; boundary="000000000000b9e5be066024e7f7"
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

--000000000000b9e5be066024e7f7
Content-Type: text/plain; charset="UTF-8"

>
> I think a shared render-only driver makes sense for the SGX5xx family,
> except for GMA500 and GMA600, since the SGX support is already integrated
> into gma500 through reMESA


> I'd also like to continue working on the SGX544MP2, since I've already
> invested considerable time and resources into its development and reverse
> engineering.


> I'm happy to collaborate on shared infrastructure and multicore support
> while avoiding duplicated work.

--000000000000b9e5be066024e7f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">I think a shared render-only driver makes sense=
 for the SGX5xx family, except for GMA500 and GMA600, since the SGX support=
 is already integrated into gma500 through reMESA</blockquote><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I&#39;d =
also like to continue working on the SGX544MP2, since I&#39;ve already inve=
sted considerable time and resources into its development and reverse engin=
eering.</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">I&#39;m happy to collaborate on shared infrastructu=
re and multicore support while avoiding duplicated work.</blockquote></div>=
</div></div>

--000000000000b9e5be066024e7f7--
