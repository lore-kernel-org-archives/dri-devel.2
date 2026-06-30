Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2641AC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4819610EC24;
	Tue, 30 Jun 2026 10:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="icQ/wQmM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E9C610EC21;
 Tue, 30 Jun 2026 10:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782815045; x=1814351045;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=ktunQaDDS5EVOVO47fVPmptPD5p+avnAGjEgEXLkbp0=;
 b=icQ/wQmMyVZEeQ41y0s/RD11IysL84RlqYL/arY/vH1/dWVzn1+QLLrf
 ueBMWmMjezVhy+WaJXO+3iNQGGIcbJzXI6eieapAM1kBIjGjhhVCaXSQm
 TOdxhxZcTJ6IN/W0mgmM+fsTXj3LXTIHco9RasSd9cPj/qGSeyCO0W2Wz
 KbLi3LZ7d4xjSij4MOQWw89C0LFz2W4TDpD3vv6oGlWF6PGxSVzs/7RtK
 R4U6BszKlVT+/8x5p+jGiXmDLemCjiVPuYg/rmmaXKWDznfJUbi98POac
 d+XGxySUIzljPn21oJFt6BBAIK0pXw+4U1qaOJf6g5aG7EdN+AsAIzC0X w==;
X-CSE-ConnectionGUID: iWFeh17OSmqppQDgk2FCwA==
X-CSE-MsgGUID: gGh6se85QkG9MuO9q2JroA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83581378"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="83581378"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 03:24:04 -0700
X-CSE-ConnectionGUID: jgq2xSQuTZCC6QLcUYS3Dw==
X-CSE-MsgGUID: Tgh3e1tLRQ2N4h0xSzOsDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="245877673"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.148])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 03:23:47 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Lucas Stach
 <l.stach@pengutronix.de>, Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, Lyude
 Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Tomi
 Valkeinen <tomi.valkeinen@ideasonboard.com>, Sandy Huang
 <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan
 <andy.yan@rock-chips.com>, Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Zack Rusin <zack.rusin@broadcom.com>,
 Matthew Brost <matthew.brost@intel.com>, Thomas Hellstrom
 <thomas.hellstrom@linux.intel.com>, Oleksandr Andrushchenko
 <oleksandr_andrushchenko@epam.com>, Helge Deller <deller@gmx.de>, Benjamin
 LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Kees Cook
 <kees@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 08/13] mm: introduce vma_get_page_prot() and use it
In-Reply-To: <3bb8bdc4788230c33102166d56cbc5abfad9d4cb.1782760670.git.ljs@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1782760670.git.ljs@kernel.org>
 <3bb8bdc4788230c33102166d56cbc5abfad9d4cb.1782760670.git.ljs@kernel.org>
Date: Tue, 30 Jun 2026 13:23:44 +0300
Message-ID: <d6d75626287ddd46d7da136cf013f7b21b1afc06@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, 29 Jun 2026, Lorenzo Stoakes <ljs@kernel.org> wrote:
>  drivers/gpu/drm/i915/gem/i915_gem_mman.c    | 12 ++++++------

For i915,

Acked-by: Jani Nikula <jani.nikula@intel.com>



-- 
Jani Nikula, Intel
