Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167E0C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E05310EFF4;
	Wed,  8 Jul 2026 06:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="HqaPy0z3";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4A710F010
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:23:27 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5b00ca000ceso372855e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 23:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783491805; cv=none;
 d=google.com; s=arc-20260327;
 b=jxlzXMMaC/Vs7Momnrl43PEbi4Wd5/Y5H8DQLS5BtcLVIo+vPh6wHniR4PqM7tLFyt
 hrPfHcClWdNMUcNxkbo4eB2jUmXyf3JgrowI9wHALTRjVjUZtqcznk1mnY7J0+IZU0GG
 SjEmFO2/8ysKGHMh7yFHk2GQz8s0XBevE20Wtaj2VVQtibhUXAHRYp0UPlajF7lZiQwQ
 U+q2DM5rdFVkU6fBPNZ0lW0T6WZAMoVptoKf1yNf6m5ksSwGiRGrFrLB9O+7FPRQi1sf
 vEVZNwDz4GV53v/jT7ni8hTCsu3kycZr73+fg6fI9MRIkSfoCqcOEsCfSQU/lOxxmJQV
 8xHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2mrsdnvD8wyDjJzaLu44gItX8Fn98lAu0yzczJuLApQ=;
 fh=gBtUm0FmLpJYAZnXRubrhe6u0MvU485gfHnley1wU7A=;
 b=QhTBrJXIY/DJvpGfrvuGWVihV/DCnytZAvh3/TcD1/f/HEhOv+EfOlMdEJqlSJNHOC
 cBCt688D1iafGIdn2PGCU14d/O7NVOq7JxW9jpNdr9yARwYonEEe7AAg9vjzR4uIhg3z
 4tpHDojBbmzLYyC3Kg/3Q1/l1fi7YB1W+s7o778DlM95h1Zh9xiiGqawYg0Coapb43KR
 m2qFKBGFFJg0aXk1ww7PBPrtd8860xMfOIUZX6fM7iAivxk7W9k1W4xKDsTWktBcr+rD
 MF87mY6M/tQeFmDR/dvgNfbAzem19daoH0BMKCz0dsB1cKRS//PehlHdGdHOUbKNIpAD
 4CYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783491805; x=1784096605; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mrsdnvD8wyDjJzaLu44gItX8Fn98lAu0yzczJuLApQ=;
 b=HqaPy0z3L41MHnGdaeMOCyAioRN31Y4eIKGJlLAG22r1ZqcUCjIVHumFd8jp7ddT+/
 kGIn/IHUTj+99bipqc6I9CiPDUcRdlI8NWcrBqMoESbALqQU2n0Pa5OL3XN0JRNUAimD
 Q+qyFjqKcZ1aA8f/oWluNzFZ6CQ+JnwPMYn5o9BEFgi5lOkQwlZr7zeTCOrkWZ6rXZ+w
 c2Rv+Uv7EW6n4TLffM7HsCke5FBAJaEtP0KJRaWIjJMUcSDm91gCQxHN5CX+ITJ+Nh1q
 kwSJLX5y3tcyQbajB/rtz09IcN+Kc9jrotKdYAjm+azjf3G8Z/o3O8ZB2t2FL0krZ6D6
 Zxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783491805; x=1784096605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2mrsdnvD8wyDjJzaLu44gItX8Fn98lAu0yzczJuLApQ=;
 b=JxTsDCUgpy+LgF66RoJcrczYIUUoacFOC6F5wis6lICTmG03qzlT+MuED6/zVW/kaj
 ZnLhoYPtMvBxkd+aLjhKU7BwjCkGZYbW9kRCNLHEzmXDIYul5dB9OZeceeScuzNqXL+5
 +4hLxm6kWQFwzQMf9us4zVDSMm2ljV04873zbCy67YG2MYmndcqgvbt67sUmXsO9+FN5
 EMelhWQM28qvenfoXNvQ/1xx+9svhidzWON9YmYx2SJmpDqK2SHoRW5RnYRqqW4SDXyS
 fpM8l8TyHjb7O08lLMUhg/iL+EnfXaVjjLV8o1VlcVxRiCoHvNyO8tU00lIPFYJ80enw
 kbqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXj7r7Zi4rBNvHL0eLtmotxwALV9BV7PTs4n2KaKdvA43oRTitB1BKTTQZXhRErUm5gZOc+Qx60YY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYoTMWZ3fhAbB9zCqizzTucoFiAwg7S1T9QSF6hj2sYQdEcM1r
 KjQp2PwZ1r0GEPsvOeLhCZeV9e1CVRBpoedCQgKs4ToRLZPP8xmpqzPZ+xGQmxbEwMOz9govQ32
 ZUdhQr6aNjQ+9fuhsDL/aIipkJrgtPXElO6GXp1Bh+A==
X-Gm-Gg: AfdE7ck2YG2Fun4j9dGa8KhrCVg3gjarniTPu4twA9/1vCT4kVeyUi/FLGtMKaw+tU5
 9E635oEwkxRaaEFRJ0VNUCWByEU3q2+lLOH9EUZGUAF+/7l1P/NyGRlWYr3wt7NwSu6QKwh1iJ5
 Wzi2ZP19D4nfH2BxstEg7k5qWC0AhmPmcnT5dAXWFiQZ+nOoE+EAYZHGuStGMoFUo2jGVaXbfex
 545S9kovSHzUs5hhD+hOK8ix0E9ssUL5nrnp1jERu6OJQ1Y03lAfmY48ETrp8VRxrVg1nfux+wm
 /iIvkctEouW4AqoxEM64mWCHlMLLWLhmLYhQNF4e
X-Received: by 2002:a05:6512:838b:b0:5b0:d0d:1f41 with SMTP id
 2adb3069b0e04-5b01145dc07mr247846e87.32.1783491805462; Tue, 07 Jul 2026
 23:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260707093812.109176-1-marco.crivellari@suse.com>
 <12766042.8bMQJbFj6T@timur-max>
 <CADnq5_MHa8L9gWutwRKBQQ5QuM=5qd8eJgC8ZYKyBQQ1J9NUZQ@mail.gmail.com>
In-Reply-To: <CADnq5_MHa8L9gWutwRKBQQ5QuM=5qd8eJgC8ZYKyBQQ1J9NUZQ@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 8 Jul 2026 08:23:14 +0200
X-Gm-Features: AVVi8CeJhDw9N0PwmBetZLqNcsqmdLEyWTsa6Ck_ToyKT89sOJoqix71D3z0JWk
Message-ID: <CAAofZF6186ZO2j-pphxxW=Gg1asF03-ZhcW3Z0-kUB=q3_xm3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Change system_unbound_wq with system_dfl_wq
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Ce Sun <cesun102@amd.com>, 
 Tao Zhou <tao.zhou1@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>
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

On Tue, Jul 7, 2026 at 8:13=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> Applied.  Thanks!

Many thanks!

--=20

Marco Crivellari

SUSE Labs
