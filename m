Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E63C44501
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F6510EDFE;
	Wed,  1 Jul 2026 07:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="IWJdyc0a";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FFF810ECB7
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 15:46:53 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-92e65e18969so87971285a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1782834412; x=1783439212; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z3V1BQpPjw58FUuLj010lwChkcBGTpKii5KT4CVPULY=;
 b=IWJdyc0ajYQyNTOKUvd//r/GVKafs+Vg5vZhE3W8RVYs6KFjD9R2lAbKMW3FXE1gEV
 qt/FNs5WHTnwNQ5dGDFr0MGeXWLqvZwzD7pVb0idXivWoqHpgYWpRZriJ55IZY3JvaMg
 c5RtmOiweRSgFyTcruKhUJjc/slOSBsCNzPTj7CNMe7aKhp7I+Kl5Hr4j8c46KZ4KEKa
 7cdd9kWZARRQzIc2d3TqRlyqueW6ta/AXPI1cu+g0SkvFGYImGIjXr2jxQh41hFlCPMZ
 XxDx08ryDdLymmAnPbTn/u2D8XHkmpsbjwxMgicaX7iavtRXrHZzve/py+1ogElyX4U2
 q0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782834412; x=1783439212;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3V1BQpPjw58FUuLj010lwChkcBGTpKii5KT4CVPULY=;
 b=Qb2wUv2JjZCm13ByekZ3TAkhj8WoLTXwqJXpwpW+Iu7RxKYTW/smva+lirpJGvSRyh
 0dKugC/mWvSpPzFW35AFAp9JmQjWQ1aq44wuVtjLqAyEoCZpv0hVpT0t+wHuA6jKg1rM
 KSUjxjPLx/Bo+IHo+kqpOUBCk1twmqjfDZtIdqyWIwR3VlLrqD98U0VCD7NjhfUmKySA
 BHGGAAUBpZSU0ijqo396wf9xRKFANOeNsz4QQymtc9LQ68KkynmujKQXA3et3Rgmn9KT
 L6vb7XXFk9xdEaX1mUwBFia3QCPw/O4bNS6uqJu92H5CNH8822Imz5eicn8EoqVyuVgD
 oSUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FBhcBDqdL6TTfFk+/M1chMmbSw3PveNquIRTaSlf6N9dtkIYYprJTrU2F1GsI3BFB7SqUnxBhLfQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMa39SizekP+m6gG5PRNLJkVdv6C8wHBOZmw7Hjk2dWTileaku
 GzXRoii3/nVdYtoyupjqtgYUqa91CBeXkLWIoIHp1cGPozOUBOebZuOByClpunnfUIM=
X-Gm-Gg: AfdE7clCWNn8Tjx83gBBuzsGDx51fn+QAX5oCh24qHi7UW4aGKRFSMgQLRPRQZStbVE
 3rwesn0F+2QBn42mUcCDTyVS9jYS96R+6PJcvGFKzuA16WwGFzHK8lQeDvdzK09djih8lXZFqAU
 Ja56d5F+oCYqBYxf8heibBP6sH/bqiJYWdjdh4gI2S1hfb1//mMi0O3TulDK64sFUdJ5RMIxjm5
 dlsVn8LdE4pf7rO2m2Qxxz0MHNVuJ9fFvgqygjS5VvvelV/bcp3ahZskXT4rBbb1fO2TtG6EHJZ
 E0M6COdnJ0cQsfo/18dEc1B5a+VwRlnlsJ3rWj38nPjD7TMpRRiGTgQJq4Kp3EmJKf3Garejxhp
 /WrhvyWsI0uZJfEmkARrgWza8GrUl6hjWzxd/9ySybnHFtXd5JckhOohqQhOxEpTwaAii0OCfJU
 Ky1X2PYu8MZqGV+ngdVlM4WYQ3HuWStC9bA43QUR225Tdik801IMyDBNJIPnljGTP0cVwB
X-Received: by 2002:a05:620a:2913:b0:915:a47c:f721 with SMTP id
 af79cd13be357-92e6974d636mr316697685a.21.1782834412151; 
 Tue, 30 Jun 2026 08:46:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e6233a5acsm267797785a.35.2026.06.30.08.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:46:51 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:46:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
 Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH 09/30] mm/rmap: parameterise anon_vma_interval_tree_*()
 by anon_vma
Message-ID: <akPk5o_gHD1SxX_0@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <1c1df7b905ef340cbf2effef769a4e770a8e0eb1.1782735110.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1df7b905ef340cbf2effef769a4e770a8e0eb1.1782735110.git.ljs@kernel.org>
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:10 +0000
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

On Mon, Jun 29, 2026 at 01:23:20PM +0100, Lorenzo Stoakes wrote:
> Similar to what we did with mapping_interval_tree*(), let's declare
> anon_vma_interval_tree*() in terms of anon_vma rather than rb_root_cached.
> 
> In each case the rb tree referenced is &anon_vma->rb_root, so just pass
> anon_vma and the functions can figure this out themselves.
> 
> Additionally, rename 'node' to 'avc', 'index' to 'pgoff_start', and 'last'
> to 'pgoff_last' to make clear what is being passed.
>

would it be possible to split the pure rename changes out from the
changed function declarations?  It's hard to pick out this as something
that needs to be looked at as more than just a %s/x/y/

> +void anon_vma_interval_tree_insert(struct anon_vma_chain *avc,
> +				   struct anon_vma *anon_vma)
...
> -	__anon_vma_interval_tree_insert(node, root);
> +	__anon_vma_interval_tree_insert(avc, &anon_vma->rb_root);

an annoying request, sorry

~Gregory
