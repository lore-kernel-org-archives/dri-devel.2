Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D537606A330
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W02Ia50l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E535112F24;
	Fri,  6 Nov 2026 16:51:04 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D31112F24
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 16:50:57 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so491596f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 08:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793983856; x=1794588656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IS+ky/vWC05xeihTw9LuH+K6BwhSb4C82XABxemvMx8=;
 b=W02Ia50l9HWPZIcYTmmz45iFH1dmwYLhw7zMF+zlAWf2pBgwgjLABRg/4YsefOyG+i
 049yK2BZjExqWIDQmXpe6wy3EORma7xMfJ4hbd7Ps392lufMus3xR4gx+O17WWBmkOaT
 bHkge1tWKjdgTmzmPlslVEscNXIH1U0QqzhOO1v4NDrJy+8felX7C2ABb6xL79261oqK
 JlQT3Ei8W4PCAIla7DapUN3YjZ6F+yYcvp2HE8PzkcDGjC4+F7XaIymBeYXVS4u8/Ss7
 5Dkpymm2cPdvmv2sD7FFrm0CCLCrB54aVMONcC/4Butm/ZiAhJvtpaH+BebxUFCGSvkR
 Nkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793983856; x=1794588656;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IS+ky/vWC05xeihTw9LuH+K6BwhSb4C82XABxemvMx8=;
 b=dKkR1JqN//kYQWgqIU8xBT7wq4FwHUeEi1dPpRRsZZiA1+byxtj0ZlRa3qO5rCRJQ6
 1XPFKCjJdBFs+wP420cbo5b/qp3e0gjtEqVmhou0RWLL22TEMBGZeCexCDhyQbHkdbJG
 iAY6je1HsOwycL+n5/fXNeZC9z48NQZDHAPs7wdzLSeHub/eMhApC2j3JSzt/x+Y0OEJ
 CLPQzhn3aKSCQYpGfVztJYAjHkkGY5OdtqkUONunHsLsWNFpe2dSLDFUlpnDGWGC4OAg
 Lwaj9s6rVQdyiDEsWLmQIvOtiQqagjeLUhpd2MXO5NdPa1EgDoTmRSW/Bkb+km+ySFiF
 0Paw==
X-Forwarded-Encrypted: i=1;
 AL+hErGQRvW4+YqcA9vDlEN75vXjx8O12hUkN4wDMYWOAfQjkHwHxVZP+/EYueUf21+qmxC8ZBFbO9oNi40=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9RAgSd6HhKUXBuylAzzoG5mpfrWEKRh2mgEDWa4FYcLUCAQdKF
 ac3jJEb1thu4WS54HgjhcN0gYf80yYIjcAd0pUuAZAaYlOalsvHXwWyu
X-Gm-Gg: AYBFou2CTTlW9vw4vgZYAGS4KkfQu1WG5V3i3a/JY0GSImN1zDfUWNc9XFobC9RLG5D
 VySA7fqq1MLbMUpedwY7UsF6teyDJXhsiFYXAJb3i4v1iu9GaAEUOvUU9rirNPQGKozV5BEks+7
 Q5i6yPS34Y6Y/zdF6sdDR1VmZOprOHme9lvBVfcLOlMN0bpiyN4EuWaxyT+Jd89FEquZmjNEkGR
 idyOkFvjLnffPLHPwtz5dlvAB7e9trHND1CqOzeGrr+kDQ+QgYQ4bJ8UKOjfZVb+cQHebVokZvb
 JZqDs5gb0ts9qmgDHnE/InwcrDDsdIR1p2UcMvEBaB1yZpE2FnGG0Xf1A6BjTv3/oug7ADRLXi9
 6p9vxTQNF6sJRThyL9WUv8H+IlyN1ben5PVMIcXj3HMhHDgkvSH5wpE1hM2rP3AyMdO/VR0AXOv
 GzbiZHOgZZTHlu2VgajC2uGWBf5F/o2y2UI+Jq5iw2VpN4ypN/WTc4EYRik+RnVjle1GA+h+Yrk
 iu8Hu1t98Gk72khpPkeRfuy3GLmzu2l51n3kKYJgKKUl2UKHDW3KlWDy10ahy0+JHfhE1BxvfBy
 32s21nvXYm2eaWpkg107w1IjuGLc0EXyshU=
X-Received: by 2002:a05:6000:26cb:b0:491:a219:8506 with SMTP id
 ffacd0b85a97d-4927863e2c8mr7103774f8f.48.1793983856073; 
 Fri, 06 Nov 2026 08:50:56 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d6d63ae2sm5011066f8f.11.2026.11.06.08.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 08:50:54 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Karthik Sarvan <karthiks1mail@gmail.com>, dri-devel@lists.freedesktop.org,
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Subject: Re: [PATCH] drm/vkms: Set preferred_depth to 24 for XRGB8888 default
Date: Fri,  6 Nov 2026 16:50:44 +0000
Message-ID: <20261106165044.540444-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <090616c5-774c-43e1-817a-20303c92a27d@suse.de>
References: <20261026071933.48366-1-karthiks1mail@gmail.com>
 <090616c5-774c-43e1-817a-20303c92a27d@suse.de>
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

Thanks for your guidance.
