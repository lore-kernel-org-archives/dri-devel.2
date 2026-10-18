Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689B1CCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA4310E684;
	Sun, 18 Oct 2026 14:53:39 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7D310E17E
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 02:27:29 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so731236a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 19:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792290449; x=1792895249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JozqsIKkMBqHrYR/iY744B/gRgb58HZl9ElHUH2x8gA=;
 b=DbdwSwKdMF3ShUwUaNIwTGvsTVMwRFPH0Eyg+WQtniAnV2i/anRS74RENYN1bAme6y
 fwe2f7XcctrKVO9o2XJ97mIxVhDCgWaKb0Xc/zosh5DA26twFONRIuuTZa/kpL3hNlHE
 2HRYajeQLbWD/rI68sYM8TVKtCxQkwr4I5eI+TYKSHUObQJGvclJNWkdA+FnqmXukT8P
 34MLDevj/2T5aWrOOqa3PTsLyGvM65vVtnRqwXC//VbZi6G3cIJE1Qg8eHhvLkE29Wu9
 lJllNo8eXmEk3HzEkswSuNnHjg/SVtk8XdEjU0yFhaMswAm95qLpH8fUTViq23pFqJou
 wEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792290449; x=1792895249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JozqsIKkMBqHrYR/iY744B/gRgb58HZl9ElHUH2x8gA=;
 b=CineqJErzgktSTKn8r0rLPzl09PLGh/ByPTCcsYYUvSo10LU7Nom6DLFDNuY5unWX2
 vBgcAHCPz32Fbp7ER9bYgLIDuALyg0t5ssOU51BfYKgFyvxru55tcF2qcPfQrWC++1FR
 8cp5tUmCNCY+s16SEq2mT7X6EER7FdrwCihP7A9Ct6prqPCNDpp+9/yIxZCv19NqSUnw
 JQDuwW8PL7P48amqu4pUldBMWpSrJh0/Rl/3//gHw25uKyaRlURmo+jStRS/rQi44bI6
 c1UhsgqN+FfRTPqVKLwD2qdNPeJJZNhNl8QRO6VMVomfiWhlFHsgH4DT8X0Oc7KLUS/u
 MfWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpGK5g3lCZMgCGvHzOqCwAmgdlrqlLhWjWMMB2rAGnPm8Bn5r7I4RYdNU5a5SANwA5ZkMBcNqXt5M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKagbIoOnrfneX2S6qMu7WhpxFYHguTyxL/90DWOAX+UVnq5Thr
 OXSWNmrWUJuQHJ7uogXyeHnv0VtDnhDYC+6VBAVAe6KpH7VHk3GbAGT9
X-Gm-Gg: AYBFou0aBz8XW6V9NpXk2QD0K7UEZtybMlMHMdQ0cS4PbI4Hk12RDlhynUTEvaBd5cf
 GUPW6Mgnla10ZrkLk/RBkpStYoLmsZCu+74wi3GzovT2cyXlxy+E38labUvpildvGNhLqFER6qF
 ArP4g2HfmcAtJ5b4iP6hUPZCAlQ86XOF7vKEdVRuUsxc9VneL5fvqqvXSIneQjvH0oLNqz2Ui7o
 mLQ0daXeSan/nGqcsovR5++wyeLLNNfV7QlHFnFvPkORBOtJf1HJc6WRYXlDYM6sCKVgrqf3L+g
 Pyl3Mmm2Q7j5gPh2nK2AjHO24AyoELMKMtbCE7AAoTUswRaF8d7Z3ouLz0u6QmF9EJ+YSPZYZnk
 HefwFlNv8LL6a3z5UO2lDoa2vZjJ+SxA5DZwUi2SWehGkqou4ha2KdKtrUU9SfyrgCt62F9mPqa
 WQPBgs5eFtqbJQaLq9DVD0vc8q89qJ1kzNL0PQnej5JvPXQ4cl/Q3h9ct20NPap+Wbp2HGVqJwb
 1AqdZM359+OSfvGLr1hc92lvlxDPOoMgdGSKJQ4g2ACiN35kSfSEw==
X-Received: by 2002:a17:90b:4fc2:b0:3a8:5fd6:cb6 with SMTP id
 98e67ed59e1d1-3aced864c6amr3928931a91.0.1792290448831; 
 Sat, 17 Oct 2026 19:27:28 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::a891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f4cadsm9897014a91.12.2026.10.17.19.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 19:27:28 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: ruoyuw560@gmail.com
Cc: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ivy Lopez <skunkolee@gmail.com>
Subject: Re: [PATCH] drm/omap: check IRQ wait allocation
Date: Sat, 17 Oct 2026 20:27:21 -0600
Message-ID: <20261018022721.297885-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260606040620.13-1-ruoyuw560@gmail.com>
References: <20260606040620.13-1-ruoyuw560@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Looks good to me. Should have a fixes tag.

Reviewed-by: Ivy Lopez <skunkolee@gmail.com>

