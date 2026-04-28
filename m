Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162BCFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D1810EAE2;
	Tue, 28 Apr 2026 10:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lh2nuyc4";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9359110EAE2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 10:01:48 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43cf8d550bdso9501086f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 03:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777370507; cv=none;
 d=google.com; s=arc-20240605;
 b=Xywmt5xTVObCqDb+Mrchjj6nj2bpwzlncGCtPjHuNcJwgBuLOBwLSDf0WU0z7Ljtwx
 lhGs2jKtJv5G64QFr7MBsCJkOre8YTHX0zbMs79IFLf/13MztoN+Yg9s1kU5p34YB42z
 NPGENQvKIj3lmRKjLL7SYr9mwy2FBMISO3JPiB73JDS7KlRkVffb73SxL4yIcNnWqXYV
 9acF2v4ct7kqD3UPies0kQ6mJtY1Z/wr+PMu9fE7ZeNhk0qPH4jD434r7WU4WU9EKZo6
 sQxJojRMTYVv1zQxP/z7v9kwotXZ8o5ObWTyjQbSc6axnwzdfkc72btBNYRSmNFF7KqC
 ciag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ejtc31VfVANMim0C7tVw1Ik/Wt16XcH03Us2/bf2BhA=;
 fh=g6XX+IXL8Hwp0bHVvEcrA+sOMVcAu+5J/B5qEviEa/Y=;
 b=anHRXEBZKIwD+Jh4WsQb3z3dGupoTaPqUHir4ofOT9xqBVJEtyxI+6YRhgWYCLpLtu
 uhlb3xYD9LwWb7J5bNHnAPdvWeq9EPPAiO80TmHdgV6fDpKuRqeYWRatwkDZThx1zPXe
 pofdYeLgNhY24h0OtQh8Ir+zLkXnvCKRcOAEuehuAD1h8CacQcP0BzFeSn/6MOA07EC8
 1MgHEphAkwqKXp3ahbMAubgQTb96QoaD+dsAWojRSpujQH8eSjn5CQQONV7wX1YmUEMt
 13LSUkQIqJ0f5w0NoRSF5StFicTMxEkoMnIBSnF62FQnvnbZHxukGicv1GkxrqfWGqy+
 elNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777370507; x=1777975307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejtc31VfVANMim0C7tVw1Ik/Wt16XcH03Us2/bf2BhA=;
 b=lh2nuyc4m29YVCnMdRnIjyvzwaYx13sADdoQMzz+4DWRYXA40ZKvDjUBBcc6w/+RZo
 esuOoxz2S1XMfym+lWZFE3h7AlTt2IKytNA3naJCXFC760pviMofqqrdBYrJUzj4LvqL
 cp+K+LlqIkH9NthzfHEXRgzZDOfJVNyyZ0TeLRZasQKbAbPgRiTD57NG//352uz9Ycpr
 wGcNiv2Y4r3zl0vaUfUW5K+JFunCcDJUJ+fUpMZA+ZSy46EO0ZOmgIjqvUaxFH7lX90B
 I/fgAZOQejuri/GLpuvaDd6sjkBOIWj/WSq+hkqWfL8Oc/0kZ3XJG03os0Wy6aJcdQjp
 anFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777370507; x=1777975307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ejtc31VfVANMim0C7tVw1Ik/Wt16XcH03Us2/bf2BhA=;
 b=hhV2lRYaCpWagAV+FkIW5Bc3BiwoCNMysqaxdD6HIUpsn3aI/qO+y8sxBQyUutsSwg
 MyUEChmmC5ZhkOno32Q4r8M7+VsIc9WCjXMPrZrXUFs3B6PRLg++bv9uIv81lh6pMNRJ
 Xr3KnkhQiuA8EiRXjFeayz8tAGJ/y/ghk0JsMMUnAdqchcYFzymgFLs7u3ZpM1dvFID8
 nuC8l+/wm6lVpFx/N+uDMfhE1SDYLRLC8gnH1f04bUoTV+SuiIgQlr8FZXP/dZM8VefA
 RHlBpyBMxmGTjk2uGnx4naAtslpu0xyupy3zOuAYrL5DZ9uwOGyKa82zACKOJcqG2URi
 ugcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ98Zc2xODTb67Yu/FxCs1KMvwrm9Msd0kG7nBbi8zXkj/Q2rK5LvYkwjne+XDfHHvCRWchx1+0jj/8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqBNKAZk0Tp/VASlau8CgI41Zhk4pzIzDieA9/DEZt2zaHxuk2
 YiDqEgWeTNsCh1Qk1Cmsj/iIm0/Xy3Uji6d24eFb4ofsxzjsQD1vB0/PAgzpRQicKQIjJPBhIBB
 HlbFBgATJJzKDzVGTZsYb/X7F7RqcMo8=
X-Gm-Gg: AeBDietAB+Lp3J5zjmXJ+qtSwWXbxQ9A5VQNIpQNs8HlKVY+Y0kqLk+eNrr4c9juFEo
 anPyUK536ROp4lT+BnrPpPynlB4vypquYYsNwurqxY0ghZKB4CkV+Ico/49gp4T3jA0gZZCsFav
 ubaZy9Nm7eYaA3Vaq+KNvzXejPPpbFsHO/i7HQDi9WLmsHG8lod5qF0L0UuXPOraYYVG5vyxmS2
 1Bx18d36GagQWckbvzRRjZD8acgnkH9zL+NKcud7cbGwvSXOoxHU3mimqRjpjYI8Bf1d3b9hwMG
 VmLATUo35PucGDwDfSelI0H7tF/32JZlB3h+np4k8ekXZieAO8jkxVaDbPIvecySGkohKf+Fszx
 tnuGq
X-Received: by 2002:a05:6000:200b:b0:43c:fde7:f1 with SMTP id
 ffacd0b85a97d-44647cda93cmr4590757f8f.18.1777370502344; Tue, 28 Apr 2026
 03:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260427154658.276737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260428-wise-rat-of-criticism-df0ea3@quoll>
In-Reply-To: <20260428-wise-rat-of-criticism-df0ea3@quoll>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 28 Apr 2026 11:01:16 +0100
X-Gm-Features: AVHnY4I4coMls4qeC6jWH5TZaGYTyTrcejKFlzmjg6GLt3Vrx9kUkLIvEYA6b80
Message-ID: <CA+V-a8sPi0FAE3V5ijCN4utxfRjcJbfr05Tn7h4xmk9SK4+sxw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display/msm: Fix typo in clock-names property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Krzysztof,

On Tue, Apr 28, 2026 at 8:41=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Mon, Apr 27, 2026 at 04:46:58PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Fix the typo "clocks-names" to "clock-names" in the allOf/if conditiona=
l
> > blocks.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Note, patch applies on top of next-20260427.
>
> No one can apply on top of next-20260427, there are no such maintainer
> trees.
>
Understood. I couldn't find Dmitry's tree so I just added the above note.

> Please add Fixes tag.
>
Ok, I will send a v2 with the fixes tag added.

Cheers,
Prabhakar
