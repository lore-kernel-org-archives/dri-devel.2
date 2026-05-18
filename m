Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3917ECD4F50
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B70D10E31C;
	Mon, 18 May 2026 14:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QhDjYmUM";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E0110E30B
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:26:36 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1324053d600so135646c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114395; cv=none;
 d=google.com; s=arc-20240605;
 b=k2VJaZYBw7/Zz8xnY51HcN58TNIrsu/EhE57cJPZY5XK1kXicNr8Q0z0EzWQaSXr7H
 /nOGzija9Hydbjgc6R2RzFBwojvFVOCLmjHbG+3KBoBOvb8VUryDE7ZBNR8XqDRSD9Ip
 roJt4Ah/PmE8iZvUW4OOxs5HsyjwWzWEIXrhPaRhDlZqf4MuExgatRHRAKdnu3c8EUsh
 ccwDtA0j3zNdNyXh9eHiPguzD4WSgAwE9Oa7QOGqGa5JG6lkegjjyu3yti/AI20aE8N+
 jTB53v88w6L8fze92lcuXjUSuuP/H4Mdbyi00xk19xA4Lr/+6Rj+5Qgu+wYuAHOk7H+I
 L54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E9ePutv8hI9TYI8G2iFJXpmM8At0fz3YEO455yV6PBM=;
 fh=hn09j7z/FtVi0ixYNkN/lWac8/MAPZfKkfUdu5g4RJQ=;
 b=EpsBRyntp2EYnLpDbub2sMP8ZPdKOaZDHP4DG5tqhW0ED39rkKooI3VrC++sIQVZSQ
 SiaqQoJluH3Kp5AEddBR4y2vdXUDQjoFB4VJTkZTrkSb8rDPz2BWtNhEL1Ls/QhZ4uqE
 PSWmUARL/Kg5a7IZFQwRRNoTt74Ffz2Onv76aYBxKOtfEUAiHXpScnPbEXM0+jKmqcV+
 eug9gJOj3UmubPAF8HMd0jjTvJbdNxAWD9qTSHcdxtQTUMZjdkPY8ag8lusE4C2W257U
 vpTvm4KCcSi6XfFuLUv0WkboBgNczahWjhKLgCHJOR2Z8GYAdxJcx8CMHkBl2XQ3Qimq
 pq1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779114395; x=1779719195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9ePutv8hI9TYI8G2iFJXpmM8At0fz3YEO455yV6PBM=;
 b=QhDjYmUM5/FkqxjjNCRdxyqIHpBG0fFUzem025ijL6yEvfw3ybSHWJz+OcAy1yEI1Z
 2rEyFkAs2w0113Dpq3pNG/MZk+m5mD0FT5NILUUc4XvrtzPCPTAS1AAzmcMk0mhtvcsX
 5uyGgfUS9KAdh1GAhvFIvCBRWLfCCiGIyvUHxo5wwp20WV0B5G5F6m1lAkBt+OpuPuXq
 pxYldm9KJDWAvQWxKdfr9g2hASMnEPAQ0GPOSL7ugm4EvAPNiUKmCg/Di3Rq6pjnQT0s
 Nm6NP4LZJr7r8Dwsf2fTMPNO93c1k5Ebyg3T3yD9XWZrmwrjD9UyB9BGh7RjxhPIUP3q
 KcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114395; x=1779719195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E9ePutv8hI9TYI8G2iFJXpmM8At0fz3YEO455yV6PBM=;
 b=WGl9wk6V43HWACfwCdJWgu19iWV3UuQDHAz4SYVRehe7UkLuGhDtNVMn6l7L9kDTOq
 IeMtmrwgahmLLMg9w7XUX6nEJHTVtU+LHVfhUyOMNzaAwmrKMG72nKY2JGS1GppWxvAf
 dN4SIVr7dQ2+jy0bEicJxPW+gq6yrvUVylfljh358SIjo6aE2JiB4BHo7oqiyRVbwy4U
 y9fIV1XPsWPm9vhAsQfsoxTlJJxgffhNEEgyVsHpFaRVhB6AGjRo6E+uO6DknEzE3ktO
 1OBi+3HNj9N8i2uTtrMnMKgKEfCYNBZ93e52loaI4QcRAnF/m+FMJ3QrmAFwkhBDokgK
 FByQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+b/Wy/EhP40NhXYfK3qhcDac6MVgnRRzef+FrGFxrdJ6MT2ltA7be1mf0uS4AImM+GLPyuc6EV0tQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6ukWP3mdkH+njVFJdNsocMoNUvBi2UZEGOP2RdM6EwfZyGMqo
 eESmKgb9+pjR6VQhI+HJbFKyH9DDTukGUbONiP3H1SSi1RMAuekNA1roRF8uXHUYB5i4jZyIPoy
 Vq+6UHZz0E1ZDhOmHR6trx+FW/ske4KE=
X-Gm-Gg: Acq92OHmdvCa7iCmUUhyhz1Fe6XlOm5hXhGv7kqsye7WlsqjAm1YIpAAB2YDetxx2/3
 dbCPoaGMq99JVbC31cagP4hf7xVz2XcBUGP5tLPQQfJs/2Q6i7ecAIhbpCEFbxtcABibVueGrV6
 FdzwFDrNXPBH520pnWDdPjGPPvh5i/6O9pZ8ITfaOyx8vYTVnKq/HH+XdP7y66/TaIkccfTfutN
 Iq9vp5mYrucrziq47D5G58U8uMQSMGpnt2yO7KWytTzVLoPyT0mg5P/bqPn8RpxGjLLIOrFw4hn
 CTIGRLITl2WYIkHYht5XXB9D9SfeUMhwe+a1j8Z9bJQsfvr8vdVgogoM8iuNaUdUEInahw==
X-Received: by 2002:a05:7022:2507:b0:12b:f616:1a31 with SMTP id
 a92af1059eb24-1350494fe45mr2848035c88.6.1779114395331; Mon, 18 May 2026
 07:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260514103815.190628-1-marco.crivellari@suse.com>
 <20260514103815.190628-3-marco.crivellari@suse.com>
In-Reply-To: <20260514103815.190628-3-marco.crivellari@suse.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 May 2026 10:26:22 -0400
X-Gm-Features: AVHnY4JdeStjA0W-g_sbQQfxFYHywAp-4OmUxt9niF4OTbAXFonBkSs6wkLrJlU
Message-ID: <CADnq5_OZG_vsEuUWgTPJtz-4zf4s=bA9Q_r9-w+KMQVa4RkMzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Replace use of system_unbound_wq with
 system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
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

On Thu, May 14, 2026 at 7:04=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> This patch continues the effort to refactor workqueue APIs, which has beg=
un
> with the changes introducing new workqueues and a new alloc_workqueue fla=
g:
>
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_w=
q")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> The point of the refactoring is to eventually alter the default behavior =
of
> workqueues to become unbound by default so that their workload placement =
is
> optimized by the scheduler.
>
> Before that to happen, workqueue users must be converted to the better na=
med
> new workqueues with no intended behaviour changes:
>
>    system_wq -> system_percpu_wq
>    system_unbound_wq -> system_dfl_wq
>
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can b=
e
> removed in the future.
>
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied the series.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index d386bc775d03..0811593fca7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -586,7 +586,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool=
 skip_vram_check,
>          */
>         adev->coredump =3D coredump;
>         /* Kick off coredump formatting to a worker thread. */
> -       queue_work(system_unbound_wq, &adev->coredump_work);
> +       queue_work(system_dfl_wq, &adev->coredump_work);
>
>         drm_info(dev, "AMDGPU device coredump file has been created\n");
>         drm_info(dev, "Check your /sys/class/drm/card%d/device/devcoredum=
p/data\n",
> --
> 2.54.0
>
