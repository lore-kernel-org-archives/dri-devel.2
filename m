Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADCAC44508
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756F510E7D5;
	Mon, 13 Jul 2026 07:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="ItAoIiEQ";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F9210E203
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:21:04 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-51bfb91795eso9176311cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1783718463; x=1784323263; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
 b=ItAoIiEQ/+GXmABehvT8ccjsETK/kcscSUADgRwIpQ3kzagaklNOavsBujwaAazp+X
 2iqGEh3Wj1EEhyv2y0ihtnEQ7VYHqOqzq7BNkKczn70yMgkC3OpCRr6Lvv6Wi0Uhs9mc
 DoIeu3u9hEOUx83epg2pG0A17JoYdcQ3PEmOcGbZSdGYaxbVkdECN3cOnZf7CUcef0pW
 fQrt9jisB1LBZxf4WvKYEgSGMFvg3vDWI+e9EII7LYF7GN1O0ozUc/Q8O5wzT+8/uSZn
 MHIem/+nvckyYRIDc+0JinlQgtzxpJECD7rh5Cud+qAX03IhSfzsNibAmz6knfTABjQR
 Y5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718463; x=1784323263;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
 b=j2v4H3bdjiNePOPEpBR/ESodg6T1D+n+FHcndzVJkGsPRYTwVawx9csQ6MxL6I6Nvz
 ycWSh+/5XDpxKNaLPYU8dpkEZ+JUPkLKTZARGomjsSsGBao4+GO5TC4JeEhFWRRO2wKp
 FgFt2jxuy4pHISa83Vn1oF4c73OQQOeOnIJe0Y0fZFCVKXsHskAApKRY5D1LChgzSCtd
 yicxDjMjlCYk2NG/kg+NGrP3WSJConGqxpFerVemBVcoV6kE3jB/TR4IQT9XJtNz8gww
 /4S57WaLHhZutaH7wClIUCDo5B0amtvhQUjbdS5gAmC9v0iMDNcemIalg1yokxOieRTb
 xNkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvpCpg0i58KGYqWH3sJA2py1H9CFNkrqfuUrva5IcUuvAxf9PuisF/RiQHmz2NUrlUGnHUjY3YLmc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOGsIDJD/qZ91SNDLy44mzkg0DZGbrpzH7IJ+j6exAnZkX8ot6
 rOzCLa1RUaINoV5Ed+Wyml18Fq7ZlEbE+MCpOVXxKe9O/iDR49VSY7kmO888lguvsJU=
X-Gm-Gg: AfdE7clExSI3TsdqohMju1xKh5SDC+V+c9ferK6TBBHsCmMLc9X62o7OreCEg8cxbNq
 x1TNAU2DsmsPW2p9YyEz6hlYJGdlgsnhfcB7/zfxLGZsmexeY4/I1nc2LPkccJc+uVIyR9LI4zS
 asSGIi/tu772ytuTviOVcqA4mRrKpSB496SSHzcqviqBpoxZ8X450Z4QqGjeVqMTeW2tj5MameU
 B0yaI+9KLUaJ3j5lPrzzvgBPCBVAic4mJV4uHP0/xfsbxAkY80BSQ5A6jnY5pGWcyzVXlLqG5CX
 0DdahZ9aTvcScSkvIMlW7TdGe1Aun/IhTGvDL2Qak4KNyNZyZCCFjL6ZFBKA5jHqlcJEEGeaXzf
 GOrkuK7/rpTikl8BUFDfp84HAA7RIRJoq5w/07onKFCtgijeLJk7vsjeMrwHUdRDHGUEqjINaXK
 zeaIQDcgvYbtwAxymelEN+4n/wG3teZoGArzKsgqU0OSmLcFtdfEqnyukRXgugar49xcck
X-Received: by 2002:ac8:5ace:0:b0:51c:7b11:41ae with SMTP id
 d75a77b69052e-51cbf2dffb2mr6287721cf.74.1783718463047; 
 Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caaf621e6sm23894971cf.24.2026.07.10.14.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:21:01 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:20:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 iommu@lists.linux.dev, kasan-dev@googlegroups.com,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 26/33] mm/vma: update vma_shrink() to not pass start,
 pgoff parameters
Message-ID: <alFiODVaGwd_wYl4@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

On Fri, Jul 10, 2026 at 09:17:07PM +0100, Lorenzo Stoakes wrote:
> vma_shrink() is only used by relocate_vma_down() to shrink the tail of a
> VMA. Therefore neither the start nor the pgoff parameters make any sense.
> 
> It seemed we were passing the pgoff parameter solely to satisfy
> vma_set_range()'s requirement for pgoff being specified.
> 
> Since vma_set_range() is now isolated to vma.c, we can simply introduce
> __vma_set_range() which sets only vma->vm_[start, end], and invoke this
> instead, removing start and pgoff from vma_shrink() altogether.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carry over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>

