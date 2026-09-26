Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE910C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 16:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9F110E06C;
	Sat, 26 Sep 2026 16:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U6BGKntt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE41610E06C
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:39:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FE2C6020C;
 Sat, 26 Sep 2026 16:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E63E1F000FF;
 Sat, 26 Sep 2026 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790440756;
 bh=NXCWwETl8AP7PG2gqMuh4RCYtkOAclSuUPrmMKZhJ4Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U6BGKnttwxo5UDLZFIsNXWAsoiubVc3yKP81PseEBV3bai7MLOATQNsoB8LBMzvti
 TmdtWomwG0GbcpkGus4u+4HekiqXycy5qN4WJnOeVfXaEqdcS+4IRlItW5sP59NHhu
 PL5Zs74VY2PhxXuJGdHeYUXFraOTbH1KlVZMkJdOCH0MMD0s+cwvy0eMBEObv5gzMn
 vmAHQ8pbEUkJX3QxFtxft6DmHvA/LpCWB6qj2P7srOGc0PpUCj45CLBAcCEnbWwiPP
 JD/mp+iRLGCIeg7dtUAiV+EY3mlFBIclbX1H5fGNbS2TDzZf9/QHMtAtI+fKuM7j6t
 OuH2luTIMEnJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] drm/qxl: clear the monitor configuration for
 disabled head zero
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260926163123.39217-4-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
 <20260926163123.39217-4-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:39:15 +0000
Message-Id: <20260926163915.9E63E1F000FF@smtp.kernel.org>
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

> Disabling head zero leaves its previous monitor entry intact because
> the inactive-head path only clears heads with a nonzero index. With
> another head still active, QXL continues publishing the disabled head
> as a visible monitor.
>=20
> Clear head zero using the same path as the other disabled heads.
>=20
> Fixes: a6d3c4d79822 ("qxl: hook monitors_config updates into crtc, not en=
coder.")
> Assisted-by: LLM sparse
> Signed-off-by: Dillon Amburgey <dillona@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163123.3921=
7-1-dillona@gmail.com?part=3D3

