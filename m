Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D0DC5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 05:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501CB10E0D4;
	Sun,  9 Aug 2026 05:54:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aRTGTe76";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D98510E0D4
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 05:53:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DD6D41179;
 Sun,  9 Aug 2026 05:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1581F000E9;
 Sun,  9 Aug 2026 05:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786254839;
 bh=56YqllMQT4PZJcnBh4e9140daSJLoz5rkyKtVXpAEdQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aRTGTe76HYbHR3UQZE0fEVAhyUH6hAc93wQiILPE6I0Idg7HKYmLAyd1ctLs0czIp
 CQPUy6nh4J1YOl3Jg/1S83Bzg/gqcm6AJA0bgacBeDpbbVsRO7kZNReRYx66yFSabl
 L92yaKmCr0uPnWK4Du31o/9s77qU7jIt8sQ8rXGdXpMR7s1kWDwjx5IRuOQnESawBz
 jFfyJyXYGqMOWuS5MSnnXnIJFXCJkiIV40IOx8tuZXCz5qUy9qgaZ8F9FPdVqXR2PV
 P7GhNmxPQ47SOhBpxM2+9ttjro7kZ1JmxnTGEZ07QIp4CiU8xfnF+3wLDGvbUUXhXb
 au0Ny64yWl5HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] drm/amdgpu/ras: Cancel delayed work before ACA
 teardown in amdgpu_ras_fini
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809051200.3276-7-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
 <20260809051200.3276-7-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 05:53:58 +0000
Message-Id: <20260809055358.EB1581F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition and Locking Violation / Use-After-Free in `amdgpu_r=
as_recovery_fini` where `page_rsv_lock` is destroyed before `page_retiremen=
t_dwork` is reliably canceled.
--

--- Patch [6]: [PATCH v3 6/6] drm/amdgpu/ras: Cancel delayed work before AC=
A teardown in amdgpu_ras_fini ---
commit dd2776768892778a29776f233fd342f5f59be385
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

drm/amdgpu/ras: Cancel delayed work before ACA teardown in amdgpu_ras_fini
   =20
In amdgpu_ras_fini(), cancel_delayed_work_sync() is currently called
after ACA subsystems and locks are destroyed. This patch moves it to the
beginning to ensure all pending work is flushed and stopped before resource
deallocation starts, preventing a use-after-free and locking violation.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 764cd49504083..118716ad04379 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4751,6 +4751,7 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>  	if (!adev->ras_enabled || !con)
>  		return 0;
> =20
> +	cancel_delayed_work_sync(&con->ras_counte_delay_work);
>  	amdgpu_ras_critical_region_fini(adev);
>  	mutex_destroy(&con->critical_region_lock);

[Severity: High]
This is a pre-existing issue, but while looking at this fix for early delay=
ed
work cancellation, I noticed a very similar pattern in
amdgpu_ras_recovery_fini():

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:amdgpu_ras_recovery_fini() {
    ...
	do {
		flush_delayed_work(&con->page_retirement_dwork);
		ret =3D amdgpu_ras_schedule_retirement_dwork(con, 0);
	} while (ret && max_flush_timeout--);

	...

	mutex_destroy(&con->page_rsv_lock);

	cancel_work_sync(&con->recovery_work);

	cancel_delayed_work_sync(&con->page_retirement_dwork);
    ...
}

If the loop exhausts its max_flush_timeout, it exits while the delayed work
is still pending. The code then proceeds to call
mutex_destroy(&con->page_rsv_lock) before calling
cancel_delayed_work_sync(&con->page_retirement_dwork).

If the delayed work (page_retirement_dwork) runs after the page_rsv_lock
mutex is destroyed, could it attempt to acquire the destroyed mutex in
amdgpu_ras_reserve_page(), leading to a locking violation and
use-after-free?

Should cancel_delayed_work_sync(&con->page_retirement_dwork) be moved above
mutex_destroy(&con->page_rsv_lock) here as well?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809051200.3276=
-1-sreekuttan2156239@gmail.com?part=3D6
