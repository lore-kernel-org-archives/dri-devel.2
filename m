Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEC6CD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 19:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C464110E57A;
	Mon, 11 May 2026 19:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VkRRfo8h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362D810E57A
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 19:40:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E5B9600CB;
 Mon, 11 May 2026 19:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64229C2BCB0;
 Mon, 11 May 2026 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778528419;
 bh=/6ftpBXC2aIHq+a9hymBxjM3BrTyaeZmEYrXz1DsS30=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=VkRRfo8hlV5fXTIE6fqKE0FXElgET8mV50cIqVCK0iAOxYY70u3/AI+j16GxjHUBV
 mCo4WmqtwTVjYiiqEbVOBI6qP38YW3pEbYz7eLb5HzSdi1c+u+4beZyVUS0keaqG4U
 FC46HFywd3VnYrQE+WefB4aNocY1KlFGCt9XuISymdOx1MXpr0CfaHMVyB7cg+uovl
 tqb1cvHcUk5QrmOmtW23IHSlRuWNCWGws0ry3PcY2rMfU3ZsefuhJeBRK0UukbchUO
 2mhwi5ORRKlBhJbVYrw+1XZ3C8qPkfA/Zr9L2IlLhPnrAEHerD5dpDp3knunePVcrn
 l7a4N9D4WwuFA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 21:40:10 +0200
Message-Id: <DIG3PCJEMPQV.1IAU6ZXLNWP4X@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 03/25] rust: device: generalize drvdata methods over
 ForLt
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
 <20260506215113.851360-4-dakr@kernel.org> <afyKqwxDxu3cT7U9@google.com>
In-Reply-To: <afyKqwxDxu3cT7U9@google.com>
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

On Thu May 7, 2026 at 2:50 PM CEST, Alice Ryhl wrote:
> On Wed, May 06, 2026 at 11:50:39PM +0200, Danilo Krummrich wrote:
>> -    /// The type of the driver's device private data.
>> -    type DriverData;
>> +    /// The [`ForLt`](trait@ForLt) encoding of the driver's device priv=
ate data type.
>> +    type DriverData: ForLt;
>
> Associated types support ForLt natively.

Correct, and as it stands DriverData is only directly used for
Device::drvdata_obtain(), which doesn't necessarily need the covariance
guarantee the ForLt bound provides.

However, I chose to use ForLt regardless as it prevents future users of
DriverData from running into the covariance trap, plus it keeps the code mo=
re
streamlined in the driver-core and in buses.
