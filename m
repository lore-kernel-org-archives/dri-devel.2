Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E70CCD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF2611A0EF;
	Thu,  4 Jun 2026 13:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SI3SXia8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BD611A0CE
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:53:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E31543DAE;
 Thu,  4 Jun 2026 13:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E351F00893;
 Thu,  4 Jun 2026 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780581217;
 bh=3tNRq6VDKdkCaUkhtn82k6pDJi8lH5/RPheKwjzO/po=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=SI3SXia8KpslS08g/xKwaLJWaS+55xfNn+IKuvBVXsJsoAJKjr5fcHbkOGgNYGzZw
 3twnPyrzIOncNjMd6MIUvV8rAMH/PxpQfScvKRKSgRvuV9AayvYC3grgg/qDmD+GyY
 sWH7//YOw7Z2UrNoJ2awr5aN5dNjbtrlBAXtldQddOCXVNYl8vwj5wM6jBT8kKYTG7
 LM0MsWjmJnC23HAY0gn5J0rHnLjpp4yKzhfpfu5KOWgDa4/sp6ReOKvv5Z/TPia+rq
 U7/GfbhQPME/+pbIjSwrNhiZN0aTlK2Wa5FA82ttTMJV4NYtPZA/5GnFjcbnluQ6O2
 8Objg8h4PHhOA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 15:53:32 +0200
Message-Id: <DJ0BD0O60VAB.10S80F8N6MQPG@kernel.org>
Subject: Re: [PATCH v2 3/7] rust: drm: Add RegistrationData to drm::Driver
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <boris.brezillon@collabora.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260603011711.2077361-1-dakr@kernel.org>
 <20260603011711.2077361-4-dakr@kernel.org> <aiC41_huOYhvacQD@um790>
In-Reply-To: <aiC41_huOYhvacQD@um790>
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

On Thu Jun 4, 2026 at 1:29 AM CEST, Deborah Brouwer wrote:
> Hi Danilo, could we use separate data arguments in UnregisteredDevice
> vs in the Registration? Basically we want to use the UnregisteredDevice
> to initialize and boot the firmware which we then store as registration
> data.
>
> Could you have a look at this patch, it applies on top of this series:
> https://lore.kernel.org/rust-for-linux/20260603-use_tyr_reg_data-v1-1-97f=
64e951cf6@collabora.com/

They already are separate -- UnregisteredDevice::new() takes T::Data and
Registration::new() takes the registration data independently. Your patch
demonstrates this correctly.

I also replied to your patch with a few comments.

Thanks,
Danilo
