Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA044C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5052510E2C0;
	Tue, 11 Aug 2026 07:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pSfkx/vH";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCDA88647
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 06:30:53 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cc97653887so29371475ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786429853; x=1787034653; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LjyBChYPac0+HFZZpbdaTfE72xakMbYP8WjcMKyr4cI=;
 b=pSfkx/vHvXoYgX8p9uiPj/4dGJyhhgwDn58Mmme/xQOEnPjqjlZGse7W4ncoubg7vt
 9kl8oKQAkUMiLNAPyiEChhjl2hQ3h2YULk5ZNOJ6q7rjhoVkgTsN1/tS90YPL0gleqGg
 gCR1HShQ5D4T8YCj8JUe/8qHGj9pRZjlJLyqmq4Wk0aQPGmfl2gUnKcnHd7rT3Rxm3ab
 xeJzUxLoIC+hfpwGWdQPfficQGKg9qZRl73NvLMDB1JnV0HIwZ1pFhlk5bu82JsCciRX
 3G8aZy31dpsHRntly7IoNKmSicj+/FIqx68htfLM1mQVFkFszt0S1HpZPaV+0Hu89yCh
 dajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786429853; x=1787034653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LjyBChYPac0+HFZZpbdaTfE72xakMbYP8WjcMKyr4cI=;
 b=lol6ydwjxFgBKuLZZQbEJ/DichYYmeXry1DoTbqWfVMCrXDEM0Kx7GHO6H5ftrQmE/
 PEZHLlG3Xw/YfpypuqDhL7U/Vo8dz/YNY9LBWWZg1jnY6mLbHDgqV69iXpmJbAr+YBxX
 VcsvApvAAe50bEEavdJX91x2clRZ1Sh56c/kJTmKfU6X2bcikVilHMpN1u3oaXHh99Gj
 QQnM+X8uGRUEo/NK8iDP6CnliRI6teJ8eQ3a8rEvagQwue4pORwUeCJvGe5Y0FCIYHIS
 8MN0GGSPc9SYR4/HcNbXz6H0HDCCZ4JucrK88OsSHr/ju9LcmnmYfJDv8LJgL5C3LQj2
 /UcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkyfP4UgdnqVt+XcxLxAEbjdLqhXbGBI2wmxqQt+x28uEo1s8UPYjq+bpVJQWyUqiFaAGvWseWwIs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxalNcARcZrADTH/oCUr6GhJZyVEwFnaTmOns7YOa6YXPRHe6P/
 Dr7jAFf1vfdTIekb2NCQ+c2zQS0fZUrV6DngUJfkz92YafUVr4lTm/wq
X-Gm-Gg: AR+sD12sXV/rY0G+RaybxPTEUxIQU8izN6RfU5y4b5U5u4GuZ33FIm2JHbHzuCbfETX
 61dub9JuQYiFcZPHj8q7gup9EzB+s8LuT7HmXTKBTSc8uzcUhWo9vuehLmzkYvcMPEdOEpFvF07
 ToCPRN2qr0cGSnAknLMmr/qWlhVuKsTlxFj4AD7djUDPTWy+7tC3dil2CXDQWkbProLDePN69Bv
 FnvHy/LvOSveheQGg/iNUg5TDFqgMOcpRV0i0tqp8iw7sSoNYR+IRaxgo/wXl1kQ8xZwGZ44egw
 UpouKbej/rQZklWh+C0Ag31xup7O8AiiD0l0CwEwWTI2LjGE9nK8jj2gFNOUGPjvz8ww4iJMwkI
 v4KWT92O7GAjduNPtMK4qDjHGiPdWihwkDeXzdIHyHoVGYLc6juE19P5EbDX04GV7KagbGX6BnN
 a0we1oMzwsHaEwZZUYa4pCChrZN/ruMuhxujMViacly250t4UiVg6tWypUoFsOOKtNwN+S0Geb
X-Received: by 2002:a17:902:ef4d:b0:2ca:62e:cc4f with SMTP id
 d9443c01a7336-2d3179824f5mr16770685ad.23.1786429852610; 
 Mon, 10 Aug 2026 23:30:52 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d315f48111sm2335105ad.35.2026.08.10.23.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 23:30:52 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/imagination: Propagate all errors from KCCB command
 submission code
Date: Tue, 11 Aug 2026 14:30:42 +0800
Message-ID: <20260811063044.4035829-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v1-1-ffd55254d6d2@imgtec.com>
References: <20260811-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v1-1-ffd55254d6d2@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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

On Tue, 11 Aug 2026 09:11:54 +0300, Alexandru Dadu wrote:=0D
> -	WARN_ON(pvr_dev->lost);=0D
> +	if (pvr_dev->lost)=0D
> +		return -EIO;=0D
=0D
kccb.reserved_count is only decremented further down, past both WARN_ON()s,=
=0D
so this returns with the slot pvr_queue_prepare_job() reserved still held.=
=0D
=0D
That path keeps being taken: pvr_power_reset()'s err_device_lost still call=
s=0D
pvr_queue_device_post_reset(), which starts every queue again, so jobs go o=
n=0D
reaching run_job() after the device is lost.  Each one then leaks a=0D
reservation, and pvr_kccb_fini() ends on=0D
=0D
	WARN_ON(pvr_dev->kccb.reserved_count);=0D
=0D
pvr_kccb_release_slot() is meant for this ("Should only be called if=0D
something failed after the pvr_kccb_reserve_slot() call"), but it has no=0D
callers yet, so the ERR_PTR returns already in pvr_queue_run_job() lose the=
=0D
reservation the same way.  Might be worth handling in one place.=0D
=0D
Thanks,=0D
Zhan Xusheng=0D
