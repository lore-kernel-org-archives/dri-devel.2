Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96024C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FF910EC18;
	Tue, 30 Jun 2026 11:08:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nzulU644";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E11010EC18
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:08:28 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so37467565e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 04:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782817707; x=1783422507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMWydGJ/5vZA6A1OvcajkdrQDyn8CAFtASnTxLQovUY=;
 b=nzulU6441WXB5BTcB6BXRJutU0DpeaUphvi6wQSuj2cxPTpCvxbYbWDIoCMd/lGoaG
 KTDpRuS8BRaPSMoX4isquNlgI10TINnVMETb/3M7+o/hQo9FThzXP950Dufi3RK3Easy
 neIvJ32nwMrsVKCoEpG9Z/FiV3JztqvMMyN5NragKhE74XtWsRStquUo0M5NxTllf9X4
 5r7nVdq2s9PFS1GzUmvRB/3A+90XUWy9XHFkDeRabEKpschv5fjUnYJFmzFo0n/NbjIb
 SjRknaOzxgaSUeKHI60bGm7JDnpCbfLh+ZFvgFNTejFEVHbfxm2h1GEcxunwNww1JKNm
 Z4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782817707; x=1783422507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XMWydGJ/5vZA6A1OvcajkdrQDyn8CAFtASnTxLQovUY=;
 b=A0gAgpkRNCXD9MkcbYRcuMqPr1sjMKw2rBhPdME4WBpSMRa99IEPgjNVQxeM4Vbius
 JKr95lCM3Q+yttHLYFbsfTVKZnP7okgrEs2H0qNghyUj5yJYVShYwdlq0SO/bvr49RXw
 O2LQ1VtqD1iFxbtEPSlyraoctBH0uAEyAmtjxNsa1//aID/GIE8d+4AvpfI50Li7RCoJ
 z/AeRb74coQmV8xyBdx29DPeY1Nul7kBqytvDgKKvCzC+IP6d4YLOaZk1DRuvaaM+9YV
 J7lWgCyAys3Lgryp9yUzo0JbHubIlNKDp5aBz3TimSDKweutWheBD0jRR4srfzbUI66N
 tMpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+630U0S/xknYbQgo5mmBpWf1gUxU/oOyTq/XZbUByBRuDKAtU6bnJD6P4UkRgAT0A9aIDbLzl/OG8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzem6otmBx8r8i2ixBJzNJPhp8ef48JFPg6AnmJMrCtw0AKnJMj
 p8+uHDcMV6qMsJEppjKWi7b5p3WaWZSjaGyZrwN/QbG/nAsj0/MmH0+l
X-Gm-Gg: AfdE7cloc8QJ/+BvBIDvgsZYuvQlxnESehfNm66J6g8F5H3c9Nep5b7PWWf4PeSrVTJ
 VndEObr2hnKD94nXkrce5IQgV6LYFqK1k0qeGvwz8eeXvobmRcuZPb2XhoHByMjU9iThbfPLF0u
 fzT4Sn8RcbQJ+sWO/wZ2mz+b6A7yze+Y8DVU4bmvZPkjRGRb4zdWvBJ/dCKmqY7Kp4TB21uajXC
 SxpryTNOBYZ7xmj9sDWGml0b4BoO/RzYpjsLMtIsgteH/IhX8ZzQ2lp4xnR6TVGt1Qke0nf/fte
 /PZTJ6Cx6cajgkheJat1ToaEXjVRmeixBhaDVbVbB9DVmc+JlH0ZNGYaRyVEz7a+Sxax8IH8Y+1
 ctK0rJCpAQtw/djaINjtXp+fKbJA6TqSsYkLup2ajm6wqWSd2AjW6XyiX5Mn/whuZyX6Zqa2afu
 2Ey2GfCiyTzekhjYRnmOnWImYvCqM=
X-Received: by 2002:a05:600c:1f8b:b0:493:a438:7f98 with SMTP id
 5b1f17b1804b1-493b82acce9mr47208375e9.18.1782817706582; 
 Tue, 30 Jun 2026 04:08:26 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8d0462asm61791645e9.11.2026.06.30.04.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 04:08:26 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 1/3] drm/ssd130x: fix column and row end address in
 partial updates for ssd132x
Date: Tue, 30 Jun 2026 14:08:06 +0300
Message-ID: <20260630110806.23204-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <87echococs.fsf@ocarina.mail-host-address-is-not-set>
References: <87echococs.fsf@ocarina.mail-host-address-is-not-set>
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

Javier Martinez Canillas <javierm@redhat.com> writes:
> Up to you. As said, I don't know were we draw the line so I will let you decide
> if you want a v2 with the tags.

I don't believe the usage was enough to warrant the tag, since the LLM only reviewed changes I'd
already written and reasoned out myself - let's keep v1 as is.

-- 
Thanks,
Amit
