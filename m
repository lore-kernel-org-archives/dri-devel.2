Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611C8CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B690D10F63D;
	Thu,  1 Oct 2026 12:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jFuxNW7m";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8A210F63D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:08:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 092FF60A57
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B493E1F000FF
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790856530;
 bh=Efy2GeD05EfphIFlVWVsMtlBk1ymm+KYQ4arEyy8BdA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=jFuxNW7mZ6qbHWx10RpXY9VNIRo4YZY2IZO+QYiVSPtGw0ROAJE0HCnGRCXFPMs82
 vdPe+j6DjROF9Xhzx3kcKTcR9jVUXE0WLj5JNDWaU9IqtI4JmsSTPApfuwRbp0FEI5
 OxGSK1shFcVAlFD3IMwK9ktrLibYGUFV/CmxWTanATzan5kRr1W46mtgGKPbg2f8ez
 MD7iDcGg5ZeR06dEa1ngOCbJ1YAZ3sL5g49Ks0lMioEN1T4iCen72sANcOGa2C4Y5R
 IcH28i0lmwQWnAwGirOTo0bJOkv3bmQ47J99vL8084ix7NQJe44onCLJ/c2NtV1ZM8
 JDgOHDrKPWqZQ==
Received: by mail-oo2-f39.google.com with SMTP id
 006d021491bc7-6b4bff33ceaso3763624eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 05:08:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByGZbNyioCmGr+9LbQTRPmQAayKEOUI+UUVqF6W3x7rQ2ZO4OyUG10QnXUQ3i8MReCKII8hUsGA/QM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mbjz3XN7sZVPhfFwbmqUY+6pRk3KsIrrihDS71dLUgDlERKbC3
 CyTXqgDDU5kftR8wtt9gCldmuw9XEqmHfv+f9Dltemo8pZnFRE5rxuM4Pc5GgEeJDyL5B7hLBu9
 a4Z5D2Q+RDfFEW6rsw0NOsXUnPWAUYtk=
X-Received: by 2002:a05:6820:709a:10b0:6dd:fdda:290b with SMTP id
 006d021491bc7-6ddfdda4299mr1394070eaf.57.1790856530140; Thu, 01 Oct 2026
 05:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
 <20260908-ebbg-ft8719-fixups-v2-3-5454ae1f5581@ixit.cz>
In-Reply-To: <20260908-ebbg-ft8719-fixups-v2-3-5454ae1f5581@ixit.cz>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 14:08:35 +0200
X-Gmail-Original-Message-ID: <CAD++jL=KPyt384bEcrTR1V6y4WH3Nkz6w7rsVxZUjnJZc6_uTQ@mail.gmail.com>
X-Gm-Features: AclHuK-CfO2vaNrbhnpcNDH7OQiVrROdFcvCpCkNzNhxCoBuSHJS-Mb8OG4p1GY
Message-ID: <CAD++jL=KPyt384bEcrTR1V6y4WH3Nkz6w7rsVxZUjnJZc6_uTQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: ebbg-ft8719: Split initialization into
 enable/disable fn
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
 phone-devel@vger.kernel.org
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

> From: David Heidelberg <david@ixit.cz>
>
> Move the MIPI commands into enable/disable callbacks since they
> are called between prepare/unprepare callbacks.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

LGTM
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
