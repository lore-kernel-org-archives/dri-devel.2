Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992E606A33E
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qe7Oy2VE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B41A010E3C2;
	Sat, 24 Oct 2026 20:52:32 +0000 (UTC)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4803510E3C2
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 20:52:26 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-679e86015e2so3098520d50.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792875145; cv=none;
 d=google.com; s=arc-20260327;
 b=o2VIBvYt9k5EYAGx4T+DO41DeVjVzydwoILUIWd3G2pyF7GiYPmr5Qw5RND73AzIqo
 JaUS56WaG9HKdt1Yu0yp7dSdtnzFMnZoMI+rDHZh2LcAtmnJdMyIwXBQ3xwIYndwrhqf
 b1BwghWOCq8po7PkVwRsKpBOq1JcKZree3zfpR06lgNH7ayrCBg3jXPM2NgrukM2D0Dd
 ypFpKDYgupsbgj76LFYC8Tb4suPMG9OM4PhjHRe7wN4JSd1LTXmn7xK9mVU662Jj9GYY
 oWqodTtuWmzPGdUk7dTHqECvoiVBS8BYxjAcJZvkwApa+xJPPwPR5mngw7kfZ4SHWlu9
 KQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yYB2Eg6udV6G2zXDMbowUufCGYXptrXQq704DwfwaUE=;
 fh=hv5RcvhCRwFVWgIax+Zn5u05ZOB9jUlVpaIqjeDQyAA=;
 b=AM4OZO3wKTN+2L9dZJUiAsMrefG87nbYrO5XVJz0tGOMIfgZo8HYbg6rVY8aHkFgdN
 4YJ9PDv7wY1eJWPUDIbbwnlAxwMq5oXmiPc/Om3GXqjsGMMETyDyeDo03v7zguBTUiQc
 L/5v513jlZjQG55pJlxrndmbScrjvcCysm5NaO+ioGJpGry3067qtBpBzZ5lA9n6F6Cr
 sKoKnMycGLpg2FF3nHOPrp4lWe7TTfYEMM+9ToZGobrQXnDab02jWCkJSUo7yd5ghu0c
 Wj+zWOtIgFPaktbLZrrbFv6E8eGCSlr8ZSVx6CODWi0ofWfj0sXsI6KQjcmPKahsAGY4
 g1wg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792875145; x=1793479945; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yYB2Eg6udV6G2zXDMbowUufCGYXptrXQq704DwfwaUE=;
 b=qe7Oy2VEnw6nnR78Z3MnR/NQX4Kcbalq28pw0nFxGNibMyXzH+qdPCvhTn2myp5vRm
 ABzqA1sYs3oEwhfnNiDEIhR6ff/SL4O2SUII9zKuSdZvuKzSltmx/vfgkDUC8ChLrYM/
 qxNgWCItoV57TD7zIQwSSH7F/9fW9EL66rutfXGsrqljmz0R36pXuB5QpEY43lY61QoS
 w/5xGFbZkMqderw3p8k9u9lv992h2yEZHAAwlH7/iJ8+As2jfnKNivMpH7pJvHp8RY+5
 wUmD9AaSHRO6y1lKP6kWx0Wf41wCboXMz8C/m36AfvWVFWa1llEKs+gOBvN8xSWWjdY/
 WTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792875145; x=1793479945;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yYB2Eg6udV6G2zXDMbowUufCGYXptrXQq704DwfwaUE=;
 b=qg8VMLuZ99gFOR0TZPd2qz8hLt7z8y70sXBnDFvKXHYM5rdDvRfB1vxGDHf+Xd5uNo
 5ZWfUE9ZwcqaysdvaeQBKrdpjsYNNjNCgHz/Eqx2Q7yPqzp06EZdgup78+GW44CrxK1O
 K9L7pHAJTfm1YRV43XI2Uu30u8gWnRuuOk7hUAVROquo3/qP2DR2rTBFCtEqRFMfs3X4
 RROB/ze54HEA0yb0Qpi7O6ePqVqyAum0XcrKOElwmk+KnPehACkS5k4otaqRtlncfeca
 eKOXLqbR/aoKganmuLwIKjXbzMIPIKjGvx3ZoKrBBqDk9DtD+2/9uiLtQ9Vi4su+lJRR
 XV2Q==
X-Gm-Message-State: AFq9FYLwEZlApuUDcoxOxH8yjU48QRlC0AXCzJwg5GcJc4IUL7ysaLi7
 5hWHG94/CBsrY6+gWJqpPPLeMtlXee7KXj5DTLklPL05Ufp/o9CAUH4jrkCq+9LAkfgfzNE5qtX
 7FyyhZJSavTbv8LHBLhcdThsCbEIUzSY=
X-Gm-Gg: AYBFou1BL5OS+8PoEjUHzZXmv3OoQG+pdRjouy+mb7BJfKp75LAL5ofhe53sl5wQ01j
 FcvztbH+6tQD5Ydh17QjDhcnsHRz5epjCDXDyHrKvlh25nGAWf3JI5pYnPRGtiBJy6mBz6Saxjz
 8f3Pg2RKMLPr2C7jtkqlRsq7EPP4DDO/h8vDeF9GLlS0ar7xupgYcAFbFLkJr9+IzV6I/PTVqg/
 2AiQrhBLo9szSRR6r3kvMIEM2tv7lXlMmaGnrMknD5zApecqVUZab6u08fTYyTedVypWr774YEf
 bw/YRv3fdv19DsDsFxMx7jP/JagOW+RuZRf2uJ+72NtIRJUDxVjY+6ZuMFEafsOjFJzWrGY7Okg
 4IlVuzCkDof2wuL3GMhG+uiHcLqmX/3UJKv4=
X-Received: by 2002:a05:690e:168d:b0:67a:5135:14a5 with SMTP id
 956f58d0204a3-67a51351aaemr804930d50.46.1792875145328; Sat, 24 Oct 2026
 13:52:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260809002621.122832-1-qwe.aldo@gmail.com>
 <20261009025857.3027341-1-qwe.aldo@gmail.com>
In-Reply-To: <20261009025857.3027341-1-qwe.aldo@gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:52:14 -0300
X-Gm-Features: AclHuK_dfnf-Kc4CxyGPfhi8r25_KWxp8xjGrUwMZthkPmBOQBB65fixyH8Z6zs
Message-ID: <CAP48Hftd06hQDCZAnQcmMPOQ0-JkBD=OQvDr1onKG3rTMaOfpA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size
 computation
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000029fc52065e9c46b5"
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

--00000000000029fc52065e9c46b5
Content-Type: text/plain; charset="UTF-8"

Hi Dave, Gerd,

Following up on this v2.

Would an updated reproducer or additional testing help with the
review? I'm happy to provide those or address any concerns with
the approach.

Thanks,
Aldo



On Thu, 08 Oct 2026 23:58:41 -0300, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:
> Hi Dave, Gerd,
>
> Friendly ping on this v2, sent August 8.  The original ALLOC_SURF
> integer overflow allows a DRM_AUTH client to create a surface backed
> by a one-page BO but described to the device as up to 4 GiB.
>
> The v2 computes the size in u64 (addressing a Sashiko review note
> about 32-bit wrap on the height+1 addition).
>
> Let me know if it needs any changes.
>
> Thanks,
> Aldo

--00000000000029fc52065e9c46b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Dave, Gerd,<br>
<br>
Following up on this v2.<br>
<br>
Would an updated reproducer or additional testing help with the<br>
review? I&#39;m happy to provide those or address any concerns with<br>
the approach.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Thu, 08 Oct 2026 23:58:41 -0300, Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt; Hi Dave, Gerd,<br>
&gt; <br>
&gt; Friendly ping on this v2, sent August 8.=C2=A0 The original ALLOC_SURF=
<br>
&gt; integer overflow allows a DRM_AUTH client to create a surface backed<b=
r>
&gt; by a one-page BO but described to the device as up to 4 GiB.<br>
&gt; <br>
&gt; The v2 computes the size in u64 (addressing a Sashiko review note<br>
&gt; about 32-bit wrap on the height+1 addition).<br>
&gt; <br>
&gt; Let me know if it needs any changes.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Aldo

--00000000000029fc52065e9c46b5--
