Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744560A382F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JayKGIPE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1740310E112;
	Fri, 13 Nov 2026 17:17:40 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2749310E112
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:17:34 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so1172532f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794590252; x=1795195052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lIHrd29kJK/zyVYq6QuF0PDr5cYVU5VKwpX6gix9trM=;
 b=JayKGIPEIsAtsh/EB3YK8CmV0ghfAJSkmVuHvrbe8tFp9UW3pQrNAfCOvrn0sJ314U
 3H7yrMYQqULoR5V+lPjvS2ioQGGKgRIgQ4rWN4vVWgHf98CtLHn9B2qY2MbeOQKaJ6lk
 VCPa5DwjfGKJk/3pYGWwBjr9PHrldegVdSVQD348qMkjCS1SN6SEfuFlEgBBhRZiBofk
 EDP2bU4biPMAk02bqCuCFQ/oHiy1e9hwd2XZwQ3GefShAwyNlBVBEvlaj++zu9EJ07+2
 wehaUMdAs7heWOBp6CSzxLQzgzvdrRWcEEWoPF2h5qQ8ZgW5VnjV/avK/8bLezr8bZ4P
 Q7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794590252; x=1795195052;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lIHrd29kJK/zyVYq6QuF0PDr5cYVU5VKwpX6gix9trM=;
 b=dImvHAz6Q8l1pYs1jMkjXBMk/qYsV/6+BjO056eIrR0L0GI5DqF8rTBgSAULM+gIjd
 7t+NIxm+dw7a7/4sUxFCKtApqlwh5Bbm7WGaYn7/QNqXS61Jnsc3dsbWXLdJCKWJSze6
 Tixs9YBihIb9987elPmSxj6cUYwUgR29XvdYxkLuXbZKEoFWlqQGhyINWtpsvs1BVho7
 n/qzZCPpOHF8VMWufdw+majD2W3iuQaodZJcTv6ltf+tTfRsJd/1EtadWnLVBJx/afLv
 wSbNJRvZGS9Ng+ubiwBdcnxxtDzEmaat526D07fR7aU1AWVkeJO2u2OAmwTwvKfHQrAO
 WFsg==
X-Forwarded-Encrypted: i=1;
 AL+hErFtzfgG7DeLoqcbv6m6ti/sTynd5fQ568pk2bRDqQVcVV5ewIfZGdoaMfbhkKO3JHb5uswLxVQ0dV4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9PLXGFsl1rKeFDkTEgL6cBdkj1YEKpFZwa68uTgLwo0522tIXo
 f/suOKrnNJi8YQThCzHKlAuo3lfq+sremt5kJGgJE4qrAULrJzUdaIAlrUeWPEsH
X-Gm-Gg: AYBFou1LtVHqTvfTLIdWwJ/mIle9cnAz0bcBUDE9phSEVdfMwIgj745DsMmzygBbQk6
 SMLkbVL4alaAZ/22tvB0X0NmRbxaGBCafSIbMlYDZIxfSRtsEM460rSsNywgJ3foSG9eYo2m/2h
 H8HyxSidqN/7n8IDtZ3S8U42SxugsaMR0HBqiFt53/yAfTI4ky4dOcphGNCW49sMQ9BUa4NON/T
 ZaCBbGjuHQ1aSMkGmdz+sF3xX9CBUevcocOGhi1j2TV5+54sVibr4uWgRzuKLPx1lxqtNT1sYwC
 fjfZJoUkRBYQZZzkEqLkcfZZYsqxGKTmiixAa/lKAvKZgOqAg66f1tvjo/QZ0ZSrlo3o8QVGUIo
 Vb1Ks70KHuQyj35nfaQ3hdRQj6chGL97mPevN7S58s/OO5+1IJVdvh6OhtfTAJG6eOGN9LCAFfV
 XRPI700IG/5wx/f9YbqwM3Y+gxCDz6/dpaHQvtM4v0kv3Ij3vLkZIj0hUWk5D+iMGBtUE9HQv0t
 r4drWqG6mOUTy9W8gJhAk5DIQc1pl1kVGmtCUHlMyJhTh32bFeicz8+sNnZXySZWtyL2+FTeUAU
 Ms0uymelP1L2JPStIZYGq8f4/NSoi3UHEvY=
X-Received: by 2002:a05:6000:428a:b0:491:8462:20be with SMTP id
 ffacd0b85a97d-49c70de380emr7607960f8f.12.1794590252163; 
 Fri, 13 Nov 2026 09:17:32 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5ff2cd05sm5564816f8f.31.2026.11.13.09.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:17:31 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vkms: use the gamma LUT of the state being composed
Date: Fri, 13 Nov 2026 17:17:25 +0000
Message-ID: <20261113171725.235403-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022215803.621996-1-oaroraetimis@gmail.com>
References: <20261022215803.621996-1-oaroraetimis@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

Gentle ping on this one -- I have not seen any comments yet. Would someone
have a moment to take a look?

Thanks,
Oarora Etimis
