Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D188606A333
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YBuavluM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE1B10F820;
	Tue, 20 Oct 2026 22:50:24 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696A310F816
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:50:15 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so658955e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792536614; x=1793141414; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f0vC8nTatz/VfjL47eh+tNgjT4mJh4syjFrv8ctbkr8=;
 b=YBuavluMfRRsJ1u2PPOnEx01mw03gv8rh8xYD7YkMwv+sO8mnYIt11Ejw0bsaZniq+
 SBQLE+dPhg9Cq+wc8iI/1Jzza/TEeL+W6pEw2kzTGp4ucNgfaFJmc3PZjHwzTk1fd+TW
 E104DLbWlwaBTwQLusPAQiNInsLtRdx3P5AeS96qh8klUSTvsYK3hJ4A7/gngn1DzxnD
 7fPecpJr2uj/Qh3iKwims/yVVZIKFhOpkAkthpxlyfe3mmnxqM4lzEs0W4OTMPinz2fa
 BAbzTG0EjpV+O5kM3QIkhn3hdaZwYW5eY8m8aPEFC+TN4e77sfB51ApbHsXiW4CEEg6T
 rvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792536614; x=1793141414;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f0vC8nTatz/VfjL47eh+tNgjT4mJh4syjFrv8ctbkr8=;
 b=Jt+BhzsOaxI3egg2wCG1pkRfzK8AoIsOUmuFu/ORa0qF2H1vWes9u8UKQtR1y2Gon9
 9e2vlMrhOPZl3xxSySfphVBrvB6KF2nJS9JT7eYbbN0kFD/YlwLvggIjB9RenQDqL05i
 KURU6K6X0y8le93UAb//uU+dPXMoYBrGQCXf7su+Q8SAc9/QB1U+1lMvM5XFBOU5XwQv
 GbxlZAZ8yufgcNsS+KYUs9kt7QTD0TFT7YEh65R9vH04Pe/aOMFj6i9Rm840qTyHE8gO
 6o6eMmQep51T/aRP6QbktZjHAJDbshTU9aHoVVr4MSYRyrSTXB2cGvZDPMtpuBVOTm8m
 qY/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0MKuoVTJvNqDiWwrDvy7U71zCe338LD9H0msv8HmCtBpu91V4nleR61U1SjbCdhBefoIh94SOSG8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKneJS6JDL6ROMsH54fgWXadAr4+cBMcSRzsRqhs7o7FxaZ23Ar
 jmJhhF9xVdMFdd8bjKVWcvHztW3nmTaxR+n4jzUjPoPVh4HEmYiJ62/I
X-Gm-Gg: AYBFou2XBgB6k4/weAnSgui1JufM/e6wP+eTfPkEUx4xq9Ov5c60ZGHMbrHeptpJ89n
 27j2jpfgoc59JTRmnDNvurOI0I5Zc1UqVW8mULifBo8XiZcr7B3WgTUSgB8k1skbAvV5LdnLqk3
 DH7k4CY8khENvf497hJffw7/Xe8ijXwH2rl//Wye7y/E1PySDMA3XvClBt5HeauZQVVqkLF5Uks
 F8JB5YCP82p3erNGWR7PxPfoRE9WG0+J8WWybinO8mLsbKuFpQxFD7r7/V9bOmx6BNOiEasAtPh
 GbcbJ+l+mjd04Go8gi3bl6ustesOPaSi4n5e6tBFApgGtmpevjhmT1FbzdD/eo1xoXH5MAQujhU
 +PTqZffjSyI4vCSCdclC+GsPW14AK8siUKBCC5wcAw9IL2aaL2hHIgKU0dnh/sSrLo6QBTuFGRR
 +MyIQ53A5uojsu6KJc7WPto2q/uwO/NlMPORt/p5xEiKlKC2lQgRw6HbYT5FEDS8+K2GFTkt/Qg
 dZ/kT/0VMxpjPXdvn4yb8fyXQ==
X-Received: by 2002:a05:600c:a0b:b0:4a1:7bae:d80a with SMTP id
 5b1f17b1804b1-4a1fdd245bcmr2271955e9.9.1792536613728; 
 Tue, 20 Oct 2026 15:50:13 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0b42bdsm17511805e9.0.2026.10.20.15.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 15:50:13 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/13] dt-bindings: display: add a boot logo node under
 /chosen
Date: Wed, 21 Oct 2026 02:50:02 +0200
Message-Id: <20261021005006.2341200-3-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261020164651.GA4017884-robh@kernel.org>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
 <20261013093243.505776-7-maximpedraza@gmail.com>
 <20261020164651.GA4017884-robh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Rob,

On Tue, Oct 20, 2026 at 11:46:51AM -0500, Rob Herring wrote:
>> +  image:
> A bit too generic for me. How about logo-image for consistency.

Sure, logo-image it is, in line with logo-position and logo-offset.

> This property is already defined in panel-common.yaml, so you need a ref
> to it. You probably don't want everything from there, so just 'rotation:
> true' here. Though keeping the description here is probably worthwhile.

OK, v6 will reference panel-common.yaml and list 'rotation: true',
keeping the description, as it turns the image rather than describe
how a panel is mounted.

Thanks,
Màxim
