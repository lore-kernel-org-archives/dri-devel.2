Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B351606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=svqRpBQ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D72D112450;
	Thu, 22 Oct 2026 09:41:22 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680E710FDD2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:23:22 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so604667a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792585402; cv=none;
 d=google.com; s=arc-20260327;
 b=JWPEqRPjeU7r3CivkIfHiQXqNEsPEldgKeBUT8WP5DsBD1I0CpAHw9Jzr6OZX8jT5z
 zXHGC6qNbH3dQkwTwmkZsw+Jn4GWKucwTfyVXDI38nqC9ML11FbzxMY8/ZP1G7TB1NVl
 X/8c8squRSJPunOnC8N42noOOstXMhgS1X95yXGcDSf/4+DqorjjUM49+DI8rVy+WpLH
 d3Yt3do5T5hLBQ8Ej+lN2RJXMkH5i9GU3t9/1cH6wU/6QY+C1zAqy46JCL3ne6GFSvYS
 TK771idS7ItGO8cCq64Ytu1uIvWABtOBzsacnZfRip6CFhY8zZl829mhED5IXKZCxt6L
 5Y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FA4/tmp+GuHTCGJRQWT+9rrmKCn9eFEpsrw/7KOeHOM=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=YGhG/2zyqEtd7FisqBZtL35vdYflNinjSh79c4cQ6Q7DXYgW8CTkiP5iUuY4xP3Nh0
 0VvBiorAXpZ9vAnxIHWgJuwcddKBAuULcaRnrUfkwoRcG160BwsJ9otIy/iGMDGWdqL9
 aXwADvnvbYZv9FnQsMgcsv/6Y/npjZloDEshZ2fyGj/yTY/dNBECUF+is/dABm5pglIV
 19ICfAlHV6DYwBv18cJUgN1CVtwIjPjO1x5HIPqyuQoZ+tjU4QtkzwCqXcoiVyae9nYS
 I58aG663nym71amL8duNB0dg0a/Z+6GYG7k52KBesQiTpybiSoPuNtz5xBNdiUJ9rQuB
 /vIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792585402; x=1793190202; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FA4/tmp+GuHTCGJRQWT+9rrmKCn9eFEpsrw/7KOeHOM=;
 b=svqRpBQ65czB2Y9CFALVocQ4tvF+J2dNg2PY9KxXLYpg5BvHwEEJWySGlhx9v9w/e/
 BCTdRD/AGwkqoz2AmH1dHK6YSqvtzSq1LFtvaS1R24XC+Ait4Ls32trDFpCJiLtLk0Ko
 s/MOlhVVzhMcixrE12ZtRashizX7NGHW638NCje/HSka1j1LOp+81QcxSFAcdz55yqpX
 LXf9LkCyo6xsHy0ne5uW3Ptw6oo6elR9r+w57jj4dPnDuObHrBUD5fouHL4Z30O8QhJv
 fl2YojkAwGUr8eL6oCwEaB84trtd2jOz8h0IDRCmLS6GagOLHF8BN1Bwj1z/rd2FY3k3
 nOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792585402; x=1793190202;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FA4/tmp+GuHTCGJRQWT+9rrmKCn9eFEpsrw/7KOeHOM=;
 b=bqjeWr/t2B/+hpIoXm+Yz7/FLbmWkUKXKzItMJDNkJzQ9jTyMAevmYQZ+NhOeJ24ej
 60hObfgT2L6fTjFFo1EsSCzNv0dus/L2OH95kP6GSA0nz6bouiyEHylO3ZTY5kLMqE9k
 57m8XN//pZHrlgQS3WXlpke+H4yhJMK0wRRFNVE1cUWBygiNBkQHfbZXuWXkdlP94WME
 XgjjC/OS1gn/sLuvOqsPV2nLSa1Ifnh5Wj+O1YQVheZYCg6Hqe7B6YESJPSHXhocQIe8
 7IuXBhTsaqdhDEBzkNW5Q6zI0FZm64hxyJpd6DD4FmOkkdPlgajCIpmrAUK6gS2G6d5u
 No2g==
X-Gm-Message-State: AFq9FYKnsOdwsl8L+/zdDEQpRitcczet+4iHSpjLIfhlMqFbsnYtXqEz
 Wr/wz4XVnFu+7n1Ojobe3sGKd3gQEWcwnXBSl59DldJxxD1w9KfqgEFLkQidMKBX18u5hZ7k4PI
 XxxnNuqeQjemmbAFj5bssO3WKTC3fFC0=
X-Gm-Gg: AYBFou0tQ4nuXOeK0j1joKJ8HEqjRrePDu1SzJUN+sd2GIAjN7w52tau5ijgoGtFkOq
 eOb+Hz3sA9eERT/3MqEucZILV0vId5/RmjcJftxn7dfM0yZ4LFt2WdlbRqjs0X0S7yCuPR7//C0
 5mSZx6eK9278pK9na8FEG2JAmYW0Ujd4nv4dZ6U9z0UkTWs/9Ddul+mMfBweFqs8QU+WPCESDVR
 PHJC/JsetayZ1vYGQCOwtBOiABmIJ8h5hKkOjNRjkHOVO19rrGBcPXiaF4gIh0JOsOX1OnxIuhd
 eQT01FjIIxOv7Y2Rdp6VCx39WT2QuShHe5/9M6cejeLTKv3OK2r++20yf1hhGRuNbxlShWG8ZRC
 YFnO+qtBwlj6L5u/Koyvyldi6Naia1Jtuasf3RcU=
X-Received: by 2002:a17:90b:39a7:b0:3ab:f2a9:cacd with SMTP id
 98e67ed59e1d1-3ad86f4b976mr1828292a91.49.1792585401836; Wed, 21 Oct 2026
 05:23:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021114122.94008-1-mptagliari@gmail.com>
 <20261021114122.94008-3-mptagliari@gmail.com>
 <sashiko-outbox-180189@kernel.org>
In-Reply-To: <sashiko-outbox-180189@kernel.org>
From: Matheus Tagliari <mptagliari@gmail.com>
Date: Wed, 21 Oct 2026 09:23:10 -0300
X-Gm-Features: AclHuK9I2Uxxmz7VDrUBR1deXH7eM_4aRDmbLrjXrHeVqgn7Sm7VhzBj-FVc6ds
Message-ID: <CAB3VZtezbGb3Ek0cMacY8PvKCa5C0v5tftBxA866ZN24FgtafQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon/vce1: enable the VCE trap interrupt
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000001b291e065e58d08e"
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
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
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000001b291e065e58d08e
Content-Type: text/plain; charset="UTF-8"

>
>
> > Does writing VCE_SYS_INT_EN unconditionally in vce_v1_0_start() access
> the
> > wrong MMIO register offset on CIK (VCE 2.0) hardware?
>
> Thanks, that is right.  vce_v1_0_start() is also reached on CIK through
> vce_v1_0_init() (cik.c) and kv_dpm, where VCE_SYS_INT_EN lives at a
> different offset (cikd.h) and is already enabled by vce_v2_0_resume().
> v1 would have written the VCE1 offset on VCE2 hardware.
>
> I have a v2 ready that only does the write for family < CHIP_BONAIRE.
> I will wait a bit for further comments before sending it.
>

--0000000000001b291e065e58d08e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>&gt; Does writing VCE_SYS_INT_=
EN unconditionally in vce_v1_0_start() access the<br>&gt; wrong MMIO regist=
er offset on CIK (VCE 2.0) hardware?<br><br>Thanks, that is right. =C2=A0vc=
e_v1_0_start() is also reached on CIK through<br>vce_v1_0_init() (cik.c) an=
d kv_dpm, where VCE_SYS_INT_EN lives at a<br>different offset (cikd.h) and =
is already enabled by vce_v2_0_resume().<br>v1 would have written the VCE1 =
offset on VCE2 hardware.<br><br>I have a v2 ready that only does the write =
for family &lt; CHIP_BONAIRE.<br>I will wait a bit for further comments bef=
ore sending it.<br>
</blockquote></div></div>

--0000000000001b291e065e58d08e--
