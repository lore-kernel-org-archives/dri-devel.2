Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6FFCD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 00:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C0A10EF11;
	Thu,  7 May 2026 00:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q9ff2BQj";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F4D10EF11
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 00:37:34 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8f83efb5729so27574085a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778114253; x=1778719053; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fz6l9Z4iYUBHhumWdhqUenv3nJ8+M9OXu3z4lbN8dSg=;
 b=q9ff2BQjZO9xCCeC7sIhHo4qRM5zj290VJDNEDHaekX/vMjEgV3xerParPngjlHSDy
 L5rYoqoBo8vUDPvtJ3qXTVt69MElxj9ey2e44d+kg57dFgQGOoBoO2wIKaJCm/c+ckOD
 DhmeMT188nQqE53Um/4lPiHrtt10+AINSmlCobSiCtAALi4J7WuCysHD+EDOQ7mz1f42
 XkY/uAOBbaJCHHGQTt5ExgvHcDHRq7DvVfNaXjIgyxDWQscUHJKxRFtGpMj4OD5fX4Kd
 fAKrm9wj70+BKNVXVOVWDLOW1eXioW0HM/qjhhftiMBQ64G2it/MyE6Drcfstc0VmAaZ
 CdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778114253; x=1778719053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fz6l9Z4iYUBHhumWdhqUenv3nJ8+M9OXu3z4lbN8dSg=;
 b=JtNJjH1m2Kqydf2u7fpbF9St8Ab/447TwzMdCs+MF0JBDf78n7Q4wOChnwrZ6mn4oM
 9x/yvg4ANpg36FllVAW0/UT4Gnjn1PKY8CCSsRrd+S6+DV26JOeEXVuoWbVUw3KpHp8D
 Q5UHoUPFxuqFEYDN/+KAXjBK5imhRXwOa1ZWUDsvwfAqMoC8ruzsv70GdQ5ucbt+qYJd
 qYbNawxWlLxwQPDWfroV85iUr9UgCUsb3yjVBPwpsHgAgBmiDgoX61Kohx3CJmoS/9VX
 VoIclicG1g0vi5vZsACzJetdaxc20PQ+2JigyRNo5HmH6l4Q2tXXagVPz01mckSeAuXz
 ioDQ==
X-Gm-Message-State: AOJu0YzozrHFQLFQRtM/HUoyQtYkGa+9YbbaqAduLTeo5QWFaFEIv2iQ
 E36nPwQSyBMY5ltGI61icTnONWmzMRrVGF0ZCJwO62LVMPbaASvKs9drXw7g4QgEE1MRKA==
X-Gm-Gg: AeBDiesaWX7lZb/PW6gM+57SyeNOk5sDrI8dtBhiDv0G7yCaZcefpDikAkuiOrlntzu
 5STbgQgXovaVwNAYJtF4Od4qSnCwHyXnu9Ae63H7M1MBI16hxS2oLIyXbr+V06QQJMaWruGNyxa
 LJTYImnJv370u45RLs7gEKrAk6XITqcx8fdcV6uNKXeN0Mju2U6hrZORxjhLsyIQR/mY/k6v7Rs
 Z7GIsVXjOWYmojALAzl150kheeQXawuog1hVfzLveGXuyOQp+vhtSM8WdOBQDHW29o94pfRzB74
 rG4c7xP6AsHKn6jDjYO1U8bbwCEJmXlGX5YqnOeFB+LK8EGRka03Gpb0qsRlbFZ2DKns2HbiSb6
 f/67MVxOxJRBAclHkwrkyh5uh0doljs+reijwPMTL4dStF5zJuYuXwFqpkctQkqPzCQq4x3hL8q
 eBWSujg9bWilL9X9sEA8zdZ1X7VMdXqvo7x1ueH9P1BHyOX245rCjCPvPQ5uwcYEIrBFhIwLuSX
 0gXnSPMY/Szh74VUXe+Mqk6MzmxozPqh30PMOc=
X-Received: by 2002:a05:620a:179e:b0:8eb:6f04:f97f with SMTP id
 af79cd13be357-904d65e0a4cmr874756085a.44.1778114253357; 
 Wed, 06 May 2026 17:37:33 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2c25324esm2051748285a.23.2026.05.06.17.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 17:37:32 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org, stable@vger.kernel.org, lyude@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH] drm/dp/mst: fix OOB reads on 2-byte fields in sideband
 reply parsers
Date: Thu,  7 May 2026 00:37:22 +0000
Message-Id: <20260507003722.986428-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410040026.2436280-1-ashutoshdesai993@gmail.com>
References: <20260410040026.2436280-1-ashutoshdesai993@gmail.com>
MIME-Version: 1.0
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

Hi,

Just a gentle ping on this patch from a few weeks ago - no rush at all.

https://lore.kernel.org/dri-devel/20260410040026.2436280-1-ashutoshdesai993@gmail.com/

Happy to revise anything if needed. Thanks!

Ashutosh
