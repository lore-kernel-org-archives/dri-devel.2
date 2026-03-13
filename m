Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC98A105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C9E10E09C;
	Fri, 13 Mar 2026 14:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="L9ZDUkRP";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26C310E09C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:30:58 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b94358796a1so314194866b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412257; cv=none;
 d=google.com; s=arc-20240605;
 b=dI3ZrYV7tOwtpaW6barrhJxcGtS9Z1pA4usCHMww5fZU25xv1nSZ7p0GSUMgHIz54O
 2WonUh3fPfFq0TKbaBHji+3qVDlHFVcA6iQw2B6LxzkL9+lClg76TQi+VCWRxYNJ41dI
 aMz4ANWjavpIssbfAg65XQWsUo/K2GnfJ8UnlvfFudpM9HGcWigF2b/u/0boskp/l5QD
 ueNH++grquRzRL/Vs2O4braTFRl7NNgG+KvYCXzenhMUSVHVRRhrcull7YT2iVq5iI0i
 7TAl687Ln3+5iXLqp2osSB7Af6jn2PTD+APiKcC/T2ZlaNVyVxfqEgKONP2gD8WSMXFg
 oe/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LRxonFHxKOFtwLU4vtjcCaWjDuObgsewD5LZ6SLLhBw=;
 fh=yrU7FU2pNiW7tXPis/GQi75kRcy3Vnebi11hcsbvb5s=;
 b=XxG96AkXcELIYdYNZ/lxG0yZA5EMH+UDc/6nIV+HV/k2y2Ughmf5ZVQ8b7bkszSryn
 LHMZrgE1kAFzN2t+DCfH64tdzJA6a7HN2YpRZy0Jb5/ZiZty2FzONfiwcabSXb1DtcLS
 lvGp1qSf429qXOkCXTL107k176qaO3Q2Cs6S0OWxkq7GDviswrzlkJnLjIQjIQeXMJwp
 2AwstBO8B4Od2wqxdSqKxCe9+ElEIrGm8IV5+f64qFtQrt6yphhNm/VGDWRRbV3TT2BT
 FSioCMLjV7D0MPdbsDCJ4E4P8qMWyApbNfL51OwKhU4j04ulouxyuCvDIlL//mt2qTIy
 Z1Yw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773412257; x=1774017057; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRxonFHxKOFtwLU4vtjcCaWjDuObgsewD5LZ6SLLhBw=;
 b=L9ZDUkRPDOqVJMDjsyN83qRs9iD5TquISN6oD/q4YF8hNSbvtYOe0eorLHilqylYOS
 /KJNHrsT12T43TlXOrONJjDSOJ+RF2r3eRPQyCCfBNzNyDCw4gdRqM1FJqou9bnraFJu
 8h3FCATlqtCsLsXrygRIOGSarcLpfLw1ieCBuxBfx4zZcI2GkGeKpKCwjV+ZLMSpq8yX
 S3+H7NFW536oLYcSLXpMBK7CSxX+3ds8QwxsAwDyFnT+f2VCHUNFI3aoEcrR76sB4Mp6
 BpOEYbnRv8e/082Wnhi3tE2P10ck4J1nYx2td+29Y8ZYKO9mMuZqBv/YYNNT0QyLcOSb
 5ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773412257; x=1774017057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LRxonFHxKOFtwLU4vtjcCaWjDuObgsewD5LZ6SLLhBw=;
 b=d0gf3Vn6QSAzMFXJvMx11o63zPayQ5ubxRJAehD+Wjz9Su1TPR1BXBhur+7G0E3tap
 jmWmQ2SWmdSod2xIeZyRy+7Id9LTx8y2GQUZEnzAZHBBKhqcS/GyRhA2e9OG6fbvUrbY
 DFXKdKqeHJY0n74EDLl1xJUgADqvjCEU1US8aUQUbCrUhDPhPDnhpmutsxl8Sp0HUZ4z
 HMr9olsT/B6U4W55n6nR3FUA4hsAmK5mdIKuc8fxlgrrUHEROpakA+5BNfJpsH3+onVj
 58b1NakVcZb7nGe01M93qy93OtBg8wEQZeZyhhuRFZNVGCuyrSOgGHB6xYq6TnnEYRGc
 IYlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnZYoWShCiPR+ezwiTGCc8WlnQxAx2q6A1D/l2EFM+pwT7QoJFSdEHinCTIBuY5tsNa0FdkJSxyd8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwY3+1HhVSYIYQaFND/I0sdsSj1e0Xa+7AOiCzNP4UATcPfoRyb
 d3r7xCK0OaFr0a2cgj4OlebI3nHZmkUQL6xvuPjdW1qnAMm5zI4QOkNAOOKNmWmveWxtKm80R/4
 N4TNecHCBl55S6a/SJsTcuMMTH6tJF3getmGZdXQ5mw==
X-Gm-Gg: ATEYQzxNNOCRa8YOCpVMsueVosSGyzGZOyTlWnGcFpjq1nxMpHszpbCprkXk6WPrRvT
 qfYVlF1n/G1Bv07zoznCUqqR/9kbeLminpNynfJNBMDvuPr40heRwlHaLhHSIMhj1Dn3tfzADqT
 RATabNao1+TLz+Z+Ts4LPOviQCKuHpA3gYroDdgSoWT/yiM6ogNFrMPSnQVOaqyQbuuA2bgXJmw
 SrD/mfzt7pLbhauJGaq5+Mij5HzjiCOFU9HUG6LNlZoOSKT0v2PlN50/RuO49COU11Xa4GzEzed
 RMMm8HC7fMI0IrZxvv054MWzVzKF/P3SdYCUEip7
X-Received: by 2002:a17:907:c11:b0:b87:1c20:7c63 with SMTP id
 a640c23a62f3a-b97650e6e92mr207376766b.20.1773412256991; Fri, 13 Mar 2026
 07:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
 <CAAofZF5XSUVn+XW75rC76-Amibc3rZnG3QQhWxPtk7K6YMQx4w@mail.gmail.com>
 <50e3d83a-c90b-40a4-85d4-f5b0b474ab97@amd.com>
In-Reply-To: <50e3d83a-c90b-40a4-85d4-f5b0b474ab97@amd.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 13 Mar 2026 15:30:44 +0100
X-Gm-Features: AaiRm50wX-gvpB6CSw1TM_ZxnjyuF9CD-NmCqCiMXD1oDbU4mspiNqOOHLx64Tw
Message-ID: <CAAofZF493ZvbZa0qpTjKU7VZgnGcG6HFuPF1SMDk1+S3kiW77Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Replace old wq name and add WQ_PERCPU and
 WQ_UNBOUND to alloc_workqueue users
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Philip Yang <yangp@amd.com>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
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

On Mon, Feb 23, 2026 at 11:51=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> [...]
> I don't have time to go over that again in detail, but skimming over it l=
ooks good to me.
>
> Feel free to add Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com=
> to the radeon and amdgpu patches.
>
> Felix or Philip might want to check the amdkfd patches.

Thanks for the ack, Christian!

--=20

Marco Crivellari

L3 Support Engineer
