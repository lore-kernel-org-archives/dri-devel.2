Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C71BFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA0D10EAC0;
	Tue,  5 May 2026 12:51:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FkM5ZspA";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B628A10EAC0
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:51:17 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so2855891f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777985476; x=1778590276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FR+WVCt5YtrC7kGd+L1JfhO4n0BhVnLSXCbRLpHl940=;
 b=FkM5ZspAAVQrhlNBK5LW39u3X3E9gKRBxN3iUK9qG9nK0pZe9wlw5h9NGfTIHYoDk1
 Y5ySs+QjMCEQ7JdUSmj4rPoFuHa7SNgzYTTJLZCOqXeQFGke1cSaJxx5m4zkTJ2cMu9A
 1C/P0I7yy87sJjLtXWBnEWMNiIkpgC44Ph5bRuQPDtaihKbm/Gc3scozkChqkksp8i9e
 zR/mc6SZs8mJa7A4fvy7YwMT0Gl14DqihMwCSwAIXZyBawA4KzyonvuKBmxRmdA3z8On
 k5hfFXHXzMAjUQ8dSIARsmzkZOXexo9kUqKNn2tUu2KSi8WPe1Al/ZKOHfRdusvMFp7h
 XKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985476; x=1778590276;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FR+WVCt5YtrC7kGd+L1JfhO4n0BhVnLSXCbRLpHl940=;
 b=lsj+8cEVOtXR+Z9vJnw8IJWBfg/z5/uiwegrDUJ+LWrOgPugR1hWwgBXsjTOClZhtj
 wVVObapGGurICVXNOaO7A28wdLzCPmnQix8QvN/mu7hxjqYAFseDgxOLUtWbESnzXyLp
 mH0/9+Zsu/A4KLx+ud6JWWZJz4WGAX15MPBxTbR0g9yWHrTfK9oXr78ndXkvW/9PFu1B
 bZMDE6yRbxx2vcqbQXep4X9mOOV4CAF7KYdp1Bh5PVJx+1erOOpZkeFetb9zqWEEIWPA
 PO3Dw260XdNIgamqK5gg4rghgu1fwfGpXd1LL1IkMufFyD3TUo0vz2bLD9iLu86A63Bx
 eRtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mqKiNSEtY+ZNbm+pYPVufGusMX0p+BTJDinJjafFfIbqDHkBKBcBCyG36VQBRTzoA4vZMZc4lfsI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7bawPh1LdEwSKUrvV7QFWWE1ABnB/2HqazXfpIcHYt/H+c17A
 r4lT9iJLIUhglgdbeBqVU9FQillyHnXCMUJii7toc4zGYnjAmRACQ5zgHYjDZEMxtgY=
X-Gm-Gg: AeBDievdTmHn4ayUNwemwvCQqSdZlVSPJcC742DKUCo2fVlHyJyj+Q5dXMJbg3WylIh
 wQQzOGI+YW3aELMExRh3Avb/fh3VU6RvqBQOXAKb+SkF2Nlag9zDJ8PBnqckmzOAe6cEqMdy42W
 5Zz7bIhPyu1gFjiMkNAh4l3QR50fnldfS+Ci8eXo62an8vRPEEVceudo2R3/xCzsR6JPr5E8n5E
 NQqVaUBmcn2q3GeUgdT5oLJvbBFbS/6hFax5uhcL3hA3fqd8f2oaONFsq5pBLX+RCqPqdj3m0NP
 6yqS8LiV4QY8dXuM1DB46Cnwl5cn1liExAWw7umJ/ZdFVwHZ5jPFUDLtio2tXEhAWhrPgf5lVhK
 vvp1RY68hasIFbLFf+TUywFjH6TybveofHjQEOXp+3tj5QaMYxIT/NhzJb+RIh5W08IealHk1Hz
 eyuD4hn917JRw5f3pDBr+kX4bj98UfDoKZQiIXlkQ3ntvGv2c2S3fBLr0=
X-Received: by 2002:a5d:5c89:0:b0:449:9aee:4575 with SMTP id
 ffacd0b85a97d-44bb6c9fe32mr23917997f8f.30.1777985475828; 
 Tue, 05 May 2026 05:51:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f249bbsm3976785f8f.36.2026.05.05.05.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 05:51:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, mitltlatltl@gmail.com
In-Reply-To: <20260327021728.647182-1-nichen@iscas.ac.cn>
References: <20260327021728.647182-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] drm/panel: himax-hx83121a: Fix incorrect error check
 for devm_drm_panel_alloc()
Message-Id: <177798547497.553197.2173385549054375372.b4-ty@b4>
Date: Tue, 05 May 2026 14:51:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Fri, 27 Mar 2026 10:17:28 +0800, Chen Ni wrote:
> Check devm_drm_panel_alloc() return value for ERR_PTR instead of NULL.
> devm_drm_panel_alloc() returns an ERR_PTR on failure, never NULL. Using
> a NULL check skips the error path and may cause a NULL pointer
> dereference.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: himax-hx83121a: Fix incorrect error check for devm_drm_panel_alloc()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/50987d4e6c55929aa2d4d3976e74ccbae22d5017

-- 
Neil

