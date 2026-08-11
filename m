Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAE0C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C215210ED3B;
	Tue, 11 Aug 2026 18:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H9BehyDJ";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6F210ED3B
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 18:50:12 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so499391a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786474212; x=1787079012;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GnHJCm2ZqOWuDJ2d9OnSHmMgxlAtHC/PNWplMTJtneE=;
 b=H9BehyDJChgE6xQkcsr0pcut+nYrG+PGDjuVYWHgOU5H033NDVsLTkk9QpS2XY2xsx
 Pj807kXVf1W5iGZhYupyl0FNyht3tG/bbF+s13zjESe2e4/0bHv/xzgqY72mYF7PaYwK
 aXVsrVR0amov308um1Il0lMaeJiiRxvhtxM/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786474212; x=1787079012;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GnHJCm2ZqOWuDJ2d9OnSHmMgxlAtHC/PNWplMTJtneE=;
 b=G2+vpbo4lANeZctzplf/4P2kzM4wzXwU4HiGrpHGk03tqNqXy82hCoNQ0CZUBonfov
 HY2T5Pl/In5q4dfrCMS68IKtPe0YnEtBC0texuuvck+8jD+w6vy9FJA9NuFXHzFIK3eB
 IiOk2eBtC5SbeAxk/1ymN0lEMKhRjD8RpJJhWhbMLFQaPhUS2INtCOHGJsOpqzfG7fBp
 BnUCJA4BvZJGa+lOJThhEOlL+IdHgCfOLFY2RQ3Aiz6XtkVtVVBRKlikKkWg/j/knHAX
 GabpAyL05KH4ElKGZRePdROG08XN4XjNIfvRAcwqvteU4NombQhjJSS0HpT2zNL3fiII
 mRXw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhGR1swZNN2zFDiImmHRwFYNAi53zfmTyo1Qa2JG1Mb0QxLqjyYsb0Uel8EN37hr9YCRNJfDApYL0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxU5Vrhh4nAnX59L+33dIoF9lj3WmsrPRmDaxOcxuDBKlaKPLQR
 Jj5zAARdvnQRE9mswPc9ubvvuoI8sx/q9dGbdB7yRiBPlTa5y+IL/OQNRD5UffiP/A==
X-Gm-Gg: AR+sD11wqLFcU3kcZpVbqfisz4jKbv1H5xj/OnNhiGeV9BWO9cEueNZaYPKF0+ltzb2
 m1I2OwOyU2gR7NayyjYtrDjve6cCynmK1YNstz2gMznA/xztO8dQ1rZZ2gwXPgfl4eEKn01JkON
 hCkrGYKIq/v0OPQx+RczIeioQclGGsZ2JrxD6V2aatUzRVYIMqSnDfbuQiAEOGyPj+PKnTqDeLx
 tag7Jw0vU2C9pLU779k+STOJT1n977FVpO3885i0IVATNBKpiDEAXs9IK4fcC7cyv1wX+jY05p+
 JSl+6ajXdCEKOQRupn23Jot4MDjNovu5gb0zclQnfmoQUqWwRv4N42TQszZbSWOmnLlH2zMmA22
 i/lBtEmdDRNqM2Y8qBb83b4skMSaO2uir97f7JSeEpE4VhT56DMsP1FjG+FxLr7hTKqQ7ZHl0pz
 bAncXeYL6uRQzLPLyRx+km25drF+CnFu0RGOyJgAoE6s6TKIaiN3Snt4uuHxCF7Vr4nAaVZ/rSj
 7H6k2yBnTkREivUNGWk651+EKg=
X-Received: by 2002:a05:6a21:3117:b0:3bf:b7e8:68ab with SMTP id
 adf61e73a8af0-3cc377db1cemr3285344637.2.1786474211555; 
 Tue, 11 Aug 2026 11:50:11 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79fa:d268:80cb:4947])
 by smtp.gmail.com with UTF8SMTPSA id
 a92af1059eb24-1412458a390sm1677688c88.14.2026.08.11.11.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 11:50:10 -0700 (PDT)
Date: Tue, 11 Aug 2026 11:50:07 -0700
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
Subject: Re: [PATCH v12 4/4] firmware: coreboot: Add CFR firmware attributes
 driver
Message-ID: <antu3wHFDzxMXBKd@google.com>
References: <CABtds-2qyH84oOG_JhXN6eNQOV9H9vhQvSG4JCv5E+r9VdwKcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABtds-2qyH84oOG_JhXN6eNQOV9H9vhQvSG4JCv5E+r9VdwKcw@mail.gmail.com>
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

On Thu, Aug 06, 2026 at 01:28:39PM -0700, Sean Rhodes wrote:
> coreboot can publish a CFR tree in its coreboot table to describe
> firmware setup options. Add a firmware-attributes driver for that table
> entry under the coreboot firmware driver directory.
...

Kind of a large driver, but in a partial pass, nothing jumps out as too
scary to me.

> diff --git a/drivers/firmware/coreboot/coreboot-cfr.c
> b/drivers/firmware/coreboot/coreboot-cfr.c
> new file mode 100644
> index 000000000000..54aae1442bcc
> --- /dev/null
> +++ b/drivers/firmware/coreboot/coreboot-cfr.c
> @@ -0,0 +1,1208 @@
...
> +static int coreboot_cfr_apply_runtime(struct coreboot_cfr_setting *setting)
> +{
> +#ifdef CONFIG_X86

What's X86-specific in here? Are you just needing inb()/outb()? That
seems like you could 'depend on HAS_IOPORT', or #ifdef
CONFIG_HAS_IOPORT.

> +	u8 status;
> +
> +	if (setting->runtime_apply_method != CFR_RUNTIME_APPLY_APM_CNT)
> +		return -EOPNOTSUPP;
> +
> +	outb((u8)setting->runtime_apply_id, COREBOOT_CFR_APM_STS_PORT);
> +	outb(COREBOOT_CFR_APM_APPLY_CMD, COREBOOT_CFR_APM_CNT_PORT);
> +	status = inb(COREBOOT_CFR_APM_STS_PORT);
> +	if (status)
> +		return -EIO;
> +
> +	return 0;
> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +

Brian
