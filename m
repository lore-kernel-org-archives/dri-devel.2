Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C7606A330
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BbHNJlPN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8C910E4C7;
	Sat, 14 Nov 2026 02:35:25 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578AF10E4C7
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 02:35:19 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-37986eb6fa2so807060eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794623718; x=1795228518;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BrzkgDtWmdDQLLKKJvsVZHgpBzkxi812kF2+E/CI8dg=;
 b=BbHNJlPN7449SMB/dfIDxmjxqqW6hxtvzlSNLWZy8sPsPc2xSXRnSEgcJULPOuaAfl
 T6+RtmClQC5tIvIHRm7HfDXckjN9tIbjErGyfEi4ZtGxpmFaC2T0Xc1wkpTx12tmRoRz
 ykVRmVK4MTzGOlf2VmA2NkHpzxZkakx3he4Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794623718; x=1795228518;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BrzkgDtWmdDQLLKKJvsVZHgpBzkxi812kF2+E/CI8dg=;
 b=uYRnKkzD27TYkQC7FjD98rXPNIU0HzDDTmHqU6L2C2crl7oHNcAAP1PVsdqGI3NDRo
 jupdZ91GJ6+UsG+qpQL0hV6gMOwnqtAaY6IH1q6SSkxhLGVbGw1juNCi22Ife3Xmfbp5
 x9CcEcDFt3VtGFwLLoQhi3ORpgjGwvyh3O5D8QpZ+Vl2yOyedJUDz9cctFQ0obZ10Ocf
 jbEokOMGsvN11IVS3BxH5D2SuGhx+M0SEe/hN4/i7yDmqBQEk8dr2XN5uKZxg8gfYAmS
 lZ5gZ6GlbXJ5aZjgQ/8t50hzlDl8b/zyZxbAJ4GhwBz+wD0/Cz1HoShLnr3+63RWDxaa
 ZAiA==
X-Forwarded-Encrypted: i=1;
 AL+hErEZFMSnKH+6WFsY09vBZHaKU+m+xR886qKjq2Ed/eW57oDfSkQ77Umr8hwkjLyY4VczMv2lOIafEZk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+mo3w1kbiEEp60kuhQBLTlB7aZlAtfCyvT3RNZn63QEYsAHSTj
 fkV9s6YVUUcEe0Y7xtWHEsWx8ql14GiZnNAxybLC96np+88enzFGpHNz3WVUi160Fg==
X-Gm-Gg: AYBFou1BUxifDOzML/Ds5Ya2kzgK9HKfiuj3fEuAwvooYZ6g4mHx17L1ykpXEPe4rOR
 ruTS29FFRAGb+GIs41qYD48Uyx3cMBiblAvM3h2PbXvnFWM8Us7WJc2QW24O6HgHoxhNucdezDo
 vk6udKbURN4zU98pazwP+F2tT9KzfAFsUq07btcOr/XIW9ru5hb3IvM6rqOZFFcjcW91iYXejVt
 Mj9JJPvaHJBaSn38cfxGQOXEl3403Uptyzw83cfS1tAAdSyCu1xvAZRx7hRm3A/r6hapuJaaZKt
 3FSxG2UXSl9N9MfftWh2OGWcY6HaS79cIRxoJwvZpFi54EEpZWgdnQc7annSWND91EhQXjdRADb
 6WULkScM5XkAArO1czVHu5LthDghsjDX+gK8uu13ZqHIAa3eycHo3E3HVJ0FoP938oK7MFzNa1J
 gj+cp9I2X4sJpCmATzk74vE5dFIAw2Axs5H46GfpIT6lXvQzWkeIRRwQinyVaTt0xWWgdWko79Q
 +8MEZnAS6qFsx1eWhhAKbroTX9UC0JBKt3EjboenJ+BDgqTcPqiVYiCILQYk8RMVK5wNuK7yMoO
 rk36TGaTjkAlxahwOdWVV7dKTtMr/S/1I00TzPvw7nSVSmnA0bopdYJCSBfwdaPn78P6Ww==
X-Received: by 2002:a05:7301:9e4c:b0:366:dbf9:32bd with SMTP id
 5a478bee46e88-37965da96cdmr3175541eec.9.1794623718394; 
 Fri, 13 Nov 2026 18:35:18 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:d97f:ef68:a8e1:6af5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379558231eesm11080880eec.12.2026.11.13.18.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 18:35:17 -0800 (PST)
Date: Sat, 14 Nov 2026 11:35:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
 Dongliang Mu <dzm91@hust.edu.cn>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, 
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
Message-ID: <avfImwT4gmBYdNv3@google.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
 <avZyo_hCRonuhXW6@google.com>
 <179457128804.2142163.14813125534208665209.b4-reply@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179457128804.2142163.14813125534208665209.b4-reply@b4>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On (26/11/13 20:01), Xueyuan Chen wrote:
[..]
> On 2026-11-13 11:19 +0900, Sergey Senozhatsky wrote:
> > On (26/11/11 20:41), Xueyuan Chen wrote:
> > [..]
> > > diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
> > > index d2bbecd78e14..4c0786378dc3 100644
> > > --- a/Documentation/mm/zsmalloc.rst
> > > +++ b/Documentation/mm/zsmalloc.rst
> > > @@ -33,8 +33,8 @@ proper handle-based APIs.
> > >  stat
> > >  ====
> > >  
> > > -With CONFIG_ZSMALLOC_STAT, we could see zsmalloc internal information via
> > > -``/sys/kernel/debug/zsmalloc/<user name>``. Here is a sample of stat output::
> > > +With CONFIG_DEBUG_FS, we could see zsmalloc internal information via
> > > +``/sys/kernel/debug/zsmalloc/<pool-name>``. Here is a sample of stat output::
> > 
> > While we are at it,
> > We use zramX throughout Documentation/admin-guide/blockdev/zram.rst
> > and in some other files as well.  So let's just replace user/pool name
> > with
> > 
> > 	/sys/kernel/debug/zsmalloc/zramX/classes
> Zswap has its own zsmalloc pool too. How about this?
> 
> 	/sys/kernel/debug/zsmalloc/{zramX,zswapX}/classes

Ahh... zswap.  Good point.  OK, feel free to keep it as is or
to use zramX/zswapX.   Up to you.
