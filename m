Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94616FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 09:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D5D10EA06;
	Tue,  5 May 2026 09:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pJJDQnBz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1A010EA06
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:18:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C8DBF43749
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA078C2BCB9
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777972738;
 bh=PDpt20zhGj59+kcTSPj9mPwLYc5JKKTB93oJcq6QCFQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pJJDQnBzs27yKILRcBSN9tDODNZBZHfu//ptqvFN1pluRZ6bJDZtzKNv/BgK85M9h
 vMsufKzwO984XQllPCy/nkQm7bM5fykdV8m3HtA30LJsbUUwYOpPSSWVuwXJvpP2DE
 S/arSGbta8DoJPzrbNhUQjGYDIoORw8cWvC1HMJVA2Nw5C7bprIsHCdw5y0oV9nDDo
 U9vE6kJtOAWLLY7TICzDH/cHmznaUy7nGSvZjPpDZjI3c1BTiEk1E64zB2jsPbZyt3
 RWnxEQ6R/0OLKhJo1J0h1wfXPa5JbcJpFQZyPwyGSkXFM4q7u94a+2wbgNzxf/4Y5E
 XTv8Xr4tEBIig==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a41099fa86so5973498e87.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 02:18:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/61a/2/IOgbJfJ7dOhKRzj3kbI2WeR9po2tE3telT0JBZ/UPMmMEh3MLXNQcCt8gZKrbIqrIhkcl4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQLN5nbEupN+/zj1FvjubaQpSmoeN3zHMlRujFV5cEje2SZV3f
 82mYW7vVEC2F/VJOXZrs9kEhxqDUlDYBveVkZPuX78zS7HElJcQbPbV/+L8DFS5FdnZlvTeptEs
 Y6UzVmChNzcQNjHVkQrKTpWyaRj1IfUI=
X-Received: by 2002:a05:6512:6cc:b0:5a3:f25f:cc30 with SMTP id
 2adb3069b0e04-5a87f206143mr888266e87.32.1777972737397; Tue, 05 May 2026
 02:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260424124118.38649-1-mhun512@gmail.com>
In-Reply-To: <20260424124118.38649-1-mhun512@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 11:18:44 +0200
X-Gmail-Original-Message-ID: <CAD++jLnqJvtx7H3YDfcuqfGHSg_9_xzUJMaLSC+N34J7R18eRw@mail.gmail.com>
X-Gm-Features: AVHnY4I2tEJMDNQZmib-CAOSb_NqD95VZ1sgU3vi5jB49uhkMsGy1e3CACaqc0I
Message-ID: <CAD++jLnqJvtx7H3YDfcuqfGHSg_9_xzUJMaLSC+N34J7R18eRw@mail.gmail.com>
Subject: Re: [PATCH] drm/tve200: Fix probe cleanup after register failure
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, Apr 24, 2026 at 2:41=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:

> tve200_modeset_init() creates a panel bridge and initializes the DRM
> mode config before tve200_probe() registers the DRM device. If
> drm_dev_register() fails, probe returns an error and the driver's remove
> callback is not called, so those modeset resources are left behind.
>
> Unwind the panel bridge and mode config on that failure path before
> disabling the clock and dropping the DRM device reference.
>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Patch applied to drm-misc-next.

Yours,
Linus Walleij
