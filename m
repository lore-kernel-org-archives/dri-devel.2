Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123C4C43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEC310E1FD;
	Tue, 30 Jun 2026 14:33:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iMYjVUNt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D13D510E122;
 Tue, 30 Jun 2026 14:33:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8257941678;
 Tue, 30 Jun 2026 14:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9591F000E9;
 Tue, 30 Jun 2026 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782829989;
 bh=9cuy7lk5rNB9ZhHqRD+Vl3cVGdgfWsb157w8wga2ThU=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=iMYjVUNtefm4X23CkoLXpK2X/IjrUyzA5uFcK1DYOIfNX60vOQr+djGJBjh9s0WZK
 xWcwGgToDKfvdSJVUtAuF/BsNpXbBHthrNNB/OqwEnBax4MSi64XhKWEjdNhB2HTOl
 mkEX0UIBYcYgS5tE8Q47pERpTu7GRh+JqvhZSLZMJyANNVGOUUd0lBMbwS8APfPKkB
 6USv1YIhzFXPS585M/4aa1YnQrYJC/BbLNzVQNmgR0pgUjwi138Yp7MDKQVAM7plfa
 7EFharRUUu/Km5UQu/mdtfE5LWYA36z6EvDeZ290yYM8YB5F7sbcYJ6spjw0/2njFw
 jzalZJhqGZ8dg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 16:33:04 +0200
Message-Id: <DJMGHGBIJTOI.3FTGPA92WVGC6@kernel.org>
Subject: Re: [PATCH v10 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Cc: "Honglei Huang" <honghuan@amd.com>, <sima@ffwll.ch>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <intel-xe@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>,
 <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
To: "Matthew Brost" <matthew.brost@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260630102127.392396-1-honghuan@amd.com>
 <akPSENdX3vz8PvdY@gsse-cloud1.jf.intel.com>
In-Reply-To: <akPSENdX3vz8PvdY@gsse-cloud1.jf.intel.com>
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

On Tue Jun 30, 2026 at 4:26 PM CEST, Matthew Brost wrote:
> If we merge the patches in drm-xe-next and pick them up via a rebase in t=
he
> AMD trees, that works.

IIUC what your are proposing this will create duplicate commits, which shou=
ld be
avoided.

If the series is needed in multiple trees it is better to pick a common bas=
e and
share via a tag that can be merged in all relevant trees.
