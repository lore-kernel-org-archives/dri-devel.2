Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D525EC44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A93A10EB5D;
	Mon, 13 Jul 2026 22:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jgebq3gx";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9773410EB0B
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 20:57:59 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so249548a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783976279; x=1784581079; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oNqruOZIzwruIpGvkzB4DJORZxeTGWU0clCn+vXfCzI=;
 b=jgebq3gxPdtPfElJHmkd6gNzn7TKR4g7uiAYLeBenpeBY0uZDc1gecA/kdihMva6/l
 lRiQp2Gk43IdKQBD/t23QRXk3Xdyobxmfej8mHtCczyQNZJZDBw05V4WjqTXV+vAcIHg
 vqBNFrriONnM6VjQMNDTx12jRseOjZyjk2aD+yoPCq2FVKRhip7vjNf4iR82NW90qVcS
 y7F4hqCjs04VatzDdCny0sD/cNVf2LMOA1XisB0vgm/+P4BSJD9VIwCtJbIGtU51E4Em
 8XSosJB4cGI3m8807t0zOrIcJpLgW3NNpUOl0dKLEpFGXZ6Xh/0JgqIxDgg4dxscJbo5
 5pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783976279; x=1784581079;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oNqruOZIzwruIpGvkzB4DJORZxeTGWU0clCn+vXfCzI=;
 b=Ta4LY+o0zTF9FcODixg1wnR55z8BO0UiXAuNS653ZvwAyZbMGKhpbrinE1xSYGX2DT
 0rDogGbBTRQ46gqJFaFBn8q5LttUF7N979r1LECN4NV7Oc+u3cdsnopteSYZot+dnZ8c
 qEbn/1oH3JR65ndtGPY5XVgCfWXvGEfvRRxx39Q2uLhEOtsYjPwpK+FO+VRpPdlWWbrR
 noFlQN9C0BcP9ruHTTfnfRelhfb9l5OANIUdDHnRpUXP3WrthtKlN+FBqZE3Y1No5RM+
 9U4a1j+HEr9x8YgkpGLg7IPJLbHB1Bar90KYcor5D7HpFoFkebbfKs/FdgQjeQl7UXRs
 BWFg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3JOOefLI5Oo7WpPOvUiIHv/ApbAKBmP52P8zee4qIYLGQNYy118VxQ2wgWhfiD855YNnskKNXMn4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQRoeZO+cKWdOCMsoy/Z+MvERrKHg4xFREbVdUtXx4R/g6u2tl
 YcWvqbRrgJuiSUYplmDOXGukgEwc8RBjy47dv/iDRTjV8z0PRcPnKZfi
X-Gm-Gg: AfdE7cmp4eMGyVKH2fOk0DYSAloT6YmJ/JR9TsvkPvgr25oGlshxMaLQdx5xWYI/wXw
 LbpR5CccMvUVKtBSOQeCpdag9K+0GyPi9nPXNhgyrENUtsvS+4+jsJ0Pd96ME7Bm4DpF3dvW8dZ
 lqif9j+nfyc0vyDbfJnnsCpET84uKaahNzkrtmhBzzGQnNrJTEZIexzF3OE8HY1DkNs6UouTYTJ
 NMcSReDSzAnKoz0IGtCQcvW4O8e7/KcX/ZU2tjcJ42sXVi3QTtj98BzUP5mhDKD3SdwcpVmp1Lb
 3ykCtXIWy7xnraQ+WuBzOEwZYI10t3toVeeFfhbciePtad6tkk0s2VxCopl94jSq7pwz/rJiprl
 TNNpnGlx7xmuI4oWTkNhLd3FwfZeAIZighuRHJG3i1GlEXSspBSBgdF/lZgvJ0yKw7DGrdNK/FF
 g6EkBEPgkiP4RlZwq8JyRCH+6mImGyombmdfl8jjLSJcgQu0WdUaGPGHllLrylp+EWOQ==
X-Received: by 2002:a17:90a:d88b:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-38dc75e3d4fmr9572711a91.12.1783976279067; 
 Mon, 13 Jul 2026 13:57:59 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b6ce6sm403816a91.1.2026.07.13.13.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:57:58 -0700 (PDT)
Date: Mon, 13 Jul 2026 13:57:55 -0700
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
Message-ID: <alVRU38lMfvmUFqJ@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <20260710151151.1e193eedd0cf2591ae392f76@linux-foundation.org>
 <alG2-RSitzPWClAX@skinsburskii>
 <20260710224950.53bcb43ce7e564f07a1f6a8c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710224950.53bcb43ce7e564f07a1f6a8c@linux-foundation.org>
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

On Fri, Jul 10, 2026 at 10:49:50PM -0700, Andrew Morton wrote:
> On Fri, 10 Jul 2026 20:22:33 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > On Fri, Jul 10, 2026 at 03:11:51PM -0700, Andrew Morton wrote:
> > > On Fri, 10 Jul 2026 14:26:20 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > > 
> > > > This series extends the HMM framework to support userfaultfd-backed memory
> > > > by allowing the mmap read lock to be dropped during hmm_range_fault().
> > > 
> > > Thanks.  This seems fairly mature and mostly-reviewed so I'll give it a
> > > spin in mm.git's mm-new branch.
> > > 
> > > Unfortunately Sashiko wasn't able to apply this or v7.  I'm not sure
> > > what base you were using.  Hopefully there's a reason for a v9 so we
> > > can retry this.
> > > 
> > 
> > I rebased this series on top of mm-new right before sending it out.
> > Should I have used a different branch?
> 
> mm-new is good - Sashiko attempts that.  But it's changing rapidly at
> this point in the development cycle.
> 

I’d like to send another revision addressing a few comments and also
replace the `max/max_t` check with something simpler.

Which branch should I base it on so that Sashiko can apply it
successfully?

Or would it be better to send fixups against `mm-new`?

Thanks, Stanislav
