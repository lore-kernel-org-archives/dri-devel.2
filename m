Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2390DC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E9310EC5A;
	Tue, 30 Jun 2026 12:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F2ro2Mjt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2A510EC5A
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:40:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 068FB43CAC;
 Tue, 30 Jun 2026 12:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ACA1F000E9;
 Tue, 30 Jun 2026 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782823207;
 bh=Y7vL6cPQzCVsGY2FybrZ7uYv01P7w30akG1DpiqGAKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F2ro2MjtZTVFvIyXN1Gu3ttzs6TkBRfHNvan4HhJIG8xXwgzOcIsm3XBIrcTw6Alt
 XlsCJTF0BsJ44U1LfKOuZo4+LkPqqUoj5F+UaXdNXF0F2sHRDBC0JDDGU2iNkaHz+I
 KauWtH26dsKoIaXB/YtXgUCeiSKjNHGZKWbX3ZXprFHQ8euuegY3YH3mnvVyhy4LUo
 /19/4d7T9w3zdp7RjloL6FIaC92A36bmmcDomgP20V8KfMxFlh0SNm2kJ92hbJniHm
 jDgCRn90tCpDEO3eaM15BOKI/+YVkzYOMt0gQ65zFzFI1Ee5kPcFP6k3UqHYGd20od
 S+qhhC9qSfgwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/11] rust: driver: remove `IdTable::id`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 ojeda@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260629-id_info-v2-1-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-1-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:06 +0000
Message-Id: <20260630124007.61ACA1F000E9@smtp.kernel.org>
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

> This is unused.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D1

