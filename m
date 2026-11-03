Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D256606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kSTARXTE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E6B10F48E;
	Tue,  3 Nov 2026 09:32:47 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5796710F496
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 09:32:42 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c38ac26cc5dso606740966b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 01:32:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793698361; cv=none;
 d=google.com; s=arc-20260327;
 b=WRNBbm/R2acbEO/3cL7paT32gz+k8fzs5crRKIv8jWxwdt6ILzTbZfpzEYBpfCFYRx
 bmKSz03I+m/RD8Zt/FzDvWCn5dgBuqZvjOe1kQgdotrg7nDFOgol+2CEeq7rZHzFzeCh
 /wNmmAfd2StKHt4nY/PEVUeQdREexoGONoMrPEElnQsW8krt7RGjluXYEYI/9P1Vsd3R
 XwtY1mwvOZHn6Q0rtSTm5UQNHT54ffj9pLXnhMa4/EiMUfADvjjSpvk4RR96xgDIfcQV
 55fwvOYTU6kBof1oWVOdhVZH8Rv8eLBuFciGLOoaubcF1pG53YvDN4/5cp9ts3d/Tjnn
 Ke8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EyZKRdruJnIAj0M6vq8KCInmZjQrUNKMEcYKRcp5WjQ=;
 fh=fV5vrg1ePgWcV3IPPyskrmNppDyEWKJCHLeP1T++usA=;
 b=Ee3xPtan5M8M9MNhbFPbiOaLUAk8eIFuGTTNtnQPlv6Z4VmyxAaD4QiROfjivIjSov
 E4zv4PrsLau+tdov4g+biuIla2bD22PmXRgH4sSUYMGNw1wh8pFTiouO+IngLzF/9nbK
 PSDlOVh0d9tOGdwZCLvt3MqtDt4wTXD0Gif7EswSBGbkLIsh6tcPklbApfmEPiLCjAbq
 YtpZN27lZDLeuhRX9X7SqStNAf2fnKfxuoXvjaISQcY+sa84k60jQTT3RCSPgNgIiXE0
 a2zNB4cAn2LwMk9iB88EP4QG201ALoWKhGuyNyvJAM3Qpgb3oHlWa4BGvC7BBcuUXe8X
 O1fw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793698361; x=1794303161; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EyZKRdruJnIAj0M6vq8KCInmZjQrUNKMEcYKRcp5WjQ=;
 b=kSTARXTE5thNX32e4Hyx6L38D7AHqkjhFlt+YZjvWe1jhNbRNXyrsJ9ARzs6WM4s44
 swUKGD9pkIqUdWSspWRU+y4v47Zn14v8csMSsXdqhr5m7fc/+QWmUSt84JNDFM+giVxv
 c12LG2XdR+3YMmy6Z07yXxpav+8iBmCmZquUcbmBNtP3SAaoyq31tNHqnwWrpWQfJFQk
 1L0VHGk6mBp3D3Pi3p3FuNTPNHkOr6jl6wvi6eakne3HNF5I9N7YkVuJIMS9irCfZJ0O
 0NVN+wG0BWTwPd8uT5hxCyEj8T2CyL5IDOnjaF8KmkVE4UlEd9YLwCA2xhmYQKdJB/h3
 A6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793698361; x=1794303161;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EyZKRdruJnIAj0M6vq8KCInmZjQrUNKMEcYKRcp5WjQ=;
 b=sjpVfn8XGvJEDruDIIy1Hc8i4ZmHnuj4cbpngwyb4yOW6lqNbZKhbM3z1sp6RowmXC
 fuEyTKlAAttjdjYhWlLyyBpnba6dDi6BCZU618AtFmLI615KK/pqETaYVMfUMOUzrw/B
 Jvv7O74+utMWdZy2bKQsYrTXjpNsJcwJEqoOrnVO71pOMHlY74UcBkJ0cJ8WF5v+xhF2
 VRV64y45jNvHbbt/C/jCjmRJLoM1JmbjjCTKc6e/Jlvk7TgtdAoP7mucVUe31tBlpev+
 8IjJM2c782BaBfYMFJURG/XbTx4hEreYxBtPQu7i1PaLx5UlWDDMz6G9+WQ1jjqtnUV6
 tJsA==
X-Forwarded-Encrypted: i=1;
 AKwUvByAF2JGpnRd05jvZIjUk0LD03c/IijvXF99yV+9NfpjPK+RFiFibiekdDYGS9tS4CbIYSP7qJtDUwI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9VB4b9ts5kWWp7sXVwk4lVVwZm23Dpmo90W5o5t/yXa2KR6IW8
 e+yxUlcTWoRkyc1xT04UN51jlxwRprAeLhmJBz1HjPTts3HjRFeHfMERUy3v/tDer6Q0JE1+sNH
 vF9Yjdo6uSxV9tcbnec3vM7Cs0gBH1Lw=
X-Gm-Gg: AYBFou2uuc09OpLWmR1FVVlaO2tbROPpzdTsqUJZg7QfIgT3XgZvh0ihZGALwmFGXQs
 QxCatQSOTfWxOJzgS4b8B2CR1zgbd7MDwSturDBIe2UwhLOFw8pVtdpmWX4xBbPY6n/EcDQQxMl
 rvYtqIa53moRD2dE+rGh/TjPwNsv1zXv4uKCXvzdJo1bwttDwIrcppll9NyIhNWoyIAzOWFq31W
 O2vTCm+ECzWZzHto64FMdM34J1Z14YUKn7I3lODuB+hYk430w9v8tMwG//R3XER802ZtCMViW0K
 YdZ/EAkQaSAJRuCv0tMNxyzOZtkF5tCkonap7Z5tQKQI1jMUIbNuOhklh23/CNVcdtDn/5ptBdt
 4EPb5NP4Q5uPu5SW1m2p4yuh03Qc8IQ7CVjvCCON5QARfOJmpzihtZy5bQz5K41hl1wzI5OlhpY
 +vZ+brZtxXwZ1piaJQEsb/1acdQU1seFaQKClx8y6DVHkmtcep6bwYQ+kl9QPTB+aIOfHg8lt+/
 eIeGwZO5RHIKscKi95+dC787g==
X-Received: by 2002:a17:907:6eaa:b0:c40:bbd2:62f6 with SMTP id
 a640c23a62f3a-c4ca7a730acmr1005018566b.19.1793698360533; Tue, 03 Nov 2026
 01:32:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101184915.33899-1-amittibi123@gmail.com>
In-Reply-To: <20261101184915.33899-1-amittibi123@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Nov 2026 11:32:02 +0200
X-Gm-Features: AclHuK-RtmLK_Q39u8fbW3hnbONKklVvIvh3AUZDr2AgWSlxsUma7DTEWb_oDSM
Message-ID: <CAHp75VcnkufMDT-NV75jzR6qKH48KbPnUgFHUNrHMATZ9NQrMw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: remove unused ssbuf member
To: amit <amittibi123@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 8:49=E2=80=AFPM amit <amittibi123@gmail.com> wrote:
>
> The ssbuf member is documented as unused and has no
> users in the FBTFT driver. Remove the unused member
> and its kerneldoc entry.

> Assisted-by: LLM

Drop this tag (it's outdated now), instead use comment block, after
'---' line to describe how you used AI.

> Signed-off-by: amit <amittibi123@gmail.com>
> ---

...

The problem is that Greg KH won't accept AI work against drivers/staging/.

--=20
With Best Regards,
Andy Shevchenko
