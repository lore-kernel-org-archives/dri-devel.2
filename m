Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED19EDB7DC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450C610E39F;
	Tue,  7 Apr 2026 09:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m8JOJBER";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8ACB10E39F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:41:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FD46442E3
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAB6C2BCB5
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775554866;
 bh=8SsH9km5SAPgEpA4A8y8P5I4CMQaaNq+s3t7JW1Vj4U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=m8JOJBERsYI95/CH4JpQNjrjthcI64rsM9S9Da9h+DVNs99MxjlHJbDb5gY+G90Ku
 2bdTelWl2YBcvx9r/adp7+awLosyMEukuPeLjqKDLUQI6U0ym3+L0EUMxIBAx3ZYWw
 yAybDA96+zImeL9jFiQbdah32ntGQtcEoHe4QWf3h8RsIyFGaG2IpBT60siqg9x1of
 PTy833Gjj/OuNGJHaQn3kqhLxGtNTF9mfynaa2Srysw1HvSo2pkTSVDhmkuTPrDTPu
 inqct8VhoMJgeFQJ+fUKDiP98gVvPRosvT6DxbrgCXUl94N8wpYSTH9oSp7KU5W/Wy
 u+9NvPsb8LP2Q==
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7991db3dc98so51407617b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:41:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXeudvu40Sadup7mn/163a7QmvG2Ztyk5Ikdw9ouZmDf3YZJxmPj3UTVArGvlVFe8/fbcp3ehwcmFA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziwlP98MBvNMVAQSNTrrZC1vh8Wnxtd/oMOVm+UajKwtA6Kqft
 BSEYeQk70PtDFjMSddqJEXFNX0RiafrPZY1tE2X8TEfTAhTcnJZEBuhC7C3AFEKPJkS5j9Tfbju
 m1+TN9zXkPhZEBOtMvgAbb0E1zVAfOg8=
X-Received: by 2002:a05:690c:dd5:b0:79f:2e53:8606 with SMTP id
 00721157ae682-7a4d5c5e341mr167507727b3.41.1775554865754; Tue, 07 Apr 2026
 02:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260402-drm-bridge-alloc-getput-drm_of_find_bridge-4-v4-0-421781c8c061@bootlin.com>
In-Reply-To: <20260402-drm-bridge-alloc-getput-drm_of_find_bridge-4-v4-0-421781c8c061@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 7 Apr 2026 11:40:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLn7mP0_vDSSrvce-C+o20_sqNpviX7BKWTRn_uX8sNgnQ@mail.gmail.com>
X-Gm-Features: AQROBzCfmWCuyLKdrRJGc7j_WCHfiMGHBS625Ijb9YPfc09N8yvcvrOHpbgfT-8
Message-ID: <CAD++jLn7mP0_vDSSrvce-C+o20_sqNpviX7BKWTRn_uX8sNgnQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] drm/bridge: convert users of of_drm_find_bridge(), 
 part 4
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Thu, Apr 2, 2026 at 6:27=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bootlin=
.com> wrote:

> This series converts many DRM drivers from the now deprecated
> of_drm_find_bridge() to its replacement of_drm_find_and_get_bridge() whic=
h
> allows correct bridge refcounting.
>
> This is part of the work to support hotplug of DRM bridges. The grand pla=
n
> was discussed in [0].

All makes sense to me. The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
