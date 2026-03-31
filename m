Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E658109B477
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750FF10E8BD;
	Tue, 31 Mar 2026 14:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OCENolOC";
	dkim-atps=neutral
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D05510E8BD
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:49:59 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-6050ff27b0dso183806137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 07:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774968598; cv=none;
 d=google.com; s=arc-20240605;
 b=KtVtEjWp4VJJDZXmzRBVClQsZdFTirz3GHIySPVVIVUZ19sDTXzo4cdIuao8FxsYzp
 H5+ogf1/MqM5watIKfjUOBneEYGe46jlFWiraWt7c3/T3Sk1B/jU6MXYnJ2jOQSRR7i+
 kmVMdJ1uENWHSVhxYLCSVxuuStaxfCj4oHXVsrGrHpvsqDfTQxByY2nyA2lXhAAIXeJC
 sv9gFATSePaA9fe+2H+CTftFWEBsKzihURLweI1Pf9FwtI0WRCLLagilAF2CDdLD8V3X
 GLP7jyGmAtrWi3oC5AQOPhHyxUMTp3BWJR1Vy+7y95RBkL7xS9wOIREH677qVLAxgsDR
 Kxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mkf0OB5moQvG4GasAeHoQXSqm+bAnxXSlhG9Kzvrg38=;
 fh=2+pDEpsBbjQ461PiL8EJwTuoXdMO30MhwOxQGNKanHU=;
 b=I00+RiKx/41KCl3P55o8QfRCPe9RIc+gH+b4Tgv1cU3IPqXPUZ1Fw7Igt1pAWuItqw
 teb4FVYlWW9YvhIAJ1zGskMzHMFay2TIgSh9Fcv5ab7fGCcaLDd7kRiqq+qPhlmHYqCG
 o35SmxlMbZdi1NE53YsNK97q7z/AQRCqosHHkOR5sqpKS7pu+wxu6YcGJ7K/iTb70HP+
 iwkDAgGgA4sbtap2Mh39JLzxAiEQS+ZCtJgNZugfeDf4Ck3E5TY/lJvfowKpvnVQQ/zX
 hYQexkrOW+GcfHLuI2MCaplnjIhI7SADM+9tndXC9/2ggYU9rw6HZ9ZeSIrdg5P7zzdV
 qAGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774968598; x=1775573398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mkf0OB5moQvG4GasAeHoQXSqm+bAnxXSlhG9Kzvrg38=;
 b=OCENolOC1qkuPXCbKr16/Pq86HcJe9udimBfAC3OFEA0OjTgnEPh3teI2hSXEraYTU
 X9yWnV9N8r4hRfq8gEpzyHxwvvSWjCDUb7QHxy37hYzdUEDYVpsKXZ+vRKdz7IaGSYLG
 0MN6nHkzkvfdr1dnWb7TrkcJk2Y6nkTHM29K/ddLTzKsf/W4PkKOykpagIEbH36TjVsD
 6GKV8M5Eqt3746huvXEFSqIJziVLiIKBAj59f5Yo9zxcKSn/bSYgSLD5jOBWMLQ9uT8/
 0KTZQX9oxOQCNMdUU3rDP9yA9IwByD1ca0sk1bP5/wGsGTQuSSyuAHOONO+chYEZWtm1
 cqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774968598; x=1775573398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mkf0OB5moQvG4GasAeHoQXSqm+bAnxXSlhG9Kzvrg38=;
 b=sZkA84V3bb9BkqtsvU3q7QiCs4mtqSmbta6R+T4l1ppwbvE/m0c8rcL8r90p5Da6dg
 1hcUxPC7JOunQ+HOLp5AD8UWCPUm92Xk3lUqSRR8pDiabdhz4ZQwGm2drb/2+fKIGp7h
 /andvRqu+GYL0gz0nYAqPz245jOEJR1fYkw4P0CBa0xC3ukl8t7FdH0H9YRGknO/kUUZ
 1yJ5NNrkHuVsK4mel9c7MGyD0jTUfMTSbeBO7ah57kJU77YUCU3TNdUPTnU0YTItoKaJ
 Vo+eocQjhIj37Dy6hB3HyHKm8L+tsKnjxrvqsrHtB4iD3lCxWkyn35nC9SUZePKjH9U5
 kSfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqH4GmBfhOzBB22GuCV7+v/Wbqn2zXGeR4ZSGYJ0igDWNVNEHdfgn1GQe3Tv4g0+GQDPKC5jHvDXI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwY05y37ukK07eCPn4Pjhs2jgAeRIxzaEGYqCh2qXL+jGoQIPNS
 yj6j2cHCJZVk8DNxwHE9KpmI5Yid1lGX7g7F1hpfh90NAGTT/UlpCRv6KK3RVFl8lGSmwx4TqSG
 tPtHAxbMBhKWxtf/WEImjP+OvZxkfs7s=
X-Gm-Gg: ATEYQzywpFMGHuFlbNVkQX2b34Fszt6kB9wynZ//HxVgC/lKVzu6rXCRFp5BmDMaChX
 yqt/iV9DXc54lWMPbrDpehlQ88LdV3JwJ1g6nk4Rm1QrEIR9E58KD2/gNLDfpl6VrgD80tYD2Qx
 f0ltpgwO+SNyHP17HyGcueGWL249jmH1jdtoPsSWX9629qsB/FRAoHaYcvXEq50CkMVZLrOlwvy
 Tlr1Xn6E9awopeD2s4SUtqMgthk1VN0dcsuHbf27KvF9EwUesL8ImVIBuZN5gxiZ3qHZWrAlF+k
 AAEx2ytGcZw/pcN6ahQtB938580lKYg4tvceHvnhCucHt9x3nR/z5lQlR1L8WGzlQ9XfTA==
X-Received: by 2002:a05:6102:21b2:b0:5e4:9fd:5a3 with SMTP id
 ada2fe7eead31-604f9296099mr2321940137.6.1774968597941; Tue, 31 Mar 2026
 07:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
 <20251224144708.61167-5-marco.crivellari@suse.com>
In-Reply-To: <20251224144708.61167-5-marco.crivellari@suse.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 10:49:45 -0400
X-Gm-Features: AQROBzDb5lfPIwy7SKyX75mQJqwLgD-PcWyA8-4y-kCD_P3pLCRi3gfxi94tegc
Message-ID: <CADnq5_P3ogoLiFumJieeLBQ6zktLO37=EwOaNtc=ROEK6Bt05w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/radeon: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philip Yang <yangp@amd.com>
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

Applied.  Thanks!

Alex

On Wed, Dec 24, 2025 at 10:26=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
>
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_w=
q")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
>
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU. For more details see the Link tag below.
>
> In order to keep alloc_workqueue() behavior identical, explicitly request
> WQ_PERCPU.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/gpu/drm/radeon/radeon_display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/ra=
deon/radeon_display.c
> index 35fb99bcd9a7..99a3e4c480c1 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -685,7 +685,8 @@ static void radeon_crtc_init(struct drm_device *dev, =
int index)
>         if (radeon_crtc =3D=3D NULL)
>                 return;
>
> -       radeon_crtc->flip_queue =3D alloc_workqueue("radeon-crtc", WQ_HIG=
HPRI, 0);
> +       radeon_crtc->flip_queue =3D alloc_workqueue("radeon-crtc",
> +                                                 WQ_HIGHPRI | WQ_PERCPU,=
 0);
>         if (!radeon_crtc->flip_queue) {
>                 kfree(radeon_crtc);
>                 return;
> --
> 2.52.0
>
