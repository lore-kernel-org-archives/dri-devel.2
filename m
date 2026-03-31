Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBD8109B479
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2508A10E20D;
	Tue, 31 Mar 2026 14:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L5lck+M6";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BEC710E19F
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:30:54 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d9bba96f7dso3052983a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 07:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774967453; cv=none;
 d=google.com; s=arc-20240605;
 b=X13QRY5+sZnsIx88JnXfQMk4hjVEiXepJsIxIArJNmcuuvjwgk0qQqoEpWvos1d8je
 48gwh/+24xokmLHOeHxVa6pIWW2C3sus8hzroDHFIZ0EWYu+k6RFRjdZIVYcXyN+2y0I
 tzOoMgGt3sYAUCyX2yiAKrjgnRJoTRdzLH65DoxDX6f+/E1+XJCi0jbPfuQw5TXbRW51
 NahkYOCdOUz+3PiLMWtp+KEK5iwVTXaxw9RXog+OTX3RblJnrQxlWfrBMCp90giKr43E
 fYYYeCf6h2t2MtZbYBXusG9HxKhkguSTKxopnU097Ve0HKGs5hwma8XC5CaB1Bl9Sz1U
 riGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2I2GOnwJGHN6Hk1IOfct2T/Z/4LB+r2ueeglPMg3SO0=;
 fh=BQNHa8dZK8t078+iJY0gqISDYVBKfCJ1RESXU/rRLao=;
 b=TQ8cwTWI95jAkq3RjLU6yN2yeCNw+rTB6LqGyBgjnwpSMrCS+sZO4fh1giCa8+SJX2
 8qidLmdnGKZV0o+WpBz87vadADQZ/xKDF6u5LHjiVMCnvPNoo/TpmH81WWWkRtV2VOHi
 x+3t+pOnGgOZTXCnO1HmB002BlwVnggS8NBnIACN+nG12cMHKEvmxRi0QX8J5wYcqiGi
 tPwCFfWbP3OpePeNX0tDqfP/Hv14sC/gK5X+0Y+UmabYK7qZInCTYKNhMdryrv2Gyo5q
 Kq+XiCXLhA/UL1mRGUxDRwF4yQyTO8VJfKEKLGZd0iX0zE+QTLwliohSfrgctNqr46yF
 hGwQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774967453; x=1775572253; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2I2GOnwJGHN6Hk1IOfct2T/Z/4LB+r2ueeglPMg3SO0=;
 b=L5lck+M6aNVN1o1d6fRXncHhhLYZZvQsPyZMUvNNnrvTu9KR9Oj/QaCxUkIHm84OV5
 gBUVgilSPSBukhEaz3QUAowyvIFmiSDLPGSuezWwflb9P+GZyU56coM0d5nWosgL0pfm
 jLusrjDP0fg3p6zHTFRLxyWc+w1MTq81WeXph2eOg6r2BOcG3knfgbe6nxFmmHYWTTSb
 +tIVxq69kKYuhtUNJ/9tZPnpclZQYVnSyvx+AHoLzTCAYfkpc1ayp7p/v4aOu26wctDt
 PoAQlADetnc7dlYQR/mKXZsj+Tc+6T/BKDJqnSYy64rZl6eQ457Ci1Fup48VJhNHwYkd
 2L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774967453; x=1775572253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2I2GOnwJGHN6Hk1IOfct2T/Z/4LB+r2ueeglPMg3SO0=;
 b=q0TCY3oZYjT7fKTg6gIPXrPs/qs1K8Bou6XxRKv7rdMKZV03+M6CBeXznvHlG7EGZs
 ae5BpZ9xIgbpL3fTqjJJScPI0rgbTNoyXHIRFIVKQqzT8A3sRoKZjuaLKe3Cw6TZGw5g
 VD54VICC3IoYwQPPejwcSFx3+ZVHpmXSbJ/9hkweMfUuJsikkXSbdQqQP5C9Jy3Bd/Xf
 FvJgid5cr4BojQk3oa+qoGz0zje1kqG/q5EtqhmgRC8fol6gcawHHJvjwwAtzEwD/stk
 mEs9CTHSn0ogz8lWSGy+SLAf8mg2o8mj7nvAWGvcodZTHJDo0VklZ2r27Zj0WCopzeVH
 o/Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqSLCra+/OxeX/Rnt8lam7Y7NnpCWNzTO76LQisXiblldpjnLbX5GxF6x8QWgn8ipUhUmY/z6Wo9I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsiH70IvqCuEXP9CcGUmXgUdAbHw8sigW7CG0uOZ+9HUh8BASJ
 N1nV5DbhXBLDPuP6BSLEPyxdxYZ3BfefGazNvtj0z09w6s+Fv7a7g39awygE1S+p1+TeWXfVhxj
 oGHKuzhgss/uwp2suH3Qjj3ztMQGzxgY=
X-Gm-Gg: ATEYQzytE5qU0qkGi810MFjc/14KmkxvIwNSiGoeZo6c5J9pNZ/03/Cvgqj5Yrs+fJ+
 iATMY1mNMiZ+4hfZDlan5iV3GuJDI1VanQH25FKkiEGBUdl8LcDALBD2NrgW5FsWeAkK0TS2UqL
 zTaSznha7ayKPNMBaVVi8fJ41/oH9bL7tyzFEA7tEzGgXjB7xFsSRErfwzR+XQnr2GAtERSDTqa
 uII8orjT3jT5uNyY7nEwSa3R5sZp/ksiovVrTEws1+aqAkmSpeZlB6KdsaAILuzx6XN8m18Fp/V
 +57nK3202w==
X-Received: by 2002:a05:6830:6f90:b0:7d9:d54c:6fa4 with SMTP id
 46e09a7af769-7d9faddcf96mr9909225a34.11.1774967453015; Tue, 31 Mar 2026
 07:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260331111808.16578-1-mikhail.v.gavrilov@gmail.com>
 <2fb67e0c-c7a2-46d6-af24-d67f704cac6d@amd.com>
In-Reply-To: <2fb67e0c-c7a2-46d6-af24-d67f704cac6d@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 31 Mar 2026 19:30:40 +0500
X-Gm-Features: AQROBzCIHC5-xaM6l3fB1g21rjj0eWZ0uNmbi9Ja_jt4CDwm7N3S2wRYyKkKeaY
Message-ID: <CABXGCsNcutmHieQR7bfw3c3+8ZhLVRHsgtA+EqbCG7xtEBn4Bw@mail.gmail.com>
Subject: Re: [PATCH v6] drm/amdgpu: replace PASID IDR with XArray
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, lijo.lazar@amd.com, 
 Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Tue, Mar 31, 2026 at 5:28=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> That should be unecessary. We already replaced GFP_KERNEL with GFP_ATOMIC=
 in Alex fixes pull.
>
> I would turn that around, e.g. if (r < 0) return r;
>
> Apart from that looks good to me.

Hi Christian,

Thanks for the review. I've sent v7 rebased on amd-staging-drm-next
(on top of dccd79bb1c7f) with the inverted error check as you
suggested.

The Fixes: tag now points to e6d765de3d6b which introduced the
plain spin_lock() for the PASID IDR.  The sleeping-under-spinlock
is already fixed by dccd79bb1c7f, but the IRQ safety issue remains =E2=80=
=94
amdgpu_pasid_free() is reachable from hardirq via the fence callback
path while the lock is taken without irqsave in process context.
I hit this lockdep WARNING on an RX 7900 XTX when exiting a Vulkan
game under Proton.  The xarray conversion with XA_FLAGS_LOCK_IRQ
fixes this.

https://lore.kernel.org/all/20260331142127.52796-1-mikhail.v.gavrilov@gmail=
.com/

--=20
Thanks,
Mike Gavrilov.
