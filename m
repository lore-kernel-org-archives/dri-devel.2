Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F174C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D7410EC77;
	Tue, 30 Jun 2026 12:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZpHACfw0";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A929010EC77
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:42:55 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-9217d13c276so321068285a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1782823374; x=1783428174; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DQO+LwB4rlmVUEVrQLIA/Kr74YcNiyTBCzOFtX1NQKY=;
 b=ZpHACfw0Ly0Kyvir5DBWTTxacTps7g1TFlW1gaZqEm5s/xL77fJiUJFacElYWhXDVx
 GGcTUobjNQ0IrfeTRij83LpkjGc+nYFoJUaJRISPrOusrk1f+2eZcR+3ZSp15/v+CjW3
 wL8r7VygY51FrdNLUcdGGm/cR7QGqAUh65vPr48RcKm3TkHEKbCK4vbI5hsHmAHZtkOe
 0lFRfX2GLix6b95tmpvjc+JdTGsDUGQHDxCV71kmV/ccsd68iEcY8uYDuGxikGnXkqtj
 BkLPonwzx2KvXiufhhohwQQ1a90SfHjStlEx4SuOCloa1UdwGV504CD4DlSGgAWVzdJX
 okhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823374; x=1783428174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQO+LwB4rlmVUEVrQLIA/Kr74YcNiyTBCzOFtX1NQKY=;
 b=Xp/mpHYccYXd3BdEbcraR6xR3Y85ULBOoqF1BXa/4pHBh7LC1M5tESb/0vlm/UhDZx
 ZjR7ZCKMnT3iBcg1q3Z2nOupbRfGUckjQnWM6vWrtbh1rtnwrtpSNnCEf95VWhF7UuEx
 XV3PsVp3PQLpfMOyxgSw/yrSZWy56Ko4+jPmFW4+/CAp+QEY6POe28I2IXTOA0KHkRPY
 we3tO3b7xU1MUHOMqY9euj8bRaIRo9LnT2dAFmZ+g7HTEQvMzv/CjxS/HyP3jd2F31be
 hpK7p6HpMaY6LyeZDqoOaHawQ8M+oU2aWSDhDn6BaO17KGeyrzudKRHI1Nu/A8W5FaHE
 yiqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ865c9oBWVTgZGCKsbnzQS+xs+FbXK4RbuNhaq4tYtV+iCBLps9d4xbFoZrh9PsQ47AcVeyorYdsvo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzz35APU56hqa5HKwzO5+oE9qZDx55EtkLHlIaWcKaGEPEj5ldc
 5h2TzgdW+q16u4odhgo3ago1BoGPvrEgs4nuh8J4pCZHJezq4OmFzPjNvZVMjqZlMs4=
X-Gm-Gg: AfdE7cn3CkTRk+OHA8WTLY7rpLqydv+YZ/sQ3u9xFHvI+h4hWbNksHvpM1h6gD8G51H
 cFVd8V+Iz89t6aJDjMTaty5zQ9nFRbnfOxccrpGxgD3IEyL542NtafzlN3w8JbqgCEb2exWcMCB
 e/KSshOiWi/rknHxcjqJjIQVhTM0qzHYwCuOQkBCbtnCtoUMFIvK0QACZOzzVMWoQ1pJw6TzB6m
 pihJvGeboE08RC9BMHb+h6sfcn71bGmqtlUpyN3nyZyDYDUnaXXhBfaObyPEjX/XbF9LJGTy3s/
 Ka3bicROGjGkvWjTGwMa+zlQdr6L4Vbc88zwfZnQE6Wt30UwrApxfqT54uaWnI+gID8EbzwHvmA
 2RzQ1cpNLmSFis7Gdgslg0+l8Sp9A3K6QqtrN8tcqLS+6MIU3cuw3adFJZqkViVWtHE3dHqQ1cn
 OeuzEvh8Kk6B3HFFwy9C2QtAjh23n0tsBi2xsj31iFLX4xgLOyg93JZ+QIKfNBNO/8Lw4=
X-Received: by 2002:a05:620a:8391:b0:92e:4867:95af with SMTP id
 af79cd13be357-92e62af0f9amr515174185a.73.1782823374078; 
 Tue, 30 Jun 2026 05:42:54 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e6234dc50sm226634685a.39.2026.06.30.05.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:42:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1weXng-00000001qgI-3Vni;
 Tue, 30 Jun 2026 09:42:52 -0300
Date: Tue, 30 Jun 2026 09:42:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Laight <david.laight.linux@gmail.com>
Cc: Pranjal Shrivastava <praan@google.com>, David Hu <xuehaohu@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 jmoroni@google.com, kpberry@google.com, chriscli@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260630124252.GD7525@ziepe.ca>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin> <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623235350.6540eaa2@pumpkin>
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

On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:

> > If we restrict incoming dmabuf transfers to fit within VFS-centric 
> > limits (2GB), we impose unnecessary overhead on the RDMA stack, forcing
> > it to manage a significantly higher number of memory registrations. By 
> > cleanly splitting these massive contiguous device buffers into 
> > page-aligned SGL entries, we directly improve the efficiency of P2P 
> > transfers and memory registration.
> 
> But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think affects
> a lot of io) when the quotient is always 1.
> Splitting into 2G chunks is a lot cheaper.

Doesn't matter this isn't fast path stuff. It is better to use fewer
SGL entries, IHMO.

> > Since this change doesn't seem to have a negative impact on standard file
> > I/O or break existing VFS constraints, I'm curious why we shouldn't 
> > support splitting these >4GB P2P transfers? Am I missing something?
> 
> I was only wondering whether it was needed...
> It does bring up the question of why the >4GB transfers even need splitting.
> But that is another question.

SGL can only store an unsigned int size, so any large physical range
has to be split down.

rdma now a days has code to process the sgl and restore back the > 4G
sizes since mode RDMA HW can accept that.

commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
Author: Michael Margolin <mrgolin@amazon.com>
Date:   Mon Feb 17 14:16:23 2025 +0000

    RDMA/core: Fix best page size finding when it can cross SG entries
    
So whatever this produces needs to be compatible with that to undo it.

Jason
