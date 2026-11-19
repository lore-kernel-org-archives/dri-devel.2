Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB960A2608
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YwBrSXlV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A3410E0D5;
	Thu, 19 Nov 2026 11:18:59 +0000 (UTC)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18ECB10E0D5
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:18:54 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-170135e43c7so3234628c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795087133; x=1795691933; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VsZrgdffbixcAT0MIaZMhRKdxCgLgvf8zPgL2cWZJCE=;
 b=YwBrSXlVIrg/4M0IsF/o/644LpssHtSgwggzQ2lwjfTu9ve+Db54qyOpPiBHMBQH4V
 D3XE4Xc4hP9jGLNc98HKuUCzPtoZPmMS/gCluk50zPdDmmOO+xTJoGpJspXIHrD01wbN
 WQk/DiL/Qp0xMNtFm77ylQ1gSjWLQ+9EfylJUrfx3U972xOZ8RG6TTiKyd6Q1WYhB+kD
 XtWPMZHhfuhaZIZ6vyaVJNve6dndfdKDyb5qnkwdixdHgHpHgsXkG5ZWhHdjUhqEN7h6
 VxdtY6F5jsHH8pB3d6vwD0WMSsHMjTZM4lqi5H0IL8qv3SB6Jx6fRT2AdUqdHxaijtPH
 wrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087133; x=1795691933;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VsZrgdffbixcAT0MIaZMhRKdxCgLgvf8zPgL2cWZJCE=;
 b=q/9XYhnk8sg9hRPj0EYu/k8lYqjPB5cHDIKjslgVK4+WeQAZfWZjnCisEHM4cBeHat
 89vEYofGdjxtOgSOAxTRNq1xFrMjoNXYKTsGhuDIHPXl2Rha4xHBYlysrkKDwrBGKc8K
 apuNJ4PVQdtKk0gBMEH/o1APP/cfNGnU7a/VtgSVx0Ho/UIcJPhiyL+uXVvUziFLLPx/
 w+iDth44u4bM/SZXgY/D/H7csUpdh4r3VkfrnkCVrkEsPn2+0+PKDVBvAAIy8a1YcacY
 Gk+bZ6zNTwKV7G5Y5lMS0LNeefdudMnbKcJ7Du26VbLoub0428CpI3F7wbhHvhVcLdh5
 j7KA==
X-Forwarded-Encrypted: i=1;
 AL+hErGU8NugGEX6CHsEVC64NOp5+Dht77RZQjSR9TRspZuaU69pm72OjEvnKLofxMmQYeamR1K88wMtRdY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9caOihgNg6gcIOzdqbDTv9RAWL60QaCadQiWvI8G5ervNPkJ6b
 LlAMAzkJcEMpOpSlmMX2W8Fr5Nq8npTWZwx96BMzGpWTp3IUok0Rdd1p
X-Gm-Gg: AYBFou0U6X4DBCFAgYBbr624RgcZI3LJu1qv+OGPF4O8Kkm1zcS7QUwjDt/vbZhvUTj
 kowuh8a5BUhHWn7I+UE+F6UbNTtae6OSOTl/VaU9FdsydttqxERJJmmjR0kQ+mu1xyaNx4UKAJ1
 n0MnoAH1ncqjtiyh5hIltoMCSqHyHYfIRF+uorXLIgAolLl1whlFpIAi7CAXzCD5oMgIdyvMgJa
 GLeaaXtZmCwY+enWmHNb2CxJ8ca3DtssibsILKUJ1lgTwMyezQ1VOPcqq6TgZekGyDAr3ZGEdyD
 xB4e86aWoUK+a7CFPBzk/G9vbmC8H1JW6rEp7oAiSVvRGwUN7XZEoRo/XBOUh2mUB7T5qFe4fho
 2R2QYhxHVslK+VB7L1cJVpE6DMWH9AsXe2XEv51SoNLQGWXa033NFLgO+HhP0fl+RDBD0H5qLKX
 F3VS4TuMlnnJxd5XutfnovA2SUcwwC3BGJTyt6I/SroYMTVWecJdIlDlJMdzmMSFITcBenXkzw+
 ENU07Wu23FLoVydDPGbTgUiBpLUTlOHq3zEQGXuFHrkeg677Vl9ia5jsJ4wl5TWqdJ85zDe78su
 M9V02VBz06lzeYRjpGNBBr0j7NCyNKiJdu7y+9siF+7u8TQpKgytKYEcJrrxyT6sTvqfQ+nyy3f
 Sv3IEWDkb+UQ+g5HYtPvkx0csJQr6nyY7Oi+YeGxOHmzosg==
X-Received: by 2002:a05:7022:7e83:b0:1b2:60ab:1e9d with SMTP id
 a92af1059eb24-1b543c3fb96mr6183656c88.37.1795087133021; 
 Thu, 19 Nov 2026 03:18:53 -0800 (PST)
Received: from [127.0.1.1] ([74.176.208.23]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5447dc5e9sm20583004c88.11.2026.11.19.03.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:18:52 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] drm/msm: release the cursor flip work before
 the KMS is torn down
Date: Thu, 19 Nov 2026 19:18:47 +0800
Message-ID: <179508712793.3615754.817569571407027777@gmail.com>
In-Reply-To: <sashiko-outbox-222715@kernel.org>
References: <20261119023604.1495603-1-shunsheng1218@gmail.com>
 <20261119083133.3437277-1-shunsheng1218@gmail.com>
 <sashiko-outbox-222715@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

thanks for the review.  You are right, and the check is redundant in the
current mdp4 code: mdp4_destroy() dereferences mdp4_kms->dev at the top,
before the new guard.

The guard only protects the CRTC traversal this patch adds, and the v2
commit message says that it does not make mdp4_destroy() safe for every
partial-initialization state.  The existing problem belongs to the separate
KMS initialization error-handling series ("drm/msm: fix the error handling
of the KMS init"), which was not merged in the msm-next baseline used for
this RFC.

I would prefer to keep this change focused on the cursor flip-work
lifetime; if the check is more noise than it is worth, I can drop it in a
follow-up revision.

Thanks,
Yaohan
