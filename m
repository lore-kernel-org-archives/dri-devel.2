Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5497606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R5FKnLg8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9746112BBC;
	Fri, 20 Nov 2026 16:17:38 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AEA410E86A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:11:13 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c50cc8e0f84so109327766b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:11:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795165872; cv=none;
 d=google.com; s=arc-20260327;
 b=V2DfLu7t/+d6DsjQoH2YWtLpBH8/hsK9kHBxOTa60BMM1PR1MDxZ8In5+R3EgVjQ3h
 oKFT7/r9Xg4Bn/gXqAgSFA3juYj01ZD3XU4QktEJUtXOYR2IRqnS1C7FpjCn/cmerlZI
 3U0Yfl8Sn+bzpEr7fZUjAdH5xgQsQF6ZOQSEY7S6yYWbkv0fUn7P96AR77ZEtxE4tA6G
 JY51aaCKy610tEievBaEj0NxTyR1xOc8Cyth46WSubRIwZUAw+gretCdN4OUvbJvUpaA
 LeaDgnFsdfFDXQVSkA2kcCYEuxJK0wboWoZJXDxwYBgqmtE+2cRiE0bDKpe5qlPos7WD
 Fj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=t6+MzUMr4/60YFoNkihAk7XxnE6CVc2ryl4+p1jYN4c=;
 fh=S4nkZoviWiz5MIBZfjTh3AA7L99CgZmBsUL312CJF6A=;
 b=HKb1/ym+/qrWAGnqQ/oG6NAloTRvdv4YKcmznzpqFWxCg3fA3/SuT6pXS82WFfFsvD
 ocy70EXvAxcj2vmspeF3+O0Rmz/BqZ22rfOmCc6JNqBzmwk1Rbdw/y+iRz8iCjRMz8NA
 e/0Jy8VbiCy85vD45wfvgwXDDZ5N6cgFJcF6gLzZs+XJsyrbBxUXIsiFz1nXXZ8gBCtm
 7cBiYcpdPdzAnpLBcdjRpkl7ZFRCTujebBWdqLaFyKc9IvIN1h4noXHB8O6sm/eJ9G+h
 hDR7eT8/lDteDknCndeNlamJmf4N9JNwkpEl4Y3SZ5VxZhBbU0m8zvuoG0ze3KDr7vQ3
 8wFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795165872; x=1795770672; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t6+MzUMr4/60YFoNkihAk7XxnE6CVc2ryl4+p1jYN4c=;
 b=R5FKnLg8rs63Nw7LI0N2K4msQbze8pxTaarLBh04kwZF1NbD1KtA4Cx4c+19srLL6R
 6IuiQr7hNF3/OxpySakWfjN1BaCmWMzHbyEFwb9Znsu9NPuVC2FKqM136DqytK400sZj
 GND6uMj6152IK5zXRyD3I1fcKVb3IPiDKZZP+QUkDhGc07z9aR0rf1iAREx1v11yOQrA
 55d20h6ciU9+6FPGBdzNrx7nr6wdzzYT8RleK2Tf3vHHydBlY/hmpuiNSj2yCCrP1cEj
 IPG8rixT+Wx4umOmcFCPEqp20rcoRkOGj5hDNRoZ86AMS9iCj0sfbzoK/ueuzX6h4KJb
 lwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795165872; x=1795770672;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t6+MzUMr4/60YFoNkihAk7XxnE6CVc2ryl4+p1jYN4c=;
 b=LRcIkbh0Ft+SQTgDFLw/CXkTgLv894n2RupPwhRIlwzLbIQJ8SFON9lmgWv+ouMK6b
 af9iNx7Ak/NAu0Y6tr0blQMPnkKOWP2iLwatS5oTh3CfL3d7H2qQU9nFDzSNvpfW8BgC
 zc5POwna3bjDGNkOYEzISo0452LTMxGB2vafzzNZJ9pD/T9jyJTS9BkhEziZjP8QzfHq
 LOLfGD960YwTgAtiR/BRxQ/WBy9DiS7u1yvcaiKKdClxzGvsEGpqZPaPuyydY2Bgh62R
 5kgAzc4Pzdr61u2PRzqUM/wssLLMEEU6JYeux9d/EoyAEdoNf98j5S+s0OjgbL6+CKaa
 fzlQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH6FqnBl2oUvl3YAiiMGq/eHUzG8vHF66UX6XUPYJTkf4KAb4MTgQrVQtFqc3S718ossn15ODzdkiY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z89zPCs3dEi7ytxh0wHMBNQKOuV8Y9ovKaQxDq4xElEsjYZt1ku
 ODKjGj1S6/4FrdHZanabYYAr2dCHETGaE6I8D2mnMSg94ITziS+f75IDiiu2Ujqks2n4JMKIT7d
 IOkaQVaUBCUX1eTwLXDGpf5U0vqw55/E=
X-Gm-Gg: AYBFou1Jhl5P8e7orzsSABoN9BIddA+Xnd+3sMyyJRrjZHht3iI/4/vgFLFRzRTzt6v
 0RF8Uuhm70uOUrSfSuncA2/zDmNQ2hCC+ogloBvsx2yOUEhIk6y2N3bL1H/HERBCTmJfZuVldn9
 YdUUSut11zPLyj3kXOhsnTsdV6ZxhO7VJDuvIzcj/GysMZnCZjXls35MexnJtHXoycMGwJXspPj
 uVq5xVk8DzEP6cPAWCQnp2GLJIK999UvoAj2IKIL10OrQVqlPVAzdWkPdxk59rc5qVNggClAtNY
 nWHZCay/bLCqvSPIDGlJkqGLdbTFtWbLVub/ewqA4hPjT1FE1VGAIHtO1EPHJp3em7kLjutZQYc
 e0AfqPmYNb2iQ/iPLgSP/4BKgy6miv4BUwGsJdPwBAT0udQ+iTT9gXcm1Kg==
X-Received: by 2002:a17:906:714a:b0:c2e:8eb7:53e8 with SMTP id
 a640c23a62f3a-c513a85d035mr137762266b.30.1795165871790; Fri, 20 Nov 2026
 01:11:11 -0800 (PST)
Received: from 118528743069 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Nov 2026 01:11:10 -0800
From: Christian <servidorjarvis1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <065124a2-d042-4b50-b9f1-3f6c648937b5@suse.de>
References: <CAMas6S3zMKwb5KZ-UNnTd92hZNN0CONY28bROWbojYHBNFCRgg@mail.gmail.com>
 <065124a2-d042-4b50-b9f1-3f6c648937b5@suse.de>
Date: Fri, 20 Nov 2026 01:11:10 -0800
X-Gm-Features: Aa3M54oJtBE0zXKo1x_1wvwSqKYQgxEMspxKwxuXHwVkxI2QPXXcrYjMd3U9iRA
Message-ID: <CAMas6S36SMzOQmzDS0dkk8y=ujvNrupQFyZTU7bYfwAqBptX0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/simpledrm: Use vblank timer
To: tzimmermann@suse.de
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 michel@daenzer.net, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:17:37 +0000
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

Hi Thomas,

Thank you for the question, and sorry for the slow reply. Trying to
answer it properly showed that my numbers were wrong.

Re-measuring today on the same machine, alternating the two kernels and
forcing the display state with xset, glxgears with vsync gives:

  without the patch, display on:     ~60 FPS
  without the patch, display off:    ~1.4 FPS
  with the patch,    display on:     ~25-29 FPS
  with the patch,    display off:    ~1.4 FPS

The ~1 FPS I reported is the X server's deliberate 1 Hz fallback while
the screen is blanked, and it happens with or without the patch. My
"before" run had been taken after DPMS had switched the panel off, so
the comparison in the changelog was invalid.

Please consider the patch withdrawn. Thanks for asking the right
question, and apologies for the noise.

Best regards,
Christian
