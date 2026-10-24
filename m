Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE3606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=swytaTTo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F40710E1EA;
	Sat, 24 Oct 2026 22:59:02 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94B110E41A
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 05:20:17 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e9f6a16aedso9691345ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 22:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792819217; x=1793424017; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4GLuOUeqEK6qd9I17ORJDYTZ4CpL0kgFtBJTA57pHhw=;
 b=swytaTTollGa2rCpXofvDEaEtcuMUjzY2BaZPq2TbIBWvOVTqUuXapFYGO1dxFcL+U
 ctllYFYe1B+UQ9glMwazUeHXJTAxmfS0fzOlQrqqmxLDC/E9RrUVi3/jGPMyF3UK0wHa
 nejXkIGC326ktUh76chRNDflS0nx8y99S82AD+mXjgcRIVUZWtElHcZOp308X5I4fKFF
 fwxXpq7R6FFMjcSvh1p7C3EX1Cn3gr0lPMHDMoJ+iqr33CR+h4uPNxHNH33DCwT8JG2M
 7FfHqkF/5wnLlcYcetaOdSlBXbBMhTCciXXcCNeuO3AkbYsZDVZbJv+KqLJZwgZQeXVd
 z2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792819217; x=1793424017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4GLuOUeqEK6qd9I17ORJDYTZ4CpL0kgFtBJTA57pHhw=;
 b=TNhUXdFjEb+l2RzWL0ZjlRRPxZ3QOwska2BHZ8VjLtfe5B0XyW2Z8aKFdIXjlD5vGE
 hY+7SF/x2m+U1TOZXQ3l/vL31gtnOYLi/rger6g84F2dOqDDrYLHXdfQdxljehciduNC
 +9ee8d5DcWyYpv7PNBHgFaszLK088V6W8iPYzd5prH3nRbHseciHWCu9jWmOXidLAXtY
 1msqNKyLFlnx7izNnHBI9ik+Qt7tRsknt+7bo8LGBz2pBpn8T5hMccb3m8m4/cLJVfXQ
 jopBxxZ79unTeNlvfmRe/HxPUqe9HiHcYwnTQIdINrSlCuwI6ctIsJQLKHshsB65WjoK
 JgDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAl0zcL5KvPhxyQEoSRICfh24mOfRdsXus6oZ8b9EUWtju3pd4HnDQN0p09nTGSWRMNakIoW44F7E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL+DZJNSwod6m57LstuYjNkX5qLHavihAdpmM8AERnSW5Ev6ANR
 PE6H/1HY6+nec2KEFvzZI2157f5xm/jjHAuySZs68gTD7m2v/rSUf3dP
X-Gm-Gg: AYBFou2sZAxwAN8tgy38xNkgIPNo2T4wWaq6pH7Xqb3arc2FGijmTH7e89kb/QVKD9m
 NKFvHouEihYhe8zn0zvqDyX0jHwyw7qKZ1PXm+DvYa6erdgmfd8FEcLzKZptchLrFMvFCff87cO
 hh+qXRcs7c678wCXSXkRv9thI5TBikIS7/oIQieoH1MKvsc/zFQPvFoQ06Ky767C72oQH2Ff5dy
 cNkIFJQPjgf7rkJ2mkYEbqbc8NAWAnE346ATCFoB9dwVoB886X+HApJHjsZCq9tf3YH/Rspl0M/
 NBX7rPaxBlAJsoQtFDowiVqYGbt/x+furBHYR73+dVmdp5zkNfy3yQEh51moxgK04E4fKuJNksB
 cV7giYL78Ih75caVuW56bNwQozEAErcDae03Mqq2pdFzVKGFd+OJSzCcUibL37u1QFHkr+vhOZE
 T2rMReQqwlhC8LgCLsB1Y9UJ4v0RjXFzezNZQROTrtAdcBcZlSkBKAhTDE3oSDFTlsY/wxL5Gp+
 VkpEaUW2Rn9MQiAWfMo+tjjj2Ji5FaUhRgWjZVQflVh0SmaDxpm3TpsMIFylM84AvtE3Rg=
X-Received: by 2002:a17:902:d50a:b0:2e5:54b9:6b5c with SMTP id
 d9443c01a7336-2ea9c66bb6emr9292565ad.20.1792819217100; 
 Fri, 23 Oct 2026 22:20:17 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b14c30asm2701535ad.36.2026.10.23.22.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 22:20:15 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: Val Packett <val@packett.cool>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dp: hold one runtime PM reference per plugged
 state
Date: Sat, 24 Oct 2026 14:20:11 +0900
Message-ID: <20261024052011.1358-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <c1f5b813-4228-42ff-94ac-2ea6533328f2@packett.cool>
References: <20261007155848.106-1-26rote@gmail.com>
 <c1f5b813-4228-42ff-94ac-2ea6533328f2@packett.cool>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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

On Sat, Oct 24, 2026 at 02:58:25AM +0000, Val Packett wrote:
> This part (msm_dp_hpd_plug_handle) is now also handled by the IRQ_HPD
> series:

Yes. v3 is on top of that series and keeps only the detect() part.

> * if we "find no change while unplugged" (!was_plugged &&
> !priv->plugged): no drop, is this intended or a leak still?

It does not leak: the existing put in the "if (!priv->plugged)" block
drops the function's own reference in that case, and only the second
put depends on was_plugged. Agreed that this is hard to see from the
code, though.

> * use a guard (probably PM_RUNTIME_ACQUIRE_IF_ENABLED to keep the error
> check) for this function's own reference;
> * and use a plain get an extra time when setting priv->plugged = true..?

Done in v3: the plugged state takes its reference with
pm_runtime_get_noresume() when detect() sets priv->plugged and drops
it when detect() clears it:

https://lore.kernel.org/all/20261024051952.2006-1-26rote@gmail.com/

Thanks,
Joonhoe Kim
