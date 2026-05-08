Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F154CD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DC210E0AD;
	Sun, 10 May 2026 10:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="RccVnukP";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E32010E30E
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 10:37:03 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so2952462c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778236623; x=1778841423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gthuyIjuskldV0oRrX2vMoLDNxHLbykzRnx9SsAWOYI=;
 b=RccVnukPoel/tQ40wr147aNYBSGueKv3RcOj+dKOnh5mC8L0LH7xJ3m6RcYhlRKpDx
 vEzB+42cCMXeSYbVPOI76KsRQfCf5WbEGI22KrwEQHHowiT+VE8CY2OBqAAJLNrq37eH
 ZOSpji4y8MsZVtQuBijydR5tlqADqNcFfrjRTxTcdpbTIGtNy2oZUVsBJN+FEZhh4MN7
 tvlg/HtaIEvMpQO7VZEEWjGC43QbUHiGitKYG0iq46W3hDEidK0l1XG7++eqrvr5afAQ
 coiVR00FaK7qXcJO2t2xgQpigEAULuUUv9wD7ARo7UisW5OR8emdpm60/NINFhxPtCvo
 WB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778236623; x=1778841423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gthuyIjuskldV0oRrX2vMoLDNxHLbykzRnx9SsAWOYI=;
 b=BjAnup5Frdv+5pWul/Su4D0O22offayguo6o3EWnNFlvVIqbIjRQeWV6L8GtlmfRW5
 8Kjs/Ry32zKgQK/SalgHFLQHDzZf8Ywu4cnfmeKmsnIirYZOAq7zM0LmQXiyvTTzvV5Q
 bwjKnzc0kxZqiXapKKBJcmTL4UuzPOwlgFhUjNwRWI7ZwFhDtshfgO0sy7GWf/HRQhLV
 va35X3LUltHznOvpUZaj0OjFXPQf0u3gftjUx6IvClRGFL2guBq+9S+iBmzMRkusHTV7
 Is6aP+LFaIJ7I/buKFNp0ZyRMdcXEuUsSNJWDTjjrRb1Us8HOjC2JN4wCKzj2oWpbOqL
 wM4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+c0jmTs8zQJuUedT2LQpvb2P15QHebbpddBPez6h5pzBXYoIMnd83upNdYW69kVh9Xxk+po9etG/Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHe5/MY9N2CYe3x14ZcsUYjArUNlJuOM/5Nni9QA3ipl9gtoEP
 PIp3kwNO1LytjZZNW7D3liEyJ98C+1iwpCfumsUccXbKSIdPWjWiGsWzK9wGyoAdPaE=
X-Gm-Gg: AeBDiet42sVvKOCVYHXcR5eUKo+BDcQhFwj7fzb1ne8j/zidOelMBRWkGQEzuE7Z7w+
 68M5wKI6AVVv0xJrl5xvWDRUWDS8/UQn9glBQnts6ADRPJBSwWBuQiWOXjz2yY4Xnz2/yva8k5r
 60E+063HRei6ayDo9HVYMh73zCpi4zTFPUyYbO0XnO6YxMr/JCqCbbpYmtrY5H6snwrJmibY14l
 Zrb7ouXfwUv/gXACRe6KOEz88gLGnz8WI96J1r8RD3TfJjGVWMJl+f/i+Pj2Fsqr408cNH0a3Lr
 3sAGmlS6fVKgw06LitBe68z+rTTxakj3UcUFZlv7qplQ32UcfvX6e43px9ab4GR6KhUX/C6Nh1F
 YZntF3pBHb+xjLduMnRBVzR4FKsUNwcEPxWW+86AXdUueRyj2e7ezdbsptLSJtY4IQO9OFjYzAL
 LcNP5LnwSMv5WszhS986s93Q9a7tKJP4twjLmsQBEcV4/LYXiQuQqOiQIRc9mgct0wiEWZfIJj1
 tbOcfIm4Uf3FY866+AHgUsSk5XQWA==
X-Received: by 2002:a05:7022:438c:b0:12d:de3e:86b6 with SMTP id
 a92af1059eb24-1318ea40d7cmr5717123c88.38.1778236623061; 
 Fri, 08 May 2026 03:37:03 -0700 (PDT)
Received: from DontFreeze.tail1d9320.ts.net (201-68-218-231.dsl.telesp.net.br.
 [201.68.218.231]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888e3e285sm1933755eec.27.2026.05.08.03.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 03:37:02 -0700 (PDT)
From: Andre Jun Hirata <andrejhirata@usp.br>
To: christian.koenig@amd.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, andrejhirata@usp.br,
 dri-devel@lists.freedesktop.org, gabriel.dimant@usp.br,
 guilhermesangabriel@usp.br, kenneth.feng@amd.com, simona@ffwll.ch
Subject: Re: [PATCH RESEND] drm/amd/pm: Use guard(mutex) instead of manual
 lock+unlock
Date: Fri,  8 May 2026 07:36:53 -0300
Message-ID: <20260508103653.39000-1-andrejhirata@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dcc966e0-da1d-4589-ad04-02aeb1a8e06f@amd.com>
References: <dcc966e0-da1d-4589-ad04-02aeb1a8e06f@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

Thanks for the feedback! I'll prepare a v2 incorporating both suggestions.
