Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C700606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vJ9A2SeU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7996910FC7B;
	Wed, 25 Nov 2026 14:29:20 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D768010FC9C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:29:14 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cdd8c20bccaso219757a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 06:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795616954; x=1796221754; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q9A1YCJDeFFdwzOmsp81thQgAJqEwj7kk0aq3hgQikM=;
 b=vJ9A2SeUYyiaeUZIIIx3wn3O7lO8xABABgQZiSLc970ee8/d0mz5R9bBc27papMcB2
 CT4hc3+gUsqYVmROK+bqPy22mWmqv5utHYuTURAAOFJgcPHwFigVyo8jxQwCMl8AjpGp
 Usylqv5LATxRSfRGvzritdbxtizhVCBXVZoSj7m3TxQB0NFoIr+rscVM7DK3Lp9Efa+f
 7t68y6i9f+kSvfn8zkcyJA9dpkzjTvAoxsScjY+4hfnEPGJwbPHeymyGtLYhWCUtUMAg
 h2WRAZS79zUn8wZWSviLwSLpvnQaNyPUXEF6VOvdI5Z6J3Rdgxi9J1hEWCxlxZMd8j/k
 7ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795616954; x=1796221754;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q9A1YCJDeFFdwzOmsp81thQgAJqEwj7kk0aq3hgQikM=;
 b=j2upM7/0Koap3J4eWNiqULFm3//CfxvgSn7If2QbpVtUah5I8QqmQv3eLNEuGK2QV3
 D8DR9cB3po5Uv4AFQVX9tDif6Ux1agd9FnKUYx4xXqSlPRHUqPkk+igiSiBCB3T3OL1R
 qg4TIk7elm66KRtpb6FmReCQdc12u6ZOGg2kEm36tx7J/71ARFmAcwztHSWY5jpYu0ur
 xiBPC9OSFhmfERKKEsv5HmUKbxo/2UWtCLuyOBgWilx61j/ILf+VSjkIVLX4cj4Mi5qJ
 PIN+GZk63g7oMAOjLTzUs+cG17ib3jTDAbSwzPT/VfK2oy+CLYiuQd4rQYluj/bubssx
 X1AQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGUnZHuzRJ/R8iXNFkV0QGZNXLPZA7Lk+K9nwT4I2nSa2/uPAGc9cMkCRLB/iOFZ+JL+gAj/vS+tlg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/gSc1NIl+qLcLjIUwQlrMSxW3aJctjQzGbuTv1T9RgD3wBAxOF
 3L6RgtK/3AnjSbA00LHcEO+OqIVETaDg0W7ewH/0KIb/lM1ld9I/mMl7
X-Gm-Gg: AZFdTZcGqovYLRFadSJ0duO/oh3czs39u23H+fVR4g5VY+P4YK5Rx10C+BAVcjc+JjW
 W9FZrSdR/14HF47bkZXgIgGOvFoi+U23uP5aEq23wecHw0w/4UlafK6DXdNin0adand5Q9xQOnA
 FgfpVWfu1Af2iJXsMCwntApPBB0O4FzSCgxpygk1gyEFg/ZoKNbDW/Vkz3zjc+Lwk3KLlsQSTuI
 sUoEo8FLAwLH5XFPBiJclWsqgs2KSHW7lPGGkx1btA09Zh6ePXHYoEgDTXcNtWCPXK/sB7V2dAb
 CIIb1rk71Dc3fKvXYxiyjKjyw0svGPwfe8dWQw0jNwmux60622zNfFX9OzHyjYKv9FXFn1o7bpX
 ZVCNWZCRRFp8mMiuYUKBNsewNjCACRKnMJh+Bdg3e6mg2s/Hft7dUIL0xRjLvjTrRbV9RD3e3Hi
 0tRIvMXYG5E+S4RFS7EJMnL5mygng34CPAED9aqnuIgK+QU7eP6M8aKWDw/oYNeIwQ0vnI9gx2B
 nQSeRlk8k433+ztjtPauC3En/bhT7uGx0vHTKSxZYQFBC35NIpIS7BA6yPMhcSbXWAkUBtipVYQ
 V/2f40Y0XbOCqLLo/RHLMZY6Hkc=
X-Received: by 2002:a05:6a20:9f08:b0:3ef:2f72:c7e5 with SMTP id
 adf61e73a8af0-4014ae6fe31mr30706224637.2.1795616954301; 
 Wed, 25 Nov 2026 06:29:14 -0800 (PST)
Received: from marchy ([2405:3800:9df:1a8d:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c873f16b41sm9085822b3a.56.2026.11.25.06.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 06:29:13 -0800 (PST)
Date: Wed, 25 Nov 2026 22:29:11 +0800
From: Adam Azuddin <azuddinadam@gmail.com>
To: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] drm/tiny: Add RAiO RA8875 display controller driver
Message-ID: <awbwtxoToNU3GEcc@marchy>
References: <20261110130515.45819-1-azuddinadam@gmail.com>
 <20261110130515.45819-3-azuddinadam@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110130515.45819-3-azuddinadam@gmail.com>
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

A gentle ping on this driver patch. The DT binding patch has
received a Reviewed-by from Krzysztof, and I would appreciate
any feedback on this driver patch when you have a moment.

Thanks,
Adam
