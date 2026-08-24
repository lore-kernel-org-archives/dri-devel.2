Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC54CC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F19010E162;
	Mon, 24 Aug 2026 17:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="OiR1StPe";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFCE510E162
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787592462; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GGxzeTmLzJu45yvV9q7B7StzgH0v2iePswko0BH+wGNz6yz0fO3lX48RgFE6TEiZLmEtHXRpABZQfaa8AaV9Bt5UXA/sFBRmORceCAjLXifsLltrvLQIx9cimmCYvOM1TPgWq8yH5QhasIkerUCuoR+HcdpmVTix9yt9GURLqVQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787592462;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8HbTyiMdTNoPhTtnFybwZJ/PhwRCOV5bvYaCpIErq+E=; 
 b=jf+Th4VvQObR6C8hwkje2j5f+/eBBHR8BRj2uowlEw2poK0rQw15bFh2HMyAkoDtI/Gt+VxZwL8VCg0I4tQWsWodN6rR6TGE27Op4F9KsVFgQgtVH8spF5fqlWT6XZlIe2ToxIlfgBIFmfz1Aw+PlaPGyYUury+fEJWJ8No/XUY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787592462; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=8HbTyiMdTNoPhTtnFybwZJ/PhwRCOV5bvYaCpIErq+E=;
 b=OiR1StPeA7X5LEwxhjV3z5qfWYTmqvwle1KTU4jVtATczpIUbPT4Md836aFLzVGd
 xe+Q93mIr05FPxIElbKB4yKrLIq73Aw3f8fmwIhOOlMF98gP/dO4XIzbCxQoS/8mfgv
 Trk+WAGS0MEoXw2/56e0snS16sPspy6nRZUkNl28=
Received: by mx.zohomail.com with SMTPS id 1787592460746905.1668030475586;
 Mon, 24 Aug 2026 10:27:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/2] drm/tyr: move reset work to platform driver data
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260823-tyr-gpu-unplug-b4-v1-1-e99c07d4c785@onurozkan.dev>
Date: Mon, 24 Aug 2026 14:27:23 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECE73D59-4043-4AC6-9D3D-69CBA5DC1515@collabora.com>
References: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
 <20260823-tyr-gpu-unplug-b4-v1-1-e99c07d4c785@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 23 Aug 2026, at 07:50, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Move ResetHandle out of DRM registration data and store it as the =
first
> field of platform driver data. This makes platform teardown drain =
queued
> or running reset work before dropping the DRM registration and the

=E2=80=9Cor -> on=E2=80=9D running the reset work before? Otherwise I =
find this hard to parse.

> resources it owns.

Can you describe a bit more the consequences here? i.e.:  IIUC the reset =
work
would access dropped resources otherwise.

>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

