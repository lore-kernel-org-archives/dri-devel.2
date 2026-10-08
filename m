Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3400DCA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D2410FCBC;
	Thu,  8 Oct 2026 07:37:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kzInXlkk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D0E910FCBC
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:37:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1857843430;
 Thu,  8 Oct 2026 07:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142191F000FF;
 Thu,  8 Oct 2026 07:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791445035;
 bh=9nh0eDL8VlS8CbRVuCMsRERyCaNvya5PFxbGvhuNeIE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kzInXlkke8Pjiz8kPnaLTJkwDXkEhcaqaDyLYDZ/5MFzfgpKx3ciR++cirT1JpcLX
 gwQxYV7fQuD9fNEE4Xx2/loRWEtR0KqFWXrWU1NJuFU/OzX2tkhY/U8pzEnnv3Y4Xg
 2BdkWR79A3GXVueJPuhpR7OQ6qbm84FZmXkRtAJW9Byei/z8hpUUFO9om9+eFfafk2
 YdVi+REpSbfaL5ktLQzov1fEbQRN5rb3XIQW83fBKWEc4xxD8Tz+kY/xj63kOJbPI6
 m641LiKCzGcjz3JAPLZBLddAI3g8sKY8frhRoT/n0aBsZC6kaoi8cf1zy2bVEdmq1X
 llKKjP4Oozz/g==
Message-ID: <sashiko-outbox-163770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/13] treewide: convert rdmsrq() from a macro to an
 inline function
To: "Juergen Gross" <jgross@suse.com>
Cc: linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, cassel@kernel.org,
 linux-ide@vger.kernel.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, dlemoal@kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20261008071839.2247074-13-jgross@suse.com>
References: <20261008071839.2247074-1-jgross@suse.com>
 <20261008071839.2247074-13-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:37:14 +0000
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

> Today rdmsrq() is a macro using its second parameter as the target for
> storing the read MSR value.
>=20
> Convert rdmsrq() to an inline function returning the MSR value.
>=20
> The users have been converted using the following semantic patch:
>=20
>   // Options: --include-headers
>=20
>   virtual patch
>   virtual report
>=20
>   @@
>   expression msr, val;
>   @@
>   (
>   - rdmsrq(msr,val)
>   + val =3D rdmsrq(msr)
>   )
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008071839.2247=
074-1-jgross@suse.com?part=3D12

