Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9071C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44AB010E1D1;
	Wed, 15 Jul 2026 15:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ddqtysqt";
	dkim-atps=neutral
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7778810E1D1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 15:02:14 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-737f6e70678so3880086137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1784127733; x=1784732533; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nGecurzBYdjUfiEExv0oL4FVVbYZSUEIMh9OhYH+0R0=;
 b=ddqtysqtjsXrr5GwlWp0+DlF6mKnACHl34D9wMG+qCmaa81DisL9WSThEnKKY76pyX
 H7AAu9FMT5shPwPI0gLYSVEwtGvfo68ThzXxYVsXSDH2WnVSfvPEvWjgQor9wKwCYXXq
 4JD2/zb9JbmkSVMDCduLbKlC04lE6ahFxxohYH0vvHWNai0rq14EM1xWawXxYAZ5d7VP
 BH1NGBy0DveYXQEV9kXKj65sN66VlTOtg83jC0/qbo2voLjPWsuIHw1iQd0ZmEuzMYRx
 9MKHN5hU6Zs5oZlEDg67waTt2bO00NvuHD4ZmLoXca2JnwVPoC45RnQDvZrZkOmazycQ
 eSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784127733; x=1784732533;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nGecurzBYdjUfiEExv0oL4FVVbYZSUEIMh9OhYH+0R0=;
 b=To55RVUDhK/SI1LAp9X4Ip+OQI7EBHDsFkQy4ZLxoNkdM0PAjheWBjpt0EpnawoUQ5
 pkl3icpU1vq5H6Z8pBE5jZnufhF/ZVSsE3kc7bjdG7gooklx7ALlJNzqZ/JPjBrWqP26
 XmAE80YEaECk8oSybyQrR5yUMLjHL7ZhQtsjZ/mO9GaFnvYtqoIjCP09UcJpPOgJ958V
 1Aay9BfMnhMtjPejrd4GP37ewHNAAdxrvNPberUtpVOGivHtizVvqLvlil/jnmEs0yOL
 ilRcCwxlp+RCDuiax2bGPozuX5gS9h8E6wXLW3AvyYR263Ov+zbasbLIPC7wyw3mU0Td
 dKsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTuI9RHx+1A8G/BqL2S8RvDTpOPeKR4icniWprx4VWC1Soa5oRTZVWEkPDNGeGDHW5WfMZdS6xtkE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/UceoYJYdccko2hMmIfLZfjXFn0xre16wlxIRyys7hNUJY9Ca
 CIPXz2WnWpn+Xr27Esy6fKpiDe9jbo63mgBG1tjToe1rySxeLqosEAPaGaANYNHwHHM=
X-Gm-Gg: AfdE7clXlWePg7s1zdLT5vp2SiNhMP1nQu4CYqGo2xC5NgKo34onP5Lh/9crilI1/yO
 Xn8tQPXNAQEC74wj7oYmdCY794OHg6g6dBtIIjZprH152mLRwz52Lb2AORTiArzazNqV3ynSwNy
 zSC2VDf20Wcf7KBJ19BxBf4m93O/SIuUZ/WDmn3eSvTSMKizQZUTEsK4kPor9VschmFwBSu8clv
 K5exxRoan7d3aGw2R/pBRappwT+fKTfZMVyU88KDWfHwsg5f8W4XZ37kCVBHClNB6FpnSXqUvW5
 efpfqhauvg935lErojRnz4UtxkDZkR8Hw2yG+ynng+21y4pWBAOge54wF2r6n7RUrU7w2vBxGS3
 aRJLr2WNpqg8O1a6NUByggAgS/OSgCfBxdpn2RYgHTGdH3oInIcKa/VYutJwM
X-Received: by 2002:a05:6102:d87:b0:737:9edc:36f6 with SMTP id
 ada2fe7eead31-7458757b204mr4167130137.26.1784127732764; 
 Wed, 15 Jul 2026 08:02:12 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd50e0811sm196100666d6.3.2026.07.15.08.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:02:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wk17i-00000000TXQ-3Nvp;
 Wed, 15 Jul 2026 12:02:10 -0300
Date: Wed, 15 Jul 2026 12:02:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, airlied@gmail.com,
 akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org, corbet@lwn.net,
 dakr@kernel.org, kees@kernel.org, leon@kernel.org,
 liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/4] mm/hmm: Clarify notifier retry state and scope
 HMM timeouts
Message-ID: <20260715150210.GA3846105@ziepe.ca>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
 <4300f09b-8f93-4605-b072-7c09a82cb16e@kernel.org>
 <alecaJ1FUso39D9k@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alecaJ1FUso39D9k@skinsburskii>
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

On Wed, Jul 15, 2026 at 07:42:48AM -0700, Stanislav Kinsburskii wrote:

> > > Stanislav Kinsburskii (4):
> > >       fixup! mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
> > >       fixup! drm/nouveau: use hmm_range_fault_unlocked_timeout() for SVM faults
> > >       fixup! accel/amdxdna: use hmm_range_fault_unlocked_timeout() for range population
> > >       fixup! drm/gpusvm: use hmm_range_fault_unlocked_timeout() for range faults
> > 
> > Why a fixup series instead of properly resending the full thing?
> > 
> 
> The goal was to get a Sashiko review, and v8 has already been applied to
> both `mm-new` and `linux-next`.

I think if you send the whole thing with a base-commit tag that
specifies a real base commit in linux-next sashiko should work

Jason
