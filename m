Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8A606A335
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SPN7eYv2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F16310E0EA;
	Fri, 13 Nov 2026 22:53:56 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C62A10E0EA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:53:49 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c4d2b741ed9so294141266b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794610428; x=1795215228;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h5U6+VCcHCIbxywmLvk50ZNvHPTQLOr+6P+EbEvWQz4=;
 b=SPN7eYv2fHA4ccZ9cd4ijw1TzcayNmQgf0nXzcQg9Kt7s2CFIX9osO45PjVuWw6blC
 grLB6hTrVLhIiiXFt5nsrU49CO4k5h0XB77Hk0INTjG8328gvDK8v9EvJ1mAc9vWmvwy
 h1hNrKHuQbQaH6LJnfowZnHJPshqMkVEN2gOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794610428; x=1795215228;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h5U6+VCcHCIbxywmLvk50ZNvHPTQLOr+6P+EbEvWQz4=;
 b=225Jcu1aafcVaPHTkI03vhMfgtgwcQAJfTk5ckMUraCKxD3y1C4D+uV79WjdSySlzo
 z0GaW7v2EpGBhmDQj80rt8/5cfqx19U7h7uqIKjMvp/vIl+zgLKS+nCgcYWQPVYKOpAR
 lu6H6QvAUXNN3nHp931WpsOo1HBqWmBlZUl8Pw/0juN2SS8dAsnpGLxSm28VEOJlMEWm
 1U2dRNGHRbrjB0iGXPMga1EoldXggCBhDuJhoROFgRrLwkDnTCr0ZSoJsG7jyoHgniLw
 M99/j+tXabLRITPLrIUw6yAb0tInz14QewlWjctSgMqHO6zmeepM4jW5x/7Icnnf6GCQ
 2CQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHE6LqqforXbb6VY4IjV0mWEUX3DgyLELqdfmiW9ySemfahxtKd280M1woxzCUnhqmnuu0xVJkN85g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Q8XtrQ934SWwYeR7mHamHc5224sG46gVkxmYMTaQJ2AURaB+/
 bSjamh/mZAdVzfgE5WP4YAvX5Upl461+d6L8JaeS553ve6dYAFlEfXjNdyc4R1f+uuw2BuNo6w0
 gS07XnGtR
X-Gm-Gg: AYBFou2jBZ+5z5mZm7TOJAfXjcnWXTDCU65F2jkRqlx8T6P6HQHeJpDU5ra5hc/dTjK
 vBm9A1xULuL0ktC4R+GVb3qKSYvI/IcfZ0vkVgCVXViCPcsWIcSDlct5Zt/pWkEsRfpX8+VPD8M
 3FCaT7XdR0YL4d5sKI7GPKySzomlEXeLNMSVkqV4bY0kn2/swb8vqRpERskjNM+dJLpa6WqPati
 HVmKNmSfbec/IIwvveGZF2QZWLffRwvuXB6o/XG1QhbDeMR3VypSLKxHYel3wfHSqUt39ENK98Y
 xiK4MiQYcI5wVddW8c8ZYALHVVMUiIMeUhPFiWFoznw0lUCyuxfDzIHjv7uI5b8X/VHYoUi9KLa
 w0t4EdbT8Yj3HtxSE9nHoeVqAlXP7HoL4UayqLz7lA78zGUCk9/osTpquIXoW8a+OGRiIazjDzR
 WslqBbK95cLHUPE2KQB5aT/LRrSOFGR/J/6oFlxVzHGRRZ25fI1PcwJPRYchl9bT47hV24Aa54m
 HDkNsD+sOgnodUmbAcXqR9MWN06fmjgeO1zWepiYU0qQLhnwLVcQdUcxh5XlRYhqsDF861CuVqv
 bINrI82n8EQXYif+GSQHBSW3ytmb2WtD7b9cfsHJQILzuswIUc280HTBbsgOzV+OluD1
X-Received: by 2002:a17:907:3f20:b0:c41:4d5:e97c with SMTP id
 a640c23a62f3a-c509640f665mr360195866b.37.1794610427727; 
 Fri, 13 Nov 2026 14:53:47 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com.
 [209.85.128.47]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b780d6sm145588166b.67.2026.11.13.14.53.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 14:53:46 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso11507655e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:53:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErF+SJ1es48kZ2JpwBdiMA2CI85UqK+0WlQJgWau27tTSQNJzCpAm594SAkEsn8iZQ/g0jbwcA7P7x4=@lists.freedesktop.org
X-Received: by 2002:a05:600c:b95:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4bb55aa3688mr87508425e9.23.1794610425607; Fri, 13 Nov 2026
 14:53:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113214526.231324-1-ingo.kubbilun@gmail.com>
In-Reply-To: <20261113214526.231324-1-ingo.kubbilun@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Nov 2026 14:53:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V7uw9s3BttHn8uLjxD8mt5=3iYXA8cRzLU=OYFtS65Xw@mail.gmail.com>
X-Gm-Features: AclHuK-RbyOy8ftZMUgl48mYpe4QeeCSa1rdMVaF_Nx5YV_pqN8sAshDCVlegf4
Message-ID: <CAD=FV=V7uw9s3BttHn8uLjxD8mt5=3iYXA8cRzLU=OYFtS65Xw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: add BOE NE160QDM-NX4 (0x0d25)
To: "Ingo A. Kubbilun" <ingo.kubbilun@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Nov 13, 2026 at 1:45=E2=80=AFPM Ingo A. Kubbilun
<ingo.kubbilun@gmail.com> wrote:
>
> 16" panel of the ASUS Vivobook S16 S3607QA. Without the entry the
> driver warns "Unknown panel BOE 0x0d25, using conservative timings".
>
> Developed with the help of an AI coding assistant (Anthropic Claude),
> which drafted the changes from the Windows ACPI tables, existing device
> trees and test logs; reviewed, built and tested on the device by the
> submitter.
>
> Signed-off-by: Ingo A. Kubbilun <ingo.kubbilun@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Please follow conventions from recent changes to this file and include
the EDID in the commit message.

Please also provide more details about how your AI agent analyzed the
ACPI tables. Did it use the ACPI tables to determine the delays to use
here? Can you have it provide a commit message detailed enough for
someone else to duplicate that effort? ...or did the AI agent just
look at the delays of similar panels?

-Doug
