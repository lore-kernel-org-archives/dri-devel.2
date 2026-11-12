Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFC606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NrXZMPPA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437B810E658;
	Thu, 12 Nov 2026 18:58:24 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E8D1122C8
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 18:58:18 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c4322d310e7so14729666b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794509896; x=1795114696;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z0LqVPtG90eWIMD2SZHKU3bFXknR8F28KDHs5gdoi8g=;
 b=NrXZMPPAhe7v9DeFD4Kmip1RKE8xokZiC4eHRigozK0J/diY1qz+EpZ5gXcpu8fbfL
 e6igaHZy3VF1e2ThFT7oes13kHuNRl74pzQBlPQ1sYElKoi6smR7u9YMMBKBuchAsaqS
 uYpcBRrKg+Mm3AcGgGfFmL6l1uTYoiRCZ/Psg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794509896; x=1795114696;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z0LqVPtG90eWIMD2SZHKU3bFXknR8F28KDHs5gdoi8g=;
 b=CDQEX0avi3u6xdsqNf2Va7bGXE1mGEdo8QJe21jAaFSArl3CGwdT3LMOgKRfJVMT6F
 VXdN4TEMKXBGn1zYRNtIEQbM0yP/mtvxZAccJjgQE6szPtUA0FPW0tIwiQYBztR5Qpmp
 yzqh/93S++7YeUFFL6P0yseWlEcuhjvXWzZ2FdKup9/5FFhndLPRq/hrneuHX8BdHHIn
 EZa13iqLj6ZNvL2OKQ4bVfhZpDQDo1bDjYWr5u3g7oX9tG3bMtbb5+zDbsqi/MLUGCOe
 x5vtsNShOodAZcG3Qln6oRvgThZWByGFOUNLcPxGEtlc6NSf4lyaJEkTnGb7oU4V1f/2
 k5Yw==
X-Forwarded-Encrypted: i=1;
 AL+hErGI9ilO5RR+pbTZsLqud8thPT0cGAwsori8AFTFMQsohiNOW+L4Hqb7wyfcGILcibgT8cQpOF3zFFs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ZquprYd5kW5QcrBDh7cXz00oyIszks/MHRq4MzEUsa3ZOWuwI
 uuG+mmFBzz4UXLjemRa4Wiv6VzT4QhKOg1W/RQH/xJwHFidQ7eFoAkjrXyxZ1M+32lyTS+4vinf
 rWeBy4w==
X-Gm-Gg: AYBFou1FVHuhO9203vZerYKIMndqJdPC3bzplta5dnuGuefV0Hba5r5HYjRAsutsKTw
 dDKkZBHG4usXIkgrL5IEWc8ssEnJ+t5Yw74vcFtLFRTna+A+xdpWGxoERT1373uuZ8a5e9EAOuU
 vY5yiGm6IXjqzE/FMen5wtFnqX4w624MCiX325QATNBBoqb3rxOulrC/rEG7Xx69rosatMjxQ3N
 BLpReRKuCzzAJu9c+C0S3b/X2aUoLC8srS6HuDZi8rSe3lq0xmYuPP1YHFRkpm3YALug5DIS5L4
 1hQgK8kyC7WzK+tMzWo29MYA+LtFqAqcAZ1/mXteab8fTnbcOzvBD8K4fQhiWnRCwuB9JBM0Tno
 1dMFUZS4FmHVznSyzSWHHHhq5EX/O+AC376Q8ZNWkIG51uR5YZ6se16mZvSdVWHi59Pev0qg1fC
 0bIa4dBxorgDOyQ5LWbCVnqXQkq6Ii7e4iWtH0/6P6N2XTx0TCU6M96H4NLR2Zo1hRGFQiRumdn
 3XoYkpuS/xsWVTY8xBkku0N7CvMrIjQL0hJ3a2bd2q0jsrnTjUPyb3aveSc6tUavIiviTx4Fn+8
 0WiCNBfo5bdvSESAJc0cV8qneQYVhjb9dwSejwdTO64mrmo3FUV0JPIgtH6qcDGtGbfD
X-Received: by 2002:a05:6402:460d:10b0:6b3:f692:985c with SMTP id
 4fb4d7f45d1cf-6b7c0d16099mr386312a12.44.1794509896494; 
 Thu, 12 Nov 2026 10:58:16 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com.
 [209.85.128.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b6091dsm7876866b.57.2026.11.12.10.58.13
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 10:58:15 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so1055595e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:58:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErE/kP2mlkWYw/OsD9MeBmRfNMQaiCJfZdBu9F2qno8tPpGAdpgL+lVDKNLUAMXCZmRr2wxKAmiTWTs=@lists.freedesktop.org
X-Received: by 2002:a05:600c:1c18:b0:4a7:9044:a87 with SMTP id
 5b1f17b1804b1-4bb55ac0e34mr2161075e9.27.1794509892596; Thu, 12 Nov 2026
 10:58:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261006231900.3230373-1-briannorris@chromium.org>
 <20261006161337.2.If1822f9a34be06cf5939be44ac6465c543087c75@changeid>
In-Reply-To: <20261006161337.2.If1822f9a34be06cf5939be44ac6465c543087c75@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 12 Nov 2026 10:58:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VbcYGJP6ag_pxwNB3s2iedeF8rey9QUZo3B2YQm25diw@mail.gmail.com>
X-Gm-Features: AclHuK_PiPmNrCWJDrFpHZHvHvTj2hKqQgB_JTPOXCKXOf56_rtdlcICXQ5xuAY
Message-ID: <CAD=FV=VbcYGJP6ag_pxwNB3s2iedeF8rey9QUZo3B2YQm25diw@mail.gmail.com>
Subject: Re: [PATCH 02/13] drm: Discard pm_runtime_put_autosuspend() return
 values
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org, 
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Melissa Wen <mwen@igalia.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, Oct 6, 2026 at 4:19=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> Several DRM drivers use or propagate the pm_runtime_put_autosuspend()
> return value, which is not particularly useful.
>
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
>
> For this reason, modify these drivers to simply discard the
> pm_runtime_put_autosuspend() return value, and change the return type of
> v3d_pm_runtime_put() (whose return value is never used) to void.  Also
> drop the redundant pm_runtime_mark_last_busy() calls right before
> pm_runtime_put_autosuspend().
>
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> This patch is independent of the rest of the series, except for the end
> (changing the return type). I expect it can be applied by individual
> maintainers, and we pick up the end once the dust is settled.
>
>  drivers/gpu/drm/panel/panel-simple.c | 8 +-------
>  drivers/gpu/drm/tidss/tidss_drv.c    | 7 +------
>  drivers/gpu/drm/v3d/v3d_drv.h        | 4 ++--
>  3 files changed, 4 insertions(+), 15 deletions(-)

FWIW, the hunk against tidss_drv.c goes away on the top of
drm-misc-next, since it's 100% identical to what landed in commit
2cc797f73768 ("drm/tidss: Drop WARN_ON() from tidss_runtime_put()").

The changes to the other two files look fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next.

[02/13] drm: Discard pm_runtime_put_autosuspend() return values
        commit: c88084027d0e922dd925b96e5a0d184ba04a8f43

-Doug
