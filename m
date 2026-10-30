Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5535E606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=Fe8eTmG7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E901127E2;
	Fri, 30 Oct 2026 13:07:53 +0000 (UTC)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600211127E2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:07:48 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-188406bb948so708813c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793365667; cv=none;
 d=google.com; s=arc-20260327;
 b=NykXMdrSFjCjM3AqZ4HHOjVHY2h2ixaTlfnznxARlSOicLDF7CtKKxvOJE43M+m6dv
 C4FO0ehWpIfL3ox6dOPdEzxKNWWa2w3JfoJcgW6XlB1a3ap3dgcVQv2woIuCTs8TZ6rQ
 OMeHYdKMjrvR2C1f9ts6Kt09bf4VqUFG7VRsKHdPgrnCiUmKpHcZQTiORkTO0sMT8kbp
 9KR8ulfMcJ8fD+gtE2B8bmVANkLypaIRVkp91qy/8G40wYsZUuLSxmvmUkkUsv/jpxvx
 +n2tj2Bgog2TTL0p4zJvzQCc5clqcFXwcwEAqPcXD75Nk0NncDfLx8SCDx1HKFW6+z3W
 dG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JmQ9d1VaCaPK84ub762yzt3Mt8tgFQPf/KYdvYI3qug=;
 fh=LNOP+rN8qRz5K6L5MAXrBGU5mhdm/sM5sPq0SlP3/a4=;
 b=HUUgncsIX8atQzcbhjPUOshk5r/AqssqvBdTV0uDGZd1o1Ulx6fC23pj0RcwBG0bqo
 WR5SEJGK7VMBORLfx3G9Bneec/WrJRDus+X+nP8HA9m0oua68cYMIjJeUHX/5x2nmtnk
 RbfPAz5N/NR/bQfWthFLqHJLL509tJxNLB17sT5tIctlg3mT6yRd6JULrPh0Gfwo127u
 +aUGiJPnl6pEHwSdsPn2YrrP+hjYnC5qj3ve44C15IObbWGukvAq/4nu7QMaiP/r8wb0
 gWQfuKEEsR0UxVEGeFYftEulBsNhjcabX0I5OvZ1MibMSjFqLmaaKw0uwU2mRighhXh5
 CtZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793365667; x=1793970467;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JmQ9d1VaCaPK84ub762yzt3Mt8tgFQPf/KYdvYI3qug=;
 b=Fe8eTmG7kCieH33EgqEef4Haz3abmT921/6WmfQgnrWyeQPndW6098vYPApFWmt+dy
 Xh3RfpGiMl1PnxaBzOlxvpZawHnEXvTVgNI04oLaXC9vPJqZtsT3pxGA65odOPrtk/ic
 yyBy4HZgVKe3wFfpi3/oupsm2PyYKuVInyB3G7gKtfVWJnb8lQx5J/Re1RQbsJt3f21S
 mGyA8SS7duSAJjc4gVigLa/BSWZj4FgjZSx9/8/ts535h6x0soSgeIjOwu9N8vI2IaHY
 wCtgkgPV/XqcTnLdJPh/GNT1fIvoFwhTho1JypXDrBpIXQ0lQ8h38KiKt5E+TUq2W0Ri
 kYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793365667; x=1793970467;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JmQ9d1VaCaPK84ub762yzt3Mt8tgFQPf/KYdvYI3qug=;
 b=aJEDGVHZnObnOEec1Wzq1L2pZm52ITrQcR474wFxT2io97Uy1qt8BHoQlIQKREDo0I
 /oYZAc5EOnIwc/U9j6PCerjiOOwH2WIdhqHipuZuevRa2Vov4luquTObIY2eNYiZayV2
 uMz6NLK48BH7Rk1QiBI2qZtdDuwAcggx546OJcBbDRLG5Qk/CYpZY0UTInrZ7w/p8RXM
 kWzaaI1UNtZi4XO7EZFkwG63kZlVXbKLL6ihuq+NFekNIIGYuExWzJg7LvVdmUaEg2k5
 JPgSxYnPnyJbgUqRZxk+Bf+kU2hn/siZksqEo/pFDTuy2s3df3W0yq1vhNqqemnVsU4V
 vZBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7rB44N6FjIT8nbQW//XE7tO/ta0T3fKQSE2TS1GCwcuDJZj7UVeX3ch0Mjn0n7bQGAq6YaML6a1M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlDdpJM52SjHYXL5CvAIzcRahNC8PXHfayDyJ4S6iapkCL4vjp
 15Y2x1co6A8RIhUufBKKfHZhA/qCs8fUYQaAf0gNWdpFVZpn6z3eZnqRGdZXQjcqy91cWdh1Vbo
 rK44qPLMAOD3NK4mz3D5hheT/f1wz4Mbjz0M/uNIb9A==
X-Gm-Gg: AYBFou1XAXWvNmuw6PKB6+SctAnis+dDJ4RoSKAXZCtg1l64i93S7zyD+z6lsEaCLFd
 /Ksft+gQlUibY8MwqAvmnX+ZR7FsOkXhIhE+DxIqg7anYYqzgcbJPmhVf/g4mzsGXaAuWxHp3HF
 ncwTKa0TQM6z/7jv7EfCGHdJgpfIwPgK20dzwP7bi4fkdTGJ2gxK7Fm83P7RT7d4GZU3ltc6YmO
 ydGnyQx4k98SFp+oTXDf7oZkuksGOdw7vzhsPnLovdCLt8ivnmz9tgINpumYFVJsyNVtV9qBRA0
 lqmC9iJjyNxFdZXOZD4SB9MTdRzXKac0EBkGCzsMi3wjTU9bYLEivDq+Ck4850WIB2CiEI3jtNq
 dmoz8W/6tlOMuuQtij9NTn9rb5FlsW0ijOh0qmvvJMmK3YDRB2Htk+Te31w==
X-Received: by 2002:a05:701b:4248:20b0:191:3c:aae7 with SMTP id
 a92af1059eb24-1ac5c64cb0emr3294959c88.26.1793365667567; Fri, 30 Oct 2026
 06:07:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <4b9b0f01c86a84b4666a1ba38a085c7b84e9a585.1793364084.git.wy@wyuan.org>
In-Reply-To: <4b9b0f01c86a84b4666a1ba38a085c7b84e9a585.1793364084.git.wy@wyuan.org>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 30 Oct 2026 13:07:35 +0000
X-Gm-Features: AclHuK-1ALJd-b5WzPc3TmnRn1z3_PjdkYlh7mZ6HcDVDQubZ-bE1wfpniBQrCk
Message-ID: <CAPj87rPiFR7idU9ta44sa9LSXNX8FrG_uLaRa2b8gp=Rp5kJsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/connector: Fix HDMI VRR capability member
 documentation
To: Weijie Yuan <kernel@wyuan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Tomasz Pakula <tomasz.pakula.oficjalny@gmail.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, 30 Oct 2026 at 12:48, Weijie Yuan <kernel@wyuan.org> wrote:
> The HDMI VRR capability comments name mcnmvrr and mcinema_vrr, but
> the members are named cnmvrr and cinema_vrr. This causes kernel-doc
> to report both missing and excess member descriptions.
>
> Match the comment names to the existing members.

Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
