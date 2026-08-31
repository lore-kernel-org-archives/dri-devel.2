Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393ABC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E67F10E2FE;
	Mon, 31 Aug 2026 15:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aiRR3owR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFFC10E30C
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:50:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C7A560233
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213611F000E9;
 Mon, 31 Aug 2026 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788191437;
 bh=9CwZ1icxCRH8/YLLV9UUaWBxf+X43/ZFZdhR1N1XIdQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aiRR3owRLU2VlSaQT9slNcRxHrgxe26nntAegxQZ+66UbuoyYCbwnLxqCcOmrLTRk
 okapSC7U3B+COdJ+cS7r2azst/+6oRt5rc+iBRLLESEgqwBFX0dXLsB5X1x38qfJIy
 3OCGlgAxHO9CqC8asGYPvhSJfTyVWjh6emFvPHfM879PjP+pFagMwzeYsOp77d7nhf
 lwemZZfala7ZS2SMIwT948w2mov77Oyx+W0BF2wdw4QbP/5ZIUkp6RF/drxjCzm4rS
 zWpK0eoM10h85YW1HMA66ecZhXhkpnZIz2zXvuodVVjJm2ZVIKGnO+O3qG3b1Frm5O
 tvqEOVuozA7wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amdgpu/userq: pin mqd and fw object bo
 to avoid eviction
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-353-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-353-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:50:36 +0000
Message-Id: <20260831155037.213611F000E9@smtp.kernel.org>
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
- [High] Missing reservation lock when calling amdgpu_bo_unpin() in amdgpu_=
userq_destroy_object()
--

commit a94e7fa8193fda17368d3bdb773d56e5a1abc907
Author: Sunil Khatri <sunil.khatri@amd.com>

drm/amdgpu/userq: pin mqd and fw object bo to avoid eviction

This commit pins the MQD and firmware object buffer objects to prevent
them from being evicted while user queues are active. It adds
amdgpu_bo_pin() during object creation and amdgpu_bo_unpin() during
destruction.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 1add21160d218..e044feaaeb01d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
[ ... ]
> @@ -278,6 +284,7 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_=
mgr *uq_mgr,
>  				 struct amdgpu_userq_obj *userq_obj)
>  {
>  	amdgpu_bo_kunmap(userq_obj->obj);
> +	amdgpu_bo_unpin(userq_obj->obj);

[Severity: High]
Is it safe to call amdgpu_bo_unpin() here without holding the buffer object=
's
reservation lock?

In amdgpu_userq_create_object(), we hold the reservation lock (via
amdgpu_bo_reserve) when calling amdgpu_bo_pin(), and when calling
amdgpu_bo_unpin() in the error path.

However, in amdgpu_userq_destroy_object(), the caller (like
mes_userq_mqd_destroy()) does not appear to reserve the buffer object before
calling this function. This means amdgpu_bo_unpin() might be executed witho=
ut
the required dma_resv lock, which is needed by the internal ttm_bo_unpin()
call.

>  	amdgpu_bo_unref(&userq_obj->obj);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-353-sashal@kernel.org?part=3D1
