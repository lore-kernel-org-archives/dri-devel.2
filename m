Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C2606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PI5/IVfI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0044E10E743;
	Fri, 13 Nov 2026 02:17:35 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD57110E2B9
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 02:17:29 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so423600a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 18:17:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794536248; cv=none;
 d=google.com; s=arc-20260327;
 b=cmZ7eHfXFpsUKzCswK+lpv6D+1xgd9CPPuA7fkeVFLiX/tik7jOWoYbRU2zkSBjGAt
 5b9F50Hk+plQJ6rpKjOZeEgu+O0JBPdWbFwijKtzeaSzjMS58YSuYyF+rxpjvvodTnAG
 yRi9CP796zhZWXRARdZ2pJhyN4YiflTssO7XMhHv6m8z0JkqW0pO+bmfbcco2QtovklU
 PnMcQ0b/RRjCFkPEwbXLFK4RQydm3NJW6ns8MmTBP04fbCm9Gi7WDmLi597wUoQvKciu
 ZOa7StsxN8kPMEYd4El8YqG9wVkANCUw+t+PRFgsV0SdbV31+rW/vzjEoVzSucHFJQrs
 tZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QnD+ySvHUO58cxjpkDP3a052kfKgub2WKAAH4qvj1u8=;
 fh=zl8v3Qx0EqWCT8MVVUtM+Ait7pqB3bi42CPh3uJqS5A=;
 b=n0xDHl69JFd4jtav5oC2sY5ElciQ9vIlzSZnBEuGBHzrses/pQmieFV24j0B+E9+M6
 jAr71VrwuZwLugULQGNm4xXWMKUlWPw0RIDs4mNW0b9JbxErNnd4l1DOHa9xlgh2tnhk
 1DDsD55IXMyP8tgWmOviNjPUlK3+1X6vzZu2bBpUQp0UPOd/4EPbobdxYyidxl2LWtAP
 Ypv9SaJwonQLPQp4RXu++0oHGOGwlFLbR/23h+IFvFjnKIdEEmKHZAvQ+kTMPZI3qZsJ
 Nxzk4mcokO+R1vRfppqfT/BLZ1GOsQLPRpqTAQBehjNxmx+L5122TE61HjsaFm4todzz
 zlKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794536248; x=1795141048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QnD+ySvHUO58cxjpkDP3a052kfKgub2WKAAH4qvj1u8=;
 b=PI5/IVfIl8jvKv2I3OprwAFVG013sQZTpiluho3mst1+yYXNhnBP0ExaYpgB2yz2Dc
 csTpGC7AcUj1sONgaEFAYDKzHmmrZBHczCu0Zc+oAlIhM+oAOaw2X9Uotaz67hRhytSx
 MR4Vk0hLQzp3GwCBFgYxt7+3CDiNK3XnVMXyrzKmme3W5YDeQWNFso9tnEzBgXTZWkZr
 zUgidWY3q44bHkkydN8Q0MtdXUYaoPezUrgMdVHUuqGuwDIm20MQtnIKA8sYCELKZtJO
 X5ZdFTk9AWgNjF1634AtAXyDtovy+ASdi1dOPSZ93rAGsekW8QRARMpQC7+ncqOCj3/p
 Ib9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794536248; x=1795141048;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QnD+ySvHUO58cxjpkDP3a052kfKgub2WKAAH4qvj1u8=;
 b=lv+NU/AnUHccK4HMd4xp2Q2Yp1m7/kMNNPmmw4VL+8LXkDWPj5hM+u8hTMj0DbmujG
 I1YjK+b+GZKM1A13xPXUb5kMH8tRG7iQZbgQeUM4g76oQ2H0j6SilPNHPFXjCgoMR/Af
 uuW8AkHADp/byEJhcifCq//i11tURetvAnJkfD3X1YAwz+bdkILHJNHByt9u76RVFaYl
 32BjVG96D8YEUUlsoe7Cz0RP0LI8bT/x6Q2QRYH3HjaUkEImxJPvo7vXJMOHJDFCeqVc
 9urKPByA96WfixZ5C361xW561gOadjeDp+cqSyxBWuYbwhtDSM+Ojb9OgCdmY1HWJPZ+
 LCQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEC4tS1Rsg9Z83SwN6Jufrx8kHUBDMynPldYLQLSteYr37DsDGvTRqi9I1kgje/Y1E/Ie3jqENzDhM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/5jAxePGyFDLKHlZqNZjG3wKR7r1aD7LWOXsNPpvHducozs18O
 4WZWJzF2fCSuVN0wCZ73MWuC2j3UeJdnP1w2brGQcTsZ1twrH1T2SZEu0FYJqH5TKZGD6FfhWj8
 WFZCDN/4EeKRCw8IM0x7VXh2UQ0UUfP4=
X-Gm-Gg: AYBFou2OOzejsrBqA9XqIZFyoypvSAtDrt32U0NewK62evqjWio1mhx/K6MxOPfwVEa
 MO+9BKdA6ziWDeEHyBX1R5OPVCTcoU/xjj+YG/PI4Bx9zFE/osq8xYeD8vUVBumTt4NgcSEbNSk
 xug/CE09XCKHlN8rYlrG3pxCJD6K7PNsEJ6BAuV+vvxxo34ehsLmiEeyjs2yFIgOchwkMJoFe3/
 QppDRPN1n0S2QD2YJiwqV6EYLhlJ3Betp6ljGVbyxXquI0EUE7AQSH/EtZjwCCM+KjTHvHw6QCV
 SZKm/6mbZN8yHuURE5EmifbZOKVvAGpNBI9Ngrm0FRX574/uEr9yQZKpGHZef94NkiS1K7M5NJG
 cgkgxj++mhDOhGoV7Kst6zLm4zZH4zhcGFNyZmU06VYMBOYYLjzck8Gk1tBUyLENtZ+kM3SU=
X-Received: by 2002:a05:6402:548c:b0:6b4:bd6d:2eef with SMTP id
 4fb4d7f45d1cf-6b7c05c02f4mr975856a12.0.1794536248094; Thu, 12 Nov 2026
 18:17:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
 <20261109063303.32658-6-operatingsystemsdepression@gmail.com>
 <20261112212032.10576-2-joseph@telaak.dev>
In-Reply-To: <20261112212032.10576-2-joseph@telaak.dev>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Thu, 12 Nov 2026 23:17:15 -0300
X-Gm-Features: AclHuK_QYczYyjw7Av3aKqozd60_7RgOFOA0MeBbV4AVanwXZfcu0ZN4U5f9y80
Message-ID: <CAFGNeagTMVdVPUxf_-uovQ1q=+=SM1PBuvSHR294pFu4ezzNsA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/6] drm/gma500: Propagate SGX MMU setup and GEM
 pin failures
To: Joseph Telaak <joseph@telaak.dev>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 6:20=E2=80=AFPM Joseph Telaak <joseph@telaak.dev> w=
rote:
>
> On Mon, Nov 09, 2026 at 03:33:02AM -0300, Gabriel Gama wrote:
> > Fixes: ae012bdc5799 ("drm/gma500: Hook up the MMU")
>
> The code looks right to me, and ae012bdc5799 is where the ignored returns
> came from.
>
> My concern is that this patch has a Fixes tag and 4/6 doesn't. If stable
> takes this one alone, the old insert still leaves partial PTEs on
> -ENOMEM, and this patch then frees the pages under them. I'd either drop
> the tag or give 4/6 (or its rollback part) a Fixes tag too, with a stable
> dependency note.
makes sense, i'm working on v3, thanks
