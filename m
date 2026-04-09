Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC884E98FD2
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5221B10E2E9;
	Thu,  9 Apr 2026 09:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Ch482v1C";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A603910E2E9
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:56:15 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5a2c500750dso734470e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 02:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775728574; cv=none;
 d=google.com; s=arc-20240605;
 b=GgkdUNKHmVQzEN5e6x6poEds2WqqSdH8snBGONGIInmqLt9MpKMWuZVnhBc+Gwh1oE
 er1GhRmPf70AhMT141mcFyzL0lbKCNJOk4RgipYqXPxNM/qmh8ASJtSW5QcD71eGPNQO
 N5RIhGzMfT522jzzt+aJgwNYShlrZphRXqfHh9FaIY0gYsIEk3CjrTQDsSv/cDm9wKYg
 i3sPMGdaLboNzjfEBw+8gANV1H2Gn+hClR4jzwWOGUTDSyq7/wJFxpr0jzWUJiusH86d
 M58XVlQzNrNGeDs+fjF+4PGFWCd2lZjpTjwTaGa0WeXvy5JTfvC3dYKRv3jTewL+f78D
 3R4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c9gSmzhinqcBOsp12tJEIswm4tlqqYWiTBRIxxnDOpk=;
 fh=XCjD+z4z32qo9HtfAnlN0xrjk82cqsgX7z3SnrQsN2M=;
 b=Wa9D4BVRZQ6kv3FuqeJzeiybM8PIdh3yZboIVCYQvZprOGodErMtv2F7Q+QWpF6grn
 6y5TiZC28cfwx8NOc0FaN3El/O1VKdfA6HAxeOU++Np9L316CuzFElBtWEdye9kTPAif
 nAoj+ZvWS/Nq3e6L4u9MjIBFRON/76c8W9C6sOG1RTjFnjpqzhVt43sWKcTdYi1ytE4D
 /21Hrct4osqktGmWtP+/XRMF+tRyrw+SMeahgQYuYqvB496z8OG/rWbTRRfYI+glkVWn
 m/IlvhsG2k4a/DxSADdicCLPsou9ee1dGUUT6LcsAlj4NGKsGicWJOKxM00VbH6hj6h7
 GKPA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775728574; x=1776333374; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9gSmzhinqcBOsp12tJEIswm4tlqqYWiTBRIxxnDOpk=;
 b=Ch482v1CaSph+cW4x1QpS8tUX2neEHbVWmr0xim4Vg7CQ5cIlAdLrItn3lkWJnllg8
 4FmqCizVzslTO1h/olNbfB5PSBfCMpsE0rs4ufAMVOCBDsW3WiuJvMntUNgCmkzjNXJ9
 6H6uAyNhwFjYiIS814nQdwAsXtWjHAEEX68S3Y/r9+OIq96IXrNsglNJ47i2v27Ds9SA
 FfKSoLQXzMBxwG8xUBBzcLcXOX7TJ/THQlCuX4It01c6fgGx8N7MNTraOxa5mjFn1ULP
 C4X5LvuRwGZZ44pIN8qkdPlHhpS6xQVyMHpEHNogHnhaNEHisZHp9j3dzbeShWAs3gwf
 weVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775728574; x=1776333374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c9gSmzhinqcBOsp12tJEIswm4tlqqYWiTBRIxxnDOpk=;
 b=o4y8mG4HhagyiNRWPVDZfTzerXXzdHWY72ZFnd2Tzvu6Wo8/4Ol7/MVkaXQJRcIRea
 NjFwRhh/nSOJ1ox6irA7a4J2gLWHbfozXFl2TlViiTPaLDjOEtEyTdp9VxRoIxGKG9dI
 3DTcvi1ZA1nfRNrYFiB7v++dsJ0lACjiEpu0KCcugHyV7vX9+CYuSmkzeK8LTxsulIbv
 6Km9dlOc7fulTAWZaS3tWPQmgViMGSoVohiGsQbuq8hOvkgWKg+zd8MdvVmPUtpekoIu
 0MNeG8HWM5qPscAj+yZ2w6uNKtt/WheTye8ySocsSFNNA156RLHrm9JvC2xFPqM3WHWo
 Guvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIXLQvE2UxU1bf5k+WGiy1veebI2g0npMLXyGsW0LB30Ft4D8tnaPcdZMFhUfL3beGVExevNnxyF8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoUTQPVWkw09Y3C+xCOn12/xsnUceVTdQBHL8IY+rJNaHVSdFb
 4tXRaV+g/AzrbkmGihDKSpfHWaSbH0tW1/W+ZvxgmdQphlutooGgSm9qK9R2eDQeyL24LCwaE6/
 xl2VEh1xOnP7E62FGD8q9OnJnscpS7OfUxPdHPUgzAw==
X-Gm-Gg: AeBDievzFgXbrsDMwKfY+sW3zLTjnf0GXjBtipYLSUu0DRBJk/kZ8XhQ0j/np/URzpP
 PKcSM0EIRrUcESg7sxKW6wOrjrwcwlQSsF54lXoTLbgpR9FPRfxiPL3WmdRlFhUkL/55PA1TR4S
 bSXHqzRx8oQFx9Yibml4l3iLL9ysykISkRRzoEZyDfiiCXEFaS0xJhBr6yfHYUB0HpmUrFH56/u
 rjHkK1sH2zTihI60IpDNo5+CfU6mlIdhI2JHuWMBOLu5VwK9xVgdUjbMfni1lpppeBiZssBWIyf
 kinqmB+emmmj/1DHcAV+JbiYdR18/SEzCgWfLyyB
X-Received: by 2002:a05:6512:15a1:b0:5a3:d2ef:2f9f with SMTP id
 2adb3069b0e04-5a3e7a55915mr1032829e87.20.1775728573604; Thu, 09 Apr 2026
 02:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251104111339.128685-1-marco.crivellari@suse.com>
In-Reply-To: <20251104111339.128685-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 9 Apr 2026 11:56:02 +0200
X-Gm-Features: AQROBzA989_lfiY3-RS3NH1OmL1VlMwSv3RIEazol177q-esTpt0aSeJYDX6spE
Message-ID: <CAAofZF7aiLb4V00CuCVz8yJFhQgCLra1ue-r3q3PRJiwTKwzjw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: replace use of system_wq with system_percpu_wq
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
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

On Tue, Nov 4, 2025 at 12:13=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  drivers/gpu/drm/bridge/ti-tfp410.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Hi,

Gentle ping.

Thanks!

--=20

Marco Crivellari

SUSE Labs
