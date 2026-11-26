Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB2606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fobx1Bne
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5737112852;
	Fri, 27 Nov 2026 08:29:33 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E149A112444
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:01:10 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3b501791bb5so821834a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:01:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795701670; cv=none;
 d=google.com; s=arc-20260327;
 b=lU8jISqtrCFNTOdlIRPG1wz2WLijhCzYA0Q9t8E0AdaiL9a5dtTGX5Crlu/iA8fwJB
 uO//pIVK3RqUauY3BWu/bU5zRh2LAvgoAyLg0H9sM93AFrMy2xS/TidGl/22R9+YqQHg
 jrD+DfpNSCwovk7SrUF4n8Wp2OJVMHLsrWsbMPXQkSm36xGYO7gz0b6Mh6IahjyI97ZY
 QRE+cK92lQPPMhWiNfW4C4K3wnLaFKmxrTn1kIdpFB+sr0WfcYrZpW0hu4DDn71+3ZsF
 awrEM0ICdPZsehqg3qvetfzRmmdkqFhSGaPORyYhjwKweSfChvzGV4nbn3Yt5jA8DyGR
 QhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=+7PsyILtAxa7IPKxzpI7zOKx9SpmvIvo+vE3udAtUiY=;
 fh=RSIbT5Av+rHvGjVLZLYbBrcvptJBfrsShXHbocChCHk=;
 b=N6KI9FgmiG8OYhVnPaXXmg219+TarkMt7hKlNsD4urcFOKNmY2BvFcsH4bNjYQuRA5
 liJxA9bKn8iyrsirLqwKetSUOv7bzFyAiyo/xAN+ItWkw8vKftK/PzBVqMoxdXGCoUN8
 rtZdfVbVYdar326Nlw4ZpA2gwppK2q/HlUyqUXAit0prwiv2U6VdZy3Nya5sVJpx6iZ6
 ubTbHnTMkP+f5Xd68Mi/ztfQ8GtF9a1EK7si+iec9/q4YneRRNVgY5pKgTvB2a+Sy2Zo
 47xjt8nZSbwP2ouDvpdudyDOeQjf+ZHtOF89+Z/ojT0mey4Ooah6Aj5bSXqjjYTWBppm
 Up/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795701670; x=1796306470; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+7PsyILtAxa7IPKxzpI7zOKx9SpmvIvo+vE3udAtUiY=;
 b=Fobx1BnekaAXc/6b5wtzObXgGv6xFzZfU/KnPCEpRtzxByR9o6xNvNcIY82wSU0jQB
 EmhDel2lKbf8fyULk09FCgqWDmDSVhjgKD6d43xWDqPzqDIyNMIy6Zr/acUGUlUWxm2p
 QwMEq5IVHxk/LhgBs4ir867FS2MPV5Z25c/ul2UBzQH8aTpjSQzYXRj/ZIvVy1zdezNA
 qbqQcljS+SgkrGOr/u95x1H0TZwmS7ckQsqzgO9EaEVHLpPE/YQoaOoqhI8jJ81gQgkR
 oA1YnBBI8SeVW2rm6KO8gmIHlGUt0MCGvYdS9w3eoHBboA0sRV7Fbfv+f1Gefeggogxi
 ZLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795701670; x=1796306470;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+7PsyILtAxa7IPKxzpI7zOKx9SpmvIvo+vE3udAtUiY=;
 b=1+0JXx7WRofY72U9lKgC3cFVkx/JY46Z+A5N9t4iDGTiA8V1tYHea1fyDy4QrvGaUH
 UnvcXcHwwacEzT/QDwj7R6HGnTQxChPbRHYdoEduTFVVttZRSyXBnFIREYeEMMAtfYT9
 ii0ThMuPGVf+iWE0RmIjlkDdq+4cL9ZZpboJ8w/JjUQumRXdkU2bIpZ0px6ESZwCHpGL
 iWmvar0asHKd1Hs240fg/eJMl3D9I9BVMsskxv1gJ7GhLf96KYqoK2JY6J2oDXxUZfYb
 +ioNSuf0b8hbVpWKuyzcEvR/SWGc8JElX52q9YmmF2Qf2bRKqfP38QRCO1TLdEbQj8Rc
 4a9g==
X-Forwarded-Encrypted: i=1;
 AL+hErFLcWQh3NZilEe5P/aTfzGTnifKw8l+zY7tTJuuta0s+78QaIt5tNs8x9HgXCz71y6k6vrLiqMGEgY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8c5z+hf6D/yUADEQ6G+VjAnGVEjcr92gMhEYzDRMDQkW7t89WV
 F90yR1wYFjv4Pq31AB+wdxknb78hBcYBaFoF41ZhxA8PvvSTo/w4fm8GmaSkdQW2myH05ZFmp6Q
 oLDriom1l1P4oJfXKgYtk17JpYvOeVFk=
X-Gm-Gg: AZFdTZdHGl3QwWmH5hXvY731jeYLJn2gTgblYI5fFyABRNHxfXhdXJl8KBcN1lDZp68
 YCrzqNp8sD8t4Q6IVyTZ2VsvVFKQU9c5rNetR40mMDWK1ZBtYghVpWEi6A3of59u7wIvI+wOZAq
 Jwefnf+pS0B76U4RI2LR71QMCp9Bc/6ebLpkIMxJPelh31HppqdF5BqngfRrn0HBPHCbCFxI4oj
 4ZVbQZr+hi4Stbe6wnPo/QbB6rQPhERWQh7ta30PC4BKdoFCjLH7cl18nbbC/MsDgiPRzcy67L8
 n3zfWCRROdkVCvFy8H4lOZvxzX1+mC/goG8mesRr/rHlGaHIOoXOVs7g+yuUInJg8dnYTlQgfVA
 M4TzL4uU4ymihCsDjTSZjaW57k/GnuUKNv3/Ut4sm5OOV1GI1T2uLKWrDtcp7i6vmI2G2xDbrYZ
 B8QyNFtPXCEgc3CxFhru02xU/dyWV+/1pvehulM+nkSpglgc10
X-Received: by 2002:a17:90b:3e48:b0:3ac:adce:60ad with SMTP id
 98e67ed59e1d1-3b41c98a343mr17253681a91.22.1795701670094; Thu, 26 Nov 2026
 06:01:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6674:130c:b0:771:4e9f:71e1 with HTTP; Thu, 26 Nov 2026
 06:01:08 -0800 (PST)
In-Reply-To: <20261125-crosshatch-panel-v4-7-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
 <20261125-crosshatch-panel-v4-7-120adc58e737@ixit.cz>
From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 26 Nov 2026 15:01:08 +0100
X-Gm-Features: Aa3M54r3jOMoaN604G_PpkDABxE0tA8XJpn1t4KmQ5BOdp8OIW38I_If28UAF8Q
Message-ID: <CAB1t1CyR_jDOBnofzWZddgutyUyEib0CN-6jhiTP0B=YPTJCKg@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] drm/panel: s6e3ha8: Add Samsung AMB630QY01 (Google
 Pixel 3 XL) panel
To: "david@ixit.cz" <david@ixit.cz>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
 "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="0000000000002b2f9b06612e6067"
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000002b2f9b06612e6067
Content-Type: text/plain; charset="UTF-8"

Hi David, all,

LGTM

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Petr

--0000000000002b2f9b06612e6067
Content-Type: text/html; charset="UTF-8"

<div>Hi David, all,</div><div><br></div><div>LGTM<br><br>Reviewed-by: Petr Vorel &lt;<a href="mailto:petr.vorel@gmail.com">petr.vorel@gmail.com</a>&gt;<br><br></div><div>Petr</div>

--0000000000002b2f9b06612e6067--
