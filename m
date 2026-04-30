Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52A1FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B94710F2B5;
	Thu, 30 Apr 2026 09:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="s6v02ueq";
	dkim-atps=neutral
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com
 [209.85.218.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D6C10E17B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:14:40 +0000 (UTC)
Received: by mail-ej1-f73.google.com with SMTP id
 a640c23a62f3a-ba47bfada67so64997666b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777540479; x=1778145279;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9iVxD0Q/b/KabKpN0s2yCS+iq2LiFZxDqstnJNGVdg=;
 b=s6v02ueqRQs44qTT5Fkr86eGOXPWOITN/2vIwH0xUwT+xt3k2572injt9V/6FLDKw6
 ZYH+dDxPGdiJIqrgVBFM4q5QZxMunskDyLapWFMsbuMZyky7IfE346330q1OzMl/Md/e
 AEoWuKExcQdnf35zz4h4axlNXYj2URe7Z1ntIx3YJ4FeFHIzlf+3zWHmLt/yTbKHpuru
 w01Q7zG+pG9heGv84pcHaGXfLwiW2G/rjwsgtZo4ddnXKoX2z/j1UXNCysTnU7V9qrAN
 mDws5hKZIbv4t8/A+6exAlUHeD+nUgncB3KFYnZhaaGf9ZYdl1ZRJ1X/36CNUGM84USS
 KZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777540479; x=1778145279;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9iVxD0Q/b/KabKpN0s2yCS+iq2LiFZxDqstnJNGVdg=;
 b=cS173o+3GaqA414dPS//dfVJjPinXMRfeFd7v8rVTRuke/g7hKGQZ5rGWkFQyYxleb
 fBJBeJkg09+GTLuaghVIN8jT1Oo6wEgkM+8EylAiVUo1oGHioo4ZQSi1vyZVOSHuIz/K
 dFdxwLt/JxLPYmNOXzGn5GtCmbAc/stmja5ykYXEOkaglU71QCg0cLDZ0yqKsOm4hMCX
 n08GKNJwdsgDEXCWlA/kmF/ksC4gKeyzMqzTNtp/nZIK1CfsM/pNj5u+GbTtCzBZRfJa
 Sxvs0MgOKKc5qog9+9Ls6MLex43SxR52PH5/1Wyy+7ukIoAR575RWPjiA/6i72HoiHjj
 2xxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vcKpiQoCPVw2GMKr6SQMEP17fB+Bd8+AjB8U7cG45wDxOSKWQoSym+MQFP/PTAhFcXwQmZFUD22I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/xZ2/D0lL+O7HNugXqQs+B6A/Yqy9GTPKfZYLPrcWSWyYNLFo
 SBwtkrfHv7eE1tOioVPmdrxxchHXW6ExKdN9iFrukPsERv/yXW7miqF48dR5nNqkHob1BA61bfC
 TQRBCYyt9rdKZDvSgrw==
X-Received: from ejcqw42.prod.google.com ([2002:a17:906:6a2a:b0:ba5:8db:d6f4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7b98:b0:baa:2d37:cbf9 with SMTP id
 a640c23a62f3a-bbac5abfee4mr145636666b.1.1777540479322; 
 Thu, 30 Apr 2026 02:14:39 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:14:38 +0000
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
Mime-Version: 1.0
References: <20260427221155.2144848-1-dakr@kernel.org>
Message-ID: <afMdfs0segrRBx34@google.com>
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
 viresh.kumar@linaro.org, m.wilczynski@samsung.com, ukleinek@kernel.org, 
 bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
 robin.murphy@arm.com, markus.probst@posteo.de, ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

Super cool to see this!

On Tue, Apr 28, 2026 at 12:10:58AM +0200, Danilo Krummrich wrote:
> Before:
> 
> 	struct MyDriver {
> 	    pdev: ARef<pci::Device>,
> 	    bar: Devres<pci::Bar<BAR_SIZE>>,
> 	}
> 
> 	let io = self.bar.access(dev)?;
> 	io.read32(OFFSET);
> 
> After:
> 
> 	struct MyDriver<'a> {
> 	    pdev: &'a pci::Device,
> 	    bar: pci::Bar<'a, BAR_SIZE>,
> 	}
> 
> 	self.bar.read32(OFFSET);

I think we should establish a convention for how to name the lifetime
early. Using just the generic name 'a is probably not ideal.

How about using 'dev for lifetimes that correspond to the lifetime of
the device being bound?

Alice
