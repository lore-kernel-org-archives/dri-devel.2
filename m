Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B22606A32D
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0eZ3aLEK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5368A10EA36;
	Sat,  7 Nov 2026 14:28:02 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01B210E452
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 19:48:25 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so674565f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793994504; x=1794599304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I/21Es773AUDvFmxDpw0bwxLoX1T07xfM8g2Md/BJQ4=;
 b=0eZ3aLEKmCJC9zlQd8KtO3SsluNNQlsbKaxitj5KmwE3RN53e4YxbvFDrwORGKq6GK
 v3LGrvT73pEeg6EbQCKRMWxzfeQLYUlaXHXLC1QSIpIfO8Zzck4dlm+LXJuQKQMVThSh
 Vg8uYsq0Cp6eEh5J0TbFDIuAD0XP/NrSAqoyRsDO8IAnp72QQ7jNPoh/jNDh6ruxcfsd
 myb7iieWWJNfV0sozjeLRJsE8jYXt2HXEUW6XfjI7Y0jFeFdOpBABiad1G9tOJyt9yOR
 YhGflA/RzS2q5trcjmqP/HGWY1Y9lUgcuDUI40IDyxXMlk3M3X2iqwklMo3AaEe3W0fJ
 o1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793994504; x=1794599304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I/21Es773AUDvFmxDpw0bwxLoX1T07xfM8g2Md/BJQ4=;
 b=Nyar14623YVDNor9mREBhjRDTzgFKPHe+DsSsYhiFC1MHsUTK0XXs3gQ3r/oVaXFse
 ipsG/Y0PPpIFDyz1lZWiAqwfnD3brDLBCm/OjxcOZP4acL3R/ELEJ5kZh5TPPSoZ0z9G
 u3rhAPgUue5j/yzj79yiRawUu1oCpd0cgQgJn20kd1XExp+X/vrzzrJV4UA3FDSgB2Zk
 cn3g9xvOQQCdb1mKANunP2kuR0SY8t8CHKrzGHKIcpwfjgzhYoj1bYNTFwHHlDDDabJL
 tX7Y8L2kgEEt6vCcYoSeUboF9SO7qP2W3cBOR+xT4T5Nh3JTw7wOEUdiHAuW+CT7VuTA
 Mxiw==
X-Gm-Message-State: APuU4Z8SRc1UYxLRZ90ayUBLjXo19kszSu1LW6kQ/6ursviuh04Kkia+
 9WhFQqyQXHcgb6m12UKK6oJAaJp1a0jg8nPPG7jVPX5b+/48rNe3c5km
X-Gm-Gg: AYBFou1MmUDWBM2rhIStb4iz9lHUj1uBI37SVHrsTfkH8GR5AK8hIDbeeldn9/d+zQg
 fMMjQ20je5328dKmLYM4czFu7/1codo7/eb2vYqXZQi0LBlJYoATrIJ+tBRjnUV7Yz1JwWenrdI
 OhhiuefIfI3mIgMOoaVRFG+zCkc8+ycBTeMv32rnEQCQC0PnhczLT9Bf+TV0+V8yAf34HMTFWkB
 /OlhY8i2KEPQqlj0D60BonU7+FnHUK2rAq7K89jq7gLhz0OZ1d9cz9+bLLLde2dVho48AH+dhrX
 qvJPzGWTFG3xkQHtTxhg1OyiN9/0BbgBqFRpJm6xsNJG5ALI9WyXXrr29SDkk+CdakpuMpMsS7L
 c6zAlj57rWm9axx5JQiHWm5baQc6KMP9m0QFQ5E0DFijK8hrm8A03OJTVc0Le7t/yIAMwY6n6mS
 yQvViiJ1u9QlWRewuG9eEgUwHIGfIUT1HInms4iFb4vQwFNrUpL2glh6OdkQnNu0tAs6QM9BNEA
 S7Owzu8+7b5r5BpQNfs5IOOHxavIBZeEIPGiI5JMK+4jHuzodsri1VUZXA2aOrVt8og9/vJymNk
 bMbqmzI90v2CSG2lT4zrm8iREhMFc5Y=
X-Received: by 2002:a05:6000:1acd:b0:490:9fe2:6a39 with SMTP id
 ffacd0b85a97d-49275fe4e8fmr6979074f8f.20.1793994503735; 
 Fri, 06 Nov 2026 11:48:23 -0800 (PST)
Received: from hp-z640.fritz.box ([64.43.161.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d73286cdsm4928130f8f.28.2026.11.06.11.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:48:23 -0800 (PST)
From: Owen O'Hehir <oo.hehir@gmail.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Heiko Stuebner <heiko@sntech.de>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH v7 00/19] drm: starfive: jh7110: Enable display subsystem
Date: Fri,  6 Nov 2026 19:48:22 +0000
Message-ID: <20261106194822.4153919-1-oo.hehir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
References: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested on a VisionFive 2 v1.3B with this series and the v7 PHY series
on next-20261105. All 24 modes the sink advertises set with modetest,
from 1920x1080@60 down to 640x480, including the mixed sync polarity
modes 1680x1050@59.88, 1280x800@59.91 and 720x400@70.08, with nothing
in dmesg.

One thing outside this series: the modetest pattern showed small black
bars until I wrote 200 MB of other data, which pushed the pattern out of
the CPU cache into memory, after which it was clean. The U74 has no
Svpbmt, so the dumb buffer mapping stays cached here. My v5 run had the
SiFive uncached-alias errata patches applied and did not show it.

Tested-by: Owen O'Hehir <oo.hehir@gmail.com>
