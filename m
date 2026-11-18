Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDBC606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HeAy7rHn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E008E10E06B;
	Wed, 18 Nov 2026 11:19:52 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E27910E06B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:19:47 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so7031805e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 03:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1795000786;
 x=1795605586; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AoUPKNSiZS6kFkBYlEFOdT09eSZL+nuPSg0RxUA4uP4=;
 b=HeAy7rHns2TVfNoJyVuh1jyxpNvGBpmgwYcunJ8KlIiYGurff+lgyZNpXzv3A+uElj
 4ZjFQh8QxOReflyOx3L4oObMgj6+y7h9KMBOCrA6ZJ4p38nvegG6ShaCKcoynLx6Icv/
 FB+qnDTFqoznXFXNhUKOb5Vtmt3lfvt9FBQKxGwfxi5QYPHEP7NJIUSuRKP+V6p1X6Ke
 JCCBmdP64fZniovWWUmfcZltosfzpdz+lYI3Y2lw9SfDBrDGDO2S8Ib6oFrOFg+tyl0j
 81mqzjB7y2UhJ86evLsodkZNJhkff9YJMkp9c/d1rzO/2dfqJ7ACGb01/vnJAQzLW9Qn
 uFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795000786; x=1795605586;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AoUPKNSiZS6kFkBYlEFOdT09eSZL+nuPSg0RxUA4uP4=;
 b=2IT0GzfzIwr1PFgolAxbFGJdbSV/9sWJUluBFJPTauYYHd4L30vM6h2qQ7BNBJvgaq
 wCDFkyBBJgQ8Dc2umWQSGDpCuubPip42hDR4APG/DriUdHbrAWSUMwRF51F55uM/ZR+g
 AFYYyH5uPHzwqfRWDXtPdu8rYWST4zZBzVRM3q0BxCzrkB0d9I2g7BTMjnI6Z76IUo4U
 MbvUBFHQFwaEdY12+lbAEcsJRYgFCyR60vYNQ8F29/ZteiHn6QsCmo63jtWkqVJNpfXF
 03PUlcZJvluBKXJX6bMo3wQA3tADHoJoULlWij68edk1Y2yMI6oC6G1nm7HfTy14BiAI
 Eg/A==
X-Forwarded-Encrypted: i=1;
 AL+hErHcrGP9r9Z/vBYsnIoFe1ByN8FVUGbt2Hh3phwwsnn/9Lqu87vWRIELefyz0s42Bt+o84Az27yOhn0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+XfZa6K9AOqBHjHDlsqVdZLUBPHyZQQl3gLwvVXxPnV1OHtDUs
 kDqsZUkj25XmunpQYx5rOS9YsN+Uc+i3S1HybrVFKyMFw4+B5kO+xxOV5TIBiBK16aY=
X-Gm-Gg: AYBFou0RNxPri0v5UOvyZqQ6Oh6OMh0RM7tuFL2x2N0gAKjMxP1lG19tLsLVvA4u4Nh
 zsixGRA2awXyKU+Je0a9NYItskFYbv2qUa2Dcc5JaFLDfTTV88qVbaVAgWVeQGoX+5+mRCtzSf9
 +xRM9qDtR/UB+vdvZGgND2YEXzaggqiE8YPpgG+xDnJEQayg69iCDkmWGxK99PbiHL6RS1guD24
 Y5ONH2OxLBY8z0DZ2dAmuD8/PqrhNsAZ4zhoplfqELwDdtOkXXxctkyH30LVQdpJGkjJuGCczXL
 5/VuGZ8o4ipPzc3HHkrVoBw90LQyhlLZFa7PAcmnGanu7J7bMTNNAYiFkJfLMxnPwBRtTgVldWT
 knmGwjwYar1gINNXvkdlk+bp1aICgZ2upPqhUJilFPvWLOKkizliHAsHd3eEwQw8ho7e1BihG62
 jZasNff6dgLW+97PcFituDSAy9v/Ao5TwpKsBTUL1zXB32NVyKH+Y81RPpMulKjvqAGGOBnE72c
 CdHrEfPzrv/VS96aTw4Gu23Qfw6Xouk7yo8dSG2uXOdPRJOX9fUg23wSXFDNAiDwKOlf8E7PHrS
 MgLRFAC1uxa5Dlo+B8NvYJUXX4SF/1VNAmUtICsoJw6AKpTX8pvRm8WA15sbwThNWVrYQgYzq9Y
 Gec16rUsOnbCc8del3gcwJzxXKm/w/p+JEzOGT1ek0KlviMeyrWdmE9skg5Qm06Y5kROx7Xg=
X-Received: by 2002:a05:600c:3d9a:b0:4a3:5aee:2c25 with SMTP id
 5b1f17b1804b1-4bb7da585cdmr42908225e9.31.1795000785807; 
 Wed, 18 Nov 2026 03:19:45 -0800 (PST)
Received: from alcachofa.home (cst-prg-52-235.cust.vodafone.cz.
 [46.135.52.235]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656c11643sm4030711f8f.49.2026.11.18.03.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 03:19:45 -0800 (PST)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: Heiko Stuebner <heiko@sntech.de>, Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Triet Hoang <triet.hoang.dev@gmail.com>,
 Sidong Yang <sidong.yang@furiosa.ai>,
 Igor Paunovic <royalnet026@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: Fix up sched array handling on open and
 close
Date: Wed, 18 Nov 2026 12:17:55 +0100
Message-ID: <179500061658.273030.6545426361573791193.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118101901.253550-1-tomeu@tomeuvizoso.net>
References: <20261118101901.253550-1-tomeu@tomeuvizoso.net>
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 18 Nov 2026 11:18:58 +0100, Tomeu Vizoso wrote:
> Don't WARN when drm_sched_entity_init() fails in rocket_job_open().
> It can return -ENOMEM, which is an allocation failure and not a
> driver bug, so it doesn't deserve a stack trace.
> 
> Also free the scheduler array in rocket_job_close() only after the entity
> has been destroyed, so that entity->sched_list never points to freed
> memory.
> 
> [...]

Applied to drm-misc-fixes.

[1/1] accel/rocket: Fix up sched array handling on open and close
      commit: a23e1f240f4309013e8e7d877944748f24a64a73

Best regards,
-- 
Tomeu Vizoso <tomeu@tomeuvizoso.net>
