Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E9BCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 22:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA55E10E8B0;
	Thu, 11 Jun 2026 22:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="f+X5/jne";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CB310E8B0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 22:22:02 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2bf2d865383so17615ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781216522; x=1781821322;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=owXfDppnGy7biMe1ABShmYBUhYqH/Ook9Bgab8mLm+E=;
 b=f+X5/jne4Z3nHRz4LCcKu9kv9eU80yvDBtyuIJ5gZyY1jqL1cvaDaL7Y6uzy6z4ckP
 Yr3w3Xt+5IVYFNqK4FbxJAeA9RUdB7CRCff1jpCJIyfZf2zfe5uYlP/nXgwPG+HbJXFv
 8gOhQayQpSJggIgWF8nNn9cVyOZCaIskCrah/ie9BfXNu1lCw8lftlJA3qwEyXCz5Cpj
 rQuu30pFVmrdu3TwCH26D9DHCU9nEjWnfZwybtEchqWTko0rdMlb5d2ADBLhFUVPkwOy
 +fN+KO5Gbk1qJoWGEypg3tW5VBczzMq2e6mIlw+ufRfe1A6UkINaNUJ2sJjDab6qFJwF
 EJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781216522; x=1781821322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owXfDppnGy7biMe1ABShmYBUhYqH/Ook9Bgab8mLm+E=;
 b=cmk1N67BZdP/8KwkgsNW9SzhTpbogkLcj/IAOgUAdL9dOe9IbmSZooewzN88wzFWLu
 bTEiGWqfe7zccz/+2hrOZA3FDBh2F0h87fkxwGAj/1pL49XWU54Ij0yRo/bCF8cU29js
 b4lzWuVYHo0dL04VXCUUv+lZKKLhbffdWJ25T8Tg2w4k9ta/alosvxMuJ5OlME544VyM
 car8QzbENl9NUKsgKbIoHXZrkGonmF5C0AXCqgSZmtb4jEJW/2wgNlu/TINRhGWjZKEJ
 Ckuw3O7czQsxlnq5GTIPxTphgIyb7tjhq4Ydfe9HfuB9Rsha0N+EtG6BJD5WQxBArtJm
 tAaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VuJQLVjDuTlQRU2XNYhR36wg4aKbnFVsOfy2GTPTD01Qv8RFU7iG46EQr2hO1+mpboeVGwBfo1ww=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhMMuB8PJnmfsYvizhUkYsof0kfb6nvd35EfdQktbh1zu2ut/B
 vnKMANoyjGroF8D51m5d6sVrwVt5Ur+hc8/IvgKNgTf58otOjIHpbZmcyWpbDYsOQA==
X-Gm-Gg: Acq92OE27ujcRtCMu9hc0lDYK9ZsoXLqK02lvOSk/mxUMYUFLy/Fn31cGMEOZ7k27+T
 nWYvGFMhIX8riiAiGbWucRlnqsyVAah5d1SStw26Lbjh1QoM825sSucf36UyPill93S7IpeiHR4
 yyeL2XwIat6j9YszzZq7SipLYvQi33LHnsE51Lknn7fo8Oa3iWmrMBchJrUwzF7x9AOdufcrYiK
 6S/FqjySsS7NyU4DFuAfcNxlnVz+w9FpuAyt5rS5MXfEcpuCdNlDN2qD+gru1btv2cabKtYXJRf
 j0YqUqqy77SAMOuQ52N13/U3SGv1vBGbtOkIn0MrnXnQncZt6gVHKeFZS4AGR0NLGx/X2BzNlvf
 da2/sTBPMQ6HSIWDHhT5RydsCLd8Ln/gLA6lXWRX4sNBCDJB22c9ytYRs0JriyxixRhdi+V/E15
 UuTslpozLWbginS+hB+cJ4F1RMgaE/2clE2P7J9JVS6Ujz2fxmf1T/1qFpDPoQciH8BDM=
X-Received: by 2002:a17:902:a710:b0:2c1:ee6e:be22 with SMTP id
 d9443c01a7336-2c3e33a51fdmr563705ad.32.1781216521837; 
 Thu, 11 Jun 2026 15:22:01 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com.
 [34.125.46.171]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9dc87sm128369b3a.4.2026.06.11.15.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 15:22:01 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:21:56 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 laura.nao@collabora.com, boris.brezillon@collabora.com
Subject: Re: [PATCH] rust: drm: gpuvm: update DriverGpuVm for DeviceContext
Message-ID: <20260611222156.GA876555@google.com>
References: <20260610-gpuvm_device_context_v1-v1-1-01a890b17448@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-gpuvm_device_context_v1-v1-1-01a890b17448@collabora.com>
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

On Wed, Jun 10, 2026 at 05:01:26PM -0700, Deborah Brouwer wrote:
> Since the introduction of DeviceContext, there is no longer a single
> driver object type to equate with the GPUVM object type.
> 
> Instead of threading DeviceContext through GPUVM, remove the strict
> identity between DriverGpuVm::Object and drm::Driver::Object and
> instead tighten the requirement that the DriverGpuVm::Object be an
> allocatable GEM object associated with the same DRM driver.
> 
> Also, make GpuVm::new() generic over DeviceContext so it can accept a
> drm::Device<T::Driver, Ctx>.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
