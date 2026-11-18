Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87E606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X8/VIIqm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39D310FD81;
	Wed, 18 Nov 2026 15:06:33 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C15BD10FDA3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:06:27 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so12178635e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795014386; x=1795619186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jHlByj6w46Y/+nbmYcY6Ogje+9NQ+ts8+a0iA/PRnf4=;
 b=X8/VIIqmXLPqrc8Bce8kTWO6gt886yPQuqtIr63mD8J4YGISqhv4JGB2I6AUxOP7N/
 b5P0UBjgKMbSJFsTpvKjmMffcII9/EAuUMkk4lQsf32tvKPiVB8LE7uQvkMd3iEgh21a
 UDUpPp/bgq2/qYhcZPhb1bNvw1kLdbzWUtbfkJs1VqiHS3saGJWTfP8iy3vdaLncWwYh
 X2vFi1JzGSAcE6iU8Cl27cmJ6LpfBATbPIp8xujM27Ucda0bVSPpfBZTcJdr+prU7nrd
 5U1/9yWj0xA8PBDM5aAHXRFeqLtC5aedyJ/0PPjmz5qUgjQRj9TVKgDx2ELGESwdstzA
 hr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795014386; x=1795619186;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jHlByj6w46Y/+nbmYcY6Ogje+9NQ+ts8+a0iA/PRnf4=;
 b=ZFRyAgi00R4buc/Px1D1Plv5MDTRSKrhq8h2JrCAv9SwkxUvAYwS3YSq/PuE8wIh3r
 duUI1c8i8xK9U6PgQSYasnkIOEfw7veAmUMCIsojt+kIQkt36m3n/ABum+Noyi46qtYR
 gh0AFVSTcYsgKlw+gV5NzTWPl4F2jGOsYsOr+Vt+5vrmqT4emsYD0lNl5WshFQMRCPhx
 qnodAHbFHr+xnPmT4jDWGaYSTWSY5t/xc3lpPTjJSuRYY9Qh08x18p/sjIh9X2TFcwUE
 98d+E8vSTxHFASKmMH6LHnO7LjSNuhvdeJVcX0WpgPeJNYq8/d0QzMkmMX9z0gY2/Hrv
 IMXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFIRGcS/59vSjbKvvS/irp/2oKVypWCSE5uK09lrmWCIUKelGIZ1VOaTxFeHkGb/mfIyLYILGR5El8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z98k6JxTp4pm4HMGyyqiWJ/rsTudRaiQpSuYNRlQ4i5zptJ0Dcr
 LfxzZYw+8VpF+DhGssJ44xMA89GEiFxgS3LR099tr5fbtKKTDMWWEKKS
X-Gm-Gg: AYBFou3ohem6NVuqopaEsazNHyNra8a1oFer78S2nNrdtqiZw2VRm/mEDF68z5NcE4y
 Ezi83NZKnpj1HokIGW1VGdvFfgCTZrZcFf6CtWYGqGDgKZFkNh7rL38W6Uc+ntz3ve1MTcet8SI
 ELAhaEyf4bRP+w97vOCt2lSQg7+9QA/L/08JCy/ivllIu57LT5cMmTbRsb8Xw1kD6+tiqYhsZG/
 +zTUxGTChZSThjp46EuBpUPyptNrbQAiJPABkHvDjLK021ViQ2T/EaOLdMv3A2VCNkpYHess0tf
 A7JK317pvSUrHf6Q6yKMYWIk8ikcUs6J20QIjOwHyK7zcBUYrEV3CgQoCRO4TbAFaAjMjFhrN1O
 T3adwP6gQNMu71cMEef6ShVf1iTLbvIQmWQ3GVU34EWw5jX0gLtH63D+lj16ZpXIKdJ8obw3XOP
 pKdzAEhvX8Fc5wp6Osn7wsIEeKCUi7BehLg16NmHt6TN0RqsKbcK/4OCxchnfU56KHF6zcoWjCO
 lQx8zwiUYnR4N6VSOXvRrLSU7f6+qyTxy+GstHNkgx0WLHM750kuMqJ4KXK8UiH9nbcZalGFdaH
 Q7PqY9N5GN9y25RW2krREpvaH0CxlF5Oeg==
X-Received: by 2002:a05:600c:4685:b0:4bb:5f43:23bb with SMTP id
 5b1f17b1804b1-4bb7da5a6e3mr53477425e9.33.1795014385984; 
 Wed, 18 Nov 2026 07:06:25 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm164487025e9.1.2026.11.18.07.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:06:25 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/vkms: make argb_u16_to_RGB565 round resulting
 values
Date: Wed, 18 Nov 2026 16:06:15 +0100
Message-ID: <20261118150615.722935-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20260928005301.367977-2-matheus.aalmeida@inf.ufrgs.br>
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
 <20260928005301.367977-2-matheus.aalmeida@inf.ufrgs.br>
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

Just a thought: DIV_ROUND_CLOSEST() would be simpler and cheaper than the
fixed-point path, and bit-identical.

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>

Thank you,
Oarora Etimis
