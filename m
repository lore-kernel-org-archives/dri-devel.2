Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2F8C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3C110E7E9;
	Mon, 13 Jul 2026 07:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OcgZfLzC";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C9110E707
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:16:44 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8485fad302bso1581329b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 20:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783739804; x=1784344604; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FBlRq40n+WQNoah/jqkKv0Mdb6DSXF7flMHY66vmfak=;
 b=OcgZfLzCM5pp62rEMe7uHm6TGnAG+n81jcNeTUO2pE/r9v7Lpadbhp0BhUNsW6latY
 xpCOT2zYk8Aav/NNuMk9+J652S5NWFJUL/g5jqW81PbdLiKQ4dz7kd0WqgS5JFtzcYft
 pVmWtmikEFerrS7MKxYFtta86CeDhRAqf2a4mNMrHygCwbWOOxFG29sjVUpywqhr94rv
 Nu0ki0iS+HnhzRa8wr5sMCe5XV2yjb84WmPtyM33Pe7RakqnQsuIjH47pjaPcvHkMOR7
 EqQkGxPeQzwC43NC40I9zcWRkwWHbF9TX3x0pvdKOec73w3RzSxQzmNSv14fabWzwUtW
 pFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783739804; x=1784344604;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FBlRq40n+WQNoah/jqkKv0Mdb6DSXF7flMHY66vmfak=;
 b=DulDpuolLyv4wwapqNAR8G2nEDEaJ/I3XruRzbjyYhXZrgL8m8yigPb9h5m19rzHRb
 C8JE3rfI+Ofl1yQnW7C5TUPDYCp7f3EO2ThkhjP86ZCKoBH1QqotN5LJ6KanmOC3xQBS
 9RkLQJdBTZDnjzwB6cgiWz2RxY7THbaQljzE2B3NmvYCXcMKsO3Lb1686OOpgFNZQsTn
 ozks4ysdHJFTUSQXvRsJPqIkAevHaQZdyFsgNs7VrPVa32ga9ly3mdRYe9HwE6zy/fVr
 8dT1syFPkIRYhK1OH9CI11gbFYz8wZABG4/VxHI1GfPh5ZVcML2yNB06hBqGVIsvhgZr
 TcoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZPhRKCLvwNDCSOF4qohyp5FmOyLUlSfrGHt7DAcB90ZGwdNs0ENMhIxZcq2WUc3vBLalBobaKM4o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywjs2Y0g64xQ5E40P7dkTaCapkUJCpaQKBXCt7OyMVCz4g8Aump
 s9RuTHYrS69RWEeUTZrvashUfDqZMg+01IKI85B5hcy62gg/FCKmAeHN
X-Gm-Gg: AfdE7cm7b73qkRwidLuFQgbgCFCY8d7x1W6pl+XNwWPqVnk/cdnVF36Ij8+1C5sZ7AE
 Ov9O0pnfCnai6shPrJyQUu3Qfd4byjDYDKc5WpzDJZKNjp5gqWn9xhzPTBoVENotfJSW9P3WqxB
 XgDcfFZ3tKBl+s7bSAQDFjg39GKo2I0pVgYK3DAwraMCu2dTTARhc2BH6k1SsRQuMDgnAeYUugx
 QtoejvU2hVnt6rPSqSv853avJ77+IgW0XL5eMgTWBmSW2MgjWnTDv3ynCx3HpBwFeY95httznwB
 ki6MURFi1qCozSu9D/FYaPA9bdXGFVxYqXIxP7loFqmxI1nSM6xcd0+sgImv4qrSWaQxrRqn4My
 ZJmekR5HeFLlOCSyj7VWwtKriwO4fSdUJqNzeCl583PpuFNZdcTlfY6ifxsBdaJsGArrr9sT+gT
 gUT7YF0lZCvpyr4uDHqwxeorIKwF0AXhHHYG8MegLe74VO5z5xEK4lxGM=
X-Received: by 2002:a05:6a00:b4f:b0:848:2f77:e2da with SMTP id
 d2e1a72fcca58-8488979d33dmr1391764b3a.67.1783739803838; 
 Fri, 10 Jul 2026 20:16:43 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84870d76ce7sm2041406b3a.55.2026.07.10.20.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 20:16:40 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:16:35 -0700
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
Message-ID: <alG1k3JsoywE2CBM@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371881847.900500.8789369230260725500.stgit@skinsburskii>
 <20260710151222.ddb35eab9c81a8720491464a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710151222.ddb35eab9c81a8720491464a@linux-foundation.org>
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

On Fri, Jul 10, 2026 at 03:12:22PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 14:26:58 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > @@ -683,15 +683,11 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
> >  			goto out;
> >  		}
> >  
> > -		range.notifier_seq = mmu_interval_read_begin(range.notifier);
> > -		mmap_read_lock(mm);
> > -		ret = hmm_range_fault(&range);
> > -		mmap_read_unlock(mm);
> > -		if (ret) {
> > -			if (ret == -EBUSY)
> > -				continue;
> > +		ret = hmm_range_fault_unlocked_timeout(&range,
> > +						       max(timeout - jiffies,
> > +							   1L));
> 
> "1UL" here?  I'd have expected min() to warn, as it likes to do.

I'm not sure... The "timeout - jiffies" can become negative.
Won't 1UL convert both of them to "UL" and thus make the comparison
overflow?

Thanks,
Stanislav
