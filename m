Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87A606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvNug6ll
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2E4112106;
	Thu, 12 Nov 2026 12:57:01 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FD8112025
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 11:26:28 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-36e90071735so256075eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794482787; x=1795087587; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2nWBtEEn4hd48cIOC+JW/bLoHA1gTBtQ/8nPmmpZzBk=;
 b=YvNug6llRyc6IaTZaL6NmE3fbulMjx5El8Pah9bagHDLlcDNphvm82R5/Dmxkjp4Zb
 mj2DI6Qea7roh265SNr1IWQxxQsCs5oI3BxAekV3SzPISN2aZBObOr2bSTNI9Z8ptd1T
 /TYjS+I6/Xdo9YwQ7HpbgAfeJCta6NLJ37v6fROqTmHdkb9IJe+MifPW0I1pqUo5wlzN
 Yr2C8IDibpH47IulIoXS4T1bbymsyAZqCirwCR1GBDZhIS8H0wqFrSxADny2gzt7cQsR
 68hxPI+574kpyQw3w0bUCOEhLEKlHeu7CafYpV48jLmD75fAjQVb9iCk44IzdFI2hk0b
 L7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794482787; x=1795087587;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2nWBtEEn4hd48cIOC+JW/bLoHA1gTBtQ/8nPmmpZzBk=;
 b=sZWVHHjdFvtr7b1JD8YCJqy/gAW/2lLT87QoyR0399yMY2k7W0AcgCyF1zxH1U3P0Z
 vKXMG9wvxb838jIWjey9CXtJTOIwA+4NmGwVSFEJfSQYV4y6YfFF0uUBkW7odNnKw0Yb
 eX+Cz4KUAHFnTT3JcjYWpbhd0OnYLMyi1+Ns2kxJGdB7JbPAsTc6/UDLsTo5h3Pfv89x
 IhfyGgC9lJDdqzVU0fy6SSx6pbQEVoDMYPx9mamhnViIdbVlpcAvnUISxXI6Y38Kd0qF
 f/2IpTGqdFLwyfmvtQPdxxwZRc2UGKXjwYg0PPlq+i4QcCxGubSbDWB9xChuBWsBQSqh
 fg1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEN+SEUCbJO0sse8T90wxHqAUtLnW74ecGT+9GnT8XzGJZqfT90QqqM4QOHe+v4axH4uhDjlVtfb80=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/JwyajXkP4PAgfxJXgqQdeq4gOX+DsW6YsHeuD05/KCpQcvPKe
 Vw27IHVuoOK5mEgGKJSRIstUqBBjCO+ePjWuHDaX8cU88uQiFwpw7xDLpw5vd3Eyk+F6CA==
X-Gm-Gg: AYBFou1gkCj1KyEP+hDcwzcL7vwEeCnHrt+vbzq1lm1Wl06zJj1xHQrogxaDAPKHlzx
 kd0ESgENMrbP48ZppglU9Ex7geB3+MMA7RroYY4gCrztB43jklxiBIFsgJ5pNxYai0RYkG4Wxgs
 DL2HDe82Tkus1DSSNzxezR7w95NDlqmdkwH30cAuwqbuhcfT21GRCUryES7hk6qpo7s5/cybmVW
 YD6Lr8ykxEAx41m0wTRyDj9SFhs1QAfzm5R+Vasaj1vqTMGTXygMtIyQtRtqb4EU17S1qrSrAZT
 akoxfTJRd6vDoTZCJYdUuq0b1n4DE9Cts5r4Cfn3oL6OReK7D/Oo69P/CbrbusV0gUq3OT3+9Wf
 sTHP/xIpDv8KqOUGct1Am8ETF0zJABlCrpZPrEnZS2mHTJtl99YeGhki7YOxDJN4YBSxjbr0oKy
 tTA9uHuusTN9CUX5FjM2rRO2k69hmRY9tuvCp3y3m89OHBtDPYQi7yViTPhNto1MsYmmDAdaJ5c
 u1Cc0KCbYFucVIIxQhPNjK3Bd6fwOzHGs+QX5OYeD4LadI2VSuxg78SVOB09KdqPqGJ3o8sjsFV
 TpnQlCg647758nRV4U6Aiaek4e32WmVWHXhEIg1L5SPv5lRUuGMPtJdUuVe3pDFi0cU=
X-Received: by 2002:a05:693c:8113:b0:35f:ea17:d171 with SMTP id
 5a478bee46e88-37684ceea1emr9219901eec.2.1794482787103; 
 Thu, 12 Nov 2026 03:26:27 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe306e3sm27380131eec.7.2026.11.12.03.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 03:26:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>, 
 Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Nhat Pham <nphamcs@gmail.com>
In-Reply-To: <avUet_6jVqlWSP00@google.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
 <avUet_6jVqlWSP00@google.com>
Date: Thu, 12 Nov 2026 19:26:15 +0800
Message-Id: <179448277582.2553194.12524350925159624366.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:57:00 +0000
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-12 11:05 +0900, Sergey Senozhatsky wrote:
> On (26/11/11 20:41), Xueyuan Chen wrote:
> > CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
> > counters are updated regardless of this option.
> > 
> > Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
> > stubs when CONFIG_DEBUG_FS=n. Skip statistics setup silently when
> > debugfs is unavailable.
> > 
> > Remove the Kconfig entry and replace the existing CONFIG_ZSMALLOC_STAT
> > settings with CONFIG_DEBUG_FS=y. Update the English and Chinese
> > documentation to match, and clarify the pool name in the debugfs path.
> > 
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Thanks!
> 
> 


