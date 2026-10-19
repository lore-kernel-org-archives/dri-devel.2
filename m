Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F916079D44
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cYvuJU9m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC1110EDC6;
	Mon, 19 Oct 2026 15:00:04 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA8B10EDC6
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:59:57 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-35f036b17easo129835eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792421997; cv=none;
 d=google.com; s=arc-20260327;
 b=Dn618te99nstvgIew7sI0eaCuCPFusm1Ih5KrCC8KvCAoJK5DdUym5UaqISEFj2ZXO
 /3DoJ1Dv7eDRhKJvuyhmMfZKupMO3feI8P/Us9NF2j8D7McR1Kf98fVCBf2khyLEbmUS
 8rgApSKOsmO3dyM1M3pocKsgCgspKf6Qvhhgrbctgi/zk0wNd3blpU/ON98WJuPI0ZBT
 ZjP4pK/bch6zXQ/UbVEmJGRLE2wkhq2I8UkWXh0OCVZzl9B7VbqHdNNd3w6e5OAQCzEz
 GO/C13F4owzpi0Sb9gG8Tr3R/fP0kxpEcsn9k1m0FO4DJ1rSJmfIi77jgfzG5yiJG0QL
 6fmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OOK3YCI+wL2FPbOEUCxouW4aFltJ6e++LOuPX8f1U38=;
 fh=NdcTkyahs5kQtFj2CfCaoZhyExA0+LFnNzzvAvi9UJg=;
 b=l4QR2bWnZrRDKZY19YHZBf+FMYb4dtjNJBnXp/ojjd1iRX31NHexh0QucxKSXdN7ri
 Z9h0ZEdks1atuOlRk188XHfy9ShLRzQg3YH3Xq0bUmM/9dYqGmTobKDBC8duptAE0GdG
 J9ybVVsjSYurFFrcrM3KKRYFY2UxtSn3i/V+WoQoIX+MDVSoSMqA+gYdoLMUCQ5YmPvc
 6J2HAHMHwt94gKhbVRysZexBCpN2DEux7Dh4IdFqVemwkYTwhiRV1s8OndV3UTuUQXIH
 FCiNWpslzNrHDpXvO0S7zdsK1PLLVA0LZbJm9ilV4rzNQSQbA59YZ0Fku+529FfHfTSK
 l+/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792421997; x=1793026797; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OOK3YCI+wL2FPbOEUCxouW4aFltJ6e++LOuPX8f1U38=;
 b=cYvuJU9m1i7oOZNQL3bLiRAC+bbgf4R6Cy0bflDfyWF0S44rJT7oJ3EKfvUbhMDVHK
 kbQz87f0EDIE08xIfGzaC+SJVPpfAhLY4/7lWmPzOh8EU9ROdNQAVSXk5EqVnOWvbvd6
 znQn9WHLsB/SwdL+KIbbjzxaYj7unF7w29+ENVfbg38ehIpQzsIPCwOwEk/n+sukbf+m
 PMFI4sGY9T6jomz11nN2mlMNT7dADhYOuXHRlqp7jTBClr2UjPaG8METKWt7N2AcB1oM
 Af1eVHQGQWscL24S+sUnuPA9SUq8j+e2vwVRJdnYXOlw2T4fseKY80O3bwXMmZ6ixhXR
 e3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792421997; x=1793026797;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OOK3YCI+wL2FPbOEUCxouW4aFltJ6e++LOuPX8f1U38=;
 b=0bEaOCq4Ahyv57xPocHuCAZJXBVpZmyzxMzrssEIZtQ43db1Y8ac+esQqiLXbI8iK+
 j6DRhhUdihHldC7C2v47ysxvQcyLqq9b6Gl48nWD/7D6E/HENGpPTRoyk8i7EuaEH9oR
 Pc7nzJM6LXseuR1AyHBz3vOU/e8r7tho+UsfMu8IjUm58ia7n7CaL52Bb4CbM3yRfsmB
 uJgYetxrONu3bGU0rt7OhVoW3+uRyRRQmQu15c3G4GRZVS1rjjiRupKe+QI5skzpR/4y
 qJgXwy9+X/MJM2XkGwq1/3uFS+vvW0bReeSysmdWpvgF2BbogOtoMB3XIxAk6dk4RkRH
 xLbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx//EHNuP70tBDZt3fqubbgs2Cte/Ewz6cuhovnBwY2CAb9f/ne4pgZ6CQzawZPLYhPjtiG6Dtb6V0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKme3uXynw9vFvlzmK3YnxBPnVSN14eEt7nASRl4RWixoe8UuXd
 uluy2uXrrDX2La9m/wUxc6eIpUMnIznqCbcqgUiztQlD3Vv5WnxO0cufGbAMIxuri0hm3f9PIj6
 gomTVuinNW/Hqh5+bGaQKVch49Rkd11g=
X-Gm-Gg: AYBFou0hvbWs1wvDrtyFpAyLgd9j0LRPe4CigtJ4pscrn4fIgtR/g/IfKPUF9EdX1Ko
 4WezuyItK3ul8hr4/vcR0g+rI2yvNnvj8EYAvpe+AOasw/TxIsHYnyRXWSdgF0Yvnv3/Jm6jBjp
 AMTctvDt3bRvF3noLvcforJ4Y08PVx0NVZkCTflyfLD330StwEGflFLQGZQRB0V5JxVBYsiTft4
 yNq1woiZqIquUl+Sri7GLmIuOYqohz05uUHt4+1DEriQZFtSJOexkD/u8sZHUBSV1I9SnGXGizD
 jjVD6Bug8TOU+8ehYm1s5dLSgN5uwP7+WSpoTl1Lf1kjVQ21C17js5tJo2JccEc8E2ekHwC+yOh
 6/VLVVpD3c4aJ9PTu8h30Hu0=
X-Received: by 2002:a05:693c:860a:10b0:351:727d:b9c2 with SMTP id
 5a478bee46e88-361a18634bcmr13588245eec.17.1792421996823; Mon, 19 Oct 2026
 07:59:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-2-clamor95@gmail.com>
 <179198322819.839288.5272985130898382430@kernel.org>
In-Reply-To: <179198322819.839288.5272985130898382430@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 19 Oct 2026 17:59:42 +0300
X-Gm-Features: AclHuK_ZuMv647lBIwF248HcvuKvZ7xEYTSnrsbVhEmmD8JSr7pPARagQdu9MDM
Message-ID: <CAPVz0n08bXQrujADdgQwuLu10JNjOrjBq-zNS6agSBGLLWt0OQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document Skyworks AAT2870
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 19 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:5=
2 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Wrong subject line.
>

What do you mean by "Wrong subject line"? Specify.

> > Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lightin=
g
> > Management Unit.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/leds/skyworks,aat2870.yaml       | 124 ++++++++++++++++++
> >  1 file changed, 124 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat=
2870.yaml
>
> [...]
>
> --
> Lee Jones
