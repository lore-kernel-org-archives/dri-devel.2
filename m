Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED36109B485
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D80210E911;
	Tue, 31 Mar 2026 14:55:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nfwrA9fI";
	dkim-atps=neutral
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9BE10E911
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:55:33 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-56ba10b5f70so291430e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 07:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774968932; cv=none;
 d=google.com; s=arc-20240605;
 b=eDTYQHbIIX4SBURmqewdW+od5lb0Q/W4oYk2w/6OuFbMEPNN8z9zgwLxWtqJnylTUz
 z7Ak02ZnRFW6iw+ZQ5BjT5KOUvv0+OWj74Pm53IYwqZYmHr/PqxIh8Oy2YdF6ZMvOp80
 QxialLpo7xYWzKXKd22No2hnU8JYnMxTauGil1xGPFQZLTDPwt5gkyqCKKRqbIfJYxyY
 UAGxJaz557QY3f+UArlG9uOpQjl/vfUIAeIxSjOY460VLvMyor5jWQWpgw0z221QdKlW
 AC/U45D1tuFkHS0R5J8TemSh5SET3nAJd8x4kqr82etJl5VNbrtJU+mav/ylL/a9qNXT
 JNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iw+4CAwzc9WeJr+OGofkDsKUrB1nWPaURjPoaaX0QUk=;
 fh=oZCrZzAY/zVKEXzNXwsE2Op+x09kg3ED4ygWRJEImxg=;
 b=S8IIz7NGlstKFLKZ4Ed1INmNoZKFGE5PM/zn/FcJBTra5iqKLFzTC4iHa6/ibOfhky
 NHM59up+fjeXVA1qX480tTsRpwHMBZ3r5OV7gqY9ywRCiZ/FDpe3BMX6DWCxoFDTboiz
 QHVAzIRJ9M8NG2atwqQ7+HaSpsAOrTau/66QjJLy+TLpGB/JL+DXadS2sYB9x6Ef6rsK
 Z2OEq4TMza8gIOsrLIT3I02DXVU/LUAGg5/QXCF8kSTyfjsG1NUw/cwcfEON08ab1z4N
 g5g4EJNpXMmFTIs87pGilOAq9YpcIp9IFTOYd3ppSS6DbdaXXEpS1ZPCBI/7IIBT9hYD
 ZK1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774968932; x=1775573732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iw+4CAwzc9WeJr+OGofkDsKUrB1nWPaURjPoaaX0QUk=;
 b=nfwrA9fIlGFs28aFdVXr7U+FF7AOvfbOT18eb8nxjLmf+znRX2YY4leXqsXEqQmcs1
 uoNoO45YqYd/6PV6M+Ziled4iCIDWPfJVTQxpvEtjzwHipmNyF6jH1JFshfoLQhPb0ZB
 zSloQTblht7MZDFecAyHB5GnU5ACUn6XsuW4WyZEyx8N5HEBjGUcAZ7iTHpNVrz6y1n2
 sN5ZuUCWPk/icpFT4buOu/fSsMurfngzO6uJ5EbXVUwzaXPA/2v6HEk4FJzruMoXkG2/
 /wXKUWOotvdM2rBezdLe3EZ53YRV1Y4pNf+qj73rqTnpChCusiWlUUvoNJmPQFb/WnTz
 ZOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774968932; x=1775573732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iw+4CAwzc9WeJr+OGofkDsKUrB1nWPaURjPoaaX0QUk=;
 b=iRmflxiygGJBOb3u6Q96xGtIHY4cePHgWDEzJzxklD3Q3HH4fIXMCFL6hCeGZ35ggH
 /f6EVZFwljEm4tVATzb/9HqgLQ9a+CqrbFNzrESUGbiLr6Xq5JU6tTctpEyci4wPRLfr
 TFCtjHAUuIj/2JU+GdsmHnG1WNaMMqU1fvKBxYhF37LsgENo0NYEgDUCBQd8DQeoEywu
 WggA1lZjkkcOTVYtla4H8zm6Vi2jENXjx+FCjockn63rXU2ZnGKbaC+SBAxauIaFZEom
 li+lQ//yaV27kpViirmh4yQ/RY6T28ibeq8bdKpYLE0b4AwwlcuEtP5w5beu2Z76oGfn
 vJNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAYbIoyf+XZSaziGS76CUQjacOfqggtb2BaVEptTqQ6AzmEEV48Xo3lYb4wQDrGw7lS+HdH//RlEA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTMOJOew/r6HRVptpHvXqSkLR3Axnw3pGMYI9FvVDWYDBMbWmk
 29m8pOmcx4GZi3qfPPVqujPylHUwJ0MEXefAfAVhalRuECeHvlliYeQES6lOJrIcllzx2se6Qd0
 y1rSNxP19Q+K7Ng9k7OX0pEV/g/lriTM=
X-Gm-Gg: ATEYQzwWJ+0/R2+8tSBMFb50TPSNe//e8iZ5T3zM7pbsH4jyrA2wE65L1yL62PlSk7D
 8cyfgh8zinYKZD095dXvkH8NrkwJpx23y35qX5RugSgOGbKkNCS+hQD3rvNZi7i3LnxDR6+AoJ/
 BP51WHO3MJtI2tUlzxu6B3wgWj917XHkrF6pGTsg8oWhks7cBCQ+dwU6xSX2cqGJ2Qz5+Ym6NZ1
 JvHDCurJpj8i1h8h4wNk+xtjKYMAxW0MhOSApI10Bssvup6lrGSl2F29jqWuFbgEUKF2Rqpttbl
 /U6b95UfLIIqhhEBInhTfOLy7qvp6aNhKS6vA14GCFlIAhStxz+6Py/HMf4QUKMd9av6JCU8dTH
 WVlyu
X-Received: by 2002:a05:6102:21ba:b0:602:7589:6536 with SMTP id
 ada2fe7eead31-604f8fd7c24mr2235805137.2.1774968932353; Tue, 31 Mar 2026
 07:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
 <20251224144708.61167-2-marco.crivellari@suse.com>
In-Reply-To: <20251224144708.61167-2-marco.crivellari@suse.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 10:55:20 -0400
X-Gm-Features: AQROBzAlliLpxduaovQB73KEGle6JGM5wuLvaBXl7gbMww3qmuvTovlmipmFmVE
Message-ID: <CADnq5_NJFv=xEyN+VQOvt=7QifK2rFUcKru92YAeX+2m-9PSNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/amdgpu: replace use of system_unbound_wq with
 system_dfl_wq
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

Applied the series.  Thanks!

Alex

On Wed, Dec 24, 2025 at 10:06=E2=80=AFAM Marco Crivellari
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
> Before that to happen after a careful review and conversion of each indiv=
idual
> case, workqueue users must be converted to the better named new workqueue=
s with
> no intended behaviour changes:
>
>    system_wq -> system_percpu_wq
>    system_unbound_wq -> system_dfl_wq
>
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can b=
e
> removed in the future.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd=
/amdgpu/aldebaran.c
> index daa7b23bc775..a7bc65099755 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -179,7 +179,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_con=
trol *reset_ctl,
>         list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
>                 /* For XGMI run all resets in parallel to speed up the pr=
ocess */
>                 if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> -                       if (!queue_work(system_unbound_wq,
> +                       if (!queue_work(system_dfl_wq,
>                                         &tmp_adev->reset_cntl->reset_work=
))
>                                 r =3D -EALREADY;
>                 } else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 12201b8e99b3..2ee416c36ca3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6173,7 +6173,7 @@ int amdgpu_do_asic_reset(struct list_head *device_l=
ist_handle,
>                 list_for_each_entry(tmp_adev, device_list_handle, reset_l=
ist) {
>                         /* For XGMI run all resets in parallel to speed u=
p the process */
>                         if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> -                               if (!queue_work(system_unbound_wq,
> +                               if (!queue_work(system_dfl_wq,
>                                                 &tmp_adev->xgmi_reset_wor=
k))
>                                         r =3D -EALREADY;
>                         } else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index 28c4ad62f50e..9c4631608526 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -116,7 +116,7 @@ static int amdgpu_reset_xgmi_reset_on_init_perform_re=
set(
>         /* Mode1 reset needs to be triggered on all devices together */
>         list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
>                 /* For XGMI run all resets in parallel to speed up the pr=
ocess */
> -               if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_=
work))
> +               if (!queue_work(system_dfl_wq, &tmp_adev->xgmi_reset_work=
))
>                         r =3D -EALREADY;
>                 if (r) {
>                         dev_err(tmp_adev->dev,
> --
> 2.52.0
>
