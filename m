Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3B2C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3173910E00C;
	Fri, 24 Jul 2026 07:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UCmiJVWV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D92810E00C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 07:23:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 191F243EFA
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 07:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90691F00ACF
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784877805;
 bh=0eQpJOs8a4sLi2e+Cp42G70EmXow6xIAasnVywVwzqw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=UCmiJVWVyZysm2B9//3gwg4d9jUsIQNC8+s8XKZqKfYZ4cIi0aVw/WHlG+KK5J/sb
 6VYfIC7+kynvKZAtpBdnrAiAhkuL6s7/4Hewmuc0twlD4nMvSTbJdhLaToXIs34W5+
 8CQBY6gTxADOWN44rbxriudVVUp7ZzD9R+hipPFv4zVjV3KGdlNB4Pe/2iOjwq88/Z
 P2pz4sEYl649/VcKQUL/rkWlM0TrU5/qRchThBsCM5aBf79qUYwViEw97kln+00b1U
 SvLwfhHXSIFfnMny4FMeRlqy/OoMpsxvsYxL5Wqkmm6TKaGF5VxW6SNC5lsZrSvRkd
 rVsGiSy1XJkyg==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5b00d083818so1054727e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:23:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrUvRA27bRgSJFKt1jL2IEaL9g8kDnQ6U1YhGpbsFH00IpammgsjtREaZn9PioeLs1KwHSchZMvetU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOEklpFZt3NPSuKODL7wDILvpwj3wZDWdyv/NMp9jefrGDqXzF
 oD1GzniCWBai9yOAQKOkwDQAG1kuaZixBKtw7z4Qn2P1gKawZTiiGWGz7u5cOIVcWFSTAah5scF
 qH567DQUTlShAOXSO/aFhzfpkLB8nsHM=
X-Received: by 2002:a05:6512:3b1e:b0:5ae:c3c6:245f with SMTP id
 2adb3069b0e04-5b2b303912bmr1100362e87.7.1784877804719; Fri, 24 Jul 2026
 00:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260715024130.186416-1-pengcan@kylinos.cn>
In-Reply-To: <20260715024130.186416-1-pengcan@kylinos.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Jul 2026 09:23:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLmqJ9JYnmYKNkMYt8Y9XG9=et3VLrEd8Tv+9M-xFAeZOQ@mail.gmail.com>
X-Gm-Features: AUfX_mxmkI9aKkU_4f4OIOyE4P8FJoW1SGNBiG6fjIbqTzr0a_cJGJ4mks0xHjc
Message-ID: <CAD++jLmqJ9JYnmYKNkMYt8Y9XG9=et3VLrEd8Tv+9M-xFAeZOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/tve200: add OF module alias for autoloading
To: Can Peng <pengcan@kylinos.cn>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, eric@anholt.net, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Jul 15, 2026 at 4:41=E2=80=AFAM Can Peng <pengcan@kylinos.cn> wrote=
:

> The TVE200 DRM driver can be built as a module and uses tve200_of_match
> as its OF match table, but the table is not exported for module alias
> generation.
>
> Add the MODULE_DEVICE_TABLE(of, ...) entry so modpost can generate OF
> module aliases for OF based module autoloading.
>
> Fixes: 179c02fe90a4 ("drm/tve200: Add new driver for TVE200")
> Signed-off-by: Can Peng <pengcan@kylinos.cn>

Patch applied.

Yours,
Linus Walleij
