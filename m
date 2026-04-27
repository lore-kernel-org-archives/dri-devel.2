Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15510FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5166A10E783;
	Mon, 27 Apr 2026 14:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pXpaS1vA";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0141710E783
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:37:51 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso86375685e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777300670; x=1777905470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VMKnr48ApFLzTqupCAriP89IyzIF45Kby0CyN0ZRK4=;
 b=pXpaS1vA9Cv6Hkbufz1I7klD3K9Prhjdc1hUDRyDHHiMig9Xev3HDmLrza6r0ijfGf
 yHpmKXFvuyFoYm3Ot4hhhuoq3Ht9kcw98QlYx6mZJ+jtEEVqxJgiXb2d/9JcpjcCXMGJ
 xiaRxNhYebnpiTvlmpC3m2YOFPuk57XlSOh3sC5H72ZJwAnwkgzhomKKZiTS6Jz1L+Sf
 04TUBaOmNDwbMmayjogTR5t+GqeGQVvTb330Gvm+e6OGPOWwoSgG/G19QAwGwpHP8tIa
 V4puqtXfCd52QyRXn+zC0YBTnwe377bpYQXvpVdAtLUsJRUY75QJZrccDs9zyYTL1rY8
 6xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777300670; x=1777905470;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6VMKnr48ApFLzTqupCAriP89IyzIF45Kby0CyN0ZRK4=;
 b=mv2AHM4SbtskMknJrgyG9uqo8eGJsYbEbzyHIUGI7Abg7CbHCYET6FlWy07TxbnFQn
 7CDGBowFA4cmMV/IW3db887xXbCNOOEAvmnRF+6R7Jj1YpLW3IqIEYFPpIlF6EW850Ny
 kqdcbo0CU0xgWy2n5Yrg8mKLjaqilPGhjOQQGeousbO1ElTEEsL/82VRTY/CDhJZpPBO
 w7vTT5L4RNHI2F79+kyUt+Z9pYzhkUgNH8It0AQPVkOqC5+HX0ERkluWBAiOCqC9xaSd
 eYZGctDd5OX11NDvZ4HT8TJXP3sWPfCDzBOjEGlgZya8q08o2k/yk0lb4OZJq6Rn9Zud
 8Isw==
X-Gm-Message-State: AOJu0YwcA2sfiuBKngve9zPqMt7v9wVY2kALlqn8ISDlIgLAV5t23Ivu
 9bzDu8ZBiUsv/GppCnyX7A5RLZ5kuLnSdwuwH4FE1w/gKzb420bDkD1KRSrEzwxR
X-Gm-Gg: AeBDieuseXqrBoNB57taTTSW0AkKCNEFiCqsMdQ+PJW1c9da7zwFfrnqE0tJHlaShLG
 gm4mKgbrEvGGWAaY+yJaY/eZBYcRJMlngt+v1ShYbnWukhou3IOSPYcGJ2sSq5ECMXYoa3FQ2fl
 7NNG0ZhNE7iTZgr85Rwi3KbwhCdm7hMWm/ryRJl72xplbqihCHARQP+wNDER1attYxdE7jqlIO4
 rYWQha6m2NMUKJCNh1Ldwu7qS+xtzZaBROCN2zgUjFSCMHDTzRciJuEW1IsVtDT8uJ3nnxC85Z/
 YzDQQfowXNOsrtMN7Rn5oLfKARn/JYNNLpYUZ6+BV0Thos9Q9qiaucmX042lHHYFTIBiVLj73N/
 ysspJvFGRU+/nN3+Dx5EXY9Q3FiPqWylUt0Jjd7J09vKqrBRebH7mICGnozT/T4WdVIDzRRkCp9
 dYhm6+nuEg7bmXbZu/585JTYgk3czvBzZtVvP3/r4ahW5BG7xfZB8CNMrXj4lyjOEcRGDcU9+na
 5wOErzYZuEUAZcSb0QcQZo=
X-Received: by 2002:a05:600c:450c:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-488fb768816mr602542435e9.14.1777300670192; 
 Mon, 27 Apr 2026 07:37:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1d:6120:e343:7f34:3778:d262?
 ([2a01:e0a:1d:6120:e343:7f34:3778:d262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm888426685e9.3.2026.04.27.07.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 07:37:49 -0700 (PDT)
Message-ID: <adf77e5d-91ad-4c5e-bc71-dba4cb2cfba6@gmail.com>
Date: Mon, 27 Apr 2026 16:37:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: xorg-announce@lists.x.org
Cc: dri-devel@lists.freedesktop.org
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Subject: [ANNOUNCE] libdrm 2.4.132
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Alex Deucher (2):
       amdgpu: update marketing names
       amdgpu: update marketing names

Ilya Zlobintsev (1):
       amdgpu: update marketing names for strix point revisions

Janne Grunau (1):
       gen_table_fourcc: Add Apple as vendor

Rudi Heitbaum (1):
       drm: handle asprintf() allocation failures in format modifier 
name functions

Samuel Pitoiset (2):
       amdgpu: reserve half of the addr space to implement a workaround 
for PRT
       build: bump version to 2.4.132

git tag: libdrm-2.4.132

https://dri.freedesktop.org/libdrm/libdrm-2.4.132.tar.xz
SHA256: df9091045e1115d4ff3eb01dbb6514168f0fe91e6f3e820dd5b21da040721eda 
libdrm-2.4.132.tar.xz
SHA512: 
45e540c1f8d35f5f4cc78bc2b5fe83c6fd6d24aef33b7becf9c26e74942e109a31362e91adad85d736388b3a9c025cfa91f816c8bcc11268c4e73bed8d96a49d 
libdrm-2.4.132.tar.xz
PGP:  https://dri.freedesktop.org/libdrm/libdrm-2.4.132.tar.xz.sig

