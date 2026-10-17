Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4391CCF2C1
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF9F10E3FA;
	Sat, 17 Oct 2026 17:07:51 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23ACC10E3FA
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 17:07:46 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so296973f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792256864; x=1792861664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yzUR4s1SjmcfQnwChERnzeBd2SyoR/60FRqLysjAHcg=;
 b=NTXl4MrjCDlrv47SbLhAVEXayhrkq/Bxc1FrxFbi5bGnsPnBAew9hgHL7jkRJtADMH
 F/ic3Ri55Bt6j67VMwUvblhv+mHCDLQp09GkTJF3UmGiRW4nQj3Dc8jNRb/hCPTn7EO6
 LG9rZ68jZLV+SzUHSZLf2QoVc/WgEwPulvEDyy4oXzXaWkGx7siuLplHCqEOed1+s9t1
 qdavWaqYVG/aWnEhq9rEZOGk3Da4d13Llquh8zXbjqK6+6Ckf4+2xsihAyf/1yBf7KBz
 XK+Q9v1I4bV0ZFkFrqnBu6OegT1xGidOeYnDy0qpTNzFZky2ZThzyv6ZRcsGG9NnzCed
 7vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792256864; x=1792861664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yzUR4s1SjmcfQnwChERnzeBd2SyoR/60FRqLysjAHcg=;
 b=B4dktfCS+juVyYbBYCxBrco+fTHcb506HcIKxMZoCJBxor++c4NXuF9DeFdHmJ5MEK
 RSe2gOmwgaTqhU+CzzQu/LD+cLCZ4tLPNP4tTEdKI2c+L+YcnoUCHm3u279PhC6u+GGI
 F8OC582lYE2/y9UFtSlvmail7GSbJZKU5BdY2XXxvg2DPpXDFCodd+4kYGt73F1pdSZi
 lrETFgvuHSk01bydQPa1g+ZU99O7GG6a8oCZInjWou6kAZwlqYRH2O2hnLkx1zfar9+e
 wdKH9ZNjDyd+KV4xhljH4INLkzoUypIRzgxfo42fVdX7yyXfMFmu14MwEWBmqptwAGdC
 +M1A==
X-Forwarded-Encrypted: i=1;
 AKwUvByx2auUlq7AI1swDLlrU/ci0lVRHTxaxnGxpCVpk8lYaFbP8f0A92OMEzI+1MH9KAV3Aq8UOXmVJMM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJS3BOkhfqpK9uqnarfSYVnb95bEjWIML5yZ3/fwD22vBoxGxdX
 qUTqC3yzm5/q2/tlWcVTEpIsG5aIO/Rue/DePlX6ww3krSMQSOEqtBxf
X-Gm-Gg: AYBFou1XTsUsCOAZXOZRAVmS/27+HhntXB465fPYF2qKvYedy6tQ0fqNEXFDTku7NcV
 c3wZMm+b4zGNZZ2gtkoX3z0iJafEzGvRrxTFsW0LaBPfMBQFuMLErwKHYB920l46aClLcFIBRSf
 y7Y6aUfMVVpIuBmI2RPPiVOwQU2ifeo5lm4uuHCDo4tVXJi4joy59p1MZ+HVK7OqkN4e4+sUxd0
 tt6R/Syjcd1eBzVOg2I5WnxXNAI+UtsJm3b6IkHSO2Fe9TxPiUHc7NJyJxPXdVCrSm9EDgWAEf+
 nojRP6CTzw0PH9NxUY9eNzSggOxVJhfT7syk5jEI/IY+hhc7oo60gXuNxP7embbiE9JFqPVJul5
 ei8N5JL7VSe/dkxp2jNofB411yAL17bNcKPAWxVY/GPWzY/5LqgWaX2bHRmRQYfdlCJlOJ09E1J
 3/7F96pxrQ5Z47H4c/T3CH3OYchTMWCigQQFy3a1t0WSH0dty+qBsDqeBwZwM4P7CBM3JSCaJRe
 FQemEvcKoSEIFvhRQnYA8uzPJNPROSNKH53U6LL5ZM1W4bNibqs
X-Received: by 2002:a05:6000:2508:b0:48d:f865:c44a with SMTP id
 ffacd0b85a97d-48e07fa74b2mr5718293f8f.39.1792256864157; 
 Sat, 17 Oct 2026 10:07:44 -0700 (PDT)
Received: from cachyos-x8664 ([2a01:e0a:899:6110:90de:8744:7ad5:471e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510201sm12596421f8f.55.2026.10.17.10.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 10:07:43 -0700 (PDT)
From: Julien Le Bourg <julien.lebourg8@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Restore self-refresh fallback in
 DCN21 bandwidth validation
Date: Sat, 17 Oct 2026 19:07:30 +0200
Message-ID: <20261017170730.56023-1-julien.lebourg8@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823115200.12502-1-julien.lebourg8@gmail.com>
References: <20260823115200.12502-1-julien.lebourg8@gmail.com>
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

Gentle ping on this one.

Since v2 was posted, a second user reported the same regression on
https://gitlab.freedesktop.org/drm/amd/-/issues/5628 and bisected it
independently to b96150a70696. Their setup is a Ryzen 3 5400U mini PC
driving external monitors: an ASUS VG248QE is limited to 120 Hz instead
of 144 Hz, and a Dell S2419HGF to 60 Hz instead of 144 Hz. They report
that the patch fixes it.

So this is not limited to 360 Hz eDP panels. Ordinary 144 Hz external
monitors on DCN 2.1 APUs (Renoir, Lucienne, Cezanne, Barcelo) lose
their top refresh rate in every release since v7.1.

Could someone from the DC team take a look? I'm happy to rework it if
you'd rather fix the check vs commit_tail mismatch differently.

Thanks,
Julien
