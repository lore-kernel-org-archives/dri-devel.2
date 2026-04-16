Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30F4F8D761
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DBF10E910;
	Thu, 16 Apr 2026 17:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="oask+gMV";
	dkim-atps=neutral
X-Greylist: delayed 373 seconds by postgrey-1.36 at gabe;
 Thu, 16 Apr 2026 17:23:52 UTC
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D40B010E910
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1776360231; x=1776619431;
 bh=uQhh7fVSeHYthfwhCsVo3JOVslYa6oeMekXrkvuQWs0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=oask+gMVH+Kf24r8B1EAjCDdwMOw4KUIObsiPI0dKsbjeDerjCZ3kJUeJ+Y/Mt2rq
 WwMYIjSLd1B/X+GRtyqAtoNzFSwDN8BztiItL8vk1vht8FF6irT3T4t04UPbZw1hZT
 +s03YfKh6Q+BhpbSQPOMZAGYdOMjby9ARnFScOgtYpoRPCHLLsfqP4MScWsOVSjo2C
 V0Him0gvrhex8LdUuwFRnJd7YU4WCSLkB6qzw1KWBQoJPwHFYeR9Pr/A7U+orPKmRL
 kbtZhkL9B4iIfi0EbOAGqb/mm+N3JgMzW9s82Q4KGTO6SZxLllCdKnuqY75W0v65qd
 wQ4MBrV+aZ17Q==
X-Pm-Submission-Id: 4fxPxd1vCbz2Scm2
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] drm/tyr: implement GPU reset API
Date: Thu, 16 Apr 2026 20:23:45 +0300
Message-ID: <20260416172347.209317-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260416171728.205141-1-work@onurozkan.dev>
References: <20260416171728.205141-1-work@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 16 Apr 2026 20:17:26 +0300=0D
Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
=0D
> This series adds GPU reset handling support for Tyr in a new module=0D
> drivers/gpu/drm/tyr/driver.rs which encapsulates the low-level reset=0D
> controller internals and exposes a ResetHandle API to the driver.=0D
> =0D
> This series is based on Alice's "Creation of workqueues in Rust" [1]=0D
> series.=0D
> =0D
> Changes since v1:=0D
>   - Removed OrderedQueue and using Alice's workqueue implementation [1] i=
nstead.=0D
>   - Added Resettable trait with pre_reset and post_reset hooks to be impl=
emented by=0D
>     reset-managed hardwares.=0D
>   - Added SRCU abstraction and used it to synchronize the reset work and =
hardware access.=0D
> =0D
> 3 important points:=0D
>   - There is no hardware using this API yet.=0D
>   - On post_reset() failure, we don't do anything for now. We should unpl=
ug the GPU (that's=0D
>     what Panthor does) but we don't have the infrastructure for that yet =
(see [2]).=0D
>   - In schedule(), similar to panthor_device_schedule_reset(), we should =
have a PM check=0D
>     but similar to the note above, we don't have the infrastructure for t=
hat yet.=0D
> =0D
> Link: https://lore.kernel.org/all/20260312-create-workqueue-v4-0-ea39c351=
c38f@google.com/ [1]=0D
> Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/29#note_=
3391826 [2]=0D
> Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28=0D
> =0D
> Onur =C3=96zkan (4):=0D
>   rust: add SRCU abstraction=0D
>   MAINTAINERS: add Rust SRCU files to SRCU entry=0D
>   rust: add Work::disable_sync=0D
>   drm/tyr: add reset management API=0D
> =0D
>  MAINTAINERS                          |   3 +=0D
>  drivers/gpu/drm/tyr/driver.rs        |  40 +---=0D
>  drivers/gpu/drm/tyr/reset.rs         | 293 +++++++++++++++++++++++++++=0D
>  drivers/gpu/drm/tyr/reset/hw_gate.rs | 155 ++++++++++++++=0D
>  drivers/gpu/drm/tyr/tyr.rs           |   1 +=0D
>  rust/helpers/helpers.c               |   1 +=0D
>  rust/helpers/srcu.c                  |  18 ++=0D
>  rust/kernel/sync.rs                  |   2 +=0D
>  rust/kernel/sync/srcu.rs             | 109 ++++++++++=0D
>  rust/kernel/workqueue/mod.rs         |  15 ++=0D
>  10 files changed, 607 insertions(+), 30 deletions(-)=0D
>  create mode 100644 drivers/gpu/drm/tyr/reset.rs=0D
>  create mode 100644 drivers/gpu/drm/tyr/reset/hw_gate.rs=0D
>  create mode 100644 rust/helpers/srcu.c=0D
>  create mode 100644 rust/kernel/sync/srcu.rs=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D
=0D
I messed up when sending the series (part of it was sent as a separate seri=
es=0D
[1]. I will resend this properly, sorry for the noise.=0D
=0D
[1]: https://lore.kernel.org/all/20260416171728.205141-1-work@onurozkan.dev=
/=0D
=0D
-Onur=0D
