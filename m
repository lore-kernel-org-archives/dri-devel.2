Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6B2CD3446
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B129010F058;
	Thu,  7 May 2026 10:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o3WSAUkA";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC7BC10EE36
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 16:47:58 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-35fbca04006so3487217a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778086078; x=1778690878; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BMbRicsmqm4MzHYDZN/YERLhC9G7DFrPOd780YtnKHs=;
 b=o3WSAUkAP6iVjc0WeiId+OToBAn2KmqqkXZYG7VY4SuWtMatkLg6V873DuQ/YJHDfk
 GV97E3lqtYYHPDO3jbkiaxb7ZjDWW1eEPYW4XQqUgVjnqoEIy5XfOU+7MZp0VnXJSFWp
 1Ol+Wbq+hTMkUIgSvAF/otz9T9HdvbI65ewTWn8ftx8yil7PyL+viLnWMxm32KtjoqDS
 JzKgLt8gTnuSMEcduYEOONnAr1FI8f4ydXzM4LWUsl/KMXmVAio0k+73mn9sqPBPpuKQ
 CxjMZwUOTctHZDfHLGAqddYD85E/3YXcsTysueQomlTCQzCNAEGd5u41t/XTae+iYGsE
 S6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778086078; x=1778690878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMbRicsmqm4MzHYDZN/YERLhC9G7DFrPOd780YtnKHs=;
 b=g5VxHKUn15w/a/Gk+9Q+O3s/r1HKYjn7QGMwnYYMZuqC70J+LOzbQsUN0euWC5HPXC
 gYq9/DQ6W80owGSXwn5/c/oLjS4c1Qyom7zGeRHbw9gt6cTcdMYdUem9lu7gVkWaPhHY
 TCg0aRdxTv19dkV23w2NJoK5Pl+Wv2vFEFSC3VDNVA5w0BrXUEjMHwsNjrjWre9b1Vpj
 hRlEP/KVh4ilJN+lBJv25JlSrLurA2GC08JOHnwCLPkjF9qkop8zFmD/cUGQxEULxGaP
 YAGlvZirWjXxYXrF14ycgGghHfPAaXO+6GDggM661ag5ty8N3Z3EDqIJtMCnQcZVQsc9
 zCRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R2BxzJZXrCZJfJTGJ7MqLsQOwsoi86jlJt/ppuDDFes5iGNNBS/te9gT6YJcoOtwL3GH5qARNO7c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNcIIZULDs2Evt3EBhNHnt3WqCyY36LtKv8XDUxqjoY75/sAda
 ww2M9n61ZMHj3pQaYZpA8YNiJ2eRBCvBJ5UPCoEvLt6Joapp+4DwPYuT
X-Gm-Gg: AeBDiet4RgouVM7ZPkJEByKV2rC5g8yxU8dAJZ43yDgp/sL6hGVj4HH41P8pOjx0UFg
 gOg957ZP88RBhJ6bt3eJZSsFUY7Oskzuf8/Fu8aIsEQDvH/N96IY37PJngfTT5YQt6TpJGV8L7L
 iYpP0ZkM8AUHMuOo7av7wAHzq31eUCe+aIZayrICG6gdPxJHPs3kDHUCbNmJ0JZwKCoSWSBdmQD
 Jv5KOaxa+Ko/Eg6v7vo/4ZSZbmAloX1qDQCnhKFfqPiUHksFV2TjmK66o47vXLgoUYRdrWzGqVV
 JZzTGtvzW48QxySegio13H9Cu7LaxHaKBQL9mkGxAvopKvoTyYxQqD1ivIgrNsnOPr1XnwY2Io5
 bzGQ2iawZBeFD8MuN+l3EhhpDlemEPLT66UiiPJMfKx5jNLxXFNJ+8vs8iX9stp6aHuiDN/COM0
 pgOf0StitdO2J6klA1cKqigjvDFvfV/pzzn9WCdyAc6qGnIxk7tjcCYbkUBvn48Mmw1DL/PlxQu
 vB+gVrvdQUP9pyG
X-Received: by 2002:a17:90b:1c8b:b0:365:a5f6:4a5c with SMTP id
 98e67ed59e1d1-365ab9b8c92mr4104026a91.1.1778086078112; 
 Wed, 06 May 2026 09:47:58 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-99-238.dynamic-ip.hinet.net.
 [36.225.99.238]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365df6f88cesm1024275a91.3.2026.05.06.09.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 09:47:57 -0700 (PDT)
Date: Thu, 7 May 2026 00:47:53 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>,
 John Hubbard <jhubbard@nvidia.com>, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>,
 Timur Tabi <ttabi@nvidia.com>
Subject: Re: [PATCH v2 1/2] gpu: nova: rename drivers to use kebab-case
 convention
Message-ID: <20260507004701.G4851@cchengyang.duckdns.org>
References: <20260316120820.2117081-1-yphbchou0911@gmail.com>
 <20260316120820.2117081-2-yphbchou0911@gmail.com>
 <DH56PG8GLW4X.2QMHJ91J9D29N@kernel.org>
 <DIBP25O5HJ09.2SRQU8QS7VUDN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIBP25O5HJ09.2SRQU8QS7VUDN@kernel.org>
X-Mailman-Approved-At: Thu, 07 May 2026 10:13:17 +0000
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

Hi Danilo,

On Wed, May 06, 2026 at 05:20:58PM +0200, Danilo Krummrich wrote:
> On Tue Mar 17, 2026 at 5:06 PM CET, Danilo Krummrich wrote:
> > Can you please move this into the second patch. Additionally, in the second
> > patch, please only keep the Kconfig change and use the following in the
> > Makefile.
> >
> > 	obj-$(CONFIG_DRM_NOVA) += nova-drm.o
> > 	nova-drm-y := nova.o
> >
> > I.e. keep the directory and filenames as they are.
> >
> > We can use the same trick for nova-core, so we get nova-core.ko and nova-drm.ko.
> 
> Do you plan to follow up on this one?

Sorry for totally missing this! Will send a v3 patch by this weekend.

-- 
Cheers,
Cheng-Yang
