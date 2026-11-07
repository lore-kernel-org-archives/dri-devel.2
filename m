Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705C606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KeGog+IB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDBE210E5C1;
	Sat,  7 Nov 2026 12:16:25 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FBD10E5C1
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 12:16:20 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso1053553f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 04:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794053778; x=1794658578; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OJxe+L81yP0ZTM1ZmFPQhaTs3ZB0xTEsasaeTWblhVY=;
 b=KeGog+IBSDSTbCg1P5tUKj/KmyFEGFRo3YZRY1rwJteQj8EFtInn5qOe3KqiDeseVu
 VJtzFLVqsSX07craiYrvK7sBACm1Ato3lchv5ojf/2Z5MyP2I+PeXWgHeApN62lQGTW1
 PutyLssVe3LiwJ1FWMj6dFtq7oz8HmZWU3EmPo1BjO7Y7oWkSnKHMEDg0P4P7XSYfWhi
 bEh2qKYalpFApax3IJg2WMFFOX96RKnvDnX0ENK0TOyCOwEIpGo5W96GHfxqNL9KoBSK
 N6n2xJz56GiEBncwYTO8BBw4SdzZ/caLCF4ByUFNTaH7sZWg4g1MyLmN+19tDDLdG2pG
 aPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794053778; x=1794658578;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OJxe+L81yP0ZTM1ZmFPQhaTs3ZB0xTEsasaeTWblhVY=;
 b=xF/6tPNVB8PAWdfNUNgAQ5pALty+NdpyDAOZk7KdLwlC9PrTdBzxYiA+V8laZoLf53
 0MwZFRC2WOni8apTH29uKfoGsoDQ1DeHrzIXdWtXgILy3BeG7IR59h7nsDwJtS7YDPqZ
 W9pMPq/2XbQqY7RNSTGZrcWB9kQXWizwv6N4sk6pOj/HI8i0UwCYCxkWEQm+19ACFeXs
 xwlMPhqm7ZLM6LHlbLze8trLSt/a9Tcu+XLIRtihrDDR99sEtfmRstXD7KqGG/imCpNM
 UvNk5iuVxwkvFfchg+f4nZedU+nZ/OC0G04jgnaU7ccMM4qO9uXxujEJn/jYFmxrLbCf
 EPOA==
X-Forwarded-Encrypted: i=1;
 AL+hErGWPfx5lf5mJ7Ni74o77zpqsWL1eYA4hEbLxNQ5RQunvgVJMk0QUGd+eQ4xPayegBKbNjaZDE0Oh0Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+9Czb1KMyReq+6f5G6Iq/xG9Yq0Wl0nRN8hiXdARznBnUiz2cc
 ZCkHJfaP80tCh5IMjVVJnUu6FoIaKkgHCg2XkZqYXEcZF2Exi7i6HN9q
X-Gm-Gg: AYBFou29To7fvxJGpsgg8XXh+imaO0KggOTIwOZmbctFKzp8f7w2fZL3g31t4g98m2S
 s31ORK43nPDlC/vF9IMpPiIqI2uM2PDRDen2aV697P9DDHQfGgyKTIo2eF0H4EFr4xOWqWIkLW6
 umHXO2qpvIKGgZ3Fzwb9edq8nTryWibUdlZ2b0b1OGv0MDcthHjloVPDv34UiMwPo+2vO6huQ+S
 H3rj8/6wu+KvI6EELqD72aL4Ji4Qo+3zqBovPBz5t/3cYXtk31T4X7DByQ6CkLhb6GEspHgrPNC
 qCJLp+OhrWCIOlSX9p++oTnM8jBVa9z2Dut8w+IvWczJnoXKmu3iiluv8Z3A1vrwaf8Y/qogkUQ
 fvXOXZa6YoRuBF63t9B0zx856QkjolBH+NUja75vuIzH9iz4P8jh8pA8XHGM9PxmfrG9s8EqupC
 8gnWB+c0tPRortiDjc9qZGMgdwP+n0+VoG6Q2Pxae4fteMni+RScJ/dVDhupV2wel+jbJHIcCvV
 pkNbnpJ2BV1U5fnGmxPpzmdeyaGXoG2eFwc2681JFw3oYjWrMoC9sOkEF3tTmZeCGBbe0fMAdMP
 EMSHx+FqckPZ9cfwsir+5pTArof02N/1uQ==
X-Received: by 2002:a05:6000:46d7:b0:490:50c1:f352 with SMTP id
 ffacd0b85a97d-4927721a480mr7374012f8f.39.1794053778032; 
 Sat, 07 Nov 2026 04:16:18 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d6d63accsm9569485f8f.17.2026.11.07.04.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 04:16:17 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniels@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 =?UTF-8?q?Jonas=20=C3=85dahl?= <jadahl@redhat.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Simon Ser <contact@emersion.fr>,
 Victoria Brekenfeld <victoria@system76.com>,
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/7] drm/vkms: Add driver-specific plane property for
 testing
Date: Sat,  7 Nov 2026 12:16:08 +0000
Message-ID: <20261107121608.103951-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106-drm-reset-state-flag-v8-7-50fd046b705f@kernel.org>
References: <20261106-drm-reset-state-flag-v8-0-50fd046b705f@kernel.org>
 <20261106-drm-reset-state-flag-v8-7-50fd046b705f@kernel.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
