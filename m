Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD52F606A333
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Gxq2A+gU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2485210EA86;
	Wed, 11 Nov 2026 15:34:16 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FBB10EB49
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:34:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794411245; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YH4GCyBgSUE4ZWKabNOPkedslFjxEeN2y+ukxGakA+nTWBBltm2ACuFjgZAhuUQTipu/k0RbB80tfJvN8S6sRxp656EDfhDzhNAFmmXoCRmjBs6G5FSi3shPCK6isX1o6IwDEmku5nWcqAut99U7JlydtjyHNmclAZhtiwxdQmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794411245;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3d6GwUcI41vPeyH4xF1H67Snjlg/ya1dkGHnX8U2dlU=; 
 b=AcKJI43GQKyj21gx708w3BVs9FDY87GsU+SlJyfy+C7zpBpMU2mCbc5YnDPs2/sLUNypYTKIG5B5UB8Qv6KRIJc4zz3KBXSYpnIEIaqqXa52NKZWjEV7rJf5D+ZxGWcv4IFtT/cwzyWw9AQNdjhoKVCUgGBnOufpZJLiIUSpOSA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=Gxq2A+gUMWVLn5WHW9l3vwnxQlQIYUqQccBXHbU8H12DDAaAOMmh6r+KWJaTUxaf5EKbaNKh4Iw8OCrcvFEdIx5UgYOxmgLH+KSccnvqk96LmLlzwTSEZUAn6cZ6vRBuklZ+0VTUjKDniwcU+BVWJcPNofa0CIDBh/pzNaUuzfk=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=3d6GwUcI41vPeyH4xF1H67Snjlg/ya1dkGHnX8U2dlU=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794411244551300.58005091833445; 
 Wed, 11 Nov 2026 07:34:04 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v7 0/3] drm/tyr: GPU reset infrastructure
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261111100745.3929894-1-work@onurozkan.dev>
Date: Wed, 11 Nov 2026 12:33:47 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE29D511-8F4A-49A3-BE4E-31E6411816D7@collabora.com>
References: <20260912-tyr-reset-impl-v7-0-077ce72084eb@onurozkan.dev>
 <70AFEE33-C637-4D49-88F1-9DF3A9BBF097@collabora.com>
 <20261111100745.3929894-1-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Onur,

>=20
> Any updates on this? I am preparing v2 of the GPU unplug series [1] =
which
> depends on this series. The reset patches need rebasing against =
current
> drm-rust-next.
>=20
> Would you prefer me to send a rebased v8 and base unplug v2 on it or =
are
> you planning to pick up v7 and handle the rebase?
>=20
> Thanks,
> Onur
>=20
> [1]: =
https://lore.kernel.org/all/20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@o=
nurozkan.dev
>=20

I'm only waiting Alice's R-b before bringing this in. Feel free to send =
a
rebased version, since it will probably be needed for the unplug work =
too.

-- Daniel=
