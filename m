Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B582ECD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E04210EAB3;
	Tue, 16 Jun 2026 12:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="QHdXLbGR";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87A310EAB3
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 12:40:21 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-517b1f2c6adso43738781cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1781613621; x=1782218421; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tPbjX8dfzPLu8onhnfm0DNzfCkJoWXqGLy1Lxvc2NUs=;
 b=QHdXLbGRwDzgvjP4d/nuuSx1tuJI7/pik9fIp6TMxwUyCBic2A9Vnh5KqWFqnZ/5O2
 TOIsZDuSI99vwI5Z5G4CFWZMsh6aKJ5CvDKSc2yn7cpjoMDYB7LhTkSWPyFvoRSlaGzJ
 4VDHUI4jHTBZaVZ/3Mk1VsJLHMqheDCb1RMpqeZAk6hGVIZ2R8EGLPoLpEyYxGoBVgOb
 8QKZL0vt1xhJ2vK6B/l/Ery/SRFMgoZwZ/ElxOp95vvoSyfvhEUt9f/D2nUR4sz0UnyF
 auIXj/gkyxBp6nouXkdju+VKg2DR/akR8S1ac0GivoqffeBM10tt4lOEA2RWvrH+1zJt
 38BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781613621; x=1782218421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tPbjX8dfzPLu8onhnfm0DNzfCkJoWXqGLy1Lxvc2NUs=;
 b=YUmgsIzQ8JBqnd1RHzn1+8boNl6dNkHh3Gir/peCPl/VidE6FtKtPU1NYqZQHDTR4+
 sst/gnLNaR2JdQe7ZhJkyYSlFyyRcbvmGrB0jEUD2Gw76keP1PFqcY6wY/ZcRpCEaGYS
 3yfXs3VNYeZkDj+Blc1JqfZYwf82ghgC9/MgXanDfogv2I0ZL2lF5s4zanDx7zf1EZ91
 U6OvZXc1/5rgEDNBoQgufcZVX2npLEV74hkvkGwsBMEp2+aQZegNIS025Ly7idcFD/jT
 MsTAIfv0lA5q+6iIsFJHL/JRUUdOKm8femjpcM9UjTHmpKyhup2Z6288RYRpk5WdRAFu
 zc9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+H7iXEMjAEdmyxwXw6R9eS3KQe3ujdakL7anV0rI9+7MUxtWT/LHMzmaBBzPbXp2jVHI6z7KBtDWI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzL1+MdMW3t3R5NIk0+rQ0TfUTDwK541uMmDtP5CIo6MOkPMM0u
 keRLeWD0nivWW7dzPJorDUMuMIx0ty36hT7SG080c8OqIp52aQWKHdBH2k61FiVaJbY=
X-Gm-Gg: Acq92OEhraoE8TnhV2aOf1BUw9fVeWjz0wyaKOI3ekirDV+zA5KlMpV2XU7cnL+1BK1
 2DNGwn+SSBb/aeqwOISEnBQE7Wxq3e9ez95bVzGhzFkZgHD9sDwlGvfhp5etx4XxNw3JMrfoERJ
 E0GCzx7xQ0+r/yru8i0y2m61pY0wIt9DgKAHse8IWNxnzmQUF0zylqBvZhvcosJV1gDF4/rTbbr
 ClPsJn5Nh2pWqu1fl3Jtn9sFXgSgW9uRPXZmJBd+XNsxEyds3+73xhzFxfVoyojCAD+B9X7TE7n
 XLDD1oBXIH+83RUt9Ck5K3CkH7pzzRAAV+tB7ulKZwmhFzcrq/aTEPThwL49JNv3wKCiXEM6w2c
 bTIbAv5vInnYIZdf51poJWSh1SORj5COuVgbnJJar9yVzpfX0tufmniJX0B/J+VfZ8NsQ6f4cuP
 r4eDpZ+4cUKVfEkd5cXy5YWRMHPIWbZori1pacM5XF/Dncmb0aG2NEia2CcHieelK6O4u/uWyyy
 3fMaw==
X-Received: by 2002:a05:622a:2282:b0:517:6804:1fb3 with SMTP id
 d75a77b69052e-517fe230d82mr282972431cf.18.1781613620607; 
 Tue, 16 Jun 2026 05:40:20 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb61d948sm133785221cf.1.2026.06.16.05.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 05:40:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wZT5X-0000000Fzb5-0uZr;
 Tue, 16 Jun 2026 09:40:19 -0300
Date: Tue, 16 Jun 2026 09:40:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>,
 "razor@blackwall.org" <razor@blackwall.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "almasrymina@google.com" <almasrymina@google.com>,
 "matttbe@kernel.org" <matttbe@kernel.org>,
 "skhawaja@google.com" <skhawaja@google.com>,
 "dw@davidwei.uk" <dw@davidwei.uk>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 2/4] udmabuf: emit one sg entry per pinned
 folio
Message-ID: <20260616124019.GA3577091@ziepe.ca>
References: <20260611-tcpdm-large-niovs-v2-0-ee2bf15e7523@meta.com>
 <20260611-tcpdm-large-niovs-v2-2-ee2bf15e7523@meta.com>
 <IA0PR11MB71852246277F773AC41DAAA3F8E52@IA0PR11MB7185.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA0PR11MB71852246277F773AC41DAAA3F8E52@IA0PR11MB7185.namprd11.prod.outlook.com>
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

On Tue, Jun 16, 2026 at 06:04:03AM +0000, Kasireddy, Vivek wrote:

> > This is helpful for importers like net/core/devmem that expect dmabuf sg
> IMO, udmabuf needs to detect whether importers can handle segments that
> are > PAGE_SIZE and set the entries appropriately. Please look into how the
> GPU drivers and other dmabuf exporters/importers handle this situation, so
> that we can adopt best practices to address this issue.

Importers have to handle arbitary scatterlists, devmem is just broken
if it can't handle the output of sg_alloc_table_from_pages().

Jason
