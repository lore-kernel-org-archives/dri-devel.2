Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7269CD39418
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 12:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C337410F26D;
	Thu,  2 Apr 2026 12:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LAEQHyEQ";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D40610E4E8
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 12:58:20 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48374014a77so10446545e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1775134699; x=1775739499;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UzYbx1sEpC0M+peXKDrwMMEQ4PJH/E0owphKLjh5Vw8=;
 b=LAEQHyEQd7kfnlxYIRuG2Hv0v0UEg1pvI51djPjMhUrVGCrD4jj/pWW9Ud+xTPDReE
 vgfIwLyWa1umLjnVTmam4d3srEfwlPFhr2iSgE2rVZDNU7Orj1Jy7k2n5XWMof0t+oe2
 ZVjrXGJb1x1IPpmpMwozVc40XnSUBXgIr8LCpyCujjhdjX2bIrRHIigQM5MtheO6K8h4
 91VINrs/7oCbqGbDKArB/ZvMNV9AcSRDUT5k+Pp0RbPjz6iRrHRqljLNFLSup29qAlq0
 NXM+cmP5s0UD5nSrAz0WajsmmorCKvV25aAEw+ijYokWKKl8IIq3pBCtQW7izVblQX24
 BhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134699; x=1775739499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UzYbx1sEpC0M+peXKDrwMMEQ4PJH/E0owphKLjh5Vw8=;
 b=FPElpi9rcFo+h7azqs9F95d0E10Y7DflaeQlFHEiTS7ax8elLEu4PLsUQkGhvSZPmt
 46QU1vPmJgQNDEgqiRFdiq3iQ+rc7PZpVfpD9Fii/I6G0KS93vd6SmEcOYVR6A1ge5E8
 hlpHhEH4+K/J/tZ3mgWsO7mcC2P3yyt7Ea6GNF9eOzqnPNzrYTgTu96br1RD25vNdvvA
 CGBdIPDXeEECe2LmJ54mv20DJjVcy97OW4b9nvbQjf0WKMh1ujCSeIxCo8L5QtYWePji
 lhCC0cQFrAm90zVS8wN3fGY8TzKDVqNHCsP9erj8UNe0GbbaPktKfSyMhHbJrk+KbB7b
 Zj7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXENFse6G5dINubcPUYYqC7J8JZuF9E7tT9kCFSLCc9Cab/OAjtuDgdtCXmC44qETjSYfsbZCQl4Y4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIdhxeS6fwxFrdVtDK0Th0LB0vSSqmWS3RP/E/osu/N+Yrb6Mh
 SVhAv+Apzy7ykpa8mpPGmLFSL6sobbqyphTigJbDm5XeewwZ90HvL2sZfHFERwG1fsk=
X-Gm-Gg: ATEYQzzJB9fc3wkUMVI6Ykz9IYtyXE6ARFD1Lt5wp7sk5VDPhpeUx6mK9XiajOhaS+z
 LqOSzGd5NWiQBfpB3ZD8aijT03DyixzhngiCmcwgConJTGE2UkdDMlGqaI23tL7w2AhbVoj6+hU
 yj3QLyB5tfzCctRLTT38r7p5NdGkwP4+IjW3nYUkAYJmlasvN5mrhYr7d+MzP0MHlql4am1LxyF
 nLUWdemxwYhMgAHghlUMsfI2d0HsAEz/Cvvvft2H/LQRkYrkuGBkgPHblIG2OTJeyZQyugQtXEs
 5UGJE6GbmoYEH4dDjXdwRz9weDBS5UVk+sFX0sVQISJynmMJYTzEyLChDKMyZKiyYXVU5ArS4kR
 O63jpvAWqQdPstt+UZGxIp9ZTLFjkiaMcuz5waid6Vvs7ihp5c4WsIkw94SNn3TWxX1gGsCnggA
 Xnn0YkQCjFP+WFut/ixKp6IErUd5yWwV259d7uCw/t7g==
X-Received: by 2002:a05:600c:1f93:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-4888b7130f3mr58915525e9.12.1775134698707; 
 Thu, 02 Apr 2026 05:58:18 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.21]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c884f77sm62829225e9.20.2026.04.02.05.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:58:18 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:58:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Brian Starkey <brian.starkey@arm.com>, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, 
 sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, jstultz@google.com, 
 tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
 robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev,
 ptesarik@suse.com, 
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev,
 nd@arm.com
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly shared/decrypted memory
Message-ID: <l26gcpagdhabj6w66hhxzgwkwqlybontqtbf7f6lu2fic6pnu6@crh3rt3j3alm>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <4s75rtsmdfrze4rscbqzyrjyrko7n6sehe7agrngqag2cna5bz@eflmf4kwjocj>
 <20260402120254.GB2551565@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402120254.GB2551565@ziepe.ca>
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

Thu, Apr 02, 2026 at 02:02:54PM +0200, jgg@ziepe.ca wrote:
>On Thu, Apr 02, 2026 at 10:52:34AM +0100, Brian Starkey wrote:
>> I'm not clear why the heap depends on !CONFIG_HIGHMEM, but I also
>> don't know anything about SEV/TDX.
>
>It is because the CC apis, set_memory_decrypted()/etc are slightly
>mis-designed. They take in a vaddr to represent the address instead of
>a phys_addr_t or a page *
>
>This means the user has to use page_address() and then the whole thing
>is incompatible with highmem.
>
>Which is fine, highmem and CC are never turned on together.

Yeah, I was wondering if it is worth sanitizing it, but decided to be on
the safe side, for unlikely oddities future may bring sake :)
