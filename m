Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C8FC44529
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 18:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 109BC10E012;
	Mon, 20 Jul 2026 18:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b6U3UURR";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C4510E012
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 18:18:49 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c15b33f7b23so1533655066b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571528; cv=none;
 d=google.com; s=arc-20260327;
 b=rSXyDjS3bQtTTP7JkhUeuNrZrajRJrjFGRKB7AOuDpu0KFaLNipofmmmawvFi4/C5i
 oP0HX3Dkp0wB0g2Y9vo5MELlzcDwscWxhVe9rfFQuSBqBYSMQ2W3rZuGPSDfsNLSREKR
 +lAr0C42H4h2oLBmRpOgvJ6nPa9trgpnWwWFC8pjingy2bvZ1xnbIiVnVlzpZ+Sn3Vts
 aZDfNxer/FDihlzH1it1SW83ULnnajiIGyO6eUYhM6LMf+FNqlDCfIbWqkZ8/tcIsPml
 fskUYqMgM5xlnSJFJ2p0TFdN0QyEzTIQ2iJu4N6CbuRzMSVTkJ9Hbb8z3rW9FuuAO+Nk
 kXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m/fEhPlmCHnFc5IcQj7KnWeRuvZDxbUo1KvQrDQOiYs=;
 fh=H/S2rJ0hZz+DlfRoPGrvHIzVALrBRFcduMGMXQSb9lk=;
 b=gWxDg4R3V7ZgPDGfDIEkDfcX5n1IxPvgV9/P/QbzJi4XrIyEJiW4ybxyKSD/9XgMo8
 jNW1TnIdYvgEhrDjeQO0lE5ED36VtcWBvX3Uc9bqZtovwvMImfGzuqDPmv2Lcq9dsZSu
 y/fqRjBMPiBkWHk4TU76e6edGfVBa7Kp68FwsBd7d17I75qNRewVt1RdTzfs/A6BcOcY
 GSf4UXZ/NKk4UcvssR+QNtb+t7SRa/Z4JKB3IT1orp9wJp/7hI8MMN92KlKrXsfLk7yF
 cd8bpOIxy9aYbmUbNDS+/BxmcOthjaHQr7PcX8CsYt2KEyuw5mjv9ODbEvc1nk/HP4Gk
 CSEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784571528; x=1785176328; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m/fEhPlmCHnFc5IcQj7KnWeRuvZDxbUo1KvQrDQOiYs=;
 b=b6U3UURR5E7buE1MjNzP4MPu1/6lsONq979TM+aLdqXlRNDRprbyVMnKeYfvThBq/f
 RFJ3s3/jZ2S4j0enNE1/uXO5WKXiOw9fF77epq00CfZSp57n7tq/JlcwGnP54DGJ/6zb
 2rDy0HFJhM9BPoFUNOu7ge9OhSNwdbmdlz47QRUgEIue1xx9pkUkIJa5wTtREsSs4oIj
 vcBge4nhoTD+EZr4cRunkbDgSAZULMoKj3ryZPF+b5IHzV5svNgYM6o7cT/4vSeTaNgE
 E/w+NjDXhF/5kWjE4oB28Qh4LLbDFPKrJ1/KpJ7bJ9MWdmHr3ANqbgrpW+Dei0St2gAZ
 AMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571528; x=1785176328;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m/fEhPlmCHnFc5IcQj7KnWeRuvZDxbUo1KvQrDQOiYs=;
 b=k1kK/phLymKiBkwu45YYO/8SfojnhEPPNZuo9aZWH71oqT314G+GVgoMzQJqcFTX83
 bVC98D9WSeMcJDqikhGISH6Q77/wuhFDM0JuBLUhMWUFG59uNQntlsuHzGkJxuN8gUI3
 gm03TDZ5MMcXO4ztftgJQgbdGrw0myeA3lDKuoBWTg4J9psDWPRdKBpJqZEgljmUQtWa
 fZViuWWoHyuTl+GiLaQPnqaaRTtcogMfRi7deuMou91azyzayss84yZmTV4YuLg5ykF2
 Jh/KRYmvFazdbSDh6T2geOn6gTPpWlfVcRm0DzJz6KjiNwWUhzBD7NyPOQEmBShnr4wr
 EQXw==
X-Forwarded-Encrypted: i=1;
 AHgh+RplGFf4ilI48q/a3r+YTMezttYA4GgaWYhLOHycDetrHLra9GU7P975bgjjQgJjerQmGnvCTlJpjYw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweNe8x5lI5v22GD2ZLUH/KmaYjNzG4y0QovPL55z/7+QlUfQFC
 p2uyFPQdlZZQ0YYtM4Cr6oZrlTlaxntA3JZGYAAfeiJtG3w1597vTRoaYqyKFlMFo9qzJi+fC/P
 Mp+YX7Apzkr0QFO3gAkHbCCcU9KvYFW4=
X-Gm-Gg: AfdE7cn4HtBrhie2S6paa+H4aZL7SHI3YRcjqEe0pxRdmaP58zjNiDTGjYJUs3X2RHB
 8MKbT5RWI33TesCPWSx9srzv8xfqgYcui1jfZKhqdHAuvpoyd6WmZfPLhj30D7Vqaw9xcgENKaG
 +yFiBIj0qBfEXpawq9yJ0+s6EGUFgMHrAi+0fpKm/dGwN9+mDNeijHqx0VyMSqmKnIWOLfYW6Xt
 U4qviiY8QrKJB+iGZN/aB3YyECX82JlPyd8XyrYivhhARIxneTlBYSiyqivGQTyld41GxRDL/BQ
 MQhj+ioO9/eDh+B5qLuYiJxWX5JTnw/m2zGDx1yVX3j+yuUOBWJOSoPxh+JiPO817eh1KQsOhfB
 axDp3PxVoMJ+8YZT02tZSg3tTslIDZ6aY+LvZ+/uc17bgCuI=
X-Received: by 2002:a17:907:e90:b0:c16:209f:d48e with SMTP id
 a640c23a62f3a-c16b477c680mr647988866b.30.1784571527740; Mon, 20 Jul 2026
 11:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260720134324.239391-1-panchuang@vivo.com>
 <20260720134324.239391-3-panchuang@vivo.com>
In-Reply-To: <20260720134324.239391-3-panchuang@vivo.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Jul 2026 21:18:11 +0300
X-Gm-Features: AUfX_mwTy2WT6DYuON66_1rgaXEdx6DQ_MN_MwvGATimw2bJv2PLyRfTTwQNNyM
Message-ID: <CAHp75Vfu7tuGsH0MS12dwSn0uAWJsfuJtTWzG=TztU08i6oQfg@mail.gmail.com>
Subject: Re: [PATCH 2/7] staging: fbtft: Remove redundant dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "open list:FBTFT Framebuffer drivers" <dri-devel@lists.freedesktop.org>, 
 "open list:FBTFT Framebuffer drivers" <linux-fbdev@vger.kernel.org>, 
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
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

On Mon, Jul 20, 2026 at 4:44=E2=80=AFPM Pan Chuang <panchuang@vivo.com> wro=
te:
>
> Since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"=
),
> devm_request_irq() automatically logs detailed error messages on
> failure. Remove the now-redundant driver-specific dev_err_probe() calls.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
