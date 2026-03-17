Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0E1F33831
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D0CE10E14E;
	Tue, 17 Mar 2026 10:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WhJaZFSs";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD1510E14E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:03:21 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so48797085e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773741799; x=1774346599; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MZ5u5gAltLh5uEgFrUNUWe9cgVa4WC5hN8ka5M2ffvk=;
 b=WhJaZFSskUPB8v3sCZQr3oQpJ7Ek1PgNpVrSDqioZ+LNkAPesX2dx3Ich3z3KQ15Iy
 wk/5KhhlWitdmzB+hAvif28bUpKhjFXsFnIViDD4rE+dSBI9+pA6Hnk+0jYFyzKzRo4H
 iAW4zi1KJw4CaQxuWyEqOY4T616EKFDXsH6hgfCA3ORGo/T3sqNe32pjmGVNRYvw68D2
 ty1ojiToCI8qu7zVtPaYUidCv53fDAkOotnuAhf2zua546MdH8x2N+M7GErDb2QBJQsI
 ysBznZEJA7g7XusdMgb0EVOzW/A0tvv8cbIwvXAuCpw4SJcTXBG4OA7Q/8NCcNcIfT+V
 JeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773741799; x=1774346599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZ5u5gAltLh5uEgFrUNUWe9cgVa4WC5hN8ka5M2ffvk=;
 b=OCNHUGe4EnSgXytgK4QT5RZAvgjJkLNFGv87TmIra3R2BhmNdz0IV4YN7u3lQOZEDC
 AxrOMKQhiYFsAJo8KCJq2C8SstrZ/qDmdWqTk+5FybTcrAfq3KFoYcxSzImfIoinm0z/
 6+YbBnZBpTXxNJN9ZT7M0K+OOGDoyL2OqWa0W+pXK5WpfYahCbektdMZDcz5+BxOUijW
 VKqnAqzZ9aaGu/tCuO1sDppFGfUirIbQ2A7w7zuiFpP8O86CnRi/5tipIT7gXEMZCeTK
 xDiBszCxkI2BQSr5Gv7PVxLzEplJy6mqEENMpTpy/x4rsVVKw06rsGWedlJuAE7xvOA9
 q+tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLOiKLiuOWJqBY9j0g2Vp9gc9DSIpiEsGBBrgn9KL/9+bID3yfD3/X4HPTT+agZU/lOP4Nt4ISIg0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmrkwjWCopIKV24BtL8MWOXLElKhxzUFsxUFYvZEmV68Rph6yf
 cVE3lPgKTZLJCcEzCiW/fZKL0/syQWSL/Se1ELU9nhURWd12EPhulgDcR/KwfGR567w=
X-Gm-Gg: ATEYQzy/MQk1mmK6oLujyLtYTmGodnysWKZqHRMRashBHPjtC6vAiaMasC2BGIRpnK/
 F4c1tp3yIwjP1wK5/mWPL8+4R0dk9txI8JMurlhrUC+GmIbsjtiOlig3mjtQjkFn+18xMilUGZq
 j0ndIBTulkNfrhoA7X18IGCsIQSA+gKyHJXrC0O67VRhC/mbUsE8bjsDE7xoYT2goqermPF35Qo
 YJhaRwOWndAX3bupfM840QUER7QSJzpLxyo5KrqeGHnjqN253uSv0CEnSIEYZ+hJyTm0imIPPdG
 98zEd4WHnUfEE8oTTE50h3+RKKguCJMv/DbLd/Hp7kiwcRMqGNlbXqQbjHqhStHWU6NXKy5BlH9
 VAKGEuPCKCy0JN0cWqJ2KDK7gRz0F3QuhLTeOX07b1SmUKS8mu+/QgKzkRRopHYDY01N26uAjXz
 2sUPT5gNz/gg0AHG4SAQBPQMC08ORu
X-Received: by 2002:a05:600c:c4ac:b0:485:33ad:3c9f with SMTP id
 5b1f17b1804b1-4855670c164mr271097835e9.25.1773741799028; 
 Tue, 17 Mar 2026 03:03:19 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eaa3b66sm63481085e9.11.2026.03.17.03.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:03:18 -0700 (PDT)
Date: Tue, 17 Mar 2026 13:03:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, Alessandro Carminati <acarmina@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v6 0/5] kunit: Add support for suppressing warning
 backtraces
Message-ID: <abkm46TIIBBbuuC_@stanley.mountain>
References: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
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

I think this is great to suppress some warnings, and I already ACKed
this patchset.  But we're still going to have some warnings where the
warning is the whole point of the test.

It would be great if marked these somehow:
1) At minimum we should mark them so people seeing the warning know it's
intentional.  "Intentional Stack Trace".  I've sent at least one patch
to add that printk before the stack trace but it was ignored.  We could
do this piecemeal.

2) It would be nice if the print was standardized enough so CI systems
could automatically filter it out.

regards,
dan carpenter

