Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12079C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95E410E7A5;
	Mon, 13 Jul 2026 07:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fjj8Z7j7";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1E110EF83
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:48:47 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso1044420b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783702127; x=1784306927; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h/T7cJaVh+vpdnCnVWowF/GJXIiYthZ82xWXxPXNVVI=;
 b=Fjj8Z7j7RTjr/BMUJIKXxTu7gJa4aRmlP6+mdUFqNSP7Dx45qNsFSIxG2Sh0DlFRV4
 c0+pvdvpXAH9d9/qcs0LYkoKt8YMRzKSBHLKA2VB7L99rbO7QKvenUsK60nl566batfi
 9Pa1S3DK9IYa5RYk54JCf8FVzuumjmHSpq70C4LkMNduT/auZBxadRht9tncXQ76eNdB
 4alWyTCaSBjARvKpP/gs6G+mZUX8fm9xvblRXimeMmj1fKTY0kkzy4vk9XMLaXUA/OvJ
 2SXwHcnxNd84tAR4o8jxiVHIbdncgJiQnUBlA+pMRY4bWEU6WwS6I7l39q62sXVGCSPk
 iJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783702127; x=1784306927;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h/T7cJaVh+vpdnCnVWowF/GJXIiYthZ82xWXxPXNVVI=;
 b=kvOA9PIxKeN1tNytrTfkdmtCZh6zHKQcxgX2UEQlRE4Qo6qJDXzBLZp5lgE9bUjoNw
 l2+Fue+FSdbgjkkCimx110YjZDgLx7BZdmPB9+5NqlQhzMUl6EFTAX5nbAKLj+LjJF8Y
 8PkPwK6okwNZEH99CgVnQLQDhIpYbyyoOog/eaoTMCIAp38RaAN5aWefTx5lOJs5EaA8
 5ODgCfSepwDGF2uoBkdrhX85rR5tYesDqVZeqstm9M9Mh27TaM6RAjxLqmUlRatvNOCM
 uEar6Lj7sNicRmEXAhC6TU67WRpQWtWfXBMVdzZ5u5veccYYiarbah2ZEDkvFIoUXEUn
 d4bg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoANy6rYv6s8lRmfbd8wFZNznZbf66WFpeyMCKnKVHHvPFc8SjjTohhvmCDwmO1VnlFeQ+W7M7eUD8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxhr9aC+OTqs7oVO1n/Kk7OT23P20DMJz2kAZ5frJJM6VnYKNdr
 KycJUVDX4N2/rQWxqFEtIRc+4ZaVts1GOXPOX2TZ6UKCZ27SOHB3b3Lk
X-Gm-Gg: AfdE7cna+2HTXF7ULCgR6xnlLRAVXr4YBJlV3aF5XyogU+5VAJebbKat5hjxZbmkhDE
 q0ujLdV06C4MxTFRy1OBDyP5U4S1YFRMuc+T9PrKfebRtuwVVB9uELGPDdcCmpquzhhaBkKssom
 Jauc/6N2bxAOBbNsYGybi/ohKI/Gh3SNPjBHyqzx4iBvelq0IJeWlSO28cNsuiUhsNf+4YdQt4V
 /z1f0tAV7C77ExjIO3FfZHsagodWTLsgbrRoeY0qckqRyw+Gqb9kSOIQ0TxsieSKxYzo3jzriNX
 Ut3/5WAq/bNdbTQ+loxaPYuwmAyppH71e11kTk1/G8Z5eHjQBoDVO5L3lV5ix2sfg5yGwyOogwn
 0kRm83Yio6mkJgklBm6pXT830IVBwbdM5oWeWBR7zUwknEfdYUsIu0H7NzYqPIubt+We64b3ZkJ
 2wJU+iZszYzUjf46rvcnafitFf+oaDOjh1SeOVIQiwtYK+Abrzg+To4Q4=
X-Received: by 2002:a05:6a00:6c9a:b0:848:2f7a:2e57 with SMTP id
 d2e1a72fcca58-848438a63damr12313317b3a.70.1783702127271; 
 Fri, 10 Jul 2026 09:48:47 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b609acsm10408336b3a.1.2026.07.10.09.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:48:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:48:44 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <alEibBRYmWQvf1z1@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
 <20260710162749.GP118978@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710162749.GP118978@ziepe.ca>
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

On Fri, Jul 10, 2026 at 01:27:49PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:
> 
> > +int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
> > +				     unsigned long timeout)
> > +{
> > +	struct mm_struct *mm = range->notifier->mm;
> > +	unsigned long deadline = 0;
> > +	int locked, ret;
> > +
> > +	if (timeout)
> > +		deadline = jiffies + timeout;
> > +
> > +	do {
> > +		if (fatal_signal_pending(current))
> > +			return -EINTR;
> > +
> > +		if (timeout && time_after(jiffies, deadline))
> > +			return -EBUSY;
> 
> I really dislike there is a timeout here, HMM is supposed to be more
> deterministic. GUP doesn't have a timeout, what is this about?
> 

The timeout was added because this version makes the unlocked helper own
the internal retry loop, including -EBUSY retries.

Several existing HMM users already bound those retries with
HMM_RANGE_DEFAULT_TIMEOUT, so the timeout argument was meant to avoid
silently turning those call sites into unbounded waits.

That said, I agree this mixes driver retry policy into HMM. A cleaner
split may be to make the new helper timeout-free and have it retry
internally only when mmap_lock was dropped by the fault path, since that
is the part HMM must hide for userfaultfd-style faults.

If the walk fails with the normal HMM invalidation -EBUSY, the helper
would return -EBUSY to the caller, preserving the existing driver
timeout loops and keeping HMM deterministic, closer to GUP.

Is it better from your POV?

THanks,
Stanislav

> Jason
