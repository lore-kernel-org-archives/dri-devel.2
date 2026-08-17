Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFEBC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66FE810E7CA;
	Mon, 17 Aug 2026 13:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SRKesSW3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7394110E0D0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 13:06:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EAD64601DE;
 Mon, 17 Aug 2026 13:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9551F000E9;
 Mon, 17 Aug 2026 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786972003;
 bh=BpTU1Doz2FdLqfgVNjl1Kfgj1b92/wmh9p9wbnCH8vQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SRKesSW3wQy4eyN0Xn2M4vXsqz7CTzA2Us6xTswIp2TRrfrOHqH4e/6eVu5/iLtE5
 kfYshvTYto3bi8CASJ6UBrbl5HThMkO7fGCdGutn5h9V/zEN2ow5EFOyxAcFCVEneE
 0zPBQgskKyzPpiOGciOVDrQrcXpbnsO5uU+MlzP/scMSzsgVHdVJEo7AHn2edUSohw
 aV3QUkaX7C476h5I6UMqktVLrmWLry1JVlL/UbtNT8bJM93KAhJURg5jsulKFt6Dtz
 1QxsAFOjhwn6TCcoM3++EBq9FlOopaWdKNFlYkobJoakP8gBY0tTjqPF3m5/QJgcc5
 34rlwWvJkJdKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] gpu: nova-core: add NVKV GSP_INIT schemas
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260817-b4-nvkv-v1-6-b84db5e84b67@nvidia.com>
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-6-b84db5e84b67@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 13:06:43 +0000
Message-Id: <20260817130643.5F9551F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVVec<RegKey> encoding does not increment NVKV element indices, ca=
using all array elements to be sent with index 0.
--

--- Patch [6]: [PATCH 6/6] gpu: nova-core: add NVKV GSP_INIT schemas ---
commit 2486533ab3027e1001c092bef8bd2ab3fb8541bf
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: add NVKV GSP_INIT schemas

This commit adds the first user of NVKV encode/decode, which is the request
and response for GSP init. It supports these messages for unit tests.

> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-=
core/gsp/fw/commands.rs
> index 6dc31d1bf5ae4..4de44c2dc6aa3 100644
> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
[ ... ]
> +impl Encodable for KVVec<RegKey> {
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        for regkey in self {
> +            regkey.encode(encoder)?;
> +        }
> +        Ok(())
> +    }
> +}

[Severity: High]
When iterating over the KVVec<RegKey> array in this custom Encodable
implementation, does this code need a mechanism to increment the NVKV
element index?

Because the underlying Key type appears to hardcode Index::new::<0>() for
all encodings (as Encodable::encode does not accept an index parameter), it
looks like all array elements will be encoded with index 0.

Will the GSP firmware overwrite earlier items with the last one or reject
the message due to the missing incrementing index when multiple registry
keys are present?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-b4-nvkv-v1=
-0-b84db5e84b67@nvidia.com?part=3D6
