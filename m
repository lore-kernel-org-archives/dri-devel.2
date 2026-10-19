Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011A606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NedFe6Jy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5B810F2F3;
	Tue, 20 Oct 2026 07:36:32 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A7510E812
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:57:42 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8a06c60065fso365427b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792396662; cv=none;
 d=google.com; s=arc-20260327;
 b=QSE0AHewIBd74a4/s0Bs76V3N2sCdV/3oRUhvzE+0b+UlOCCY/eKTrZhGU4UNLpc4o
 BNIe4/kEn7krzDfX6RqRAJFMONW05iZ6lJBf3Z2X8LWQZ+Aq+I/RPpBwfmnELH4V1Uux
 S5Ff+ngQlCOV9cKYmY/TRHf+QqRqXuVgqWvuPiyRWlOoyq0a2PY/XvwWuAvNtKVjr9/d
 sedUXbISOR9IUKC0BfkD9FEmk7oMGlQzwdU2/gxLQOa+S7MePOsnXIxfoOyQz1YXQsmF
 gcCXMpavatZ63x0etcDalO8PH9o2pOxBOHbNxqhAW/tLw7FQXTzou7W+7r0nS59aFRnD
 n70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MPcEmjZPn0U1HR0YqbRJlGEJNlJcmuvq9yIqrqLbn/k=;
 fh=qnKcvuP2AeS6vDDnCnbz+kRUf5pxX/g2Gzn+j1uf6/I=;
 b=Y3PwsG67muRk60Pjz031V+EiuEYYlLRUpnddityqu9MlS4O02DwzrTPALWu5HShsFL
 uCcGPYpkMaLztkEsBZL4z4oqaxpwzK7OKfyagRJMGPRyHsguslseAJYIvrRuyqroVevU
 CuR5goKCYzKn1C9NG2MF9DWYtxn1MDa99GDPmBVvwXf4rV933z9P+WZA+2+2u5A+o3Ax
 /XUS8JvRE0h+Q36vmTMKUY9yCLEv7k7AcYIbfdygc00XeVs2fNibFZ4JgkA8vG2WEght
 o26knuPygh4DKSbH9CfIYRCm3qpW9VHPrf4UajXzfBwFitsoRrtrHbqWuHhWyX6o2XDh
 qA9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792396662; x=1793001462; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MPcEmjZPn0U1HR0YqbRJlGEJNlJcmuvq9yIqrqLbn/k=;
 b=NedFe6JyfpguRdQ4TFPX3IZAhMF8/31T8+L/RARB/oxeAc+N7YwDfDHLZkWtmBep0Y
 p7ze18JX2MtMkFex+sh4Q9uABGrAbz4Kh9+INZSdHzpWeeZzkf16XUkz93av5fpsffIq
 HXmGM9vJuL3n5gdFw6uJEKwGARBGmVgY574vpA/0HmPDUuSzBtYNscGdZ/52rklhahxT
 Z0Kllg8U1OOAu1m/lNfzACd7Q05TRWyqp3hMkbwU/S80EFGZDz3Bw5KkPB5YXjDG+VGu
 yr1bZed8ifvAK3qtk6HB/mmN83t83JueAjr+s5MDVHTHz3mM/j4tT8v1sKkW4yaCKLKE
 FmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792396662; x=1793001462;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MPcEmjZPn0U1HR0YqbRJlGEJNlJcmuvq9yIqrqLbn/k=;
 b=BARE1T7Sm1Y1eZjPexrBvgBnfuXNY4mmqFa5nEjeJ3vfQoZP0Q1o82vb36hSiiolx7
 qQSTzyOZqDs8c4vNY32TORG+MXdFoQT0v7UMx6UPdbGIx5z7mLkbDFQO9H3Ei8dMgQtw
 E6ymC3uZZdnlF6ci/XlyfsfzxBVYaRygbrBKcieRtpDESqyPTbhHckwqpbX9FSkD3GmI
 Ow36D4CdJeyAbTtvPUkzu9qJBI1wQNLmHRMHzImU98gTrcp3avIsaKOauaZNVyampg1l
 ZodMEaF7jwCXNf88xxWSdz9plq/jfBGRAJue34EvfhVxxuGcE+JRIotxPo9/6OfMSHQ2
 +aIg==
X-Forwarded-Encrypted: i=1;
 AKwUvByUCEg3hFjgkz7wNTOOqGDXFgs2HIXxMlP5PC3V+ox+UDnY6JveIj0qls6F6FIeiw1cAEPcuuuTzjs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKsDx7lq35hS1g8mwVY0/iRJBcHpXlqtvyz97AMyELk/T74buxk
 cewfhsrU/QtGSQ2cpD+1/pIPIuc2f3tn7MBGo6xqnGXvJF3mFcey1eRpU+xWCWFFr8DHxPg72Pb
 lYMuKsB11GH4vebPu4J02Kvnmxc+ZgRg=
X-Gm-Gg: AYBFou2iE1ia1T+LLDiE9/e3z7wLQ22J9JGp0pnlSe5QlbQKyOL49JXFPLXXbwQfOjg
 +SPrD0MJBpocLjvmjXiXv+CP8KclfcVS2BXlCyrowujWKQRbER9b7x6cyq3iGHPhdbTTbUDRHe3
 vqtjW8yW4z7Y4BHQovw5ZguBowZCTWFDLJQWPTfiviSM05n4PSXvx2UFcW4RIdlXTOsZpsiphRR
 0mxywe2i4u3y7n3pgeqV4KYU0OUThToLMdnjmS0SsC7+D2hFHttC9ULXgLWSqcpiZLeZHHOfR1+
 cvZqlEuxPr+FofAGMujWQzeRn1qSXjfaOgb21zrrM2ySJcSdJfYAJI9KvszV8r+TSfFSgEiiX6y
 GzbwIs29sCe7XiT9QjxgWLoDQJZ3e0OAKADfrJwcNxy/O6QK/fLFB7ErnqQYywmwHr+QVDYBIWS
 njNDoRhQ==
X-Received: by 2002:a05:6a00:f8c:b0:874:705d:f64e with SMTP id
 d2e1a72fcca58-8a04ba30be6mr5022138b3a.28.1792396661246; Mon, 19 Oct 2026
 00:57:41 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261017140827.290666-1-lukapanio@gmail.com>
 <20261017140827.290666-7-lukapanio@gmail.com>
 <atW_DkB9H0oV6U8v@monoceros>
In-Reply-To: <atW_DkB9H0oV6U8v@monoceros>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 19 Oct 2026 09:57:28 +0200
X-Gm-Features: AclHuK-MehupUeh6pNNKQQ7CplFtLMUS6VR_BXN9elAOlhRnJMBhoDSEjrXhQXI
Message-ID: <CACi=Ov77_J3N=5UoY8A9XRuQgcprojpV=KahGQ9e3gZz_yErqA@mail.gmail.com>
Subject: Re: [PATCH 6/7] Input: edt-ft5x06 - add SPI transport and FT8722
 support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Henrik Rydberg <rydberg@bitmath.org>, Douglas Anderson <dianders@chromium.org>,
 linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks Uwe, both make sense, will fix in v2.
