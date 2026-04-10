Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F4FF3ED43
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF5910E1FB;
	Sat, 11 Apr 2026 12:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DsdYCeqR";
	dkim-atps=neutral
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A67E810E05E
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 22:10:47 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-8a049a767c3so25328236d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775859046; x=1776463846; darn=lists.freedesktop.org;
 h=date:references:in-reply-to:subject:cc:to:from
 :content-transfer-encoding:mime-version:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=captTN2ETGlkU8wklkiBKw2YqZ7bPi1mceunz3bmMTo=;
 b=DsdYCeqRMdLk8W1W8fc09ma7vseC7sVgQOZG0Qo8/h0Nm7dth3O6x8I1pUziPos8DS
 qb/4Yfj1mmdY/3mCyjBHIVqFk96QEl/ELgM8aah4/7XAQj+Qjf66DgAnM+B/ImTD/6MV
 Jowvo5TqdkQVmBXcYU+aRU7qdwVvV6zFMrRJRjJ6U2qc3sgBnpcBbldwD4NbC4PWrU7t
 OPZ2LlAK/qiMRzKiAVCFRlVO2Jqqb1BeZQ1NS09JZZAe0k4SGfzDh/tNWAhJFysQ81He
 LyB3yLPwc5SKwWAFg76Fp0u3li+WIwBVNmFuZNstj73BQWxEGP2+VEYz4z07gjQ6YP46
 Bv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775859046; x=1776463846;
 h=date:references:in-reply-to:subject:cc:to:from
 :content-transfer-encoding:mime-version:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=captTN2ETGlkU8wklkiBKw2YqZ7bPi1mceunz3bmMTo=;
 b=ht+Rs8ZuVGemgT2AyikiGIV6R3DtYitZBqLSoETBIyzkLUSlgwq3nrwK6oKcZILGGZ
 PbtCPR1L/R5nNoB428V9hUEyGo7lo+6jj0scdkLgHeDg1S/YKkIsmA03MSSS1ZU1L98d
 Bt+3G53eFwcnRaVlsMmdYFIYiJAFecxgusmKkp52uZtHaUkLjf+7XKWTQ7wbPFcMcEfq
 APuGAp4LLPaMHcq86sW8xIXfqk6DD7EoQCWOws6GzlEUTeHBhRtjIK3VyClBQxB4vk5H
 0ZtTWzkPBzwHtxg8JXeGUqJRskMxLjwtTFPmgtei/8ptVumxywiaMixADfWIf5cdtgVp
 1HAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl4usb7iSzecLtK8HSFFvQZZeGGHDSdamKdbl6PdnejsIF28S8na40Q9gCieLH9BkLii80UQWglI8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOiQlVb67P1D74iaR7V11gKryUOvTB7cp65kk5L64PzfBpryb4
 B7nXCWlyFqcW/iIkdpnssG6hOOKDReyAmDt/HBA865tmBIqXYGpEvjPU
X-Gm-Gg: AeBDieuQfIvlfO9aHIoNZF7ThyU87etnmjCN3AWLZcz1ACnLWF8qDPCjPCVTd4fErXn
 0BykQdUXSolDzxMpOwW6AJMKqfCEGqHRygzpl9bOIqNt/ktpUtnJxVRNmaQIV1FDBSnTsqHZb1t
 m2O9dGnR9nWHQBMnD+92T2UHfmFWis4hhfwouJwHmWcthqegdAP4RzYOaM60mDcnbVAcpDLKevK
 N86aMD8/6W1XLboRsdYcGVcnayBGrsQ8G5Ig5zNVRe3NrVn6MaWMfR8L+3y03H61ZSGuyEPMsuK
 7WN9lN0OhNXfsaDoZFUhkQp0Ca6+uBowQyqpXpFTCs6/Lu0xV60H6cy6MBwrGiBRKEwBSEfoTfS
 i+PRGTh9831IhZYYcYiYuukKaFhmwgw2wjHCQWePGj7glB44GbVxKpz4TQtNgIqMi9/87maFWNK
 BUz5urL37jDuj2Hxp60LmErph/wiDAL1NcvJoaL5ADhxWLo4fcSxQcJbe6B/Ff
X-Received: by 2002:a05:6214:31a0:b0:89f:9417:93ac with SMTP id
 6a1803df08f44-8ac74572b37mr131340746d6.9.1775859046561; 
 Fri, 10 Apr 2026 15:10:46 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84c45944sm33877436d6.24.2026.04.10.15.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 15:10:46 -0700 (PDT)
Message-ID: <69d97566.050a0220.362616.9418@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gem: Fix inconsistent plane dimension calculation in
 drm_gem_fb_init_with_funcs()
In-Reply-To: <20260409164156.2235189-1-ashutoshdesai993@gmail.com>
References: <20260409164156.2235189-1-ashutoshdesai993@gmail.com>
Date: Fri, 10 Apr 2026 22:10:45 +0000
X-Mailman-Approved-At: Sat, 11 Apr 2026 12:29:27 +0000
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

SGkgSmFuaSwKClRoYW5rIHlvdSBmb3IgeW91ciBxdWVzdGlvbi4gSXQgaXMgYSB2YWxpZCBvbmUu
IEkgaGF2ZSB1c2VkIEFJIHRvIGEgc21hbGwgZXh0ZW50IHRvIGhlbHAgbWUgdW5kZXJzdGFuZCB0
aGUgc3Vic3lzdGVtIGJlY2F1c2UgaXQgd2FzIHNvbWV0aGluZyBuZXcgZm9yIG1lLiBJIGhhdmVu
J3QgdXNlZCBBSSB0byBpZGVudGlmeSBhbnkgYnVncyBvciBjcmVhdGUgcGF0Y2hlcy4gVGhpcyB0
eXBlIG9mIGJ1ZyBpcyBzb21ldGhpbmcgdGhhdCBJIGFtIGFsd2F5cyBvbiB0aGUgbG9va291dCBm
b3IgKHNpemUgY2hlY2tpbmcgYW5kIGJvdW5kYXJ5IGNoZWNrcykuIFNvLCB0aGVzZSBiZWNhbWUg
ZXZpZGVudCBkdXJpbmcgbXkgcmV2aWV3LiBTaW5jZSBBSSB3YXNuJ3QgdXNlZCBmb3IgY29kZSBn
ZW5lcmF0aW9uLCBJIGRpZG4ndCB0aGluayBhdHRyaWJ1dGlvbiB3YXMgcmVxdWlyZWQsIGJ1dCBw
bGVhc2UgbGV0IG1lIGtub3cgaWYgeW91J2QgcHJlZmVyIG90aGVyd2lzZS4KCldvdWxkIGJlIGhh
cHB5IHRvIHdhbGsgdGhyb3VnaCBhbnkgb2YgdGhlIHBhdGNoZXMgaWYgaXQgaXMgaGVscGZ1bC4K
CkJlc3QgcmVnYXJkcywKQXNodXRvc2g=
