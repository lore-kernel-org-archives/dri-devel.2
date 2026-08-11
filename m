Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E8CC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6314710ED55;
	Tue, 11 Aug 2026 18:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dRH57UJV";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BEA810ED55
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 18:52:53 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so81311a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786474373; x=1787079173;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/A62uLpxfiS9evE/MOrYEJH336pQ9QO0r0n78qP4dLA=;
 b=dRH57UJVqCtdrNiuQMEXFtSWLlfSBzqTXRLUMn0i9sRba4MO4RFihSahfY1ZZvOd3p
 AmK1NFNyO+R3Zl23SxERzSlJVIfl9VBg4TlrpehOfsOPpU7E5z3J262SUxRQipogSLrc
 f7+1vCzFJuZr8khnje5N0FtjLQAzvziMSDKdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786474373; x=1787079173;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/A62uLpxfiS9evE/MOrYEJH336pQ9QO0r0n78qP4dLA=;
 b=RP/zERMGTZl6BbY0e+DMc9dT3VJHO792XeCEIXmGs5hIR0QWtwfGnlk03e5fS6a84Y
 ind/ax6CE90VS0vG6N1YN7BHDZFLuReAZk3Z3mhJjgggu1ASfTjWQjNfiBZfSLQu4AAO
 zgxxFqhDofJYiqhEjL3F0DKiIeprSz49QdEsyDH/xu3PXmsMHqCGLCqgmO32HjZ9FL2+
 IacDW1ef9HYoLxH+IP8s+w1EZiegFlsT/i/fPVLhgUrpC7ln/Giy5Dxhq+blVU6cHu8x
 bd36zchj2mIFMO+CY1PGZnqB5qN0fyBGRwUxlDa0s7RFnpfEUh8xyOGSZrncIGdkaVSj
 vyzw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpq7S55RycOa92YtKRBGUXw0AtpOrkY3TxCNBUBns9ZPwRkuBffoCkpJiHwncIlbLND7tOFQg1fRo4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzbh9ldkikOpJneMSS7crndpm0130hixetigeVvozaXbqWbECQ5
 I1oQ6IVRfTC1kmXvqbfLaweDx59wjtMoEZzaFrGd3I0k8tXruM60z2NRB/CzzLZjZA==
X-Gm-Gg: AR+sD1194lbxo7759Kti/w97D00oHYtwgZVLnOVs4UJyedZ1rLUaj/Gc4NbrE8xZD2C
 nIRWqdMUtKULiceNqFmM5dSR4HlafrNj9a+40LIbZXLlcNDj2PDGJqCCh1cKNuIQZJTvHLzueh3
 xnM9Zq5h608RYyknafvB+7a2M4vSRDxsnoHwwL4NMaSXDj56aebHQIjSwQLFw+7b2JujWZVXJmv
 SrNdubUJb2o88XLDsDZtVAsYLzVARlMf9q3SKXXThAxGNG5YPZ9aridYwFJqpTE7HZQBRkvKMsP
 SNPnlGpw272/2jXti98ESOLzSwWoW8Bh9YTJjoft9W0FgGh8sRs3HWLlpI5J3JuuEvLn/euOf17
 Z33M+bLvvp3dbP9NhowfIOdHQQuhyBpoft+cxgkEBJu7wGsvR0VJ9vAk64NiB6+QmfrNgo+dyt8
 Lz5kILmGVIlaKPdM3yjcY4cEP3qCC5zFAYiCcEMEIfSrHjlf+gScptswMjrKMtk2lAn1353ON3s
 7+fSVLYkV5rF48E9+du6xTpiHQ=
X-Received: by 2002:a05:6a21:699:b0:3c4:396d:4a7f with SMTP id
 adf61e73a8af0-3cc2ba20ae3mr7611480637.15.1786474373068; 
 Tue, 11 Aug 2026 11:52:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79fa:d268:80cb:4947])
 by smtp.gmail.com with UTF8SMTPSA id
 5a478bee46e88-31cf6d7a3c7sm2872543eec.29.2026.08.11.11.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 11:52:52 -0700 (PDT)
Date: Tue, 11 Aug 2026 11:52:49 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: chrome-platform@lists.linux.dev, corentin.chary@gmail.com,
 luke@ljones.dev, denis.benato@linux.dev, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, prasanth.ksr@dell.com,
 jorge.lopez2@hp.com, mpearson-lenovo@squebb.ca,
 derekjohn.clark@gmail.com, josh@joshuagrisham.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com, florian.fainelli@broadcom.com,
 chenhuacai@kernel.org, mst@redhat.com, wenst@chromium.org,
 tzungbi@kernel.org, jwerner@chromium.org, tzimmermann@suse.de,
 javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 krzysztof.kozlowski@oss.qualcomm.com, andersson@kernel.org,
 geert@linux-m68k.org, dmitry.baryshkov@oss.qualcomm.com,
 arnd@arndb.de, ebiggers@kernel.org, luca.weiss@fairphone.com,
 michal.simek@amd.com, sven@kernel.org, u.kleine-koenig@baylibre.com,
 bhelgaas@google.com, dakr@kernel.org, o-takashi@sakamocchi.jp,
 titouan.ameline@gmail.com, kees@kernel.org,
 dri-devel@lists.freedesktop.org, oliver@liuxiaozhen.dev
Subject: Re: [PATCH v12 3/4] firmware: Rename google firmware directory to
 coreboot
Message-ID: <antvgf6pF8JbW9BA@google.com>
References: <CABtds-3MAA8y5ksGcps6s-iLx8dOF7EoJEJH9079Y_E+-bJB4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABtds-3MAA8y5ksGcps6s-iLx8dOF7EoJEJH9079Y_E+-bJB4A@mail.gmail.com>
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

Hi Sean,

On Thu, Aug 06, 2026 at 01:28:26PM -0700, Sean Rhodes wrote:
> Most drivers in drivers/firmware/google are coreboot table drivers rather
> than Google-specific firmware drivers. Rename the directory to coreboot
> and update the Kconfig prompt, build path and maintainer entry.
> 
> Keep the existing CONFIG_GOOGLE_* symbols to avoid user configuration
> churn in this mechanical move.
> 
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  MAINTAINERS                                                 | 4 ++--
>  drivers/firmware/Kconfig                                    | 2 +-
>  drivers/firmware/Makefile                                   | 2 +-
>  drivers/firmware/{google => coreboot}/Kconfig               | 6 +++---
>  drivers/firmware/{google => coreboot}/Makefile              | 0
>  drivers/firmware/{google => coreboot}/cbmem.c               | 0
>  drivers/firmware/{google => coreboot}/coreboot_table.c      | 0
>  drivers/firmware/{google => coreboot}/coreboot_table.h      | 0
>  .../firmware/{google => coreboot}/framebuffer-coreboot.c    | 0
>  drivers/firmware/{google => coreboot}/gsmi.c                | 0
>  drivers/firmware/{google => coreboot}/memconsole-coreboot.c | 0
>  .../firmware/{google => coreboot}/memconsole-x86-legacy.c   | 0
>  drivers/firmware/{google => coreboot}/memconsole.c          | 0
>  drivers/firmware/{google => coreboot}/memconsole.h          | 6 +++---
>  drivers/firmware/{google => coreboot}/vpd.c                 | 0
>  drivers/firmware/{google => coreboot}/vpd_decode.c          | 0
>  drivers/firmware/{google => coreboot}/vpd_decode.h          | 0
>  17 files changed, 10 insertions(+), 10 deletions(-)
>  rename drivers/firmware/{google => coreboot}/Kconfig (94%)
>  rename drivers/firmware/{google => coreboot}/Makefile (100%)
>  rename drivers/firmware/{google => coreboot}/cbmem.c (100%)
>  rename drivers/firmware/{google => coreboot}/coreboot_table.c (100%)
>  rename drivers/firmware/{google => coreboot}/coreboot_table.h (100%)
>  rename drivers/firmware/{google => coreboot}/framebuffer-coreboot.c (100%)
>  rename drivers/firmware/{google => coreboot}/gsmi.c (100%)
>  rename drivers/firmware/{google => coreboot}/memconsole-coreboot.c (100%)
>  rename drivers/firmware/{google => coreboot}/memconsole-x86-legacy.c (100%)
>  rename drivers/firmware/{google => coreboot}/memconsole.c (100%)
>  rename drivers/firmware/{google => coreboot}/memconsole.h (82%)
>  rename drivers/firmware/{google => coreboot}/vpd.c (100%)
>  rename drivers/firmware/{google => coreboot}/vpd_decode.c (100%)
>  rename drivers/firmware/{google => coreboot}/vpd_decode.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e6a8c271e79d..62ddee473f55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11069,14 +11069,14 @@ S:	Maintained
>  F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
>  F:	drivers/net/ethernet/google
> 
> -GOOGLE FIRMWARE DRIVERS
> +COREBOOT FIRMWARE DRIVERS

I won't weigh in on the Google-to-Coreboot naming, but if you're doing
it...
...this leaves MAINTAINERS sorted incorrectly. You'll need to move this
entry between "CONTROL GROUP ..." and "CORETEMP ...".

>  M:	Tzung-Bi Shih <tzungbi@kernel.org>
>  R:	Brian Norris <briannorris@chromium.org>
>  R:	Julius Werner <jwerner@chromium.org>
>  L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
> -F:	drivers/firmware/google/
> +F:	drivers/firmware/coreboot/
>  F:	include/linux/coreboot.h
> 
>  GOOGLE TENSOR SoC SUPPORT

...

> diff --git a/drivers/firmware/google/Makefile
> b/drivers/firmware/coreboot/Makefile

I think something about how you sent v12 has broken a few things:

 1) some aritificial line-breaks; the above 2 lines should be 1 line.
    This breaks `git am`
 2) the email threading seems missing

v11 and most (all?) previous versions didn't have this problem.

 Brian
