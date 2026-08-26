Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CBFC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC8B10E17C;
	Wed, 26 Aug 2026 17:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="BOjl42VL";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BEF910E17C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=6kvjk25rvX43dVhJ6Zk3JZPWl7hUKkWcNDJWv+5kpek=; b=BOjl42VLN9ObfdI+7XMrnqD5cV
 88NXPu9JtsCP3xQzyw97dFMmboDrvhWFgUXynYKVtLFKOzfUvHBHL6yZgWfY3rdYJyDVZqQ90CltT
 NlHkyeohACUaNJptdtjJYA0s5jFwwcq+9DjhmTzZF62JUC10Eap2/rYvl0x95OF1qjV6oSraeLKg0
 DucId+LcouIZSj98IafphU6RC0FZRNy+yqD5I4c21pbDv4mmBluY/n215NSY5VCnr0hhlwbyYsGyl
 vibRMHHGReiXIS0Jun0+fF0NrEkTozYJcdPA2hlCng3g/VoCWYqj87a5XihWwwYCX9IR10Vtl4VA0
 LKp9m9Ow==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wzHQf-00000002oku-183z; Wed, 26 Aug 2026 17:28:49 +0000
Message-ID: <b0251a55-340d-48e1-88c7-e8725e84f10d@infradead.org>
Date: Wed, 26 Aug 2026 10:28:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] Documentation/gpu: document the Vino driver
To: Mike Lothian <mike@fireburn.co.uk>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
References: <20260826163913.7052-1-mike@fireburn.co.uk>
 <20260826163913.7052-14-mike@fireburn.co.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260826163913.7052-14-mike@fireburn.co.uk>
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



On 8/26/26 9:37 AM, Mike Lothian wrote:
> diff --git a/Documentation/gpu/vino.rst b/Documentation/gpu/vino.rst
> new file mode 100644
> index 000000000000..98e82297a82a
> --- /dev/null
> +++ b/Documentation/gpu/vino.rst
> @@ -0,0 +1,254 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +==========================
> +Vino DisplayLink DL3 driver
> +==========================

Documentation/gpu/vino.rst:3: WARNING: Title overline too short.

==========================
Vino DisplayLink DL3 driver
========================== [docutils]


Extend both the overline and the underline lines by one '='.

-- 
~Randy

