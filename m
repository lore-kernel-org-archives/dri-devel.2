Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E57C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C69510E29F;
	Thu, 10 Sep 2026 16:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BhJWIRvO";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E4F10E29F
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 16:07:10 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso72504455e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789056429; x=1789661229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9dX7P2+0UXjBFLbwcIRVQxDJqxLq0XE6y5aklSGH0fI=;
 b=BhJWIRvO49ItvOWlZJHiqyMzISUWNgq6GZIj+eamm2e+sMojmWmrPAP+QTyPLyKAlh
 go0PTHa0QSUGz21c3LcbRFkOGNVBpCSR0NeAq0G9QA65XwYTDgp1ppB7xQQZzJvc0kRb
 tAyN7n5eZRD4U1E/biPckJyx9seD1WgA4e++g5QXfT0tlI4Kob0Ixv86tPVgbECgGhJ7
 2bCgkrNf9b25TsSxEW1fdGF5kNodnkQ0FiQwFYvaN9OwnFElKoDHLZIAlzCWpyTChcIR
 hsJJEksn7AmmyKyfiXkNaCHKj3tbUv7o7vpxJWW78XpiATLO8H+J9at7Fmzclr25yHHT
 CsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789056429; x=1789661229;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9dX7P2+0UXjBFLbwcIRVQxDJqxLq0XE6y5aklSGH0fI=;
 b=tQO0oGJlLfhb9EKREC1fmTipGhLwSo63tUakarLGkXHAPC3Jcq1+J2o4H8j9pB/MDz
 JT9/dNjKs+HzOc0p39xLEQAHZStnm1nsv0tD2L3D6J8bdBD4qMgNwVZFn22MSbSQmFxl
 aBJQAP1634WFs6ipWqHklbddCLxbfGfPzplgANRS8lE1vLA7Vdq8ORVvHZkXz9kAyZ+q
 4uuGljQFuuOl2tCHFR1UZEzLhYkvt4ENVzBmUu4Rs7n10xhh1X8VYzKUu2KUxN30K5XU
 S041ig3MF38Kf3r9u9VpJo5HFhAvNbKQ+9e5wZKyCuQF4Vz8ByEdYm5m1JNlauFpvTdW
 WbUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByzbFnmldmX4N95YUf7j1hoFcEpNYJ45+mkYoGILmxZyewp0NBqlo0hpyQOxAK1+/b/h/BOydqJqAQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k6xpF9Rnr1AJjVBGwAu4EjN9/C7ciww5h39DnHcRI8oREcy3Xu
 MaClsL+Ha2t+AFisdBJAn88PkdXwd03kxggNFmmWtkbwyTYYhYT+E+Mj
X-Gm-Gg: AYBFou1Gsa5bcKWrP1fmwgle+PNNmArxCB4Tt1P8SgnFWQa/lTTmw94LXHIwNfxiksL
 bYM932G0DRCB2vjUFQn7Z21F18hYbrrg2PrNBrlvhJIHQmpQJXT+xeQV2d98h4dXxsTZeii7iYp
 N2WeyycEZgkuTfo3imUsV8WsKnLGE2FI5ME2dSTeruazzdo1+MSn2/ouN30TZ2l0yuNAlezq7lu
 oM9obLfj+4XdLwCRoP0wn5fv1msPa6ep0N/Sxg2IQs97XMCII4oTI8fv83rwNoOHG+ubhJ+qnEC
 ToPJoKhsLHUTuOKmgcgTylpRYkH437/vhmPLnJoIk49WcelTmOwG/8K7YAIAPcPQz+5NNi2yPnv
 1omx3Wt2HSuVdhobQAicPmR9X4DHoM3J3ZigDRIwpf+mI+UjIRpexUmPWjphf94BSXU+h8aNKPr
 NqihmzLsUyxZ2IytOaux6/xuoAXGF4cLqerY/wr2ydCXCdllRcwffgP7jFYfWXbLh5Caw2b5Qcb
 /oeoa+veRrmUZpoo1JA
X-Received: by 2002:a05:600c:64c6:b0:49c:fa20:cc02 with SMTP id
 5b1f17b1804b1-49cfa20ccaemr391623755e9.25.1789056427375; 
 Thu, 10 Sep 2026 09:07:07 -0700 (PDT)
Received: from [192.168.178.84] ([134.19.60.238])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fce7a7sm304986225e9.4.2026.09.10.09.07.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Sep 2026 09:07:06 -0700 (PDT)
Message-ID: <e0d0c87a-7502-48cf-9d64-f383edbbacb9@gmail.com>
Date: Thu, 10 Sep 2026 18:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: apply the swapout bulk_move fix to the intended
 condition
To: Vadim Nikitushkin <bub4z0r@gmail.com>, thomas.hellstrom@linux.intel.com
Cc: ray.huang@amd.com, matthew.auld@intel.com, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, skainsworth@gmail.com, alexander.deucher@amd.com,
 bernardomagri21@gmail.com
References: <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
 <20260910143451.65853-1-bub4z0r@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260910143451.65853-1-bub4z0r@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Vadim,

On 9/10/26 16:34, Vadim Nikitushkin wrote:
> Commit 3db7d7d58341 ("drm/ttm: fix swapped-out resources never leaving
> their bulk_move range") landed in drm-misc-fixes with its one-line
> change applied to the wrong "if": the "if (ret)" after
> ttm_resource_try_charge() in ttm_bo_alloc_at_place() became
> "if (ret > 0)", while the "if (!ret)" after ttm_tt_swapout() in
> ttm_bo_swapout_cb() that the patch targeted was left untouched.
> 
> ttm_resource_try_charge() returns 0 or a negative error code, so with
> "ret > 0" a failed dmem cgroup charge no longer fails the allocation.
> Restore that check and apply the intended change: ttm_tt_swapout()
> returns the number of pages swapped out on success, so the bulk_move
> removal must run for ret > 0.
> 
> Fixes: 3db7d7d58341 ("drm/ttm: fix swapped-out resources never leaving their bulk_move range")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
> ---
> Christian, the commit in drm-misc-fixes (3db7d7d58341) ended up with the
> change applied to the try_charge condition at line 532 instead of the
> swapout one at line 1434; the resulting tree still has "if (!ret)" in
> ttm_bo_swapout_cb(). This is a fix-up on top of 3db7d7d58341 since
> drm-misc-fixes does not rebase. Sorry for the noise.

Mea culpa.

AMDs mail servers convert incoming mail to a different encoding which prevents the patch from applying cleanly (yeah everybody knows how braindead that is).

Usually I pick up patches from patchwork now, but this time I though I could apply the one liner manually.

Well long story short that didn't worked the way it should.

I've just reviewed and pushed this patch to drm-misc-fixes as well.

Thanks a lot for helping out here.

Sorry,
Christian.

> 
>  drivers/gpu/drm/ttm/ttm_bo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index a12af5b..9b85b5f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -532,7 +532,7 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>                 ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
>                                               force_space ? &alloc_state->limit_pool
>                                                           : NULL);
> -               if (ret > 0) {
> +               if (ret) {
>                         /*
>                          * -EAGAIN means the charge failed, which we treat
>                          * like an allocation failure. Therefore, return an
> @@ -1434,7 +1434,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
> 
>         if (ttm_tt_is_populated(tt)) {
>                 ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
> -               if (!ret) {
> +               if (ret > 0) {
>                         spin_lock(&bdev->lru_lock);
>                         ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
>                         ttm_resource_move_to_lru_tail(bo->resource);
> --
> 2.53.0
> 

