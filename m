Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BFC606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MzbYg6+i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C46010E829;
	Mon, 23 Nov 2026 15:06:51 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CD6890BB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:06:44 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso41819675e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795446403; x=1796051203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EC2mcbhZaUCQFFpEa+7YYJ6zsvThGtcbiOMpvNNHs8M=;
 b=MzbYg6+i6IZWAWtfWbOrXTdnexNYyWT/bWm/zsunIHafJgtXajuDGQ0N17ZEy4Wgd0
 RJeAwWw+uboR+Ygdkj7ZPuaRTInj+m6SUyLCcHx8QI1KeiJ8VH0fQPxZkruwbESceijc
 HYK13MhkclfknJ4VX6LBd73E/2/iyBomGp0B/rLJK66LfN5KEDQ1cq9cHwhvVrPR9r8h
 8fD3UtS8XFtTK7fI+7PYrU1eOmT2VjNZPsIMdZBgOUySZj7kZluBT3ku2dkXAI7oV736
 vQeOEo7ME1emmkYE/D0sW52s9qnuEa6WimN51B5cXpbZ7516Ii+b/gkPxQCwZlO5w5kh
 bCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795446403; x=1796051203;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EC2mcbhZaUCQFFpEa+7YYJ6zsvThGtcbiOMpvNNHs8M=;
 b=hUOJOFXHKptym3uzJXLuTEu0QufWRueCbTxKv95+e4q2c2DxSilogSuwYuuq2veT76
 wPPqzLuGWFKoUxsfe2xOgr4za9YMRhIum8c+MLk68eRVwyyJF41aI3ZuoMCkztLMQXED
 DiWwnfARBgSpcElhfIS2VH4on/3DUT7o/El10xNahJ/jWPHmOUWq69TXwS6x2CHYKXk7
 O1t55H3HGaCeWppAR9raH9I1RndeBYq3Lu97KbzvORBMh4vp5t/iNbwQRseN5+CFdRmG
 YqvFTjdR2JVpxFwTwj5zGQDfixhwRTF6WMlAGCoGlxRgKZgc8+A9tWjN2yAcCYvRweY0
 ybPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGHrF33ISWccHK99TiD6Hbl14MCsg9s0dyb1Z/PV5xhZFtHEv5Qrsiil9XWGSmcQFLM85La6HR1GI8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+S6E4HWxetpkoy55AzfgR6W+IYe445D5adFAhFeLo6jSmC6k8p
 wuqK68x6x6Ru0tXcDk8LYt+uBs7JaDdQn/ijS1QQsvTR8MDGqwIOIIxK
X-Gm-Gg: AZFdTZdSK8iXB7RQXEMfNuPIZGozCl8wWM25GC2WL1K26zvMm6RzvqR+jwLPIw2mlfw
 A8Ggz9lbcHbiuuu/r6t1ibu2DZJVW8WDIy779TQuuJagA73un9FnuSt1hb6wpJ4JSFkJx36wfSc
 uV9eKb2aKEgF6/J7oq50LvbJle/zFpuUqDMm1tl9AJk2GMiqgJU4Ffq7Ix6W7KzKWLTaOBCUKfT
 JUIgnW6Zuc4l9TfXYXaR1ppkstAIuqrfL+rL38u2oEr9efUSW+Htac97v5Vj0SKb2AaCSNVH3ga
 4gsWZnGeUgHH/+d7aKOfvU4+Mwp4qp0SHAJM8PWF0PrhBWial1WYzisLIs58gipBNVVLbVbfoYS
 ohn/JYfyJ9u6FDeOUXJt0tyqvXwT5xEkjdUoz7x6spjj8XdpCMp/Fd7qZQM9voLPyVe3c4xMHh8
 EZXXLDnI+a6tf7AUI1ZFfmX1AkT20aTPPLCaZiCVKnOAW6DA4VrZfNvOdJ9R8gyu7SgOVjnf9aV
 4/FynInsyPU2aQONM2NVxm+7ykuqfR5TuXEUjgH30ZaFRwzTO1CjQu/1zcNDuleLBaC8lNz8Fhh
 zHpz5ZhWfjte9byhHM5ikfGEKYQf99k2yw==
X-Received: by 2002:a05:600c:4755:b0:4bb:7033:de79 with SMTP id
 5b1f17b1804b1-4bb8881dd02mr248093335e9.35.1795446402877; 
 Mon, 23 Nov 2026 07:06:42 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989b3sm22848177f8f.51.2026.11.23.07.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:06:42 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 jose.exposito89@gmail.com, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 llvm@lists.linux.dev
Subject: Re: [PATCH v6 18/43] drm/vkms: Introduce config for plane name
Date: Mon, 23 Nov 2026 16:06:14 +0100
Message-ID: <awRWEiYaktJcbFfU@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <18c7d8af-1156-4bee-be0d-f78334d1908d@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-18-78ace90f4fc1@bootlin.com>
 <awRQxKxzVyw10pFr@ArchOarora>
 <18c7d8af-1156-4bee-be0d-f78334d1908d@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

> Can I keep your R-by with this change?

Yes, please.
 
