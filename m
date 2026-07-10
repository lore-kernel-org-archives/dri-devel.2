Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82314C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B748A10E1E1;
	Fri, 10 Jul 2026 16:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="a/JHg6NU";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF23510E1E1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:27:52 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-9030f8ea3b3so6932226d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783700872; x=1784305672; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UNIXCm8Zus/z4nQ3xLBTLCwOawMM/+5sDMMsd2dm66E=;
 b=a/JHg6NUu7yhvFXdHy2tvGQik/CgSEJALWjMKD2fQvsptidTVSoTt3YecKhCncKXwQ
 Ar+BmusXNYMLzK7MHZDWTyOUqW/3l0mO4VMgbStMdgFHm4tZXhJjQe7u7hwwyb043IBn
 BQal+lg2ndjRYi8SaOZkpzkbW6yRdakFmz1D1EV+z/Qh6HruyiOLpIrTqEvi0et3RmHf
 fYI2/GPLYxyKVQ6pWalbQUSjRbVzALZExjjGdGmeezzA5baY/ZmkOPDA8dXBvpIqimBe
 ptfLMlORRRSYNoGf5B616jq358FCgPcLJJJT1tJ9VfSY+S39i+JbTEaTrWoRBdywTIcQ
 fw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783700872; x=1784305672;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UNIXCm8Zus/z4nQ3xLBTLCwOawMM/+5sDMMsd2dm66E=;
 b=AeFCrwfInx13jcLIkn3/6l7nLYgNSat+YJcK0AvbDQgVAKyfuQNKZgpL8ZKR6Y/rip
 x+2age+UrQN/bzg6LP9Hy7foU/9nq9JbgYeIslSq0hofUXqLK3oEfG5oaszzGx+fy+BV
 a6/BvrAICrnjFpDVmml1WCzJLpfcVVhyKebSVkKK9nbhO9dMLaK0vXoXR9tUtfD+JzkY
 BDPnkYiPqplZaSmVtrsrAOFE41F6p10RdYBu3PT8hApIIA23pBy4WIWdYUYoGr8bYGfa
 S99Y1eRcyAnuBaa5x9fe50QtzjGG+0/AUgQu7UMyPRXhQo8RD3zhFfL69lS8KAkYYCFv
 VLBg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr15vAzGg+6QBZeGVYgxed8hgMiBXovEfzEGVnE3KQk5ZYDutvPIdme9O0Vxr1Ih0155HjrXvkSTHY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4RrjIouJHVPEoXqbwDfxp1xsf1BxYyfZMg6FCbDlnSwNa5DXy
 WAvYQcN6da92th+vWp2kbFJdIbVndad+TaMTrsbEoQ7CtY+VZ4fX+ZMyIZgFNf5hPwk=
X-Gm-Gg: AfdE7cn9YwXrw0lSHSIy0sCaM3yj0q88pStnuTSPf3nWNFDd2mfRP2o/rFlEsgoo4AB
 FPc2u7A54eP7atF2bn52AsQWnefggGFXz17M65rz1hemVGQrwqVd4mFAjGd7v54b7iAQZt+JT10
 JHJ7y4XnYmlAOjQl3KR3aNtx3HseQ9UuGZgBOai+IQBQMem+eUM17rzK/807W+z75Mej7qaDizj
 QUA0gaFQb7Qp6IWh7JULZU5RJzHCgrcb5d8HLD9vGYWSWfuDm97mvHdasowfsC0p1w5f11+KSoC
 pHGHnIgt9mmUY8KDrgEw+gcKAaCFXiiwhE8XvhMlLn35bvOIKlZztABIEKoOX29EMSKzJ8brJPv
 Y2EBSe9p0KyQ4zYZlfJ1DDmEe6y5m7ArDeASSESf/c70L5X9xvEZdwIdptFZAU2xt9HP5J0w=
X-Received: by 2002:a05:6214:2127:b0:8f5:eea1:6f04 with SMTP id
 6a1803df08f44-8fec3522cffmr120531466d6.54.1783700870475; 
 Fri, 10 Jul 2026 09:27:50 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd50e081dsm44781476d6.9.2026.07.10.09.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:27:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wiE4r-00000007XPF-1WDC;
 Fri, 10 Jul 2026 13:27:49 -0300
Date: Fri, 10 Jul 2026 13:27:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org,
 decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
 kys@microsoft.com, leon@kernel.org, liam@infradead.org,
 lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
Message-ID: <20260710162749.GP118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345362182.660027.12809852179204464964.stgit@skinsburskii>
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

On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:

> +int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
> +				     unsigned long timeout)
> +{
> +	struct mm_struct *mm = range->notifier->mm;
> +	unsigned long deadline = 0;
> +	int locked, ret;
> +
> +	if (timeout)
> +		deadline = jiffies + timeout;
> +
> +	do {
> +		if (fatal_signal_pending(current))
> +			return -EINTR;
> +
> +		if (timeout && time_after(jiffies, deadline))
> +			return -EBUSY;

I really dislike there is a timeout here, HMM is supposed to be more
deterministic. GUP doesn't have a timeout, what is this about?

Jason
