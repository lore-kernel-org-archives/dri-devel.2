Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E8C10854BE
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B40F10E0DD;
	Wed, 18 Mar 2026 09:16:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ivf84CT0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E32A610E0DD;
 Wed, 18 Mar 2026 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773825362; x=1805361362;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PpwWrd+2QR2uovzpbfqsfAWdIZqDhI4/F4guxYzlqsQ=;
 b=Ivf84CT0K9lRbuQAWr84oGjvLCaaIXHlk6+YjukjRAaQxq0cEo6AllJF
 Ze6wpGtRAECvTKlXvzXD9mOBF2d2WpwBjpVEgf9ZUo0CQCeGn+KaRh/1X
 oBnOmhmGdPyT0L9qEPKzQ5qgToN4AHhSS5/khHNACethp155Px6Z2voIm
 DlJb3HmAwlSBBINBX5a44mrXf6LLH/p04TQ3HolDFIfDZWvSeRKs6P/Tv
 TOw8HRy3Xq/guJzmp3r7OrvfQvz/mrnwx0CTNjo3pRvgCt+nOdbQMGsSE
 L/l305qw77EHUnVUjzZBEdKeNajiGyzMXJBAea2oJfkkPd11ZYXjoArq4 g==;
X-CSE-ConnectionGUID: KtVCLd2rTZC9/PIo9VRJ/A==
X-CSE-MsgGUID: T75W3dIfSKi9Y3sdEQE++Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="86345768"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="86345768"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 02:16:01 -0700
X-CSE-ConnectionGUID: 6O7M7J2OR6OTF280f791KA==
X-CSE-MsgGUID: 2je+XzzIS4a6LIAiBrIMmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="222783308"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.244.34])
 ([10.245.244.34])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 02:15:49 -0700
Message-ID: <ada571ca-b624-4494-a6fe-c9ca803c6cc6@intel.com>
Date: Wed, 18 Mar 2026 09:15:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/2] MAINTAINERS: gpu: buddy: Update reviewer
To: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, Nikola Djukic <ndjukic@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Helge Deller <deller@gmx.de>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, Elle Rhumsaa
 <elle@weathered-steel.dev>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
References: <20260308180407.3988286-1-joelagnelf@nvidia.com>
 <20260317220323.1909618-1-joelagnelf@nvidia.com>
 <20260317220323.1909618-3-joelagnelf@nvidia.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260317220323.1909618-3-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 17/03/2026 22:03, Joel Fernandes wrote:
> Christian Koenig mentioned he'd like to step down from the reviewer
> role for the GPU buddy allocator. Joel Fernandes is stepping in as
> reviewer with agreement from Matthew Auld and Arun Pravin.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd9505d3be60..3353cbf98be1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8946,7 +8946,7 @@ F:	include/drm/ttm/
>   GPU BUDDY ALLOCATOR
>   M:	Matthew Auld <matthew.auld@intel.com>
>   M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
> -R:	Christian Koenig <christian.koenig@amd.com>
> +R:	Joel Fernandes <joelagnelf@nvidia.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

