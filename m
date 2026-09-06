Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF50C79F85
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 15:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0615A10E3DC;
	Sun,  6 Sep 2026 15:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PpEphqRK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A31510E3DC
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 15:29:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F287C60142;
 Sun,  6 Sep 2026 15:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1067D1F00A3A;
 Sun,  6 Sep 2026 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788708596;
 bh=hudtMkuumyJji663PnsRBqg8gRdSXAGMJC9a29y8rUk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=PpEphqRKwcJ2ak+MGNqjolZAF+7z/VgT+H/kuWorS35rGTgpLe/CetcOz+y+gxEQH
 0CA+oHhUmBbgJ79zkhSpUHORS6/pAwB7Uo0zvcZQRYoj10OWYV0gdUi3NVq0J7qesN
 3+p7TeCkHDS7te1PT4gYVoqaiMtnv09IBUDLeL8QAAClqf8iWZ9HA9sn5pWqaYdHoM
 ecTto1o7uvZgKyQsLC2w30s8H0+rIPakGuNUACsU16Kh+cugBEfzpHTA9lrTE6rg3Y
 0KzmweDTnZM6mQX2JCmWJfKXy3MLQs5VWMhiRWNn9b8i5JjLM66ZvaboD+hVmmgQ4M
 ohCwbCaFu9JXQ==
Message-ID: <f72e2bf9-9934-4b2c-aa44-4becc6dee779@kernel.org>
Date: Sun, 6 Sep 2026 17:29:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] gpu: nova-core: add PRAMIN window support
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov
 <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
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

On 8/27/26 10:51 AM, Eliot Courtney wrote:
> Eliot Courtney (3):
>       gpu: nova-core: mm: Implement Alignable and Debug for VramAddress
>       gpu: nova-core: mm: Add the memory management HAL
>       gpu: nova-core: Add self-test assertion macros and config option
> 
> Gary Guo (1):
>       rust: io: add static `cast()` method for views
> 
> Joel Fernandes (6):
>       gpu: nova-core: mm: Add VramAddress type
>       gpu: nova-core: mm: Add PRAMIN window registers
>       gpu: nova-core: mm: Add support to use PRAMIN windows to write to VRAM
>       docs: gpu: nova-core: Document the PRAMIN aperture mechanism
>       gpu: nova-core: mm: Add GpuMm centralized memory manager
>       gpu: nova-core: mm: Add PRAMIN aperture self-tests
Acked-by: Danilo Krummrich <dakr@kernel.org>
