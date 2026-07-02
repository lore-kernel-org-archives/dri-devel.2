Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B56CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CD710F187;
	Thu,  2 Jul 2026 07:29:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DEv0uzJA";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADBC10F187
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:29:31 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4grT6J0t5Fz9tFL;
 Thu,  2 Jul 2026 09:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782977368; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vBbebS2OwZPm7sHgbFW0Ki3IJSy/62qddr5vkTOY9Ws=;
 b=DEv0uzJASpK4GLQb5gKGSCeK8F+W1LrM6iCTDHS7JCnely+GbspAIX9Fu2hAz8FzMCQ2JW
 zd7D9WappJBc7Q6aZQBudT4En1k9yGaGADIult6h4PwCOEgQZk+02wwi1Xb33RhUo2no/p
 IAEAQlaSflUDGGugEG/LoOETP5qmKBoxU/H+zC/jMYH+sHAqmSJyLD601nN6601dwt57L7
 ygKH8dtA3wBVQzXXAM1IwoeVxY11085iAzYlfX0pXty1LyoNmKhcVJ/UEJ/hUh/gN4eNsd
 GP8df10TbufimC0KfqsAhscNxITE+w3tipUUXBHIG2K7TDbxgyEB9P22//tqLw==
Message-ID: <d1e82acdaa6b63b2e0b11d91ce244f0554f71a27.camel@mailbox.org>
Subject: Re: [PATCH 05/10] drm/sched: use dma_fence_test_signaled_flag()
From: Philipp Stanner <phasta@mailbox.org>
To: christian.koenig@amd.com, phasta@kernel.org, simona@ffwll.ch, 
 sumit.semwal@linaro.org, tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org
Date: Thu, 02 Jul 2026 09:29:22 +0200
In-Reply-To: <20260624122917.2483-6-christian.koenig@amd.com>
References: <20260624122917.2483-1-christian.koenig@amd.com>
 <20260624122917.2483-6-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: e9ede8f42704973847b
X-MBO-RS-META: bq4oxfcwzw3fj9ysqp93ycjj1sczxe41
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-06-24 at 13:13 +0200, Christian K=C3=B6nig wrote:
> Instead of dma_fence_is_signaled_locked() use
> dma_fence_test_signaled_flag().
>=20
> No functional difference the mock HW fence has no signaled callback
> anyway.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Fine by me, but the commit message needs to be tuned up a bit, see my
other comment on this series :)


P.

> ---
> =C2=A0drivers/gpu/drm/scheduler/tests/mock_scheduler.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/g=
pu/drm/scheduler/tests/mock_scheduler.c
> index 14403a762335..82dce344bfa1 100644
> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> @@ -224,7 +224,7 @@ mock_sched_timedout_job(struct drm_sched_job *sched_j=
ob)
> =C2=A0	}
> =C2=A0
> =C2=A0	spin_lock_irqsave(&sched->lock, flags);
> -	if (!dma_fence_is_signaled_locked(&job->hw_fence)) {
> +	if (!dma_fence_test_signaled_flag(&job->hw_fence)) {
> =C2=A0		list_del(&job->link);
> =C2=A0		job->flags |=3D DRM_MOCK_SCHED_JOB_TIMEDOUT;
> =C2=A0		dma_fence_set_error(&job->hw_fence, -ETIMEDOUT);
> @@ -258,7 +258,7 @@ static void mock_sched_cancel_job(struct drm_sched_jo=
b *sched_job)
> =C2=A0	hrtimer_cancel(&job->timer);
> =C2=A0
> =C2=A0	spin_lock_irqsave(&sched->lock, flags);
> -	if (!dma_fence_is_signaled_locked(&job->hw_fence)) {
> +	if (!dma_fence_test_signaled_flag(&job->hw_fence)) {
> =C2=A0		list_del(&job->link);
> =C2=A0		dma_fence_set_error(&job->hw_fence, -ECANCELED);
> =C2=A0		dma_fence_signal_locked(&job->hw_fence);
