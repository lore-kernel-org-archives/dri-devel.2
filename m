Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FCD606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0918C10EBE4;
	Thu, 12 Nov 2026 21:20:48 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE21B10EBD6
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 21:20:43 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-8b4a15c84c5so3506037b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518443; x=1795123243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gnD0qZKot62lDZhBXBy8q6Wbwwjv+VVzs1p/sCw+Vic=;
 b=Ea4L1/0ChIgtyvnaofmlvxScwHk93DIIKO5NtOl+9DIjKddrukzBE77r8FRfyR+7xk
 rH4QCYFABmbulX4RmyjS/pz9e/yvDCDBBU3CgtNc2xDgsiRhcj5MypkkN+91yyU0o/X7
 95/vtaX811Yd2fFNyB9/PztCXChxffNZ4mGhCvp/wZonp3vNMEZYelefOHSVuewz35Qp
 8SZ/Bd/ltEdX2KHErnZYwq4WmycvXux4eARZwDmnVcVV+R5dBrohGRKuq5lNiFJxMikQ
 7ngRGldxPwwSq377i6P+pTV2v1zyC8CspEY+7D6/jEMHLXHuBbfcuywX4TX5Tqbq56ZR
 Xa1A==
X-Forwarded-Encrypted: i=1;
 AL+hErFp5E1f0Iu0dSnWkG8RjLIhkK+XJtbyMXlcN/Vcmux3J7en/GRpi/FdF0gBbHzpQKw/CffBT/186Og=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ujB1ba4Y5WebO1DVCMbx8bo4CzNffbFU1AxgqDgaCuN9iEW/z
 A0qIz5q/VZZ7X1n1YrnA+alCl9Hcuv5AN9F0bV4EpeFV7pMQkJ4J4BLWhzG61FZSsVY=
X-Gm-Gg: AYBFou2lAIWNuQJhbn6FG/wSTI6OvYFOxmvzU89ZBjpM3Kb3mcRxNtH8i1dKIrQ5DZI
 KlWzc47KRqtIYDCaIo/kVN2Caiphyly3nYXYMnrKOvjo0KdxHtNQt6LSJN5ze+RVJ2fay/dgHfs
 zlXuXTAknyNlZIrs0+f5f2ll3gp7ZoUfT1/vphsS9LfHtM4gB0wpA4cwiZ8fqmEuCknhE1TnPyV
 S+ztb1pau7DoYwdsS1uVmxQOuJipBzYzO1iNc1zfP5chzRK4ROpuhqOTwykxY/p2zjCB6VN1CwU
 hNt+T4kbjmqSjJvtjBxyrlnamStOAEVa02XSLx9vAzHL1KFQ2F2W2G1NbUy7LZ3yBTSmhai9Tfm
 x4ywR31tXZxSeZytqda8wVVfmTwt5iiBYghG+jjvWypG+GiCEmA2lF24z36wmTPN9b7JA2POmke
 1mAeOTsvX41Cznk7HxXykNUsOE442kjFyWcDTS6Wl/+h12xQO9l1jUYbbD1+QLQ6uEJCAascegW
 sKPvSRBfrR/fpXUc6QbD4rZPXtPFIwB8pOvw3m+vkFRsMP1BmYQh/pdQDXnRvipGiq2zoC/5hHc
 qGPPARqDmqooueq8jfcmlPmedDcIOMgcCKCPrMlkLWM3bR+/sNkYq2eoZ9gW657UrcNMavZxQ7D
 7I3i/TEcmFtcuWpUlK3TiDKfAOwlWCtY=
X-Received: by 2002:a05:690c:9217:b0:8a4:aeb2:acfa with SMTP id
 00721157ae682-8b4aa2e0babmr4442757b3.54.1794518442814; 
 Thu, 12 Nov 2026 13:20:42 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa67085bsm6051947b3.0.2026.11.12.13.20.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 13:20:42 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: Gabriel Gama <operatingsystemsdepression@gmail.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v2 5/6] drm/gma500: Propagate SGX MMU setup and GEM
 pin failures
Date: Thu, 12 Nov 2026 16:20:30 -0500
Message-ID: <20261112212032.10576-2-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261109063303.32658-6-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
 <20261109063303.32658-6-operatingsystemsdepression@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 03:33:02AM -0300, Gabriel Gama wrote:
> Fixes: ae012bdc5799 ("drm/gma500: Hook up the MMU")

The code looks right to me, and ae012bdc5799 is where the ignored returns
came from.

My concern is that this patch has a Fixes tag and 4/6 doesn't. If stable
takes this one alone, the old insert still leaves partial PTEs on
-ENOMEM, and this patch then frees the pages under them. I'd either drop
the tag or give 4/6 (or its rollback part) a Fixes tag too, with a stable
dependency note.
