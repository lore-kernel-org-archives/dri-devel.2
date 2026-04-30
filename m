Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9012CD13DA
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA6C10E46D;
	Thu, 30 Apr 2026 15:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mNYPlwcz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B7210E468
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 15:22:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4FB726091C;
 Thu, 30 Apr 2026 15:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9AEC2BCB3;
 Thu, 30 Apr 2026 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777562551;
 bh=7OR9Aj2MjzbGYmPLJPBBskhrfWzRXDzzOcdpttRG7U4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mNYPlwczVgyLLTsSqIom5SWRUhJilo3cp+B3WppC8tc5vde7+b+3JxfynTaQJXitD
 CELki1hDS7aiBEa0EIJOrrGdH5cnpkOTMxIx4hOJK4Oa9n4prE6H/pPTYkx7LtdCFk
 XhHJ79STZC67KMczGycbaC7Ym4F6Wqkmqh4lfDENIMu/Q5ioSUldDJnCma3+ZgFZjf
 kSTuY2q9E1CfieEGxsfJXEogoU4G+AymCib7PGXz4Uv7sYeynnRdz9LevANjLhi4o8
 V991Hu8N7zajfHdTebEcJvd4a/DNfnSnrQ+pXFBceJHHMzxTO6bdI6nzOKSC8NKMgX
 WUJ30POulqFsQ==
Message-ID: <4060e63f-010f-403d-af18-5d6c94763745@kernel.org>
Date: Thu, 30 Apr 2026 17:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] rust: add warn_on_err macro
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Boqun Feng <boqun@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
 <20260422-nova-unload-v3-1-1d2c81bd3ced@nvidia.com>
 <CANiq72=7u5O_58b6cnCwGz=j0D1tmf5+9Ntv1mkJZpACWXQpFw@mail.gmail.com>
 <DI6L3WUV1AX9.20T2183TYVJQR@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DI6L3WUV1AX9.20T2183TYVJQR@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/30/26 5:11 PM, Alexandre Courbot wrote:
> Thanks - I will send a separate patch for this shortly, and take it
> alongside the Nova unload series if it can be reviewed quickly.
Do we still need this? It goes away with the lifetime series.
