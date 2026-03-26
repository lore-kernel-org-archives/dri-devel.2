Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257BD10AB827
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 22:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0DF210E1AA;
	Thu, 26 Mar 2026 22:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qv8nv8WF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12FB10E1AA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 22:10:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 44AE660054;
 Thu, 26 Mar 2026 22:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15866C116C6;
 Thu, 26 Mar 2026 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774563010;
 bh=7DmAbiQ09Mn5Ir+yhLzCGFJykmIJedgJuwOFfqNIbEY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=Qv8nv8WF0Ko5ulaJlt/HjRWXjl/yGPIRLoVOi8SqhM5R6oK6463uiRxeeMetOuL7K
 ziu4d9xXb+aEp2e6s/omNOGidG1hn4S5ayDlpRl40e4ZyTfSC5OnC51WHzzoLBT4rq
 +dC3Ct1jHdTPnOw7/Y2/Yc7wjJpehyeZIZv8mtAeWmE+k3ajhjZN5t44xPGxOkdRnq
 Zeo/GEQfa2qKaMjyUCKEBJEhdqXXdTkXz9l4B0bopAXVvjk3tO8HgrNK3dczuhPDhm
 kDXXMlI/WFicwtM8lFxKfbahAlhWePTmJQpGyg0YAwIBoThe8dDOZssfx9Y9JMU8Ov
 zhflvnWoC+jVw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 23:10:05 +0100
Message-Id: <DHD232A6MYDI.1SZ5JL6UWA6SU@kernel.org>
Subject: Re: [PATCH v5 02/11] drm/gpuvm: Remove dead code
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Steven Price" <steven.price@arm.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Janne Grunau" <j@jannau.net>,
 <kernel@collabora.com>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
To: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
 <20260313150956.1618635-3-adrian.larumbe@collabora.com>
In-Reply-To: <20260313150956.1618635-3-adrian.larumbe@collabora.com>
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

On Fri Mar 13, 2026 at 4:09 PM CET, Adri=C3=A1n Larumbe wrote:
>  struct drm_gpuva *drm_gpuva_find_prev(struct drm_gpuvm *gpuvm, u64 start=
);
> -struct drm_gpuva *drm_gpuva_find_next(struct drm_gpuvm *gpuvm, u64 end);

drm_gpuva_find_prev() seems to be unused too.
