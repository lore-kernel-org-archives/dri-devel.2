Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC4606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tLUhT89K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF524112556;
	Fri, 13 Nov 2026 13:43:53 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0827410E6E8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:02:04 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-37123334649so52700eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794531723; x=1795136523; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QuB4gRralS9yFslodv3QC7A77JieK5X8DdVq10Sbwss=;
 b=tLUhT89KQATtRE+i9nFTAbiSMLlHETbBu6gGc1+apJGX2X9k4aC9XNMcgNaYDMcvbV
 /3rMgOt0cjFkZijAvxp36W0cjXP0UcAqs9WYYPvhnYwWFunZD6KSLSTSD1xtfTOhJSxQ
 Ma1NTNT0hWSW17qjmJIJabC2X4LSHQwVUiTE5GnAfERYOEO9Y6M7vtM5fh8K8Y6JeokT
 CwmfLvt/3MOOC40Cjmp7qGL/Us+v24efav6ljnfQyP8EtmnDMH6Z2AQ8PDpYI2KqmZEg
 +7AhEU1Lk1tGnlids1hsA6usVoHN/pd03QCzCJKcuAgHc0uQOZ6KrBfR12b2hOn2wZQm
 g8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794531723; x=1795136523;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QuB4gRralS9yFslodv3QC7A77JieK5X8DdVq10Sbwss=;
 b=rnpyVpg4xrORG6Q3KXgVItJsIAkIIQ65h0Ax/j98mRDN764Ou0W/tFJkfskikak1Y8
 pBM/NCv+n9XFqFBhjL2aPOhYfGWLF+AWR4flKINDQpwprtr7ZYau8eY6DPHkbSGrvPlz
 z8bq7OQ4BMt80WGu2la2uTLlU07io05J4TjpyYGuBs9piyf+sZ/wGPG7TYjFER0Eug5y
 iLOUhB4RwLSK4FBAzbvUPH6fv65riXK42wg8pUsldp1QQJW3xlZHgKSYDvBECq/isUId
 +/2apiVWGjNuQGsGf1+s+f3m0nQDZV0mbwDVUloOez6l2yAfPmcm8N6doynn7rWDokKu
 oZVw==
X-Forwarded-Encrypted: i=1;
 AL+hErFTpwcCtOZFTpe4zuxD2egcknqTrFiwzK8KLgrxRLZ8Q5sO6rn9OazfOszfaJurF0k7YurrB66uNro=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Jc/7bmLR2nlmuq6qP+LpXD4nwqeYd5a5TNoN6kL5i+4jGd2t0
 Oi0utarlyMNkqmLRb+OFxSfBPsMu6Kcbv2Cqy18yUBTn9b5Jy4LgVtSpAiPmgx7z9iX+RQ==
X-Gm-Gg: AYBFou1kkmYTjsDqbQM7KciWijtyDRzzUMirvBHtaTmQzeArww4Gh4DU9GN1Lp3wb90
 hyh4QYVFEEvdAiIougjTg9m1p8ROhjsi4naZCyeJM8+6J3LpLWFjEftuwIbfWs/xAQ89K3Wh865
 s8dFgnRxEMiHMMBMB9oeenVHiYgccjJsrt3KmRz5jpbvV8W+GMUrYiHM4WYoOeFXcSxRHgexcGz
 DzdFIB4kvTC9qnnse7uqlX2xV1bi473Qjzbu9ldkUn+l9X/qVU2RxTMceRxAZ3jpJpUwMdmjrdX
 hz2gbGhJWeB7myJqgWct2T0En7CA9peInb82FI4TTtzFk4Dl2Phfl/YwPqfklRAPSON+P6T3tbM
 zobW0DEgQa9ouZYiH0MsVaIb/ZuYCjJjpCdPBTVgMgbTjVSEO8/ZTzCiL8F9ZGTWPXjbw+/G/L3
 7FmX8cTHCglwuFkqgbPH6nFnkNOc4t00qeiJvueemOak1kwdvnvsrlzwDPsxAG9gPgB4DDawyh+
 B/3mV6XQnZQLj2FLIDx4UYBzPgjP2w9xQxOMv8KrixNrwuglIY22TxgkQkRU3hYNCUNGEB7G3Si
 sIiI0ItOpUiu88N63RnRYg0nmuRh0NyPDq7KnZEqY6RL2ncKeGOGrVfRDYDxtImBwCUb0GYYeRU
 roHxeRRHWh2Q4
X-Received: by 2002:a05:7300:c00e:20b0:35e:d21c:f33e with SMTP id
 5a478bee46e88-379651ecb3emr1356356eec.1.1794531722833; 
 Thu, 12 Nov 2026 17:02:02 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332ae7sm4453590eec.8.2026.11.12.17.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 17:02:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>, 
 Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
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
In-Reply-To: <d812b71d-b7ec-496f-9404-add2282105a6-agordeev@linux.ibm.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
 <d812b71d-b7ec-496f-9404-add2282105a6-agordeev@linux.ibm.com>
Date: Fri, 13 Nov 2026 09:01:51 +0800
Message-Id: <179453171134.2553194.3867422839676762696.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-12 13:29 +0100, Alexander Gordeev wrote:
> On Wed, Nov 11, 2026 at 08:41:26PM +0800, Xueyuan Chen wrote:
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
> ...
> >  arch/s390/configs/debug_defconfig                |  2 +-
> >  arch/s390/configs/defconfig                      |  2 +-
> ...
> > diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> > index d44674b63715..83193ef8efb9 100644
> > --- a/arch/s390/configs/debug_defconfig
> > +++ b/arch/s390/configs/debug_defconfig
> > @@ -100,7 +100,7 @@ CONFIG_UNIXWARE_DISKLABEL=y
> >  CONFIG_IOSCHED_BFQ=y
> >  CONFIG_BINFMT_MISC=m
> >  CONFIG_ZSWAP=y
> > -CONFIG_ZSMALLOC_STAT=y
> > +CONFIG_DEBUG_FS=y
> >  CONFIG_SLAB_BUCKETS=y
> >  CONFIG_SLUB_STATS=y
> >  # CONFIG_COMPAT_BRK is not set
> > diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> > index e00e252d4694..694a309377d5 100644
> > --- a/arch/s390/configs/defconfig
> > +++ b/arch/s390/configs/defconfig
> > @@ -94,7 +94,7 @@ CONFIG_UNIXWARE_DISKLABEL=y
> >  CONFIG_IOSCHED_BFQ=y
> >  CONFIG_BINFMT_MISC=m
> >  CONFIG_ZSWAP=y
> > -CONFIG_ZSMALLOC_STAT=y
> > +CONFIG_DEBUG_FS=y
> >  CONFIG_SLAB_BUCKETS=y
> >  # CONFIG_COMPAT_BRK is not set
> >  CONFIG_MEMORY_HOTPLUG=y
> 
> So DEBUG_FS is selected unconditionally? Please, drop this for s390.
CONFIG_ZSMALLOC_STAT used to select DEBUG_FS, so I added
CONFIG_DEBUG_FS=y to keep the stats available.

OK, I'll drop those lines from the s390 defconfigs in v4.
> 
> > --  
> > Best regards,
> > Xueyuan
> 
> Thanks!
> 
> 


