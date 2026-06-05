Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749CDCD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E5D10E22E;
	Fri,  5 Jun 2026 08:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="EAz1k9t9";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3561210E22E
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:25:23 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5aa63628d26so1422538e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 01:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647921; cv=none;
 d=google.com; s=arc-20240605;
 b=MLQ2j+RLjqFW/URy1EkXGPgbayWZzFfyhYYrsBAifQ+zKzfbARoiipp5gDbK9f5IPa
 aHTEWOrkXNKQr+7cskSWu3N7Wb7V6tBhmMStOdeRhgOck2E+55Gc6SGofkvsszTzP94v
 Tcf0is2eZ0e0KK8t6fjjF7/Z2ICPk18FwrbOfyTq2DyQV1ZGIvWniI8gxTKcosSmxDgk
 XyIfvspOPn+FAYA5lIeAIcT/gRjLpKdaiPwMUjEha8ldsAh2eCBOOMrsUP6sf9y4a1ju
 IS5/YmjRi6fkCck31iExKJu/sD4fjJ3Dz9quzwUMqDPVDq1D8XLUZdmprHBY/M3hX9xx
 Ulrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YQQCaTW2PStNvlCTnfo6Kjyo9IOqxmkl6p5lx1f7doo=;
 fh=/OkzIyqc6oAJhbIYZhpm83KCzRE1C7s2abVQ5aG/IRk=;
 b=CKBQX/9Hmk6jLV2zh8IHnlgW851pTe2QAdnce6CEZbf4hgO1gNOAB0lLV/OKWxyv6P
 kuCkxaNdGYHz6JKR7TjD2saIP4F71fMMHvn9oC0ww90z9UBGncXLYtL5ppPXLf0ZYNEO
 iNNC3bEx1N/+fqNmPYSfSgX+6DmeUQLjNA1hKxREK6nhQ4J1v36P+QcVjT2fUbT/IOuH
 yRfCC+TaY98JTvgehwFpwG6GDlHV8peLK78fxK6AEhJrh7DmXb+sqGefA9V/TiHZn92O
 VmeV1pI1V5vAGBEWKZy0qDg/x/8Zhrb6E2jIe53c4wYpgIwwIUa2bHA3K98d0ixsvNpX
 qDXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780647921; x=1781252721; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQQCaTW2PStNvlCTnfo6Kjyo9IOqxmkl6p5lx1f7doo=;
 b=EAz1k9t9wm8PRcNrvMotR/dVVNKL7EksVelSl3SelFYImpfjReiiI4yxnssEk0KPO9
 UH4fyxJrZkQ62YCbQAmYHNCgTECSyxCAFRj3pK79xFVK7SIRuXGFq3vCDCw3jea3wDK+
 t5tyAXHG63GOw7uDZaSpWqZjO5mpZdIRHUVboc3ZTTIMMK4H2KRddV2HvbE/CZCzEW3U
 SCwSu1xPd5nlQb1c9/q6HWvvP9Ta1rwAFRvXMDr4eeES8rLSomRWkeQVG/ffFlpUPICt
 sstFghz/gQnC+KBWtFXDXKrBRUSJOI0k8OUbo4bYajm8u6jzkyYoN9pQHoIoHIi1xRXP
 DecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780647921; x=1781252721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YQQCaTW2PStNvlCTnfo6Kjyo9IOqxmkl6p5lx1f7doo=;
 b=hgAY+O40U9NHnxLFy64olSlancwaeIIYfAWflzYJyKMNN28PgxKzh1rKHFS7i4LXkQ
 s4uM2nMfUZ78mYM5m7pbLYyNxjpSfKxUVgccC3PYXEk85sktNHJI2OkR6ksolqOq2Cdr
 Q7Le59nqJRWNXgUP/RBhQr/MKVq3tUtFWNE1oEOErAVxl7Wl0IELcXCNMXnecIktCzdU
 E2bH8goorxNyjaaVmruAjDaWGLA7MoxSGYCl0sj4cev5TrcK+Oh1WOte9q4pMGYrWF00
 kPMs8ffMXz5pjivARtKWofaQ2q1iJPx1eGI080DtTwIIsESgCMrcgQQMxog6YEv+/Rya
 P41A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IYtUachJ9lxGsiQKXHDYxeVHsCZQNPYiHc8jAqqC/2zL6DLCd9TkOYq4EyUGNC9FJdPoYBf8UAsc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+fr9/Wmn8dPWH8Q1BmV0p+L18GGOZTY9HTJKC+GkUiraGHAot
 dwvFFRnfoJ4zsl8SY18GNRciKDQiGIDzSidoSjh54jpjq5KEvB2q9oU7ZDTE7o+CJjktyy+wEBI
 dvvCDssWOl9ZIIoo0BIw8b2I9MVreTUf2jpRa6D+Seg==
X-Gm-Gg: Acq92OF/mG9sX/h15xrwiN4VEx3B8Sp3ShRpbxBpXuSgSMci/82ujoFqwuJDBC5mo6g
 Ac/q88gTGsPcLqBJbyAacYKOLPE5fS4BD7fYMCocHUuuPKalH86hPgVCnc7FQMp3wbSXZ+E+aO8
 aR1xPO6Ndsve7bFtfy+S7IsKAxilVFiWewOa5NXlQT2vnHxy7qsoqbxtoBqfekvHwWTk+d+h2E8
 Dcu4evrcFRWw2M0YTG0jCdXhpiMcBfdqJgDpDCRmr35xc+DegR88Ilv5sCfgJhW+D9aEmoxTwca
 Zh0OBp3XhzsrEaDQPcWgRDjA3VzuBX8Gmtu+NTPf4VNu50XYNTM=
X-Received: by 2002:ac2:4e0e:0:b0:5a8:6cbc:60f3 with SMTP id
 2adb3069b0e04-5aa87c03398mr762219e87.34.1780647921360; Fri, 05 Jun 2026
 01:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260430091532.115846-1-marco.crivellari@suse.com>
 <CAAofZF5dMD1Y5+eswi0u6xmTHaMZEcGVTtXe7Ps4vFiCxJFKCw@mail.gmail.com>
 <e7b92047-fd40-44e1-ba3d-138d14122cbf@suse.de>
In-Reply-To: <e7b92047-fd40-44e1-ba3d-138d14122cbf@suse.de>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Jun 2026 10:25:10 +0200
X-Gm-Features: AVVi8CeSRmMVtPvm-tyAlXau4PXyxCfig4TGwwlPpxXRrC4SjqbWu-N2l4oVHHo
Message-ID: <CAAofZF5yZkOCP+FK2sn+_YGmOF8eL+gcUZYdq1p5QfghMO8Pmg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/gm12u320: Replace system_long_wq with
 system_dfl_long_wq
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Hans de Goede <hansg@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
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

On Fri, Jun 5, 2026 at 10:22=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 05.06.26 um 10:17 schrieb Marco Crivellari:
> > Hi,
> >
> > On Thu, Apr 30, 2026 at 11:15=E2=80=AFAM Marco Crivellari
> > <marco.crivellari@suse.com> wrote:
> >> [...]
> >>   drivers/gpu/drm/tiny/gm12u320.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> > Gentle ping.
>
> This patch as already been merged a bit ago.

Many thanks Thomas!
--=20

Marco Crivellari

SUSE Labs
