Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38917C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 00:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A70910E788;
	Sun, 13 Sep 2026 00:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iCny66GA";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815B710E7A7
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 00:50:56 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso833945a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 17:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789260656; x=1789865456; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uZqrmQnZ68N7oDm3XCrSRrggNkZKtA35ciFNphe4Q48=;
 b=iCny66GAvW2vqeDbJsPpCL9Zf9vhee5sLIEJ3vrk2Bq2ADjv6+A58ObRA1DaY8Zs1j
 5CYob3rXGsOiJ6zwuEk5QEIwOQEhQ9jcsd1SIiDikb7h9PtnQIu5YAsjOAF478s4nRQI
 ayGyWMeKdF+YH6RXjAqZ8ArAgOJVSSkENiMBgkyLrIEYc232T5wrXbwMheOa1S/AhI+i
 cczJYG6IlqzoYibwnXMm4UVT4hHnIRS5QIKhuIUuI7jE51qVkGjD2rYJH5qVQ/AfbQXa
 caT7W00aljVd9z3w6nGxfd4VNSoEkCTinwLKVqiNzzvaE5dIGT7o0JS2SecyMTRKB8Cb
 1RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789260656; x=1789865456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uZqrmQnZ68N7oDm3XCrSRrggNkZKtA35ciFNphe4Q48=;
 b=jX0FlGfccZWn9FTwOMpdr1jtvXMyAd0a+l00pIjxXbFGj8QmdD32ABS/9UiDJtJjKB
 p5EMr6FgfNKRfiPjvBVSug940ilKaaiwAgmOl4kz4rccrV4JO5Bl29vS1ULYBOqyabeZ
 hzcTNwx1wkTVePOxZUQ9aMAHDHAVlKiU6ohduG+sGMjXAV7hpdhgIcidnrCgwtbsKgru
 f8p0X8nzQAk99jJhWyg9DIfr/X7d4N6rFntvnJcpR8/Tx8SWYLd5R/24QzEGj/vVBUI+
 3PswO97ILgRIkwb28l5H4DudxzUt9Iq3+CBKi15L3B5KdvGrmWSEA/wMaSa5AEuX4yjH
 YgRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcOTZbsOGpmjlylkgElIyx65KfFiFoBjDI++gpba0L+eMrX+Mq5myntY/S5kSXiuXcfhoODO0lacU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQmtR/3GLHyTsBWt+izXzoqp95RFK5aY1+zE0GpZvz6bJiSQM6
 scKOqnICja6O+so3bVXVtjCkFCa5uZUW/pdtEXCgXsCDPE3OYMPqdoI=
X-Gm-Gg: AYBFou0RgmruFzY0oaZOJngolF4Jp9TcfzVKOOahrGvTpP0+h/bpcpJsyoYb+iuF4VB
 0KArihOgXTeaqKATi+ABpk7EMDmtwqXFSqTV5yV/1QnmI/18R9d/OJ7pFdiHLGuSHe2vrDl1fC/
 vSBrzpsBG4HyENOie8YS1hu3zgc4+vuyb29QDT0F1Z/7ShPfdtkh1KPwFXDQ47bt6cyBFZIZdUx
 z+yVJDjVgVXPwbQ9W3OC3aggbztJ1FlJXR8NlGosmUPnfPKD1S9MdGcnXMK4a826Uu5HKV97Fux
 DssNJz5uRmV4zM/lAa/VUv1GbCoAdyPh6AQmkN/wWms/WpFlbLhEyan9sRNxklWfiyGX6FFD8Ie
 kSjVaqEw+JTJtFS5o0U5clFcLks6YYRG1s19BtDiU3eRzbxtf1HNXxKEZPGIn3j5gC7UTKrQ4ud
 TU5ZkAjaL4i2TK0Yuj/c12fVLWlaMXT3qGSWrv1mnJgfBUxE4omm2O+rOW/K7DPdh7gORoloIW+
 elpg03b6UJVWU4Te0Bc7ARc8MTF9uSXyPIU
X-Received: by 2002:a17:90b:560e:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39d9c3a1fc2mr20056368a91.24.1789260655987; 
 Sat, 12 Sep 2026 17:50:55 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.205.210.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm15820897c88.10.2026.09.12.17.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 17:50:55 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: 062bel313@gmail.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Kenneth.Feng@amd.com, airlied@gmail.com, amd-gfx@lists.freedesktop.org,
 atharvatiwarilinuxdev@gmail.com, dri-devel@lists.freedesktop.org,
 ed@aicharmers.com, linux-kernel@vger.kernel.org, simona@ffwll.ch
Subject: Re: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
Date: Sat, 12 Sep 2026 20:50:48 -0400
Message-ID: <20260913005048.1167-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_PNt5Huo-bk=tqdCLorUp3BDCtdGmaFJDxfVbcKx-CPoQ@mail.gmail.com>
References: <CADnq5_PNt5Huo-bk=tqdCLorUp3BDCtdGmaFJDxfVbcKx-CPoQ@mail.gmail.com>
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

> Applied.  Thanks!

Hey, so im the author of the original patch:

https://github.com/t2linux/wiki/issues/743#issuecomment-5347204171

The author of the patch mentions this:
> Combine Atharva Tiwari's delayed-UCLK proposal for 0219 with the Navi post-init implementation for 0218. Retain the revision restriction for
> 0218 and the revision-independent 0219 match from Atharva's proposal.

So as the main developer of the patch, i would like you to remove this patch,
as it dosent give me credit, and also this is not the solution to this problem
as i have mentioned here:

https://github.com/t2linux/wiki/issues/743#issuecomment-5608044095

thanks
