Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D0606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0qdDWdk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CAA10F2EE;
	Tue, 20 Oct 2026 07:36:31 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA80610E720
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 21:56:51 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so6570965e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792360610; x=1792965410; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GPuST2lg0n0E0s++DBETZe7atvtvRXP9mMNzFPHYaTs=;
 b=i0qdDWdkxczdU3QnmxUsQOkEq6GqA313FYPdJF5MU+KSqv59YBNmq9HZHFm66RHCNV
 UwIemxQEQ7bsBF1DjthbDq456IhCij+U0dCl8Gc4tqU7dfCi/DuFuKCXL3H0HmCkP2WW
 2A4M9ObLx7ZwICOzqnfThAGjdbBfjn8G0PL7Fr/j3t4TzNF7nwGqZVbJBsiBmnPp6LYX
 gPI1R5GW4LvETHhMg+rsKUyEdFhz5/cIKYGfYVi8n8y4lANwa6ir3VjaqLIF3bL9sCMR
 kPg40KniIBNmKH87G8SEFviv17Me+L0HrHG6jaeIisOGS7cwXPwssdLeNWL3NMPsatAb
 32zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792360610; x=1792965410;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GPuST2lg0n0E0s++DBETZe7atvtvRXP9mMNzFPHYaTs=;
 b=l1iZaR1vSC441Qz1exM8Amnpp+aqxNHyXkItheKBw4pbISteLaeWuUs1gDJfPhe2a3
 eOM5oT0tuS63V1sgYtIaCbNtWOqyx+8eoisRBFuW79W16Bx9d5du/lcBPKQcy5BYDmtj
 imLblohoiGBzKT48i9w0GV21NruLap3oX5Jpl/4wBvPUj4Q+Enu89/srwaFgKueK+5YX
 /iunrr5k1bmKUk6Qmgf6M7RhOkz364ijxT4xxzXxiWjOkTZoJ+M407ppv96CijtZIxA8
 tWO2jKkAtdjuHONJwIIo8f9ALIpPifMR5tG7O6g9H2M8e7h1HJBwBRb5VngHGOIESN1T
 xirg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhfu6J+Rgvso8T66ugh974ndlcmKBoKw2xzzjvPhiF5kSbjNuOTzLzwFyCdcnASQOKYPJBsESbNHk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLmWACx5aS832KXNYzB8Gc2E22jJSnmYjWa7Pan3W3n6sxHsEOF
 5g9QJU1TiGITUN8gBbpVMhQsCDrWLyrFV0ZvABH1NJ0wXlq4EvF+qQCF
X-Gm-Gg: AYBFou0AkAIJ6no4bkROS2mRlq2x0k5KfZFv8skbSsWBHpxqWj9KBad+/BuEFijks/D
 1ZmVM3do/9O5R8LtrKJOBBgPzxFH1hR16YqPETkGX8yOgpqy6zXstaBUTWbBZVeH+tJ6b1bGkaF
 kOP0PQYZBL1NrCqkHZKw08K4/7l2/FvuMWRgRvJXPlN5ADBKSj1OwPJ97Ko5Iov5a5Zx9cbKxSj
 n/pIbJ/VrIqwBUhG9mMzMKGWA5EdVlyeAr/81YGqvQmr/lMFRnxGKqFjnV+kK9ilOr2xZgJHzxZ
 8GxYWqs83YIx9rWyRyC26qetpYZhpW7OvHr9/vZ6ua2UxeYUKIwc2FknZjlw+YIr5WQw0GxDu7D
 QJJOAB3fLgVPMMAi2QBcPCBXry6BcTz1fsAG9uptwI4YzETVFl9rzACOtZ7pV+ORfXK9nQs4QVE
 kunWe0NOH3DhwrFtIMBtmQyplTkpWnAsX1I+AhjEt+mCSzBLTvwtuFG3VgrdfZvbEeWsXKWk+Vk
 frUH1W+PBP1ojVzy82kRkI3XIf4JTTCbYeVRGJSRiwxk3sSEA+u/iJSb2w30rcx+uDu3hwlJzxO
 v3NJ/BviKUw=
X-Received: by 2002:a05:600c:190e:b0:4a1:90d7:88a8 with SMTP id
 5b1f17b1804b1-4a1d76106c0mr131795365e9.25.1792360609943; 
 Sun, 18 Oct 2026 14:56:49 -0700 (PDT)
Received: from hermes-agent.lan (228.red-80-29-82.staticip.rima-tde.net.
 [80.29.82.228]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm278449055e9.0.2026.10.18.14.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 14:56:49 -0700 (PDT)
From: =?UTF-8?q?Ram=C3=B3n=20Jes=C3=BAs=20Miranda?=
 <ramonjesusmiranda@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: sashiko-bot@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: keep vblank enabled when entering self
 refresh
Date: Sun, 18 Oct 2026 21:56:48 +0000
Message-ID: <20261018215648.1329624-1-ramonjesusmiranda@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-176261@kernel.org>
References: <sashiko-outbox-176261@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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

Thanks for the review. Both points look right to me: the self refresh
exit path in dpu_crtc_disable() returns early without
drm_crtc_vblank_off(), and with vblank_disable_immediate the vblank
worker can end up touching DPU interrupt registers after the last
runtime PM reference is gone.

Please consider this patch withdrawn. I will look at keeping the vblank
IRQ path consistent with the self refresh entry/exit (and the runtime PM
reference) and send a v2 if I get it right.

Thanks,
Ramón
