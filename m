Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3762CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5B810E5C9;
	Mon, 12 Oct 2026 16:12:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C9610E5C9
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:12:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F2C060220;
 Mon, 12 Oct 2026 16:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83611F0089B;
 Mon, 12 Oct 2026 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791821554;
 bh=SaLW2FJlto3Qvv7X/qyeniECA7NTJ2pwwpj+4jqSVtg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Ni+fFgedygYDm+tg97lg0hq/n+kkD1IblbhAUblehNd7tLWPV6yQzEhQC3QREd0UB
 1H40sFcJOBjcW0rV8E0FUiDDeuN31DeRm36yTuV5eYeLCJnffvNFF4rMruHd1bU3bS
 +4VzIL1AonF4px6+iZhLFqeLdfAreGzotqBCM300RiumaLCoARq8bN4jF3JTl/YcyC
 uv3tPQc/I1Za0rFYgR+EdwHokM6MqqqK/tGGeQbSLOL6Huc/KT21G4L7DdB9MK0ru1
 mt14SWvGOBOGOjf+3l6q+EtyuFJc/jSrpJAtZpwMDtdvVaQKc0h78Ubn12zNQKRH72
 MIoks0m3OOmsg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 18:12:31 +0200
Message-Id: <DM2ZQ8WLXOLQ.Z4U2APODVLL1@kernel.org>
Subject: Re: [PATCH 2/7] rust: drm: gem: gate open/close callbacks with
 RegistrationGuard
Cc: <sashiko-reviews@lists.linux.dev>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <ojeda@kernel.org>,
 <dri-devel@lists.freedesktop.org>, "rust-for-linux"
 <rust-for-linux@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-3-dakr@kernel.org>
 <20260814232106.01AA71F000E9@smtp.kernel.org>
 <E989BBD7-DF97-4384-AFC1-3D7448A1C747@collabora.com>
 <DM22LS0S86HB.2G9NWE78JHV0@kernel.org>
 <0CA5ABE5-C198-45D5-B393-50AA219D6F14@collabora.com>
In-Reply-To: <0CA5ABE5-C198-45D5-B393-50AA219D6F14@collabora.com>
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

On Mon Oct 12, 2026 at 6:06 PM CEST, Daniel Almeida wrote:
> So you=E2=80=99re saying that close() can be removed entirely? Or did I m=
isunderstand?

Not entirely, it can still be useful when the driver remains bound and the =
DRM
device registered as an optimization to release resources early.  It's just=
 not
useful on / after DRM device unregistration / driver unbind as it implies t=
hat
those resources are released anyway.
