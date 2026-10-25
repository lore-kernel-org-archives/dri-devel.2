Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62B606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U8HFpFjY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905CF10EC47;
	Mon, 26 Oct 2026 08:36:44 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8786510E0C6
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 12:53:33 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso17599975e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792932812; x=1793537612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AMW1/8fX8Atf6UqsvjpOywQP22hAnwECitMY445RWYA=;
 b=U8HFpFjYcae/BqN7CQvuuh2jFpetrbiNWHJ5PMTGlrsYmgQKDA11oSBELmMZPWFNRZ
 7snGEfr1pIOGMNvuZHSs/5PAmfUjAaAbS7vOCrob9OPQknN9vFKeM/FegbLxs+VTUnqt
 f6dStfhdyzQwaRfLtU19vKcbEbg5fpxIfcNwUk/chwdLQ8c8nILcuqWPiiY0ZBgrXqeL
 wAO6QordkGZZ+tDglSc3nKF4zNs/jHhf1+GC6nH1MwhZOqMtA5maEQITYqpA62ZSZ3Ik
 qtcqtWSCJ0q3UVMIqofR/O6y83eAC0GdjFxykpbWsndFBZtQ31yHGrNTUlJSWcNqZE/D
 Bf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792932812; x=1793537612;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AMW1/8fX8Atf6UqsvjpOywQP22hAnwECitMY445RWYA=;
 b=USp8rKCKZA7WMbBugA0U3V6UJ2XZSFERoxkaf0zKrxKb3BFzBXWmUOui4g18XV0Gxt
 53IgUpbIoAwm75wB0Q6zxKUzOeQnoIaqTbNWzflDVt9kEpg/+0uk9G2NhaYNUoRMYbnv
 SeOjbVmONlAr94oPtxB21Aktspgku3zdgLCbjZTjU1GgScZnowIVT2xGHMUCsR09UdX0
 b3MPXxDos6Xx7lHv3vJWqy37mRGiMFIhsJ1XuotiJRLpMSn7AVtXwedJ7S9dMmdZOrLq
 vl95pXT+UmgbYa40T2qQo699/ymtv2SUudNBq4hdT+f9p1x/PQKuPQaznzleTlUozh6l
 33bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOj/azc4YdFpZtiD2aIXKd0Klr8Q3MoIAH2rDwJSvqk6SGAZgG2GYzJFTGskq+vGTnINuD/kk5Fy8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI9YDrHTDrsJYl48D250v41NDljo/4HpMWcStmqSfUylCkzptKE
 dqHlRCL9calgjDS/HJM/gRzRmF4xjiDulopvvSO6/EX2dxMYznkumn3R
X-Gm-Gg: AYBFou2+/GkHzyQKOoHEgI3GIFeIbYI2AEe5vCgdL77rFUk0nJAYMq6BloEuyEuJIz9
 ZB8FLph0xsWZ4+sSRaEFju/mO7XGcoP3bJ5LLMWVaXGy1VlZtHpt57hcShrBOgEbCMWW2uVcZxp
 19t4hcnbKftV8nJWteLk1Jlsan836pKm7cO820pbbAfFr8MY/2F7sD091YJJfE6zLIueWJ9ZRqB
 ZRKfxfGzvBliGRm3+OwR5M8/pFjzpTbHBPrbNImqE4dvXU2bZB4hEa3UJkIYWDks8mw56psaN1R
 2wB5w59Xlzn+8mqggLFn1LKnT82yq11ZVo5Nn+y/v+GG7w5DlD6KOTGNAl8sx10BMEgmxm6jNql
 +VOwm7nNtSPW8W1LhnED2LOrQKcu6qnUbtw8PwaRNf+RWQPiTmmQfT+VSt4CbeakEC0oehXVhq3
 UkNat5tIoCqsaQ94MMuz/widr/PEJrCXO+6rL44r0ZBsZQsh4qod2PZ5rHlC8+x6w7mbyJ9M4QN
 6R6FmFk3F7cU6+/cgr4kkpTk7GvdmzVpXcdrmN0KogoTXyOjsaLYlB5MFdNhaSJR8lh08NjhS9q
 rL3mQj8XWjugaiZBqst4/3i5Pd9vHZhnvSu5sVjpNE6SU/2zQ5us8ltuckwfNP9r4G5e
X-Received: by 2002:a05:600c:870b:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4a35ac95981mr70164175e9.14.1792932811603; 
 Sun, 25 Oct 2026 05:53:31 -0700 (PDT)
Received: from hermes-agent.lan (228.red-80-29-82.staticip.rima-tde.net.
 [80.29.82.228]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece14a1sm10240448f8f.57.2026.10.25.05.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 05:53:30 -0700 (PDT)
From: =?UTF-8?q?Ram=C3=B3n=20Jes=C3=BAs=20Miranda?=
 <ramonjesusmiranda@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: keep vblank enabled when entering self
 refresh
Date: Sun, 25 Oct 2026 12:53:27 +0000
Message-ID: <20261025125327.208328-1-ramonjesusmiranda@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9ee7225b-588b-4253-b766-5e6ee6dffb04@oss.qualcomm.com>
References: <9ee7225b-588b-4253-b766-5e6ee6dffb04@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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

On 10/19/26 3:27 PM, Konrad Dybcio wrote:
> FWIW this is not enough to get self-refresh to work on the Glymur
> Zenbook A16 and the 8280-based x13s, the screen stays black if
> there's no updates (it worked on the latter in the past). Dmitry promised
> to take a look one day.

Thanks. For the record, I had already withdrawn this patch after the
sashiko-bot review (the self refresh exit path, and the vblank worker
touching DPU registers after the last runtime PM reference is gone). It
was never meant to make self refresh work, only to avoid the atomic
helper warning about vblank being disabled on a self refresh "disable".

I have no fix for the black screen, but I am happy to test whatever
Dmitry comes up with on the Surface Pro 11 (x1e80100, OLED eDP panel).

Ramón
