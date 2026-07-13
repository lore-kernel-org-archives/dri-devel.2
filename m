Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEF5C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1DD10EB57;
	Mon, 13 Jul 2026 22:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aFJqT+dX";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B3B10E639
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 16:59:20 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so2204806a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783961960; x=1784566760; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntUweueTN5fRqaQOoy5Hqmcgc1LaFPt81cAcvUtqRRA=;
 b=aFJqT+dXuuGboFsZSwoJnHWjFRHS5fCNMiU5u9SmvrrYVYjXApZMUVoQzxhj1/11wA
 7OXUzhVieb25IBuwid6MBcKMjvJY6Ffey6J3zu3/6gpEN80B81Ruub2Tb7SpTUzr0Wdj
 ga3tzPcUDMRihri1yY5btb9w0ONABObAWBo6QCWyj7ap3zXPoNecoLMVG/jyB0nMvNR9
 3+f0xdEsJBwgRZ5jNBdhWjJ/2WejFiVlzi8nYurwwpH32Uvb0DD80fQCkILZF+AemB3R
 dydjxM2NFmYU3FzVFbWtiZAJMgNcL0Ytyzaj90UbcdvgrgpKzbxgoSD1GdwC/ov1uFpI
 j9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783961960; x=1784566760;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ntUweueTN5fRqaQOoy5Hqmcgc1LaFPt81cAcvUtqRRA=;
 b=r1W2UD78thYS7zvRSrIdfqZrK2xzr9WOKP5bQ2HoxLDd0NtQkv/28jVgOxjeNQdbzf
 ZGzTXHcbkbVtD4zhsS4O9OcSX+Xf1rUPUwe1gN+ytPk+JQ0954FKKbtxjh1pFcM3smgr
 Ik5U1CfycLO2XPljyZGGwOyLDsL32XxeNahZ8pQ2jtm9PjEZYL3ZS3r05WGn0y2Alqev
 qCtfb+4KlJnr4i7Li0Il+um3qWrh6Ah0M0j1SA5k8XFpzkgK7BhjB0CE8SGOOVtUXOHq
 xT1FGdmN9R8QXT2/yoB4R7x/CTDSw4e75jWHy229AIHMhUXlmFIdGxr56/EGjYqdKDhS
 udZA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrq1HecJEJWltRSM5aYcYbsYsgGHUzTWsvejXw4sHKZKzBivPRRjIJZSfM5Lo8U/4A66AMbk7+suaw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxdVbh6OdEGH1lqVfihvvBaRr6eil2y69xN0A+S4n7zlsRH0YR
 lktpR7hy6qZ9njt2IUub9sQCl07rLHRvGoa0C5gr/qD3uh5UBZZdc7JT
X-Gm-Gg: AfdE7cnBMmEd7Cj83rz/YgP3rCwCDi2UIGXKybMY8GhsQj8r99wrHK6KDNb4rExdrqm
 Uat2mMMvMNDXcgG9oQB3rfj9cd73YYJh+ooEA/adpWCYqZ1pJckN6PbyrMOA3BElrGml5n9hZlc
 EP8xTCnDndCYtDxXOUOYdc2wWdhrEzykRn0qlUE7e5FDxIqREsgvS9pPvIhV8IfyqF5KLiqZRDb
 ihdZ8mdYn9CD9Sksklp9ST7e4fMY+dFzquYvKzJ+KjH5GH8LK6/Qsak7NiLJty+TfMyxRRigePf
 zkIzKhH3ZTyooaxUhq89Fma0sPIGWxWhgrVe5JmHtU6zCqmvBB6cEdzL3I6cJ5qp/h6hwTv0RBe
 ZVYzgnohOijWVBhApReQ5IDHlCX77n8txDhviECMbRrXyWWJ9Vvqp8+jB9yCwMmf//0uXSLi17t
 nM8rZnXXIEs5w4xgxP1DrsDbm2/to75RCwYdIrC8ie9hiH5cc0/nhDC5U=
X-Received: by 2002:a05:6a20:c907:b0:3bf:a1e5:ff62 with SMTP id
 adf61e73a8af0-3c110cdb078mr12110955637.47.1783961960162; 
 Mon, 13 Jul 2026 09:59:20 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5afbc1208sm8643053a12.9.2026.07.13.09.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:59:19 -0700 (PDT)
Date: Mon, 13 Jul 2026 09:59:17 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
 dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org,
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
Subject: Re: [PATCH v8 5/8] drm/nouveau: Use
 hmm_range_fault_unlocked_timeout() for SVM faults
Message-ID: <alUZZYIPY-UkhpY4@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881847.900500.8789369230260725500.stgit@skinsburskii>
 <20260710151222.ddb35eab9c81a8720491464a@linux-foundation.org>
 <alG1k3JsoywE2CBM@skinsburskii>
 <20260710224833.9caf2a0a9906f0515e326a45@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710224833.9caf2a0a9906f0515e326a45@linux-foundation.org>
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

On Fri, Jul 10, 2026 at 10:48:33PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 20:16:35 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > On Fri, Jul 10, 2026 at 03:12:22PM -0700, Andrew Morton wrote:
> > > On Fri, 10 Jul 2026 14:26:58 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > > 
> > > > @@ -683,15 +683,11 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
> > > >  			goto out;
> > > >  		}
> > > >  
> > > > -		range.notifier_seq = mmu_interval_read_begin(range.notifier);
> > > > -		mmap_read_lock(mm);
> > > > -		ret = hmm_range_fault(&range);
> > > > -		mmap_read_unlock(mm);
> > > > -		if (ret) {
> > > > -			if (ret == -EBUSY)
> > > > -				continue;
> > > > +		ret = hmm_range_fault_unlocked_timeout(&range,
> > > > +						       max(timeout - jiffies,
> > > > +							   1L));
> > > 
> > > "1UL" here?  I'd have expected min() to warn, as it likes to do.
> > 
> > I'm not sure... The "timeout - jiffies" can become negative.
> > Won't 1UL convert both of them to "UL" and thus make the comparison
> > overflow?
> 
> `timeout' and `jiffies' are both unsigned long.

Yeah, I’m sorry for the sloppy wording.

What I meant was: will "max(timeout - jiffies, 1UL)" correctly handle
the case where jiffies < timeout?

Thanks,
Stanislav
