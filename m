Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A503C5516F
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE78710E2D0;
	Sat,  1 Aug 2026 07:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=flapping.org header.i=@flapping.org header.b="ONehS35z";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGVbakgg";
	dkim-atps=neutral
Received: from flow-b6-smtp.messagingengine.com
 (flow-b6-smtp.messagingengine.com [202.12.124.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 434B910F20F
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 10:45:24 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.stl.internal (Postfix) with ESMTP id 8440F13000DE;
 Fri, 31 Jul 2026 06:45:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 31 Jul 2026 06:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1785494722;
 x=1785498322; bh=9cYRjbKynmrdZ6ZOmjPzFzuKEmKJ7o6czSt4sOVcJu0=; b=
 ONehS35z/NuNbZaHLGNCl+zUbNYQieVo3LvwKS2He3tXuvDALIjKgf2mHpgi5Rbt
 nK3Y2WDr6boesSgVxRkeScN/0UqJmsg8D/ajYDwnJSMMdMxf1dbwjSAjaMbx4C0T
 k/mAMltdhQo3iCZL8fdopraAlJzj5+dkAKn22eKLAWIq7FIJhf8yZjBfNmquoT0b
 V09BLQIC/NJ8uUDGPcGPXp3JgNm/G6166yKOiv703HIhHZDJu08NdS27LXVhJ+ct
 qjjfPY+dcPwDOZ1XTFzzCs9jE+22SLAR2HfR+/e1fgRYoR4EnIe0+6MEDoFNdMrH
 BDEEbyKrAeWczqJAYFZ3Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785494722; x=
 1785498322; bh=9cYRjbKynmrdZ6ZOmjPzFzuKEmKJ7o6czSt4sOVcJu0=; b=X
 GVbakggSPLxEevBHEbNFNOQ4fjcQiha6yuDzeKjOeHdC7Sr+jkACWTO85OvAAfzT
 NAk3a8Qc6aQSOSWiyLDlOfnnc1jYruJ/lcquYFXWMlExVIZJWU0hsYpF3lQ5xWQE
 q5+aR1Cq+fd5fRypRwsQiWXSihZTOdCdKFlvqZ8flJ44KXWtlQQKGc4EdPNr84+X
 B1dYLN2Lk175ydXKrrC1RqSpQQHhwmaH0wlflk75r0CPX7LZ1xUHjVylhvSRLMwR
 MVSPFGTfjte/x42ggkLY+yFeRpXo1vfLBc9NhWfM5F6zkQ2moW98V/aXsrU9sa2L
 XDBRNyQEDmSUGaIZfmYLg==
X-ME-Sender: <xms:wXxsavqS9NXSdZwLIbjTuGTsn3GGyYSvXMvchKYz8pbQMe4oB0bIkw>
 <xme:wXxsaj0vjQ8OVTgRre8XjOzcaHURdJhgE0VbcS_E8B_yq1jnMvqih0fYYRcOI3n6u
 YX3sxUsB97xLsrc0RPXRPBjrK0sjQeJYcmLX8S08BDMNX229paPalO0>
X-ME-Received: <xmr:wXxsag0JrHIp23tbfQcNF8wWp9xYfCG9UqOAYNIrgXuj2piKN_oHonBW1kN_xGTOIQqTZHn7ZX_7vERFBEHRr28o>
X-ME-Proxy-Cause: dmFkZTESiYr64BfODGRGPxARRYeKhSgda2bNED5mgnDDVRjzB/sHQAz8QPP74HyW+BeHzE
 GOSDzxGIQ5lNwHDJMdTOfhQyDL6oLccVwDnPlSVY3RQPV6w0eqxndBDI72OaT/IQWEfZIZ
 DgX8bp/QOYX4jUwYTX9SycpbLYA29cpSUNxd0sd8897NhsFyBBfKV0JGMLwt2LLSkewFmM
 z1nB1cDeod8Qbs4I0h4ydQA75LjqZaj2xFg8SALv4KssNLLrtPIZeMWYyc8IHKvkGwQVjn
 2oc6L2wSy8ixq83mQk3/c8amyXviL0Ydf2VqWh1X0SrRo+NliZU/aZrW6gnx6JrGuV4nht
 ChzoU4J70ojSSkDfdwfmesqq8xnGusLFp08gp5YoUIT9gD+HmWUWnQYCMJWw5qSuCwpI09
 23BIvYrgPptd3W60UNyf4bo+x0+dhn/5OJtm16HPfFEdFMkLnUDsapXqJ8O0cxCoCaYLnV
 82wxzPdF7ygva8dWVYy90jfDoDJptOPzmmk0hPyB4zTJR+smoSPY/CvouZDb7m1AkndN6D
 u0RD4OAlEIQwiSYbsSomKG4BedEMc7dlsFNY98xi39XaKzPHLWhD+kb9x9YclgI7VrjLQb
 AllVK6JFGErSnUSnTO3OouUxocCHFG9a5DIYJRV1KBzxVtvNKqtPNA+IP0tQ
X-ME-Proxy: <xmx:wXxsajcRuwaAHqDvuj2cCXYdePEZ3pI_iZdo_az4JBVv57fVOpzfHg>
 <xmx:wXxsajIECSGcr3g-dwRrtQ_glJu60iBHbLq1nWfui3wDHi5G-b0riw>
 <xmx:wXxsaua-kny0ZAfBqv1NsbhiC02tGvPa1pkoJYH6L3Y7TWY9ha3MYQ>
 <xmx:wXxsagZrDShaAUf7ahxGOxIrPNjn3JLlfNhjII3IVa7idYXyE2wc_w>
 <xmx:wnxsajC42RPpL2VPiHvHr2JOxhX6PuDYsyJa2YVO9m68CfbHvN5A3qKj>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 06:45:12 -0400 (EDT)
Date: Fri, 31 Jul 2026 19:45:09 +0900 (JST)
Message-Id: <20260731.194509.1672759045396477102.tomo@flapping.org>
To: dakr@kernel.org
Cc: gary@garyguo.net, fujita.tomonori@gmail.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, ojeda@kernel.org, boqun@kernel.org,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 airlied@gmail.com, simona@ffwll.ch, bhelgaas@google.com,
 kwilczynski@kernel.org, abdiel.janulgue@gmail.com, robin.murphy@arm.com,
 david.m.ertman@intel.com, iweiny@kernel.org, leon@kernel.org,
 lenb@kernel.org, igor.korotin@linux.dev, robh@kernel.org,
 saravanak@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 fustini@kernel.org, guoren@kernel.org, wefu@redhat.com,
 ukleinek@kernel.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 05/11] rust: net/phy: remove expansion from doc
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <DKC7J1TB8TZN.1LT1GJ0WP9LR0@kernel.org>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-5-56fccbe9c5ef@garyguo.net>
 <DKC7J1TB8TZN.1LT1GJ0WP9LR0@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

On Thu, 30 Jul 2026 23:01:18 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Mon Jun 29, 2026 at 2:39 PM CEST, Gary Guo wrote:
>> The expansion serves little purpose and it can easily diverge.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
> 
> I did not pick this one up, as it is not necessarily needed by this series.
> 
> However, I agree with the intend and I think it did diverge already before this
> series.
> 
> FUJITA, please consider to pick this one up, or let me know if you want me to
> take it.

net/phy changes normally go through netdev, but this one just removes
documentation that is already obsolete, so I think taking it via
driver-core as part of this series is the least work for everyone.

So please take it with the series, unless the netdev folks object.

Thanks,
