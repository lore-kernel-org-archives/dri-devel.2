Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87BBC982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10D110E0DD;
	Wed, 16 Sep 2026 16:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TKsIZmoj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6446510E0DD
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:40:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3037241B71
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135C81F00898
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789576828;
 bh=NMD7vBQ6RWs/J5cNo+VFCsSkxyb2apVp1B4H98H0FXc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=TKsIZmojAOCZjVkuTEgu/Ojwjhf036GzQdXroxfypwiDNIxHQWqBjvK0vOkxCSOvf
 SDTolr2qG/vfhUXo0swwfHYpn9E8Z47GZVBKvuDxpwgQ1cXXuQh9Fh877873KVTmzB
 XQyqW0MAgfIvsHXGLckUqVpptBkk31pAt/Q9KMAu02W9Fvi9xEodCxZPsLnbYp+k8+
 n+6cOLyimrkEwcaLHYCw4WMeswPWzpUp5oX0knNETQuVaKKQ8xoaEsU1O1qy2GNzPg
 aR+ez/vPscABS5AEn7M4qruHiurIohb0SFlk4+C07AlCWDYM088WL3whOU8RqNtLXx
 JMVjqi15NNTfQ==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b899413537so1630689e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:40:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwgjBU0eVbbZETWEXb5ucyLWV5jMNZuU8I/D/WDsjD1mOAGZNh7bRENQXBpUtElHwrot4pk8o48gmA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mM72LV5wQ1hPYVHMKgQF9yLcpJXXViIkZ4goGT2+YD1aq2xpNh
 +iJmfjvGlFoWYIR5OXrXOzfSrf5YSSPUvYEg9lh7rk0k444JZd+qKS4IOb36jvhERVcDQ/riHTQ
 gfaHvuBBdcp2DTs8fFa9bHVVz0M9/ua4=
X-Received: by 2002:a05:6512:1107:b0:5b4:a836:13fd with SMTP id
 2adb3069b0e04-5b8b661e3a7mr897834e87.22.1789576826773; Wed, 16 Sep 2026
 09:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
In-Reply-To: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:40:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLkQw-U=e43K7Zjdawid5D54hoQFAkVLBLmOsq00FGOoAg@mail.gmail.com>
X-Gm-Features: AcwNN1WRdUJu-Cn8nI0om7fEFyccuBINdekovMd8_4ronkacx1OYdjXuVXiord8
Message-ID: <CAD++jLkQw-U=e43K7Zjdawid5D54hoQFAkVLBLmOsq00FGOoAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Xiaomi Poco F1 (ebbg display variant) fixes
To: david@ixit.cz
Cc: Joel Selvaraj <foss@joelselvaraj.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>, 
 stable@vger.kernel.org
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

On Tue, Sep 8, 2026 at 2:45=E2=80=AFPM David Heidelberg via B4 Relay
<devnull+david.ixit.cz@kernel.org> wrote:

> Been broken in mainline for some time.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Looks good to me:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Or should I simply apply it for fixes?

Yours,
Linus Walleij
