Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25706606A335
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+OfHKVc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C9CB10E8AA;
	Wed,  4 Nov 2026 12:11:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D372510FB78
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:11:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0922438B1
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806561F00A16
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793794296;
 bh=P1YQxp3XsCTd1iLiQ6IyjPG7JvNJZEb/3zHJJtVDzw0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=f+OfHKVc20zlD2vQQYsmK2EZu14j3FQdm5D59yiF+0/UZfxlu5q9/bHsUh7SWGJ65
 UYeLWbxuXpvY8VjGQ8E8lfgRw504OtohnwjG/wjGLRqhogwdIc2cLhvOl/TX0l+5yU
 CW8lhpz7S+/XDHcm4HjoGDKPEzZ/Z3TnHMYNXn1lFiGsgcrqx3X8TiLIEXpOqSdUpf
 2NsPm+RSxY0w2ptwMiBbfoUKQgpDIEBOiUrL+c2HSmGriS7c9FNqz7WNxOZ08v8aFK
 HToUPIqM4aRM20ugCaImD4tUtNw5eY5gJD4iB6S7kF1ayt26rlPjfeSdkbcG2znj/o
 6rRsbKolYHolg==
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5ba3ac592faso655380e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 04:11:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBzVvDMZuH88Bx35cCm80I0Kqu/xYCTU1ONB3tEILuUPm1uD4poIK+UVg4dLaMvrajaUv66axOlvFHg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+k7hjqKpthuFNgqgcwBwqwCs2BpaEUzscohvLWM2yCzMdQnr4s
 40j4aRRq9xDq9VwnGaZu014wRv489tTZKgKvB/4cQk2NDGLDjESU9648HRjM1uMw3SZocSgAUpX
 he1Fw5/v5otFUZq0TE4AD4YIE0PvXq0o=
X-Received: by 2002:a05:6512:1250:b0:5bf:b945:4334 with SMTP id
 2adb3069b0e04-5bfd9583e31mr5118063e87.67.1793794295307; Wed, 04 Nov 2026
 04:11:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104073813.42429-1-amittibi123@gmail.com>
In-Reply-To: <20261104073813.42429-1-amittibi123@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Nov 2026 13:11:23 +0100
X-Gmail-Original-Message-ID: <CAD++jLkvgQN+6PvYD5jag_hGSkMcyw37PS1qbPHBPJooZ9ZqjQ@mail.gmail.com>
X-Gm-Features: AclHuK-0hyE8vjWYyjjwFPCyxZUvs4LI93ctjtI7wKXVJH90efTHDZ845WZHkoo
Message-ID: <CAD++jLkvgQN+6PvYD5jag_hGSkMcyw37PS1qbPHBPJooZ9ZqjQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Replace deprecated DCS display-on calls
To: amit <amittibi123@gmail.com>
Cc: neil.armstrong@linaro.org, hanxu5@huaqin.corp-partner.google.com, 
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, icenowy@aosc.io, 
 jagan@amarulasolutions.com, robert.chiras@nxp.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 8:38=E2=80=AFAM amit <amittibi123@gmail.com> wrote:
>
> Signed-off-by: amit <amittibi123@gmail.com>

No commit message? Why?

Motivate the change, especially since it adds a lot of code to a lot
of drivers.

I guess the motivation is multi-context but spell it out in the commit
message.

Yours,
Linus Walleij
