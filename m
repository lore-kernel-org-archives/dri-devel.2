Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDF6C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E17010F774;
	Mon, 14 Sep 2026 23:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="t2gv6bw8";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F3910F771
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 23:24:37 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccf3bc34cso8515e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789428276; cv=none;
 d=google.com; s=arc-20260327;
 b=hh1ieeV8XmYeNbsspV5mjbmbF0VhHnsL7ObZEXuRCimE4tsKarhkSrsXBSSAHtmqE/
 lLVfWc/fByzQx3sdK2qREf3npTn09EVmfZV6KE4Wid5Yu1Wx0aB30KkVZBRgpZT5xMt3
 h7a3ayBjBLH5As+44y5WY8+FJA1nVor6izqnF5EFC7T48tgNRdEJW20G/JOele3SEc/H
 2AfzEqDN4eTMzLGeU8oLcHKDQWzeY1YwsiSd23sh1SHM3e28DFC/ULfPl7W6SrzHwaT0
 Ga+Hx3KzkioJrhNTQKm76LnbwckTOSeSNKdXHdJxpDY9nOV9+nwu3GHE51EANnzFLZog
 vEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7p4q/8XpWdajN+6pM5dO5w0pWVy5g2TnVfIncKpHzXw=;
 fh=SJjmbn2LpPw3keKuA3ii2nd5MQ14NsAVfF9iQu8kldE=;
 b=FnzTdOUsYsL4ODXY4TA2TrtL3yWyhIdje8KjLEpp+mqaMOidUEMkjez7/9tvoyNMR9
 8Sv7sCmiQ746AT66t9LbtohvQjf0RJj7pW57TA8zFXQ03QFO4QxwZVo2Px49WU5yka0j
 MItXWVlc2bC8wuh+g+cFGTmR1cChxlSGK++IX4ZO3UAHRcs0phHerZA0FLhbjuWtt9AQ
 WQTvbMhjHbfSFsinYb4hfyif77jYILMhwvWcNYPMYoyucfaoIpzC6c61aqTpIWYTo9de
 6uNjI3TBoQgb6HvQVCX3QfA1WugEGNy3vNslR198jvSr/0AYq1WONvamRG3gJ+ZAXkUG
 EOnw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789428276; x=1790033076;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7p4q/8XpWdajN+6pM5dO5w0pWVy5g2TnVfIncKpHzXw=;
 b=t2gv6bw8eUHe9+0TTpypkZnLLeXug+aQzJ9oKBde090KGfm7Uu7/R2hl+FaDjz29ua
 8Xn9t4AsietPnwuHDC1T6X6kudDzuras0c6cMl0BHEP0sfD0TDngKtzLSSiaNdfXfgtO
 vralkadyqil2zKa2HyvxyhWsv8/v2UGyB5aA0bil0Ips9O999sC3FosZ9yH7gXyHydIq
 BtOt+7FW5vSoCBzaFYKS1y8yxun6jFXPG3ebKWYvWAMt42jXYDd3MtE1MpsicTTKwmqD
 10NhIicZMcnFs1yqUlGHiBT08n7nMSn17XKGBYxUksEc+AqFmxpBaLuSBBiAq4flBoiq
 ggIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789428276; x=1790033076;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7p4q/8XpWdajN+6pM5dO5w0pWVy5g2TnVfIncKpHzXw=;
 b=2vHnw7qm7f13jvERPI+BmvXpTYVsZasARv+qhyAHcznQcK1T7dKX7wZ/6i7lr/yFzT
 UlgHaLTbBwDa60A5GBNmgCguitx5v6tVDe+9tZH3J573mQsZUcu1wdo3jS2xJydgWXWY
 H7mHmLMUYjIonHsu/hfcbY1Uky2ZdXa6aknLGxGTct7QhXR0cO+izoLH+S430FTyKHCX
 zk/aa7TLC5vU2jmqW5d2iIyiJtQhxlB8VjfMxcjfwU8LLT7mG46Vvb3/HYXMKxCjAADv
 CSFXDgbpMppfLoJbqs77T4EWZ7mjw2WOEq1z9aPnba0sMFsFSGk9NQ8ISg09YeuzR+tk
 0QEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0MXojYqLb39eFJlMu3WJ8MJQNmJoA/NF69GVbOKp4uYgvY7Ac1ifMp+kj06aq7uY+cWZfbumJ/NU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lEslPI/n40sy+zIomXWxGh4A3xIpz3Dy/QyH/UUyt61Y2SitdS
 aVAGMqn+r7qOG+vvUI344Q7lFs4g+gDlADgZ7/wvalF5S+5Fd5ICX6fs4Y09qmLqBQDxyIURtoD
 N45XXj6BCJJoTv5gx0NB5nEBYK0U/NHnZGeRttYOS
X-Gm-Gg: AYBFou26yhaSpAFHMAAWsNMfy6So9l3b3nouDptK2xIRXS4BoHWqn4JgjMM31SZ6LgW
 Up9+pmI1x/em6O946r1Bu9oKKdnbRJ/jtqRQMgjJdReajFNW/Y1O8s6GwYLeiEfgXFdGfPu48sT
 VOQB+4hORBpTDwoLQBsLT+vEcu2j52SIldalbAHFEqFM0laExuETdQz9OoQaW1TwBzA0/68eVYH
 a2/FtlDD+X9M1IXP+rweg0eBF0JR0wiwR9+/N/Fsng4WMbWHKrJuCcSTTNTPgeprMm46RWAIL0/
 /8eZuZ1sLAyx88TaLbRNxRxn+iE1vz4egURE4diQxrMBRP7NWvwh3OxNxEy9O/mP8tWI+gOxtHN
 QIjILlJCLbQ==
X-Received: by 2002:a05:600c:4252:b0:499:c3da:6f40 with SMTP id
 5b1f17b1804b1-49e7daa1eacmr259015e9.4.1789428275379; Mon, 14 Sep 2026
 16:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-3-dave@stgolabs.net>
In-Reply-To: <20260914212258.2657788-3-dave@stgolabs.net>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 14 Sep 2026 16:24:23 -0700
X-Gm-Features: AcwNN1XWnnbhAeWCdYdUleWL6H4kAfKBgLjOO27tKKfVi6W-pWHl8l94S0Cfe5w
Message-ID: <CABdmKX2-3vZB0Em3iUK2H3mbQMpv=v4P1Syj9tm_bsKnP-D74Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] dma-buf: system_heap: fix the allocation ladder on
 non-4K base pages
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
 benjamin.gaignard@collabora.com, jstultz@google.com, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Juan Yescas <jyescas@google.com>
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

On Mon, Sep 14, 2026 at 2:23=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> The orders for large base page sizes are calculated incorrectly, and
> currently only hold for the 4K case. Order 9 is intended for 2MB but
> will be 8MB on 16K, for example. Adjust the orders/sizes accordingly.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

We've been doing something like this downstream to support 16k base
pages: https://r.android.com/3907360
