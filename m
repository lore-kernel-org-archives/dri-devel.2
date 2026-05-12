Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA9BCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 15:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0890B10E2A5;
	Tue, 12 May 2026 15:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NPrzns29";
	dkim-atps=neutral
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CAE10E036
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 15:29:36 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-393d07e8938so52385481fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778599775; cv=none;
 d=google.com; s=arc-20240605;
 b=eSO/8FmTEHx7JDuvs/h1WcBD0BeK6phhDUdTupzwWlGqaU7mNokJScyC1hkaRLpvov
 j5eOftLscqJEZu97P6Md79JEQgIx/vw65ioeK2abPX8JvVv7z8r+TUQQd5R4va1LquPn
 ivMuY2Q9j7H9MiWJk+eDY1eOGc3NnQkRVo4HZ9jmzaYAsjYdtO2r0uRhNPJd4iy+ovo3
 gNOqQRpOjdnUbmTTeHUvPBTpybYLzU2emwNFz7xZtYY/fuVWcFlpLtB1yBqFc0xb9gbt
 YxD6QLpQ9H5aZWPdL4DDidaEJE+mdx8fSL2AtTfoQBWENPbGfwTmDTPlXVAls38YgYon
 vV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1m8Vx7sSpkFzoMEAPBBuv0g6bgC7CqPm0P/FXD5R46g=;
 fh=9tagRah3MHd7leYwtxJAt5sqBkdT7+LcdYSJ7pZnhXw=;
 b=K5oLYaupETqguoqQDPM188vQ3Foa6AcRl0A/W4Yf8X0gLRHIQT2PI9RXPmqj7jNoUl
 PmYkEAhhufKcXhrPNXpH0fIfGV+dcT5tXk+bxgKvEfuNHALbbdmHq5Sm+RyJHhShv1Qd
 BHh1pwLdwuMgCpvqdkN4SbFSf+cIW9AiUr5n3IOBkzKyxpuLTbMaN1xMceLjZAtOC5TW
 bRO0Q6ZRMcVuO0w5WjkmcGSlMnf+RmYDWIv9DfRvvoUz2r6Qx4SfKE5MUbiSe9K+5hL9
 FODSxNkUChxfjwDahK1OX+kP2YykIwn0TOFWegYEsVsejI5XGlRSuwHrklu8x3IIOqLT
 U79Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778599775; x=1779204575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1m8Vx7sSpkFzoMEAPBBuv0g6bgC7CqPm0P/FXD5R46g=;
 b=NPrzns29sqKuxsm6ZI07hSK3sz3ywbqAK6Ov9zMTBC9wvh97idFtBg5HYDPTLmfEjl
 7Ycj87UiwE9Kz8Vpq3AqKIzZgShxmk2XT5PS5mTYKqrNo3iBKtQ+h0GB3tKE+qRuRR+m
 ZajwkOwV8fpHJnzAHiIeBNfX2MIQ2Y9F5BvN0hgAysPBjLfKZMDchoSyBq5lpWk6Za7u
 tEOYYRDVWquGmZfGVe8QpwtQvHLsRMM658vczt4VVV92rfD3xKJjr74+wTNzsAJV9g4g
 sYrYBvmDSPzXdEaWIHtYPIfYGRIfZ+Ygznadad/B0IPccI3/K5eyKHu9VX1TUeZECFYJ
 FVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778599775; x=1779204575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1m8Vx7sSpkFzoMEAPBBuv0g6bgC7CqPm0P/FXD5R46g=;
 b=n3RG8gU7cklrO69axnBqyw6+2XxKKhDfHM0hcWlUUQbJkBgqdXPSJBNCIQX1PhZThl
 xnr1fPrqrEKptQCW0eVGR72EdZGaYg/HOzdzdFuDCZ/LJPc3t5+aQ6hL/9fcfwbwlhFj
 vF4um/AY3TnN4A+BIKVwgNgHZpmcNy6HzntTRIfR/8vJByJdudgFsMYI1he/ZB1IVGdP
 LTVk1fMRoM3YH9kQMVj3nWci4+Ko60aeMq/c0a1QGh4iPZIryqPVtzGFkqc0frJBklFF
 5omuyKF+q+v92PIoULv0QanQcYprp1KE40cWLgZbvCvkSqO4iIiV+luAASaGqx1auRCo
 pYkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8742aRHUaBItohCGppzyG+91+EkiI/l6sZDVZw13DOr4RkWsI+lVA3AoXmHdx80w/degXtvmMreyE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysXDubpuyYorAeN3J6TjK+ShrQO2H5THp5pUp6DAWW/V/n/82U
 Dla3utneWfsCdrHFUfYXjp4cD5FPOqt+5l8Ca1iSFHGvHqAtINuJhezqsY0DkdRrUXx0MZpxivE
 pr4v3MW9sOuWPELbsnKofRPpsYUtA+jA=
X-Gm-Gg: Acq92OHpj7onDFmxcr9dMg9GlY4O/lhDsMCFvkwVXTB/9JGJ5MF10csKXyFaTw/kYah
 1xwx0qXL5wzxmzhi0Ac4uSHmcn70/ThiTUaxJ/wWX61vUevz/k6y3XJ4oL5fWkEF4aL+VMkrZM/
 iCeXE7O2FRbnudwvMeYl38XYmxLgy0oZUWJgJ/gQfbPdhzrEGoT72bqnsVscSsClwtqzKmg6HMy
 O9O+Xn2vSeyANgsGgeJl8J7sEB6EK4mapLFQT4yENUM91XZjWJa4I/SbdWTV+oUw5efme27z6Vd
 KAeMbomr34gCNGWQLWEZux5aWOl13Mrq5u98kGoHDatViKmmSI4G8qvfHG2mAivXNADC+8ZTe8a
 Fp/IUpAu/y26O1O331A==
X-Received: by 2002:a2e:bc28:0:b0:394:2b8a:234a with SMTP id
 38308e7fff4ca-3942b8a5e7fmr31619441fa.25.1778599775037; Tue, 12 May 2026
 08:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
 <20260512-swnode-remove-on-dev-unreg-v5-6-0035eff63812@oss.qualcomm.com>
In-Reply-To: <20260512-swnode-remove-on-dev-unreg-v5-6-0035eff63812@oss.qualcomm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 18:28:58 +0300
X-Gm-Features: AVHnY4L1_zJHNRi354c-jkblkHr8hmHJHYehCTnWbdMU5vf_KkUdHclsjlbuBjY
Message-ID: <CAHp75VcdbpY+DfFh6b61U61X6or0KoVs_akygnAgW27XmmXo2Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] kunit: provide kunit_software_node_register()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, brgl@kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, platform-driver-x86@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 12, 2026 at 3:00=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Implement a helper for registering kunit test-managed software nodes.

...

> @@ -10,7 +10,8 @@ kunit-objs +=3D                         test.o \
>                                         executor.o \
>                                         attributes.o \
>                                         device.o \
> -                                       platform.o
> +                                       platform.o \
> +                                       fwnode.o

You may put it after device.o, 1 line less to change.

--=20
With Best Regards,
Andy Shevchenko
