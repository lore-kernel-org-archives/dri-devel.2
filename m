Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54522606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVk6cjJa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B882E10F128;
	Mon, 23 Nov 2026 18:19:32 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CFD710F120
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 18:19:27 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2efe591a1f6so12066845ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457967; cv=none;
 d=google.com; s=arc-20260327;
 b=gjLCrJeLywj1xHLvUAbr2qIhsNTrFdzAPcfQjSdT+5FyruRdFzqjnsDO4iZgpRMDbF
 yRGtro2EhCB2rNBl6lJCaA2JVTd2jutOpLtksdAFWBE2w06MqQeS/5NC6Xyfcax783+0
 nCSYEAinnFQ0X2IymeFWQWHxTS8LH7rRowwwWoLOwXQLfvScyk3GxtEWOMk2BNzymg1S
 PAdOrgKtYlTTVG/P0Z1+Hx4PnvnCfVeDAmMQ5e+kvixPBlrTxuvTjwUZPTo8/C6S5Trh
 EK+wF/SyJIW3NlL9EXzaaXbT4ykMdWNgHogQTML3TaDZvErejPp9i/R5yulh3rvSylvk
 VyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w/35+OKTYeKSrDPcP1f5IU7EdP2ctykP8aw1CQHX1hQ=;
 fh=SuiltkwtxYE7Na9ace6CsKk/YKXYDVV3zbS1EHenti0=;
 b=ijLiDM0+JZ97jLDIhYEsGfJ647Zy8Vt8LyWsqwEZiUj+86fapTOuGHXSzaxe2HFd5s
 U+aQ8UPy1lJEtGSX5ZnRZer5HIcGROzELUjqVri2Za//gmffJsfbLT2walX2KENFdA3r
 dPWUJ48Qej6SbEreHPJZmv6x+SUVtPp+IXbiKWcmZiF6M9+JuBK9S64eLvOjbOf0v0F+
 KD9xnyVxn/yDPQO8A0mj9xUcTqfXFde13EM4Jsslkwqa6slkSaD9j7FtqfQ2/hjEkwLq
 4vlD+DWRtXC/jMjz/GmFH5iDYzYqzXePdelGCr9mQDGmbcyLSai98x8zgZy9YOWPEZ6r
 8tTw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795457967; x=1796062767; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w/35+OKTYeKSrDPcP1f5IU7EdP2ctykP8aw1CQHX1hQ=;
 b=gVk6cjJaMdMYUqL5it7nzWPl/QJe5ZyA36XafeVNfbVRxF0OWepAQSzWXhiQaTAh/Z
 eCsmdTym0U/S6f1+CUKA1y+7KiIcsGKqqC/AJXwG3Eojztnru3qhlcehreGdKUXo15ry
 aHDbryJucBWHXlyDJCXpaEx2c75FTUOW9qnlcriwq8MevjSudZHqvD0xIp6m4JPLjHLv
 03m7GH1rq9IXM6OmlotUkq06UzvuC66rP0AHDtqblMNLZaoZBurAA51VgKH7Ua1IPCno
 oscy/j8aZ0F2KgxnGAmBxYsRjSAEBKaZmxDxxxgm4fGP61CZSPtLg2r/OXnvI/c+AvIk
 hWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795457967; x=1796062767;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w/35+OKTYeKSrDPcP1f5IU7EdP2ctykP8aw1CQHX1hQ=;
 b=VWaGLhsh9Ch2Ae83E7ooQ4qqLvZlhwfNkfKxVYAX2U5fNhHf+Kap0X8Sw3CjJsnds2
 +LE+zM2rz2jVN1DOa2ANi9BlpzmAKGQ72OSuqbtEU5IgaiPP9p5k9+bfvmtstKbbv1uF
 U+60kl2CSPNlQbu67Iw5bM/BvM4pNjcVU0Dk/unE3UdhmMNmUsmjBVF1n5Vo15O33+MF
 EFaUIU4Ud5Nq8j9X1Gl4dZrMZsxMTDV7fb12w0tZGmycLyjTQ+bx7pNqp+1znkHVCn7D
 c0QDp51QBeoxoBbu0lew9UhxnFuo15U/qz7wZih4AbKwQ6zgjX2QbEsIoM3g+SnGrcAi
 Tj8g==
X-Gm-Message-State: APuU4Z+IDj9vRW6qqqvquRSOdwja6wNpZvUJRht7B2qw9bqBNAkIXrCS
 lcjYYnaynNnG5E8eQfGQYKLG4GvR6aLn0RJAzElvfTnNwcBVrrsum84/xwEOk3DX7Hv29V7oL2w
 QCSa7nVhbdmYV7TpsHuSsbw8KUUvCAbs=
X-Gm-Gg: AZFdTZcS5aHSCaddl7TsG3YWG0aQt2tXhvIpBXQ8Y86p5LqZ8+cL5NId9F1u8tnkT5c
 7e1lOOzJ2a3+m6FAOniKqgoE/ac5RVBz9AAH5H7yhLjXCvB9KpG6+GOJaC8IF+jcWX8sE2kS1We
 zryJj9jePLvjy0VtqAUZfzLOQ3bjk6kwuNN3WpOdzuST51g66XY09RYs3icSTWBOXIkhI3mAGZF
 356c+pfqMUhxar5aQV0kTkEeY7h3s4BqaO7Jkwdvi+XDsypH2u89zm+XnhEWlamQBhnQ5QVoDye
 DraqNqbrTML3ygSsVtSKY4e6nFCbXgMvcz7h3lv5NoGtev71Nh0VV6PttXmJ024nMy9wFTY7KW7
 joDvNEXCgqMGxwW04fqAfvqxFAqrqWbCYN6nC0w==
X-Received: by 2002:a17:902:ec8b:b0:2e8:6ae2:75db with SMTP id
 d9443c01a7336-2f03f18a9c9mr111167675ad.41.1795457966645; Mon, 23 Nov 2026
 10:19:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118-orangepi-gpu-v2-1-f68676f844eb@gmail.com>
 <sashiko-outbox-221816@kernel.org>
In-Reply-To: <sashiko-outbox-221816@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 23 Nov 2026 19:19:00 +0100
X-Gm-Features: Aa3M54oPNh2HItK5OWAdt9J3mY6fBO_MvaXSMAuL_-aTSXsvBo00wfnHc9xmRpc
Message-ID: <CABdCQ=Pu=_M7wbP8SWA3ux4ztpnJoR3PzCn3bFg6ao7dxqXpUA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dts: spacemit: k1: add PowerVR GPU device node
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 robh@kernel.org, conor+dt@kernel.org
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> [Severity: High]
> Does this break the DTB build when CONFIG_ARCH_SPACEMIT is enabled?
> Neither include/dt-bindings/power/spacemit,k1-power.h nor K1_PMDOMAIN_GPU
> is present in the tree yet, so preprocessing any SpacemiT K1 board DTS
> that includes k1.dtsi fails until the prerequisite power-domain series is
> applied.

This is expected when testing the patch in isolation: both
include/dt-bindings/power/spacemit,k1-power.h and K1_PMDOMAIN_GPU are
introduced by Yixun Lan's prerequisite K1 power-domain series [1] (noted
in the patch cover notes).

This DTS patch is meant to be applied after that series lands.

[1] https://lore.kernel.org/linux-riscv/20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org/
