Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254B3CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 18:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1675510E130;
	Mon, 25 May 2026 18:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FFatuLdk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBEF10E130
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 18:08:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C48660008;
 Mon, 25 May 2026 18:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F0A1F000E9;
 Mon, 25 May 2026 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779732503;
 bh=7Af3TKqZ6J/IkI0/8uM7h0/MHCvGSTZXbOtVg9cLdf0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FFatuLdk5Yox/DB+pOxc7ZBNnKlyHccQqtirihulizn4txxUHmpV2QruT3DTznn+E
 HuRemBwC4OpBkkL199x3vYvZ6ADunW6bTE7kjdDXnAyOXVeH3Iaj4p+Wu8tvGhV5VC
 zqLDTPhgPBnMMsVBCi+hJ4lUQL/1WPS8EBpkJPWArh3/ojVuKkUp8zshUVGDPDEei5
 rRpMqE5cSv+MJjIqpag64sRlZGMIwrvEJBkia42drb7oi2RJiWoeaf6kN0Nyod9xeS
 rAohY2dZThMZjusM4EQpMU6zOVGQvbincCji6SisiTiyuai+iWrRigIUSH7rkg43Em
 WrFNSPB/mdvag==
Message-ID: <c46cee82-d4b2-41bd-af2a-686d4f6cda2b@kernel.org>
Date: Mon, 25 May 2026 20:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/22] gpu: nova-core: vbios: use the first PCI-AT image
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
 <20260525-fix-vbios-v5-15-e5e455251537@nvidia.com>
 <DIRU7Z3NH9J2.2HT7Z93HFCFW0@kernel.org>
 <CANiq72kR0raSG33DgSxMuc-2uMa626dT=-5=ko_HBgmeOrCFZA@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CANiq72kR0raSG33DgSxMuc-2uMa626dT=-5=ko_HBgmeOrCFZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 5/25/26 8:02 PM, Miguel Ojeda wrote:
> On Mon, May 25, 2026 at 4:46 PM Danilo Krummrich <dakr@kernel.org> wrote:
>>
>> However, I'm not exactly sure it really is an improvement in terms of
>> readability and whether this is a prime example for this lint.
> 
> The lint is globally allowed since v7.1-rc3, commit 838d852da850
> ("rust: allow `clippy::collapsible_match` globally"), so please feel
> free to ignore it.
> 
> (Same for `clippy::collapsible_if`.)
Ah, I somehow missed that -- thanks!
