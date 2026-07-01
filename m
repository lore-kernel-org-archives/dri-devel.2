Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6832C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A6110F020;
	Wed,  1 Jul 2026 16:26:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nWTajatr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD69E10F00D;
 Wed,  1 Jul 2026 16:26:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34DA960122;
 Wed,  1 Jul 2026 16:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97B21F000E9;
 Wed,  1 Jul 2026 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782923168;
 bh=Fm3FlfcjybotyrEI+ohYn0xEKLKpJ541/JkKmW8KEOI=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=nWTajatro/WOZW3acbYn6ZHvEQen/ICZDIUQtWAq9wq9FgaRufQ1iL6UL3WAXnGVd
 Y7nXgO7M0c4H6E6g66NtfypeY1T4qHKNCvyMEueZBoTULMQJ04gseonvzIjByBWV9r
 vaMa/R6fZKK6SNMu7DA0eV6G+qeIh0D/Z+TAZxspcwEP+z39Vo9T+OblMU486+bhE+
 RXQBLOPd0gtNuK8Dj+ixXlvkI3RawaKYTD8a52f9dosIfwABk0jDJh5fQ2e0zOUjgo
 m7WO/kKsJiiycatxCxB9/t54wecjylvTKaIwYf0fBHAsq0NUrFfWQrN1B9/CakSHp4
 T/rRJDHiOb1kg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 18:26:04 +0200
Message-Id: <DJNDIIFV82WU.21FKVRT80BJ73@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v10 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Cc: "Matthew Brost" <matthew.brost@intel.com>, "Honglei Huang"
 <honghuan@amd.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>,
 <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
To: =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260630102127.392396-1-honghuan@amd.com>
 <akPSENdX3vz8PvdY@gsse-cloud1.jf.intel.com>
 <DJMGHGBIJTOI.3FTGPA92WVGC6@kernel.org>
 <6f612bb912271b0dabb86c10e4f81dfbd4c4d31c.camel@linux.intel.com>
In-Reply-To: <6f612bb912271b0dabb86c10e4f81dfbd4c4d31c.camel@linux.intel.com>
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

On Wed Jul 1, 2026 at 5:56 PM CEST, Thomas Hellstr=C3=B6m wrote:
> Hi Danilo,
>
> On Tue, 2026-06-30 at 16:33 +0200, Danilo Krummrich wrote:
>> On Tue Jun 30, 2026 at 4:26 PM CEST, Matthew Brost wrote:
>> > If we merge the patches in drm-xe-next and pick them up via a
>> > rebase in the
>> > AMD trees, that works.
>>=20
>> IIUC what your are proposing this will create duplicate commits,
>> which should be
>> avoided.
>>=20
>> If the series is needed in multiple trees it is better to pick a
>> common base and
>> share via a tag that can be merged in all relevant trees.
>
> Our standard workflow if we need commits merged elsewhere in the DRM
> tree is to wait for it to appear in drm-next and then backmerge drm-
> next into our branch. It sounds like that's what Matthew is proposing
> here? And it wouldn't create duplicate commits?

Sure, that works. But "merge in tree A and pick up via rebase in tree B" wo=
uld
create duplicate commits, which we should avoid.
