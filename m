Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375E606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q6gWh4nz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757A210E71A;
	Thu,  5 Nov 2026 18:36:59 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF2410E3BF
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:36:53 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1269384f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793903812; x=1794508612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eURpXedoFOfRQ/r9QZEtib/RzaUOHxCVKJ6f94qIWpI=;
 b=q6gWh4nz4CjQMSb5FKpNnrKZiWaw8j47/V51HZE4Ihslr3sWlVw1NNfV3M9gambNeV
 TJ7fqMnUTJ56T+5XB9CvBUwbb0Aycox/f3j07iu18qCBDYmjaD5QKrCmif+Prc45slYe
 qfj2BRuD0JL5hol2mtaXGGFOLGtjNEUDzYolXdg/tceuUknyLWaL5m+Q9ak7fHOm4bMC
 iww6l/fWoLL1yXQbR0fZEfpTmvsb4KSYkxc66ibysfEd3tMQWyYnEH79JjzziLd/74ol
 9wMdHcytgds6wJZALNzBVn4JWTX7/pk+Vz0eznElgxW0qcrqkrqat+LdZZUT+WQc6doq
 g8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903812; x=1794508612;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eURpXedoFOfRQ/r9QZEtib/RzaUOHxCVKJ6f94qIWpI=;
 b=wFmg3tlV7sGvzLW64ENHiFngPFNKUSXr9Q9m1Fb+PfQCjJXJIR1MjWVkr6ZoaZPCVp
 ZDeQQ4Uj9KKtH3vT4Bw0mNRXhAgi+/4krITmaf9I58KHUNodKnSNSiyby3Q3olA8ObNU
 c2txaomFR8b00cXh7MSsAfg1LKTiEB1sEKveqRvInevwUHtlXFtNzWIPWMK/17nozCfc
 oWq2Q8qgvwRX1Qh6l+UkFEUkiUM2oxJobwcy2BlHqof3OvWcAGZmmoDiZOOFxsgsszkd
 qw3d6+MloBOP+3pscoXSMPK7mMt9HHSOk5YcFgFhqlbK824YRvN4Ya/1bH959RhMSJi1
 uV/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBPvJ2Kc3P49fwiB/OGXdTz+EEl07wX0K+YV1rFVTdeRLdDpTe/l14EK/zqzBMGCQF6H0CyPUT/KA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z93Je+QlcnPIaDZOchGy8gdBnFibo6DYFbaJ4AMjEysVlXTbcvA
 7tiJE88fHWK2KIT7D+3hLsMmx0/Y59V/w3MBY92LkpizpCBzSfWNVWHn
X-Gm-Gg: AYBFou2ToLvMLUk3M3ZOmSeKisWhDaRaSjjCNGnmPQ6235rKt8LL4fOubqyBA1bFsXf
 5R7xTiSIi2YGz8ucAgz2blAdjE7gp5BAwJNLToFoD35DHEMOHqzRU5BHhdGvudB+HrBtfN7HAJg
 +kSpDRruyvyL8BRxtUUyxfbNyZfHHbDpPFDpxq6wjVXLfwczrYnqlG13zwU8+RnxLgNN2M1eY0F
 2hSUvfZfsirUVzlg59jfkRa/w9k43GyCG0bymCB2yYgbspQgjmms0J9bty17abAjl2Oj2lPaf3C
 iEo67ZCDoRrqQCB8HMBvjCbniPYGSeJMt+R1wQhFBXgh+jRQcy5aKZyzcEpRSkflGxQqDqnb3Zp
 Lj3ko5RjUHrW5qV7ZjzyIbfsmfbzb6E+4i3cMMQ3JJ3DdNUJpDIxAoqm803WedoRZDbYJDu5p/J
 /2Jf8Cp87FikqxxudQAz90zTfuqXuZ6MB0hyYpuaAHQynjXn6a2hsSDC2o9o3MVCesUynzhiR8j
 a84U5Y5KSR5vMqUP1Cfd+XdAsBbbhMpP2oa2qCx+0a1TpeRKghGccbv+5OlnQ6BifpQ6wq6TW7P
 EnPrxdYxuMYb1GJXWfAlHqAxP9YuJJXO0g==
X-Received: by 2002:a05:600c:a00d:b0:4a5:e6fd:65e5 with SMTP id
 5b1f17b1804b1-4ac19705d57mr435027495e9.31.1793903811876; 
 Thu, 05 Nov 2026 10:36:51 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56f5e59d3sm89170995e9.10.2026.11.05.10.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:36:51 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/vkms: Add drm_dev_enter/exit guards for
 hot-removable paths
Date: Thu,  5 Nov 2026 18:36:44 +0000
Message-ID: <20261105183644.188127-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031225901.3200167-1-sebastian.wick@redhat.com>
References: <20261031225901.3200167-1-sebastian.wick@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Whoops, May I ask about one path.

> 2. Conversely, if struct drm_device is still kept alive by an open
> /dev/dri/card<N> fd when crc/data is closed after drm_dev_unplug() sets
> dev->unplugged = true, drm_dev_enter(crtc->dev, &idx) in
> vkms_set_crc_source(crtc, NULL) will return false and exit early with
> -ENODEV. Doesn't that skip vkms_set_composer(out, false), leaving
> out->composer_enabled set to true and leaking the vblank reference from
> drm_crtc_vblank_put(&out->crtc)?

I followed it and think it really holds. And this issue was introduced by this patch.

drivers/gpu/drm/vkms/vkms_composer.c:vkms_set_crc_source() {
	if (!drm_dev_enter(crtc->dev, &idx))
		return -ENODEV;

	ret = vkms_crc_parse_source(src_name, &enabled);

	vkms_set_composer(out, enabled);
}

I understand the guard is meant to reject new operations after unplug. However, since closing the CRC file is a cleanup path, skipping vkms_set_composer(out, false) seems like it would leak the vblank reference.

Thank you,
Oarora Etimis
