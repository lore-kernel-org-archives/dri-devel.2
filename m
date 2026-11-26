Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4F606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WX8KSIwu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8242411282B;
	Fri, 27 Nov 2026 08:29:12 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DE010E9C0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:40:21 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2f02f04a426so57161885ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 05:40:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795700421; cv=none;
 d=google.com; s=arc-20260327;
 b=VS/39wo8KxiEMbKptHkX5tcEvaZE6P/CbLf+bJUQPKostT4l6qHmtVAQCxvoa1aOFJ
 A87ph3t1BSy4gnKP0dQIRjz2oW4bnJpFIdVzs5q1Qyi06XybicmidNJvuRPARZqIWTin
 0s/cJUwKNYZl6BfYcROc2rgdPnPUzIGbE+uaNnovXymqzJJaLHhDqjYA7H0bbjoCuSgi
 JkPPvTp0PDEmq8tt5KodIJ7gvDo0ZbinQhccqwculBfNiaiRoN4IZoucMrxjYSetzJEw
 Z8171Hg8gOVADwbATPaU0gxE7lLKOApXaA07eNxIJJ3LeTU/1EfmUmRQgSJyJY14kBRt
 R+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=TK7sU6Dup3oSGjjseEYHeRQNyCJVQb7RMxx6Hj+oz+k=;
 fh=Eip0aQqfY/dxbX4jr9I1ZnWXqXCI2xN5gbxLjM9zUB8=;
 b=ULOMRpTI/fMRXSDj3iMkoDOlKmvpci/LmqMS3A3jrdxsYwFHcjaWECYsFpyQ1arGlm
 WIdbf0r7C7fukVUC1BhLS7Ep5RHCdjUuyh0+MflEooDlrawAySRUjEAU7KFuPyEDAP2J
 eK9qBS0XJCvoh85ptpYi6XI5p6xTLRP4Po/F2enZmhGZrLLKbhd7ZZKHrMhdsuZI8288
 QIuNJoD+93rjkAzN28x5UUenjnTfS8wWg6+/zrW4I9ucgTwleF52pdDGSFrhNcmO+6TL
 sycAPluzlercRXliyQ4+otO2a+CJMK3Yvq87PguYX6f7oyO1h/bqaXGCPsa5JVBaBAIs
 bqHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795700421; x=1796305221; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TK7sU6Dup3oSGjjseEYHeRQNyCJVQb7RMxx6Hj+oz+k=;
 b=WX8KSIwuVlhXyLhk9OJfDOhFJwvtPfivYBkm6wwTUydWG5JeYqkeBsjKFjO3baF8w+
 KaYnV0JaA5EDvGOD6NPGfrLoa08QXirVEqCEp6BPMsOaJRPBO9q9vFsgTqX82xCJI+Mn
 lgyMiLL4yIIeH7fZKr1x6iqy2cZ21hLNWpwqWEGUFS/pIwe9hQDVkcROIXFPRS3Vb+xY
 5jBwpr8npabruUVb6ryog1e85mZSecAmPm+WvgSSBWFSnPYUMagGOUuMpuPZAmJgb9iD
 /ZywnOdF4Y5otMkJf0/iTy8OpG7knpRAoA5AB2gCEF2e5Q9ye/k4XSfgKkbvNwdF5W4f
 V7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795700421; x=1796305221;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TK7sU6Dup3oSGjjseEYHeRQNyCJVQb7RMxx6Hj+oz+k=;
 b=z6VFzCPkX01Ah3VXnIGtbBvrBJ2poT+QKCiOQ+bHuHQnIDLm+itKIqHb137plAQPy4
 VRGBbov4m/yjyAJbldFBq9+zIqme1rOr8UuGwa5b9lwg9CRykZjn3v6zt3pjRddiRw87
 hJ1l/w871+1oQ3wC8RvSxJed2J6ina4oqHaOnRyGX806xsCHNTgN54Jq5PflVDOeecqg
 zo3+YbJvNLo8QfZYR8tIezdul3jnW/GOmRO/3HPxFsWGF9/wCsXqamGwEbxCRdAG88I7
 QbNx+5yyGneyYb+w4/jrIWxrcPAxN4vfaAqOr+qUNgCoDIuua7HhjDTOJcCKZqiZ1WT8
 G+PQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFZXoXriMODpMU5TehaRLEfzv5FDoYhPY37UCTIn36ZCGQZgYkRhEZw9J7gf7U+1dxmcrrE7hGGRjo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8XIVcD9vUd4/Nx/dEhL4EcmOeWQ4da/yyQIrFcxUQJRYF3/fpb
 aq1jJ7lnmnsFTjHT9CbSqJEUmcz28Nc+g3dkkij4SjTS8E0DRV+j0uFvtq6PEIcZq5CBdj9Cn3O
 gSsby6c/cytrGSJT7ZDZD+dZqv+By5jw=
X-Gm-Gg: AZFdTZfFcFil7QuNfo2iNE1s9PrxcFsvJcf/ndmER9CKyfFBtK8nLQeEx+Zr0bzBZ2o
 UiHx+5+WT1rWx8V0+FVoxRAuxg1lMLqJaBYOnpiIWj96RR8csDd8NIvR0id4SFl/iPOqhOMS5fN
 yr59lAX+NBP7mPDSZklZD1bbvo9FCAoXRO/IABVb/tGdU9lW8mK9KMvv6SCBdu0YXciqoVpagx0
 bOYqSuGWamph1fpeq85HeXLFBvMXA+5Vnr2xtiBHIpr68kxd3/K2a+BWOd4/FI+dvI0/bhn+mtB
 9ysAjHflHjn3ZxFl86ABTNEqJOL7m/gyJpImGs6VgNS7Qg0dJgXnfjhmAJWJAmT9Mo8h4fvJu96
 /f88UP+3bX9nBBPyE04GUlTNtREf5deSiFtWcWYW2OfhG/vVTS02Tz0vBYWHRqV+Xm/47O6/7jH
 ZIlcUD/4L8rOwt9ACnFatslPAOM/s=
X-Received: by 2002:a17:902:e802:b0:2e9:a16b:c251 with SMTP id
 d9443c01a7336-2f03efb1099mr243902615ad.3.1795700421265; Thu, 26 Nov 2026
 05:40:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6674:1483:b0:76e:c882:7689 with HTTP; Thu, 26 Nov 2026
 05:40:19 -0800 (PST)
In-Reply-To: <20261125-crosshatch-panel-v4-1-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
 <20261125-crosshatch-panel-v4-1-120adc58e737@ixit.cz>
From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 26 Nov 2026 14:40:19 +0100
X-Gm-Features: Aa3M54og_H4IzpH7EvpAxUM4OanCCPa2Is0gIzMGQ606cP-gzpaxXkWDzG21f2o
Message-ID: <CAB1t1CyB8VLG2wgviTJ+VVzajnZZ2B3ck+E3dps=fWxWcYqzew@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: display: panel: s6e3ha8: Adjust to
 reflect the DDIC and panel used
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
Content-Type: multipart/alternative; boundary="000000000000bb8e0606612e1544"
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

--000000000000bb8e0606612e1544
Content-Type: text/plain; charset="UTF-8"

Hi David, all,

Not a deeper device tree expert but LGTM.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Petr

--000000000000bb8e0606612e1544
Content-Type: text/html; charset="UTF-8"

<div>Hi David, all,</div><div><br></div><div>Not a deeper device tree expert but LGTM.</div><div><br></div><div>Reviewed-by: Petr Vorel &lt;<a href="mailto:petr.vorel@gmail.com">petr.vorel@gmail.com</a>&gt;<br><br></div><div>Petr</div>

--000000000000bb8e0606612e1544--
