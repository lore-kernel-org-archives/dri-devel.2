Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A095CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB9D10E64B;
	Sun, 18 Oct 2026 14:53:14 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC8E112826
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:49:17 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e915887d9dso27400905ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792158557; x=1792763357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2oPOPJSo8SwZG2zShQhf9c9WjJUFK6Ksr1Sry34EbzU=;
 b=DEfKNJ57kPhEpD9FDgRNdjJC/kcv5/6PbHhnwCdnZoT8vMJrRYl5BlR1EHpywIPyVK
 +V2FHmyHEpfvUw8Oa35WCHkpjFUSRu5FD80UxZDqk44KJ7WNBfCju5iGE9kidpkGEUrW
 OeKxWWWz2dkaJqeujF9tvoDdg5yFQTalYcv7immZKBE2MD8hTzegvIJNcIK61i/uufCO
 gWzrqECOg3NW0hIf3ZTn/yUyZcws8pS6Vuy2E0F6IuRlkqj7Y6Pv0XfJrRZceFJthdhI
 YYXhelddT4LHtsQEYo15/7GR/Q8gCweXqq3HR+VvXQOtb6+ntQV4/LT3Dfn4cDmg1PRs
 y5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158557; x=1792763357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2oPOPJSo8SwZG2zShQhf9c9WjJUFK6Ksr1Sry34EbzU=;
 b=wYHNW7TkjreWsGVnyaES/gV+Af86ZcGNfbpMW5e3fLT0l1w34mN7nfQg2gmnnpV+YC
 xWacS3b+U1FfnkuSKgQ+edNYxC6pT+IoatlN0I3jgZ4VOOHHTx0cKQkbSL2/sgKAtgiR
 dFYmsMqE2BLbyuq/kuqXUY6kc3Sl+jAfToH9qclzWjlT00rHZVXBSbdI84qMGC1MhjMQ
 /mdV2TsJIgleIZMhzWZQ9GRD30x4YXM9TvZp9Oj1dOJoppFmeC1m/+c9i0KagCf/Krfo
 L/4gpsWJLdvsGBGxriN/yyzKsTdwB28b6w1k9OyRh9OqX7j6OCw9KGkP1Aa1JDSSv2d+
 lPrA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHefqDt1qL8TvA5hzXIvFN9n+z1+OtgPTEns3bphMGIqJbXs971ySwlQjokD4wVRFIGtfj8vPn+2I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwLXlX1e/zXp+fuMJrr6Db594A9VJRvunar3/NuqomEpVSaYmO
 VEyOynRDAjIKd+Fw6k0QNBpn8kwhDCTcWcyro974QRp2OQIP04yjvGh1X75sisJGTbXR5g==
X-Gm-Gg: AYBFou3pgshN/2fz6sI+cNQmAE6yuy+gl2z+oTxBQ7DHyGRlX+UId95ZppVzHo5Myk8
 paHrAfrYm9U2Ky3KehFgUGjwMZ9/kc12M0FgdxhTKMdSzBrZj7NKA+oduLHRTkejmncV+tfo6JC
 i+PLGSz/MX2DooqtDlgOxCeE9vrDTXYJzWNQlE0JlHqJpM95ltdBmY6qMArEFqWrph0T3KzXcLu
 rcn2mIhTXJA2tiS+jcn30+sn3hOC23U/wFQvSGGKCa0u4TCa0/SaQynp7UxjKw/IZJbiNLvxZXt
 n5JTOKGJhv2gbffXWccsqmUKSqdkNazGHlTiD9c2VJ26VU/c++VI5PsIcof95y0g6QP5gOOXVl5
 dmvi9/aS6I5XjrVo/pLTq6QAmyJFbd1YA3mIERByR4ppbH1Ed/UsfFGFNpbv/jzhJHZNExIUk1M
 ja5H6P9DRw0vETF0Bgk4X4KVt6F8QM3TyoIlt5to60Ru0fc/vo6LTG/ZqXrH1MdGW6fJiZLq9i5
 fbmYApd8uclinfZM8uRkB4e6YymI5rQravBw+89Ngyj2WIjYpJRN+kUSDqbr3OOO6YJf8acPA==
X-Received: by 2002:a17:902:ef45:b0:2e9:7ace:ccc7 with SMTP id
 d9443c01a7336-2e9a69eadc5mr215965ad.39.1792158557334; 
 Fri, 16 Oct 2026 06:49:17 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:1467:1666:71b7:b993])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e87836bsm10762845ad.47.2026.10.16.06.49.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Oct 2026 06:49:16 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel: ethosu: Fix kernel-doc for
 ethosu_gem_cmdstream_create()
Date: Fri, 16 Oct 2026 19:19:06 +0530
Message-ID: <20261016134910.35015-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261016132726.GH5059-robh@kernel.org>
References: <20261016132726.GH5059-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

On Fri, Oct 16, 2026 at 08:27:26AM -0500, Rob Herring wrote:
> Why are you sending this again after 4 days?

My mistake sorry, this is an accidental resend. It is the same patch as the
12 Oct posting with nothing changed:

https://lore.kernel.org/all/20261012152118.33548-1-sinha.aryan03@gmail.com/

Please ignore this copy and use the original. Sorry for the duplication.

Aryan
