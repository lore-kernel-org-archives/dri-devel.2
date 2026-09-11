Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3170C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E694410F535;
	Fri, 11 Sep 2026 07:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jR/is4Gf";
	dkim-atps=neutral
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6555D10F33A
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 00:19:14 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-66cf1f9965dso305473d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 17:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789085953; cv=none;
 d=google.com; s=arc-20260327;
 b=KsLp/GkxohDBkOkC9f7GdQFcdzv+nS7xVyd6k0hvgkNXGNn/mVZ/IxGRyKK2b9qutv
 OcRyKynYLk9l1/zinBfCIRlmtAAhdIVLG4544nrYtX8O7AzW9lZM+RhoBdEvCsQr2V+x
 O4YfI1AqWYevc9S9WviU6OlM0hXh93Tld+C9QgDaH3YN/C/Y5pz6YsZcWGuEoUPNwRRz
 KbTOCpSK6hUOZOOOxCLReTItc3yCnP0dYQf6WdBEtn7OxvTH3u7ONsfLh5CQTtyFboGE
 jTAR1PXUVzYWPlfXBX6Fp9CllsqpY7Jrwg5zOOWAK3ZSvQebsvmy2fQvTY/z3t9/z+q8
 Vo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6AJasxW3GodlVjAlTMJ767WLjIvMw4WJZ6v8qOvBjjg=;
 fh=U9m9r8NToeZlKg7bD9W/Rg6D5ZgF7Et3TXCJs9YvnbQ=;
 b=clF+HM4b0FQfiK1FQ+3Kabatu7RFLDJkk0qOhpv9ZyhIvp3LdJTUudEYfaONMlnBjo
 DgwjLQGlsxPW9Iow9QY6lUnBTHJl2rrVWd20GISFwEmX7VQ6CgjM6X4t0S4kA+spULC9
 BPFxgCziv7mwccJC+uqWeIieNA4a/5NwhXUTqrA8zm33j1TWtf+SHhDC8/gwv2aS9/tn
 jLsNVUxagoNjEhn8Fm8l9GaGyhPr1TqJZ3pK0snqPX9l5U97aOXZGJdYPmPTM1+A/QJ/
 0O4P0KdD7JJucl6bpKklmr8LJPegPzVH4DttG1Fl1fPht/knlzINpc02rMtUtju6z7zn
 31Yg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789085953; x=1789690753; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6AJasxW3GodlVjAlTMJ767WLjIvMw4WJZ6v8qOvBjjg=;
 b=jR/is4GfNyu6aTJTIkHyVFpenqgf/flRp6+2/KzL0SUXkz0pGP0A9WNqcYrytMPn62
 t+cmDFRCDxFlOW/GBJwLrEptj6drWCm8XO0sSGqs9BySLUDKrgxmnPzj06o1rHIpNyGV
 SRAqiTQanthaNQ52AjvWpo88ts/XBv6dUdJ5sqOiQgbcK2Sn2wn9WgJ9BkmYXgriOJzl
 RBw8NxFhZYrd0HCkbMpvWsP+RcEcy+H2COKkEOPDH5l8VnxeOA06H/6LIJd6cT/dHUsF
 ZVCb4JRwupAO077+yBsA5Pkknoe4PDoUKWzxWVCfc7yOeyIIZuanrIpqRSbP8hI4DUWI
 EU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789085953; x=1789690753;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6AJasxW3GodlVjAlTMJ767WLjIvMw4WJZ6v8qOvBjjg=;
 b=X1DdF/vWELrCL96HRVCStQtKIuWY4g9TNWt9WqUDe+ay8IVU/ywZGX6fw2FbNlAXwx
 ApMOFgrtaCPyc1p7VRy3K2k0aHtu0HMI8gaIp72LB6AIfQ6YOxt8FsJH+oE3XsFGSs70
 BTvsvMk1Dn0aCrCWbtMdvD9F4+M9uHI7aWDmQgWbsOwdrCWyRYNRQcKyYzAd2wXBdkeY
 d9kZMyT3uspB6GCPXks/93sgx0pM523EhdYRNgPcppiwfao3/ZKQz21zHfxJB680u9HW
 yKv+ivtFKlm+taQ7cDhv26PgW9V4YbLBG0NNU5LKCUaHdUyG+/3puHPR+PxJ4HK1JtkZ
 3crg==
X-Gm-Message-State: AFuF++m5c4CQvdeMAVtQrBaM8PicU6kXtc16U/uMMtEodOh3Xvjnc3x1
 Gh9qANs5cQ2PcXd8Fw+SBUObpke6vJIj5/SSGtJHde1OgVyOW8MwV9d0i3EVlKnQacAjjbzrT6z
 VxaHQVCWZsv8+Yj+a4mD2a+byGR4gwL4=
X-Gm-Gg: AYBFou0gvIgm+mmXZ4QoqkhJ9QONo7dytsQ7jxE3FVfmAJVTXHE5PIjMZHbhpA862vQ
 64KA9/Ennr03GE533N0DnT94cLri9Cn65qcour+sDvYs3e4nSkXYGh9OipLJh8F2D5hkAiClIj3
 yp56pkN2QVyJRrxsevfdHvFJFaPe3pbzKD+2jNH/2A7VOsqgBQqQUDcXa8xDky6TQujVyVPg0Wp
 hO+kWOC6gNyrEagGuv+mPMPrFL5h7onGr+OOcZCWwZrDqCq5pBJ1u2qhYT2nZU9AJrH+C3lLxhi
 rJvjbRlJ9QPoc4XTDOS05Y1rCc7Ab1e0oz4+P/CzDxjrj3ijpT1b68iBouo4YIhU3hM2kcNq8Cu
 e3yTepiHqiSg=
X-Received: by 2002:a53:c787:0:b0:66f:c1bc:4031 with SMTP id
 956f58d0204a3-67124725896mr622106d50.94.1789085953300; Thu, 10 Sep 2026
 17:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260910185030.870-1-frazinjonathan@gmail.com>
 <20260910185030.870-3-frazinjonathan@gmail.com>
 <20260910190542.BE6AE1F000FF@smtp.kernel.org>
In-Reply-To: <20260910190542.BE6AE1F000FF@smtp.kernel.org>
From: Jonathan Frazin <frazinjonathan@gmail.com>
Date: Thu, 10 Sep 2026 19:19:02 -0500
X-Gm-Features: AcwNN1Xw_ZV3zJF9oPd7-FCfkmdUBDHBhWTNPa2DLIGGrFtpH901py50U9hSvEQ
Message-ID: <CANW_FuNBVteTL52+iEnM3pUerrVnRRLES2SbrDt1FUtLgPi3Jw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/tiny: allow a framebuffer larger than the
 panel on MIPI DBI drivers
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Alex Lanzano <lanzano.alex@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

On Thu, Sep 10, 2026 at 2:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> Since tx_buf was strictly allocated during drm_mipi_dbi_dev_init() to hol=
d
> exactly the panel size, copying based on this inflated width and height w=
ill
> overflow tx_buf on the heap.

Confirmed. On a fractional plane SRC_X/SRC_Y the damage iterator rounds
the merged rect out by up to a pixel per axis, so it can exceed the
panel and overflow the mode-sized tx_buf. v2 will clamp the rect back to
the panel in mipi_dbi_fb_dirty().
