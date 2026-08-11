Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CBCC5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9CC810EC54;
	Tue, 11 Aug 2026 14:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QXr+b8ob";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972DB10EC54;
 Tue, 11 Aug 2026 14:40:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E4F65419B4;
 Tue, 11 Aug 2026 14:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8F51F000E9;
 Tue, 11 Aug 2026 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786459251;
 bh=dv95HLkIV9zfyuLaN0dP8Mt0PJtOEokmYVlcO3vePPw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QXr+b8obbHZamqXC4vU/mo857M1X3DPhEZUZp/MrRr0nW33FOcREt+vEmS4oPjiU7
 sFIvuvjbUUPCCiCCjwvy4XBdiQTPNhK5G4UMEw1Y8TtutAUOeDjnXBM2Ib0olQEVwK
 W4TFHgSBASrBp8/+nwljpAmkMMxm9dyzX7JdJ/hnNIL416oqAzjuYu6V27VdRHXzy8
 jkA9PfTLNs+h+YfACk0PEjezhbH1fuWaT4gZ9dsTGnVAVh+NG/Yi2Wq9uimzRfmKbV
 7wp9Fq9qZQhgiTBxR+DmjDk+NwF1k4RvY2oKGG5cM2SaTWtz8mU9Aaog3a5OG2TkM/
 1XagBHwewqO+Q==
Message-ID: <0e55a887-e40a-4ce8-afc5-fbcb20807536@kernel.org>
Date: Tue, 11 Aug 2026 16:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] Revert switching default DRM scheduler policy to
 fair
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Luke.Wildhardt@proton.me,
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner
 <phasta@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>
References: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
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

On 8/11/26 4:07 PM, Tvrtko Ursulin wrote:
> Tvrtko Ursulin (20):
>   Revert "drm/sched: Remove redundant entity->rq initialization and
>     checks"
>   Revert "drm/sched: Remove drm_sched_init_args->num_rqs"
>   Revert "drm/xe: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/v3d: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/sched: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/panthor: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/panfrost: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/nouveau: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/msm: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/lima: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/imagination: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/etnaviv: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/amdgpu: Remove drm_sched_init_args->num_rqs usage"
>   Revert "accel/ethosu: Remove drm_sched_init_args->num_rqs usage"
>   Revert "accel/rocket: Remove drm_sched_init_args->num_rqs usage"
>   Revert "accel/amdxdna: Remove drm_sched_init_args->num_rqs usage"
>   Revert "drm/sched: Embed run queue singleton into the scheduler"
>   Revert "drm/sched: Remove FIFO and RR and simplify to a single run
>     queue"
>   Revert "drm/sched: Switch default policy to fair"
>   drm/sched: Mark fair policy as experimental
Acked-by: Danilo Krummrich <dakr@kernel.org>
