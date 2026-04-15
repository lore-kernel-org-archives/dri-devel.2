Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3450F43854
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0A610E140;
	Wed, 15 Apr 2026 16:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HLlYqIZh";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048C110E140
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:34:12 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-66b2d49ffb0so9169661a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1776270851; x=1776875651;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SVtPfhgGSMK7VhUt7eWOmIDqvBPOmQt89lyJEcl6ojk=;
 b=HLlYqIZhooM8xkqTBJja9n3QcJ5oDGH19cRmlQY5iRHXofbzMKYa/qNiLNdeqdbUik
 B4Gj1KFPwiRZ9VIqm9VcgIG5eMM/Z+RVdvRhHLe85HZCFmVhIRMdGpbGPn3qkosu5jsT
 trHj6XMAIcQ/ZhJpd+ZnumFz1WiDQu46wdipo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776270851; x=1776875651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVtPfhgGSMK7VhUt7eWOmIDqvBPOmQt89lyJEcl6ojk=;
 b=Y6w4i5QWO8mIseQM1TzuINCqg1CL7lvgz0YuhjSUprPOHqkBm+t8nosFdCjcr2seSj
 Fi+p9tLPlmJANuHiqk2cZHQDLl6KSlacnUKiKIUub07zYXlroJXNaHcteGqQ7b+bxChP
 FTxahV8RSIRPTE1dbw451baDOy7fQlPCyCWrmxdnUocG7nOkyYJugq4b9YBw8oq+UAbV
 +eUxC3wc0rUIQcuXINKY/LbP5xUnQ7rf9Fk6ff1LLk5F3CwWa3/ZDp5orSFmA0fR6qPo
 7N8uL8E19HiFhBVnL1PlthtzkDM6TqhPke697mABF274rFtQv1wxK02ZPaHfdJwBWnxG
 TAzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kWe1/EtUZ2E57IGcZdjyx7tKoMh9+tZbKpNeGh8gC8tewSq1Aedq5/7+bq/GdZA/NifLkDL5D4EE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yylpz0D0/D3t1HgZ6154d4LtuI7KYs7yGH97i5ErKMAqFQlArgG
 ak5cv50Yw41oolTZSdZh/Nwhtou020LUbiFHbw9NYfsfmWCuc51rfVaehJG5Ku1dOwuN8tFsn3z
 rj8bbp+E=
X-Gm-Gg: AeBDietEnV8Q6EpcYEa4zfB9IcC7f4iUqVmgw0YhWgy425hN0tveRkGhXSJILUGtl41
 5YyGPJv9OMbIZTFs2oXPcwqB08iXBx+D05V4HnXQLr2x3AatSygR6Jvrfq+4mepqyQNMICRa5bz
 f5U5akNqz6O49RER5ltzlnLf579+ZOeoiTnHsMlHP9CKS1Vx/q2B9t4u7/N3wP4ivdDJB6w5HC0
 84TT+Uo0nX8xqXkepj7xYZVBuRTyKQ942mTAOsgCrZ4P8nP+C8aTe8VSbPg3G66cY78rnXQ9jrt
 4pHGg73cfRhe7f1eQJE7c+nT9HH/VOi7xq4NilWDo4SosYsu+qSxoZxjn88AiNamml/XS4xLasS
 IcO6zjSalSjhuFfCM37ojWdtkQ8Q8lsJVNEHXasFqGYZzYcPts2d/ofH5W/SWWL5E8DnAh1qsuZ
 j0TLg7jcBiOImSiOU9Vt6v3kr/k0hhN3OgJvhaCpRp/Srje7e9Nv1lpYVJ6jSElCrdRIQmCFwq
X-Received: by 2002:a05:6402:1f48:b0:66e:bad3:1ca0 with SMTP id
 4fb4d7f45d1cf-6707a475baamr11217504a12.13.1776270851079; 
 Wed, 15 Apr 2026 09:34:11 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com.
 [209.85.218.53]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67237d78933sm568536a12.6.2026.04.15.09.34.10
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 09:34:10 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso980311566b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:34:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8uX5yMcDn63Q1jzolJxm6MaN0J4sBHcTozFGfXSjqUcvfMMWX3pNz4EYlmypVW2pNrJrWz920cT8Y=@lists.freedesktop.org
X-Received: by 2002:a17:907:9801:b0:b9d:31c2:37f9 with SMTP id
 a640c23a62f3a-b9d724f01a5mr1184257666b.2.1776270512082; Wed, 15 Apr 2026
 09:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <d69501d53c233386d70ed10290af24aafebf434f@intel.com>
In-Reply-To: <d69501d53c233386d70ed10290af24aafebf434f@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Apr 2026 09:28:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAGevirr3=xC=u5_kN+m63JtjqA0C9NJLrd5PGrM0suw@mail.gmail.com>
X-Gm-Features: AQROBzAwO_jXF6Cc0zC7gGmeVDHe5c1N_2hgiklfnxVR1DaUU6j-D3KNwiqGohU
Message-ID: <CAHk-=wiAGevirr3=xC=u5_kN+m63JtjqA0C9NJLrd5PGrM0suw@mail.gmail.com>
Subject: Re: [PULL] topic/pipe-reorder for drm-intel-next and possibly v7.1-rc1
To: Jani Nikula <jani.nikula@intel.com>
Cc: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dim-tools@lists.freedesktop.org, 
 Ville Syrjala <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 15 Apr 2026 at 09:09, Jani Nikula <jani.nikula@intel.com> wrote:
>
> We're fully aware this is beyond feature deadlines for v7.1 and it
> hasn't seen linux-next. But in the off-chance you might consider also
> pulling this as a fix for v7.1 (and really, distros might want this to
> be backported to stable) I'm sending this as a separate topic pull
> request.

Does this basically obviate the hack that I've been running for
several months now for my dual 6k setup?

I guess I'll test it just to verify, but if this fixes that known
issue I'm all for getting this fixed sooner rather than later.

                 Linus
