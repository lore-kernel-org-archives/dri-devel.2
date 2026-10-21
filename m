Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7812606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LdeRx6ev
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275FD10E1D1;
	Wed, 21 Oct 2026 05:59:41 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A39A510E1D1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:59:34 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so170232f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792562372; x=1793167172; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7wvxYM7tnszHbpN8YPIatF2rX8H2hfZfH08DLyoi0hs=;
 b=LdeRx6evBiRGewlC9+nPuHFGdVP4ZXVD3xYnKVdOKZ5fZfZqEDjx8CyQiLkK2GTEZC
 iraGM+mrn/aZgV7mrXjrPHI8dDbFNT8Ysfc/WEfWd7Sk3mX7BAa51hINjarqNTvCRnBq
 TjxXqqfWJ/d69/sPQhCxrKkySSZVaV2USeXhyrTiX3kPy9kfacx8sxv6K6JaTRJEUlkH
 OwzBh+xb5pNnxq/aC9sz/cHVu82bDQ/uRI+1tz8ITk/g25KbVzt9AFCsflpfVfqZ/p75
 oyAQ+QF7gssbzWQf2LciotGfJleOPcfs5ZWs/cAH/RgZl9kLgui7PfbooYFCyhXL4GCX
 edDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792562372; x=1793167172;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7wvxYM7tnszHbpN8YPIatF2rX8H2hfZfH08DLyoi0hs=;
 b=oZY1giKzRRb/B2DQpho6+14+eRBCtalwTfLJVDEQOyAXNJ8DGnZ4E64jfoqWtQzX65
 CqSR4/9K1dOnz7RqVfz7wnRpAWjs1Ty/NVJWgKBk0OtB+B3kfZoJyHGz3DSNWzDNmT0k
 P8X9nvz6Kqq8hLu7AOJspcpLsitx0r/LymPGKMk2xPqcP2PiantUzISYeuX6/kkXmMJi
 Kg6gEkm/4NEJGRjOMoCXNs798jgKSAofZ8QosMLDbMWycuwGbm5Tt/QYEJh8hrbpcV1o
 yaGEAgYEQml+JuJPl6bwS3BFAdII+7ahKqwnACxV8sdQG6fISn9pfRG4bxX0FVBJ2rdI
 EOow==
X-Forwarded-Encrypted: i=1;
 AKwUvBxS9PK5wgmteVoeVDNWVYj+vIvK+VT5s+H75dpdT6tUVNE5NG7F7805ECSu+eT2lFDrLJqt1e64j9w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKn6BtC91D5pPi7ycyvFLX7ZfZHPjU9c7y5ocKuRbMhVRpu3zRU
 Y1TpkKSIiIZgm2zYI1W0MbbfnIAptRQe4XomOFudWdTU1w/j8iV6rrib
X-Gm-Gg: AYBFou0tWd8GagfcLHD6dWo+l17Pl4AqJE1gX+TzwJuMDZ51PbK2JJC/zhWxQvg+7lF
 3skrX1GCKJGHswzAG3ZoUH4CMyYMdnPZWanXtNWz5TA0PLFmekINGS0tmNUn7FYSc1mgzO78dpH
 cPHPR7X+QdxFNP8wS1IvIeHr24iCiNanSdW2DgsTDFd+GvQ5hmL0jG///bbfvgcEkF3RSlbU76Q
 44gwsK5+6x5kTJDNyoCQI6xnaZ9J5orEsAtk32sUkggifX1dk3oEBxSKqGb5hhDjZdIKehEH34z
 iBSWMS9LfwO4y3GZ4GbFBTjmkSGK0BNaGrGLQA0p734LKEVxB++Q1J/yqsB7A1YNEp3bbicWGAj
 mB/ju9HGmqAVWKqx4Xc/C22c7D1PT5VchYspvhcIr140ZPGnqKi8lY5AvVNuQH3IDiGSdHCbTFf
 0XfAfIKn9+VbWN5qxXpsXcDka4lFJX+VGqJvPnLvmq5GWsyU/zXbRfkjP5GYgmFRsvAc+ZklNSy
 hqgFhDNHiupAn7wS/3rn4Q11JrWPebvcM1PH6ESOmnaDijYoEa+WIow31pLi2IaubNydAfsqg==
X-Received: by 2002:a05:600c:c8c:b0:4a1:e489:f8a1 with SMTP id
 5b1f17b1804b1-4a1fd89d90cmr15704905e9.2.1792562372261; 
 Tue, 20 Oct 2026 22:59:32 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d6e2dbsm134642305e9.13.2026.10.20.22.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 22:59:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:59:28 +0300
From: Dan Carpenter <error27@gmail.com>
To: LiuJunyuan <2058432396@qq.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: use scnprintf for fixed-size text buffers
Message-ID: <athUwPFnbEJ0p-0s@stanley.mountain>
References: <tencent_FFC8FA1142CEF600BDEBE1EDF4EC27C39005@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_FFC8FA1142CEF600BDEBE1EDF4EC27C39005@qq.com>
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 11:22:08AM +0800, LiuJunyuan wrote:
> Replace sprintf() with scnprintf() when formatting the framebuffer
> description strings into fixed-size buffers.

In commits like this, I want some analysis of if this change matters
or not.  I would still support a change like this even if it didn't
fix a bug but the commit message needs to say if it's a cleanup or
a fix.

regards,
dan carpenter

