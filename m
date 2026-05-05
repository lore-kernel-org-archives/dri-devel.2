Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E47FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 11:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8422C10E135;
	Tue,  5 May 2026 11:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ozJw+W1Z";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1B010E135
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 11:23:07 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso806975266b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 04:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777980185; cv=none;
 d=google.com; s=arc-20240605;
 b=HxkKV5NLOL7B/Yjb0673AAUzIYMneTiKyG3ay3GEBkrOyRnZkbYzyfzb5PfICCTFxf
 1jftA61U1ZWKrq9M6FsokCDbQtUsZa8ySgS6BQmMfjAEYoUUCHapTj+Q3uB+gzlSOQzn
 J8qVLveBOfUEO7zOlzmSovDMAS1n0Dy20r16E7/AIcZN+8ddy/LHZdgETKHbyxyDusmx
 dymFRKosLbUclvMWcfKViX0gcDIxJaKWf/EAQyn7qCmhOmC4EE6YMsuIIrATSuim115W
 c4/WCzTYNB0ozwlwzsn/9DvXjvva6BkFVGui6GWPImT1zqXWz0qidZx1Tmyn4RH8WTPF
 alKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=axlZf04eFZVnPGKiWOTNXf6FhugAQGt8Ph+b3ZFJZEI=;
 fh=HbSYMojxRAA4cizux55qizZ3Th2+wLwJaZ9ZPWCdaII=;
 b=Dg5mjt9fsB4WjPNJKTbIoUMHaXR/qpnVDzTHflsUaZWJDXu7t4J7olJ3QWeIjGwlQD
 hNzl5OG72LDBD3uyeJFBmUFTDGGhCvPfxlnqPJtF5b4RCjG7FLNZF1vU8nyZZG6V6FQu
 Hmb2u0ol9uhRGf87gLxHUiAf9dybiDbIkHc6y5dcbpuz02KDnrqDI1NVvfWQVZKoEy//
 S1OibbXoD0xW/v1IeXUI7wpqb3NXeweXGW3/hnDXz1gwA3mcyRRfxM6jZjtQ8FWyz5kj
 4FHv7Z1btYvSigux3KixShY5GgUnx4GecI3wixWFA8nAauJAL5kxulSI9fm2ZQIXV2iZ
 Vgkg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777980185; x=1778584985; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=axlZf04eFZVnPGKiWOTNXf6FhugAQGt8Ph+b3ZFJZEI=;
 b=ozJw+W1Z23mXa6YBIy81ZPRRGqi4J2sKZtdoOw+aAcqVvUuRXbgqrKdTib7gNCC8oZ
 e1LVlzw2DxN1AWnLwhbq+T9YoFXC9HEXljmJwb5hRcIykNSI0TWt8EommEFi9/AOQ6gH
 K4vmA35qfN/mqLD+k1i5lbPKsfo8TaiiHr2C7KAbi/Q9EALyWvCptb5SlhUcWaMUizav
 ysk88W/MfjQ9enQduHR6J22eb8NHjorSLlfvwBPVjCZk7pacjRhUIWUxXTvPmLD8D5eM
 QlDgvwzmNj9SvkQiN8kEvoH5PYnr9n/ttjfZoU+dytZ7RTZ1iB0NsgCZJYIBKIsc0v6w
 mzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777980185; x=1778584985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axlZf04eFZVnPGKiWOTNXf6FhugAQGt8Ph+b3ZFJZEI=;
 b=eKXqQBoSffokhrN0rHGDqSGICY1A8N1Mf4GQEFLtu14MJzlqHGP+aJbFLXaS6xND/K
 xhgL5ygLpHXJ37L1dHN+fYKuukj4KrSfQtDQbrYgZWPAbVowrRs7yVc91ZfYSuon58wL
 cYoXtDzykJnAJr9wHVZNAvG4vcD7tb8hj3GlS6u3RM8wTb73M5cRjCq2Fa0FqDzTGbf2
 DkBjf1TmO45UnmTFx25O3vfOMlSk4kGLankib6TQluR+vEVYx90M/wMGv32mXQlughTt
 zuHlLTirJIsA7atPiXDVxNju3YF2gMUuRhlhH5ZYEMPmZFBMAy0dUd1QY1zU0yq1POra
 qSRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HOMqCqabcat323SpCcbXMDjIqhmeu5jBQzwYkaD6QBI4StzhSfU2igIk1BdRgwTgIyDizA3C3Puo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9YghBs8MvoNCeOytGQiN++BeA3AleSBiMJ2ijIKCJkBEjs/Mn
 jiSEWN5KoNTYYXLp1OXkphCF4hMZuQKK3mDixxgXyFg51XLxBgjeRsV6U5QBA2d00Vtm2PPHMdM
 s0ysGYMm2RV5/LBoONQ2Lpw4FBX+y1Uw=
X-Gm-Gg: AeBDieuWrcwNOZ+YcP9wMMEjW+15jFcbr0gQKM4RdNhkCeTzWtZ05Q65kF+PZvDVmfV
 EbbVanstD8iBgysJA5IrNQgZ5Vj8oE1uf2C+uXFftsqrWc08hKSLP+0VnV2jZsWNmFr+CHoYmuS
 aIGQamq9l+cgqsrFlNcxAj0sFjHTxYAmGbwemo/T/BoOP42JJskfngFSsX01zT2hZsDrS6JtsMc
 k90dRwbNtlH0sRygjYAaDqyofeYpYr97ZH7WCfnBJZZf2i77D9OCxYRw2Ktm/cqRS7uGDoM4gkc
 NDDOpRkQGIZaFzIE
X-Received: by 2002:a17:907:7ba4:b0:bc1:36dd:c6cb with SMTP id
 a640c23a62f3a-bc41111d10dmr135147766b.20.1777980185375; Tue, 05 May 2026
 04:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260420010118.17960-1-dbgh9129@gmail.com>
 <CACrCO_VZg_2PXG011qQ7NWo3iz-u2HE6DdHZWQdQ_UnRk4A0Eg@mail.gmail.com>
 <2bf485cd-0c6d-4f0e-99d6-7b592b949a1f@gmx.de>
In-Reply-To: <2bf485cd-0c6d-4f0e-99d6-7b592b949a1f@gmx.de>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Tue, 5 May 2026 07:22:54 -0400
X-Gm-Features: AVHnY4KGIseGzQJ6YPebo9l-gxUHaibdM3sX7SGH34uGZHlvXl6i7jaTP7IScU8
Message-ID: <CACrCO_UFOLqwmSvZzQ6pOxihTEngCOMshws0UTCee5DSt4BvuA@mail.gmail.com>
Subject: Re: [PATCH v1] fbdev/offb: fix PCI device reference leak on probe
 failure
To: Helge Deller <deller@gmx.de>
Cc: Jason@zx2c4.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mhun512@gmail.com, ae878000@gmail.com, tmk5904@psu.edu
Content-Type: text/plain; charset="UTF-8"
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

Dear Helge,

Thanks for letting me know that the patches were merged.

Best regards,
Yuho Choi

On Tue, 5 May 2026 at 06:10, Helge Deller <deller@gmx.de> wrote:
>
> On 5/5/26 03:39, dbgh9129@gmail.com wrote:
> > I am sending a gentle ping on this patch. Please let me know if you
> > have any feedback or if any changes are required.
>
> Both of your patches (offb and savagefb) were merged upstream 13 days ago:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/log/?h=fbdev-7.1-2
>
> Usually I send "patch applied" messages, but in this case I probably forgot.
>
> Helge
