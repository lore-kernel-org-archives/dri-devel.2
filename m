Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B222606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s82qW8i0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0113C10E59D;
	Sat,  7 Nov 2026 11:12:36 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567A410E59D
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 11:12:29 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc785ed8aacso37638a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 03:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794049949; x=1794654749; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kpcgrgeS4YJixEjOpFKN1PyswVGYEcCcMxkh0K6m0Ok=;
 b=s82qW8i0c9yrbJpELM6sbQ3dcuBtLwv7+GbPQS5POS7f43icERJv0Rpa7+OxbAPD+r
 /VNUbiG1Lp2cDEli1EC4yJnQ0nW7ijpyxTUcc9LTbhCFLJ8GWPMsMC2QvIT0zpCgWBZU
 +GGegZNHGQRzuyJ8NJJ/2I6nnzt6+tOge+UiGq2jHwfXk4iie2WaNBMMAKxWRVic/LsK
 HLfrHQ2UdaAywqvxJRKbosd5D7b8bUgo5i4E/PYaIcLEKOLyE+BKK8PApjTBoL7ycwZu
 6/Y3S2ZuO7QtavdVVyzdOdOGyDjBY1tfV/mesEHS8yLdQG+CLibBeb12M+NXzCXHgIAC
 5TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794049949; x=1794654749;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kpcgrgeS4YJixEjOpFKN1PyswVGYEcCcMxkh0K6m0Ok=;
 b=TIJMrhLT1c6F5+mhp9R87b4hCaSoFV5ANA5qRqHFrNEVJe1nkt1fmaPwbbGdMIOZvz
 FVFuXVlUB+uDrSDYkTHPxrwES8NhMa4MJDVGXjYO43RQMzAQpD7CraCnrC7zdSK2f+Yd
 5Roa/XpUtzDOz25RNVJCbUOzrJ9i1S3bpMPZdnlLAbDLHMn7QuIuTpp507wxnBJXx4U+
 3rEgBO4ybYGzvsOZuT+DqySxdXkeTeNJa9XYsqSTelK53qDmaHKw6PzoEWrt+j2pLHN2
 +7BadL6hQQ9vRNj1c8M9D0pNI6Y05oOTNo5eiSo2kJiE+n+nKy1TRrAmYwvieHbGO8BN
 rEZA==
X-Forwarded-Encrypted: i=1;
 AL+hErFfW0J1XZtZE/enAEeCWJ6MG8rifB3mw1noa9W9O5028UQqbJ8ozb5LgIHFz6kyghvWMx2+dLrqoHI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ctyjD71GGD2oQFun7xStry7W0YiZb+wIqRsTCfMyNg+pLRzC2
 RhcqSQHxieHd2gwiQPaZvscn6uHSgCegolQ/EN04r3UBGJoAHKCg4ZhD
X-Gm-Gg: AYBFou2/jPZnqQTfig4AWdbgXtBuUIh5s0NOEQXSq/mynHDkyJEvZECUOrHq3RXX6IX
 d12ZlbqjTB7JwpTpJfgsDv8uFs2V90uztL+Dixl9an/4zVp095nEu+PFh7Dqog+y7WBi8CGaUza
 uAvvS/4E+dTBP+U0yqSkcu3sMjaZieb8CqErNf1kCDiXZ6tIrv2sFke7hTOgHw2dFcFtdUgHZFt
 MNFKaTgz9LYcYrbd2LJ78RKn9bOziV+ok/Cjh0X2+5jdrFFkvH0BPHsTJNzWkdTB+mZLfxerkXJ
 KQaYJw8SqSvoRKTE4H7IH/cW+lxyyhM4+0oVUFcRm3yO9pRfn2mSv58IbAsq38l+9USq8TElrQA
 Wd5W4DGmB4+KVCbmgKmupVl1gW/tmto/kK36EhidXFuvsPQnBpu2SjxRIu4kwCXHfntJxM418t6
 nzu6l7ywJOQPNp6bQvbtqOELtFcBVjOx5cuB5QfKW1qaVwegWxC40we5sBv/lBPvTBUXO0H0WFt
 FimOkpA6B19sCTtF2TuNRyUDKm2X4JlG5+hlyYcg8WLXxhCwfJ9Etlm6gqHxzfUggzg/zYeXaz6
 k0yYJTE8TrgybjgVQjRbB1wW
X-Received: by 2002:a17:903:1a24:b0:2e9:5714:607a with SMTP id
 d9443c01a7336-2ed416ae161mr87708345ad.2.1794049948724; 
 Sat, 07 Nov 2026 03:12:28 -0800 (PST)
Received: from marchy ([2001:e68:544d:4b2a:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d89f59sm12431085ad.68.2026.11.07.03.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 03:12:28 -0800 (PST)
Date: Sat, 7 Nov 2026 19:12:25 +0800
From: Adam Azuddin <azuddinadam@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jesszhan0024@gmail.com,
 airlied@gmail.com, simona@ffwll.ch, andersson@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: display: panel: Add RAiO RA8875
 display controller
Message-ID: <au8HmdyRnuFmSmKh@marchy>
References: <20261030083737.47188-1-azuddinadam@gmail.com>
 <20261030083737.47188-2-azuddinadam@gmail.com>
 <20261103-zippy-quantum-bat-98b5ed@quoll>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-zippy-quantum-bat-98b5ed@quoll>
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

On Tue, Nov 03, 2026 at 11:49:07AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Oct 30, 2026 at 04:37:35PM +0800, Adam Azuddin wrote:
> > The RA8875 is an SPI-connected TFT display controller by RAiO
> > Technology Inc. It supports display resolutions of up to 800x480.
> > 
> > Assisted-by: LLM
> 
> You can drop this.
> 

Will drop.

> > +  interrupts:
> > +    description:
> > +      INT# pin, active low. Signals RA8875 interrupt events such as touch
> > +      panel, key scan, DMA, BTE and font access completion. Optional, since
> > +      the host can poll the interrupt status register instead.
> 
> Last sentence is not correct. What driver can do is here less relevant.
> Question is whether hardware datasheet allows interrupt being not
> connected.
> 

Understood. I will drop the sentence referencing driver polling.

Thanks for the review.

Regards,
Adam
