Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385BAFF885D
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 22:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FCE710E21E;
	Sun, 26 Apr 2026 22:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bw39loPX";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D74B10E1A9
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 09:15:58 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43d7dab87e1so1045774f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777194957; x=1777799757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpyPL5TyTayqbvU2HEjTYaipnvh2LNQ+6cgKsY26UEw=;
 b=Bw39loPXn+C37IRnR7yaW1dfyhP8PdvPK4rBE06IJnZQXDMpGcMczgw80fIh3gYE/A
 EC0HLsKWPqJKd5uFi/EvhK+skgAZqVdBK3eY7T5kT0oJke+8mk/yFXDmwgeTcGjCJxQf
 B9plMLZyVrky2/vyRM0mSSjRItRkK/0hfojeFG6c2R3y2RvoPaSoJNBnkxGfPgctcVL6
 FK3lzEKNLj97Lo/Gc+SE0m/hDm0I3dp51RhYWcrHEgB+ZUrslzRViD6OZXwxfXgUzpbL
 9nsZ6zjFIpAQs5ISQGX5QWKKczo8xGVMda3leyImGLD1u0Gq8DjMI2UoG8rpODU7G0p3
 r5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777194957; x=1777799757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MpyPL5TyTayqbvU2HEjTYaipnvh2LNQ+6cgKsY26UEw=;
 b=BQDBkYT53hBuzcgB4C9GdUevgR5VFJ3H0j8NhJkTxY3ZEpU83rQzrMubvxTNATsz7/
 l0RNgWJ1NNbuHuIjKzGLfnfZQ/79QTIHuMMZPtmUSzXTQgq5xCMuTzs8sB+B/buv/lGy
 8Bze/fEhOAmEgiaZm/yPCfuyvmmSVGjpD19zgq52xf1AH8uClmYQY3uP9urhUZWk606A
 Tzn6suratsppY4nieLe7EnA3rDMT72mwAmOs+giZT8WxvkAOqJXxOqryoTqxHjsb3ifs
 eWtYoJJnRmJSMLUYogW3uvJxtq3s1X7bcQ37L72t22IQ8sQB9KwPahsVmQpoglnW6/Ds
 i45A==
X-Gm-Message-State: AOJu0YxiGP9PB81u43yY6RNORz9etxsqXuYyjTVhMFGONDj1e20XBrJ2
 E6MV8559phOrcF1afSDDkXRaUJcoSIk9jqtE3VbJDPND6NX9pzRdCTyx
X-Gm-Gg: AeBDievmjgc2JPw+xImv7ujfwEW2ezCDVUEY52Gq7usND7zM2ApVO6HSBiaghNnZLta
 iZ1XcLh5F3u/7YfH03xgk0eZGqhXw38xR2nh0Y5IiQJOLYuikXlEaQn33WLU3ya9rQTejvsvvpk
 sPayRgrXB0yVnpooQ888onRFAdNsnqGqFb6gDIu8YTJZi69zDyqPdMsHRysPfR9cMg2KXywv1Oa
 kgz1D14ofVwcLry74D5+9iMHmuVddyaaszmlePw+2zwMiW+gCNuy3hKPsjJPVYBjTIkD30C/sCm
 6TqIaWqdne5Rxmn65fYjmG1wci1e+h/mPK2ycvgtHMTJ++onO1rZ44IIHtMXCsIMEB/lxz3bc0i
 shoP0oUZ6t7fm0HTxRKpfptOOTpTsZc+fGMnep9Ba42hOsMs1YATN4mHxRnUF8EfnynHcFlmmNe
 L/O0uIuSPKd/Rlas/YqwhRK1HmMTisdVyzRpOwxBfBlbkyCy6srQORVIeDySu1/5+x6PLYYO+EE
 sHfzcC9ULCI3DxHfk1BpKXg/tv3iM02xBA=
X-Received: by 2002:a05:600c:4686:b0:489:6c28:dbb4 with SMTP id
 5b1f17b1804b1-4896c28dccbmr204731515e9.5.1777194956440; 
 Sun, 26 Apr 2026 02:15:56 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-078-043-200-145.um18.pools.vodafone-ip.de. [78.43.200.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc558f2sm552070085e9.1.2026.04.26.02.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 02:15:55 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Marek Czernohous <marek@czernohous.de>
Subject: Re: [PATCH 0/3] drm/nouveau: stability fixes for NVAC (MCP79/MCP7A)
 -- 3 weeks soak report
Date: Sun, 26 Apr 2026 11:15:54 +0200
Message-ID: <20260426091554.21272-1-marek@czernohous.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409172126.115441-1-marek@czernohous.de>
References: <20260409172126.115441-1-marek@czernohous.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 22:10:08 +0000
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

Hi,

just a soak-test follow-up on this series (submitted 2026-04-09).

The three patches have been running on my Mac mini (Late 2009), MCP79
chipset with the integrated GeForce 9400M / NVAC, as my daily-driver
graphics stack across 17 reboots on the patched kernels (14 boots on
v6.18.18 and 3 boots on v6.18.22) since 2026-04-09. No regressions and
no new failure modes attributable to the series:

  - No FIFO errors (PATCH 1/3, nv46 MSI rearm)
  - No NULL deref under labwc/Wayland atomic modesetting (PATCH 2/3,
    CRTC NULL check)
  - No spurious DisplayPort disconnects on HPD IRQ glitches (PATCH 3/3,
    DP retry link check)

Regards,
Marek
