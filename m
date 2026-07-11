Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1442C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C37710E7F8;
	Mon, 13 Jul 2026 07:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e5bR6NYS";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D41510E719
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:22:38 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-845c92bc464so1385464b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 20:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783740158; x=1784344958; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZoRTmK7mqG76n1GL0uhVSS5eZwslPyOiLYDvdkV1GQU=;
 b=e5bR6NYSKzNvj/sq0whBg27T68e39DqxEQVyD/pUEVJ+h3Sw93VvWD24tc7BvA8JPg
 2QOEoBl5wsn97Oimi2lt+OGUQLwCKtdRdhFSBx8nSkOz6qp4d6SzJl+yNm62GKWxo41i
 dzpBNR8AAg19LUxiUU4EicM/G3Dh4wBRyFOMoeXBtpPeS2jla14fzc5VkqrMsYEnqaac
 Db+3XYJVQa76Tc0grUsD+0/f2/A4CMkwxGQ8mU3U1v5Nc6NWbj3vANmBzHWVw9t8Bl5z
 ZB1wTYRBtDrQwNR5P08moZkP3lPKl+fKsjXOCfVSmUUIedrIVeUf+dey/HKZedjHxpMf
 xWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783740158; x=1784344958;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZoRTmK7mqG76n1GL0uhVSS5eZwslPyOiLYDvdkV1GQU=;
 b=VdidDf6/h/h3H998dJvcI3pUR7s/Bk4BNC5cBsnnZk1xwJIgZBix5+2vSsAmaxCCXt
 b4paNGmldnwitYjoSoWJNS0+rsVW/5JcPtTrd+r/YbfnAdxSveis+6nxjZXy2U9BEYLC
 iFipbr17aD/p37k9tupbaLmgLZuYM0QFF3Ts/TIFpv12fRwxQfJjWWHjSLMqMoN9KV6S
 FJk7Bf3Jge28p6BVWnZuf/T9A6qkxhWuB0hu7jX9dbkVuoAoY2WROuq/Z7U72hLxvF9i
 e6Fj4YGBq9C97tPpM02ZaY6buxTYsm6vd96QSdWumjmoqBcoPFQDt984nmz10M09NFDg
 B34Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RraCPRX34jjCd5slaSUdXdWItT4U6D9EWVK9Vry8WRKpMeMqk4zWApvF6JrCbwW9lYSL9dQQwFqx3I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzTWyT9vRnQgYcu1UQzE9CcFKOW08s2VOeQ67SCPORRg3ye79j
 RuzfXQ43zwtosGaom5z8/mRnUdkppq/zo8d2wbW8gC1CW/JbTS3c6qQi
X-Gm-Gg: AfdE7clMdc6pjJI0ylH8J23/e3sxF98rApWimNoYXEXDW4giOdTfrd8YHsh69tMSLIM
 zf5xF6OW2TDgVWKepRUWZB9JmNxvJ+QBGoFB9hgYLHGmUda6TovNzzve7x/fpyqmb8WBJVaZ6j/
 CNhh4qeBMHUoX46wmkb7pD+zR6WSs3QEzIa1lHUSZvCgZcVcvpXyBoPhyCyc6HuJ223ix8XwJ9e
 tVvONG8fNhGblXO2QSeTn6NYDMuPtlrwwmMVlcG+3oV31Y805iQh2qT+5t26FPKMpCVbRa8iuER
 FWn33RgjfAVAoFu88XAFCxby+kHwYBJZ0UmuvEz6vo7l/gZDVh1+LJOiOPN96Yi5Mogpsz1Faoz
 j8grH85diNFmxBlL6OnmTeRpILsR9leKLDw+nCguEOifRHCy0RKSSmWWYfqJWwRznbFkcbuL3az
 BajVCrIh9w/bz8mivOyeVJtQ6/qsy3Vn5FXh9Js3SOKlJ/EhnxzQU4XjY=
X-Received: by 2002:a05:6a00:2303:b0:848:2f74:1d68 with SMTP id
 d2e1a72fcca58-84889750a60mr1542258b3a.78.1783740157808; 
 Fri, 10 Jul 2026 20:22:37 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84856e7c8edsm3652647b3a.36.2026.07.10.20.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 20:22:37 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:22:33 -0700
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
Subject: Re: [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Message-ID: <alG2-RSitzPWClAX@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <20260710151151.1e193eedd0cf2591ae392f76@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710151151.1e193eedd0cf2591ae392f76@linux-foundation.org>
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

On Fri, Jul 10, 2026 at 03:11:51PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 14:26:20 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > This series extends the HMM framework to support userfaultfd-backed memory
> > by allowing the mmap read lock to be dropped during hmm_range_fault().
> 
> Thanks.  This seems fairly mature and mostly-reviewed so I'll give it a
> spin in mm.git's mm-new branch.
> 
> Unfortunately Sashiko wasn't able to apply this or v7.  I'm not sure
> what base you were using.  Hopefully there's a reason for a v9 so we
> can retry this.
> 

I rebased this series on top of mm-new right before sending it out.
Should I have used a different branch?

Thanks,
Stanislav

> I have a few niggles, nothing major...
