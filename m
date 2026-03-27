Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9421910BA43A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B3A10ECE3;
	Fri, 27 Mar 2026 08:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bb0ARMvC";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3445710ECE3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:18:24 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-60327793ec9so591910137.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 01:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774599503; cv=none;
 d=google.com; s=arc-20240605;
 b=c8+WLAlbM0s0EziTkqIc1Mw7ccG4qpO6/LvzJcKwhQ7NYITggpdHg8NZcE0Ly7O9ma
 bWO2LE1EpZPQl+ZrO2n7ox8L5M2s1tKrwR7pX/rBSiXw/AryryL3jvIdJ9qJ9KTs/tf3
 MSXvsa7+dsf4q2i8PJ8VZ+nh2IaUN2XZqb7EgYpE3DoPZH0IOP6hFCLlSq2gEz33kAJ3
 iptkC/zGVfMcVbNSxHLvtr5CDL+RA5MQdraflhSyxcpGMek99UNwz58zZJFEQpouMvsM
 TxW+PtSUVJFxBSOkQnMDQyJHsl1vePBOtpzGL7lI/0FgBr4ul3J2YtxBfGMY+pVW3cSh
 6gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QuPpLbdHrgi5gR7bQ+OPvpgg5A9XMEpoCpqb7gTJN8I=;
 fh=rIaIo6PkrT/bE5s9jmU/RepW2meUAUkTEw4IjV1BEgk=;
 b=ZK7uDSHnBlSxZnVOuR4Qh57+75pZ98Nw8WEiWYpVFjk9CD1KTEIcCMDhv/NiUNjfe1
 25S3h2l80tH8KbkPkFvrW5ID3cT05JLJIWQtinFYm8k1QL6PmH3ASA8Jq4iX7fshwAqH
 tosi/U1ex/3AIjvM8o06C0RwyUnoaeTtyj2fROeUFI7AB8Dd4WnMecekDH2NASkdXvLM
 8r2S/3/6wcyoqX/tOITauKhf5x1kjkyom2/8H4d52/wv1qeiJzuDFdI3b9OBK3EbPvKD
 RdNteFoUtk8nYnRKrPATc5UTqK/davoW0gXSgIBfmDjl8pxUhFLG4qzVIlWbYMrzld6h
 oABQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774599503; x=1775204303; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuPpLbdHrgi5gR7bQ+OPvpgg5A9XMEpoCpqb7gTJN8I=;
 b=bb0ARMvCUpfCvIiU6CWjquxA2uvVHh3oLIaDDOXU2ubDm7G80BgMfnyVC87EOspHvJ
 Dbk/z4gJLj8rn4s9wplNV1ASN1xDeVgcVb3SrSBqfhRjZgktpPLuxGdhxps4HiFYfzbz
 Tp1l3JUxrkKUE5x6k7WFXI3ZKIRl/QVyMNYAqnGi6OM+Ww0VjlQi9tq24Sf8ZIz9Q8Z+
 FAgxylNuehHf/TVRl9BsFLRIOuHDWjgviD0mAAdHMAZGnGsTfpr9EClIA7lDlfEYwF36
 dcOpbYFGon46QM9hD9MhGqakkFC+3JFsGmV9snDdXc2e0P3CM/ohpYvce3XfQioWHtkF
 nD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774599503; x=1775204303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QuPpLbdHrgi5gR7bQ+OPvpgg5A9XMEpoCpqb7gTJN8I=;
 b=H2R/3nBGci0cXw+rtt08CEDSATDH0/i8WPVhejd13vgQoRj6jpvMMt4hN4R754F12w
 D6ia899sGIsfQUAmlROejid3bFlo602VVooKiL/8TksPujrJY2xxvTpH8Y7DZW4upAtw
 1fRPQYWaJrGHvrA15gJ2OsamiWReBMUPPR8vY59qf7jsMkScLTQ6mN6eHJ6qqveDK5EF
 hGMZNZplyY1bnwoIi9+X2kSeL6m5X9KQwrENlR1p6b3L6l3MJex5CukDgR4FkZ1kO7GO
 xYPp+bD9ibUcgiuqDVe7O2aepDqN7YHhhwNnseCfCcVL43EkN1pH0U5B39hFK2nGuSTQ
 6hYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+E1hbahTqUa6hNqJpEydVTwwVvgs9IfyUB4Ypyy8L/BACreYZ24cc8AUU/KhhUoDRS+nMSbS7dc8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8+QRYF+HYYlvKTMblNxfnk0h7lQyD+WB//tUb1PMzl4RRSqc2
 VFj77zgmWc6HJjz3OjtGwnToFuds1XIWeGI5w22P62xSyN5bbzO4TdR/2QwEMCKx0+gvejkxY+y
 QXgdyNPSnJ2g7zxAOFq1l4pDvVWV9Ftw=
X-Gm-Gg: ATEYQzy+O+frYyTLMfRE1s1nU6PWj9CvrCm8wMzEGtfRUun3TrS2ee0eqFq5j+nrSTu
 I36/JsENaFP7ir0Z7AXZAicu2JMSty2hCN+xFpZNles/m/69sKvvNBySXjtnw7k8+v5vQJSF5DL
 5zM/XvBbwGY0b5drRjrzMHPuFpNukXDsEyvCbjIghPdR5KKI3BIQqe9M/gX+u5u4GJcoKY47nLR
 EEQxGjimEAm8pAUbI/Rg6kFJgiq9Ek9D/VY3evxIOXoduM7MQ4aaDcGYA1XxqdzPol+nwc7Q/gX
 c+FM
X-Received: by 2002:a05:6102:1588:b0:602:aac7:b8bc with SMTP id
 ada2fe7eead31-604f92ff779mr611452137.30.1774599502859; Fri, 27 Mar 2026
 01:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260327021728.647182-1-nichen@iscas.ac.cn>
In-Reply-To: <20260327021728.647182-1-nichen@iscas.ac.cn>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Fri, 27 Mar 2026 16:17:52 +0800
X-Gm-Features: AQROBzAr61Da5h07D6ItHHc-QSJGbO-be55ryw14cCDr8d4zOwDCJT_TB421exk
Message-ID: <CAH2e8h6gN7Q+1D6eTe0UQis8wi=C+FTRTvLRnWSxE3Pth2Gt0g@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83121a: Fix incorrect error check for
 devm_drm_panel_alloc()
To: Chen Ni <nichen@iscas.ac.cn>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org
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

On Fri, Mar 27, 2026 at 10:18=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Check devm_drm_panel_alloc() return value for ERR_PTR instead of NULL.
> devm_drm_panel_alloc() returns an ERR_PTR on failure, never NULL. Using
> a NULL check skips the error path and may cause a NULL pointer
> dereference.
>
> Fixes: a7c61963b727 ("drm/panel: Add Himax HX83121A panel driver")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>

--
Best wishes,
Pengyu
