Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83488C624D6
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 07:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA2810E181;
	Sat,  5 Sep 2026 07:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TxYzS9GA";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F7BC10E181
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 07:01:47 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843178b1c8so51423f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788591705; x=1789196505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kt57QRCH4DJKVKib3n3ZvQOCIYr91lFNtPdO+vKS0wg=;
 b=TxYzS9GANI65iFKCiKzbxtpXH50PYIkqwM2XcAG3DV2YDpCcWMLZ7VindlLlHJk8UW
 DmWPSuMjsp1OpcSrVS5yjrnwIdDetlGSe0qa9FQ8QCcnasZEzKLzUrs9ERE/4JbUr96i
 PjXEwAZX9Nz3miA8UxoV+JFfTeMRuuSEkBfvHwA8AWtYf2cWNs4t4xV0YDiER6L+pMlv
 rHtlitjNQbh5CYhlcxeBxc9ehWPv4ACYeZ3ndbIM2h8jLuySJ8/gFkOBRtULext7d9Fh
 wcICIQ2uookYAKVyyBQDo2pHz75OlMfc0zU6pOi68xA8PdlGGscahQ3y8SUGW68m66fT
 o0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788591705; x=1789196505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kt57QRCH4DJKVKib3n3ZvQOCIYr91lFNtPdO+vKS0wg=;
 b=CJXUliiSLJ4oJ+f7t05HTv5uYFmpWowKZhclrOEIk1gBXxNvbMGh8E8mhqIPxdFzHc
 u0hoSnQ8xQhV8kSqNddpuAOE5rfkGzevZ51UgfmYvkYzEPnwAOPL6myHVs0cfYjq/EPv
 gVHzTdrG9ftUNO7DMHH7yWzWKWNFpfLqSGGP6dHd/llZlXa1YHOojLnaCqA9aXUv6lbn
 JYan95fvh+Wy5Lz6JRZHawD066fSTcgxglw8mBOmCDEpSoPFM3GvltVzqGG/Tygs/5ec
 aixyXjkorocGJ2MJgVHUQQzkEHxDi+FkK0NCIl62bsA9rwdhchfsyrcvNnqPnu9b85GZ
 23Zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcRlo6/ycyX+lV9cDtDa9TuNhJmUQqqElJHd3bxCZo9mA43BdQXIomDZp+BIbqeB1q6Dzx4/HZGUw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1uqQh6VgYdHU4m0kIDcxjdzJyTCx/YyIS901Qk6fAf21xfL1G
 aECY83hfF5iXa5tf+mnxuXux0xwdrwhRu42lo7CnGX4C9pslsi2C2C07
X-Gm-Gg: AYBFou1SzwdV9DtwJm+EuNSbesup806Tjztyt9aYLbjTYkeToWWfsyPqKTNYInk0sEm
 a3NRQxGl7LTbLdxOcJE5BTFaP1v5LYEz8fpZX8RR0aKwbyVgrFmiTavWS33siSKPG/ZzsN3DbEm
 GtIcVC8SIpfDG8nJsYfJit2XqEtu4J+T8weUWhK8JooxOxTC3gdpl7RPU+YUzfCyQFPyaa2Z43E
 AaXiP1XqvGaXl5e4K2PVgI7le/8EgAo2kKyBB6EL5VQ6sBWNFnKw0Lo6YHRB4bsADJfwzwRJ/U+
 XYlKmg1eg83V7ig53hYt6TS7SHpymoIw8H7PgbCxA5XElajNo6sXE5TtAg9O1TIjEWlAsbs5s2e
 i6dJSW58SFbtAIRWkitREachFNoL6SuAePu1l98tYuELUL54iSKJs+lOmQNxwIlAmTaDs7e0SSV
 iZm0BCGP4NVfvyg2IBTYSCvanZqEJKaFnkfuPNZC3joqTkGXbYoYt3x/9A9UYURO1Gw1SDJGfVq
 5SRfHaudDgmLNb7Q5NlZ5DjlvCFv4YtTqix5C1KhWgW0u9sXg/XQ/VzPm05Z5sltOM=
X-Received: by 2002:a5d:5e0a:0:b0:484:3200:b7a6 with SMTP id
 ffacd0b85a97d-485907ec2c3mr2477008f8f.4.1788591705286; 
 Sat, 05 Sep 2026 00:01:45 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B950E00FBE43EAE5CDC0C29.dsl.pool.telekom.hu.
 [2001:4c4e:1b95:e00:fbe4:3eae:5cdc:c29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858ab73c2bsm10109185f8f.22.2026.09.05.00.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 00:01:44 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, tomeu@tomeuvizoso.net,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Sat,  5 Sep 2026 09:01:16 +0200
Message-ID: <20260905070121.37113-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905051323.189794-1-gahing@gahingwoo.com>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <20260903091646.7183-1-royalnet026@gmail.com>
 <20260904110853.85150-1-gahing@gahingwoo.com>
 <20260904124659.25971-1-royalnet026@gmail.com>
 <20260905051323.189794-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Jiaxing,

> Drop it. A Signed-off-by says I passed the patch along, and on your
> copy I did not.

Done for v2: 1/7 keeps your Reviewed-by and loses the Signed-off-by.

>   Tested-by: Jiaxing Hu <gahing@gahingwoo.com> # RK3576, two cores

Thank you. That is the second SoC for the fix, and the one where the
same code runs with a different core count. One request: the tag sits in
this thread rather than under the patch, so b4 will not see it when
Tomeu applies, and it drops a trailer I repost on your behalf as a
from/email mismatch. If you have a minute, a one-line reply with it on
the patch itself lets it be collected with the rest:

  https://lore.kernel.org/dri-devel/20260904125936.26234-1-royalnet026@gmail.com/

If not, I will carry it on the next revision should one be needed.

> an accel device takes the next free minor, so after two rebinds the
> NPU sat at /dev/accel/accel2

I saw the same here - the minor walked from 1 to 10 over ten unbind/bind
rounds, and only a module reload put it back to 0 - and I think it is
more than the next free minor. rocket_device_init() allocates the
drm_device with devm_drm_dev_alloc() against the module's "rknn"
platform device, so the drm_dev_put() that frees it hangs off that
device's devres, and that device is only unregistered in
rocket_unregister(). rocket_device_fini() calls drm_dev_unregister() and
nothing else. The minor's xa_erase() is a drmm action on the drm_device,
so it runs at the last drm_dev_put(), which does not come until module
exit. Every unbind therefore leaves one unregistered drm_device behind,
still holding its minor, and the reload is what finally frees them.
That is the devm leak the automated review raised on the fix; the
climbing minor is the visible half of it. It wants its own patch, not a
line in this thread - I will look at it once the series has had a first
round.

Glad the unbind path paid its hour back on your side. A bug found in
unsent work is the cheap kind.

Igor
