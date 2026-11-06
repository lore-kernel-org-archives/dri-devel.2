Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3F606A32F
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ooemX1LR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E1B10EB4C;
	Sat,  7 Nov 2026 14:28:20 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F110112FAE
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 19:14:27 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so11756025e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793992466; x=1794597266;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ny7CBnpzaEmqmRZNMZQTuMsTlRnHeslB+C3vtjdk+QE=;
 b=ooemX1LRkbyDyihZXClU2C78Wl2oelTaUA+fXr77RPRiYnHYKykUo+8smKeAVrjYE1
 DyxSWKRFNZv8+VBrVpUEUZJ8jWP1KE0CeVnLWdsiQ2spC4mbkUel49n3IcEjuh+LpvMN
 rzlF4M8hLvQm8FSlqHh/08kIPd/lFKu8kCpZT9pZ1Nn+BzpiC5IWrpPL3z4qNOw1gEmF
 Df1LBqVwIwteVSo0vsMWGpTIX3l87VLhGlFkIA2YvBZL7+2H9uyTijMB3FLCCL5cn4r5
 AGDiZj245s3xkYIYwly24OhFY723lnhfQ1fVmyq5OiAjDArgI3KeMUVPGDu/oYeCeyA1
 IdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793992466; x=1794597266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ny7CBnpzaEmqmRZNMZQTuMsTlRnHeslB+C3vtjdk+QE=;
 b=JxyCogeZJtOzlkc7kFIqU27S9X2cd+EpsPmn8scfAyl1Dm3E6SHD2ZEdkNouqr3OmG
 RfS7d+hCSjm6YKHjaV2aUcsG8tDGRiE4yEox9tYkk4+wC2uPGVze4F2EkHEX3PZEzvha
 r03yAAvfh3dRn7Iw+pNrDvJQyHmSjd86EsgXcyhtPvzCvNXCP2J0dW54Tb5lti3aAYxi
 diDGrPlXideSIVv6DqNVJoIiRgdRcFetfim9IXsOZkVsP9xZuQf7MBQJ33qjWDyFxTob
 uFJB8iHjs1+sRhzCuEEx80kLKY1OYy2VMNXy5v7+FUJNHlUj9VJoIDuy/6NXrjzrgmFW
 ShCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5/1jgEfmlaI1s2l6CgJWaMB/W2chq7a4ElKbJIjDenwffPNhzS/ZbaM9XWUG9E5/BPIUgmT7FuZ8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9RXIPeao4GH+oYHVoKmPPI051dTPcAVxJgimeoefqWGRsZgMTV
 HH999KI0bVEmwLf1g/XV6ziiOBRs38ELo3USFrgDtQpcGuyiRJ/6a19YICPRSnlg4pE=
X-Gm-Gg: AYBFou0MMQx01qyx56Hg47mKCK006h7GhcQxItMZ3qqxWAFAKe6XCRUNBbu6elzTjfI
 Dw+q5372welNRwuqCIJgubY1JqCAYNTSF4gZkTTJ2Z1Juyf3BZ9QPdQNc1SeA7JOijvCjT51Eob
 ec5tCyLvxs0srvHmHfyXSyQHrdtlA3Y7UnFWndlyeQy4HcSqPH4QTYxVL+aVUizecHNHqqgpEiD
 HsxupF4oC2DkzgkpP31lQbQXIf1gLwpyWZlasvughgqzutk35FinDRM2201KMAOC+PmZAWjIgPC
 EAAUyWq4jEt7K5xrTSyQOR3j/axAXGisid0vgVOhTugJ2RXgyMYyQnHRW38hLa7NCQewOLJEWKg
 f75aDq2ZQ0/PqaTCCzDIym7QE+kzFL1SVEpWSNtlbHjrf87iTVYAwO8iY/cET3pPkj15zhV9lzH
 0qXVkeWWkzvlEprTS+1V04cdlOHPO1XfjbRZISHgIm/ujD/Cdkg6hH18sEzxtWD0eeb73oWVt6h
 TUG0hX3RU6KSQVs8mqtSjKh44kG7k00MpWfzfJ20Jv15pACaz83sBDKC1eM5vWB30ZIGHe+i2ab
 NZUXMytbsg05bRQDNLpn0qp1dvcX1FvQduoUZmqaqFfhu901QvnXo8lx4dwJOw==
X-Received: by 2002:a05:600c:5295:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4b6de973c5fmr58007235e9.6.1793992465400; 
 Fri, 06 Nov 2026 11:14:25 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:30ce:e69c:9ae:c94a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7efb1b64esm670335e9.13.2026.11.06.11.14.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Nov 2026 11:14:24 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Paul Cercueil <paul@crapouillou.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] drm/ingenic: Add a driver for the X1600 display
 controller
Date: Fri,  6 Nov 2026 20:13:08 +0100
Message-ID: <20261106191308.31303-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <71aa432f71144f446dba2037ab5664eea3569fdc.camel@crapouillou.net>
References: <20261106112000.1612-4-olivier@mgcrea.io>
 <0a2e8ea782fa819a547e0a3075303bd74a7fde72.camel@crapouillou.net>
 <20261106143827.15926-1-olivier@mgcrea.io>
 <71aa432f71144f446dba2037ab5664eea3569fdc.camel@crapouillou.net>
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Paul,

On Fri, Nov 06, 2026 at 04:06:50PM +0100, Paul Cercueil wrote:
> Is there really a point in enabling the clock on-demand? Why not keep it enabled
> always? It makes the driver more complex and I don't see a real benefit.

Fair enough. I have nothing on the R1 to measure what the gate saves,
and the PLL it divides from keeps running for the MMC controllers
anyway. v4 enables the clock in probe and keeps it on until unbind, as
ingenic-drm-drv.c does, and moves the timing block to
atomic_mode_set() as you suggested first.

Thanks,
Olivier
