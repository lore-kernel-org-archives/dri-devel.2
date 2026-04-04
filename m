Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7B3E88D6D
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 00:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74B910F4C4;
	Sat,  4 Apr 2026 00:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sge3PIuj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCD910F4C4
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 00:09:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C886243BD6;
 Sat,  4 Apr 2026 00:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22891C4CEF7;
 Sat,  4 Apr 2026 00:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775261391;
 bh=vIy1Ll9qC2oyfXhmdhIT7TXP8/zUi4JSdeupiKPg+9E=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=sge3PIujCFfaeJ/VjXEtbWh43ZhoT5uLd7ZviKQEMyiXOb6Tli+ymIuMAEsTBQIl2
 EI1yMfHkMi1R3Sp+zktVVPTJ+bAIfG7OdbDoSDJO4pWAN+geajHZUaELBhXv5bGn9W
 HEp/ZQDQ6s6YReJwNX1tloP8UZKgWEoxgyGW3yAeXxc2lxq+IBoOdFoZT15fTW/erf
 Aa3RlWMNJhKLT4O1whg7GI724geAUjGRXai/9d4n1EtF2DRBSyqkUTN8lomuY18LLL
 KDD57YZ2bWCHczFAPKUEAMg8UZ8/pv0RqJ0Y/rhZOgtdmTAfJqNZlx5eu4+CkLp3Ou
 pNhIlVpra20Fg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 02:09:47 +0200
Message-Id: <DHJXN2MZTZBF.3LSU0NJD0BQNC@kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: bitfield: fix broken Default
 implementation
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Lyude
 Paul" <lyude@redhat.com>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260401-fix-bitfield-v2-1-2fa68c98114a@nvidia.com>
In-Reply-To: <20260401-fix-bitfield-v2-1-2fa68c98114a@nvidia.com>
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

On Wed Apr 1, 2026 at 3:42 AM CEST, Eliot Courtney wrote:
> The current implementation does not actually set the default values for
> the fields in the bitfield.
>
> Fixes: 3fa145bef533 ("gpu: nova-core: register: generate correct `Default=
` implementation")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Due to [1] I dropped this one as well for now; I will pick it up once -rc1 =
is
out.

Thanks,
Danilo

[1] https://lore.kernel.org/all/DHJXK4PAD7V0.3UYK35FDHRNIK@kernel.org/
