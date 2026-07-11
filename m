Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16F0C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02BD010E7BA;
	Mon, 13 Jul 2026 07:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lVVLr9b2";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79DE10E717
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:19:52 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ca64c3ce5fso18530475ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 20:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783739992; x=1784344792; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CYTaMzfdKXyQ96IWRR1Bd78qVpBo65z/nucHslKEHMk=;
 b=lVVLr9b27LXGDr9B4nnT9eA02AX0bhioCbakpGalCwbm9ZoRsFYC8taEE+dIuqPxPF
 RQWnFvwv7LPxPPjexTXWHgmyFxKfpt/yti9iJweb/3hbWW/Dc19MinS6SYW+XGTCWuIk
 livck9mQR++WVtS9zCpKD3kVoE6QSn4YETj1bscRPY6H4ZTBrS/pcSB3FOXeVlf+47mE
 Iqu3Of8YQn33VoGIOkXmrbw8asi6araXfkz+Yfm255XpwM2nQ6Dqq3zRTb8XVWs0aQY/
 SWXLSj3S59aTVACGLIWkFn5l2lzPgJSdTDRGxg+J+o89W2YM0BGQ8prvhcjp46X7Gp02
 fn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783739992; x=1784344792;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CYTaMzfdKXyQ96IWRR1Bd78qVpBo65z/nucHslKEHMk=;
 b=LCEOPjdi9py2P5kXtCHMvnPsSEkP+xPRYAC3/SmXRWRyY5ELklaRx/UN2fLtBosncF
 jqk8UIrDk5PS7/jDtiz3yrg2O4hL0VCxO8UeCFK4aXEXgNogQNP7ktR6F9DIF7cOMOmp
 6b/2oeoEFTxv/1c+cO6VBiYnaVH7g3fNSjkCEnL5D8trmdALMf1pAsWzinSLvnKLCg3p
 PXS3yjIE55315GrPLkbOCgQABsv1K/tEO+//uxzs+MNbBnWvFHVxdIJjVuNaYQT02eT2
 p9+rn1F/gCxvw0fUftoy4CzYFyI3sxEar5YpEfnBjegAcAuXykMmozTDmxgsqf+OFhSE
 WY0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2G7C6rX5qRHCaBCg7gw7XmybioRIa6X4wuLveIv+o+fm38V/HJzglWqRGt7IAlHL2iujdwcw8KF0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6pGjo1AelqctAwM4qiG6k1E43TGS9zSDEdPrxOrli+Ljl8gb/
 kNy0J512rs3cCnTM/NrUza9VaxCUU+0tXKrrLQRn+m0ZmYopfj8IxTdC
X-Gm-Gg: AfdE7cnEDLvfGM8xPoaTDpVpKb1fGHI5B+2YDHUVQgn996OhiX0mcdEqTpQAwntc/87
 qbpsb1LTirKPb2c0PhCkuvgsb6Eqd8MXOg/A5wmLNofVNfm32mxNzfPegq6DfldoG+o6cstA5B4
 MgoLmkuP7VVwS9BVvHIEEePBdxfuUd/6tG6RuT5WWI/T+1BbcRx+PalzJ/zaVXe+wXx2meRDxoQ
 HJT77EqCndiqQG9JapN+/2Hbp8kfkrvXMx+yjEe2Fi3i1/WFYR6qCBd3LxgqNp0HmM0qvySaiLy
 3q6vt0K2DE5OEsomAFmLn3k8PbDItURWn+Xq2H0fJSZEogfKCDSIwIbsGobmspd6Ah/ahudmjER
 VWIMD4BgP/gZDULvuvvDpjr0DCqHH6sV3didki3WlkzZEAZnwhYbEp99k55LZGUKLCVma1bBwSG
 MjezpKdHyPCCWgIqag51mdFead6eehFNkm7dweQtNKsfVxVyMiED9JSA0=
X-Received: by 2002:a17:902:d2ca:b0:2c9:97a8:8c1b with SMTP id
 d9443c01a7336-2ce9f2948camr16114365ad.46.1783739992132; 
 Fri, 10 Jul 2026 20:19:52 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d5bdddsm67571165ad.77.2026.07.10.20.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 20:19:51 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:19:42 -0700
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
Subject: Re: [PATCH v8 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
Message-ID: <alG2TldWdL8Ez8Dq@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371883276.900500.12789147320642521200.stgit@skinsburskii>
 <20260710151228.ca22e127b93ec5c6d591fb5f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710151228.ca22e127b93ec5c6d591fb5f@linux-foundation.org>
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

On Fri, Jul 10, 2026 at 03:12:28PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 14:27:12 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > --- a/drivers/accel/amdxdna/aie2_ctx.c
> > +++ b/drivers/accel/amdxdna/aie2_ctx.c
> > @@ -1061,22 +1061,11 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
> >  		return -EFAULT;
> >  	}
> >  
> > -	mapp->range.notifier_seq = mmu_interval_read_begin(&mapp->notifier);
> > -	mmap_read_lock(mm);
> > -	ret = hmm_range_fault(&mapp->range);
> > -	mmap_read_unlock(mm);
> > +	ret = hmm_range_fault_unlocked_timeout(&mapp->range,
> > +			max_t(long, timeout - jiffies, 1));
> 
> max(timeout - jiffies, 1UL)?

"ma" for sure, thank you.
I have the same quesitong here: will "max(timeout - jiffies, 1UL)"
handle negative "timeout - jiffies" values correctly?

Thanks,
Stanislav
