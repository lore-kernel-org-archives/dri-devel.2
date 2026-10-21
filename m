Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D2606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kh0AeHw3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAC610F822;
	Tue, 20 Oct 2026 22:50:36 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A00410F7F3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:50:23 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso403365e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792536622; x=1793141422; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s0sFZviiuD58KoKuefE1C//igVvTgzZQdIYejlrorjA=;
 b=Kh0AeHw3l5pP0V+E+l7QWxzNn6U6CJ+Kkz3oAbKJjql5umNFBuenIp1e96S1Lv9HfS
 CI0qh/P7BnE4OZogfG6/vOk7DNThoaCDFwcRBDzR94X8I6eKxGDQwwwWIMdu+0CYFx36
 Ht68auw6Id1lgn8m26i/hZwTAEFhgza9oIaxeV6pE+SLTaIlEgYJ/3L77/vcAw/6Talk
 3A5Hqjp/aOH7sKZvRk676yBES/ao5JhGwJfP51pUEo2xPbdi7RuZnahymf0OqQ4fV4ad
 BpYTggkElYpp00sdZZAJOftBQMPAF6KEyCu2ewoE0NeGkhMNHrHx7VuQPD5uVUdjY2LT
 C3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792536622; x=1793141422;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s0sFZviiuD58KoKuefE1C//igVvTgzZQdIYejlrorjA=;
 b=Qyh+JvzYq9Y95Ryhi3f63lSxfaM4g6xfcjLkUJFNt8VZm+1MB2KxR42/ztKWw3ZtOI
 a3q9gR9oN2iULj0/57AT//oTVT0APp6waDQyHyzI18jNMo+GwRZhrhho//oHWYJ4orIo
 ZuenJX339n9mmMSxU4vuPG5P1pxa8v4wqscKdqktEbmDBNAl3x6R0x99MfMu9iNiVWcu
 s6v8iFrK5lWBXW0dem56hgxH0prOfavgWBVhKQ/85TeDJilHXioU45QxF3hEf0XnFaTo
 BCZ3tEmNF9zp2MwJljqrYnFNbS21cIcFO19r8nbpi+jjE/3PxA+OOxSUmqcDnks59pvT
 QLmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaorfn3Vng5NM9yCumRfwM5sVr9LGVkhiI3gWHFUWhSSiu4l8ycKIGFzgSS2uk32TcRScZXYVMF5I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLSWCfuLthnhove2LJgrfuLFZxoLWa/2mQ4G1S8MzHgD7ljjVje
 iPXIzddmkcuvqsMW6LrBvQb3Rnjn48CiN9muCPVNLckiW4fcz9QoliCZ
X-Gm-Gg: AYBFou0aWaKJiyKSvWCWOgLhZWyCOAn99T7RPYGcVQqc306LtoAxrSLpVKw20Tcc8NC
 E/yjLf7So550bT5UlNp82mLbkjWMPsvYCk5zgidXjzlwB9+WEaWpezSwNDo9Wdugp4yg6dXvTFL
 NYPVhB1GnJEV+HLKj+3XtraI6PYjAE1/bcGtfVYp+E1//WzC+nVZnDjGFKJ9QLEENFW1sV8WnKh
 dJdP1LrpVNelLPa9Pj01b0fdC+XIdNh0vVl0QvtErZqTnHoP1Zk5VY2ljXZyzGheSZ9UhNTx19n
 CHj+1DZN1L1rAzMAXS9Ttsbv931y1OIHO1K0JNRsAAtXOQVptIawAtH8nc4GqX5x4wQRhn3AvZo
 IZ+AbKS7K42qbCAAdLIL54WuX38GsgPqf7SmzXlON5jv/l6lki93HEvoOCogikJ4pdik3QmHCmz
 l/hwztXTztuia5qc1iBypZJEQaSRKyv2fXbBOHsi8EvpRxs/gWBK6PZuUnwfhKOw3ftmuywXWFw
 bSCpYvF0f/lC3M3Lb4lDVaw
X-Received: by 2002:a05:600d:8646:20b0:49f:bd3c:bc24 with SMTP id
 5b1f17b1804b1-4a1fdd5b101mr1644285e9.31.1792536621644; 
 Tue, 20 Oct 2026 15:50:21 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0b42bdsm17511805e9.0.2026.10.20.15.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 15:50:21 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/13] drm/client: splash: prefer what the command line
 asks for
Date: Wed, 21 Oct 2026 02:50:06 +0200
Message-Id: <20261021005006.2341200-7-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <45b55f94-0cd2-425b-b985-ba3958502b06@suse.de>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
 <20261013093243.505776-13-maximpedraza@gmail.com>
 <45b55f94-0cd2-425b-b985-ba3958502b06@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas,

Am 20.10.26 um 13:26 schrieb Thomas Zimmermann:
> Please see my earlier comments on module parameters.

Same here: my reasons for keeping these are in my reply on patch 3. If
the command line is not wanted, this patch goes away in v6.

Best regards,
Màxim
