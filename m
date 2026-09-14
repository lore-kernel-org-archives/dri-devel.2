Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FAAC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 06:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B05A10E113;
	Mon, 14 Sep 2026 06:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a2/sBXkD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B608110E113
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 06:46:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E23141158
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 06:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5324D1F0089A
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 06:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789368373;
 bh=vf4OTWCzFptFtUWwqcIcYq0DPqdjpvNpZ1b62htJOyY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=a2/sBXkDEvAnxG3hoWBe1n1dP/Iy/ykZvceoPjfJOB0j/udqY/yBdt7/lYRUvcWro
 t4hOFAjpnrUyiWSTlbwcItaskCBrSaub2mHJfpbokmGY962rCN9nXcE6wCsBv4+hdV
 OaDwRo0F20TswjTzgCc9EMqT9Lph9VNUc/qvFFqb6HdVw2lDVO2aAUl0dbknZX+S15
 Oxzh8Q+OGTvLDAfsCBlgeB5wfK01nzLxEfX4LlYKcxrvY644INztJWzBBY+LXFk7j5
 0fD26N71Ral4x/X04jxEL28hxNslTHL4tPkwZzSp6kEtiwsybrKjX1J3ECc2e+8Aav
 8/HMOvgaql3qQ==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b899413537so2768046e87.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:46:13 -0700 (PDT)
X-Gm-Message-State: AFuF++nX6v60oc4jhC02HGZb8RLBmOPBnJ7q8ZPdR9X1W0v/8HRcx9iK
 SmbSqawT6sWcV5K0SwsILKSPG38bC2FGY2jt755YgkcR+mh7ZVVYcu3ljNT6tcU2qkvIavHxFBs
 ecdSGt9VOnb7Xht2Wc4/da8qleMLv1oc=
X-Received: by 2002:a05:6512:238d:b0:5b4:b03e:b17 with SMTP id
 2adb3069b0e04-5b8ae662512mr248644e87.4.1789368371958; Sun, 13 Sep 2026
 23:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-drm-panels-sofef0-v1-0-9e841645beba@kernel.org>
In-Reply-To: <20260903-drm-panels-sofef0-v1-0-9e841645beba@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 08:45:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLmasG382jO8ASY5bCO7BREJUTF47yA=145yD1f=Xauahw@mail.gmail.com>
X-Gm-Features: AcwNN1UDk74CFwFD6WoQYGv69D_gXD18YTMm7ykM6jej1Wyo1-Vu6O89szatReU
Message-ID: <CAD++jLmasG382jO8ASY5bCO7BREJUTF47yA=145yD1f=Xauahw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/panel: samsung: Share test key command helpers
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 David Heidelberg <david@ixit.cz>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Yedaya Katsman <yedaya.ka@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org
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

On Thu, Sep 3, 2026 at 11:21=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:

> Several Samsung display controller drivers use identical three-byte
> commands to enable and disable test key levels. The commands are
> currently repeated as driver-specific macros or raw DCS writes.

Patches applied.

Yours,
Linus Walleij
