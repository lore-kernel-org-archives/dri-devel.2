Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD7606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eSzKPBgn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666F110E7B0;
	Tue, 10 Nov 2026 19:30:55 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DDE10E191
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 19:30:48 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b305312e4fso20982727b3.2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 11:30:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794339047; cv=none;
 d=google.com; s=arc-20260327;
 b=mEblEnWRCB6GgTem5vBPvUpDea1o87rigLGSL5nMeCilmJCo+WEeSGbZG+MYh3aRri
 sFpF1ho0H8lJzOfxVoSdraTFgsYIzH0fz9JDbI7Nqfc4yi9KJSzFa48f6quFLUNj5r2c
 vUYC9PDLVyY+ZWWARITKPSG88vuxHxUsHIm1LI2ouTFntL2KQlmjUEk2/IqPkUXJg/YE
 cDb0508BWiSu7q01j5VQday+ozwHibhdU3iI1xo+rNGHgQznHq+bnX/8z2twU+21Qhhh
 U/+TkzLKrsBvmZHdZI72NV8Vy4jgvMb9tzub5ABHwYin5xyLr4wEbg4qDEyUAZ0gu0nk
 X4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bxDwPFOXkyRkRlbGoiQb8iudRyw26lOximDKyM7mel4=;
 fh=mOBTE2T1M5JEjWF4OypsyeuS504ra4S5Q7Xv760spM8=;
 b=RMLHnEvhztG/4bF7w/yW93dZEwLvBpWcAT4Q/IDmF4DeA3mBvo9AcsIVi68pKYMVwH
 EgCEDE33M9wGmLqd6cWfvVuxbpDHVJWgEaeXagwPR7g2tDQPfNUJ3BfGgERbgmI6b0kQ
 G6Zhg3lYnKZXnZeB6yjWAC3fUCsj54XpP0u9/N47zIzsv524oPihKEmtc85hXyuXVhnH
 I8LsIcw0PXHBWXCr4u0Up9TyJJAi2Oc0Vgteng9HpIhjpQ/WvN6AXoDWnsJQLMMFsaTt
 KgehHGsdlAgjTpR37QyvCggKOoK9vi3xH7qkvQIKsKyX/15mfoqQYDjoehGVamiDhU5T
 HNDA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794339047; x=1794943847; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bxDwPFOXkyRkRlbGoiQb8iudRyw26lOximDKyM7mel4=;
 b=eSzKPBgnH9i2gJvfx7nvG5zubu5SbxETEN2sw7emzPYuxrl5IJ8UvLwVSSPjbC4hjd
 YhTS9mOKCGWZumwgxZJ0s4iKHEv1X1hlMzEKrh7jWN9w9+ZXYCjh8BYQSraajx0wLwqS
 4DmbSl7cBgsZkVsjOI37AWn2k+2IIhQK1N1g6RdWL8abou6VZuKd3F71FJGkaZS5TX0r
 TX5LZpa+prcH3AajqCZTH2Vw2sclPRFd6dmcykWW5Ch5SUdKJ+PjP/eAS0+/r/8Kpdkl
 mn2iIBxp++ny3Jx00v2z1eOjasBpudZu289sB3dKaRpPTgoT3DIYA3gh3MMXe37cSVOn
 RVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794339047; x=1794943847;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bxDwPFOXkyRkRlbGoiQb8iudRyw26lOximDKyM7mel4=;
 b=K7Y9QfbVk9e8neNRXihGIdkumJO8V8qzACR5388sWoOAnK0OOxoIlrT4zdWiV2vjIY
 FcH/ODDJNnGviYy+rb8NbhmDptu65LXojiAntE0imhAgOG7+DNLvYe0NgUASkIFgjoTk
 lZNCjRqIWIxNtYMIWpHwgpgzGsWJWUrbiMQGJSAXJxVChHh7CqBtCf08LtlqM3HetHBT
 YaAfCs+BgEJOGcjcLA9/i8wO9TiLGz3mNtf9zILoETOGKuzY/RMtxlXKT1O89mlL4OBv
 ZqBZkoElprOBlpMkkYW28+uMStya+0VL2RB/zA6pTWxq4PDKSK1FVYsfAUbNhnTPYpQd
 RU2g==
X-Forwarded-Encrypted: i=1;
 AL+hErGxsivYmyWLg5kn/IQZyUVRtfOiDxoYZCKw7NdcyJ2nRz8r6LSXxGolmO8MbrHDJOZwy826r96RZeA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2igFJ9OT9KjDS16DyYEe6/9TDfTKGu3FJc3rFI2/EemyJUt4e
 mc7+KIsh4htU/h/iJ8rB2oHPzmMGwdDkGe/L5yfvW3Bo/q4TbRDy/8j9Y2Sy1eE+4lbLlcCetzz
 Da/4/nxpME0JNJvJdVaLWo0lpb42OetM=
X-Gm-Gg: AYBFou2r/Z0hPJobi+DnLY6grrjdDDIZVlcG7EgQS71ZBXmAIKmPmJF01SxyLgLRigq
 mTYLaM3BaDqu2nN8zG/O4363gEp6pPzJ2K2ZtLp0vviOt51TYVLd+qZcNUxH5qBNofVWhGHPKdH
 cZFO9VJAHxMCG0BgIj0CAwxk0Y3ulzznIFJQafCKs3+Uyfbmllra5dbMtV75P235ue619EYT75/
 yFkBC70kMCCqPZgDw4d2mu87tPqhz/sJQJrVwPYEql3LlRb9W7ZwGVfAyPtv+CeF0rORz3fdcJQ
 i0gmPRLvo8HFxsrfv3AT724DLx58VLQqSb4XjIzBn2lXeKXiSxnLc/dYVVta3vE93fqj23u2mED
 H/0e7MNxf47zUCK+BSniPBdKVWSJHVRTNEzCjbQ==
X-Received: by 2002:a05:690e:43c1:b0:67c:2804:fa9a with SMTP id
 956f58d0204a3-67c67fd7c9emr126041d50.36.1794339047361; Tue, 10 Nov 2026
 11:30:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015-orangepi-gpu-v1-0-03566a615660@gmail.com>
In-Reply-To: <20261015-orangepi-gpu-v1-0-03566a615660@gmail.com>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 10 Nov 2026 20:29:00 +0100
X-Gm-Features: AclHuK-V5XriYQc7jPlMOpsvH2O8V3xAiSzCm-87ylsSLg9H0W8yUGZ1h1oG_o8
Message-ID: <CABdCQ=N8afBsoZcTA7He3FOR9D2K-yieb9i4cAa=WksjoHm5aQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] riscv: dts: spacemit: Enable PowerVR GPU on
 OrangePi RV2
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

Hi all,

A friendly ping on this RFC series. Any feedback or thoughts on this
approach would be greatly appreciated.
