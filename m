Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584ADCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 17:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E34D110E0D4;
	Fri, 19 Jun 2026 17:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Digz7RkV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730C910E0D4
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 17:05:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5551A440AA;
 Fri, 19 Jun 2026 17:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9091F000E9;
 Fri, 19 Jun 2026 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781888705;
 bh=SRRzcwaH4d1wxFZYtGSRDSdJpieIh3jJ5CEMg853dhQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Digz7RkV5vKHK3x/VfyiCMQpapcFtP/wf8fplSSA66JmR5jQBgx/GKyfBCKYmxg3G
 vgkQimbUZeuR2PD45uJc+gu4keQl/W3+X1XN8qG/bAWZnrNrJ0UICDiyjVEVWIZI8C
 PBEHoKZ6pOIRthUNh3EDGHeKAOdkCK6AmbEDjp0rZT+4ZKgEFDu/LAEj3RftFmoO31
 Mq76japzgC70tKC4CzaoJtGCPPGfl2ZULr9t7tPVPgDTA7lPavrnmtyWXDO66Lw/w5
 GWtbZzAYY/uImIlz3ozHF2La6Ce0TfHfHCnxdKHlTFt8KtDYUUSVV0gQ8gz8sOQ9mk
 d0x9o5wFJfG0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] rust: driver: remove duplicate ID table
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260618-id_info-v1-9-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-9-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:03 +0000
Message-Id: <20260619170504.4B9091F000E9@smtp.kernel.org>
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

> Previously, `IdArray` contains both device ID table and info table so we
> keep a separate copy for MODULE_DEVICE_TABLE for hotplug (which needs to =
be
> just the device ID table). With the info being changed to be carried via
> pointers, `IdArray` is now layout compatible with raw ID table and hence
> there is no longer a need to keep the distinction.
>=20
> Deduplicate the code, and remove the redundant copy for hotplug purpose by
> just giving the `IdArray` instance a proper symbol name.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D9

