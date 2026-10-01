Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ABCCA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9601510F6CB;
	Thu,  1 Oct 2026 14:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mk4WOmCx";
	dkim-atps=neutral
Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com
 [74.125.230.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624E710F6CB
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:04:04 +0000 (UTC)
Received: by mail-lr2-f35.google.com with SMTP id
 38308e7fff4ca-3a7756096e7so19279981fa.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790863442; cv=none;
 d=google.com; s=arc-20260327;
 b=BA9rnKqsoM4QlXtFPaTqChJAV6X5re6EW/DvQ944e+etfHu9cdBGFOkWRPHWub5GaA
 GbvBso1pNDnUnehxCN4QtGPYcb/+1kI6wapByuDNOyiJ+UQmH1dh8ChZsb1C1Dg9KAWM
 RxwruMXp2s0XUourJOGIL2KxI2hEte5tThe6LUf+h5TjyKTWu+ABCRPD+fgaK5BlwUz1
 b+fcRlH1VmuAe9bUwOXHRPVuHzBB9UPqrfVvdjmlpq30k+C0evrXWLx2tXQyzalxZOTY
 cCKPjxHISGxYQR3Rqkcs7ZqKQO7WvvZzQfF+v5IZrjRiWsJq20fGJyXkAq4pZl2Kz+9m
 k5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U9jLK7/wc7B6mGa6+VCwGx4Ieg2jj91kEAwv06rg/rQ=;
 fh=qNQtGL0YXtGbdqhUGWow+OvvsXJFcPEGRlrFUMnmkWU=;
 b=bwySHhVpeWYGJCySsepO5VgPSHPhycCnjsUn7GrU64cvxZ8rI3OiSHOQLHBqI2A3gD
 Vm9scNaVCa94o/kUXGVPPkym204kDa4DmcEaoJGIsU4WF8Z77GjuJdinxK3egZL9L0w1
 E9C0MhkkQy1ZZct0RY6Nnm2sedry7Aww7wyoROTSyyruUUIsBVrWN2mOQzzr/Y3eayVh
 ifV9MJHWI0UU+qNpT3eKT3hAyI6e3IBJgwBeGWDpz6/OwJFZI45Q7ZilwJEpg34UVwA0
 ydZpDR6xY8711xPlTcWYINARjFHcnNwy6WZpT2RW8Ksju5mSvtbJM6DZIYK0BOYTxbnT
 Ie/Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790863442; x=1791468242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U9jLK7/wc7B6mGa6+VCwGx4Ieg2jj91kEAwv06rg/rQ=;
 b=mk4WOmCxUGd2xfciwRQV2mrprzVhHtqLFVS8tf7w77B1hzOyTtQW7S4lW/uJ6DJRZ1
 d+r1ajcsKVHQis/5Jv1h9LZkqO1nGkwoLx0TxjH/r46ioJ3A4Hp/AHE4iHqdQ+4skAtQ
 hUYp3xS2y088HGT8F1/fu4197hhM68+gbcYfWdSXEfQwXtsE/wS3qePqswZdUGTxpPz3
 3hezsLqFApRwZLqbSpx+WQ/g/favLo/B6Rr++7C2Fx2bWIwlVZF/MevZOZvwHZk+gMga
 pbk0Y8hnxVV60tMc8tGbK7qIW7U/PXvgSvXSfNHf0p1v8OpsJNvGjHJ45dQ0AR6baI2Z
 mD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790863442; x=1791468242;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U9jLK7/wc7B6mGa6+VCwGx4Ieg2jj91kEAwv06rg/rQ=;
 b=KCAncXthGPvbNiImw23FoQRZLREk3y9UQyqVhmbPiKgorZfq8RKa5gpeM6Ui7gI+z2
 1yZsF4e8/UaGgri36BOlkiMQX1EcWG7aygAP1q8upIU9QRkr8eH0MV3EswYxn3OkqLm7
 1VxoCCWepQHxwhrYQ7y4v7isnhUKHUyuK6ZFJVRGjqs7mWxOhBblZ+aFAlwE3OLMPM0C
 DHGFxgpCBy3GzsA1Tujch8el3lg4juz7WjkEpoQ2DE30h1BKONqBeBGUheuPtXB1qQZl
 9JHEgvG2VT+9tizERp8C14M97TeEER5ccRZaKZnV+3d2fdOoInagEiEOySj/oVCkYwuL
 PBjA==
X-Forwarded-Encrypted: i=1;
 AKwUvByN3PCacpqjig3hhT1eY2MurIRdFl5vlLdocIvjzp0a0xYIUyLv6RZ2n7nulJSAPAYGTF+SU/f0rww=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTclmOc1m016h1p+fU1MNt0WTV6Qm+8lSPLXHhcS9VwXhCEEi1
 IuyxCU8GIu6ACxPB32DtXXcX4gpvdB8T5V7ldyAFHtd0+N52PPcqTilkzI1mLZcGSOwapX1Lu7p
 su75hmlcO/IRg2KMhJxjYPAb47VdNJsU=
X-Gm-Gg: AYBFou31ltPHyKqpciA9c5ywiXQsetxOl9TmY01ihCfvn9vYjUWgJkmOeYGnmcM7dps
 9z7RJUCehJ7Yw0WJ4k6fdlMt5tcYgC47UQk2gEm815BFNH7gjYclTd2XzLabzXIy5m3jlZC4HFE
 G40PfLyye/Vq/Z6DDsOWQqUwUL6PFhfx9BuAQSMpXysLXl2rmxhamphdg+ESDUcOGL7HRdxvCKW
 8wCnoVHz1JyPUbyzwx12B9TYqJKfpM0+JltuedmWZvDjng6UtPIijyKnO/uxDyBdvuvRsBj8hEG
 qwuIBf75DxOWDvHBqz8KfWkNMEhbkUHZTlGg9iBNFSGx8k0zRKRerTzKG/kVWjo6J50B8oJYNcv
 EZD1kPpU5/1vvRxBZQPe+Wz6i+Z2N/C7qDTA39sE79oDg/M6gtCCz/x45JyxdtDSUY5heGVvw1f
 heop2FKm51IxklYSJ7PguIGysC6afFMP+lJtJiRZPG
X-Received: by 2002:a05:651c:2121:b0:3a6:27ba:be0b with SMTP id
 38308e7fff4ca-3a77928dc6cmr16119671fa.20.1790863442038; Thu, 01 Oct 2026
 07:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20261001133736.802604-1-tzimmermann@suse.de>
In-Reply-To: <20261001133736.802604-1-tzimmermann@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Oct 2026 17:03:25 +0300
X-Gm-Features: AclHuK-MGGGgGsa7XTJEX30X4AH0rHlA77AtOEFwmZmXzvdKsC2XJRDqSMsLZSA
Message-ID: <CAHp75Vf80MzmPvOK7Qpy99dxoKY1JSiJWM6KUVswoO12LgtuBw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm: Remove simple-display pipe
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch, decui@microsoft.com, longli@microsoft.com, 
 ssengar@linux.microsoft.com, andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 sashiko-reviews@lists.linux.dev
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

On Thu, Oct 1, 2026 at 4:37=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> There are no drivers using struct drm_simple_display_pipe left. Remove
> the related helpers from DRM and clear any TODO items. Hyperv-drm needs
> a minor fix to include some additonal headers.

additional

...

Makes a lot of sense,
Reviewed-by: Andy Shevchenko <andy@kernel.org>
with the spelling fix in the patch 2/2.

--=20
With Best Regards,
Andy Shevchenko
