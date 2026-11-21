Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F100606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EHt0U1PH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DBFD10E90D;
	Sat, 21 Nov 2026 17:58:05 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A1410E92B
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 17:57:59 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b4f4095a7aso16346647b3.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 09:57:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795283877; cv=none;
 d=google.com; s=arc-20260327;
 b=VbR9LIa5es6OVBMMl0LQjQtegZZWjo+WyL+q3tPDiQQmqCGnIWsYaafNVBoqpafKlI
 5Uj/+mLjmluX9HkeVWaeeb7NZmcJExZk3H4lLOGCsufqVFdnz+cLjCrrx9GsXeFeyVW0
 Q//VP0F7ve1vo8LC3nUhYFZNTN2Aiu6BkhV1+RC7mn+5lEMJbI1UDAUMDmipfEsZdKsk
 FENbrGkUHegtNlmJn+zwg9kfxI2NM63ldH4PmaY8ycshjawMc6NgYaFI++wmS4lu7jgk
 I9QwGXM9TJ+3cd/95nDoi5QVpq7TqufOntoZXQBLBq3Z75SDW0jbF7qNm09pTZXtjOLc
 a54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9dxaFlJRZuXJMii9iS5rhrUq3M78QjQcIGXNp7AQ9tg=;
 fh=UBAs2EiTdZLm1SgjAZjgXHiDSIfASWhaSvi4tLgHocs=;
 b=cmPOmB+a7GGtY5LT4OYzOxcLSWyxSC1a4qdIkil99MfqOQFmEtpcmYF1POpemETGOm
 JoUYHfKloopTrxO/d6lTu0dXmZXl5UKfwi1gw0R35hZhS0BBfJXpc6vDu2QL2Lwpo8CW
 Sg40zm13od0mJf0Cnw+9wAOxnlavpYzzGVS9m8dqzk1+eGp8dSrtdNW7etdXc2YSaodn
 wbK7LWEFMx+ykMl/rcLLkcAUjfqSHwjxXES+A1R87XbdEn252/qzXv0j8nitVWjszgq2
 nId+FzrapXKG0jxCDXFcUoBJHsumMexnS7DFiNGFLgNrRghuDuV/0Do0PqIetoLd+x+7
 qRbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795283877; x=1795888677; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9dxaFlJRZuXJMii9iS5rhrUq3M78QjQcIGXNp7AQ9tg=;
 b=EHt0U1PHNx650pz/WH8byaTe1xZ9yelR1sNbctwMVeniAx2YzFlC4OuL8AyPW0WHxi
 YdgIKCF6r2SF2Uosg6xV15AcOtQZwbXsSASgOobZ1YxQbF6H7LBoMgsYD3tYGTkTLqsa
 uWEk//gcZowZEYVFVXb8obP/3hSlLEWcWKtir84DxV91Cb/SarMIuc5slQY1dmmm43ac
 LsSCn/O6wKwLg/zvlfaS9rrb4d+dlkK80S3SNxctq3sm/CT3ayNbiUiIHreMcg9f0+RN
 2sqx86ksLkFKC3tVh9Gc+e+/sWOD3ZGAXkZTVrZqD9l+MGrqd1+mSIZ3a/7+13oPmBX2
 byPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795283877; x=1795888677;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9dxaFlJRZuXJMii9iS5rhrUq3M78QjQcIGXNp7AQ9tg=;
 b=HJutrPO4gg1EDp/OMqy4LQArBWoi70EvT8V+Do7DYETmHtYwrPArtyK9ksxfJEb/7z
 ZadaDyecT0SrTgbfx7KpB8qZIWVKx5O76cP0ta55j3oB/loKaDqDke+42m2KZ7zEvYQp
 9Ak8MxloC7llJoL4j/j4A2MeK7S8WvmwxDOQXIbOwZobrRy/iNtQ/vECOb2eIv+rWYCm
 lzhdqeqE8EOjxqv2SF0s75BqOs2J9MYwqELEbLGyY4D+7QOGFxJ18IBrQy21yDfKBihR
 M8ON3ZMZ9ptHiVJAAkSYjczV9KSVisMzgYNTiPDcPPrewQkj+JVgAs1BuxkUufe6aVZp
 Zlgg==
X-Forwarded-Encrypted: i=1;
 AL+hErF1pWPIVX984pinJ2poAKePGAW94i+1+kYkfSDea0x168YelBmmz+IcOtzHSJEaErtw6kMJqx1Lb9Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z84ynO0kD5f5g+WH1kyJ12EtWDvQzSbG4t9GrjRoW0ai02K3BDE
 zbcTV3Rerb9VrolvBV5Xx9PAv23sHEfxccPdUoSz+26APICnH4wGOOd053YP9rps2S2wbySX3pj
 +DkpKNOdV6xftH91JlgDQPaHW9gW16VI=
X-Gm-Gg: AZFdTZdCBSzXWYXxzoY724fsD7FakpMewkZy8FO1yyUN0Ox2mX6xCfI53Qisc5+SQs6
 QY64G5udOBXpRb0u7mtGenrpeV/KP1ggNjbaudb59GwFolBYmY1s++lYSKLDMvhMIMxb0hHcxvV
 hMe/7h1wBJvw7heky/yeReH1oDoF88P2Ti5Tile7BWADDvXhBdAplPBmvuanQ5ft5x7go3Ndunn
 K5sggCgRbAi/D2JOmrokOv7911rd+iaf8TdQoAAFLMIqaVvBBcqeLrYVVq1NtdR+Wv+2hUplfCA
 v20JW4bnNJuswqD09Ss5N2HmGhYPKP5TdVplNSX4LXqSWJGeZiO9Lf/FwTEuzvvSa1BBWKvN7zc
 IRbf0bhh78FeI9DFhiLhJbdp7fmJ8XrgY4j96iCI=
X-Received: by 2002:a05:690c:9b0b:b0:8b0:702f:2a69 with SMTP id
 00721157ae682-8b520500588mr37750997b3.39.1795283877275; Sat, 21 Nov 2026
 09:57:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-img-pm-autosuspend-v2-1-427689f6f2f9@linux.spacemit.com>
In-Reply-To: <20261111-img-pm-autosuspend-v2-1-427689f6f2f9@linux.spacemit.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 22 Nov 2026 02:57:46 +0900
X-Gm-Features: Aa3M54o-NmMelfecL-8e1chO9NJSddT-nsp3zPaudeABWyPskoPrY6_ORqOpIUA
Message-ID: <CAKbEzntsUc4D3Nvxfphy5yApWG+sGsx7VF1cYd3SLSoZKhiteA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/imagination: re-check firmware idle state before
 runtime suspend
To: Baihui Liang <liangbaihui@linux.spacemit.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Baihui,

On Wed, Nov 11, 2026 at 6:29=E2=80=AFPM Baihui Liang
<liangbaihui@linux.spacemit.com> wrote:
>
> pvr_power_device_idle() rejects runtime suspend while the firmware
> hasn't reached ROGUE_FWIF_POW_IDLE. The PM core doesn't reschedule
> idle notification after rejection, so no further pm_runtime_put()
> arrives on an idle GPU and the device stays powered indefinitely.
>
> Move the idle check into pvr_power_device_suspend() and return -EBUSY
> after pm_runtime_mark_last_busy() so the PM core reschedules the
> autosuspend timer and retries until the firmware is idle.

My understanding of Sashiko's point (correct me if I'm wrong):

- pvr_remove(): must power off unconditionally
- runtime suspend: power off only once idle (-EBUSY otherwise)

Since remove goes through the suspend callback, it can now skip the
power-off on -EBUSY.

Moving the idle check into runtime suspend looks right to me, so how
about keeping just the power-off logic in a common helper, called by
runtime suspend after the idle check and by remove directly? Roughly:

  pvr_power_device_off()        /* fw_disable + power_off */

  pvr_remove()
      pm_runtime_disable();
      if (!pm_runtime_status_suspended()) {
          pvr_power_device_off();
          pm_runtime_set_suspended();
      }
      pm_runtime_enable();      /* balance devm_pm_runtime_enable() */

--=20
Thanks,
Gyeyoung
